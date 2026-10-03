import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/favorit_model.dart';
import '../navigation/app_routes.dart';
import 'layanan_data.dart';

class LayananPage extends StatelessWidget {
  const LayananPage({super.key});

  Future<void> _buka(BuildContext context, Layanan l) async {
    final hasil = await Navigator.pushNamed<String>(
      context,
      AppRoutes.rincian,
      arguments: l,
    );
    if (hasil != null && context.mounted) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(hasil)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final kelompok = dataLayanan.keys.toList();
    return DefaultTabController(
      length: kelompok.length,
      child: Column(
        children: [
          TabBar(tabs: [for (final k in kelompok) Tab(text: k)]),
          Expanded(
            child: TabBarView(
              children: [
                for (final k in kelompok)
                  ListView(
                    children: [
                      for (final l in dataLayanan[k]!)
                        ListTile(
                          leading: const Icon(Icons.description_outlined),
                          title: Text(l.nama),
                          subtitle: Text(l.dinas),
                          trailing: Builder(
                            builder: (ctx) {
                              // watch: warna bintang mengikuti status favorit.
                              final bool favorit = ctx
                                  .watch<FavoritModel>()
                                  .apakahFavorit(l.nama);

                              return Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    tooltip: favorit
                                        ? 'Batalkan favorit'
                                        : 'Tandai favorit',
                                    icon: Icon(
                                      favorit ? Icons.star : Icons.star_border,
                                      color: favorit
                                          ? Colors.amber.shade700
                                          : null,
                                    ),
                                    onPressed: () {
                                      // read: hanya memanggil aksi, tanpa
                                      // berlangganan perubahan.
                                      final model = ctx.read<FavoritModel>();
                                      if (favorit) {
                                        model.batalTandai(l.nama);
                                      } else {
                                        model.tandai(l.nama);
                                      }
                                    },
                                  ),
                                  const Icon(Icons.chevron_right),
                                ],
                              );
                            },
                          ),
                          onTap: () => _buka(context, l),
                        ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
