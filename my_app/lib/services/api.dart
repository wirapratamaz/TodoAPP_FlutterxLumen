import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_app/helper/connection_config.dart';
import 'package:my_app/models/Book.dart';

import 'package:my_app/models/book_record.dart';

const baseUrl = "jsonplaceholder.typicode.com";
const localUrl = ConnectionConfig.localUrl;

class API {
  static Future getUsers() {
    final url = Uri.https(baseUrl, "/users");
    return http.get(url);
  }

  static Future getBooks() {
    final url = Uri.http(localUrl, "/show-index");
    return http.get(url);
  }

  static Future<BookRecord> createBookRecord(String title) async {
    final response = await http.post(
      Uri.http(localUrl, "/create-data"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': title,
      }),
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return BookRecord.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create BookRecord.');
    }
  }

  static Future<http.Response> deleteBookRecord(String id) async {
    final http.Response response = await http.delete(
      Uri.http(localUrl, "/delete-data/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return response;
  }
}
