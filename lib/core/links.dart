/// Orbitly's website. One place for the domain: invite links, legal pages
/// and the account deletion page all live there. (The Android invite link
/// filter in AndroidManifest.xml repeats it; change both together.)
abstract final class AppLinks {
  static const host = 'orbitily.app';

  static Uri page(String path) => Uri.https(host, path);

  static final Uri communityRules = page('/rules');
  static final Uri privacyPolicy = page('/privacy');
  static final Uri terms = page('/terms');
  static final Uri deleteAccount = page('/delete-account');

  /// The link in someone's QR code or invite message.
  static String invite(String code) => page('/invite/$code').toString();
}
