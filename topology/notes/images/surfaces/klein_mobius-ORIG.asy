// A smooth, bottle-shaped Klein immersion with two disjoint Mobius bands.
//
// Render a still image:
//   asy -f png -render 3 klein_mobius.asy
//   asy -f pdf -render 3 klein_mobius.asy
// Interactive view (recent Asymptote versions):
//   asy -f html klein_mobius.asy
// Use positive -render for the translucent, self-intersecting surface.
//
// This file uses native Asymptote 3D surfaces. The geometry was checked
// analytically and numerically and previewed independently; the file has
// not been compiled in the environment in which it was written.

settings.prc=false;
settings.twosided=true;

import graph3;

size(620,720);

currentprojection=orthographic(4,-7,2.8);
currentlight=White;
currentlight.background=white;

// ---------------- Appearance controls ----------------
bool showBody=true;             // false: display just the two Mobius bands
bool showMesh=true;
bool showBandBoundaries=true;

real bodyOpacity=0.12;
real bandOpacity=0.96;
real bandHalfWidth=0.28;         // radians; keep this small
int longitudinalCells=80;

pen bandOrange=rgb(0.96,0.31,0.055);
pen bandBlue=rgb(0.035,0.28,0.77);
pen bodyColor=rgb(0.64,0.75,0.84);
pen wire=rgb(0.12,0.19,0.25)+opacity(0.40)+linewidth(0.32);

// ---------------- Bottle geometry ----------------
// Start with a planar cusped directrix
// C(u)=(a(1-cos u), b sin u(1-cos u), 0).
// Its unit normal extends smoothly through the cusp after cancelling
// the vanishing scalar factor in C'(u). The extended normal reverses
// after one circuit. A periodic radius r(u)=r0-r1 sin u closes the surface.
//
// Output coordinates are (old y, depthScale*old z, old x), putting the
// bottle upright. The depth scaling makes the small double curve close
// to a round circle (about 3.7 units across, against a height about 46).

real a=20;
real b=8;
real r0=5.5;
real r1=4.5;
real depthScale=1.47;

triple klein(pair uv)
{
  real u=uv.x, v=uv.y;
  real cu=cos(u), su=sin(u);

  // C'(u)=2 sin(u/2)*(dx,dy,0). This cancelled expression also works
  // at u=0 and u=2pi, so there is no division by zero at the seam.
  real dx=a*cos(u/2);
  real dy=b*sin(u/2)*(1+2*cu);
  real lengthD=sqrt(dx*dx+dy*dy);
  real nx=-dy/lengthD, ny=dx/lengthD;

  real radius=r0-r1*su;
  real oldx=a*(1-cu)+radius*nx*cos(v);
  real oldy=b*su*(1-cu)+radius*ny*cos(v);
  real oldz=radius*sin(v);

  return (oldy,depthScale*oldz,oldx);
}

// Seam: klein((2pi,v)) = klein((0,pi-v)), with v taken modulo 2pi.
// Near v0=pi/2 or 3pi/2, write v=v0+s. The seam sends s to -s.
// Thus each colored strip is a Mobius band, not an annulus.
// Orange lies in y>0, blue in y<0, so their images are disjoint.
//
// Regularity at the chosen constants:
// r>=1; away from r'=0 the radial derivative ensures rank 2.
// At u=pi/2,3pi/2, |r*kappa|<=0.161<1, so rank is still 2.
// At the cusp r'=-4.5 is nonzero. The seam is smooth to every order.

material bodyMaterial=material(
  diffusepen=bodyColor,
  emissivepen=0.08*bodyColor,
  specularpen=gray(0.25),
  opacity=bodyOpacity,
  shininess=24);

material orangeMaterial=material(
  diffusepen=bandOrange,
  emissivepen=0.10*bandOrange,
  specularpen=gray(0.25),
  opacity=bandOpacity,
  shininess=30);

material blueMaterial=material(
  diffusepen=bandBlue,
  emissivepen=0.10*bandBlue,
  specularpen=gray(0.25),
  opacity=bandOpacity,
  shininess=30);

void drawRegion(real vmin, real vmax, int transverseCells, material m)
{
  // Explicit nonperiodic cubic splines, one for each output coordinate.
  // The generic Spline option can select periodic end conditions, but
  // this parameter rectangle closes with v -> pi-v, not v -> v.
  // Specify BOTH directions so neither uses automatic periodic detection.
  splinetype[] openSpline={notaknot,notaknot,notaknot};
  surface s=surface(klein,(0,vmin),(2*pi,vmax),
                    longitudinalCells,transverseCells,
                    openSpline,openSpline);
  draw(s,surfacepen=m,meshpen=showMesh ? wire : nullpen,
       meshlight=nolight);
}

real p=pi/2;
real q=3*pi/2;
real w=bandHalfWidth;

// Partition the surface: no gray surface is hidden beneath a colored
// strip. This avoids coincident polygons and depth-buffer flicker.
if(showBody) {
  drawRegion(0,p-w,8,bodyMaterial);
  drawRegion(p+w,q-w,16,bodyMaterial);
  drawRegion(q+w,2*pi,8,bodyMaterial);
}
drawRegion(p-w,p+w,4,orangeMaterial);
drawRegion(q-w,q+w,4,blueMaterial);

path3 parameterTrack(real v)
{
  int n=4*longitudinalCells;
  guide3 g=klein((0,v));
  for(int i=1; i<=n; ++i)
    g=g--klein((2*pi*i/n,v));
  return g;
}

if(showBandBoundaries) {
  pen orangeBoundary=rgb(0.47,0.095,0.015)+linewidth(0.85);
  pen blueBoundary=rgb(0.015,0.10,0.32)+linewidth(0.85);

  // For each band these two tracks join at the parameter seam and
  // together form its ONE boundary circle.
  draw(parameterTrack(p-w),orangeBoundary);
  draw(parameterTrack(p+w),orangeBoundary);
  draw(parameterTrack(q-w),blueBoundary);
  draw(parameterTrack(q+w),blueBoundary);
}

// Construction background: G. Franzoni, "The Klein bottle in its
// classical shape: a further step towards a good parametrization",
// arXiv:0909.5354, section 3. The periodic radius and cancelled normal
// used here are a modification of that tube construction.
//
// Asymptote API references:
// https://asymptote.sourceforge.io/doc/graph3.html
// https://asymptote.sourceforge.io/doc/three.html
