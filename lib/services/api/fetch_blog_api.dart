import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/model.dart';

class FetchBlogs {
  static Future<Blog> fetchBlogs() async {
    try {
      const String url = 'https://intent-kit-16.hasura.app/api/rest/blogs';
      const String adminSecret =
          '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';

      final res = await http.get(Uri.parse(url), headers: {
        'x-hasura-admin-secret': adminSecret,
      });

      if (res.statusCode == 200) {
        // Request successful, handle the response data here
        // print('Response data: ${res.body}');

        var data = jsonDecode(res.body);
        Blog blog = Blog.fromJson(data);
        // print(blog.blogs[0].imageUrl);
        return blog;
      } else {
        // Request failed
        // print('Request failed with status code: ${res.statusCode}');
        // print('Response data: ${res.body}');
        throw Exception("Couldn't able to fetch the blogs!!");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
