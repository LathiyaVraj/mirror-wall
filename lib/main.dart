import 'package:flutter/material.dart';
import 'package:mwall1/web_page.dart';

import 'global.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => homepage(),
        "web_page": (context) => website_page(),
      },
    ),
  );
}

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("EDUCATIONAL WEBSITES "),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: ListView.builder(
            itemCount: global.container.length,
            itemBuilder: (context, i) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('web_page', arguments: i);
                  },
                  child: Container(
                    color: Colors.grey,
                    alignment: Alignment.center,
                    height: 100,
                    width: double.infinity,
                    child: Text(
                      "${global.container[i]["name"]}",
                      style: TextStyle(color: Colors.black, fontSize: 23),
                    ),
                  ),
                ),
              );
            }));
  }
}
