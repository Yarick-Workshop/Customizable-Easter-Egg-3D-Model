/*
    How I got this formula - just guessed :) (Thanks God!!!).
    Few standard formulas (such as Hügelschäffer one etc.) were tried,
    but they were either too complex or didn't work as expected.

    So at the rights of a Pioneer I called it "Ivan's formula" in name of my father.
*/

module draw_rotated_objects(z_r_pairs)
{
    rotate_extrude(angle=360, convexity = 2)
        rotate([0, 0, 90])
            polygon(z_r_pairs);
}

module draw_Easter_egg_internal(step_angle)
{
    egg_points = [for (i = [-90 : step_angle : 90])
        let (
             z = sin(i),
             t = 2 - (i + 90) / 180,
             r = t * cos(i) * 0.5
        )
    [ z, r ] ];

    draw_rotated_objects(egg_points);
}

module draw_whole_Easter_egg(step_angle)
{
    translate([0, 0, 1])
        draw_Easter_egg_internal(step_angle);
}

module draw_two_halves_of_Easter_egg(step_angle)
{
    // top part
    difference()
    {
        draw_Easter_egg_internal(step_angle);
        translate([0, 0, -1])
            cube([2, 2, 2], center = true);
    }

    // bottom part
    translate([1.8, 0, 0])
        rotate([0, 180, 0])
            difference()
            {
                draw_Easter_egg_internal(step_angle);
                translate([0, 0, 1])
                    cube([2, 2, 2], center = true);
            }
}

module draw_demo_Easter_eggs(step_angle)
{
    angle = -20;
    distance = 1.27;

    color("Brown")
        rotate([0, 0, -20])
            draw_whole_Easter_egg(step_angle);

    color("Teal")
        rotate([0, 0, 30])
            translate([0, distance, 0])
                rotate([angle, 0, 0])
                    draw_whole_Easter_egg(step_angle);

    color("Chartreuse")
        rotate([0, 0, 150])
            translate([0, distance, 0])
                rotate([angle, 0, 0])
                    draw_whole_Easter_egg(step_angle);

    color("Gold")
        rotate([0, 0, -90])
            translate([0, distance, 0])
                rotate([angle, 0, 0])
                    draw_whole_Easter_egg(step_angle);
}

module Egg_v1(
    rendering_type = "Whole Egg",
    number_of_fragments = 180,
    surface_color = "Brown",
    egg_length = 57
)
{
    assert(
        number_of_fragments >= 3 && number_of_fragments == floor(number_of_fragments),
        "number_of_fragments should be a positive integer value >= 3."
    );

    step_angle = 180 / number_of_fragments;
    scaling_factor = egg_length / 2;

    $fn = number_of_fragments;

    scale([scaling_factor, scaling_factor, scaling_factor])
        if (rendering_type == "Whole Egg")
        {
            color(surface_color)
                draw_whole_Easter_egg(step_angle);
        }
        else if (rendering_type == "Two Halves")
        {
            color(surface_color)
                draw_two_halves_of_Easter_egg(step_angle);
        }
        else if (rendering_type == "Demo")
        {
            draw_demo_Easter_eggs(step_angle);
        }
        else
        {
            echo("rendering_type should be either 'Whole Egg', 'Two Halves' or 'Demo'!");
        }
}
