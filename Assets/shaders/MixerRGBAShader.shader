Shader "ENTI / MixerRGBA" {
	Properties{
		_Color("Color", color) = (1, 0, 0, 1)
		_TextureRed("Texture Red", 2D) = "" {}
		_TextureGreen("Texture Green", 2D) = "" {}
		_TextureBlue("Texture Blue", 2D) = "" {}
		_TextureAlpha("Texture Alpha", 2D) = "" {}
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
	uniform sampler2D _TextureRed;
	uniform sampler2D _TextureGreen;
	uniform sampler2D _TextureBlue;
	uniform sampler2D _TextureAlpha;
	uniform sampler2D _TextureMix;
	varying vec2 TextureCoordinate;
	void main() {
		vec4 mixer = texture2D(_TextureMix, TextureCoordinate);
		vec4 red = texture2D(_TextureRed, TextureCoordinate);
		vec4 green = texture2D(_TextureGreen, TextureCoordinate);
		vec4 blue = texture2D(_TextureBlue, TextureCoordinate);
		vec4 alpha = texture2D(_TextureAlpha, TextureCoordinate);
		gl_FragColor = (mixer.x * red) + (mixer.y * green) + (mixer.z * blue) + (mixer.w * alpha);
	}

#endif
	ENDGLSL
	}
	}
}