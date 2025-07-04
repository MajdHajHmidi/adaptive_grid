import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

class AdaptiveGrid extends StatelessWidget {
  final Widget Function(BuildContext context, int index) itembuilder;
  final int itemCount;
  final double minimumItemWidth;

  /// When `itemCount` is less than the possible `crossAxisCount`,
  /// invisible items are added to fill up the remaining space
  /// in case `disableStretch` is true
  final bool disableStretch;
  final double verticalSpacing;
  final double horizontalSpacing;
  final TextDirection? textDirection;

  final bool _sliver;

  const AdaptiveGrid({
    super.key,
    required this.itemCount,
    required this.itembuilder,
    required this.minimumItemWidth,
    this.disableStretch = false,
    this.verticalSpacing = 0,
    this.horizontalSpacing = 0,
    this.textDirection,
  }) : _sliver = false;

  const AdaptiveGrid.sliver({
    super.key,
    required this.itemCount,
    required this.itembuilder,
    required this.minimumItemWidth,
    this.disableStretch = false,
    this.verticalSpacing = 0,
    this.horizontalSpacing = 0,
    this.textDirection,
  }) : _sliver = true;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    // Calculate available width for columns (total minus gaps)
    // If there are n columns, there are (n - 1) gaps between them.
    int crossAxisCount = (width ~/ (minimumItemWidth + horizontalSpacing))
        .clamp(1, itemCount);

    int maxCrossAxisCount =
        (width ~/ (minimumItemWidth + horizontalSpacing)).floor();

    final rowCount = (itemCount / crossAxisCount).ceil();

    final gridWidget = LayoutGrid(
      columnSizes: List.filled(
        (disableStretch && itemCount < maxCrossAxisCount)
            ? maxCrossAxisCount
            : crossAxisCount,
        1.fr,
      ),
      rowSizes: List.filled(rowCount, auto),
      columnGap: horizontalSpacing,
      rowGap: verticalSpacing,
      textDirection: textDirection,
      children: [
        ...List.generate(itemCount, (index) => itembuilder(context, index)),
        if (disableStretch && itemCount < maxCrossAxisCount)
          ...List.generate(
            maxCrossAxisCount - itemCount,
            (_) => SizedBox.shrink(),
          ),
      ],
    );

    if (_sliver) {
      return SliverToBoxAdapter(child: gridWidget);
    }

    return gridWidget;
  }
}
