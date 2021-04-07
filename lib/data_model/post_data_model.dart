class PostModel {
  String userId;
  String userName;
  String userSmallImage;
  String content;

  PostModel({this.userId, this.userName, this.userSmallImage, this.content});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['userName'] = this.userName;
    data['userSmallImage'] = this.userSmallImage;
    data['content'] = this.content;
    return data;
  }
}
