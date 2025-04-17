// How I got this formula - just guessed :) (Thanks God!!!)
// I tried different standard formulas (such as Hügelschäffer one etc.) 
// but they were either too complex or didn't work as expected.
// So at the rights of a Pioneer I call it "Ivan's formula" in name of my father.

// The lower the value, the smoother the surface
Step_Angle = 10;//[1, 2, 3, 4, 5, 6, 9, 10, 12, 15, 18, 20, 30, 36, 45, 60, 90]
$fn = 360 / Step_Angle;


module rotated_objects(z_r_pairs)
{
    rotate_extrude(angle=360, convexity = 2)
        rotate([0, 0, 90])
            polygon(z_r_pairs);
}

module easter_egg() 
{
    egg_points = [for (i = [-90 : Step_Angle : 90])
        let (
             z = sin(i),
             t = 1 + (i + 90) / 180,
             r = t * cos(i) * 0.5
        ) 
    [ z, r ] ];

    translate([0, 0, 1])
        mirror([0, 0, 1])
            rotated_objects(egg_points);
    
    echo(len(egg_points));
}

easter_egg();