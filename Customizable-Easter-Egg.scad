$fn = 360;
module rotated_objects(z_r_pairs)
{
    rotate_extrude(angle=360, convexity=10)
        //rotate([0, 0, 90])
            polygon(z_r_pairs);
}

module easter_egg() 
{
    egg_points = [for (i = [0 : 10 : 180])
        let (
             rad = 100,
             z = sin(i) * rad,
             r = cos(i) * rad            
        ) 
    [ z, r ] ];
    
    rotated_objects(egg_points);
    
    echo(len(egg_points));
}

mirror([0, 0, 1])
    easter_egg();