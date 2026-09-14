import 'package:flutter/material.dart';
import '../models/menu.dart';
import 'detail_pemesanan_page.dart';
 
class DetailMenuPage extends StatefulWidget {
  final Menu menu;
  final int indexMenu;
  final List<Menu> daftarMenu;
  final List<int> jumlahPesanan;
  final void Function(int indexMenu) onTambah;
  final void Function(int indexMenu) onKurang;
 
  const DetailMenuPage({
    super.key,
    required this.menu,
    required this.indexMenu,
    required this.daftarMenu,
    required this.jumlahPesanan,
    required this.onTambah,
    required this.onKurang,
  });
 
  @override
  State<DetailMenuPage> createState() => _DetailMenuPageState();
}
 
class _DetailMenuPageState extends State<DetailMenuPage> {
  static const Color primaryColor = Color(0xFFC62828);
  static const Color textColor = Color(0xFF3E2723);
  static const Color mutedColor = Color(0xFF757575);
  static const Color boxColor = Color(0xFFFFF3E0);
 
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
 
  // Tekan "Pesan": pastikan minimal 1 porsi masuk pesanan, lalu buka
  // halaman Detail Pemesanan (di sana jumlah masih bisa diubah).
  void _pesan() {
    if (widget.jumlahPesanan[widget.indexMenu] == 0) {
      widget.onTambah(widget.indexMenu);
    }
 
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailPemesananPage(
          daftarMenu: widget.daftarMenu,
          jumlahPesanan: widget.jumlahPesanan,
          onTambah: widget.onTambah,
          onKurang: widget.onKurang,
        ),
      ),
    ).then((_) {
      setState(() {});
    });
  }
 
  Widget _gambarMenu(double ukuran) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.asset(
        widget.menu.imagePath,
        width: ukuran,
        height: ukuran,
        fit: BoxFit.cover,
      ),
    );
  }
 
  Widget _badgeStatus(bool habis) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: habis ? const Color(0xFF9E9E9E) : const Color(0xFF2E7D32),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        habis ? 'Habis' : 'Tersedia',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
      ),
    );
  }
 
  // Header: gambar di kiri, nama + kategori + harga + badge + porsi di kanan
  Widget _headerMenu(bool habis, double ukuranGambar) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _gambarMenu(ukuranGambar),
        const SizedBox(width: 18),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.menu.namaMenu,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                widget.menu.kategori,
                style: const TextStyle(fontSize: 13, color: mutedColor),
              ),
              const SizedBox(height: 10),
              Text(
                _formatRupiah(widget.menu.harga),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              const SizedBox(height: 10),
              _badgeStatus(habis),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.restaurant, size: 15, color: mutedColor),
                  const SizedBox(width: 6),
                  Text(
                    habis
                        ? 'Porsi tersedia: 0'
                        : 'Porsi tersedia: ${widget.menu.porsiTersedia}',
                    style: const TextStyle(fontSize: 13, color: mutedColor),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
 
  Widget _judulSeksi(IconData icon, String judul) {
    return Row(
      children: [
        Icon(icon, size: 18, color: textColor),
        const SizedBox(width: 8),
        Text(
          judul,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ],
    );
  }
 
  Widget _blokDeskripsi() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _judulSeksi(Icons.description_outlined, 'Deskripsi'),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: boxColor,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Text(
            widget.menu.deskripsi,
            style: const TextStyle(fontSize: 14, height: 1.5, color: mutedColor),
          ),
        ),
      ],
    );
  }
 
  // Satu kotak info (dipakai untuk Kategori & Ketersediaan)
  Widget _kotakInfo({
    required IconData icon,
    required String label,
    required String nilai,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: boxColor,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 18, color: primaryColor),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(fontSize: 12, color: mutedColor),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    nilai,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
 
  Widget _blokInformasiMenu(bool habis) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _judulSeksi(Icons.info_outline, 'Informasi Menu'),
        const SizedBox(height: 10),
        Row(
          children: [
            _kotakInfo(
              icon: Icons.restaurant_menu,
              label: 'Kategori',
              nilai: widget.menu.kategori,
            ),
            const SizedBox(width: 12),
            _kotakInfo(
              icon: Icons.access_time,
              label: 'Ketersediaan',
              nilai: habis ? '0 porsi' : '${widget.menu.porsiTersedia} porsi',
            ),
          ],
        ),
      ],
    );
  }
 
  Widget _tombolPesan(bool habis) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: habis ? null : _pesan,
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          disabledBackgroundColor: const Color(0xFFE0E0E0),
          disabledForegroundColor: const Color(0xFF9E9E9E),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Text(
          habis ? 'Menu Habis' : 'Pesan',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }
 
  @override
  Widget build(BuildContext context) {
    final bool habis = widget.menu.statusMenu() == 'Habis';
 
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Menu'),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
          child: _tombolPesan(habis),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Satu layout yang sama untuk semua ukuran layar, hanya ukuran
          // gambar & lebar konten yang menyesuaikan supaya tetap rapi dan
          // tidak kosong di layar lebar.
          final double lebarLayar = constraints.maxWidth;
 
          double ukuranGambar;
          double lebarMaksimalKonten;
 
          if (lebarLayar < 680) {
            ukuranGambar = 96;
            lebarMaksimalKonten = double.infinity;
          } else if (lebarLayar < 1100) {
            ukuranGambar = 130;
            lebarMaksimalKonten = 720;
          } else {
            ukuranGambar = 180;
            lebarMaksimalKonten = 820;
          }
 
          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: lebarMaksimalKonten),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _headerMenu(habis, ukuranGambar),
                    const SizedBox(height: 24),
                    _blokDeskripsi(),
                    const SizedBox(height: 24),
                    _blokInformasiMenu(habis),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
 
