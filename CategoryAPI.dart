import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled6/modal/Success.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  Future<Success>? _future;
  TextEditingController Category = TextEditingController();
  TextEditingController Desc = TextEditingController();
  bool isVisible = false;
  Future<Success> AddNewCategory(String category, String desc) async
  {
    var resp = await http.post(Uri.parse("http://catodotest.elevadosoftwares.com/category/insertcategory"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "categoryId":0,
        "category":category,
        "description":desc,
        "createdBy":1
      }),

    );
    var data = jsonDecode(resp.body);
    return Success.fromJson(data);

  }
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //
  // }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: Column(
            children: [
              TextField(
                controller: Category,
                decoration: const InputDecoration(hintText: 'Enter Category'),
              ),
              TextField(
                controller: Desc,
                decoration: const InputDecoration(hintText: 'Enter Desc'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _future = AddNewCategory(Category.text, Desc.text);
                    isVisible = true;
                  });
                },
                child: const Text('Create Data'),
              ),
              Visibility(
                visible: isVisible,
                child: FutureBuilder(
                  future: _future,
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

                    // By default, show a loading spinner.
                    return const CircularProgressIndicator();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
