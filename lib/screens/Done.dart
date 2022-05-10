import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo2app/shared/states.dart';
import 'package:todo2app/shared/task.dart';

import '../shared/cubit.dart';

class DoneSCreen extends StatelessWidget {
  const DoneSCreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCupid cupit = AppCupid.get(context);

    return BlocConsumer<AppCupid, AppStates>(
      listener: (context, state) {},
      builder: (contrxt, state) {
        return ListView.builder(
            itemBuilder: ((context, index) => Task(
                model: cupit.donetasks[index],
                context: context,
                isdone: true,
                isarchived: false)),
            itemCount: cupit.donetasks.length);
      },
    );
  }
}
