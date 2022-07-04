import 'package:flutter/material.dart';

import '../../shared/cubit/cubit.dart';

Widget buildTransferButton({required context, required icon, required text, bool transfer = false}){
  double width = MediaQuery.of(context).size.width;
  return InkWell(
    onTap: () => transfer ? Navigator.pushNamed(context, '/TransferScreen') : null,
    child: Container(
      width: width/2.5, height: width/6,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(width/10),
        gradient: const LinearGradient(colors: [Color(0xFFFF9900), Color(0xFFEFC842)], ),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ImageIcon(AssetImage(icon), size: width/11,),
            FittedBox(
              child: Text(text, style: TextStyle(fontSize: width/20, fontWeight: FontWeight.w700))
            ),
          ],
        ),
      ),
    ),
  );
}