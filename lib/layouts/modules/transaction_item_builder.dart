import 'package:bank_app/shared/cubit/cubit.dart';
import 'package:flutter/material.dart';

import '../../models/user_data.dart';

Widget transactionItemBuilder(UserData? user, context){
  AppCubit cubit = AppCubit.get(context);
  return SizedBox(
    height: MediaQuery.of(context).size.height/12, width: double.infinity,
    child: Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(user!.name!),
            Text(user.lastTransactionDate),
          ],
        ),
        Spacer(),
        Text('${cubit.formatNumber(!user.lastTransactionState ? user.lastTransaction*-1 : user.lastTransaction)}\$', style: TextStyle(fontSize: 18, fontFamily: 'numbers', color: Colors.red[600]),),
      ],
    ),
  );
}
