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



bool palindrom(String? wordss){

  
	if(wordss == null || wordss!.length == 1){
    return true;
  } else if( wordss!.length == 2){
    var words = wordss!.trim();
    var word= words.toLowerCase();
      return word![0] == word![1];
  } else{
    var words = wordss!.trim();
    var word= words.toLowerCase();
      return word![0] == word![word!.length-1] && palindrom( word!.substring(1, word!.length -1));
  }
}

