import "dart:io";


// this code is not correct nor completed!!



void main(){

bool inner=true;
String s = "1+(12*45-10{14/2}])";
var ss = s.split('');
 List<String> stack = [ss[0]];

for(int i=1; i < ss.length; i++){
  if(ss[i]== "(" || ss[i]== "{" || ss[i]== "[" ){ stack.add(ss[i]);}
  if(ss[i]== ")"){ 
    if (stack.removeLast() != "("){inner = false; break;}
  }
  if(ss[i]== "]"){ 
    if (stack.removeLast() != "["){inner = false; break;}
  }
  if(ss[i]== "}"){ 
    if (stack.removeLast() != "{"){inner = false; break;}
  }
  
}

if(!inner){

if ( !stack.isEmpty && stack[0]!= "(" && stack[0]!= "{" && stack[0]!= "[" && stack[0]!= ")" && stack[0]!= "}" && stack[0]!= "]"){stack.removeAt(0);}

inner = stack.isEmpty;
}

print("string balanced?: ${inner}");

}