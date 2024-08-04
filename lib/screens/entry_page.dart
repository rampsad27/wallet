import 'package:flutter/material.dart';
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

  void _toggleNotifIcon() {
    setState(() {
      notifIsIconPressed = !notifIsIconPressed;
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const NotificationDialog();
      },
    );
  }

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
      body: Row(
        children: [
          MediaQuery.removePadding(
            context: context,
            removeLeft: false,
            removeTop: true,
            removeRight: true,
            removeBottom: true,
            child: NavigationRail(
              selectedIndex: widget.selectedIndex,
              extended: false,
              // leading: Image.network('https://picsum.photos/200'),

              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(
                    thickness: 1,
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
              minWidth: MediaQuery.of(context).size.width * 0.2,
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
          ),
          const VerticalDivider(
            thickness: 1,
            width: 1,
            indent: 70,
            endIndent: 104,
          ),
          // Main content on the right (end)
          Expanded(
            child: widget.body,
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
                    color: isSelected ? Appcolour.green : Appcolour.black,
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
}
