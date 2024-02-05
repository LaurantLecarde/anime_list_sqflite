class Anime {
  int? id;
  String? name;
  int? episodes;
  String? type;
  String? image;
  int? season;
  bool animTapped;

  Anime(this.id, this.name, this.episodes, this.type, this.image,this.animTapped,this.season);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'episodes': episodes,
      'type': type,
      'image': image,
      'season':season,
      'animTapped':animTapped ? 1 : 0,
    };
  }

  Anime.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        episodes = json['episodes'],
        type = json['type'],
        image = json['image'],
        season = json['season'],
        animTapped = json['animTapped']==0;
}

