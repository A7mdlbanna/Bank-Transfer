import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:bank_app/shared/cubit/states.dart';

import '../../models/user_data.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);


  List<String> usersName = [
    'William John',
    'Mical Zohn',
    'Denial Mark',
    'Hotel Zilla',
    'David Ali',
    'Osali Jonas',
    'Michel Jackson',
    'Jim Hopper',
    'Sadie Max',
    'Darin Hopper',
  ];
  List<String> usersEmail = [
    'William John@gmail.com',
    'Mical Zohn@gmail.com',
    'Denial Mark@gmail.com',
    'Hotel Zilla@gmail.com',
    'David Ali@gmail.com',
    'Osali Jonas@gmail.com',
    'Michel Jackson@gmail.com',
    'Jim Hopper@gmail.com',
    'Sadie Max@gmail.com',
    'Darin Hopper@gmail.com',
  ];
  List<double> usersCurrentBalance = [
    5618623.69,
    266555.69,
    35436.69,
    6709645.69,
    7457857.69,
    4296785.69,
    2789364.69,
    3894674.69,
    9367366.69,
    324574677.69,
  ];
  void insertUsers(){
    for(int i = 0; i < 10; i++) {
      insertToDatabase(name: usersName[i], email: usersEmail[i], currentBalance: usersCurrentBalance[i], lastTransaction: 0.0);
    }
  }

  double userBalance = 545212531251.55;

  String formatNumber(number){
    NumberFormat numberFormat = NumberFormat.decimalPattern('en_us');
    return numberFormat.format(number);
  }

  void transferMoney(TextEditingController controller, UserData info) {
    double money = double.parse(controller.text.substring(0, controller.text.length-1).replaceAll(',', ''));
    userBalance -= money;
    updateCurrentBalance(
        id: info.id,
        currentBalance: money + info.currentBalance,
        lastTransaction: -1 * money,
        lastTransactionDate: DateFormat.yMd().add_jm().format(DateTime.now())
    );
    emit(TransferMoney());
  }

  //////////////////DataBase///////////////////
  Database? database;
  bool doneCreateDB = false;
  void createDatabase() {
    openDatabase(
        'bank.db', version: 1,
        onCreate: (database, version) async{
          debugPrint('data.toString()base created');
          await database
              .execute(
              'CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT, email TEXT, current_balance REAL, last_transaction REAL, last_transaction_state INTEGER, last_transaction_date TEXT)')
              .then((value) {
            debugPrint('tabl.toString()e created');
          }).catchError((error) {
            debugPrint('Erro.toString()r When Creating Table ${error.toString}');
          });
        }, onOpen: (database) {
          getFromDatabase(database);
      debugPrint('data.toString()base opened');
    }).then((value) {
      database = value;
      doneCreateDB = true;
      emit(AppCreateDatabaseState());
    });
  }

  insertToDatabase({required String name, required String email, required double currentBalance, double lastTransaction = 0, int lastTransactionState = 0, String lastTransactionDate = '3/7/2022'}) async {
    await database!.transaction((txn) async{
      return await txn.rawInsert(
        'INSERT INTO users(name, email , current_balance, last_transaction, last_transaction_state, last_transaction_date) VALUES("$name", "$email" , "$currentBalance", "$lastTransaction",  "$lastTransactionState", "$lastTransactionDate")',
      ).then((value) {
        debugPrint('$value inserted successfully');
        emit(AppInsertToDatabaseState());

        getFromDatabase(database);
      }).catchError((error) {
        debugPrint('Error When Inserting New Record ${error.toString()}');
      });
    });
  }

  Users? users;
  List<UserData?> usersList = [];
  List<UserData?> lastTransactions = [];
  void getFromDatabase(database,{id}) {
    emit(AppGetFromDatabaseLoadingState());
    database.rawQuery('SELECT * FROM users').then((value) {
      debugPrint(value.toString());
      users = Users.addUser(value);
      usersList = users!.users;
      if(id != null){
        lastTransactions.insert(0, usersList[id-1]);
      }
      emit(AppGetFromDatabaseState());
    });
  }

  updateCurrentBalance({required double currentBalance, required double lastTransaction, required String lastTransactionDate, required int id}) {
      return database!.rawUpdate(
        'UPDATE users SET current_balance = ?, last_transaction = ?, last_transaction_date = ? WHERE id = ?',
          [currentBalance, lastTransaction, lastTransactionDate, id]).then((value) {
          debugPrint(value.toString());
          getFromDatabase(database, id: id);
          emit(AppUpdateDatabaseState());
      });
  }
  // void updateLastTransaction({required String lastTransaction, required int id}) {
  //     database!.rawUpdate(
  //       'UPDATE tasks SET last_transaction = ? WHERE id = ?',
  //         [lastTransaction, id]).then((value) {
  //         debugPrint(value.toString());
  //         getFromDatabase(database);
  //         emit(AppUpdateDatabaseState());
  //     });
  // }


  void deleteItem(int n){
    for(int i = 0; i <= n; i++){
      database!.rawDelete('DELETE FROM users WHERE id = ?', [i]).then((value) {
        debugPrint(value.toString());
        emit(AppDeleteDatabaseState());
      });
    }
  }
}
