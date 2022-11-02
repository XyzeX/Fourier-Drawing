class Complex {
  float re;
  float im;
  
  public Complex(float a, float b) {
    this.re = a;
    this.im = b;
  }
  
  public void add(Complex c) {
    this.re += c.re;
    this.im += c.im;
  }
  
  public Complex mult(Complex c) {
    final float re = this.re * c.re - this.im * c.im;
    final float im = this.re * c.im + this.im * c.re;
    return new Complex(re, im);
  }
}
