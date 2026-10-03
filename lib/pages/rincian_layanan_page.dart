import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/pengajuan_model.dart';
import 'layanan_data.dart';

class RincianLayananPage extends StatefulWidget {
  final Layanan layanan;
  const RincianLayananPage({super.key, required this.layanan});

  @override
  State<RincianLayananPage> createState() => _RincianLayananPageState();
}

class _RincianLayananPageState extends State<RincianLayananPage> {
  // State lokal: hanya halaman ini yang perlu tahu proses sedang berjalan.
  bool _sedangMengirim = false;

  Future<void> _ajukan() async {
    setState(() {
      _sedangMengirim = true;
    });

    // Simulasi proses pengiriman permohonan ke dinas terkait.
    await Future.delayed(const Duration(seconds: 2));

    // Halaman bisa saja sudah tertutup selama menunggu.
    if (!mounted) return;

    final String nama = widget.layanan.nama;

    // read: hanya menjalankan aksi, tidak perlu berlangganan perubahan.
    final bool berhasilDitambah = context.read<PengajuanModel>().tambah(nama);

    final String pesan = berhasilDitambah
        ? 'Permohonan ${nama.toLowerCase()} telah diajukan'
        : '${nama[0].toUpperCase()}${nama.substring(1)} sudah ada di keranjang pengajuan';

    Navigator.pop(context, pesan);
  }

  @override
  Widget build(BuildContext context) {
    final layanan = widget.layanan;

    return PopScope(
      // Tombol kembali dikunci selama proses mengirim berjalan.
      canPop: !_sedangMengirim,
      child: Scaffold(
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
                  // null membuat tombol nonaktif, jadi tidak bisa ditekan ulang.
                  onPressed: _sedangMengirim ? null : _ajukan,
                  child: _sedangMengirim
                      ? const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                            SizedBox(width: 12),
                            Text('Mengirim...'),
                          ],
                        )
                      : const Text('Ajukan Permohonan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
