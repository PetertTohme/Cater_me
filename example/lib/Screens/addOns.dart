import 'package:CaterMe/NavigationBar/navigation_bar.dart';
import 'package:CaterMe/Providers/packages.dart';
import 'package:CaterMe/model/add_on.dart';
import 'package:CaterMe/widgets/addOns/add_on_cards.dart';

import 'package:CaterMe/widgets/addOns/add_on_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddOns extends StatefulWidget {
int addOns;
  AddOns(this.addOns);

  @override
  State<AddOns> createState() => _AddOnsState();
}

class _AddOnsState extends State<AddOns> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getallons();
  }
  getallons() async{

    final _cuisin = Provider.of<PackagesProvider>(context, listen: false);
   await _cuisin.getonid(widget.addOns);
  }
  @override
  Widget build(BuildContext context) {
    final _cuisin = Provider.of<PackagesProvider>(context, listen: true);
    final mediaQuery = MediaQuery.of(context);
    PreferredSize appBar = PreferredSize(
      preferredSize: Size.fromHeight(
        MediaQuery.of(context).size.height * 0.12,
      ),
      child: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(top: (mediaQuery.size.width * 0.04)),
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back, color: Colors.white),
            iconSize: 30,
          ),
        ),
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
        centerTitle: true,
        title: Padding(
          padding: EdgeInsets.only(top: (mediaQuery.size.height * 0.04)),
          child: Text(
            '',
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
    return Scaffold(
      appBar: appBar,
      body:ListView.builder(
        //itemCount: friend.length,
        itemBuilder: (ctx, index)  {
          ///TabBarView children length = Number of categories
          ///Each category have foodList (ListView)
          return
                AddOnCards(_cuisin.allons[index]);




          },
        )



    );
  }
}
