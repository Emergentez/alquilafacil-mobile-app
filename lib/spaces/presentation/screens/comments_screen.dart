import 'package:alquilafacil/auth/presentation/screens/login.dart';
import 'package:alquilafacil/profile/domain/model/profile.dart';
import 'package:alquilafacil/profile/presentation/providers/profile_provider.dart';
import 'package:alquilafacil/public/presentation/widgets/screen_bottom_app_bar.dart';
import 'package:alquilafacil/spaces/data/remote/helpers/comment_service_helper.dart';
import 'package:alquilafacil/spaces/domain/model/comment.dart';
import 'package:alquilafacil/spaces/presentation/providers/comment_provider.dart';
import 'package:alquilafacil/spaces/presentation/providers/space_provider.dart';
import 'package:alquilafacil/spaces/presentation/widgets/space_comment.dart'; // Asegúrate de que esto esté bien importado
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

//import '../../../profile/data/local/services/users_service.dart';
import '../../data/remote/services/comments_service.dart';


import '../../data/remote/services/comments_service.dart';


class CommentsScreen extends StatefulWidget {
  const CommentsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {

  @override
  void initState() {
    super.initState();
    var logger = Logger();
    final commentProvider = context.read<CommentProvider>();
    final spaceProvider = context.read<SpaceProvider>();
    final profileProvider = context.read<ProfileProvider>();
    var authorIds = [];
    () async {
      logger.v(spaceProvider.spaceSelected!.id);
      await commentProvider.getAllCommentsBySpaceId(spaceProvider.spaceSelected!.id);
      for (int i = 0; i < commentProvider.comments.length; i++){
        authorIds.add(commentProvider.comments[i].authorId);
      }
      await profileProvider.fetchUsernamesExpect(authorIds);
      for (int i = 0; i < profileProvider.usernamesExpect.length; i++){
        commentProvider.comments[i].authorName = profileProvider.usernamesExpect[i];
      }
    }();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final commentProvider = context.watch<CommentProvider>();
    final profileProvider = context.watch<ProfileProvider>();
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
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: commentProvider.comments.map((comment) =>
                SpaceComment(
                      author: comment.authorName,
                      text: comment.text,
                      rating: comment.rating,
                )).toList(),
          )
        )
      )
    );
  }
}
