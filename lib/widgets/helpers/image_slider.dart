import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../colors/color_picker.dart';
import '../../constants/image_urls.dart';

class ImageSliderScreen extends StatefulWidget {
  const ImageSliderScreen({super.key});

  @override
  State<ImageSliderScreen> createState() => _ImageSliderScreenState();
}

class _ImageSliderScreenState extends State<ImageSliderScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    debugPrint(
      'ImageSliderScreen: Images loaded: ${AssetImageUrls.allImages.length}',
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentIndex < AssetImageUrls.allImages.length - 1) {
      _pageController.animateToPage(
        _currentIndex + 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentIndex > 0) {
      _pageController.animateToPage(
        _currentIndex - 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageList = AssetImageUrls.allImages;

    if (imageList.isEmpty) {
      debugPrint('ImageSliderScreen: No images available');
      return const Center(child: Text('No images to display'));
    }

    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              PageView.builder(
                controller: _pageController,
                itemCount: imageList.length,
                onPageChanged: (index) {
                  setState(() => _currentIndex = index);
                  debugPrint('ImageSliderScreen: Current index: $index');
                },
                physics:
                    const AlwaysScrollableScrollPhysics(), // Ensure swiping works
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        imageList[index],
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                        errorBuilder: (context, error, stackTrace) {
                          debugPrint('Image error: $error');
                          return const Center(
                            child: Text('Image failed to load'),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
              // Navigation buttons
              Positioned(
                left: 12,
                top: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(30), // Rounded corners
                  ),
                  child: IconButton(
                    icon: const Icon(
                      CupertinoIcons.arrow_left_circle,
                      color: ColorPicker.cyberYellow,
                      size: 30,
                    ),
                    onPressed: _previousPage,
                  ),
                ),
              ),
              Positioned(
                right: 12,
                top: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(30), // Rounded corners
                  ),
                  child: IconButton(
                    icon: const Icon(
                      CupertinoIcons.arrow_right_circle,
                      color: ColorPicker.cyberYellow,
                      size: 30,
                    ),
                    onPressed: _nextPage,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _buildPageIndicator(imageList.length),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _buildPageIndicator(int length) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(length, (index) {
        bool isActive = index == _currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 16 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: isActive ? Colors.blueAccent : Colors.grey,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}
