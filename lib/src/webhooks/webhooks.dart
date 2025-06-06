import 'dart:convert';
import 'dart:async';
import '../types/types.dart';
import '../exceptions/exceptions.dart';

/// Webhook event types
enum MedusaWebhookEvent {
  orderPlaced('order.placed'),
  orderUpdated('order.updated'),
  orderCanceled('order.canceled'),
  orderFulfilled('order.fulfilled'),
  orderPaymentCaptured('order.payment_captured'),
  orderRefunded('order.refunded'),

  productCreated('product.created'),
  productUpdated('product.updated'),
  productDeleted('product.deleted'),

  customerCreated('customer.created'),
  customerUpdated('customer.updated'),
  customerDeleted('customer.deleted'),

  inventoryItemCreated('inventory_item.created'),
  inventoryItemUpdated('inventory_item.updated'),
  inventoryItemDeleted('inventory_item.deleted'),

  regionCreated('region.created'),
  regionUpdated('region.updated'),
  regionDeleted('region.deleted'),

  cartCreated('cart.created'),
  cartUpdated('cart.updated'),

  userCreated('user.created'),
  userUpdated('user.updated'),
  userDeleted('user.deleted');

  const MedusaWebhookEvent(this.value);
  final String value;
}

/// Webhook payload container
class WebhookPayload {
  final MedusaWebhookEvent event;
  final Map<String, dynamic> data;
  final DateTime timestamp;
  final String? id;

  const WebhookPayload({
    required this.event,
    required this.data,
    required this.timestamp,
    this.id,
  });

  factory WebhookPayload.fromJson(Map<String, dynamic> json) {
    final eventValue = json['event'] as String;
    final event = MedusaWebhookEvent.values.firstWhere(
      (e) => e.value == eventValue,
      orElse: () => throw ArgumentError('Unknown webhook event: $eventValue'),
    );

    return WebhookPayload(
      event: event,
      data: json['data'] as Map<String, dynamic>,
      timestamp: DateTime.parse(json['timestamp'] as String),
      id: json['id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'event': event.value,
      'data': data,
      'timestamp': timestamp.toIso8601String(),
      if (id != null) 'id': id,
    };
  }
}

/// Webhook handler function type
typedef WebhookHandler = Future<void> Function(WebhookPayload payload);

/// Webhook manager for handling Medusa webhooks
class MedusaWebhooks {
  final Map<MedusaWebhookEvent, List<WebhookHandler>> _handlers = {};
  final Logger? _logger;

  MedusaWebhooks({Logger? logger}) : _logger = logger;

  /// Register a webhook handler for a specific event
  void on(MedusaWebhookEvent event, WebhookHandler handler) {
    _handlers.putIfAbsent(event, () => []).add(handler);
    _logger?.debug('Registered handler for ${event.value}');
  }

  /// Register a webhook handler that listens to all events
  void onAll(WebhookHandler handler) {
    for (final event in MedusaWebhookEvent.values) {
      on(event, handler);
    }
  }

  /// Remove a webhook handler for a specific event
  void off(MedusaWebhookEvent event, WebhookHandler handler) {
    _handlers[event]?.remove(handler);
    if (_handlers[event]?.isEmpty == true) {
      _handlers.remove(event);
    }
    _logger?.debug('Removed handler for ${event.value}');
  }

  /// Remove all handlers for a specific event
  void removeAllHandlers(MedusaWebhookEvent event) {
    _handlers.remove(event);
    _logger?.debug('Removed all handlers for ${event.value}');
  }

  /// Remove all handlers
  void clear() {
    _handlers.clear();
    _logger?.debug('Cleared all webhook handlers');
  }

  /// Process a webhook payload
  Future<void> processWebhook(WebhookPayload payload) async {
    final handlers = _handlers[payload.event];
    if (handlers == null || handlers.isEmpty) {
      _logger?.warn('No handlers registered for ${payload.event.value}');
      return;
    }

    _logger?.debug(
      'Processing webhook ${payload.event.value} with ${handlers.length} handlers',
    );

    final futures = handlers.map((handler) => _handleSafely(handler, payload));
    await Future.wait(futures);
  }

  /// Process webhook from raw JSON string
  Future<void> processWebhookJson(String jsonPayload) async {
    try {
      final json = jsonDecode(jsonPayload) as Map<String, dynamic>;
      final payload = WebhookPayload.fromJson(json);
      await processWebhook(payload);
    } catch (e) {
      _logger?.error('Failed to process webhook JSON: $e');
      throw MedusaException('Invalid webhook payload: $e');
    }
  }

  /// Verify webhook signature (for security)
  static bool verifySignature(String payload, String signature, String secret) {
    // Implementation would depend on Medusa's webhook signing mechanism
    // This is a placeholder for the actual verification logic
    try {
      // Usually involves HMAC-SHA256 or similar
      return true; // Placeholder
    } catch (e) {
      return false;
    }
  }

  /// Helper method to handle webhook processing safely
  Future<void> _handleSafely(
    WebhookHandler handler,
    WebhookPayload payload,
  ) async {
    try {
      await handler(payload);
    } catch (e) {
      _logger?.error('Webhook handler failed for ${payload.event.value}: $e');
      // Don't rethrow to avoid affecting other handlers
    }
  }

  /// Get the number of registered handlers for an event
  int getHandlerCount(MedusaWebhookEvent event) {
    return _handlers[event]?.length ?? 0;
  }

  /// Get all registered events
  List<MedusaWebhookEvent> getRegisteredEvents() {
    return _handlers.keys.toList();
  }
}

/// Webhook middleware for handling HTTP webhook requests
class WebhookMiddleware {
  final MedusaWebhooks webhooks;
  final String? webhookSecret;

  const WebhookMiddleware(this.webhooks, {this.webhookSecret});

  /// Handle incoming webhook HTTP request
  Future<Map<String, dynamic>> handleRequest({
    required String body,
    required Map<String, String> headers,
  }) async {
    try {
      // Verify signature if secret is provided
      if (webhookSecret != null) {
        final signature =
            headers['x-medusa-signature'] ??
            headers['X-Medusa-Signature'] ??
            '';

        if (!MedusaWebhooks.verifySignature(body, signature, webhookSecret!)) {
          throw AuthenticationError('Invalid webhook signature');
        }
      }

      // Process the webhook
      await webhooks.processWebhookJson(body);

      return {'success': true, 'message': 'Webhook processed successfully'};
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }
}
