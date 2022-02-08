import 'package:CaterMe/Screens/auth/login_screen.dart';
import 'package:CaterMe/Services/HomePage/PackageService.dart';
import 'package:CaterMe/model/Cuisines.dart';
import 'package:CaterMe/model/add_on.dart';

import 'package:CaterMe/model/addons/addonsall.dart';
import 'package:CaterMe/model/cuisins.dart';
import 'package:CaterMe/model/item.dart';

import 'package:CaterMe/model/occasion.dart';
import 'package:CaterMe/model/package.dart';
import 'package:CaterMe/model/packages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PackagesProvider extends  ChangeNotifier{


Packages _packages=new Packages();
 List<Package> _allpackages=[];
 List<Package> _allpackagesorder=[];
 Cuisines _cuisins=Cuisines();

List<Package> get allpackagesorder => _allpackagesorder;

  set allpackagesorder(List<Package> value) {
    _allpackagesorder = value;
  }

  List<Package> get allpackages => _allpackages;

  set allpackages(List<Package> value) {
    _allpackages = value;
  }

  List<Cuisins> _allcuisins=[];
List<AddOn> _allons=[];
List<AddOn> _allonsorder=[];
Map<String, dynamic> _alldata={};
List<AddOn> _listItems=[];

List<AddOn> get listItems => _listItems;

  set listItems(List<AddOn> value) {
    _listItems = value;
  }

  List<AddOn> get allonsorder => _allonsorder;

  set allonsorder(List<AddOn> value) {
    _allonsorder = value;
  }

  TextEditingController controllersearch=TextEditingController();
List<AddOn> get allons => _allons;

  set allons(List<AddOn> value) {
    _allons = value;
  }



  Packages get packages => _packages;

  set packages(Packages value) {
    _packages = value;
  }

  List<Addonall> _addonsall=[];

List<Occasion> _occasions=[];
List<Occasion> _alloccasions=[];
List<Package> _listfavorite=[];

List<Occasion> get alloccasions => _alloccasions;

  set alloccasions(List<Occasion> value) {
    _alloccasions = value;
  }

  List<Package> get listfavorite => _listfavorite;

  set listfavorite(List<Package> value) {
    _listfavorite = value;
  }

  List<Occasion> get occasions => _occasions;

  set occasions(List<Occasion> value) {
    _occasions = value;
  }

  List<Addonall> get addonsall => _addonsall;

set addonsall(List<Addonall> value) {
  _addonsall = value;
}

Map<String, dynamic> get alldata => _alldata;

  set alldata(Map<String, dynamic> value) {
    _alldata = value;
  }





bool _loading=false;


bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
  }






  Future<void>  getallpacakges(BuildContext c)async {
loading=false;
//notifyListeners();
    _alldata=await PackageService.getPackages();
    if(_alldata.length==0){

    }
  else  if(_alldata['status']!=null){

      Navigator.of(c).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) =>
              LoginScreen()), (Route<dynamic> route) => false);
    }
    else {
      _packages = Packages.fromJson( _alldata['packages']);
      _cuisins = Cuisines.fromJson(_alldata['cuisine']);
     _addonsall = List<Addonall>.from(_alldata['addons'].map((model) => Addonall.fromJson(model)));
      _occasions = List<Occasion>.from(_alldata['occasions'].map((model) => Occasion.fromJson(model)));

       _listItems = List<AddOn>.from(
          _alldata['dropDown'].map((model) => AddOn.fromJson(model)));
    }

loading=true;
    notifyListeners();
  }


Future<void>  getalloccasions()async {
  loading=false;
//notifyListeners();
  _alloccasions=await PackageService.AllOccasions() ;
  loading=true;
  notifyListeners();

}




Future<void>  getonid(int id)async {
  loading = false;
  // notifyListeners();
  _allons = await PackageService.getOnsbyid(id);
  loading = true;
  //         Cuisines.fromJson(_alldata['cuisine']);
  // _addonsall = List<Addonall>.from(
  //     _alldata['addons'].map((model) => Addonall.fromJson(model)));
  // _occasions = List<Occasion>.from(
  //     _alldata['occasions'].map((model) => Occasion.fromJson(model)));
  // _listItems = List<Item>.from(
  //     _alldata['dropDown'].map((model) => Item.fromJson(model)));

//loading=true;

  notifyListeners();
}

Future<void>  getonidorder(int id,int idservice,bool a)async {
  loading = false;
  // notifyListeners();
  _allonsorder = await PackageService.getOnsbyidorder(id,idservice,a);
  loading = true;
  //         Cuisines.fromJson(_alldata['cuisine']);
  // _addonsall = List<Addonall>.from(
  //     _alldata['addons'].map((model) => Addonall.fromJson(model)));
  // _occasions = List<Occasion>.from(
  //     _alldata['occasions'].map((model) => Occasion.fromJson(model)));
  // _listItems = List<Item>.from(
  //     _alldata['dropDown'].map((model) => Item.fromJson(model)));

//loading=true;

  notifyListeners();
}

getAllFavorite()async{
    _listfavorite=await PackageService.getAllFavorite();
    notifyListeners();
}

Future<void>  getpacakgesby(int id)async {

//notifyListeners();
  _allpackages=await PackageService.getPackagesbyid(id);



  loading=true;

  notifyListeners();


}
Future<void>  getpacakgesbyidorder(int idservice,int iditemtyp,int idnumberguest)async {

//notifyListeners();
  _allpackagesorder=await PackageService.getPackagesbyidorder(idservice,iditemtyp,idnumberguest);



  loading=true;

  notifyListeners();


}
Future<void>  getcuisinby(int ic)async {

//notifyListeners();
  _allcuisins=await PackageService.getCuisbyid(ic);



  loading=true;

  notifyListeners();


}

 cleardata(){

  _alldata={};
  _packages.items=[];
  _cuisins.categories=[];
  _addonsall=[];
  loading=false;
  notifyListeners();

}

List<Cuisins> get allcuisins => _allcuisins;

  set allcuisins(List<Cuisins> value) {
    _allcuisins = value;
  }

Cuisines get cuisins => _cuisins;

  set cuisins(Cuisines value) {
    _cuisins = value;
  }
}