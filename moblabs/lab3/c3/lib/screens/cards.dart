import 'package:flutter/material.dart';

class Cards extends StatefulWidget {
  const Cards({super.key});

  @override
  State<Cards> createState() => _CardsState();
}

class _CardsState extends State<Cards> {


  List<Map<String, dynamic>> items =[
    {'title': "blabla", "subtitle": "bla", "text": "blablabla", "picture":"images/download (1).jpg" },
    {'title': "blabla", "subtitle": "bla", "text": "blablabla", "picture": "images/download (2).jpg"},
    {'title': "blabla", "subtitle": "bla", "text": "blablabla", "picture": "images/download.jpg"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cards")),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            cardsMaker(items[0]['title'], items[0]['subtitle'], items[0]['text'], items[0]['picture']),
            cardsMaker(items[1]['title'], items[1]['subtitle'], items[1]['text'], items[1]['picture']),
            cardsMaker(items[2]['title'], items[2]['subtitle'], items[2]['text'], items[2]['picture']),

          ]),
        ),
      )
    );
  }


  Widget cardsMaker(String title, String subtitle, String text, String path){
    return Container(
      decoration: BoxDecoration(color: Colors.white ,border: BoxBorder.fromLTRB(left: BorderSide(color: Colors.blue, width: 10)) ,borderRadius:BorderRadius.circular(20), boxShadow:[ BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(3, 3))]),
      width: 400,
      height:200,
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin:EdgeInsets.all(10),
            child: Row(
              children: [
                SizedBox(height:100, width:200, child: Image.asset(path)),
                Column( crossAxisAlignment: CrossAxisAlignment.start ,children: [Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),), Text(subtitle, style: TextStyle(color: Colors.grey),)],),
              ],),
          ),
          Container(margin: EdgeInsets.fromLTRB(25, 5, 25, 5) ,child: Text(text))
        ],
        )
    );
  }
}