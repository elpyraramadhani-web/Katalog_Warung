import 'package:flutter/material.dart';
import '../models/menu.dart';

class DetailMenuPage extends StatelessWidget {
  final Menu menu;

  const DetailMenuPage({
    super.key,
    required this.menu,
  });

  String _formatRupiah(int value) {
    final String angka = value.toString();
    final StringBuffer hasil = StringBuffer();

    for (int i = 0; i < angka.length; i++) {
      if (i > 0 && (angka.length - i) % 3 == 0) {
        hasil.write('.');
      }

      hasil.write(angka[i]);
    }

    return 'Rp$hasil';
  }

  @override
  Widget build(BuildContext context) {
    final bool habis = menu.statusMenu() == 'Habis';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Menu'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              menu.namaMenu,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3E2723),
              ),
            ),

            const SizedBox(height: 8),

            Text(
              menu.kategori,
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xFF757575),
              ),
            ),

            const SizedBox(height: 16),

            Text(
              _formatRupiah(menu.harga),
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFFC62828),
              ),
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: habis
                    ? const Color(0xFF9E9E9E)
                    : const Color(0xFF2E7D32),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                habis ? 'Habis' : 'Tersedia',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              habis
                  ? 'Porsi tersedia: 0'
                  : 'Porsi tersedia: ${menu.porsiTersedia}',
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF757575),
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Deskripsi',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3E2723),
              ),
            ),

            const SizedBox(height: 8),

            Text(
              menu.deskripsi,
              style: const TextStyle(
                fontSize: 15,
                height: 1.5,
                color: Color(0xFF757575),
              ),
            ),
          ],
        ),
      ),
    );
  }
}