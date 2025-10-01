import "dart:io";





bool main(){

String one = "11025471100255";
var counter =0;

var split = one.split('');
for(int i=0; i< split.length-1; i++){
  if(split[i] == "0" && split[i+1] == "0"){counter++;}
}

return counter == 1;

}