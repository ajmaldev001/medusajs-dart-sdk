import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

/// Simple connectivity test to diagnose backend issues
Future<void> main() async {
  print('🔍 Simple Backend Connectivity Test');
  print('=' * 40);

  final baseUrl = 'http://localhost:9000';

  print('🔧 Testing connectivity to: $baseUrl');
  print('');

  // Test 1: Basic connectivity
  print('📡 Test 1: Basic HTTP connectivity...');
  try {
    final response = await http
        .get(Uri.parse('$baseUrl/health'))
        .timeout(Duration(seconds: 5));
    print('✅ Connected successfully');
    print('   Status: ${response.statusCode}');
    print('   Headers: ${response.headers}');
    if (response.body.isNotEmpty) {
      print('   Body: ${response.body}');
    }
  } catch (e) {
    print('❌ Connection failed: $e');
    print('');
    print('🔍 This suggests:');
    print('   1. Medusa backend is not running');
    print('   2. Backend is running on a different port');
    print('   3. Firewall/network issues');
    print('');
    print('💡 To fix:');
    print('   1. Start your Medusa backend: npm run dev');
    print('   2. Check if it\'s running on the correct port');
    print('   3. Try: curl http://localhost:9000/health');
    return;
  }
  print('');

  // Test 2: Store endpoint
  print('📡 Test 2: Testing /store endpoint...');
  try {
    final response = await http
        .get(Uri.parse('$baseUrl/store'))
        .timeout(Duration(seconds: 5));
    print('✅ Store endpoint accessible');
    print('   Status: ${response.statusCode}');
    print(
      '   Body preview: ${response.body.substring(0, response.body.length > 200 ? 200 : response.body.length)}...',
    );
  } catch (e) {
    print('❌ Store endpoint failed: $e');
  }
  print('');

  // Test 3: Regions endpoint
  print('📡 Test 3: Testing /store/regions endpoint...');
  try {
    final response = await http
        .get(Uri.parse('$baseUrl/store/regions'))
        .timeout(Duration(seconds: 5));
    print('✅ Regions endpoint accessible');
    print('   Status: ${response.statusCode}');

    if (response.statusCode == 200) {
      try {
        final data = jsonDecode(response.body);
        print('   Response type: ${data.runtimeType}');
        if (data is Map && data.containsKey('regions')) {
          final regions = data['regions'] as List;
          print('   Found ${regions.length} regions');
        } else {
          print('   Unexpected response format: $data');
        }
      } catch (e) {
        print('   Could not parse JSON: $e');
        print('   Raw body: ${response.body}');
      }
    } else {
      print('   Error response: ${response.body}');
    }
  } catch (e) {
    print('❌ Regions endpoint failed: $e');

    if (e is SocketException) {
      print('');
      print('🔍 Socket Exception means:');
      print('   - Backend is not running');
      print('   - Wrong host/port combination');
      print('   - Network connectivity issues');
    } else if (e is HttpException) {
      print('');
      print('🔍 HTTP Exception means:');
      print('   - Backend returned an error');
      print('   - Endpoint might not exist');
    }
  }
  print('');

  // Test 4: Try different common ports
  print('📡 Test 4: Trying common Medusa ports...');
  final commonPorts = [7001, 8000, 3000, 4000, 9001];

  for (final port in commonPorts) {
    try {
      final testUrl = 'http://localhost:$port/health';
      final response = await http
          .get(Uri.parse(testUrl))
          .timeout(Duration(seconds: 2));
      print('✅ Found backend on port $port (Status: ${response.statusCode})');
    } catch (e) {
      print('❌ Port $port: not accessible');
    }
  }

  print('');
  print('🛠️  Next Steps:');
  print('');
  print('1. **Start your Medusa backend**:');
  print('   cd your-medusa-project');
  print('   npm run dev');
  print('');
  print('2. **Verify it\'s running**:');
  print('   curl http://localhost:9000/health');
  print('   (Should return something like {"status":"ok"})');
  print('');
  print('3. **Check regions in backend**:');
  print('   curl http://localhost:9000/store/regions');
  print('');
  print('4. **If no regions, seed them**:');
  print('   npx medusa seed -f ./data/seed.json');
  print('   (in your Medusa backend directory)');
}
