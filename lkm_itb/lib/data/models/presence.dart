class Presence {
  String? userID;
  String? name;
  bool isPresence;

  Presence({this.userID,this.name,required this.isPresence});

  void setPresence(bool value){
    isPresence = value;
  }


}