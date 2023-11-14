import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rare_crew_test/features/home_screen/models/item.dart';
import 'package:rare_crew_test/features/home_screen/view/tabs/home_tab.dart';
import 'package:rare_crew_test/features/home_screen/view/tabs/profile_tab.dart';
import 'package:rare_crew_test/features/login/view_model/login_provider.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_state.dart';

final homeProvider = StateNotifierProvider<HomeState, HomeStateModel>((ref) {
  final user = ref.watch(loginProvider.select((value) => value.user));
  return HomeState(user);
});

class HomeState extends StateNotifier<HomeStateModel> {
  HomeState(user)
      : super(HomeStateModel(
            selectedView: const HomeView(),
            user: user,
            itemDesc: TextEditingController(),
            itemName: TextEditingController())) {
    getLocalItems();
  }

  final List<String> titles = ["Home", "Profile"];
  final List<Widget> views = [
    const HomeView(),
    const ProfileView(),
  ];

  changeIndex(int index) {
    _changeState(
        index: index, selectedTitle: titles[index], view: views[index]);
  }

  _changeState(
      {bool? isLoading,
      int? index,
      String? selectedTitle,
      Widget? view,
      List<Item>? items}) {
    state = HomeStateModel(
        items: items ?? state.items,
        selectedView: view ?? state.selectedView,
        selectedIndex: index ?? state.selectedIndex,
        selectedTitle: selectedTitle ?? state.selectedTitle,
        itemName: state.itemName,
        itemDesc: state.itemDesc,
        user: state.user,
        isLoading: isLoading ?? state.isLoading);
  }

  saveToLocalStorage() async {
    final SharedPreferences shared = await SharedPreferences.getInstance();
    shared.setStringList(state.user?.userId ?? "userId",
        state.items.map<String>((e) => jsonEncode(e.toMap())).toList());
  }

  Future<void> getLocalItems() async {
    if (state.user == null) return;
    final SharedPreferences shared = await SharedPreferences.getInstance();
    final itemsStr = shared.getStringList(state.user!.userId);
    if (itemsStr != null) {
      _changeState(
          items:
              itemsStr.map<Item>((e) => Item.fromJson(jsonDecode(e))).toList());
    }
  }

  addItem(context) {
    if (state.formKey.currentState?.validate() ?? false) {
      try {
        int randomNumber =
            state.items.isEmpty ? 0 : (state.items.last.itemId + 1);

        final Item item = Item(
            name: state.itemName.text.trim(),
            itemId: randomNumber,
            description: state.itemDesc.text.trim());
        List<Item> temp = List.from(state.items);
        temp.add(item);
        state.items = List.from(temp);
        state.itemName.text = '';
        state.itemDesc.text = '';
        _changeState(items: state.items, isLoading: false);
        saveToLocalStorage();
        Navigator.pop(context);
      } catch (e) {
        _changeState(isLoading: false);
      }
    }
  }

  deleteItem(Item item) {
    state.items.removeWhere((element) => element.itemId == item.itemId);
    _changeState(items: state.items);
    saveToLocalStorage();
  }

  editItem(Item item) {
    try {
      final int index = state.items.indexOf(item);
      List<Item> temp = List.from(state.items);
      temp.removeWhere((element) => element.itemId == item.itemId);
      temp.insert(
          index,
          Item(
              name: state.itemName.text.trim(),
              itemId: item.itemId,
              description: state.itemDesc.text.trim()));
      state.itemName.text = '';
      state.itemDesc.text = '';
      _changeState(items: temp, isLoading: false);
      saveToLocalStorage();
    } catch (e) {
      print("error ==> $e");
    }
  }

  updateControllers(Item item) {
    state.itemDesc.text = item.description;
    state.itemName.text = item.name;
  }
}
