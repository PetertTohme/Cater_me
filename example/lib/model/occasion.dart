class Occasion {
  int id=0;
  String type="";
  String date="";
  String name="";
 bool yearly;

  Occasion();

Occasion.fromJson(Map<String, dynamic> json) {
  id = json['id']??0;
  date = json['date']??"not found";
  name = json['title']??"not found";
  type = json['type']??"not found";
}
  Occasion.fromJsonadd(Map<String, dynamic> json) {
    id = json['profileId']??0;
    date = json['date']??"not found";
    name = json['title']??"not found";
    type = json['type'].toString()??"not found";

  }
}
