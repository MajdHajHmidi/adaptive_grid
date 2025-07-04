import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

class AdaptiveGrid extends StatelessWidget {
  final Widget Function(BuildContext context, int index) itembuilder;
  final int itemCount;
  final double minimumItemWidth;
  final double verticalSpacing;
  final double horizontalSpacing;

  /// Optional maximum width for each item
  final double? maximumItemWidth;

  /// Optional alignment for each item (defaults to topLeft)
  final Alignment? itemAlignment;

  final bool _sliver;

  const AdaptiveGrid({
    super.key,
    required this.itemCount,
    required this.itembuilder,
    required this.minimumItemWidth,
    this.verticalSpacing = 0,
    this.horizontalSpacing = 0,
    this.maximumItemWidth,
    this.itemAlignment,
  }) : _sliver = false;

  const AdaptiveGrid.sliver({
    super.key,
    required this.itemCount,
    required this.itembuilder,
    required this.minimumItemWidth,
    this.verticalSpacing = 0,
    this.horizontalSpacing = 0,
    this.maximumItemWidth,
    this.itemAlignment,
  }) : _sliver = true;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    int crossAxisCount = (width ~/ (minimumItemWidth + horizontalSpacing))
        .clamp(1, itemCount);

    final rowCount = (itemCount / crossAxisCount).ceil();

    final useFallbackWrap =
        itemCount <= crossAxisCount && maximumItemWidth != null;

    // ignore: no_leading_underscores_for_local_identifiers
    final _itemAlignment =
        itemAlignment != null
            ? itemAlignment!
            : Directionality.of(context) == TextDirection.ltr
            ? Alignment.topLeft
            : Alignment.topRight;

    final List<Widget> children = List.generate(itemCount, (index) {
      final item = itembuilder(context, index);
      if (maximumItemWidth == null) return item;

      return ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maximumItemWidth!,
          minWidth: useFallbackWrap ? maximumItemWidth! : minimumItemWidth,
        ),
        child: IntrinsicWidth(
          child: Align(alignment: _itemAlignment, child: item),
        ),
      );
    });

    final fallbackWrap = Wrap(
      spacing: horizontalSpacing,
      runSpacing: verticalSpacing,
      alignment: _alignmentToWrapAlignment(_itemAlignment),
      children: children,
    );

    final gridWidget = LayoutGrid(
      columnSizes: List.filled(
        crossAxisCount,
        maximumItemWidth != null ? auto : 1.fr,
      ),
      rowSizes: List.filled(rowCount, auto),
      columnGap: horizontalSpacing,
      rowGap: verticalSpacing,
      children: children,
    );

    final content = useFallbackWrap ? fallbackWrap : gridWidget;

    if (_sliver) {
      return SliverToBoxAdapter(child: content);
    }

    return content;
  }

  /// Helper: convert Flutter Alignment to WrapAlignment
  WrapAlignment _alignmentToWrapAlignment(Alignment alignment) {
    if (alignment == Alignment.topCenter ||
        alignment == Alignment.center ||
        alignment == Alignment.bottomCenter) {
      return WrapAlignment.center;
    } else if (alignment == Alignment.topRight ||
        alignment == Alignment.centerRight ||
        alignment == Alignment.bottomRight) {
      return WrapAlignment.end;
    } else {
      return WrapAlignment.start;
    }
  }
}
