import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rare_crew_test/features/home_screen/models/item.dart';

import '../../../../shared_resources/color_manager.dart';
import '../../../../shared_resources/string_manager.dart';
import '../../../../shared_resources/styles_manager.dart';
import '../../../login/views/widgets/textfield_signup.dart';
import '../../view_model/home_provider.dart';

class ItemDialog extends StatelessWidget {
  const ItemDialog({super.key,this.edit=false,this.item});

  final Item? item;
  final bool edit;
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final home = ref.watch(homeProvider);
        return AlertDialog(
          backgroundColor: ColorManager.appBarDark,
          content: Container(
            margin: const EdgeInsets.all(10),
            child: Form(
              key: home.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SignupTextField(
                    controller: home.itemName,
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return 'Enter an item name';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    style: getRegularStyle(
                        fontSize: 14, color: ColorManager.primaryTextDark),
                    labelText: StringManager.itemName,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SignupTextField(
                    controller: home.itemDesc,
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return 'Enter an item description';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    style: getRegularStyle(
                        fontSize: 14, color: ColorManager.primaryTextDark),
                    labelText: StringManager.itemDesc,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        edit?ref.read(homeProvider.notifier).editItem(item!):ref.read(homeProvider.notifier).addItem(context);
                      },
                      child: Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          child: home.isLoading
                              ? const CircularProgressIndicator()
                              : Text(
                            edit?StringManager.edit:StringManager.add,
                                ))),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
