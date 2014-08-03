#ifndef RAYTRACEUTIL_H
#define RAYTRACEUTIL_H

typedef struct {
    float x;
    float y;
    float z;
} Vec3;

typedef unsigned char byte;
typedef struct {
    byte r;
    byte g;
    byte b;
} Color24;


bool colorEquals(Color24 c1, Color24 c2);

#endif