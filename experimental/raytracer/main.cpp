#include "Ray.h"
#include "Color32.h"
#include "Scene.h"
#include "Sphere.h"
#include "Vec3.h"

#include <iostream>
#include <cmath>

Color32 rayTrace(const Scene& _scene, const Ray& _ray);

int main() {
    const int RES_X = 30;
    const int RES_Y = 30;

    const float FOCAL_LENGTH = 1.0;
    const float FOCAL_WIDTH = 4.0;

    Color32 background_color = StdColor::White;
    Scene scene(background_color);
    Sphere* sphere = scene.addSphere(Vec3<float>(0,0,10), 5);

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
            Vec3<float> ray_angle;
            ray_angle.x = std::atan2(pix_pos.x, FOCAL_LENGTH);
            ray_angle.y = std::atan2(pix_pos.y, FOCAL_LENGTH);
            ray_angle.z = 0;

			//std::cout << "Pix position: " << pix_pos.x << ", " << pix_pos.y << std::endl;
			//std::cout << "Ray angle: " << ray_angle.x << ", " << ray_angle.y << ", " << ray_angle.z << std::endl;
            Ray ray(pix_pos, ray_angle);

            Color32 pix_color = rayTrace(scene, ray);
            if (pix_color == background_color) {
                std::cout << " ";
            }
            else {
                std::cout << "O";
            }
        }
        std::cout << std::endl;
    }

    int x;
    std::cin >> x;
    return 0;
}

Color32 rayTrace(const Scene& _scene, const Ray& _ray) {
	if (_scene.doesRayIntersectObj(_ray))
	{
		return StdColor::Black;
	}
	else {
		return StdColor::White;
	}
}
