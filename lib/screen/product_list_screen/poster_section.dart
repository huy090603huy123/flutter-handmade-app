import 'package:handmade_app/utility/extensions.dart';
import '../../core/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../utility/app_data.dart';
import '../../utility/animation/open_container_wrapper.dart';
import '../../widget/navigation_tile.dart';
import '../product_details_screen/product_detail_screen.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:carousel_slider/carousel_slider.dart';

class PosterSection extends StatelessWidget {
  const PosterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: Consumer<DataProvider>(
        builder: (context, dataProvider, child) {
          return CarouselSlider.builder(
            itemCount: dataProvider.posters.length,
            itemBuilder: (BuildContext context, int index, int realIndex) {
              return Padding(
                padding: const EdgeInsets.only(right: 20, top: 10, bottom: 10),
                child: GestureDetector(
                  onTap: () {
                    // Handle tap on poster
                    // For example, navigate to a detailed page
                  },
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      // Background with gradient and subtle pattern
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              AppData.randomPosterBgColors[index].withOpacity(0.8),
                              AppData.randomPosterBgColors[index].withOpacity(0.5),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: AppData.randomPosterBgColors[index].withOpacity(0.4),
                              spreadRadius: 2,
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                      ),

                      // Glassmorphic layer for a modern effect
                      GlassmorphicContainer(
                        width: double.infinity,
                        height: double.infinity,
                        borderRadius: 25,
                        blur: 10,
                        alignment: Alignment.bottomLeft,
                        border: 2,
                        linearGradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withOpacity(0.2),
                            Colors.white30.withOpacity(0.2),
                          ],
                          stops: const [0.0, 1.0],
                        ),
                        borderGradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withOpacity(0.5),
                            Colors.white.withOpacity(0.5),
                          ],
                        ),
                        child: Container(),
                      ),

                      // Product Image with elevated shadow
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Image.network(
                          '${dataProvider.posters[index].imageUrl}',
                          height: 180,
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                          errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                            return const Icon(Icons.error, color: Colors.red);
                          },
                        ),
                      ),

                      // Text and CTA with custom layout and style
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${dataProvider.posters[index].posterName}',
                              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    blurRadius: 5.0,
                                    color: Colors.black.withOpacity(0.3),
                                    offset: const Offset(2.0, 2.0),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            // Custom designed CTA button
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: const Text(
                                "SHOP NOW",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            options: CarouselOptions(
              height: 220,
              viewportFraction: 0.85,
              initialPage: 0,
              enableInfiniteScroll: true,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 5),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
            ),
          );
        },
      ),
    );
  }
}