class EmailRequest {
  final String toEmail;
  final String subject;
  final String body;
  final String? path;
  final List<String>? cc;

  EmailRequest(
      {required this.toEmail, required this.subject, required this.body, this.path, this.cc});

  Map<String, dynamic> toJson() {
    return {
      'toEmail': toEmail,
      'subject': subject,
      'body': body,
      'path': path,
      'cc': cc,
    };
  }
}
