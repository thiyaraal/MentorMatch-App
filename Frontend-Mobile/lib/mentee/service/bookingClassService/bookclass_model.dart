class BookingResultClass {
  final bool isSuccess;
  final int? uniqueCode;
  final String message;

  BookingResultClass(
      {required this.isSuccess, this.uniqueCode, this.message = ''});
}
