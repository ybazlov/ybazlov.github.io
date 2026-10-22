settings.render = 8;
import graph3;
import three;

size(12cm,0);  // Increase size for better clarity
currentprojection = perspective(10,8,6);  // Set the viewing angle

// Define the sphere
triple north_pole = (0, 0, 1);
triple south_pole = (0, 0, -1);

// Draw the unit sphere with a transparent surface
draw(unitsphere, surfacepen=gray(0.7)+opacity(0.7));

// Define the tangent plane at the south pole using the `surface` function
triple A = (-2, -2, -1);
triple B = (2, -2, -1);
triple C = (2, 2, -1);
triple D = (-2, 2, -1);
surface tangentPlane = surface(A--B--C--D--cycle);
draw(tangentPlane, surfacepen=gray(0.5)+opacity(0.3));

// Define a few sample points on the sphere to project
triple P1 = (2/3, 2/3, 1/3); // Sample point 1
triple P2 = (-0.680413817439772, 0.680413817439772, -0.272165526975909); // Sample point 2
triple P3 = (0.381000381000571, -0.889000889001333, -0.254000254000381);  // Sample point 3

// Corrected stereographic projection formula onto the plane z = -1
triple P1_proj = (2*P1.x / (1 - P1.z), 2*P1.y / (1 - P1.z), -1);
triple P2_proj = (2*P2.x / (1 - P2.z), 2*P2.y / (1 - P2.z), -1);
triple P3_proj = (2*P3.x / (1 - P3.z), 2*P3.y / (1 - P3.z), -1);

// Draw the projection lines from the north pole to the sample points and their projections
draw(north_pole -- P1, linetype(new real[] {4,2.66667})+red+linewidth(0.75));
draw(north_pole -- P2, linetype(new real[] {4,2.66667})+green+linewidth(0.75));
draw(north_pole -- P3, linetype(new real[] {4,2.66667})+blue+linewidth(0.75));
draw(P1 -- P1_proj, linetype(new real[] {3,2})+red+linewidth(1.0));
draw(P2 -- P2_proj, linetype(new real[] {3,2})+green+linewidth(1.0));
draw(P3 -- P3_proj, linetype(new real[] {3,2})+blue+linewidth(1.0));

// Draw the sample points on the sphere and their projections using heavier dots
real dot_size = 1.5;  // Define the size of heavier dots
draw(circle(P1, dot_size/100), red+linewidth(3)); label("$P_1$", P1, NE);
draw(circle(P2, dot_size/100), green+linewidth(3)); label("$P_2$", P2, NW);
draw(circle(P3, dot_size/100), blue+linewidth(3)); label("$P_3$", P3, SE);
draw(circle(P1_proj, dot_size/100), red+linewidth(3)); label("$P_1'$", P1_proj, S);
draw(circle(P2_proj, dot_size/100), green+linewidth(3)); label("$P_2'$", P2_proj, S);
draw(circle(P3_proj, dot_size/100), blue+linewidth(3)); label("$P_3'$", P3_proj, S);

// Draw and label the north and south poles with heavier dots
draw(circle(north_pole, dot_size/100), red+linewidth(3)); label("$N$", north_pole, NW);
draw(circle(south_pole, dot_size/100), blue+linewidth(3)); label("$S$", south_pole, SW);

// Optional: Add labels to the tangent plane and sphere
label("Tangent Plane", (1.5,1.5,-1), align=SE);
label("Unit Sphere", (0,0,1.2), align=N);

// Optional: Draw a coordinate grid on the tangent plane for better visualization
for(real i=-1.5; i<=1.5; i+=0.5) {
draw((i,-1.5,-1) -- (i,1.5,-1), gray+linewidth(0.5));
draw((-1.5,i,-1) -- (1.5,i,-1), gray+linewidth(0.5));
}
