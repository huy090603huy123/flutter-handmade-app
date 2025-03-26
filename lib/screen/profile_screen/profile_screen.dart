import '../login_screen/login_screen.dart';
import '../my_address_screen/my_address_screen.dart';
import '../../utility/animation/open_container_wrapper.dart';
import '../../utility/extensions.dart';
import '../../widget/navigation_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utility/app_color.dart';
import '../my_order_screen/my_order_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Assuming your theme and colors are defined elsewhere in your app
    const TextStyle linkStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.w600);
    const TextStyle titleStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.darkOrange,
        title: const Text(
          "Quản lý tài khoản",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColor.darkOrange.withOpacity(0.8), Colors.white],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SizedBox(height: 40),
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/profile_pic.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.edit, color: AppColor.darkOrange),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Text(
                    "${context.userProvider.getLoginUsr()?.name}",
                    style: titleStyle,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "${context.userProvider.getLoginUsr()?.name}",
                    style: const TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            _buildNavigationButton(context, Icons.list, 'Danh sách đơn hàng', const MyOrderScreen()),
            const SizedBox(height: 15),
            _buildNavigationButton(context, Icons.location_on, 'Thông tin khách hàng', const MyAddressPage()),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: () {
                  // Add logout confirmation dialog
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Đăng Xuất"),
                        content: const Text("Bạn có chắc chắn muốn đăng xuất?"),
                        actions: <Widget>[
                          TextButton(
                            child: const Text("Hủy", style: TextStyle(color: Colors.black)),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: const Text("Đăng Xuất", style: TextStyle(color: Colors.red)),
                            onPressed: () {
                              context.userProvider.logOutUser();
                              Get.offAll(const LoginScreen());
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(Icons.logout),
                label: const Text('Đăng Xuất', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationButton(BuildContext context, IconData icon, String title, Widget nextScreen) {
    return OpenContainerWrapper(
      nextScreen: nextScreen,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 8,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColor.darkOrange),
            const SizedBox(width: 20),
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}