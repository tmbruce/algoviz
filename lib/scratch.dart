import 'dart:math';

Random random = Random();

void main() {
  List<int> arr = List<int>.generate(50, (index) => random.nextInt(1000));
  print(arr);

  void mergeSort(List<int> arr) {
    if (arr.length > 1) {
      int mid = (arr.length / 2).floor();
      List<int> L = [...arr.sublist(0, mid)];
      List<int> R = [...arr.sublist(mid)];
      mergeSort(L);
      mergeSort(R);
      int i = 0;
      int j = 0;
      int k = 0;
      while (i < L.length && j < R.length) {
        if (L[i] < R[j]) {
          arr[k] = L[i];
          i++;
        } else {
          arr[k] = R[j];
          j++;
        }
        k++;
      }
      while (i < L.length) {
        arr[k] = L[i];
        i++;
        k++;
      }
      while (j < R.length) {
        arr[k] = R[j];
        j++;
        k++;
      }
    }
  }

  mergeSort(arr);
  print(arr);
}
