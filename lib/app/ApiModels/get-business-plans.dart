class PlanResponse {
  final int id;
  final String planName;
  final String subscriptionType;
  final int durationDays;
  final String amount;
  final List<String> features;
  final String discount;
  final bool isActive;
  final String createdAt;
  final String updatedAt;

  PlanResponse({
    required this.id,
    required this.planName,
    required this.subscriptionType,
    required this.durationDays,
    required this.amount,
    required this.features,
    required this.discount,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  static List<PlanResponse> listFromJson(List<dynamic> json) {
    return json.map((e) => PlanResponse(
          id: e['id'] ?? 0,
          planName: e['plan_name']?.toString() ?? 'Unknown Plan',
          subscriptionType: e['subscription_type']?.toString() ?? 'Unknown',
          durationDays: e['duration_days'] ?? 0,
          amount: e['amount']?.toString() ?? '0.00',
          features: List<String>.from(e['features'] ?? []),
          discount: e['discount']?.toString() ?? '0.00',
          isActive: e['is_active'] ?? false,
          createdAt: e['created_at']?.toString() ?? '',
          updatedAt: e['updated_at']?.toString() ?? '',
        )).toList();
  }
}