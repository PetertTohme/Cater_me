import 'package:CaterMe/Providers/friend.dart';
import 'package:CaterMe/Providers/user.dart';
import 'package:CaterMe/Screens/occasion/theme/colors/light_colors.dart';
import 'package:CaterMe/Screens/widgets/Costumtextfield.dart';
import 'package:CaterMe/model/friend_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../language/language.dart';

class editfriend extends StatefulWidget {
  FriendModel alpha;



  editfriend(this.alpha);

  @override
  State<editfriend> createState() => _FreindsTextFieldState();
}

class _FreindsTextFieldState extends State<editfriend> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  bool validate() {
    if (formkey.currentState != null) {
      if (formkey.currentState.validate()) {
        // ignore: avoid_print
        print('Validated');
        return true;
      } else {
        // ignore: avoid_print
        print('Not validated');
        return false;
      }
    }
    return false;
  }

  bool loading = false;


@override
  void initState() {
    // TODO: implement initState
    super.initState();

    final friends = Provider.of<FriendsProvider>(context, listen: false);
    friends.namecontroller.text=widget.alpha.name;
    // friends.emailcontroller.text=widget.alpha.email;
    friends.phonecontroller.text=widget.alpha.phoneNumber;
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    FocusNode focusnode =FocusNode();
    final friends = Provider.of<FriendsProvider>(context, listen: true);
    final personalInfo = Provider.of<UserProvider>(context, listen: true);



    var _mediaQueryText = MediaQuery
        .of(context)
        .size
        .height;
    return Card(
      child: SingleChildScrollView(
        child: Container(
          color: LightColors.kLightYellow,
          child: Padding(
            padding: EdgeInsets.only(
                right: 10,
                left: 10,
                top: 10,
                bottom: MediaQuery
                    .of(context)
                    .viewInsets
                    .bottom + 10),
            child: Form(
              key:formkey,
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: _mediaQueryText * 0.06),
                  customTextField(read: false,label:'${LanguageTr.lg[personalInfo.language]["Name"]}', controller:friends.namecontroller ,),

                  //     SizedBox(height: _mediaQueryText * 0.02),
                  // customTextField(read: false,label:'Email' ,controller:friends.emailcontroller ,),

                  Container(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(

                        controller: friends.phonecontroller,
                        focusNode: focusnode,

                        autovalidateMode:
                        AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(



                            // contentPadding:
                            // EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.04),

                            alignLabelWithHint: true,
                            labelStyle: TextStyle(
                                fontSize: focusnode.hasFocus ? 18 : 16.0,//I believe the size difference here is 6.0 to account padding
                                color:
                                focusnode.hasFocus ? Color(0xFF3F5521) : Colors.grey),
                            labelText: '${LanguageTr.lg[personalInfo.language]["Phone number"]}',
                            hintStyle:TextStyle(
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
                      )),
                  SizedBox(height: _mediaQueryText * 0.03),

                  SizedBox(height: _mediaQueryText * 0.03),
                  !loading ? ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        loading = true;
                      });
                      if (formkey.currentState.validate() == false) {
                        // ignore: avoid_print
                        print('Not Validated');
                        setState(() {
                          loading = false;
                        });
                        // reset!=null?
                      }
                      else
                      {

                        await friends.UpdateFriend(widget.alpha.id);

                        setState(() {
                          loading = false;

                        });
                    //    final friends = Provider.of<FriendsProvider>(context, listen: false);
                        friends.namecontroller.text="";
                        // friends.emailcontroller.text="";
                        friends.phonecontroller.text="";
                        Navigator.of(context).pop();
                      }
                    },


                    child: Text(
                      '${LanguageTr.lg[personalInfo.language]["edit"]}',
                      style: Theme
                          .of(context)
                          .textTheme
                          .headline1,
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
                      primary: Theme
                          .of(context)
                          .primaryColor,
                    ),
                  ):Center(child: CircularProgressIndicator(),),
                ],
              ),
            ),
          ),
        )
        ,
      )
      ,
    );
  }
}