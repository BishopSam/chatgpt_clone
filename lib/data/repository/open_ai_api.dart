import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class OpenAiCompletionApi {
  final String _apiKey;
  final String _endpoint =
      'https://api.openai.com/v1/completions';

  OpenAiCompletionApi(this._apiKey);

  Future<String> complete(String prompt,
      {int maxTokens = 10, double temperature = 0.5}) async {
    final response = await http.post(Uri.parse(_endpoint),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        },
        body: jsonEncode({
          'prompt': prompt,
          'max_tokens': (2048).toInt(),
          "model": "text-davinci-003",
          'temperature': temperature,
        }));

    if (response.statusCode == 200) {
      debugPrint(response.statusCode.toString());
      debugPrint(response.body.toString());
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse['choices'][0]['text'];
    } else {
       debugPrint(response.body.toString());
      throw Exception('Failed to complete prompt');
    }
  }
}
