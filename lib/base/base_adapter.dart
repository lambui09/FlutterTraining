abstract class BaseAdapter<T> {
  final List<T> dataList = [];

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
}
