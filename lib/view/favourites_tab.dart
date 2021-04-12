import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xkcd/view/components/favorite_item.dart';
import '../model/comics_provider.dart';
import '../model/comic.dart';
import '../utility/constants.dart';

class FavoritesTab extends StatefulWidget {
  @override
  _FavoritesTabState createState() => _FavoritesTabState();
}

class _FavoritesTabState extends State<FavoritesTab> {
  List<Comic> favourites;

  @override
  Widget build(BuildContext context) {
    favourites = Provider.of<ComicsProvider>(context).favouriteComics;
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: favourites == null || favourites.isEmpty
            ? Center(
                child: Text(
                Constants.emptyFavList,
                style: TextStyle(color: Constants.contrastColor, fontSize: 20),
              ))
            : SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: List.generate(favourites.length, (index) {
                    final comic = favourites[index];
                    return Dismissible(
                      key: UniqueKey(),
                      background: Container(
                        color: Constants.secondaryColor,
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 40,
                        ),
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                      ),
                      direction: DismissDirection.endToStart,
                      onDismissed: (_) {
                        Provider.of<ComicsProvider>(context, listen: false)
                            .removeFavorite(comic.id);
                      },
                      child: FavoriteItemCard(index: index, comic: comic),
                    );
                  }),
                ),
              ));
  }
}
