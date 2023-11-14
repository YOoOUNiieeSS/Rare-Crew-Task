import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rare_crew_test/features/home_screen/view_model/home_provider.dart';
import 'package:rare_crew_test/features/login/view_model/login_provider.dart';
import 'package:rare_crew_test/shared_resources/color_manager.dart';
import 'package:rare_crew_test/shared_resources/string_manager.dart';
import 'package:rare_crew_test/shared_resources/styles_manager.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer(
        builder: (context, ref, child) {
          final user = ref.watch(loginProvider.select((value) => value.user));

          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InlineData(
                    value: user?.userId ?? 'user id', label: 'User  ID: '),
                const SizedBox(
                  height: 15,
                ),
                InlineData(
                    value: user?.name ?? 'Display Name value',
                    label: 'Display Name: '),
                const SizedBox(
                  height: 15,
                ),
                InlineData(
                    value: user?.email ?? 'Email value', label: 'Email: '),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                    onPressed: () async {
                      await ref
                          .read(loginProvider.notifier)
                          .logout(context, ref);
                    },
                    child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        child: const Text(StringManager.logout))),
              ],
            ),
          );
        },
      ),
    );
  }
}

class InlineData extends StatelessWidget {
  const InlineData({super.key, required this.value, required this.label});

  final String label;
  final String value;
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: label,
          style: getRegularStyle(
              color: ColorManager.secondaryTextDark, fontSize: 16),
          children: [
            TextSpan(
                style: getBoldStyle(
                    color: ColorManager.primaryTextDark, fontSize: 18),
                text: value)
          ]),
    );
  }
}
