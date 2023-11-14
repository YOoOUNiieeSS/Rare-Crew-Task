import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rare_crew_test/features/home_screen/view_model/home_provider.dart';
import 'package:rare_crew_test/shared_resources/color_manager.dart';
import 'package:rare_crew_test/shared_resources/styles_manager.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.color18,
      appBar: AppBar(
          backgroundColor: ColorManager.appBarDark,
          title: Consumer(builder: (context, ref, child) {
            final selectedTitle =
                ref.watch(homeProvider.select((value) => value.selectedTitle));
            return Text(selectedTitle,
                style: getBoldStyle(
                    fontSize: 18, color: ColorManager.primaryTextDark));
          })),
      body: Consumer(
        builder: (context, ref, child) {
          final home = ref.watch(homeProvider);
          return home.selectedView;
        },
      ),
      bottomNavigationBar: Consumer(builder: (context, ref, child) {
        final selectedIndex =
            ref.watch(homeProvider.select((value) => value.selectedIndex));
        return BottomNavigationBar(
          elevation: 10,
          backgroundColor: ColorManager.color28,
          unselectedFontSize: 12,
          selectedFontSize: 14,
          unselectedItemColor: ColorManager.secondaryTextDark,
          selectedItemColor: ColorManager.primaryTextDark,
          onTap: (index) {
            if (context.mounted) {
              ref.read(homeProvider.notifier).changeIndex(index);
            }
          },
          currentIndex: selectedIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined,
                    color: ColorManager.secondaryTextDark),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outlined,
                    color: ColorManager.secondaryTextDark),
                label: 'Profile'),
          ],
        );
      }),
    );
  }
}
