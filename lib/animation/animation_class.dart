import 'package:flutter/material.dart';

class ZoomIn extends StatefulWidget {
  final Key? key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;
  final double from;

  ZoomIn(
      {this.key,
        required this.child,
        this.duration = const Duration(milliseconds: 500),
        this.delay = const Duration(milliseconds: 0),
        this.controller,
        this.manualTrigger = false,
        this.animate = true,
        this.from = 1.0})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  _ZoomInState createState() => _ZoomInState();
}

class _ZoomInState extends State<ZoomIn> with SingleTickerProviderStateMixin {
  AnimationController? controller;
  bool disposed = false;
  late Animation<double> fade;
  late Animation<double> opacity;

  @override
  void dispose() {
    disposed = true;
    controller!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);
    fade = Tween(begin: 0.0, end: widget.from)
        .animate(CurvedAnimation(curve: Curves.easeOut, parent: controller!));

    opacity = Tween<double>(begin: 0.0, end: 1).animate(
        CurvedAnimation(parent: controller!, curve: Interval(0, 0.65)));

    if (!widget.manualTrigger && widget.animate) {
      Future.delayed(widget.delay, () {
        if (!disposed) {
          controller?.forward();
        }
      });
    }

    if (widget.controller is Function) {
      widget.controller!(controller!);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate && widget.delay.inMilliseconds == 0) {
      controller?.forward();
    }

    return AnimatedBuilder(
        animation: fade,
        builder: (BuildContext context, Widget? child) {
          return Transform.scale(
            scale: fade.value,
            child: Opacity(
              opacity: opacity.value,
              child: widget.child,
            ),
          );
        });
  }
}

class ZoomOut extends StatefulWidget {
  final Key? key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;
  final double from;

  ZoomOut(
      {this.key,
        required this.child,
        this.duration = const Duration(milliseconds: 500),
        this.delay = const Duration(milliseconds: 0),
        this.controller,
        this.manualTrigger = false,
        this.animate = true,
        this.from = 0.0})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  _ZoomOutState createState() => _ZoomOutState();
}

class _ZoomOutState extends State<ZoomOut> with SingleTickerProviderStateMixin {
  AnimationController? controller;
  bool disposed = false;
  late Animation<double> zoom;
  late Animation<double> opacity;

  @override
  void dispose() {
    disposed = true;
    controller!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);

    zoom = Tween(begin: 1.0, end: widget.from)
        .animate(CurvedAnimation(curve: Curves.easeOut, parent: controller!));

    opacity = Tween<double>(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(parent: controller!, curve: Interval(0, 0.65)));

    if (!widget.manualTrigger && widget.animate) {
      Future.delayed(widget.delay, () {
        if (!disposed) {
          controller?.forward();
        }
      });
    }

    if (widget.controller is Function) {
      widget.controller!(controller!);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate && widget.delay.inMilliseconds == 0) {
      controller?.forward();
    }

    return AnimatedBuilder(
        animation: controller!,
        builder: (BuildContext context, Widget? child) {
          return Transform.scale(
            scale: zoom.value,
            child: Opacity(
              opacity: opacity.value,
              child: widget.child,
            ),
          );
        });
  }
}

class JelloIn extends StatefulWidget {
  final Key? key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;

  JelloIn(
      {this.key,
        required this.child,
        this.duration = const Duration(milliseconds: 800),
        this.delay = const Duration(milliseconds: 0),
        this.controller,
        this.manualTrigger = false,
        this.animate = true})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  _JelloInState createState() => _JelloInState();
}

class _JelloInState extends State<JelloIn> with SingleTickerProviderStateMixin {
  AnimationController? controller;
  bool disposed = false;
  late Animation<double> rotation;
  late Animation<double> opacity;

  @override
  void dispose() {
    disposed = true;
    controller!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);

    rotation = Tween<double>(begin: 1.5, end: 0.0)
        .animate(CurvedAnimation(parent: controller!, curve: Curves.bounceOut));

    opacity = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: controller!, curve: Interval(0, 0.65)));

    if (!widget.manualTrigger && widget.animate) {
      Future.delayed(widget.delay, () {
        if (!disposed) {
          controller?.forward();
        }
      });
    }

    if (widget.controller is Function) {
      widget.controller!(controller!);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate && widget.delay.inMilliseconds == 0) {
      controller?.forward();
    }

    return AnimatedBuilder(
        animation: controller!,
        builder: (BuildContext context, Widget? child) {
          return Transform(
              alignment: FractionalOffset.center,
              transform: Matrix4.identity()
                ..setEntry(0, 0, rotation.value + 1)
                ..rotateX(rotation.value),
              child: Opacity(
                opacity: opacity.value,
                child: widget.child,
              ));
        });
  }
}

class SlideInUp extends StatefulWidget {
  final Key? key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;
  final double from;

  SlideInUp(
      {this.key,
        required this.child,
        this.duration = const Duration(milliseconds: 600),
        this.delay = const Duration(milliseconds: 0),
        this.controller,
        this.manualTrigger = false,
        this.animate = true,
        this.from = 100})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  _SlideInUpState createState() => _SlideInUpState();
}

class _SlideInUpState extends State<SlideInUp>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  bool disposed = false;
  late Animation<double> animation;

  @override
  void dispose() {
    disposed = true;
    controller!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);

    animation = Tween<double>(begin: widget.from, end: 0)
        .animate(CurvedAnimation(parent: controller!, curve: Curves.easeOut));

    if (!widget.manualTrigger && widget.animate) {
      Future.delayed(widget.delay, () {
        if (!disposed) {
          controller?.forward();
        }
      });
    }

    if (widget.controller is Function) {
      widget.controller!(controller!);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate && widget.delay.inMilliseconds == 0) {
      controller?.forward();
    }

    return AnimatedBuilder(
        animation: controller!,
        builder: (BuildContext context, Widget? child) {
          return Transform.translate(
              offset: Offset(0, animation.value), child: widget.child);
        });
  }
}

class SlideInDown extends StatelessWidget {
  final Key? key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;
  final double from;

  SlideInDown(
      {this.key,
        required this.child,
        this.duration = const Duration(milliseconds: 600),
        this.delay = const Duration(milliseconds: 0),
        this.controller,
        this.manualTrigger = false,
        this.animate = true,
        this.from = 100})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  Widget build(BuildContext context) => SlideInUp(
    child: child,
    duration: duration,
    delay: delay,
    controller: controller,
    manualTrigger: manualTrigger,
    animate: animate,
    from: from * -1,
  );
}

class SlideInLeft extends StatefulWidget {
  final Key? key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;
  final double from;

  SlideInLeft(
      {this.key,
        required this.child,
        this.duration = const Duration(milliseconds: 600),
        this.delay = const Duration(milliseconds: 0),
        this.controller,
        this.manualTrigger = false,
        this.animate = true,
        this.from = 100})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  _SlideInLeftState createState() => _SlideInLeftState();
}

class _SlideInLeftState extends State<SlideInLeft>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  bool disposed = false;
  late Animation<double> animation;

  @override
  void dispose() {
    disposed = true;
    controller!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);

    animation = Tween<double>(begin: widget.from * -1, end: 0)
        .animate(CurvedAnimation(parent: controller!, curve: Curves.easeOut));

    if (!widget.manualTrigger && widget.animate) {
      Future.delayed(widget.delay, () {
        if (!disposed) {
          controller?.forward();
        }
      });
    }

    if (widget.controller is Function) {
      widget.controller!(controller!);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate && widget.delay.inMilliseconds == 0) {
      controller?.forward();
    }

    return AnimatedBuilder(
        animation: controller!,
        builder: (BuildContext context, Widget? child) {
          return Transform.translate(
              offset: Offset(animation.value, 0), child: widget.child);
        });
  }
}

class SlideInRight extends StatelessWidget {
  final Key? key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;
  final double from;

  SlideInRight(
      {this.key,
        required this.child,
        this.duration = const Duration(milliseconds: 600),
        this.delay = const Duration(milliseconds: 0),
        this.controller,
        this.manualTrigger = false,
        this.animate = true,
        this.from = 100})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  Widget build(BuildContext context) => SlideInLeft(
    child: child,
    duration: duration,
    delay: delay,
    controller: controller,
    manualTrigger: manualTrigger,
    animate: animate,
    from: from * -1,
  );
}

class FlipInX extends StatefulWidget {
  final Key? key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;

  FlipInX(
      {this.key,
        required this.child,
        this.duration = const Duration(milliseconds: 800),
        this.delay = const Duration(milliseconds: 0),
        this.controller,
        this.manualTrigger = false,
        this.animate = true})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  _FlipInXState createState() => _FlipInXState();
}

class _FlipInXState extends State<FlipInX> with SingleTickerProviderStateMixin {
  AnimationController? controller;
  bool disposed = false;
  late Animation<double> rotation;
  late Animation<double> opacity;

  @override
  void dispose() {
    disposed = true;
    controller!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);

    rotation = Tween<double>(begin: 1.5, end: 0.0)
        .animate(CurvedAnimation(parent: controller!, curve: Curves.bounceOut));

    opacity = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: controller!, curve: Interval(0, 0.65)));

    if (!widget.manualTrigger && widget.animate) {
      Future.delayed(widget.delay, () {
        if (!disposed) {
          controller?.forward();
        }
      });
    }

    if (widget.controller is Function) {
      widget.controller!(controller!);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate && widget.delay.inMilliseconds == 0) {
      controller?.forward();
    }

    return AnimatedBuilder(
        animation: controller!,
        builder: (BuildContext context, Widget? child) {
          return Transform(
              alignment: FractionalOffset.center,
              transform: Matrix4.identity()..rotateX(rotation.value),
              child: Opacity(
                opacity: opacity.value,
                child: widget.child,
              ));
        });
  }
}

class FlipInY extends StatefulWidget {
  final Key? key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;

  FlipInY(
      {this.key,
        required this.child,
        this.duration = const Duration(milliseconds: 800),
        this.delay = const Duration(milliseconds: 0),
        this.controller,
        this.manualTrigger = false,
        this.animate = true})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  _FlipInYState createState() => _FlipInYState();
}

class _FlipInYState extends State<FlipInY> with SingleTickerProviderStateMixin {
  AnimationController? controller;
  bool disposed = false;
  late Animation<double> rotation;
  late Animation<double> opacity;

  @override
  void dispose() {
    disposed = true;
    controller!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);

    rotation = Tween<double>(begin: 1.5, end: 0.0)
        .animate(CurvedAnimation(parent: controller!, curve: Curves.bounceOut));

    opacity = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: controller!, curve: Interval(0, 0.65)));

    if (!widget.manualTrigger && widget.animate) {
      Future.delayed(widget.delay, () {
        if (!disposed) {
          controller?.forward();
        }
      });
    }

    if (widget.controller is Function) {
      widget.controller!(controller!);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate && widget.delay.inMilliseconds == 0) {
      controller?.forward();
    }

    return AnimatedBuilder(
        animation: controller!,
        builder: (BuildContext context, Widget? child) {
          return Transform(
              alignment: FractionalOffset.center,
              transform: Matrix4.identity()..rotateY(rotation.value),
              child: Opacity(
                opacity: opacity.value,
                child: widget.child,
              ));
        });
  }
}

class FadeIn extends StatefulWidget {
  final Key? key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;

  FadeIn(
      {this.key,
        required this.child,
        this.duration = const Duration(milliseconds: 300),
        this.delay = const Duration(milliseconds: 0),
        this.controller,
        this.manualTrigger = false,
        this.animate = true})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  _FadeInState createState() => _FadeInState();
}

class _FadeInState extends State<FadeIn> with SingleTickerProviderStateMixin {
  AnimationController? controller;
  bool disposed = false;
  late Animation<double> animation;

  @override
  void dispose() {
    disposed = true;
    controller!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);
    animation = CurvedAnimation(curve: Curves.easeOut, parent: controller!);

    if (!widget.manualTrigger && widget.animate) {
      Future.delayed(widget.delay, () {
        if (!disposed) {
          controller?.forward();
        }
      });
    }

    if (widget.controller is Function) {
      widget.controller!(controller!);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate && widget.delay.inMilliseconds == 0) {
      controller?.forward();
    }

    return AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? child) {
          return Opacity(
            opacity: animation.value,
            child: widget.child,
          );
        });
  }
}

class FadeInDown extends StatefulWidget {
  final Key? key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;
  final double from;

  FadeInDown(
      {this.key,
        required this.child,
        this.duration = const Duration(milliseconds: 800),
        this.delay = const Duration(milliseconds: 0),
        this.controller,
        this.manualTrigger = false,
        this.animate = true,
        this.from = 100})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  _FadeInDownState createState() => _FadeInDownState();
}

class _FadeInDownState extends State<FadeInDown>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  bool disposed = false;
  late Animation<double> animation;
  late Animation<double> opacity;

  @override
  void dispose() {
    disposed = true;
    controller!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);

    animation = Tween<double>(begin: widget.from * -1, end: 0)
        .animate(CurvedAnimation(parent: controller!, curve: Curves.easeOut));

    opacity = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: controller!, curve: Interval(0, 0.65)));

    if (!widget.manualTrigger && widget.animate) {
      Future.delayed(widget.delay, () {
        if (!disposed) {
          controller?.forward();
        }
      });
    }

    if (widget.controller is Function) {
      widget.controller!(controller!);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate && widget.delay.inMilliseconds == 0) {
      controller?.forward();
    }

    return AnimatedBuilder(
        animation: controller!,
        builder: (BuildContext context, Widget? child) {
          return Transform.translate(
              offset: Offset(0, animation.value),
              child: Opacity(
                opacity: opacity.value,
                child: widget.child,
              ));
        });
  }
}

class FadeInDownBig extends StatelessWidget {
  final Key? key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;
  final double from;

  FadeInDownBig(
      {this.key,
        required this.child,
        this.duration = const Duration(milliseconds: 1300),
        this.delay = const Duration(milliseconds: 0),
        this.controller,
        this.manualTrigger = false,
        this.animate = true,
        this.from = 600})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  Widget build(BuildContext context) => FadeInDown(
      child: child,
      duration: duration,
      delay: delay,
      controller: controller,
      manualTrigger: manualTrigger,
      animate: animate,
      from: from);
}

class FadeInUp extends StatefulWidget {
  final Key? key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;
  final double from;

  FadeInUp(
      {this.key,
        required this.child,
        this.duration = const Duration(milliseconds: 800),
        this.delay = const Duration(milliseconds: 0),
        this.controller,
        this.manualTrigger = false,
        this.animate = true,
        this.from = 100})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  _FadeInUpState createState() => _FadeInUpState();
}

class _FadeInUpState extends State<FadeInUp>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  bool disposed = false;
  late Animation<double> animation;
  late Animation<double> opacity;
  @override
  void dispose() {
    disposed = true;
    controller!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);

    animation = Tween<double>(begin: widget.from, end: 0)
        .animate(CurvedAnimation(parent: controller!, curve: Curves.easeOut));
    opacity = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: controller!, curve: Interval(0, 0.65)));

    if (!widget.manualTrigger && widget.animate) {
      Future.delayed(widget.delay, () {
        if (!disposed) {
          controller?.forward();
        }
      });
    }

    if (widget.controller is Function) {
      widget.controller!(controller!);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate && widget.delay.inMilliseconds == 0) {
      controller?.forward();
    }

    return AnimatedBuilder(
        animation: controller!,
        builder: (BuildContext context, Widget? child) {
          return Transform.translate(
              offset: Offset(0, animation.value),
              child: Opacity(
                opacity: opacity.value,
                child: widget.child,
              ));
        });
  }
}

class FadeInUpBig extends StatelessWidget {
  final Key? key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;
  final double from;

  FadeInUpBig(
      {this.key,
        required this.child,
        this.duration = const Duration(milliseconds: 1300),
        this.delay = const Duration(milliseconds: 0),
        this.controller,
        this.manualTrigger = false,
        this.animate = true,
        this.from = 600})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  Widget build(BuildContext context) => FadeInUp(
    child: child,
    duration: duration,
    delay: delay,
    controller: controller,
    manualTrigger: manualTrigger,
    animate: animate,
    from: from,
  );
}

class FadeInLeft extends StatefulWidget {
  final Key? key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;
  final double from;

  FadeInLeft(
      {this.key,
        required this.child,
        this.duration = const Duration(milliseconds: 800),
        this.delay = const Duration(milliseconds: 0),
        this.controller,
        this.manualTrigger = false,
        this.animate = true,
        this.from = 100})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  _FadeInLeftState createState() => _FadeInLeftState();
}

class _FadeInLeftState extends State<FadeInLeft>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  bool disposed = false;
  late Animation<double> animation;
  late Animation<double> opacity;
  late Animation<double> bouncing;
  @override
  void dispose() {
    disposed = true;
    controller!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);

    animation = Tween<double>(begin: widget.from * -1, end: 0)
        .animate(CurvedAnimation(parent: controller!, curve: Curves.easeOut));
    opacity = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: controller!, curve: Interval(0, 0.65)));
    controller = AnimationController(duration: widget.duration, vsync: this);

    opacity = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: controller!, curve: Interval(0, 0.45)));

    bouncing = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: controller!, curve: Curves.elasticOut));

    if (!widget.manualTrigger && widget.animate) {
      Future.delayed(widget.delay, () {
        if (!disposed) {
          controller?.forward();
        }
      });
    }

    if (widget.controller is Function) {
      widget.controller!(controller!);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate && widget.delay.inMilliseconds == 0) {
      controller?.forward();
    }

    return AnimatedBuilder(
        animation: controller!,
        builder: (BuildContext context, Widget? child) {
          return Transform.scale(
            scale: bouncing.value,
            child: Opacity(
              opacity: opacity.value,
              child: widget.child,
            ),
          );
        });
  }
}

class ElasticInDown extends StatefulWidget {
  final Key? key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;
  final double from;
  final double to;

  ElasticInDown(
      {this.key,
        required this.child,
        this.duration = const Duration(milliseconds: 1000),
        this.delay = const Duration(milliseconds: 0),
        this.controller,
        this.manualTrigger = false,
        this.animate = true,
        this.from = 200,
        this.to = 100})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  _ElasticInDownState createState() => _ElasticInDownState();
}

class _ElasticInDownState extends State<ElasticInDown>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  bool disposed = false;
  late Animation<double> bouncing;
  late Animation<double> falling;
  late Animation<double> opacity;
  @override
  void dispose() {
    disposed = true;
    controller!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);

    opacity = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: controller!, curve: Interval(0, 0.45)));

    falling = Tween<double>(begin: widget.from * -1, end: widget.to * -1)
        .animate(CurvedAnimation(
        parent: controller!,
        curve: Interval(0, 0.30, curve: Curves.linear)));

    bouncing = Tween<double>(begin: widget.to * -1, end: 0).animate(
        CurvedAnimation(
            parent: controller!,
            curve: Interval(0.30, 1, curve: Curves.elasticOut)));

    if (!widget.manualTrigger && widget.animate) {
      Future.delayed(widget.delay, () {
        if (!disposed) {
          controller?.forward();
        }
      });
    }

    if (widget.controller is Function) {
      widget.controller!(controller!);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate && widget.delay.inMilliseconds == 0) {
      controller?.forward();
    }

    return AnimatedBuilder(
        animation: controller!,
        builder: (BuildContext context, Widget? child) {
          return Transform.translate(
              offset: Offset(
                  0,
                  (falling.value == (widget.to * -1))
                      ? bouncing.value
                      : falling.value),
              child: Opacity(
                opacity: opacity.value,
                child: widget.child,
              ));
        });
  }
}

class ElasticInUp extends StatelessWidget {
  final Key? key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;
  final double from;

  ElasticInUp(
      {this.key,
        required this.child,
        this.duration = const Duration(milliseconds: 1000),
        this.delay = const Duration(milliseconds: 0),
        this.controller,
        this.manualTrigger = false,
        this.animate = true,
        this.from = 200})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  Widget build(BuildContext context) => ElasticInDown(
    child: child,
    duration: duration,
    delay: delay,
    controller: controller,
    manualTrigger: manualTrigger,
    animate: animate,
    from: from * -1,
    to: 100,
  );
}

class ElasticInLeft extends StatefulWidget {
  final Key? key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;
  final double from;
  final double to;

  ElasticInLeft(
      {this.key,
        required this.child,
        this.duration = const Duration(milliseconds: 1000),
        this.delay = const Duration(milliseconds: 0),
        this.controller,
        this.manualTrigger = false,
        this.animate = true,
        this.from = 200,
        this.to = 100})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  _ElasticInLeftState createState() => _ElasticInLeftState();
}

class _ElasticInLeftState extends State<ElasticInLeft>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  bool disposed = false;
  late Animation<double> bouncing;
  late Animation<double> falling;
  late Animation<double> opacity;
  @override
  void dispose() {
    disposed = true;
    controller!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);

    opacity = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: controller!, curve: Interval(0, 0.45)));

    falling = Tween<double>(begin: widget.from * -1, end: widget.to * -1)
        .animate(CurvedAnimation(
        parent: controller!,
        curve: Interval(0, 0.30, curve: Curves.linear)));

    bouncing = Tween<double>(begin: widget.to * -1, end: 0).animate(
        CurvedAnimation(
            parent: controller!,
            curve: Interval(0.30, 1, curve: Curves.elasticOut)));

    if (!widget.manualTrigger && widget.animate) {
      Future.delayed(widget.delay, () {
        if (!disposed) {
          controller?.forward();
        }
      });
    }

    if (widget.controller is Function) {
      widget.controller!(controller!);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate && widget.delay.inMilliseconds == 0) {
      controller?.forward();
    }

    return AnimatedBuilder(
        animation: controller!,
        builder: (BuildContext context, Widget? child) {
          return Transform.translate(
              offset: Offset(
                  (falling.value == (widget.to * -1))
                      ? bouncing.value
                      : falling.value,
                  0),
              child: Opacity(
                opacity: opacity.value,
                child: widget.child,
              ));
        });
  }
}

class ElasticInRight extends StatelessWidget {
  final Key? key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;
  final double from;

  ElasticInRight(
      {this.key,
        required this.child,
        this.duration = const Duration(milliseconds: 1000),
        this.delay = const Duration(milliseconds: 0),
        this.controller,
        this.manualTrigger = false,
        this.animate = true,
        this.from = 200})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  Widget build(BuildContext context) => ElasticInLeft(
      child: child,
      duration: duration,
      delay: delay,
      controller: controller,
      manualTrigger: manualTrigger,
      animate: animate,
      from: from * -1,
      to: -100);
}

class BounceInDown extends StatefulWidget {
  final Key? key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;
  final double from;

  BounceInDown(
      {this.key,
        required this.child,
        this.duration = const Duration(milliseconds: 1000),
        this.delay = const Duration(milliseconds: 0),
        this.controller,
        this.manualTrigger = false,
        this.animate = true,
        this.from = 75})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  _BounceInDownState createState() => _BounceInDownState();
}

class _BounceInDownState extends State<BounceInDown>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  bool disposed = false;
  late Animation<double> animation;
  late Animation<double> opacity;
  @override
  void dispose() {
    disposed = true;
    controller!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);

    opacity = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: controller!, curve: Interval(0, 0.65)));

    animation = Tween<double>(begin: widget.from * -1, end: 0)
        .animate(CurvedAnimation(parent: controller!, curve: Curves.bounceOut));

    if (!widget.manualTrigger && widget.animate) {
      Future.delayed(widget.delay, () {
        if (!disposed) {
          controller?.forward();
        }
      });
    }

    if (widget.controller is Function) {
      widget.controller!(controller!);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate && widget.delay.inMilliseconds == 0) {
      controller?.forward();
    }

    return AnimatedBuilder(
        animation: controller!,
        builder: (BuildContext context, Widget? child) {
          return Transform.translate(
              offset: Offset(0, animation.value),
              child: Opacity(opacity: opacity.value, child: widget.child));
        });
  }
}

class BounceInUp extends StatelessWidget {
  final Key? key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;
  final double from;

  BounceInUp(
      {this.key,
        required this.child,
        this.duration = const Duration(milliseconds: 1000),
        this.delay = const Duration(milliseconds: 0),
        this.controller,
        this.manualTrigger = false,
        this.animate = true,
        this.from = 75})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  Widget build(BuildContext context) => BounceInDown(
    child: child,
    duration: duration,
    delay: delay,
    controller: controller,
    manualTrigger: manualTrigger,
    animate: animate,
    from: from * -1,
  );
}

class BounceInLeft extends StatefulWidget {
  final Key? key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;
  final double from;

  BounceInLeft(
      {this.key,
        required this.child,
        this.duration = const Duration(milliseconds: 1000),
        this.delay = const Duration(milliseconds: 0),
        this.controller,
        this.manualTrigger = false,
        this.animate = true,
        this.from = 75})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  _BounceInLeftState createState() => _BounceInLeftState();
}

class _BounceInLeftState extends State<BounceInLeft>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  bool disposed = false;
  late Animation<double> animation;
  late Animation<double> opacity;
  @override
  void dispose() {
    disposed = true;
    controller!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);
    opacity = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: controller!, curve: Interval(0, 0.65)));

    animation = Tween<double>(begin: widget.from * -1, end: 0)
        .animate(CurvedAnimation(parent: controller!, curve: Curves.bounceOut));

    if (!widget.manualTrigger && widget.animate) {
      Future.delayed(widget.delay, () {
        if (!disposed) {
          controller?.forward();
        }
      });
    }

    if (widget.controller is Function) {
      widget.controller!(controller!);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate && widget.delay.inMilliseconds == 0) {
      controller?.forward();
    }

    return AnimatedBuilder(
        animation: controller!,
        builder: (BuildContext context, Widget? child) {
          return Transform.translate(
              offset: Offset(animation.value, 0),
              child: Opacity(
                opacity: opacity.value,
                child: widget.child,
              ));
        });
  }
}

class BounceInRight extends StatelessWidget {
  final Key? key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;
  final double from;

  BounceInRight(
      {this.key,
        required this.child,
        this.duration = const Duration(milliseconds: 1000),
        this.delay = const Duration(milliseconds: 0),
        this.controller,
        this.manualTrigger = false,
        this.animate = true,
        this.from = 75})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  Widget build(BuildContext context) => BounceInLeft(
    child: child,
    duration: duration,
    delay: delay,
    controller: controller,
    manualTrigger: manualTrigger,
    animate: animate,
    from: from * -1,
  );
}

class Bounce extends StatefulWidget {
  final Key? key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final bool infinite;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;
  final double from;

  Bounce(
      {this.key,
        required this.child,
        this.duration = const Duration(milliseconds: 1300),
        this.delay = const Duration(milliseconds: 0),
        this.infinite = false,
        this.controller,
        this.manualTrigger = false,
        this.animate = true,
        this.from = 50})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  _BounceState createState() => _BounceState();
}

class _BounceState extends State<Bounce> with SingleTickerProviderStateMixin {
  AnimationController? controller;
  bool disposed = false;
  late Animation<double> animationBounce;

  late Animation<double> animationUp;
  @override
  void dispose() {
    disposed = true;
    controller!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);

    animationUp = Tween<double>(begin: 0, end: widget.from * -1).animate(
        CurvedAnimation(
            curve: Interval(0, 0.35, curve: Curves.easeInOut),
            parent: controller!));

    animationBounce = Tween<double>(begin: widget.from * -1, end: 0.0).animate(
        CurvedAnimation(
            curve: Interval(0.35, 1, curve: Curves.bounceOut),
            parent: controller!));

    if (!widget.manualTrigger && widget.animate) {
      Future.delayed(widget.delay, () {
        if (!disposed) {
          (widget.infinite) ? controller!.repeat() : controller?.forward();
        }
      });
    }

    if (widget.controller is Function) {
      widget.controller!(controller!);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate && widget.delay.inMilliseconds == 0) {
      controller?.forward();
    }

    return AnimatedBuilder(
        animation: controller!,
        builder: (BuildContext context, Widget? child) {
          return Transform.translate(
              offset: Offset(
                  0,
                  (animationUp.value == (widget.from * -1))
                      ? animationBounce.value
                      : animationUp.value),
              child: widget.child);
        });
  }
}

class Flash extends StatefulWidget {
  final Key? key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final bool infinite;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;

  Flash(
      {this.key,
        required this.child,
        this.duration = const Duration(milliseconds: 1000),
        this.delay = const Duration(milliseconds: 0),
        this.infinite = false,
        this.controller,
        this.manualTrigger = false,
        this.animate = true})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  _FlashState createState() => _FlashState();
}

class _FlashState extends State<Flash> with SingleTickerProviderStateMixin {
  AnimationController? controller;
  bool disposed = false;
  late Animation<double> opacityOut1;
  late Animation<double> opacityIn1;
  late Animation<double> opacityOut2;
  late Animation<double> opacityIn2;
  @override
  void dispose() {
    disposed = true;
    controller!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);

    opacityOut1 = Tween<double>(begin: 1, end: 0).animate(
        CurvedAnimation(parent: controller!, curve: Interval(0, 0.25)));
    opacityIn1 = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: controller!, curve: Interval(0.25, 0.5)));
    opacityOut2 = Tween<double>(begin: 1, end: 0).animate(
        CurvedAnimation(parent: controller!, curve: Interval(0.5, 0.75)));
    opacityIn2 = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: controller!, curve: Interval(0.75, 1)));

    if (!widget.manualTrigger && widget.animate) {
      Future.delayed(widget.delay, () {
        if (!disposed) {
          (widget.infinite) ? controller!.repeat() : controller?.forward();
        }
      });
    }

    if (widget.controller is Function) {
      widget.controller!(controller!);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate && widget.delay.inMilliseconds == 0) {
      controller?.forward();
    }

    return AnimatedBuilder(
        animation: controller!,
        builder: (BuildContext context, Widget? child) {
          return Opacity(
              opacity: (controller!.value < 0.25)
                  ? opacityOut1.value
                  : (controller!.value < 0.5)
                  ? opacityIn1.value
                  : (controller!.value < 0.75)
                  ? opacityOut2.value
                  : opacityIn2.value,
              child: widget.child);
        });
  }
}

class Pulse extends StatefulWidget {
  final Key? key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final bool infinite;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;

  Pulse(
      {this.key,
        required this.child,
        this.duration = const Duration(milliseconds: 1000),
        this.delay = const Duration(milliseconds: 0),
        this.infinite = false,
        this.controller,
        this.manualTrigger = false,
        this.animate = true})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  _PulseState createState() => _PulseState();
}

class _PulseState extends State<Pulse> with SingleTickerProviderStateMixin {
  AnimationController? controller;
  bool disposed = false;
  late Animation<double> animationInc;
  late Animation<double> animationDec;
  @override
  void dispose() {
    disposed = true;
    controller!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);

    animationInc = Tween<double>(begin: 1, end: 1.5).animate(CurvedAnimation(
        parent: controller!, curve: Interval(0, 0.5, curve: Curves.easeOut)));

    animationDec = Tween<double>(begin: 1.5, end: 1).animate(CurvedAnimation(
        parent: controller!, curve: Interval(0.5, 1, curve: Curves.easeIn)));

    if (!widget.manualTrigger && widget.animate) {
      Future.delayed(widget.delay, () {
        if (!disposed) {
          (widget.infinite) ? controller!.repeat() : controller?.forward();
        }
      });
    }

    if (widget.controller is Function) {
      widget.controller!(controller!);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate && widget.delay.inMilliseconds == 0) {
      controller?.forward();
    }

    return AnimatedBuilder(
        animation: controller!,
        builder: (BuildContext context, Widget? child) {
          return Transform.scale(
            scale: (controller!.value < 0.5)
                ? animationInc.value
                : animationDec.value,
            child: widget.child,
          );
        });
  }
}

class Swing extends StatefulWidget {
  final Key? key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final bool infinite;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;

  Swing(
      {this.key,
        required this.child,
        this.duration = const Duration(milliseconds: 1000),
        this.delay = const Duration(milliseconds: 0),
        this.infinite = false,
        this.controller,
        this.manualTrigger = false,
        this.animate = true})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  _SwingState createState() => _SwingState();
}

class _SwingState extends State<Swing> with SingleTickerProviderStateMixin {
  AnimationController? controller;
  bool disposed = false;
  late Animation<double> animationRotation1;
  late Animation<double> animationRotation2;
  late Animation<double> animationRotation3;
  late Animation<double> animationRotation4;
  late Animation<double> animationRotation5;
  late Animation<double> animationRotation6;
  @override
  void dispose() {
    disposed = true;
    controller!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);

    animationRotation1 = Tween<double>(begin: 0, end: -0.5).animate(
        CurvedAnimation(
            parent: controller!,
            curve: Interval(0, 0.1666, curve: Curves.easeOut)));

    animationRotation2 = Tween<double>(begin: -0.5, end: 0.5).animate(
        CurvedAnimation(
            parent: controller!,
            curve: Interval(0.1666, 0.3333, curve: Curves.easeInOut)));

    animationRotation3 = Tween<double>(begin: 0.5, end: -0.5).animate(
        CurvedAnimation(
            parent: controller!,
            curve: Interval(0.3333, 0.4999, curve: Curves.easeInOut)));

    animationRotation4 = Tween<double>(begin: -0.5, end: 0.4).animate(
        CurvedAnimation(
            parent: controller!,
            curve: Interval(0.4999, 0.6666, curve: Curves.easeInOut)));

    animationRotation5 = Tween<double>(begin: 0.4, end: -0.4).animate(
        CurvedAnimation(
            parent: controller!,
            curve: Interval(0.6666, 0.8333, curve: Curves.easeInOut)));

    animationRotation6 = Tween<double>(begin: -0.4, end: 0).animate(
        CurvedAnimation(
            parent: controller!,
            curve: Interval(0.8333, 1, curve: Curves.easeOut)));

    if (!widget.manualTrigger && widget.animate) {
      Future.delayed(widget.delay, () {
        if (!disposed) {
          (widget.infinite) ? controller!.repeat() : controller?.forward();
        }
      });
    }

    if (widget.controller is Function) {
      widget.controller!(controller!);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate && widget.delay.inMilliseconds == 0) {
      controller?.forward();
    }

    return AnimatedBuilder(
        animation: controller!,
        builder: (BuildContext context, Widget? child) {
          double angle = (animationRotation1.value != -0.5)
              ? animationRotation1.value
              : (animationRotation2.value != 0.5)
              ? animationRotation2.value
              : (animationRotation3.value != -0.5)
              ? animationRotation3.value
              : (animationRotation4.value != 0.4)
              ? animationRotation4.value
              : (animationRotation5.value != -0.4)
              ? animationRotation5.value
              : animationRotation6.value;

          return Transform.rotate(
            angle: angle,
            child: widget.child,
          );
        });
  }
}

class Spin extends StatefulWidget {
  final Key? key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final bool infinite;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;
  final double spins;

  Spin(
      {this.key,
        required this.child,
        this.duration = const Duration(milliseconds: 1000),
        this.delay = const Duration(milliseconds: 0),
        this.infinite = false,
        this.controller,
        this.manualTrigger = false,
        this.animate = true,
        this.spins = 1})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  _SpinState createState() => _SpinState();
}

class _SpinState extends State<Spin> with SingleTickerProviderStateMixin {
  AnimationController? controller;
  bool disposed = false;
  late Animation<double> spin;

  @override
  void dispose() {
    disposed = true;
    controller!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);

    spin = Tween<double>(begin: 0, end: widget.spins * 2)
        .animate(CurvedAnimation(parent: controller!, curve: Curves.easeInOut));

    if (!widget.manualTrigger && widget.animate) {
      Future.delayed(widget.delay, () {
        if (!disposed) {
          (widget.infinite) ? controller!.repeat() : controller?.forward();
        }
      });
    }

    if (widget.controller is Function) {
      widget.controller!(controller!);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate && widget.delay.inMilliseconds == 0) {
      controller?.forward();
    }

    return AnimatedBuilder(
        animation: controller!,
        builder: (BuildContext context, Widget? child) {
          return Transform.rotate(
            angle: spin.value * 3.1415926535,
            child: widget.child,
          );
        });
  }
}

class SpinPerfect extends StatefulWidget {
  final Key? key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final bool infinite;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;
  final double spins;

  SpinPerfect(
      {this.key,
        required this.child,
        this.duration = const Duration(milliseconds: 1000),
        this.delay = const Duration(milliseconds: 0),
        this.infinite = false,
        this.controller,
        this.manualTrigger = false,
        this.animate = true,
        this.spins = 1})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  _SpinPerfectState createState() => _SpinPerfectState();
}

class _SpinPerfectState extends State<SpinPerfect>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  bool disposed = false;
  late Animation<double> spin;

  @override
  void dispose() {
    disposed = true;
    controller!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);

    spin = Tween<double>(begin: 0, end: widget.spins * 2)
        .animate(CurvedAnimation(parent: controller!, curve: Curves.linear));

    if (!widget.manualTrigger && widget.animate) {
      Future.delayed(widget.delay, () {
        if (!disposed) {
          (widget.infinite) ? controller!.repeat() : controller?.forward();
        }
      });
    }

    if (widget.controller is Function) {
      widget.controller!(controller!);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate && widget.delay.inMilliseconds == 0) {
      controller?.forward();
    }

    return AnimatedBuilder(
        animation: controller!,
        builder: (BuildContext context, Widget? child) {
          return Transform.rotate(
            angle: spin.value * 3.141516,
            child: widget.child,
          );
        });
  }
}

class Dance extends StatefulWidget {
  final Key? key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final bool infinite;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;

  Dance(
      {this.key,
        required this.child,
        this.duration = const Duration(milliseconds: 1000),
        this.delay = const Duration(milliseconds: 0),
        this.infinite = false,
        this.controller,
        this.manualTrigger = false,
        this.animate = true})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  _DanceState createState() => _DanceState();
}

class _DanceState extends State<Dance> with SingleTickerProviderStateMixin {
  AnimationController? controller;
  bool disposed = false;
  late Animation<double> step1;
  late Animation<double> step2;
  late Animation<double> step3;

  @override
  void dispose() {
    disposed = true;
    controller!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);

    step1 = Tween<double>(begin: 0, end: -0.2).animate(CurvedAnimation(
        parent: controller!,
        curve: Interval(0, 0.3333, curve: Curves.bounceOut)));

    step2 = Tween<double>(begin: -0.2, end: 0.2).animate(CurvedAnimation(
        parent: controller!,
        curve: Interval(0.3333, 0.6666, curve: Curves.bounceOut)));

    step3 = Tween<double>(begin: 0.2, end: 0).animate(CurvedAnimation(
        parent: controller!,
        curve: Interval(0.6666, 1, curve: Curves.bounceOut)));

    if (!widget.manualTrigger && widget.animate) {
      Future.delayed(widget.delay, () {
        if (!disposed) {
          (widget.infinite) ? controller!.repeat() : controller?.forward();
        }
      });
    }

    if (widget.controller is Function) {
      widget.controller!(controller!);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate && widget.delay.inMilliseconds == 0) {
      controller?.forward();
    }

    return AnimatedBuilder(
        animation: controller!,
        builder: (BuildContext context, Widget? child) {
          final animation = (step1.value != -0.2)
              ? step1.value
              : (step2.value != 0.2)
              ? step2.value
              : step3.value;

          return Transform(
              alignment: FractionalOffset.center,
              transform: Matrix4.skew(0, animation),
              child: widget.child);
        });
  }
}

class Roulette extends StatefulWidget {
  final Key? key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final bool infinite;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;
  final double spins;

  Roulette(
      {this.key,
        required this.child,
        this.duration = const Duration(milliseconds: 3500),
        this.delay = const Duration(milliseconds: 0),
        this.infinite = false,
        this.controller,
        this.manualTrigger = false,
        this.animate = true,
        this.spins = 2})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  _RouletteState createState() => _RouletteState();
}

class _RouletteState extends State<Roulette>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  bool disposed = false;
  late Animation<double> spin;

  @override
  void dispose() {
    disposed = true;
    controller!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);

    spin = Tween<double>(begin: 0, end: widget.spins * 2).animate(
        CurvedAnimation(parent: controller!, curve: Curves.elasticOut));

    if (!widget.manualTrigger && widget.animate) {
      Future.delayed(widget.delay, () {
        if (!disposed) {
          (widget.infinite) ? controller!.repeat() : controller?.forward();
        }
      });
    }

    if (widget.controller is Function) {
      widget.controller!(controller!);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate && widget.delay.inMilliseconds == 0) {
      controller?.forward();
    }

    return AnimatedBuilder(
        animation: controller!,
        builder: (BuildContext context, Widget? child) {
          return Transform.rotate(
            angle: spin.value * 3.141516,
            child: widget.child,
          );
        });
  }
}