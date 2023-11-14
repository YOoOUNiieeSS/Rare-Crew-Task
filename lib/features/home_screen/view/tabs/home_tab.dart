import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rare_crew_test/features/home_screen/models/item.dart';
import 'package:rare_crew_test/features/home_screen/view/widgets/dialog.dart';
import 'package:rare_crew_test/features/home_screen/view_model/home_provider.dart';
import 'package:rare_crew_test/features/login/views/widgets/textfield_signup.dart';
import 'package:rare_crew_test/shared_resources/color_manager.dart';
import 'package:rare_crew_test/shared_resources/styles_manager.dart';

import '../../../../shared_resources/string_manager.dart';
import '../widgets/item_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final home = ref.watch(homeProvider);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (home.items.isNotEmpty)
              Expanded(
                  child: ListView.builder(
                shrinkWrap: true,
                itemCount: home.items.length,
                itemBuilder: (context, index) =>
                    ItemWidget(item: home.items[index]),
              )),
            if (home.items.isEmpty) ...[
              const Spacer(),
              Center(
                child: Text(
                  "There is no items, try to add new item.",
                  style: getRegularStyle(
                      color: ColorManager.primaryTextDark, fontSize: 14),
                ),
              ),
              const Spacer()
            ],
            Container(
              margin: const EdgeInsets.all(12),
              child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          ref.read(homeProvider.notifier).updateControllers(
                              Item(name: '', itemId: 0, description: ''));
                          return const ItemDialog();
                        });
                  },
                  child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      child: const Text("Add New Item"))),
            )
          ],
        );
      },
    );
  }
}
