import 'dart:io';

import 'package:app_bandnames/src/models/band.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: 'Metalica', votes: 6),
    Band(id: '2', name: 'Guns', votes: 1),
    Band(id: '3', name: 'Roses', votes: 2),
    Band(id: '4', name: 'AC/DC', votes: 4),
    Band(id: '5', name: 'The Vines', votes: 7),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Center(child: Text('BandNames', style: TextStyle(color: Colors.yellowAccent),)),
      ),
      body:ListView.builder(
        itemCount: bands.length,
        itemBuilder: (BuildContext context, int index) { 
        return Dismissible (
          key: Key(bands[index].id),
          direction: DismissDirection.startToEnd,
          onDismissed: (direction){
            print('$direction');
            print('id: ${bands[index].id}');
          },
          background: Container(
            color: Colors.red,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Delete Band', style: TextStyle(color: Colors.white),))) ,
          child: ListTile(
            leading: CircleAvatar(
              child: Text(bands[index].name.substring(0,2)),
              backgroundColor: Colors.blue[100],
            ),
            title: Text(bands[index].name),
            trailing: Text('${bands[index].votes}', style: TextStyle(fontSize: 20),),
            onTap: (){
              print('${bands[index].name}');
            },
          ),
        );
       },),
       floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 1,
        onPressed: (){
          addNewBand();
        },
       ),
   );
  }

  addNewBand(){

  final textController = TextEditingController();

  if(Platform.isAndroid){
    showDialog(
      context: context, 
      builder: (context){
        return AlertDialog(
          title: Text('New Band Name'),
          content: TextField(
            controller: textController,
          ),
          actions: [
            MaterialButton(
              elevation: 5,
              child: Text('Add'),
              textColor: Colors.blue,
              onPressed: (){
                  addBandToList(textController.text);
              }
            )
          ],
        ); 
      });
    }else{

    showCupertinoDialog(
      context: context, 
      builder: (context){
        return CupertinoAlertDialog(
          title: Text('New Band name'),
          content: TextField(
            controller: textController,
          ),
          actions: [
            CupertinoDialogAction(
              child: Text('Add'),
              onPressed: (){
                addBandToList(textController.text);
              },),
              CupertinoDialogAction(
              child: Text('Dismiss'),
              onPressed: (){
                  Navigator.pop(context);
              },)
          ],
        );
      });
    }
  }

  void addBandToList(String name){
    if(name.length > 1){
      this.bands.add(Band(
        id: DateTime.now().toString(), 
        name: name, 
        votes: 0));
    }
    setState(() {
      
    });
  Navigator.pop(context);
  }
}