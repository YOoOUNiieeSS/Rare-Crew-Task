import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rare_crew_test/features/home_screen/models/item.dart';
import 'package:rare_crew_test/features/home_screen/view_model/home_provider.dart';
import 'package:rare_crew_test/shared_resources/color_manager.dart';
import 'package:rare_crew_test/shared_resources/styles_manager.dart';

import 'dialog.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({super.key, required this.item});
  final Item item;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: ColorManager.appBarDark,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                item.name,
                style: getBoldStyle(
                        color: ColorManager.primaryTextDark, fontSize: 14)
                    .copyWith(overflow: TextOverflow.ellipsis),
                maxLines: 1,
              ),
              Text(
                item.description,
                style: getBoldStyle(
                        color: ColorManager.secondaryTextDark, fontSize: 12)
                    .copyWith(overflow: TextOverflow.ellipsis),
                maxLines: 1,
              ),
            ],
          )),
          Consumer(
            builder: (context, ref, child) => InkWell(
                onTap: () {
                  ref.read(homeProvider.notifier).updateControllers(item);
                  showDialog(
                      context: context,
                      builder: (_) => ItemDialog(
                            edit: true,
                            item: item,
                          ));
                },
                child: Icon(
                  Icons.edit_outlined,
                  color: ColorManager.primaryTextDark,
                )),
          ),
          Consumer(
            builder: (context, ref, child) => InkWell(
                onTap: () => ref.read(homeProvider.notifier).deleteItem(item),
                child: Icon(
                  Icons.delete_outline,
                  color: ColorManager.primaryTextDark,
                )),
          ),
        ],
      ),
    );
  }
}
