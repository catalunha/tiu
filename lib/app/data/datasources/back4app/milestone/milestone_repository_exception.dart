class MilestoneRepositoryException implements Exception {
  final int code;
  final String message;
  MilestoneRepositoryException({
    required this.code,
    required this.message,
  });
}
