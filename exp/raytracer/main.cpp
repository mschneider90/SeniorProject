#include "Ray.h"
#include "Color32.h"
#include "Scene.h"
#include "Sphere.h"
#include "Vec3.h"

#include <iostream>
#include <cmath>

typedef struct {
    int obj; //temp
} ObjectBuffer;

Color24 rayTrace(ObjectBuffer obj_buffer, RayInfo r, Color24 background_color, float delta, float max_ray_length);

int main() {
    const int RES_X = 30;
    const int RES_Y = 30;

    const float FOCAL_LENGTH = 1.0;
    const float FOCAL_WIDTH = 4.0;

    const float MAX_RAY_LENGTH = 30;

    Color32 framebuffer[RES_X][RES_Y];

    //Start with an "eyeball" at the three dimensional origin, with a screen of RES_X * RES_Y pixels
    //in front of it, FOCAL_LENGTH away and FOCAL_WIDTH x FOCAL_WIDTH in size. For each pixel in the 
    //screen, cast a ray through the center of it. If the ray hits an object, return the color of 
    //that object; otherwise, return the background color.
    int total_pix = RES_X * RES_Y;
    for (int x = 0; x < RES_X; x++) {
        for (int y = 0; y < RES_Y; y++) {
            //Calculate the center of the pixel
            Vec3<float> pix_pos;
            pix_pos.x = FOCAL_WIDTH / (RES_X * 2) + x * FOCAL_WIDTH / RES_X - FOCAL_WIDTH / 2;
            pix_pos.y = FOCAL_WIDTH / (RES_Y * 2) + y * FOCAL_WIDTH / RES_Y - FOCAL_WIDTH / 2;
            pix_pos.z = 0;
            //Calculate the angle at which the ray travels through the pixel
            r.theta_x = std::atan2(r.pos.x, FOCAL_LENGTH);
            r.theta_y = std::atan2(r.pos.y, FOCAL_LENGTH);
            Ray r;

            //Dummy obj buffer for now
            ObjectBuffer obj_buf = { 0 };
            Color32 pix_color = rayTrace(obj_buf, r, white, .01, MAX_RAY_LENGTH);
            if (colorEquals(pix_color, white)) {
                std::cout << " ";
            }
            else {
                std::cout << "O";
            }
        }
        printf("\n");
    }

    int x;
    std::cin >> x;
    return 0;
}

Color24 rayTrace(ObjectBuffer obj_buffer, RayInfo r, Color24 background_color, float delta, float max_ray_length) {
    if (distanceFromOrigin(r.pos) > max_ray_length) {
        return background_color;
    }
    else {
        if (intersectsObject(r.pos, obj_buffer)) {
            Color24 c = { 0x00, 0xFF, 0x21 };
            return c;
        }
        else {
            float x_incr = delta * std::tan(r.theta_x);
            float y_incr = delta * std::tan(r.theta_y);

            r.pos.x += x_incr;
            r.pos.y += y_incr;
            r.pos.z += std::sqrt(std::pow(x_incr, 2) + std::pow(y_incr, 2) + std::pow(delta, 2));

            return rayTrace(obj_buffer, r, background_color, delta, max_ray_length);
        }
    }
}

bool intersectsObject(Vec3 pos, ObjectBuffer obj_buf) {
    //Temporary: only have one shape (circle of radius 3) at a position <0,0,10> (in the middle of the scene 10 units away from the origin)
    Vec3 circle_position = { 0, 0, 7.5 };
    int circle_radius = 5;

    if (distanceFromPoint(pos, circle_position) < circle_radius)
        return true;
    else
        return false;
}

bool colorEquals(Color24 c1, Color24 c2) {
    if (c1.r == c2.r && c1.g == c2.g && c1.b == c2.b) {
        return true;
    }
    else {
        return false;
    }
}