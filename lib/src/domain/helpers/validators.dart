class Validators {
  static bool networkImage(String? url) {
    if (url != null && url.isNotEmpty && url.contains('https')) {
      return true;
    }
    return false;
  }
}
