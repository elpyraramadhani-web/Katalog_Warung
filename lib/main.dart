import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/menu_images.dart';
import 'data/menu_data.dart';
import 'models/menu.dart';
import 'widget/menu_card.dart';
import 'functions/aturan_pesanan.dart';
import 'pages/detail_menu_page.dart';
import 'widget/app_bar.dart';
import 'widget/checkout_bar.dart';
import 'pages/detail_pemesanan_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build (BuildContext context) {
    //tema warna aplikasi
    const Color primaryColor = Color(0xFFC62828);
    const Color secondaryColor = Color(0xFFE53935);
    const Color backgroundColor = Color(0xFFFFF3E0);
    const Color cardColor = Color(0xFFFFFFFF);
    const Color textColor = Color(0xFF3E2723);

    return MaterialApp(
      title: 'KASIR WARUNG AYAMNIN',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: backgroundColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          primary: primaryColor,
          secondary: secondaryColor,
          surface: cardColor,
        ),
        cardColor: cardColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: textColor),
          titleMedium: TextStyle(color: textColor, fontWeight: FontWeight.bold)
        ),
        fontFamily: 'Roboto',
      ),
      home: const AyaminAppHomePage()
    );
  }
}

  //Menampilkan daftar mentah apa
  class AyaminAppHomePage extends StatefulWidget {
    const AyaminAppHomePage({super.key});
  
    @override
    State<AyaminAppHomePage> createState() => _AyaminAppHomePageState();
  }

  class _AyaminAppHomePageState extends State<AyaminAppHomePage> {
    late TextEditingController _searchController;
    late List<int> _jumlahPesanan;

    List<Menu> filteredMenus = [];

    String _urutan = 'Harga Tertinggi';
    String _kategori = 'Semua';

    void _urutkanMenu(String urutan) {
    setState(() {
      _urutan = urutan;

      if (_urutan == 'Harga Tertinggi') {
        filteredMenus.sort(
          (a, b) => b.harga.compareTo(a.harga),
        );
      } else if (_urutan == 'Harga Terendah') {
        filteredMenus.sort(
          (a, b) => a.harga.compareTo(b.harga),
        );
      }
    });
  }

    int _hitungTotalPesanan() {
    int total = 0;

    for (int i = 0; i < daftarMenu.length; i++) {
      final int jumlah = _jumlahPesanan[i];

      if (jumlah > 0) {
        total += hitungTotalMenu(
          daftarMenu[i],
          jumlah,
        );
      }
    }

    return total;
  }

  int _hitungJumlahSemuaPesanan(){
    int total = 0;

    for(final jumlah in _jumlahPesanan){
      total += jumlah;
    }
    return total;
  }

  int _hitungJumlahMenu() {
    int jumlah = 0;

    for (final menu in filteredMenus){
      if (menu.tersedia && menu.porsiTersedia > 0){
        jumlah++;
      }
    }

    return jumlah;
  }

  int _hitungTotalStok() {
    int totalStok = 0;

    for (final menu in filteredMenus){
      totalStok += menu.porsiTersedia;
    }
    return totalStok;
  }

  Widget _kotakRingkasan({
    required String judul,
    required String nilai,
    required IconData icon,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
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
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                color: const Color(0xFFFFEBEE),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: const Color(0xFFC62828),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  judul,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF757575),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  nilai,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3E2723),
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

  Widget _emptySearchView(){
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsetsGeometry.symmetric(
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
                  color: Color(0xFF3E2723)
                ),
              ),
              const SizedBox(height: 8),

              const Text(
                'Coba cari dengan menu yang berbeda',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF757575)
                ),
              ),
              const SizedBox(height: 16),

              OutlinedButton.icon(
                onPressed: () {
                  _searchController.clear();
                  _filterMenu('');
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Tampilkan Semua Menu'),
                style: OutlinedButton.styleFrom(
                  foregroundColor:const Color(0xFFC62828) ,
                  side: const BorderSide(
                    color: Color(0xFFC62828)
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 12
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(12)
                  )
                )
               )
            ],
          ), 
          ),
      ),
    );
  }

    @override
    void initState() {
      super.initState();

      _searchController = TextEditingController();

      _jumlahPesanan = List<int>.filled(
        daftarMenu.length,
        0,
      );

      filteredMenus = List<Menu>.from(daftarMenu);

      filteredMenus.sort(
        (a, b) => b.harga.compareTo(a.harga),
      );
    }

    void _filterMenu(String keyword) {
    final String teks = keyword.toLowerCase().trim();

    setState(() {
      filteredMenus = daftarMenu.where((menu) {
        final cocokNama = menu.namaMenu.toLowerCase().contains(teks);

        final cocokKategori = _kategori == 'Semua' || menu.kategori == _kategori;

        return cocokNama && cocokKategori;
      }).toList();

          if (_urutan == 'Harga Tertinggi') {
            filteredMenus.sort(
              (a, b) => b.harga.compareTo(a.harga),
            );
          } else if (_urutan == 'Harga Terendah') {
            filteredMenus.sort(
              (a, b) => a.harga.compareTo(b.harga),
            );
          }
    });
  }

      void _pilihKategori(String kategori){
        setState(() {
          _kategori = kategori;

          final String teks = _searchController.text.toLowerCase().trim();

          filteredMenus = daftarMenu.where((menu) {
            final cocokNama = menu.namaMenu.toLowerCase().contains(teks);

            final cocokKategori =
              kategori == 'Semua' || 
              menu.kategori == kategori;

              return cocokNama && cocokKategori;
          }).toList();

           if (_urutan == 'Harga Tertinggi') {
            filteredMenus.sort(
              (a, b) => b.harga.compareTo(a.harga),
            );
          } else if (_urutan == 'Harga Terendah') {
            filteredMenus.sort(
              (a, b) => a.harga.compareTo(b.harga),
            );
          }
        });
      }

      Widget _tombolKategori(String kategori) {
        final bool aktif = _kategori == kategori;

        return InkWell(
          onTap: () => _pilihKategori(kategori),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10
            ),
            decoration: BoxDecoration(
              color: aktif
                ? const Color(0xFF198754)
                : Colors.transparent,
              border: Border.all(
                color: const Color(0xFF43A982),
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
                  const SizedBox(width: 6,)
                ],
                Text(
                  kategori,
                  style: TextStyle(
                    color: aktif
                      ? Colors.white
                      : const Color(0xFF286F5C),
                      fontWeight: 
                        aktif ? FontWeight.bold : FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
        );
      }

    void _tambahJumlah(int indexMenu) {
      final menu = daftarMenu[indexMenu];
      final int jumlahBaru = _jumlahPesanan[indexMenu] + 1;

      if (jumlahValid(menu, jumlahBaru)) {
        setState(() {
          _jumlahPesanan[indexMenu] = jumlahBaru;
        });
      }
    }

    void _kurangJumlah(int indexMenu) {
      final int jumlahBaru = _jumlahPesanan[indexMenu] - 1;

      if (jumlahBaru >= 0) {
        setState(() {
          _jumlahPesanan[indexMenu] = jumlahBaru;
        });
      }
    }

    int _getIndexMenu(Menu menu) {
      return daftarMenu.indexOf(menu);
    }

    @override
    void dispose() {
      _searchController.dispose();
      super.dispose();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarAyamin(),
      body:Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onChanged: _filterMenu,
              decoration: InputDecoration(
                hintText: 'Cari menu...',
                prefixIcon: const Icon(
                  Icons.search,
                  color: Color(0xFF757575),
                ),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          _searchController.clear();
                          _filterMenu('');
                        },
                        icon: const Icon(Icons.clear),
                      )
                    : null,
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 16,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(
                    color: Color(0xFFC62828),
                    width: 2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),

            LayoutBuilder(
              builder: (context, constraints) {
                return SizedBox(
                  height: 52,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: constraints.maxWidth,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // TOMBOL SORTING
                          PopupMenuButton<String>(
                            onSelected: _urutkanMenu,
                            itemBuilder: (context) => const [
                              PopupMenuItem(
                                value: 'Harga Tertinggi',
                                child: Text('Harga Tertinggi'),
                              ),
                              PopupMenuItem(
                                value: 'Harga Terendah',
                                child: Text('Harga Terendah'),
                              ),
                            ],
                            child: Container(
                              height: 52,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(
                                  color: const Color(0xFFC62828),
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.swap_vert,
                                    color: Color(0xFFC62828),
                                    size: 22,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    _urutan,
                                    style: const TextStyle(
                                      color: Color(0xFFC62828),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(width: 8),

                          _tombolKategori('Semua'),

                          const SizedBox(width: 8),

                          _tombolKategori('Ayam Geprek'),

                          const SizedBox(width: 8),

                          _tombolKategori('Ayam Crispy'),

                          const SizedBox(width: 8),

                          _tombolKategori('Rice Bowl'),

                          const SizedBox(width: 8),

                          _tombolKategori('Paket Hemat'),

                          const SizedBox(width: 8),

                          _tombolKategori('Minuman'),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                _kotakRingkasan(
                  judul: 'Menu Aktif',
                  nilai: '${_hitungJumlahMenu()}',
                  icon: Icons.restaurant_menu,
                ),

                const SizedBox(width: 12),

                _kotakRingkasan(
                  judul: 'Total Stok',
                  nilai: '${_hitungTotalStok()} porsi',
                  icon: Icons.inventory_2_outlined,
                ),
              ],
            ),

            const SizedBox(height: 16),

            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  int jumlahKolom;

                  if (constraints.maxWidth < 600) {
                    jumlahKolom = 1;
                  } else if (constraints.maxWidth < 900) {
                    jumlahKolom = 2;
                  } else {
                    jumlahKolom = 3;
                  }

                  if (filteredMenus.isEmpty) {
                    return _emptySearchView();
                  }

                  return GridView.builder(
                    padding: const EdgeInsets.only(bottom: 16),
                    itemCount: filteredMenus.length,
                    gridDelegate: 
                    SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: jumlahKolom,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      mainAxisExtent: 320,
                    ),
                    itemBuilder: (context, index) {
                    final menu = filteredMenus[index];
                    final indexMenu = _getIndexMenu(menu);
                    final jumlah = _jumlahPesanan[indexMenu];

                    return MenuCard(
                      menu: menu,
                      jumlah: jumlah,

                      onTambah: () {
                        _tambahJumlah(indexMenu);
                      },

                      onKurang: () {
                        _kurangJumlah(indexMenu);
                      },

                      onTap: () async {
                        final hasil = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailMenuPage(
                              menu: menu,
                              jumlahAwal: jumlah,
                            ),
                          ),
                        );

                        if (hasil != null) {
                          setState(() {
                            _jumlahPesanan[indexMenu] = hasil;
                          });
                        }
                      },
                    );
                  },
                  );
                }
              )
            )
              ],
              ),
            ),
            bottomNavigationBar: CheckoutBar(
              jumlahPesanan: _hitungJumlahSemuaPesanan(), 
              totalHarga: _hitungTotalPesanan(),
              onCheckout: (){
                Navigator.push(context,
                MaterialPageRoute(
                  builder: (context) => DetailPemesananPage(
                    daftarMenu: daftarMenu, 
                    jumlahPesanan: _jumlahPesanan, 
                    onTambah: _tambahJumlah, 
                    onKurang: _kurangJumlah
                    )
                  )
                ).then((_) {
                  setState(() {} );
                  });
              }
        )
      );
  }
}