import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// list of all 6 user guide images from assets
const List<String> _guideImages = [
  'assets/CC User Guide/1.png',
  'assets/CC User Guide/2.png',
  'assets/CC User Guide/3.png',
  'assets/CC User Guide/4.png',
  'assets/CC User Guide/5.png',
  'assets/CC User Guide/6.png',
];

// step captions shown below each guide image
const List<String> _guideCaptions = [
  'Step 1: Tap PROCEED on the landing page to enter the Citizen\'s Charter.',
  'Step 2: The left panel shows all service categories. Tap one to expand it.',
  'Step 3: Choose External or Internal Services from the dropdown.',
  'Step 4: Tap a service from the list to view its details.',
  'Step 5: The service guide will open as a PDF on the right panel.',
  'Step 6: Use the search bar to find any service across all categories.',
];

// UserGuideDialog - full-screen dialog that shows the image slideshow
class UserGuideDialog extends StatefulWidget {
  const UserGuideDialog({super.key});

  @override
  State<UserGuideDialog> createState() => _UserGuideDialogState();
}

class _UserGuideDialogState extends State<UserGuideDialog> {
  // tracks which guide step is currently shown
  int _currentPage = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // go to next page or close if on last page
  void _next() {
    if (_currentPage < _guideImages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.of(context).pop(); // close on last step
    }
  }

  // go to previous page
  void _prev() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isLast = _currentPage == _guideImages.length - 1;
    final bool isFirst = _currentPage == 0;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(24),
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(maxWidth: 700),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // header bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.green.shade700,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.menu_book_rounded, color: Colors.white, size: 22),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'User Guide',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  // step counter e.g. "2 / 6"
                  Text(
                    '${_currentPage + 1} / ${_guideImages.length}',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 8),
                  // close button
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(Icons.close, color: Colors.white, size: 20),
                  ),
                ],
              ),
            ),

            // image slideshow
            SizedBox(
              height: 380,
              child: PageView.builder(
                controller: _pageController,
                itemCount: _guideImages.length,
                onPageChanged: (i) => setState(() => _currentPage = i),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        _guideImages[index],
                        fit: BoxFit.contain,
                      ),
                    ),
                  );
                },
              ),
            ),

            // dot indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_guideImages.length, (i) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentPage == i ? 20 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentPage == i
                        ? Colors.green.shade700
                        : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              }),
            ),
            const SizedBox(height: 12),

            // caption text for current step
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                _guideCaptions[_currentPage],
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: Colors.grey.shade700,
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // prev / next buttons
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Row(
                children: [
                  // prev — hidden on first step
                  if (!isFirst)
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _prev,
                        icon: const Icon(Icons.arrow_back_ios, size: 14),
                        label: const Text('Previous'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.green.shade700,
                          side: BorderSide(color: Colors.green.shade700),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  if (!isFirst) const SizedBox(width: 12),
                  // next / done
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _next,
                      icon: Icon(
                        isLast ? Icons.check : Icons.arrow_forward_ios,
                        size: 14,
                      ),
                      label: Text(isLast ? 'Done' : 'Next'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade700,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// UserGuideButton - chatbot-style button, bottom right of landing page
// has a press scale animation on tap and opens the guide with scale+fade dialog
class UserGuideButton extends StatefulWidget {
  const UserGuideButton({super.key});

  @override
  State<UserGuideButton> createState() => _UserGuideButtonState();
}

class _UserGuideButtonState extends State<UserGuideButton>
    with SingleTickerProviderStateMixin {
  // amo nadi - press animation controller, shrinks button on tap then bounces back
  late final AnimationController _pressController;
  // amo nadi - scale animation, 1.0 to 0.85 on press
  late final Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    // amo nadi - 120ms total, fast enough to feel snappy
    _pressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
    );
    // amo nadi - shrinks to 85% then returns to 100%
    _scaleAnim = Tween<double>(begin: 1.0, end: 0.85).animate(
      CurvedAnimation(parent: _pressController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pressController.dispose(); // amo nadi - dispose animation controller
    super.dispose();
  }

  Future<void> _handleTap(BuildContext context) async {
    // amo nadi - play forward (shrink) then reverse (bounce back)
    await _pressController.forward();
    await _pressController.reverse();
    if (!context.mounted) return;
    // amo nadi - open dialog with scale+fade transition
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'UserGuide',
      barrierColor: Colors.black54,
      // amo nadi - 280ms with easeOutBack for a lively overshoot settle
      transitionDuration: const Duration(milliseconds: 280),
      pageBuilder: (_, __, ___) => const UserGuideDialog(),
      transitionBuilder: (context, animation, _, child) {
        // amo nadi - scale from 0.7 to 1.0
        final scale = Tween<double>(begin: 0.7, end: 1.0).animate(
          CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
        );
        // amo nadi - fade from 0 to 1 simultaneously with scale
        final fade = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: animation, curve: Curves.easeIn),
        );
        return FadeTransition(
          opacity: fade,
          child: ScaleTransition(scale: scale, child: child), // amo nadi
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 28,
      right: 28,
      // amo nadi - ScaleTransition wraps the whole button for press feedback
      child: ScaleTransition(
        scale: _scaleAnim,
        child: GestureDetector(
          onTap: () => _handleTap(context),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // circle button on top
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: Colors.green.shade700,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(Icons.menu_book_rounded, color: Colors.white, size: 28),
              ),
              const SizedBox(height: 6),
              // "User Guide" label below the circle
              Text(
                'User Guide',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Colors.greenAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
