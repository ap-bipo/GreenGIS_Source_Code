import 'package:flutter/material.dart';

class ProofAIResultCard extends StatelessWidget {
  final bool hasAnalysis;
  final bool waiting;
  final bool canClaimPoints;
  final List<Map<String, dynamic>> detectedItemsDetails;
  final String detailedAnalysis;
  final int quantity;

  const ProofAIResultCard({
    super.key,
    required this.hasAnalysis,
    required this.waiting,
    required this.canClaimPoints,
    required this.detectedItemsDetails,
    required this.detailedAnalysis,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: canClaimPoints
                      ? const Color(0xFF22B07D)
                      : (waiting
                            ? Colors.grey.shade300
                            : Colors.orange.shade400),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  canClaimPoints
                      ? Icons.check_circle
                      : (waiting ? Icons.image_search : Icons.warning_amber),
                  color: Colors.white,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Kết quả phân tích AI',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 15,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: canClaimPoints
                            ? const Color(0xFFD1FAE5)
                            : (waiting
                                  ? Colors.grey.shade100
                                  : Colors.orange.shade50),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        waiting
                            ? 'Chưa có ảnh'
                            : (canClaimPoints ? 'Hợp lệ ✓' : 'Không hợp lệ'),
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: canClaimPoints
                              ? const Color(0xFF065F46)
                              : (waiting
                                    ? Colors.grey
                                    : Colors.orange.shade800),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Detected items chips
          if (hasAnalysis) ...[
            const Text(
              'Vật thể phát hiện:',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: detectedItemsDetails.map((item) {
                final String lbl = item['label'] as String;
                final bool isTarget = item['isTarget'] == true;
                return Chip(
                  avatar: Icon(
                    isTarget ? Icons.recycling : Icons.remove_circle_outline,
                    size: 16,
                    color: isTarget ? const Color(0xFF22B07D) : Colors.grey,
                  ),
                  label: Text(
                    lbl,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isTarget
                          ? const Color(0xFF065F46)
                          : Colors.grey[600],
                    ),
                  ),
                  backgroundColor: isTarget
                      ? const Color(0xFFD1FAE5)
                      : Colors.grey.shade100,
                  side: BorderSide.none,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 12),
          ],

          // AI commentary text
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.smart_toy_outlined,
                  color: Color(0xFF22B07D),
                  size: 18,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    detailedAnalysis,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF1B4332),
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Points badge when eligible
          if (canClaimPoints) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF22B07D), Color(0xFF16A34A)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.monetization_on,
                    color: Colors.amber,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '+${quantity * 10} Green Points',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
