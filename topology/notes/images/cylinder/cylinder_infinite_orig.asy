settings.render = 8;
import graph3;
import three;
size(7cm,0);
currentprojection = perspective(10,6,3);

real h = 1;      // half-height of the central, fully opaque part
real fade = 1.5;   // length of each fading end
int m = 12;      // number of fading slices per end

path3 circ = Circle(c=O, r=1, normal=Z, n=12);

// Surface slice between heights a and b with given opacity
void slice(real a, real b, real op) {
  path3 g = (1,0,a)--(1,0,b);
  surface t = surface(g, c=O, axis=Z, n=12);
  draw(t, surfacepen=material(white+opacity(op), emissivepen=0.1*white),
       meshpen=gray(0.2)+opacity(op), light=currentlight);
}

// central part
slice(-h, h, 0.7);
// fading ends
for (int i = 0; i < m; ++i) {
  real op = 0.7*(1 - (i+1)/m);
  real d = fade/m;
  slice(h + i*d, h + (i+1)*d, op);
  slice(-h - (i+1)*d, -h - i*d, op);
}

// boundary circles of the central part
draw(shift(h*Z)*circ);
draw(shift(-h*Z)*circ);

// arrows indicating continuation to infinity
draw((0,0,h+fade+0.2)--(0,0,h+fade+0.8), Arrow3(size=6));
draw((0,0,-h-fade-0.2)--(0,0,-h-fade-0.8), Arrow3(size=6));
