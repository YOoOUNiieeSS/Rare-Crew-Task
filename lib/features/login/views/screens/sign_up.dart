import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rare_crew_test/features/login/view_model/login_provider.dart';
import 'package:rare_crew_test/features/login/views/widgets/textfield_signup.dart';
import 'package:rare_crew_test/shared_resources/string_manager.dart';
import 'package:rare_crew_test/shared_resources/styles_manager.dart';

import '../../../../shared_resources/color_manager.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.appBarDark,
      body: SafeArea(
          child: Consumer(
            builder: (context, ref, child) {
              final register = ref.watch(loginProvider);
              return Form(
                key: register.signupFormKey,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(StringManager.register,
                          style: getRegularStyle(
                              color: ColorManager.primaryTextDark,
                              fontSize: 18)
                              .copyWith(letterSpacing: 3)),
                      const SizedBox(height: 10,),
                      SignupTextField(
                        controller: register.displayName,
                        validator: ref.read(loginProvider.notifier).validateName,
                        keyboardType: TextInputType.text,
                        style: getRegularStyle(
                            fontSize: 14, color: ColorManager.primaryTextDark),
                        labelText: StringManager.displayName,
                      ),
                      const SizedBox(height: 10,),
                      SignupTextField(
                        controller: register.emailController,
                        validator: ref.read(loginProvider.notifier).validateEmail,
                        keyboardType: TextInputType.emailAddress,
                        style: getRegularStyle(
                            fontSize: 14, color: ColorManager.primaryTextDark),
                        labelText: StringManager.emailAddress,
                      ),
                      const SizedBox(height: 10,),
                      SignupTextField(
                        controller: register.passwordController,
                        validator: ref.read(loginProvider.notifier).validatePassword,
                        keyboardType: TextInputType.visiblePassword,
                        isPassword: true,
                        style: getRegularStyle(
                            fontSize: 14, color: ColorManager.primaryTextDark),
                        labelText: StringManager.password,
                      ),
                      const SizedBox(height: 10,),
                      ElevatedButton(
                          onPressed: ()=>ref.read(loginProvider.notifier).register(context),
                          child:  Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              child: register.isLoading?const CircularProgressIndicator():const Text(StringManager.signup,))),
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
