import 'package:flutter/material.dart';
import 'package:movie_app/app/data/models/category_item_model.dart';

final List<CategoryItem> navList = [
  CategoryItem(
    name: "Reviews",
    icon: Icons.rate_review, // ✍️ writing/review icon
  ),
  CategoryItem(
    name: "Favorite",
    icon: Icons.favorite, // ❤️ heart for favorites
  ),
  CategoryItem(
    name: "Watchlists",
    icon: Icons.playlist_play, // 📺 playlist for watchlists
  ),
];
