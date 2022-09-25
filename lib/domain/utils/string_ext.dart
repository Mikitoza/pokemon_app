extension StringExtensionDomain on String {
  int getIdFromUrl() {
    final str = split('/');
    return int.parse(str[str.length - 2]);
  }
}
