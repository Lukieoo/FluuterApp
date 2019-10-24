import 'package:flutter/material.dart';
import 'package:flutter_design/addnew.dart';
import 'package:flutter_design/utills/database_helper.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';

import 'main.dart';
import 'models/Note.dart';
import 'note_detail.dart';

class Applogick2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SIForm2();
}

class SIForm2 extends State<Applogick2> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note> noteList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Image.network(
        "https://cdn.apartmenttherapy.info/image/fetch/f_jpg,q_auto:eco,c_fill,g_auto,w_1500,ar_1:1/https%3A%2F%2Fstorage.googleapis.com%2Fgen-atmedia%2F3%2F2017%2F06%2F2832ac37be11d5fabdab28b5e17de6c50f7fd8c5.jpeg",
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      Scaffold(
        floatingActionButton: new FloatingActionButton(
          backgroundColor: Colors.orangeAccent,
          onPressed: () {
            navigateToDetail(Note('', '', ''), "Larder");
          },
          elevation: 3,
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        backgroundColor: Colors.transparent,
        body: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                      width: 125.0,
                      child: Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.ac_unit),
                            color: Colors.white,
                            onPressed: () {
                              Navigator.of(context).pop(MaterialPageRoute(
                                  builder: (context) => Applogick()));
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.whatshot),
                            color: Colors.white,
                            onPressed: () {},
                          )
                        ],
                      ))
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Larder',
                    style: TextStyle(
                        shadows: [
                          Shadow(
                            blurRadius: 40.0,
                            color: Colors.black,
                            offset: Offset(5.0, 5.0),
                          ),
                        ],
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 35.0)),
                SizedBox(width: 10.0),
              ],
            ),
            SizedBox(height: 20.0),
            Container(
              height: MediaQuery.of(context).size.height - 115.0,
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 0.9),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(35.0),
                    topLeft: Radius.circular(35.0)),
              ),
              child: Container(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 45.0),
                  height: MediaQuery.of(context).size.height - 230.0,
                  width: 125.0,
                  child: getNoteListView()),
            )
          ],
        ),
      )
    ]);
  }

  Widget _buildFoodItem(String imgPath, String foodName, String price) {
    return Padding(
        padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
        child: InkWell(
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    child: Row(children: [
                  Hero(
                      tag: imgPath,
                      child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(imgPath),
                                  fit: BoxFit.cover)),
                          height: 60.0,
                          width: 60.0)),
                  SizedBox(width: 10.0),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(foodName,
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold)),
                        Text(price,
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 15.0,
                                color: Colors.grey))
                      ])
                ])),
                IconButton(
                    icon: Icon(Icons.add),
                    color: Colors.black,
                    onPressed: () {})
              ],
            )));
  }

  Color getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;
        break;
      case 2:
        return Colors.yellow;
        break;

      default:
        return Colors.yellow;
    }
  }

  Icon getPriorityIcon(int priority) {
    switch (priority) {
      case 1:
        return Icon(Icons.play_arrow);
        break;
      case 2:
        return Icon(Icons.keyboard_arrow_right);
        break;

      default:
        return Icon(Icons.keyboard_arrow_right);
    }
  }

  void _delete(BuildContext context, Note note) async {
    int result = await databaseHelper.deleteNote(note.id);
    if (result != 0) {
      updateListView();
    }
  }

  ListView getNoteListView() {
    TextStyle titleStyle = TextStyle(
        fontFamily: 'Montserrat', fontSize: 17.0, fontWeight: FontWeight.bold);
    updateListView();
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return draw(position, titleStyle);
      },
    );
  }

  void navigateToDetail(Note note, String title) async {
    bool result = await Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => DetailsPage(note, title)));

    if (result == true) {
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList = noteList;
          this.count = noteList.length;
        });
      });
    });
  }

  String imageset(String product) {
    String setIMage;
    switch (product) {
      case "Dairy products":
        {
          setIMage = 'image/site1.png';
          break;
        }
      case "Meat, fats":
        {
          setIMage = 'image/site2.png';
          break;
        }
      case "Beverages":
        {
          setIMage = 'image/site7.png';
          break;
        }
      case "Fruit":
        {
          setIMage = 'image/site4.png';
          break;
        }
      case "Vegetables":
        {
          setIMage = 'image/site5.png';
          break;
        }
      case "Bread":
        {
          setIMage = 'image/site6.png';
          break;
        }
      case "Other":
        {
          setIMage = 'image/site3.png';
          break;
        }
      default:
        {
          setIMage = 'image/site3.png';
        }
    }
    return setIMage;
  }

  Padding draw(int position, TextStyle titleStyle) {
    if (this.noteList[position].store == "Larder") {
      return Padding(
        padding: EdgeInsets.only(left: 10.0, right: 10.0),
        child: Card(
          color: Colors.transparent,
          elevation: 0,
          child: ListTile(
            leading: Hero(
                tag: this.noteList[position].id,
                child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                imageset(this.noteList[position].product)),
                            fit: BoxFit.cover)),
                    height: 60.0,
                    width: 60.0)),
            title: Text(
              this.noteList[position].title,
              style: titleStyle,
            ),
            subtitle: Text(this.noteList[position].description),
            trailing: GestureDetector(
              child: Icon(
                Icons.delete,
                color: Colors.black,
              ),
              onTap: () {
                _delete(context, noteList[position]);
              },
            ),
          ),
        ),
      );
    } else {
      return Padding(padding: EdgeInsets.only(left: 0, right: 0));
    }
  }
}
