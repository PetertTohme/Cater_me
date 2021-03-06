import 'package:CaterMe/Providers/address.dart';
import 'package:CaterMe/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:provider/provider.dart';

import '../../Providers/user.dart';

class AddressesTextField extends StatefulWidget {
  final Function addAddress;
  BuildContext main;

  AddressesTextField(this.addAddress, this.main);

  @override
  State<AddressesTextField> createState() => _AddressesTextFields();
}

class _AddressesTextFields extends State<AddressesTextField> {
  // final contactNameController = TextEditingController();
  // final emailController = TextEditingController();
  // final phoneNumberController = TextEditingController();
  // final countryController = TextEditingController();
  // final cityController = TextEditingController();
  // final addressTitleController = TextEditingController();

  bool loadingfinal = false;
  bool loading = true;

  getdata() async {
    final adress = Provider.of<AdressProvider>(context, listen: false);
    //await adress.getallcountry();
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // @override
  // void dispose() {
  //   _scaffoldKey.currentState.removeCurrentSnackBar();
  //   super.dispose();
  // }
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    FocusNode focusNode = FocusNode();
    final adress = Provider.of<AdressProvider>(context, listen: true);
    final user = Provider.of<UserProvider>(context, listen: false);
    var _mediaQueryText = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      key: _scaffoldKey,
      child: Container(
        child: Padding(
          padding: EdgeInsets.only(
              right: 10,
              left: 10,
              top: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: !loading
              ? Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(height: _mediaQueryText * 0.03),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value.isEmpty) {
                              return '${user.lg[user.language]["Title can't be empty"]}';
                            } else
                              return null;
                          },
                          // keyboardType: TextInputType.number,
                          controller: adress.addresstitlecontroller,
                          // focusNode: focusNode,
                          decoration: InputDecoration(
                              // contentPadding: EdgeInsets.only(
                              //     left:
                              //         MediaQuery.of(context).size.width * 0.04),
                              alignLabelWithHint: true,
                              labelStyle: TextStyle(
                                  fontSize: focusNode.hasFocus ? 18 : 16.0,
                                  //I believe the size difference here is 6.0 to account padding
                                  color: focusNode.hasFocus
                                      ? Color(0xFF3F5521)
                                      : Colors.grey),
                              labelText:
                                  '${user.lg[user.language]["Address Title"]}',
                              hintStyle: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'BerlinSansFB'),
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                  color: redColor,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                  color: redColor,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: const BorderSide(
                                    color: Color(0xFF3F5521),
                                  ))),
                          style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'BerlinSansFB'),
                        ),
                      ),
                      // customTextField(
                      //   label: 'Address Title',
                      //   controller: adress.addresstitlecontroller,
                      //   read: false,
                      // ),

                      SizedBox(height: _mediaQueryText * 0.03),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          // keyboardType: TextInputType.number,
                          controller: adress.countrycontroller,
                          enabled: false,
                          // focusNode: focusNode,
                          decoration: InputDecoration(
                              // contentPadding: EdgeInsets.only(
                              //     left:
                              //     MediaQuery.of(context).size.width * 0.04),
                              alignLabelWithHint: true,
                              labelStyle: TextStyle(
                                  fontSize: focusNode.hasFocus ? 18 : 16.0,
                                  //I believe the size difference here is 6.0 to account padding
                                  color: focusNode.hasFocus
                                      ? Color(0xFF3F5521)
                                      : Colors.grey),
                              labelText:
                                  '${user.lg[user.language]["Country"]}',
                              hintStyle: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'BerlinSansFB'),
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                  color: redColor,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                  color: redColor,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: const BorderSide(
                                    color: Color(0xFF3F5521),
                                  ))),
                          style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'BerlinSansFB'),
                        ),
                      ),
                      SizedBox(height: _mediaQueryText * 0.03),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          enabled: false,
                          // keyboardType: TextInputType.number,
                          controller: adress.citycontroller,
                          // focusNode: focusNode,
                          decoration: InputDecoration(
                              // contentPadding: EdgeInsets.only(
                              //     left:
                              //     MediaQuery.of(context).size.width * 0.04),
                              alignLabelWithHint: true,
                              labelStyle: TextStyle(
                                  fontSize: focusNode.hasFocus ? 18 : 16.0,
                                  //I believe the size difference here is 6.0 to account padding
                                  color: focusNode.hasFocus
                                      ? Color(0xFF3F5521)
                                      : Colors.grey),
                              labelText:
                                  '${user.lg[user.language]["City"]}',
                              hintStyle: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'BerlinSansFB'),
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                  color: redColor,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                  color: redColor,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: const BorderSide(
                                    color: Color(0xFF3F5521),
                                  ))),
                          style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'BerlinSansFB'),
                        ),
                      ),
                      SizedBox(height: _mediaQueryText * 0.03),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          ///autovalidateMode: AutovalidateMode.onUserInteraction,
                          // validator: (value) {
                          //   if (value.isEmpty) {
                          //     return "Street can't be empty";
                          //   } else
                          //     return null;
                          // },
                          // keyboardType: TextInputType.number,
                          controller: adress.streetcontroller,
                          // focusNode: focusNode,
                          decoration: InputDecoration(
                              // contentPadding: EdgeInsets.only(
                              //     left:
                              //         MediaQuery.of(context).size.width * 0.04),
                              alignLabelWithHint: true,
                              labelStyle: TextStyle(
                                  fontSize: focusNode.hasFocus ? 18 : 16.0,
                                  //I believe the size difference here is 6.0 to account padding
                                  color: focusNode.hasFocus
                                      ? Color(0xFF3F5521)
                                      : Colors.grey),
                              labelText:
                                  '${user.lg[user.language]["Street"]}',
                              enabled: false,
                              hintStyle: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'BerlinSansFB'),
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                  color: redColor,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                  color: redColor,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: const BorderSide(
                                    color: Color(0xFF3F5521),
                                  ))),
                          style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'BerlinSansFB'),
                        ),
                      ),
                      // customTextField(
                      //   label: 'Street',
                      //   controller: adress.streetcontroller,
                      //   read: false,
                      // ),

                      // keyboardType: TextInputType.phone,

                      SizedBox(height: _mediaQueryText * 0.03),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          //  autovalidateMode: AutovalidateMode.onUserInteraction,
                          // validator: (value) {
                          //   if (value.isEmpty) {
                          //     return "Building can't be empty";
                          //   } else
                          //     return null;
                          // },
                          // keyboardType: TextInputType.number,
                          controller: adress.buildingcontroller,
                          // focusNode: focusNode,
                          decoration: InputDecoration(
                              // contentPadding: EdgeInsets.only(
                              //     left:
                              //         MediaQuery.of(context).size.width * 0.04),
                              alignLabelWithHint: true,
                              labelStyle: TextStyle(
                                  fontSize: focusNode.hasFocus ? 18 : 16.0,
                                  //I believe the size difference here is 6.0 to account padding
                                  color: focusNode.hasFocus
                                      ? Color(0xFF3F5521)
                                      : Colors.grey),
                              labelText:
                                  '${user.lg[user.language]["Building"]}',
                              hintStyle: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'BerlinSansFB'),
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                  color: redColor,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                  color: redColor,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: const BorderSide(
                                    color: Color(0xFF3F5521),
                                  ))),
                          style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'BerlinSansFB'),
                        ),
                      ),
                      // customTextField(
                      //   label: 'Building',
                      //   controller: adress.buildingcontroller,
                      //   read: false,
                      // ),

                      SizedBox(height: _mediaQueryText * 0.03),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          // autovalidateMode: AutovalidateMode.onUserInteraction,
                          // validator: (value) {
                          //   if (value.isEmpty) {
                          //     return "Floor can't be empty";
                          //   } else
                          //     return null;
                          // },
                          // keyboardType: TextInputType.number,
                          keyboardType: TextInputType.phone,

                          controller: adress.floornumbercontroller,
                          // focusNode: focusNode,
                          decoration: InputDecoration(
                              // contentPadding: EdgeInsets.only(
                              //     left:
                              //         MediaQuery.of(context).size.width * 0.04),
                              alignLabelWithHint: true,
                              labelStyle: TextStyle(
                                  fontSize: focusNode.hasFocus ? 18 : 16.0,
                                  //I believe the size difference here is 6.0 to account padding
                                  color: focusNode.hasFocus
                                      ? Color(0xFF3F5521)
                                      : Colors.grey),
                              labelText:
                                  '${user.lg[user.language]["Floor"]}',
                              hintStyle: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'BerlinSansFB'),
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                  color: redColor,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                  color: redColor,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: const BorderSide(
                                    color: Color(0xFF3F5521),
                                  ))),
                          style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'BerlinSansFB'),
                        ),
                      ),

                      SizedBox(height: _mediaQueryText * 0.03),

                      // SizedBox(height: _mediaQueryText * 0.03),
                      //
                      // SizedBox(height: _mediaQueryText * 0.03),
                      !loadingfinal
                          ? ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  setState(() {
                                    loadingfinal = true;
                                  });

                                  adress.loading = true;
                                  if (!adress.isUpdate) {
                                    await adress.createAddress();
                                    setState(() {
                                      loadingfinal = false;
                                    });
                                    adress.loading = false;
                                    if (adress.addressCreated.id == 0) {
                                      MotionToast.error(
                                              title: "Cater me",
                                              titleStyle: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                              description:
                                                  '${user.lg[user.language]["Failed to add address"]}'
                                              //  animationType: ANIMATION.FROM_LEFT,
                                              )
                                          .show(context);
                                      // _scaffoldKey.currentState.showSnackBar();
                                      // ScaffoldMessenger.of(context)
                                      //     .showSnackBar(SnackBar(
                                      //         content: Text(
                                      //   '${authProvider.lg[user.language]["Failed to add address"]}',
                                      // )));
                                    } else {
                                      MotionToast.success(
                                        title: "Cater me",
                                        titleStyle: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        description:
                                            '${user.lg[user.language]["Address added"]}',
                                        //  animationType: ANIMATION.FROM_LEFT,
                                      ).show(context);
                                      await Future.delayed(Duration(seconds: 2));
                                      // ScaffoldMessenger.of(context)
                                      //     .showSnackBar(
                                      //   SnackBar(
                                      //     content: Text(
                                      //       '${authProvider.lg[user.language]["Address added"]}',
                                      //     ),
                                      //   ),
                                      // );
                                      // await  Future.delayed(Duration(seconds: 2));
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop();
                                    }
                                  } else {
                                    await adress.updateAddresss();
                                    adress.loading = false;
                                    print(adress.addressUpdated);
                                    if (adress.addressUpdated.id != 0) {
                                     await adress.getAllAddress();
                                      MotionToast.success(
                                        title: "Cater me",
                                        titleStyle: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        description:
                                            '${user.lg[user.language]["updated done"]}',
                                        //  animationType: ANIMATION.FROM_LEFT,
                                      ).show(context);
                                      await Future.delayed(Duration(seconds: 2));

                                      // ScaffoldMessenger.of(context)
                                      //     .showSnackBar(Snack
                                      //     Bar(
                                      //         content: Text(t
                                      //   '${authProvider.lg[user.language]["updated done"]}',
                                      // )));
                                      //   await  Future.delayed(Duration(seconds: 2));
                                      Navigator.of(context)
                                          .pop(); // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to update address")));
                                      Navigator.of(context)
                                          .pop();
                                      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to update address")));
                                      Navigator.of(context).pop();

                                    } else {
                                      adress.getAllAddress();

                                      MotionToast.error(
                                        title: "Cater me",
                                        titleStyle: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        description:
                                            '${user.lg[user.language]["Updated failed"]}',
                                        //  animationType: ANIMATION.FROM_LEFT,
                                      ).show(context);

                                      // ScaffoldMessenger.of(context)
                                      //     .showSnackBar(SnackBar(
                                      //         content: Text(
                                      //   '${authProvider.lg[user.language]["Updated failed"]}',
                                      // )));
                                      // Navigator.of(context).pop();
                                    }
                                  }
                                }

                                // Navigator.of(context).pop();
                                // Navigator.of(context).push(MaterialPageRoute(builder: (_)=>ConfirmLocation() ));
                              },
                              child: Text(
                                '${user.lg[user.language]["Save"]}',
                                style: Theme.of(context).textTheme.headline1,
                              ),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.only(
                                  left: 35,
                                  right: 35,
                                  top: 15,
                                  bottom: 15,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                primary: Theme.of(context).primaryColor,
                              ),
                            )
                          : Center(
                              child: CircularProgressIndicator(),
                            )
                    ],
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }
}
