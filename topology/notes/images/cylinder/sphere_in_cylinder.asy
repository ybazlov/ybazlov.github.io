import three;
import graph3;
size(10cm);

// viewing angle
currentprojection = perspective(6,4,3);

// parameters
real R = 1;              // sphere radius and cylinder radius
real ztop = 1.4;         // top of drawn cylinder
real zbot = -1.4;        // bottom of drawn cylinder

// helper to draw a latitude circle on the sphere at height z (|z|<1)
void lat(real z, pen p=currentpen, real opacity=1) {
  real r = sqrt(max(0,1 - z*z));
  // unitcircle in xy-plane scaled to radius r and shifted to z
  draw(shift(0,0,z)*scale(r)*unitcircle, p+opacity(opacity));
}

// helper to draw a meridian at angle theta (0..360)
void mer(real theta, pen p=currentpen, real opacity=1) {
  // make a path3 by sampling points on the meridian in the xz-plane, then rotate about z
  path3 merpath;
  int N = 80;
  for (int i = 0; i <= N; ++i) {
    real phi = -80 + 160*(i/(real)N); // avoid poles at ±90
    real z = sin(phi*pi/180);
    real r = cos(phi*pi/180); // sqrt(1-z^2)
    triple pt = (r*cos(theta*pi/180), r*sin(theta*pi/180), z);
    if (i==0) merpath = merpath -- pt;
    else merpath = merpath -- pt;
  }
  draw(merpath, p+opacity(opacity));
}

// Draw the sphere (many latitudes and meridians), but omit the poles (open sphere)
for (real z = -0.85; z <= 0.85; z += 0.15) {
  lat(z, gray+0.6bp, 0.9);
}
for (real theta = 0; theta < 360; theta += 20) {
  mer(theta, gray+0.6bp, 0.9);
}

// Draw the cylinder of radius 1 about z-axis (shaded, semi-transparent)
pen cylpen = black+0.8bp;
filldraw(shift(0,0,ztop)*scale(R,R,0.2)*unitcircle, lightcyan+opacity(0.25), cylpen+dashed);
filldraw(shift(0,0,zbot)*scale(R,R,0.2)*unitcircle, lightcyan+opacity(0.25), cylpen+dashed);
// side as two visible vertical segments and dashed back
draw( (R,0,zbot) -- (R,0,ztop), cylpen );
draw( (-R,0,zbot) -- (-R,0,ztop), cylpen );
draw( (0,R,zbot) -- (0,R,ztop), cylpen+dashed );
draw( (0,-R,zbot) -- (0,-R,ztop), cylpen+dashed );

// Shade the lateral surface slightly (approximate by many vertical segments)
for (real ang = 0; ang < 360; ang += 6) {
  triple p1 = (R*cos(ang*pi/180), R*sin(ang*pi/180), zbot);
  triple p2 = (R*cos(ang*pi/180), R*sin(ang*pi/180), ztop);
  draw(p1 -- p2, lightcyan+0.3bp+opacity(0.35));
}

// Mark origin O
triple O = (0,0,0);
dot(O, black); label("$O$", O, SW);

// Mark (removed) north and south poles as small open circles (not drawn on sphere)
triple N = (0,0,1), S = (0,0,-1);
draw(shift(N)*scale(0.06)*unitcircle, black+0.8bp); label("$N$", N, N);
draw(shift(S)*scale(0.06)*unitcircle, black+0.8bp); label("$S$", S, S);

// Choose a few sample points P on the sphere (avoid poles). We'll show their images P' on the cylinder.
pair[] samples2d = new pair[3];
real[] zvals = { 0.6, 0.0, -0.4 };
real[] thetas = { 40, 200, 320 }; // degrees

for (int i = 0; i < 3; ++i) {
  real z = zvals[i];
  real theta = thetas[i];
  real r = sqrt(1 - z*z);       // radius of latitude
  triple P = ( r*cos(theta*pi/180), r*sin(theta*pi/180), z );
  // compute t so that t*P lies on cylinder x^2+y^2 = 1 : t = 1 / sqrt(x^2+y^2) = 1/r
  real t = 1.0 / r;
  triple Pp = t * P; // image on cylinder
  
  // draw point P and a small dot
  dot(P, red+2bp);
  label("$P_"+string(i+1)+"$", P, dir(120));

  // draw ray from O through P to P'
  draw(O -- Pp, orange+0.9bp, Arrow3(size=6)); // arrow shows direction outward
  // mark P' on the cylinder
  dot(Pp, blue+2bp);
  label("$P'_"+string(i+1)+"$", Pp, dir(-20));

  // draw short segment on the sphere to highlight P location
  draw(shift(P)*scale(0.08)*unitcircle, red+0.6bp);
  
  // draw vertical projection from P' down to z-plane for clarity (dashed)
  draw(Pp -- (Pp.x, Pp.y, 0), dashed+gray);
}

// Add explanatory labels
label(rotate(0)*"Unit sphere $S\setminus\{N,S\}$", (0, -1.35, 1.25), fontsize(10));
label(rotate(0)*"Cylinder $C=\{(x,y,z):x^2+y^2=1\}$", (2.2, -0.6, 1.3), fontsize(10));

// A legend
guide g = (3.2,-1.1,1.3) -- (4.2,-1.1,1.3);
draw(g, invisible);
label("$P\\mapsto P'$ (radial projection)", (3.8,-1.1,1.3), fontsize(8));
