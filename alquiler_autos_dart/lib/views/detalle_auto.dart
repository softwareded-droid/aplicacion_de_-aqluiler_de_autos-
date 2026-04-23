import 'package:flutter/material.dart';
import '../services/api_service.dart';

class DetalleAuto extends StatelessWidget {
  final Map<String, dynamic> auto;
  const DetalleAuto({Key? key, required this.auto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${auto['marca']} ${auto['modelo']}"),
        backgroundColor: Color(0xFF60B5FF),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          auto['imagen'] != null
            ? Image.network(auto['imagen'], height: 220, width: double.infinity, fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(height: 220, color: Colors.grey[200],
                  child: Icon(Icons.directions_car, size: 80, color: Colors.grey)))
            : Container(height: 220, color: Colors.grey[200],
                child: Icon(Icons.directions_car, size: 80, color: Colors.grey)),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${auto['marca']} ${auto['modelo']}",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text("Año: ${auto['anio']}", style: TextStyle(fontSize: 16, color: Colors.grey[600])),
                Text("Precio/día: \$${auto['valorAlquiler']}", style: TextStyle(fontSize: 16)),
                SizedBox(height: 8),
                Chip(label: Text("Disponible"),
                  backgroundColor: Colors.green[100],
                  labelStyle: TextStyle(color: Colors.green[800])),
                SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF60B5FF), foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () async {
                      try {
                        final result = await ApiService.realizarAlquiler(1, auto['id']);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(result['mensaje'] ?? 'Alquilado'),
                            backgroundColor: Colors.green));
                        Navigator.pop(context);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red));
                      }
                    },
                    icon: Icon(Icons.car_rental),
                    label: Text("Alquilar Vehículo", style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
