import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rare_crew_test/features/login/view_model/login_provider.dart';
import 'package:rare_crew_test/features/login/views/widgets/textfield_signup.dart';
import 'package:rare_crew_test/shared_resources/routes_manager.dart';
import 'package:rare_crew_test/shared_resources/string_manager.dart';
import 'package:rare_crew_test/shared_resources/styles_manager.dart';

import '../../../../shared_resources/color_manager.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.appBarDark,
      body: SafeArea(
        child: Consumer(
          builder: (context, ref, child) {
            final login = ref.watch(loginProvider);
            return Form(
              key: login.formKey,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(StringManager.welcome,
                            style: getRegularStyle(
                                color: ColorManager.primaryTextDark,
                                fontSize: 18)
                                .copyWith(letterSpacing: 3)),
                        Text(StringManager.pleaseLoginToYourAccount,
                            style: getRegularStyle(
                                color: ColorManager.secondaryTextDark,
                                fontSize: 14)
                                .copyWith(letterSpacing: 1)),
                      ],
                    ),
                    const SizedBox(height: 30,),
                    SignupTextField(
                      controller: login.emailController,
                      validator: ref.read(loginProvider.notifier).validateEmail,
                      keyboardType: TextInputType.emailAddress,
                      style: getRegularStyle(
                          fontSize: 14, color: ColorManager.primaryTextDark),
                      labelText: StringManager.emailAddress,
                    ),
                    const SizedBox(height: 10,),
                    SignupTextField(
                      controller: login.passwordController,
                      validator: ref.read(loginProvider.notifier).validatePassword,
                      keyboardType: TextInputType.visiblePassword,
                      isPassword: true,
                      style: getRegularStyle(
                          fontSize: 14, color: ColorManager.primaryTextDark),
                      labelText: StringManager.password,
                    ),
                    const SizedBox(height: 10,),
                    ElevatedButton(
                        onPressed: ()=>ref.read(loginProvider.notifier).login(context),
                        child:  Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            child: login.isLoading?const CircularProgressIndicator():const Text(StringManager.login,))),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          StringManager.doNotHaveAccount,
                          style: getRegularStyle(
                              fontSize: 14,
                              color: ColorManager.secondaryTextDark),
                        ),
                        TextButton(
                            onPressed: () {
                              ref.read(loginProvider.notifier).newState();
                              Navigator.pushNamed(context, Routes.signup);
                            },
                            child: Text(
                              StringManager.signupNow,
                              style: getRegularStyle(
                                  fontSize: 14,
                                  color: ColorManager.primaryTextDark),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        )
      ),
    );
  }
}
