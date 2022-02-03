import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_days_mvvm_architecture/presentation/screens/anime/view_model/anime_search_cubit.dart';
import 'package:mobile_days_mvvm_architecture/presentation/screens/anime/view_model/anime_search_state.dart';

import 'anime_list_item.dart';

class BlocSelectorAnimeList extends StatelessWidget {
  const BlocSelectorAnimeList({
    Key? key,
    this.verticalSpace = 16,
    this.horizontalSpace = 24,
  }) : super(key: key);

  final double verticalSpace;
  final double horizontalSpace;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AnimeSearchCubit, AnimeSearchState, AnimeSearchState>(
      selector: (state) => state,
      builder: (context, state) {
        if (state is AnimeSearchLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AnimeSearchError) {
          return Center(child: Text(state.error ?? '-'));
        } else if (state is AnimeSearchSuccess) {
          return Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: verticalSpace,
              crossAxisSpacing: horizontalSpace,
              childAspectRatio: (140 / 168),
              controller: ScrollController(keepScrollOffset: false),
              shrinkWrap: true,
              children: List.generate(state.animeList?.length ?? 0, (index) {
                return AnimeListItem(item: state.animeList?[index]);
              }),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
