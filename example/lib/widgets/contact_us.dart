import 'package:CaterMe/Providers/contact_us_provider.dart';
import 'package:CaterMe/colors/colors.dart';
import 'package:CaterMe/model/contact_us_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../Providers/user.dart';
import '../language/language.dart';
import '../widgets/contact_us.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lottie/lottie.dart';


const _ktexts = ['Special Thank You For Using', 'CaterMe'];

class Contact_Us extends StatefulWidget {
  @override
  State<Contact_Us> createState() => _Contact_UsState();
}

class _Contact_UsState extends State<Contact_Us> {
  initState(){

    getdata();
  }
  getdata()async{
    final contact = Provider.of<ContactUsProvider>(context, listen: false);
    await contact.getPersonalInfo();
  setState(() {
    loading=false;
  });


  }
  Future<void> launchUrl(String url) async {
    if (await canLaunch(url)) {
      launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
bool loading=true;
  // For Calling Button
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context, listen: true);
    final contact = Provider.of<ContactUsProvider>(context, listen: true);


    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_rounded),
          iconSize: 40,
          color: Colors.white,
        ),
         title: Text('${LanguageTr.lg[authProvider.language]["Contact Us"]}',


          style: Theme.of(context).textTheme.headline1,
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      //End Appbar
      body:!loading?
      Column(
        children: [

SizedBox(
  height: MediaQuery.of(context).size.height*0.02,
),

          GestureDetector(
            onTap: () async {
              launchUrl("tel://${contact.UsContact.phoneNumber}.");
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListTile(
                  leading: Icon(
                      Icons.call,
                      color: colorCustom,
                    ),

                  title: Text(contact.UsContact.phoneNumber,
                      // contact.UsContact.phoneNumber,
                      style: TextStyle(fontWeight: FontWeight.bold)),

                  ),
              ),
            ),


      GestureDetector(
    onTap: () async {
    launchUrl("mailto:${contact.UsContact.email}");},
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListTile(
                leading:Icon(
                    Icons.email,
                    color: colorCustom,
                  ),

                title: Text(contact.UsContact.email,style: TextStyle(fontWeight: FontWeight.bold),),

                ),
              ),
            ),
          SizedBox(height: MediaQuery.of(context).size.height*0.02,

          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Image.asset(
              'images/CaterMe.png',
              height: mediaQuery.size.height * 0.15,
            ),

            // Animation shimer finish
          ),









          Column(
            children: [
              SizedBox(
              height: MediaQuery.of(context).size.height*0.07,
            ),



    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

      children: [
        IconButton(onPressed: ()async{
          final url = 'https://www.facebook.com/Cater-Me-103856805573526/';
          if(await canLaunch(url)){
            await launch(url,forceSafariVC: false);
          }


        } ,
          icon:Icon(

            FontAwesomeIcons.facebook,

            color: colorCustom,
            size: 40,
          ),),

        IconButton(onPressed: ()async{
          final url = 'https://www.instagram.com/caterme.online/?hl=en';
          if(await canLaunch(url)){
            await launch(url,forceSafariVC: false);
          }


        },
          icon:Icon(

          FontAwesomeIcons.instagram,

          color: colorCustom,
          size: 40,
        ),),




        IconButton(
          onPressed: ()async{
            final url = 'https://www.linkedin.com/company/cater-me/';
            if(await canLaunch(url)){
              await launch(url,forceSafariVC: false);
            }


          } ,
          icon:Icon(

          FontAwesomeIcons.linkedin,

          color: colorCustom,
          size: 40,
        ),),
        IconButton(onPressed: ()async{
          final url = 'https://www.snapchat.com/add/caterme.online?share_id=Q0UzMUVF&locale=en_US';
          if(await canLaunch(url)){
            await launch(url,forceSafariVC: false);
          }


        } ,
          icon:Icon(

            FontAwesomeIcons.snapchat,

            color: colorCustom,
            size: 40,
          ),),


      ],
    ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.1,
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(height: mediaQuery.size.height*0.1,
                  child: AnimatedTextKit(
                    onTap: () {},
                    animatedTexts: [
                      for (final txt in ['${LanguageTr.lg[authProvider.language]["Special Thank You For Using"]}', 'CaterMe'])
                        FadeAnimatedText(txt,
                            textStyle: TextStyle(
                                fontSize: 20,
                                color: colorCustom,
                                fontWeight: FontWeight.bold))
                    ],
                    repeatForever: true,
                  ),
                ),
              ),
              Text('${LanguageTr.lg[authProvider.language]["We/’d Love to Hear From You"]}'
                ,
                style: TextStyle(fontSize: 22),
              ),
              Text('${LanguageTr.lg[authProvider.language]["Ready to answer any and all questions"]}'
                ,
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),





            ],
          )

        ],
      ):
          Center(child: CircularProgressIndicator()),
    );
  }
}
