// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Tim/Dots"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
		_Vector4("Vector 4", Vector) = (10,10,0,0)
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_TimeOffset("Time Offset", Float) = 0
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
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
			float4 screenPos;
			float3 viewDir;
			INTERNAL_DATA
			float3 worldNormal;
		};

		uniform sampler2D _TextureSample0;
		uniform float2 _Vector4;
		uniform float _TimeOffset;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 componentMask76 = i.screenPos.xy;
			float4 appendResult75 = float4( ( _ScreenParams.x / _ScreenParams.y ) , 1 , 0 , 0 );
			float mulTime85 = _Time.y * 0.1;
			float2 componentMask63 = i.screenPos.xy;
			float4 appendResult67 = float4( ( _ScreenParams.x / _ScreenParams.y ) , 1 , 0 , 0 );
			o.Emission = tex2D( _TextureSample0,lerp( ( float4( ( componentMask76 / max( i.screenPos.w , 0.01 ) ), 0.0 , 0.0 ) * ( appendResult75 * float4( _Vector4, 0.0 , 0.0 ) ) ) , float4( (abs( ( float4( ( componentMask63 / max( i.screenPos.w , 0.01 ) ), 0.0 , 0.0 ) * ( appendResult67 * float4( float2( 5,5 ), 0.0 , 0.0 ) ) ).xy+( mulTime85 + _TimeOffset ) * float2(1,1 ))), 0.0 , 0.0 ) , ( 1.0 - dot( i.viewDir , i.worldNormal ) ) ).xy).rgb;
			o.Alpha = 1;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha 

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
				fixed3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				fixed3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
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
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				fixed3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.viewDir = worldViewDir;
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
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
15;540;1906;1004;3169.813;-1728.767;1;True;True
Node;AmplifyShaderEditor.CommentaryNode;69;-3231.035,1300.467;Float;False;1013.419;702.6989;Screen Mapping;10;60;64;68;63;62;67;66;61;65;59;
Node;AmplifyShaderEditor.CommentaryNode;71;-3228.434,2023.004;Float;False;1013.419;702.6989;Screen Mapping;10;81;80;79;78;77;76;75;74;73;72;
Node;AmplifyShaderEditor.ScreenParams;65;-3181.035,1632.866;Float;False;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.ScreenParams;72;-3178.434,2355.403;Float;False;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleDivideOpNode;66;-2980.435,1660.766;Float;False;0;FLOAT;0.0;False;1;FLOAT;0.0;False;FLOAT
Node;AmplifyShaderEditor.ScreenPosInputsNode;61;-3052.617,1417.167;Float;False;1;False;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleDivideOpNode;74;-2977.834,2383.304;Float;False;0;FLOAT;0.0;False;1;FLOAT;0.0;False;FLOAT
Node;AmplifyShaderEditor.ScreenPosInputsNode;73;-3050.016,2139.704;Float;False;1;False;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMaxOp;62;-2813.42,1565.066;Float;False;0;FLOAT;0.0;False;1;FLOAT;0.01;False;FLOAT
Node;AmplifyShaderEditor.ComponentMaskNode;63;-2849.618,1350.467;Float;True;True;True;False;False;0;FLOAT4;0,0,0,0;False;FLOAT2
Node;AmplifyShaderEditor.AppendNode;67;-2812.735,1699.766;Float;False;FLOAT4;0;1;0;0;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;FLOAT4
Node;AmplifyShaderEditor.Vector2Node;59;-2820.518,1860.165;Float;False;Constant;_Vector3;Vector 3;-1;0;5,5;FLOAT2;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleDivideOpNode;64;-2553.919,1528.066;Float;False;0;FLOAT2;0.0,0;False;1;FLOAT;0.0,0;False;FLOAT2
Node;AmplifyShaderEditor.WorldNormalVector;45;-2448.935,1062.465;Float;True;0;FLOAT3;0,0,0;False;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMaxOp;78;-2810.819,2287.603;Float;False;0;FLOAT;0.0;False;1;FLOAT;0.01;False;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;88;-2188.802,1855.848;Float;False;Property;_TimeOffset;Time Offset;1;0;0;0;0;FLOAT
Node;AmplifyShaderEditor.SimpleTimeNode;85;-2192.64,1695.06;Float;False;0;FLOAT;0.1;False;FLOAT
Node;AmplifyShaderEditor.Vector2Node;77;-2843.917,2563.703;Float;False;Property;_Vector4;Vector 4;-1;0;10,10;FLOAT2;FLOAT;FLOAT
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;40;-2375.135,903.2661;Float;False;World;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;68;-2615.736,1685.466;Float;False;0;FLOAT4;0.0;False;1;FLOAT2;0,0,0,0;False;FLOAT4
Node;AmplifyShaderEditor.AppendNode;75;-2810.134,2422.304;Float;False;FLOAT4;0;1;0;0;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;FLOAT4
Node;AmplifyShaderEditor.ComponentMaskNode;76;-2847.017,2073.004;Float;True;True;True;False;False;0;FLOAT4;0,0,0,0;False;FLOAT2
Node;AmplifyShaderEditor.SimpleAddOpNode;87;-1960.88,1754.151;Float;False;0;FLOAT;0.0;False;1;FLOAT;10.0;False;FLOAT
Node;AmplifyShaderEditor.DotProductOpNode;42;-2172.034,965.3658;Float;True;0;FLOAT3;0,0,0;False;1;FLOAT3;0.0;False;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;79;-2582.135,2406.003;Float;False;0;FLOAT4;0.0;False;1;FLOAT2;0,0,0,0;False;FLOAT4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;60;-2386.616,1601.267;Float;False;0;FLOAT2;0.0,0;False;1;FLOAT4;0.0,0;False;FLOAT4
Node;AmplifyShaderEditor.SimpleDivideOpNode;80;-2551.319,2250.603;Float;False;0;FLOAT2;0.0,0;False;1;FLOAT;0.0,0;False;FLOAT2
Node;AmplifyShaderEditor.PannerNode;84;-1880.138,1560.96;Float;False;1;1;0;FLOAT2;0,0;False;1;FLOAT;0.0;False;FLOAT2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;81;-2384.015,2323.804;Float;False;0;FLOAT2;0.0,0;False;1;FLOAT4;0.0,0;False;FLOAT4
Node;AmplifyShaderEditor.OneMinusNode;44;-1889.235,958.1663;Float;True;0;FLOAT;0.0;False;FLOAT
Node;AmplifyShaderEditor.LerpOp;47;-1476.034,1455.965;Float;False;0;FLOAT4;0.0,0,0,0;False;1;FLOAT2;0,0,0,0;False;2;FLOAT;0.0;False;FLOAT4
Node;AmplifyShaderEditor.SamplerNode;50;-1178.358,1426.212;Float;True;Property;_TextureSample0;Texture Sample 0;1;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-765.3182,1396.617;Float;False;True;2;Float;ASEMaterialInspector;0;Standard;Tim/Dots;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;False;0;4;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;Add;Add;0;False;0;0,0,0,0;VertexOffset;False;Cylindrical;Relative;0;;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;OBJECT;0.0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;13;OBJECT;0.0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False
WireConnection;66;0;65;1
WireConnection;66;1;65;2
WireConnection;74;0;72;1
WireConnection;74;1;72;2
WireConnection;62;0;61;4
WireConnection;63;0;61;0
WireConnection;67;0;66;0
WireConnection;64;0;63;0
WireConnection;64;1;62;0
WireConnection;78;0;73;4
WireConnection;68;0;67;0
WireConnection;68;1;59;0
WireConnection;75;0;74;0
WireConnection;76;0;73;0
WireConnection;87;0;85;0
WireConnection;87;1;88;0
WireConnection;42;0;40;0
WireConnection;42;1;45;0
WireConnection;79;0;75;0
WireConnection;79;1;77;0
WireConnection;60;0;64;0
WireConnection;60;1;68;0
WireConnection;80;0;76;0
WireConnection;80;1;78;0
WireConnection;84;0;60;0
WireConnection;84;1;87;0
WireConnection;81;0;80;0
WireConnection;81;1;79;0
WireConnection;44;0;42;0
WireConnection;47;0;81;0
WireConnection;47;1;84;0
WireConnection;47;2;44;0
WireConnection;50;1;47;0
WireConnection;0;2;50;0
ASEEND*/
//CHKSM=1816B2786008A1EF44429EF3C2A4B8DC73242278