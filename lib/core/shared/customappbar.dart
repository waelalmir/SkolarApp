import 'package:flutter/material.dart';

class Customappbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;

  const Customappbar({super.key, required this.title, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(
        color: Colors.black87, // 👈 لون زر الباك
        size: 24,
      ),
      elevation: 0,
      backgroundColor: Color(0xffF2EFEC),
      surfaceTintColor: Colors.white,
      centerTitle: false,
      titleSpacing: 20,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
      actions: actions,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(height: 1, color: Colors.grey.shade200),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
