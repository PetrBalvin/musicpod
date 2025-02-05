// Mocks generated by Mockito 5.4.4 from annotations
// in musicpod/test/local_audio_service_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:musicpod/settings/settings_service.dart' as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [SettingsService].
///
/// See the documentation for Mockito's code generation for more information.
class MockSettingsService extends _i1.Mock implements _i2.SettingsService {
  MockSettingsService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  bool get allowManualUpdates => (super.noSuchMethod(
        Invocation.getter(#allowManualUpdates),
        returnValue: false,
      ) as bool);

  @override
  _i3.Stream<bool> get themeIndexChanged => (super.noSuchMethod(
        Invocation.getter(#themeIndexChanged),
        returnValue: _i3.Stream<bool>.empty(),
      ) as _i3.Stream<bool>);

  @override
  int get themeIndex => (super.noSuchMethod(
        Invocation.getter(#themeIndex),
        returnValue: 0,
      ) as int);

  @override
  bool get neverShowFailedImports => (super.noSuchMethod(
        Invocation.getter(#neverShowFailedImports),
        returnValue: false,
      ) as bool);

  @override
  _i3.Stream<bool> get neverShowFailedImportsChanged => (super.noSuchMethod(
        Invocation.getter(#neverShowFailedImportsChanged),
        returnValue: _i3.Stream<bool>.empty(),
      ) as _i3.Stream<bool>);

  @override
  _i3.Stream<bool> get recentPatchNotesDisposedChanged => (super.noSuchMethod(
        Invocation.getter(#recentPatchNotesDisposedChanged),
        returnValue: _i3.Stream<bool>.empty(),
      ) as _i3.Stream<bool>);

  @override
  bool get recentPatchNotesDisposed => (super.noSuchMethod(
        Invocation.getter(#recentPatchNotesDisposed),
        returnValue: false,
      ) as bool);

  @override
  _i3.Stream<bool> get usePodcastIndexChanged => (super.noSuchMethod(
        Invocation.getter(#usePodcastIndexChanged),
        returnValue: _i3.Stream<bool>.empty(),
      ) as _i3.Stream<bool>);

  @override
  bool get usePodcastIndex => (super.noSuchMethod(
        Invocation.getter(#usePodcastIndex),
        returnValue: false,
      ) as bool);

  @override
  _i3.Stream<bool> get podcastIndexApiKeyChanged => (super.noSuchMethod(
        Invocation.getter(#podcastIndexApiKeyChanged),
        returnValue: _i3.Stream<bool>.empty(),
      ) as _i3.Stream<bool>);

  @override
  _i3.Stream<bool> get podcastIndexApiSecretChanged => (super.noSuchMethod(
        Invocation.getter(#podcastIndexApiSecretChanged),
        returnValue: _i3.Stream<bool>.empty(),
      ) as _i3.Stream<bool>);

  @override
  _i3.Stream<bool> get directoryChanged => (super.noSuchMethod(
        Invocation.getter(#directoryChanged),
        returnValue: _i3.Stream<bool>.empty(),
      ) as _i3.Stream<bool>);

  @override
  _i3.Stream<bool> get useArtistGridViewChanged => (super.noSuchMethod(
        Invocation.getter(#useArtistGridViewChanged),
        returnValue: _i3.Stream<bool>.empty(),
      ) as _i3.Stream<bool>);

  @override
  bool get useArtistGridView => (super.noSuchMethod(
        Invocation.getter(#useArtistGridView),
        returnValue: false,
      ) as bool);

  @override
  void setThemeIndex(int? value) => super.noSuchMethod(
        Invocation.method(
          #setThemeIndex,
          [value],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void setNeverShowFailedImports(bool? value) => super.noSuchMethod(
        Invocation.method(
          #setNeverShowFailedImports,
          [value],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i3.Future<void> disposePatchNotes() => (super.noSuchMethod(
        Invocation.method(
          #disposePatchNotes,
          [],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<void> setUsePodcastIndex(bool? value) => (super.noSuchMethod(
        Invocation.method(
          #setUsePodcastIndex,
          [value],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  void setPodcastIndexApiKey(String? value) => super.noSuchMethod(
        Invocation.method(
          #setPodcastIndexApiKey,
          [value],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void setPodcastIndexApiSecret(String? value) => super.noSuchMethod(
        Invocation.method(
          #setPodcastIndexApiSecret,
          [value],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i3.Future<void> setDirectory(String? directory) => (super.noSuchMethod(
        Invocation.method(
          #setDirectory,
          [directory],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  void setUseArtistGridView(bool? value) => super.noSuchMethod(
        Invocation.method(
          #setUseArtistGridView,
          [value],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i3.Future<void> init({String? testDir}) => (super.noSuchMethod(
        Invocation.method(
          #init,
          [],
          {#testDir: testDir},
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<void> dispose() => (super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
}
