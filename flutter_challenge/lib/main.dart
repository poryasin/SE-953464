import 'package:flutter/material.dart';

void main() {
  runApp(const SimpleInteractionApp());
}

class SimpleInteractionApp extends StatelessWidget {
  const SimpleInteractionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(debugShowCheckedModeBanner: false, home: SimpleInteractionPage());
  }
}

class SimpleInteractionPage extends StatelessWidget {
  const SimpleInteractionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mouse & Touch Workshop')),
      body: const Center(child: HoverTapCard()),
    );
  }
}

class HoverTapCard extends StatefulWidget {
  const HoverTapCard({super.key});

  @override
  State<HoverTapCard> createState() => _HoverTapCardState();
}

class _HoverTapCardState extends State<HoverTapCard> {
  bool isHover = false;
  bool isPressed = false;

  void _onTap(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Activated 🎉')));
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => isHover = true),
      onExit: (_) => setState(() => isHover = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => isPressed = true),
        onTapUp: (_) {
          setState(() => isPressed = false);
          _onTap(context);
        },
        onTapCancel: () => setState(() => isPressed = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: 240,
          height: 140,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color:
                isPressed
                    ? Colors.blue.shade700
                    : isHover
                    ? Colors.blue
                    : Colors.grey,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Text(
            'Hover or Tap Me\n(Mouse / Touch)',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }
}