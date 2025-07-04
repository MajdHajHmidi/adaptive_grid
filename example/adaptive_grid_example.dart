import 'package:adaptive_grid/adaptive_grid.dart';
import 'package:flutter/material.dart';

import 'blog_model.dart';
import 'blog_tile.dart';

class BlogsGrid extends StatelessWidget {
  final List<Blog> blogs;
  const BlogsGrid({super.key, required this.blogs});

  @override
  Widget build(BuildContext context) {
    return AdaptiveGrid(
      itemCount: blogs.length,
      itembuilder: (context, index) => BlogTile(blog: blogs[index]),
      minimumItemWidth: 300,
      verticalSpacing: 16,
      horizontalSpacing: 16,
      disableStretch: false,
      textDirection: TextDirection.ltr,
    );
  }
}
