import "dart:io";



void main(){

print("enter a number");

var number = stdin.readLineSync();
var the = int.parse(number ?? "0");
var binary = convert(the);

print("the number ${the} in binary is: ${binary}");

}



int convert(int number){
var iterator = 1;
var N =number;
var binary = 0;
while( number != 0 ){
N = number %2;
number = number ~/ 2;
binary = binary + iterator*N;
iterator = iterator*10;

}

  return binary;
}