# Reglas de Arquitectura, Estado, Seguridad y UI/UX - Fiscalis

Este documento detalla la arquitectura, el flujo de estado, los esquemas de seguridad y las reglas de diseño detectadas mediante ingeniería inversa de la aplicación Flutter **Fiscalis**.

---

## 1. Arquitectura de la Aplicación

La aplicación implementa una arquitectura basada en principios de **Clean Architecture** estructurada en las siguientes capas bajo el directorio `lib/`:

*   **`lib/domain/`**: Capa de negocio pura (independiente de librerías externas).
    *   **Entities**: Modelos de datos del dominio (ej. [Infraccion](file:///C:/Sistema_Fiscalizacion_Municipal/sgf_mobile/lib/domain/entities/infraccion.dart)).
    *   **Repositories**: Definición de contratos/interfaces (ej. [IInfraccionRepository](file:///C:/Sistema_Fiscalizacion_Municipal/sgf_mobile/lib/domain/repositories/i_infraccion_repository.dart)).
*   **`lib/data/`**: Capa de infraestructura y persistencia.
    *   **Datasources**: Conexión con base de datos local Drift (ej. [AppDatabase](file:///C:/Sistema_Fiscalizacion_Municipal/sgf_mobile/lib/data/datasources/local/database.dart)).
    *   **Models**: Adaptadores de datos que heredan de las entidades del dominio e implementan serialización JSON o mapeos de base de datos (ej. [InfraccionModel](file:///C:/Sistema_Fiscalizacion_Municipal/sgf_mobile/lib/data/models/infraccion_model.dart)).
    *   **Repositories**: Implementaciones concretas de las interfaces del dominio (ej. [InfraccionRepositoryImpl](file:///C:/Sistema_Fiscalizacion_Municipal/sgf_mobile/lib/data/repositories/infraccion_repository_impl.dart)).
    *   **Services**: Servicios específicos para geolocalización, cámara y sincronización (ej. [LocationService](file:///C:/Sistema_Fiscalizacion_Municipal/sgf_mobile/lib/data/services/location_service.dart), [ImageService](file:///C:/Sistema_Fiscalizacion_Municipal/sgf_mobile/lib/data/services/image_service.dart), y [SyncService](file:///C:/Sistema_Fiscalizacion_Municipal/sgf_mobile/lib/data/services/sync_service.dart)).
*   **`lib/presentation/`**: Capa de interfaz de usuario.
    *   **Pages**: Pantallas y vistas de la aplicación (ej. [NuevaInfraccionScreen](file:///C:/Sistema_Fiscalizacion_Municipal/sgf_mobile/lib/presentation/pages/nueva_infraccion_screen.dart)).
    *   **Providers**: Estado reactivo gestionado con Riverpod (ej. [formulario_provider.dart](file:///C:/Sistema_Fiscalizacion_Municipal/sgf_mobile/lib/presentation/providers/formulario_provider.dart)).
    *   **Widgets**: Componentes compartidos e inyectables (ej. [MainScaffold](file:///C:/Sistema_Fiscalizacion_Municipal/sgf_mobile/lib/presentation/widgets/main_scaffold.dart)).

---

## 2. Gestión de Estado (Riverpod)

El estado reactivo se maneja a través de **Riverpod** (`flutter_riverpod: ^2.5.1`). La raíz de la aplicación en [main.dart](file:///C:/Sistema_Fiscalizacion_Municipal/sgf_mobile/lib/main.dart) se encuentra envuelta en un `ProviderScope`.

### Proveedores Clave Detectados:
1.  **`authProvider`** (`StateNotifierProvider<AuthNotifier, bool>`):
    *   Gestiona el estado de autenticación (sesión activa/inactiva).
    *   Lugar: [auth_provider.dart](file:///C:/Sistema_Fiscalizacion_Municipal/sgf_mobile/lib/presentation/providers/auth_provider.dart).
2.  **`formularioInfraccionProvider`** (`StateNotifierProvider<FormularioInfraccionNotifier, FormularioState>`):
    *   Mantiene los datos en memoria del formulario actual: `latitud`, `longitud`, `fotosConHash` y un booleano `isLoading`.
    *   Lugar: [formulario_provider.dart](file:///C:/Sistema_Fiscalizacion_Municipal/sgf_mobile/lib/presentation/providers/formulario_provider.dart).
3.  **`infraccionesStreamProvider`** (`StreamProvider<List<Infraccion>>`):
    *   Escucha reactivamente las filas de la tabla de base de datos a través de Drift (`watchInfracciones()`).
    *   Lugar: [infraccion_provider.dart](file:///C:/Sistema_Fiscalizacion_Municipal/sgf_mobile/lib/presentation/providers/infraccion_provider.dart).
4.  **`infraccionRepositoryProvider`** y **`syncServiceProvider`**:
    *   Proveedores de lectura (`Provider`) que inyectan dependencias de infraestructura como `AppDatabase` y `Dio`.
5.  **`locationServiceProvider`** e **`imageServiceProvider`**:
    *   Proveedores de solo lectura para los servicios nativos del dispositivo.

> [!WARNING]
> **Duplicación de Provider en el Estado:**
> Se detectaron dos declaraciones independientes del proveedor de base de datos `databaseProvider` en diferentes archivos:
> *   En `lib/presentation/providers/infraccion_provider.dart` (`final databaseProvider = Provider<AppDatabase>((ref) { ... ref.onDispose(() => db.close()); ... });`).
> *   En `lib/presentation/providers/formulario_provider.dart` (`final databaseProvider = Provider((ref) => AppDatabase());`).
> Esto rompe el principio de instancia única (Singleton) y causa que existan dos instancias y conexiones activas a la base de datos simultáneamente.

---

## 3. Seguridad de Datos

La persistencia segura local de los datos de fiscalización está estructurada bajo las siguientes reglas:

*   **Cifrado de Base de Datos Local**:
    *   La base de datos SQLite gestionada por Drift utiliza soporte nativo para **SQLCipher** mediante la dependencia `sqlcipher_flutter_libs: ^0.7.0+eol`.
    *   **Estado de Clave de Cifrado**: Actualmente se encuentra en simulación para pruebas en desarrollo. En el archivo [database.dart](file:///C:/Sistema_Fiscalizacion_Municipal/sgf_mobile/lib/data/datasources/local/database.dart#L61) se ejecuta la sentencia PRAGMA directamente sobre la conexión SQLite:
        ```dart
        db.execute("PRAGMA key = 'temp_ram_key';");
        ```
    *   La contraseña simétrica utilizada temporalmente en el código es `'temp_ram_key'`.
*   **Integridad de Archivos de Evidencia**:
    *   Cada fotografía capturada a través del `ImagePicker` se almacena físicamente en el directorio seguro de la app (`getApplicationDocumentsDirectory/fotos_infracciones`).
    *   Se calcula de manera inmediata un **hash SHA-256** del archivo (`sha256.convert(bytes)`) antes de registrarlo en la base de datos, garantizando la no-repudiación y consistencia de las pruebas fotográficas según normativa.

---

## 4. Reglas e Identidad UI/UX

La interfaz de usuario sigue las directrices visuales de Material 3 (`useMaterial3: true`), adaptada con la tipografía oficial **Inter** y una paleta de colores municipal.

### 4.1. Paleta de Colores
Se detectó una discrepancia menor entre los colores declarados en la paleta global y los locales de las pantallas:

| Elemento / Nombre | Color en main.dart (Global) | Color en Pantallas / Widgets (Local) |
| :--- | :--- | :--- |
| **Primary (Azul Marino)** | `0xFF2D2D6D` | `0xFF171557` |
| **Secondary (Amarillo)** | `0xFFEEE926` | `0xFFEEE925` |
| **Tertiary (Verde)** | `0xFF15813D` | (No declarado de forma local) |
| **Background (Fondo)** | `Colors.white` / `surface` | `0xFFF9F9F9` |
| **Error (Rojo)** | `0xFFBA1A1A` | `0xFFBA1A1A` |
| **Outline Variant (Bordes)** | - | `0xFFC8C5D1` |
| **Surface Container Low** | - | `0xFFF3F3F3` |
| **On Surface Variant (Gris)** | - | `0xFF464650` |
| **On Secondary Container** | - | `0xFF6A6700` |
| **Offline Warning Banner** | - | `0xFFE8E8E8` (Fondo) / `0xFF636100` (Texto/Icono) |

### 4.2. Escalado de Texto (`TextScaler`)
*   **Estado Actual**: **NO IMPLEMENTADO**. No existe ninguna configuración global en el `MaterialApp` de `main.dart` ni configuraciones de `MediaQuery.copyWith` locales para forzar o limitar el factor de escala de texto. La aplicación responde al tamaño predeterminado del sistema operativo sin restricciones.

### 4.3. Estructura del Scaffold Global
El Scaffold principal está centralizado en el widget reusable [MainScaffold](file:///C:/Sistema_Fiscalizacion_Municipal/sgf_mobile/lib/presentation/widgets/main_scaffold.dart):

*   **AppBar**:
    *   Fondo azul marino (`0xFF171557`). Iconos en blanco.
    *   Título centrado utilizando la tipografía `Inter` (w700, 20px).
    *   Acción a la derecha: Botón de actualización (`Icons.sync`) para forzar sincronización de actas pendientes.
*   **Drawer Lateral (Hamburguesa)**:
    *   Encabezado con fondo azul marino (`0xFF171557`) que incluye el logotipo del escudo en blanco (`Icons.shield`), nombre `Fiscalis` y subtítulo "Inspector Municipal".
    *   Opciones principales: "Mi Perfil" e "Estado de Red" (enlazados a `Navigator.pop`).
    *   Opción destructiva: "Cerrar Turno Seguro" (color rojo `0xFFBA1A1A`).
*   **Bottom Navigation Bar**:
    *   Barra de navegación de 3 pestañas:
        *   **Nuevo** (Ruta: `/home`, Icono: `Icons.add_circle`)
        *   **Historial** (Ruta: `/historial`, Icono: `Icons.history`)
        *   **Ajustes** (Ruta: `/ajustes`, Icono: `Icons.settings`)
    *   *Nota*: El ítem activo se resalta con un contenedor con fondo amarillo (`0xFFEEE925`) y el texto/icono cambia a azul marino (`0xFF171557`). Los ítems inactivos usan gris (`0xFF464650`).
    *   **Área de Acción Dinámica (`bottomActionArea`)**: Inyecta widgets condicionales directamente sobre la barra de navegación (usado en la creación de infracciones para añadir el banner de advertencia offline y el botón "Guardar Infracción").
    *   **Footer Institucional**: Muestra en la parte superior de los botones la etiqueta `"Fiscalis v1.0.0 • Desarrollado por Renkai"` en tipografía `Inter` (peso 500, tamaño 11, color gris `0xFF777681`).

> [!CAUTION]
> **Ruta Inexistente en la Navegación:**
> El botón de la pestaña **Ajustes** del `BottomNavigationBar` redirige a la ruta `/ajustes` en `Navigator.pushReplacementNamed`, pero dicha ruta **no está registrada** en el mapa de rutas de `MaterialApp` en `lib/main.dart`. Al presionarla, la aplicación lanzará una excepción y sufrirá una caída en tiempo de ejecución.
