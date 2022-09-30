import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerifyTextFeild extends StatelessWidget {
  const VerifyTextFeild({
    required this.controller,
    Key? key,
  }) : super(key: key);
  final TextEditingController controller;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50.w,
      child: TextField(
        controller: controller,
        onChanged: (value) {
          if(value.isNotEmpty){
            FocusScope.of(context).nextFocus();
          }else if(value.isEmpty){
            FocusScope.of(context).previousFocus();
          }
        },
        maxLength: 1,
        keyboardType: const TextInputType
            .numberWithOptions(
            decimal: false, signed: false),
        textAlign: TextAlign.center,

        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 1,
            ),
          ),
          counterText: '',
        ),
      ),
    );
  }
}