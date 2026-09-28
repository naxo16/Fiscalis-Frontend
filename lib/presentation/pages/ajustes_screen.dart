import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/main_scaffold.dart';
import '../providers/settings_provider.dart';
import '../providers/infraccion_provider.dart';
import '../providers/auth_provider.dart';

class AjustesScreen extends ConsumerStatefulWidget {
  const AjustesScreen({super.key});

  @override
  ConsumerState<AjustesScreen> createState() => _AjustesScreenState();
}

class _AjustesScreenState extends ConsumerState<AjustesScreen> {
  late TextEditingController _urlController;

  @override
  void initState() {
    super.initState();
    final currentUrl = ref.read(serverUrlProvider);
    _urlController = TextEditingController(text: currentUrl);
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pendingCountAsync = ref.watch(pendingInfraccionesCountProvider);

    return MainScaffold(
      selectedIndex: 2,
      title: 'Ajustes Técnicos',
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ajustes del Sistema',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF171557),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Configuración operativa y de desarrollo para el MVP.',
              style: TextStyle(fontFamily: 'Inter', fontSize: 14, color: Color(0xFF464650)),
            ),
            const SizedBox(height: 24),

            // Card 1: URL base
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFC8C5D1)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'URL BASE DEL SERVIDOR',
                    style: TextStyle(fontFamily: 'Inter', fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black45, letterSpacing: 1.1),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _urlController,
                    style: const TextStyle(fontFamily: 'Inter', fontSize: 16, color: Color(0xFF1B1B1B)),
                    decoration: InputDecoration(
                      hintText: 'Ej: http://localhost:8000',
                      hintStyle: const TextStyle(color: Colors.black38),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFC8C5D1))),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFC8C5D1))),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF171557))),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        final newUrl = _urlController.text.trim();
                        ref.read(serverUrlProvider.notifier).setServerUrl(newUrl);
                        FocusScope.of(context).unfocus(); // Oculta el teclado
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Configuración aplicada exitosamente')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF171557),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Aplicar', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Card 2: Estado de Sincronización
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFC8C5D1)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'ESTADO DE SINCRONIZACIÓN LOCAL',
                    style: TextStyle(fontFamily: 'Inter', fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black45, letterSpacing: 1.1),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Actas Pendientes:',
                        style: TextStyle(fontFamily: 'Inter', fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF1B1B1B)),
                      ),
                      pendingCountAsync.when(
                        data: (count) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: count > 0 ? const Color(0xFFEEE925).withValues(alpha: 0.2) : const Color(0xFF15813D).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '$count actas',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: count > 0 ? const Color(0xFF171557) : const Color(0xFF15813D),
                            ),
                          ),
                        ),
                        loading: () => const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)),
                        error: (err, _) => Text('Error: $err', style: const TextStyle(color: Color(0xFFBA1A1A))),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Card 3: Seguridad de la Cuenta
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFC8C5D1)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'SEGURIDAD DE LA CUENTA',
                    style: TextStyle(fontFamily: 'Inter', fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black45, letterSpacing: 1.1),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Protege tu cuenta institucional con un segundo factor de autenticación (TOTP).',
                    style: TextStyle(fontFamily: 'Inter', fontSize: 14, color: Color(0xFF464650)),
                  ),
                  const SizedBox(height: 16),
                                    Consumer(
                    builder: (context, ref, _) {
                      final isMfaEnabled = ref.watch(mfaStatusProvider);
                      return SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            if (isMfaEnabled) {
                                // Navigator or dialog to revoke
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Revocar MFA'),
                                    content: const Text('¿Estás seguro de que deseas revocar el MFA? Deberás configurarlo de nuevo en el próximo inicio de sesión.'),
                                    actions: [
                                      TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.pushNamed(context, '/mfa_setup', arguments: {'revoke': true});
                                        },
                                        child: const Text('Revocar', style: TextStyle(color: Colors.red)),
                                      ),
                                    ],
                                  ),
                                );
                            } else {
                                Navigator.pushNamed(context, '/mfa_setup');
                            }
                          },
                          icon: Icon(isMfaEnabled ? Icons.verified_user : Icons.security),
                          label: Text(isMfaEnabled ? 'MFA Activado (Revocar)' : 'Activar Autenticación MFA', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isMfaEnabled ? const Color(0xFFBA1A1A) : const Color(0xFF15813D),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      );
                    },
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
