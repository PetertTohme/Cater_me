

import 'dart:async';
import 'dart:io';



import 'package:CaterMe/Screens/otpverify/phoneverificationplugin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:motion_toast/motion_toast.dart';

import 'package:provider/provider.dart';

import '../../Providers/address.dart';
import '../../Providers/user.dart';
import '../../SplachScreen.dart';
import '../../language/language.dart';


class PhoneVerification extends StatefulWidget {


  var _contact;
  String dialcode;
  File image;
 // const PhoneVerification({Key? key}) : super(key: key);
PhoneVerification(this._contact ,this.dialcode,this.image);

  @override
  _PhoneVerificationState createState() => _PhoneVerificationState();

}

class _PhoneVerificationState extends State<PhoneVerification> {
 String phoneNo;
 String smsOTP='';
 String verificationId;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
String errorMessage = '';
final FirebaseAuth _auth = FirebaseAuth.instance;
 Timer _timer;

@override
  void initState() {
    // TODO: implement initState
    super.initState();

  //  widget._contact = '${ModalRoute.of(context)!.settings.arguments as String}';
    generateOtp(widget._contact);
  }
  int _resendToken;


Future<void> generateOtp(String contact) async {



  final PhoneCodeSent smsOTPSent =
      (String verId, [int forceCodeResend]) {
    verificationId = verId;
    _resendToken = forceCodeResend;

  };
  try {
    await _auth.verifyPhoneNumber(
        phoneNumber: contact,
        codeAutoRetrievalTimeout: (String verId) {
          verificationId = verId;
        },
        codeSent: smsOTPSent,
        forceResendingToken: _resendToken,
        timeout: const Duration(seconds: 25),

        verificationCompleted: (AuthCredential phoneAuthCredential) async {


        },
        verificationFailed: (FirebaseAuthException exception) {
       //   UserProvider _user = Provider.of<UserProvider>(context, listen: true);

       //   SnackBar(content: Text("${keysLang[_user.language]!["Registration failed!"]} "));

          print(exception.toString());



        });
  } catch (e) {
    handleError(e as PlatformException);
    // Navigator.pop(context, (e as PlatformException).message);
  }
}

//Method for verify otp entered by user
Future<void> verifyOtp() async {
  if (smsOTP == null || smsOTP == '') {
    showAlertDialog(context, 'please enter 6 digit otp');
    return;
  }
  try {
    final AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsOTP,
    );
    final UserCredential user = await _auth.signInWithCredential(credential);
    final User currentUser = await _auth.currentUser;
   // assert(user.user.uid == currentUser.uid);

    print("verification failed");
    // if(!await Provider.of<UserProvider>(context).signUp(widget.dialcode)){
    //   UserProvider _user = Provider.of<UserProvider>(context, listen: true);
    //   Scaffold.of(context).showSnackBar(
    //       SnackBar(content: Text("${keysLang[_user.language]!["Registration failed!"]} "))
    //   );
    //   print("error login");
    //   return;
    // }


  //  Navigator.pushReplacementNamed(context, '/homeScreen');
  } catch (e) {
   print(e.toString());
  }
}
  final _scaffKey = GlobalKey<ScaffoldState>();

//Method for handle the errors
void handleError(PlatformException error) {
  switch (error.code) {
    case 'ERROR_INVALID_VERIFICATION_CODE':
      FocusScope.of(context).requestFocus(FocusNode());
      setState(() {
        errorMessage = 'Invalid Code';
      });
      showAlertDialog(context, 'Invalid Code');
      break;
    default:
    showAlertDialog(context, error.message);
      break;
  }
}

//Basic alert dialogue for alert errors and confirmations
void showAlertDialog(BuildContext context, String message) {
 // UserProvider _user = Provider.of<UserProvider>(context, listen: true);
  // set up the AlertDialog
  final CupertinoAlertDialog alert = CupertinoAlertDialog(
    title: const Text('Error'),
    content: Text('\n$message'),

    actions: <Widget>[

      CupertinoDialogAction(

        isDefaultAction: true,
        child:  Text("'Ok "),
        onPressed: () {
          Navigator.of(context).pop();
        },
      )
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}





@override
  Widget build(BuildContext context) {

 // UserProvider _user = Provider.of<UserProvider>(context, listen: true);
  //UserProvider authProvider = Provider.of<UserProvider>(context);

  //WorkProvider work = Provider.of<WorkProvider>(context);


  final address = Provider.of<AdressProvider>(context, listen: true);

  // final user = Provider.of<UserProvider>(context, listen: true);
  FocusNode focusNode = FocusNode();
  final authProvider = Provider.of<UserProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: Colors.transparent,
    //  key:_scaffKey,
      extendBodyBehindAppBar: true,
      key: _scaffoldKey,
      appBar:AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text('${LanguageTr.lg[authProvider.language]["OTP Verification"]}',
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'Ubuntu',
              fontWeight: FontWeight.normal,
              fontSize: 14),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: Colors.black,),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.center,
                colors: [Colors.white,Colors.white,Colors.white],
                stops: [0.1,0.3,1]
            )
        ),
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/20, vertical: MediaQuery.of(context).size.height/20),
        child: Column(
          children: [
            Container(height: MediaQuery.of(context).size.height/10,),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text('${LanguageTr.lg[authProvider.language]["Please enter the 6-digit code you received via text message"]}'
                ,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontFamily: 'Ubuntu',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height/15,
            ),

                 Center(

                   child: VerificationCode(
                           itemSize:MediaQuery.of(context).size.width/10,

                           textStyle: TextStyle(
                               color: Colors.black,
                               fontSize: 30,
                             fontFamily: 'Ubuntu',
                             fontWeight: FontWeight.w300,
                           ),
                           underlineColor:  Color(0xFF3F5521),
                           underlineUnfocusedColor:  Color(0xFF3F5521),
                           length: 6,
                           onCompleted: (value) async{
                             FocusScope.of(context).unfocus();
                             _scaffoldKey.currentState.showSnackBar(
                                 SnackBar(content: Row(
                                   children: [
                                     CircularProgressIndicator(),
                                     SizedBox(width: 15,),
                                     Text("Loading...")
                                   ],
                                 ))

                             );
                             setState(() {
                               smsOTP = value as String;
                             });
                             if (smsOTP == null || smsOTP == '') {
                               showAlertDialog(context, 'please enter 6 digit otp');
                               return;
                             }
                             try {
                               final AuthCredential credential = PhoneAuthProvider.credential(
                                 verificationId: verificationId,
                                 smsCode: smsOTP,
                               );
                               final UserCredential user = await _auth.signInWithCredential(credential);
                               final User currentUser = await _auth.currentUser;
                            //   assert(user.user.uid == currentUser.uid);

                               if (await authProvider.signUp(
                                   widget.image, address.evendatecontroller.text)) {
                                 // setState(() {
                                 //   _loading = false;
                                 // });
                                 Navigator.pushAndRemoveUntil(
                                     context,
                                     MaterialPageRoute(
                                       builder: (context) => SplashScreen(),
                                     ),
                                         (Route<dynamic> route) => false
                                 );
                               } else {
                                 // setState(() {
                                 //   _loading = false;
                                 // });

                                 MotionToast.error(
                                   title: "Cater me",
                                   titleStyle:
                                   TextStyle(fontWeight: FontWeight.bold),
                                   description:
                                   '${LanguageTr.lg[authProvider.language]["${authProvider.messageSignUp.toString()}"]}',
                                   //  animationType: ANIMATION.FROM_LEFT,
                                 ).show(context);
                                 // _scaffoldKey.currentState.showSnackBar(
                                 //   SnackBar(
                                 //     content: Text(
                                 //         "${authProvider.messageSignUp.toString()}"),
                                 //   ),
                                 // );
                                 authProvider.messageSignUp = "";
                               }

                             } catch (e) {
                               {
                                 MotionToast.error(
                                   title: "Cater me",
                                   titleStyle:
                                   TextStyle(fontWeight: FontWeight.bold),
                                   description:
                                   '${LanguageTr.lg[authProvider.language]["otp not valid"]}'
                                 ).show(context);
                                 // _scaffoldKey.currentState.showSnackBar(
                                 //     SnackBar(content: Row(
                                 //       children: [
                                 //        // CircularProgressIndicator(),
                                 //       //  SizedBox(width: 15,),
                                 //         Text('${LanguageTr.lg[authProvider.language]["otp not valid"]}'),
                                 //       ],
                                 //     ))
                                 //
                                 // );
                                 return;
                               }
                             }
                      //  verifyOtp();
                           },
                           onEditing: (value){},
                         ),
                 ),

            Container(
              height: MediaQuery.of(context).size.height/50,
            ),
            TextButton(onPressed: (){
              generateOtp(widget._contact);

            },
              child:  Text('${LanguageTr.lg[authProvider.language]["Resend code"]}',

                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Ubuntu',
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                  decoration: TextDecoration.underline,),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
