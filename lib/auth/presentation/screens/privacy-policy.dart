import 'package:alquilafacil/public/ui/theme/main_theme.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Política de Privacidad",
          style: TextStyle(fontSize: 20)
        ),
      ),
      backgroundColor: MainTheme.primary(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSection(
                title: "1. Introducción",
                content: "En AlquilaFácil, valoramos su privacidad y estamos comprometidos a proteger su información personal. Esta política describe cómo recopilamos, usamos y protegemos su información.",
              ),
              _buildSection(
                title: "2. Información que recopilamos",
                content: "Podemos recopilar información personal cuando se registra en nuestra aplicación, realiza una reserva, o se comunica con nosotros. Esto puede incluir su nombre, dirección de correo electrónico, número de teléfono y detalles de pago.",
              ),
              _buildSection(
                title: "3. Uso de la información",
                content: "Usamos su información para:\n"
                    "- Procesar sus reservas.\n"
                    "- Mejorar nuestro servicio.\n"
                    "- Comunicarnos con usted sobre actualizaciones y promociones.",
              ),
              _buildSection(
                title: "4. Protección de la información",
                content: "Implementamos diversas medidas de seguridad para proteger su información personal. Sin embargo, ningún método de transmisión a través de Internet o método de almacenamiento electrónico es 100% seguro.",
              ),
              _buildSection(
                title: "5. Cambios en esta política",
                content: "Nos reservamos el derecho de actualizar esta política en cualquier momento. Notificaremos a los usuarios sobre cualquier cambio mediante un aviso en nuestra aplicación.",
              ),
              _buildSection(
                title: "6. Contacto",
                content: "Si tiene alguna pregunta sobre esta política de privacidad, contáctenos a través de info@alquilafacil.com.",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required String content}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          Text(content),
        ],
      ),
    );
  }
}
