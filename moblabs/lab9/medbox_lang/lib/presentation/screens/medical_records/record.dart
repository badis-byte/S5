import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:medbox/data/repositories/profiles/profile_repo.dart';
import 'package:medbox/logic/cubits/profiles_cubit.dart';
import 'package:medbox/logic/cubits/records_cubit.dart';
import 'package:path/path.dart';


// Future<bool> getPatients(context, patients, patient) async{
//   late final ProfilesRepo profileRepo;
//   profileRepo = GetIt.I<ProfilesRepo>();
//   patients = await profileRepo.getData();


//   for(var i= 0; i< patients.length; i++){
//     patient.add(patients[i]['name']);
// }

//   return true;
// }


bool getpatient(List<Map<String, dynamic>>state, List<String> patients){

for(var i=0; i< state.length; i++){
  patients.add(state[i]['name']);
}
return true;
}


class Record extends StatefulWidget {
  const Record({super.key});

  @override
  State<Record> createState() => _RecordState();
}

class _RecordState extends State<Record> {
  
  String? _selectedItem;
  var formkey = GlobalKey<FormState>();
  TextEditingController doctor = TextEditingController();
  TextEditingController notes = TextEditingController();
  @override
  Widget build(BuildContext context) {
   List<String> patients=[];
    return Scaffold(body: Center(child: 
    Form(
      key: formkey,
      child: Column(
      children: [
        TextFormField(
          controller: doctor,
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: const OutlineInputBorder(),
              hintText: "enter doctor name",
              hintStyle: const TextStyle(
                color: Color.fromARGB(255, 124, 124, 157),
                fontSize: 15,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
        ),
        BlocConsumer<ProfilesCubit, Map<String, dynamic>>(
          builder: (context, state) {
              if (state['state'] == 'loading') {
                return CircularProgressIndicator();
              }
              if (state['state'] == 'error') {
                return Text('Error....${state['data']['message']}');
              }
              getpatient(state['data'], patients);
              
              print("$state ");

              print("$patients ");
              print("$_selectedItem ");
              if (_selectedItem==null)
                _selectedItem=patients[0];

              //return Text("ddd");
              return DropdownButton<String>(
              value: _selectedItem, // The currently selected value
              hint: Text('Select an option'), // Optional hint when nothing is selected
              onChanged: (String? newValue) {
              setState(() {
             _selectedItem = newValue;
                });
              },
              items: patients.map<DropdownMenuItem<String>>((String item) {
              return DropdownMenuItem<String>(
               value: item,
                child: Text(item),
                );
                }).toList(),
                );
            },
        listener: (context, state){
        }
        ),
        TextFormField(
          controller: notes,
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: const OutlineInputBorder(),
              hintText: "any notes",
              hintStyle: const TextStyle(
                color: Color.fromARGB(255, 124, 124, 157),
                fontSize: 15,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
        ),
          ElevatedButton(onPressed: () => _process(context, _selectedItem), child: Text("create"))
      ],
    ))
    ,)
    
    ,);
  }

  void _process(context, _selectedItem){
   context.read<RecordsCubit>().insertItem({
    'doctor':doctor, 'note':notes, 'name':_selectedItem});

    Navigator.of(context).pop();
    setState(() {
      
    });
  }
}