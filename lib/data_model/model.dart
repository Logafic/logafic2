class DataModel {
  int? id;
  String? name;
  String? country;
  String? image;
  String? createdAt;

  DataModel(int id, String name, String country, String createdAt) {
    this.id = id;
    this.name = name;
    this.country = country;
    this.createdAt = createdAt;
  }

  DataModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["full_name"];
    country = json["country"];
    image = json["image"];
    createdAt = json["created_at"];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": name,
        "country": country,
        "image": image,
        "created_at": DateTime.now()
      };
}
