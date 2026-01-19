class EmailJsConfig {
  const EmailJsConfig({
    required this.serviceId,
    required this.templateId,
    required this.publicKey,
    this.enabled = false,
  });

  /// Set this true after you fill all IDs.
  final bool enabled;

  final String serviceId;
  final String templateId;
  final String publicKey;
}

/// EmailJS configuration.
///
/// If not enabled, the app will just show a success dialog and log the message.
const emailJsConfig = EmailJsConfig(
  enabled: false,
  serviceId: 'YOUR_SERVICE_ID',
  templateId: 'YOUR_TEMPLATE_ID',
  publicKey: 'YOUR_PUBLIC_KEY',
);
