import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wallet_xuno/constants/app_colour.dart';
import 'package:wallet_xuno/screens/side_bar.dart';
import 'package:wallet_xuno/screens/tabbed_page.dart';

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

  bool notifIsIconPressed = false;
  bool searchIsIconPressed = false;

  final String notifIconNotfilled = 'assets/images/notification.png';
  final String notifIconFilled = 'assets/images/notification_filled.png';

  final String searchIconNotfilled = 'assets/images/search.png';
  final String searchIconFilled = 'assets/images/search_filled.png';

  void _toggleNotifIcon() {
    setState(() {
      notifIsIconPressed = !notifIsIconPressed;
    });
  }

  void _toggleSearchIcon() {
    setState(() {
      searchIsIconPressed = !searchIsIconPressed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Appcolour.background, Appcolour.white],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: AppBar(
                shadowColor: Colors.black,
                elevation: 8, // rajm
                backgroundColor: Appcolour.white,
                actions: [
                  const SizedBox(width: 50),
                  SvgPicture.asset(
                    'assets/svg/logo.svg',
                    height: 20,
                    width: 50,
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: _toggleSearchIcon,
                    child: Image.asset(
                      searchIsIconPressed
                          ? searchIconFilled
                          : searchIconNotfilled,
                      height: 30,
                      width: 30,
                    ),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: _toggleNotifIcon,
                    child: Image.asset(
                      notifIsIconPressed ? notifIconFilled : notifIconNotfilled,
                      height: 28,
                      width: 28,
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
            Padding(
              padding: const EdgeInsets.all(44.0),
              child: SizedBox(
                // color: const Color.fromARGB(255, 208, 154, 172),
                height: 700.h,
                width: 1780.w,
                child: Row(
                  children: [
                    if (isDesktop(context))
                      SizedBox(width: 300.w, child: const SideBar()),
                    const Spacer(),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: 760.w,
                      ),
                      child: const TabbedScreen(),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: isMobile(context) ? const Drawer(child: SideBar()) : null,
    );
  }
}
