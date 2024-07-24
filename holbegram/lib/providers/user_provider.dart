import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:holbegram/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  Users? _user;

  Users? get user => _user;

  Future loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? user = prefs.getString("userInfo");
    if (user != null) {
      _user = Users.fromSnap(jsonDecode(user));
      notifyListeners();
    }
    return _user;
  }

  Future setUser(Users? user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _user = user;
    prefs.setString("userInfo", jsonEncode(user!.toJson()));
    notifyListeners();
  }

  void clearUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _user = null;
    prefs.remove("userInfo");
    notifyListeners();
  }
}
