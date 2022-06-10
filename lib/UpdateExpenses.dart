import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'HomePage.dart';
import 'helpers/DataBaseHelper.dart';

class UpdateExpenses extends StatefulWidget {
  var updateEid="";

  UpdateExpenses({this.updateEid});

  @override
  State<UpdateExpenses> createState() => _UpdateExpensesState();
}

class _UpdateExpensesState extends State<UpdateExpenses> {
  var finaldate = "";

  TextEditingController _title = TextEditingController();
  TextEditingController _amount = TextEditingController();
  var _select = 'expense';

  getsingledata() async
  {
    DataBaseHelper obj = new DataBaseHelper();
    var data = await obj.getsingleexpense(widget.updateEid);
    setState(() {
      _title.text = data[0]["title"].toString();
      _amount.text = data[0]["amount"].toString();
      _select = data[0]["type"].toString();
      finaldate = data[0]["datetime"].toString();

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getsingledata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Expenses"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Title :",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _title,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Amount :",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _amount,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Radio(
                      activeColor: Colors.green,
                      value: 'expense',
                      groupValue: _select,
                      onChanged: (value) {
                        setState(() {
                          _select = value;
                        });
                      },
                    ),
                    Text('Expense', style: TextStyle(fontSize: 20)),
                    Radio(
                      activeColor: Colors.green,
                      value: 'income',
                      groupValue: _select,
                      onChanged: (value) {
                        setState(() {
                          _select = value;
                        });
                      },
                    ),
                    Text('Income', style: TextStyle(fontSize: 20)),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  "Date :",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 20.0,
                ),
                (finaldate!="")?  DateTimePicker(
                    type: DateTimePickerType.dateTimeSeparate,
                    dateMask: 'd MMM, yyyy',
                    initialValue:finaldate.toString(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    // icon: Icon(Icons.event),
                    dateLabelText: 'Date',
                    timeLabelText: "Hour",
                    //use24HourFormat: false,
                    //locale: Locale('pt', 'BR'),
                    selectableDayPredicate: (date) {
                      if (date.weekday == 6 || date.weekday == 7) {
                        return false;
                      }
                      return true;
                    },
                    onChanged: (val) => setState(() => finaldate = val),
                    validator: (val) {
                      print("val");
                      return null;
                    },
                    onSaved: (val) => print("val")):SizedBox(height: 0,),
                SizedBox(
                  height: 50,
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () async {
                        var title = _title.text.toString();
                        var amount = _amount.text.toString();
                        // var type = _select.toString();
                        // var datentime = DateTime.now().toString();

                        DataBaseHelper obj = new DataBaseHelper();
                        var status = await obj.updateexpense(
                            title, amount, _select, finaldate,widget.updateEid);

                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => HomePage())
                        );
                        Fluttertoast.showToast(
                            msg: "Record Updated Successfully",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black26,
                            textColor: Colors.black,
                            fontSize: 20.0);

                      },
                      child: Text("Update"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
