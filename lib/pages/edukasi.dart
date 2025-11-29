import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;
import 'eduview.dart';

class EdukasiPage extends StatefulWidget {
  const EdukasiPage({super.key});

  @override
  State<EdukasiPage> createState() => _EdukasiPageState();
}

class _EdukasiPageState extends State<EdukasiPage> {
  final List<_DiseaseInfo> items = const [
    _DiseaseInfo(
      title: 'Bakterial',
      scientific: 'Xanthomonas oryzae',
      description: 'Serangan berat menurunkan hasil panen signifikan.',
      image: 'assets/images/bakterial.png',
    ),
    _DiseaseInfo(
      title: 'Blast',
      scientific: 'Magnaporthe oryzae',
      description: 'Serangan berat menurunkan hasil panen hingga 50%.',
      image: 'assets/images/blast.png',
    ),
    _DiseaseInfo(
      title: 'BrownSpot',
      scientific: 'Bipolaris oryzae',
      description: 'menyebabkan penurunan efisiensi penyerapan nutrisi.',
      image: 'assets/images/brownspot.png',
    ),
    _DiseaseInfo(
      title: 'LeafSmut',
      scientific: 'Entyloma oryzae',
      description: 'Daun terinfeksi mengganggu proses fotosintesis.',
      image: 'assets/images/leafsmut.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final bg = Colors.white;

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Text(
                'Penyakit Daun Padi',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 12),
            // area behind cards (light grey) to match design
            Expanded(
              child: Container(
                color: const Color(0xFFF2F4F6),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 12.0,
                ),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    mainAxisExtent: 192.0,
                    childAspectRatio: 172.0 / 192.0,
                  ),
                  itemCount: items.length,
                  itemBuilder: (context, i) {
                    final it = items[i];
                    return _InfoCard(
                      title: it.title,
                      description: it.description,
                      scientific: it.scientific,
                      image: it.image,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EduViewPage(initialPage: i),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      // Bottom navigation and center scan are provided by the parent `HomePage`.
    );
  }
}

class _DiseaseInfo {
  final String title;
  final String scientific;
  final String description;
  final String image;

  const _DiseaseInfo({
    required this.title,
    required this.scientific,
    required this.description,
    required this.image,
  });
}

class _InfoCard extends StatelessWidget {
  final String title;
  final String scientific;
  final String description;
  final String image;
  final VoidCallback onPressed;

  const _InfoCard({
    super.key,
    required this.title,
    required this.scientific,
    required this.description,
    required this.image,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final cardColor = const Color.fromRGBO(255, 255, 255, 0.9);
    final accent = const Color(0xFF00A991);

    return SizedBox(
      width: 172,
      height: 192,
      child: Container(
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row: circular image and title (title aligned next to icon)
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // circular image from assets
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha((0.06 * 255).round()),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                      errorBuilder: (ctx, err, st) => Container(
                        color: Colors.grey.shade200,
                        child: const Center(
                          child: Icon(Icons.image, color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // subtitle (description) below the icon+title row
            Text(
              description,
              style: GoogleFonts.poppins(
                fontSize: 13,
                height: 1.25,
                color: Colors.grey.shade700,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),

            const Spacer(),

            // bottom row: scientific name and arrow button (unchanged)
            Row(
              children: [
                Expanded(
                  child: Text(
                    scientific,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: onPressed,
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: accent,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha((0.08 * 255).round()),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                      // rotate the arrow about ~70 degrees to make it slanted
                      child: Transform.rotate(
                        angle: -45 * math.pi / 180,
                        child: const Icon(Icons.arrow_forward, color: Colors.white),
                      ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
