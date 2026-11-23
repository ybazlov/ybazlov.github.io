// Boy's surface: a smooth immersion of the real projective plane in R^3.
// Bryant-Kusner parametrization, with its removable poles cancelled.
//
// Still images (positive -render is useful for the translucent surface):
//   asy -f png -render 3 projective_plane.asy
//   asy -f pdf -render 3 projective_plane.asy
// Interactive view in recent Asymptote versions:
//   asy -f html projective_plane.asy
//
// The geometry has been checked analytically and numerically and rendered
// independently. This source has not been compiled in its authoring environment.

settings.prc=false;
settings.twosided=true;

import graph3;

size(680,680);

// ---------------- Appearance controls ----------------
bool showMesh=true;
bool showTriplePoint=false;
real surfaceOpacity=0.5;       // 1 gives an opaque surface
int meshIntervals=18;           // visual mesh density, independent of smoothness
int surfaceCells=64;            // surface sampling; keep even and >= 8
int curveSamples=360;

pen bodyColor=rgb(0.08,0.49,0.60);
pen meshColor=rgb(0.055,0.17,0.21)+opacity(0.40)+linewidth(0.28);

currentprojection=orthographic(camera=(5,-5,3.28),target=(0,0,-0.78));
currentlight=White;
currentlight.background=white;

material bodyMaterial=material(
  diffusepen=bodyColor + opacity(surfaceOpacity),
  emissivepen=0.08*bodyColor,
  specularpen=gray(0.25),
  opacity=surfaceOpacity,
  shininess=30);

// ---------------- The immersion ----------------
// A pair is a complex number in Asymptote; multiplication below is complex
// multiplication. The parameter z ranges over the CLOSED unit disk.
// On its boundary, boy(z)=boy(-z), giving the antipodal identification
// that turns the disk into RP^2. The immersion is regular at every point
// of RP^2, although distinct sheets intersect in its image in R^3.
//
// The usual formula first divides by D=z^6+sqrt(5)*z^3-1 and then applies
// inversion. At the three roots of D inside the disk those intermediate
// values are infinite. The algebraically equivalent formula below avoids
// division by D entirely. Its denominator K is >= 1/4 on the whole disk.
// The three roots of D inside the disk are the three preimages of the triple point O.

triple boy(pair z)
{
  pair z2=z*z;
  pair z3=z2*z;
  pair z4=z2*z2;
  pair z6=z3*z3;

  pair D=z6+sqrt(5)*z3-1;
  pair E=z6-sqrt(5)*z3-1;
  pair A=z*(1-z4);
  pair B=z*(1+z4);
  pair C=1+z6;

  pair AD=A*conj(D);
  pair BD=B*conj(D);
  pair CD=C*conj(D);
  pair ED=E*conj(D);
  real Q=abs2(D);

  triple M=(-1.5*AD.y,-1.5*BD.x,CD.y-0.5*Q);
  real K=0.5*(2.25*(abs2(A)+abs2(B))+abs2(C))
         -0.5*ED.x-CD.y+0.25*Q;

  return M/K;
}

// ---------------- Five regular parameter patches ----------------
// A central square and four surrounding sectors cover the disk exactly
// once, apart from shared edges. This avoids collapsed parameter rows
// at a polar center and keeps every patch regular even at its corners.
// No part of the disk is deleted, including the triple-point preimages.

real centralHalfSide=0.4;

pair outerDiskPatch(pair st)
{
  real s=st.x, t=st.y;
  real R=centralHalfSide+t*(1/sqrt(1+s*s)-centralHalfSide);
  return (R*s,R);
}

triple centerPatch(pair st) {return boy(centralHalfSide*st);}
triple topPatch(pair st)    {return boy(outerDiskPatch(st));}
triple leftPatch(pair st)   {return boy((0,1)*outerDiskPatch(st));}
triple bottomPatch(pair st) {return boy(-outerDiskPatch(st));}
triple rightPatch(pair st)  {return boy((0,-1)*outerDiskPatch(st));}

void drawPatch(triple f(pair), pair lo, pair hi, int nu, int nv)
{
  // Explicit nonperiodic end conditions in BOTH parameter directions.
  // Do not replace these arrays by automatic Spline: antipodal seam
  // identifications are not ordinary coordinatewise periodicity.
  splinetype[] openSpline={notaknot,notaknot,notaknot};
  surface s=surface(f,lo,hi,nu,nv,openSpline,openSpline);
  draw(s,surfacepen=bodyMaterial);
}

drawPatch(centerPatch,(-1,-1),(1,1),surfaceCells,surfaceCells);
drawPatch(topPatch,(-1,0),(1,1),surfaceCells,surfaceCells);
drawPatch(leftPatch,(-1,0),(1,1),surfaceCells,surfaceCells);
drawPatch(bottomPatch,(-1,0),(1,1),surfaceCells,surfaceCells);
drawPatch(rightPatch,(-1,0),(1,1),surfaceCells,surfaceCells);

// ---------------- A separate, coarser visual mesh ----------------
// This square-to-disk map is used only for drawing mesh curves. Its
// opposite boundary points become antipodal points on the disk boundary.
// Thus the mesh also illustrates the square model of the projective plane.
// Using a separate mesh lets surfaceCells increase without cluttering it.

pair squareToDisk(pair st)
{
  real s=st.x, t=st.y;
  return (s*sqrt(1-t*t/2),t*sqrt(1-s*s/2));
}

path3 meshTrack(real fixedCoordinate, bool horizontal)
{
  pair st=horizontal ? (-1,fixedCoordinate) : (fixedCoordinate,-1);
  guide3 g=boy(squareToDisk(st));
  for(int j=1; j<=curveSamples; ++j) {
    real u=-1+2.0*j/curveSamples;
    st=horizontal ? (u,fixedCoordinate) : (fixedCoordinate,u);
    g=g--boy(squareToDisk(st));
  }
  return g;
}

if(showMesh) {
  // Opposite outer edges have the same image, so draw only one of each pair.
  for(int i=0; i<meshIntervals; ++i) {
    real c=-1+2.0*i/meshIntervals;
    draw(meshTrack(c,true),meshColor);
    draw(meshTrack(c,false),meshColor);
  }
}

if(showTriplePoint)
  dot((0,0,0),rgb(0.9,0.16,0.045)+linewidth(5));

// Mathematical references for the original Bryant-Kusner formula:
// https://drorbn.net/AcademicPensieve/2013-04/nb/Boy.pdf
// https://www.science.smith.edu/~patela/boysurface/AmyJenny/other_boys.html
// The cancellation in boy() is an algebraic rewriting of that formula.
//
// Asymptote API references:
// https://asymptote.sourceforge.io/doc/graph3.html
// https://asymptote.sourceforge.io/doc/three.html
// https://asymptote.sourceforge.io/doc/Data-types.html
