import 'package:flutter/material.dart';
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
                          trailing: const Icon(Icons.chevron_right),
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
