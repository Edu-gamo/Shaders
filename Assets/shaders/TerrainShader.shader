Shader "ENTI / Terrain" {
	Properties{
		_Color("Color", color) = (1, 0, 0, 1)
		_heightTexture("Height Map", 2D) = "" {}
		_heatTexture("Heat Map", 2D) = "" {}
		_gMaxHeight("Max Height", Float) = 1
	}

		SubShader{
		Tags{ "Queue" = "Geometry" }
		Pass{
		GLSLPROGRAM

#ifdef VERTEX

#include "UnityCG.glslinc"

	uniform float _gMaxHeight;
	uniform sampler2D _heightTexture;
	varying vec2 TextureCoordinate;
	void main() {
		vec4 lHeight = vec4(0, 0, texture2DLod(_heightTexture, gl_MultiTexCoord0.xy, 0.0).x * _gMaxHeight, 0);
		mat4 lViewMatrix = gl_ModelViewMatrix * unity_WorldToObject;
		gl_Position = unity_ObjectToWorld * (gl_Vertex + lHeight);
		gl_Position = lViewMatrix * gl_Position;
		gl_Position = gl_ProjectionMatrix * gl_Position;
		TextureCoordinate = vec2(0.5, lHeight.z);
	}

#endif
#ifdef FRAGMENT
	uniform vec4 _Color;
	varying vec2 TextureCoordinate;
	uniform sampler2D _heatTexture;
	void main() {
		gl_FragColor = texture2D(_heatTexture, TextureCoordinate);
	}

#endif
	ENDGLSL
	}
	}
}