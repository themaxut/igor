class ChatMessage {
  final String text;
  final bool isFromUser;
  final bool isLoading;

  ChatMessage({
    required this.text,
    required this.isFromUser,
    this.isLoading = false,
  });
}
