import 'package:flutter/material.dart';
import '../services/api_service.dart';

class MisAlquileresScreen extends StatefulWidget {
  final int clienteId;

  const MisAlquileresScreen({super.key, this.clienteId = 1});

  @override
  State<MisAlquileresScreen> createState() => _MisAlquileresScreenState();
}

class _MisAlquileresScreenState extends State<MisAlquileresScreen> {
  List<dynamic> alquileres = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    cargar();
  }

  Future<void> cargar() async {
    setState(() => loading = true);

    try {
      final data = await ApiService.getMisAlquileres(widget.clienteId);

      setState(() {
        alquileres = data;
        loading = false;
      });
    } catch (e) {
      setState(() => loading = false);
    }
  }

  Future<void> devolver(int alquilerId) async {
    try {
      await ApiService.devolverVehiculo(alquilerId);
      await cargar();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Vehículo devuelto"),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error al devolver"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mis Alquileres"),
        backgroundColor: Color(0xFF60B5FF),
      ),

      body: loading
          ? Center(child: CircularProgressIndicator())
          : alquileres.isEmpty
              ? Center(child: Text("No tienes alquileres"))
              : ListView.builder(
                  itemCount: alquileres.length,
                  itemBuilder: (context, index) {
                    final a = alquileres[index];

                    final estado = a['estado'] ?? 'activo';

                    return Card(
                      margin: EdgeInsets.all(10),
                      child: ListTile(
                        leading: Icon(Icons.directions_car),

                        title: Text("Auto ID: ${a['autoId']}"),

                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Inicio: ${a['fechaInicio']}"),

                            SizedBox(height: 4),

                            Text(
                              "Estado: $estado",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: estado == "devuelto"
                                    ? Colors.green
                                    : Colors.orange,
                              ),
                            ),
                          ],
                        ),

                        trailing: estado == "devuelto"
                            ? Text(
                                "DEVUELTO",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                ),
                                onPressed: () => devolver(a['id']),
                                child: Text("Devolver"),
                              ),
                      ),
                    );
                  },
                ),
    );
  }
}