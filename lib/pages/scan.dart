import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riceleafanalyzer/services/auth_service.dart';
import 'analisis.dart';
import '../utils/responsive.dart';

/// ScanPage
/// - shows live camera preview (if available)
/// - pick image from gallery
/// - capture photo and confirm/retake
/// - detect (disabled until an image is selected)
/// - flash toggle and back button
class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  CameraController? _controller;
  List<CameraDescription> _cameras = [];
  bool _initializing = true;
  bool _flashOn = false;

  File? _pickedImage; // image to detect (from camera capture or gallery)
  bool _processing = false; // during detection

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _initCameras();
  }

  Future<void> _initCameras() async {
    try {
      _cameras = await availableCameras();
      // Prefer a back camera if available
      CameraDescription cam = _cameras.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.back,
        orElse: () => _cameras.isNotEmpty
            ? _cameras.first
            : throw Exception('No cameras'),
      );
      _controller = CameraController(
        cam,
        ResolutionPreset.high,
        enableAudio: false,
      );
      await _controller!.initialize();
      await _controller!.setFlashMode(FlashMode.off);
    } catch (e) {
      // ignore and keep _controller null
    } finally {
      if (mounted) setState(() => _initializing = false);
    }
  }

  Future<void> _toggleFlash() async {
    if (_controller == null) return;
    try {
      _flashOn = !_flashOn;
      await _controller!.setFlashMode(
        _flashOn ? FlashMode.torch : FlashMode.off,
      );
      if (mounted) setState(() {});
    } catch (e) {
      // ignore
    }
  }

  Future<void> _pickFromGallery() async {
    try {
      final XFile? xfile = await _picker.pickImage(source: ImageSource.gallery);
      if (xfile != null) {
        setState(() {
          _pickedImage = File(xfile.path);
        });
      }
    } catch (e) {
      // ignore
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _capturePhoto() async {
    if (_controller == null || !_controller!.value.isInitialized) return;
    try {
      final XFile xfile = await _controller!.takePicture();
      setState(() {
        _pickedImage = File(xfile.path);
      });
    } catch (e) {
      // ignore
    }
  }

  Future<void> _detectImage() async {
    if (_pickedImage == null) return;

    setState(() => _processing = true);

    final auth = AuthService();
    final result = await auth.predict(_pickedImage!);

    setState(() => _processing = false);

    if (!mounted) return;

    if (result == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Gagal mendeteksi, coba lagi")),
      );
      return;
    }

    // Ambil data dari API
    final predictedClass = result["predicted_class"];
    final confidence = result["confidence"];
    final detail = result["disease_detail"];

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AnalisisPage(
          imagePath: _pickedImage!.path,
          label: predictedClass,
          accuracy: confidence / 100,
          detail: detail,
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    // Top bar: place back (left), title (center), flash (right) anchored in safe area.
    // Use equal-sized left/right containers so the title stays visually centered.
    final double controlSize = scaleWidth(context, 44.0);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
        child: Row(
          children: [
            // left (back) - translucent circular background
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                width: controlSize,
                height: controlSize,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(Icons.arrow_back, color: Colors.white, size: 22),
                ),
              ),
            ),

            // title (centered using Expanded)
            Expanded(
              child: Center(
                child: Text(
                  'SRIKANDI',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),

            // right (flash) - white circular background with teal bolt, subtle shadow
            GestureDetector(
              onTap: _toggleFlash,
              child: Container(
                width: controlSize,
                height: controlSize,
                decoration: BoxDecoration(
                  color: _flashOn ? const Color(0xFF00A991) : Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.12),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    Icons.flash_on,
                    color: _flashOn ? Colors.white : const Color(0xFF00A991),
                    size: 22,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCameraPreview(BuildContext c) {
    if (_initializing) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_controller == null || !_controller!.value.isInitialized) {
      return Center(
        child: Text(
          'Camera not available',
          style: GoogleFonts.poppins(color: Colors.white),
        ),
      );
    }
    return CameraPreview(_controller!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: _pickedImage == null
                ? _buildCameraPreview(context)
                : Image.file(_pickedImage!, fit: BoxFit.cover),
          ),

          // overlay corners
          Positioned.fill(
            child: IgnorePointer(
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.88,
                  height: MediaQuery.of(context).size.width * 0.88,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.white.withOpacity(0.0)),
                  ),
                  child: CustomPaint(
                    painter: _CornerPainter(
                      color: Colors.white,
                      strokeWidth: 4,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // top bar - anchored to the top so icons/title/flash appear in the top safe area
          Positioned(top: 0, left: 0, right: 0, child: _buildTopBar()),

          // bottom control panel: contains gallery / thumbnail+actions, capture, and detect
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              color: Colors.black.withOpacity(0.45),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // left: either gallery button, or thumbnail + Ulangi/Konfirmasi when an image is picked
                  if (_pickedImage == null)
                    GestureDetector(
                      onTap: _pickFromGallery,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          // color: Colors.white.withOpacity(0.9),
                          // shape: BoxShape.circle,
                        ),
                        // use a local asset image as the icon so it can be provided manually
                        child: Image.asset(
                          'assets/icon/file.png',
                          width: scaleWidth(context, 50),
                          height: scaleWidth(context, 50),
                          // avoid forcing a tint that could hide a colored icon; use blend mode if needed
                          // color: Colors.teal,
                          fit: BoxFit.contain,
                          // if the asset fails to load at runtime, show the default Icon as a fallback
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(
                                Icons.photo,
                                color: Colors.teal,
                                size: 24,
                              ),
                        ),
                      ),
                    )
                  else
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            _pickedImage!,
                            width: scaleWidth(context, 72),
                            height: scaleWidth(context, 72),
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ElevatedButton(
                              onPressed: () =>
                                  setState(() => _pickedImage = null),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white70,
                                foregroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                              ),
                              child: Text(
                                'Ulangi',
                                style: GoogleFonts.poppins(),
                              ),
                            ),
                            const SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: _processing ? null : _detectImage,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                              ),
                              child: Text(
                                'Konfirmasi',
                                style: GoogleFonts.poppins(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                  // capture button (center) - only show when no image picked
                  if (_pickedImage == null)
                    GestureDetector(
                      onTap: _capturePhoto,
                      child: Container(
                        width: scaleWidth(context, 84),
                        height: scaleWidth(context, 84),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white70,
                            width: scaleWidth(context, 6),
                          ),
                          color: Colors.transparent,
                        ),
                        child: Center(
                          child: Container(
                            width: scaleWidth(context, 52),
                            height: scaleWidth(context, 52),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                    )
                  else
                    const SizedBox.shrink(),

                  // right: detect button (shows label)
                  GestureDetector(
                    onTap: _pickedImage == null || _processing
                        ? null
                        : _detectImage,
                    child: Opacity(
                      opacity: _pickedImage == null ? 0.6 : 1.0,
                      child: Row(
                        children: [
                          Text(
                            'Deteksi',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(width: 8),
                          if (_processing)
                            const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // thumbnail/actions are now integrated into the bottom bar
        ],
      ),
    );
  }
}

class _CornerPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  _CornerPainter({required this.color, this.strokeWidth = 4});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.9)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final cornerLen = 28.0;
    // top-left
    canvas.drawLine(Offset(8, 8), Offset(8 + cornerLen, 8), paint);
    canvas.drawLine(Offset(8, 8), Offset(8, 8 + cornerLen), paint);
    // top-right
    canvas.drawLine(
      Offset(size.width - 8, 8),
      Offset(size.width - 8 - cornerLen, 8),
      paint,
    );
    canvas.drawLine(
      Offset(size.width - 8, 8),
      Offset(size.width - 8, 8 + cornerLen),
      paint,
    );
    // bottom-left
    canvas.drawLine(
      Offset(8, size.height - 8),
      Offset(8 + cornerLen, size.height - 8),
      paint,
    );
    canvas.drawLine(
      Offset(8, size.height - 8),
      Offset(8, size.height - 8 - cornerLen),
      paint,
    );
    // bottom-right
    canvas.drawLine(
      Offset(size.width - 8, size.height - 8),
      Offset(size.width - 8 - cornerLen, size.height - 8),
      paint,
    );
    canvas.drawLine(
      Offset(size.width - 8, size.height - 8),
      Offset(size.width - 8, size.height - 8 - cornerLen),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
