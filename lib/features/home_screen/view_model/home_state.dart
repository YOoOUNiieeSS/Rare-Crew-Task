import 'package:flutter/material.dart';
import 'package:rare_crew_test/features/home_screen/models/item.dart';
import 'package:rare_crew_test/features/login/models/user.dart';

class HomeStateModel {
  final TextEditingController itemName;
  final TextEditingController itemDesc;
  int selectedIndex;
  MyUser? user;
  String selectedTitle;
  Widget selectedView;
  List<Item> items;
  final formKey = GlobalKey<FormState>();
  bool isLoading;

  HomeStateModel(
      {required this.itemDesc,
        required this.itemName,
        this.user,
        this.isLoading = false,
        this.items = const [],
        this.selectedIndex = 0,
        this.selectedTitle = 'Home',
        required this.selectedView});
}
