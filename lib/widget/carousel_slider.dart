import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../utility/app_color.dart';
import '../models/product.dart';
import '../utility/utility_extention.dart';
import 'custom_network_image.dart';

class CarouselSlider extends StatefulWidget {
  const CarouselSlider({
    super.key,
    required this.items,
  });

  final List<Images> items;

  @override
  State<CarouselSlider> createState() => _CarouselSliderState();
}

class _CarouselSliderState extends State<CarouselSlider> {
  int newIndex = 0;
  final _controller = PageController(); // Add a PageController

  @override
  void initState() {
    super.initState();
    // Start auto-sliding after a delay
    Future.delayed(const Duration(seconds: 2), () {
      _startAutoSlide();
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  Timer? _timer;

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (newIndex < widget.items.length - 1) {
        newIndex++;
      } else {
        newIndex = 0; // Go back to the first image
      }
      _controller.animateToPage(
        newIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        SizedBox(
          height: height * 0.32,
          child: Stack(
            children: [
              PageView.builder(
                controller: _controller,
                itemCount: widget.items.length,
                onPageChanged: (int currentIndex) {
                  setState(() {
                    newIndex = currentIndex;
                  });
                },
                itemBuilder: (_, index) {
                  return CustomNetworkImage(
                    imageUrl: widget.items.safeElementAt(index)?.url ?? '',
                    fit: BoxFit.cover,
                  );
                },
              ),
              Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: Center(
                  child: AnimatedSmoothIndicator(
                    effect: const WormEffect(
                      dotHeight: 8,
                      dotWidth: 8,
                      dotColor: Colors.grey,
                      activeDotColor: AppColor.darkOrange,
                    ),
                    count: widget.items.length,
                    activeIndex: newIndex,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}