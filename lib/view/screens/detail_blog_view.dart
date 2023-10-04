// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blog_rise/controller/favourite_blogs_provider.dart';
import 'package:blog_rise/view/utils/constants/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/model.dart';

class DetailBlogView extends StatefulWidget {
  final Blogs blogData;

  const DetailBlogView({
    Key? key,
    required this.blogData,
  }) : super(key: key);

  @override
  State<DetailBlogView> createState() => _DetailBlogViewState();
}

class _DetailBlogViewState extends State<DetailBlogView> {
  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<FavouriteBlogsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 32,
        backgroundColor: Colors.transparent,
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Text(
                  widget.blogData.title!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.blueGrey,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CachedNetworkImage(
                  progressIndicatorBuilder: (context, url, progress) => Center(
                    child: CircularProgressIndicator(
                      value: progress.progress,
                    ),
                  ),
                  imageUrl: widget.blogData.imageUrl!,
                  height: 250,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () {
                    appProvider.toggleFavourites(widget.blogData);
                  },
                  icon: appProvider.isExists(widget.blogData)
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 30,
                        )
                      : const Icon(
                          Icons.favorite_outline,
                          size: 30,
                        ),
                ),
              ),
              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.blueGrey.shade500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
