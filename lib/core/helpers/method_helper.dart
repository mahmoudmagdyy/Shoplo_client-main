///this function get index of any list of model
int getIndex(List<dynamic> list,int id){
  for(int i=0;i<list.length;i++){
    if(list[i].id==id){
      return i;
    }
  }
  return 0;
}
