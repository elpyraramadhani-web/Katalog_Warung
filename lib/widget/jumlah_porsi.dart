import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class JumlahPorsi extends StatefulWidget {
  final int stokTersedia;
  final bool tersedia;
  final int jumlahAwal;
  final ValueChanged<int> onChanged;

  const JumlahPorsi({
    super.key,
    required this.stokTersedia,
    required this.tersedia,
    required this.jumlahAwal,
    required this.onChanged,
  });

  @override
  State<JumlahPorsi> createState() => _JumlahPorsiState();
}

class _JumlahPorsiState extends State<JumlahPorsi> {
  late int _jumlah;

  static const Color _textColor = Color(0xFF3E2723);

  @override
  void initState() {
    super.initState();
    _jumlah = widget.jumlahAwal;
  }

  bool get _habis => !widget.tersedia || widget.stokTersedia <= 0; 

  void _tambah() {
    if (_habis) return;
    if (_jumlah >= widget.stokTersedia) return;
      setState(() {
        _jumlah++;
      });
      widget.onChanged(_jumlah);
    }

  void _kurang() {
    if (_jumlah <= 0) return;
      setState(() {
        _jumlah--;
      });
      widget.onChanged(_jumlah);
    }

  @override
  Widget build(BuildContext context) {
    final bool bisaKurang = _jumlah > 0;
    final bool bisaTambah = !_habis && _jumlah < widget.stokTersedia;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _TombolBulat(
          icon: Iconsax.minus,
          aktif: bisaKurang,
          onPressed: _kurang,
        ),
        const SizedBox(width: 18),
        Text(
          '$_jumlah',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: _textColor,
          ),
        ),
        const SizedBox(width: 18),
        _TombolBulat(
          icon: Iconsax.add,
          aktif: bisaTambah,
          onPressed: _tambah,
        ),
      ],
    );
  }
}

  class _TombolBulat extends StatelessWidget {
    final IconData icon;
    final bool aktif;
    final VoidCallback onPressed;

    const _TombolBulat({
      required this.icon,
      required this.aktif,
      required this.onPressed,
    });

    static const Color _primaryColor = Color(0xFFC62828);
    static const Color _disabledColor = Color(0xFF9E9E9E);

    @override
    Widget build(BuildContext context) {
      return Material(
        color: aktif ? _primaryColor : _disabledColor,
        shape: const CircleBorder(),
        child: InkWell(
          onTap: aktif ? onPressed : null,
          customBorder: const CircleBorder(),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      );
    }
  }