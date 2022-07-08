import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
class Parent extends StatefulWidget {
  final Widget? child;
  final AppBar? appBar;
  final bool avoidBottomInset;
  final Widget? floatingButton;
  final Widget? bottomNavigation;
  final Widget? drawer;
  final Widget? endDrawer;
  final Color? backgroundColor;
  final Key? scaffoldKey;
  final bool extendBodyBehindAppBar;

  const Parent({
    Key? key,
    this.child,
    this.appBar,
    this.avoidBottomInset = true,
    this.floatingButton,
    this.backgroundColor,
    this.bottomNavigation,
    this.drawer,
    this.scaffoldKey,
    this.endDrawer,
    this.extendBodyBehindAppBar = false,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ParentState createState() => _ParentState();
}

class _ParentState extends State<Parent> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: OKToast(
        child: ScreenUtilInit(
           designSize: const Size(375, 667),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_,__) => Scaffold(
            key: widget.scaffoldKey,
            backgroundColor: widget.backgroundColor,
            resizeToAvoidBottomInset: widget.avoidBottomInset,
            extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
            appBar: widget.appBar,
            body: widget.child,
            drawer: widget.drawer,
            endDrawer: widget.endDrawer,
            floatingActionButton: widget.floatingButton,
            bottomNavigationBar: widget.bottomNavigation,
          ),
        ),
      ),
    );
  }
}