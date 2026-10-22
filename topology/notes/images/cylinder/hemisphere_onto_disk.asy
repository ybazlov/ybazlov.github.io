settings.render = 8;
import graph3;
import three;
size(9cm,0);
currentprojection = perspective(1,5,1);  // Set the viewing angle

triple O = (0,0,0);
triple S = (0,0,-1);

// Define the hemisphere as before
path3 myarc = Arc(c=O, normal=X, v1=-Z, v2=Y, n=10);
path3 boundary1 = Arc(c=(0,0,0), normal=Z, v1=(1,0,0), v2=(-1,0,0), n=10);
path3 boundary2 = Arc(c=(0,0,0), normal=Z, v1=(-1,0,0), v2=(1,0,0), n=10);

surface backHemisphere = surface(myarc, angle1=0, angle2=180, c=O, axis=Z, n=10);
surface frontHemisphere = surface(myarc, angle1=180, angle2=360, c=O, axis=Z, n=10);

// Draw the hemisphere
draw(backHemisphere, surfacepen=material(white+opacity(0.8), emissivepen=0.1*white), meshpen=gray(0.2));
draw(frontHemisphere, surfacepen=material(white+opacity(0.8), emissivepen=0.1*white), meshpen=gray(0.2));
draw(boundary1, dashed+0.5bp);
draw(boundary2, dashed+0.5bp);

// Add the origin O
//draw(O--(0,0,0), invisible);
//dot(O, black);
//label("$O$", O, NE);

// Add the tangent unit disk at S = (0, 0, -1), with shading
surface tangentDisk = surface(S -- (1,0,-1), angle1=0, angle2=360, c=S, axis=Z, n=30);
draw(tangentDisk, surfacepen=material(white+opacity(0.5)), meshpen=gray(0.4));
draw(shift(0,0,-1)*circle(O,1), gray(0.35));

dot(S, black);
label("$S$", S, S);

// Add points P1, P2, and P3 on the hemisphere
triple P1 = (0.75,0,-sqrt(1-0.75^2));
//triple P2 = (-0.5,0.5,-sqrt(1-0.5^2-0.5^2));
triple P3 = (-0.6,0.7,-sqrt(1-0.6^2-0.7^2));

// Add rays OP1, OP2, OP3 and extend them
//draw(O--P1, red);
//draw(O--P2, blue);
//draw(O--P3, green);

// Orthogonal projection onto the tangent disk (plane z = -1)
triple project_to_disk(triple P) {
  return (P.x, P.y, -1);
}

triple P1_proj = project_to_disk(P1);
//triple P2_proj = project_to_disk(P2);
triple P3_proj = project_to_disk(P3);

draw(P1--P1_proj, red+dashed);
//draw(P2--P2_proj, blue+dashed);
draw(P3--P3_proj, green+dashed);

// Label the points
dot(P1, red);
//dot(P2, blue);
dot(P3, green);
label("$P_1$", P1, SW);
//label("$P_2$", P2, N);
label("$P_3$", P3, E);

// Label the projected points on the tangent unit disk
dot(P1_proj, red);
//dot(P2_proj, blue);
dot(P3_proj, green);
label("$P_1^{\\perp}$", P1_proj, SE);
//label("$P_2^{\\perp}$", P2_proj, SE);
label("$P_3^{\\perp}$", P3_proj, SE);
//label("\small tangent unit disk $z=-1$", (0,1.3,-1), SE);
