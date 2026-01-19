import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ordervia/config/emailjs.dart';
import 'package:ordervia/config/social.dart';
import 'package:ordervia/shared/utils/launch_url.dart';
import 'package:ordervia/shared/utils/tawk_chat.dart';
import 'package:ordervia/widgets/contact_action_card.dart';

class ContactPanel extends StatefulWidget {
  const ContactPanel({super.key, required this.onClose});

  final VoidCallback onClose;

  @override
  State<ContactPanel> createState() => _ContactPanelState();
}

class _ContactPanelState extends State<ContactPanel> {
  final _name = TextEditingController();
  final _contact = TextEditingController();
  final _message = TextEditingController();

  bool _showForm = false;
  bool _submitting = false;

  static const _adminEmail = 'sabtainiii@gmail.com';

  @override
  void dispose() {
    _name.dispose();
    _contact.dispose();
    _message.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = width >= 900;

    return Align(
      alignment: Alignment.bottomRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: isDesktop ? 420 : width,
        ),
        child: Material(
          elevation: 18,
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(22),
            topRight: isDesktop ? const Radius.circular(22) : Radius.zero,
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'How can we help you?',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.w800),
                        ),
                      ),
                      IconButton(
                        onPressed: widget.onClose,
                        icon: const Icon(Icons.close),
                      )
                    ],
                  ),
                  Text(
                    'Choose your preferred way to contact us',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFF6B7280),
                        ),
                  ),
                  const SizedBox(height: 14),
                  if (!_showForm) ...[
                    ContactActionCard(
                      title: 'Chat with Admin',
                      subtitle: 'Fastest response (web chat)',
                      icon: Icons.chat_bubble_outline,
                      background: const Color(0xFF0EA5A4),
                      onTap: () async {
                        // Close the panel immediately so it never stays open behind Tawk.
                        widget.onClose();

                        // Attempt to open chat (web only). Do not show any warning if not ready.
                        await openTawkChat();
                      },
                    ),
                    const SizedBox(height: 10),
                    ContactActionCard(
                      title: 'Facebook DM',
                      subtitle: 'Message us on Facebook',
                      icon: Icons.facebook,
                      background: const Color(0xFF1877F2),
                      onTap: () => launchExternalUrl(socialConfig.facebookDmUrl),
                    ),
                    const SizedBox(height: 10),
                    _InstagramCard(
                      onTap: () =>
                          launchExternalUrl(socialConfig.instagramProfileUrl),
                    ),
                    const SizedBox(height: 10),
                    ContactActionCard(
                      title: 'Leave a Message',
                      subtitle: 'Send a short request',
                      icon: Icons.mail_outline,
                      background: Colors.white,
                      foreground: const Color(0xFF111827),
                      border: const BorderSide(color: Color(0xFFE5E7EB)),
                      onTap: () => setState(() => _showForm = true),
                    ),
                  ] else ...[
                    _MessageForm(
                      name: _name,
                      contact: _contact,
                      message: _message,
                      submitting: _submitting,
                      onBack: () => setState(() => _showForm = false),
                      onSubmit: _submitting ? null : _submit,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    setState(() => _submitting = true);

    final payload = {
      'name': _name.text.trim(),
      'contact': _contact.text.trim(),
      'message': _message.text.trim(),
    };

    try {
      if (emailJsConfig.enabled) {
        await _sendEmailJs(payload);

        if (!mounted) return;
        await showDialog<void>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Message sent'),
              content: const Text(
                'Thanks! We received your message and will get back to you soon.',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        // Fallback: open user's email client addressed to admin email.
        final subjectText =
            'OrderVia: New message from ${payload['name'] ?? ''}'.trim();

        final bodyText =
            'Name: ${payload['name'] ?? ''}\n'
            'Contact: ${payload['contact'] ?? ''}\n\n'
            '${payload['message'] ?? ''}';

        final subject = Uri.encodeComponent(subjectText);
        final body = Uri.encodeComponent(bodyText);

        await launchExternalUrl(
          'mailto:$_adminEmail?subject=$subject&body=$body',
        );

        if (!mounted) return;
        await showDialog<void>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Email opened'),
              content: Text(
                'Your email app is opened to send this message to $_adminEmail.',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }

      _name.clear();
      _contact.clear();
      _message.clear();

      setState(() => _showForm = false);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not send message: $e')),
      );
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  Future<void> _sendEmailJs(Map<String, String> payload) async {
    final uri = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');

    final body = {
      'service_id': emailJsConfig.serviceId,
      'template_id': emailJsConfig.templateId,
      'user_id': emailJsConfig.publicKey,
      'template_params': {
        'from_name': payload['name'] ?? '',
        'from_contact': payload['contact'] ?? '',
        'message': payload['message'] ?? '',
      },
    };

    final res = await http.post(
      uri,
      headers: const {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw StateError('EmailJS failed: ${res.statusCode} ${res.body}');
    }
  }
}

class _InstagramCard extends StatelessWidget {
  const _InstagramCard({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: const LinearGradient(
            colors: [Color(0xFF7C3AED), Color(0xFFF97316)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.10),
              blurRadius: 18,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(Icons.camera_alt_outlined, color: Colors.white),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Instagram DM',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'Message us on Instagram',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withValues(alpha: 0.92),
                        ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right,
                color: Colors.white.withValues(alpha: 0.95)),
          ],
        ),
      ),
    );
  }
}

class _MessageForm extends StatelessWidget {
  const _MessageForm({
    required this.name,
    required this.contact,
    required this.message,
    required this.submitting,
    required this.onBack,
    required this.onSubmit,
  });

  final TextEditingController name;
  final TextEditingController contact;
  final TextEditingController message;
  final bool submitting;
  final VoidCallback onBack;
  final VoidCallback? onSubmit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: onBack,
              icon: const Icon(Icons.arrow_back),
            ),
            const SizedBox(width: 6),
            Text(
              'Leave a Message',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.w800),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextField(
          controller: name,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
            labelText: 'Name',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: contact,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
            labelText: 'Email / Phone',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: message,
          maxLines: 4,
          decoration: const InputDecoration(
            labelText: 'Message',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: onSubmit,
            child: submitting
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Submit'),
          ),
        ),
      ],
    );
  }
}
