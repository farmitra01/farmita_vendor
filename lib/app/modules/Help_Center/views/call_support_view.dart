import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/utils/global_widgets/vendor_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For clipboard functionality
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class CallEmailSupportView extends StatelessWidget {
  const CallEmailSupportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const VendorAppBar(title: 'Call & Email Support'),
      body: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.background,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Mail Support'),
            _buildEmailCard(
              context: context,
              name: 'Business Mail',
              email: 'business@farmitra.com',
            ),
            const SizedBox(height: 5),
            _buildEmailCard(
              context: context,
              name: 'Support Mail',
              email: 'support@farmitra.com',
            ),
            const SizedBox(height: 10),
            _buildSectionTitle('Call Support'),
            _buildPhoneCard(
              context: context,
              name: 'Technical Support',
              phone: '9277103055',
            ),
            const SizedBox(height: 5),
            _buildPhoneCard(
              context: context,
              name: 'Business Support',
              phone: '9277103057',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: GoogleFonts.montserrat(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  Widget _buildEmailCard({
    required BuildContext context,
    required String name,
    required String email,
  }) {
    return GestureDetector(
      onTap: () async {
        final Uri emailUri = Uri(
          scheme: 'mailto',
          path: email,
          query: _encodeQueryParameters({
            'subject': 'Hello',
            'body': 'Hi there!',
          }),
        );
        // Log the URI for debugging
        debugPrint('Email URI: $emailUri');

        try {
          if (await canLaunchUrl(emailUri)) {
            await launchUrl(emailUri, mode: LaunchMode.externalApplication);
          } else {
            // Copy email to clipboard as a fallback
            await Clipboard.setData(ClipboardData(text: email));
            // Show feedback to the user
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text(
                  'No email app found. Email address copied to clipboard.',
                ),
                action: SnackBarAction(
                  label: 'Open Gmail',
                  onPressed: () async {
                    // Try opening Gmail in browser as an alternative
                    final gmailUri = Uri.parse('https://mail.google.com');
                    if (await canLaunchUrl(gmailUri)) {
                      await launchUrl(
                        gmailUri,
                        mode: LaunchMode.externalApplication,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Could not open Gmail.')),
                      );
                    }
                  },
                ),
              ),
            );
            debugPrint('No email app found to handle this request.');
          }
        } catch (e) {
          // Show error feedback to the user
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error launching email: $e')));
          debugPrint('Error launching email: $e');
        }
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 2.5),
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.primaryGradinatMixColor,
                  child: const Icon(
                    Icons.support_agent,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2.5),
                      Text(
                        email,
                        style: GoogleFonts.montserrat(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.mail, color: AppColors.primaryGradinatMixColor),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Helper method to encode query parameters
String _encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map(
        (e) =>
            '${Uri.encodeQueryComponent(e.key)}=${Uri.encodeQueryComponent(e.value)}',
      )
      .join('&');
}

Widget _buildPhoneCard({
  required BuildContext context,
  required String name,
  required String phone,
}) {
  return GestureDetector(
    onTap: () async {
      final Uri phoneUri = Uri(scheme: 'tel', path: phone);
      try {
        if (await canLaunchUrl(phoneUri)) {
          await launchUrl(phoneUri);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'No dialer app found. Please install a dialer app.',
              ),
            ),
          );
          debugPrint('Could not launch dialer');
        }
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error launching dialer: $e')));
        debugPrint('Error launching dialer: $e');
      }
    },
    child: Card(
      margin: const EdgeInsets.symmetric(vertical: 2.5),
      child: ListTile(
        title: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: AppColors.primaryGradinatMixColor,
                child: const Icon(Icons.support_agent, color: AppColors.white),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2.5),
                    // Text(
                    //   " ", // 👈 instead of showing phone number
                    //   style: GoogleFonts.montserrat(
                    //     fontSize: 10,
                    //     fontWeight: FontWeight.w500,
                    //     color: AppColors.textPrimary,
                    //   ),
                    // ),
                  ],
                ),
              ),
              Icon(Icons.call, color: AppColors.primaryGradinatMixColor),
            ],
          ),
        ),
      ),
    ),
  );
}
