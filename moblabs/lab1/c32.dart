import "dart:io";





void main(){

List<String> lista = ["ayoo", "kifah", "kifach", "ayoo"];

List<String> mod = ["1"];

for (int i =0; i< lista.length; i++){
  if( ! mod.contains(lista[i]) ){
    mod.add(lista[i]);
  }
}

mod.removeAt(0);

print("${mod}");

}


