#include "Vec3.h"
#include <cmath>

template <class vec_t> vec_t Vec3<vec_t>::distanceFromOrigin() const {
    Vec3 origin(0, 0, 0);
	return distanceFromPoint(origin);
}

template <class vec_t> vec_t Vec3<vec_t>::distanceFromPoint(const Vec3<vec_t>& _point) const {
	return std::sqrt(pow(pos.x - point.x, 2) + pow(pos.y - point.y, 2) + pow(pos.z - point.z, 2));
}

template <class vec_t> Vec3<vec_t>& Vec3<vec_t>::operator=(const Vec3<vec_t>& _rhs) {
    if (this == &rhs) { //Check for self assignment
        return rhs;
    }

    this->x = _rhs.x;
    this->y = _rhs.y;
    this->z = _rhs.z;

    return *this;
}

template <class vec_t> bool Vec3<vec_t>::operator==(const vec_t& _other) const {
	if (_other.x == x && _other.y == y && _other.z == z) {
		return true;
	}
	else {
		return false;
	}
}

template <class vec_t> bool Vec3<vec_t>::operator!=(const vec_t& _other) const {
	if (_other == *this) {
		return false;
	}
	else {
		return true;
	}
}

template <class vec_t> static vec_t dot(const Vec3<vec_t>& vec_a, const Vec3<vec_t>& vec_b) {
    return (vec_a.x * vec_b.x + vec_a.y * vec_b.y + vec_a.z * vec_b.z);
}