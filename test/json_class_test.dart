import 'package:json_class/json_class.dart';
import 'package:test/test.dart';

void main() {
  test('JsonClass.parseBool', () {
    expect(JsonClass.parseBool('false'), false);
    expect(JsonClass.parseBool('FALSE'), false);
    expect(JsonClass.parseBool('NO'), false);
    expect(JsonClass.parseBool('no'), false);
    expect(JsonClass.parseBool(0), false);
    expect(JsonClass.parseBool(false), false);
    expect(JsonClass.parseBool(null), false);

    expect(JsonClass.parseBool('true'), true);
    expect(JsonClass.parseBool('TRUE'), true);
    expect(JsonClass.parseBool('YES'), true);
    expect(JsonClass.parseBool('yes'), true);
    expect(JsonClass.parseBool(1), true);
    expect(JsonClass.parseBool(true), true);

    expect(JsonClass.parseBool(null, whenNull: false), false);
    expect(JsonClass.parseBool(null, whenNull: true), true);
  });

  test('JsonClass.parseDateTime', () {
    expect(
      JsonClass.parseDateTime(null),
      null,
    );

    expect(
      JsonClass.parseDateTime(DateTime(2019, 01, 01)),
      DateTime(2019, 01, 01),
    );

    expect(
      JsonClass.parseDateTime('01/02/2020'),
      DateTime(2020, 01, 02),
    );
    expect(
      JsonClass.parseDateTime('01/02/2020')!.isUtc,
      false,
    );

    expect(
      JsonClass.parseDateTime('2020-02-01'),
      DateTime(2020, 02, 01),
    );
    expect(
      JsonClass.parseDateTime('2020-02-01')!.isUtc,
      false,
    );

    expect(
      JsonClass.parseDateTime('2020-02-01T12:30'),
      DateTime(2020, 02, 01, 12, 30),
    );
    expect(
      JsonClass.parseDateTime('2020-02-01T12:30')!.isUtc,
      false,
    );

    expect(
      JsonClass.parseDateTime('2020-02-01T12:30:45'),
      DateTime(2020, 02, 01, 12, 30, 45),
    );
    expect(
      JsonClass.parseDateTime('2020-02-01T12:30:45')!.isUtc,
      false,
    );

    expect(
      JsonClass.parseDateTime('2020-02-01T12:30:45.123'),
      DateTime(2020, 02, 01, 12, 30, 45, 123),
    );
    expect(
      JsonClass.parseDateTime('2020-02-01T12:30:45.123')!.isUtc,
      false,
    );

    expect(
      JsonClass.parseDateTime('2020-02-01T12:30Z')!.isUtc,
      true,
    );
    expect(
      JsonClass.parseDateTime('2020-02-01T12:30:45Z')!.isUtc,
      true,
    );
    expect(
      JsonClass.parseDateTime('2020-02-01T12:30:45.123Z')!.isUtc,
      true,
    );
  });

  test('JsonClass.parseDouble', () {
    expect(JsonClass.parseDouble(null), null);
    expect(
      JsonClass.parseDouble('infinity'),
      double.infinity,
    );
    expect(
      JsonClass.parseDouble('INFINITY'),
      double.infinity,
    );
    expect(JsonClass.parseDouble(1.23), 1.23);
    expect(JsonClass.parseDouble('1.23'), 1.23);
    expect(JsonClass.parseDouble('1.0'), 1.0);
    expect(JsonClass.parseDouble(1.0), 1.0);
    expect(JsonClass.parseDouble(1), 1.0);

    expect(JsonClass.parseDouble('0xff'), 0xff);
  });

  test('JsonClass.parseDurationFromMillis', () {
    expect(JsonClass.parseDurationFromMillis(null), null);
    expect(JsonClass.parseDurationFromMillis(123), Duration(milliseconds: 123));
    expect(
      JsonClass.parseDurationFromMillis(123.5),
      Duration(milliseconds: 123),
    );
    expect(
      JsonClass.parseDurationFromMillis('123'),
      Duration(milliseconds: 123),
    );
    expect(
      JsonClass.parseDurationFromMillis('123.5'),
      Duration(milliseconds: 123),
    );
  });

  test('JsonClass.parseDurationFromSeconds', () {
    expect(JsonClass.parseDurationFromSeconds(null), null);
    expect(JsonClass.parseDurationFromSeconds(123), Duration(seconds: 123));
    expect(JsonClass.parseDurationFromSeconds(123.5), Duration(seconds: 123));
    expect(JsonClass.parseDurationFromSeconds('123'), Duration(seconds: 123));
    expect(JsonClass.parseDurationFromSeconds('123.5'), Duration(seconds: 123));
  });

  test('JsonClass.parseInt', () {
    expect(JsonClass.parseInt(null), null);
    expect(JsonClass.parseInt(1.23), 1);
    expect(JsonClass.parseInt('1.23'), 1);
    expect(JsonClass.parseInt('1.0'), 1);
    expect(JsonClass.parseInt(1.0), 1);
    expect(JsonClass.parseInt(1), 1);
    expect(JsonClass.parseInt('0xff'), 0xff);
  });

  test('JsonClass.parseUtcMillis', () {
    const millis = 1586717564014;

    expect(JsonClass.parseUtcMillis(null), null);
    expect(
        JsonClass.parseUtcMillis(null, millis)?.millisecondsSinceEpoch, millis);
    expect(JsonClass.parseUtcMillis(millis)?.millisecondsSinceEpoch, millis);
    expect(JsonClass.parseUtcMillis('$millis')?.millisecondsSinceEpoch, millis);
    expect(JsonClass.parseUtcMillis(millis)?.isUtc, true);
  });

  test('JsonClass.removeNull', () {
    var data = {
      'foo': 'bar',
      'other': null,
      'list': [],
      'map': {'value': null},
    };

    expect(
      JsonClass.removeNull(data),
      {'foo': 'bar'},
    );
    expect(
      JsonClass.removeNull(data, false),
      {'foo': 'bar', 'list': [], 'map': {}},
    );
  });
}
