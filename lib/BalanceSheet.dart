import 'package:expensemanager/helpers/DataBaseHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BalanceSheet extends StatefulWidget {

  @override
  State<BalanceSheet> createState() => _BalanceSheetState();
}

class _BalanceSheetState extends State<BalanceSheet> {
  var totalincome=0.0;
  var totalexpense=0.0;
  var balance=0.0;

  getdata() async
  {
    DataBaseHelper obj = new DataBaseHelper();
    var alldata = await obj.getAllExpense();
    for(var row in alldata)
      {
        if(row["type"].toString()=="income")
          {
            setState(() {
              totalincome = totalincome + double.parse(row["amount"].toString());
            });
          }
        else
          {
            setState(() {
              totalexpense = totalexpense + double.parse(row["amount"].toString());
            });
          }
      }
    setState(() {
      balance= totalincome-totalexpense;
    });
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          color:  Color(0xFFf3e5f5),
          child:Column(
            children: [
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.attach_money, color:Color(0xFF6a1b9a), size:40,),
                  Text("Income :"+totalincome.toString(), style: TextStyle(fontSize: 20, color: Color(0xFF4a148c)),),
                  SizedBox(width: 20,),
                  Text("Expense :"+totalexpense.toString(), style: TextStyle(fontSize: 20, color: Color(0xFF4a148c)),),
                ],
              ),
              SizedBox(height: 50,),
              Text("Total Balance :" + balance.toString(),style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: Color(0xFF4a148c)),),
            ],
          ),

        ),

      ),
    );
  }
}
