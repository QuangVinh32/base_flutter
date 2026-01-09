import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shop_food_app/library/app_utils.dart';
import 'package:shop_food_app/theme/app_theme.dart';

class SwiperBanner extends StatefulWidget {
  final List<String> images;
  final double height;
  final BorderRadius? borderRadius;
  final double paddingHorizontal;
  final double paddingVertical;
  final Duration autoPlayInterval;
  final bool autoPlay;

  const SwiperBanner({
    super.key,
    required this.images,
    this.height = 160,
    this.borderRadius,
    this.paddingHorizontal = 16.0,
    this.paddingVertical = 0.0,
    this.autoPlayInterval = const Duration(seconds: 3),
    this.autoPlay = true,
  });

  @override
  State<SwiperBanner> createState() => _SwiperBannerState();
}

class _SwiperBannerState extends State<SwiperBanner> {
  final PageController _controller = PageController();
  int _index = 0;
  Timer? _timer;
  bool _isManualSwiping = false;

  @override
  void initState() {
    super.initState();
    _startAutoPlay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _startAutoPlay() {
    if (!widget.autoPlay || widget.images.length <= 1) return;

    _timer?.cancel();
    _timer = Timer.periodic(widget.autoPlayInterval, (_) {
      if (_controller.hasClients && !_isManualSwiping) {
        final next = (_index + 1) % widget.images.length;
        _controller.animateToPage(
          next,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _stopAutoPlay() {
    _timer?.cancel();
    _timer = null;
  }

  void _onPageChanged(int index) {
    setState(() => _index = index);
  }

  Widget _buildImage(String path, AppTheme theme) {
    final isNetwork = path.startsWith('http');

    return isNetwork
        ? Image.network(
            path,
            fit: BoxFit.cover,
            width: double.infinity,
            loadingBuilder: (context, child, progress) {
              if (progress == null) return child;
              return _loading(theme);
            },
            errorBuilder: (_, __, ___) => _error(theme),
          )
        : Image.asset(
            path,
            fit: BoxFit.cover,
            width: double.infinity,
            errorBuilder: (_, __, ___) => _error(theme),
          );
  }

  Widget _loading(AppTheme theme) {
    return Container(
      color: theme.colors.surface,
      child: const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _error(AppTheme theme) {
    return Container(
      color: theme.colors.surface,
      child: Center(
        child: Icon(
          Icons.broken_image,
          size: 48,
          color: theme.colors.textDisabled,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    if (widget.images.isEmpty) {
      return Container(
        height: widget.height,
        margin: EdgeInsets.symmetric(
          horizontal: widget.paddingHorizontal,
          vertical: widget.paddingVertical,
        ),
        decoration: BoxDecoration(
          color: theme.colors.surface,
          borderRadius:
              widget.borderRadius ?? BorderRadius.circular(AppUtils.radius),
        ),
        child: Center(
          child: Icon(Icons.image, color: theme.colors.textDisabled, size: 48),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: widget.paddingHorizontal,
        vertical: widget.paddingVertical,
      ),
      child: Column(
        children: [
          GestureDetector(
            onPanDown: (_) {
              _isManualSwiping = true;
              _stopAutoPlay();
            },
            onPanEnd: (_) {
              _isManualSwiping = false;
              _startAutoPlay();
            },
            child: ClipRRect(
              borderRadius:
                  widget.borderRadius ?? BorderRadius.circular(AppUtils.radius),
              child: SizedBox(
                height: widget.height,
                child: PageView.builder(
                  controller: _controller,
                  itemCount: widget.images.length,
                  onPageChanged: _onPageChanged,
                  itemBuilder: (_, i) =>
                      _buildImage(widget.images[i], theme),
                ),
              ),
            ),
          ),

          const SizedBox(height: 8),

          if (widget.images.length > 1)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.images.length,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _index == i ? 16 : 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: _index == i
                        ? theme.colors.accent
                        : theme.colors.border,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
