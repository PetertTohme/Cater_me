
import 'package:CaterMe/Providers/orderById_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'OrderTimeline.dart';
import 'widgets/OrderList.dart';

class OrderDetailsView extends StatefulWidget {
  int id ;
   OrderDetailsView({Key key, this.id}) : super(key: key);

  @override
  _OrderDetailsViewState createState() => _OrderDetailsViewState();
}

class _OrderDetailsViewState extends State<OrderDetailsView> {
  getdata(){

    final _order= Provider.of<OrderByIdProvider>(context,listen:false);
    _order.getOrderById(widget.id);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }
  @override
  Widget build(BuildContext context) {

    final _order= Provider.of<OrderByIdProvider>(context,listen:true);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffF5F6F7),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(62.0),
        child: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            "Order Details",
            style: TextStyle(
                fontWeight: FontWeight.w600,
               fontSize: 25),
          ),
          leading: IconButton(
            icon: Image.asset(
              'images/icon_back.png',
              color: Color.fromRGBO(86, 115, 116, 1),
              height: 25,
              width: 25,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: _order.loading?SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${_order.orderbyId["event"]["eventName"]}",
                        style: TextStyle(

                            fontWeight: FontWeight.w600,

                            fontSize: 16),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text.rich(
                        TextSpan(
                          text: "Order Date:${
                              DateFormat("dd-MM-yyyy").format(DateTime.parse(_order.orderbyId["event"]["eventDate"]))
                              } 12 November 2021",
                          style: TextStyle(

                              fontWeight: FontWeight.w400,

                              fontSize: 14),
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),

                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 220,
              width: width,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      "Delivery Address :",
                      style: TextStyle(


                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${_order.orderbyId["event"]["contactName"]}",
                              style: TextStyle(

                                  fontWeight: FontWeight.w400,

                                  fontSize: 14),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text.rich(
                              TextSpan(
                                text: "Street :${_order.orderbyId["address"]["street"]},Building ${_order.orderbyId["address"]["buildingName"]}",
                                style: TextStyle(

                                    fontWeight: FontWeight.w400,

                                    fontSize: 14),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text.rich(
                              TextSpan(
                                text: "City ${_order.orderbyId["address"]["city"]},${_order.orderbyId["address"]["country"]}",
                                style: TextStyle(

                                    fontWeight: FontWeight.w400,

                                    fontSize: 14),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            // Text.rich(
                            //   TextSpan(
                            //     text: "0000",
                            //     style: TextStyle(
                            //
                            //         fontWeight: FontWeight.w400,
                            //
                            //         fontSize: 14),
                            //   ),
                            // ),

                            SizedBox(
                              height: 5,
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.white,
              width: width,
              height: height * 0.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 8.0),
                    child: Text(
                      'Items Ordered',
                      style: TextStyle(
                        //color: Color.fromRGBO(146, 156, 170, 1),
                       // fontFamily: 'Geomanist',
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Divider(
                    color: Color.fromRGBO(112, 112, 112, 1),
                    indent: 20,
                    endIndent: 20,
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  OrderList(a:_order.orderbyId["orderItems"]),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: ElevatedButton(
                onPressed: () {
               //   changeScreen(context, OrderTimeLine());
                },
                child: Text(
                  'Track Parcel',
                  style: TextStyle(
                      color: Color.fromRGBO(85, 115, 116, 1),
                      fontSize: 13,
                      fontFamily: 'Geomanist',
                      fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xffF5F6F7),
                  side: BorderSide(
                    color: Color.fromRGBO(85, 115, 116, 1),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              color: Colors.white,
              height: height * 0.12,
              width: width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 8.0),
                    child: Text(
                      'Payment Details : ',
                      style: TextStyle(


                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      "VISA **** **** ****12",
                      style: TextStyle(fontFamily: 'Geomanist', fontSize: 14),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              color: Colors.white,
              height: height * 0.25,
              width: width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Order Total : ",
                              style: TextStyle(
                                  color: Color.fromRGBO(146, 156, 170, 1),
                                  fontFamily: 'Geomanist',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text.rich(
                                  TextSpan(
                                    text: "Sub total",
                                    style: TextStyle(

                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(right: 25.0),
                                  child: Text(
                                    "${_order.orderbyId["subTotal"]}",
                                    style: TextStyle(

                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),


                            Row(
                              children: [
                                Text.rich(
                                  TextSpan(
                                    text: "Total",
                                    style: TextStyle(

                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(right: 25.0),
                                  child: Text(
                                    "${_order.orderbyId["total"]}",
                                    style: TextStyle(

                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ):Center(child: CircularProgressIndicator(color:Color(0xFF3F5521)),),
    );
  }
}