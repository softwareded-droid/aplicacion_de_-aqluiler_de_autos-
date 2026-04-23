import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://autos-movil.onrender.com/api';

  // =========================
  // 🚗 AUTOS
  // =========================
  static Future<List<dynamic>> getAutosDisponibles() async {
    final res = await http.get(
      Uri.parse('$baseUrl/autos/disponibles'),
    );

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    }

    throw Exception(res.body);
  }

  // =========================
  // ➕ REGISTRAR AUTO
  // =========================
  static Future<Map<String, dynamic>> registrarAuto(
      Map<String, dynamic> data,
  ) async {
    final res = await http.post(
      Uri.parse('$baseUrl/autos'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (res.statusCode == 200 || res.statusCode == 201) {
      return jsonDecode(res.body);
    }

    throw Exception(res.body);
  }

  // =========================
  // 👤 REGISTRAR CLIENTE
  // =========================
  static Future<Map<String, dynamic>> registrarCliente(
      Map<String, dynamic> data,
  ) async {
    final res = await http.post(
      Uri.parse('$baseUrl/clientes'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (res.statusCode == 200 || res.statusCode == 201) {
      return jsonDecode(res.body);
    }

    throw Exception(res.body);
  }

  // =========================
  // 📋 ALQUILERES
  // =========================
  static Future<List<dynamic>> getMisAlquileres(int clienteId) async {
    final res = await http.get(
      Uri.parse('$baseUrl/alquiler/cliente/$clienteId'),
    );

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    }

    throw Exception(res.body);
  }

  // =========================
  // 🚘 ALQUILAR
  // =========================
  static Future<Map<String, dynamic>> realizarAlquiler(
      int clienteId,
      int autoId,
  ) async {
    final res = await http.post(
      Uri.parse('$baseUrl/alquiler'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "clienteId": clienteId,
        "autoId": autoId,
        "fechaInicio": DateTime.now().toIso8601String(),
      }),
    );

    if (res.statusCode == 200 || res.statusCode == 201) {
      return jsonDecode(res.body);
    }

    throw Exception(res.body);
  }

  // =========================
  // 🔁 DEVOLVER
  // =========================
  static Future<void> devolverVehiculo(int alquilerId) async {
    final res = await http.put(
      Uri.parse('$baseUrl/alquiler/devolver/$alquilerId'),
    );

    if (res.statusCode != 200 && res.statusCode != 204) {
      throw Exception(res.body);
    }
  }
}