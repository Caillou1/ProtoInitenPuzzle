// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Tim/Stretch"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
		_SpeedX("SpeedX", Float) = 10
		_SpeedZ("SpeedZ", Float) = 10
		_SpeedY("SpeedY", Float) = 10
		_IntensityY("IntensityY", Float) = 0
		_IntensityX("IntensityX", Float) = 0
		_IntensityZ("IntensityZ", Float) = 0
		_OffsetZ("OffsetZ", Float) = 0
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float3 worldPos;
		};

		uniform float _SpeedY;
		uniform float _SpeedZ;
		uniform float _OffsetZ;
		uniform float _SpeedX;
		uniform float _IntensityZ;
		uniform float _IntensityX;
		uniform float _IntensityY;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float mulTime45 = _Time.y * _SpeedZ;
			float temp_output_48_0 = ( ( sin( ( mulTime45 + _OffsetZ ) ) + 1.0 ) / 2.0 );
			float mulTime35 = _Time.y * _SpeedX;
			float temp_output_38_0 = ( ( cos( mulTime35 ) + 1.0 ) / 2.0 );
			float mulTime28 = _Time.y * _SpeedY;
			float temp_output_25_0 = ( ( sin( mulTime28 ) + 1.0 ) / 2.0 );
			v.vertex.xyz += ( ( ( v.vertex.z * ( temp_output_48_0 * _IntensityZ ) ) * float3(0,0,1) ) + ( ( ( v.vertex.x * ( temp_output_38_0 * _IntensityX ) ) * float3(1,0,0) ) + ( ( v.vertex.y * ( temp_output_25_0 * _IntensityY ) ) * float3(0,1,0) ) ) );
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float mulTime28 = _Time.y * _SpeedY;
			float temp_output_25_0 = ( ( sin( mulTime28 ) + 1.0 ) / 2.0 );
			float temp_output_77_0 = clamp( temp_output_25_0 , 0.0 , 0.8 );
			float mulTime45 = _Time.y * _SpeedZ;
			float temp_output_48_0 = ( ( sin( ( mulTime45 + _OffsetZ ) ) + 1.0 ) / 2.0 );
			float temp_output_75_0 = clamp( temp_output_48_0 , 0.0 , 0.8 );
			float mulTime35 = _Time.y * _SpeedX;
			float temp_output_38_0 = ( ( cos( mulTime35 ) + 1.0 ) / 2.0 );
			float temp_output_76_0 = clamp( temp_output_38_0 , 0.0 , 0.8 );
			float4 appendResult80 = float4( temp_output_77_0 , temp_output_75_0 , temp_output_76_0 , 0 );
			float4 appendResult74 = float4( temp_output_75_0 , temp_output_76_0 , temp_output_77_0 , 0 );
			float3 vertexPos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float3 desaturateVar86 = lerp( lerp( ( appendResult80 * 0.5 ) , appendResult74 , (0.0 + (vertexPos.y - -1.0) * (1.0 - 0.0) / (1.0 - -1.0)) ).xyz,dot(lerp( ( appendResult80 * 0.5 ) , appendResult74 , (0.0 + (vertexPos.y - -1.0) * (1.0 - 0.0) / (1.0 - -1.0)) ).xyz,float3(0.299,0.587,0.114)),0.6);
			o.Albedo = desaturateVar86;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=7003
89;710;1906;1004;-259.6969;790.1829;1;True;True
Node;AmplifyShaderEditor.RangedFloatNode;44;-981.6188,-364.5544;Float;False;Property;_SpeedZ;SpeedZ;0;0;10;0;0;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;34;-663.8511,72.9519;Float;False;Property;_SpeedX;SpeedX;0;0;10;0;0;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;30;-822.9443,592.8213;Float;False;Property;_SpeedY;SpeedY;0;0;10;0;0;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;57;-763.6169,-331.0705;Float;False;Property;_OffsetZ;OffsetZ;6;0;0;0;0;FLOAT
Node;AmplifyShaderEditor.SimpleTimeNode;45;-851.2058,-479.8521;Float;False;0;FLOAT;50.0;False;FLOAT
Node;AmplifyShaderEditor.SimpleTimeNode;28;-703.946,467.3214;Float;False;0;FLOAT;50.0;False;FLOAT
Node;AmplifyShaderEditor.SimpleTimeNode;35;-544.8528,-52.54797;Float;False;0;FLOAT;50.0;False;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;55;-571.8171,-449.4152;Float;False;0;FLOAT;0.0;False;1;FLOAT;0.0;False;FLOAT
Node;AmplifyShaderEditor.SinOpNode;29;-493.5457,469.6212;Float;False;0;FLOAT;0.0;False;FLOAT
Node;AmplifyShaderEditor.CosOpNode;53;-322.3763,-45.55121;Float;False;0;FLOAT;0.0;False;FLOAT
Node;AmplifyShaderEditor.SinOpNode;46;-384.9248,-471.4312;Float;False;0;FLOAT;0.0;False;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;37;-162.0519,-37.24808;Float;False;0;FLOAT;0.0;False;1;FLOAT;1.0;False;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;24;-321.1451,482.6213;Float;False;0;FLOAT;0.0;False;1;FLOAT;1.0;False;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;47;-211.5242,-458.431;Float;False;0;FLOAT;0.0;False;1;FLOAT;1.0;False;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;31;-208.0234,592.3792;Float;False;Property;_IntensityY;IntensityY;1;0;0;0;0;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;33;91.04849,115.0518;Float;False;Property;_IntensityX;IntensityX;1;0;0;0;0;FLOAT
Node;AmplifyShaderEditor.SimpleDivideOpNode;25;-174.2451,446.2217;Float;False;0;FLOAT;0.0;False;1;FLOAT;2.0;False;FLOAT
Node;AmplifyShaderEditor.SimpleDivideOpNode;38;-34.95193,-129.1476;Float;False;0;FLOAT;0.0;False;1;FLOAT;2.0;False;FLOAT
Node;AmplifyShaderEditor.SimpleDivideOpNode;48;-65.62421,-462.3306;Float;False;0;FLOAT;0.0;False;1;FLOAT;2.0;False;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;43;-104.9174,-344.5948;Float;False;Property;_IntensityZ;IntensityZ;1;0;0;0;0;FLOAT
Node;AmplifyShaderEditor.PosVertexDataNode;1;-1275.928,311.3958;Float;True;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;39;154.2941,-46.16937;Float;False;0;FLOAT;0.0;False;1;FLOAT;1.0;False;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-4.799024,473.7;Float;False;0;FLOAT;0.0;False;1;FLOAT;1.0;False;FLOAT
Node;AmplifyShaderEditor.ClampOpNode;77;259.4301,-753.585;Float;False;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.8;False;FLOAT
Node;AmplifyShaderEditor.ClampOpNode;76;258.6298,-882.3848;Float;False;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.8;False;FLOAT
Node;AmplifyShaderEditor.ClampOpNode;75;257.1301,-1004.385;Float;False;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.8;False;FLOAT
Node;AmplifyShaderEditor.Vector3Node;10;178.4004,516.1;Float;False;Constant;_Vector0;Vector 0;0;0;0,1,0;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;49;83.8218,-419.8523;Float;False;0;FLOAT;0.0;False;1;FLOAT;1.0;False;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;41;336.3942,-153.1693;Float;False;0;FLOAT;0.0;False;1;FLOAT;0.0;False;FLOAT
Node;AmplifyShaderEditor.Vector3Node;40;337.4936,-3.769409;Float;False;Constant;_Vector1;Vector 1;0;0;1,0,0;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;85;779.5631,-1063.244;Float;False;Constant;_Float0;Float 0;7;0;0.5;0;0;FLOAT
Node;AmplifyShaderEditor.AppendNode;80;633.8028,-1149.899;Float;False;FLOAT4;0;0;0;0;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;FLOAT4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;177.301,366.7001;Float;False;0;FLOAT;0.0,0,0,0;False;1;FLOAT;0.0;False;FLOAT
Node;AmplifyShaderEditor.PosVertexDataNode;82;-300.8766,-877.2997;Float;False;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.Vector3Node;50;338.332,-397.3396;Float;False;Constant;_Vector2;Vector 2;0;0;0,0,1;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;394.4004,452.1;Float;False;0;FLOAT;0.0;False;1;FLOAT3;0.0;False;FLOAT3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;51;373.858,-542.2924;Float;False;0;FLOAT;0.0;False;1;FLOAT;0.0;False;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;42;536.0894,-92.13533;Float;False;0;FLOAT;0.0;False;1;FLOAT3;0.0;False;FLOAT3
Node;AmplifyShaderEditor.AppendNode;74;653.4666,-967.7727;Float;False;FLOAT4;0;0;0;0;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;FLOAT4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;84;858.674,-1234.091;Float;False;0;FLOAT4;0.0;False;1;FLOAT;0.25,0.25,0.25,0.25;False;FLOAT4
Node;AmplifyShaderEditor.TFHCRemap;83;-36.94873,-858.5494;Float;False;0;FLOAT;0.0;False;1;FLOAT;-1.0;False;2;FLOAT;1.0;False;3;FLOAT;0.0;False;4;FLOAT;1.0;False;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;18;717.3572,167.5934;Float;False;0;FLOAT3;0,0,0;False;1;FLOAT3;0.0;False;FLOAT3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;52;673.0213,-513.9523;Float;False;0;FLOAT;0.0;False;1;FLOAT3;0.0;False;FLOAT3
Node;AmplifyShaderEditor.LerpOp;79;1046.303,-989.7992;Float;False;0;FLOAT4;0.0,0,0,0;False;1;FLOAT4;0.0;False;2;FLOAT;0.0;False;FLOAT4
Node;AmplifyShaderEditor.RangedFloatNode;87;1049.797,-647.4829;Float;False;Constant;_Float1;Float 1;7;0;0.6;0;0;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;54;961.8451,168.5209;Float;False;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;FLOAT3
Node;AmplifyShaderEditor.DesaturateOpNode;86;1245.797,-923.4829;Float;False;0;FLOAT3;0,0,0;False;1;FLOAT;0.0;False;FLOAT3
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1285.882,-359.985;Float;False;True;2;Float;ASEMaterialInspector;0;Standard;Tim/Stretch;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;False;0;4;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;Add;Add;0;False;0;0,0,0,0;VertexOffset;False;Cylindrical;Relative;0;;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;OBJECT;0.0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;13;OBJECT;0.0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False
WireConnection;45;0;44;0
WireConnection;28;0;30;0
WireConnection;35;0;34;0
WireConnection;55;0;45;0
WireConnection;55;1;57;0
WireConnection;29;0;28;0
WireConnection;53;0;35;0
WireConnection;46;0;55;0
WireConnection;37;0;53;0
WireConnection;24;0;29;0
WireConnection;47;0;46;0
WireConnection;25;0;24;0
WireConnection;38;0;37;0
WireConnection;48;0;47;0
WireConnection;39;0;38;0
WireConnection;39;1;33;0
WireConnection;9;0;25;0
WireConnection;9;1;31;0
WireConnection;77;0;25;0
WireConnection;76;0;38;0
WireConnection;75;0;48;0
WireConnection;49;0;48;0
WireConnection;49;1;43;0
WireConnection;41;0;1;1
WireConnection;41;1;39;0
WireConnection;80;0;77;0
WireConnection;80;1;75;0
WireConnection;80;2;76;0
WireConnection;7;0;1;2
WireConnection;7;1;9;0
WireConnection;11;0;7;0
WireConnection;11;1;10;0
WireConnection;51;0;1;3
WireConnection;51;1;49;0
WireConnection;42;0;41;0
WireConnection;42;1;40;0
WireConnection;74;0;75;0
WireConnection;74;1;76;0
WireConnection;74;2;77;0
WireConnection;84;0;80;0
WireConnection;84;1;85;0
WireConnection;83;0;82;2
WireConnection;18;0;42;0
WireConnection;18;1;11;0
WireConnection;52;0;51;0
WireConnection;52;1;50;0
WireConnection;79;0;84;0
WireConnection;79;1;74;0
WireConnection;79;2;83;0
WireConnection;54;0;52;0
WireConnection;54;1;18;0
WireConnection;86;0;79;0
WireConnection;86;1;87;0
WireConnection;0;0;86;0
WireConnection;0;11;54;0
ASEEND*/
//CHKSM=5C421C5AA27A93640D7D12C9DDCD127E09F02D1A