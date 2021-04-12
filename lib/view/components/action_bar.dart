import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/comics_provider.dart';
import '../../utility/constants.dart';

class ActionBar extends StatefulWidget {
  final Function setLoadingCallback;

  ActionBar(this.setLoadingCallback);

  @override
  _ActionBarState createState() => _ActionBarState();
}

class _ActionBarState extends State<ActionBar> {
  @override
  Widget build(BuildContext context) {
    final comic = Provider.of<ComicsProvider>(context).currentComic;
    final latestComicId = Provider.of<ComicsProvider>(context).latestComicIndex;
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 8),
              ),
              onPressed: comic == null || comic.id != 1
                  ? () {
                      widget.setLoadingCallback(true);
                      Provider.of<ComicsProvider>(context, listen: false)
                          .loadComic(1)
                          .then((_) {
                        widget.setLoadingCallback(false);
                      });
                    }
                  : null,
              child: Icon(Icons.fast_rewind_outlined)),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.only(left: 8, right: 16)),
            child: Row(
              children: [
                Icon(Icons.keyboard_arrow_left),
                Text(Constants.actionPrevLabel)
              ],
            ),
            onPressed: comic == null || comic.id != 1
                ? () {
                    widget.setLoadingCallback(true);
                    Provider.of<ComicsProvider>(context, listen: false)
                        .loadComic(comic.id - 1)
                        .then((_) {
                      widget.setLoadingCallback(false);
                    });
                  }
                : null,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 12)),
              child: Text(Constants.actionRandomLabel),
              onPressed: () {
                widget.setLoadingCallback(true);
                final id = Random().nextInt(latestComicId) + 1;
                Provider.of<ComicsProvider>(context, listen: false)
                    .loadComic(id)
                    .then((_) {
                  widget.setLoadingCallback(false);
                });
              }),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.only(left: 16, right: 8)),
            child: Row(children: [
              Text(Constants.actionNextLabel),
              Icon(Icons.keyboard_arrow_right)
            ]),
            onPressed: comic == null || comic.id != latestComicId
                ? () {
                    widget.setLoadingCallback(true);
                    Provider.of<ComicsProvider>(context, listen: false)
                        .loadComic(comic.id + 1)
                        .then((_) {
                      widget.setLoadingCallback(false);
                    });
                  }
                : null,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 8)),
            child: Icon(Icons.fast_forward_outlined),
            onPressed: comic == null || comic.id != latestComicId
                ? () {
                    widget.setLoadingCallback(true);
                    Provider.of<ComicsProvider>(context, listen: false)
                        .loadComic(latestComicId)
                        .then((_) {
                      widget.setLoadingCallback(false);
                    });
                  }
                : null,
          ),
        ],
      ),
    );
  }
}
