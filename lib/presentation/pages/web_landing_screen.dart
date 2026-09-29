import 'package:flutter/material.dart';

class WebLandingScreen extends StatelessWidget {
  const WebLandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.admin_panel_settings,
                  size: 100,
                  color: Colors.white,
                ),
                const SizedBox(height: 24),
                const Text(
                  'Sistema de Gestión Fiscalizadora (SGF)',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Plataforma Offline-First para Inspectores Municipales',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 48),
                Container(
                  constraints: const BoxConstraints(maxWidth: 600),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.android,
                        size: 64,
                        color: Color(0xFF3DDC84),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Descarga la App Móvil',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D2D6D),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Esta aplicación está diseñada para funcionar en terrenos sin conexión a internet mediante tecnología Offline-First con SQLite. Para probar todas sus capacidades (creación de actas, sincronización en segundo plano y TOTP), por favor instala la versión para Android.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: () {
                          // Aquí pueden poner el link de GitHub Releases al APK
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('El APK está disponible en GitHub Releases de este proyecto.'),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        icon: const Icon(Icons.download),
                        label: const Text('Descargar APK'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 48),
                const Text(
                  '© 2026 RenkaiDev - Desarrollado para el Portafolio Web',
                  style: TextStyle(color: Colors.white54),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
