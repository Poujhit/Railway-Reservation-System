import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:universal_html/html.dart' as html;

import '../provider/auth.dart';

class HeadBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      floating: true,
      delegate: _SliverDelegate(
        child: Container(
          color: Theme.of(context).primaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Container(),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Railway Reservation System',
                    style: TextStyle(
                      fontSize: 27,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: RaisedButton(
                  onPressed: () async {
                    !Provider.of<Auth>(context, listen: false).isAuth
                        ? Provider.of<Auth>(context, listen: false).authenticate()
                        : Provider.of<Auth>(context, listen: false).signOut().then((_) {
                            html.window.location.reload();
                          });
                  },
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: EdgeInsets.all(6),
                        width: 35,
                        height: 35,
                        child: Image.asset(
                          'assets/images/google.png',
                        ),
                      ),
                      Provider.of<Auth>(context).isAuth
                          ? Text(
                              ' SIGN OUT  ',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            )
                          : Text(
                              ' SIGN IN WITH GOOGLE  ',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SliverDelegate implements SliverPersistentHeaderDelegate {
  _SliverDelegate({
    this.minHeight = 60.0,
    this.maxHeight = 70.0,
    @required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => maxHeight;
  @override
  double get minExtent => minHeight;
  @override
  bool shouldRebuild(_SliverDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight || minHeight != oldDelegate.minHeight || child != oldDelegate.child;
  }

  @override
  FloatingHeaderSnapConfiguration get snapConfiguration => null;
  @override
  OverScrollHeaderStretchConfiguration get stretchConfiguration => null;

  @override
  // TODO: implement showOnScreenConfiguration
  PersistentHeaderShowOnScreenConfiguration get showOnScreenConfiguration => null;

  @override
  // TODO: implement vsync
  TickerProvider get vsync => null;
}
