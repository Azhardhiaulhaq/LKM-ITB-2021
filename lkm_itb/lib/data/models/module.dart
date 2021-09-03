class Module {
  String? modulID;
  String? banner;
  String? naration;
  String? name;
  List<String>? questions;

  Module({this.modulID,this.banner,this.naration,this.name,this.questions});

  factory Module.fromJson(Map<String, dynamic> json){
    return Module(
      modulID: json['moduleID'],
      banner: json['banner'],
      naration: json['naration'],
      name: json['name'],
      questions: json['questions']
    );

  }
}