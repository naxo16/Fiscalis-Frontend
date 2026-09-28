import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/infraccion.dart';

/// Vista de detalle de solo lectura para una infracción específica.
/// Replica la jerarquía visual de la App SGF_CORE.
class DetalleInfraccionScreen extends StatelessWidget {
  final Infraccion infraccion;

  const DetalleInfraccionScreen({super.key, required this.infraccion});

  @override
  Widget build(BuildContext context) {
    final dateStr = DateFormat('dd/MM/yyyy HH:mm').format(infraccion.fecha);

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: const Text('Detalle de Infracción', style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF171557),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header con PPU y Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  infraccion.ppu,
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF171557)),
                ),
                _buildStatusBadge(infraccion.status),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Registrado el $dateStr',
              style: const TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 24),

            // Información del Infractor
            _buildSectionTitle('Información del Infractor'),
            _buildInfoCard([
              _buildInfoRow('Nombre', infraccion.nombreCompleto ?? 'No especificado'),
              _buildInfoRow('RUT', infraccion.rutInfractor ?? 'No especificado'),
              _buildInfoRow('Firma de Rechazo', infraccion.firmaRechazo ? 'Sí' : 'No'),
            ]),
            const SizedBox(height: 24),

            // Información del Vehículo
            _buildSectionTitle('Vehículo'),
            _buildInfoCard([
              _buildInfoRow('PPU', infraccion.ppu),
              _buildInfoRow('Tipo', infraccion.tipoVehiculo ?? 'No especificado'),
              _buildInfoRow('Marca', infraccion.marcaVehiculo ?? 'No especificado'),
              _buildInfoRow('Color', infraccion.colorVehiculo ?? 'No especificado'),
            ]),
            const SizedBox(height: 24),

            // Ubicación y Hechos
            _buildSectionTitle('Ubicación y Hechos'),
            _buildInfoCard([
              _buildInfoRow('Coordenadas', infraccion.coordenadas),
              const Divider(height: 24),
              const Text('Descripción', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 8),
              Text(
                infraccion.descripcion,
                style: const TextStyle(color: Colors.black87, height: 1.5),
              ),
            ]),
            const SizedBox(height: 24),

            // Evidencia Fotográfica
            _buildSectionTitle('Evidencia Fotográfica'),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: infraccion.fotos.map((path) => _buildPhotoThumbnail(path)).toList(),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black45, letterSpacing: 1.1),
      ),
    );
  }

  Widget _buildInfoCard(List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.black54)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(InfraccionStatus status) {
    final isSincronizado = status == InfraccionStatus.sincronizado;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isSincronizado ? const Color(0xFF15813D) : const Color(0xFFEEE926),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        isSincronizado ? 'SINCRONIZADO' : 'LOCAL',
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: isSincronizado ? Colors.white : const Color(0xFF171557),
        ),
      ),
    );
  }

  Widget _buildPhotoThumbnail(String path) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.file(
        File(path),
        width: 100,
        height: 100,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          width: 100,
          height: 100,
          color: Colors.grey.shade300,
          child: const Icon(Icons.broken_image, color: Colors.grey),
        ),
      ),
    );
  }
}
