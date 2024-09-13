extension IntExt on int {
  String get estimate {
    if (this < 10) {
      return '$this';
    }

    var data = this - (this % 10);
    if (data == this) {
      data = this - 5;
    }
    return 'over $data';
  }

  String get pluralize {
    return (this > 1 || this == 0) ? 's' : '';
  }

  String get displayDuration {
    if (this <= 60) {
      return '$this seconds';
    }
    if (this <= 3600) {
      return '${(this / 60).round()} minutes';
    }
    if (this <= 86400) {
      return '${(this / 3600).round()} hours';
    }

    return '${(this / 86400).round()} days';
  }
}
