import 'package:flutter/material.dart';

class DescriptionTextWidget extends StatefulWidget {
  final String text;
  bool isBold = false;

  DescriptionTextWidget({@required this.text, this.isBold});

  @override
  _DescriptionTextWidgetState createState() =>
      new _DescriptionTextWidgetState();
}

class _DescriptionTextWidgetState extends State<DescriptionTextWidget> {
  String firstHalf;
  String secondHalf;

  bool flag = true;

  final int textLenghtCutter = 100;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > textLenghtCutter) {
      firstHalf = widget.text.substring(0, textLenghtCutter);
      secondHalf = widget.text.substring(textLenghtCutter, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: secondHalf.isEmpty
          ? new Text(
              firstHalf,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16.0,
                fontWeight: widget.isBold ? FontWeight.bold : FontWeight.normal,
              ),
              textAlign: TextAlign.justify,
            )
          : new Column(
              children: <Widget>[
                new Text(
                  flag ? (firstHalf + "...") : (firstHalf + secondHalf),
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16.0,
                    fontWeight:
                        widget.isBold ? FontWeight.bold : FontWeight.normal,
                  ),
                  textAlign: TextAlign.justify,
                ),
                new InkWell(
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      new Text(
                        flag ? "Read more" : "Read less",
                        style: new TextStyle(
                          color: Colors.blue,
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      flag = !flag;
                    });
                  },
                ),
              ],
            ),
    );
  }
}

class ExpandableText extends StatefulWidget {
  final String text;

  ExpandableText({@required this.text});

  bool isExpanded = false;

  @override
  _ExpandableTextState createState() => new _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText>
    with TickerProviderStateMixin<ExpandableText> {
  @override
  Widget build(BuildContext context) {
    return new Column(children: <Widget>[
      new AnimatedSize(
          vsync: this,
          duration: const Duration(milliseconds: 500),
          child: new ConstrainedBox(
              constraints: widget.isExpanded
                  ? new BoxConstraints()
                  : new BoxConstraints(maxHeight: 50.0),
              child: new Text(
                widget.text,
                softWrap: true,
                overflow: TextOverflow.fade,
              ))),
      widget.isExpanded
          ? new ConstrainedBox(constraints: new BoxConstraints())
          : new FlatButton(
              child: const Text('...'),
              onPressed: () => setState(() => widget.isExpanded = true))
    ]);
  }
}
