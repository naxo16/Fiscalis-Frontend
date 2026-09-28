import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import '../providers/infraccion_provider.dart';

class MainScaffold extends ConsumerWidget {
  final Widget body;
  final int selectedIndex;
  final String title;
  final Widget? bottomActionArea; // Inyección dinámica para botones específicos de la vista

  const MainScaffold({
    super.key,
    required this.body,
    required this.selectedIndex,
    required this.title,
    this.bottomActionArea,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const Color cPrimary = Color(0xFF171557);
    final isAuthenticated = ref.watch(authProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: cPrimary,
        elevation: 4,
        shadowColor: Colors.black26,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: isAuthenticated ? [
          IconButton(
            icon: const Icon(Icons.sync, color: Colors.white),
            tooltip: 'Forzar Sincronización',
            onPressed: () async {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sincronizando actas...')),
              );
              try {
                final count = await ref.read(syncServiceProvider).syncPendingInfracciones();
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Sincronización completa: $count registros')),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error de sync: $e'), backgroundColor: Colors.red),
                  );
                }
              }
            },
            splashColor: const Color(0xFF2D2D6D),
          ),
        ] : null,
      ),
      drawer: isAuthenticated ? _buildDrawer(context, ref) : null,
      body: body,
      bottomNavigationBar: isAuthenticated ? _buildBottomNav(context) : null,
    );
  }

  // --- HAMBURGUESA (DRAWER LATERAL) ---
  Widget _buildDrawer(BuildContext context, WidgetRef ref) {
    const cPrimary = Color(0xFF171557);
    return Drawer(
      backgroundColor: const Color(0xFFF9F9F9),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: cPrimary),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/fiscalis_logo.png', height: 60),
                const SizedBox(height: 12),
                const Text('Fiscalis', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Inter')),
                const Text('Inspector Municipal', style: TextStyle(color: Colors.white70, fontSize: 14, fontFamily: 'Inter')),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.add_circle_outline, color: Color(0xFF464650)),
            title: const Text('Nueva Infracción', style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600)),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
          ListTile(
            leading: const Icon(Icons.history, color: Color(0xFF464650)),
            title: const Text('Historial de Turno', style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600)),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/historial');
            },
          ),

          ListTile(
            leading: const Icon(Icons.settings, color: Color(0xFF464650)),
            title: const Text('Ajustes Técnicos', style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600)),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/ajustes');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app, color: Color(0xFFBA1A1A)),
            title: const Text('Cerrar Sesión', style: TextStyle(color: Color(0xFFBA1A1A), fontFamily: 'Inter', fontWeight: FontWeight.bold)),
            onTap: () async {
              final pendingAsync = ref.read(pendingInfraccionesCountProvider);
              final pendingCount = pendingAsync.value ?? 0;

              if (pendingCount > 0) {
                Navigator.pop(context); // Close drawer
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('No puede cerrar sesión con $pendingCount actas pendientes de sincronizar. (RF-016)'),
                    backgroundColor: Colors.red,
                    duration: const Duration(seconds: 4),
                  ),
                );
                return;
              }

              final db = ref.read(databaseProvider);
              await ref.read(authProvider.notifier).logout(db: db);
              if (context.mounted) {
                Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
              }
            },
          ),
        ],
      ),
    );
  }

  // --- BARRA INFERIOR GLOBAL ---
  Widget _buildBottomNav(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: const Border(top: BorderSide(color: Color(0xFFC8C5D1))),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 6, offset: const Offset(0, -4))],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Inyección del área de acción (Ej: Botón Guardar de la vista Infracción)
            if (bottomActionArea != null) bottomActionArea!,
            
            // Footer Institucional (Global para toda la app)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(border: Border(top: BorderSide(color: const Color(0xFFC8C5D1).withValues(alpha: 0.3)))),
              child: const Text(
                'Fiscalis v1.0.0 • Desarrollado por Renkai',
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'Inter', fontSize: 11, fontWeight: FontWeight.w500, color: Color(0xFF777681)),
              ),
            ),

            // Botones de Navegación
            Container(
              height: 64,
              decoration: const BoxDecoration(border: Border(top: BorderSide(color: Color(0xFFC8C5D1)))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavTab(context, Icons.add_circle, 'Nuevo', 0, '/home'),
                  _buildNavTab(context, Icons.history, 'Historial', 1, '/historial'),
                  _buildNavTab(context, Icons.settings, 'Ajustes', 2, '/ajustes'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavTab(BuildContext context, IconData icon, String label, int index, String route) {
    final isActive = selectedIndex == index;
    const cPrimary = Color(0xFF171557);
    const cSecondaryContainer = Color(0xFFEEE925);
    const cOnSurfaceVariant = Color(0xFF464650);

    return GestureDetector(
      onTap: () {
        if (!isActive) {
          // Navegación sin apilar infinitamente pantallas
          Navigator.pushReplacementNamed(context, route);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: isActive ? cSecondaryContainer : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: isActive ? cPrimary : cOnSurfaceVariant),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isActive ? cPrimary : cOnSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}