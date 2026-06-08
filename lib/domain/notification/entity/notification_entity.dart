class NotificationEntity {
  final String id;
  final String? userId;
  final String title;
  final String body;
  final String type; // 'order' | 'promo' | 'system'
  final bool isRead;
  final DateTime createdAt;

  NotificationEntity({
    required this.id,
    this.userId,
    required this.title,
    required this.body,
    required this.type,
    required this.isRead,
    required this.createdAt,
  });
}
