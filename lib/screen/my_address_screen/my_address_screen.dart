import '../../utility/extensions.dart';
import 'package:flutter/material.dart';
import '../../utility/app_color.dart';
import '../../widget/custom_text_field.dart';

class MyAddressPage extends StatelessWidget {
  const MyAddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.profileProvider.retrieveSavedAddress();
    return Scaffold(
      backgroundColor: const Color(0xFFF2E7F9), // Màu nền tím hồng nhạt
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2E7F9), // Màu nền AppBar tím hồng nhạt
        elevation: 0, // Loại bỏ đổ bóng
        title: const Text(
          "Địa chỉ của tôi",
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColor.darkGrey),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: context.profileProvider.addressFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    surfaceTintColor: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextField(
                            labelText: 'Số Điện thoại',
                            textColor: Colors.black, // Màu chữ đen cho dễ đọc
                            labelColor:  Colors.black, // Màu label đen
                            onSave: (value) {},
                            inputType: TextInputType.number,
                            controller: context.profileProvider.phoneController,
                            validator: (value) =>
                            value!.isEmpty ? 'Nhập số điện thoại' : null,
                          ),
                          CustomTextField(
                            labelText: ' số nhà',
                            textColor: Colors.black,
                            labelColor: Colors.black,
                            onSave: (val) {},
                            controller: context.profileProvider.streetController,
                            validator: (value) =>
                            value!.isEmpty ? 'Nhập số nhà̉' : null,
                          ),
                          CustomTextField(
                            labelText: 'Thành phố',
                            textColor: Colors.black,
                            labelColor: Colors.black,
                            onSave: (value) {},
                            controller: context.profileProvider.cityController,
                            validator: (value) =>
                            value!.isEmpty ? 'Nhập thành phố' : null,
                          ),
                          CustomTextField(
                            labelText: 'Quận',
                            textColor: Colors.black,
                            labelColor: Colors.black,
                            onSave: (value) {},
                            controller: context.profileProvider.stateController,
                            validator: (value) =>
                            value!.isEmpty ? 'Nhập Quận' : null,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  labelText: 'Mã bưu điện',
                                  textColor: Colors.black,
                                  labelColor: Colors.black,
                                  onSave: (value) {},
                                  inputType: TextInputType.number,
                                  controller:
                                  context.profileProvider.postalCodeController,
                                  validator: (value) => value!.isEmpty
                                      ? 'Nhập mã bưu điện'
                                      : null,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: CustomTextField(
                                  labelText: 'Quốc tịch',
                                  textColor: Colors.black,
                                  labelColor: Colors.black,
                                  onSave: (value) {},
                                  controller:
                                  context.profileProvider.countryController,
                                  validator: (value) =>
                                  value!.isEmpty ? 'Quốc tịch' : null,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                        const Color(0xFF9966CC), // Màu nút tím đậm
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      onPressed: () {
                        if (context
                            .profileProvider.addressFormKey.currentState!
                            .validate()) {
                          context.profileProvider.storeAddress();
                        }
                      },
                      child: const Text('Chỉnh sửa địa chỉ',
                          style: TextStyle(fontSize: 18)),
                    ),
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