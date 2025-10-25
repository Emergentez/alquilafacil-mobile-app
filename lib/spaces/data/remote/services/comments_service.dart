import 'dart:convert';
import 'dart:io';
import 'package:alquilafacil/spaces/domain/model/comment.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

abstract class CommentService {
  Future<List<Comment>> getAllCommentsBySpaceId(int spaceId);
  Future<String> createComment(Comment comment);
}
