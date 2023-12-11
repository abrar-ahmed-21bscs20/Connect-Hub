class PostDataModel {
  final String postId;
  final String userId;
  final String username;
  final String caption;
  final String postUrl;
  final DateTime postedOn;
  final List<String> likes;
  final List<String> comments;

  PostDataModel({
    required this.postId,
    required this.userId,
    required this.username,
    required this.caption,
    required this.postUrl,
    required this.postedOn,
    required this.likes,
    required this.comments,
  });

  Map<String, dynamic> toJson() => {
        'postId': postId,
        'userId': userId,
        'username': username,
        'caption': caption,
        'postUrl': postUrl,
        'postedOn': postedOn.toIso8601String(),
        'likes': likes,
        'comments': comments,
      };

  factory PostDataModel.fromJson(Map<String, dynamic> json) => PostDataModel(
        postId: json['postId'],
        userId: json['userId'],
        username: json['username'],
        caption: json['caption'],
        postUrl: json['postUrl'],
        postedOn: DateTime.parse(json['postedOn']),
        likes: List<String>.from(json['likes']),
        comments: List<String>.from(json['comments']),
      );
}
