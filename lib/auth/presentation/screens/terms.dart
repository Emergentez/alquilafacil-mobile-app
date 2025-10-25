import 'package:alquilafacil/public/ui/theme/main_theme.dart';
import 'package:flutter/material.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Términos de uso"),
      ),
      backgroundColor: MainTheme.primary(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSection(
                title: "1. Aceptación de los términos",
                content: "Al utilizar nuestra aplicación, usted acepta cumplir con estos Términos de Servicio. Si no está de acuerdo, no debe utilizar nuestros servicios.",
              ),
              _buildSection(
                title: "2. Uso de la aplicación",
                content: "Usted se compromete a utilizar la aplicación solo para fines legales y de acuerdo con las leyes aplicables. No debe usar la aplicación para cualquier actividad que sea fraudulenta o que infrinja los derechos de otros.",
              ),
              _buildSection(
                title: "3. Reservas y pagos",
                content: "Las reservas realizadas a través de nuestra aplicación están sujetas a disponibilidad y a las políticas de cada espacio. Los pagos se procesarán a través de plataformas seguras.",
              ),
              _buildSection(
                title: "4. Modificaciones",
                content: "Nos reservamos el derecho de modificar o interrumpir el servicio en cualquier momento, sin previo aviso.",
              ),
              _buildSection(
                title: "5. Limitación de responsabilidad",
                content: "En la medida máxima permitida por la ley, AlquilaFácil no será responsable de ningún daño indirecto, incidental o consecuente que surja del uso de nuestra aplicación.",
              ),
              _buildSection(
                title: "6. Contacto",
                content: "Si tiene preguntas sobre estos Términos de Servicio, contáctenos a través de info@alquilafacil.com.",
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
