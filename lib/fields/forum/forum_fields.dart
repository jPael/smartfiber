class ForumFields {
  static String get title => "title";
  static String get content => "content";
  static String get barangay => "barangay";
  static String get docId => "docId";
  static String get createdAt => "created_at";
  static String get updatedAt => "updated_at";
  static String get authorId => "author_id";
  static String get like => "like";
  static String get likes => "likes";
}

class LikeFields extends ForumFields {
  static String get userId => "user_id";
  static String get createdAt => "created_at";
}
