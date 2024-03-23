import 'rev_text.dart';

class AutoScrollText extends StatefulWidget {
  const AutoScrollText(
    this.text, {
    super.key,
    this.style,
    this.delayBefore = const Duration(seconds: 2),
    this.duration = const Duration(seconds: 1),
    this.delayBetween = const Duration(seconds: 2),
  });
  final String text;
  final TextStyle? style;
  final Duration delayBefore;
  final Duration duration;
  final Duration delayBetween;

  @override
  State<AutoScrollText> createState() {
    return _AutoScrollTextState();
  }
}

class _AutoScrollTextState extends State<AutoScrollText> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animate();
    });
  }

  @override
  void didUpdateWidget(covariant AutoScrollText oldWidget) {
    if (widget.text != oldWidget.text) {
      _scrollController.jumpTo(0);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      child: RevText(
        widget.text,
        fontSize: widget.style?.fontSize?.sp,
        fontWeight: widget.style?.fontWeight,
        color: widget.style?.color,
      ),
    );
  }

  Future<void> _animate() async {
    await Future<dynamic>.delayed(widget.delayBefore);

    while (mounted) {
      await _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: widget.duration,
          curve: Curves.linear);
      await Future<dynamic>.delayed(const Duration(milliseconds: 500));

      if (!mounted) break;
      await _scrollController.animateTo(
          _scrollController.position.minScrollExtent,
          duration: widget.duration,
          curve: Curves.linear);
      await Future<dynamic>.delayed(widget.delayBetween);
    }
  }
}
