import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/responsive.dart';
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
      child: Stack(
        children: [
          // main row content
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // reserve more space for top-left icon so content doesn't not overlap
              SizedBox(width: scaleWidth(context, 48)),
              // title and subtitle (left)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hasil Analisis',
                      style: GoogleFonts.poppins(
                        fontSize: scaleText(context, 12),
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      item.title,
                      style: GoogleFonts.poppins(
                        fontSize: scaleText(context, 14),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      item.subtitle,
                      style: GoogleFonts.poppins(
                        fontSize: scaleText(context, 12),
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),

              // right column: thumbnail on top, button below (right-aligned)
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (item.imagePath != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        File(item.imagePath!),
                        width: scaleWidth(context, 64),
                        height: scaleWidth(context, 64),
                        fit: BoxFit.cover,
                        errorBuilder: (c, e, s) => _thumbPlaceholder(),
                      ),
                    )
                  else
                    SizedBox(
                      width: scaleWidth(context, 64),
                      height: scaleWidth(context, 64),
                    ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: scaleWidth(context, 100),
                    height: scaleWidth(context, 34),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: accent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.zero,
                      ),
                      onPressed: () {
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
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: scaleText(context, 12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // small icon top-left (no grey background)
          Positioned(
            top: 8,
            left: 8,
            child: SizedBox(
              width: scaleWidth(context, 24),
              height: scaleWidth(context, 24),
              child: Image.asset(
                'assets/icon/hasil-analisis.png',
                width: scaleWidth(context, 24),
                height: scaleWidth(context, 24),
                fit: BoxFit.contain,
                errorBuilder: (ctx, err, st) => Icon(
                  Icons.analytics,
                  color: Colors.grey,
                  size: scaleWidth(context, 18),
                ),
              ),
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
