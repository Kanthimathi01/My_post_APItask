import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'modal/employeeclass.dart';

class postapi extends StatefulWidget {
  const postapi({super.key});

  @override
  State<postapi> createState() => _postapiState();
}

class _postapiState extends State<postapi> {

  Future<postemployee>? _Post;
  TextEditingController uid=TextEditingController();
  TextEditingController _name=TextEditingController();
  TextEditingController numbers=TextEditingController();
  TextEditingController uname=TextEditingController();
  TextEditingController pasword=TextEditingController();
  TextEditingController confrim=TextEditingController();
  TextEditingController count=TextEditingController();
  bool isVisible = false;
  Future<postemployee>Adddetails(String id,String name,
      String number,String username,String Password,String Confrim,String createby) async
  {
    var res =await http.post(Uri.parse("http://catodotest.elevadosoftwares.com/Employee/InsertEmployee"),
        headers:<String,String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
         body: jsonEncode(<String, dynamic>{
          "employee id":id,
          "employee Name":name,
          "Mobile number":number,
          "USername":username,
          "Confirm password":Password,
          "Created by":createby,

        }));


  var data = jsonDecode(res.body);
  return postemployee.fromJson(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Emplyoee logIN"),
      ),
      body: Column(
        children: [
          TextField(
            controller: uid,
            decoration: InputDecoration(hintText: "employee id"),
          ),
          TextField(
            controller: _name,
            decoration: InputDecoration(hintText: "employee Name"),
          ),
          TextField(
            controller: numbers,
            decoration: InputDecoration(hintText: "Mobile number"),
          ),
          TextField(
            controller: uname,
            decoration: InputDecoration(hintText: "USername"),
          ),
          TextField(
            controller: pasword,
            decoration: InputDecoration(hintText: "password"),
          ),
          TextField(
            controller: confrim,
            decoration: InputDecoration(hintText: "Confirm password"),
          ),
          TextField(
            controller: count,
            decoration: InputDecoration(hintText: "Created by"),
          ),
          Center(child: ElevatedButton(onPressed: (){
            setState(() {
              _Post = Adddetails(uid.text,_name.text,numbers.text,uname.text,pasword.text,confrim.text,count.text);
              isVisible = true;
            });
          }, child: Text("Save"))),
          Visibility(
              visible: isVisible,
              child: FutureBuilder(
                  future: _Post,
                  builder: (context,snapshot){
                    if (snapshot.hasData){
                      return Text("Added Successfully");
                    }
                    else if(snapshot.hasError){
                      return Text("Not Added");
                    }
                    return CircularProgressIndicator();
                  }
                  )
          )
        ],
      )
    );




  }
}
