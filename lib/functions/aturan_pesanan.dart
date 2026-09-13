import '../models/menu.dart';

bool bisaDipesan(Menu menu) {
  return menu.tersedia && menu.porsiTersedia > 0;
}

bool jumlahValid(Menu menu, int jumlahPesanan) {
  return jumlahPesanan > 0 && 
  jumlahPesanan <= menu.porsiTersedia &&
  bisaDipesan(menu);
}

int hitungSubTotal(Menu menu, int jumlah){
  return menu.harga * jumlah;
}

int hitungTotalDiskon(Menu menu, int jumlah){
  final int subtotal = hitungSubTotal(menu, jumlah);

  if(jumlah >= 5) {
    return (subtotal * 10) ~/ 100;
  }
  return 0;
}

int hitungTotalMenu(Menu menu, int jumlah){
  final int subtotal = hitungSubTotal(menu, jumlah);
  final int diskon = hitungTotalDiskon(menu, jumlah);

  return subtotal - diskon;
}