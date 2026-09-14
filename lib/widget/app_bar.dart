import 'package:flutter/material.dart';
import '../data/menu_images.dart';

class AppBarAyamin extends StatelessWidget
    implements PreferredSizeWidget {
  const AppBarAyamin({super.key});

  static const Color primaryColor = Color(0xFFC62828);

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: primaryColor,
      elevation: 0,
      automaticallyImplyLeading: false,

      title: Row(
        children: [
          Image.asset(
          TImages.logo,
            width: 60,
            height: 60,
            fit: BoxFit.contain,
          ),
          const Spacer(),

          const Text(
            'AYAMIN',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),

          const Spacer(),

          const Icon(
            Icons.account_circle_outlined,
            color: Colors.white,
            size: 32,
          ),
        ],
      ),
    );
  }
}