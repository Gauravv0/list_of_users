import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MaterialApp(
      home: Data(),
    ));

class Data extends StatefulWidget {
  @override
  _DataState createState() {
    return _DataState();
  }
}

class _DataState extends State<Data> {
  fetchdata() async {
    var response =
        await http.get(Uri.parse('https://reqres.in/api/users?page=2'));
    if (response.statusCode == 200) {
      var obj = json.decode(response.body);
      return obj;
    }
  }

  @override
  void initState() {
    fetchdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
            future: fetchdata(),
            builder: (context, snapshot) {
              // ignore: unnecessary_null_comparison
              if (snapshot != null) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(snapshot.data[index]["avatar"]),
                      ),
                      title: Text(
                          snapshot.data[index]["first_name" + "last_name"]),
                      subtitle: Text(snapshot.data[index]["email"]),
                    );
                  },
                );
              } else {
                return CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}
