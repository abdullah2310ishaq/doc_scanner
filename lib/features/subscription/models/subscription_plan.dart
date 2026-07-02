enum SubscriptionPlan {
  none,
  weekly,
  yearly;

  static SubscriptionPlan fromStorage(String? value) {
    return switch (value) {
      'weekly' => SubscriptionPlan.weekly,
      'yearly' => SubscriptionPlan.yearly,
      _ => SubscriptionPlan.none,
    };
  }

  String toStorage() {
    return switch (this) {
      SubscriptionPlan.none => 'none',
      SubscriptionPlan.weekly => 'weekly',
      SubscriptionPlan.yearly => 'yearly',
    };
  }
}
