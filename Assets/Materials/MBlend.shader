// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Tim/MBlend"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
		_AlbedoA("Albedo A", 2D) = "gray" {}
		_NormalA("Normal A", 2D) = "bump" {}
		_MetallicA("Metallic A", 2D) = "black" {}
		_SmoothnessA("Smoothness A", 2D) = "black" {}
		_AlbedoB("Albedo B", 2D) = "gray" {}
		_NormalB("Normal B", 2D) = "bump" {}
		_MetallicB("Metallic B", 2D) = "black" {}
		_SmoothnessB("Smoothness B", 2D) = "black" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#pragma target 4.6
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
		};

		uniform sampler2D _NormalA;
		uniform float4 _NormalA_ST;
		uniform sampler2D _NormalB;
		uniform float4 _NormalB_ST;
		uniform sampler2D _AlbedoA;
		uniform float4 _AlbedoA_ST;
		uniform sampler2D _AlbedoB;
		uniform float4 _AlbedoB_ST;
		uniform sampler2D _MetallicA;
		uniform float4 _MetallicA_ST;
		uniform sampler2D _MetallicB;
		uniform float4 _MetallicB_ST;
		uniform sampler2D _SmoothnessA;
		uniform float4 _SmoothnessA_ST;
		uniform sampler2D _SmoothnessB;
		uniform float4 _SmoothnessB_ST;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_NormalA = i.uv_texcoord * _NormalA_ST.xy + _NormalA_ST.zw;
			float2 uv_NormalB = i.uv_texcoord * _NormalB_ST.xy + _NormalB_ST.zw;
			o.Normal = lerp( UnpackNormal( tex2D( _NormalA,uv_NormalA) ) , UnpackNormal( tex2D( _NormalB,uv_NormalB) ) , i.vertexColor.r );
			float2 uv_AlbedoA = i.uv_texcoord * _AlbedoA_ST.xy + _AlbedoA_ST.zw;
			float2 uv_AlbedoB = i.uv_texcoord * _AlbedoB_ST.xy + _AlbedoB_ST.zw;
			o.Albedo = lerp( tex2D( _AlbedoA,uv_AlbedoA) , tex2D( _AlbedoB,uv_AlbedoB) , i.vertexColor.r ).rgb;
			float2 uv_MetallicA = i.uv_texcoord * _MetallicA_ST.xy + _MetallicA_ST.zw;
			float2 uv_MetallicB = i.uv_texcoord * _MetallicB_ST.xy + _MetallicB_ST.zw;
			o.Metallic = lerp( tex2D( _MetallicA,uv_MetallicA) , tex2D( _MetallicB,uv_MetallicB) , i.vertexColor.r ).r;
			float2 uv_SmoothnessA = i.uv_texcoord * _SmoothnessA_ST.xy + _SmoothnessA_ST.zw;
			float2 uv_SmoothnessB = i.uv_texcoord * _SmoothnessB_ST.xy + _SmoothnessB_ST.zw;
			o.Smoothness = lerp( tex2D( _SmoothnessA,uv_SmoothnessA) , tex2D( _SmoothnessB,uv_SmoothnessB) , i.vertexColor.r ).r;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=7003
7;130;1906;903;1463.703;373.2996;1.7;True;True
Node;AmplifyShaderEditor.SamplerNode;7;-787.8336,46.30011;Float;True;Property;_NormalA;Normal A;1;0;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;5;-806.2,-154.2;Float;True;Property;_AlbedoB;Albedo B;4;0;None;True;0;False;gray;Auto;False;Object;-1;Auto;Texture2D;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.VertexColorNode;1;-1153.3,261.1998;Float;False;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;4;-806.2,-343.2;Float;True;Property;_AlbedoA;Albedo A;0;0;None;True;0;False;gray;Auto;False;Object;-1;Auto;Texture2D;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;10;-777.4348,432.4001;Float;True;Property;_MetallicA;Metallic A;2;0;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;11;-776.0347,621.3996;Float;True;Property;_MetallicB;Metallic B;6;0;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;13;-775.5349,823.7999;Float;True;Property;_SmoothnessA;Smoothness A;3;0;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;14;-774.1349,1012.8;Float;True;Property;_SmoothnessB;Smoothness B;7;0;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;8;-288.1332,447.3001;Float;True;Property;_NormalB;Normal B;5;0;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.LerpOp;6;-357.8346,175.3001;Float;False;0;FLOAT3;0.0;False;1;FLOAT3;0.0,0,0,0;False;2;FLOAT;0.0;False;FLOAT3
Node;AmplifyShaderEditor.LerpOp;2;-376.2,-214.2;Float;False;0;COLOR;0.0;False;1;COLOR;0.0,0,0,0;False;2;FLOAT;0.0;False;COLOR
Node;AmplifyShaderEditor.LerpOp;9;-353.0347,531.9997;Float;False;0;COLOR;0.0;False;1;COLOR;0.0,0,0,0;False;2;FLOAT;0.0;False;COLOR
Node;AmplifyShaderEditor.LerpOp;12;-344.1347,952.7998;Float;False;0;COLOR;0.0;False;1;COLOR;0.0,0,0,0;False;2;FLOAT;0.0;False;COLOR
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;176,161;Float;False;True;6;Float;ASEMaterialInspector;0;Standard;Tim/MBlend;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;False;0;4;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;Add;Add;0;False;0;0,0,0,0;VertexOffset;False;Cylindrical;Relative;0;;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;OBJECT;0.0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;13;OBJECT;0.0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False
WireConnection;6;0;7;0
WireConnection;6;1;8;0
WireConnection;6;2;1;1
WireConnection;2;0;4;0
WireConnection;2;1;5;0
WireConnection;2;2;1;1
WireConnection;9;0;10;0
WireConnection;9;1;11;0
WireConnection;9;2;1;1
WireConnection;12;0;13;0
WireConnection;12;1;14;0
WireConnection;12;2;1;1
WireConnection;0;0;2;0
WireConnection;0;1;6;0
WireConnection;0;3;9;0
WireConnection;0;4;12;0
ASEEND*/
//CHKSM=A9ADCFFA9C2572E1471BBC95446546686B8AF86B