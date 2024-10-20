import 'package:flutter/material.dart';

class PreviewResultScreen extends StatelessWidget {
  const PreviewResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PreviewResultScreenContent();
  }
}

class PreviewResultScreenContent extends StatelessWidget {
  const PreviewResultScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview screen'),
      ),
      body: const Column(
        children: [],
      ),
    );
  }
}
