import 'package:flutter/material.dart';
class Homepage extends StatefulWidget {
  final String userName;
  const Homepage({super.key, required this.userName});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
