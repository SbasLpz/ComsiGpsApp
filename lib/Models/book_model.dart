class BookModel {
  String? id;
  String? title;
  String? publication_year;
  String? desc;

  BookModel({
    this.id,
    this.title,
    this.publication_year,
    this.desc
  });

  BookModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    title = json['title'];
    publication_year = json['publication_year'].toString();
    desc = json['description'];
  }
}