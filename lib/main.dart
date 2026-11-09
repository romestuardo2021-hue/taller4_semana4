import 'package:flutter/material.dart';

void main() {
  runApp(const FormularioCorreoUAEApp());
}

// Configuración general de la aplicación
class FormularioCorreoUAEApp extends StatelessWidget {
  const FormularioCorreoUAEApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Formulario de correo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const FormularioCorreoPage(),
    );
  }
}

// Pantalla principal con estado
class FormularioCorreoPage extends StatefulWidget {
  const FormularioCorreoPage({super.key});

  @override
  State<FormularioCorreoPage> createState() => _FormularioCorreoPageState();
}

class _FormularioCorreoPageState extends State<FormularioCorreoPage> {
  // Controlador para manipular el campo de texto (reemplazo de EditText + findViewById)
  final TextEditingController _ctrl = TextEditingController();

  // Variable de estado para almacenar y mostrar el resultado
  String _resultado = '';

  // Acción que se ejecuta al presionar el botón Enviar
  void _procesarEnvio() {
    print('[EVENTO] Clic en botón Enviar');
    final String texto = _ctrl.text.trim();

    // Verificamos que el campo no esté vacío
    if (texto.isEmpty) {
      print('[ALERTA] Campo vacío');
      setState(() {
        _resultado = 'Por favor, ingresa tu correo.';
      });
      return;
    }

    print('[DATOS] Correo ingresado: $texto');

    // setState notifica a Flutter para redibujar la pantalla con el nuevo dato
    setState(() {
      _resultado = 'Correo ingresado:\n$texto';
    });
  }

  @override
  void dispose() {
    // Liberamos memoria del controlador al destruir la pantalla
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // Barra superior con título centrado
      appBar: AppBar(
        title: const Text(
          'Formulario de correo',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF1565C0),
        elevation: 0,
      ),

      // Formulario centrado horizontal y verticalmente
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Etiqueta centrada
                const Text(
                  'Ingresa tu correo',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),

                // Campo de texto centrado para correos
                TextField(
                  controller: _ctrl,
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Botón verde que ocupa el ancho del contenedor
                ElevatedButton(
                  onPressed: _procesarEnvio,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E7D32),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    'Enviar',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Resultado centrado
                if (_resultado.isNotEmpty)
                  Text(
                    _resultado,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: _resultado.startsWith('Por favor')
                          ? Colors.red.shade700
                          : const Color(0xFF0D47A1),
                      height: 1.4,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}