import "dart:io";
import "dart:core";






void main(){

print("enter your sentence:");
var sent = stdin.readLineSync() ?? "";

var jdid = capitalizer(sent);
print(jdid);
}



bool previousisletter(String sentence, int index){
  Set<int> accent = {192, 224, 231, 232, 233, 234, 235, 249, 250, 251, 252, 255};
  if(index ==0){ return false;}
  if( !accent.contains(sentence[index - 1].codeUnitAt(0)) ){
    if( !( (sentence[index-1].codeUnitAt(0) >= 65 && sentence[index-1].codeUnitAt(0) <= 90) || (sentence[index-1].codeUnitAt(0) >= 97 && sentence[index-1].codeUnitAt(0) <= 122) ) ){
      return false;
    }

    return  true;
  }
  return  true;
}

String capitalizer(String sentence){
  var jdida = "";
  for(int i=0; i<sentence.length; i++){
    if( previousisletter(sentence, i)){
      jdida = jdida + sentence[i];
    }else{
      jdida = jdida + sentence[i].toUpperCase();
    }
  }


return jdida;
}