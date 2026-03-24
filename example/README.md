# AdaptiFlow Example

A complete demo app showcasing the [adapti_flow](https://pub.dev/packages/adapti_flow) responsive design system.

## Getting Started

```bash
cd example
flutter pub get
flutter run
```

## What This Example Demonstrates

### App Setup (`lib/app.dart`)

Wrapping `MaterialApp` with the `AdaptiFlow` configuration widget:

```dart
AdaptiFlow(
  data: const AdaptiFlowData(),  // zero-config defaults (fully customizable)
  child: MaterialApp(
    home: const MyCustomPage(),
  ),
)
```

### Responsive Layout Switching (`lib/pages/my_custom_page.dart`)

Using `ResponsiveLayout` to automatically switch between mobile, tablet, and desktop views based on screen width:

```dart
Scaffold(
  appBar: AppBar(
    title: const ResponsiveText('AdaptiFlow Demo', baseFontSize: 20),
  ),
  body: const ResponsiveLayout(
    mobile: MobileView(),
    tablet: TabletView(),
    desktop: DesktopView(),
  ),
)
```

### Mobile View (`lib/pages/mobile_view.dart`)

Demonstrates key mobile features:

- `SafeResponsiveLayout` — handles notches, status bar, keyboard overlay, and scrolling
- `context.wp(5)` — percentage-based horizontal padding (5% of screen width)
- `context.hp(25)` — percentage-based container height (25% of screen height)
- `context.fontSize(16)` — responsive font scaling
- `context.isMobile` / `context.isPortrait` — device and orientation detection
- `Spacers.s16` — auto-direction spacers (vertical in Column, horizontal in Row)
- Keyboard guard testing with `TextField`

### Tablet View (`lib/pages/tablet_view.dart`)

Demonstrates tablet-specific features:

- `context.adaptivePadding` — adaptive padding (24px on tablet)
- `context.wp(90)` — 90% width container
- `.adaptiveConstrained(context)` — config-driven max width constraint
- Two-column `Row` layout with auto-direction spacers

### Desktop View (`lib/pages/desk_top_view.dart`)

Demonstrates desktop-specific features:

- `context.hp(50)` — panels at 50% screen height
- `context.adaptivePadding` — adaptive padding (32px on desktop)
- `context.fontSize(24)` — scaled font sizes for desktop
- `.constrained(maxWidth: 1400)` — max width to prevent stretching on ultrawide monitors
- Side-by-side panel layout with `Spacers.s24`

## Features Used in This Example

| Feature | Where |
|---------|-------|
| `AdaptiFlow` config wrapper | `app.dart` |
| `ResponsiveLayout` | `my_custom_page.dart` |
| `ResponsiveText` | `my_custom_page.dart` |
| `SafeResponsiveLayout` | `mobile_view.dart` |
| `context.wp()` / `context.hp()` | All views |
| `context.fontSize()` | All views |
| `context.adaptivePadding` | `tablet_view.dart`, `desk_top_view.dart` |
| `context.isMobile` / `context.isPortrait` | `mobile_view.dart` |
| `Spacers.s*` | All views |
| `.constrained()` | `desk_top_view.dart` |
| `.adaptiveConstrained()` | `tablet_view.dart` |

## Try It

Resize the window (desktop/web) or rotate the device (mobile) to see layouts adapt in real-time.
