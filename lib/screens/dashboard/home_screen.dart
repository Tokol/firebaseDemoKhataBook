import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fbdemo03/models/khata.dart';
import 'package:fbdemo03/splash_screen.dart';
import 'package:fbdemo03/widget/custome_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config.dart';

class HomeScreen extends StatefulWidget {
  static final String id = "HOME_SCREEN";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseFirestore _store = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home Screen'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                //request to logout in server;
                prefs.setBool(KUserLoginKey, false);
                prefs.setString(KUserEmail, null);
                Navigator.pushReplacementNamed(context, SplashScreen.id);
              },
            )
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: _store.collection("khata").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(

                  itemCount: snapshot.data.size,
                  itemBuilder: (context, position) {
                    var data = snapshot.data.docs;


                    return Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Card(
                        elevation: 10.0,
                        child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: Column(
                              children: <Widget>[

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: () {

                                        var _khataData = data[position];

                                        Khata _khata = Khata();

                                        _khata.name = _khataData["name"];
                                        _khata.itemName = _khataData["itemName"];
                                        _khata.rate = _khataData["rate"];
                                        _khata.quantity = _khataData["quantity"];




                                        _khata.email = _khataData["email"];
                                        _khata.contactNumber = _khataData["contactNumber"];
                                        _khata.date = _khataData["date"];
                                        _khata.remark = _khataData["remark"];








                                        showModalBottomSheet(
                                            backgroundColor: Colors.transparent,
                                            isScrollControlled: true,
                                            context: context,
                                            builder:
                                                (BuildContext context) {
                                              return StatefulBuilder(
                                                builder: (context, state) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      FocusScope.of(context)
                                                          .requestFocus(
                                                          new FocusNode());
                                                    },
                                                    child: Container(
                                                      color: Colors.white,
                                                      height: MediaQuery.of(context).size.height-100,
                                                        child: ListView(
                                                          children: <Widget>[
                                                            Row(children: <Widget>[ IconButton(icon:Icon(Icons.close, ), onPressed: (){
                                                              Navigator.pop(context);

                                                            },)],),
                                                            FireBaseText(
                                                              hint: _khata.name.toString(),
                                                              onChanged: (value){
                                                                _khata.name = value;
                                                              },
                                                            ),

                                                            FireBaseText(
                                                              hint: _khata.itemName.toString(),
                                                              onChanged: (value){
                                                                _khata.itemName = value;
                                                              },
                                                            ),


                                                            FireBaseText(

                                                              hint: _khata.rate.toString(),
                                                              keyboardType:TextInputType.number,

                                                              onChanged: (value){
                                                                _khata.rate = int.parse(value);

                                                              },
                                                            ),


                                                            FireBaseText(
                                                              hint: _khata.quantity.toString(),
                                                              keyboardType:TextInputType.number,
                                                              onChanged: (value){
                                                                _khata.quantity = int.parse(value);
                                                              },
                                                            ),


                                                            FireBaseText(
                                                              hint: _khata.contactNumber.toString(),
                                                              keyboardType:TextInputType.phone,
                                                              onChanged: (value){
                                                                _khata.contactNumber = value;
                                                              },
                                                            ),

                                                            FireBaseText(
                                                              hint: _khata.email.toString(),
                                                              keyboardType:TextInputType.emailAddress,
                                                              onChanged: (value){
                                                                _khata.email = value;
                                                              },
                                                            ),

                                                            GestureDetector(
                                                              onTap: () {
                                                                DatePicker.showDatePicker(context,
                                                                    showTitleActions: true,
                                                                    minTime: DateTime(1995, 1, 1),
                                                                    maxTime: DateTime.now(),
                                                                    onChanged: (date) {
                                                                      DateFormat formatter =
                                                                      DateFormat('yyyy-MM-dd');
                                                                      state(() {
                                                                        _khata.date =
                                                                            (formatter.format(date))
                                                                                .toString();
                                                                      });
                                                                    }, onConfirm: (date) {
                                                                      DateFormat formatter =
                                                                      DateFormat('yyyy-MM-dd');

                                                                      state(() {
                                                                        _khata.date =
                                                                            (formatter.format(date))
                                                                                .toString();
                                                                      });
                                                                    },
                                                                    currentTime: DateTime.now(),
                                                                    locale: LocaleType.en);
                                                              },
                                                              child: Container(
                                                                  width: MediaQuery.of(context)
                                                                      .size
                                                                      .width -
                                                                      100,
                                                                  margin: EdgeInsets.symmetric(
                                                                      horizontal: 10),
                                                                  padding: EdgeInsets.all(20.0),
                                                                  decoration: BoxDecoration(
                                                                    color: Colors.white,
                                                                    borderRadius: BorderRadius.all(
                                                                        Radius.circular(20.0)),
                                                                    border: Border.all(
                                                                        width: 0.8,
                                                                        color: Colors.black38),
                                                                  ),
                                                                  child: Text(
                                                                    _khata.date,
                                                                    textAlign: TextAlign.center,
                                                                  )),
                                                            ),




                                                            FireBaseText(
                                                              hint: _khata.remark.toString(),
                                                              onChanged: (value){
                                                                _khata.remark = value;
                                                              },
                                                            ),






                                                            SizedBox(
                                                              height: MediaQuery.of(context)
                                                                  .viewInsets
                                                                  .bottom ==
                                                                  0
                                                                  ? 10
                                                                  : 300,
                                                            ),
                                                            GestureDetector(
                                                              onTap: () async {

                                  await _store.collection("khata").doc(data[position].id).update(_khata.toMap());


                                                                Navigator.pop(context);
                                                              },
                                                              child: Container(
                                                                width:
                                                                MediaQuery.of(context).size.width -
                                                                    100,
                                                                margin: EdgeInsets.symmetric(
                                                                    vertical: 10, horizontal: 20),
                                                                padding: EdgeInsets.all(20.0),
                                                                decoration: BoxDecoration(
                                                                    color: Colors.greenAccent,
                                                                    borderRadius: BorderRadius.all(
                                                                        Radius.circular(20.0)),
                                                                    border: Border.all(
                                                                        width: 0.8,
                                                                        color: Colors.black38)),
                                                                child: Text(
                                                                  'Update',
                                                                  textAlign: TextAlign.center,
                                                                ),
                                                              ),
                                                            ),





                                                          ],
                                                        ),
                                                    ),
                                                  );
                                                },
                                              );
                                            });
                                      },
                                    ),

                                  IconButton(icon:Icon(Icons.delete), onPressed: () async {

                                    await _store.collection("khata").doc(data[position].id).delete();

                                  },),

                                ],),


                                Text((data[position]["name"]).toString()),
                                Text((data[position]["itemName"]).toString()),
                                Text((data[position]["quantity"]).toString()),
                                Text((data[position]["rate"]).toString()),
                                Text((data[position]["contactNumber"])
                                    .toString()),
                                Text((data[position]["email"]).toString()),
                                Text((data[position]["date"]).toString()),
                                Text((data[position]["remark"]).toString()),
                              ],
                            )),
                      ),
                    );
                  });
            } else {
              return Container(child: Text('Not inserted any Value'));
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          splashColor: Colors.yellowAccent,
          hoverColor: Colors.yellowAccent,
          elevation: 10,
          child: IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Khata _khata = Khata();
              final DateTime now = DateTime.now();
              final DateFormat formatter = DateFormat('yyyy-MM-dd');
              _khata.date = (formatter.format(now)).toString();

              showModalBottomSheet<void>(
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return StatefulBuilder(
                      builder: (context, state) {
                        return Container(
                          height: MediaQuery.of(context).size.height - 200,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0)),
                          ),
                          child: Scrollbar(
                            child: SingleChildScrollView(
                              child: GestureDetector(
                                onTap: () {
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                },
                                child: Column(
                                  children: <Widget>[
                                    FireBaseText(
                                      hint: 'Name',
                                      onChanged: (value) {
                                        _khata.name = value;
                                      },
                                    ),
                                    FireBaseText(
                                      hint: 'Item Name',
                                      onChanged: (value) {
                                        _khata.itemName = value;
                                      },
                                    ),
                                    FireBaseText(
                                      hint: 'Quantity',
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        _khata..quantity = int.parse(value);
                                      },
                                    ),
                                    FireBaseText(
                                      hint: 'Rate',
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        _khata.rate = int.parse(value);
                                      },
                                    ),
                                    FireBaseText(
                                      hint: 'Email',
                                      keyboardType: TextInputType.emailAddress,
                                      onChanged: (value) {
                                        _khata.email = value;
                                      },
                                    ),
                                    FireBaseText(
                                      hint: 'Contact',
                                      onChanged: (value) {
                                        _khata.contactNumber = value;
                                      },
                                      keyboardType: TextInputType.phone,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        DatePicker.showDatePicker(context,
                                            showTitleActions: true,
                                            minTime: DateTime(1995, 1, 1),
                                            maxTime: DateTime.now(),
                                            onChanged: (date) {
                                          DateFormat formatter =
                                              DateFormat('yyyy-MM-dd');
                                          state(() {
                                            _khata.date =
                                                (formatter.format(date))
                                                    .toString();
                                          });
                                        }, onConfirm: (date) {
                                          DateFormat formatter =
                                              DateFormat('yyyy-MM-dd');

                                          state(() {
                                            _khata.date =
                                                (formatter.format(date))
                                                    .toString();
                                          });
                                        },
                                            currentTime: DateTime.now(),
                                            locale: LocaleType.en);
                                      },
                                      child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              100,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          padding: EdgeInsets.all(20.0),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20.0)),
                                            border: Border.all(
                                                width: 0.8,
                                                color: Colors.black38),
                                          ),
                                          child: Text(
                                            _khata.date,
                                            textAlign: TextAlign.center,
                                          )),
                                    ),
                                    FireBaseText(
                                      hint: 'Remark',
                                      onChanged: (value) {
                                        _khata.remark = value;
                                      },
                                    ),
                                    SizedBox(
                                      height: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom ==
                                              0
                                          ? 10
                                          : 300,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        _store
                                            .collection("khata")
                                            .add(_khata.toMap());

                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                100,
                                        margin: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 20),
                                        padding: EdgeInsets.all(20.0),
                                        decoration: BoxDecoration(
                                            color: Colors.greenAccent,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20.0)),
                                            border: Border.all(
                                                width: 0.8,
                                                color: Colors.black38)),
                                        child: Text(
                                          'Save',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  });
            },
          ),
        ));
  }
}
