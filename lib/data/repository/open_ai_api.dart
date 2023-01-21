import 'dart:convert';

import 'package:http/http.dart' as http;

class OpenAiCompletionApi {
  final String _apiKey;
  final String _endpoint =
      'https://api.openai.com/v1/completions';

  OpenAiCompletionApi(this._apiKey);

  Future<String> complete(String prompt,
      {int maxTokens = 10, String temperature = '0.5'}) async {
    final response = await http.post(Uri.parse(_endpoint),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        },
        body: jsonEncode({
          'prompt': prompt,
          'max_tokens': maxTokens,
          'temperature': temperature,
        }));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse['choices'][0]['text'];
    } else {
      throw Exception('Failed to complete prompt');
    }
  }
}
