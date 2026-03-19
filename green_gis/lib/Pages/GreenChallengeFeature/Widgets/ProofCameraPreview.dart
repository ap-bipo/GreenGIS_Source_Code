import 'dart:io';
import 'package:flutter/material.dart';

class ProofCameraPreview extends StatelessWidget {
  final File? image;
  final bool isDetecting;
  final String resultText;
  final VoidCallback onPickImage;

  const ProofCameraPreview({
    super.key,
    required this.image,
    required this.isDetecting,
    required this.resultText,
    required this.onPickImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          if (image != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.file(
                image!,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          if (isDetecting)
            const Center(child: CircularProgressIndicator(color: Colors.white))
          else if (image == null)
            Center(
              child: IconButton(
                onPressed: onPickImage,
                icon: const Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ),

          if (resultText.isNotEmpty && image != null)
            Positioned(
              top: 15,
              left: 15,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  resultText,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),

          Positioned(
            bottom: 15,
            right: 15,
            child: GestureDetector(
              onTap: onPickImage,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.replay, color: Colors.redAccent, size: 18),
                    const SizedBox(width: 6),
                    const Text(
                      'Chụp lại',
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
