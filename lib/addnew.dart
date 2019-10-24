import 'package:flutter/material.dart';
import 'package:flutter_design/utills/database_helper.dart';
import 'package:intl/intl.dart';
import 'models/Note.dart';

class DetailsPage extends StatefulWidget {



  final Note note;
  final selectedCard;
  DetailsPage(this. note,this.selectedCard);

  @override
  _DetailsPageState createState() => _DetailsPageState(this.note,this.selectedCard);
}

class _DetailsPageState extends State<DetailsPage> {

  var selectedCard ;
  var selectedCardImage = 'Dairy products';
  Note note;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  DatabaseHelper helper = DatabaseHelper();
  _DetailsPageState(this.note,this.selectedCard);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF7A9BEE),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: ListView(children: [
          Stack(children: [
            Container(
                height: MediaQuery.of(context).size.height - 62.0,
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent),
            Positioned(
                top: 55.0,
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(45.0),
                          topRight: Radius.circular(45.0),
                        ),
                        color: Colors.white),
                    height: MediaQuery.of(context).size.height - 100.0,
                    width: MediaQuery.of(context).size.width)),
            Positioned(
                top: 60.0,
                left: 25.0,
                right: 25.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    TextField(
                      controller: titleController,

                      onChanged: (value) {
                        debugPrint('Something changed in Title Text Field');
                        updateTitle();
                      },
                      decoration: InputDecoration(
                          labelText: 'Title',

                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)
                          )
                      ),
                    ),
                    SizedBox(height: 20.0),
                    TextField(
                      controller: descriptionController,

                      onChanged: (value) {
                        debugPrint('Something changed in Description Text Field');
                        updateDescription();
                      },
                      decoration: InputDecoration(
                          labelText: 'Description',

                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)
                          )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Store",
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 12.0,
                            color: Colors.black,
                          )),
                    ),
                    SizedBox(height: 5.0),
                    Container(
                        height: 100.0,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            _buildInfoCard('Fridge'),
                            SizedBox(width: 10.0),
                            _buildInfoCard('Larder'),
                            SizedBox(width: 10.0),
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Product",
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 12.0,
                            color: Colors.black,
                          )),
                    ),
                    Container(
                        height: 150.0,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            _buildInfoCardIMage('image/site1.png','Dairy products'),
                            SizedBox(width: 10.0),
                            _buildInfoCardIMage('image/site2.png','Meat, fats'),
                            SizedBox(width: 10.0),
                            _buildInfoCardIMage('image/site7.png','Beverages'),
                            SizedBox(width: 10.0),
                            _buildInfoCardIMage('image/site4.png','Fruit'),
                            SizedBox(width: 10.0),
                            _buildInfoCardIMage('image/site5.png','Vegetables'),
                            SizedBox(width: 10.0),
                            _buildInfoCardIMage('image/site6.png','Bread'),
                            SizedBox(width: 10.0),
                            _buildInfoCardIMage('image/site3.png','Other'),
                            SizedBox(width: 10.0),
                          ],
                        )),

                    SizedBox(height: 20.0),
                    Center(

                      child: ButtonTheme(
                        minWidth: 200.0,
                        child: RaisedButton(

                          child: Text("OK",),

                          textColor: Colors.white,
                          color:Colors.indigoAccent,
                          onPressed: () {
                            setState(() {
                              debugPrint("Save button clicked");
                              _save();

                            });
                          },
                        ),
                      ),
                    )
                  ],
                ))
          ])
        ]));
  }
  void updateTitle(){
    if(note.title==null){
      note.title="";
    }else{
      note.title = titleController.text;
    }

  }

  // Update the description of Note object
  void updateDescription() {
    if(note.title==null){
      note.description="";
    }else{
      note.description = descriptionController.text;
    }

  }
  void _save() async {

    moveToLastScreen();
    if(note.title==null){
      note.title="";
    }
    if(note.description==null){
      note.description=DateFormat.yMMMd().format(DateTime.now());;
    }
    note.product =selectedCardImage;
    note.store = selectedCard;

    int result;
    if (note.id != null) {  // Case 1: Update operation
      result = await helper.updateNote(note);
    } else { // Case 2: Insert Operation
      result = await helper.insertNote(note);
    }

    if (result != 0) {  // Success
      _showAlertDialog('Status', 'Saved Successfully');
    } else {  // Failure
      _showAlertDialog('Status', 'Problem Saving ');
    }

  }
  void _showAlertDialog(String title, String message) {

    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(
        context: context,
        builder: (_) => alertDialog
    );
  }
  void moveToLastScreen() {
    Navigator.pop(context, true);
  }
  Widget _buildInfoCard(String cardTitle) {
    return InkWell(
        onTap: () {
          selectCard(cardTitle);
        },
        child: AnimatedContainer(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeIn,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color:
                  cardTitle == selectedCard ? Color(0xFF7A9BEE) : Colors.white,
              border: Border.all(
                  color: cardTitle == selectedCard
                      ? Colors.transparent
                      : Colors.grey.withOpacity(0.3),
                  style: BorderStyle.solid,
                  width: 0.75),
            ),
            height: 100.0,
            width: 100.0,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 15.0),
                    child: Text(cardTitle,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 12.0,
                          color: cardTitle == selectedCard
                              ? Colors.white
                              : Colors.grey.withOpacity(0.7),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, bottom: 8.0),
                    child: Icon(
                        cardTitle == "Fridge" ? Icons.ac_unit : Icons.whatshot),
                  )
                ])));
  }

  selectCard(cardTitle) {
    setState(() {
      selectedCard = cardTitle;
    });
  }

  Widget _buildInfoCardIMage(String asset,String cardTitle) {
    return InkWell(
        onTap: () {
          selectedImage(cardTitle);
        },
        child: AnimatedContainer(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeIn,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: cardTitle == selectedCardImage
                  ? Color(0xFF7A9BEE)
                  : Colors.white,
              border: Border.all(
                  color: cardTitle == selectedCardImage
                      ? Colors.transparent
                      : Colors.grey.withOpacity(0.3),
                  style: BorderStyle.solid,
                  width: 0.75),
            ),
            height: 100.0,
            width: 100.0,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 15.0),
                    child: Text(cardTitle,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 12.0,
                          color: cardTitle == selectedCardImage
                              ? Colors.white
                              : Colors.grey.withOpacity(0.7),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, bottom: 8.0),
                    child:  Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(asset),
                                fit: BoxFit.cover)),
                        height: 75.0,
                        width: 75.0)),
                ])));
  }

  selectedImage(cardTitle) {
    setState(() {
      selectedCardImage = cardTitle;
    });
  }
}
