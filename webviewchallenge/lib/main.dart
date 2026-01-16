import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple.shade100)),
      home: const MyHomePage(title: 'Webview JS Example',),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final WebViewController _controller;
  String totalFromJS = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        'FlutterChannel',
        onMessageReceived: (JavaScriptMessage message) {
          setState(() {
            totalFromJS = message.message;
          });
        },
      );
    _controller.loadHtmlString(htmlContent);
  }

  Future<void> _sendMessage() async {
    final int step2Total = int.tryParse(totalFromJS) ?? 0;

    await _controller.runJavaScript("updateTotalFromFlutter('$step2Total');");

    debugPrint("Sent to JS: $step2Total");
  }

  @override
  Widget build(BuildContext context) {

   
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(child: WebViewWidget(controller: _controller)),
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.grey[200],
              width: double.infinity,
              child: Text(
                'Receive from JS: $totalFromJS',
                style: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: _sendMessage,
              child:  Text(" Send + 100 total from Flutter to JS"),
            ),
          ],
        ),
      ),
    );
  }
}

const String htmlContent = '''
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>My Cart</title>
    <style>
      body {
        font-family: -apple-system, Arial, sans-serif;
        padding: 16px;
      }
      h1 {
        font-size: 28px;
        margin: 8px 0 16px;
      }
      .row {
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 10px 12px;
        border: 1px solid #e6e6e6;
        border-radius: 10px;
        margin-bottom: 10px;
      }
      .name {
        font-size: 14px;
      }
      .btn {
        padding: 6px 14px;
        font-size: 12px;
        border-radius: 15px;
        border: 1px solid #d9d9d9;
        background: #f4f4f4;
        color: #008BFF;
      }
      .cartTitle {
        font-weight: 700;
        font-size: 18px;
        margin-top: 18px;
      }
      .totalLabel {
        margin-top: 8px;
        font-size: 12px;
        color: #444;
      }
      .totalValue {
        margin-top: 6px;
        font-size: 12px;
      }
    </style>
  </head>
  <body>
    <h1>My Cart</h1>

    <div class="row">
      <div class="name">Apple - \$30</div>
      <button class="btn" onclick="addItem(30)">Add</button>
    </div>

    <div class="row">
      <div class="name">Banana - \$20</div>
      <button class="btn" onclick="addItem(20)">Add</button>
    </div>

    <div class="row">
      <div class="name">Orange - \$25</div>
      <button class="btn" onclick="addItem(25)">Add</button>
    </div>

    <div class="row">
      <div class="name">Milk - \$45</div>
      <button class="btn" onclick="addItem(45)">Add</button>
    </div>

    <div class="row">
      <div class="name">Bread - \$35</div>
      <button class="btn" onclick="addItem(35)">Add</button>
    </div>

    <div class="cartTitle">Cart</div>
    <div class="totalLabel">Total:</div>
    <div class="totalValue" id="total">\$0</div>


    <script>
      var total = 0;

      function renderTotal() {
        document.getElementById("total").innerText = "\$" + total;
      }

      function sendTotalToFlutter() {
        if (window.FlutterChannel && window.FlutterChannel.postMessage) {
          window.FlutterChannel.postMessage(String(total));
        }
      }

      function addItem(price) {
        total += price;
        renderTotal();
        sendTotalToFlutter();
      }

      function updateTotalFromFlutter(newTotal) {
        var v = parseInt(newTotal);
        if (isNaN(v)) v = 0;
        total = v + 100;
        renderTotal();
        sendTotalToFlutter();
        return total;
      }

      function showMessageFromFlutter(msg) {
        document.getElementById("msg").innerText = "Flutter says:" + msg;
        return "Message received: " + msg;
      }

      renderTotal();
      sendTotalToFlutter();
    </script>
  </body>
</html>
''';
