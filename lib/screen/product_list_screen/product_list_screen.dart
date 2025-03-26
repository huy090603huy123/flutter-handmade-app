import 'dart:async';

import '../../core/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'custom_app_bar.dart';
import '../../../../widget/product_grid_view.dart';
import 'category_selector.dart';
import 'poster_section.dart';
import '../../utility/app_color.dart'; // Import AppColor

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColor.darkOrange.withOpacity(0.8), Colors.white], // Sử dụng AppColor
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Center(
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 3),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 8,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/logo.png', // Thay bằng logo của bạn
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      "Chào mừng bạn đến với Ngôi nhà Handmade",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 1),
                  Center(
                    child: Text(
                      "Hãy bắt đầu mua sắm nhé",
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const PosterSection(),
                  const SizedBox(height: 20),
                  Text(
                    "Kho tàng nghệ thuật thủ công",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  FlashSaleSection(),
                  Consumer<DataProvider>(
                    builder: (context, dataProvider, child) {
                      return CategorySelector(
                        categories: dataProvider.categories,
                      );
                    },
                  ),
                  Consumer<DataProvider>(
                    builder: (context, dataProvider, child) {
                      return ProductGridView(
                        items: dataProvider.products,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FlashSaleSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Flash Sale!",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        // Thêm widget hiển thị thời gian đếm ngược tại đây
        CountdownTimer(),
      ],
    );
  }
}

class CountdownTimer extends StatefulWidget {
  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  DateTime endTime = DateTime.now().add(const Duration(hours: 8)); // Ví dụ: Đếm ngược 8 tiếng

  @override
  void initState() {
    super.initState();
    // Cập nhật thời gian đếm ngược mỗi giây
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Duration remainingTime = endTime.difference(DateTime.now());
    return Text(
      "${remainingTime.inHours}:${remainingTime.inMinutes.remainder(60)}:${remainingTime.inSeconds.remainder(60)}",
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.red,
      ),
    );
  }
}