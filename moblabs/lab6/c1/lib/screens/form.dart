import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Forms extends StatefulWidget {
  const Forms({super.key});

  @override
  State<Forms> createState() => _FormsState();
}

class _FormsState extends State<Forms> {
  String user = "";
  late SharedPreferences prefs;

  Future<bool> initPrefs() async{
   prefs = await SharedPreferences.getInstance();
   user = prefs.getString("user") ?? "";
   return true;
  }

  @override
  void initState(){
    super.initState();
    initPrefs();
    if(user != "" ){
      logged = true;
    }
    _checklogged();
    }



  TextEditingController nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool search = false;
  bool logged = false;
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("Forms screen")),
      body: Center(child: 
      Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          if(!search)
          Text("Enter your Full name to Login", textAlign: TextAlign.center,),
          TextFormField(
            decoration: InputDecoration(
              labelText: "Enter your name",
            ),
            validator:(value) => _nameValidator(value),
            controller: nameController,
            ),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: _buttonpressed, child: Text("Login")),

            if(search)
            CircularProgressIndicator(),

        ],
      ))
      ),
    );
  }

  String? _nameValidator(String? value){
    if(value == null || value.isEmpty){
      return "Name cannot be empty";
    }
    if(nameController.text.length <= 3){
      return "Name is too short";
    }
    prefs.setString(user, "value");
    return null;
  }

  Future<bool> _buttonpressed() async{
    if(formKey.currentState!.validate()){
      search = true;
      setState(() {});
      await Future.delayed(Duration(seconds: 1));
      logged = true;
      _checklogged;
      return true;

    }else{
      return false;
    }
  }



  Future<bool> _checklogged( ) async{
    if(logged = true){
      await Navigator.pushNamed(context, "/logged", arguments: {"user": user});
      return true;

    }else{
      return true;
    }
  }





}







