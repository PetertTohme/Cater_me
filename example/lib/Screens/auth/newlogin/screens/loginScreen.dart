// import 'package:CaterMe/NavigationBar/navigation_bar.dart';
// import 'package:CaterMe/Providers/user.dart';
// import 'package:CaterMe/Screens/auth/newlogin/screens/signUpScreen.dart';
// import 'package:CaterMe/Screens/auth/newlogin/widgets/inputTextWidget.dart';
// import 'package:CaterMe/Screens/occasion/theme/colors/light_colors.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
//
// import '../../reset_password_screen.dart';
//
// class LoginScreen extends StatefulWidget {
//   LoginScreen() : super();
//
//   @override
//   _SearchScreenState createState() => _SearchScreenState();
// }
//
// class _SearchScreenState extends State<LoginScreen> {
//   String password = '', confirmPassword = '', email = '';
//   bool passObscure = true;
//   bool confObscure = true;
//   final _scaffoldKey = GlobalKey<ScaffoldState>();
//   bool loading = false;
//
//   //final snackBar = SnackBar(content: Text('email ou mot de passe incorrect'));
//   final _formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     final authProvider = Provider.of<UserProvider>(context, listen: true);
//     final screenWidth = MediaQuery.of(context).size.width;
//     final double r = (300 / 360); //  rapport for web test(304 / 540);
//     final coverHeight = screenWidth * r;
//     bool _pinned = false;
//     bool _snap = false;
//     bool _floating = false;
//     final loggedinkey = GlobalKey<ScaffoldState>();
//     final widgetList = [
//       Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               InputTextWidget(
//                   controller: authProvider.email,
//                   labelText: "Email or Phone number",
//                   icon: Icons.email,
//                   obscureText: false,
//                   keyboardType: TextInputType.emailAddress),
//               SizedBox(
//                 height: 12.0,
//               ),
//               InputTextWidget(
//                   controller: authProvider.password,
//                   labelText: "Password",
//                   icon: Icons.lock,
//                   obscureText: true,
//                   keyboardType: TextInputType.text),
//               Padding(
//                 padding: const EdgeInsets.only(right: 25.0, top: 10.0),
//                 child: Align(
//                     alignment: Alignment.topRight,
//                     child: Material(
//                       color: Colors.transparent,
//                       child: InkWell(
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => ResetPasswordScreen()));
//                         },
//                         child: Text(
//                           "Forgot Password ?",
//                           style: TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.bold,
//                             color: Color(0xFF3F5521),
//                           ),
//                         ),
//                       ),
//                     )),
//               ),
//               SizedBox(
//                 height: 15.0,
//               ),
//               Container(
//                 height: 55.0,
//                 child:!loading? ElevatedButton(
//                   onPressed: () async {
//                     setState(() {
//                       loading = true;
//                     });
//                     if (_formKey.currentState.validate() == false) {
//                       // ignore: avoid_print
//                       print('Not Validated');
//                       setState(() {
//                         loading = false;
//                       });
//                       // reset!=null?
//                     } else {
//                       if (await authProvider.LogIn()) {
//                         print("logged");
//                         setState(() {
//                           loading = false;
//                         });
//                         SharedPreferences sh =
//                         await SharedPreferences.getInstance();
//                         sh.setBool("logged", true);
//
//                         Navigator.of(context).pushAndRemoveUntil(
//                             MaterialPageRoute(
//                                 builder: (context) =>
//                                     Navigationbar(0)),
//                                 (Route<dynamic> route) => false);
//                         //authProvider.status=Status.Authenticated;
//                         setState(() {});
//                       } else {
//                         print("hello");
//                         setState(() {
//                           loading = false;
//                         });
//                         loggedinkey.currentState.showSnackBar(
//                           SnackBar(
//                             content: Text(
//                                 "${authProvider.messagelogin.toString()}"),
//                           ),
//                         );
//                         authProvider.messagelogin = "";
//                       }
//                     }
//                   },
//                   //   if (_formKey.currentState.validate()) {
//                   //   //   Navigator.push(
//                   //   //       context,
//                   //   //       MaterialPageRoute(
//                   //   //           builder: (context) =>
//                   //   //           Navigationbar(0)));
//                   //   // }
//                   //   //Get.to(ChoiceScreen());
//                   // },
//                   style: ElevatedButton.styleFrom(
//                     primary: Colors.white,
//                     elevation: 0.0,
//                     minimumSize: Size(screenWidth, 150),
//                     padding: EdgeInsets.symmetric(horizontal: 30),
//                     shape: const RoundedRectangleBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(0)),
//                     ),
//                   ),
//                   child: Ink(
//                     decoration: BoxDecoration(
//                         boxShadow: <BoxShadow>[
//                           BoxShadow(
//                               color: LightColors.kLavender,
//                               offset: const Offset(1.1, 1.1),
//                               blurRadius: 10.0),
//                         ],
//                         color: LightColors.kLavender, // Color(0xffF05945),
//                         borderRadius: BorderRadius.circular(12.0)),
//                     child: Container(
//                       alignment: Alignment.center,
//                       child: Text(
//                         "Log In",
//                         textAlign: TextAlign.center,
//                         style: TextStyle(color: Colors.white, fontSize: 25),
//                       ),
//                     ),
//                   ),
//                 ):Center(child: CircularProgressIndicator())
//               ),
//             ],
//           )),
//       SizedBox(
//         height: 15.0,
//       ),
//       Wrap(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(left: 30.0, right: 10.0, top: 15.0),
//             child: Container(
//               decoration: BoxDecoration(
//                   boxShadow: <BoxShadow>[
//                     BoxShadow(
//                         color: Colors.grey, //Color(0xfff05945),
//                         offset: const Offset(0, 0),
//                         blurRadius: 5.0),
//                   ],
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(12.0)),
//               width: (screenWidth / 2) - 40,
//               height: 55,
//               child: Material(
//                 borderRadius: BorderRadius.circular(12.0),
//                 child: InkWell(
//                   onTap: () {
//                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                       content: Text('Coming Soon!'),
//                     ));
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       children: [
//                         Image.asset("images/fb.png", fit: BoxFit.cover),
//                         SizedBox(
//                           width: 7.0,
//                         ),
//                         Text("Sign in avec\nfacebook")
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 10.0, right: 30.0, top: 15.0),
//             child: Container(
//               decoration: BoxDecoration(
//                   boxShadow: <BoxShadow>[
//                     BoxShadow(
//                         color: Colors.grey, //Color(0xfff05945),
//                         offset: const Offset(0, 0),
//                         blurRadius: 5.0),
//                   ],
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(12.0)),
//               width: (screenWidth / 2) - 40,
//               height: 55,
//               child: Material(
//                 borderRadius: BorderRadius.circular(12.0),
//                 child: InkWell(
//                   onTap: () {
//                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                       content: Text('Coming Soon!'),
//                     ));
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       children: [
//                         Image.asset("images/google.png", fit: BoxFit.cover),
//                         SizedBox(
//                           width: 7.0,
//                         ),
//                         Text("Sign in avec\nGoogle")
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//       SizedBox(
//         height: 15.0,
//       ),
//     ];
//     return Scaffold(
//     key: loggedinkey,
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         // leading: Icon(Icons.arrow_back),
//         backgroundColor: Colors.transparent,
//         elevation: 0.0,
//       ),
//       body: CustomScrollView(
//         slivers: <Widget>[
//           SliverAppBar(
//             pinned: _pinned,
//             snap: _snap,
//             floating: _floating,
//             expandedHeight: coverHeight - 25,
//             //304,
//             backgroundColor: Color(0xFFdccdb4),
//             flexibleSpace: FlexibleSpaceBar(
//               centerTitle: true,
//               background: Image.asset(
//                 "images/logo.png",
//                 fit: BoxFit.cover,
//                 height: 200,
//               ),
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: Container(
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.only(),
//                   gradient: LinearGradient(
//                       colors: <Color>[Color(0xFFdccdb4), Color(0xFFd8c3ab)])),
//               width: screenWidth,
//               height: 25,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: <Widget>[
//                   Container(
//                     width: screenWidth,
//                     height: 25,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.only(
//                         topLeft: const Radius.circular(30.0),
//                         topRight: const Radius.circular(30.0),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//           SliverList(
//               delegate:
//                   SliverChildBuilderDelegate((BuildContext context, int index) {
//             return widgetList[index];
//           }, childCount: widgetList.length))
//         ],
//       ),
//       bottomNavigationBar: Stack(
//         children: [
//           new Container(
//             height: 50.0,
//             color: Colors.white,
//             child: Center(
//                 child: Wrap(
//               children: [
//                 Material(
//                     child: InkWell(
//                   onTap: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => SignUpScreen()));
//                   },
//                   child: Text(
//                     "Create New Account",
//                     style: TextStyle(
//                       color: Color(0xFF3F5521),
//                       fontWeight: FontWeight.bold,
//                       fontSize: 15,
//                     ),
//                   ),
//                 )),
//               ],
//             )),
//           ),
//         ],
//       ),
//     );
//   }
// }
