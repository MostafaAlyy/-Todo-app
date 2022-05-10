import 'package:flutter/material.dart';
import 'package:todo2app/shared/cubit.dart';

Widget Task(
    {@required Map model,
    @required context,
    @required isdone,
    @required isarchived}) {
  return Dismissible(
    key: Key(model['id'].toString()),
    onDismissed: (direction) {
      AppCupid.get(context).DeletFromDb(model['id']);
    },
    background: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.red,
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.grey,
        ),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.teal,
                radius: 40,
                child: Text(
                  "${model['time']}",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "${model['title']}",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Text(
                      "${model['date']}",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 25,
              ),
              (isdone == false)
                  ? Row(children: [
                      SizedBox(
                        width: 5,
                      ),
                      IconButton(
                          onPressed: () {
                            AppCupid.get(context).UpDateDB(
                              status: 'done',
                              id: model['id'],
                            );
                          },
                          icon: Icon(
                            Icons.check_box,
                            color: Colors.amber,
                          )),
                    ])
                  : Container(),
              SizedBox(
                width: 5,
              ),
              (isarchived == false)
                  ? Row(children: [
                      SizedBox(
                        width: 5,
                      ),
                      IconButton(
                          onPressed: () {
                            AppCupid.get(context).UpDateDB(
                              status: 'archived',
                              id: model['id'],
                            );
                          },
                          icon: Icon(
                            Icons.archive,
                            color: Colors.black,
                          )),
                    ])
                  : Container(),
              (isdone || isarchived)
                  ? Row(children: [
                      SizedBox(
                        width: 5,
                      ),
                      IconButton(
                          onPressed: () {
                            AppCupid.get(context).UpDateDB(
                              status: 'new',
                              id: model['id'],
                            );
                            AppCupid.get(context)
                                .getFromDatbase(AppCupid.get(context).database);
                          },
                          icon: Icon(
                            Icons.undo_sharp,
                            color: Colors.amber,
                          )),
                    ])
                  : Container(),
            ],
          ),
        ),
      ),
    ),
  );
}
