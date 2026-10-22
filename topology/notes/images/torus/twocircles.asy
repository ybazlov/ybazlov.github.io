//include "torus_parameters.asy";

real varphi = 145;
real theta = 60;

pair O = (0,0);
pair C = (2.8,0);
pair X = (1,0);
size(8cm);

path leftcircle = circle(O, 1);
path rightcircle = circle(C, 1);

draw(leftcircle, blue+0.5bp);
pair P = rotate(varphi,O)*X;
draw(O -- X, black+0.25bp);
draw(O -- P, blue+0.5bp);
dot(P, blue+3bp);

label("$(x,y)$", P, blue, align=NW);

path sectorarrow = arc(O, scale(0.25)*X, scale(0.25)*P);
path sector = O -- sectorarrow -- cycle;
fill(sector, blue+opacity(0.3));
draw(sectorarrow, blue+0.25bp, arrow=EndArcArrow);
//label("$\varphi$", rotate(varphi/2,O)*scale(0.33)*X, blue, align=NE);

draw(rightcircle, red+0.5bp);
pair Q0 = rotate(theta,O)*X;
pair Q = C+Q0;;
draw(C -- C+X, black+0.25bp);
draw(C -- Q, red+0.5bp);
dot(Q, red+3bp);

path redsectorarrow = arc(C, C+scale(0.25)*X, C+scale(0.25)*Q0);
path redsector = C -- redsectorarrow -- cycle;
fill(redsector, red+opacity(0.3));
draw(redsectorarrow, red+0.25bp, arrow=EndArcArrow);
//label("$\theta$", C+rotate(theta/2,O)*scale(0.33)*X, red, align=NE);
label("$(u,v)$", Q, red, align=NE);
