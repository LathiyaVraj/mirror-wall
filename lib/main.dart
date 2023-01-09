import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:mwall2/bookmark.dart';
import 'package:mwall2/global.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => homepage(),
        "bookmark": (context) => bookmarkpage(),
      },
    ),
  );
}

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

late InAppWebViewController inAppWebViewController;

class _homepageState extends State<homepage> {
  late PullToRefreshController pullToRefreshController;
  TextEditingController searchcontroller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          await inAppWebViewController.reload();
        }
        if (Platform.isIOS) {
          Uri? uri = await inAppWebViewController.getUrl();

          await inAppWebViewController.loadUrl(
              urlRequest: URLRequest(url: uri));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        title: const Text("SEARCH ENGINE"),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.red,
            heroTag: "btn2",
            onPressed: () async {
              Uri? uri = await inAppWebViewController.getUrl();

              global.bookmarkList.add(uri.toString());
            },
            child: Icon(Icons.bookmark_add_outlined),
          ),
          SizedBox(
            width: 20,
          ),
          FloatingActionButton(
            backgroundColor: Colors.red,
            heroTag: "btn1",
            onPressed: () async {
              // await inAppWebViewController.loadUrl(urlRequest: )
              Navigator.of(context).pushNamed("bookmark");
            },
            child: Icon(Icons.web),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: 50,
              width: double.infinity,
              color: Colors.black.withOpacity(0.4),
              child: Container(
                color: Colors.red,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        color: Colors.white,
                        onPressed: () async {
                          if (await inAppWebViewController.canGoBack()) {
                            await inAppWebViewController.goBack();
                          }
                        },
                        icon: Icon(Icons.keyboard_arrow_left)),
                    IconButton(
                        color: Colors.white,
                        onPressed: () async {
                          if (await inAppWebViewController.canGoForward()) {
                            await inAppWebViewController.goForward();
                          }
                        },
                        icon: Icon(Icons.keyboard_arrow_right)),
                    IconButton(
                        color: Colors.white,
                        onPressed: () async {
                          if (Platform.isAndroid) {
                            await inAppWebViewController.reload();
                          }
                          if (Platform.isIOS) {
                            Uri? uri = await inAppWebViewController.getUrl();

                            await inAppWebViewController.loadUrl(
                                urlRequest: URLRequest(url: uri));
                          }
                        },
                        icon: Icon(Icons.restart_alt)),
                    IconButton(
                        color: Colors.white,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text("Search"),
                              content: TextFormField(
                                onFieldSubmitted: (val) {
                                  Navigator.of(context).pop();
                                },
                                controller: searchcontroller,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Search here...",
                                ),
                                onChanged: (val) {
                                  inAppWebViewController.loadUrl(
                                      urlRequest: URLRequest(
                                          url: Uri.parse(
                                              "https://www.google.com/search?q=$val")));
                                },
                              ),
                            ),
                          );
                        },
                        icon: Icon(Icons.search)),
                    IconButton(
                        color: Colors.white,
                        onPressed: () async {
                          await inAppWebViewController.stopLoading();
                        },
                        icon: Icon(Icons.cancel)),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 15,
            child: InAppWebView(
              initialOptions: InAppWebViewGroupOptions(
                android: AndroidInAppWebViewOptions(
                  useHybridComposition: true,
                ),
              ),
              initialUrlRequest: URLRequest(
                url: Uri.parse("https://www.google.co.in/"),
              ),
              pullToRefreshController: pullToRefreshController,
              onWebViewCreated: (val) {
                setState(() {
                  inAppWebViewController = val;
                });
              },
              onLoadStop: (controller, uri) async {
                await pullToRefreshController.endRefreshing();
              },
            ),
          ),
        ],
      ),
    );
  }
}
