import '../../resources/base_resource.dart';
import '../../models/models.dart';
import '../../types/types.dart';

/// Store cart resource for cart management operations
class StoreCartResource extends StoreResource {
  const StoreCartResource(super.client);

  String get resourcePath => '$basePath/carts';

  /// Create a cart
  Future<Cart?> create(
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await createGeneric<Cart>(
      body: body,
      endpoint: resourcePath,
      dataKey: 'cart',
      fromJson: Cart.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Update a cart
  Future<Cart?> update(
    String id,
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await updateGeneric<Cart>(
      id: id,
      body: body,
      endpoint: '$resourcePath/$id',
      dataKey: 'cart',
      fromJson: Cart.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Retrieve a cart by ID
  Future<Cart?> retrieve(
    String id, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await retrieveGeneric<Cart>(
      id: id,
      endpoint: '$resourcePath/$id',
      dataKey: 'cart',
      fromJson: Cart.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Add line item to cart
  Future<Cart?> createLineItem(
    String cartId,
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$cartId/line-items',
      method: 'POST',
      body: body,
      query: query,
      headers: headers,
    );

    final cartData = response['cart'];
    return cartData != null
        ? Cart.fromJson(cartData as Map<String, dynamic>)
        : null;
  }

  /// Update line item in cart
  Future<Cart?> updateLineItem(
    String cartId,
    String lineItemId,
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$cartId/line-items/$lineItemId',
      method: 'POST',
      body: body,
      query: query,
      headers: headers,
    );

    final cartData = response['cart'];
    return cartData != null
        ? Cart.fromJson(cartData as Map<String, dynamic>)
        : null;
  }

  /// Delete line item from cart
  Future<Map<String, dynamic>> deleteLineItem(
    String cartId,
    String lineItemId, {
    ClientHeaders? headers,
  }) async {
    return await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$cartId/line-items/$lineItemId',
      method: 'DELETE',
      headers: headers,
    );
  }

  /// Add shipping method to cart
  Future<Cart?> addShippingMethod(
    String cartId,
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$cartId/shipping-methods',
      method: 'POST',
      body: body,
      query: query,
      headers: headers,
    );

    final cartData = response['cart'];
    return cartData != null
        ? Cart.fromJson(cartData as Map<String, dynamic>)
        : null;
  }

  /// Complete cart (place order)
  Future<Map<String, dynamic>> complete(
    String cartId, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$cartId/complete',
      method: 'POST',
      query: query,
      headers: headers,
    );
  }

  /// Transfer cart to logged-in customer
  Future<Cart?> transferCart(
    String id, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id/customer',
      method: 'POST',
      query: query,
      headers: headers,
    );

    final cartData = response['cart'];
    return cartData != null
        ? Cart.fromJson(cartData as Map<String, dynamic>)
        : null;
  }

  /// Apply discount code to cart
  Future<Cart?> applyDiscount(
    String cartId,
    String discountCode, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final body = {'code': discountCode};

    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$cartId/discounts/$discountCode',
      method: 'POST',
      body: body,
      query: query,
      headers: headers,
    );

    final cartData = response['cart'];
    return cartData != null
        ? Cart.fromJson(cartData as Map<String, dynamic>)
        : null;
  }

  /// Remove discount from cart
  Future<Cart?> removeDiscount(
    String cartId,
    String discountCode, {
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$cartId/discounts/$discountCode',
      method: 'DELETE',
      headers: headers,
    );

    final cartData = response['cart'];
    return cartData != null
        ? Cart.fromJson(cartData as Map<String, dynamic>)
        : null;
  }
}
