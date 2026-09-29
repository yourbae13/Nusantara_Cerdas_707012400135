class Layanan {
  final String nama;
  final String dinas;
  final String jam;
  final String keterangan;

  const Layanan({
    required this.nama,
    required this.dinas,
    required this.jam,
    required this.keterangan,
  });
}

const Map<String, List<Layanan>> dataLayanan = {
  'Perizinan': [
    Layanan(
      nama: 'Izin Usaha',
      dinas: 'Dinas Penanaman Modal',
      jam: '08.00 - 15.00',
      keterangan: 'Pengurusan izin usaha mikro dan kecil.',
    ),
    Layanan(
      nama: 'Izin Mendirikan Bangunan',
      dinas: 'Dinas Pekerjaan Umum',
      jam: '08.00 - 14.00',
      keterangan: 'Persetujuan bangunan gedung dan renovasi.',
    ),
    Layanan(
      nama: 'Izin Keramaian',
      dinas: 'Satpol PP',
      jam: '08.00 - 16.00',
      keterangan: 'Izin penyelenggaraan acara di ruang publik.',
    ),
  ],
  'Kesehatan': [
    Layanan(
      nama: 'Pendaftaran Puskesmas',
      dinas: 'Dinas Kesehatan',
      jam: '07.00 - 12.00',
      keterangan: 'Pendaftaran antrean berobat secara daring.',
    ),
    Layanan(
      nama: 'Imunisasi Anak',
      dinas: 'Dinas Kesehatan',
      jam: '08.00 - 11.00',
      keterangan: 'Jadwal dan pendaftaran imunisasi dasar.',
    ),
    Layanan(
      nama: 'Ambulans Gawat Darurat',
      dinas: 'Dinas Kesehatan',
      jam: '24 jam',
      keterangan: 'Permintaan ambulans untuk kondisi darurat.',
    ),
  ],
  'Transportasi': [
    Layanan(
      nama: 'Jadwal Bus Kota',
      dinas: 'Dinas Perhubungan',
      jam: '05.00 - 21.00',
      keterangan: 'Informasi rute dan jadwal bus kota.',
    ),
    Layanan(
      nama: 'Uji Kir Kendaraan',
      dinas: 'Dinas Perhubungan',
      jam: '08.00 - 15.00',
      keterangan: 'Pendaftaran uji berkala kendaraan bermotor.',
    ),
    Layanan(
      nama: 'Izin Trayek',
      dinas: 'Dinas Perhubungan',
      jam: '08.00 - 14.00',
      keterangan: 'Pengajuan izin trayek angkutan umum.',
    ),
  ],
};
