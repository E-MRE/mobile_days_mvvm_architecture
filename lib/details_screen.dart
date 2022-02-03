import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'models/anime_search_model.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({
    Key? key,
    required this.responseModel,
  }) : super(key: key);

  final AnimeSearchModel responseModel;
  final String _imageUrl = 'https://wallpaperaccess.com/full/3471309.jpg';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTitle(context, responseModel.title ?? '-'),
              const SizedBox(height: 24),
              _buildTopArea(context),
              const SizedBox(height: 4),
              _buildEpisode(),
              const SizedBox(height: 24),
              _buildDetails(context),
              const SizedBox(height: 18),
              Expanded(
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
        ),
      ),
    );
  }

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
      children: [
        Container(
          width: 154,
          height: 28,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                '${responseModel.episodes} Episodes',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'DMSans-Medium',
                ),
              ),
            ),
          ),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(79, 191, 103, 1),
            borderRadius: BorderRadius.circular(8),
          ),
        )
      ],
    );
  }

  Widget _buildDetails(BuildContext context) {
    return Expanded(
      flex: 5,
      child: ListView(
        children: [
          _buildListItem(context, title: 'Type:', value: responseModel.type),
          _buildListItem(context, title: 'Rated:', value: responseModel.rated),
          _buildListItem(
            context,
            title: 'Score:',
            value: responseModel.score?.toString(),
          ),
          _buildListItem(
            context,
            title: 'Members:',
            value: responseModel.members?.toString(),
          ),
          _buildListItem(
            context,
            title: 'Start Date:',
            value: responseModel.startDate,
          ),
          _buildListItem(context,
              title: 'End Date:', value: responseModel.endDate),
        ],
      ),
    );
  }

  Widget _buildListItem(BuildContext context,
      {required String title, String? value}) {
    return Column(
      children: [
        const Divider(height: 2),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontFamily: 'DMSans-Bold',
                        color: const Color.fromRGBO(27, 29, 33, 1),
                      )),
              Text(value ?? '-',
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontFamily: 'DMSans-SemiBold',
                        color: const Color.fromRGBO(27, 29, 33, 0.4),
                      )),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTitle(BuildContext context, String text) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline4?.copyWith(
            fontFamily: 'DMSans-Bold',
            letterSpacing: -1.6,
            fontSize: 32,
            color: const Color.fromRGBO(27, 29, 33, 1)),
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
