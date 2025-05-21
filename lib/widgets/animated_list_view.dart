import 'package:flutter/material.dart';

class AnimatedListView extends StatefulWidget {
  final List<Widget> children;

  final Axis scrollDirection;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;
  final ScrollController? controller;
  final Duration animationDuration;
  final Duration staggerDuration;
  final Curve animationCurve;
  final Widget Function(BuildContext, Widget, Animation<double>) itemBuilder;

  const AnimatedListView({
    super.key,
    required this.children,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.physics,
    this.padding,
    this.controller,
    this.animationDuration = const Duration(milliseconds: 300),
    this.staggerDuration = const Duration(milliseconds: 50),
    this.animationCurve = Curves.easeInOut,
    this.itemBuilder = defaultItemBuilder,
  });

  static Widget defaultItemBuilder (
      BuildContext context,
      Widget child,
      Animation<double> animation
      ) {
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: animation.drive(Tween(
          begin: const Offset(0.5, 0.0),
          end: const Offset(0.0, 0.0),
        ).chain(CurveTween(curve: Curves.easeInOut))),
        child: child,
      ),
    );
  }

  @override
  State<AnimatedListView> createState() => _AnimatedListViewState();
}

class _AnimatedListViewState extends State<AnimatedListView> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  List<Widget> _items = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animateItems();
    });
  }

  @override
  void didUpdateWidget(AnimatedListView oldWidget) {
    super.didUpdateWidget(oldWidget);

    print(oldWidget.children.length);

    if (widget.children.length != oldWidget.children.length) {
      if (widget.children.length > _items.length) {
        for (int i = _items.length; i < widget.children.length; i++) {
          Future.delayed(widget.staggerDuration * i, () {
            if (mounted && _listKey.currentState != null) {
              _listKey.currentState!.insertItem(i, duration: widget.animationDuration);
              setState(() {
                _items.add(widget.children[i]);
              });
            }
          });
        }
      } else if (widget.children.length < _items.length) {
        for (int i = _items.length - 1; i >= widget.children.length; i--) {
          final removedItem = _items[i];
          _listKey.currentState?.removeItem(
            i,
            (context, animation) {
              return widget.itemBuilder(context, removedItem, animation);
            },
            duration: widget.animationDuration,
          );
          _items.removeAt(i);
        }
      }
    }
  }

  void _animateItems() {
    _items = [];
    for (int i = 0; i < widget.children.length; i++) {
      Future.delayed(widget.staggerDuration * i, () {
        if (mounted && _listKey.currentState != null) {
          _listKey.currentState!.insertItem(i, duration: widget.animationDuration);
          setState(() {
            if (i < widget.children.length) {
              _items.add(widget.children[i]);
            }
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: _listKey,
      scrollDirection: widget.scrollDirection,
      initialItemCount: _items.length,
      physics: widget.physics,
      padding: widget.padding,
      controller: widget.controller,
      shrinkWrap: widget.shrinkWrap,
      itemBuilder: (context, index, animation) {
        if (index >= _items.length) return const SizedBox();
        return widget.itemBuilder(context, _items[index], animation);
      },
    );
  }
}
