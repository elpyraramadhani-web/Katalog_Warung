class Menu {
    final String namaMenu;
    final String kategori;
    final int harga;
    final bool tersedia;
    final int porsiTersedia;
    final String deskripsi;
    final String imagePath;

    const Menu({
        required this.namaMenu,
        required this.kategori,
        required this.harga,
        required this.tersedia,
        required this.porsiTersedia,
        required this.deskripsi,
        required this.imagePath,
    });

    //Mengembalikan status menu berdasarkan tersedia dan jumlah yg masih ada
    String statusMenu(){
        if (!tersedia || porsiTersedia <= 0){
            return "Habis";
        }
        return "Tersedia";
    }

    @override
    String toString() {
        return 'Menu(namaMenu: $namaMenu, kategori: $kategori, harga: $harga, '
            'tersedia: $tersedia, porsiTersedia: $porsiTersedia, status: ${statusMenu()})';
    }
}