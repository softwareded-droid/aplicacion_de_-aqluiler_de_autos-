const express = require('express');
const router = express.Router();
const alquilerController = require('../controllers/alquilerController');

// =========================
// ➕ CREAR ALQUILER
// =========================
router.post('/', alquilerController.realizarAlquiler);

// =========================
// 📋 ALQUILERES POR CLIENTE
// =========================
router.get('/cliente/:clienteId', alquilerController.alquileresPorCliente);

// =========================
// 🔁 DEVOLVER VEHÍCULO
// =========================
router.put('/devolver/:alquilerId', alquilerController.devolverVehiculo);

module.exports = router;