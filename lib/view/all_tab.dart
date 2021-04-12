import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utility/constants.dart';
import '../model/comic.dart';
import '../model/comics_provider.dart';
import './components/action_bar.dart';
import './components/image_viewer.dart';

class AllTab extends StatefulWidget {
  @override
  _AllTabState createState() => _AllTabState();
}

class _AllTabState extends State<AllTab> {
  bool isInit = true;
  bool isLoading = true;
  Comic comic;
  int latestComicId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isInit) {
      Provider.of<ComicsProvider>(context, listen: false)
          .loadComic(null)
          .then((_) {
        setState(() {
          this.isLoading = false;
        });
      });
      isInit = false;
    }
  }

  void setIsLoading(bool value) {
    setState(() {
      this.isLoading = value;
    });
  }

  Widget get favouriteButton {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, right: 12.0),
      child: Align(
          alignment: Alignment.topRight,
          child: InkWell(
            customBorder:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            onTap: () {
              final SnackBar snackBar = SnackBar(
                content: Text(comic.isFavourite
                    ? Constants.removeFromFavSuccess
                    : Constants.addToFavSuccess),
                action: SnackBarAction(
                  onPressed: () {},
                  label: Constants.actionOkLabel,
                  textColor: Colors.amber,
                ),
              );
              Provider.of<ComicsProvider>(context, listen: false)
                  .updateFavStatus(this.comic)
                  .then((_) =>
                      ScaffoldMessenger.of(context).showSnackBar(snackBar));
            },
            child: Card(
              color: Constants.bgColor,
              shadowColor: Constants.primaryColor,
              elevation: 20,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  comic.isFavourite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.redAccent,
                  size: 32,
                ),
              ),
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    comic = Provider.of<ComicsProvider>(context).comic;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ActionBar(setIsLoading),
          Container(
              width: screenWidth,
              height: screenWidth,
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Stack(children: [
                      Card(
                          shadowColor: Constants.primaryColor,
                          color: Constants.bgColor,
                          elevation: 20,
                          child: ImageViewer(this.comic.imgUrl)),
                      favouriteButton
                    ])),
          ActionBar(setIsLoading)
        ],
      ),
    );
  }
}
