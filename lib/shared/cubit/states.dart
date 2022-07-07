abstract class AppStates{}

class AppInitialState extends AppStates{}



class TransferMoney extends AppStates{}
class AddTransaction extends AppStates{}

////////////////DataBase//////////////////
class AppChangeTasksValue extends AppStates{}
class AppCreateDatabaseState extends AppStates{}
class AppInsertToDatabaseState extends AppStates{}
class AppGetFromDatabaseState extends AppStates{}
class AppGetFromDatabaseLoadingState extends AppStates{}
class AppUpdateDatabaseState extends AppStates{}
class AppDeleteDatabaseState extends AppStates{}