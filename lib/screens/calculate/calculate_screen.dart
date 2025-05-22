import 'package:flutter/material.dart';
import 'package:movemateshipmentsui/utils/constants.dart';
import 'package:movemateshipmentsui/widgets/animated_list_view.dart';
import 'calculation_result_screen.dart';

class CalculateScreen extends StatefulWidget {
  const CalculateScreen({super.key});

  @override
  State<CalculateScreen> createState() => _CalculateScreenState();
}

class _CalculateScreenState extends State<CalculateScreen> {
  final TextEditingController _senderLocationController = TextEditingController();
  final TextEditingController _receiverLocationController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  String? _selectedCategory;

  final List<String> categories = [
    'Documents',
    'Glass',
    'Liquid',
    'Food',
    'Electronic',
    'Product',
    'Others',
  ];

  @override
  Widget build(BuildContext context) {

    List<Widget> widgetList = [

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
          controller: _receiverLocationController,
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
          controller: _weightController,
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
            return _buildBouncingCategory(category);
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
                  onTapDown: (_) {
                    setState(() {
                      (context as Element).markNeedsBuild();
                    });
                  },
                  onTapUp: (_) {
                    setState(() {
                      (context as Element).markNeedsBuild();
                      if (_selectedCategory != null &&
                          _senderLocationController.text.isNotEmpty &&
                          _receiverLocationController.text.isNotEmpty &&
                          _weightController.text.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                            const CalculationResultScreen(
                              amount: 1453.00,
                            ),
                          ),
                        );
                      }
                    });
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF6C63FF),
        centerTitle: true,
        title: const Text(
          'Calculate',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 16
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: AnimatedListView(
            scrollDirection: Axis.vertical,
            staggerDuration: const Duration(milliseconds: 200),
            animationDuration: const Duration(milliseconds: 500),
            itemBuilder: (context, child, animation) {
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: animation.drive(Tween(
                    begin: const Offset(0.0, 1.0),
                    end: const Offset(0.0, 0.0),
                  ).chain(CurveTween(curve: Curves.easeOutCubic))),
                  child: child,
                ),
              );
            },
            children: widgetList,
          ),
        ),
      ),
    );
  }

  Widget _buildBouncingCategory(String category) {
    final isSelected = _selectedCategory == category;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 1.0, end: isSelected ? 0.95 : 1.0),
      duration: const Duration(milliseconds: 200),
      builder: (context, scale, child) {
        return Transform.scale(
          scale: scale,
          child: GestureDetector(
            onTapDown: (_) {
              setState(() {
                _selectedCategory = category;
              });
            },
            onTapUp: (_) {
              setState(() {
              });
            },
            onTapCancel: () {
              setState(() {
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(
                  color: isSelected ? Colors.black87 : Colors.grey[300]!,
                  width: isSelected ? 2 : 1,
                ),
                borderRadius: BorderRadius.circular(10),
                color: isSelected ? Colors.black87 : null,
              ),
              child: Text(
                category,
                style: TextStyle(
                  fontSize: 14,
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
