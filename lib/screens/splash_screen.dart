import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'root_shell.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  // Phase 1 (0.00 - 0.42): scattered points converge into a globe network — the "screenplay" intro.
  late final Animation<double> _formation;
  // Phase 2 (0.40 - 0.62): logo fades/scales in over the settled globe.
  late final Animation<double> _logoFade;
  late final Animation<double> _logoScale;
  // Phase 3 (0.62 - 0.80 / 0.80 - 0.94): tagline lines.
  late final Animation<double> _line1Fade;
  late final Animation<double> _line2Fade;
  // Phase 4 (0.94 - 1.00): Parm mark.
  late final Animation<double> _parmFade;

  static const _totalDuration = Duration(milliseconds: 4400);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _totalDuration);

    _formation = CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.42, curve: Curves.easeOutCubic));
    _logoFade = CurvedAnimation(parent: _controller, curve: const Interval(0.40, 0.60, curve: Curves.easeOut));
    _logoScale = Tween<double>(begin: 0.7, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: const Interval(0.40, 0.62, curve: Curves.easeOutBack)));
    _line1Fade = CurvedAnimation(parent: _controller, curve: const Interval(0.62, 0.80, curve: Curves.easeOut));
    _line2Fade = CurvedAnimation(parent: _controller, curve: const Interval(0.80, 0.94, curve: Curves.easeOut));
    _parmFade = CurvedAnimation(parent: _controller, curve: const Interval(0.94, 1.0, curve: Curves.easeOut));

    _controller.forward();

    Future.delayed(_totalDuration + const Duration(milliseconds: 400), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const RootShell()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            return Stack(
              children: [
                // The animated "screenplay": a global network forming into a rotating globe.
                Positioned.fill(
                  child: CustomPaint(
                    painter: _GlobeNetworkPainter(
                      formation: _formation.value,
                      rotation: _controller.value * math.pi * 0.9,
                      fade: 1.0 - _logoFade.value * 0.55,
                    ),
                  ),
                ),
                // Logo + tagline, truly centered in the full screen.
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FadeTransition(
                          opacity: _logoFade,
                          child: ScaleTransition(
                            scale: _logoScale,
                            child: SizedBox(
                              width: 96,
                              height: 96,
                              child: Image.asset(
                                'assets/images/vasatyl_logo.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 28),
                        FadeTransition(
                          opacity: _line1Fade,
                          child: const Text(
                            'One Big World.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        FadeTransition(
                          opacity: _line2Fade,
                          child: const Text(
                            "Let's Get You Connected.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Parm mark, anchored to the bottom — shown only here, with a small
                // "from" label above it, matching how Meta labels its own apps.
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 26),
                    child: FadeTransition(
                      opacity: _parmFade,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Opacity(
                            opacity: 0.75,
                            child: Text(
                              'from',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.85),
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.6,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Opacity(
                            opacity: 0.95,
                            child: Image.asset(
                              'assets/images/parm_logo.png',
                              height: 56,
                              fit: BoxFit.contain,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

/// Paints a network of points that converge from scattered positions into a
/// rotating globe outline — the "screenplay" intro that plays before the
/// logo and tagline settle in.
class _GlobeNetworkPainter extends CustomPainter {
  final double formation; // 0..1, points converging into the globe
  final double rotation; // radians, continuous slow spin
  final double fade; // overall opacity once the logo takes over

  _GlobeNetworkPainter({required this.formation, required this.rotation, required this.fade});

  // Deterministic pseudo-random node layout so it looks organic but is stable across rebuilds.
  static final List<_Node> _nodes = List.generate(22, (i) {
    final seed = i * 137.5;
    final theta = (seed % 360) * math.pi / 180;
    final phi = ((seed * 1.7) % 180 - 90) * math.pi / 180;
    final scatterAngle = (seed * 2.3) % (2 * math.pi);
    final scatterRadius = 160.0 + (i % 5) * 30.0;
    return _Node(theta: theta, phi: phi, scatterAngle: scatterAngle, scatterRadius: scatterRadius);
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2 - 60);
    final globeRadius = math.min(size.width, size.height) * 0.20;

    final dotPaint = Paint()..color = Colors.white.withOpacity(0.75 * fade);
    final linePaint = Paint()
      ..color = Colors.white.withOpacity(0.18 * fade)
      ..strokeWidth = 1;

    final settled = <Offset>[];

    for (final node in _nodes) {
      // Target position: on the globe sphere, projected to 2D, with slow rotation.
      final rotatedTheta = node.theta + rotation;
      final x3 = math.cos(node.phi) * math.cos(rotatedTheta);
      final z3 = math.cos(node.phi) * math.sin(rotatedTheta);
      final y3 = math.sin(node.phi);
      // Simple orthographic projection; fade points on the far side slightly.
      final depth = (z3 + 1) / 2; // 0 (far) .. 1 (near)
      final target = Offset(center.dx + x3 * globeRadius, center.dy + y3 * globeRadius);

      // Scatter position (where the point starts, off to the sides).
      final scatter = Offset(
        center.dx + math.cos(node.scatterAngle) * node.scatterRadius,
        center.dy + math.sin(node.scatterAngle) * node.scatterRadius,
      );

      final t = Curves.easeOutCubic.transform(formation.clamp(0.0, 1.0));
      final pos = Offset.lerp(scatter, target, t)!;
      settled.add(pos);

      final radius = 1.6 + depth * 1.8;
      canvas.drawCircle(pos, radius, dotPaint..color = Colors.white.withOpacity((0.35 + depth * 0.5) * fade));
    }

    // Connect nearby settled points with faint lines to suggest a network.
    for (int i = 0; i < settled.length; i++) {
      for (int j = i + 1; j < settled.length; j++) {
        final d = (settled[i] - settled[j]).distance;
        if (d < globeRadius * 0.62) {
          final opacity = (1 - d / (globeRadius * 0.62)) * 0.22 * fade * formation;
          if (opacity > 0.01) {
            canvas.drawLine(settled[i], settled[j], linePaint..color = Colors.white.withOpacity(opacity));
          }
        }
      }
    }

    // A faint outer ring to read clearly as "a globe."
    final ringPaint = Paint()
      ..color = Colors.white.withOpacity(0.14 * fade * formation)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    canvas.drawCircle(center, globeRadius, ringPaint);
  }

  @override
  bool shouldRepaint(covariant _GlobeNetworkPainter oldDelegate) =>
      oldDelegate.formation != formation || oldDelegate.rotation != rotation || oldDelegate.fade != fade;
}

class _Node {
  final double theta;
  final double phi;
  final double scatterAngle;
  final double scatterRadius;
  const _Node({required this.theta, required this.phi, required this.scatterAngle, required this.scatterRadius});
}
