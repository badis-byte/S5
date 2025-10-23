import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool loggedin = false;
  bool correcttry = true;

  var name='';
  var username= '';
  var password= '';

  List<Map<String,dynamic>> data=[
  {'username':'student1','password':'123', "name":'Ali'},
  {'username':'student2','password':'103', "name":'Aya'},
  {'username':'student3','password':'203', "name":'Ahmed'},
  {'username':'badis','password':'123', "name":'Badis'},
];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login PAge"), backgroundColor: Colors.blue,),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(  20),
            color: Colors.white,
            child: Visibility(
              visible: loggedin,
              child: Center(
                child: Container(
                  color: Colors.blueGrey,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Image.asset("assets/image.png", height: 150, width: 200,),
                      SizedBox(height: 20,),
                      Text("Welcome $name", style: TextStyle(fontSize: 30, fontWeight: FontWeight.normal), textAlign: TextAlign.center,),
                      SizedBox(height: 20,),
                      ElevatedButton(onPressed: getback, child: Text("Log Out"),)
                    ],
                  ),
                ),
              )),
          ),
          Container(
            padding: EdgeInsets.all(20),
            color: Colors.white,
            child: Visibility(
              visible: !loggedin,
              child: Column(
                children: [
                  Image.asset("assets/image.png", height: 150, width: 200,),
                  Text("Sign in", style: TextStyle(fontSize: 30, fontWeight: FontWeight.normal), textAlign: TextAlign.center,),
              
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Username"
                    ),
                    onChanged: (value) => username = value,
                  ),
                  SizedBox(height: 20,),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Password"
                    ),
                    onChanged: (value) => password = value,
                  ),
              
                  SizedBox(height: 15,),
                  Text("Forgot Password", style: TextStyle(color: Colors.blue), textAlign: TextAlign.center,),
                  Visibility(child:   Text("Incorrect username or password", style: TextStyle(color: Colors.red),), visible: !correcttry,),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    width: double.infinity,
                    height: 40,
                    color: Colors.blue,
                    child: ElevatedButton(onPressed: formvalidate, style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: Text("Login", style: TextStyle(fontSize: 20, color: Colors.white),),),
                  )
                ],
              ),
            ),
          ),
        ],
      )
    );
  }

  bool formvalidate(){
    for (var i = 0; i < data.length; i++) {
      if(data[i]['username'] == username && data[i]['password'] == password){
        setState(() {
          name= data[i]["name"];
          loggedin = true;
          correcttry = true;
        });
        return true;
      } else {
        setState(() {
          correcttry = false;
        });
      return false;
    }
    }
    return false;
  }

  bool getback(){
    setState(() {
      loggedin = false;
      name= '';
      password= '';
      username= '';
      correcttry= true;
    });
    return true;
  }
}
