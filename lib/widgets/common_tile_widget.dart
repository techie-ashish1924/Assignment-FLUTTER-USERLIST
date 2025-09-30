import 'package:assignment/model/user_model.dart';
import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final User user;
  const UserTile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        user.name ?? "title",
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(user.email ?? "dummy email"),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        Navigator.pushNamed(context, '/detail', arguments: user);
      },
    );
  }
}
