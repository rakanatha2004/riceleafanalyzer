import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnalisisPage extends StatelessWidget {
  final String? imagePath; // path lokal ATAU url network
  final bool isNetworkImage; // true = network, false = file
  final String label;
  final double accuracy;
  final Map<String, dynamic> detail;

  const AnalisisPage({
    Key? key,
    required this.imagePath,
    required this.label,
    required this.accuracy,
    required this.detail,
    this.isNetworkImage = false, // default: bukan network
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final percent = (accuracy * 100).round();

    final ringkasan = detail["ringkasan"] ?? "Tidak ada data.";
    final pencegahan = detail["pencegahan"] ?? [];
    final pengobatan = detail["pengobatan"] ?? [];

    return Scaffold(
      backgroundColor: const Color(0xFFF7FBFA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Hasil Analisis',
          style: GoogleFonts.poppins(color: Colors.black87),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),

      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ==== GAMBAR DARI FILE ATAU NETWORK ====
            if (imagePath != null)
              AspectRatio(
                aspectRatio: 16 / 9,
                child: isNetworkImage
                    ? Image.network(
                        imagePath!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _placeholder(),
                      )
                    : Image.file(File(imagePath!), fit: BoxFit.cover),
              )
            else
              SizedBox(height: 200, child: _placeholder()),

            const SizedBox(height: 12),

            // ==== LABEL + AKURASI ====
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),

                  Row(
                    children: [
                      Text(
                        'Akurasi:',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '$percent%',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: accuracy.clamp(0.0, 1.0),
                      minHeight: 10,
                      backgroundColor: Colors.grey.shade200,
                      valueColor: const AlwaysStoppedAnimation(
                        Color(0xFF00A991),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // ==== TAB ====
            Expanded(
              child: DefaultTabController(
                length: 3,
                child: Column(
                  children: [
                    TabBar(
                      labelColor: const Color(0xFF00A991),
                      unselectedLabelColor: Colors.grey.shade600,
                      indicatorColor: const Color(0xFF00A991),
                      tabs: [
                        Tab(
                          child: Text(
                            'Ringkasan',
                            style: GoogleFonts.poppins(fontSize: 13),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'Pencegahan',
                            style: GoogleFonts.poppins(fontSize: 13),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'Pengobatan',
                            style: GoogleFonts.poppins(fontSize: 13),
                          ),
                        ),
                      ],
                    ),

                    Expanded(
                      child: TabBarView(
                        children: [
                          // RINGKASAN
                          _textTab(ringkasan),

                          // PENCEGAHAN
                          _listTab(pencegahan),

                          // PENGOBATAN
                          _listTab(pengobatan),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      color: Colors.grey.shade300,
      child: const Center(
        child: Icon(Icons.broken_image, size: 48, color: Colors.grey),
      ),
    );
  }

  Widget _textTab(String text) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Text(
          text,
          style: GoogleFonts.poppins(fontSize: 13, height: 1.5),
        ),
      ),
    );
  }

  Widget _listTab(List list) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: list
              .map(
                (e) => Text(
                  "• $e",
                  style: GoogleFonts.poppins(fontSize: 13, height: 1.5),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
