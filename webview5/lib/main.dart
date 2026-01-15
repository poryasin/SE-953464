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
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const MyHomePage(title: 'Webview JS Example'),
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

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadHtmlString(htmlContent);
  }

  Future<void> _sendMessage() async {
    await _controller.runJavaScript(
      "ShowMessageFromFlutter('Helle from Flutter!)",
    );

    final result = await _controller.runJavaScriptReturningResult(
      "ShowMessageFromFlutter('Helloe from Flutter with return value!')",
    );
    debugPrint("JS returned: $result");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(onPressed: _sendMessage, icon: Icon(Icons.send)),
        ],
        title: Text(widget.title),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}

const String htmlContent = '''
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <h1>Web Page</h1>
    <p id="msg">No message yet</p>

    <script>
        function showMessageFromFlutter(msg) {
            document.getElementById("msg").innerText = "Flutter says:" +msg;
            return "Message received: " +msg
        }
    </script>
</body>
</html> ''';
