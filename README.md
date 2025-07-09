# adaptive_grid

A lightweight Flutter widget that turns a list of widgets into a responsive grid layout using `flutter_layout_grid`. It automatically adjusts the number of columns based on screen width, a minimum item width, and configurable spacing.

Supports both regular and sliver-based grids out of the box.

---

## 👀 Preview
![Sample 1](https://raw.githubusercontent.com/MajdHajHmidi/adaptive_grid/master/example/Adaptive%20Grid%20-%20Blogs.gif)

![Sample 2](https://raw.githubusercontent.com/MajdHajHmidi/adaptive_grid/master/example/Adaptive%20Grid%20-%20Products.gif)

---

## ✨ Features

- Fully responsive layout using `minimumItemWidth`
- Auto-calculated column count and row sizes
- Configurable `horizontalSpacing` and `verticalSpacing`
- Optional `SliverToBoxAdapter` support via `.sliver` constructor
- Built on top of the powerful `flutter_layout_grid`

---

## 🚀 Getting Started

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  responsive_layout_grid:
```

Import it in your Dart code:
```dart
import 'package:responsive_layout_grid/responsive_layout_grid.dart';
```

## 📦 Usage
### Regular grid
```dart
AdaptiveGrid(
  itemCount: items.length,
  minimumItemWidth: 200,
  horizontalSpacing: 16,
  verticalSpacing: 24,
  itembuilder: (context, index) => ItemCard(data: items[index]),
)
```

### Sliver grid (inside a CustomScrollView)
```dart
CustomScrollView(
  slivers: [
    AdaptiveGrid.sliver(
      itemCount: items.length,
      minimumItemWidth: 250,
      horizontalSpacing: 16,
      verticalSpacing: 24,
      itembuilder: (context, index) => ItemCard(data: items[index]),
    ),
  ],
)
```

## 📄 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## 🙌 Contributing

Pull requests and issues are welcome! Feel free to suggest improvements or features.
