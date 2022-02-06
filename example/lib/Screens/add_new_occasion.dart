import 'package:CaterMe/Providers/occasion.dart';
import 'package:CaterMe/Providers/packages.dart';
import 'package:CaterMe/Screens/ocassionsScreens/occasion_added.dart';
import 'package:CaterMe/Screens/ocassionsScreens/occasions.dart';
import 'package:CaterMe/Screens/widgets/custom_cupertino_picker.dart';
import 'package:CaterMe/model/occasion.dart';
import 'package:CaterMe/model/occasions/occasion.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddNewOccasion extends StatefulWidget {
  const AddNewOccasion({Key? key}) : super(key: key);

  @override
  State<AddNewOccasion> createState() => _AddNewOccasionState();
}

class _AddNewOccasionState extends State<AddNewOccasion> {
  DateTime selectedDate = DateTime.now();
  late DateTime? _newDate;
  // void _presentDataPicker() {
  //   showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(2019),
  //     lastDate: DateTime(DateTime.now().year + 1),
  //   ).then((value) {
  //     if (value == null) {
  //       return;
  //     }
  //     setState(() {
  //       selectedDate = value;
  //     });
  //   });
  // }
  _presentDataPicker() async {
    _newDate = (await showDatePicker(
      context: context,
      builder: (context, child) => Theme(
          data: ThemeData().copyWith(
            colorScheme: ColorScheme.light(
                primary: Color(0xff3F5521),
                surface: Color(0xff3F5521),
                onPrimary: Colors.black),
          ),
          child: child!),
      initialDate: selectedDate,
      firstDate: DateTime(1930),
      lastDate: DateTime.now(),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    ));
    setState(() {
      if (_newDate != null) {
        selectedDate = _newDate!;
      }
    });
  }

  bool loading = true;
  getData() async {
    final occasion = Provider.of<OccasionProvider>(context, listen: false);
    await occasion.getAllOccasionType();
    occasion.yearlureminder = false;
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  bool yearly = false;
  bool ispressed = false;
  final _scaff = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final package = Provider.of<PackagesProvider>(context, listen: true);
    final occa = Provider.of<OccasionProvider>(context, listen: true);

    // List<Occasion> occasion = occasionSS;
    final mediaQuery = MediaQuery.of(context);


    return SafeArea(
      child: Scaffold(
        key: _scaff,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop(
              );
            },
            icon: Icon(Icons.arrow_back, color: Colors.white),
            iconSize: 30,
          ),
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          ),
          centerTitle: true,
          title: Text(
            'Add An Occasion',
            style: Theme.of(context).textTheme.headline1,
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: SingleChildScrollView(
          child: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(height: mediaQuery.size.height * 0.07),
                  TextFormField(
                    controller: occa.nameofoccasioncontroller,
                    decoration: InputDecoration(
                      labelText: 'Name Of Occasion',
                      labelStyle: Theme.of(context).textTheme.headline4,
                      contentPadding:
                          EdgeInsets.only(left: mediaQuery.size.width * 0.04),
                    ),
                  ),
                  SizedBox(height: mediaQuery.size.height * 0.04),
                  // TextFormField(
                  //   controller: typeController,
                  //   decoration: InputDecoration(
                  //     labelText: 'Type of Occasion',
                  //     labelStyle: Theme.of(context).textTheme.headline4,
                  //     contentPadding:
                  //         EdgeInsets.only(left: mediaQuery.size.width * 0.04),
                  //   ),
                  // ),

                  occa.listoccasiontype.length != 0
                      ? CustomCupertinoPicker(
                          label: 'Type of Occasion',
                          items: occa.listoccasiontypename,
                          listoccasiontype: occa.listoccasiontype,
                          selectedValue: 0,
                          inputType: TextInputType.number,
                          controller: occa.typeofoccasioncontroller,
                        )
                      : Center(
                          child: Container(
                          child: Text("No Occasion Type to Dispaly"),
                        )),
                  SizedBox(height: mediaQuery.size.height * 0.04),

                  Padding(
                    padding:
                        EdgeInsets.only(left: mediaQuery.size.height * 0.035),
                    child: Row(
                      children: [
                        Text(
                          selectedDate == null
                              ? "No Date chosen!"
                              : 'Picked date: ${DateFormat.yMd().format(selectedDate)}',
                        ),
                        IconButton(
                          onPressed: () async {
                            _newDate = (await showDatePicker(
                              context: context,
                              builder: (context, child) => Theme(
                                  data: ThemeData().copyWith(
                                    colorScheme: ColorScheme.light(
                                        primary: Color(0xff3F5521),
                                        surface: Color(0xff3F5521),
                                        onPrimary: Colors.black),
                                  ),
                                  child: child!),
                              initialDate: selectedDate,
                              firstDate: DateTime(1930),
                              lastDate: DateTime.now(),
                              initialEntryMode:
                                  DatePickerEntryMode.calendarOnly,
                            ));

                            setState(() {
                              if (_newDate != null) {
                                selectedDate = _newDate!;
                                occa.datechosencontroller.text =
                                    _newDate!.toString();
                              }
                            });
                          },
                          icon: Icon(
                            Icons.date_range,
                            color: Theme.of(context).primaryColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(
                      "Yearly reminder",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    Switch.adaptive(
                      activeColor: Theme.of(context).primaryColor,
                      value: yearly,
                      onChanged: (val) {
                        setState(() {
                          yearly = val;
                        });
                        occa.yearlureminder = val;
                      },
                    ),
                  ]),
                  SizedBox(
                    height: mediaQuery.size.height * 0.2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      !ispressed
                          ? ElevatedButton(
                              onPressed: () async {
                                if (occa.datechosencontroller.text == "" ||
                                    occa.typeofoccasioncontroller.text ==
                                        "" ||
                                    occa.nameofoccasioncontroller.text ==
                                        "") {
                                  _scaff.currentState!.showSnackBar(
                                    SnackBar(
                                      content:
                                          Text("you cant add empty occasion"),
                                    ),
                                  );
                                } else {
                                  setState(() {
                                    ispressed = true;
                                  });
                                  // Occassion n = Occasion(
                                  //     name: nameController.text.toString(),
                                  //     type: typeController.text.toString(),
                                  //     date: selectedDate.toString(),
                                  //     yearly: yearly) as Occassion;
                                  //  package.occasions.add(n);
                                  occa.datechosencontroller.text =
                                      '${DateFormat.yMd().format(selectedDate)}';
                                  bool a =
                                      await occa.createOccasions(context);
                                  if (!a)
                                    {
                                      setState(() {
                                        ispressed=false;
                                      });
                                    _scaff.currentState!.showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            "Please fill all the fields"),
                                      ),

                                    );  }
                                  else {
                                    occa.cleardata();
                                    setState(() {
                                      ispressed = false;
                                    });
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => OccasionAdded(),
                                      ),
                                    );
                                  }
                                }
                              },
                              child: Text(
                                'ADD',
                                style: Theme.of(context).textTheme.headline1,
                              ),
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                  horizontal: (mediaQuery.size.width * 0.3),
                                  vertical: (mediaQuery.size.height * 0.02),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                primary: Theme.of(context).primaryColor,
                              ),
                            )
                          : Center(child: CircularProgressIndicator()),
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }
}
