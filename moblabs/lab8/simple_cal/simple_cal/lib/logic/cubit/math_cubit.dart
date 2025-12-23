import 'package:bloc/bloc.dart';



class MathCubit extends Cubit<List<dynamic>>{
  MathCubit(): super([0, false, '']);
  bool error =false;
  int first = 0;
  int third = 0;
  String operation = '+';

  void setError(String message){
    var array = [...state];
    array[1] = true;
    array[2] = message;
    emit(array);
  }

  void setFirst(int? value){
    error=false;
    first = value ?? 0;
    calculate();
  }
  void setSecond(String value){
    error=false;
    operation = value=='' ? '+' : value;
    calculate();
  }
  void setThird(int? value){
    error=false;
    third = value ?? 0;
    calculate();
  }
  void calculate(){
    var array = [0, false];
    int result = 0;
    try{
    if(operation == '+'){
      result = first + third;
    } else if (operation == '-'){
      result = first - third;
    } else if (operation == '*'){
      result = first * third;
    } else if (operation == '/'){
      result = first ~/ third;
    }
    array[0]= result;
    emit(array);
    }catch(e){
      setError("division by zero");
    }

  }
}
