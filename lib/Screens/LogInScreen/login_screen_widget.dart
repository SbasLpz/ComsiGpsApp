import 'package:apprutas/Screens/LogInScreen/login_screen.dart';
import 'package:flutter/material.dart';

class LoginScreenWidget extends StatefulWidget {
  const LoginScreenWidget({super.key});

  @override
  State<LoginScreenWidget> createState() => _LoginScreenWidgetState();
}

class _LoginScreenWidgetState extends State<LoginScreenWidget> with SingleTickerProviderStateMixin {
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
        title: Text("Inicio de Sesión"),
        backgroundColor: Colors.blue[600],
      ),
      body: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: LoginScreen(),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {},
        child: Text("Add +"),
      ),
    );
  }
}
