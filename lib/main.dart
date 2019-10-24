
import 'package:flutter/material.dart';
import 'package:flutter_design/addnew.dart';

import 'hot.dart';


void main() => runApp(MaterialApp(

      debugShowCheckedModeBanner: false,

      title: "tak",
      home: Applogick(),
    ));

class Applogick extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SIForm();
}

class SIForm extends State<Applogick> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: new FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context)=> DetailsPage(heroTag: "", foodName: "", foodPrice: "")
          ));
        },
        backgroundColor: Colors.lightBlueAccent,
        elevation: 3,
        child: const Icon(Icons.add),
      ),

      floatingActionButtonLocation:FloatingActionButtonLocation.centerFloat,
      backgroundColor: Colors.lightBlueAccent,
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 15.0, left: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
//                IconButton(
//                  icon: Icon(Icons.arrow_back_ios),
//                  color: Colors.white,
//                  onPressed: () {},
//                ),
                Container(
                    width: 125.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                builder: (context) => Applogick2()
                            ));
                          },
                        )
                      ],
                    ))
              ],
            ),
          ),
          SizedBox(height: 15.0),
          Padding(
            padding: EdgeInsets.only(left: 40.0),
            child: Row(
              children: <Widget>[
                Text('Fridge',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0)),
                SizedBox(width: 10.0),

              ],
            ),
          ),
          SizedBox(height: 20.0),
          Container(
            height: MediaQuery.of(context).size.height - 155.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(75.0)),
            ),
            child: ListView(
              primary: false,
              padding: EdgeInsets.only(left: 25.0, right: 20.0),
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(top: 45.0),
                    child: Container(
                        height: MediaQuery.of(context).size.height - 230.0,
                        child: ListView(children: [
                          _buildFoodItem('image/site1.png', 'Salmon bowl', '\$24.00'),
                          _buildFoodItem('image/site6.png', 'Spring swl', '\$222.00'),
                          _buildFoodItem('image/site3.png', 'Spring bowl', '\$22.00'),
                          _buildFoodItem('image/site3.png', 'Spring bowl', '\$23.00'),

                        ]))),

              ],
            ),
          )
        ],
      ),
    );
  }

 Widget _buildFoodItem(String imgPath, String foodName, String price) {
    return Padding(
        padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
        child: InkWell(
            onTap: () {

            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    child: Row(
                        children: [
                          Hero(
                              tag: imgPath+foodName+price,
                              child:  Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(imgPath),
                                          fit: BoxFit.cover)),
                                  height: 60.0,
                                  width: 60.0)
                          ),
                          SizedBox(width: 10.0),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:[
                                Text(
                                    foodName,
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.bold
                                    )
                                ),
                                Text(
                                    price,
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 15.0,
                                        color: Colors.grey
                                    )
                                )
                              ]
                          )
                        ]
                    )
                ),
                IconButton(
                    icon: Icon(Icons.add),
                    color: Colors.black,
                    onPressed: () {}
                )
              ],
            )
        ));
  }
}
