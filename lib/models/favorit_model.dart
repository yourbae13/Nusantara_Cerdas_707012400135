import 'package:flutter/material.dart';

class FavoritModel extends ChangeNotifier {
  // Set menjamin satu nama layanan tidak tersimpan dua kali.
  final Set<String> _favorit = {};

  // Daftar favorit sesuai urutan ditandai. Tidak bisa diubah dari luar.
  List<String> get daftarFavorit => List.unmodifiable(_favorit);

  int get jumlahFavorit => _favorit.length;

  bool apakahFavorit(String namaLayanan) {
    return _favorit.contains(namaLayanan);
  }

  void tandai(String namaLayanan) {
    final bool berhasil = _favorit.add(namaLayanan);
    if (berhasil) {
      notifyListeners();
    }
  }

  void batalTandai(String namaLayanan) {
    final bool berhasil = _favorit.remove(namaLayanan);
    if (berhasil) {
      notifyListeners();
    }
  }
}
