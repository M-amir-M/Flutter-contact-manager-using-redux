import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RectInput extends StatefulWidget {
  final TextEditingController controller;
  final void Function(String) onSave;
  final VoidCallback onClear;
  final Function validator;
  final String placeholder;
  final double opacity;
  final int maxLines;
  final textColor;
  final labelColor;
  final Widget suffixIcon;
  final enabled;
  final formatter;
  final keyboardType;
  final clearable;

  RectInput(
      {this.controller,
      this.onSave = null,
      this.onClear = null,
      this.validator = null,
      this.placeholder = 'متنی وارد کنید',
      this.opacity = 1.0,
      this.maxLines = 1,
      this.enabled = true,
      this.clearable = false,
      this.keyboardType = TextInputType.text,
      this.suffixIcon = null,
      this.formatter = null,
      this.labelColor = Colors.black,
      this.textColor = Colors.black});
  @override
  _RectInputState createState() => _RectInputState();
}

class _RectInputState extends State<RectInput> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final greenColor = Theme.of(context).primaryColorLight;
    final blueColor = Theme.of(context).primaryColorDark;
    final iconSize = 30.0;

    return Stack(
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(minWidth: double.infinity),
          child: Container(
            height: 55.0,
            color: Colors.white.withOpacity(0.0),
          ),
        ),
        IgnorePointer(
            ignoring: !widget.enabled,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                    keyboardType: widget.keyboardType,
                    controller: widget.controller,
                    maxLines: widget.maxLines,
                    textInputAction: TextInputAction.done,
                    inputFormatters: widget.formatter,
                    // enabled: widget.enabled,
                    decoration: InputDecoration(
                        suffixIcon: widget.suffixIcon,
                        fillColor: Colors.white.withOpacity(0.7),
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: greenColor,
                                width: 1.0,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(10.0)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: blueColor,
                                width: 1.0,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(10.0)),
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: blueColor,
                                width: 1.0,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(10.0)),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.redAccent,
                                width: 1.0,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(10.0)),
                  
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 20.0),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: greenColor,
                                width: 1.0,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(10.0)),
                        labelText: widget.placeholder,
                        labelStyle:
                            TextStyle(color: widget.labelColor, height: 0.5)),
                    style: TextStyle(
                        fontFamily: 'is',
                        fontSize: 18.0,
                        color: widget.textColor),
                    validator: (value) {
                      return widget.validator() ?? null;
                    },
                    onFieldSubmitted: (text) {
                      widget.onSave(text);
                    },
                    onSaved: (String value) {
                      widget.onSave(value);
                    }),
              ],
            )),
        Positioned(
          left: 0,
          child: widget.clearable
              ? new IconButton(
                  onPressed: () {
                    widget.controller.clear();
                    widget.onClear();
                  },
                  icon: new Icon(Icons.clear))
              : Container(),
        )
      ],
    );
  }
}

//TODO: clean
class RectInputT extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String) onSave;
  final void Function(dynamic) validator;
  final String placeholder;
  final double opacity;
  final int maxLines;
  final textColor;
  final labelColor;
  final Widget suffixIcon;
  final enabled;

  RectInputT(
      {this.controller,
      this.onSave = null,
      this.validator = null,
      this.placeholder = 'متنی وارد کنید',
      this.opacity = 1.0,
      this.maxLines = 1,
      this.enabled = true,
      this.suffixIcon = null,
      this.labelColor = Colors.black,
      this.textColor = Colors.black});

  @override
  Widget build(BuildContext context) {
    final greenColor = Theme.of(context).primaryColorLight;
    final blueColor = Theme.of(context).primaryColorDark;
    final iconSize = 30.0;
    FocusNode _focusNode = new FocusNode();

    return Stack(
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(minWidth: double.infinity),
          child: Container(
            height: 55.0,
            color: Colors.white.withOpacity(0.0),
          ),
        ),
        IgnorePointer(
          ignoring: !enabled,
          child: TextFormField(
              textAlign: TextAlign.start,
              controller: controller,
              maxLines: maxLines,
              focusNode: _focusNode,
              textInputAction: TextInputAction.done,
              // enabled: enabled,
              decoration: InputDecoration(
                  suffixIcon: suffixIcon,
                  fillColor: Colors.white.withOpacity(0.7),
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: greenColor,
                          width: 1.0,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(10.0)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: blueColor,
                          width: 1.0,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(10.0)),
                  disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: blueColor,
                          width: 1.0,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(10.0)),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: greenColor,
                          width: 1.0,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(10.0)),
                  labelText: placeholder,
                  labelStyle: TextStyle(color: labelColor, height: 0.5)),
              style:
                  TextStyle(fontFamily: 'is', fontSize: 18.0, color: textColor),
              validator: (value) {
                this.validator(value);
              },
              onFieldSubmitted: (text) {
                _focusNode.unfocus();
              },
              onSaved: (String value) {
                this.onSave(value);
              }),
        ),
      ],
    );
  }
}
