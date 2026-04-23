import 'package:flutter/material.dart';
import '../controllers/auto_controller.dart';
import '../models/auto_model.dart';
import '../widgets/custom_textfield.dart';

class RegistrarAutoScreen extends StatefulWidget {
  @override
  _RegistrarAutoScreenState createState() => _RegistrarAutoScreenState();
}

class _RegistrarAutoScreenState extends State<RegistrarAutoScreen> {
  final _marcaCtrl = TextEditingController();
  final _modeloCtrl = TextEditingController();
  final _precioCtrl = TextEditingController();
  final _anioCtrl = TextEditingController();
  final _imagenCtrl = TextEditingController();

  final _controller = AutoController();

  Future<void> _registrar() async {
    // 🔥 VALIDACIÓN
    if (_marcaCtrl.text.isEmpty ||
        _modeloCtrl.text.isEmpty ||
        _precioCtrl.text.isEmpty ||
        _anioCtrl.text.isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Por favor completa todos los campos"),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    try {
      final nuevaAuto = Auto(
        marca: _marcaCtrl.text.trim(),
        modelo: _modeloCtrl.text.trim(),
        precio: int.tryParse(_precioCtrl.text) ?? 0,
        anio: int.tryParse(_anioCtrl.text) ?? 2024,
        disponible: true,
        imagen: _imagenCtrl.text.isNotEmpty
            ? _imagenCtrl.text.trim()
            : "https://loremflickr.com/400/300/car?random=${DateTime.now().millisecond}",
      );

      // 🔥 CLAVE: esperar respuesta del backend
      await _controller.registrarAuto(nuevaAuto);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("¡Vehículo registrado exitosamente!"),
          backgroundColor: Colors.green,
        ),
      );

      // 🔥 regresar y avisar que hubo cambios
      Navigator.pop(context, true);

    } catch (e) {
      print("ERROR REAL: $e");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error al registrar vehículo"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    _marcaCtrl.dispose();
    _modeloCtrl.dispose();
    _precioCtrl.dispose();
    _anioCtrl.dispose();
    _imagenCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registrar Nuevo Vehículo"),
        backgroundColor: Color(0xFF60B5FF),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Datos del vehículo",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),

            CustomTextField(
              hint: "Marca (ej: Toyota)",
              icon: Icons.branding_watermark,
              controller: _marcaCtrl,
            ),

            CustomTextField(
              hint: "Modelo (ej: Corolla)",
              icon: Icons.directions_car,
              controller: _modeloCtrl,
            ),

            CustomTextField(
              hint: "Precio por día (USD)",
              icon: Icons.attach_money,
              controller: _precioCtrl,
              keyboardType: TextInputType.number,
            ),

            CustomTextField(
              hint: "Año (ej: 2023)",
              icon: Icons.calendar_today,
              controller: _anioCtrl,
              keyboardType: TextInputType.number,
            ),

            CustomTextField(
              hint: "URL imagen (opcional)",
              icon: Icons.image,
              controller: _imagenCtrl,
            ),

            SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF60B5FF),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: _registrar,
                icon: Icon(Icons.save),
                label: Text(
                  "Registrar Vehículo",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}