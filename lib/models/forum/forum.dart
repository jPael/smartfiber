import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartfiber/error/app_error.dart';
import 'package:smartfiber/fields/forum/forum_fields.dart';
import 'package:smartfiber/models/forum/author.dart';
// import 'package:smartfiber/services/forum/forum_services.dart';

class Forum {
  final String title;
  final String content;
  final String barangay;
  final String authorId;
  final String? docId;
  Timestamp? createdAt;
  Timestamp? updatedAt;
  Author? author;
  int replyCount;
  bool liked;
  List<Map<String, dynamic>>? likes;

  Forum(
      {required this.title,
      required this.content,
      required this.barangay,
      required this.authorId,
      this.likes,
      this.createdAt,
      this.updatedAt,
      this.docId,
      this.author,
      this.replyCount = 0,
      this.liked = false});

  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // final ForumServices _forumService = ForumServices();

  Map<String, dynamic> toMap() => {
        ForumFields.title: title,
        ForumFields.content: content,
        ForumFields.barangay: barangay,
        ForumFields.updatedAt: updatedAt,
        ForumFields.createdAt: createdAt,
        ForumFields.authorId: authorId,
      };

  bool isLiked(String userId) => likes?.any((like) => like[LikeFields.userId] == userId) ?? false;

  Future<Map<String, dynamic>> post() async {
    try {
      createdAt = Timestamp.now();
      updatedAt = Timestamp.now();

      // await _forumService.postForum(toMap());

      return {"success": true};
    } catch (e, stackTrace) {
      log("There was an error: ${e.toString()}", stackTrace: stackTrace);
      return {"success": false, "message": errorMessage("Post unsuccessful")};
    }
  }

  Future<Map<String, dynamic>> likePost(String userId) async {
    try {
      // await _forumService.likePost(forumId: docId!, userId: userId);
      liked = !liked;
      return {"success": true, "value": liked};
    } catch (e, stackTrace) {
      log("There was an error", stackTrace: stackTrace);
      return {
        "success": false,
        "value": liked,
        "message": "There was an error ${!liked ? "unliking" : "liking"} this post"
      };
    }
  }
}
