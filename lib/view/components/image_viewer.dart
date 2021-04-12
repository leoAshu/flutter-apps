import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../model/comics_provider.dart';
import '../../utility/constants.dart';

class ImageViewer extends StatelessWidget {
  final String imgUrl;

  const ImageViewer(this.imgUrl);

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      boundaryMargin: const EdgeInsets.all(double.infinity),
      maxScale: 2.0,
      minScale: 0.99,
      child: Center(
        child: Image.network(
          imgUrl,
          fit: BoxFit.fitHeight,
          errorBuilder: (context, error, stackTrace) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '😢',
                style: TextStyle(
                  fontSize: 32,
                ),
              ),
              Text(
                Constants.imageError,
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.redAccent,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
