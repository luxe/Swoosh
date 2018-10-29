#version 110

uniform float A;
uniform float theta;
uniform float rho;

void main()
{
    float R, r, beta;
    vec3  v1;
    vec4  position = gl_Vertex;
                    
    // Radius of the circle circumscribed by vertex (vi.x, vi.y) around A on the x-y plane
    R = sqrt(position.x * position.x + pow(position.y - A, 2.0)); 
    // Now get the radius of the cone cross section intersected by our vertex in 3D space.
    r = R * sin(theta);                       
    // Angle subtended by arc |ST| on the cone cross section.
    beta = asin(position.x / R) / sin(theta);       
   
    //project the vertex onto the cone
    v1.x  = r * sin(beta);
    v1.y  = R + A - r * (1.0 - cos(beta)) * sin(theta); 
    v1.z  = r * (1.0 - cos(beta)) * cos(theta);

    position.x = (v1.x * cos(rho) - v1.z * sin(rho));
    position.y = v1.y;
    position.z = (v1.x * sin(rho) + v1.z * cos(rho));

    gl_Position = position; // gl_ProjectionMatrix * gl_ModelViewProjectionMatrix * position; 
    gl_TexCoord[0] = gl_TextureMatrix[0] * gl_MultiTexCoord0;
    gl_FrontColor = gl_Color;
}  