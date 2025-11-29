import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EduViewPage extends StatefulWidget {
  final int initialPage;

  const EduViewPage({super.key, this.initialPage = 0});

  @override
  State<EduViewPage> createState() => _EduViewPageState();
}

class _EduViewPageState extends State<EduViewPage> {
  late final PageController _controller;
  late int _page;

  final List<_Disease> _items = const [
    _Disease(
      title: 'Bakterial',
      image: 'assets/bakterial.png',
      scientific: 'Xanthomonas oryzae',
      description:
          'Daun padi yang terinfeksi bakteri biasanya menunjukkan gejala awal berupa bercak hijau pucat di tepi daun yang kemudian berubah menjadi cokelat kekuningan. Seiring waktu, bercak tersebut meluas hingga menyebabkan seluruh daun mengering dan mati. Infeksi bakteri ini menghambat proses fotosintesis karena jaringan daun rusak, sehingga tanaman kehilangan kemampuan menyerap nutrisi secara optimal. Akibatnya, pertumbuhan padi menjadi terhambat dan hasil panen berkurang drastis jika serangan meluas.',
    ),
    _Disease(
      title: 'Blast',
      image: 'assets/blast.png',
      scientific: 'Magnaporthe oryzae',
      description:
          'Penyakit blast yang disebabkan oleh jamur Magnaporthe oryzae dapat menimbulkan bercak pada daun yang berwarna cokelat dengan batas yang jelas. Daun yang terinfeksi akan mengalami penurunan kemampuan fotosintesis sehingga tanaman kehilangan vigor. Jika serangan berat, blast dapat menyebar ke batang dan malai sehingga menyebabkan penurunan hasil panen yang signifikan.',
    ),
    _Disease(
      title: 'BrownSpot',
      image: 'assets/brownspot.png',
      scientific: 'Bipolaris oryzae',
      description:
          'Brown Spot menimbulkan bercak-bercak cokelat bulat pada permukaan daun. Pada serangan berat, bercak bisa menyatu dan menyebabkan jaringan daun mati. Kondisi ini menurunkan efisiensi fotosintesis dan pertumbuhan tanaman sehingga hasil panen menurun.',
    ),
    _Disease(
      title: 'LeafSmut',
      image: 'assets/leafsmut.png',
      scientific: 'Entyloma oryzae',
      description:
          'Leaf Smut menyebabkan bercak gelap dan perubahan tekstur pada daun. Infeksi parah mengurangi daya fotosintesis dan dapat membuat tanaman tampak kusam. Dampaknya termasuk penurunan pertumbuhan dan produktivitas tanaman.',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _page = widget.initialPage.clamp(0, _items.length - 1);
    _controller = PageController(initialPage: _page);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: PageView.builder(
          controller: _controller,
          itemCount: _items.length,
          onPageChanged: (p) => setState(() => _page = p),
          itemBuilder: (context, index) {
            final it = _items[index];
            return _buildDetail(context, it);
          },
        ),
      ),
    );
  }

  Widget _buildDetail(BuildContext context, _Disease it) {
    return Column(
      children: [
        // AppBar-like header
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color(0x12000000),
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
              ),
              Expanded(
                child: Text(
                  it.title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 48),
            ],
          ),
        ),

        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey.shade200,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      it.image,
                      fit: BoxFit.cover,
                      errorBuilder: (ctx, err, st) => Container(
                        color: Colors.grey.shade200,
                        child: const Center(child: Icon(Icons.broken_image)),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),
                Text(
                  'Efek Terkena ${it.title}',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  it.scientific,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  it.description,
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: Colors.grey.shade800,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _Disease {
  final String title;
  final String image;
  final String scientific;
  final String description;

  const _Disease({
    required this.title,
    required this.image,
    required this.scientific,
    required this.description,
  });
}
