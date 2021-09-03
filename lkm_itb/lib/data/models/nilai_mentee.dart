class NilaiMentee {
  String ID;
  String name;
  int totalNilai;

  NilaiMentee({required this.ID, required this.name,required this.totalNilai});

  String get getID{
    return ID;
  }

  String get getName{
    return name;
  }

  set setID (String ID){
    this.ID = ID;
  }

  set setName (String name){
    this.name = name;
  }


  void incrementNilai(int grade) {
    this.totalNilai += grade;
  }


  

}