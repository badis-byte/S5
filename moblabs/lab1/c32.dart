import "dart:io";





void main(){

List<String> lista = ["ayoo", "kifah", "kifach", "ayoo"];

var liste = removeDuplicate(lista);

print(liste);
}




List<String> removeDuplicate(List<String> lista){

  Map<String, int> jdida = {};

List<String> liste = [];


for(int i =0; i < lista.length; i++){

if( jdida[lista[i]] == null){
  jdida[lista[i]] = 1;
  liste.add(lista[i]);
}

}

return liste;
}
