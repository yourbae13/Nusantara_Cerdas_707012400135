import 'package:flutter/material.dart';

class PengajuanModel extends ChangeNotifier {
  final List<String> _daftarPengajuan = [];

  // Daftar layanan yang sedang diajukan. Tidak bisa diubah dari luar.
  List<String> get daftarPengajuan => List.unmodifiable(_daftarPengajuan);

  // Dipakai oleh badge pada ikon tujuan Warga.
  int get totalPengajuan => _daftarPengajuan.length;

  bool sudahDiajukan(String namaLayanan) {
    return _daftarPengajuan.contains(namaLayanan);
  }

  // Mengembalikan false jika layanan sudah ada di keranjang.
  bool tambah(String namaLayanan) {
    if (_daftarPengajuan.contains(namaLayanan)) {
      return false;
    }
    _daftarPengajuan.add(namaLayanan);
    notifyListeners();
    return true;
  }

  void hapus(String namaLayanan) {
    final bool berhasil = _daftarPengajuan.remove(namaLayanan);
    if (berhasil) {
      notifyListeners();
    }
  }

  void kosongkan() {
    if (_daftarPengajuan.isEmpty) return;
    _daftarPengajuan.clear();
    notifyListeners();
  }
}
