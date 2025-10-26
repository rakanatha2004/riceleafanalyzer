import 'package:flutter/material.dart';

//  BottomNavBar widget
//  Usage:
//  Scaffold(
//    body: ...,
//    floatingActionButton: CenterScanButton(
//      onTap: () => onTap(2),
//     asset: 'assets/icon/scan.png',
//   ),
//    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//    bottomNavigationBar: BottomNavBar(
//      currentIndex: currentIndex,
//      onTap: onTap,
//    ),
//  );
class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  /// default asset list (index 0..4). You can pass your own list (5 items)
  final List<String>? assets;
  final List<String>? labels;
  final double iconSize;
  final double height;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.assets,
    this.labels,
    this.iconSize = 36.0,
    this.height = 64.0,
  });

  List<String> get _defaultAssets => const [
    'assets/icon/Home.png', // Home (ubah bila perlu)
    'assets/icon/edukasi.png', // Edukasi
    'assets/icon/scan.png', // Scan (tombol tengah)
    'assets/icon/hasil.png', // Hasil
    'assets/icon/Profil.png', // Informasi / Profil
  ];

  List<String> get _defaultLabels => const [
    'Home',
    'Edukasi',
    'Scan',
    'Hasil',
    'Informasi',
  ];

  @override
  Widget build(BuildContext context) {
    final items = assets ?? _defaultAssets;
    final itemLabels = labels ?? _defaultLabels;
    final activeColor = const Color(0xFF00B686);
    final inactiveColor = Colors.grey.shade600;

    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      elevation: 8,
      child: SizedBox(
        height: height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // left two
            _navItem(
              index: 0,
              asset: items[0],
              label: itemLabels[0],
              selected: currentIndex == 0,
              activeColor: activeColor,
              inactiveColor: inactiveColor,
            ),
            _navItem(
              index: 1,
              asset: items[1],
              label: itemLabels[1],
              selected: currentIndex == 1,
              activeColor: activeColor,
              inactiveColor: inactiveColor,
            ),

            // spacer untuk tombol tengah
            const SizedBox(width: 48),

            // right two
            _navItem(
              index: 3,
              asset: items[3],
              label: itemLabels[3],
              selected: currentIndex == 3,
              activeColor: activeColor,
              inactiveColor: inactiveColor,
            ),
            _navItem(
              index: 4,
              asset: items[4],
              label: itemLabels[4],
              selected: currentIndex == 4,
              activeColor: activeColor,
              inactiveColor: inactiveColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _navItem({
    required int index,
    required String asset,
    required String label,
    required bool selected,
    required Color activeColor,
    required Color inactiveColor,
  }) {
    // helper to create the '-aktif' variant path
    String aktifVariant(String path) {
      final dot = path.lastIndexOf('.');
      if (dot == -1) return '$path-aktif';
      return '${path.substring(0, dot)}-aktif${path.substring(dot)}';
    }

    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        child: SizedBox(
          height: height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // icon from asset
              // if this asset is the scan icon, make it larger than other icons
              Builder(
                builder: (ctx) {
                  final isScan = asset.toLowerCase().contains('scan');
                  final currentIconSize = isScan ? iconSize * 1.6 : iconSize;
                  return SizedBox(
                    width: currentIconSize,
                    height: currentIconSize,
                    child: Image.asset(
                      selected ? aktifVariant(asset) : asset,
                      fit: BoxFit.contain,
                      // fallback to the original asset if the '-aktif' file is missing
                      errorBuilder: (ctx, error, stackTrace) =>
                          Image.asset(asset, fit: BoxFit.contain),
                    ),
                  );
                },
              ),
              // label removed per design: no text under icons
              // underline removed: do not show active underline indicator
            ],
          ),
        ),
      ),
    );
  }
}

/// Center scan button: gunakan ini di floatingActionButton
class CenterScanButton extends StatelessWidget {
  final VoidCallback onTap;
  final String asset;
  final double size;
  final bool showShadow;

  const CenterScanButton({
    super.key,
    required this.onTap,
    this.asset = 'assets/icon/scan.png',
    this.size = 72,
    this.showShadow = true,
  });

  @override
  Widget build(BuildContext context) {
    final activeColor = const Color(0xFF00A991);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: activeColor,
          shape: BoxShape.circle,
          boxShadow: showShadow
              ? [
                  BoxShadow(
                    color: const Color.fromRGBO(0, 0, 0, 0.18),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Center(
          child: SizedBox(
            // make the scan icon noticeably larger inside the circular button
            width: size * 0.7,
            height: size * 0.7,
            child: Image.asset(asset, fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }
}
