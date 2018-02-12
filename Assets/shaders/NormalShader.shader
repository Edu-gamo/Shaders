Shader "ENTI / Normal" {
	Properties{
		_Color("Color", color) = (1, 0, 0, 1)
	}

		SubShader{
		Tags{ "Queue" = "Geometry" }
		Pass{
		GLSLPROGRAM

#ifdef VERTEX

#include "UnityCG.glslinc"

	varying vec3 normal;
	void main() {
		mat4 l_ViewMatrix = gl_ModelViewMatrix*unity_WorldToObject;
		gl_Position = unity_ObjectToWorld * gl_Vertex;
		gl_Position = l_ViewMatrix * gl_Position;
		gl_Position = gl_ProjectionMatrix * gl_Position;

		normal = (unity_ObjectToWorld * vec4(gl_Normal.xyz, 0.0)).xyz;
		normalize(normal);
	}

#endif
#ifdef FRAGMENT
	uniform vec4 _Color;
	varying vec3 normal;
	void main() {
		normalize(normal);
		gl_FragColor = vec4(normal, 1.0);
		//gl_FragColor = texture2D(_MainTex, TextureCoordinate);
	}

#endif
	ENDGLSL
	}
	}
}