import 'package:flutter/material.dart';
import '../../utility/constants.dart';
import '../../model/comic.dart';

class FavoriteItemCard extends StatelessWidget {
  final int index;
  final Comic comic;

  const FavoriteItemCard({this.index, this.comic});

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Constants.primaryColor,
      elevation: 4,
      child: ListTile(
        onTap: () {
          showModalBottomSheet(
              backgroundColor: Constants.bgColor,
              elevation: 8,
              isDismissible: true,
              context: context,
              builder: (context) {
                return Container(
                  child: InteractiveViewer(
                      child: Center(
                          child: Image.network(
                    comic.imgUrl,
                    fit: BoxFit.fitHeight,
                  ))),
                );
              });
        },
        leading: Container(
          height: 38,
          width: 38,
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: Constants.secondaryColor),
          child: Center(
            child: FittedBox(
              child: Text(
                '${index + 1}',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ),
        title: Text(
          comic.title,
          style: TextStyle(
              color: Constants.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 20),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            comic.alt,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        dense: true,
      ),
    );
  }
}
