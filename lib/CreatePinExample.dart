import 'package:expensemanager/ExpenseManagerPage.dart';
import 'package:expensemanager/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'EnterPinExample.dart';

class CreatePinExample extends StatefulWidget {

  @override
  State<CreatePinExample> createState() => _CreatePinExampleState();
}

class _CreatePinExampleState extends State<CreatePinExample> {

  TextEditingController _pin = TextEditingController();
  TextEditingController _confirmPin = TextEditingController();
  GlobalKey<FormState> _form = GlobalKey<FormState>();

  checkpin() async
  {
    SharedPreferences prefs =
    await SharedPreferences.getInstance();
    if(prefs.containsKey("Pin"))
    {
      if(prefs.containsKey("counter"))
      {
        if(prefs.getInt("counter")>=3)
        {
          Navigator.of(context).pop();
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ExpenseManagerPage())
          );
        }
        else
        {
          Navigator.of(context).pop();
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => EnterPinExample())
          );
        }
      }
      else
      {
        Navigator.of(context).pop();
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => EnterPinExample())
        );
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkpin();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bank Clone Example"),
      ),
      body: SingleChildScrollView(
        child:Form(
          key: _form,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20,),
                Text(
                  "Create Pin:",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                    controller: _pin,
                    obscureText: true,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Create Pin",
                    ),
                    validator: (val){
                      if(val.isEmpty)
                      {
                        return 'Empty';
                      }
                      else
                      {
                        return null;
                      }
                    }
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Confirm Pin :",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                    controller: _confirmPin,
                    obscureText: true,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Confirm Pin",
                    ),
                    validator: (val){
                      if(val.isEmpty) {
                        return 'Empty';
                      }
                      else if(val != _pin.text)
                      {
                        return 'Not Match';
                      }
                      else
                      {
                        return null;
                      }
                    }
                ),
                SizedBox(
                  height: 50,
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width/2,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        if(_form.currentState.validate())
                        {
                          var pin = _pin.text.toString();

                          SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                          prefs.setString("Pin", pin);

                          Navigator.of(context).pop();
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => HomePage())
                          );
                        }
                      },
                      child: Text("Submit",
                        style: TextStyle(fontSize: 20),),
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
