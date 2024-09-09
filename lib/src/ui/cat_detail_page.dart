import 'package:flutter/material.dart';

import '../models/cat_image.dart';

class CatDetailsPage extends StatelessWidget {
  final CatImage catImage;

  const CatDetailsPage({required this.catImage});

  @override
  Widget build(BuildContext context) {
    final breed = (catImage.breeds != null && catImage.breeds!.isNotEmpty)
        ? catImage.breeds![0]
        : null;

    return Scaffold(
      appBar: AppBar(
        title: Text(breed?.name ?? 'Catbreed'),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            top: 300,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (breed != null) ...[
                      Text('Description: ${breed.description}',
                          style: Theme.of(context).textTheme.displayMedium),
                      const SizedBox(height: 8),
                    ] else ...[
                      Text('Unknown',
                          style: Theme.of(context).textTheme.titleMedium),
                    ],
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 300,
            child: Image.network(
              catImage.url,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
