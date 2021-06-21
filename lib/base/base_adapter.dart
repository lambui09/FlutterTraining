import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/base/base_view.dart';

abstract class BaseAdapter<T> {
  final List<T> dataList = [];

  int getSize() => dataList.length;

  void setData(List<T> list) {
    dataList.clear();
    dataList.addAll(list);
  }

  void addData(List<T> list) {
    dataList.addAll(list);
  }

  T? getItem(int index) {
    if (index < 0 || index >= dataList.length) {
      return null;
    }
    return dataList[index];
  }

  Widget renderUI(BuildContext context);
}

abstract class BaseItemCell<T> extends BaseViewStateLess {
  final T data;
  final Function(T)? onTap;

  BaseItemCell(this.data, [this.onTap]);

  Widget renderUI(BuildContext context, T data);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap != null ? () => onTap!(data) : () {},
      child: renderUI(context, data),
    );
  }
}
