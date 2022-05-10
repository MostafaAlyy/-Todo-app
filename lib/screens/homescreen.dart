import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:todo2app/shared/cubit.dart';
import 'package:todo2app/shared/states.dart';

// ignore: must_be_immutable
class MyHomePage extends StatelessWidget {
  MyHomePage({Key key}) : super(key: key);

  var textcontrolor = TextEditingController();
  var timecontrolor = TextEditingController();
  var datecontrolor = TextEditingController();

  @override
  var scaffoldkey = GlobalKey<ScaffoldState>();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: ((context) => AppCupid()..CreateDB()),
      child: BlocConsumer<AppCupid, AppStates>(
        listener: (context, state) {
          if (state is AppInsertToDB) {
            AppCupid.get(context).ChangeFabIcon(AppCupid.get(context).fabicon);
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          AppCupid cupit = AppCupid.get(context);

          return Scaffold(
              key: scaffoldkey,
              appBar: AppBar(
                backgroundColor: Colors.teal,
                title: const Center(
                  child: Text('TODO TASKS'),
                ),
              ),
              body: cupit.screens[cupit.curentindex],
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  if (cupit.fabicon == Icons.add) {
                    if (formkey.currentState.validate()) {
                      cupit.InsertToDB(
                        title: textcontrolor.text,
                        date: datecontrolor.text,
                        time: timecontrolor.text,
                      );
                      //cupit.ChangeFabIcon(cupit.fabicon);
                    }
                  } else {
                    scaffoldkey.currentState
                        .showBottomSheet<void>(
                            (context) => Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    width: double.infinity,
                                    height: 350,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Form(
                                        key: formkey,
                                        child: Column(
                                          //     mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(
                                              height: 20,
                                            ),
                                            TextFormField(
                                              keyboardType: TextInputType.text,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "Task Title",
                                                prefixIcon: Icon(Icons.title),
                                              ),
                                              controller: textcontrolor,
                                              validator: (valu) {
                                                if (valu.isEmpty) {
                                                  return 'Title canot be empty';
                                                } else {
                                                  return null;
                                                }
                                              },
                                              onTap: () {},
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            TextFormField(
                                              keyboardType:
                                                  TextInputType.datetime,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "Task Time",
                                                prefixIcon: Icon(
                                                    Icons.watch_later_rounded),
                                              ),
                                              controller: timecontrolor,
                                              validator: (valu) {
                                                if (valu.isEmpty) {
                                                  return 'Time canot be empty';
                                                } else {
                                                  return null;
                                                }
                                              },
                                              onTap: () {
                                                showTimePicker(
                                                        context: context,
                                                        initialTime:
                                                            TimeOfDay.now())
                                                    .then((value) {
                                                  timecontrolor.text = value
                                                      .format(context)
                                                      .toString();
                                                });
                                              },
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            TextFormField(
                                              keyboardType:
                                                  TextInputType.datetime,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "Task date",
                                                prefixIcon: Icon(
                                                    Icons.date_range_rounded),
                                              ),
                                              controller: datecontrolor,
                                              validator: (valu) {
                                                if (valu.isEmpty) {
                                                  return 'Date canot be empty';
                                                } else {
                                                  return null;
                                                }
                                              },
                                              onTap: () {
                                                showDatePicker(
                                                        context: context,
                                                        initialDate:
                                                            DateTime.now(),
                                                        firstDate:
                                                            DateTime.now(),
                                                        lastDate:
                                                            DateTime.parse(
                                                                '2022-05-29'))
                                                    .then((value) {
                                                  datecontrolor.text =
                                                      DateFormat.yMMMd()
                                                          .format(value);
                                                });
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            elevation: 15,
                            backgroundColor: Colors.transparent)
                        .closed
                        .then((value) {
                      if (cupit.fabicon == Icons.add)
                        cupit.ChangeFabIcon(cupit.fabicon);
                    });

                    cupit.ChangeFabIcon(cupit.fabicon);

                    cupit.getFromDatbase(cupit.database);
                  }
                  ;
                },
                child: Icon(cupit.fabicon),
              ),
              bottomNavigationBar: CurvedNavigationBar(
                //   currentIndex: AppCupid.get(context).curentindex,
                onTap: (index) {
                  cupit.ChangeIndex(index);
                },
                items: [
                  Icon(Icons.menu),
                  Icon(Icons.done_outline_rounded),
                  Icon(Icons.archive_outlined)
                  // const BottomNavigationBarItem(
                  //     icon: Icon(Icons.menu), label: "Tasks"),
                  // const BottomNavigationBarItem(
                  //     icon: Icon(Icons.done_outline_rounded), label: "Done"),
                  // const BottomNavigationBarItem(
                  //     icon: Icon(Icons.archive_outlined), label: "Archived"),
                ],
                // elevation: 15.0,
                backgroundColor: Colors.transparent,
                buttonBackgroundColor: Colors.amber,
                color: Colors.teal,
                // fixedColor: Colors.white,
              ));
        },
      ),
    );
  }
}
