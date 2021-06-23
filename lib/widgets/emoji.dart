import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nara_task/state/state.dart';

import 'package:rive/rive.dart';

class Emoji extends StatefulWidget {
  const Emoji({Key? key, height, width})
      : _height = height ?? 120,
        _width = width ?? 120,
        super(key: key);
  final double _height, _width;

  @override
  _EmojiState createState() => _EmojiState();
}

class _EmojiState extends State<Emoji> {
  Artboard? _artboard;
  RiveAnimationController? _animController;
  @override
  void initState() {
    _animController = SimpleAnimation('entry');

    rootBundle.load('assets/emoji.riv').then(
      (data) {
        final file = RiveFile.import(data);
        final artboard = file.mainArtboard;
        artboard.addController(
          _animController = SimpleAnimation('entry'),
        );
        setState(() => _artboard = artboard);
      },
    );
    super.initState();
  }

  void playAnimation() {}
  @override
  Widget build(BuildContext context) {
    return _artboard == null
        ? SizedBox()
        : Consumer(
            builder: (_, watch, ___) {
              final state = watch(stateProvider)
                ..state.setArtboard(_artboard!)
                ..state.setController(_animController!);
              return SizedBox(
                height: widget._height,
                width: widget._width,
                child: Rive(artboard: state.state.artboard!),
              );
            },
          );
  }
}

// _artboard!.removeController(_animController!);
// _artboard!.addController(
//   _animController = SimpleAnimation(fromToAnim),
// );
