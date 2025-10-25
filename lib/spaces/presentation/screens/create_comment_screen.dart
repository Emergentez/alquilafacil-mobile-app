import 'package:alquilafacil/public/ui/theme/main_theme.dart';
import 'package:alquilafacil/spaces/domain/model/comment.dart';
import 'package:alquilafacil/spaces/presentation/providers/comment_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../providers/space_provider.dart';

class CreateCommentScreen extends StatefulWidget {
  const CreateCommentScreen({super.key});

  @override
  State<CreateCommentScreen> createState() => _CreateCommentScreenState();
}

class _CreateCommentScreenState extends State<CreateCommentScreen> {
  int spaceId = 0;
  int authorId = 0;
  String text = "";
  double rating = 0;

  @override
  void initState() {
    super.initState();
    final spaceProvider = context.read<SpaceProvider>();

    spaceId = spaceProvider.spaceSelected!.id;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController commentController = TextEditingController();
    //Numero de estrellas
    int starCount = 5;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Comentarios'),
        leading: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.orangeAccent,
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            //Titulo y Estrellas
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Deja tu valoración: "),
                StarRating(
                  color: MainTheme.secondary(context),
                  rating: rating,
                  starCount: starCount,
                  allowHalfRating: false,
                  onRatingChanged: (rating) => setState(() {
                    this.rating = rating;
                  }),
                )
              ],
            ),
            const SizedBox(height: 16),
            //Caja de texto
            TextField(
              cursorColor: MainTheme.primary(context),
              controller: commentController,
              maxLines: 6,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: MainTheme.primary(context)
                  )
                ),
                hintText: "Escribe aqui tu comentario...",
                border:const  OutlineInputBorder(
                ),
              ),
              style: TextStyle(color: MainTheme.contrast(context))
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: 130,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MainTheme.primary(context),
                    foregroundColor: MainTheme.background(context),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
                  onPressed: () {
                    final text = commentController.text;
                    final provider = context.read<CommentProvider>();
                    var comment = Comment(
                        id: 0,
                        authorId: 0,
                        spaceId: spaceId,
                        text: text,
                        rating: rating.round()
                    );
                    provider.createComment(comment);
                    Navigator.pop(context);
                  },
                  child: const Text('Publicar', style: TextStyle(color: Colors.white),),
                ),
              ),
            ),
          ],
        )
      )
    );
  }
}
