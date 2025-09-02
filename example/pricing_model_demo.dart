import 'package:medusajs_dart_sdk/medusajs_dart_sdk.dart';

/// Demo script showing the updated ProductVariantPrice model capabilities
void main() async {
  print('🏷️ ProductVariantPrice Model Demo');
  print('=====================================');

  // Create a sample ProductVariantPrice with comprehensive pricing data
  final priceData = {
    'id': 'pset_01234567890',
    'is_calculated_price_price_list': true,
    'is_calculated_price_tax_inclusive': false,
    'calculated_amount': 2500, // $25.00
    'calculated_amount_with_tax': 2750, // $27.50
    'calculated_amount_without_tax': 2500, // $25.00
    'is_original_price_price_list': false,
    'is_original_price_tax_inclusive': false,
    'original_amount': 3000, // $30.00
    'original_amount_with_tax': 3300, // $33.00
    'original_amount_without_tax': 3000, // $30.00
    'currency_code': 'USD',
    'calculated_price': {
      'id': 'price_01234567890',
      'price_list_id': 'plist_sale2024',
      'price_list_type': 'sale',
      'min_quantity': 1,
      'max_quantity': null,
    },
    'original_price': {
      'id': 'price_09876543210',
      'price_list_id': null,
      'price_list_type': null,
      'min_quantity': 1,
      'max_quantity': null,
    },
  };

  try {
    // Parse the pricing data using our model
    final variantPrice = ProductVariantPrice.fromJson(priceData);

    print('\n💰 Pricing Information:');
    print('=======================');

    print('🆔 Price Set ID: ${variantPrice.id}');
    print('💱 Currency: ${variantPrice.currencyCode}');
    print('');

    print('📊 Calculated Price:');
    print(
      '   💵 Amount: ${variantPrice.getFormattedCalculatedPrice()} ${variantPrice.currencyCode}',
    );
    print(
      '   📈 With Tax: \$${(variantPrice.calculatedAmountWithTax! / 100).toStringAsFixed(2)}',
    );
    print(
      '   📉 Without Tax: \$${(variantPrice.calculatedAmountWithoutTax! / 100).toStringAsFixed(2)}',
    );
    print('   🏷️ From Price List: ${variantPrice.isCalculatedPricePriceList}');
    print('   💳 Tax Inclusive: ${variantPrice.isCalculatedPriceTaxInclusive}');
    print('');

    print('📊 Original Price:');
    print(
      '   💵 Amount: ${variantPrice.getFormattedOriginalPrice()} ${variantPrice.currencyCode}',
    );
    print(
      '   📈 With Tax: \$${(variantPrice.originalAmountWithTax! / 100).toStringAsFixed(2)}',
    );
    print(
      '   📉 Without Tax: \$${(variantPrice.originalAmountWithoutTax! / 100).toStringAsFixed(2)}',
    );
    print('   🏷️ From Price List: ${variantPrice.isOriginalPricePriceList}');
    print('   💳 Tax Inclusive: ${variantPrice.isOriginalPriceTaxInclusive}');
    print('');

    print('🎯 Price Analysis:');
    print(
      '   💰 Effective Price: ${variantPrice.getFormattedEffectivePrice()} ${variantPrice.currencyCode}',
    );
    print('   🎉 Has Discount: ${variantPrice.hasDiscount}');

    if (variantPrice.hasDiscount) {
      print(
        '   💸 Discount Amount: \$${(variantPrice.discountAmount! / 100).toStringAsFixed(2)}',
      );
      print(
        '   📊 Discount %: ${variantPrice.discountPercentage!.toStringAsFixed(1)}%',
      );
    }
    print('');

    print('📋 Price List Details:');
    if (variantPrice.calculatedPrice != null) {
      final calc = variantPrice.calculatedPrice!;
      print('   Calculated Price List:');
      print('     🆔 ID: ${calc.priceListId}');
      print('     📊 Type: ${calc.priceListType}');
      print('     📦 Min Qty: ${calc.minQuantity}');
      print('     📦 Max Qty: ${calc.maxQuantity ?? 'No limit'}');
    }

    if (variantPrice.originalPrice != null) {
      final orig = variantPrice.originalPrice!;
      print('   Original Price:');
      print('     🆔 Price List ID: ${orig.priceListId ?? 'None'}');
      print('     📊 Type: ${orig.priceListType ?? 'Standard'}');
      print('     📦 Min Qty: ${orig.minQuantity}');
    }

    print('\n✨ Comprehensive Pricing Model Features:');
    print('   ✅ Supports calculated vs original pricing');
    print('   ✅ Tax-inclusive and tax-exclusive amounts');
    print('   ✅ Price list information and types');
    print('   ✅ Quantity-based pricing rules');
    print('   ✅ Automatic discount calculation');
    print('   ✅ Formatted price display methods');
    print('   ✅ Currency support');

    print(
      '\n🎉 The ProductVariantPrice model is ready for comprehensive pricing!',
    );
  } catch (e) {
    print('❌ Error: $e');
  }
}
