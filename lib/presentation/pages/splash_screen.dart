import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import '../providers/auth_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Temporizador de 1 segundo para mostrar el branding rápido
    _timer = Timer(const Duration(seconds: 1), () async {
      if (!mounted) return;
      try {
        await ref.read(authProvider.notifier).checkSessionValidity();
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString()), backgroundColor: Colors.red));
        }
      }

      if (!mounted) return;
      final estaLogueado = ref.read(authProvider);

      if (estaLogueado) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF171557), // Azul corporativo SGF_CORE
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            
            // 1. Logo Principal de la App (Fiscalis)
            Center(
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32), // Borde estilo Material 3
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  // Reemplazar este Icon por tu imagen generada:
                  child: Image.asset('assets/images/fiscalis_logo.png'),
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            // 2. Nombre de la App
            const Text(
              'FISCALIS',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 4.0,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Sistema de Gestión Operativa',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white70,
                letterSpacing: 1.2,
              ),
            ),
            
            const Spacer(),
            
            // 3. Logos Institucionales (Inferior)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Logo Municipalidad de Cauquenes
                  Column(
                    children: [
                      // Descomentar al tener el asset:
                      Image.asset('assets/images/logo_cauquenes.png', height: 50),
                      const SizedBox(height: 8),
                      const Text('I. Municipalidad', style: TextStyle(color: Colors.white54, fontSize: 10)),
                    ],
                  ),
                  
                  // Línea divisoria
                  Container(height: 40, width: 1, color: Colors.white24),
                  
                  // Logo Seguridad Pública
                  Column(
                    children: [
                      // Descomentar al tener el asset:
                      Image.asset('assets/images/logo_seguridad.png', height: 50),
                      const SizedBox(height: 8),
                      const Text('Seguridad Pública', style: TextStyle(color: Colors.white54, fontSize: 10)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}