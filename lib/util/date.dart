class Date implements Comparable<Date> {
  final DateTime _dateTime;

  Date._internal(this._dateTime);

  Date(int year, [int month = 1, int day = 1]) : this._internal(DateTime(year, month, day));

  Date.fromDateTime(DateTime dateTime) : this._internal(_atStartOfDay(dateTime));

  Date.now() : this.fromDateTime(DateTime.now());

  static DateTime _atStartOfDay(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day);
  }

  int get year => _dateTime.year;

  int get month => _dateTime.month;

  int get day => _dateTime.day;

  int get weekday => _dateTime.weekday;

  DateTime toDateTime() => _dateTime;

  bool isBefore(Date other) => _dateTime.isBefore(other.toDateTime());

  bool isAfter(Date other) => _dateTime.isAfter(other.toDateTime());

  DateTime addDays(int amount) => _dateTime.add(Duration(days: amount));

  DateTime subtractDays(int amount) => _dateTime.subtract(Duration(days: amount));

  Duration difference(Date other) => _dateTime.difference(other.toDateTime());

  int compareTo(Date other) => _dateTime.compareTo(other.toDateTime());

  bool operator ==(Object other) => other is Date && _dateTime == other.toDateTime();

  int get hashCode => _dateTime.hashCode;

  String toString() {
    String y = _fourDigits(year);
    String m = _twoDigits(month);
    String d = _twoDigits(day);
    return "$y-$m-$d";
  }

  String toIso8601String() {
    String y = (year >= -9999 && year <= 9999) ? _fourDigits(year) : _sixDigits(year);
    String m = _twoDigits(month);
    String d = _twoDigits(day);
    return "$y-$m-${d}";
  }

  static String _twoDigits(int n) {
    if (n >= 10) return "${n}";
    return "0${n}";
  }

  static String _fourDigits(int n) {
    int absN = n.abs();
    String sign = n < 0 ? "-" : "";
    if (absN >= 1000) return "$n";
    if (absN >= 100) return "${sign}0$absN";
    if (absN >= 10) return "${sign}00$absN";
    return "${sign}000$absN";
  }

  static String _sixDigits(int n) {
    assert(n < -9999 || n > 9999);
    int absN = n.abs();
    String sign = n < 0 ? "-" : "+";
    if (absN >= 100000) return "$sign$absN";
    return "${sign}0$absN";
  }

  static Date parse(String formattedString) {
    var re = _parseFormat;
    Match? match = re.firstMatch(formattedString);
    if (match != null) {
      int years = int.parse(match[1]!);
      int month = int.parse(match[2]!);
      int day = int.parse(match[3]!);
      return Date(years, month, day);
    } else {
      throw FormatException("Invalid date format", formattedString);
    }
  }

  /// Constructs a new [Date] instance based on [formattedString].
  ///
  /// Works like [parse] except that this function returns `null`
  /// where [parse] would throw a [FormatException].
  static Date? tryParse(String formattedString) {
    try {
      return parse(formattedString);
    } on FormatException {
      return null;
    }
  }

  /*
   * date ::= yeardate time_opt timezone_opt
   * yeardate ::= year colon_opt month colon_opt day
   * year ::= sign_opt digit{4,6}
   * colon_opt :: <empty> | ':'
   * sign ::= '+' | '-'
   * sign_opt ::=  <empty> | sign
   * month ::= digit{2}
   * day ::= digit{2}
   */
  static final RegExp _parseFormat = RegExp(r'^([+-]?\d{4,6})-?(\d\d)-?(\d\d)'); // Day part.
}
