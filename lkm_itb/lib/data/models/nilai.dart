
class Nilai {
  String ID;
  int totalNilai;

  Nilai({required this.ID, required this.totalNilai});

  void setID(String id){
    this.ID = id;
  }

  void incrementNilai(int nilai){
    this.totalNilai += nilai;
  }

}