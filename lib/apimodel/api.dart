//"https://newsdata.io/api/1/news?apikey="+apiKey+"&q=dogecoin"

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:testnew/Model/newsmodel.dart';

class FetchApi {
  Future<List<ModelResults>> fetchArticle(int page) async {
    String apiKey = "e39ca228925c439b991389f1bcfe833c";
    String news =
        "https://newsapi.org/v2/everything?q=apple&from=2021-12-25&to=2021-12-25&sortBy=popularity&apiKey=" +
            apiKey +
            "&page=" +
            page.toString();

    http.Response response = await http.get(Uri.parse(news));

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      var jsonResults = body["articles"];

      List<ModelResults> news = [];
      for (var item in jsonResults) {
        news.add(ModelResults.fromJson(item));
      }

      print(news.length);
      return news;
    } else {
      return throw Exception("Erooooooor");
    }
  }
}
