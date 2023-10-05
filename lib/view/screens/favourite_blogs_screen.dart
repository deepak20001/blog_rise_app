import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/favourite_blogs_provider.dart';
import '../utils/constants/routes.dart';
import 'detail_blog_view.dart';

class FavouriteBlogsScreen extends StatelessWidget {
  const FavouriteBlogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appProvider =
        Provider.of<FavouriteBlogsProvider>(context).favouriteBlogsList;

    // print(appProvider[0].title);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Favourite Blogs"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: appProvider.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Routes.instance.push(
                          widget: DetailBlogView(
                            blogData: appProvider[index],
                          ),
                          context: context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          color: Colors.blueGrey.shade100,
                          border: Border.all(color: Colors.blueGrey)),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            appProvider[index].title!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          )),
                          Expanded(
                            child: Image.network(
                              appProvider[index].imageUrl!,
                              width: 40,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
