import 'package:flutter/material.dart';
import '../widgets/custom_textfield.dart';
import 'register_screen.dart';
import 'menu_Principal.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.directions_car, size: 100, color: Color(0xFF60B5FF)),
            SizedBox(height: 20),
            Text("Alquiler de Autos",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            Text("Inicia sesión para continuar"),
            SizedBox(height: 30),
            CustomTextField(hint: "Correo electrónico", icon: Icons.email),
            CustomTextField(hint: "Contraseña", icon: Icons.lock, isPassword: true),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF60B5FF),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/MenuPrincipal');
                },
                child: Text("Ingresar", style: TextStyle(fontSize: 16)),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/RegisterScreen'),
              child: Text("¿No tienes cuenta? Regístrate"),
            ),
          ],
        ),
      ),
    );
  }
}
