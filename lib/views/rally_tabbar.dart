import 'package:flutter/material.dart';

class RallyTab extends StatefulWidget {
  RallyTab({
    TextStyle textStyle,
    IconData iconData,
    String title,
    int tabIndex,
    TabController tabController,
    this.isVertical,
    this.color = Colors.blueAccent,
    this.tabCount = 1,
  })  : titleText = Text(title, style: textStyle),
        isExpanded = tabController.index == tabIndex,
        icon = Icon(
          iconData,
          semanticLabel: title,
          color: color,
        );

  final Text titleText;
  final Icon icon;
  final bool isExpanded;
  final bool isVertical;
  final Color color;
  final int tabCount;

  @override
  _RallyTabState createState() => _RallyTabState();
}

class _RallyTabState extends State<RallyTab>
    with SingleTickerProviderStateMixin {
  Animation<double> _titleSizeAnimation;
  Animation<double> _titleFadeAnimation;
  Animation<double> _iconFadeAnimation;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _titleSizeAnimation = _controller.view;
    _titleFadeAnimation = _controller.drive(CurveTween(curve: Curves.easeOut));
    _iconFadeAnimation = _controller.drive(Tween<double>(begin: 0.6, end: 1));
    if (widget.isExpanded) {
      _controller.value = 1;
    }
  }

  @override
  void didUpdateWidget(RallyTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isExpanded) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isVertical) {
      return Column(
        children: [
          const SizedBox(height: 18),
          FadeTransition(
            child: widget.icon,
            opacity: _iconFadeAnimation,
          ),
          const SizedBox(height: 12),
          FadeTransition(
            child: SizeTransition(
              child: Center(child: ExcludeSemantics(child: widget.titleText)),
              axis: Axis.vertical,
              axisAlignment: -1,
              sizeFactor: _titleSizeAnimation,
            ),
            opacity: _titleFadeAnimation,
          ),
          const SizedBox(height: 18),
        ],
      );
    }
    final width = MediaQuery.of(context).size.width;
    const expandedTitleWidthMultiplier = 2;
    final unitWidth = width / (widget.tabCount + expandedTitleWidthMultiplier);

    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 56),
      child: Row(
        children: [
          FadeTransition(
            child: SizedBox(
              width: unitWidth,
              child: widget.icon,
            ),
            opacity: _iconFadeAnimation,
          ),
          FadeTransition(
            child: SizeTransition(
              child: SizedBox(
                width: unitWidth * expandedTitleWidthMultiplier,
                child: Center(
                  child: ExcludeSemantics(child: widget.titleText),
                ),
              ),
              axis: Axis.horizontal,
              axisAlignment: -1,
              sizeFactor: _titleSizeAnimation,
            ),
            opacity: _titleFadeAnimation,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class RallyTabBar extends StatelessWidget {
  const RallyTabBar({Key key, this.tabs, this.tabController}) : super(key: key);

  final List<Widget> tabs;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return FocusTraversalOrder(
      order: const NumericFocusOrder(0),
      child: TabBar(
        isScrollable: true,
        labelPadding: EdgeInsets.zero,
        tabs: tabs,
        controller: tabController,
        indicatorColor: Colors.transparent,
      ),
    );
  }
}
