import 'package:flutter/material.dart';
import 'package:movemateshipmentsui/widgets/animated_list_view.dart';

class CalculationResultScreen extends StatelessWidget {
  final double amount;

  const CalculationResultScreen({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Spacer(),
          Container(
            height: 700,
            alignment: Alignment.center,
            child: Center(
              child: AnimatedListView(
              scrollDirection: Axis.vertical,
              staggerDuration: const Duration(milliseconds: 200),
              animationDuration: const Duration(milliseconds: 400),
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
              children: [
                Image.asset('assets/images/box.png', width: 120, height: 120),
                const SizedBox(height: 32),
                const Text(
                  'Total Estimated Amount',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  '\$${amount.toStringAsFixed(2)} USD',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF00C853),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'This amount is estimated this will vary\nif you change your location or weight',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF8C00),
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Back to home',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
                    ),
            ),
              ),
        ],
      ),
    );
  }
}