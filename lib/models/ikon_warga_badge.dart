import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/pengajuan_model.dart';

class IkonWargaBadge extends StatelessWidget {
  final IconData ikon;

  const IkonWargaBadge({super.key, required this.ikon});

  @override
  Widget build(BuildContext context) {
    // select: hanya membangun ulang widget ini ketika angka total berubah.
    final int total = context.select<PengajuanModel, int>(
      (model) => model.totalPengajuan,
    );

    return Badge(
      isLabelVisible: total > 0,
      label: Text('$total'),
      child: Icon(ikon),
    );
  }
}
