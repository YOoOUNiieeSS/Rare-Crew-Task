import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rare_crew_test/shared_resources/color_manager.dart';
import 'package:rare_crew_test/shared_resources/styles_manager.dart';

class SignupTextField extends StatelessWidget {

  final TextInputType keyboardType;
  final String? labelText;
  final bool isPassword,readOnly;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final int? maxLength;
  final void Function(String?)? onSaved;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  const SignupTextField({super.key, required this.keyboardType,this.maxLength,this.readOnly=false,this.onChanged,this.onSaved,this.controller,this.validator,this.onTap,this.labelText,this.style,this.isPassword=false,this.labelStyle});

  final TextStyle? labelStyle,style;
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (c,ref,_){
        final toggle = ref.watch(toggleVisibility);
        return TextFormField(
            onTapOutside: (_)=>FocusScope.of(context).unfocus(),
            maxLength: maxLength,
            controller: controller,
            readOnly: readOnly,
            validator: validator,
            onChanged: onChanged,
            onSaved: onSaved,
            keyboardType: keyboardType,
            onTap: onTap,
            obscureText: isPassword&&toggle,
            decoration: InputDecoration(
                suffixIcon: isPassword?InkWell(onTap: (){
                  ref.read(toggleVisibility.notifier).state=!toggle;
                }, child: Icon(toggle?Icons.visibility_off_outlined:Icons.visibility_outlined)):null,
                labelText: labelText,
                labelStyle: labelStyle
            ),
            style: style??getRegularStyle(fontSize: 12,color: ColorManager.primaryTextDark,),
        );
      }
    );
  }
}
final toggleVisibility = StateProvider((ref) =>true);