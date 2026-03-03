import 'package:flutter/material.dart';

class Refreshable extends StatelessWidget {
  const Refreshable({
    required this.child,
    required this.onRefresh,
    this.wrapWithScrollView = false,
    super.key,
  });
  final VoidCallback onRefresh;
  final Widget child;
  final bool wrapWithScrollView;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        onRefresh();
      },
      child: wrapWithScrollView
          ? LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: constraints.maxHeight,
                    ),
                    child: child,
                  ),
                );
              },
            )
          : child,
    );
  }
}
