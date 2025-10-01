import "dart:io";
import "dart:math";







void main(){
print("enter a number to check if it is a prime:");
var number = stdin.readLineSync();
var decision = prime( double.parse(number ?? "0"));

if(decision){
  print("it is a prime!!");
}else{
  print("it is NOT a prime!!");
}


}



bool prime(var number){
var half = sqrt(number);
for(int i=2; i<= half; i++){
  if( number % i == 0){
    return false;
  }
}
return true;
}