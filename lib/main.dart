import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lesson7/model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HTTP Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'HTTP Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder(
          future: makeRequest(),
          builder: (context, snapshot){
            if(snapshot.hasData){
              return ListView.separated(
                separatorBuilder: (context, index){
                  return Divider();
                },
                itemCount: snapshot.data.length,
                  itemBuilder: (context, index){
                    return ListTile(
                      title: Text('${snapshot.data[index].id} ${snapshot.data[index].title}'),
                    );
                  }
              );
            }
            if(snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  Future<List<Model>> makeRequest()async{
    await Future.delayed(Duration(seconds: 2));

    var url = 'http://jsonplaceholder.typicode.com/posts';
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    List<dynamic> responseMap = jsonDecode(response.body);
    List<Model> modelList = [];
    responseMap.forEach((value) {
      modelList.add(Model.fromJson(value));
    });

    return modelList;
  }
}
