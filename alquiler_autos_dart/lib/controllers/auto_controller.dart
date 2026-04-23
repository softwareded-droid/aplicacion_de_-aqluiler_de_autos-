import '../models/auto_model.dart';
import '../services/api_service.dart';

class AutoController {

  Future<void> registrarAuto(Auto auto) async {
    try {
      final data = {
        "marca": auto.marca,
        "modelo": auto.modelo,
        "valorAlquiler": auto.precio, // 🔥 CORREGIDO
        "anio": auto.anio.toString(), // 🔥 CORREGIDO (string)
        "disponibilidad": auto.disponible, // 🔥 CORREGIDO
        "imagen": auto.imagen
      };

      await ApiService.registrarAuto(data);

    } catch (e) {
      print("ERROR en registrarAuto: $e");
      rethrow;
    }
  }
}