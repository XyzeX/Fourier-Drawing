public ArrayList dft(ArrayList<Complex> x) {
  ArrayList<FloatList> X = new ArrayList<FloatList>();
  final int N = x.size();
  
  for (int k = 0; k < N; k++) {
    Complex sum = new Complex(0, 0);
    
    for (int n = 0; n < N; n++) {
      final float phi = (TWO_PI * k * n) / N;
      final Complex c = new Complex(cos(phi), -sin(phi));
      sum.add(x.get(n).mult(c));
    }
    sum.re = sum.re / N;
    sum.im = sum.im / N;

    final int freq = k;
    final float amp = sqrt(sum.re * sum.re + sum.im * sum.im);
    final float phase = atan2(sum.im, sum.re);
    final FloatList temp = new FloatList(sum.re, sum.im, freq, amp, phase);
    X.add(temp);
  }
  return X;
}
