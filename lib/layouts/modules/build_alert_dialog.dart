import 'package:flutter/material.dart';

import '../../models/user_data.dart';
import '../../shared/cubit/cubit.dart';

 buildAlertDialog(context, UserData? user) {
   AppCubit cubit = AppCubit.get(context);
   TextEditingController controller = TextEditingController();
   double height = MediaQuery
       .of(context)
       .size
       .height;

   return showDialog(
       context: context,
       builder: (context) =>
           AlertDialog(
             // backgroundColor: Colors.transparent,
             title: const Text('Transfer', textAlign: TextAlign.center,),
             titlePadding: const EdgeInsets.symmetric(vertical: 20),
             shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(height / 20)
             ),
             content: Column(
               mainAxisSize: MainAxisSize.min,
               children: [
                 FittedBox(child: Text('Transfer money to ${user!.name}')),
                 TextFormField(
                   controller: controller,
                   onChanged: (value) {
                     value.endsWith('\$')
                         ? controller.text = '${cubit.formatNumber(double.parse(value.substring(0, value.length - 1).replaceAll(',', '')))}\$'
                         : controller.text = '${cubit.formatNumber(double.parse(value.replaceAll(',', '')))}\$';
                     controller.selection = TextSelection.fromPosition(TextPosition(offset: controller.text.length - 1));
                   },
                   autofocus: true,
                   keyboardType: TextInputType.number,
                   textAlign: TextAlign.center,
                   keyboardAppearance: Brightness.dark,
                   decoration: const InputDecoration(
                     hintText: '\$0.0',
                     focusedBorder: InputBorder.none,
                     border: InputBorder.none,
                   ),
                 )
               ],
             ),
             actionsAlignment: MainAxisAlignment.center,
             actionsPadding: const EdgeInsets.only(bottom: 20),
             actions: [
               ElevatedButton(
                   onPressed: () {
                     Navigator.pop(context);
                     cubit.transferMoney(controller, user);
                   },
                   style: ElevatedButton.styleFrom(
                     primary: Colors.amber,
                   ),
                   child: const Text('Transfer')
               )
             ],
           )
   );
 }