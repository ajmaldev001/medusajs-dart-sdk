import 'package:medusajs_dart_sdk/medusajs_dart_sdk.dart';

/// Simple pricing validation test
/// This test validates that the pricing models and methods work correctly
Future<void> main() async {
  print('🧪 Testing Pricing Models and Methods');
  print('=' * 40);

  // Test ProductVariantPrice model
  print('📋 Test 1: ProductVariantPrice Model');

  // Create test pricing data
  final testPriceData = {
    'id': 'price_test123',
    'currency_code': 'usd',
    'calculated_amount': 1500, // $15.00
    'original_amount': 2000, // $20.00
    'is_calculated_price_price_list': true,
    'is_calculated_price_tax_inclusive': false,
    'calculated_price': {
      'id': 'calc_price_123',
      'price_list_type': 'sale',
      'min_quantity': 1,
      'max_quantity': null,
    },
    'original_price': {
      'id': 'orig_price_123',
      'price_list_type': null,
      'min_quantity': 1,
      'max_quantity': null,
    },
  };

  try {
    final variantPrice = ProductVariantPrice.fromJson(testPriceData);

    print('✅ ProductVariantPrice model creation successful');
    print('   💰 Currency: ${variantPrice.currencyCode}');
    print(
      '   💵 Original Price: \$${variantPrice.getFormattedOriginalPrice()}',
    );
    print(
      '   💸 Calculated Price: \$${variantPrice.getFormattedCalculatedPrice()}',
    );
    print(
      '   ⚡ Effective Price: \$${variantPrice.getFormattedEffectivePrice()}',
    );
    print('   🎉 Has Discount: ${variantPrice.hasDiscount ? 'Yes' : 'No'}');

    if (variantPrice.hasDiscount) {
      final original = variantPrice.originalAmount!;
      final calculated = variantPrice.calculatedAmount!;
      final discountAmount = original - calculated;
      final discountPercent = ((discountAmount / original) * 100);

      print(
        '   💰 Discount Amount: \$${(discountAmount / 100).toStringAsFixed(2)}',
      );
      print(
        '   📊 Discount Percentage: ${discountPercent.toStringAsFixed(1)}%',
      );
    }

    print(
      '   📋 From Price List: ${variantPrice.isCalculatedPricePriceList == true ? 'Yes' : 'No'}',
    );
    print(
      '   🏷️ Tax Inclusive: ${variantPrice.isCalculatedPriceTaxInclusive == true ? 'Yes' : 'No'}',
    );
  } catch (e) {
    print('❌ ProductVariantPrice model test failed: $e');
  }

  print('');
  print('📋 Test 2: Cart Pricing Formatting');

  // Test Cart model pricing formatting
  final testCartData = {
    'id': 'cart_test123',
    'region_id': 'reg_test',
    'currency_code': 'usd',
    'total': 2300, // $23.00
    'subtotal': 2000, // $20.00
    'tax_total': 300, // $3.00
    'shipping_total': 500, // $5.00
    'discount_total': 200, // $2.00
    'gift_card_total': 0,
    'gift_card_tax_total': 0,
    'item_count': 2,
    'created_at': DateTime.now().toIso8601String(),
    'updated_at': DateTime.now().toIso8601String(),
  };

  try {
    final cart = Cart.fromJson(testCartData);

    print('✅ Cart model creation successful');
    print('   🛒 Cart ID: ${cart.id}');
    print('   💰 Subtotal: ${cart.formattedSubtotal}');
    print('   🏷️ Tax Total: ${cart.formattedTaxTotal}');
    print('   🚚 Shipping: ${cart.formattedShippingTotal}');
    print('   🎁 Discount: ${cart.formattedDiscountTotal}');
    print('   📦 Final Total: ${cart.formattedTotal}');
    print('   📊 Item Count: ${cart.itemCount}');
    print('   💳 Currency: ${cart.currencyCode}');
  } catch (e) {
    print('❌ Cart model test failed: $e');
  }

  print('');
  print('📋 Test 3: Promotion Model');

  // Test Promotion model
  final testPromotionData = {
    'id': 'promo_test123',
    'code': 'SAVE20',
    'is_automatic': false,
    'type': 'standard',
    'application_method': 'code',
    'created_at': DateTime.now().toIso8601String(),
    'updated_at': DateTime.now().toIso8601String(),
  };

  try {
    final promotion = Promotion.fromJson(testPromotionData);

    print('✅ Promotion model creation successful');
    print('   🎫 Code: ${promotion.code}');
    print('   🔄 Automatic: ${promotion.isAutomatic ? 'Yes' : 'No'}');
    print('   📋 Type: ${promotion.type}');
    print('   ⚡ Application: ${promotion.applicationMethod}');
    print('   ✅ Active: ${promotion.isActive ? 'Yes' : 'No'}');
  } catch (e) {
    print('❌ Promotion model test failed: $e');
  }

  print('');
  print('📋 Test 4: Tax Model');

  // Test Tax model
  final testTaxData = {
    'id': 'tax_test123',
    'rate': 0.1, // 10%
    'name': 'VAT',
    'code': 'VAT_10',
    'created_at': DateTime.now().toIso8601String(),
    'updated_at': DateTime.now().toIso8601String(),
  };

  try {
    final taxRate = TaxRate.fromJson(testTaxData);

    print('✅ TaxRate model creation successful');
    print('   �️ Name: ${taxRate.name}');
    print('   � Rate: ${taxRate.rateAsPercentage.toStringAsFixed(1)}%');
    print('   🔢 Code: ${taxRate.code ?? 'N/A'}');
    print('   � Type: ${taxRate.isPercentageRate ? 'Percentage' : 'Flat'}');

    // Test tax calculation
    final testAmount = 100.0;
    final calculatedTax = taxRate.calculateTax(testAmount);
    print(
      '   💰 Tax on \$${testAmount.toStringAsFixed(2)}: \$${calculatedTax.toStringAsFixed(2)}',
    );
  } catch (e) {
    print('❌ TaxRate model test failed: $e');
  }

  print('');
  print('📋 Test 5: Price Calculations');

  // Test various price calculation scenarios
  final testScenarios = [
    {'name': 'No Discount', 'original': 2000, 'calculated': 2000},
    {'name': '10% Discount', 'original': 2000, 'calculated': 1800},
    {'name': '25% Discount', 'original': 2000, 'calculated': 1500},
    {'name': '50% Discount', 'original': 2000, 'calculated': 1000},
  ];

  for (final scenario in testScenarios) {
    final priceData = {
      'id': 'test_price',
      'original_amount': scenario['original'],
      'calculated_amount': scenario['calculated'],
      'currency_code': 'usd',
    };

    try {
      final price = ProductVariantPrice.fromJson(priceData);
      final hasDiscount = price.hasDiscount;
      final discountPercent =
          hasDiscount
              ? ((price.originalAmount! - price.calculatedAmount!) /
                  price.originalAmount! *
                  100)
              : 0.0;

      print('   ${scenario['name']}:');
      print('     💵 Original: \$${price.getFormattedOriginalPrice()}');
      print('     💸 Final: \$${price.getFormattedCalculatedPrice()}');
      print('     🎉 Discount: ${discountPercent.toStringAsFixed(1)}%');
    } catch (e) {
      print('   ❌ ${scenario['name']} test failed: $e');
    }
  }

  print('');
  print('🎉 All pricing model tests completed!');
  print('');
  print('💡 Next steps for testing with real backend:');
  print(
    '   1. Run: dart run example/test_pricing_and_promotions.dart http://your-backend-url your-publishable-key',
  );
  print('   2. Ensure your backend has products with variants');
  print('   3. Create discount codes or price lists in Medusa admin');
  print('   4. Test different regions and currencies');
}
