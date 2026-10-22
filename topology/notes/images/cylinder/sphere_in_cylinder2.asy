import three;
import graph3;
import solids;
size(10cm);
settings.render = 4;
currentprojection = perspective(2,-2,1);

// Parameters
real R = 1;
real ztop = 1.5, zbot = -1.5;

// Draw the sphere (omitting poles)
surface sph = surface(sphere(O, R));
draw(sph, surfacepen=material(white+opacity(0.5)), meshpen=gray(0.3));

// Draw the cylinder
surface cyl = shift(0,0,zbot)*scale(1,1,ztop-zbot)*unitcylinder;
draw(cyl, surfacepen=material(lightcyan+opacity(0.2)), meshpen=gray(0.3));


// Mark origin and poles
triple O = (0,0,0);
dot(O, black); label("$O$", O, SW);
triple N = (0,0,1), S = (0,0,-1);
draw(circle(N,0.04,Z), black+0.8bp); label("$N$", N, N);
draw(circle(S,0.04,Z), black+0.8bp); label("$S$", S, S);

// Sample points on sphere
real[] zvals = {0.7, -0.5};
real[] thetas = {20, 0};

for (int i=0; i < zvals.length; ++i) {
  real z = zvals[i];
  real theta = thetas[i];
  real r = sqrt(1 - z*z);
  triple P = (r*cos(theta*pi/180), r*sin(theta*pi/180), z);
  real t = 1/r;                  // radial projection factor
  triple Pp = t*P;               // intersection with cylinder

  draw(O -- Pp, orange+1bp, Arrow3(size=6));
  dot(P, red+2bp); label("$P_"+string(i+1)+"$", P, dir(90));
  dot(Pp, blue+2bp); label("$P'_"+
      string(i+1)+"$", Pp, dir(-20));
}

triple P3 = (0, -1, 0);
draw(O -- P3, orange+1bp, Arrow3(size=6));
label("$P_3=P_3'$", P3, dir(-90));
draw(circle(O, 1.0, Z), black+1.5bp);
dot(P3, red+2bp);
// Labels
// label("Sphere $S\\setminus\\{N,S\}$", (0,-1.5,1.1), fontsize(10));
// label("Cylinder $C$", (2.2,-0.5,1.1), fontsize(10));
