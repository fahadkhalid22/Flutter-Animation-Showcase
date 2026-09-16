/// Central registry of Hero tags used by the shared-element demo.
///
/// Tags are matched by [Hero] on both the source and the destination route,
/// so they live in one place to avoid typos and accidental duplicates.
abstract final class HeroTags {
  /// Tag shared by the source orb and its destination counterpart.
  ///
  /// Must be unique within the active route subtree — exactly one Hero with
  /// this tag exists on each route.
  static const String motionObject = 'hero-motion-object';
}
