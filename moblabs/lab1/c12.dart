import "dart:io";
import "dart:core";


void main(){


late var first;
late var second;

print("enter the first string");
first = stdin.readLineSync();
print("enter the second string");
second = stdin.readLineSync();

var lett = anagram(first, second);

if (lett == true){
	print("they are anagram!!");
}else{
	print("they are NOT anagram!!");
}

}




bool anagram(String onee, String twoo){

var first = onee.toLowerCase();
var second =twoo.toLowerCase();

var one = first.codeUnits.toList();
var two = second.codeUnits.toList();

one.sort(); two.sort();

if(one.length != two.length){
  return false;
}
for(var i= 0; i< one.length; i++){
  if( one[i] != two[i] ){
    return false;
  }
}


return true;
}


















