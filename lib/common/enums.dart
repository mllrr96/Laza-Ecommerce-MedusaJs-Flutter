enum DateFormatOptions {
  first,
  second,
  third,
  fourth,
  fifth,
  sixth,
  seventh,
  eighth;

  String toPattern() {
    switch (index) {
      case 0:
        return 'EEEE, MMM d, yyyy';
      case 1:
        return 'MM/dd/yyyy';
      case 2:
        return 'MM-dd-yyyy';
      case 3:
        return 'MMM d';
      case 4:
        return 'MMM d, yyyy';
      case 5:
        return 'E, d MMM yyyy';
      case 6:
        return 'yyyy-MM-dd';
      case 7:
        return 'dd.MM.yy';
      default:
        return 'MMM d, yyyy';
    }
  }

  static DateFormatOptions fromInt(int? val) {
    switch (val) {
      case null:
        return DateFormatOptions.fifth;
      case 0:
        return DateFormatOptions.first;
      case 1:
        return DateFormatOptions.second;
      case 2:
        return DateFormatOptions.third;

      case 3:
        return DateFormatOptions.fourth;
      case 4:
        return DateFormatOptions.fifth;
      case 5:
        return DateFormatOptions.sixth;
      case 6:
        return DateFormatOptions.seventh;
      case 7:
        return DateFormatOptions.eighth;
      default:
        return DateFormatOptions.fifth;
    }
  }
}

enum AuthenticationType {
  cookie,
  jwt;

  @override
  String toString() {
    switch (this) {
      case AuthenticationType.cookie:
        return 'Cookie';
      case AuthenticationType.jwt:
        return 'JWT';
    }
  }
}
