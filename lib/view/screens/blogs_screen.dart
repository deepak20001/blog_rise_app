import 'package:blog_rise/services/api/fetch_blog_api.dart';
import 'package:flutter/material.dart';

class BlogsScreen extends StatefulWidget {
  const BlogsScreen({super.key});

  @override
  State<BlogsScreen> createState() => _BlogsScreenState();
}

class _BlogsScreenState extends State<BlogsScreen> {
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

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: snapshot.data!.blogs.length,
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(snapshot.data!.blogs[index].title),
                          subtitle: Text(snapshot.data!.blogs[index].id),
                          trailing: Image.network(
                              snapshot.data!.blogs[index].imageUrl),
                        );
                      }),
                ),
              ],
            );
          }),
    );
  }
}
