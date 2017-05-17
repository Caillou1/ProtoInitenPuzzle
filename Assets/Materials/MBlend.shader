// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Tim/MBlend"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
		_AlbedoA("Albedo A", 2D) = "gray" {}
		_NormalA("Normal A", 2D) = "bump" {}
		_MetallicA("Metallic A", 2D) = "gray" {}
		_SmoothnessA("Smoothness A", 2D) = "gray" {}
		_AlbedoB("Albedo B", 2D) = "gray" {}
		_NormalB("Normal B", 2D) = "bump" {}
		_MetallicB("Metallic B", 2D) = "black" {}
		_SmoothnessB("Smoothness B", 2D) = "gray" {}
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float2 texcoord_0;
			float4 vertexColor : COLOR;
		};

		uniform sampler2D _NormalA;
		uniform sampler2D _NormalB;
		uniform sampler2D _AlbedoA;
		uniform sampler2D _AlbedoB;
		uniform sampler2D _MetallicA;
		uniform sampler2D _MetallicB;
		uniform sampler2D _SmoothnessA;
		uniform sampler2D _SmoothnessB;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			o.texcoord_0.xy = v.texcoord.xy * float2( 1,1 ) + float2( 0,0 );
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			o.Normal = lerp( UnpackNormal( tex2D( _NormalA,i.texcoord_0) ) , UnpackNormal( tex2D( _NormalB,i.texcoord_0) ) , i.vertexColor.r );
			o.Albedo = lerp( tex2D( _AlbedoA,i.texcoord_0) , tex2D( _AlbedoB,i.texcoord_0) , i.vertexColor.r ).rgb;
			o.Metallic = lerp( tex2D( _MetallicA,i.texcoord_0) , tex2D( _MetallicB,i.texcoord_0) , i.vertexColor.r ).r;
			o.Smoothness = lerp( tex2D( _SmoothnessA,i.texcoord_0) , tex2D( _SmoothnessB,i.texcoord_0) , i.vertexColor.r ).r;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=7003
7;29;1906;1004;1936.403;324.9998;1.7;True;True
Node;AmplifyShaderEditor.TextureCoordinatesNode;15;-1167.702,542.1004;Float;False;0;-1;2;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;FLOAT2;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;5;-806.2,-154.2;Float;True;Property;_AlbedoB;Albedo B;4;0;None;True;0;False;gray;Auto;False;Object;-1;Auto;Texture2D;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;7;-787.8336,46.30011;Float;True;Property;_NormalA;Normal A;1;0;None;True;0;False;bump;Auto;True;Object;-1;Auto;Texture2D;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;13;-774.1349,823.7999;Float;True;Property;_SmoothnessA;Smoothness A;3;0;None;True;0;False;gray;Auto;False;Object;-1;Auto;Texture2D;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;4;-806.2,-343.2;Float;True;Property;_AlbedoA;Albedo A;0;0;None;True;0;False;gray;Auto;False;Object;-1;Auto;Texture2D;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;8;-787.8336,235.3001;Float;True;Property;_NormalB;Normal B;5;0;None;True;0;False;bump;Auto;True;Object;-1;Auto;Texture2D;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;11;-776.0347,621.3996;Float;True;Property;_MetallicB;Metallic B;6;0;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.VertexColorNode;1;-1153.3,261.1998;Float;False;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;10;-776.0347,432.4001;Float;True;Property;_MetallicA;Metallic A;2;0;None;True;0;False;gray;Auto;False;Object;-1;Auto;Texture2D;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;14;-774.1349,1012.8;Float;True;Property;_SmoothnessB;Smoothness B;7;0;None;True;0;False;gray;Auto;False;Object;-1;Auto;Texture2D;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.LerpOp;2;-376.2,-214.2;Float;False;0;COLOR;0.0;False;1;COLOR;0.0,0,0,0;False;2;FLOAT;0.0;False;COLOR
Node;AmplifyShaderEditor.LerpOp;9;-346.0346,561.3996;Float;False;0;COLOR;0.0;False;1;COLOR;0.0,0,0,0;False;2;FLOAT;0.0;False;COLOR
Node;AmplifyShaderEditor.LerpOp;12;-344.1347,952.7998;Float;False;0;COLOR;0.0;False;1;COLOR;0.0,0,0,0;False;2;FLOAT;0.0;False;COLOR
Node;AmplifyShaderEditor.LerpOp;6;-357.8346,175.3001;Float;False;0;FLOAT3;0.0;False;1;FLOAT3;0.0,0,0,0;False;2;FLOAT;0.0;False;FLOAT3
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;176,161;Float;False;True;2;Float;ASEMaterialInspector;0;Standard;Tim/MBlend;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;False;0;4;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;Add;Add;0;False;0;0,0,0,0;VertexOffset;False;Cylindrical;Relative;0;;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;OBJECT;0.0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;13;OBJECT;0.0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False
WireConnection;5;1;15;0
WireConnection;7;1;15;0
WireConnection;13;1;15;0
WireConnection;4;1;15;0
WireConnection;8;1;15;0
WireConnection;11;1;15;0
WireConnection;10;1;15;0
WireConnection;14;1;15;0
WireConnection;2;0;4;0
WireConnection;2;1;5;0
WireConnection;2;2;1;1
WireConnection;9;0;10;0
WireConnection;9;1;11;0
WireConnection;9;2;1;1
WireConnection;12;0;13;0
WireConnection;12;1;14;0
WireConnection;12;2;1;1
WireConnection;6;0;7;0
WireConnection;6;1;8;0
WireConnection;6;2;1;1
WireConnection;0;0;2;0
WireConnection;0;1;6;0
WireConnection;0;3;9;0
WireConnection;0;4;12;0
ASEEND*/
//CHKSM=3E352693E458F46C18CF0567D9A5ECD1BFB8C9C6