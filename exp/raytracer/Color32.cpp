#include "Color32.h"

void Color32::setColor(StandardColor _color) {
	if (_color == StandardColor::White) {
		r = 0xFF;
		g = 0xFF;
		b = 0xFF;
		a = 0xFF;
	}
}

bool Color32::operator==(const Color32& _other) const {
	if (r == _other.r && g == _other.g && b == _other.b && a == _other.a) {
		return true;
	}
	else {
		return false;
	}
}

bool Color32::operator!=(const Color32& _other) const {
	return (*this == _other);
}