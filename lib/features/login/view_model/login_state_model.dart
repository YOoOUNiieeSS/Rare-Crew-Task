import 'package:flutter/material.dart';
import 'package:rare_crew_test/features/login/models/user.dart';

class LoginStateModel {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController displayName;
  final formKey = GlobalKey<FormState>();
  final signupFormKey = GlobalKey<FormState>();
  bool isLoading;
  MyUser? user;

  LoginStateModel({
    this.user,
    this.isLoading = false,
    required this.passwordController,
    required this.emailController,
    required this.displayName,
  });
}
