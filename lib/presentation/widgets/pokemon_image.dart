import 'package:flutter/material.dart';
import 'package:pokemon_app/core/ui/utils/image_util.dart';

class PokemonImage extends StatelessWidget {
  final bool isOnline;
  final String imgUrl;
  final double width;
  final double height;

  const PokemonImage({
    Key? key,
    required this.isOnline,
    required this.imgUrl,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isOnline
        ? Image.network(
            imgUrl,
            width: width,
            height: height,
            fit: BoxFit.fill,
            frameBuilder:
                (BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded) =>
                    wasSynchronouslyLoaded
                        ? child
                        : AnimatedOpacity(
                            opacity: frame == null ? 0 : 1,
                            duration: const Duration(seconds: 2),
                            curve: Curves.easeOut,
                            child: child,
                          ),
            loadingBuilder: (context, child, progress) =>
                progress == null ? child : const CircularProgressIndicator(),
            errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) =>
                const Text('Failed to load image'),
          )
        : Image.memory(
            Utility.dataFromBase64String(
              imgUrl,
            ),
            width: width,
            height: height,
            fit: BoxFit.fill,
          );
  }
}
