import 'package:flutter/material.dart';
import 'package:movemateshipmentsui/viewmodels/calculate_view_model.dart';
import 'package:movemateshipmentsui/widgets/animated_list_view.dart';
import 'package:stacked/stacked.dart';
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

  @override
  Widget build(BuildContext context) {

    return ViewModelBuilder<CalculateViewModel>.reactive(
        viewModelBuilder: () => CalculateViewModel(),
        disposeViewModel: false,
        onViewModelReady:(model) async {

        },
        builder: (context, model, child) {
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
                children: model.setupWidgetList(
                  receiverLocationController: _receiverLocationController,
                  weightController: _weightController,
                  onCategorySelected: (s) {
                  },
                  onNavigateToNext: (){
                    setState(() {
                      (context as Element).markNeedsBuild();
                      if (model.selectedCategory != null) {

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
                ),
              ),
            ),
          ),
        );
      }
    );
  }

}

class CategoryItems extends StatefulWidget {
  const CategoryItems({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onSelect,
    this.calculateViewModel,
  });

  final String category;
  final bool isSelected;
  final ValueChanged<String> onSelect;
  final CalculateViewModel? calculateViewModel;

  @override
  State<CategoryItems> createState() => _CategoryItemsState();
}

class _CategoryItemsState extends State<CategoryItems> {

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CalculateViewModel>.reactive(
        viewModelBuilder: () => widget.calculateViewModel ?? CalculateViewModel(),
        disposeViewModel: false,
        builder: (context, model, child) {
        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 1.0, end: (widget.category == model.selectedCategory) ? 0.95 :1.0),
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeInOut,
          builder: (context, scale, child) {
            return Transform.scale(
              scale: scale,
              child: GestureDetector(
                onTap: () {
                  model.updateSelectedCategory(s: widget.category);
                },
                onTapCancel: () => {},
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: widget.category == model.selectedCategory ? Colors.black : Colors.grey.withOpacity(0.4),
                      width: widget.category == model.selectedCategory ? 2 : 0.9,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    color: widget.category == model.selectedCategory ? Colors.black : Colors.white,
                  ),
                  child: Container(
                    width: widget.category == model.selectedCategory ? 85 : 75,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if(widget.category == model.selectedCategory) ... [
                          const Icon(Icons.check, color: Colors.white, size: 12,)
                        ],
                        const SizedBox(width: 4,),
                        Text(
                          widget.category,
                          style: TextStyle(
                            fontSize: 12,
                            color: widget.category == model.selectedCategory ? Colors.white : Colors.black,
                            fontWeight: widget.category == model.selectedCategory ? FontWeight.bold :  FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }
    );
  }
}
