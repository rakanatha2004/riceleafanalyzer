import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/responsive.dart';
import '../response/predict_history.dart';
import '../services/auth_service.dart';
import 'analisis.dart';

class HasilPage extends StatefulWidget {
  const HasilPage({Key? key}) : super(key: key);

  @override
  State<HasilPage> createState() => _HasilPageState();
}

class _HasilPageState extends State<HasilPage> {
  late Future<List<PredictHistory>> futureHistory;

  @override
  void initState() {
    super.initState();
    futureHistory = AuthService().getHistory();
  }

  /// 🔄 Refresh handler
  Future<void> _refresh() async {
    setState(() {
      futureHistory = AuthService().getHistory(); // reload future
    });
  }

  @override
  Widget build(BuildContext context) {
    const accent = Color(0xFF00A991);

    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Hasil Analisis',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
      ),

      // 🟢 WRAP BODY DENGAN RefreshIndicator
      body: RefreshIndicator(
        color: accent,
        onRefresh: _refresh,
        child: FutureBuilder<List<PredictHistory>>(
          future: futureHistory,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final list = snapshot.data!;
            if (list.isEmpty) {
              return Center(
                child: Text(
                  "Belum ada riwayat",
                  style: GoogleFonts.poppins(fontSize: 14),
                ),
              );
            }

            return ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(), // penting!
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: list.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, idx) {
                return _HasilCard(item: list[idx], accent: accent);
              },
            );
          },
        ),
      ),
    );
  }
}

class _HasilCard extends StatelessWidget {
  final PredictHistory item;
  final Color accent;

  const _HasilCard({Key? key, required this.item, required this.accent})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageUrl = "${AuthService.baseUrl}${item.imageUrl}";

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: scaleWidth(context, 40),
            child: Align(
              alignment: Alignment.topLeft,
              child: Image.asset(
                'assets/icon/hasil-analisis.png',
                width: scaleWidth(context, 27),
                height: scaleWidth(context, 27),
                fit: BoxFit.contain,
              ),
            ),
          ),

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
                  "Daun Terkena ${item.predictedClass}",
                  style: GoogleFonts.poppins(
                    fontSize: scaleText(context, 14),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Akurasi: ${item.confidence?.toStringAsFixed(2)}%",
                  style: GoogleFonts.poppins(
                    fontSize: scaleText(context, 12),
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),

          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  width: scaleWidth(context, 200),
                  height: scaleWidth(context, 34),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AnalisisPage(
                            imagePath: imageUrl,
                            isNetworkImage: true,
                            label: item.predictedClass!,
                            accuracy: (item.confidence ?? 0) / 100,
                            detail: item.diseaseDetail!.toJson(),
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
          ),
        ],
      ),
    );
  }
}
