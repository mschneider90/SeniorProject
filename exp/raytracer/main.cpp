#include <iostream>
#include <cmath>

typedef struct {
    float x;
    float y;
    float z;
} Vec3;

typedef struct {
    Vec3 pos;
    float theta_x;
    float theta_y;
} RayInfo;

typedef unsigned char byte;
typedef struct {
    byte r;
    byte g;
    byte b;
} Color24;

typedef struct {
    int obj; //temp
} ObjectBuffer;

Color24 rayTrace(ObjectBuffer obj_buffer, RayInfo r, Color24 background_color, float delta, float max_ray_length);
float distanceFromOrigin(Vec3 pos);
float distanceFromPoint(Vec3 pos, Vec3 point);
Vec3 pixelPosition(float focal_width, float focal_length);
bool intersectsObject(Vec3 pos, ObjectBuffer obj_buf);
bool colorEquals(Color24 c1, Color24 c2);

int main() {
    const int RES_X = 30;
    const int RES_Y = 30;

    const float FOCAL_LENGTH = 1.0;
    const float FOCAL_WIDTH = 4.0;

    const float MAX_RAY_LENGTH = 30;

    Color24 white;
    white.b = 0xFF;
    white.g = 0xFF;
    white.r = 0xFF;

    Color24 framebuffer[RES_X][RES_Y];

    for (int x = 0; x < RES_X; x++) {
        for (int y = 0; y < RES_Y; y++) {
            int total_pix = RES_X * RES_Y;

            RayInfo r;
            //Calculate the center of the pixel
            r.pos.x = FOCAL_WIDTH / (RES_X * 2) + x * FOCAL_WIDTH / RES_X - FOCAL_WIDTH / 2;
            r.pos.y = FOCAL_WIDTH / (RES_Y * 2) + y * FOCAL_WIDTH / RES_Y - FOCAL_WIDTH / 2;
            r.pos.z = 0;
            //Calculate the angle at which the ray travels through the pixel
            r.theta_x = std::atan2(r.pos.x, FOCAL_LENGTH);
            r.theta_y = std::atan2(r.pos.y, FOCAL_LENGTH);

            //Dummy obj buffer for now
            ObjectBuffer obj_buf = { 0 };
            Color24 pix_color = rayTrace(obj_buf, r, white, .01, MAX_RAY_LENGTH);
            if (colorEquals(pix_color, white)) {
                std::cout << "X";
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
            r.pos.z += delta;
            r.pos.x += delta * r.theta_x;
            r.pos.y += delta * r.theta_y;
            return rayTrace(obj_buffer, r, background_color, delta, max_ray_length);
        }
    }
}

bool intersectsObject(Vec3 pos, ObjectBuffer obj_buf) {
    //Temporary: only have one shape (circle of radius 3) at a position <0,0,10> (in the middle of the scene 10 units away from the origin)
    Vec3 circle_position = { 0, 0, 5 };
    int circle_radius = 5;

    if (distanceFromPoint(pos, circle_position) < circle_radius)
        return true;
    else
        return false;
}

float distanceFromPoint(Vec3 pos, Vec3 point) {
    return std::sqrt(pow(pos.x - point.x, 2) + pow(pos.y - point.y, 2) + pow(pos.z - point.z, 2));
}

float distanceFromOrigin(Vec3 pos) {
    Vec3 origin = { 0, 0, 0 };
    return distanceFromPoint(pos, origin);
}

bool colorEquals(Color24 c1, Color24 c2) {
    if (c1.r == c2.r && c1.g == c2.g && c1.b == c2.b) {
        return true;
    }
    else {
        return false;
    }
}