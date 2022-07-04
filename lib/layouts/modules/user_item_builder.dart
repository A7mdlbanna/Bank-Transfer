import 'package:bank_app/shared/cubit/cubit.dart';
import 'package:flutter/material.dart';

import '../../models/user_data.dart';

Widget userItemBuilder(UserData? user, context){
  AppCubit cubit = AppCubit.get(context);
  return InkWell(
    onTap: (){},
    child: SizedBox(
      height: MediaQuery.of(context).size.height/12, width: double.infinity,
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(user!.name!, style: TextStyle(fontSize: MediaQuery.of(context).size.height/50),),
              Text(user.email!, style: TextStyle(fontSize: MediaQuery.of(context).size.height/65),),
            ],
          ),
          Spacer(),
          Text('${cubit.formatNumber(user.currentBalance)}\$', style: TextStyle(fontSize: 18, fontFamily: 'numbers'),),
        ],
      ),
    ),
  );
}
