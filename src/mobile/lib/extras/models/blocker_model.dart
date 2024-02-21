class BlockerCommentModel {
  String? commentId;
  String? message;
  String? createdAt;
  String? user;
  String? blocker;
  String? senderName;

  BlockerCommentModel(
      {this.commentId,
      this.message,
      this.createdAt,
      this.user,
      this.blocker,
      this.senderName});

  BlockerCommentModel.fromJson(Map<String, dynamic> json) {
    commentId = json['comment_id'];
    message = json['message'];
    createdAt = json['created_at'];
    user = json['user'];
    blocker = json['blocker'];
    senderName = json['sender_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['comment_id'] = commentId;
    data['message'] = message;
    data['created_at'] = createdAt;
    data['user'] = user;
    data['blocker'] = blocker;
    data['sender_name'] = senderName;
    return data;
  }
}
