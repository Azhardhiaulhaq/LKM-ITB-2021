class PenilaianModul {
  String userID;
  String name;
  int nilai;
  bool isComplete;

  PenilaianModul(
      {required this.userID,
      required this.name,
      required this.nilai,
      required this.isComplete});

  void setID(String id) {
    this.userID = id;
  }

  void incrementNilai(int nilai) {
    this.nilai += nilai;
  }

  void setName(String name) {
    this.name = name;
  }

  void setStatus(bool status) {
    this.isComplete = status;
  }
}
