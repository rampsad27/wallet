import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallet_xuno/constants/app_colour.dart';
import 'package:wallet_xuno/constants/app_text.dart';

class ToggleableContainerScreen extends StatefulWidget {
  const ToggleableContainerScreen({super.key});

  @override
  State<ToggleableContainerScreen> createState() =>
      _ToggleableContainerScreenState();
}

class _ToggleableContainerScreenState extends State<ToggleableContainerScreen> {
  bool _isContainerVisible = false;

  void _toggleNotificationContainerVisibility() {
    setState(() {
      _isContainerVisible = !_isContainerVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Toggleable Container'),
        actions: [
          IconButton(
            onPressed: _toggleNotificationContainerVisibility,
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0.w),
            child: const Center(
              child: Text('Main Content Area'),
            ),
          ),
          if (_isContainerVisible)
            Positioned(
              top: AppBar().preferredSize.height +
                  16.h, // Positioning below the app bar
              right: 0, // Align to the right side
              width: 320.w, // Adjust width as needed
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Appcolour.background, Appcolour.white],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Notification',
                        style: AppText.notificationText,
                      ),
                      SizedBox(height: 10.h),
                      Container(
                          height: 130.h,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            color: Appcolour.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 3,
                                offset: Offset(0, 1),
                              ),
                            ],
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Title",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                Text(
                                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry.")
                              ],
                            ),
                          )),
                      SizedBox(height: 20.h),
                      Container(
                          height: 130.h,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            color: Appcolour.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 3,
                                offset: Offset(0, 1),
                              ),
                            ],
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Title",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                Text(
                                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry.")
                              ],
                            ),
                          )),
                      SizedBox(height: 20.h),
                      Container(
                          height: 130.h,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            color: Appcolour.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 3,
                                offset: Offset(0, 1),
                              ),
                            ],
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Title",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                Text(
                                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry.")
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
