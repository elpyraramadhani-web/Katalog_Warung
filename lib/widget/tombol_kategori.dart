import 'package:flutter/material.dart';
import '../constants/colors.dart';

class TombolKategori extends StatelessWidget {
  final String kategori;
  final bool aktif;
  final VoidCallback onTap;

  const TombolKategori({
    super.key,
    required this.kategori,
    required this.aktif,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: aktif
              ? AppColors.green
              : Colors.transparent,
          border: Border.all(
            color: AppColors.lightGreen,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (aktif) ...[
              const Icon(
                Icons.check,
                color: Colors.white,
                size: 18,
              ),
              const SizedBox(width: 6),
            ],

            Text(
              kategori,
              style: TextStyle(
                color: aktif
                    ? Colors.white
                    : AppColors.darkGreen,
                fontWeight: aktif
                    ? FontWeight.bold
                    : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}