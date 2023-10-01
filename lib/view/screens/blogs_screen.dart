import 'package:blog_rise/services/api/fetch_blog_api.dart';
import 'package:blog_rise/view/screens/detail_blog_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/constants/routes.dart';

class BlogsScreen extends StatefulWidget {
  const BlogsScreen({super.key});

  @override
  State<BlogsScreen> createState() => _BlogsScreenState();
}

class _BlogsScreenState extends State<BlogsScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: FetchBlogs.fetchBlogs(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text("error -> ${snapshot.error.toString()}"),
              );
            }

            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0)
                    .copyWith(top: 50.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: searchController,
                            onSubmitted: (value) {
                              // searchController = searchController.text;
                              // fNews.searchNews(searchedWord);
                              // setState(() {});
                            },
                            decoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2, color: Colors.blueGrey),
                              ),
                              hintText: "Search blogs titles",
                            ),
                            style: const TextStyle(color: Colors.blueGrey),
                          ),
                        ),
                        CupertinoButton(
                          onPressed: () {
                            // if (searchText.text.isNotEmpty) {
                            //   searchedWord = searchText.text;

                            //   setState(() {
                            //     fNews.searchNews(searchedWord);
                            //   });
                            // }
                          },
                          child: const Icon(
                            Icons.search,
                            color: Colors.blueGrey,
                          ),
                        ),
                        CupertinoButton(
                          onPressed: () {
                            // authService.handleSignOut();
                          },
                          child: Icon(
                            Icons.logout,
                            color: Colors.red.shade800,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: snapshot.data!.blogs.length,
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 10.0),
                            child: GestureDetector(
                              onTap: () {
                                Routes.instance.push(
                                    widget: DetailBlogView(
                                        index: index, blogData: snapshot.data!),
                                    context: context);
                              },
                              child: Card(
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
                                            snapshot.data!.blogs[index].title
                                                .toString(),
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
                                          snapshot.data!.blogs[index].imageUrl
                                              .toString(),
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
            );
          }),
    );
  }
}
