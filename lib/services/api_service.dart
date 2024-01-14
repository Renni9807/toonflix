import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:toonflix/models/webtoon_model.dart';

class ApiService {
  static const String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev";
  static const today = "today";

  // http package is necessary as calling API and try to fetch data
  // want request go to the server and then come back. No need to complete http.get(url) early
  // Just wait until it finish.
  // This is async programming. This meams that I want to wait for something to happen
  // just waiting for the server to reply
  // the way to tell Dart to wait for something is by using keyword await
  // rule for await --> await can only be used inside an asynchronous function
  // So need to add async keyword following the function name.
  // Similar to JavaScript
  static Future<List<WebtoonModel>> getTodaysToons() async {
    // async => Future type
    List<WebtoonModel> webtoonInstances = [];
    final url = Uri.parse('$baseUrl\\$today');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        webtoonInstances.add(WebtoonModel.fromJson(webtoon));
        // webtoon as argument because webtoon format is Map<String, dynamic>
      }
      // fetch data in JSON form

      return webtoonInstances;
    }
    throw Error();
  }
}
