import "dart:io";
import "dart:core";






void main(){

print("enter your sentence:");
var sent = stdin.readLineSync() ?? "";

var jdid = capitalizer(sent);
print(jdid);
}

String capitalizer(String sentence){
int n=0;
String caped = sentence.split("")[0].toUpperCase();
var senten = sentence.substring(1);

for (var word in senten.split("")){
  if(word == " " || word == "." || word == ","){
    n++;
    caped = caped + word;
    continue;
  }
  if(n > 0){
    caped = caped + word.toUpperCase();
    n=0;
  }else{
    caped = caped + word;
  }
}
return caped;

}