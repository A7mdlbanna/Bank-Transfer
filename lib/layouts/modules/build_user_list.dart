import 'package:bank_app/layouts/modules/transaction_item_builder.dart';
import 'package:bank_app/layouts/modules/user_item_builder.dart';
import 'package:bank_app/shared/cubit/cubit.dart';
import 'package:flutter/material.dart';

Widget buildUserList(context){
  AppCubit cubit = AppCubit.get(context);

  return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) => userItemBuilder(cubit.usersList[index], context),
      separatorBuilder: (context, index) =>
      const SizedBox(height: 10,),
      itemCount: cubit.usersList.length
  );
}