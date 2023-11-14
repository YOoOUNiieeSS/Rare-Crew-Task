import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rare_crew_test/features/home_screen/models/item.dart';
import 'package:rare_crew_test/features/login/view_model/login_state_model.dart';
import 'package:rare_crew_test/features/login/models/user.dart';
import 'package:rare_crew_test/features/login/views/widgets/flash_helper.dart';
import 'package:rare_crew_test/shared_resources/routes_manager.dart';
import 'package:rare_crew_test/shared_resources/string_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../home_screen/view_model/home_provider.dart';

final loginProvider =
    StateNotifierProvider<LoginState, LoginStateModel>((ref) => LoginState());

class LoginState extends StateNotifier<LoginStateModel> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  LoginState()
      : super(LoginStateModel(
            displayName: TextEditingController(),
            emailController: TextEditingController(),
            passwordController: TextEditingController())) {
    _init();
  }

  _init() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? userStr = sharedPreferences.getString(StringManager.userKey);
    MyUser? myUser;
    if (userStr != null&&userStr!='') {
      String? userDataStr = sharedPreferences.getString('${userStr}_${StringManager.userKey}');
      if(userDataStr!=null) {
        myUser = MyUser.fromJson(jsonDecode(userDataStr));
      }
    }
    _changeState(user: myUser);
  }

  _changeState({bool? isLoading, MyUser? user}) {
    state = LoginStateModel(
        user: user ?? state.user,
        displayName: state.displayName,
        isLoading: isLoading ?? state.isLoading,
        passwordController: state.passwordController,
        emailController: state.emailController);
  }

  String? validateEmail(String? email) {
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email ?? "");
    if (!emailValid) {
      return 'enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty || password.length < 8) {
      return 'enter a valid password';
    }
    return null;
  }

  String? validateName(String? name) {
    if (name == null || name.isEmpty || name.length < 4) {
      return 'enter a valid name';
    }
    return null;
  }

  login(context) async {
    if (state.formKey.currentState?.validate() ?? false) {
      _changeState(isLoading: true);
      try {
        final res = await _auth.signInWithEmailAndPassword(
          email: state.emailController.text.trim(),
          password: state.passwordController.text.trim(),
        );
        _handleUserRes(res, context);
      }
      on FirebaseAuthException catch(e) {
        _changeState(isLoading: false);
        FlashHelper.showMsgFlash(context, e.code);
      }
      catch (e) {
        _changeState(isLoading: false);
        FlashHelper.showMsgFlash(context, e.toString());
      }
    }
  }

  register(context) async {
    if (state.signupFormKey.currentState?.validate() ?? false) {
      try {
        _changeState(isLoading: true);
        final res = await _auth.createUserWithEmailAndPassword(
          email: state.emailController.text.trim(),
          password: state.passwordController.text.trim(),
        );

        _handleUserRes(res, context, login: false);
      }
      on FirebaseAuthException catch(e) {
        _changeState(isLoading: false);
        FlashHelper.showMsgFlash(context, e.code);
      }
      catch (e) {
        _changeState(isLoading: false);
        FlashHelper.showMsgFlash(context, e);
      }
    }
  }

  _handleUserRes(UserCredential userCredential, context,
      {bool login = true}) async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      String? userStr = sharedPreferences.getString('${userCredential.user!.uid}_${StringManager.userKey}');
      late final MyUser myUser;
      if (login&&userStr!=null&&userStr!='') {
        String? userDataStr = sharedPreferences.getString('${userCredential.user!.uid}_${StringManager.userKey}');
        myUser = MyUser.fromJson(jsonDecode(userDataStr??userStr));
      } else {
        myUser = MyUser(
          name: state.displayName.text.trim(),
          email:
              userCredential.user?.email ?? state.emailController.text.trim(),
          userId: userCredential.user?.uid ?? "defaultUserId",
        );
      }

      await sharedPreferences.setString(
        StringManager.userKey,
        myUser.userId,
      );
      await sharedPreferences.setString(
        '${userCredential.user!.uid}_${StringManager.userKey}',
        jsonEncode(myUser.toMap()),
      );
      await sharedPreferences.setBool(StringManager.isLoggedKey, true);
      _changeState(isLoading: false, user: myUser);
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.homeScreen,
        (route) => route.toString() == Routes.loginRoute,
      );
    } catch (error) {
      log("Error handling user data: $error");
      _changeState(isLoading: false);
      FlashHelper.showMsgFlash(context, error);
    }
  }

  Future<void> logout(context, ref) async {
    try {
      _changeState(isLoading: true);
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await _auth.signOut();
      await sharedPreferences.setBool(StringManager.isLoggedKey, false);
      await sharedPreferences.setString(StringManager.userKey, '');
      newState();
      ref.invalidate(homeProvider);
      ref.invalidate(loginProvider);
      Navigator.pushReplacementNamed(context, Routes.loginRoute);
    }
    on FirebaseAuthException catch(e) {
      _changeState(isLoading: false);
      FlashHelper.showMsgFlash(context, e.code);
    }catch (e) {
      _changeState(isLoading: false);
      FlashHelper.showMsgFlash(context, e);
    }
  }

  newState() {
    state = LoginStateModel(
        user: null,
        emailController: TextEditingController(),
        passwordController: TextEditingController(),
        displayName: TextEditingController());
  }
}
