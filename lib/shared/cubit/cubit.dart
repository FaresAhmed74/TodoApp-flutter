import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/shared/cubit/states.dart';

import '../../modules/archived_tasks/Archived_screen.dart';
import '../../modules/done_tasks/Done_screen.dart';
import '../../modules/new_tasks/Tasks_screen.dart';
import '../components/constants.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit():super(AppIntialState());

  static AppCubit get(context) => BlocProvider.of(context);

  /////////////// var///////////////////////
  int indx=0;
  List<Widget>Screens=[
    NewTasks(),
    doneTasks(),
    archivedTasks(),
  ];
  List<String>titles=[
    'New Tasks',
    'Done Tasks',
    'Archived Tasks'
  ];

  late Database database;
  List<Map> tasks=[];
  List<Map> doneTask=[];
  List<Map> archievedTask=[];
  void changeIndex(int index){
    indx=index;
    emit(AppChangeNavbarState());
  }

  void  createDatabase() {
     openDatabase(
        'todo.db',
        version: 1,
        onCreate: (database, version)  {
          print(' database created');
          database.execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY,title TEXT,description TEXT ,date TEXT, time TEXT, status TEXT)')
              .then
            ((value) {
            print('Table created');
          }
          ).catchError((error) {
            print('Error creating table  ${error.toString()}');
          }
          );
        },
        onOpen: (database) {
          getDataFromDatabase(database);
          print('database opened');
        }
    ).then((value)  {
      database=value;
      emit(AppCreateDatabaseState());
    });
  }

  void insertIntoDatabase({@required title, @required description, @required time, @required date,}) {
    database.transaction((txn) {
      var req = txn.rawInsert(
          'INSERT INTO tasks(title,description,date,time,status) VALUES("$title","$description","$date","$time","new")')
          .then((value) {
        print('the id ${value} inserted successfully');
        print('the title ${title} inserted successfully');
        emit(AppInsertDatabaseState());

        getDataFromDatabase(database);
      })
          .catchError((error) {
        print('Error when inserting ${error.toString()}');
      });
      return req;
    });
  }

  void getDataFromDatabase(database){
      tasks=[];
      doneTask=[];
      archievedTask=[];
    emit(AppGetDatabaseLoadingState());
    database.rawQuery('SELECT * FROM tasks').then((value) {
      // tasks=value;
      // print(tasks);
      value.forEach((element) {
        if(element['status']=='new'){
          tasks.add(element);
        }
        else if(element['status']=='done'){
          doneTask.add(element);
        }
        else
          {
            archievedTask.add(element);
          }
      });
      emit(AppGetDatabaseState());
    });
  }
  void updateDatabase({required String status,required int id}){
     database.rawUpdate(
      'UPDATE tasks SET status=? where id =?',
      ['$status',id],
    ).then((value) {
      print('database updated');
      getDataFromDatabase(database);
      emit(AppUpdateDatabaseState());
     });
  }
  void DeleteFromDatabase({required int id}){
    database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).
    then((value) {
      getDataFromDatabase(database);
      print('row number $id was deleted');
      emit(AppDeleteFromDatabase());

    });
  }
}

