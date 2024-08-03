import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wallet_xuno/constants/app_colour.dart';
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
  bool searchIsIconPressed = false;

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
              // Handle hover state here if needed
              // For example, you might want to change the icon when hovered
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
            removeLeft: true,
            removeTop: true,
            removeRight: true,
            removeBottom: true,
            child: NavigationRail(
              selectedIndex: widget.selectedIndex,
              extended: false,
              // leading: Image.network('https://picsum.photos/200'),
              trailing: Expanded(
                  child: Column(
                children: [
                  const Spacer(),
                  TextButton(onPressed: () {}, child: const Text('kk kk')),
                ],
              )),
              minWidth: MediaQuery.of(context).size.width * 0.2,
              onDestinationSelected: widget.onDestinationSelected,
              labelType: NavigationRailLabelType.none,
              destinations: [
                _buildNavRailItem(
                  'Home',
                  Icons.home,
                  widget.selectedIndex == 0,
                  0,
                  context,
                ),
                _buildNavRailItem(
                  'Settings',
                  Icons.settings,
                  widget.selectedIndex == 1,
                  1,
                  context,
                ),
              ],
            ),
          ),
          const VerticalDivider(thickness: 1, width: 1),
          // Main content on the right (end)
          Expanded(
            child: widget.body,
          ),
        ],
      ),
    );
  }

  /// Builds a [NavigationRailDestination] widget for the navigation rail.
  ///
  /// The [text] parameter represents the text to be displayed on the navigation
  /// rail item.
  ///
  /// The [iconData] parameter represents the icon to be displayed on the
  /// navigation rail item.
  ///
  /// The [isSelected] parameter indicates whether the navigation rail item is
  /// currently selected.
  ///
  /// The [itemIndex] parameter represents the index of the navigation rail item.
  ///
  /// The [context] parameter represents the build context.
  ///
  /// Returns a [NavigationRailDestination] widget.
  NavigationRailDestination _buildNavRailItem(String text, IconData iconData,
      bool isSelected, int itemIndex, BuildContext context) {
    return NavigationRailDestination(
      // padding: const EdgeInsets.symmetric(horizontal: 0),

      icon: InkWell(
        hoverColor: Colors.amber,
        borderRadius: BorderRadius.circular(4),
        splashColor: Colors.blue,
        onTap: () {
          widget.onDestinationSelected(itemIndex);
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.2,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: isSelected ? Colors.greenAccent : Colors.transparent,
          ),
          child: Row(
            children: [
              Icon(iconData),
              const SizedBox(width: 12),
              Text(text),
            ],
          ),
        ),
      ),
      label: const SizedBox.shrink(),
    );
  }
}
