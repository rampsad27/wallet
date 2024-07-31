import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wallet_xuno/constants/appColour.dart';
import 'package:wallet_xuno/screens/sideBar.dart';
import 'package:wallet_xuno/screens/tabbedPage.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 600;
  }

  bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 235, 246, 230),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          child: AppBar(
            shadowColor: const Color.fromARGB(255, 0, 0, 0),
            // elevation: 5,
            backgroundColor: Colors.white,
            actions: [
              const SizedBox(width: 50),
              SvgPicture.asset(
                'assets/svg/logo.svg',
                height: 20,
                width: 50,
              ),
              const Spacer(),
              InkWell(
                onTap: () {},
                child: Image.asset(
                  'assets/images/search.png',
                  height: 32,
                  width: 32,
                ),
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: () {},
                child: Image.asset(
                  'assets/images/notification.png',
                  height: 30,
                  width: 30,
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.person,
                  color: Appcolour.primaryLogo,
                ),
                onPressed: () {},
              ),
              const SizedBox(width: 20),
            ],
          ),
        ),
      ),
      body: Row(
        children: [
          if (isDesktop(context))
            const Center(
                child: SizedBox(height: 566, width: 300, child: SideBar())),
          Expanded(
            child: Container(
              color: Colors.yellow,
              height: 673,
              width: 1480,
              padding: const EdgeInsets.fromLTRB(120, 0, 120, 0),
              child: const Center(
                child: TabbedScreen(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
