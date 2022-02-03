class AnimeSearchModel {
  int? id;
  String? url;
  String? imageUrl;
  String? title;
  bool? airing;
  String? synopsis;
  String? type;
  num? episodes;
  num? score;
  String? startDate;
  String? endDate;
  num? members;
  String? rated;

  ///TODO: Anlat! model içerisinde de getter setterlar yazmak. Kapsülleme etc.
  //   String? get getStartDate {
  //   var date = DateTime.tryParse(startDate ?? '');

  //   if (date == null) return '-';

  //   return '${date.day}.${date.month}.${date.year}';
  // }

  // String? get getEndDate {
  //   var date = DateTime.tryParse(endDate ?? '');

  //   if (date == null) return '-';

  //   return '${date.day}.${date.month}.${date.year}';
  // }

  // String get getImageUrl => (imageUrl?.isNotEmpty ?? false)
  //     ? imageUrl!
  //     : 'https://wallpaperaccess.com/full/3471309.jpg';

  // String get getWebsite => (url?.isNotEmpty ?? false)
  //     ? url!
  //     : 'https://wallpaperaccess.com/full/3471309.jpg';

  AnimeSearchModel({
    this.id,
    this.url,
    this.imageUrl,
    this.title,
    this.airing,
    this.synopsis,
    this.type,
    this.episodes,
    this.score,
    this.startDate,
    this.endDate,
    this.members,
    this.rated,
  });

  factory AnimeSearchModel.fromJson(Map<String, dynamic> json) {
    return AnimeSearchModel(
      id: json['mal_id'],
      url: json['url'],
      imageUrl: json['image_url'],
      title: json['title'],
      airing: json['airing'],
      synopsis: json['synopsis'],
      type: json['type'],
      episodes: json['episodes'],
      score: json['score'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      members: json['members'],
      rated: json['rated'],
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['mal_id'] = id;
    _data['url'] = url;
    _data['image_url'] = imageUrl;
    _data['title'] = title;
    _data['airing'] = airing;
    _data['synopsis'] = synopsis;
    _data['type'] = type;
    _data['episodes'] = episodes;
    _data['score'] = score;
    _data['start_date'] = startDate;
    _data['end_date'] = endDate;
    _data['members'] = members;
    _data['rated'] = rated;
    return _data;
  }
}
