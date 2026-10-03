import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/favorit_model.dart';
import '../models/pengajuan_model.dart';
import '../navigation/app_routes.dart';

class WargaPage extends StatelessWidget {
  const WargaPage({super.key});

  void _kirimSemua(BuildContext context) {
    final model = context.read<PengajuanModel>();
    final int jumlah = model.totalPengajuan;
    model.kosongkan();

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text('$jumlah permohonan dikirim ke dinas terkait')),
      );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Card(
          child: ListTile(
            leading: CircleAvatar(child: Icon(Icons.person)),
            title: Text('Bayu Firmansyah'),
            subtitle: Text('NIK: 3577xxxxxxxxxxxx'),
          ),
        ),
        const SizedBox(height: 8),
        Card(
          child: ListTile(
            leading: const Icon(Icons.history),
            title: const Text('Riwayat Laporan'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.pushNamed(context, AppRoutes.riwayat),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Keranjang Pengajuan',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Consumer<PengajuanModel>(
          builder: (context, model, child) {
            final daftar = model.daftarPengajuan;

            if (daftar.isEmpty) {
              return const Card(
                child: ListTile(
                  leading: Icon(Icons.shopping_basket_outlined),
                  title: Text('Keranjang masih kosong'),
                  subtitle: Text(
                    'Ajukan permohonan dari halaman rincian layanan.',
                  ),
                ),
              );
            }

            return Card(
              child: Column(
                children: [
                  for (final nama in daftar)
                    ListTile(
                      leading: const Icon(Icons.description_outlined),
                      title: Text(nama),
                      trailing: IconButton(
                        tooltip: 'Hapus dari keranjang',
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          context.read<PengajuanModel>().hapus(nama);
                        },
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: () => _kirimSemua(context),
                        icon: const Icon(Icons.send),
                        label: Text('Kirim Semua (${daftar.length})'),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 16),
        Text('Layanan Favorit', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Consumer<FavoritModel>(
          builder: (context, model, child) {
            final daftar = model.daftarFavorit;

            if (daftar.isEmpty) {
              return const Card(
                child: ListTile(
                  leading: Icon(Icons.star_border),
                  title: Text('Belum ada layanan favorit'),
                  subtitle: Text(
                    'Tekan ikon bintang pada tujuan Layanan untuk menandai.',
                  ),
                ),
              );
            }

            return Card(
              child: Column(
                children: [
                  for (final nama in daftar)
                    ListTile(
                      leading: Icon(Icons.star, color: Colors.amber.shade700),
                      title: Text(nama),
                      trailing: IconButton(
                        tooltip: 'Batalkan favorit',
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          context.read<FavoritModel>().batalTandai(nama);
                        },
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
