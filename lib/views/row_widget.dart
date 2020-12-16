import 'package:flutter/material.dart';

class Item {
  const Item(this.value, {this.name, this.icon});
  @required
  final String name;
  @required
  final Widget icon;
  final int value;

  @override
  bool operator ==(dynamic other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    final Item typedOther = other;
    return typedOther.name == name && typedOther.icon == icon;
  }

  @override
  int get hashCode => hashValues(name, icon);

  @override
  String toString() {
    return '$runtimeType($name)';
  }
}

class _RowItem extends StatelessWidget {
  const _RowItem({
    Key key,
    this.category,
    this.onTap,
  }) : super(key: key);

  final Item category;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return new RepaintBoundary(
        child: new Container(
      alignment: Alignment.center,
      child: new RawMaterialButton(
        padding: EdgeInsets.zero,
        splashColor: theme.primaryColor.withOpacity(0.12),
        highlightColor: Colors.transparent,
        onPressed: onTap,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Padding(
              padding: EdgeInsets.zero,
              child: category.icon,
            ),
            const SizedBox(height: 5.0),
            new Container(
              // height: 48.0,
              alignment: Alignment.center,
              child: new Text(
                category.name,
                textAlign: TextAlign.center,
                style: theme.textTheme.subtitle1.copyWith(
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

class RowWidget extends StatelessWidget {
  const RowWidget({
    Key key,
    this.items,
    this.callBack,
  }) : super(key: key);

  final Iterable<Item> items;
  final ValueChanged<Item> callBack;

  @override
  Widget build(BuildContext context) => new GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        primary: false,
        childAspectRatio: 1.2,
        children: items.map((item) {
          return new SizedBox(
            child: new _RowItem(
              category: item,
              onTap: () {
                callBack(item);
              },
            ),
          );
        }).toList(),
      );
}
