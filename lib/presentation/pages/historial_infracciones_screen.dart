import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../providers/infraccion_provider.dart';
import '../widgets/main_scaffold.dart';
import 'detalle_infraccion_screen.dart';
import '../../domain/entities/infraccion.dart';

/// Pantalla de Historial de Actas (DERA).
/// Implementación nativa en Flutter consumiendo Drift y Riverpod.
class HistorialInfraccionesScreen extends ConsumerWidget {
  const HistorialInfraccionesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final infraccionesAsync = ref.watch(infraccionesStreamProvider);

    return MainScaffold(
      selectedIndex: 1,
      title: 'FISCALIS - Historial',
      body: infraccionesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator(color: Color(0xFF171557))),
        error: (err, stack) => Center(child: Text('Error de carga: $err')),
        data: (infracciones) {
          if (infracciones.isEmpty) {
            return _buildEmptyState();
          }

          return Column(
            children: [
              _buildSyncHeader(infracciones.length),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemCount: infracciones.length,
                  itemBuilder: (context, index) {
                    final item = infracciones[index];
                    return _InfraccionListCard(infraccion: item);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.history_toggle_off, size: 80, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          const Text(
            'No hay actas registradas',
            style: TextStyle(color: Colors.black38, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text('Las actas capturadas aparecerán aquí.', style: TextStyle(color: Colors.black26, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildSyncHeader(int count) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF171557).withValues(alpha: 0.05),
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(
            children: [
              Icon(Icons.inventory_2_outlined, size: 16, color: Color(0xFF171557)),
              SizedBox(width: 8),
              Text(
                'Registros Recientes',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF171557)),
              ),
            ],
          ),
          Text(
            '$count Actas',
            style: const TextStyle(fontSize: 12, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

class _InfraccionListCard extends StatelessWidget {
  final Infraccion infraccion;

  const _InfraccionListCard({required this.infraccion});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');
    final dateStr = dateFormat.format(infraccion.fecha);

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade300), // FIX BORDER SYNTAX
      ),
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetalleInfraccionScreen(infraccion: infraccion),
            ),
          );
        },
        contentPadding: const EdgeInsets.all(16),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              infraccion.ppu,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Color(0xFF171557)), // FIX FONTWEIGHT CONSTANT
            ),
            _StatusBadge(status: infraccion.status),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 12, color: Colors.black45),
                const SizedBox(width: 4),
                Text('$dateStr hrs', style: const TextStyle(color: Colors.black54, fontSize: 13)),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.person_outline, size: 12, color: Colors.black45),
                const SizedBox(width: 4),
                Text(infraccion.nombreCompleto ?? 'Sin nombre registrado', style: const TextStyle(color: Colors.black54, fontSize: 13)),
              ],
            ),
          ],
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final InfraccionStatus status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;
    String label;
    IconData icon;

    switch (status) {
      case InfraccionStatus.sincronizado:
        bgColor = const Color(0xFF15813D).withValues(alpha: 0.1);
        textColor = const Color(0xFF15813D);
        label = 'SINCRONIZADO';
        icon = Icons.cloud_done_outlined;
        break;
      case InfraccionStatus.guardadoLocal:
        bgColor = const Color(0xFFEEE926).withValues(alpha: 0.2);
        textColor = const Color(0xFF171557);
        label = 'PENDIENTE SYNC';
        icon = Icons.cloud_upload_outlined;
        break;
      default:
        bgColor = Colors.grey.shade200;
        textColor = Colors.black54;
        label = 'BORRADOR';
        icon = Icons.edit_note;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: textColor),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}