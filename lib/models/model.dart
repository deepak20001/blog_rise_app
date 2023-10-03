// ignore_for_file: public_member_api_docs, sort_constructors_first
class Blog {
  List<Blogs>? blogs;

  Blog({this.blogs});

  Blog.fromJson(Map<String, dynamic> json) {
    if (json['blogs'] != null) {
      blogs = <Blogs>[];
      json['blogs'].forEach((v) {
        blogs!.add(Blogs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (blogs != null) {
      data['blogs'] = blogs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Blogs {
  String? id;
  String? imageUrl;
  String? title;

  Blogs({this.id, this.imageUrl, this.title});

  Blogs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageUrl = json['image_url'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image_url'] = imageUrl;
    data['title'] = title;
    return data;
  }

  // @override
  // String toString() => 'Blogs(id: $id, imageUrl: $imageUrl, title: $title)';
}
