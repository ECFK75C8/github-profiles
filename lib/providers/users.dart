import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class User {
  final String username;
  final String avatarUrl;
  final String repoUrl;

  User({this.username, this.avatarUrl, this.repoUrl});
}

class Users with ChangeNotifier {
  List<User> _users = [];

  List<User> get users => [..._users];

  void clear(){
    _users.clear();
    notifyListeners();
  } 

  Future<void> fetchUsers({String location = 'lagos', int pageNum = 1}) async {
    final url =
        'https://api.github.com/search/users?q=location:$location&page=$pageNum&per_page=10';
    var client = http.Client();

    try {
      final response = await client.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) return;
      // var count = extractedData['total_count'];
      List<dynamic> items = extractedData['items'];
      items.forEach((item) {
        var username = item['login'];
        var avatarUrl = item['avatar_url'];
        var repoUrl = item['repos_url'];
        _users.add(
            User(username: username, avatarUrl: avatarUrl, repoUrl: repoUrl));
      });
      notifyListeners();
    } catch (e) {
      print(e.toString());
      throw e;
    } finally {
      client.close();
    }
  }
}
