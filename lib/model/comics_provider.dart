import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:xkcd/utility/constants.dart';
import './comic.dart';
import './comics_database.dart';

class ComicsProvider with ChangeNotifier {
  Comic comic;
  List<Comic> favouriteComics;
  int totalComics;
  Dio dio;

  Future<void> loadComic(int id) async {
    if (dio == null) {
      dio = Dio();
    }

    // id == null ==> load latest comic
    if (id == null) {
      // ensures that the latest comic is loaded only the first time.
      if (comic == null) {
        // loading the favorites list the first time
        await loadFavourites();

        final url = Constants.apiDomain + Constants.apiEndpoint;

        // api call
        var response = await dio.get(url);

        if (response.statusCode == 200) {
          final responseData = response.data;
          final comicId = responseData['num'];

          // checking and fetching the loaded comic from the database
          this.comic = await ComicsDatabase.getInstance().fetchComic(comicId);

          if (this.comic == null) {
            // loaded comic not present in database
            // mapping the response data to the comic object
            this.comic = Comic(
                id: responseData['num'],
                title: responseData['title'],
                imgUrl: responseData['img'],
                alt: responseData['alt'],
                isFavourite: false);

            // inserting the comic into the database
            ComicsDatabase.getInstance().insertComic(this.comic);
          }
          // setting the total number of comics as the id of the latest comic
          this.totalComics = this.comic.id;
        } else {
          print(response.statusMessage);
        }
      } else {
        // the latest comic already loaded and present in the memory
        print('No need to load');
      }
    } else {
      // loading a specific comic by id
      // checking and fetching the comic from database
      final comic = await ComicsDatabase.getInstance().fetchComic(id);

      if (comic != null) {
        this.comic = comic;
      } else {
        // comic not present in database

        final url = Constants.apiDomain + '/$id' + Constants.apiEndpoint;

        // api call
        var response = await dio.get(url);

        if (response.statusCode == 200) {
          final responseData = response.data;
          this.comic = Comic(
              id: responseData['num'],
              title: responseData['title'],
              imgUrl: responseData['img'],
              alt: responseData['alt'],
              isFavourite: false);

          // inserting the loaded comic into the database
          ComicsDatabase.getInstance().insertComic(this.comic);
        } else {
          print(response.statusMessage);
        }
      }
    }
  }

  Future<void> updateFavStatus(Comic oldComic) async {
    this.comic.toggleFavStatus();

    if (!this.comic.isFavourite) {
      // comic present in the favorites list

      this
          .favouriteComics
          .removeWhere((element) => element.id == this.comic.id);
    } else {
      // comic not present in the favorites list

      this.favouriteComics.add(this.comic);
    }
    // updating the favorite status of the comic in the database
    await ComicsDatabase.getInstance().updateComic(oldComic);

    notifyListeners();
  }

  Future<void> loadFavourites() async {
    this.favouriteComics =
        await ComicsDatabase.getInstance().fetchFavouriteComics();

    if (this.favouriteComics == null) {
      this.favouriteComics = [];
    }
  }

  Future<void> removeFavorite(int id) async {
    final idx = this.favouriteComics.indexWhere((element) => element.id == id);

    final Comic comic = this.favouriteComics[idx];
    this.favouriteComics.removeAt(idx);

    comic.toggleFavStatus();
    await ComicsDatabase.getInstance().updateComic(comic);
    notifyListeners();
  }

  Comic get currentComic {
    if (this.comic == null) {
      return null;
    }
    return this.comic;
  }

  Future<List<Comic>> get favourites async {
    if (favouriteComics == null) {
      return null;
    }
    return [...this.favouriteComics];
  }

  int get latestComicIndex {
    return totalComics;
  }
}
