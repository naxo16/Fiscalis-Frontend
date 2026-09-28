import 'package:flutter/services.dart';

/// OWASP Top 10: Validación y mitigación de inyección/overflow
class AppValidators {
  /// Validación oficial de RUT Chileno usando Módulo 11
  static String? validarRutChileno(String? value) {
    if (value == null || value.trim().isEmpty) return null;

    String rutClean = value.replaceAll('.', '').replaceAll('-', '').toUpperCase();
    if (rutClean.length < 2) return 'RUT inválido';

    String dv = rutClean.substring(rutClean.length - 1);
    String rutBodyStr = rutClean.substring(0, rutClean.length - 1);

    int? rutBody = int.tryParse(rutBodyStr);
    if (rutBody == null) return 'RUT inválido';

    int suma = 0;
    int multiplicador = 2;

    for (int i = rutBodyStr.length - 1; i >= 0; i--) {
      suma += int.parse(rutBodyStr[i]) * multiplicador;
      multiplicador++;
      if (multiplicador == 8) multiplicador = 2;
    }

    int resto = suma % 11;
    int digitoEsperado = 11 - resto;
    String dvEsperado = digitoEsperado == 11 ? '0' : (digitoEsperado == 10 ? 'K' : digitoEsperado.toString());

    if (dv != dvEsperado) return 'RUT incorrecto (Dígito verificador no coincide)';
    return null; // Válido
  }

  /// Sanitización de Strings para prevenir XSS/Inyecciones lógicas
  /// Aunque Drift usa parametrized queries y Flutter renderiza en Canvas (no DOM), 
  /// sanitizar en origen es una buena práctica de defensa en profundidad.
  static String sanitizeText(String input) {
    return input.replaceAll('<', '').replaceAll('>', '').replaceAll(';', '').trim();
  }
}

/// Formateador para bloquear caracteres peligrosos y longitud excesiva
class OwaspSanitizerFormatter extends TextInputFormatter {
  final int maxLength;
  OwaspSanitizerFormatter(this.maxLength);

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Evita Buffer Overflow cortando el string en el límite
    if (newValue.text.length > maxLength) {
      return oldValue;
    }
    // Remueve caracteres clave de inyección web/SQL (<, >, ;)
    String sanitized = newValue.text.replaceAll(RegExp(r'[<>;]'), '');
    return TextEditingValue(
      text: sanitized,
      selection: TextSelection.collapsed(offset: sanitized.length),
    );
  }
}
