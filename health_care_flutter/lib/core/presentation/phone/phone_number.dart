class MyphoneNumber {
  MyphoneNumber({
    required this.countryISOCode,
    required this.countryCode,
    required this.number,
  });
  String countryISOCode;
  String countryCode;
  String number;

  String get completeNumber {
    return countryCode + number;
  }

  @override
  String toString() =>
      'PhoneNumber(countryISOCode: $countryISOCode, countryCode: $countryCode, number: $number)';
}
