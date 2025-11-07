import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnalisisPage extends StatelessWidget {
  final String? imagePath;
  final String label;
  final double accuracy; // 0.0 - 1.0

  const AnalisisPage({
    Key? key,
    this.imagePath,
    this.label = 'Blast',
    this.accuracy = 1.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final percent = (accuracy * 100).round();

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
            // top image
            if (imagePath != null)
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.file(File(imagePath!), fit: BoxFit.cover),
              )
            else
              Container(
                height: 200,
                color: Colors.grey.shade200,
                child: const Center(
                  child: Icon(Icons.image, size: 48, color: Colors.grey),
                ),
              ),

            const SizedBox(height: 12),

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
                  // progress bar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: accuracy.clamp(0.0, 1.0),
                      minHeight: 10,
                      backgroundColor: Colors.grey.shade200,
                      valueColor: AlwaysStoppedAnimation(
                        const Color(0xFF00A991),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // tabs
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
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: SingleChildScrollView(
                              child: Text(
                                'Penyakit blast yang disebabkan oleh jamur Magnaporthe oryzae dapat menimbulkan kerusakan serius pada daun padi. Daun yang terinfeksi biasanya menampakkan bercak berbentuk belah ketupat berwarna abu-abu dan bagian tengah dengan tepi berwarna cokelat. Infeksi ini menghambat proses fotosintesis, membuat daun mengering lebih cepat, dan mengurangi kemampuan tanaman untuk tumbuh optimal. Jika penyebaran parah, penyakit blast dapat menjalar ke batang dan malai, menyebabkan bulir padi menjadi hampa dan mengakibatkan penurunan hasil panen secara signifikan.',
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: SingleChildScrollView(
                              child: Text(
                                'Pencegahan:\n• Gunakan varietas tahan penyakit jika tersedia.\n• Lakukan rotasi tanaman dan hindari kelembaban tinggi.\n• Jaga jarak tanam agar sirkulasi udara baik.\n• Aplikasi fungisida sebaiknya mengikuti anjuran penyuluh pertanian.',
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: SingleChildScrollView(
                              child: Text(
                                'Pengobatan:\n• Lakukan aplikasi fungisida sistemik yang direkomendasikan.\n• Ikuti dosis dan interval yang dianjurkan.\n• Potong dan bakar bagian tanaman yang parah untuk mengurangi sumber inokulum.',
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  height: 1.5,
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
            ),
          ],
        ),
      ),
    );
  }
}
