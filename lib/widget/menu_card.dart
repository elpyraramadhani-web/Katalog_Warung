import 'package:flutter/material.dart';
import '../models/menu.dart';
import 'jumlah_porsi.dart';

class MenuCard extends StatelessWidget {
  final Menu menu;
  final int jumlah;
  final VoidCallback onTambah;
  final VoidCallback onKurang;
  final VoidCallback onTap;

  const MenuCard({
    super.key,
    required this.menu,
    required this.jumlah,
    required this.onTambah,
    required this.onKurang,
    required this.onTap,
  });

  static const Color primaryColor = Color(0xFFC62828);
  static const Color textColor = Color(0xFF3E2723);
  static const Color creamColor = Color(0xFFFFFBF5);

  String _formatRupiah(int value) {
    final String angka = value.toString();
    final StringBuffer hasil = StringBuffer();

    final int sisa = angka.length % 3 == 0 ? 3 : angka.length % 3;

    for (int i = 0; i < angka.length; i++) {
      if (i != 0 && (i - sisa) % 3 == 0) {
        hasil.write('.');
      }
      hasil.write(angka[i]);
    }

    return 'Rp$hasil';
  }

  @override
  Widget build(BuildContext context) {
    final bool habis =
        !menu.tersedia || menu.porsiTersedia <= 0;

    return Opacity(
      opacity: habis ? 0.55 : 1.0,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: creamColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 12,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                // Lebar gambar mengikuti lebar card
                final double imageWidth =
                    (constraints.maxWidth * 0.42)
                        .clamp(130.0, 190.0);

                  return Column(
                  children: [
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                // Status
                                _StatusBadge(habis: habis),

                                const SizedBox(height: 18),

                                // Nama menu
                                Text(
                                  menu.namaMenu,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    height: 1.15,
                                    fontWeight: FontWeight.bold,
                                    color: textColor,
                                  ),
                                ),

                                const SizedBox(height: 8),

                                // Kategori
                                Text(
                                  menu.kategori,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: textColor.withOpacity(0.7),
                                  ),
                                ),

                                const SizedBox(height: 10),

                                // Harga
                                Text(
                                  _formatRupiah(menu.harga),
                                  style: const TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(width: 14),

                          SizedBox(
                            width: imageWidth,
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(18),
                                child: Image.asset(
                                  menu.imagePath,
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 14),

                    // Garis pemisah
                    Divider(
                      height: 1,
                      color: textColor.withOpacity(0.12),
                    ),

                    const SizedBox(height: 14),

                    // ==========================================
                    // BAGIAN STOK + JUMLAH
                    // ==========================================

                    Row(
                      children: [
                        // Icon stok
                        Icon(
                          Icons.inventory_2_outlined,
                          size: 32,
                          color: textColor.withOpacity(0.75),
                        ),

                        const SizedBox(width: 12),

                        // Informasi stok
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                habis
                                    ? 'Stok tidak tersedia'
                                    : 'Stok tersedia:',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: textColor.withOpacity(0.7),
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                habis
                                    ? 'Habis'
                                    : '${menu.porsiTersedia} porsi',
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Jumlah
                        JumlahPorsi(
                          stokTersedia: menu.porsiTersedia,
                          tersedia: menu.tersedia,
                          jumlahAwal: jumlah,
                          onChanged: (nilaiBaru) {
                            if (nilaiBaru > jumlah) {
                              onTambah();
                            } else if (nilaiBaru < jumlah) {
                              onKurang();
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}


// ============================================================
// STATUS BADGE
// ============================================================

class _StatusBadge extends StatelessWidget {
  final bool habis;

  const _StatusBadge({
    required this.habis,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: habis
            ? const Color(0xFF9E9E9E)
            : const Color(0xFF168A3B),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.circle,
            size: 10,
            color: Colors.white,
          ),
          const SizedBox(width: 7),
          Text(
            habis ? 'Habis' : 'Tersedia',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}