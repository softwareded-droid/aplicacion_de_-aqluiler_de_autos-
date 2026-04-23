import 'package:flutter/material.dart';
import '../widgets/custom_textfield.dart';
import '../services/api_service.dart';
import 'menu_Principal.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nombreCtrl = TextEditingController();
  final correoCtrl = TextEditingController();
  final licenciaCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  bool loading = false;

  Future<void> registrar() async {
    if (loading) return;

    if (nombreCtrl.text.isEmpty ||
        correoCtrl.text.isEmpty ||
        licenciaCtrl.text.isEmpty ||
        passCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Completa todos los campos")),
      );
      return;
    }

    setState(() => loading = true);

    try {
      final data = {
        "nombre": nombreCtrl.text.trim(),
        "correo": correoCtrl.text.trim(),
        "numLic": licenciaCtrl.text.trim(),
        "password": passCtrl.text.trim(),
      };

      await ApiService.registrarCliente(data);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Cliente registrado correctamente")),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => MenuPrincipal()),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }

    if (mounted) {
      setState(() => loading = false);
    }
  }

  @override
  void dispose() {
    nombreCtrl.dispose();
    correoCtrl.dispose();
    licenciaCtrl.dispose();
    passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 60),
              Icon(Icons.person, size: 100),
              SizedBox(height: 20),

              Text(
                "Registro de Usuario",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 20),

              CustomTextField(
                hint: "Nombre",
                icon: Icons.person,
                controller: nombreCtrl,
              ),
              CustomTextField(
                hint: "Correo",
                icon: Icons.email,
                controller: correoCtrl,
              ),
              CustomTextField(
                hint: "Licencia",
                icon: Icons.badge,
                controller: licenciaCtrl,
              ),
              CustomTextField(
                hint: "Contraseña",
                icon: Icons.lock,
                isPassword: true,
                controller: passCtrl,
              ),

              SizedBox(height: 25),

              loading
                  ? CircularProgressIndicator()
                  : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: registrar,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF60B5FF),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: Text("Registrarse"),
                      ),
                    ),

              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}