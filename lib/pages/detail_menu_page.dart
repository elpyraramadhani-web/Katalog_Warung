import 'package:flutter/material.dart';
import '../models/menu.dart';
import '../widget/jumlah_porsi.dart';

class DetailMenuPage extends StatefulWidget {
  final Menu menu;
  final int jumlahAwal;

  const DetailMenuPage({
    super.key,
    required this.menu,
    this.jumlahAwal = 0,
  });

  @override
  State<DetailMenuPage> createState() => _DetailMenuPageState();
}

class _DetailMenuPageState extends State<DetailMenuPage> {
  static const Color primaryColor = Color(0xFFC62828);
  static const Color secondaryColor = Color(0xFFE53935);
  static const Color backgroundColor = Color(0xFFFFF3E0);
  static const Color textColor = Color(0xFF3E2723);

  late int _jumlah;

  @override
  void initState() {
    super.initState();
    _jumlah = widget.jumlahAwal;
  }

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

  void _tambahPesanan() {
    if (!widget.menu.tersedia || widget.menu.porsiTersedia <= 0) {
      return;
    }

    if (_jumlah <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Silakan pilih jumlah pesanan terlebih dahulu.'),
        ),
      );
      return;
    }

    Navigator.pop(context, _jumlah);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          'Detail Menu',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 700) {
              return _buildMobileLayout();
            }
            return _buildDesktopLayout();
          },
        ),
      ),
    );
  }

  Widget _buildMobileLayout() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImage(),

          const SizedBox(height: 16),

          _buildInfo(),

          const SizedBox(height: 16),

          _buildDeskripsi(),

          const SizedBox(height: 22),

          _buildJumlah(),

          const SizedBox(height: 20),

          _buildButton(),

          const SizedBox(height: 8),
        ],
      ),
    );
  }
  Widget _buildDesktopLayout() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 1200,
          ),
          child: Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.07),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: _buildImage(
                    height: 430,
                  ),
                ),

                const SizedBox(width: 32),
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfo(),

                      const SizedBox(height: 20),

                      _buildDeskripsi(),

                      const SizedBox(height: 24),

                      _buildJumlah(),

                      const SizedBox(height: 24),

                      _buildButton(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


//Gambar
  Widget _buildImage({
    double? height,
  }) {
    return AspectRatio(
      aspectRatio: 1.35,
      child: Container(
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 15,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Image.asset(
          widget.menu.imagePath,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey.shade200,
              child: const Center(
                child: Icon(
                  Icons.image_not_supported_outlined,
                  size: 60,
                  color: Colors.grey,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildInfo() {
    final bool tersedia =
        widget.menu.tersedia && widget.menu.porsiTersedia > 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Nama menu
        Text(
          widget.menu.namaMenu,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),

        const SizedBox(height: 5),

        // Kategori
        Text(
          widget.menu.kategori,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),

        const SizedBox(height: 8),

        // Harga + Status
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 12,
          runSpacing: 8,
          children: [
            Text(
              _formatRupiah(widget.menu.harga),
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            _buildStatus(tersedia),
          ],
        ),

        const SizedBox(height: 10),

        // Stok
        Row(
          children: [
            Icon(
              Icons.groups_rounded,
              size: 21,
              color: Colors.grey.shade700,
            ),
            const SizedBox(width: 7),
            Text(
              '${widget.menu.porsiTersedia} porsi tersedia',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ],
    );
  }


  Widget _buildStatus(bool tersedia) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: tersedia
            ? Colors.green.withValues(alpha: 0.12)
            : Colors.grey.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            tersedia ? Icons.check_circle : Icons.cancel,
            size: 16,
            color: tersedia ? Colors.green : Colors.grey,
          ),
          const SizedBox(width: 5),
          Text(
            tersedia ? 'Tersedia' : 'Habis',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: tersedia ? Colors.green : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeskripsi() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Deskripsi',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            widget.menu.deskripsi,
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJumlah() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Jumlah Pesanan',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),

        const SizedBox(height: 14),

        Center(
          child: JumlahPorsi(
            stokTersedia: widget.menu.porsiTersedia,
            tersedia: widget.menu.tersedia,
            jumlahAwal: _jumlah,
            onChanged: (value) {
              setState(() {
                _jumlah = value;
              });
            },
          ),
        ),
      ],
    );
  }


  Widget _buildButton() {
    final bool tersedia =
        widget.menu.tersedia && widget.menu.porsiTersedia > 0;

    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: tersedia ? _tambahPesanan : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          disabledBackgroundColor: Colors.grey.shade400,
          foregroundColor: Colors.white,
          disabledForegroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.shopping_cart_outlined,
              size: 22,
            ),
            const SizedBox(width: 9),
            Text(
              tersedia
                  ? 'Tambah ke Pesanan'
                  : 'Menu Habis',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}