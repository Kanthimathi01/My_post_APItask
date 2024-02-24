import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'modal/clientpostclass.dart';
class poss extends StatefulWidget {
  const poss({super.key});

  @override
  State<poss> createState() => _possState();
}

class _possState extends State<poss> {
  Future<Details>? _clientdetails;
  
  TextEditingController cid = TextEditingController();
  TextEditingController cname = TextEditingController();
  TextEditingController cnum = TextEditingController();
  TextEditingController cweb = TextEditingController();
  TextEditingController cmail = TextEditingController();
  TextEditingController cper = TextEditingController();
  TextEditingController ccon = TextEditingController();
  TextEditingController cby = TextEditingController();
  bool isVisible = false;
  Future<Details> Addclient(
      String id,String name,String number,String webname,String mail,String contact,String ph,String createby) async
  {
    var resp = await http.post(Uri.parse("http://catodotest.elevadosoftwares.com/Client/InsertClient"),
        headers : <String,String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
        body: jsonEncode(<String, dynamic>{
          "clientId":id,
          "clientName":name,
          "phone":number,
          "website":webname,
          "email":mail,
          "contactperson":contact,
          "phonenumber":ph,
          "Created by":createby,

        }));
    var data = jsonDecode(resp.body);
    return Details.fromJson(data);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller:  cid,
            decoration: InputDecoration(
              hintText: "ID"
            ),
          ),
          TextField(
            controller: cname,
            decoration: InputDecoration(
                hintText: "Name"
            ),
          ),
          TextField(
            controller: cnum,
            decoration: InputDecoration(
                hintText: "Number"
            ),
          ),
          TextField(
            controller: cweb,
            decoration: InputDecoration(
                hintText: "website"
            ),
          ),
          TextField(
            controller: cmail,
            decoration: InputDecoration(
                hintText: "Email"
            ),
          ),
          TextField(
            controller: cper,
            decoration: InputDecoration(
                hintText: "personname"
            ),
          ),
          TextField(
            controller: ccon,
            decoration: InputDecoration(
                hintText: "Contact"
            ),
          ),
          TextField(
            controller: cby,
            decoration: InputDecoration(
                hintText: "by"
            ),
          ),
          ElevatedButton(onPressed: (){
            _clientdetails = Addclient(cid.text, cname.text, cnum.text, cweb.text, cmail.text, cper.text,ccon.text,cby.text);
            isVisible = true;
          }, child: Text("save")),
          Visibility(
            visible: isVisible,
            child: FutureBuilder(
              future: Addclient(cid.text, cname.text, cnum.text, cweb.text, cmail.text, cper.text,ccon.text, cby.text),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if(snapshot.data!.success == true) {
                    return Text("Added Sucessfully");
                  }
                  else
                  {
                    return Text("Not Added");
                  }
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),

    );
  }
}
