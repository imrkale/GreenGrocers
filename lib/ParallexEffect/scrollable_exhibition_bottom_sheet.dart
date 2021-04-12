import 'dart:math';
import 'dart:ui';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:greengrocers/userside/models/cart_item.dart';
import 'package:greengrocers/userside/provider/app.dart';
import 'package:greengrocers/userside/provider/user.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class ScrollableExhibitionSheet extends StatefulWidget {
  ScrollableExhibitionSheet({this.controller,this.tween});
  AnimationController controller;
  Tween<Offset> tween;
  @override
  _ScrollableExhibitionSheetState createState() =>
      _ScrollableExhibitionSheetState();
}
final _key = GlobalKey<ScaffoldState>();
class _ScrollableExhibitionSheetState extends State<ScrollableExhibitionSheet> {
  double initialPercentage = 0.15;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final app = Provider.of<AppProvider>(context);
    final List<Event> events = [];
    for(int i=0;i<user.userModel.cart.length;i++)
      {
        events.add(Event(user.userModel.cart[i]));
      }

    return Positioned.fill(
      child: SlideTransition(
        position: widget.tween.animate(widget.controller),
        child: DraggableScrollableSheet(
          minChildSize: initialPercentage,
          initialChildSize: initialPercentage,
          builder: (context, scrollController) {
            return AnimatedBuilder(
              animation: scrollController,
              builder: (context, child) {
                double percentage = initialPercentage;
                if (scrollController.hasClients) {
                  percentage = (scrollController.position.viewportDimension) /
                      (MediaQuery.of(context).size.height);
                }
                double scaledPercentage =
                    (percentage - initialPercentage) / (1 - initialPercentage);
                return Container(
                  padding: const EdgeInsets.only(left: 32),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [Colors.green,Colors.white]),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                  ),
                  child: Stack(
                    children: <Widget>[
                      Opacity(
                        opacity: percentage == 1 ? 1 : 0,
                        child: ListView.builder(
                          padding: EdgeInsets.only(right: 32, top: 128),
                          controller: scrollController,
                          physics: ScrollPhysics(),
                          itemCount: user.userModel.cart.length,
                          itemBuilder: (context, index) {
                            Event event = events[index];
                            return MyEventItem(
                              index:index,
                              user: user,
                              app: app,
                              event: event,
                              percentageCompleted: percentage,
                            );
                          },
                        ),
                      ),
                      ...events.map((event) {
                        int index = events.indexOf(event);
                        int heightPerElement = 120 + 8 + 8;
                        double widthPerElement =
                            40 + percentage * 80 + 8 * (1 - percentage);
                        double leftOffset = widthPerElement *
                            (index > 4 ? index + 2 : index) *
                            (1 - scaledPercentage);
                        return Positioned(
                          top: 44.0 +
                              scaledPercentage * (128 - 44) +
                              index * heightPerElement * scaledPercentage,
                          left: leftOffset,
                          right: 32 - leftOffset,
                          child: IgnorePointer(
                            ignoring: true,
                            child: Opacity(
                              opacity: percentage == 1 ? 0 : 1,
                              child: MyEventItem(
                                index:index,
                                user:user,
                                app:app,
                                event: event,
                                percentageCompleted: percentage,
                              ),
                            ),
                          ),
                        );
                      }),
                      SheetHeader(
                        fontSize: 14 + percentage * 8,
                        topMargin:
                            16 + percentage * MediaQuery.of(context).padding.top,
                      ),

                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class MyEventItem extends StatelessWidget {
  final Event event;
  final index;
  final double percentageCompleted;
  final UserProvider user;
  final AppProvider app;

  const MyEventItem({Key key,this.index,this.user,this.app, this.event, this.percentageCompleted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Transform.scale(
        alignment: Alignment.topLeft,
        scale: 1 / 3 + 2 / 3 * percentageCompleted,
        child: SizedBox(
          height: 120,
          child: Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(16),
                  right: Radius.circular(16 * (1 - percentageCompleted)),
                ),
                // child: Image.asset(
                //   '${event.cartItemModel.image}',
                //   width: 120,
                //   height: 120,
                //   fit: BoxFit.cover,
                // ),
                child: Image.network(
                  event.cartItemModel.image,
                  height: 120,
                  width: 120,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Opacity(
                  opacity: max(0, percentageCompleted * 2 - 1),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.horizontal(right: Radius.circular(16)),
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.all(8),
                    child: _buildContent(user,app),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(UserProvider user,AppProvider app) {
    return Column(
      children: <Widget>[
        Text(event.cartItemModel.name, style: TextStyle(
            color: Colors.black,
            fontSize: 20,fontFamily: 'SF Pro Display')),
        SizedBox(height: 1.0,),
        Row(
          children: <Widget>[
            Text(
              'Quantity',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
            SizedBox(width: 8),
            Text(
              "${event.cartItemModel.quantity}",
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Align(alignment:Alignment.topLeft,child: Text("Price ")),
            Align(alignment:Alignment.center,child: Text(" ${event.cartItemModel.price}",style: TextStyle(color: Colors.red),)),
            Padding(
              padding: const EdgeInsets.only(left:40.0),
              child: IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () async {
                    app.changeLoading();
                    bool value = await user.removeFromCart(
                        cartItem: user.userModel.cart[index]);
                    if (value) {
                      user.reloadUserModel();
                      Fluttertoast.showToast(
                          msg: "Item removed from basket!",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                      app.changeLoading();
                      return;
                    } else {
                      print("ITEM WAS NOT REMOVED");
                      app.changeLoading();
                    }
                  }),
            )
          ],
        ),

        Spacer(),
        Row(
          children: <Widget>[
            Icon(Icons.place, color: Color(0xFF162A49), size: 16),
            Text(
              '${event.cartItemModel.restaurant}, ',
              style: TextStyle(color: Colors.grey.shade400, fontSize: 13),
            ),
            Text(
              '${event.cartItemModel.areaname[0]}',
              style: TextStyle(color: Colors.grey.shade400, fontSize: 13),
            )
          ],
        )
      ],
    );
  }
}




class Event {

  final CartItemModel cartItemModel;

  Event(this.cartItemModel);
}

class SheetHeader extends StatelessWidget {
  final double fontSize;
  final double topMargin;

  const SheetHeader(
      {Key key, @required this.fontSize, @required this.topMargin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 32,
      child: IgnorePointer(
        child: Container(
          padding: EdgeInsets.only(top: topMargin, bottom: 12),
          child: Text(
            'Your Basket',
            style: TextStyle(
              color: Colors.white,
              fontSize: fontSize,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 12,
      bottom: 24,
      child: Icon(
        Icons.menu,
        color: Colors.white,
        size: 28,
      ),
    );
  }
}
