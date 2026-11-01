// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: document_ignores, lines_longer_than_80_chars, unnecessary_null_checks, specify_nonobvious_property_types

part of 'report_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(weeklyReport)
final weeklyReportProvider = WeeklyReportProvider._();

final class WeeklyReportProvider
    extends
        $FunctionalProvider<
          AsyncValue<WeeklyReport>,
          WeeklyReport,
          FutureOr<WeeklyReport>
        >
    with $FutureModifier<WeeklyReport>, $FutureProvider<WeeklyReport> {
  WeeklyReportProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'weeklyReportProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$weeklyReportHash();

  @$internal
  @override
  $FutureProviderElement<WeeklyReport> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<WeeklyReport> create(Ref ref) {
    return weeklyReport(ref);
  }
}

String _$weeklyReportHash() => r'1df3ca96fe55da08b6749b6f247a253ac36e32ed';
