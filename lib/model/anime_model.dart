class Anime {
  int? id;
  String? name;
  String? episodes;
  String? type;
  String? image;
  // bool animeIconTapped = false;

  Anime(this.id, this.name, this.episodes, this.type, this.image,
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'episodes': episodes,
      'type': type,
      'image': image,
    };
  }

  Anime.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        episodes = json['episodes'],
        type = json['type'],
        image = json['image'];
}

