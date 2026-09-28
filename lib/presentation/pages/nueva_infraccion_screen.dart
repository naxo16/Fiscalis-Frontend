import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/formulario_provider.dart';
import '../providers/settings_provider.dart';
import '../widgets/main_scaffold.dart';
import '../utils/formatters.dart';
import '../utils/validators.dart';
class NuevaInfraccionScreen extends ConsumerStatefulWidget {
  const NuevaInfraccionScreen({super.key});

  @override
  ConsumerState<NuevaInfraccionScreen> createState() => _NuevaInfraccionScreenState();
}

class _NuevaInfraccionScreenState extends ConsumerState<NuevaInfraccionScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Controladores
  late TextEditingController _nombreController;
  late TextEditingController _rutController;
  late TextEditingController _ppuController;
  late TextEditingController _tipoController;
  late TextEditingController _marcaController;
  late TextEditingController _colorController;
  late TextEditingController _descripcionController;
  late TextEditingController _tipoInfraccionController; // <-- NUEVO

  bool _firmaRechazo = false;

  // Paleta de colores Tailwind extraída de tu HTML
  final Color _cBackground = const Color(0xFFF9F9F9);
  final Color _cPrimary = const Color(0xFF171557);
  final Color _cPrimaryContainer = const Color(0xFF2D2D6D);
  final Color _cOnPrimary = const Color(0xFFFFFFFF);
  final Color _cSurface = const Color(0xFFFFFFFF);
  final Color _cSurfaceContainerLow = const Color(0xFFF3F3F3);
  final Color _cOutlineVariant = const Color(0xFFC8C5D1);
  final Color _cOnSurface = const Color(0xFF1B1B1B);
  final Color _cOnSurfaceVariant = const Color(0xFF464650);
  final Color _cSecondaryContainer = const Color(0xFFEEE925);
  final Color _cOnSecondaryContainer = const Color(0xFF6A6700);
  final Color _cError = const Color(0xFFBA1A1A);

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController();
    _rutController = TextEditingController();
    _ppuController = TextEditingController();
    _tipoController = TextEditingController();
    _marcaController = TextEditingController();
    _colorController = TextEditingController();
    _descripcionController = TextEditingController();
    _tipoInfraccionController = TextEditingController();

    _loadDraft();

    _nombreController.addListener(_saveDraft);
    _rutController.addListener(_saveDraft);
    _ppuController.addListener(_saveDraft);
    _tipoController.addListener(_saveDraft);
    _marcaController.addListener(_saveDraft);
    _colorController.addListener(_saveDraft);
    _descripcionController.addListener(_saveDraft);
    _tipoInfraccionController.addListener(_saveDraft);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(formularioInfraccionProvider.notifier).recuperarFotoPerdida();
    });
  }

  Future<void> _loadDraft() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      _nombreController.text = prefs.getString('draft_nombre') ?? '';
      _rutController.text = prefs.getString('draft_rut') ?? '';
      _ppuController.text = prefs.getString('draft_ppu') ?? '';
      _tipoController.text = prefs.getString('draft_tipo') ?? '';
      _marcaController.text = prefs.getString('draft_marca') ?? '';
      _colorController.text = prefs.getString('draft_color') ?? '';
      _descripcionController.text = prefs.getString('draft_desc') ?? '';
      _tipoInfraccionController.text = prefs.getString('draft_tipoinf') ?? '';
      _firmaRechazo = prefs.getBool('draft_firma') ?? false;
    });
  }

  Future<void> _saveDraft() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('draft_nombre', _nombreController.text);
    await prefs.setString('draft_rut', _rutController.text);
    await prefs.setString('draft_ppu', _ppuController.text);
    await prefs.setString('draft_tipo', _tipoController.text);
    await prefs.setString('draft_marca', _marcaController.text);
    await prefs.setString('draft_color', _colorController.text);
    await prefs.setString('draft_desc', _descripcionController.text);
    await prefs.setString('draft_tipoinf', _tipoInfraccionController.text);
    await prefs.setBool('draft_firma', _firmaRechazo);
  }

  Future<void> _clearDraft() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('draft_nombre');
    await prefs.remove('draft_rut');
    await prefs.remove('draft_ppu');
    await prefs.remove('draft_tipo');
    await prefs.remove('draft_marca');
    await prefs.remove('draft_color');
    await prefs.remove('draft_desc');
    await prefs.remove('draft_tipoinf');
    await prefs.remove('draft_firma');
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _rutController.dispose();
    _ppuController.dispose();
    _tipoController.dispose();
    _marcaController.dispose();
    _colorController.dispose();
    _descripcionController.dispose();
    _tipoInfraccionController.dispose(); // <-- NUEVO
    super.dispose();
  }

  void _guardar() async {
    if (_formKey.currentState!.validate()) {
      if (_rutController.text.isNotEmpty) {
        final rutError = AppValidators.validarRutChileno(_rutController.text);
        if (rutError != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(rutError)));
          return;
        }
      }

      try {
        final cleanRut = _rutController.text.isNotEmpty 
            ? _rutController.text.replaceAll('.', '').trim() 
            : null;
        final cleanPpu = _ppuController.text.trim();
        final int tipoId = _tipoInfraccionController.text.toLowerCase() == 'citación' ? 2 : 1;

        await ref.read(formularioInfraccionProvider.notifier).guardarActa(
          nombreInfractor: _nombreController.text.isNotEmpty ? _nombreController.text : null,
          rutInfractor: cleanRut,
          ppu: cleanPpu,
          tipoVehiculo: _tipoController.text,
          marcaVehiculo: _marcaController.text,
          colorVehiculo: _colorController.text,
          tipoInfraccionId: tipoId,
          observaciones: _descripcionController.text.trim(),
          firmaRechazo: _firmaRechazo,
        );
        
        await _clearDraft();

        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Infracción Guardada (Modo Offline)')),
        );
        // Navegar al historial
        // Navigator.pushReplacementNamed(context, '/historial');
      } catch (e) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: _cError),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final formState = ref.watch(formularioInfraccionProvider);

    return MainScaffold(
      selectedIndex: 0,
      title: 'Fiscalis',
      body: Stack(
        children: [
          // Marca de Agua (Escudo)
          Positioned.fill(
            child: Opacity(
              opacity: 0.05,
              child: Image.asset(
                'assets/images/fiscalis_logo.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          
          // Contenido Principal Scrollable
          SingleChildScrollView(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Títulos
                Text(
                  'Nueva Infracción',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: _cPrimary,
                    letterSpacing: -0.01,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Complete el formulario para registrar un nuevo incidente.',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    color: _cOnSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 16),

                // Contenedor del Formulario
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _cSurface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: _cOutlineVariant),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 4, offset: const Offset(0, 2)),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInputGroup('Nombre (Opcional)', _buildTextField(_nombreController, 'Nombre completo del infractor')),
                        const SizedBox(height: 16),
                        _buildInputGroup('RUT (Opcional)', _buildTextField(_rutController, 'Ej: 12.345.678-9', inputFormatters: [RutFormatter()], maxLength: 12)),
                        const SizedBox(height: 16),
                        _buildInputGroup('PPU', _buildPpuRow()),
                        const SizedBox(height: 16),
                        _buildInputGroup('Tipo de Infracción', _buildAutocomplete(_tipoInfraccionController, ['Advertencia', 'Citación'])),
                        const SizedBox(height: 16),
                        _buildInputGroup('Tipo de Vehículo', _buildAutocomplete(_tipoController, ['Automóvil', 'Camioneta', 'Motocicleta', 'Furgón', 'Camión'])),
                        const SizedBox(height: 16),
                        _buildInputGroup('Marca', _buildAutocomplete(_marcaController, ['Chevrolet', 'Toyota', 'Nissan', 'Hyundai', 'Kia'])),
                        const SizedBox(height: 16),
                        _buildInputGroup('Color', _buildAutocomplete(_colorController, ['Blanco', 'Negro', 'Gris', 'Rojo', 'Azul'])),
                        const SizedBox(height: 16),
                        
                        // Ubicación GPS
                        _buildInputGroup('Ubicación', _buildUbicacionBox(formState)),
                        const SizedBox(height: 16),
                        _buildInputGroup(
                          'Observaciones',
                          _buildTextField(_descripcionController, 'Escriba los detalles de la infracción aquí...', maxLines: 4, maxLength: 500),
                        ),const SizedBox(height: 16),
                        
                        // Evidencia Fotográfica
                        _buildInputGroup('Evidencia Fotográfica', _buildEvidenciaRow(formState)),
                        const SizedBox(height: 16),
                        
                        // Firma Rechazo
                        Row(
                          children: [
                            SizedBox(
                              height: 24,
                              width: 24,
                              child: Checkbox(
                                value: _firmaRechazo,
                                activeColor: _cPrimary,
                                side: BorderSide(color: _cOutlineVariant),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                onChanged: (val) {
                                  setState(() => _firmaRechazo = val ?? false);
                                  _saveDraft();
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Firma Rechazo',
                              style: TextStyle(fontFamily: 'Inter', fontSize: 16, color: _cOnSurface),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
      bottomActionArea: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Consumer(
            builder: (context, ref, child) {
              final currentUrl = ref.watch(serverUrlProvider);
              final isOnlineConfigured = currentUrl.isNotEmpty && !currentUrl.contains('localhost');
              
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  color: isOnlineConfigured ? const Color(0xFFE8F5E9) : const Color(0xFFE8E8E8),
                  border: Border(bottom: BorderSide(color: _cOutlineVariant)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      isOnlineConfigured ? Icons.cloud_done : Icons.cloud_off, 
                      color: isOnlineConfigured ? const Color(0xFF15813D) : const Color(0xFF636100), 
                      size: 18
                    ),
                    const SizedBox(width: 8),
                    Text(
                      isOnlineConfigured ? 'Servidor configurado (Guardado local)' : 'Modo Offline: Los datos se guardarán localmente', 
                      style: TextStyle(fontFamily: 'Inter', fontSize: 14, fontWeight: FontWeight.w600, color: _cOnSurfaceVariant),
                    ),
                  ],
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: (formState.latitud == null || formState.fotosConHash.isEmpty) ? null : _guardar,
                icon: Icon(Icons.save, color: _cOnPrimary),
                label: const FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text('Guardar Infracción', style: TextStyle(fontFamily: 'Inter', fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white)),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _cPrimary,
                  disabledBackgroundColor: _cPrimary.withValues(alpha: 0.5),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  elevation: 2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGETS AUXILIARES PARA EL FORMULARIO ---

  Widget _buildInputGroup(String label, Widget input) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontFamily: 'Inter', fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.05, color: _cOnSurface),
        ),
        const SizedBox(height: 4),
        input,
      ],
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, {int maxLines = 1, bool isRequired = false, List<TextInputFormatter>? inputFormatters, int maxLength = 50}) {
    final formatters = <TextInputFormatter>[
      OwaspSanitizerFormatter(maxLength),
      if (inputFormatters != null) ...inputFormatters,
    ];

    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      style: TextStyle(fontFamily: 'Inter', fontSize: 16, color: _cOnSurface),
      validator: isRequired ? (val) => val == null || val.isEmpty ? 'Requerido' : null : null,
      inputFormatters: formatters,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.black38),
        filled: true,
        fillColor: _cSurface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: _cOutlineVariant)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: _cOutlineVariant)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: _cPrimary)),
      ),
    );
  }

  Widget _buildPpuRow() {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: _ppuController,
            textCapitalization: TextCapitalization.characters,
            inputFormatters: [OwaspSanitizerFormatter(8), PpuFormatter()],
            style: TextStyle(fontFamily: 'Inter', fontSize: 16, color: _cOnSurface),
            validator: (val) => val == null || val.isEmpty ? 'Requerido' : null,
            decoration: InputDecoration(
              hintText: 'AAAA12',
              hintStyle: const TextStyle(color: Colors.black38),
              filled: true,
              fillColor: _cSurface,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: _cOutlineVariant)),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: _cOutlineVariant)),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: _cPrimary)),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.search, color: Colors.white, size: 20),
            label: const FittedBox(
              fit: BoxFit.scaleDown,
              child: Text('Buscar PPU'),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF171557),
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          height: 48,
          child: ElevatedButton(
            onPressed: () => setState(() => _ppuController.text = 'S/P'),
            style: ElevatedButton.styleFrom(
              backgroundColor: _cSecondaryContainer,
              foregroundColor: _cOnSecondaryContainer,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 0,
            ),
            child: const Text('SP', style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }

  Widget _buildAutocomplete(TextEditingController controller, List<String> suggestions) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue value) {
        if (value.text.isEmpty) return const Iterable<String>.empty();
        return suggestions.where((s) => s.toLowerCase().contains(value.text.toLowerCase()));
      },
      onSelected: (val) => controller.text = val,
      fieldViewBuilder: (context, textController, focusNode, onFieldSubmitted) {
        textController.text = controller.text;
        textController.addListener(() => controller.text = textController.text);
        return TextFormField(
          controller: textController,
          focusNode: focusNode,
          style: TextStyle(fontFamily: 'Inter', fontSize: 16, color: _cOnSurface),
          validator: (val) => val == null || val.isEmpty ? 'Requerido' : null,
          decoration: InputDecoration(
            hintText: 'Seleccione o escriba...',
            hintStyle: const TextStyle(color: Colors.black38),
            filled: true,
            fillColor: _cSurface,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: _cOutlineVariant)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: _cOutlineVariant)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: _cPrimary)),
          ),
        );
      },
    );
  }

  Widget _buildUbicacionBox(FormularioState formState) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _cSurfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF777681), width: 1), // Borde sólido en reemplazo del dashed web
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.location_on, color: _cOnSurfaceVariant, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  formState.latitud != null 
                    ? 'Lat: ${formState.latitud?.toStringAsFixed(3)} • Lng: ${formState.longitud?.toStringAsFixed(3)}'
                    : 'Sin coordenadas capturadas',
                  style: TextStyle(fontFamily: 'Inter', fontSize: 14, color: _cOnSurfaceVariant),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton.icon(
              onPressed: formState.isLoading ? null : () => ref.read(formularioInfraccionProvider.notifier).capturarGPS(),
              icon: formState.isLoading 
                  ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                  : Icon(Icons.my_location, color: _cOnPrimary),
              label: Text(
                'Obtener Ubicación GPS',
                style: TextStyle(fontFamily: 'Inter', fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.05, color: _cOnPrimary),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: _cPrimary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEvidenciaRow(FormularioState formState) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Botón Tomar Foto
        GestureDetector(
          onTap: () => ref.read(formularioInfraccionProvider.notifier).tomarFotografia(),
          child: Container(
            height: 100,
            width: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _cPrimary, width: 2), // Borde sólido simulando el dashed
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.photo_camera, color: _cPrimary),
                const SizedBox(height: 4),
                Text(
                  'Tomar\nFotografía',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: 'Inter', fontSize: 12, color: _cPrimary, height: 1.1),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 16),
        
        // Miniaturas
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: formState.fotosConHash.map((foto) {
                final hashShort = foto['hash']!.substring(0, 8);
                return Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Column(
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          color: const Color(0xFFDADADA), // surface-dim
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: _cOutlineVariant),
                          image: foto['path'] != null
                              ? DecorationImage(
                                  image: FileImage(File(foto['path']!)),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: Stack(
                          children: [
                            if (foto['path'] == null)
                              const Center(child: Icon(Icons.image, color: Color(0xFF777681))),
                            Positioned(
                              top: 4,
                              right: 4,
                              child: GestureDetector(
                                onTap: () {
                                  if (foto['path'] != null) {
                                    ref.read(formularioInfraccionProvider.notifier).eliminarFotografia(foto['path']!);
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(color: _cSurface, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 2)]),
                                  child: Icon(Icons.close, size: 16, color: _cError),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        hashShort,
                        style: TextStyle(fontFamily: 'monospace', fontSize: 10, fontWeight: FontWeight.w500, color: _cOnSurfaceVariant),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavTab(IconData icon, String label, {required bool isActive}) {
    return GestureDetector(
      onTap: () {
        // TODO: Rutas de navegación (ej: Navigator.pushReplacementNamed)
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: isActive ? _cSecondaryContainer : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: isActive ? _cPrimary : _cOnSurfaceVariant),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isActive ? _cPrimary : _cOnSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}