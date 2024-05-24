void shell(int a[],int n) {
    int gap = 1;
    while (gap < n) {
        gap = gap * 2;
    }
    gap = (gap/2) - 1;
    while (gap > 1) {
        gap = 1;
    }
  for (int p = gap; p < n; p++)
  {
    int x = a[p];
    int i = p - gap;
    while (i >= 0 && x < a[i])
    {
      a[i + gap] = a[i];
      i--;
    }
    a[i + gap] = x;
  }
  gap = gap / 2;
}




