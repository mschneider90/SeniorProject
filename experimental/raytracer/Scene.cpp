#include "Scene.h"
#include "Ray.h"
#include "Color32.h"
#include "SceneObj.h"
#include "Sphere.h"

Scene::~Scene() {
    for (auto obj_iter = scene_objs.begin(); obj_iter != scene_objs.end(); obj_iter++) {
        SceneObj* obj = *obj_iter;
        delete obj;
    }
} 

Sphere* Scene::addSphere(const Vec3<float>& _pos, const float _radius) {
    Sphere* sphere = new Sphere(_pos, _radius);
    scene_objs.push_back(sphere);
    return sphere;
}

bool Scene::doesRayIntersectObj(const Ray& _ray) const { 
    //TODO how to handle multiple intersections?
    for (auto obj_iter = scene_objs.begin(); obj_iter != scene_objs.end(); obj_iter++) {
        if ((*obj_iter)->doesRayIntersect(_ray)) {
            return true;
        }
    }
    return false;
}

Color32 Scene::getBackgroundColor() {
    return background_color;
}