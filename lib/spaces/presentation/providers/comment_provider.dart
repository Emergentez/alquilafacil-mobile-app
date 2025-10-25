import 'package:alquilafacil/profile/presentation/providers/profile_provider.dart';
import 'package:alquilafacil/spaces/data/remote/helpers/comment_service_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';

import '../../domain/model/comment.dart';

class CommentProvider extends ChangeNotifier{
  final CommentServiceHelper commentService;
  CommentProvider(this.commentService);

  var logger = Logger();
  List<Comment> comments = [];
  List<String> authors = [];

  Future<void> getAllCommentsBySpaceId(int spaceId)async {
    try{
      comments = await commentService.getAllCommentsBySpaceId(spaceId);
    }catch(e){
      comments = [];
    }
    notifyListeners();
  }

  Future<void> createComment(Comment comment) async{
    try {
      await commentService.createComment(comment);
    } catch (e){
      logger.e("Error al crear el comentario con datos:");
      logger.e(comment.toJson());
    }
    notifyListeners();
  }

}