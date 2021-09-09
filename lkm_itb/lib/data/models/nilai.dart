
class Nilai {
  // ignore: non_constant_identifier_names
  String ID;
  int totalNilai;

  // ignore: non_constant_identifier_names
  Nilai({required this.ID, required this.totalNilai});

  void setID(String id){
    this.ID = id;
  }

  void incrementNilai(int nilai){
    this.totalNilai += nilai;
  }

}