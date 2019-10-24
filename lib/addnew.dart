import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  final heroTag;
  final foodName;
  final foodPrice;

  DetailsPage({this.heroTag, this.foodName, this.foodPrice});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  var selectedCard = 'Fridge';
  var selectedCardImage = 'Fruit';

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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Store",
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 12.0,
                            color: Colors.black,
                          )),
                    ),
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
                            _buildInfoCardIMage('image/site1.png','Dairy products '),
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
                    TextField(
                      decoration: InputDecoration(hintText: 'Enter a title'),
                    ),
                    SizedBox(height: 20.0),
                    TextField(
                      decoration: InputDecoration(
                          hintText: 'Enter a short description'),
                    ),
                    SizedBox(height: 20.0),
                    Center(
                      child: RaisedButton(

                        child: Text("OK",),
                        textColor: Colors.white,
                        color:Colors.indigoAccent,
                        onPressed: () {

                        },
                      ),
                    )
                  ],
                ))
          ])
        ]));
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
