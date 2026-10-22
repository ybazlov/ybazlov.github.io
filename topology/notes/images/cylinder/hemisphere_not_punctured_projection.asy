settings.render = 8;
import graph3;
import three;
size(9cm,0);
currentprojection = perspective(5,3,3);  // Set the viewing angle


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
triple O = (0,0,0);
draw(O--(0,0,0), invisible);
dot(O, black);
label("$O$", O, NE);
surface unitcirclesurface = surface(O -- (1,0,0), angle1=0, angle2=360, c=O, axis=Z, n=20);

// Add the tangent plane at S = (0, 0, -1), with shading
triple S = (0,0,-1);
surface tangentPlane = shift(0,0,-1)*scale(2,2,0)*unitcirclesurface;
draw(tangentPlane, surfacepen=material(white+opacity(0.5)), meshpen=gray(0.4));

// Add a polar coordinate grid on the tangent plane for better visual representation
for (real r=0.5; r<=2; r+=0.5) {
  draw(shift(0,0,-1)*circle(O,r), gray(0.4)+linewidth(0.125bp)); // Circles for radial grid
}
//for (real theta=0; theta<360; theta+=30) {
//  draw(shift(0,0,-1)*scale(2)*rotate(theta,Z)*((-1,0,0)--(1,0,0)), gray+opacity(0.5)); // Radial lines
//}

dot(S, black);
label("$S$", S, S);

// Add points P1, P2, and P3 on the hemisphere
triple P1 = (0.75,0,-sqrt(1-0.75^2));
triple P2 = (-0.5,0.5,-sqrt(1-0.5^2-0.5^2));
triple P3 = (-0.2,-0.7,-sqrt(1-0.2^2-0.7^2));

// Add rays OP1, OP2, OP3 and extend them
draw(O--P1, red);
draw(O--P2, blue);
draw(O--P3, green);

// Extend the rays beyond P1, P2, P3 to intersect the tangent plane at z = -1
triple extend_to_plane(triple P) {
  real scale_factor = (-1 - O.z) / (P.z - O.z);
  return O + scale_factor * (P - O);
}

triple P1_ext = extend_to_plane(P1);
triple P2_ext = extend_to_plane(P2);
triple P3_ext = extend_to_plane(P3);

draw(P1--P1_ext, red+dashed);
draw(P2--P2_ext, blue+dashed);
draw(P3--P3_ext, green+dashed);

// Label the points
dot(P1, red);
dot(P2, blue);
dot(P3, green);
label("$P_1$", P1, N);
label("$P_2$", P2, N);
label("$P_3$", P3, N);

// Label the extended points on the tangent plane
dot(P1_ext, red);
dot(P2_ext, blue);
dot(P3_ext, green);
label("$P_1^{ext}$", P1_ext, SE);
label("$P_2^{ext}$", P2_ext, SE);
label("$P_3^{ext}$", P3_ext, SE);
//label("\small the open hemisphere", (-2.4,0,0), SE); 
label("\small the plane $z=-1$", (0,2,-1), SE); 
