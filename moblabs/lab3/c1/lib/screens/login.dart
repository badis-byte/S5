import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
   Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("Sample App", textAlign: TextAlign.center,)),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              Text("TutorialKart", style: TextStyle(fontSize: 20, color: Colors.blue),),
              Text("Sign in"),
              TextField( decoration: InputDecoration(
                labelText: "Sign in",
              ),),
              SizedBox(height :10),
              TextField( decoration: InputDecoration(
                labelText: "Password",
              ),),
              SizedBox(height :10),
              Spacer(),
              Text("Forgot Password"),
              SizedBox(height :5),
              ElevatedButton(onPressed: (){}, child: Container(width: double.infinity , child : Text("Login", textAlign: TextAlign.center, style: TextStyle(color: Colors.blue),)))
          
            ]
          ),
        )
      ),
    );
  }
}