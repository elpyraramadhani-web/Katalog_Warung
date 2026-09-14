import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CheckoutBar extends StatelessWidget{
  final int jumlahPesanan;
  final int totalHarga;
  final VoidCallback? onCheckout;

  const CheckoutBar({
    super.key,
    required this.jumlahPesanan,
    required this.totalHarga,
    this.onCheckout
  });

  static const Color primaryColor = Color(0xFFC62828);
  static const Color secondaryColor = Color(0xFFE53935);

  String _formatRupiah(int value){
    final String angka = value.toString();
    final StringBuffer hasil = StringBuffer();

    final int sisa = angka.length % 3 == 0 ? 3 : angka.length % 3;

    for(int i = 0; i < angka.length; i++) {
      if (i != 0 && (i - sisa) % 3 == 0){
        hasil.write('.');
      }
      hasil.write(angka[i]);
    }

    return 'Rp$hasil';
  }

  @override
  Widget build(BuildContext context) {
    if (jumlahPesanan == 0) {
      return const SizedBox.shrink();
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsetsGeometry.fromLTRB(16, 8, 16, 16),
        child: Material(
          elevation: 8,
          borderRadius: BorderRadius.circular(16),
          clipBehavior: Clip.antiAlias,
          child: SizedBox(
            height: 72,
            child: Row(
              children: [
                Container(
                  width: 72,
                  color: Colors.white,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      const Icon(
                        Iconsax.shopping_bag,
                        color: primaryColor,
                        size: 32,
                      ),

                      Positioned(
                        top: 7, right: 7,
                        child: Container(
                          width: 22, height: 22,
                          decoration: const BoxDecoration(
                            color: primaryColor,
                            shape: BoxShape.circle
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '$jumlahPesanan',
                            style: const TextStyle(
                              color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18, vertical: 8,
                    ),
                    color: secondaryColor,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Total', maxLines: 1, overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.white, fontSize: 13)
                              ),
                              const SizedBox(height: 2),

                              Text(
                                _formatRupiah(totalHarga),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold
                                ),
                              )
                            ],
                          ),
                        ),

                        InkWell(
                          onTap: onCheckout,
                          borderRadius: BorderRadius.circular(10),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children:[
                              Text('CHECK OUT ($jumlahPesanan)',
                              style: const TextStyle(
                                color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(width: 6),
                              const Icon(Iconsax.arrow_right_3, color: Colors.white, size: 20,)
                            ]
                          )
                        )
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}