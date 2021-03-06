
import 'dart:convert';

import 'package:CaterMe/Services/ApiLink.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/setup_items_model.dart';


class SetupItemsService {
  Future<List<setupItemsModel>> getallsetupItems(String a)async {
    List l=[];
    try{
      SharedPreferences prefs=await SharedPreferences.getInstance();
      var headers={'Authorization': 'Bearer ${prefs.getString("token")}'};
      var request=http.Request('GET',Uri.parse(ApiLink.setupitems));
      request.headers.addAll(headers);
      http.StreamedResponse responses =await request.send();
      var response = await http.Response.fromStream(responses);
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        l =List<setupItemsModel>.from(responseData['setupItems'].map((model) => setupItemsModel.fromJson(model,a)));
        // setupItemsModel posts = setupItemsModel.fromJson(responseData,a);

        return l;
      } else {
        print(response.reasonPhrase);
        return [];
      }
    } catch (e) {
      return [];
    }
  }

}