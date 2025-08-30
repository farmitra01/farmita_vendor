import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/home/controllers/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatView extends GetView {
  ChatView({super.key});
  final ChatController controller = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.lightGrey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          backgroundColor: AppColors.appBarColor,
          elevation: 0,
          flexibleSpace: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 12,
                top: 12,
                bottom: 8,
              ),
              child: Row(
                children: [
                  Text(
                    "FARMITR",
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      "Ai Q",
                      style: TextStyle(
                        color: AppColors.primaryGradinatMixColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 75),
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  controller: controller.scrollController,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    // vertical: 5,
                  ),
                  itemCount: controller.messages.length,
                  itemBuilder: (context, index) {
                    final msg = controller.messages[index];
                    if (msg.isUser) {
                      return _userBubble(msg.text);
                    } else {
                      return _aiBubble(
                        msg.title ?? "Farmitra IQ",
                        msg.text,
                        AppColors.appBarColor,
                      );
                    }
                  },
                );
              }),
            ),
          ],
        ),
      ),

      bottomSheet: BottomSheet(
        onClosing: () {},
        builder: (context) {
          return Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 12.0,
            ),
            color: AppColors.lightGrey,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: controller.textController,
                            textInputAction: TextInputAction.send,
                            onSubmitted: (_) => controller.sendMessage(),
                            style: const TextStyle(fontSize: 15),
                            decoration: const InputDecoration(
                              hintText: "कृपया समस्या लिखें...",
                              border: InputBorder.none,
                              isDense: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: controller.sendMessage,
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.primaryGradinatMixColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryGradinatMixColor.withOpacity(
                            0.3,
                          ),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.send,
                      color: AppColors.white,
                      size: 22,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _aiBubble(String title, String text, Color color) {
    // Convert Markdown **text** to HTML <b>text</b>, handle paragraphs, and numbered lists
    String htmlText = text;

    // Convert **text** to <b>text</b> for bold
    htmlText = htmlText.replaceAllMapped(
      RegExp(r'\*\*(.*?)\*\*'),
      (match) => '<b>${match.group(1)}</b>',
    );

    // Convert numbered points (e.g., "1. Item") to ordered list
    final lines = htmlText.split('\n');
    bool inList = false;
    StringBuffer convertedText = StringBuffer();
    int listStartIndex = -1;

    for (int i = 0; i < lines.length; i++) {
      final line = lines[i].trim();
      final listMatch = RegExp(r'^(\d+)\.\s*(.*)$').firstMatch(line);

      if (listMatch != null) {
        if (!inList) {
          inList = true;
          listStartIndex = i;
          convertedText.write('<ol>');
        }
        convertedText.write('<li>${listMatch.group(2)}</li>');
      } else {
        if (inList) {
          inList = false;
          convertedText.write('</ol>');
          if (i > listStartIndex && line.isNotEmpty) {
            convertedText.write('<p>$line</p>');
          }
        } else if (line.isNotEmpty) {
          convertedText.write('<p>$line</p>');
        }
      }
    }

    if (inList) {
      convertedText.write('</ol>');
    }

    htmlText = convertedText.toString();

    return Padding(
      padding: const EdgeInsets.only(right: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title row
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(
                      Icons.android,
                      color: AppColors.primaryGradinatMixColor,
                      size: 26,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      title,
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Icon(
                      Icons.verified,
                      size: 14,
                      color: AppColors.primaryGradinatMixColor,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Html(
                  data: htmlText,
                  style: {
                    'p': Style(
                      fontSize: FontSize(15.0),
                      fontFamily: GoogleFonts.montserrat().fontFamily,
                      color: AppColors.textPrimary,
                      lineHeight: LineHeight(1.6),
                      margin: Margins.symmetric(vertical: 8.0),
                      textAlign: TextAlign.left,
                    ),
                    'b': Style(
                      fontWeight: FontWeight.bold,
                      fontSize: FontSize(15.0),
                      fontFamily: GoogleFonts.montserrat().fontFamily,
                      textAlign: TextAlign.left,
                    ),
                    'ol': Style(
                      fontSize: FontSize(15.0),
                      fontFamily: GoogleFonts.montserrat().fontFamily,
                      color: AppColors.textPrimary,
                      margin: Margins.only(left: 0.0, top: 0, bottom: 0),
                      textAlign: TextAlign.left,
                    ),
                    'li': Style(
                      fontSize: FontSize(15.0),
                      fontFamily: GoogleFonts.montserrat().fontFamily,
                      color: AppColors.textPrimary,
                      lineHeight: LineHeight(1.6),
                      margin: Margins.symmetric(vertical: 4.0),
                      textAlign: TextAlign.left,
                    ),
                  },
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  heightFactor: 0.5,
                  child: IconButton(
                    icon: const Icon(Icons.copy, size: 20, color: Colors.grey),

                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: text));
                      Get.snackbar(
                        "Copied",
                        "Message copied to clipboard",
                        backgroundColor: AppColors.primaryGradinatMixColor,
                        colorText: AppColors.white,
                        snackPosition: SnackPosition.BOTTOM,
                        margin: const EdgeInsets.all(12),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _userBubble(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              margin: const EdgeInsets.only(left: 60),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Text(text, style: const TextStyle(fontSize: 15)),
            ),
          ),
        ],
      ),
    );
  }
}
