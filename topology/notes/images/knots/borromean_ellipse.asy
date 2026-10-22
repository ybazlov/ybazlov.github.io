import graph3;
import tube;

// Set the size and background
size(200, 0);
currentlight.background = paleyellow + opacity(0.0);
// currentprojection = orthographic(camera=(-40, 9, 70), up=Z);
currentprojection = perspective(camera=(-40, 9, 70), up=Z);

// Define the parameters for the elliptical rings
real major_radius = 1.0;      // Major radius of the ellipses
real minor_radius = 0.7;      // Minor radius for deformation
real tube_radius = 0.1;       // Radius of the tubes
int n = 500;                  // Number of points for smoothness

// Parametric equations for deformed ellipses in different planes
triple ellipse1(real t) { return (major_radius * cos(t), minor_radius * sin(t), 0); }
triple ellipse2(real t) { return (0, major_radius * cos(t), minor_radius * sin(t)); }
triple ellipse3(real t) { return (minor_radius * sin(t), 0, major_radius * cos(t)); }

// Define the three rings using smooth elliptical loops
guide3 ring1 = graph(ellipse1, 0, 2pi, n);
guide3 ring2 = graph(ellipse2, 0, 2pi, n);
guide3 ring3 = graph(ellipse3, 0, 2pi, n);

// Draw the three rings using the tube() function and color them distinctly
draw(tube(ring1, circle((0,0), tube_radius)), red);    // Red elliptical ring
draw(tube(ring2, circle((0,0), tube_radius)), green);  // Green elliptical ring
draw(tube(ring3, circle((0,0), tube_radius)), blue);   // Blue elliptical ring
