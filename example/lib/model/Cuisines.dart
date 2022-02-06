import 'cuisins.dart';

class Cuisines {
  int id=0;
  String name="";
  List<Cuisins>categories=[];

  Cuisines();

  Cuisines.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['categories'] != null) {
      categories = <Cuisins>[];
      json['categories'].forEach((v) {
        categories.add(new Cuisins.fromJson(v));
      });
    }
  }


}