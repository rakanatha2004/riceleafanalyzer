import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widget/bottom_navbar.dart';

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
    // Simple placeholder pages for each tab
    final pages = [
      _buildHome(context),
      const Center(child: Text('Edukasi')),
      const Center(child: Text('Scan')),
      const Center(child: Text('Hasil')),
      const Center(child: Text('Informasi')),
    ];

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Rice Leaf Analyzer'),
      //   backgroundColor: const Color(0xFF00A991),
      // ),
      body: pages[_currentIndex],
      floatingActionButton: CenterScanButton(onTap: () => _onTap(2)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTap,
      ),
    );
  }

  Widget _buildHome(BuildContext context) {
    final teal = const Color(0xFF00A991);

    // feature card that uses an asset icon.
    // titleSize/subtitleSize can be passed to change font sizes.
    // showBadge controls whether the circular teal background is shown around the icon.
    Widget featureCard(
      String assetPath,
      String title,
      String subtitle, {
      double titleSize = 16,
      double subtitleSize = 12,
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // icon area: either a circular badge with image or the plain image (no border)
            if (showBadge)
              Container(
                width: 56,
                height: 56,
                decoration: const BoxDecoration(
                  color: Color(0x1F00A991),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SizedBox(
                    width: 28,
                    height: 28,
                    child: Image.asset(assetPath, fit: BoxFit.contain),
                  ),
                ),
              )
            else
              SizedBox(
                width: 56,
                height: 56,
                child: Center(
                  child: SizedBox(
                    width: 36,
                    height: 36,
                    child: Image.asset(assetPath, fit: BoxFit.contain),
                  ),
                ),
              ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: titleSize,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: subtitleSize,
                      color: Colors.black54,
                    ),
                  ),
                ],
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
                  // Illustration placeholder (no border/background)
                  SizedBox(
                    width: 86,
                    height: 86,
                    child: Center(
                      child: Image.asset(
                        'assets/Icon5.png',
                        width: 144,
                        height: 176,
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

            // Features grid 2x2
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1,
              children: [
                featureCard(
                  'assets/icon/icondeteksi.png',
                  'Deteksi AI',
                  'Foto daun padi untuk identifikasi cepat.',
                  titleSize: 14,
                  subtitleSize: 10,
                ),
                featureCard(
                  'assets/icon/iconedukasi.png',
                  'Edukasi',
                  'Pelajari kondisi daun padi yang terkena penyakit.',
                  titleSize: 14,
                  subtitleSize: 10,
                ),
                featureCard(
                  'assets/icon/iconhasil.png',
                  'Hasil',
                  'Lihat diagnosa daun padi Anda secara instan.',
                  titleSize: 14,
                  subtitleSize: 10,
                ),
                featureCard(
                  'assets/icon/iconinformasi.png',
                  'Informasi',
                  'Bersihkan informasi penggunaan aplikasi.',
                  titleSize: 14,
                  subtitleSize: 10,
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
                        // Replace circular progress with piechart image asset
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
                              // child: const Center(
                              //   child: Icon(
                              //     Icons.pie_chart,
                              //     color: Colors.white,
                              //   ),
                              // ),
                            ),
                          ),
                        ),
                        // Column(
                        //   mainAxisSize: MainAxisSize.min,
                        //   children: [
                        //     Text(
                        //       '95%',
                        //       style: GoogleFonts.poppins(
                        //         fontSize: 16,
                        //         fontWeight: FontWeight.bold,
                        //       ),
                        //     ),
                        //     Text(
                        //       'Akurasi',
                        //       style: GoogleFonts.poppins(fontSize: 12),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
