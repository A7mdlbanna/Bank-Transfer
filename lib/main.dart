import 'package:bank_app/layouts/home_screen.dart';
import 'package:bank_app/layouts/on_boarding.dart';
import 'package:bank_app/shared/Network/local/cached_helper.dart';
import 'package:bank_app/shared/bloc_observer.dart';
import 'package:bank_app/shared/cubit/cubit.dart';
import 'package:bank_app/shared/cubit/states.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'layouts/login_screen.dart';
import 'layouts/transfer_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init();
  BlocOverrides.runZoned(
        () {
      runApp(const MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    bool doneBoarding = CacheHelper.getData(key: 'doneBoarding')??false;
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return BlocProvider(
      create: (context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state){},
        builder: (context, state) {
          bool getUsers = CacheHelper.getData(key: 'doneGetUsers') ?? false;
          if (!getUsers && AppCubit.get(context).doneCreateDB) {
            AppCubit.get(context).insertUsers();
            CacheHelper.saveData('doneGetUsers', true);
          }
          return MaterialApp(
            title: 'Bank App',
            initialRoute: '/',
            routes: {
              '/LoginScreen': (context) => const LoginScreen(),
              '/HomeScreen': (context) => const HomeScreen(),
              '/TransferScreen': (context) => const TransferScreen(),
            },
            theme: ThemeData.dark(),
            home: doneBoarding ? const HomeScreen() : const OnBoarding(),
          );
        }
      )
    );
  }
}
