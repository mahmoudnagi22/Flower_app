import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flower_app/core/l10n/app_localizations.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  Future<List<dynamic>> loadTermsData() async {
    final jsonString = await rootBundle.loadString('assets/data/terms_conditions.json');
    final jsonMap = json.decode(jsonString);
    return jsonMap['terms_and_conditions'];
  }

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;
    final isArabic = lang.localeName == 'ar';

    return Scaffold(
      appBar: AppBar(title: Text(lang.titleTermsAndConditions)),
      body: FutureBuilder<List<dynamic>>(
        future: loadTermsData(),
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

    final style = section['style'];
    final contentStyle = section['style']?['content'] ?? style;
    final titleStyle = section['style']?['title'] ?? style;

    // Title
    if (section.containsKey('title')) {
      final titleText = section['title'][localeKey];
      titleWidget = _buildStyledText(titleText, titleStyle, localeKey);
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
              child: _buildStyledText(e, contentStyle, localeKey),
            );
          }).toList(),
        );
      } else if (content is String) {
        contentWidget = _buildStyledText(content, contentStyle, localeKey);
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
      hexColor = 'FF$hexColor';
    }
    return Color(int.parse(hexColor, radix: 16));
  }
}
