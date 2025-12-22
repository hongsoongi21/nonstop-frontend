import 'package:flutter/material.dart';

class BoardScreen extends StatelessWidget {
  const BoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Board')),
      body: const Center(child: Text('Board Screen')),
    );
  }
}
