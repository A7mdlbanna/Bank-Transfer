import 'package:flutter/material.dart';

import '../shared/cubit/cubit.dart';
import 'modules/build_last_transactions.dart';
import 'modules/build_user_list.dart';

class TransferScreen extends StatelessWidget {
  const TransferScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: const Color(0xFF1C1C1E),
        appBar: AppBar(
          elevation: 0.8,
          backgroundColor: const Color(0xFF1C1C1E),
          leading: IconButton(icon: const ImageIcon(
            AssetImage('assets/icons/menu.png'), size: 30,), onPressed: () {},),
          title: const Center(child: Text('PARTNER', style: TextStyle(
              fontSize: 18, letterSpacing: 6.0, fontWeight: FontWeight.w300),)),
          actions: [
            IconButton(icon: const ImageIcon(
              AssetImage('assets/icons/user.png'), size: 30,),
              onPressed: () {},),
          ],
        ),
        body: cubit.usersList.isEmpty
            ? const Center(child: CircularProgressIndicator(),
        ) : Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Transfer', style: TextStyle(fontSize: height / 20),),
                Text('Money', style: TextStyle(fontSize: height / 40, color: Colors.white38),),
                const SizedBox(height: 20,),
                buildUserList(context),
                Divider(),
                SizedBox(height: 30,),
                Text('Last Transactions', style: TextStyle(fontSize: height/40 ),),
                buildLastTransactions(context),
              ],
            ),
          ),
        )
    );
  }
}
