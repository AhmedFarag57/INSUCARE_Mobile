import 'package:flutter/material.dart';

class CustomDialogBox extends StatefulWidget {
  final String? title, descriptions, text1, text2, imgUrl;
  final VoidCallback? callback1, callback2;
  final bool twoAction;

  const CustomDialogBox({
    Key? key,
    this.title,
    this.descriptions,
    this.text1,
    this.text2,
    this.imgUrl,
    this.callback1,
    this.callback2,
    required this.twoAction,
  }) : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: widget.twoAction ? _buildTwoAction() : _buildOneAction(),
    );
  }

  Widget _buildOneAction() {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(
            left: 20.0,
            top: 65.0,
            right: 20.0,
            bottom: 20.0,
          ),
          margin: const EdgeInsets.only(top: 45.0),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                offset: Offset(0, 10),
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                widget.title!,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                widget.descriptions!,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 22),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: widget.callback1,
                  child: Text(
                    widget.text1!,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 20.0,
          right: 20.0,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 45.0,
            child: ClipRRect(
              child: Image.asset(widget.imgUrl!),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTwoAction() {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(
            left: 20.0,
            top: 65.0,
            right: 20.0,
            bottom: 20.0,
          ),
          margin: const EdgeInsets.only(top: 45.0),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                offset: Offset(0, 10),
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                widget.title!,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                widget.descriptions!,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 22),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: TextButton(
                      onPressed: widget.callback1,
                      child: Text(
                        widget.text1!,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      onPressed: widget.callback2,
                      child: Text(
                        widget.text2!,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          left: 20.0,
          right: 20.0,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 45.0,
            child: ClipRRect(
              child: Image.asset(widget.imgUrl!),
            ),
          ),
        ),
      ],
    );
  }
}
