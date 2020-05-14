import 'package:batufo/engine/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';

class GameWidget extends StatelessWidget {
  final Game game;
  final Color background;

  const GameWidget(this.game, {this.background = Colors.transparent});

  Widget build(BuildContext context) {
    return Container(
      color: background,
      child: _EmbeddedGameWidget(game),
    );
  }
}

class _EmbeddedGameWidget extends LeafRenderObjectWidget {
  final Game game;
  final Size size;

  const _EmbeddedGameWidget(this.game, {this.size});

  RenderBox createRenderObject(BuildContext context) {
    return RenderConstrainedBox(
        child: _GameRenderBox(context, game),
        additionalConstraints: BoxConstraints.expand(
          width: size?.width,
          height: size?.height,
        ));
  }

  void updateRenderObject(
      BuildContext context, RenderConstrainedBox renderBox) {
    renderBox
      ..child = _GameRenderBox(context, game)
      ..additionalConstraints =
          BoxConstraints.expand(width: size?.width, height: size?.height);
  }
}

class _GameRenderBox extends RenderBox with WidgetsBindingObserver {
  final BuildContext context;
  final Game game;
  int _frameCallbackId;
  double _previous = 0.0;

  _GameRenderBox(this.context, this.game);

  bool get sizedByParent => true;

  void performResize() {
    super.performResize();
    game.resize(constraints.biggest);
  }

  void attach(PipelineOwner owner) {
    super.attach(owner);
    game.onAttach();
    _scheduleTick();
    _bindLifecycleListener();
  }

  void detach() {
    super.detach();
    game.onDetach();
    _unscheduleTick();
    _unbindLifecycleListener();
  }

  void paint(PaintingContext context, Offset offset) {
    context.canvas.save();
    game.render(context.canvas);
    context.canvas.restore();
  }

  void _scheduleTick() {
    _frameCallbackId = SchedulerBinding.instance.scheduleFrameCallback(_tick);
  }

  void _unscheduleTick() {
    SchedulerBinding.instance.cancelFrameCallbackWithId(_frameCallbackId);
  }

  void _tick(Duration ts) {
    if (!attached) return;
    _scheduleTick();
    _update(ts.inMicroseconds / Duration.microsecondsPerMillisecond);
    markNeedsPaint();
  }

  void _update(double ts) {
    final dt = _computeDelta(ts);
    game
      ..update(dt, ts)
      ..updateUI(dt, ts)
      ..cleanup();
  }

  double _computeDelta(double ts) {
    final delta = _previous == 0.0 ? 0.0 : ts - _previous;
    _previous = ts;
    return delta;
  }

  void _bindLifecycleListener() {
    WidgetsBinding.instance.addObserver(this);
  }

  void _unbindLifecycleListener() {
    WidgetsBinding.instance.removeObserver(this);
  }
}
