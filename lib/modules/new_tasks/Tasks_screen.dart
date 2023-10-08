import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_alert/flutter_alert.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import '../../layout/home_screen.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';


class NewTasks extends StatelessWidget {

  @override

  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        listener:(context,state) {},
      builder: (context, state){
          var tasks=AppCubit.get(context).tasks;
          return taskBuilder(tasks: tasks);
    });
    }
   }
