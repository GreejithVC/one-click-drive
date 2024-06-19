import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MessageWidget extends StatelessWidget {
   MessageWidget({super.key, required this.text, required this.isFromUser});
  final String text;
  final bool isFromUser;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: isFromUser? MainAxisAlignment.end:MainAxisAlignment.start,
        children: [
          Flexible(child: DecoratedBox(decoration: BoxDecoration(
            color: isFromUser? Theme.of(context).colorScheme.primary :  Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                MarkdownBody(data: text,shrinkWrap: true,styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context))
                    .copyWith(
                    p: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 14.0,color: Colors.white)
                ),)
              ],
            ),
          ),
          )),

        ],
      ),
    );
  }
}
