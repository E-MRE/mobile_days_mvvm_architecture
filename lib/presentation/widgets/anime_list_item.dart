import 'package:flutter/material.dart';
import 'package:mobile_days_mvvm_architecture/models/anime_search_model.dart';

import '../screens/anime/view/details_screen.dart';

class AnimeListItem extends StatelessWidget {
  const AnimeListItem({
    Key? key,
    this.item,
    this.radius = 24,
    this.height = 168,
    this.width = 140,
  }) : super(key: key);

  final AnimeSearchModel? item;
  final double radius;
  final double height;
  final double width;
  final String _imageUrl = 'https://wallpaperaccess.com/full/3471309.jpg';

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _onItemSelected(context),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: SizedBox(
          height: height,
          width: width,
          child: Image.network(
            //item.getImageUrl,
            item?.imageUrl ?? _imageUrl,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  void _onItemSelected(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            DetailScreen(responseModel: item ?? AnimeSearchModel()),
      ),
    );
  }
}
