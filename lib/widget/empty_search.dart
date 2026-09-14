import 'package:flutter/material.dart';
import '../data/menu_images.dart';
import '../constants/colors.dart';

class EmptySearch extends StatelessWidget {
  final VoidCallback onReset;

  const EmptySearch({
    super.key,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                TImages.emptySearch,
                width: 220,
                height: 220,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 12),

              const Text(
                'Menu Tidak Ditemukan',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.text,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Coba cari dengan menu yang berbeda',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.grey,
                ),
              ),

              const SizedBox(height: 16),

              OutlinedButton.icon(
                onPressed: onReset,
                icon: const Icon(Icons.refresh),
                label: const Text(
                  'Tampilkan Semua Menu',
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  side: const BorderSide(
                    color: AppColors.primary,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}