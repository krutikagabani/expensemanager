import 'dart:io';

import 'package:expensemanager/BalanceSheet.dart';
import 'package:expensemanager/ExpenseManagerPage.dart';
import 'package:expensemanager/TransactionsData.dart';
import 'package:expensemanager/UpdateExpenses.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'helpers/DataBaseHelper.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Future<List> alldata;
  //
  // getData() async
  // {
  //   DataBaseHelper obj = new DataBaseHelper();
  //   setState(() {
  //     alldata = obj.getAllExpense();
  //   });
  // }
  //
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   getData();
  // }

  // _createDialog(id) {
  //   AlertDialog alert = AlertDialog(
  //     title: Text("Are you Sure ?"),
  //     content: Text("Do you really want to delete permanently ?"),
  //     contentPadding: EdgeInsets.all(15.0),
  //     actions: [
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Container(
  //             width: MediaQuery.of(context).size.width / 3,
  //             child: ElevatedButton(onPressed: () async {
  //               DataBaseHelper obj = new DataBaseHelper();
  //               int status = await obj.deleteexpense(id);
  //               print("Status :"+status.toString());
  //               Navigator.of(context).pop();
  //               if(status==1)
  //               {
  //                 print("Record Deleted");
  //                 Fluttertoast.showToast(
  //                     msg: "Record Deleted Permanently",
  //                     toastLength: Toast.LENGTH_SHORT,
  //                     gravity: ToastGravity.CENTER,
  //                     timeInSecForIosWeb: 1,
  //                     backgroundColor: Colors.red,
  //                     textColor: Colors.white,
  //                     fontSize: 20.0
  //                 );
  //                 getData();
  //               }
  //               else
  //               {
  //                 print("Error");
  //               }
  //             }, child: Text("Yes")),
  //           ),
  //           Container(
  //             width: MediaQuery.of(context).size.width / 3,
  //             child: ElevatedButton(
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //                 child: Text("No")),
  //           ),
  //         ],
  //       ),
  //     ],
  //   );
  //
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return alert;
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Home page"),
          centerTitle: true,
          bottom: TabBar(
            indicatorWeight: 3,
            indicatorColor: Colors.white,
            //Change background color from here
            tabs: [
              Tab(
                icon: Icon(Icons.compare_arrows_rounded),
                child: Text("Transactions", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
              ),
              Tab(
                icon: Icon(Icons.attach_money),
                child: Text("Balances", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
              ),
            ],
          ),
        ),
        // body: FutureBuilder(
        //     future: alldata,
        //     builder: (context,snapshots)
        //     {
        //       if(snapshots.hasData)
        //       {
        //         //  if data loaded
        //         if(snapshots.data.length<=0)
        //         {
        //           return Center(child: Text("No data"));
        //         }
        //         else
        //         {
        //           return ListView.builder(
        //               itemCount:  snapshots.data.length,
        //               itemBuilder: (context,index)
        //               {
        //                 return Card(
        //                   color: (snapshots.data[index]["type"].toString()=="income")?Colors.green.shade300:Colors.red.shade300,
        //                   elevation: 20,
        //                   margin: EdgeInsets.all(10),
        //                   child: Column(
        //                     children: [
        //                       Divider(),
        //                       Text(snapshots.data[index]["title"].toString(), style: TextStyle(fontSize: 20),),
        //                       Divider(),
        //                       Text(snapshots.data[index]["amount"].toString(), style: TextStyle(fontSize: 20),),
        //                       Divider(),
        //                       Text(snapshots.data[index]["type"].toString(), style: TextStyle(fontSize: 20),),
        //                       Divider(),
        //                       Text(snapshots.data[index]["datetime"].toString(), style: TextStyle(fontSize: 20),),
        //                       Divider(),
        //                       SizedBox(
        //                         height: 30,
        //                       ),
        //                       Row(
        //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                         children: [
        //                           Padding(
        //                             padding: EdgeInsets.all(5),
        //                           ),
        //                           Container(
        //                             width:
        //                             MediaQuery.of(context).size.width / 2.3,
        //                             child: ElevatedButton(
        //                                 onPressed: () {
        //                                   var id = snapshots.data[index]["eid"].toString();
        //                                   _createDialog(id);
        //                                 }, child: Text("Delete")),
        //                           ),
        //                           Padding(
        //                             padding: EdgeInsets.all(5),
        //                           ),
        //                           Container(
        //                             width:
        //                             MediaQuery.of(context).size.width / 2.3,
        //                             child: ElevatedButton(
        //                                 onPressed: () {
        //                                   var id = snapshots.data[index]["eid"].toString();
        //                                   Navigator.of(context).push(
        //                                       MaterialPageRoute(builder: (context)=>UpdateExpenses(updateEid: id))
        //                                   );
        //                                 },
        //                                 child: Text("Update")),
        //                           ),
        //                           Padding(
        //                             padding: EdgeInsets.all(5),
        //                           ),
        //                         ],
        //                       ),
        //                     ],
        //                   ),
        //                 );
        //               }
        //           );
        //         }
        //       }
        //       else
        //       {
        //         //  data not loaded
        //         return Center(child: CircularProgressIndicator(),);
        //       }
        //     }
        // ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ExpenseManagerPage())
            );
          },
          label: const Text('Add'),
          icon: const Icon(Icons.add),
          backgroundColor: Color(0xFF6a1b9a),
        ),

        body: TabBarView(
          children: [
            TransactionsData(),
            BalanceSheet(),

            // SingleChildScrollView(
            //   child: Column(
            //     children: [
            //       Text("Tab 4")
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
