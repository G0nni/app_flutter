import 'package:flutter/material.dart';
import '../model/datamodel.dart';

class QuestionWidget extends StatefulWidget {
  const QuestionWidget({super.key, required this.questiondata});

  final List<QuestionInfo> questiondata;

  @override
  State<StatefulWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: .all(4.0),
          child: Column(
            children: <Widget>[
              Spacer(),
              Text(widget.questiondata[index].title),
              Spacer(),
              Text(widget.questiondata[index].question),
              Spacer(),
              LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: 500,
                        maxWidth: 500,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: widget.questiondata[index].responses
                            .map(
                              (unresponse) => ItemWidget(
                                text: unresponse,
                                onTap: () {
                                  if (index + 1 < widget.questiondata.length) {
                                    setState(() {
                                      index++;
                                    });
                                  } else {
                                    Navigator.pushNamed(context, '/after');
                                  }
                                },
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  );
                },
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemWidget extends StatelessWidget {
  const ItemWidget({super.key, required this.text, required this.onTap});

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      height: 100,
      child: ElevatedButton(
        onPressed: () {
          onTap();
        },
        child: Text(text),
      ),
    );
  }
}
