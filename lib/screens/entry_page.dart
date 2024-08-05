import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallet_xuno/constants/app_colour.dart';
import 'package:wallet_xuno/constants/app_text.dart';

class ScaffoldWithNavigationRail extends StatefulWidget {
  const ScaffoldWithNavigationRail({
    super.key,
    required this.body,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });
  final Widget body;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  State<ScaffoldWithNavigationRail> createState() =>
      _ScaffoldWithNavigationRailState();
}

class _ScaffoldWithNavigationRailState
    extends State<ScaffoldWithNavigationRail> {
  bool _isContainerVisible = false;

  bool notifIsIconPressed = false;

  final String notifIconNotfilled = 'assets/images/notification.png';
  final String notifIconFilled = 'assets/images/notification_filled.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        shadowColor: Appcolour.background,
        surfaceTintColor: Colors.transparent,
        elevation: 6,
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
            onTap: _toggleNotifIcon,
            child: Image.asset(
              notifIsIconPressed ? notifIconFilled : notifIconNotfilled,
              height: 28,
              width: 28,
            ),
          ),
          const SizedBox(width: 12),
          InkWell(
            onTap: () {},
            child: Image.asset(
              'assets/images/person.png',
              height: 28,
              width: 28,
            ),
          ),
          const SizedBox(width: 32),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Appcolour.background,
                  Appcolour.white,
                ],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(56, 34, 0, 12),
              child: Row(
                children: [
                  NavigationRail(
                    selectedIndex: widget.selectedIndex,
                    extended: false,
                    backgroundColor: Colors.transparent,
                    trailing: SizedBox(
                      width: 300.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Divider(
                            thickness: 1,
                            color: Colors.grey.shade200,
                          ),
                          TextButton(
                              onPressed: () {},
                              child: Text(
                                'Review limit breakdown',
                                style: AppText.hindText,
                              )),
                          TextButton(
                              onPressed: () {},
                              child: Text(
                                'Contact us anytime for help',
                                style: AppText.hindText,
                              )),
                        ],
                      ),
                    ),
                    minWidth: 300.w,
                    onDestinationSelected: widget.onDestinationSelected,
                    labelType: NavigationRailLabelType.none,
                    destinations: [
                      _buildNavRailItem(
                        'Home',
                        const AssetImage('assets/images/home.png'),
                        widget.selectedIndex == 0,
                        0,
                        context,
                      ),
                      _buildNavRailItem(
                        'Account',
                        const AssetImage('assets/images/account.png'),
                        widget.selectedIndex == 1,
                        1,
                        context,
                      ),
                      _buildNavRailItem(
                        'Recipients',
                        const AssetImage('assets/images/recipients.png'),
                        widget.selectedIndex == 2,
                        2,
                        context,
                      ),
                      _buildNavRailItem(
                        'Transactions',
                        const AssetImage('assets/images/transaction.png'),
                        widget.selectedIndex == 3,
                        3,
                        context,
                      ),
                      _buildNavRailItem(
                        'Requests',
                        const AssetImage('assets/images/request.png'),
                        widget.selectedIndex == 4,
                        4,
                        context,
                      ),
                      _buildNavRailItem(
                        'Banks',
                        const AssetImage('assets/images/banks.png'),
                        widget.selectedIndex == 5,
                        5,
                        context,
                      ),
                      _buildNavRailItem(
                        'Vouchers',
                        const AssetImage('assets/images/voucher.png'),
                        widget.selectedIndex == 6,
                        6,
                        context,
                      ),
                    ],
                  ),
                  VerticalDivider(
                    thickness: 1,
                    width: 1,
                    indent: 16,
                    endIndent: 164,
                    color: Colors.grey.shade200,
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 730.w,
                    child: widget.body,
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
          if (_isContainerVisible)
            Positioned(
              top: AppBar().preferredSize.height + 16.h, // Below the app bar
              right: 54, // Align to the right side
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

  NavigationRailDestination _buildNavRailItem(
      String text,
      ImageProvider imageData,
      bool isSelected,
      int itemIndex,
      BuildContext context) {
    return NavigationRailDestination(
      icon: InkWell(
        borderRadius: BorderRadius.circular(4),
        splashColor: Appcolour.backgroundContainer,
        onTap: () {
          widget.onDestinationSelected(itemIndex);
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.2,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color:
                isSelected ? Appcolour.backgroundContainer : Colors.transparent,
          ),
          child: Row(
            children: [
              Image(
                image: imageData,
                height: 16, // Adjust height as needed
                width: 16, // Adjust width as needed
              ),
              const SizedBox(width: 8),
              Text(text,
                  style: GoogleFonts.hind(
                    color: isSelected
                        ? Appcolour.textGreenSidebar
                        : Appcolour.black,
                    fontSize: isSelected ? 16 : 14,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  )),
            ],
          ),
        ),
      ),
      label: const SizedBox.shrink(),
    );
  }

  void _toggleNotifIcon() {
    setState(() {
      notifIsIconPressed = !notifIsIconPressed;
      _isContainerVisible = !_isContainerVisible;
    });
  }
}
