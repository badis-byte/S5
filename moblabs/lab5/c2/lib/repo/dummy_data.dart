import 'dart:convert';
import 'package:http/http.dart' as http;

class DummyData {
  // Replace with your real endpoint
  final String url =
      'https://mobilebackendsimpleflask-imed1024-s73qk5q3.leapcell.dev/news.categories.get';

  // Local fallback (useful for testing)
  final Map<String, dynamic> _local = {
    "title": "List of Categories",
    "time": "2025-10-22 10:40:48",
    "categories": [
      {"id": 1, "name": "Sports"},
      {"id": 2, "name": "Politics"},
      {"id": 3, "name": "Education"}
    ]
  };

  // Return the local map immediately (Future) if you need it synchronously in tests
  Future<Map<String, dynamic>> fetchLocal() async {
    await Future.delayed(Duration(seconds: 2)); // simulate delay
    return Future.value(_local);
  }

  Future<Map<String, dynamic>> fetchRaw() async {
    final uri = Uri.parse(url);
    final resp = await http.get(uri).timeout(const Duration(seconds: 10));

    if (resp.statusCode != 200) {
      throw Exception('Failed to load categories (status ${resp.statusCode})');
    }

    final decoded = jsonDecode(resp.body);

    if (decoded is Map<String, dynamic>) {
      // defensive copy to ensure typing
      return Map<String, dynamic>.from(decoded);
    }

    throw Exception('Unexpected JSON structure: expected object at top level');
  }

  Future<List<Map<String, dynamic>>> fetchCategories() async {
    final raw = await fetchRaw();

    final categories = raw['categories'];
    if (categories is List) {
      // convert each item to Map<String,dynamic>
      return categories
          .map((e) => Map<String, dynamic>.from(e as Map))
          .toList(growable: false);
    }

    throw Exception('Unexpected JSON structure: "categories" not found or not a list');
  }
}
