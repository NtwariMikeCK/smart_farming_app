import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../models/prediction_inputs.dart';
import '../models/prediction_result.dart';

class ApiService {
  // Add url here for backend
  static const String baseUrl =
      'https://smart-farming-app-vlny.onrender.com/predict';
  static const String predictEndpoint = '/predict';

  Future<PredictionResult> predictYield(PredictionInput input) async {
    try {
      // final url = Uri.parse('$baseUrl$predictEndpoint');
      final url = Uri.parse(baseUrl);

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(input.toJson()),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return PredictionResult.fromJson(data);
      } else {
        throw Exception('Failed to predict: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error connecting to API: $e');
    }
  }
}

final apiServiceProvider = Provider<ApiService>((ref) => ApiService());
