import 'package:bank_app/layouts/modules/build_transfer_button.dart';
import 'package:bank_app/layouts/modules/transaction_item_builder.dart';
import 'package:bank_app/models/user_data.dart';
import 'package:bank_app/shared/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/cubit/states.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (_, state){},
      builder: (_, state){
        AppCubit cubit = AppCubit.get(context);
        double height = MediaQuery.of(context).size.height;
        double width = MediaQuery.of(context).size.width;
        return Scaffold(
          backgroundColor: const Color(0xFF1C1C1E),
          appBar: AppBar(
            elevation: 0.8,
            backgroundColor: const Color(0xFF1C1C1E),
            leading: IconButton(icon: const ImageIcon(AssetImage('assets/icons/menu.png'), size: 30,), onPressed: () {}, ),
            title: const Center(child: Text('PARTNER', style: TextStyle(fontSize: 18, letterSpacing: 6.0, fontWeight: FontWeight.w300),)),
            actions: [
              IconButton(icon: const ImageIcon(AssetImage('assets/icons/user.png'), size: 30,), onPressed: () {}, ),
            ],
          ),
          body: cubit.usersList.isEmpty ? Center(child: CircularProgressIndicator(),) : SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              child: Column(
                children: [
                  const SizedBox(height: 100,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: FittedBox(child: Text('\$${cubit.formatNumber(cubit.userBalance)}', style: TextStyle(fontSize: height/15, fontFamily: 'numbers' ),)),
                  ),
                  Text('Current Balance', style: TextStyle(fontSize: height/50 , color: Color(0xFFB0ABAB),)),
                  const SizedBox(height: 100,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      buildTransferButton(context: context, icon: 'assets/icons/send.png', text: 'Transfer', transfer: true),
                      buildTransferButton(context: context, icon: 'assets/icons/receive.png', text: 'Receive'),
                    ],
                  ),
                  const SizedBox(height: 80,),
                  Text('TRANSACTIONS', style: TextStyle(fontSize: height/40 ),),
                  const SizedBox(height: 20,),
                  cubit.lastTransactions.isNotEmpty
                      ? ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) => transactionItemBuilder(cubit.lastTransactions[index], context),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                    height: 10,
                                  ),
                              itemCount:
                                  cubit.usersList.length)
                      : Padding(
                        padding: EdgeInsets.only(top: height/4),
                        child: Text('There are no recently transactions ^^', style: TextStyle(fontSize: height/40, color: Colors.white54),),
                      ),
                ],
              ),
            ),
          ),
        );
      },
    );
    Users? users;
  }
}
