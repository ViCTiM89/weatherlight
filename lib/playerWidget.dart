import 'package:flutter/material.dart';

class PlayerWidget extends StatefulWidget {
  final double pmHeight;
  final double pmWidth;
  final double statusHeight;
  final double statusWidth;
  String commanderName;
  final String initialCommanderName;
  int nLP;
  final Color shadowIncrement;
  final Color shadowDecrement;
  final Color shadowStatus;
  Color colorPlayer;
  final TextEditingController controller;
  final TextEditingController controllerName;

  PlayerWidget({super.key,
    required this.pmHeight,
    required this.pmWidth,
    required this.statusHeight,
    required this.statusWidth,
    required this.commanderName,
    required this.initialCommanderName,
    required this.nLP,
    required this.shadowIncrement,
    required this.shadowDecrement,
    required this.shadowStatus,
    required this.colorPlayer,
    required this.controller,
    required this.controllerName,
  });

  @override
  _PlayerWidgetState createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget> {
  void _updateLP(int i) {
    setState(
      () {
        widget.nLP += i;
        if (widget.nLP < 10) {
          widget.colorPlayer = widget.shadowDecrement;
        } else {
          widget.colorPlayer = widget.shadowStatus;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        InkWell(
          child: Container(
            height: widget.pmHeight,
            width: widget.pmWidth,
            decoration: const BoxDecoration(
              color: Colors.white30,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: Center(
              child: RotatedBox(
                quarterTurns: 3,
                child: Icon(
                  Icons.add,
                  size: 50,
                  color: Colors.greenAccent,
                  shadows: [
                    for (double i = 1; i < 5; i++)
                      Shadow(
                        color: widget.shadowIncrement,
                        blurRadius: 3 * i,
                      )
                  ],
                ),
              ),
            ),
          ),
          onTap: () {
            _updateLP(1);
          },
          onLongPress: () {
            _updateLP(10);
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              child: Container(
                height: widget.statusHeight,
                width: widget.statusWidth,
                color: Colors.white30,
                child: Center(
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: FittedBox(
                      child: Text(
                        widget.commanderName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.white,
                          shadows: [
                            for (double i = 1; i < 10; i++)
                              Shadow(
                                color: widget.shadowStatus,
                                blurRadius: 3 * i,
                              )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              onLongPress: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text("Player Name"),
                  content: TextField(
                    textCapitalization: TextCapitalization.sentences,
                    controller: widget.controllerName,
                    onSubmitted: (value) {
                      setState(() {
                        if (widget.controllerName.text.isEmpty) {
                          widget.commanderName = widget.initialCommanderName;
                        } else {
                          widget.commanderName = widget.controllerName.text;
                          widget.controllerName.clear();
                        }
                      });
                      Navigator.pop(context, 'OK');
                    },
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              child: Container(
                height: widget.statusHeight,
                width: widget.statusWidth,
                color: Colors.white30,
                child: Center(
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: Text(
                      '${widget.nLP}',
                      style: TextStyle(
                        fontSize: 50,
                        color: Colors.white,
                        shadows: [
                          for (double i = 1; i < 10; i++)
                            Shadow(
                              color: widget.colorPlayer,
                              blurRadius: 3 * i,
                            )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              onLongPress: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text("Enter Life Points"),
                  content: TextField(
                    keyboardType: TextInputType.number,
                    controller: widget.controller,
                    onSubmitted: (value) {
                      if (widget.controller.text.isNotEmpty) {
                        setState(() {
                          widget.nLP = int.parse(widget.controller.text);
                        });
                        widget.controller.clear();
                      }
                      Navigator.pop(context, 'OK');
                    },
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        InkWell(
          child: Container(
            height: widget.pmHeight,
            width: widget.pmWidth,
            decoration: const BoxDecoration(
              color: Colors.white30,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
            ),
            child: Center(
              child: RotatedBox(
                quarterTurns: 3,
                child: Icon(
                  Icons.remove,
                  size: 50,
                  color: Colors.red,
                  shadows: [
                    for (double i = 1; i < 10; i++)
                      Shadow(
                        color: widget.shadowStatus,
                        blurRadius: 3 * i,
                      ),
                  ],
                ),
              ),
            ),
          ),
          onTap: () {
            _updateLP(-1);
          },
          onLongPress: () {
            _updateLP(-10);
          },
        ),
      ],
    );
  }
}
