import 'package:flutter/material.dart';

class PricingScreen extends StatefulWidget {
  const PricingScreen({super.key});

  @override
  State<PricingScreen> createState() => _PricingScreenState();
}

class _PricingScreenState extends State<PricingScreen> {
  int isSelected = 0;
  @override
  Widget build(BuildContext context) {
    List<Map<String,dynamic>> items = [
      {"title": "Free", "Price": "10"},
      {"title": "Pro", "Price": "200"},
      {"title": "Business", "Price": "400"},
      {"title": "Premium", "Price": "900"}
    ];

    return Scaffold(appBar: AppBar(title: Text("Pricing", textAlign: TextAlign.center,),),
                    body:  Container(
                      margin: EdgeInsets.all(10),
                      child: Column(
                        
                        children: [
                          SizedBox(height: 15,), 
                          Text("Choose\n Your Plan", textAlign: TextAlign.center, style: TextStyle(fontSize: 30, height: 1, fontWeight: FontWeight.bold, ),),   
                          //SizedBox(height: 20,), 
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              makeit(items[0]["title"], items[0]["Price"], 0),
                              SizedBox(width: 20),
                              makeit(items[1]["title"], items[1]["Price"], 1),
                            ],
                          ),
                          SizedBox(height: 20,), 
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              makeit(items[2]["title"], items[2]["Price"], 2),
                              SizedBox(width: 20),
                              makeit(items[3]["title"], items[3]["Price"], 3),
                            ],
                          ),
                          SizedBox(height: 30,),
                          makelist( "Unlimited product updates"),
                          makelist( "100+ templates"),
                          makelist( "24/7 support"),
                          Spacer(),

                          ElevatedButton(onPressed:() {
                            print("Subscribed to ${items[isSelected]["title"]} plan");
                          },
                          style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),), backgroundColor: Colors.blue),
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 130, vertical: 15),
                            child: Text("Subscribe", style: TextStyle(fontSize: 18, color: Colors.white),),
                          )
                          )
                        ],
                        ),
                    )
                    );
  }

  Widget makeit(String offre, String price, int index){
    bool s = index == isSelected;
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = index;
        });
      },
      child: Container(
        width: 200,
        height: 120,
        decoration: BoxDecoration(
          border: Border.all( width: 2, color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
          color: s ? Colors.lightBlueAccent : Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Text(offre, style: TextStyle( fontSize: 23, fontWeight: FontWeight.bold, height: 1),),
            Text(price, style: TextStyle(color: s ? Colors.amber: Colors.grey,)),
          ],
        ),
      ),
    );
  }

  Widget makelist(String sentence){
    return Container(
      margin: EdgeInsets.only(top: 10, left: 50),
      child: Row(
        children: [
          Image.asset("assets/icons/check.png", width: 25, height: 25,),
          SizedBox(width: 10,),
          Text(sentence, style: TextStyle(fontSize: 16, color: Colors.grey),)
      ],),  
    );
  }

}