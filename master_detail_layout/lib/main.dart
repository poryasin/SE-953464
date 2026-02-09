import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Responsive Padding Challenge")),
        body: const ResponsiveCard(),
      ),
    );
  }
}

class ResponsiveCard extends StatelessWidget {
  const ResponsiveCard({super.key});

  @override
  Widget build(BuildContext context) {
    // 1️⃣ MediaQuery → full screen info
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isTablet = screenWidth >= 600;

    return Padding(
      padding: EdgeInsets.all(isTablet ? 32 : 12),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // 2️⃣ LayoutBuilder → actual widget width
          final boxWidth = constraints.maxWidth;

          final useVerticalLayout = boxWidth < 600;

          return Container(
            height: 150,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.pinkAccent,
              borderRadius: BorderRadius.circular(16),
            ),
            child:
                Text(useVerticalLayout ? "Small Screen" : "Large Screen",style:const TextStyle(fontSize: 18, color: Colors.white,fontWeight: FontWeight.bold),),
          );
        },
      ),
    );
  }

  List<Widget> _contentWidgets() {
    return [
      const Icon(Icons.phone_android, size: 80),
      const SizedBox(width: 16, height: 16),
      const Expanded(
        child: Text(
          "This layout adapts using MediaQuery + LayoutBuilder",
          style: TextStyle(fontSize: 18),
        ),
      ),
    ];
  }
}
