import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flower_app/core/l10n/app_localizations.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  Future<List<dynamic>> loadAboutData() async {
    final jsonString = await rootBundle.loadString('assets/data/about_us.json');
    final jsonMap = json.decode(jsonString);
    return jsonMap['about_app'];
  }

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;
    final isArabic = lang.localeName == 'ar';

    return Scaffold(
      appBar: AppBar(title: Text(lang.titleAboutUs)),
      body: FutureBuilder<List<dynamic>>(
        future: loadAboutData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final sections = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: sections.length,
            itemBuilder: (context, index) {
              final section = sections[index];
              return _buildSection(context, section, isArabic);
            },
          );
        },
      ),
    );
  }

  Widget _buildSection(BuildContext context, Map<String, dynamic> section, bool isArabic) {
    final localeKey = isArabic ? 'ar' : 'en';

    Widget? titleWidget;
    Widget? contentWidget;

    // Title
    if (section.containsKey('title')) {
      final titleText = section['title'][localeKey];
      final style = section['style']?['title'];
      titleWidget = _buildStyledText(titleText, style, localeKey);
    }

    // Content
    if (section.containsKey('content')) {
      final content = section['content'][localeKey];

      if (content is List) {
        contentWidget = Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: content.map<Widget>((e) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildStyledText(e, section['style']?['content'] ?? section['style'], localeKey),
            );
          }).toList(),
        );
      } else if (content is String) {
        contentWidget = _buildStyledText(content, section['style'], localeKey);
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (titleWidget != null) ...[
          titleWidget,
          const SizedBox(height: 8),
        ],
        if (contentWidget != null) ...[
          contentWidget,
          const SizedBox(height: 24),
        ],
      ],
    );
  }

  Widget _buildStyledText(String text, Map<String, dynamic>? style, String localeKey) {
    final fontSize = (style?['fontSize'] ?? 16).toDouble();
    final fontWeight = _getFontWeight(style?['fontWeight'] ?? 'normal');
    final color = _parseColor(style?['color'] ?? '#000000');
    final textAlignStr = style?['textAlign']?[localeKey] ?? 'left';
    final textAlign = _getTextAlign(textAlignStr);

    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }

  FontWeight _getFontWeight(String weight) {
    switch (weight) {
      case 'bold':
        return FontWeight.bold;
      case 'normal':
      default:
        return FontWeight.normal;
    }
  }

  TextAlign _getTextAlign(String align) {
    switch (align) {
      case 'right':
        return TextAlign.right;
      case 'center':
        return TextAlign.center;
      case 'left':
      default:
        return TextAlign.left;
    }
  }

  Color _parseColor(String hexColor) {
    hexColor = hexColor.replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor'; // add alpha if missing
    }
    return Color(int.parse(hexColor, radix: 16));
  }
}
