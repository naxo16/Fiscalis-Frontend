import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import '../../main.dart';

class SessionLockScreen extends ConsumerStatefulWidget {
  final Widget child;

  const SessionLockScreen({super.key, required this.child});

  @override
  ConsumerState<SessionLockScreen> createState() => _SessionLockScreenState();
}

class _SessionLockScreenState extends ConsumerState<SessionLockScreen> with WidgetsBindingObserver {
  bool _isLocked = false;
  bool _isAuthenticating = false;
  final _codeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // Verificar sesión al inicio si ya estamos autenticados (opcional, normalmente lo hace el authProvider)
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _codeController.dispose();
    super.dispose();
  }

  DateTime? _pausedTime;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      final isAuthenticated = ref.read(authProvider);
      final isMfaEnabled = ref.read(mfaStatusProvider);
      if (isAuthenticated && isMfaEnabled) {
        if (!_isLocked) {
          _pausedTime = DateTime.now();
          setState(() {
            _isLocked = true;
          });
          _codeController.clear();
        }
      }
    } else if (state == AppLifecycleState.resumed) {
      if (_isLocked && !_isAuthenticating) {
        if (_pausedTime != null) {
          final diff = DateTime.now().difference(_pausedTime!);
          if (diff.inSeconds < 60) {
            // Grace period de 60 segundos para permitir cambiar entre apps rápido
            setState(() {
              _isLocked = false;
            });
            _pausedTime = null;
            return;
          }
        }
        // Si superó los 60 segundos, se queda bloqueado. No se valida automáticamente.
      }
    }
  }

  Future<void> _unlock() async {
    final code = _codeController.text;
    if (code.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Ingrese el código de 6 dígitos')));
      return;
    }

    setState(() {
      _isAuthenticating = true;
    });

    final success = await ref.read(authProvider.notifier).validateMfa(code);

    if (mounted) {
      if (success) {
        setState(() {
          _isLocked = false;
          _isAuthenticating = false;
          _pausedTime = null;
        });
      } else {
        setState(() {
          _isAuthenticating = false;
        });
        // Si cancela, no lo deslogueamos automáticamente para no arruinar la experiencia,
        // simplemente lo dejamos en la pantalla de bloqueo para que intente de nuevo.
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLocked) {
      return Scaffold(
        backgroundColor: const Color(0xFF171557),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.lock_outline, size: 80, color: Colors.white),
              const SizedBox(height: 24),
              const Text(
                'Sesión Bloqueada',
                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                'Ingrese su código TOTP de Authy para continuar.',
                style: TextStyle(color: Colors.white70),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              if (_isAuthenticating)
                const CircularProgressIndicator(color: Colors.white)
              else
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 48),
                      child: TextField(
                        controller: _codeController,
                        keyboardType: TextInputType.number,
                        maxLength: 6,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white, fontSize: 24, letterSpacing: 8),
                        decoration: const InputDecoration(
                          hintText: '000000',
                          hintStyle: TextStyle(color: Colors.white38),
                          counterText: '',
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white54)),
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: _unlock,
                      icon: const Icon(Icons.security),
                      label: const Text('Verificar Código'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF171557),
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 24),
              TextButton(
                onPressed: () async {
                  await ref.read(authProvider.notifier).logout();
                  if (context.mounted) {
                    globalNavigatorKey.currentState?.pushNamedAndRemoveUntil('/login', (route) => false);
                  }
                },
                child: const Text('Cerrar Sesión', style: TextStyle(color: Colors.white54)),
              ),
            ],
          ),
        ),
      );
    }

    return widget.child;
  }
}
