import 'package:flutter/material.dart';

class UserItem extends StatelessWidget {
  final String username;
  final String avatarUrl;
  final String location;

  UserItem({this.username, this.avatarUrl, this.location = 'lagos'});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(avatarUrl),
      ),
      title: Text(username, style: Theme.of(context).textTheme.title),
      subtitle: Text(
        location,
        style: Theme.of(context).textTheme.subtitle,
      ),
    );
  }
}
