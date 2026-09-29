import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'presentation/pages/historial_infracciones_screen.dart';
import 'presentation/pages/nueva_infraccion_screen.dart'; 
import 'presentation/pages/splash_screen.dart';
import 'presentation/pages/login_screen.dart';
import 'presentation/pages/ajustes_screen.dart';
import 'presentation/pages/mfa_verification_screen.dart';
import 'presentation/pages/session_lock_screen.dart';
import 'presentation/pages/mfa_setup_screen.dart';
import 'presentation/pages/web_landing_screen.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

final GlobalKey<NavigatorState> globalNavigatorKey = GlobalKey<NavigatorState>();

void main() {
  // ProviderScope es obligatorio para usar Riverpod
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: globalNavigatorKey,
      title: 'Fiscalis',
      initialRoute: '/',
      routes: {
        '/': (context) => kIsWeb ? const WebLandingScreen() : const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/mfa_verify': (context) => const MfaVerificationScreen(),
        '/mfa_setup': (context) => const MfaSetupScreen(),
        '/home': (context) => const NuevaInfraccionScreen(),
        '/historial': (context) => const HistorialInfraccionesScreen(),
        '/ajustes': (context) => const AjustesScreen(),
      },
      builder: (context, child) {
        return SessionLockScreen(
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: TextScaler.noScaling,
            ),
            child: child!,
          ),
        );
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        // Definimos la paleta oficial de SGF_CORE
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xFF2D2D6D),      // Azul Marino
          onPrimary: Color(0xFFFFFFFF),    // Blanco
          secondary: Color(0xFFEEE926),    // Amarillo
          onSecondary: Color(0xFF000000),  // Negro
          tertiary: Color(0xFF15813D),     // Verde
          onTertiary: Color(0xFFFFFFFF),   // Blanco
          surface: Color(0xFFFFFFFF),      // Blanco
          onSurface: Color(0xFF000000),    // Negro
          error: Color(0xFFBA1A1A),        // Rojo error estándar
          onError: Color(0xFFFFFFFF),
          surfaceContainerHigh: Color(0xFFF0F0F0), // Gris para banner offline
        ),
      ),
    );
  }
}