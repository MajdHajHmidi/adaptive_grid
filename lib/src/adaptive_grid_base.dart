import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

class AdaptiveGrid extends StatelessWidget {
  final Widget Function(BuildContext context, int index) itembuilder;
  final int itemCount;
  final double minimumItemWidth;
  final double verticalSpacing;
  final double horizontalSpacing;

  final bool _sliver;

  const AdaptiveGrid({
    super.key,
    required this.itemCount,
    required this.itembuilder,
    required this.minimumItemWidth,
    this.verticalSpacing = 0,
    this.horizontalSpacing = 0,
  }) : _sliver = false;

  const AdaptiveGrid.sliver({
    super.key,
    required this.itemCount,
    required this.itembuilder,
    required this.minimumItemWidth,
    this.verticalSpacing = 0,
    this.horizontalSpacing = 0,
  }) : _sliver = true;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    // Calculate available width for columns (total minus gaps)
    // If there are n columns, there are (n - 1) gaps between them.
    int crossAxisCount = (width ~/ (minimumItemWidth + horizontalSpacing))
        .clamp(1, itemCount);

    final rowCount = (itemCount / crossAxisCount).ceil();

    final gridWidget = LayoutGrid(
      columnSizes: List.filled(crossAxisCount, 1.fr),
      rowSizes: List.filled(rowCount, auto),
      columnGap: horizontalSpacing,
      rowGap: verticalSpacing,
      children:
          List.generate(
            itemCount,
            (index) => itembuilder(context, index),
          ).toList(),
    );

    if (_sliver) {
      return SliverToBoxAdapter(child: gridWidget);
    }

    return gridWidget;
  }
}
