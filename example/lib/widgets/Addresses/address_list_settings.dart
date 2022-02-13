import 'package:CaterMe/Providers/address.dart';
import 'package:CaterMe/Providers/order_provider.dart';
import 'package:CaterMe/Screens/occasion/theme/colors/light_colors.dart';
import 'package:CaterMe/model/address/address.dart';
import 'package:CaterMe/model/address_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import 'addresses_textField.dart';

class AddressesListSettings extends StatefulWidget {
  final List<Address> address;
  Function deleteAddress;

  AddressesListSettings(this.address, this.deleteAddress);

  @override
  State<AddressesListSettings> createState() => _AddressesListSettingsState();
}

class _AddressesListSettingsState extends State<AddressesListSettings> {
  int _value = -1;


  @override
  Widget build(BuildContext context) {
    final orderprovider =
    Provider.of<OrderCaterProvider>(context, listen: true);
    final address=Provider.of<AdressProvider>(context,listen: true);
    var _mediaQueryWidth = MediaQuery.of(context).size.width;
    var _mediaQuery = MediaQuery.of(context).size.height;
    return Container(

      height: _mediaQuery * 0.7,
      child: widget.address.isEmpty
          ? Center(
          child: Container(
            child: Image.asset('images/NoAdresses.png'),
          ))
          : ListView.builder(
          itemCount: widget.address.length,
          itemBuilder: (ctx, index) {
            return Slidable(
              key: UniqueKey(),
              endActionPane: ActionPane(
                motion:  BehindMotion(),
                children:  [
                  Spacer(),
                  IconButton(onPressed: (){
                    address.valueIndex=index;
                    address.createOrUpdate=1;
                    address.id=widget.address[index].id;
                    address.addresstitlecontroller.text=widget.address[index].title;
                    address.citycontrollerstring.text=widget.address[index].city;
                    // address.countrycontrollerstring.text=;
                    address.streetcontroller.text=widget.address[index].street;
                    address.buildingcontroller.text=widget.address[index].buildingName;
                    address.floornumbercontroller.text=widget.address[index].floorNumber.toString();
                    print(address.addresstitlecontroller.text);
                    showModalBottomSheet(
                        isScrollControlled: true,
                        context: ctx,
                        builder: (_) {
                          return AddressesTextField((){} ,context);
                        });

                  }, icon: Icon(Icons.edit,color: Color(0xFF3F5521),)),
                  IconButton(
                      onPressed: () async{
                    var delete= await  address.deleteAddress(widget.address[index].id);
                    if(delete=="deleted"){
                      widget.address.remove(widget.address[index]);
                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Address Deleted')));
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Address cannot be Deleted'),
                      ));
                    }
                  }, icon:Icon(Icons.delete,color: Colors.red,) ),
                ],
              ),

              child: Card(
                color:LightColors.kLightYellow2,
                elevation: 2,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: _mediaQuery * 0.03,
                      horizontal: _mediaQuery * 0.01),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.location_on ,color: Color(0xFF3F5521),),
                      Column(children: [

                      ],),
                      SizedBox(

                        width: _mediaQueryWidth*0.01,

                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [


                          Row(
                            children: [
                              const Text(
                                "Title : ",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ), Text(
                                 widget.address[index].title.toString(),
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              Text(
                                "City : ",
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ), Text(
                                widget.address[index].city.toString(),
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.normal
                                ),
                              ),
                            ],
                          ),

                          Text(
                            "Street : ${widget.address[index].street.toString()}",
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),

                          Text(
                            "Building Name : ${widget.address[index].buildingName.toString()}",
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),

                          Text(
                            "Floor Number : ${widget.address[index].floorNumber.toString()}",
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
