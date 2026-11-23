// Mobius band (one half-twist) -- one of three matched meshed bands.
// Self-contained: only the standard graph3 module is needed.
//
//   asy -f png -render 3 moebius_band.asy
//   asy -f pdf -render 3 moebius_band.asy
//   asy -f html moebius_band.asy
//
// The same radius, width, style, camera, and invisible framing box are
// used in cylinder.asy, moebius_band.asy, and double_twist_band.asy.
// The only geometric difference between them is halfTwists = 0, 1, or 2.
// Geometry checked and previewed independently; not compiled here.

settings.prc=false;
settings.twosided=true;

import graph3;

size(640,480);
currentprojection=orthographic(camera=(6,-8,6),target=(0,0,0),center=false);
currentlight=White;
currentlight.background=white;

// ---------------- Geometry and appearance ----------------
int halfTwists=1;              // 180 degrees of twist
real radius=2.2;                 // radius of the common circular centerline
real halfWidth=0.65;             // total strip width = 1.30; keep < radius

bool showMesh=true;
bool showBoundary=true;
real surfaceOpacity=0.80;

int surfaceCells=128;            // surface smoothness along the circle
int widthCells=8;
int meshAround=64;               // visible transverse mesh lines
int meshAcross=8;                // visible intervals across the strip
int curveSamples=512;

//pen bodyColor=rgb(0.08,0.49,0.60);
pen bodyColor=rgb(0.44,0.74,0.80);
//pen meshColor=rgb(0.055,0.17,0.21)+opacity(0.50)+linewidth(0.28);
pen meshColor=rgb(0.055,0.17,0.21)+opacity(0.80)+linewidth(0.5);
//pen boundaryColor=rgb(0.035,0.16,0.20)+linewidth(0.90);
pen boundaryColor=rgb(0.8,0.16,0.20)+linewidth(0.90);

material bodyMaterial=material(
  diffusepen=bodyColor + opacity(surfaceOpacity),
  emissivepen=0.08*bodyColor,
  specularpen=gray(0.25),
  opacity=surfaceOpacity,
  shininess=30);

// ---------------- The parametrization ----------------
// u runs from 0 to 2pi, v from -halfWidth to halfWidth.
// The width direction rotates through halfTwists*pi in one circuit.
// At halfTwists=0 this is exactly the side of a circular cylinder;
// the cylinder's two ends are open.
//
// band((2pi,v)) = band((0,(-1)^halfTwists*v)).
// Thus one half-twist gives a Mobius band with ONE boundary component;
// zero or two half-twists give an annulus with TWO boundary components.
// Since radius > halfWidth, all three surfaces are embedded in R^3.

triple band(pair uv)
{
  real u0=uv.x, v=uv.y;
  // YB:
  real u = pi*(1+sin((u0-pi)/2));	
  //
  real angle=halfTwists*u/2;
  real r=radius+v*sin(angle);
  return (r*cos(u0),r*sin(u0),v*cos(angle));
}

// Both spline directions are explicitly nonperiodic. This retains the
// fix for the "function values are not periodic" error: the Mobius seam
// reverses v, rather than closing each fixed-v curve separately.
splinetype[] openSpline={notaknot,notaknot,notaknot};

surface s=surface(band,(0,-halfWidth),(2*pi,halfWidth),
                  surfaceCells,widthCells,openSpline,openSpline);
draw(s,surfacepen=bodyMaterial);

// ---------------- Mesh and boundary ----------------
// Keep the visible mesh independent of the surface interpolation density.
path3 alongBand(real v)
{
  guide3 g=band((0,v));
  for(int j=1; j<=curveSamples; ++j)
    g=g--band((2*pi*j/curveSamples,v));
  return g;
}

if(showMesh) {
  // Omit u=2pi: its transverse segment is the same geometric seam as u=0.
  for(int i=0; i<meshAround; ++i) {
    real u=2*pi*i/meshAround;
    draw(band((u,-halfWidth))--band((u,halfWidth)),meshColor);
  }
  // Boundary curves are drawn separately with a heavier pen.
  for(int j=1; j<meshAcross; ++j) {
    real v=-halfWidth+2*halfWidth*j/meshAcross;
    draw(alongBand(v),meshColor);
  }
}

if(showBoundary) {
  // For one half-twist these two tracks join into a SINGLE closed curve.
  // For zero or two half-twists they are two separate closed curves.
  draw(alongBand(-halfWidth),boundaryColor);
  draw(alongBand(halfWidth),boundaryColor);
}

// ---------------- Identical framing in all three files ----------------
// A completely transparent box contributes common bounds but is not visible.
// This prevents automatic fitting from enlarging the individual surfaces
// by different factors. Keep this block identical when juxtaposing outputs.
// The chosen box contains all three surfaces, with a little extra space.
real frameRadius=radius+halfWidth+0.15;
real frameHeight=halfWidth+0.25;
//YB// draw(box((-frameRadius,-frameRadius,-frameHeight), (frameRadius,frameRadius,frameHeight)), white+opacity(0)+linewidth(0));

// Standard Asymptote APIs:
// https://asymptote.sourceforge.io/doc/graph3.html
// https://asymptote.sourceforge.io/doc/three.html

