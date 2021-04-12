import 'package:flutter/material.dart';

class Comic {
  int id;
  String title;
  String alt;
  String imgUrl;
  bool isFavourite;

  Comic(
      {@required this.id,
      @required this.title,
      @required this.alt,
      @required this.imgUrl,
      @required this.isFavourite});

  Comic.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.title = map['title'];
    this.alt = map['alt'];
    this.imgUrl = map['imgUrl'];
    this.isFavourite = map['isFavourite'] == 1;
  }

  Map<String, dynamic> comicToMap() {
    final map = Map<String, dynamic>();
    map['id'] = this.id;
    map['title'] = this.title;
    map['alt'] = this.alt;
    map['imgUrl'] = this.imgUrl;
    map['isFavourite'] = this.isFavourite == true ? 1 : 0;

    return map;
  }

  void toggleFavStatus() {
    this.isFavourite = !this.isFavourite;
  }
}



// {"month": "4", "num": 2447, "link": "", "year": "2021", "news": "", "safe_title": "Hammer Incident", "transcript": "", "alt": "I still think the Cold Stone Creamery partnership was a good idea, but I should have asked before doing the first market trials during the cryogenic mirror tests.", "img": "https://imgs.xkcd.com/comics/hammer_incident.png", "title": "Hammer Incident", "day": "7"}