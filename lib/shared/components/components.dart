import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/shared/cubit/cubit.dart';

Widget buildTaskItem(Map mytask,context)=>Dismissible(
  key: UniqueKey(),
  child:Padding(
    padding: const EdgeInsets.all(18.0),
  
    child: Row(
      children:  [
        CircleAvatar(
          backgroundColor: Colors.lightGreen,
          radius: 38.0,
          child: Text(mytask['time'],style: TextStyle(color: Colors.blue[700]),),
        ),
        SizedBox(width: 20.0,),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                mytask['title'],
                style: TextStyle(
                  fontSize: 19.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Text(
                   mytask['description'],
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.grey[500]
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
  
        SizedBox(width: 20.0,),
  
        IconButton(onPressed: (){
          AppCubit.get(context).updateDatabase(status: 'done', id: mytask['id']);
        }, icon: Icon(Icons.check_circle,color: Colors.green,)),
  
        IconButton(onPressed: (){
  
          AppCubit.get(context).updateDatabase(status: 'archiev', id: mytask['id']);
  
        }, icon: Icon(Icons.archive,color: Colors.black54,))
      ],
    ),
  ),
  onDismissed: (direction)
  {
    AppCubit.get(context).DeleteFromDatabase(id:mytask['id']);
  },
);
Widget taskBuilder({required List<Map>tasks})=> ConditionalBuilder(
    condition: tasks.isEmpty,
    builder: (context)=>Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.do_not_disturb_alt_sharp,color: Colors.blueGrey,size: 80.0,),
          SizedBox(height: 10,),
          Text(
            'No Tasks Yet !',
            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.grey),

          ),
        ],
      ),
    ),
    fallback:(context)=>
        ListView.separated(
            itemBuilder: (context,index)=>buildTaskItem(tasks[index],context),
            separatorBuilder:(context,index)=> Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],

            )
            , itemCount: tasks.length));





