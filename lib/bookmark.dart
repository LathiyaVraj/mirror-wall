import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:mwall2/global.dart';

import 'main.dart';

class bookmarkpage extends StatefulWidget {
  const bookmarkpage({Key? key}) : super(key: key);

  @override
  State<bookmarkpage> createState() => _bookmarkpageState();
}

class _bookmarkpageState extends State<bookmarkpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("BookMark Link"),
          centerTitle: true,
        ),
        body: ListView.builder(
            itemCount: global.bookmarkList.length,
            itemBuilder: (context, i) {
              return GestureDetector(
                onTap: () {
                  inAppWebViewController.loadUrl(
                      urlRequest:
                          URLRequest(url: Uri.parse(global.bookmarkList[i])));
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Text(
                        "${global.bookmarkList[i]}",
                        style: TextStyle(fontSize: 21),
                      ),
                      Divider(
                        height: 40,
                        thickness: 3,
                        color: Colors.blue,
                        endIndent: 5,
                        indent: 5,
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}
