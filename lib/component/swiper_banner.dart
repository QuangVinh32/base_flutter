  import 'dart:async'; // Thêm import này
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
      _stopAutoPlay();
      _controller.dispose();
      super.dispose();
    }

    void _startAutoPlay() {
      if (!widget.autoPlay || widget.images.length <= 1) return;

      _timer?.cancel();
      _timer = Timer.periodic(widget.autoPlayInterval, (_) {
        if (_controller.hasClients && !_isManualSwiping) {
          final nextPage = (_index + 1) % widget.images.length;
          _controller.animateToPage(
            nextPage,
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
      // Reset manual swiping flag sau khi chuyển trang xong
      if (_isManualSwiping) {
        _isManualSwiping = false;
        // Restart timer sau khi người dùng swipe xong
        Future.delayed(const Duration(seconds: 2), _startAutoPlay);
      }
    }

    void _onManualSwipeStart() {
      _isManualSwiping = true;
      _stopAutoPlay();
    }

    void _onManualSwipeEnd() {
      if (_isManualSwiping) {
        _isManualSwiping = false;
        // Đợi 2 giây rồi restart auto play
        Future.delayed(const Duration(seconds: 2), _startAutoPlay);
      }
    }

    @override
    Widget build(BuildContext context) {
      final theme = AppTheme.of(context);

      if (widget.images.isEmpty) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: widget.paddingHorizontal,
            vertical: widget.paddingVertical,
          ),
          child: Container(
            height: widget.height,
            decoration: BoxDecoration(
              color: theme.colors.surface,
              borderRadius: widget.borderRadius ?? BorderRadius.circular(16),
            ),
            child: Center(
              child: Icon(
                Icons.image,
                size: 48,
                color: theme.colors.textDisabled,
              ),
            ),
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
            // Banner với gesture detector để xử lý swipe
            GestureDetector(
              onPanDown: (_) => _onManualSwipeStart(),
              onPanEnd: (_) => _onManualSwipeEnd(),
              onPanCancel: _onManualSwipeEnd,
              child: ClipRRect(
                borderRadius: widget.borderRadius ?? BorderRadius.circular(AppUtils.radius),
                child: SizedBox(
                  height: widget.height,
                  child: Stack(
                    children: [
                      // PageView
                      PageView.builder(
                        controller: _controller,
                        itemCount: widget.images.length,
                        onPageChanged: _onPageChanged,
                        itemBuilder: (_, i) {
                          return Image.network(
                            widget.images[i],
                            fit: BoxFit.cover,
                            width: double.infinity,
                            errorBuilder: (context, error, stackTrace) {
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
                            },
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                color: theme.colors.surface,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress.cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),

                      // Gradient overlay ở dưới cùng (tùy chọn)
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 20,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.1),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Auto play indicator (tùy chọn)
                      if (widget.autoPlay && widget.images.length > 1)
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(AppUtils.radius),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  _timer?.isActive == true
                                      ? Icons.play_circle_filled
                                      : Icons.pause_circle_filled,
                                  color: Colors.white,
                                  size: 12,
                                ),
                                const SizedBox(width: 4),
                                const Text(
                                  'Auto',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 8),

            // Dots indicator với số thứ tự
            if (widget.images.length > 1)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Chỉ số hiện tại / tổng số
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colors.accent.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${_index + 1}/${widget.images.length}',
                      style: theme.text.caption.copyWith(
                        color: theme.colors.accent,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  // Dots indicator
                  ...List.generate(
                    widget.images.length,
                    (i) => GestureDetector(
                      onTap: () {
                        _onManualSwipeStart();
                        _controller.animateToPage(
                          i,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        ).then((_) => _onManualSwipeEnd());
                      },
                      child: AnimatedContainer(
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
          ],
        ),
      );
    }
  }