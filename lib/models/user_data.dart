class Users{
  List<UserData?> users = [];

  Users.addUser(List<Map<String, dynamic>> users){
    users.forEach((element) {
      this.users.add(UserData.addUser(element));
    });
  }
}

class UserData{

  UserData({required this.id, this.name, this.email, required this.currentBalance, required this.lastTransaction, required this.lastTransactionState, required this.lastTransactionDate});

  late int id;
  String? name;
  String? email;
  late double currentBalance;
  late double lastTransaction;
  late bool lastTransactionState;
  late String lastTransactionDate;

  UserData.addUser(Map<String, dynamic> user){
    id = user['id'];
    name = user['name'];
    email = user['email'];
    currentBalance = user['current_balance'];
    lastTransaction = user['last_transaction'];
    lastTransactionState = user['last_transaction_state']=='true';
    lastTransactionDate = user['last_transaction_date'];
  }
}