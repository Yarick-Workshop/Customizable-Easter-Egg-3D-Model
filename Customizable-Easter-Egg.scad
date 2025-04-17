// How I got this formula - just guessed :) (Thanks God!!!)
// I tried different standard formulas (such as Hügelschäffer one etc.) 
// but they were either too complex or didn't work as expected.
// So at the rights of a Pioneer I call it "Ivan's formula" in name of my father.

Rendering_Type="Whole Egg";// [Whole Egg, Two Halves]
// The lower the value, the smoother the surface
Step_Angle = 10;//[1, 2, 3, 4, 5, 6, 9, 10, 12, 15, 18, 20, 30, 36, 45, 60, 90]
Surface_Color = "Brown";// [Black, Blue, Brown, Chartreuse, Green, Gold, Magenta, Orange, Purple, Red, Silver, Teal, Violet, White, Yellow]

$fn = 360 / Step_Angle;

module rotated_objects(z_r_pairs)
{
    rotate_extrude(angle=360, convexity = 2)
        rotate([0, 0, 90])
            polygon(z_r_pairs);
}

module whole_easter_egg() 
{
    translate([0, 0, 1])
        easter_egg_internal();
}

module two_halves_of_easter_egg() 
{
    // top part
    difference()
    {
        easter_egg_internal();
        translate([0, 0, -1])
            cube([2, 2, 2], center = true);
    }

    // bottom part
    translate([1.8, 0, 0])
        rotate([0, 180, 0])
            difference()
            {
                easter_egg_internal();
                translate([0, 0, 1])
                    cube([2, 2, 2], center = true);
            }
}

module easter_egg_internal() 
{
    egg_points = [for (i = [-90 : Step_Angle : 90])
        let (
             z = sin(i),
             t = 1 + (i + 90) / 180,
             r = t * cos(i) * 0.5
        ) 
    [ z, r ] ];

    mirror([0, 0, 1])
        rotated_objects(egg_points);
}

color(Surface_Color)
if (Rendering_Type == "Whole Egg")
{
    whole_easter_egg();
}
else if (Rendering_Type == "Two Halves")
{
    two_halves_of_easter_egg();
}
else
{
    echo("Rendering_Type should be either 'Whole Egg' or 'Two Halves'");
}
