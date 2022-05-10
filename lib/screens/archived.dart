import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo2app/shared/states.dart';
import 'package:todo2app/shared/task.dart';

import '../shared/cubit.dart';

class ArchivedSCreen extends StatelessWidget {
  const ArchivedSCreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCupid cupit = AppCupid.get(context);

    return BlocConsumer<AppCupid, AppStates>(
      listener: (context, state) {},
      builder: (contrxt, state) {
        return ListView.builder(
            itemBuilder: ((context, index) =>
                Task(model:  cupit.archivedtasks[index], context: context,isdone: false,isarchived: true)),
            itemCount: cupit.archivedtasks.length);
      },
    );
  }
}
