void main() {
  String rutClean = '555555555';
  String dv = rutClean.substring(rutClean.length - 1);
  String rutBodyStr = rutClean.substring(0, rutClean.length - 1);
  int rutBody = int.parse(rutBodyStr);
  int m = 0, s = 1;
  for (; rutBody != 0; rutBody ~/= 10) {
    s = (s + rutBody % 10 * (9 - m++ % 6)) % 11;
  }
  String expectedDv = s > 0 ? (s - 1).toString() : 'K';
  print('dv: $dv, expected: $expectedDv');
}
