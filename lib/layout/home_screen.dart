import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/shared/cubit/cubit.dart';
import 'package:todoapp/shared/cubit/states.dart';


class Home extends StatefulWidget {

  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {

  @override
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
      AppCubit()
        ..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {
          if (state is AppInsertDatabaseState) {
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, AppStates state) {
          AppCubit cubit = AppCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.lightGreen,
              title: Row(
                children: [
                  Text(cubit.titles[cubit.indx],
                    style: TextStyle(color: Colors.grey[700]),),
                  SizedBox(width: 25,),
                  if(cubit.indx == 0)
                    IconButton(
                      icon: Icon(Icons.add_box, color: Colors.grey[700]),
                      onPressed: () {
                        // insertIntoDatabase();
                        showTaskAlert(context, cubit);
                      },
                    ),
                ],
              ),
            ),
            body: state is AppGetDatabaseLoadingState ? Center(
                child: CircularProgressIndicator()) : cubit.Screens[cubit.indx],
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: cubit.indx,
                onTap: (index) {
                  cubit.changeIndex(index);
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.menu_open),
                    label: 'Tasks',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.check_circle),
                    label: 'Done',

                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.archive),
                    label: 'Archived',
                  ),
                ]),
          );
        },
      ),

    );
  }

  void showTaskAlert(BuildContext context, AppCubit cubit) {
    String taskTitle = '';
    String taskDescription = '';
    DateTime selectedDateTime = DateTime.now();
    TimeOfDay selectedTime = TimeOfDay.now();
    String selectedDate = "";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Create Task'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Task Title',
                  ),
                  onChanged: (value) {
                    taskTitle = value;
                  },
                ),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Task Description',
                  ),
                  onChanged: (value) {
                    taskDescription = value;
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    DatePicker.showDateTimePicker(
                      context,
                      showTitleActions: true,
                      onChanged: (date) {
                        selectedDateTime = date;
                        selectedTime = TimeOfDay.fromDateTime(date);
                        selectedDate = DateFormat.yMd().format(date);
                      },
                    );
                  },
                  child: Text('Select Date and Time'),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                cubit.insertIntoDatabase(title: taskTitle,
                    description: taskDescription,
                    time: selectedTime.format(context),
                    date: selectedDate);
                AndroidAlarmManager.oneShotAt(
                    selectedDateTime, 1, firedAlarm);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void firedAlarm() {
    print("fired at ${DateTime.now()}");
  }

}