import 'package:flutter/material.dart';

class AppSectionHeader extends StatelessWidget {
  final String title;

  const AppSectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          // (Theme Aware) اللون بيظبط نفسه
          color: Theme.of(context).colorScheme.onBackground,
        ),
      ),
    );
  }
}
