# ALCANCE DERA SINTETIZADO - FISCALIS MOBILE

## 1. Contexto Institucional
- [cite_start]**Institución:** Ilustre Municipalidad de Cauquenes 
- [cite_start]**Unidad:** Dirección de Seguridad Pública [cite: 5]
- [cite_start]**Objetivo:** Sustituir la fiscalización vehicular manual en papel por un registro digital robusto[cite: 7, 8].

## 2. Alcance Limitado de la Primera Etapa (MVP Local)
Para efectos del hito de entrega del 24 de junio, la aplicación operará en entorno LOCAL de pruebas y se enfocará ÚNICAMENTE en:
- [cite_start]**Módulo Core:** Fiscalización Vehicular Exclusiva[cite: 63].
- [cite_start]**Tipos de Infracción soportados:** Advertencia y Citación[cite: 64, 65, 66].
- [cite_start]**Flujo Operacional Mandatorio:** 1. Inicio de sesión institucional mediante Autenticación Stateless JWT real transmitida sobre canal IP local.
  2. [cite_start]Registro de datos del vehículo (PPU, Marca, Tipo)[cite: 12].
  3. [cite_start]Captura fotográfica con cálculo de Hash SHA-256 inmutable[cite: 13, 53].
  4. [cite_start]Captura automática de coordenadas GPS[cite: 14, 71].
  5. [cite_start]Almacenamiento local cifrado (Offline-First)[cite: 15, 17, 50].
  6. [cite_start]Historial básico del turno local.

## 3. Exclusiones Absolutas (FUERA DE ALCANCE ACTUAL)
Queda estrictamente prohibido que la IA sugiera, cree código o configure archivos para:
- Módulos de Comercio, Memorándums, Eventos o Registro de Actividades Generales.
- [cite_start]Generación de archivos PDF en el celular o Firma Electrónica Avanzada[cite: 77, 78].
- [cite_start]Visualización de mapas avanzados o analíticas de Dashboards[cite: 76, 79, 80].
- [cite_start]Interoperabilidad en tiempo real con Juzgados de Policía Local (JPL)[cite: 82].