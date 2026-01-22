import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Universal deep-navigation transition:
/// - Forward: fade + slight slide up (enter)
/// - Back: faster, ease-in (exit)
///
/// Recommended for:
/// Home → List → Detail
CustomTransitionPage<T> fadeSlidePage<T>({
  required GoRouterState state,
  required Widget child,
  Duration forwardDuration = const Duration(milliseconds: 400),
  Duration reverseDuration = const Duration(milliseconds: 300),
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionDuration: forwardDuration,
    reverseTransitionDuration: reverseDuration,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.easeInCubic,
      );

      return FadeTransition(
        opacity: curved,
        child: SlideTransition(
          position: curved.drive(
            Tween(
              begin: const Offset(0, 0.12),
              end: Offset.zero,
            ),
          ),
          child: child,
        ),
      );
    },
  );
}
