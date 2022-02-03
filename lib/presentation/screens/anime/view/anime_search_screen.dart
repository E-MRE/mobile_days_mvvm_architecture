import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mobile_days_mvvm_architecture/presentation/screens/anime/view_model/anime_search_cubit.dart';
import 'package:mobile_days_mvvm_architecture/presentation/screens/anime/view_model/anime_search_state.dart';
import 'package:mobile_days_mvvm_architecture/presentation/widgets/bloc_selector_anime_list.dart';
import 'package:mobile_days_mvvm_architecture/utils/constants/assets_contants.dart';
import 'package:mobile_days_mvvm_architecture/utils/decorations/empty_space.dart';
import 'package:mobile_days_mvvm_architecture/presentation/widgets/anime_search_bar.dart';
import 'package:mobile_days_mvvm_architecture/presentation/widgets/default_scaffold.dart';
import 'package:mobile_days_mvvm_architecture/presentation/widgets/sub_title.dart';

class AnimeSearchScreen extends StatelessWidget {
  AnimeSearchScreen({Key? key}) : super(key: key);

  final String _description =
      'İstediğiniz animeyi arayarak bulabilir ve detaylarına ulaşabilirsiniz.';

  final EdgeInsetsGeometry _pagePadding =
      const EdgeInsets.all(40).copyWith(bottom: 16);

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      padding: _pagePadding,
      body: BlocProvider(
        create: (context) => AnimeSearchCubit(),
        child: BlocConsumer<AnimeSearchCubit, AnimeSearchState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                _buildIcon(),
                const EmptySpace.bigHeigh(),
                const SubTitle(text: 'Anime Ara', align: TextAlign.left),
                const EmptySpace.normalHeigh(),
                _buildDescription(context),
                const EmptySpace.normalHeigh(),
                AnimeSearchBar(
                    onSearched: (query) async =>
                        context.read<AnimeSearchCubit>().searchAnime(query)),
                const EmptySpace.veryBigHeigh(),
                const BlocSelectorAnimeList(),
              ],
            );
          },
        ),
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
