import 'package:flutter/material.dart';

class SidebarValues {
  static final List<Widget> items = [
    const ListTile(
      leading: Icon(Icons.home),
      title: Text("Home"),
    ),
    const ListTile(
      leading: Icon(Icons.account_balance),
      title: Text("Account"),
    ),
    const ListTile(
      leading: Icon(Icons.people),
      title: Text("Recipients"),
    ),
    const ListTile(
      leading: Icon(Icons.list),
      title: Text("Transactions"),
    ),
    const ListTile(
      leading: Icon(Icons.chat_sharp),
      title: Text("Requests"),
    ),
    const ListTile(
      leading: Icon(Icons.houseboat),
      title: Text("Banks"),
    ),
    const ListTile(
      leading: Icon(Icons.pause_presentation_sharp),
      title: Text("Vouchers"),
    ),
  ];
}
