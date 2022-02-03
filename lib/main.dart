import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'details_screen.dart';
import 'models/anime_search_model.dart';
import 'utils/constants/assets_contants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
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
  final String _imageUrl = 'https://wallpaperaccess.com/full/3471309.jpg';
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

  void _onItemSelected(BuildContext context, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailScreen(responseModel: _responseList[index]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: _pagePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                _buildIcon(),
                const SizedBox(height: 24),
                _buildTitle(context),
                const SizedBox(height: 16),
                _buildDescription(context),
                const SizedBox(height: 12),
                _buildSearchBar(context),
                const SizedBox(height: 32),
                if (_isLoading)
                  const Center(child: CircularProgressIndicator()),
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
                        return InkWell(
                          onTap: () => _onItemSelected(context, index),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: SizedBox(
                              height: 168,
                              width: 140,
                              child: Image.network(
                                _responseList[index].imageUrl ?? _imageUrl,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return Image.asset(AssetsConstants.png.marsIcon, height: 80, width: 148);
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      'Anime Ara',
      style: Theme.of(context).textTheme.headline3?.copyWith(
            color: Colors.black,
            fontFamily: 'DMSans-Bold',
            fontSize: 36,
          ),
    );
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

  Widget _buildSearchBar(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: const Color.fromRGBO(27, 29, 33, 0.1)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: TextField(
                  controller: _controller,
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      fontFamily: 'DMSans-Regular',
                      letterSpacing: -0.3,
                      color: const Color.fromRGBO(4, 4, 21, 1)),
                  decoration: InputDecoration(
                    hintText: 'Bir anime ara...',
                    hintStyle: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontFamily: 'DMSans-Italic',
                      fontSize: 14,
                    ),
                    contentPadding: const EdgeInsets.all(16),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () async => _retrieveData(),
              icon: Container(
                height: 40,
                width: 40,
                child: const Icon(Icons.search_outlined),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(237, 251, 255, 1),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
