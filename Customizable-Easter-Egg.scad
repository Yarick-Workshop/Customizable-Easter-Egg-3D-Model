// How I got this formula - just guessed :) (Thanks God!!!)
// I tried different standard formulas (such as Hügelschäffer one etc.) 
// but they were either too complex or didn't work as expected.
// So at the rights of a Pioneer I call it "Ivan's formula" in name of my father.

$fn = 360;

module rotated_objects(z_r_pairs)
{
    rotate_extrude(angle=360, convexity = 2)
        rotate([0, 0, 90])
            polygon(z_r_pairs);
}

module easter_egg() 
{
    egg_points = [for (i = [-90 : 1 : 90])
        let (
             z = sin(i),
             t = 1 + (i + 90) / 180,
             r = t * cos(i) * 0.5 
        ) 
    [ z, r ] ];
    
    rotated_objects(egg_points);
    
    echo(len(egg_points));
}

easter_egg();