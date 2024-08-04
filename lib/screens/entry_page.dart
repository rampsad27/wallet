import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallet_xuno/constants/app_colour.dart';
import 'package:wallet_xuno/constants/app_text.dart';
import 'package:wallet_xuno/screens/notification_dialog.dart';

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
  bool notifIsIconPressed = false;
  // bool searchIsIconPressed = false;

  final String notifIconNotfilled = 'assets/images/notification.png';
  final String notifIconFilled = 'assets/images/notification_filled.png';

  final String searchIconNotfilled = 'assets/images/search.png';
  final String searchIconFilled = 'assets/images/search_filled.png';

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
            onHover: (isHovered) {
              setState(() {
                notifIsIconPressed = !notifIsIconPressed;
              });
            },
            onTap: _toggleNotifIcon, // Call _toggleNotifIcon on tap
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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Appcolour.background,
              Appcolour.white,
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
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

                // leading: Image.network('https://picsum.photos/200'),

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
                    const AssetImage(
                        'assets/images/home.png'), // Changed to AssetImage
                    widget.selectedIndex == 0,
                    0,
                    context,
                  ),
                  _buildNavRailItem(
                    'Account',
                    const AssetImage(
                        'assets/images/account.png'), // Changed to AssetImage
                    widget.selectedIndex == 1,
                    1,
                    context,
                  ),
                  _buildNavRailItem(
                    'Recipients',
                    const AssetImage(
                        'assets/images/recipients.png'), // Changed to AssetImage
                    widget.selectedIndex == 2,
                    2,
                    context,
                  ),
                  _buildNavRailItem(
                    'Transactions',
                    const AssetImage(
                        'assets/images/transaction.png'), // Changed to AssetImage
                    widget.selectedIndex == 3,
                    3,
                    context,
                  ),
                  _buildNavRailItem(
                    'Requests',
                    const AssetImage(
                        'assets/images/request.png'), // Changed to AssetImage
                    widget.selectedIndex == 4,
                    4,
                    context,
                  ),
                  _buildNavRailItem(
                    'Banks',
                    const AssetImage(
                        'assets/images/banks.png'), // Changed to AssetImage
                    widget.selectedIndex == 5,
                    5,
                    context,
                  ),
                  _buildNavRailItem(
                    'Vouchers',
                    const AssetImage(
                        'assets/images/voucher.png'), // Changed to AssetImage
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
              // Main content on the right (end)
              // ignore: sized_box_for_whitespace
              Container(
                // color: Colors.teal.shade100,
                width: 730.w,
                child: widget.body,
              ),
              const Spacer(),
            ],
          ),
        ),
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
    });

    showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(
        0, //top
        0,
        0,
        0,
      ),
      //  RelativeRect.fromLTRB(
      //   MediaQuery.of(context).size.width - 50,
      //   kToolbarHeight,
      //   10,
      //   20,
      // ),

      items: [
        PopupMenuItem(
          child: ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notification 1'),
            onTap: () {
              Navigator.of(context).pop(); // Close the menu
              // Handle notification 1 tap
            },
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notification 2'),
            onTap: () {
              Navigator.of(context).pop(); // Close the menu
              // Handle notification 2 tap
            },
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notification 3'),
            onTap: () {
              Navigator.of(context).pop(); // Close the menu
              // Handle notification 3 tap
            },
          ),
        ),
      ],
      elevation: 8.0,
    );
  }
}
