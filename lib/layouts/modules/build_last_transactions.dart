import 'package:bank_app/layouts/modules/transaction_item_builder.dart';
import 'package:bank_app/shared/cubit/cubit.dart';
import 'package:flutter/material.dart';

Widget buildLastTransactions(context){
  AppCubit cubit = AppCubit.get(context);
  double height = MediaQuery.of(context).size.height;

  return cubit.lastTransactions.isNotEmpty ? ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) => transactionItemBuilder(cubit.lastTransactions[index], context),
      separatorBuilder: (context, index) =>
      const SizedBox(height: 10,),
      itemCount: cubit.lastTransactions.length
  ) : Padding(
    padding: EdgeInsets.symmetric(vertical: height/8),
    child: FittedBox(child: Text('There are no recent transactions ^^', style: TextStyle(fontSize: height/40, color: Colors.white54),)),
  );
}