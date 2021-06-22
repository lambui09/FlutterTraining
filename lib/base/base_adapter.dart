import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/base/base_view.dart';

abstract class BaseAdapter<T> extends BaseViewStateLess {
  const BaseAdapter(this.items);

  final List<T> items;

  int getSize() => items.length;

  T getItem(int index) {
    return items[index];
  }

  Widget buildListItem(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return getSize() == 0 ? const SizedBox() : buildListItem(context);
  }
}

abstract class BaseItemCell<T> extends BaseViewStateLess {
  final T data;
  final Function(T)? onTap;

  const BaseItemCell(this.data, [this.onTap]);

  Widget buildItem(BuildContext context, T data);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap != null ? () => onTap!(data) : () {},
      child: buildItem(context, data),
    );
  }
}
