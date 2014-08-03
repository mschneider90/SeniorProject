#include "Scene.h"
#include "Ray.h"
#include "Color32.h"
#include "SceneObj.h"

//TODO implement
Scene::~Scene() { } 

//TODO implement
Sphere* Scene::addSphere(const Vec3<float>& _pos, const float _radius) {
    return nullptr;
}

//TODO implement
bool Scene::doesRayIntersectObj(const Ray& _ray) { 
    return false;
}

//TODO implement
Color32 Scene::getBackgroundColor() {
    return Color32(StdColor::White);
}