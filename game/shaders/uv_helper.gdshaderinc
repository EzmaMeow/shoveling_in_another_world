//This add ways to adjust uv in the editor. commented out
//to give the shader that include this more control
//uniform vec2 uv_scaling = vec2(1.0,1.0);
//uniform vec2 uv_offset;
//uniform float uv_angle;
//uniform vec2 uv_rotation_offset = vec2(0.5,0.5);

//standalone scaling if needed
vec2 scale_uv(vec2 _uv, vec2 _scaling){
	return fract(_uv*_scaling);
}
//standalone offset if needed
vec2 offset_uv(vec2 _uv, vec2 _offset){
	return fract(_uv+_offset);
}
//rotate the uv
vec2 rotate_uv(vec2 _uv, float _angle, vec2 _origin) {
	_angle = radians(_angle);
    float cos_a = cos(_angle);
    float sin_a = sin(_angle);
    mat2 rotation_matrix = mat2(
		vec2(cos_a, -sin_a),
		vec2 (sin_a,  cos_a)
	);
	return (rotation_matrix * (_uv-_origin))+_origin;
}
//apply most of the uv transformations
vec2 transform_uv(
	vec2 _uv,vec2 _scaling, vec2 _offset,
	float _angle, vec2 _origin
){
	vec2 transformed_uv = _uv;
	if (_angle != 0.0){
		transformed_uv = rotate_uv(transformed_uv,_angle,_origin);
	}
	return fract(transformed_uv*_scaling+_offset);
}
//If uv is screen_uv, this will act like a world_uv
//but if UV is used, this will act like the oppssite of screen_uv
//where the uv will move in the opposit direction.
vec2 map_uv_to_position(vec2 _uv, vec2 _position, vec2 _pixel_size){
	return _position * _pixel_size + _uv;
}