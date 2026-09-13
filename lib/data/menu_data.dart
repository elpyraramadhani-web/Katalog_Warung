import '../models/menu.dart';
import 'menu_images.dart';

//Seluruh daftar menu yang ada di warung AYAMIN
final List<Menu> daftarMenu = [
    //Ayam Geprek
    const Menu(
        namaMenu: 'Ayam Geprek Sambel Bawang',
        kategori: 'Ayam Geprek',
        harga: 13000,
        tersedia: true,
        porsiTersedia: 40,
        deskripsi: 'Ayam geprek dengan sambal bawang yang harum dan pedas menggigit.',
        imagePath: TImages.geprekMatah,
    ),
    const Menu(
        namaMenu: 'Ayam Geprek Sambel Ijo',
        kategori: 'Ayam Geprek',
        harga: 13000,
        tersedia: true,
        porsiTersedia: 8,
        deskripsi: 'Ayam geprek dengan sambal ijo khas, segar dengan tingkat pedas sedang.',
        imagePath: TImages.geprekIjo,
    ),
    const Menu(
        namaMenu: 'Ayam Geprek Sambal Matah',
        kategori: 'Ayam Geprek',
        harga: 14000,
        tersedia: true,
        porsiTersedia: 15,
        deskripsi: 'Ayam geprek dipadukan sambal matah khas Bali yang segar dan aromatik.',
        imagePath: TImages.geprekMatah,
    ),
    const Menu(
        namaMenu: 'Ayam Geprek Lava',
        kategori: 'Ayam Geprek',
        harga: 15000,
        tersedia: true,
        porsiTersedia: 0,
        deskripsi: 'Ayam geprek dengan siraman sambal lava super pedas.',
        imagePath: TImages.geprekLava,
    ),
    const Menu(
        namaMenu: 'Ayam Geprek Mozzarella',
        kategori: 'Ayam Geprek',
        harga: 18000,
        tersedia: true,
        porsiTersedia: 6,
        deskripsi: 'Ayam geprek dengan lelehan keju mozzarella yang creamy dan gurih.',
        imagePath: TImages.geprekMoza,
    ),

    //Ayam Crispy tambah saos
    const Menu(
        namaMenu: 'Ayam Crispy Original',
        kategori: 'Ayam Crispy',
        harga: 13000,
        tersedia: true,
        porsiTersedia: 18,
        deskripsi: 'Ayam crispy renyah dengan rasa original yang gurih.',
        imagePath: TImages.crispyOriginal,
    ),
    const Menu(
        namaMenu: 'Ayam Crispy Lava',
        kategori: 'Ayam Crispy',
        harga: 15000,
        tersedia: true,
        porsiTersedia: 2,
        deskripsi: 'Ayam crispy dengan siraman saus lava pedas menggoda.',
        imagePath: TImages.crispyLava,
    ),
    const Menu(
        namaMenu: 'Ayam Crispy Spicy BBQ',
        kategori: 'Ayam Crispy',
        harga: 15000,
        tersedia: true,
        porsiTersedia: 45,
        deskripsi: 'Ayam crispy berbalut saus BBQ pedas yang manis gurih.',
        imagePath: TImages.crispyBBQ,
    ),
    const Menu(
        namaMenu: 'Ayam Crispy Black Pepper',
        kategori: 'Ayam Crispy',
        harga: 16000,
        tersedia: true,
        porsiTersedia: 20,
        deskripsi: 'Ayam crispy dengan saus lada hitam yang harum dan sedikit pedas.',
        imagePath: TImages.crispyBlackPepper,
    ),
    const Menu(
        namaMenu: 'Ayam Crispy Korean Spicy',
        kategori: 'Ayam Crispy',
        harga: 17000,
        tersedia: true,
        porsiTersedia: 3,
        deskripsi: 'Ayam crispy dengan saus pedas ala Korea yang nagih.',
        imagePath: TImages.crispyKorean,
    ),

    //Rice Bowl
    const Menu(
        namaMenu: 'Rice Bowl Chicken Teriyaki',
        kategori: 'Rice Bowl',
        harga: 15000,
        tersedia: true,
        porsiTersedia: 9,
        deskripsi: 'Nasi hangat dengan topping ayam saus teriyaki manis gurih.',
        imagePath: TImages.rbSaos,
    ),
    const Menu(
        namaMenu: 'Rice Bowl Chicken BBQ',
        kategori: 'Rice Bowl',
        harga: 15000,
        tersedia: true,
        porsiTersedia: 20,
        deskripsi: 'Nasi hangat dengan topping ayam saus BBQ.',
        imagePath: TImages.rbSaos,
    ),
    const Menu(
        namaMenu: 'Rice Bowl Chicken Black Pepper',
        kategori: 'Rice Bowl',
        harga: 16000,
        tersedia: true,
        porsiTersedia: 25,
        deskripsi: 'Nasi hangat dengan topping ayam saus lada hitam.',
        imagePath: TImages.rbSaos,
    ),
    const Menu(
        namaMenu: 'Rice Bowl Chicken Spicy',
        kategori: 'Rice Bowl',
        harga: 15000,
        tersedia: true,
        porsiTersedia: 40,
        deskripsi: 'Nasi hangat dengan topping ayam pedas menggugah selera.',
        imagePath: TImages.rbSaos,
    ),
    const Menu(
        namaMenu: 'Rice Bowl Chicken Sambal Matah',
        kategori: 'Rice Bowl',
        harga: 16000,
        tersedia: true,
        porsiTersedia: 8,
        deskripsi: 'Nasi hangat dengan topping ayam dan sambal matah segar.',
        imagePath: TImages.rbMatah,
    ),
    const Menu(
        namaMenu: 'Rice Bowl Chicken Geprek',
        kategori: 'Rice Bowl',
        harga: 14000,
        tersedia: true,
        porsiTersedia: 15,
        deskripsi: 'Nasi hangat dengan topping ayam geprek pedas.',
        imagePath: TImages.rbGeprek,
    ),

    //Menu Paket
    const Menu(
        namaMenu: 'Paket Geprek',
        kategori: 'Paket Hemat',
        harga: 15000,
        tersedia: true,
        porsiTersedia: 18,
        deskripsi: 'Paket hemat berisi ayam geprek, nasi, dan sambal pilihan.',
        imagePath: TImages.paketGeprek,
    ),
    const Menu(
        namaMenu: 'Paket Geprek Komplit',
        kategori: 'Paket Hemat',
        harga: 20000,
        tersedia: true,
        porsiTersedia: 3,
        deskripsi: 'Paket lengkap ayam geprek dengan nasi, sambal, dan es teh.',
        imagePath: TImages.paketKomplit,
    ),
    const Menu(
        namaMenu: 'Paket Lava',
        kategori: 'Paket Hemat',
        harga: 20000,
        tersedia: true,
        porsiTersedia: 50,
        deskripsi: 'Paket hemat ayam dengan saus lava pedas plus nasi dan es teh.',
        imagePath: TImages.paketSaos,
    ),
    const Menu(
        namaMenu: 'Paket Crispy',
        kategori: 'Paket Hemat',
        harga: 18000,
        tersedia: true,
        porsiTersedia: 0,
        deskripsi: 'Paket hemat ayam crispy dengan nasi tambah saos dan es teh. ',
        imagePath: TImages.paketSaos
    ),
    const Menu(
        namaMenu: 'Paket Korean',
        kategori: 'Paket Hemat',
        harga: 22000,
        tersedia: true,
        porsiTersedia: 12,
        deskripsi: 'Paket hemat ayam ala Korea lengkap dengan nasi dan es teh.',
        imagePath: TImages.paketSaos
    ),
    const Menu(
        namaMenu: 'Paket Matah',
        kategori: 'Paket Hemat',
        harga: 21000,
        tersedia: true,
        porsiTersedia: 6,
        deskripsi: 'Paket hemat ayam dengan sambal matah segar plus nasi dan es teh.',
        imagePath: TImages.paketSaos
    ),

    //Minuman
    const Menu(
        namaMenu: 'Es Teh',
        kategori: 'Minuman',
        harga: 5000,
        tersedia: true,
        porsiTersedia: 50,
        deskripsi: 'Es teh manis segar sebagai pelepas dahaga.',
        imagePath: TImages.esTeh
    ),
    const Menu(
        namaMenu: 'Teh Hangat',
        kategori: 'Minuman',
        harga: 4000,
        tersedia: true,
        porsiTersedia: 40,
        deskripsi: 'Teh hangat manis cocok untuk menemani makan.',
        imagePath: TImages.esTeh
    ),
    const Menu(
        namaMenu: 'Lemon Tea',
        kategori: 'Minuman',
        harga: 7000,
        tersedia: true,
        porsiTersedia: 20,
        deskripsi: 'Teh dengan perasan lemon segar.',
        imagePath: TImages.lemonTea
    ),
    const Menu(
        namaMenu: 'Milk Tea',
        kategori: 'Minuman',
        harga: 8000,
        tersedia: true,
        porsiTersedia: 3,
        deskripsi: 'Teh susu creamy dengan rasa manis pas.',
        imagePath: TImages.milkTea
    ),
    const Menu(
        namaMenu: 'Thai Tea',
        kategori: 'Minuman',
        harga: 9000,
        tersedia: true,
        porsiTersedia: 45,
        deskripsi: 'Thai tea creamy dengan warna oranye khas.',
        imagePath: TImages.thaiTea
    ),
    const Menu(
        namaMenu: 'Matcha Latte',
        kategori: 'Minuman',
        harga: 12000,
        tersedia: true,
        porsiTersedia: 15,
        deskripsi: 'Matcha latte creamy dengan rasa teh hijau khas.',
        imagePath: TImages.matchaLatte
    ),
    const Menu(
        namaMenu: 'Chocolate Latte',
        kategori: 'Minuman',
        harga: 11000,
        tersedia: true,
        porsiTersedia: 0,
        deskripsi: 'Chocolate latte creamy, stok sedang habis.',
        imagePath: TImages.chocolateLatte
    ),
    const Menu(
        namaMenu: 'Es Jeruk',
        kategori: 'Minuman',
        harga: 6000,
        tersedia: true,
        porsiTersedia: 50,
        deskripsi: 'Es jeruk peras segar penambah semangat.',
        imagePath: TImages.jeruk
    ),
    const Menu(
        namaMenu: 'Jeruk Hangat',
        kategori: 'Minuman',
        harga: 5000,
        tersedia: true,
        porsiTersedia: 40,
        deskripsi: 'Jeruk hangat manis segar cocok di cuaca dingin.',
        imagePath: TImages.jeruk
    ),
];