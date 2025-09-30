import "dart:io";


void main() {

print("enter a string and we'll tell if it is a palindrom or not");

String? pal = stdin.readLineSync();

var lett = palindrom(pal);

if (lett == true){
	print("it is a palindrom!!");
}else{
	print("it is NOT a palindrom");
}

}



bool palindrom(String? word){
	if(word == null || word!.length == 1){
    return true;
  } else if( word!.length == 2){
    return word![0] == word![1];
  } else{
    return palindrom( word!.substring(1, word!.length -2));
  }
}

