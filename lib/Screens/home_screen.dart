import 'package:flutter/material.dart';

  class HomeScreen extends StatefulWidget {
    const HomeScreen({super.key});

    @override
    State<HomeScreen> createState() => _HomeScreenState();
  }

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen (0)'),
        backgroundColor: Colors.white12
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: ElevatedButton(
              onPressed: () {},
              child: Text("Hola mundo !")
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Text('Add'),
      ),
    );
  }
}
