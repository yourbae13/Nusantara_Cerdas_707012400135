import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../pages/beranda_page.dart';
import '../pages/layanan_page.dart';
import '../pages/warga_page.dart';
import 'app_routes.dart';
import '../models/ikon_warga_badge.dart';

class KerangkaNavigasi extends StatefulWidget {
  const KerangkaNavigasi({super.key});

  @override
  State<KerangkaNavigasi> createState() => _KerangkaNavigasiState();
}

class _KerangkaNavigasiState extends State<KerangkaNavigasi> {
  int _indeks = 0;

  static const _judul = ['Beranda', 'Layanan', 'Warga'];
  static const _halaman = [BerandaPage(), LayananPage(), WargaPage()];

  void _pilih(int i) => setState(() => _indeks = i);

  Future<void> _konfirmasiKeluar() async {
    final ya = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Keluar'),
        content: const Text('Tutup aplikasi?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Keluar'),
          ),
        ],
      ),
    );
    if (ya == true) SystemNavigator.pop();
  }

  Widget _drawer() {
    return NavigationDrawer(
      selectedIndex: _indeks,
      onDestinationSelected: (i) {
        Navigator.pop(context); // tutup drawer dulu
        if (i < 3) {
          _pilih(i);
        } else if (i == 3) {
          Navigator.pushNamed(context, AppRoutes.pengaturan);
        } else if (i == 4) {
          Navigator.pushNamed(context, AppRoutes.tentang);
        } else {
          _konfirmasiKeluar();
        }
      },
      children: const [
        Padding(
          padding: EdgeInsets.fromLTRB(28, 24, 16, 12),
          child: Text(
            'Nusantara Cerdas',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        NavigationDrawerDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: Text('Beranda'),
        ),
        NavigationDrawerDestination(
          icon: Icon(Icons.miscellaneous_services_outlined),
          selectedIcon: Icon(Icons.miscellaneous_services),
          label: Text('Layanan'),
        ),
        NavigationDrawerDestination(
          icon: IkonWargaBadge(ikon: Icons.person_outline),
          selectedIcon: IkonWargaBadge(ikon: Icons.person),
          label: Text('Warga'),
        ),
        Padding(padding: EdgeInsets.fromLTRB(28, 8, 28, 8), child: Divider()),
        NavigationDrawerDestination(
          icon: Icon(Icons.settings_outlined),
          label: Text('Pengaturan Kota'),
        ),
        NavigationDrawerDestination(
          icon: Icon(Icons.info_outline),
          label: Text('Tentang Aplikasi'),
        ),
        NavigationDrawerDestination(
          icon: Icon(Icons.logout),
          label: Text('Keluar'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _indeks == 0,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _pilih(0); // kembali ke Beranda, bukan tutup app
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          final lebar = constraints.maxWidth >= 600;
          final isi = IndexedStack(index: _indeks, children: _halaman);

          return Scaffold(
            appBar: AppBar(title: Text(_judul[_indeks])),
            drawer: _drawer(),
            body: lebar
                ? Row(
                    children: [
                      NavigationRail(
                        selectedIndex: _indeks,
                        onDestinationSelected: _pilih,
                        labelType: NavigationRailLabelType.all,
                        destinations: const [
                          NavigationRailDestination(
                            icon: Icon(Icons.home_outlined),
                            selectedIcon: Icon(Icons.home),
                            label: Text('Beranda'),
                          ),
                          NavigationRailDestination(
                            icon: Icon(Icons.miscellaneous_services_outlined),
                            selectedIcon: Icon(Icons.miscellaneous_services),
                            label: Text('Layanan'),
                          ),
                          NavigationRailDestination(
                            icon: IkonWargaBadge(ikon: Icons.person_outline),
                            selectedIcon: IkonWargaBadge(ikon: Icons.person),
                            label: Text('Warga'),
                          ),
                        ],
                      ),
                      const VerticalDivider(width: 1),
                      Expanded(child: isi),
                    ],
                  )
                : isi,
            bottomNavigationBar: lebar
                ? null
                : NavigationBar(
                    selectedIndex: _indeks,
                    onDestinationSelected: _pilih,
                    destinations: const [
                      NavigationDestination(
                        icon: Icon(Icons.home_outlined),
                        selectedIcon: Icon(Icons.home),
                        label: 'Beranda',
                      ),
                      NavigationDestination(
                        icon: Icon(Icons.miscellaneous_services_outlined),
                        selectedIcon: Icon(Icons.miscellaneous_services),
                        label: 'Layanan',
                      ),
                      NavigationDestination(
                        icon: IkonWargaBadge(ikon: Icons.person_outline),
                        selectedIcon: IkonWargaBadge(ikon: Icons.person),
                        label: 'Warga',
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
