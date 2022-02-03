import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'models/anime_search_model.dart';
import 'utils/decorations/empty_space.dart';
import 'widgets/default_scaffold.dart';
import 'widgets/detail_list_item.dart';
import 'widgets/episode.dart';
import 'widgets/sub_title.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({
    Key? key,
    required this.responseModel,
  }) : super(key: key);

  final AnimeSearchModel responseModel;
  final String _imageUrl = 'https://wallpaperaccess.com/full/3471309.jpg';

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SubTitle(text: responseModel.title ?? '-'),
          const EmptySpace.bigHeigh(),
          _buildTopArea(context),
          const EmptySpace.extraSmallHeigh(),
          _buildEpisode(),
          const EmptySpace.bigHeigh(),
          _buildDetails(context),
          const EmptySpace.normalHeigh(),
          Expanded(
            //TODO: child: WebSiteButton(webiste: responseModel.url ?? _imageUrl),
            child: ElevatedButton(
              onPressed: () async =>
                  _openUrl(website: responseModel.url ?? _imageUrl),
              child: const Text('Web Sitesine Git'),
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size.fromWidth(double.infinity),
                  primary: const Color.fromRGBO(30, 188, 253, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  )),
            ),
          ),
        ],
      ),
    );
  }

  //TODO: burada olmaz
  Future<void> _openUrl(
      {VoidCallback? errorCallback, required String website}) async {
    if (await canLaunch(website)) {
      await launch(website);
    } else {
      errorCallback?.call();
    }
  }

  Widget _buildTopArea(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(responseModel.imageUrl ?? _imageUrl),
          const SizedBox(width: 16),
          Expanded(
              child: Text(
            responseModel.synopsis ?? '-',
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                color: Colors.black.withOpacity(0.5),
                fontFamily: 'DMSans-Regular',
                fontSize: 16,
                letterSpacing: -0.36),
          ))
        ],
      ),
    );
  }

  Widget _buildEpisode() {
    return Row(
      children: [Episode(text: '${responseModel.episodes} Episodes')],
    );
  }

  Widget _buildDetails(BuildContext context) {
    return Expanded(
      flex: 5,
      child: ListView(
        children: [
          DetailListItem(title: 'Type:', value: responseModel.type),
          DetailListItem(title: 'Rated:', value: responseModel.rated),
          DetailListItem(
            title: 'Score:',
            value: responseModel.score?.toString(),
          ),
          DetailListItem(
            title: 'Members:',
            value: responseModel.members?.toString(),
          ),
          DetailListItem(title: 'Start Date:', value: responseModel.startDate),
          DetailListItem(title: 'End Date:', value: responseModel.endDate),
        ],
      ),
    );
  }
}
