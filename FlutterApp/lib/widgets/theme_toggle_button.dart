import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/theme_provider.dart';

class ThemeToggleButton extends ConsumerWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeNotifier = ref.watch(themeModeProvider.notifier);
    final isDark = themeNotifier.isDarkMode;

    return FloatingActionButton.small(
      onPressed: () => themeNotifier.toggleTheme(),
      heroTag: 'theme_toggle',
      tooltip: isDark ? 'Switch to Light Mode' : 'Switch to Dark Mode',
      elevation: 4,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) {
          return RotationTransition(
            turns: animation,
            child: FadeTransition(opacity: animation, child: child),
          );
        },
        child: Icon(
          isDark ? Icons.light_mode : Icons.dark_mode,
          key: ValueKey(isDark),
        ),
      ),
    );
  }
}
