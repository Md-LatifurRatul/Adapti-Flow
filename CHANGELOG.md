## 1.0.0

- Initial release
- **Configuration system**: `AdaptiFlow` InheritedWidget with `AdaptiFlowData` for fully customizable breakpoints, scale factors, and adaptive values
- **Device detection**: `DeviceType` enum with `context.deviceType`, `context.isMobile`, `context.isTablet`, `context.isDesktop`, `context.isWidescreen`
- **Percentage-based sizing**: `context.wp()`, `context.hp()`, `context.swp()`, `context.shp()`
- **Design-proportional scaling**: `context.w()`, `context.h()`, `context.r()`, `context.sp()` — similar to flutter_screenutil
- **Responsive scaling**: `context.scale()`, `context.fontSize()` with configurable multipliers
- **Adaptive values**: `context.adaptivePadding`, `context.adaptiveMargin`, `context.adaptiveSpacing`
- **Layout widgets**: `ResponsiveLayout`, `ResponsiveLayoutBuilder`, `SafeResponsiveLayout`
- **Utility widgets**: `ResponsiveText`, `ResponsiveGrid`, `ResponsivePadding`, `ResponsiveVisibility`
- **Spacer system**: `ResponsiveSpacer` with auto-direction detection, `Spacers.s4` through `Spacers.s48`
- **Widget constraints**: `.constrained()`, `.constrainedBoth()`, `.adaptiveConstrained()` extensions
- **Responsive values**: `responsiveValue()`, `ResponsiveValue<T>`, `orientationValue()`
- **Safe area handling**: Keyboard-aware, notch-safe, scrollable layout wrapper
- **Performance**: Uses `MediaQuery.sizeOf/paddingOf/orientationOf/viewInsetsOf` for minimal rebuilds
- **Zero dependencies**: Pure Flutter, no external packages
- **Cross-platform**: Works on iOS, Android, macOS, Windows, Linux, and Web
