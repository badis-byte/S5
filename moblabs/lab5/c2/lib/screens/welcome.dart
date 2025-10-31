import 'package:c2/repo/dummy_data.dart';
import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {

late Future<Map<String, dynamic>> data;

  @override
  Widget build(BuildContext context) {
    data = DummyData().fetchLocal();
    //print(data);
    return Scaffold(
      appBar: AppBar(title: Text("Static Tile")),
      body: Column(
        children: [
          FutureBuilder(future: data,
           builder: (context, snapshot){
            if (snapshot.connectionState == ConnectionState.waiting){
              return Text("fetching data...");
            }
            if(snapshot.hasData && snapshot.data != null){
              final the_data = snapshot.data!;
              return Row(
            children: [
            Spacer(),
            Text(the_data['title'] ?? CircularProgressIndicator(), style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
            Spacer(),
            Text( the_data['time'] ?? CircularProgressIndicator(), style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),),
            Spacer(),
            ],
          );
            }else if (snapshot.hasError){
              return Text("Error: ${snapshot.error}");
            }
            return Text("No Data Available");
           },
           ),
          Expanded(
            child: FutureBuilder(
             future: data,
             builder: (context, snapshot) {
               if (snapshot.connectionState == ConnectionState.waiting) {
                 return const Center(child: CircularProgressIndicator());
               }
               if (snapshot.hasData && snapshot.data != null) {
                 var tmp_data = snapshot.data!;
                 return ListView.builder(
                   itemCount: tmp_data['categories'].length,
                   itemBuilder: (context, index) {
                     return getItemTodo(index, tmp_data['categories']);
                   },
                 );
               } else if (snapshot.hasError) {
                 return Center(child: Text('Error: ${snapshot.error}'));
               }
               return const Center(child: Text('No Data Available'));
             },
          ),
          ),
        ],
      ) ,
    );
  }

  Card getItemTodo(int index, List<Map<String, dynamic>> data) {
    return Card(
                elevation: 5,
                margin: EdgeInsets.all(10),
                child: ListTile(
                  title: Text("${data[index]['name']}") ,
                ),
              );
  }
}