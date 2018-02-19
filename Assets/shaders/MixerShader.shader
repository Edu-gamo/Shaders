Shader "ENTI / Mixer" {
	Properties{
		_Color("Color", color) = (1, 0, 0, 1)
		_Texture0("Texture 0", 2D) = "" {}
		_Texture1("Texture 1", 2D) = "" {}
		_TextureMix("Texture Mixer", 2D) = "" {}
	}

		SubShader{
		Tags{ "Queue" = "Geometry" }
		Pass{
		GLSLPROGRAM

#ifdef VERTEX

#include "UnityCG.glslinc"

	varying vec2 TextureCoordinate;
	void main() {
		mat4 l_ViewMatrix = gl_ModelViewMatrix*unity_WorldToObject;
		gl_Position = unity_ObjectToWorld * gl_Vertex;
		gl_Position = l_ViewMatrix * gl_Position;
		gl_Position = gl_ProjectionMatrix * gl_Position;

		TextureCoordinate = gl_MultiTexCoord0.xy;
	}

#endif
#ifdef FRAGMENT
	uniform sampler2D _Texture0;
	uniform sampler2D _Texture1;
	uniform sampler2D _TextureMix;
	varying vec2 TextureCoordinate;
	void main() {
		gl_FragColor = mix(texture2D(_Texture0, TextureCoordinate), texture2D(_Texture1, TextureCoordinate), texture2D(_TextureMix, TextureCoordinate).xxxx);
	}

#endif
	ENDGLSL
	}
	}
}