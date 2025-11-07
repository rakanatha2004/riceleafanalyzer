import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'analisis.dart';

class HasilPage extends StatelessWidget {
  /// path of the image taken from the camera (optional)
  final String? imagePath;

  const HasilPage({Key? key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final accent = const Color(0xFF00A991);

    // Example results list; in production this should come from your detection model output
    final results = List.generate(
      3,
      (i) => _HasilItem(
        title: 'Daun Padi Anda Terkena LeafSmut',
        subtitle: 'Daun terinfeksi mengganggu proses fotosintesis.',
        imagePath: imagePath,
      ),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Hasil Analisis',
          style: GoogleFonts.poppins(color: Colors.black87),
        ),
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: ListView.separated(
          itemCount: results.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, idx) {
            final item = results[idx];
            return _HasilCard(item: item, accent: accent);
          },
        ),
      ),
    );
  }
}

class _HasilItem {
  final String title;
  final String subtitle;
  final String? imagePath;

  const _HasilItem({
    required this.title,
    required this.subtitle,
    this.imagePath,
  });
}

class _HasilCard extends StatelessWidget {
  final _HasilItem item;
  final Color accent;

  const _HasilCard({Key? key, required this.item, required this.accent})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.04 * 255).round()),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // left badge: icon from assets (hasil-analisis)
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFF2F4F6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Image.asset(
                'assets/icon/hasil-analisis.png',
                width: 28,
                height: 28,
                fit: BoxFit.contain,
                errorBuilder: (ctx, err, st) =>
                    const Icon(Icons.analytics, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // title & subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hasil Analisis',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  item.title,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  item.subtitle,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),

          // right: thumbnail (from captured image) and CTA button
          if (item.imagePath != null) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(
                File(item.imagePath!),
                width: 64,
                height: 64,
                fit: BoxFit.cover,
                errorBuilder: (c, e, s) => _thumbPlaceholder(),
              ),
            ),
            const SizedBox(width: 8),
          ] else ...[
            const SizedBox(width: 8),
          ],

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: accent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              // open detailed result view (Analisis)
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => AnalisisPage(
                    imagePath: item.imagePath,
                    label: 'Blast',
                    accuracy: 1.0,
                  ),
                ),
              );
            },
            child: Text(
              'Lihat Lengkap',
              style: GoogleFonts.poppins(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _thumbPlaceholder() => Container(
    width: 64,
    height: 64,
    color: Colors.grey.shade200,
    child: const Center(child: Icon(Icons.image, color: Colors.grey)),
  );
}
