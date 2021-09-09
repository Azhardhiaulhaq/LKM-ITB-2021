class NilaiMentee {
  // ignore: non_constant_identifier_names
  String ID;
  String name;
  int totalNilai;

  // ignore: non_constant_identifier_names
  NilaiMentee({required this.ID, required this.name,required this.totalNilai});

  String get getID{
    return ID;
  }

  String get getName{
    return name;
  }

  // ignore: non_constant_identifier_names
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