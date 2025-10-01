import "dart:io";
import "dart:math";


void main(){

print("enter a number to calaulate its factorial");
var number = stdin.readLineSync();
var result1 = fact1( int.parse(number ?? "0"));
var result2 = fact2( int.parse(number ?? "0"));


print("result1= ${result1}, result2= ${result2}.");

}


int fact1(int number){
  var n = 1;
  if (number <= 0){return 1;}
  for (int i=1; i<=number; i++){
    n = n * i;
  }
  return n;
}



int fact2(int number){
  if(number == 0 || number == 1){return 1;}
  return number * fact2(number-1);
}



