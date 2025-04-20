import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartfiber/fields/forum/reply_fields.dart';
import 'package:smartfiber/models/forum/author.dart';

class Reply {
  final String content;
  final String authorId;
  final String forumId;

  Author? author;

  Timestamp? createdAt;
  Timestamp? updatedAt;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Reply(
      {required this.content,
      required this.authorId,
      required this.forumId,
      this.author,
      this.createdAt,
      this.updatedAt});

  Map<String, dynamic> get toMap => {
        ReplyFields.content: content,
        ReplyFields.authorId: authorId,
        ReplyFields.createdAt: createdAt,
        ReplyFields.updatedAt: updatedAt
      };

  Future<void> post() async {
    createdAt = Timestamp.now();
    updatedAt = Timestamp.now();

    try {
      await _firestore.collection("forums").doc(forumId).collection("replies").add(toMap);
    } catch (e, stackTrace) {
      log("There was an error: $e", stackTrace: stackTrace);
    }
  }
}
