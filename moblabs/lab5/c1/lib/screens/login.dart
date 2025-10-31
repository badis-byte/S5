import 'package:c1/screens/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool Searching = false;
  var formKey = GlobalKey<FormState>();
  var username = TextEditingController();
  bool error = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              if(!Searching)
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Login Screen", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                  SizedBox(height: 20),
                  TextFormField(
                    validator: uservalidate,
                    controller: username,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Username",
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(onPressed: _process, child: Text("Submit"))
                ],
              ),

              if(Searching)
              Column(
                children: [
              SizedBox(height: 35,),
              CircularProgressIndicator(),
                ],
              )

            ],
          ),
        ),
      ),
    );
  }

   Future<bool> fakeLoginProcess(String username) async {
   await Future.delayed(Duration(seconds: 5));
   return username == 'ensia';
    }

  Future<bool> _process() async {
    if (formKey.currentState!.validate()){
      setState(() {
        Searching = true;
      });
      bool loginSuccess = await fakeLoginProcess(username.text);
      Searching = false;
      if (loginSuccess) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Welcome()),
        );
        setState(() {});
        return true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed. Please try again.')),
        );
        setState(() {});
        return false;
      }
    } else {
      return false;
    }
  }


  String? uservalidate(String? value){
    if(value == null || value.isEmpty){
      return "Username cannot be empty";
    }
    if(value.length< 3 ){
      return "Username must be at least 3 characters long";
     }

    return null;

  }
}