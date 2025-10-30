import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'spoiler2.dart';

class SpoilerPage extends StatefulWidget {
  const SpoilerPage({super.key});

  @override
  State<SpoilerPage> createState() => _SpoilerPageState();
}

class _SpoilerPageState extends State<SpoilerPage> {
  final PageController _controller = PageController();
  int _page = 0;

  final List<_OnboardData> pages = const [
    _OnboardData(
      image: 'assets/Icon1.png',
      title: 'Kenali penyakit daun padi dengan cepat!',
      subtitle: 'Unggah foto daun padi dan kenali penyakitnya',
    ),
    _OnboardData(
      image: 'assets/icon2.png',
      title: 'Analisis penyakit daun padi secara otomatis!',
      subtitle: 'Teknologi AI kami membantu mengenali jenis penyakit.',
    ),
    _OnboardData(
      image: 'assets/icon3.png',
      title: 'Lihat hasil analisis lengkap!',
      subtitle: 'Ketahui kondisi daun padi dan langkah yang bisa di lakukan.',
    ),
  ];

  void _onSkip() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const Spoiler2Page()),
    );
  }

  void _onNext() {
    if (_page < pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _onSkip();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final accent = const Color(0xFF00A991);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                // top bar with skip
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: _onSkip,
                        child: Text(
                          'Lewati',
                          style: TextStyle(color: const Color(0xFF00A991)),
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: PageView.builder(
                    controller: _controller,
                    itemCount: pages.length,
                    onPageChanged: (idx) => setState(() => _page = idx),
                    itemBuilder: (context, idx) {
                      final item = pages[idx];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 28.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 12),
                            Expanded(
                              child: Center(
                                child: Image.asset(
                                  item.image,
                                  width: 220,
                                  height: 220,
                                  fit: BoxFit.contain,
                                  errorBuilder: (ctx, err, st) => const Icon(
                                    Icons.broken_image,
                                    size: 120,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 12),
                            Text(
                              item.title,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              item.subtitle,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                color: Colors.grey.shade700,
                              ),
                            ),

                            const SizedBox(height: 28),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // paging dots + spacer bottom
                Padding(
                  padding: const EdgeInsets.only(bottom: 28.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(pages.length, (i) {
                          final active = i == _page;
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            margin: const EdgeInsets.symmetric(horizontal: 6),
                            width: active ? 12 : 8,
                            height: active ? 12 : 8,
                            decoration: BoxDecoration(
                              color: active ? accent : Colors.grey.shade300,
                              shape: BoxShape.circle,
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 12),
                      // CTA button
                      GestureDetector(
                        onTap: _onNext,
                        child: Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: accent,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
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

class _OnboardData {
  final String image;
  final String title;
  final String subtitle;
  const _OnboardData({
    required this.image,
    required this.title,
    required this.subtitle,
  });
}
