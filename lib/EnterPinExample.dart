
import 'package:expensemanager/ExpenseManagerPage.dart';
import 'package:expensemanager/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';


class EnterPinExample extends StatefulWidget {
  @override
  State<EnterPinExample> createState() => _EnterPinExampleState();
}

class _EnterPinExampleState extends State<EnterPinExample> {
  TextEditingController _pin = TextEditingController();

  // checkpin() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   if (prefs.containsKey("pinentered")) {
  //     Navigator.of(context).pop();
  //     Navigator.of(context).push(
  //         MaterialPageRoute(builder: (context) => EnterPinExample()));
  //   }
  // }
  //
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   checkpin();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Enter Your Pin"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Text(
                "Enter your Pin",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _pin,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Confirm Pin",
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      var Pin = _pin.text.toString();

                      var s_pin = "";

                      SharedPreferences prefs =
                      await SharedPreferences.getInstance();

                      if (prefs.containsKey("Pin"))
                      {
                        s_pin = prefs.getString("Pin");
                      }

                      if(Pin==s_pin)
                      {
                        if(prefs.containsKey("counter"))
                        {
                          prefs.remove("counter");
                        }

                        Navigator.of(context).pop();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => HomePage())
                        );
                      }
                      else
                      {
                        if(prefs.containsKey("counter"))
                        {
                          var c = prefs.getInt("counter");
                          if(c>=3)
                          {
                            Navigator.of(context).pop();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ExpenseManagerPage())
                            );
                          }
                          c++;
                          prefs.setInt("counter", c);
                        }
                        else
                        {
                          prefs.setInt("counter", 1);
                        }

                        Fluttertoast.showToast(
                            msg: "Pin not match",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black26,
                            textColor: Colors.black,
                            fontSize: 20.0
                        );
                      }
                    },
                    child: Text(
                      "Submit",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
