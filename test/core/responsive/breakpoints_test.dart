import 'package:flutter_test/flutter_test.dart';
import 'package:adapti_flow/core/responsive/responsive.dart';

void main() {
  group('Breakpoints', () {
    test('static constants have correct default values', () {
      expect(Breakpoints.mobile, 600);
      expect(Breakpoints.tablet, 900);
      expect(Breakpoints.desktop, 1200);
      expect(Breakpoints.widescreen, 1920);
    });

    test('constants are ordered correctly', () {
      expect(Breakpoints.mobile, lessThan(Breakpoints.tablet));
      expect(Breakpoints.tablet, lessThan(Breakpoints.desktop));
      expect(Breakpoints.desktop, lessThan(Breakpoints.widescreen));
    });
  });

  group('DeviceType', () {
    test('resolveDeviceType returns mobile for widths < 600', () {
      expect(resolveDeviceType(0), DeviceType.mobile);
      expect(resolveDeviceType(320), DeviceType.mobile);
      expect(resolveDeviceType(599), DeviceType.mobile);
    });

    test('resolveDeviceType returns tablet for widths 600-1199', () {
      expect(resolveDeviceType(600), DeviceType.tablet);
      expect(resolveDeviceType(900), DeviceType.tablet);
      expect(resolveDeviceType(1199), DeviceType.tablet);
    });

    test('resolveDeviceType returns desktop for widths 1200-1919', () {
      expect(resolveDeviceType(1200), DeviceType.desktop);
      expect(resolveDeviceType(1440), DeviceType.desktop);
      expect(resolveDeviceType(1919), DeviceType.desktop);
    });

    test('resolveDeviceType returns widescreen for widths >= 1920', () {
      expect(resolveDeviceType(1920), DeviceType.widescreen);
      expect(resolveDeviceType(2560), DeviceType.widescreen);
      expect(resolveDeviceType(3840), DeviceType.widescreen);
    });

    test('resolveDeviceType respects custom breakpoints', () {
      expect(
        resolveDeviceType(499, mobileBreakpoint: 500),
        DeviceType.mobile,
      );
      expect(
        resolveDeviceType(500, mobileBreakpoint: 500),
        DeviceType.tablet,
      );
      expect(
        resolveDeviceType(1023, desktopBreakpoint: 1024),
        DeviceType.tablet,
      );
      expect(
        resolveDeviceType(1024, desktopBreakpoint: 1024),
        DeviceType.desktop,
      );
    });

    test('resolveDeviceType handles exact boundary values', () {
      // Exact mobile breakpoint → tablet
      expect(resolveDeviceType(600), DeviceType.tablet);
      // Just below → mobile
      expect(resolveDeviceType(599.9), DeviceType.mobile);
      // Exact desktop breakpoint → desktop
      expect(resolveDeviceType(1200), DeviceType.desktop);
      // Just below → tablet
      expect(resolveDeviceType(1199.9), DeviceType.tablet);
      // Exact widescreen breakpoint → widescreen
      expect(resolveDeviceType(1920), DeviceType.widescreen);
      // Just below → desktop
      expect(resolveDeviceType(1919.9), DeviceType.desktop);
    });
  });
}
