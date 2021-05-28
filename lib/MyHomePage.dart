import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

var ulist = [];
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  


fetchdata() async{
    var url = Uri.parse('https://jsonplaceholder.typicode.com/users/');
var response = await http.get(url);
if (response.statusCode == 200){
  var results = jsonDecode(response.body);
  setState(() {
    ulist = results;
  });
  //print(list[8]['name']);
}
  }
@override
  void initState() {
    super.initState();
    this.fetchdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listing Users'),
      ),
      body: userList(),
    );
  }
}

Widget userList() {
  return ListView.builder(
    itemCount: ulist.length, 
    itemBuilder: (context, index) {
    return userDetails(index);
  });
}

userDetails(index) {
  var id = ulist[index]['id'];
  var uname = ulist[index]['username'];
  var uemail = ulist[index]['email'];
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Row(
         // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.deepPurpleAccent,
                borderRadius: BorderRadius.circular(10), 
            
              ),
              child: Center(child: Text('$id', style: TextStyle(fontSize: 20,
            fontWeight: FontWeight.bold, color: Colors.white),),),
            ),
            SizedBox(width: 20),
            Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text(
                '$uname',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              Text(
                '$uemail',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
            ])
          ],
        ),
        trailing: Text('More Info'),
      ),
    ),
  );
}
