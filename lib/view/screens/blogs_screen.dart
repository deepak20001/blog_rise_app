import 'package:blog_rise/controller/blogs_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/model.dart';

class BlogsScreen extends StatefulWidget {
  const BlogsScreen({super.key});

  @override
  State<BlogsScreen> createState() => _BlogsScreenState();
}

class _BlogsScreenState extends State<BlogsScreen> {
  TextEditingController searchController = TextEditingController();
  late List<Blogs> blogsList = [];

  void addBlogs() async {
    final appProvider = context.read<BlogsProvider>();
    await appProvider.fetchBlogs();
    blogsList = appProvider.totalBlogsList;
    // print(blogsList.length);
  }

  @override
  void initState() {
    addBlogs();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = context.watch<BlogsProvider>();

    return Scaffold(
      body: appProvider.isLoading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  children: [
                    TextField(
                      controller: searchController,
                      onSubmitted: (value) async {
                        if (value.isEmpty) {
                          await appProvider.fetchBlogs();
                          blogsList = appProvider.totalBlogsList;
                        } else {
                          await appProvider.fetchSearchedBlogs(value);
                          blogsList = appProvider.searchedBlogsList;
                        }
                      },
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                          onTap: () {
                            searchController.clear();
                          },
                          child: const Icon(Icons.clear),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              width: 2, color: Colors.blueGrey.shade900),
                        ),
                        hintText: "Search blogs titles",
                      ),
                      style: TextStyle(color: Colors.blueGrey.shade900),
                    ),
                    const SizedBox(height: 15.0),
                    Expanded(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: blogsList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: GestureDetector(
                              onTap: () {},
                              child: Card(
                                color: Colors.blueGrey.shade200,
                                shape: const RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0,
                                    vertical: 10.0,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            blogsList[index].title!,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        child: Image.network(
                                          blogsList[index].imageUrl!,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
