import 'package:flutter/material.dart';
import 'package:flutter_design/AddFood.dart';
import 'package:flutter_design/utills/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'Larder.dart';
import 'models/Food.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Food",
      home: Applogick(),
    ));

class Applogick extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SIForm();
}

class SIForm extends State<Applogick> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note> noteList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Image.asset('image/bq1.jpg',
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover),
//      Image.network(
//        "https://i.pinimg.com/originals/77/1a/19/771a19b5cec98b3b3b1eb7094803924b.jpg",
//        height: MediaQuery.of(context).size.height,
//        width: MediaQuery.of(context).size.width,
//        fit: BoxFit.cover,
      // ),
      Scaffold(
        floatingActionButton: new FloatingActionButton(
          onPressed: () {
            navigateToDetail(Note('', '', ''), "Fridge");
          },
          backgroundColor: Colors.lightBlueAccent,
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
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(Icons.whatshot),
                            color: Colors.white,
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Applogick2()));
                            },
                          )
                        ],
                      ))
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Fridge',
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
            SizedBox(height: 40.0),
            Padding(
              padding: const EdgeInsets.only(left: 5.0, right: 5.0),
              child: Container(
                height: MediaQuery.of(context).size.height - 115.0,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35.0),
                      topRight: Radius.circular(35.0)),
                ),
                child: Container(
                    padding:
                        EdgeInsets.only(left: 10.0, right: 10.0, top: 45.0),
                    height: MediaQuery.of(context).size.height - 230.0,
                    width: 125.0,
                    child: getNoteListView()),
              ),
            )
          ],
        ),
      ),
    ]);
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
    if (this.noteList[position].store == "Fridge") {
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
                _showDialog(position);
              },
            ),
          ),
        ),
      );
    } else {
      return Padding(padding: EdgeInsets.only(left: 0, right: 0));
    }
  }

  void _showDialog(int position) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("Delete food"),
          content: Text("Delete this food for your staff ?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog

            FlatButton(
                child: Text("DELETE"),
                onPressed: () {
                  _delete(context, noteList[position]);
                  Navigator.of(context).pop();
                }),
            FlatButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
