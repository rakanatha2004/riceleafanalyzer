import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PenggunaanPage extends StatelessWidget {
  const PenggunaanPage({super.key});

  Widget _section(Widget child) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF2FAF8),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE6F4F1)),
      ),
      child: child,
    );
  }

  Widget _h(String text) => Text(
    text,
    style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700),
  );
  Widget _p(String text) =>
      Text(text, style: GoogleFonts.poppins(fontSize: 13, height: 1.45));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black87),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'Penggunaan Aplikasi',
            style: GoogleFonts.poppins(
              color: Colors.black87,
              fontWeight: FontWeight.w700,
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.black87),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _section(
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _h('Ambil Foto Langsung'),
                    const SizedBox(height: 8),
                    _p(
                      '1. Pilih menu scan "Maka Aplikasi Akan membuka Kamera".',
                    ),
                    const SizedBox(height: 6),
                    _p('2. Arahkan kamera ke daun padi yang ingin diperiksa.'),
                    const SizedBox(height: 6),
                    _p(
                      '3. Pastikan daun terlihat jelas, dalam cahaya cukup dan kamera focus.',
                    ),
                    const SizedBox(height: 6),
                    _p(
                      '4. Setelah itu, tekan tombol "Deteksi" untuk memulai analisis.',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              _section(
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _h('Unggah Gambar dari Galeri'),
                    const SizedBox(height: 8),
                    _p(
                      '1. Jika sudah memiliki foto daun padi, pilih opsi "Unggah Gambar".',
                    ),
                    const SizedBox(height: 6),
                    _p('2. Pilih gambar dari galeri perangkat Anda.'),
                    const SizedBox(height: 6),
                    _p(
                      '3. Tunggu beberapa detik, aplikasI akan menganalisis gambar menggunakan AI.',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              _section(
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _h('Lihat Hasil Deteksi'),
                    const SizedBox(height: 8),
                    _p(
                      '1. Setelah analisis selesai, hasil diagnosis akan muncul otomatis pada halaman hasil.',
                    ),
                    const SizedBox(height: 6),
                    _p(
                      '2. Pilih menu hati "Maka Aplikasi Akan Menampilkan Hasil Diagnosis".',
                    ),
                    const SizedBox(height: 6),
                    _p(
                      '3. Pilih menu tombol "Lihat Lengkap" untuk melihat hasil diagnosis secara detail.',
                    ),
                    const SizedBox(height: 6),
                    _p(
                      '4. Sistem menampilkan jenis penyakit, tingkat akurasi, serta menampilkan ringkasan, pencegahan dan pengobatan.',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              _section(
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _h('Tips agar Hasil Deteksi lebih Akurat'),
                    const SizedBox(height: 8),
                    _p(
                      '1. Pastikan foto diambil dalam pencahayaan yang cukup (tidak gelap atau silau).',
                    ),
                    const SizedBox(height: 6),
                    _p(
                      '2. Hindari latar belakang yang terlalu ramai agar daun lebih mudah dikenali.',
                    ),
                    const SizedBox(height: 6),
                    _p('3. Gunakan daun tunggal sebagai fokus utama foto.'),
                    const SizedBox(height: 6),
                    _p('4. Bersihkan lensa kamera sebelum mengambil gambar.'),
                  ],
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
