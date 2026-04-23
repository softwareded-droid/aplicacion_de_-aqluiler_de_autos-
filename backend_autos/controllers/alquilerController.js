const { Alquiler, Cliente, Autos } = require('../models');

const alquilerController = {

  // =========================
  // ➕ CREAR ALQUILER
  // =========================
  async realizarAlquiler(req, res) {
    try {
      const { clienteId, autoId, fechaInicio, fechaFin } = req.body;

      const cliente = await Cliente.findByPk(clienteId);
      if (!cliente) {
        return res.status(404).json({ mensaje: "El cliente no existe" });
      }

      const auto = await Autos.findByPk(autoId);
      if (!auto) {
        return res.status(404).json({ mensaje: "El auto no existe" });
      }

      if (!auto.disponibilidad) {
        return res.status(400).json({ mensaje: "Auto no disponible" });
      }

      const alquiler = await Alquiler.create({
        clienteId,
        autoId,
        fechaInicio,
        fechaFin: null,
        estado: "activo"
      });

      await auto.update({ disponibilidad: false });

      return res.status(201).json({
        mensaje: "Alquiler creado correctamente",
        alquiler
      });

    } catch (error) {
      return res.status(500).json({ error: "Error en alquiler" });
    }
  },

  // =========================
  // 📋 ALQUILERES POR CLIENTE
  // =========================
  async alquileresPorCliente(req, res) {
    try {
      const { clienteId } = req.params;

      const data = await Alquiler.findAll({
        where: { clienteId },
        include: ['Autos']
      });

      return res.json(data);
    } catch (error) {
      return res.status(500).json({ error: "Error al obtener alquileres" });
    }
  },

  // =========================
  // 🔁 DEVOLVER VEHÍCULO
  // =========================
  async devolverVehiculo(req, res) {
    try {
      const { alquilerId } = req.params;

      const alquiler = await Alquiler.findByPk(alquilerId);
      if (!alquiler) {
        return res.status(404).json({ mensaje: "No existe alquiler" });
      }

      const auto = await Autos.findByPk(alquiler.autoId);

      await auto.update({ disponibilidad: true });

      await alquiler.update({
        estado: "devuelto",
        fechaFin: new Date()
      });

      return res.json({
        mensaje: "Vehículo devuelto correctamente",
        estado: "devuelto"
      });

    } catch (error) {
      return res.status(500).json({ error: "Error devolución" });
    }
  }
};

module.exports = alquilerController;