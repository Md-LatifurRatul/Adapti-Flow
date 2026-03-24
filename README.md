<div align="center">

# 📱 AdaptiFlow

**A comprehensive zero-dependency Flutter responsive design system with adaptive layouts, design-proportional scaling, and fully customizable breakpoints**

[![pub package](https://img.shields.io/pub/v/adapti_flow.svg)](https://pub.dev/packages/adapti_flow)
![Flutter](https://img.shields.io/badge/Flutter-02569B?style=flat-square&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=flat-square&logo=dart&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green.svg?style=flat-square)
![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web%20%7C%20macOS%20%7C%20Windows%20%7C%20Linux-blue?style=flat-square)

[Features](#-features) • [Installation](#-installation) • [Quick Start](#-quick-start) • [Examples](#-real-world-examples) • [Documentation](#-api-reference)

</div>

---

## 📋 Table of Contents

- [Why I Built This](#-why-i-built-this)
- [Features](#-features)
- [Installation](#-installation)
- [Quick Start](#-quick-start)
- [Usage Guide](#-complete-usage-guide)
  - [Percentage Sizing](#1-percentage-based-sizing)
  - [Device Detection](#3-device-detection)
  - [Adaptive Layouts](#4-adaptive-layouts)
  - [Spacing System](#6-responsive-spacing)
- [Real-World Examples](#-real-world-examples)
- [Best Practices](#-best-practices)
- [API Reference](#-api-reference)
- [Contributing](#-contributing)

---

## 🎯 Why I Built This

> After building multiple Flutter apps, I faced the same frustrating problems repeatedly...

| ❌ Problems | ✅ Solutions |
|------------|-------------|
| Overflow errors on different screens | Zero overflow with percentage sizing |
| MediaQuery code everywhere | Clean context extensions |
| Hardcoded pixels breaking layouts | Adaptive responsive values |
| Different layouts for each device | Single codebase, auto-adapts |
| Inconsistent UI across platforms | Perfect on all platforms |

**So I built this system, and now I'm sharing it with you.**

---

## ✨ Features

### 🎨 Percentage-Based Sizing

```dart
Container(
  width: context.wp(80),   // 80% of screen width
  height: context.hp(30),  // 30% of screen height
)
```

### 📱 Automatic Device Detection

```dart
if (context.isMobile) {
  // Phone layout
} else if (context.isTablet) {
  // Tablet layout  
} else {
  // Desktop layout
}
```

### 🎯 Smart Adaptive Values

```dart
padding: EdgeInsets.all(context.adaptivePadding)
// Mobile: 16px | Tablet: 24px | Desktop: 32px
```

### 🚀 Zero Overflow Errors

```dart
SafeMobileLayout(
  child: YourContent(), // Handles everything!
)
```

### 🧠 Intelligent Spacing

```dart
Column(children: [
  Widget1(),
  const ResponsiveSpacer(), // Auto vertical
  Widget2(),
])
```

---

## 📦 Installation

### Step 1: Add to pubspec.yaml

```yaml
dependencies:
  adapti_flow: ^1.0.0
```

### Step 2: Install

```bash
flutter pub get
```

### Step 3: Import

```dart
import 'package:adapti_flow/adapti_flow.dart';
```

**Zero external dependencies!** Pure Flutter.

---

## 🚀 Quick Start

```dart
import 'package:flutter/material.dart';
import 'package:adapti_flow/adapti_flow.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeMobileLayout(
        padding: EdgeInsets.all(context.adaptivePadding),
        child: Column(
          children: [
            Container(
              width: context.wp(90),
              height: context.hp(25),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  'Perfect on All Devices!',
                  style: TextStyle(
                    fontSize: context.fontSize(18),
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            
            const ResponsiveSpacer(),
            
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

## 📖 Complete Usage Guide

### 1. Percentage-Based Sizing

```dart
// Width percentage
Container(width: context.wp(50))  // 50% width
Container(width: context.wp(80))  // 80% width
Container(width: context.wp(100)) // Full width

// Height percentage
Container(height: context.hp(20)) // 20% height
Container(height: context.hp(50)) // 50% height

// Safe area (excludes notches/bars)
Container(height: context.shp(50)) // 50% of safe height
Container(width: context.swp(90))  // 90% of safe width
```

**Why it works:**
- 400px screen: `wp(50)` = 200px
- 800px screen: `wp(50)` = 400px
- 1920px screen: `wp(50)` = 960px

### 2. Screen Dimensions

```dart
// Full dimensions
final width = context.screenWidth;
final height = context.screenHeight;

// Safe area
final safeHeight = context.safeHeight;
final safeWidth = context.safeWidth;

// Safe area padding
final topPadding = context.topPadding;
final bottomPadding = context.bottomPadding;

// Keyboard
final keyboardHeight = context.keyboardHeight;
bool isKeyboardOpen = context.isKeyboardVisible;
```

### 3. Device Detection

```dart
// Device type
if (context.isMobile) {     // < 600px
  // Mobile layout
}

if (context.isTablet) {     // 600px - 1200px
  // Tablet layout
}

if (context.isDesktop) {    // >= 1200px
  // Desktop layout
}

if (context.isWidescreen) { // >= 1920px
  // Widescreen layout
}

// Orientation
if (context.isPortrait) {
  // Portrait layout
}

if (context.isLandscape) {
  // Landscape layout
}
```

### 4. Adaptive Layouts

```dart
ResponsiveLayout(
  mobile: MobileHomePage(),
  tablet: TabletHomePage(),
  desktop: DesktopHomePage(),
  widescreen: WidescreenHomePage(), // Optional
)
```

### 5. Adaptive Values

```dart
// Auto-scaling constants
padding: EdgeInsets.all(context.adaptivePadding)
// Mobile: 16px, Tablet: 24px, Desktop: 32px

margin: EdgeInsets.all(context.adaptiveMargin)
// Mobile: 12px, Tablet: 16px, Desktop: 24px

SizedBox(height: context.adaptiveSpacing)
// Mobile: 8px, Tablet: 12px, Desktop: 16px

// Font scaling
Text(
  'Title',
  style: TextStyle(fontSize: context.fontSize(18)),
)
// Mobile: 18, Tablet: 20.7, Desktop: 23.4

// Custom scaling
double size = context.scale(16);
// Mobile: 16, Tablet: 19.2, Desktop: 24
```

### 6. Responsive Spacing

```dart
// Auto-direction spacing
Column(
  children: [
    Text('Item 1'),
    const ResponsiveSpacer(),        // 16px vertical
    Text('Item 2'),
    const ResponsiveSpacer(size: 24), // 24px vertical
  ],
)

Row(
  children: [
    Icon(Icons.star),
    const ResponsiveSpacer(),        // 16px horizontal
    Text('Rating'),
  ],
)

// Predefined spacers
Spacers.vertical8    // 8px
Spacers.vertical16   // 16px
Spacers.vertical24   // 24px
Spacers.horizontal8  // 8px
Spacers.horizontal16 // 16px

// Quick methods
Spacers.v(12)  // 12px vertical
Spacers.h(20)  // 20px horizontal
```

### 7. Safe Mobile Layout

```dart
SafeMobileLayout(
  padding: EdgeInsets.all(16),
  child: YourContent(),
)
```

**Handles:**
- ✅ Device notches
- ✅ Status bar
- ✅ Bottom navigation
- ✅ Keyboard overlay
- ✅ Content scrolling

**Advanced:**

```dart
SafeMobileLayout(
  padding: EdgeInsets.symmetric(
    horizontal: context.wp(5),
    vertical: 16,
  ),
  maintainBottomViewPadding: true,
  enableScroll: true,
  child: YourContent(),
)
```

### 8. Responsive Values

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
final gridColumns = ResponsiveValue<int>(
  mobile: 2,
  tablet: 3,
  desktop: 4,
);

GridView.count(
  crossAxisCount: gridColumns.getValue(context),
  children: [...],
)

// Orientation-based
final padding = orientationValue(
  context,
  portrait: 16.0,
  landscape: 24.0,
);
```

### 9. Constraint Widgets

```dart
// Max width
YourWidget().constrained(maxWidth: 800)

// Max width and height
YourWidget().constrainedBoth(
  maxWidth: 800,
  maxHeight: 600,
)

// Adaptive constraint
YourWidget().adaptiveConstrained(context)
// Mobile: no constraint
// Tablet: max 900px
// Desktop: max 1200px
```

---

## 🎯 Real-World Examples

<details>
<summary><b>📱 Login Screen</b></summary>

```dart
class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeMobileLayout(
        padding: EdgeInsets.symmetric(horizontal: context.wp(5)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Image.asset(
              'assets/logo.png',
              height: context.hp(15),
            ),
            
            Spacers.vertical32,
            
            // Email field
            TextField(
              style: TextStyle(fontSize: context.fontSize(16)),
              decoration: InputDecoration(
                labelText: 'Email',
                contentPadding: EdgeInsets.symmetric(
                  horizontal: context.scale(16),
                  vertical: context.scale(12),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            
            Spacers.vertical16,
            
            // Password field
            TextField(
              obscureText: true,
              style: TextStyle(fontSize: context.fontSize(16)),
              decoration: InputDecoration(
                labelText: 'Password',
                contentPadding: EdgeInsets.symmetric(
                  horizontal: context.scale(16),
                  vertical: context.scale(12),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            
            Spacers.vertical32,
            
            // Login button
            SizedBox(
              width: double.infinity,
              height: context.hp(6),
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: context.fontSize(16)),
                ),
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
<summary><b>🛍️ Product Grid</b></summary>

```dart
class ProductGrid extends StatelessWidget {
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(context.adaptivePadding),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: responsiveValue(
          context,
          mobile: 2,
          tablet: 3,
          desktop: 4,
          widescreen: 5,
        ),
        crossAxisSpacing: context.adaptiveSpacing,
        mainAxisSpacing: context.adaptiveSpacing,
        childAspectRatio: 0.75,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductCard(product: products[index]);
      },
    );
  }
}
```

</details>

<details>
<summary><b>📊 Dashboard</b></summary>

```dart
class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard')),
      body: ResponsiveLayout(
        // Mobile: Vertical list
        mobile: SingleChildScrollView(
          padding: EdgeInsets.all(context.adaptivePadding),
          child: Column(
            children: [
              _StatCard(title: 'Users', value: '1,234'),
              Spacers.vertical16,
              _StatCard(title: 'Revenue', value: '\$45K'),
              Spacers.vertical16,
              _StatCard(title: 'Orders', value: '567'),
            ],
          ),
        ),
        
        // Tablet: 2-column grid
        tablet: GridView.count(
          crossAxisCount: 2,
          padding: EdgeInsets.all(context.adaptivePadding),
          mainAxisSpacing: context.adaptiveSpacing,
          crossAxisSpacing: context.adaptiveSpacing,
          children: [
            _StatCard(title: 'Users', value: '1,234'),
            _StatCard(title: 'Revenue', value: '\$45K'),
            _StatCard(title: 'Orders', value: '567'),
            _StatCard(title: 'Products', value: '89'),
          ],
        ),
        
        // Desktop: Horizontal cards
        desktop: Padding(
          padding: EdgeInsets.all(context.adaptivePadding),
          child: Row(
            children: [
              Expanded(child: _StatCard(title: 'Users', value: '1,234')),
              Spacers.horizontal16,
              Expanded(child: _StatCard(title: 'Revenue', value: '\$45K')),
              Spacers.horizontal16,
              Expanded(child: _StatCard(title: 'Orders', value: '567')),
              Spacers.horizontal16,
              Expanded(child: _StatCard(title: 'Products', value: '89')),
            ],
          ),
        ).constrained(maxWidth: 1400),
      ),
    );
  }
}
```

</details>

<details>
<summary><b>👤 Profile Page</b></summary>

```dart
class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeMobileLayout(
        child: Column(
          children: [
            // Header with gradient
            Container(
              height: context.hp(30),
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.purple],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: context.scale(50),
                    backgroundImage: NetworkImage('avatar_url'),
                  ),
                  Spacers.vertical12,
                  Text(
                    'John Doe',
                    style: TextStyle(
                      fontSize: context.fontSize(24),
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            
            // Content section
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(context.adaptivePadding),
                children: [
                  _buildInfoCard(
                    context,
                    icon: Icons.email,
                    title: 'Email',
                    value: 'john@example.com',
                  ),
                  Spacers.vertical12,
                  _buildInfoCard(
                    context,
                    icon: Icons.phone,
                    title: 'Phone',
                    value: '+1 234 567 890',
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
```

</details>

---

## ✅ Best Practices

### DO's ✅

```dart
// ✅ Use percentage sizing
Container(width: context.wp(80), height: context.hp(30))

// ✅ Use adaptive constants
padding: EdgeInsets.all(context.adaptivePadding)

// ✅ Wrap in SafeMobileLayout
SafeMobileLayout(child: YourContent())

// ✅ Use ResponsiveSpacer
const ResponsiveSpacer()

// ✅ Constrain wide content
Content().constrained(maxWidth: 1200)

// ✅ Use fontSize() for text
TextStyle(fontSize: context.fontSize(16))
```

### DON'Ts ❌

```dart
// ❌ Don't use fixed pixels
Container(width: 200)

// ❌ Don't use MediaQuery directly
MediaQuery.of(context).size.width

// ❌ Don't forget SafeArea
Column(children: [...])

// ❌ Don't ignore keyboard
TextField() // May be covered by keyboard
```

---

## 🎯 Common Use Cases

### E-commerce App

```dart
GridView(
  crossAxisCount: responsiveValue(
    context,
    mobile: 2,
    tablet: 3,
    desktop: 4,
  ),
)
```

### Social Media Feed

```dart
SafeMobileLayout(
  child: ListView.builder(
    itemBuilder: (context, index) {
      return Post().constrained(maxWidth: 600);
    },
  ),
)
```

### Form Input

```dart
SafeMobileLayout(
  padding: EdgeInsets.symmetric(horizontal: context.wp(5)),
  child: Column(
    children: [
      TextField(
        style: TextStyle(fontSize: context.fontSize(16)),
      ),
      Spacers.vertical16,
      // More fields...
    ],
  ),
)
```

---

## 📊 Breakpoint Reference

| Device | Width Range | Variable |
|--------|-------------|----------|
| Mobile | < 600px | `context.isMobile` |
| Tablet | 600px - 1200px | `context.isTablet` |
| Desktop | 1200px - 1920px | `context.isDesktop` |
| Widescreen | >= 1920px | `context.isWidescreen` |

**Customize in `breakpoints.dart`:**

```dart
class Breakpoints {
  static const double mobile = 600;
  static const double tablet = 900;
  static const double desktop = 1200;
  static const double widescreen = 1920;
}
```

---

## 📚 API Reference

<details>
<summary><b>Context Extensions</b></summary>

```dart
// Screen dimensions
context.screenWidth
context.screenHeight
context.safeWidth
context.safeHeight

// Percentage sizing
context.wp(percent)   // Width percentage
context.hp(percent)   // Height percentage
context.shp(percent)  // Safe height percentage
context.swp(percent)  // Safe width percentage

// Device detection
context.isMobile
context.isTablet
context.isDesktop
context.isWidescreen
context.isPortrait
context.isLandscape

// Scaling
context.scale(value)
context.fontSize(size)

// Adaptive values
context.adaptivePadding
context.adaptiveMargin
context.adaptiveSpacing

// Safe area
context.topPadding
context.bottomPadding
context.keyboardHeight
context.isKeyboardVisible
```

</details>

<details>
<summary><b>Widgets</b></summary>

```dart
// Layouts
ResponsiveLayout(
  mobile: Widget,
  tablet: Widget?,
  desktop: Widget?,
  widescreen: Widget?,
)

ResponsiveBuilder(
  builder: (context, constraints) => Widget,
)

// Spacing
const ResponsiveSpacer(size: double)
Spacers.vertical8 / vertical16 / vertical24
Spacers.horizontal8 / horizontal16 / horizontal24
Spacers.v(size) / Spacers.h(size)

// Safety
SafeMobileLayout(
  padding: EdgeInsets?,
  maintainBottomViewPadding: bool,
  enableScroll: bool,
  child: Widget,
)
```

</details>

<details>
<summary><b>Functions</b></summary>

```dart
// Responsive values
T responsiveValue<T>(
  BuildContext context,
  {required T mobile, T? tablet, T? desktop, T? widescreen}
)

// Orientation values
T orientationValue<T>(
  BuildContext context,
  {required T portrait, required T landscape}
)

// Class-based
ResponsiveValue<T>(
  {required T mobile, T? tablet, T? desktop, T? widescreen}
).getValue(context)
```

</details>

<details>
<summary><b>Extensions</b></summary>

```dart
// Widget constraints
widget.constrained(maxWidth: double)
widget.constrainedBoth(maxWidth: double, maxHeight: double)
widget.adaptiveConstrained(BuildContext)
```

</details>

---

## 🚀 Performance Tips

1. **Use const constructors:**
   ```dart
   const ResponsiveSpacer()  // ✅
   ```

2. **Cache responsive values:**
   ```dart
   final width = context.screenWidth;  // Cache it
   ```

3. **Use predefined spacers:**
   ```dart
   Spacers.vertical16  // ✅ Const
   ```

4. **Minimize ResponsiveLayout nesting:**
   ```dart
   // ✅ One at top level
   ResponsiveLayout(mobile: Page())
   ```

---

## 🤝 Contributing

Contributions are welcome! Here's how:

1. **Fork the repository**
2. **Create your feature branch:** `git checkout -b feature/AmazingFeature`
3. **Commit your changes:** `git commit -m 'Add AmazingFeature'`
4. **Push to the branch:** `git push origin feature/AmazingFeature`
5. **Open a Pull Request**

---

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

Built with ❤️ using Flutter & Dart

Special thanks to the Flutter community for inspiration and feedback.

---


---

## 🌟 Show Your Support

If this helped you, please:
- ⭐ Star this repository
- 📝 Write a blog post

---

<div align="center">

**Made with ❤️ for the Flutter Community**

[⬆️ Back to Top](#-flutter-responsive-system)

</div>