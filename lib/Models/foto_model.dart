class FotoModel {
  int? albumId;
  int? id;
  String? title;
  String? url;
  String? thumbnail;

  FotoModel({
    this.albumId,
    this.id,
    this.title,
    this.url,
    this.thumbnail
  });

  FotoModel.fromJson(Map<String, dynamic> json) {
    albumId = json['albumId'];
    id = json['id'];
    title = json['title'];
    url = json['url'];
    thumbnail = json['thumbnailUrl'];
  }
}