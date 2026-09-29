import 'package:flutter/material.dart';
import '../pages/layanan_data.dart';
import '../pages/pengaturan_kota_page.dart';
import '../pages/tentang_page.dart';
import '../pages/rincian_layanan_page.dart';
import '../pages/riwayat_laporan_page.dart';
import '../pages/route_tidak_dikenal_page.dart';
import 'kerangka_navigasi.dart';

class AppRoutes {
  static const beranda = '/';
  static const rincian = '/layanan/rincian';
  static const riwayat = '/warga/riwayat';
  static const pengaturan = '/pengaturan';
  static const tentang = '/tentang';

  static Map<String, WidgetBuilder> daftarRoute() => {
    beranda: (_) => const KerangkaNavigasi(),
    pengaturan: (_) => const PengaturanKotaPage(),
    tentang: (_) => const TentangPage(),
  };

  static Route<dynamic>? bentukRoute(RouteSettings settings) {
    switch (settings.name) {
      case rincian:
        final args = settings.arguments;
        if (args is Layanan) {
          return MaterialPageRoute<String>(
            settings: settings,
            builder: (_) => RincianLayananPage(layanan: args),
          );
        }
        return null; // jatuh ke onUnknownRoute
      case riwayat:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const RiwayatLaporanPage(),
        );
    }
    return null;
  }

  static Route<dynamic> routeTidakDikenal(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => RouteTidakDikenalPage(nama: settings.name),
    );
  }
}
