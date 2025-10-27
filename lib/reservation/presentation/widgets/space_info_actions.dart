import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SpaceInfoActions extends StatelessWidget {
  const SpaceInfoActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, "/comments");
          },
          child: const Row(
            children: [
              Text(
                "Ver comentarios",
                style: TextStyle(
                    color: Colors.red
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.red,
              )
            ],
          ),
        ),
        const SizedBox(height: 20),
        GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, "/space-features");
          },
          child: const Row(
            children: [
              Text(
                "Detalles adicionales",
                style: TextStyle(
                    color: Colors.red
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.red,
              )
            ],
          ),
        ),
        const SizedBox(height: 20),
        GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, "/create-report");
          },
          child: const Row(
            children: [
              Text(
                "Reportar espacio",
                style: TextStyle(
                    color: Colors.red
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.red,
              )
            ],
          ),
        ),
      ],
    );
  }
}
