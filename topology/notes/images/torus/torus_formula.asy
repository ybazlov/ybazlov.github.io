settings.render = 8;
import graph3;
import three;

//include "torus_parameters.asy";

real varphi = 145;
real theta = 58;

size(14cm,0);
//currentprojection = perspective(0.3,-6,3);  // Set the viewing angle
// currentprojection = orthographic(0.3,-6,1);  // Set the viewing angle
currentprojection = orthographic(0,-1,0.2);  // Set the viewing angle

real R = 5.4;
real r = 1.8;
triple P = (R, 0, 0);
triple P1 = (R+r, 0, 0);
triple RP = rotate(varphi, Z)*P;
triple RP1 = rotate(varphi, Z)*P1;

draw( (-R-r-0.5,0,0) -- (R+r+2,0,0), gray(0.5)+0.125bp, Arrow3);
label("$x$", (R+r+1.5, 0, 0), align=NE);
draw( (0,0,0) -- (0,R+r+2,0), gray(0.5)+0.125bp, Arrow3);
label("$y$", (0, R+r+1.5, 0), align=NE);

triple Q0 = P + rotate(theta,-Y)*(r*X);
real u = (Q0.x - P.x)/r;
real v = Q0.z/r;
triple Q0minus = P + rotate(theta-1.0,-Y)*(r*X);
triple Q0plus = P + rotate(theta+1.0,-Y)*(r*X);
path3 myarc = arc(P, Q0plus, Q0minus, normal=-Y);

surface semitorus = surface(myarc, angle1=0, angle2=varphi, c=O, axis=Z, n=9);
//draw(semitorus, surfacepen=material(white+opacity(0.5), emissivepen=0.1*white), meshpen=gray(0.2));

path3 largecircle = arc(O, P, RP, normal=Z); //circle(O, R);
draw(largecircle, blue+0.75bp);
draw(myarc, red+0.75bp);
draw(rotate(varphi, Z)*myarc, red+0.75bp);
dot(O, blue+3bp);
dot(P, blue+3bp);
dot(RP, blue+4bp);
dot(rotate(varphi, Z)*P1, red+4bp);
//draw(O -- P, blue+0.5bp);
draw(O -- rotate(varphi, Z)*P, blue+0.5bp);
path3 myxradius = P -- P+r*X;
path3 myradius = P -- P+rotate(theta,-Y)*(r*X);
draw(myxradius, black+0.25bp);
draw(myradius, red+0.5bp);
draw(rotate(varphi,Z)*myxradius, black+0.25bp);
draw(rotate(varphi,Z)*myradius, red+0.5bp);

path3 sectorarrow = arc(O, X, rotate(varphi,Z)*X);
path3 sector = O -- sectorarrow -- cycle;
draw(surface(sector), blue+opacity(0.3));
draw(sectorarrow, blue+0.25bp, arrow=EndArcArrow3);
//label("$\varphi$", rotate(varphi/2,Z)*X, blue, align=NE);

path3 smallsectorarrow = arc(P, P+0.33*r*X, P+0.33*r*rotate(theta,-Y)*X);
path3 smallsector = P -- smallsectorarrow -- cycle;
draw(surface(smallsector), red+opacity(0.5));
draw(smallsectorarrow, red+0.25bp, arrow=EndArcArrow3);
draw(surface(rotate(varphi,Z)*smallsector), red+opacity(0.5));
draw(rotate(varphi,Z)*smallsectorarrow, red+0.25bp, arrow=EndArcArrow3);

triple Q = rotate(varphi,Z)*Q0;
dot(Q, green+4bp);
triple M = (R+r*u, 0, 0);
triple RM = rotate(varphi, Z)*M;

//triple L = (-R, R, 0);
//dot(L, 0.75*green+0.25*black+3bp);

//label("$\theta$", P + (0.66*r*X), red, align=N);
//label("$\theta$", rotate(varphi,Z)*(P + (0.66*r*X)), red, align=N);
//label("\boldmath$(0, 0, 0)$", O, blue, align=SW);
label("\boldmath$(R, 0, 0)$", P, blue, align=SW, Embedded);
draw(RP -- RM, magenta+2bp);
draw(RM -- Q, green+2bp);
dot(RM, magenta+4bp);
label( "\boldmath$((R+ru)x, (R+ru)y, 0)$", RM, magenta, align=SW, Embedded);
label("\boldmath$z=rv$", Q, 0.75*green+0.25*black, align=NW, Embedded);
draw(P -- M, magenta+2bp);
label("\boldmath$ru$", (R+r*u/2, 0, 0), magenta, align=S, Embedded);
draw(M -- Q0, green+2bp);
label("\boldmath$rv$", (R+r*u, 0, r*v/3), green, align=E, Embedded);
dot(M, magenta+4bp);
label("\boldmath$(R+ru, 0, 0)$", M, magenta, align=SE, Embedded);
