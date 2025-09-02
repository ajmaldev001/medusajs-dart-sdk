import 'dart:convert';
import 'package:http/http.dart' as http;

/// Inspect the actual region data structure to debug type casting issues
Future<void> main() async {
  print('🔍 Inspecting Region Data Structure');
  print('=' * 40);

  final baseUrl = 'http://localhost:9000';
  final publishableKey =
      'pk_91b3a86dc075c322be390706c681561c525df7c54f4e54bf574b28e837d78714';

  try {
    final headers = {
      'x-publishable-api-key': publishableKey,
      'Content-Type': 'application/json',
    };

    final response = await http.get(
      Uri.parse('$baseUrl/store/regions'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      print('📋 Raw Response Structure:');
      print(JsonEncoder.withIndent('  ').convert(data));
      print('');

      final regions = data['regions'] as List;
      if (regions.isNotEmpty) {
        final firstRegion = regions[0] as Map<String, dynamic>;

        print('🔍 First Region Field Analysis:');
        print('');
        firstRegion.forEach((key, value) {
          print('   $key: ${value.runtimeType} = $value');
        });
        print('');

        print('🔍 Potential Type Issues:');
        print('');

        // Check tax_rate specifically
        final taxRate = firstRegion['tax_rate'];
        print('   tax_rate: ${taxRate.runtimeType} = $taxRate');
        if (taxRate == null) {
          print('   ❌ tax_rate is null - this will cause casting issues');
        } else if (taxRate is! num) {
          print(
            '   ❌ tax_rate is not a number - this will cause casting issues',
          );
        }

        // Check other potential numeric fields
        final fields = ['tax_rate', 'created_at', 'updated_at', 'deleted_at'];
        for (final field in fields) {
          final value = firstRegion[field];
          if (value != null) {
            print('   $field: ${value.runtimeType} = $value');
          } else {
            print('   $field: null');
          }
        }
      }
    } else {
      print('❌ Request failed: ${response.statusCode}');
      print('   Body: ${response.body}');
    }
  } catch (e) {
    print('❌ Error: $e');
  }
}
