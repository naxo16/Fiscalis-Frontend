import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MfaSetupScreen extends ConsumerStatefulWidget {
  const MfaSetupScreen({super.key});

  @override
  ConsumerState<MfaSetupScreen> createState() => _MfaSetupScreenState();
}

class _MfaSetupScreenState extends ConsumerState<MfaSetupScreen> {
  final _passwordController = TextEditingController();
  final _codeController = TextEditingController();
  
  bool _isLoading = false;
  bool _isConfirming = false;
  bool _isRevoking = false;
  bool _isRevokeMode = false;
  final bool _isDirectConfirmMode = false;
  
  String? _manualSecret;
  List<String>? _recoveryCodes;

  Future<void> _startSetup() async {
    if (_passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Debes ingresar tu contraseña reciente')),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      final data = await ref.read(authProvider.notifier).setupMfa(_passwordController.text);
      await const FlutterSecureStorage().write(key: 'mfa_temp_password', value: _passwordController.text);
      setState(() {
        _manualSecret = data['manual_secret'];
        _recoveryCodes = List<String>.from(data['recovery_codes']);
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString().replaceAll('Exception: ', ''))),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _confirmMfa() async {
    if (_codeController.text.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('El código TOTP debe tener 6 dígitos')),
      );
      return;
    }

    setState(() => _isConfirming = true);
    try {
      final success = await ref.read(authProvider.notifier).confirmMfa(_codeController.text);
      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Seguridad MFA activada exitosamente'),
            backgroundColor: Color(0xFF15813D),
          ),
        );
        ref.read(mfaStatusProvider.notifier).setEnabled(true);
        Navigator.pop(context); // Volver a Ajustes
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString().replaceAll('Exception: ', ''))),
        );
      }
    } finally {
      if (mounted) setState(() => _isConfirming = false);
    }
  }

  @override
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null && args['revoke'] == true) {
      _isRevokeMode = true;
    }
    _checkCacheAndClipboard();
  }

  Future<void> _checkCacheAndClipboard() async {
    const storage = FlutterSecureStorage();
    final cachedPwd = await storage.read(key: 'mfa_temp_password');
    if (cachedPwd != null && _manualSecret == null && !_isRevokeMode) {
      _passwordController.text = cachedPwd;
      _startSetup();
    }
    
    final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
    if (clipboardData != null && clipboardData.text != null) {
      final text = clipboardData.text!.trim();
      if (RegExp(r'^\d{6}$').hasMatch(text)) {
        if (mounted) {
          setState(() {
            _codeController.text = text;
          });
        }
      }
    }
  }

  Future<void> _revokeMfa() async {
    if (_codeController.text.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('El código TOTP debe tener 6 dígitos')));
      return;
    }
    setState(() => _isRevoking = true);
    try {
      final success = await ref.read(authProvider.notifier).revokeMfa(_codeController.text);
      if (success && mounted) {
        ref.read(mfaStatusProvider.notifier).setEnabled(false);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('MFA revocado exitosamente')));
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString().replaceAll('Exception: ', ''))));
    } finally {
      if (mounted) setState(() => _isRevoking = false);
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: const Text('Gestión de MFA', style: TextStyle(color: Color(0xFF171557))),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF171557)),
      ),
      
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: _isRevokeMode 
            ? _buildRevokeStep() 
            : (_isDirectConfirmMode || _manualSecret != null) 
                ? _buildSetupStep() 
                : _buildPasswordStep(),
      ),

    );
  }

  Widget _buildRevokeStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.warning_amber_rounded, size: 64, color: Colors.orange),
        const SizedBox(height: 24),
        const Text('Revocar MFA', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF171557))),
        const SizedBox(height: 16),
        const Text('Ingresa el código actual de tu aplicación Authy para desvincular tu dispositivo.'),
        const SizedBox(height: 24),
        TextField(
          controller: _codeController,
          keyboardType: TextInputType.number,
          maxLength: 6,
          decoration: const InputDecoration(labelText: 'Código TOTP', border: OutlineInputBorder()),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _isRevoking ? null : _revokeMfa,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 16)),
            child: _isRevoking ? const CircularProgressIndicator(color: Colors.white) : const Text('Revocar y Desvincular'),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.lock_person, size: 64, color: Color(0xFF171557)),
        const SizedBox(height: 24),
        const Text(
          'Confirmación de Identidad',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF171557)),
        ),
        const SizedBox(height: 16),
        const Text(
          'Por motivos de seguridad, ingresa tu contraseña actual para generar una nueva semilla TOTP.',
          style: TextStyle(fontSize: 16, color: Color(0xFF464650)),
        ),
        const SizedBox(height: 32),
        TextFormField(
          controller: _passwordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Contraseña',
            prefixIcon: const Icon(Icons.lock_outline),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: _isLoading ? null : _startSetup,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF171557),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: _isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text('Continuar', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }

  Widget _buildSetupStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.security, size: 64, color: Color(0xFF171557)),
        const SizedBox(height: 24),
        const Text(
          '1. Códigos de Recuperación',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF171557)),
        ),
        const SizedBox(height: 8),
        const Text(
          '¡GUARDA ESTOS CÓDIGOS! Si pierdes el teléfono o reinstalas Authy, los necesitarás para entrar. Cada código solo se puede usar una vez.',
          style: TextStyle(fontSize: 14, color: Color(0xFFBA1A1A), fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFC8C5D1))),
          child: Text(
            _recoveryCodes!.join('\n'),
            style: const TextStyle(fontFamily: 'monospace', fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 2.0),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 32),
        const Text(
          '2. Semilla Manual (Para Authy)',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF171557)),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFC8C5D1))),
          child: Column(
            children: [
              Text(
                _manualSecret ?? '',
                style: const TextStyle(fontFamily: 'monospace', fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1B1B1B), letterSpacing: 2.0),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: _manualSecret ?? ''));
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Código copiado al portapapeles')));
                },
                icon: const Icon(Icons.copy, size: 18),
                label: const Text('Copiar Semilla'),
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFF0F0F0), foregroundColor: const Color(0xFF171557), elevation: 0),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        const Text(
          '3. Confirmar Activación',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF171557)),
        ),
        const SizedBox(height: 8),
        const Text(
          'Ingresa el código actual de 6 dígitos que te entrega Authy.',
          style: TextStyle(fontSize: 14, color: Color(0xFF464650)),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _codeController,
          keyboardType: TextInputType.number,
          maxLength: 6,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 24, letterSpacing: 8, fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            hintText: '000000',
            counterText: '',
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: _isConfirming ? null : _confirmMfa,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF171557),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: _isConfirming
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text('Confirmar y Activar MFA', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }
}
