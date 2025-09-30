import 'dart:convert';

import 'package:assignment/model/user_model.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  final String apiUrl = "https://jsonplaceholder.typicode.com/users";

  Future<List<User>> fetchUser() async {
    try {
      final response = await http.get(
        Uri.parse(apiUrl),

        headers: {'Accept': "application/json"},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        return data.map((json) => User.fromJson(json)).toList();
      } else {
        throw Exception(
          "Failed to load users. Status code: ${response.statusCode}",
        );
      }
    } catch (e) {
      throw Exception("Something went wrong while fetching users ${e}");
    }

    // return;
  }
}
