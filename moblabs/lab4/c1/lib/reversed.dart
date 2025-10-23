import 'package:flutter/material.dart';

class Reverse extends StatefulWidget {
  const Reverse({super.key});

  @override
  State<Reverse> createState() => _ReverseState();
}

class _ReverseState extends State<Reverse> {
  String reversedText = '';
  bool pali = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(padding: EdgeInsets.all(15),
      child: Column(
        children: [
          SizedBox(height: 20,),
          Text("Enter a text to get reversed", style: TextStyle(fontSize: 20, color: Colors.black),),
          SizedBox(height: 20,),
          Container(
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter text here',
              ),
              onChanged: (text) {
                reversedText = text.split('').reversed.join('');
                setState(() {
                  isPalindrome(text, reversedText);
                });
              },
            ),
          ),
          SizedBox(height: 20,),
          Text('the reverse is : "$reversedText"'),
          SizedBox(height: 20,),
          Visibility(visible: pali ,child: Text("the input is a palindrome", style: TextStyle(fontSize: 16, color: Colors.green),)),
      
        ],
      )
      ),
    );
  }

  bool isPalindrome(String text, String reversedText) {
    pali = text == reversedText;
    return true;
  }
}