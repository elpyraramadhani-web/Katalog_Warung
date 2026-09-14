import 'package:flutter/material.dart';
import '../models/menu.dart';
import '../functions/aturan_pesanan.dart';

class DetailPemesananPage extends StatefulWidget {
  final List<Menu> daftarMenu;
  final List<int> jumlahPesanan;
  final void Function(int indexMenu) onTambah;
  final void Function(int indexMenu) onKurang;

  const DetailPemesananPage({
    super.key,
    required this.daftarMenu,
    required this.jumlahPesanan,
    required this.onTambah,
    required this.onKurang,
  });

  @override
  State<DetailPemesananPage> createState() => _DetailPemesananPageState();
}

class _DetailPemesananPageState extends State<DetailPemesananPage> {
  static const Color primaryColor = Color(0xFFC62828);

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

  // Total subtotal (sebelum diskon) dari semua menu yang dipesan
  int _hitungTotalSubtotal() {
    int total = 0;
    for (int i = 0; i < widget.daftarMenu.length; i++) {
      final int jumlah = widget.jumlahPesanan[i];
      if (jumlah > 0) {
        total += hitungSubTotal(widget.daftarMenu[i], jumlah);
      }
    }
    return total;
  }

  // Total diskon dari semua menu, memakai fungsi aturan_pesanan.dart yang sudah ada
  int _hitungTotalDiskonSemua() {
    int total = 0;
    for (int i = 0; i < widget.daftarMenu.length; i++) {
      final int jumlah = widget.jumlahPesanan[i];
      if (jumlah > 0) {
        total += hitungTotalDiskon(widget.daftarMenu[i], jumlah);
      }
    }
    return total;
  }

  int _hitungTotalAkhir() {
    return _hitungTotalSubtotal() - _hitungTotalDiskonSemua();
  }

  void _tambah(int index) {
    setState(() {
      widget.onTambah(index);
    });
  }

  void _kurang(int index) {
    setState(() {
      widget.onKurang(index);
    });
  }

  void _selesaikanPesanan() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 28),
              SizedBox(width: 8),
              Text('Pesanan Berhasil'),
            ],
          ),
          content: const Text(
            'Pesanan kamu sudah berhasil diselesaikan. Terima kasih sudah memesan di AYAMIN!',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // tutup dialog
                Navigator.popUntil(context, (route) => route.isFirst); // kembali ke menu utama
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _tombolBulat({required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: const Color(0xFFFFEBEE),
          shape: BoxShape.circle,
          border: Border.all(color: primaryColor, width: 1),
        ),
        child: Icon(icon, size: 16, color: primaryColor),
      ),
    );
  }

  Widget _baris(String label, String nilai, {bool tebal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: tebal ? 15 : 13,
            fontWeight: tebal ? FontWeight.bold : FontWeight.normal,
            color: tebal ? primaryColor : const Color(0xFF757575),
          ),
        ),
        Text(
          nilai,
          style: TextStyle(
            fontSize: tebal ? 17 : 14,
            fontWeight: tebal ? FontWeight.bold : FontWeight.w600,
            color: tebal ? primaryColor : const Color(0xFF3E2723),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Ambil daftar index menu yang jumlahnya lebih dari 0
    final List<int> indexDipesan = [];
    for (int i = 0; i < widget.daftarMenu.length; i++) {
      if (widget.jumlahPesanan[i] > 0) {
        indexDipesan.add(i);
      }
    }

    final int totalSubtotal = _hitungTotalSubtotal();
    final int totalDiskon = _hitungTotalDiskonSemua();
    final int totalAkhir = _hitungTotalAkhir();

    return Scaffold(
      // AppBar memakai tema aplikasi (primaryColor + tombol kembali otomatis dari Navigator)
      appBar: AppBar(
        title: const Text('Detail Pemesanan'),
      ),
      body: indexDipesan.isEmpty
          ? const Center(
              child: Text(
                'Belum ada menu yang dipesan',
                style: TextStyle(fontSize: 16, color: Color(0xFF757575)),
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Daftar menu yang dipesan
                ...indexDipesan.map((index) {
                  final Menu menu = widget.daftarMenu[index];
                  final int jumlah = widget.jumlahPesanan[index];
                  final int subtotal = hitungSubTotal(menu, jumlah);

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          menu.namaMenu,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF3E2723),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _formatRupiah(menu.harga),
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF757575),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            _tombolBulat(
                              icon: Icons.remove,
                              onTap: () => _kurang(index),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              '$jumlah',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 12),
                            _tombolBulat(
                              icon: Icons.add,
                              onTap: () => _tambah(index),
                            ),
                            const Spacer(),
                            Text(
                              _formatRupiah(subtotal),
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),

                const SizedBox(height: 8),

                // Rincian pembayaran
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Rincian Pembayaran',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3E2723),
                        ),
                      ),
                      const SizedBox(height: 12),
                      _baris('Subtotal', _formatRupiah(totalSubtotal)),
                      const SizedBox(height: 6),
                      _baris('Diskon', '- ${_formatRupiah(totalDiskon)}'),
                      const Divider(height: 20),
                      _baris('Total', _formatRupiah(totalAkhir), tebal: true),
                    ],
                  ),
                ),
              ],
            ),
      bottomNavigationBar: indexDipesan.isEmpty
          ? null
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: Material(
                  elevation: 8,
                  borderRadius: BorderRadius.circular(16),
                  clipBehavior: Clip.antiAlias,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 12,
                    ),
                    color: Colors.white,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Total Pembayaran',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF757575),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                _formatRupiah(totalAkhir),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: _selesaikanPesanan,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 14,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'PESANAN SELESAI',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}