// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Tim/Dither"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
		_MaskClipValue( "Mask Clip Value", Float ) = 0.5
		_Dither("Dither", Range( 0 , 1)) = 0.8022036
		_Color0("Color 0", Color) = (0,0,0,0)
		_Color1("Color 1", Color) = (0,0,0,0)
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float4 screenPosition;
		};

		uniform float4 _Color0;
		uniform float4 _Color1;
		uniform float _Dither;
		uniform float _MaskClipValue = 0.5;


		inline float Dither8x8Bayer( int x, int y )
		{
			const float dither[ 64 ] = {
				 1, 49, 13, 61,  4, 52, 16, 64,
				33, 17, 45, 29, 36, 20, 48, 32,
				 9, 57,  5, 53, 12, 60,  8, 56,
				41, 25, 37, 21, 44, 28, 40, 24,
				 3, 51, 15, 63,  2, 50, 14, 62,
				35, 19, 47, 31, 34, 18, 46, 30,
				11, 59,  7, 55, 10, 58,  6, 54,
				43, 27, 39, 23, 42, 26, 38, 22};
			int r = y * 8 + x;
			return (dither[r]-1) / 63;
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			o.screenPosition = ComputeScreenPos( UnityObjectToClipPos( v.vertex ) );
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 clipScreen1 = ( i.screenPosition.xy / i.screenPosition.w ) * _ScreenParams.xy;
			o.Albedo = lerp( _Color0 , _Color1 , ( Dither8x8Bayer( fmod(clipScreen1.x, 8), fmod(clipScreen1.y, 8) ) + (-1.0 + (_Dither - 0.0) * (1.0 - -1.0) / (1.0 - 0.0)) ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=7003
-33;481;1906;1004;2347.701;165.4;1.6;True;True
Node;AmplifyShaderEditor.RangedFloatNode;5;-1029.901,343.1999;Float;False;Property;_Dither;Dither;0;0;0.8022036;0;1;FLOAT
Node;AmplifyShaderEditor.TFHCRemap;6;-688.4014,344.4999;Float;False;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;1.0;False;3;FLOAT;-1.0;False;4;FLOAT;1.0;False;FLOAT
Node;AmplifyShaderEditor.DitheringNode;1;-775.5998,169.2;Float;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;4;-515.0004,230.4999;Float;False;0;FLOAT;0.0;False;1;FLOAT;0.0;False;FLOAT
Node;AmplifyShaderEditor.ColorNode;3;-743.9998,-240.7999;Float;False;Property;_Color0;Color 0;0;0;0,0,0,0;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.ColorNode;7;-745.6009,-73.30013;Float;False;Property;_Color1;Color 1;1;0;0,0,0,0;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.LerpOp;8;-388.8013,-52.50013;Float;False;0;COLOR;0.0;False;1;COLOR;0.0,0,0,0;False;2;FLOAT;0.0;False;COLOR
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;2;Float;ASEMaterialInspector;0;Standard;Tim/Dither;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Custom;0.5;True;True;0;False;TransparentCutout;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;False;0;4;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;Add;Add;0;False;0;0,0,0,0;VertexOffset;False;Cylindrical;Relative;0;;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;OBJECT;0.0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;13;OBJECT;0.0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False
WireConnection;6;0;5;0
WireConnection;4;0;1;0
WireConnection;4;1;6;0
WireConnection;8;0;3;0
WireConnection;8;1;7;0
WireConnection;8;2;4;0
WireConnection;0;0;8;0
ASEEND*/
//CHKSM=3F57C4BD3C59BF024191D250A23CEAB41470DAC0