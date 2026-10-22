//
// trefoil.asy
// 
// to get trefoil.png, run
// asy -f png -render=4 trefoil.asy
// 
// to view it in internal Asymptote 3d-viewer, run
// asy -V trefoil.asy
//
// or, to get an interactive 3D vector WebGL graphics,
//    embedded within HTML file trefoil.html, run
// asy -f html trefoil.asy

//
import graph3;
import tube;

settings.render = 8;
size(200,0);
currentlight.background=paleyellow+opacity(0.0);
currentprojection=orthographic(camera=(-40,9,70), up=Z);

real x(real t){return sin(t)+2sin(2t);}
real y(real t){return cos(t)-2cos(2t);}
real z(real t){return -sin(3t);}

guide3 g=graph(x,y,z, 0, 2pi,operator..);

draw(tube(g,circle((0,0),0.2)),white);
