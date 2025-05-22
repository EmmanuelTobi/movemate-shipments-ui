import 'package:flutter/material.dart';
import 'package:movemateshipmentsui/screens/calculate/calculate_screen.dart';
import 'package:stacked/stacked.dart';

class CalculateViewModel extends BaseViewModel {

  final List<String> categories = [
    'Documents',
    'Glass',
    'Liquid',
    'Food',
    'Electronic',
    'Product',
    'Others',
  ];
  String? selectedCategory = '';

  List<Widget> setupWidgetList({
    TextEditingController? receiverLocationController,
    TextEditingController? weightController,
    Function(String? s)? onCategorySelected,
    Function? onNavigateToNext,
}) {

    return [

      const Text(
        'Destination',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),

      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.upload_outlined),
              hintText: 'Sender location',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[200],
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: receiverLocationController,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.download_outlined),
              hintText: 'Receiver location',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[200],
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: weightController,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.scale_outlined),
              hintText: 'Approx weight',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[200],
            ),
          ),
        ],
      ),

      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          const Text(
            'Packaging',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            'What are you sending?',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Image.asset(
                  'assets/images/box.png',
                  width: 24,
                  height: 24,
                ),
                const SizedBox(width: 12),
                const Text(
                  'Box',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                const Icon(Icons.keyboard_arrow_down),
              ],
            ),
          ),
        ],
      ),

      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          const Text(
            'Categories',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            'What are you sending?',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: categories.map((category) {
              return CategoryItems(
                category: category,
                isSelected: selectedCategory == category,
                calculateViewModel: this,
                onSelect: (category) {
                  updateSelectedCategory(s: category);
                },
              );
            }).toList(),
          ),
        ],
      ),

      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 1.0, end: 1.0),
              duration: const Duration(milliseconds: 200),
              builder: (context, scale, child) {
                return Transform.scale(
                  scale: scale,
                  child: GestureDetector(
                    onTap: () {
                      onNavigateToNext?.call();
                    },
                    child: Container(
                      width: double.infinity,
                      height: 56,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
                        child: Text(
                          'Calculate',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),

    ];

  }

  void updateSelectedCategory({String? s}) {
    selectedCategory = s;
    notifyListeners();
  }


}