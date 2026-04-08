use <Customizable-Easter-Egg-Library.scad>

Rendering_Type="Whole Egg";// [Whole Egg, Two Halves, Demo]
// The higher the value, the smoother the surface
Number_of_Fragments = 180;// [3:1:360]
Surface_Color = "Brown";// [Black, Blue, Brown, Chartreuse, Green, Gold, Magenta, Orange, Purple, Red, Silver, Teal, Violet, White, Yellow]
Egg_Length = 57;

Egg_v1(
    rendering_type = Rendering_Type,
    number_of_fragments = Number_of_Fragments,
    surface_color = Surface_Color,
    egg_length = Egg_Length
);
