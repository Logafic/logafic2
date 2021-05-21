class UserProfile {
  String userEmail;
  String userId;
  String userName;
  String universty;
  String userProfileImage;
  String userBackImage;
  String department;
  String city;
  String gender;
  String webSite;
  String linkedin;
  String twitter;
  String instagram;
  String birtday;
  String biograpfy;

  UserProfile(
      {this.userEmail,
      this.userId,
      this.userName,
      this.universty,
      this.userProfileImage,
      this.userBackImage,
      this.department,
      this.city,
      this.gender,
      this.webSite,
      this.linkedin,
      this.twitter,
      this.instagram,
      this.birtday,
      this.biograpfy});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['userName'] = this.userName;
    data['userProfileImage'] = this.userProfileImage;
    data['userBackImage'] = this.userBackImage;
    data['department'] = this.department;
    data['city'] = this.city;
    data['gender'] = this.gender;
    data['webSite'] = this.webSite;
    data['linkedin'] = this.linkedin;
    data['twitter'] = this.twitter;
    data['instagram'] = this.instagram;
    data['birtday'] = this.birtday;
    data['biograpfy'] = this.biograpfy;
    return data;
  }
}
