import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_tflite_examples/common/helpers/bar_chart.dart';
import 'package:flutter_tflite_examples/domain/image_classification/bird_detection/classifier_service.dart';
import 'package:flutter_tflite_examples/models/image_classification/bird_detection/classification_result.dart';
import 'package:flutter_tflite_examples/presentation/widgets/custom_appbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class TFLiteClassifierPage extends StatefulWidget {
  const TFLiteClassifierPage({super.key});

  @override
  State<TFLiteClassifierPage> createState() => _TFLiteClassifierPageState();
}

class _TFLiteClassifierPageState extends State<TFLiteClassifierPage> {
  final ClassifierService _classifier = ClassifierService();
  File? _image;
  ClassificationResult? _result;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _classifier.loadModel().then((_) => setState(() {}));
  }

  Future<void> _pickImageAndClassify() async {
    if (!_classifier.isModelLoaded) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Model is still loading, please wait...')),
      );
      return;
    }

    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Capture with Camera'),
                onTap: () async {
                  Navigator.pop(context);
                  await _getImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Pick from Gallery'),
                onTap: () async {
                  Navigator.pop(context);
                  await _getImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _getImage(ImageSource source) async {
    final picker = ImagePicker();
    final XFile? imageFile = await picker.pickImage(source: source);
    if (imageFile == null) return;

    final image = File(imageFile.path);
    setState(() {
      _image = image;
      _result = null;
      _isProcessing = true;
    });

    final result = await _classifier.classifyImage(image);

    if (result != null) {
      setState(() {
        _result = result.confidence < 75.0
            ? ClassificationResult(
                label: "Not a bird",
                confidence: 0.0,
                topResults: {
                  "Male Peafowl": 0.0,
                  "Peahen": 0.0,
                  "Rose Ringed Parakeet": 0.0,
                  "Eagle": 0.0,
                  "Bulbul": 0.0,
                  "Robin": 0.0,
                  "Hornbill": 0.0,
                  "Owl": 0.0,
                  "Trogon": 0.0,
                  "Kingfisher": 0.0,
                },
              )
            : result;
        _isProcessing = false;
      });
    } else {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      appBar: const CustomAppBar(title: 'Bird Classifier'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton.icon(
                  onPressed: _classifier.isModelLoaded ? _pickImageAndClassify : null,
                  icon: const Icon(Icons.photo_library_outlined, size: 18),
                  label: Text(
                    _classifier.isModelLoaded ? 'Pick Image' : 'Loading...'
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    backgroundColor: Colors.teal.shade700,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    elevation: 1,
                    minimumSize: const Size(120, 40),
                    visualDensity: VisualDensity.compact,
                    shadowColor: Colors.black12,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              if (_image != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    width: double.infinity,
                    height: 220,
                    child: Image.file(_image!, fit: BoxFit.cover),
                  ),
                ),
              if (_isProcessing)
                const Center(
                  child: SizedBox(
                    height: 180,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(color: Colors.black),
                        SizedBox(height: 16),
                        Text(
                          'Recognizing bird...',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 24),
              if (_result != null)
                Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 4,
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _result!.label,
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "Confidence: ${_result!.confidence.toStringAsFixed(2)}%",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.teal.shade800,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 30),
                        if (_result!.confidence > 75)
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 400),
                            child: ConfidenceBarChart(
                              key: ValueKey(_result!.topResults),
                              topResults: _result!.topResults,
                            ),
                          ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
