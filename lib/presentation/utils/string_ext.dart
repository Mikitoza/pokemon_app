extension StringExtensionPresentataion on String {
  String fromBigChar() {
    return replaceRange(0, 1, this[0].toUpperCase());
  }
}
