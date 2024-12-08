import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future getMostListenedSongList(
  int? page
) async {
  var url = Uri.parse('${dotenv.env['API_BASE_URL']}/music/api/songs?page=1&order%5BlistenCount%5D=desc');
  if (page != null) {
    url = Uri.parse('${dotenv.env['API_BASE_URL']}/music/api/songs?page=$page&order%5BlistenCount%5D=desc');
  }
  var headers = {
    'accept': 'application/ld+json'
  };
  try {
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      return jsonResponse['member'];
    }
  } catch (e) {
    // Ignored
  }
  return [];
}