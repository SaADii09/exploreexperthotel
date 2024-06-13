import 'package:exploreexperthotel/features/user_auth/presentation/widgets/essentials.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MessageWidget extends StatelessWidget {
  final String text;
  final bool isFromUser;

  const MessageWidget({
    super.key,
    required this.text,
    required this.isFromUser,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isFromUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 20,
            ),
            margin: const EdgeInsets.only(bottom: 8),
            constraints: const BoxConstraints(maxWidth: 520),
            decoration: BoxDecoration(
              color:
                  isFromUser ? EXColors.primaryDark : EXColors.secondaryMedium,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              children: [MarkdownBody(data: text)],
            ),
          ),
        )
      ],
    );
  }
}
