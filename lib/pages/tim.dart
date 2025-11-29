import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TimPage extends StatelessWidget {
  const TimPage({super.key});

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
            'Kenali Tim Kami',
            style: GoogleFonts.poppins(
              color: Colors.black87,
              fontWeight: FontWeight.w700,
              fontSize: 24,
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.black87),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Team member grid (4 columns, custom layout)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Column 1: member1 (tall) + member2 (small)
                  Expanded(
                    child: _teamMemberPhoto('assets/tim/dodi.png', height: 285),
                  ),
                  const SizedBox(width: 8),
                  // Column 2: member3 (small)
                  Expanded(
                    child: Column(
                      children: [
                        _teamMemberPhoto('assets/tim/putri.png', height: 133),
                        const SizedBox(height: 8),
                        _teamMemberPhoto('assets/tim/cindy.png', height: 133),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Column 3: member4 (small)
                  Expanded(
                    child: Column(
                      children: [
                        _teamMemberPhoto('assets/tim/asep.png', height: 133),
                        const SizedBox(height: 8),
                        _teamMemberPhoto('assets/tim/sendi.png', height: 133),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Column 4: member6 (tall) + member5 (small)
                  Expanded(
                    child: _teamMemberPhoto(
                      'assets/tim/rakan.jpg',
                      height: 285,
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              ),

              const SizedBox(height: 20),

              // Team description
              Text(
                'Di SRIKANDI, kami adalah tim yang berdedikasi untuk membantu para petani melindungi tanaman padi dari ancaman penyakit. SRIKANDI adalah aplikasi cerdas berbasis kecerdasan buatan yang membantu petani mendeteksi penyakit pada daun padi secara cepat dan akurat. Kami percaya bahwa kesehatan tanaman adalah kunci keberhasilan panen, sehingga SRIKANDI hadir sebagai sahabat di lahan pertanian menyediakan analisis tepat, rekomendasi penanganan, dan akses informasi yang mudah. Bersama SRIKANDI, mari wujudkan pertanian yang lebih cerdas, produktif, dan berkelanjutan.',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  height: 1.6,
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.justify,
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _teamMemberPhoto(String imagePath, {double height = 160}) {
    return SizedBox(
      height: height,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha((0.08 * 255).round()),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
            errorBuilder: (ctx, err, st) => Container(
              color: Colors.grey.shade300,
              child: const Center(
                child: Icon(Icons.person, color: Colors.grey),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
