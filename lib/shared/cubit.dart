import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo2app/shared/states.dart';

import '../screens/Done.dart';
import '../screens/Tasks.dart';
import '../screens/archived.dart';

class AppCupid extends Cubit<AppStates> {
  AppCupid() : super(AppIntialstate());
  IconData fabicon = Icons.edit;
  static AppCupid get(context) => BlocProvider.of(context);
  List<Map> newtasks = [];
  List<Map> donetasks = [];
  List<Map> archivedtasks = [];

  int curentindex = 0;
  List<Widget> screens = [
    TasksSCreen(),
    DoneSCreen(),
    ArchivedSCreen(),
  ];
  Database database;

  void ChangeIndex(index) {
    curentindex = index;
    emit(AppNavBarChange());
  }

  void CreateDB() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) async {
        print("DATABASE CREATED");
        await database.execute(
            'CREATE TABLE tasks(id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT)');
        print("table created");
      },
      onOpen: (database) {
        getFromDatbase(database);
        print("database opened");
      },
    ).then((value) {
      database = value;
      emit(AppCreateDB());
    });
  }

  InsertToDB({
    @required String title,
    @required String time,
    @required String date,
  }) async {
    await database.transaction((txn) {
      txn.rawInsert(
          'INSERT INTO tasks(title, date, time, status) VALUES("$title", "$date","$time","new") ');
      print('inserted successful');
    }).then((value) {
      emit(AppInsertToDB());
      getFromDatbase(database);
    });
  }

  Future<List<Map>> getFromDatbase(database) {
    this.newtasks = [];
    this.donetasks = [];
    this.archivedtasks = [];
    database.rawQuery("SELECT * FROM tasks").then((value) {
      value.forEach((element) {
        if (element['status'] == 'new')
          newtasks.add(element);
        else if (element['status'] == 'done')
          donetasks.add(element);
        else
          archivedtasks.add(element);

        emit(AppgetDB());
      });
    });
    //   await print(tasks);
  }

  void ChangeFabIcon(IconData icon) {
    this.fabicon = icon;
    if (icon == Icons.add) {
      this.fabicon = Icons.edit;
    } else {
      this.fabicon = Icons.add;
    }
    emit(AppChangeFab());
  }

  Future UpDateDB({
    @required String status,
    @required int id,
  }) async {
    return await database.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id]).then((value) {
      getFromDatbase(database);
      emit(AppUpdateDB());
      print("stste updated");
    });
  }

  Future DeletFromDb(int id) async {
    return await database
        .rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getFromDatbase(database);
      emit(AppdeleteDB());
    });
  }
}
