class Post {
  String caption;
  String uid;
  String username;
  List<dynamic> likes;
  String postId;
  DateTime datePublished;
  String postUrl;
  String profImage;

  Post({
    required this.caption,
    required this.uid,
    required this.username,
    required this.likes,
    required this.postId,
    required this.datePublished,
    required this.postUrl,
    required this.profImage,
  });

  Map<String, dynamic> toJson() {
    return {
      "caption": caption,
      "uid": uid,
      "username": username,
      "likes": likes,
      "postId": postId,
      "datePublished": datePublished.toIso8601String(),
      "postUrl": postUrl,
      "profImage": profImage,
    };
  }
}
