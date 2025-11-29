import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riceleafanalyzer/pages/splash.dart';
import 'package:riceleafanalyzer/services/auth_service.dart';
import '../utils/responsive.dart';
import '../widget/bottom_navbar.dart';
import 'edukasi.dart';
import 'scan.dart';
import 'hasil.dart';
import 'informasi.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  void _onTap(int idx) {
    setState(() => _currentIndex = idx);
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      _buildHome(context),
      const EdukasiPage(),
      const Center(child: Text('Scan')),
      // show the HasilPage when the Hasil tab is selected
      const HasilPage(),
      const InformasiPage(),
    ];

    return Scaffold(
      body: pages[_currentIndex],
      floatingActionButton: CenterScanButton(
        onTap: () => Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (_) => const ScanPage())),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTap,
      ),
    );
  }

  Widget _buildHome(BuildContext context) {
    final teal = const Color(0xFF00A991);

    Widget featureCard(
      String assetPath,
      String title,
      String subtitle, {
      double titleSize = 12.5,
      double subtitleSize = 11,
      bool showBadge = false,
    }) {
      return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: const Color(0x0A000000),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (showBadge)
                  Container(
                    width: scaleWidth(context, 56),
                    height: scaleWidth(context, 56),
                    decoration: const BoxDecoration(
                      color: Color(0x1F00A991),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: SizedBox(
                        width: scaleWidth(context, 28),
                        height: scaleWidth(context, 28),
                        child: Image.asset(assetPath, fit: BoxFit.contain),
                      ),
                    ),
                  )
                else
                  SizedBox(
                    width: scaleWidth(context, 56),
                    height: scaleWidth(context, 56),
                    child: Center(
                      child: SizedBox(
                        width: scaleWidth(context, 36),
                        height: scaleWidth(context, 36),
                        child: Image.asset(assetPath, fit: BoxFit.contain),
                      ),
                    ),
                  ),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: titleSize,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            Text(
              subtitle,
              style: GoogleFonts.poppins(
                fontSize: subtitleSize,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      );
    }

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top banner
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: teal,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Deteksi Penyakit Daun Padi Lebih Cepat!',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Gunakan AI untuk mendeteksi penyakit sejak dini tingkatkan hasil pertanian.',
                          style: GoogleFonts.poppins(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),

                  SizedBox(
                    width: scaleWidth(context, 86),
                    height: scaleWidth(context, 86),
                    child: Center(
                      child: Image.asset(
                        'assets/Icon5.png',
                        width: scaleWidth(context, 144),
                        height: scaleWidth(context, 176),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // Fitur Utama header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Fitur Utama',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Kemudahan Deteksi Penyakit Daun Padi',
                      style: GoogleFonts.poppins(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 12),

            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.1,
              children: [
                featureCard(
                  'assets/icon/icondeteksi.png',
                  'Deteksi AI',
                  'Foto daun padi untuk identifikasi cepat.',
                ),
                featureCard(
                  'assets/icon/iconedukasi.png',
                  'Edukasi',
                  'Pelajari kondisi daun padi yang terkena penyakit.',
                ),
                featureCard(
                  'assets/icon/iconhasil.png',
                  'Hasil',
                  'Lihat diagnosa daun padi Anda secara instan.',
                ),
                featureCard(
                  'assets/icon/iconinformasi.png',
                  'Informasi',
                  'Bersihkan informasi penggunaan aplikasi.',
                ),
              ],
            ),

            const SizedBox(height: 18),

            // Tentang
            Text(
              'Tentang RiceLeafAnalyzer',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'RiceLeafAnalyzer aplikasi diagnosa daun padi',
              style: GoogleFonts.poppins(fontSize: 12),
            ),

            const SizedBox(height: 18),

            // Algoritma AI yang Teruji
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(color: const Color(0x08000000), blurRadius: 8),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Algoritma AI yang Teruji',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Model prediksi kami dilatih dengan lebih dari 2.000 dataset daun padi dengan tingkat akurasi mencapai 95%.',
                          style: GoogleFonts.poppins(fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: Image.asset(
                            'assets/piechart.png',
                            fit: BoxFit.contain,
                            errorBuilder: (ctx, err, st) => Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0x2600A991),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Analisi Faktor Risiko Komprehensif
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(color: const Color(0x08000000), blurRadius: 8),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Analisi Faktor Risiko Komprehensif',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Kami menganalisis 4 jenis penyakit pada daun padi yang terbukti secara ilmiah.',
                          style: GoogleFonts.poppins(fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: Image.asset(
                            'assets/sawit.png',
                            fit: BoxFit.contain,
                            errorBuilder: (ctx, err, st) => Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0x2600A991),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Saran Pencegahan & Penanganan
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(color: const Color(0x08000000), blurRadius: 8),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Saran Pencegahan & Penanganan',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Memberikan rekomendasi tindakan yang tepat untuk mencegah penyakit dan menjaga kesehatan tanaman padi Anda.',
                          style: GoogleFonts.poppins(fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: Image.asset(
                            'assets/lampu.png',
                            fit: BoxFit.contain,
                            errorBuilder: (ctx, err, st) => Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0x2600A991),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
