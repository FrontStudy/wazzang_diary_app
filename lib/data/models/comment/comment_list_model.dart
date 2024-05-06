import '../../../domain/entities/comment/comment.dart';
import 'comment_model.dart';

class CommentListModel {
  final List<CommentModel> comments;

  CommentListModel({required this.comments});

  Map<String, dynamic> toJson() => {
        'comments': comments.map((comment) => comment.toJson()).toList(),
      };

  factory CommentListModel.fromJsonList(List<dynamic> json) {
    final List<CommentModel> commentList =
        json.map((commentJson) => CommentModel.fromJson(commentJson)).toList();
    return CommentListModel(comments: commentList);
  }

  List<Comment> toEntityList() {
    return comments.map((model) => model.comment).toList();
  }
}
