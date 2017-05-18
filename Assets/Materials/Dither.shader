// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Tim/Dither"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
		_MaskClipValue( "Mask Clip Value", Float ) = 0.5
		_TilingTP("TilingTP", Float) = 0
		_Speed("Speed", Float) = 0
		_Falloff("Falloff", Float) = 0
		_Texture1("Texture 1", 2D) = "white" {}
		_TessValue( "Max Tessellation", Range( 1, 32 ) ) = 4
		_TessMin( "Tess Min Distance", Float ) = 10
		_TessMax( "Tess Max Distance", Float ) = 30
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "Tessellation.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 4.6
		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) fixed3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		struct Input
		{
			float3 worldNormal;
			float3 worldPos;
		};

		struct appdata
		{
			float4 vertex : POSITION;
			float4 tangent : TANGENT;
			float3 normal : NORMAL;
			float4 texcoord : TEXCOORD0;
			float4 texcoord1 : TEXCOORD1;
			float4 texcoord2 : TEXCOORD2;
			float4 texcoord3 : TEXCOORD3;
			fixed4 color : COLOR;
			UNITY_VERTEX_INPUT_INSTANCE_ID
		};

		uniform float _Falloff;
		uniform sampler2D _Texture1;
		uniform float _Speed;
		uniform float _TilingTP;
		uniform float _MaskClipValue = 0.5;
		uniform float _TessValue;
		uniform float _TessMin;
		uniform float _TessMax;

		float4 tessFunction( appdata v0, appdata v1, appdata v2 )
		{
			return UnityDistanceBasedTess( v0.vertex, v1.vertex, v2.vertex, _TessMin, _TessMax, _TessValue );
		}

		void vertexDataFunc( inout appdata v )
		{
		}

		inline fixed4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return fixed4 ( s.Emission, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float3 temp_cast_0 = (_Falloff).xxx;
			float mulTime119 = _Time.y * _Speed;
			float3 ase_worldPos = i.worldPos;
			float4 appendResult57 = float4( ase_worldPos.y , ase_worldPos.z , 0 , 0 );
			float4 temp_output_110_0 = ( appendResult57 * _TilingTP );
			float4 appendResult58 = float4( ase_worldPos.z , ase_worldPos.x , 0 , 0 );
			float4 temp_output_111_0 = ( appendResult58 * _TilingTP );
			float4 appendResult59 = float4( ase_worldPos.x , ase_worldPos.y , 0 , 0 );
			float4 temp_output_112_0 = ( appendResult59 * _TilingTP );
			float3 weightedBlendVar70 = clamp( pow( abs( i.worldNormal ) , temp_cast_0 ) , float3( 0,0,0 ) , float3( 1,1,1 ) );
			float4 temp_output_70_0 = ( weightedBlendVar70.x*tex2D( _Texture1,(abs( temp_output_110_0.xy+mulTime119 * float2(-1,-1 )))) + weightedBlendVar70.y*tex2D( _Texture1,(abs( temp_output_111_0.xy+mulTime119 * float2(0,0 )))) + weightedBlendVar70.z*tex2D( _Texture1,(abs( temp_output_112_0.xy+mulTime119 * float2(1,-1 )))) );
			o.Emission = temp_output_70_0.xyz;
			o.Alpha = 1;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Unlit keepalpha vertex:vertexDataFunc tessellate:tessFunction nolightmap 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			# include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float3 worldPos : TEXCOORD6;
				float4 tSpace0 : TEXCOORD1;
				float4 tSpace1 : TEXCOORD2;
				float4 tSpace2 : TEXCOORD3;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			fixed4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				float3 worldPos = IN.worldPos;
				fixed3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				SurfaceOutput o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutput, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=7003
-178;739;1906;1004;4803.737;1372.9;1.3;True;True
Node;AmplifyShaderEditor.WorldPosInputsNode;122;-5124.038,-208.8011;Float;False;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.AppendNode;59;-4851.514,32.0755;Float;False;FLOAT4;0;0;0;0;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;FLOAT4
Node;AmplifyShaderEditor.RangedFloatNode;120;-4633.354,-589.4434;Float;False;Property;_Speed;Speed;4;0;0;0;0;FLOAT
Node;AmplifyShaderEditor.WorldNormalVector;66;-4264.244,-1231.194;Float;True;0;FLOAT3;0,0,0;False;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.AppendNode;58;-4850.416,-150.5244;Float;False;FLOAT4;0;0;0;0;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;FLOAT4
Node;AmplifyShaderEditor.AppendNode;57;-4844.915,-329.5244;Float;False;FLOAT4;0;0;0;0;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;FLOAT4
Node;AmplifyShaderEditor.RangedFloatNode;113;-4854.372,-440.4983;Float;False;Property;_TilingTP;TilingTP;4;0;0;0;0;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;112;-4563.802,37.0522;Float;False;0;FLOAT4;0.0;False;1;FLOAT;0,0,0,0;False;FLOAT4
Node;AmplifyShaderEditor.AbsOpNode;125;-3848.322,-1401.004;Float;True;0;FLOAT3;0.0;False;FLOAT3
Node;AmplifyShaderEditor.RangedFloatNode;156;-3852.034,-1149.802;Float;False;Property;_Falloff;Falloff;5;0;0;0;0;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;110;-4571,-362.5477;Float;False;0;FLOAT4;0.0;False;1;FLOAT;0.0,0,0,0;False;FLOAT4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;111;-4559.801,-183.3478;Float;False;0;FLOAT4;0.0;False;1;FLOAT;0.0,0,0,0;False;FLOAT4
Node;AmplifyShaderEditor.SimpleTimeNode;119;-4459.155,-584.6435;Float;False;0;FLOAT;1.0;False;FLOAT
Node;AmplifyShaderEditor.PowerNode;155;-3589.032,-1312.504;Float;True;0;FLOAT3;0.0;False;1;FLOAT;5.0;False;FLOAT3
Node;AmplifyShaderEditor.TexturePropertyNode;63;-4104.717,-85.12451;Float;True;Property;_Texture1;Texture 1;10;0;None;False;white;Auto;SAMPLER2D
Node;AmplifyShaderEditor.PannerNode;71;-4072.716,-610.2248;Float;False;-1;-1;0;FLOAT2;0,0;False;1;FLOAT;0.0;False;FLOAT2
Node;AmplifyShaderEditor.PannerNode;72;-4087.917,-434.0246;Float;False;0;0;0;FLOAT2;0,0;False;1;FLOAT;0.0;False;FLOAT2
Node;AmplifyShaderEditor.PannerNode;73;-4082.416,-239.3248;Float;False;1;-1;0;FLOAT2;0,0;False;1;FLOAT;0.0;False;FLOAT2
Node;AmplifyShaderEditor.ClampOpNode;158;-3272.435,-1272.1;Float;False;0;FLOAT3;0.0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;1,1,1;False;FLOAT3
Node;AmplifyShaderEditor.SamplerNode;60;-3554.549,-707.8731;Float;True;Property;_TextureSample1;Texture Sample 1;7;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;62;-3552.317,-315.3241;Float;True;Property;_TextureSample3;Texture Sample 3;7;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;61;-3556.117,-511.0243;Float;True;Property;_TextureSample2;Texture Sample 2;7;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;107;-2416.606,-109.8476;Float;False;Constant;_Float5;Float 5;4;0;0;0;0;FLOAT
Node;AmplifyShaderEditor.SimpleMaxOp;49;-1355.665,-307.5518;Float;True;0;FLOAT;0.0;False;1;FLOAT;0.0;False;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;45;-1275.935,454.3992;Float;False;Constant;_Float4;Float 4;5;0;1;0;0;FLOAT
Node;AmplifyShaderEditor.SummedBlendNode;70;-3115.521,-661.3244;Float;False;0;FLOAT3;0.0;False;1;FLOAT4;0.0;False;2;FLOAT4;0.0;False;3;FLOAT4;0.0;False;4;FLOAT;0.0;False;FLOAT4
Node;AmplifyShaderEditor.SummedBlendNode;84;-3004.18,689.0815;Float;False;0;FLOAT3;0.0;False;1;FLOAT4;0.0;False;2;FLOAT4;0.0;False;3;FLOAT4;0.0;False;4;FLOAT;0.0;False;FLOAT4
Node;AmplifyShaderEditor.TFHCRemap;106;-2189.307,-208.9478;Float;False;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT4;2,2,2,2;False;3;FLOAT4;0,0,0,0;False;4;FLOAT4;1,1,1,1;False;FLOAT4
Node;AmplifyShaderEditor.SimpleAddOpNode;93;-2416.414,-218.2251;Float;False;0;FLOAT4;0.0,0,0,0;False;1;FLOAT4;0,0,0,0;False;FLOAT4
Node;AmplifyShaderEditor.RangedFloatNode;25;-1025.93,723.3414;Float;False;Constant;_Float0;Float 0;2;0;1;0;0;FLOAT
Node;AmplifyShaderEditor.PannerNode;75;-4033.69,991.3409;Float;False;-1;-1;0;FLOAT2;0,0;False;1;FLOAT;0.0;False;FLOAT2
Node;AmplifyShaderEditor.DotProductOpNode;89;-1472.565,-773.9514;Float;False;0;FLOAT;0.0;False;1;FLOAT;0.0;False;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;44;-1283.935,371.3992;Float;False;Constant;_Float3;Float 3;5;0;0;0;0;FLOAT
Node;AmplifyShaderEditor.WorldPosInputsNode;53;-1719.264,-267.1512;Float;False;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;41;-431.4335,465.0989;Float;False;0;FLOAT3;0,0,0;False;1;FLOAT3;0.0,0,0,0;False;FLOAT3
Node;AmplifyShaderEditor.SimpleMaxOp;54;-1051.467,-319.3512;Float;True;0;FLOAT;0.0;False;1;FLOAT;1.0;False;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;27;-611.6304,603.9404;Float;False;0;FLOAT3;0,0,0;False;1;FLOAT3;0.0,0,0;False;FLOAT3
Node;AmplifyShaderEditor.TFHCRemap;22;-1009.182,-61.49509;Float;False;0;FLOAT;0.0;False;1;FLOAT;-1.5;False;2;FLOAT;1.5;False;3;FLOAT;0.0;False;4;FLOAT;1.0;False;FLOAT
Node;AmplifyShaderEditor.Vector3Node;91;-1736.564,-773.9513;Float;False;Constant;_Vector1;Vector 1;9;0;0,0,0;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;100;-3136.104,-183.2492;Float;False;Constant;_Float9;Float 9;9;0;1;0;0;FLOAT
Node;AmplifyShaderEditor.PannerNode;78;-4035.475,836.5814;Float;False;0;0;0;FLOAT2;0,0;False;1;FLOAT;0.0;False;FLOAT2
Node;AmplifyShaderEditor.PannerNode;76;-4052.472,673.3813;Float;False;-1;1;0;FLOAT2;0,0;False;1;FLOAT;0.0;False;FLOAT2
Node;AmplifyShaderEditor.SamplerNode;81;-3535.875,772.5819;Float;True;Property;_TextureSample4;Texture Sample 4;7;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;83;-3532.075,968.2818;Float;True;Property;_TextureSample6;Texture Sample 6;7;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.Vector3Node;24;-1492.731,708.1408;Float;False;Constant;_Vector0;Vector 0;2;0;0,0,1;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;99;-3137.704,-307.4492;Float;False;Constant;_Float8;Float 8;9;0;0;0;0;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;-804.7014,814.2002;Float;False;0;FLOAT;0.0;False;1;FLOAT;0,0,0,0;False;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;134;-3229.83,321.6975;Float;False;0;FLOAT3;0.0;False;1;FLOAT;0.0,0,0;False;FLOAT3
Node;AmplifyShaderEditor.SamplerNode;82;-3534.306,575.7331;Float;True;Property;_TextureSample5;Texture Sample 5;7;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;135;-3473.631,398.4976;Float;False;Constant;_Float6;Float 6;6;0;-1;0;0;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;109;-2396.106,50.65234;Float;False;Constant;_Float11;Float 11;4;0;1;0;0;FLOAT
Node;AmplifyShaderEditor.ClampOpNode;92;-1307.765,-774.7512;Float;False;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;FLOAT
Node;AmplifyShaderEditor.ClampOpNode;98;-2861.003,-143.9493;Float;False;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;FLOAT4
Node;AmplifyShaderEditor.WorldNormalVector;90;-1752.564,-929.9515;Float;False;0;FLOAT3;0,0,0;False;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;26;-841.5305,587.1404;Float;False;0;FLOAT3;0.0;False;1;FLOAT;0,0,0;False;FLOAT3
Node;AmplifyShaderEditor.RangedFloatNode;108;-2405.406,-27.04763;Float;False;Constant;_Float10;Float 10;4;0;2;0;0;FLOAT
Node;AmplifyShaderEditor.ClampOpNode;97;-2861.604,-439.1492;Float;False;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;FLOAT4
Node;AmplifyShaderEditor.RangedFloatNode;43;-1281.935,286.3992;Float;False;Property;_Float2;Float 2;5;0;0;0;0;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;42;-1294.935,210.3992;Float;False;Property;_Float1;Float 1;5;0;0;0;0;FLOAT
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-236.5,-267.4;Float;False;True;6;Float;ASEMaterialInspector;0;Unlit;Tim/Dither;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Custom;0.5;True;True;0;True;Transparent;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;True;0;4;10;30;False;0.5;True;0;Zero;Zero;0;Zero;Zero;Add;Add;0;False;0;0,0,0,0;VertexOffset;False;Cylindrical;Relative;0;;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;OBJECT;0.0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;13;OBJECT;0.0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False
WireConnection;59;0;122;1
WireConnection;59;1;122;2
WireConnection;58;0;122;3
WireConnection;58;1;122;1
WireConnection;57;0;122;2
WireConnection;57;1;122;3
WireConnection;112;0;59;0
WireConnection;112;1;113;0
WireConnection;125;0;66;0
WireConnection;110;0;57;0
WireConnection;110;1;113;0
WireConnection;111;0;58;0
WireConnection;111;1;113;0
WireConnection;119;0;120;0
WireConnection;155;0;125;0
WireConnection;155;1;156;0
WireConnection;71;0;110;0
WireConnection;71;1;119;0
WireConnection;72;0;111;0
WireConnection;72;1;119;0
WireConnection;73;0;112;0
WireConnection;73;1;119;0
WireConnection;158;0;155;0
WireConnection;60;0;63;0
WireConnection;60;1;71;0
WireConnection;62;0;63;0
WireConnection;62;1;73;0
WireConnection;61;0;63;0
WireConnection;61;1;72;0
WireConnection;70;0;158;0
WireConnection;70;1;60;0
WireConnection;70;2;61;0
WireConnection;70;3;62;0
WireConnection;84;0;134;0
WireConnection;84;1;82;0
WireConnection;84;2;81;0
WireConnection;84;3;83;0
WireConnection;106;0;93;0
WireConnection;106;1;107;0
WireConnection;106;2;108;0
WireConnection;106;3;107;0
WireConnection;106;4;109;0
WireConnection;93;0;97;0
WireConnection;93;1;98;0
WireConnection;75;0;112;0
WireConnection;75;1;119;0
WireConnection;89;0;90;1
WireConnection;89;1;91;1
WireConnection;41;1;27;0
WireConnection;54;0;53;2
WireConnection;27;0;26;0
WireConnection;22;0;53;2
WireConnection;22;1;42;0
WireConnection;22;2;43;0
WireConnection;22;3;44;0
WireConnection;22;4;45;0
WireConnection;78;0;111;0
WireConnection;78;1;119;0
WireConnection;76;0;110;0
WireConnection;76;1;119;0
WireConnection;81;0;63;0
WireConnection;81;1;78;0
WireConnection;83;0;63;0
WireConnection;83;1;75;0
WireConnection;13;1;22;0
WireConnection;134;0;66;0
WireConnection;134;1;135;0
WireConnection;82;0;63;0
WireConnection;82;1;76;0
WireConnection;98;0;84;0
WireConnection;98;1;99;0
WireConnection;98;2;100;0
WireConnection;26;0;24;0
WireConnection;26;1;25;0
WireConnection;97;0;70;0
WireConnection;97;1;99;0
WireConnection;97;2;100;0
WireConnection;0;2;70;0
ASEEND*/
//CHKSM=50E5A36A98EB1400CB4EC52717D598AE020D3356