import 'package:flutter/material.dart';
import '../models/model.dart';

class FavouriteBlogsProvider extends ChangeNotifier {
  List<Blogs> favouriteBlogsList = [];

  void toggleFavourites(Blogs soloBlog) {
    final isExist = favouriteBlogsList.contains(soloBlog);

    if (isExist == true) {
      favouriteBlogsList.remove(soloBlog);
    } else {
      favouriteBlogsList.add(soloBlog);
    }

    // for (var element in favouriteBlogsList) {
    //   print(element.title);
    // }
    // print(favouriteBlogsList.length);

    notifyListeners();
  }

  bool isExists(Blogs soloBlog){
    final isExist = favouriteBlogsList.contains(soloBlog);
    return isExist;
  }
}
