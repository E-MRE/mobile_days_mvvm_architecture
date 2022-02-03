import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_days_mvvm_architecture/utils/decorations/empty_space.dart';
import 'package:mobile_days_mvvm_architecture/widgets/anime_list_item.dart';
import 'package:mobile_days_mvvm_architecture/widgets/anime_search_bar.dart';
import 'package:mobile_days_mvvm_architecture/widgets/default_scaffold.dart';
import 'package:mobile_days_mvvm_architecture/widgets/sub_title.dart';

import 'models/anime_search_model.dart';
import 'utils/constants/assets_contants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const HomeScreen(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  final http.Client _client = http.Client();

  final String _url = 'https://api.jikan.moe/v3/search/anime?q=';
  final String _description =
      'İstediğiniz animeyi arayarak bulabilir ve detaylarına ulaşabilirsiniz.';
  String _error = '';
  bool _isLoading = false;

  final EdgeInsetsGeometry _pagePadding =
      const EdgeInsets.all(40).copyWith(bottom: 16);

  List<AnimeSearchModel> _responseList = [];

  void _changeLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  void _setError(String message) {
    setState(() {
      _error = message;
    });
  }

  void _setList(List<AnimeSearchModel> list) {
    setState(() {
      _responseList = list;
    });
  }

  Future<void> _retrieveData() async {
    _setError('');

    if (_controller.text.isEmpty) {
      _setError('Boş arama yapılamaz');
    }

    try {
      _changeLoading();
      var uri = Uri.parse('$_url${_controller.text}');
      var response =
          await _client.get(uri).timeout(const Duration(seconds: 10));

      if (response.statusCode != HttpStatus.ok) {
        _changeLoading();
        _setError('Veriler alınırken bir hata meydana geldi');
      }

      var json = jsonDecode(response.body);
      if (json['results'] != null && json['results'] is List) {
        var list = (json['results'] as List)
            .map((item) => AnimeSearchModel.fromJson(item))
            .toList();

        _setList(list);
      }
      _changeLoading();
    } catch (error) {
      _changeLoading();
      _setError(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      padding: _pagePadding,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _buildIcon(),
          const EmptySpace.bigHeigh(),
          const SubTitle(text: 'Anime Ara'),
          const EmptySpace.normalHeigh(),
          _buildDescription(context),
          const EmptySpace.normalHeigh(),
          AnimeSearchBar(onSearched: (query) => _retrieveData()),
          const EmptySpace.veryBigHeigh(),
          //TODO: bloc selector widget tüm durumları kapsasın
          //const BlocSelectorAnimeList(),
          if (_isLoading) const Center(child: CircularProgressIndicator()),
          if (_error.isNotEmpty) Center(child: Text(_error)),
          if (!_isLoading && _error.isEmpty && _responseList.isNotEmpty)
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 24,
                childAspectRatio: (140 / 168),
                controller: ScrollController(keepScrollOffset: false),
                shrinkWrap: true,
                children: List.generate(_responseList.length, (index) {
                  return AnimeListItem(item: _responseList[index]);
                }),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildIcon() {
    return Image.asset(AssetsConstants.png.marsIcon, height: 80, width: 148);
  }

  Widget _buildDescription(BuildContext context) {
    return Text(
      _description,
      style: Theme.of(context).textTheme.subtitle1?.copyWith(
            color: Colors.black.withOpacity(0.5),
            fontFamily: 'DMSans-Regular',
            letterSpacing: -0.36,
          ),
    );
  }
}
