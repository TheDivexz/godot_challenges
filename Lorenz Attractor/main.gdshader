shader_type spatial;
render_mode unshaded;
void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
 	//float magnitude = 0.0;
	//if(VERTEX.x > magnitude) {
		//magnitude = VERTEX.x;
	//}
	//if (VERTEX.y > magnitude){
		//magnitude = VERTEX.y;
	//}
	//if (VERTEX.z > magnitude) {
		//magnitude = VERTEX.z;
	//}
	//ALBEDO = vec3(VERTEX.x/magnitude,VERTEX.y/magnitude,VERTEX.z/magnitude);
	ALBEDO = vec3(1.0,1.0,0.0);
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
