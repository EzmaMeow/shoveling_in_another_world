//This uses a noise texture and either mask the source color or tint it
//depending on the noise values.
//TODO: this can be a mask shader instead. can convert the noise vec4 to
//a mask float. tinting option may be used as well. may add a few way to mask
//such as replace, multiply, or added. strength may be kept to override the mask
//and lightness may be kept as well though not sure of a better name. it offsets
//the black/white
shader_type canvas_item;

#include "uid://dpeqmg8nxnxfa" //uv_control

global uniform vec2 world_pos_2D;
//mask
//TODO: need an option to decide how to handle
//alpha. such as either to use the TEXTURE alpha
//or to use the blended alpha(or the replace texture alpha)
uniform sampler2D mask_source;
uniform sampler2D mask_texture;
uniform bool use_mask_texture_alpha;
uniform bool blend_mask;
uniform float mask_strength = 1.0;
uniform float mask_lightness = 0.1;
//uv
uniform bool use_screen_space_uv;
uniform bool map_uv_to_world;
uniform vec2 uv_scaling = vec2(1.0,1.0);
uniform vec2 uv_offset;
uniform float uv_angle;
uniform vec2 uv_rotation_offset = vec2(0.5,0.5);

void fragment() {
	vec2 uv;
	vec4 texture_color;
	vec4 mask;
	vec4 mask_color;
	vec4 color;
	if (use_screen_space_uv){
		uv = SCREEN_UV;
	}
	else{
		uv = UV;
	}
	if (map_uv_to_world){
		uv = map_uv_to_position(uv,world_pos_2D,SCREEN_PIXEL_SIZE);
	}
	uv = transform_uv(uv,uv_scaling,uv_offset,uv_angle,uv_rotation_offset);
	texture_color = texture(TEXTURE, uv);
	mask = texture(mask_source,uv);
	mask_color = texture(mask_texture,uv);
	if (blend_mask){
		color = (mask.x+mask_lightness) * mask_color;
		if (mask_strength != 1.0) {
			color = mix(texture_color,color,mask_strength);
		}
	}
	else{
		color = mix(texture_color,mask_color,(mask.x+mask_lightness)*mask_strength);
	}
	if (!use_mask_texture_alpha){
		color.a = texture_color.a;
	}
	COLOR=color;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
