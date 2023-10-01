import 'dart:convert';

Blog blogFromJson(String str) => Blog.fromJson(json.decode(str));
String blogToJson(Blog data) => json.encode(data.toJson());

class Blog {
  List<BlogElement> blogs;
  Blog({required this.blogs});

  factory Blog.fromJson(Map<String, dynamic> json) => Blog(
        blogs: List<BlogElement>.from(
            json["blogs"].map((x) => BlogElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "blogs": List<dynamic>.from(blogs.map((x) => x.toJson())),
      };
}

class BlogElement {
  String id;
  String imageUrl;
  String title;

  BlogElement({
    required this.id,
    required this.imageUrl,
    required this.title,
  });

  factory BlogElement.fromJson(Map<String, dynamic> json) => BlogElement(
        id: json["id"],
        imageUrl: json["image_url"] ?? "https://www.vhv.rs/dpng/d/553-5531706_dummy-image-image-not-available-hd-png-download.png",
        title: json["title"] ?? "--",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image_url": imageUrl,
        "title": title,
      };
}
