import 'package:date_time_picker/date_time_picker.dart';
import 'package:expensemanager/HomePage.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';

import 'helpers/DataBaseHelper.dart';

class ExpenseManagerPage extends StatefulWidget {
  // var updateEid="";
  //
  // UpdateEmployee({this.updateEid});
  @override
  State<ExpenseManagerPage> createState() => _ExpenseManagerPageState();
}

class _ExpenseManagerPageState extends State<ExpenseManagerPage> {
  var finaldate = "";

  TextEditingController _title = TextEditingController();
  TextEditingController _amount = TextEditingController();
  var _select = 'expense';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense Manager"),
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
                Container(
                  width: MediaQuery.of(context).size.width,
                  child : Row(
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
                      SizedBox(width: 100,),
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
                DateTimePicker(
                    type: DateTimePickerType.dateTimeSeparate,
                    dateMask: 'd MMM, yyyy',
                    initialValue: DateTime.now().toString(),
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
                    onSaved: (val) => print("val")),
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
                        var id = await obj.addexpense(
                            title, amount, _select, finaldate);
                        print("Record inserted at :" + id.toString());

                        Fluttertoast.showToast(
                            msg: "Record inserted Successfully",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 20.0);

                        _title.text = "";
                        _amount.text = "";
                        _select="";
                        finaldate="";
                        
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => HomePage())
                        );
                        

                      },
                      child: Text("ADD"),
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
