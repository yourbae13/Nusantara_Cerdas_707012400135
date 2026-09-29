import 'package:flutter/material.dart';
import 'layanan_data.dart';

class RincianLayananPage extends StatelessWidget {
  final Layanan layanan;
  const RincianLayananPage({super.key, required this.layanan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rincian Layanan')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              layanan.nama,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.apartment),
              title: const Text('Dinas Penanggung Jawab'),
              subtitle: Text(layanan.dinas),
            ),
            ListTile(
              leading: const Icon(Icons.schedule),
              title: const Text('Jam Operasional'),
              subtitle: Text(layanan.jam),
            ),
            ListTile(
              leading: const Icon(Icons.notes),
              title: const Text('Keterangan'),
              subtitle: Text(layanan.keterangan),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => Navigator.pop(
                  context,
                  'Permohonan ${layanan.nama.toLowerCase()} telah diajukan',
                ),
                child: const Text('Ajukan Permohonan'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
