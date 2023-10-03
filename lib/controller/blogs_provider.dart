import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../models/model.dart';

class BlogsProvider extends ChangeNotifier {
  Blog? blog;
  List<Blogs> totalBlogsList = [];
  List<Blogs> searchedBlogsList = [];
  bool isLoading = true;
  bool isSearchLoading = true;


  Future<void> fetchBlogs() async {
    totalBlogsList = [];
    try {
      const String url = 'https://intent-kit-16.hasura.app/api/rest/blogs';
      const String adminSecret =
          '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';

      final res = await http.get(Uri.parse(url), headers: {
        'x-hasura-admin-secret': adminSecret,
      });

      if (res.statusCode == 200) {
        blog = Blog.fromJson(jsonDecode(res.body));
        blog!.blogs!.forEach(
          (element) {
            totalBlogsList.add(element);
          },
        );
        print(totalBlogsList.length);
        isLoading = false;

        notifyListeners();
      } else {
        isLoading = false;

        notifyListeners();
        throw Exception("Couldn't able to fetch the blogs!!");
      }
    } catch (e) {
      isLoading = false;

      notifyListeners();
      throw Exception(e.toString());
    }
  }

  Future<void> fetchSearchedBlogs(String searchedKeyword) async {
    searchedBlogsList = [];
    try {
      const String url = 'https://intent-kit-16.hasura.app/api/rest/blogs';
      const String adminSecret =
          '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';

      final res = await http.get(Uri.parse(url), headers: {
        'x-hasura-admin-secret': adminSecret,
      });

      if (res.statusCode == 200) {
        blog = Blog.fromJson(jsonDecode(res.body));
        blog!.blogs!.forEach(
          (element) {
            if (element.title!
                .toLowerCase()
                .startsWith(searchedKeyword.toLowerCase())) {
              searchedBlogsList.add(element);
            }
          },
        );

        print("Searched List = ${searchedBlogsList.length}");

        searchedBlogsList.forEach((element) {
          print("element title : ${element.title}");
        });
        isSearchLoading = false;

        notifyListeners();
      } else {
        isSearchLoading = false;
        notifyListeners();
        throw Exception("Couldn't able to fetch the blogs!!");
      }
    } catch (e) {
      isSearchLoading = false;
      notifyListeners();
      throw Exception(e.toString());
    }
  }
}
