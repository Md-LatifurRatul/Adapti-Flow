<div align="center">

# AdaptiFlow

**A comprehensive zero-dependency Flutter responsive design system with adaptive layouts, design-proportional scaling, and fully customizable breakpoints**

[![pub package](https://img.shields.io/pub/v/adapti_flow.svg)](https://pub.dev/packages/adapti_flow)
![Flutter](https://img.shields.io/badge/Flutter-02569B?style=flat-square&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=flat-square&logo=dart&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green.svg?style=flat-square)
![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web%20%7C%20macOS%20%7C%20Windows%20%7C%20Linux-blue?style=flat-square)

[Features](#-features) • [Installation](#-installation) • [Quick Start](#-quick-start) • [Examples](#-real-world-examples) • [API Reference](#-api-reference)

</div>

---

## Why AdaptiFlow?

| Problem | AdaptiFlow Solution |
|---------|-------------------|
| Overflow errors on different screens | Zero overflow with percentage sizing |
| MediaQuery code everywhere | Clean context extensions |
| Hardcoded pixels breaking layouts | Adaptive responsive values |
| Different layouts for each device | Single codebase, auto-adapts |
| Inconsistent UI across platforms | Perfect on all 6 platforms |
| No customizable breakpoints | Fully configurable via InheritedWidget |

---

## Features

- **Percentage-Based Sizing** — `context.wp(80)`, `context.hp(30)`
- **Design-Proportional Scaling** — `context.w()`, `context.h()`, `context.r()`, `context.sp()` (flutter_screenutil alternative)
- **Device Detection** — `context.isMobile`, `context.isTablet`, `context.isDesktop`, `context.deviceType`
- **Adaptive Values** — `context.adaptivePadding`, `context.adaptiveMargin`, `context.adaptiveSpacing`
- **Customizable Config** — `AdaptiFlow` InheritedWidget with `AdaptiFlowData` for breakpoints, scale factors, design size
- **Layout Widgets** — `ResponsiveLayout`, `ResponsiveLayoutBuilder`, `SafeResponsiveLayout`
- **Utility Widgets** — `ResponsiveText`, `ResponsiveGrid`, `ResponsivePadding`, `ResponsiveVisibility`
- **Spacer System** — `ResponsiveSpacer` with auto-direction detection
- **Widget Constraints** — `.constrained()`, `.adaptiveConstrained()` extensions
- **Zero Dependencies** — Pure Flutter, works on iOS, Android, Web, macOS, Windows, Linux

---

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  adapti_flow: ^1.0.0
```

Then run:

```bash
flutter pub get
```

Import:

```dart
import 'package:adapti_flow/adapti_flow.dart';
```

---

## Quick Start

```dart
import 'package:flutter/material.dart';
import 'package:adapti_flow/adapti_flow.dart';

// 1. Wrap your app (optional — works with zero config)
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AdaptiFlow(
      data: const AdaptiFlowData(), // all defaults, or customize any field
      child: MaterialApp(home: HomePage()),
    );
  }
}

// 2. Use anywhere via context extensions
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeResponsiveLayout(
        padding: EdgeInsets.all(context.adaptivePadding),
        child: Column(
          children: [
            Container(
              width: context.wp(90),   // 90% of screen width
              height: context.hp(25),  // 25% of screen height
              color: Colors.blue,
              child: Center(
                child: ResponsiveText(
                  'Perfect on All Devices!',
                  baseFontSize: 18,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            Spacers.s16,  // 16px auto-direction spacer
            Text(
              'This looks great everywhere',
              style: TextStyle(fontSize: context.fontSize(16)),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

## Complete Usage Guide

### 1. Configuration (Optional)

Wrap your app with `AdaptiFlow` to customize any default value:

```dart
AdaptiFlow(
  data: AdaptiFlowData(
    // Custom breakpoints
    mobileBreakpoint: 500,
    desktopBreakpoint: 1024,
    widescreenBreakpoint: 1920,

    // Design reference size (for w/h/r/sp scaling)
    designSize: Size(390, 844),  // Your Figma/design mockup size

    // Scale factors
    tabletScaleFactor: 1.2,
    desktopScaleFactor: 1.5,

    // Font scale factors
    tabletFontScale: 1.15,
    desktopFontScale: 1.3,

    // Adaptive values
    mobilePadding: 16,
    tabletPadding: 24,
    desktopPadding: 32,
  ),
  child: MaterialApp(...),
)
```

**Zero config works too** — all values have sensible defaults. `AdaptiFlow.of(context)` returns defaults when no wrapper is in the tree.

### 2. Percentage-Based Sizing

```dart
Container(width: context.wp(50))   // 50% of screen width
Container(height: context.hp(20))  // 20% of screen height

// Safe area (excludes notches/status bars)
Container(height: context.shp(50)) // 50% of safe height
Container(width: context.swp(90))  // 90% of safe width
```

### 3. Design-Proportional Scaling

Scale values proportionally to a design reference size — like flutter_screenutil but built-in:

```dart
// If your design mockup is 375px wide and you set a widget to 100px:
context.w(100)  // Scales proportionally to actual screen width

context.h(50)   // Scales proportionally to actual screen height

context.r(24)   // Uniform scaling using min(widthRatio, heightRatio)
                // Great for icons, avatars, border radius

// Font scaling with optional min/max clamp
context.sp(16)                      // Proportional font size
context.sp(16, min: 12, max: 24)    // Clamped between 12-24px
```

### 4. Device Detection

```dart
// Boolean checks
if (context.isMobile) { }     // < 600px (configurable)
if (context.isTablet) { }     // 600px - 1200px
if (context.isDesktop) { }    // >= 1200px
if (context.isWidescreen) { } // >= 1920px

// Enum-based (type-safe)
switch (context.deviceType) {
  case DeviceType.mobile:     // ...
  case DeviceType.tablet:     // ...
  case DeviceType.desktop:    // ...
  case DeviceType.widescreen: // ...
}

// Orientation
if (context.isPortrait) { }
if (context.isLandscape) { }
```

### 5. Responsive Layout

```dart
// Switch entire layouts per device type
ResponsiveLayout(
  mobile: MobileHomePage(),
  tablet: TabletHomePage(),     // Falls back to mobile if null
  desktop: DesktopHomePage(),   // Falls back to tablet if null
  widescreen: WidescreenPage(), // Falls back to desktop if null
)

// Builder with DeviceType + constraints
ResponsiveLayoutBuilder(
  builder: (context, constraints, deviceType) {
    return switch (deviceType) {
      DeviceType.mobile => MobileView(),
      DeviceType.tablet => TabletView(),
      _ => DesktopView(),
    };
  },
)
```

### 6. Adaptive Values

```dart
// Auto-scaling per device type (configurable)
padding: EdgeInsets.all(context.adaptivePadding)
// Mobile: 16px, Tablet: 24px, Desktop: 32px

margin: EdgeInsets.all(context.adaptiveMargin)
// Mobile: 12px, Tablet: 16px, Desktop: 24px

SizedBox(height: context.adaptiveSpacing)
// Mobile: 8px, Tablet: 12px, Desktop: 16px

// Font scaling (breakpoint-based)
TextStyle(fontSize: context.fontSize(18))
// Mobile: 18, Tablet: 20.7, Desktop: 23.4

// General scaling
double size = context.scale(16);
// Mobile: 16, Tablet: 19.2, Desktop: 24
```

### 7. ResponsiveText

Auto-scaling text without manual `context.fontSize()` on every `TextStyle`:

```dart
// Breakpoint-based scaling (default)
ResponsiveText('Hello', baseFontSize: 16)

// Design-proportional scaling
ResponsiveText('Hello', baseFontSize: 16, useDesignScale: true)

// With min/max bounds
ResponsiveText(
  'Hello',
  baseFontSize: 16,
  minFontSize: 12,
  maxFontSize: 24,
  style: TextStyle(fontWeight: FontWeight.bold),
  maxLines: 2,
  overflow: TextOverflow.ellipsis,
)
```

### 8. ResponsiveVisibility

Show or hide widgets based on device type:

```dart
// Only visible on mobile
ResponsiveVisibility.mobileOnly(child: BottomNavBar())

// Only visible on desktop/widescreen
ResponsiveVisibility.desktopOnly(child: SidePanel())

// Hidden on mobile, visible elsewhere
ResponsiveVisibility.hideOnMobile(child: DetailedStats())

// Custom visibility rules
ResponsiveVisibility(
  visibleOn: {DeviceType.tablet, DeviceType.desktop},
  child: TabletDesktopWidget(),
)

// Custom replacement when hidden
ResponsiveVisibility(
  hiddenOn: {DeviceType.mobile},
  replacement: CompactVersion(),
  child: FullVersion(),
)
```

### 9. ResponsiveGrid

Auto-adjusting column count per breakpoint:

```dart
ResponsiveGrid(
  mobileColumns: 2,
  tabletColumns: 3,
  desktopColumns: 4,
  widescreenColumns: 5,
  spacing: 16,
  runSpacing: 16,
  childAspectRatio: 0.75,
  children: products.map((p) => ProductCard(product: p)).toList(),
)
```

### 10. ResponsivePadding

Eliminates repetitive `EdgeInsets.all(context.adaptivePadding)`:

```dart
// Auto-adaptive (uses config values)
ResponsivePadding.adaptive(child: YourContent())

// Custom per-breakpoint
ResponsivePadding(
  mobilePadding: EdgeInsets.all(16),
  tabletPadding: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
  desktopPadding: EdgeInsets.symmetric(horizontal: 64, vertical: 32),
  child: YourContent(),
)
```

### 11. Spacing System

```dart
// Auto-direction spacer (detects Row/Column parent)
Column(children: [
  Text('Item 1'),
  const ResponsiveSpacer(),         // 16px vertical (auto-detected)
  Text('Item 2'),
  const ResponsiveSpacer(size: 24), // 24px vertical
])

Row(children: [
  Icon(Icons.star),
  const ResponsiveSpacer(),         // 16px horizontal (auto-detected)
  Text('Rating'),
])

// Predefined const spacers
Spacers.s4    // 4px
Spacers.s8    // 8px
Spacers.s12   // 12px
Spacers.s16   // 16px
Spacers.s24   // 24px
Spacers.s32   // 32px
Spacers.s48   // 48px

// Custom size
Spacers.of(20)  // 20px
```

### 12. SafeResponsiveLayout

Safe layout wrapper for all devices — handles notches, keyboard, scrolling:

```dart
SafeResponsiveLayout(
  padding: EdgeInsets.all(16),
  child: YourContent(),
)
```

**Handles:** device notches, status bar, bottom navigation, keyboard overlay, content scrolling.

**Advanced options:**

```dart
SafeResponsiveLayout(
  padding: EdgeInsets.symmetric(horizontal: context.wp(5)),
  maintainBottomViewPadding: true,
  enableScroll: true,
  maxWidth: 800,                          // Optional max width constraint
  maxHeight: 600,                         // Optional max height constraint
  physics: const BouncingScrollPhysics(), // Custom scroll physics
  child: YourContent(),
)
```

### 13. Responsive Values

```dart
// Function-based
final columns = responsiveValue(
  context,
  mobile: 1,
  tablet: 2,
  desktop: 3,
  widescreen: 4,
);

// Class-based (reusable)
const gridColumns = ResponsiveValue<int>(
  mobile: 2,
  tablet: 3,
  desktop: 4,
);
GridView.count(crossAxisCount: gridColumns.of(context))

// Orientation-based
final padding = orientationValue(
  context,
  portrait: 16.0,
  landscape: 24.0,
);
```

### 14. Widget Constraints

```dart
// Max width (prevents stretching on large screens)
YourWidget().constrained(maxWidth: 800)

// Max width and height
YourWidget().constrainedBoth(maxWidth: 800, maxHeight: 600)

// Adaptive constraint (uses config values)
YourWidget().adaptiveConstrained(context)
// Mobile: no constraint, Tablet: max 900px, Desktop: max 1200px
```

---

## Real-World Examples

<details>
<summary><b>Login Screen</b></summary>

```dart
class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeResponsiveLayout(
        padding: EdgeInsets.symmetric(horizontal: context.wp(5)),
        maxWidth: 500,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo.png', height: context.hp(15)),
            Spacers.s32,
            TextField(
              style: TextStyle(fontSize: context.fontSize(16)),
              decoration: InputDecoration(
                labelText: 'Email',
                contentPadding: EdgeInsets.symmetric(
                  horizontal: context.scale(16),
                  vertical: context.scale(12),
                ),
              ),
            ),
            Spacers.s16,
            TextField(
              obscureText: true,
              style: TextStyle(fontSize: context.fontSize(16)),
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            Spacers.s32,
            SizedBox(
              width: double.infinity,
              height: context.hp(6),
              child: ElevatedButton(
                onPressed: () {},
                child: const ResponsiveText('Login', baseFontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

</details>

<details>
<summary><b>Product Grid</b></summary>

```dart
class ProductGrid extends StatelessWidget {
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return ResponsiveGrid(
      mobileColumns: 2,
      tabletColumns: 3,
      desktopColumns: 4,
      widescreenColumns: 5,
      spacing: context.adaptiveSpacing,
      runSpacing: context.adaptiveSpacing,
      childAspectRatio: 0.75,
      padding: EdgeInsets.all(context.adaptivePadding),
      children: products.map((p) => ProductCard(product: p)).toList(),
    );
  }
}
```

</details>

<details>
<summary><b>Dashboard with Sidebar</b></summary>

```dart
class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar — only on desktop
          ResponsiveVisibility.desktopOnly(
            child: SizedBox(width: 250, child: SideMenu()),
          ),
          // Main content
          Expanded(
            child: ResponsivePadding.adaptive(
              child: ResponsiveLayout(
                mobile: _MobileDashboard(),
                tablet: _TabletDashboard(),
                desktop: _DesktopDashboard(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
```

</details>

---

## Breakpoint Reference

| Device | Width Range | Check | Enum |
|--------|-------------|-------|------|
| Mobile | < 600px | `context.isMobile` | `DeviceType.mobile` |
| Tablet | 600px - 1200px | `context.isTablet` | `DeviceType.tablet` |
| Desktop | 1200px - 1920px | `context.isDesktop` | `DeviceType.desktop` |
| Widescreen | >= 1920px | `context.isWidescreen` | `DeviceType.widescreen` |

**All breakpoints are customizable** via `AdaptiFlowData`:

```dart
AdaptiFlow(
  data: AdaptiFlowData(
    mobileBreakpoint: 500,
    desktopBreakpoint: 1024,
    widescreenBreakpoint: 1920,
  ),
  child: MaterialApp(...),
)
```

---

## API Reference

<details>
<summary><b>Context Extensions</b></summary>

```dart
// Screen dimensions
context.screenWidth           // Full screen width
context.screenHeight          // Full screen height
context.safeWidth             // Width minus side padding
context.safeHeight            // Height minus top/bottom padding

// Percentage sizing
context.wp(percent)           // Width percentage
context.hp(percent)           // Height percentage
context.shp(percent)          // Safe height percentage
context.swp(percent)          // Safe width percentage

// Design-proportional scaling
context.w(value)              // Scale by width ratio to designSize
context.h(value)              // Scale by height ratio to designSize
context.r(value)              // Scale by min(width, height) ratio
context.sp(size, {min, max})  // Proportional font with clamp

// Device detection
context.deviceType            // DeviceType enum
context.isMobile              // < mobileBreakpoint
context.isTablet              // >= mobileBreakpoint && < desktopBreakpoint
context.isDesktop             // >= desktopBreakpoint
context.isWidescreen          // >= widescreenBreakpoint
context.isPortrait            // Portrait orientation
context.isLandscape           // Landscape orientation

// Responsive scaling
context.scale(value)          // Mobile: 1x, Tablet: 1.2x, Desktop: 1.5x
context.fontSize(size)        // Mobile: 1x, Tablet: 1.15x, Desktop: 1.3x

// Adaptive values
context.adaptivePadding       // Mobile: 16, Tablet: 24, Desktop: 32
context.adaptiveMargin        // Mobile: 12, Tablet: 16, Desktop: 24
context.adaptiveSpacing       // Mobile: 8, Tablet: 12, Desktop: 16

// Safe area info
context.topPadding            // Status bar / notch height
context.bottomPadding         // Bottom navigation height
context.keyboardHeight        // Keyboard height (0 on desktop)
context.isKeyboardVisible     // true when soft keyboard is open

// Text scale
context.textScaleFactor       // System text scale factor
context.textSize(size)        // size * textScaleFactor
```

</details>

<details>
<summary><b>Widgets</b></summary>

```dart
// Layout switching
ResponsiveLayout(mobile: Widget, tablet: Widget?, desktop: Widget?, widescreen: Widget?)

// Layout builder with DeviceType
ResponsiveLayoutBuilder(builder: (context, constraints, deviceType) => Widget)

// Auto-scaling text
ResponsiveText(text, baseFontSize: double, {minFontSize, maxFontSize, useDesignScale, style, maxLines, overflow})

// Auto-column grid
ResponsiveGrid(children: [], mobileColumns: int, {tabletColumns, desktopColumns, widescreenColumns, spacing, childAspectRatio})

// Responsive padding
ResponsivePadding(child: Widget, {mobilePadding, tabletPadding, desktopPadding})
ResponsivePadding.adaptive(child: Widget)

// Conditional visibility
ResponsiveVisibility(child: Widget, {visibleOn, hiddenOn, replacement})
ResponsiveVisibility.mobileOnly(child: Widget)
ResponsiveVisibility.desktopOnly(child: Widget)
ResponsiveVisibility.hideOnMobile(child: Widget)
ResponsiveVisibility.hideOnDesktop(child: Widget)

// Safe layout wrapper
SafeResponsiveLayout(child: Widget, {padding, enableScroll, maxWidth, maxHeight, physics})

// Auto-direction spacer
const ResponsiveSpacer({size: 16})
Spacers.s4 / s8 / s12 / s16 / s24 / s32 / s48
Spacers.of(size)

// Widget constraints
widget.constrained(maxWidth: 800)
widget.constrainedBoth(maxWidth: 800, maxHeight: 600)
widget.adaptiveConstrained(context)
```

</details>

<details>
<summary><b>Configuration</b></summary>

```dart
// InheritedWidget wrapper (optional)
AdaptiFlow(data: AdaptiFlowData(...), child: MaterialApp(...))

// Configuration class (all fields have defaults)
AdaptiFlowData(
  mobileBreakpoint: 600,        desktopBreakpoint: 1200,
  widescreenBreakpoint: 1920,   designSize: Size(375, 812),
  mobileScaleFactor: 1.0,      tabletScaleFactor: 1.2,      desktopScaleFactor: 1.5,
  mobileFontScale: 1.0,        tabletFontScale: 1.15,       desktopFontScale: 1.3,
  mobilePadding: 16,            tabletPadding: 24,            desktopPadding: 32,
  mobileMargin: 12,             tabletMargin: 16,             desktopMargin: 24,
  mobileSpacing: 8,             tabletSpacing: 12,            desktopSpacing: 16,
  tabletMaxWidth: 900,          desktopMaxWidth: 1200,
)

// Access config
AdaptiFlow.of(context)        // With dependency (rebuilds on change)
AdaptiFlow.maybeOf(context)   // Without dependency (one-time read)

// Functions
T responsiveValue<T>(context, {required T mobile, T? tablet, T? desktop, T? widescreen})
T orientationValue<T>(context, {required T portrait, required T landscape})

// Class-based
ResponsiveValue<T>(mobile: T, {tablet, desktop, widescreen}).of(context)

// Device type
DeviceType resolveDeviceType(width, {mobileBreakpoint, desktopBreakpoint, widescreenBreakpoint})
```

</details>

---

## Best Practices

```dart
// DO
Container(width: context.wp(80))                // Percentage sizing
EdgeInsets.all(context.adaptivePadding)          // Adaptive values
SafeResponsiveLayout(child: content)             // Safe wrapper
const ResponsiveText('Title', baseFontSize: 20)  // Auto-scaling text
ResponsiveVisibility.hideOnMobile(child: panel)  // Conditional display
Spacers.s16                                      // Const spacers

// DON'T
Container(width: 200)                            // Fixed pixels
MediaQuery.of(context).size.width                // Direct MediaQuery
Column(children: [...])                          // No SafeArea
```

---

## Performance

AdaptiFlow uses `MediaQuery.sizeOf`, `paddingOf`, `orientationOf`, and `viewInsetsOf` instead of `MediaQuery.of` — this means your widgets only rebuild when the specific property they depend on changes, not when any MediaQuery property changes.

```dart
const ResponsiveSpacer()  // const constructors where possible
Spacers.s16               // Predefined const spacers
```

---

## Contributing

Contributions are welcome! Please:

1. Fork the repository
2. Create your feature branch: `git checkout -b feature/amazing-feature`
3. Commit your changes: `git commit -m 'Add amazing feature'`
4. Push to the branch: `git push origin feature/amazing-feature`
5. Open a Pull Request

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

<div align="center">

**Made with Flutter & Dart**

[Back to Top](#adaptiflow)

</div>
