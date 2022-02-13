import 'package:CaterMe/model/add_on.dart';

class Addonall {
  int id=0;
  String name="";
  List<AddOn> items=[];

  Addonall();

  Addonall.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    name = json['name']??"not found";
    if (json['items'] != null) {
      items = <AddOn>[];
      json['items'].forEach((v) {
        items.add(new AddOn.fromJson(v));
      });
    }
  }


}