import 'package:flutter_riverpod/flutter_riverpod.dart';

class User {
  final int id;
  final int roleID;

  const User({required this.id, required this.roleID});
}

class UserProvider extends StateNotifier<User> {
  UserProvider() : super(const User(id: 0, roleID: 0));

  addUser(User user) {
    state = user;
  }
}

final userProvider =
    StateNotifierProvider<UserProvider, User>((ref) => UserProvider());
