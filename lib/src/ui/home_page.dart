import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../blocs/cat_images_bloc.dart';
import '../blocs/cat_images_event.dart';
import '../blocs/cat_images_state.dart';
import '../models/cat_image.dart';
import 'cat_detail_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late CatImagesBloc _catImagesBloc;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _catImagesBloc = Provider.of<CatImagesBloc>(context, listen: false);
    _catImagesBloc.onEvent(LoadCatImages());

    _searchController.addListener(() {
      _catImagesBloc.eventSink.add(FilterCatImages(_searchController.text));
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _catImagesBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Catbreeds'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search...',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          StreamBuilder<CatImagesState>(
            stream: _catImagesBloc.stateStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError || snapshot.data is CatImagesError) {
                final error = snapshot.error ?? 'An error occurred';
                return Center(child: Text('Error: $error'));
              } else if (snapshot.data is CatImagesLoading) {
                return const LinearProgressIndicator();
              } else if (snapshot.data is CatImagesLoaded) {
                final state = snapshot.data as CatImagesLoaded;
                final catImages = state.images;

                return Expanded(child: buildIMage(catImages));
              }

              return const Center(child: Text('No cat images available'));
            },
          )
        ],
      ),
    );
  }

  GridView buildIMage(List<CatImage> catImages) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        crossAxisSpacing: 30,
        mainAxisSpacing: 10,
      ),
      itemCount: catImages.length,
      itemBuilder: (context, index) {
        final catImage = catImages[index];

        return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CatDetailsPage(catImage: catImage),
                ),
              );
            },
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Breed: ${catImage.breeds?[0].name}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        'Ver más...',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Image.network(catImage.url, fit: BoxFit.cover, height: 300),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Origin: ${catImage.breeds?[0].origin}'),
                      Text('Intelligence: ${catImage.breeds?[0].intelligence}')
                    ],
                  )
                ],
              ),
            ));
      },
    );
  }
}
