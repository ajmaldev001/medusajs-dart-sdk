/// Test runner for the MedusaJS Dart SDK
/// 
/// This file imports and runs all test suites to ensure comprehensive coverage
/// of the SDK functionality.

import 'package:test/test.dart';

// Import all test files
import 'medusajs_dart_sdk_test.dart' as sdk_tests;
import 'store_test.dart' as store_tests;
import 'admin_test.dart' as admin_tests;
import 'integration_test.dart' as integration_tests;

void main() {
  group('MedusaJS Dart SDK - All Tests', () {
    group('SDK Core Tests', () {
      sdk_tests.main();
    });

    group('Store Module Tests', () {
      store_tests.main();
    });

    group('Admin Module Tests', () {
      admin_tests.main();
    });

    group('Integration Tests', () {
      integration_tests.main();
    });
  });
}