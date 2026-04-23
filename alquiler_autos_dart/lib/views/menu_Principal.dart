import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'detalle_auto.dart';
import 'mis_alquileres_screen.dart';
import 'registrar_auto_screen.dart';
import '../widgets/menu_drawer_perfil.dart';

class MenuPrincipal extends StatefulWidget {
  @override
  _MenuPrincipalState createState() => _MenuPrincipalState();
}

class _MenuPrincipalState extends State<MenuPrincipal> {
  List<dynamic> _autos = [];
  bool _cargando = true;

  @override
  void initState() {
    super.initState();
    _cargarAutos();
  }

  Future<void> _cargarAutos() async {
    setState(() => _cargando = true);

    try {
      final autos = await ApiService.getAutosDisponibles();

      if (!mounted) return;

      setState(() {
        _autos = autos;
        _cargando = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() => _cargando = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error conectando al servidor: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // 🔥 FUNCIÓN CENTRAL DE NAVEGACIÓN SEGURA
  Future<void> _goToRegistrarAuto() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => RegistrarAutoScreen()),
    );

    if (result == true && mounted) {
      await _cargarAutos();
    }
  }

  Future<void> _goToMisAlquileres() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => MisAlquileresScreen()),
    );

    if (mounted) {
      await _cargarAutos();
    }
  }

  Future<void> _goToDetalle(auto) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => DetalleAuto(auto: auto)),
    );

    if (mounted) {
      await _cargarAutos();
    }
  }

  Future<void> _refresh() async {
    await _cargarAutos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        title: Text("Vehículos Disponibles"),
        backgroundColor: Color(0xFF60B5FF),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _refresh,
          )
        ],
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [

            DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF60B5FF)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage('https://picsum.photos/200'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Usuario",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "usuario@email.com",
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),

            ListTile(
              leading: Icon(Icons.home, color: Color(0xFF60B5FF)),
              title: Text("Inicio"),
              onTap: () => Navigator.pop(context),
            ),

            ListTile(
              leading: Icon(Icons.car_rental, color: Color(0xFF60B5FF)),
              title: Text("Mis Alquileres"),
              onTap: () async {
                Navigator.pop(context);
                await _goToMisAlquileres();
              },
            ),

            ListTile(
              leading: Icon(Icons.add_circle, color: Color(0xFF60B5FF)),
              title: Text("Registrar Vehículo"),
              onTap: () async {
                Navigator.pop(context);
                await _goToRegistrarAuto();
              },
            ),

            Divider(),

            ListTile(
              leading: Icon(Icons.person, color: Color(0xFF60B5FF)),
              title: Text("Perfil"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => MenuDrawerPerfil()),
                );
              },
            ),

            ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: Text("Cerrar Sesión"),
              onTap: () =>
                  Navigator.pushReplacementNamed(context, '/LoginScreen'),
            ),
          ],
        ),
      ),

      body: _cargando
          ? Center(child: CircularProgressIndicator())
          : _autos.isEmpty
              ? Center(
                  child: Text(
                    "No hay vehículos disponibles",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                )
              : GridView.builder(
                  padding: EdgeInsets.all(12),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.78,
                  ),
                  itemCount: _autos.length,
                  itemBuilder: (context, index) {
                    final auto = _autos[index];

                    return GestureDetector(
                      onTap: () async {
                        await _goToDetalle(auto);
                      },
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(14),
                              ),
                              child: auto['imagen'] != null
                                  ? Image.network(
                                      auto['imagen'],
                                      height: 110,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) => Container(
                                        height: 110,
                                        color: Colors.grey[200],
                                        child: Icon(
                                          Icons.directions_car,
                                          color: Colors.grey,
                                          size: 50,
                                        ),
                                      ),
                                    )
                                  : Container(
                                      height: 110,
                                      color: Colors.grey[200],
                                      child: Icon(
                                        Icons.directions_car,
                                        color: Colors.grey,
                                        size: 50,
                                      ),
                                    ),
                            ),

                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${auto['marca']}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    "${auto['modelo']} ${auto['anio']}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "\$${auto['valorAlquiler']}/día",
                                    style: TextStyle(
                                      color: Color(0xFF60B5FF),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF60B5FF),
        foregroundColor: Colors.white,
        onPressed: () async {
          await _goToRegistrarAuto();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}