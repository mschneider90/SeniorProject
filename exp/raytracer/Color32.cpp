#include "Color32.h"

void Color32::setColor(StdColor _color) {
	if (_color == StdColor::White) {
		r = static_cast<byte>(0xFF);
        g = static_cast<byte>(0xFF);
        b = static_cast<byte>(0xFF);
        a = static_cast<byte>(0xFF);
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