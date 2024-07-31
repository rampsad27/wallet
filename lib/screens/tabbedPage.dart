import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wallet_xuno/widgets/button_container.dart';
import 'package:wallet_xuno/widgets/container.dart';
import 'package:wallet_xuno/widgets/tabbar_textfield.dart';

class TabbedScreen extends StatelessWidget {
  const TabbedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const TabBar(
            indicatorColor: Colors.red,
            labelColor: Colors.black,
            tabs: [
              Tab(text: 'USD to NPR'),
              Tab(text: 'USD to USD'),
              Tab(text: 'Send Now Convert Later'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // First Tab - USD to NPR
            MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: const SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MyInputTextField(
                          title: "You Sent",
                          value: 1000.00,
                          inputType: TextInputType.number,
                          suffixIcon: Icon(Icons.usb),
                        ),
                        MyInputTextField(
                          title: "Recipient Gets",
                          value: 132694.00,
                          inputType: TextInputType.number,
                          suffixIcon: Icon(Icons.near_me),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomButtonContainer(
                          height: 100,
                          width: 100,
                          text: "Instant",
                        ),
                        CustomButtonContainer(
                          height: 100,
                          width: 100,
                          text: "Same Day",
                        ),
                        CustomButtonContainer(
                          height: 100,
                          width: 100,
                          text: "Standard",
                        ),
                        CustomButtonContainer(
                          height: 100,
                          width: 100,
                          text: "Best Deal",
                          icon: Icon(Icons.star_border_purple500),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    CustomContainer(
                      height: 120,
                      width: 420,
                      text: "Message regarding delivery limits",
                      borderColor: Colors.red,
                      backgroundColor: Colors.transparent,
                      textColor: Colors.red,
                    ),
                    CustomContainer(
                      height: 120,
                      width: 420,
                      text: "Msdf",
                      borderColor: Colors.transparent,
                      backgroundColor: Color.fromARGB(255, 221, 237, 222),
                      textColor: Colors.black,
                    ),
                    SizedBox(height: 20),
                    CustomContainer(
                      height: 20,
                      width: 420,
                      text: "Msdf",
                      borderColor: Colors.transparent,
                      backgroundColor: Color.fromARGB(255, 221, 237, 222),
                      textColor: Colors.black,
                    ),
                    CustomContainer(
                      height: 20,
                      width: 420,
                      text: "You just saved",
                      borderColor: Colors.transparent,
                      backgroundColor: Color.fromARGB(255, 221, 237, 222),
                      textColor: Colors.black,
                    ),
                    CustomButtonContainer(
                      height: 40,
                      width: 200,
                      text: "Continue",
                    ),
                  ],
                ),
              ),
            ),
            // Second Tab - USD to USD
            MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: const Center(child: Text("USD to USD")),
            ),
            // Third Tab - Send Now Convert Later
            MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: const Center(child: Text("Send Now Convert Later")),
            ),
          ],
        ),
      ),
    );
  }
}
