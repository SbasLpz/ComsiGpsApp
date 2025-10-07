import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
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
    return ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Container(
              width: 400,
              height: 300,
              color: Colors.blueGrey[300],
              child: const Wrap(
                direction: Axis.vertical,
                alignment: WrapAlignment.spaceAround,
                runAlignment: WrapAlignment.center,
                children: [
                  SizedBox(
                    width: 250.0,
                    child: TextField(
                      obscureText: false,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Usuario"
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 250.0,
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Contraseña"
                      ),
                      //keyboardType: TextInputType.visiblePassword,
                    ),
                  )
                ],
              ),
            ),
            Container(
              color: Colors.amber[900],
              width: 100.0,
              height: 100.0,
            ),
            Text("Hola mundo"),
            FilledButton(
                onPressed: () {},
                child: Text("Ingresar"),
            ),
          ],
        ),
      ),
    );
  }
}
