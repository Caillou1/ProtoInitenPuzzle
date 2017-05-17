// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Tim/Stretch"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
		_SpeedZ("SpeedZ", Float) = 10
		_SpeedX("SpeedX", Float) = 10
		_SpeedY("SpeedY", Float) = 10
		_IntensityZ("IntensityZ", Float) = 0
		_IntensityY("IntensityY", Float) = 0
		_IntensityX("IntensityX", Float) = 0
		_OffsetZ("OffsetZ", Float) = 0
		_Color0("Color 0", Color) = (0,0,0,0)
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float3 worldPos;
		};

		uniform float4 _Color0;
		uniform float _SpeedY;
		uniform float _IntensityY;
		uniform float _SpeedZ;
		uniform float _OffsetZ;
		uniform float _IntensityZ;
		uniform float _SpeedX;
		uniform float _IntensityX;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float mulTime45 = _Time.y * _SpeedZ;
			float mulTime35 = _Time.y * _SpeedX;
			float mulTime28 = _Time.y * _SpeedY;
			float temp_output_9_0 = ( ( ( sin( mulTime28 ) + 1.0 ) / 2.0 ) * _IntensityY );
			v.vertex.xyz += ( ( ( v.vertex.z * ( ( ( sin( ( mulTime45 + _OffsetZ ) ) + 1.0 ) / 2.0 ) * _IntensityZ ) ) * float3(0,0,1) ) + ( ( ( v.vertex.x * ( ( ( cos( mulTime35 ) + 1.0 ) / 2.0 ) * _IntensityX ) ) * float3(1,0,0) ) + ( ( v.vertex.y * temp_output_9_0 ) * float3(0,1,0) ) ) );
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float mulTime28 = _Time.y * _SpeedY;
			float temp_output_9_0 = ( ( ( sin( mulTime28 ) + 1.0 ) / 2.0 ) * _IntensityY );
			float3 vertexPos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			o.Emission = ( _Color0 * (0.0 + (( temp_output_9_0 * ( clamp( ( vertexPos.y * -1.0 ) , 0.0 , 1.0 ) + clamp( vertexPos.y , 0.0 , 1.0 ) ) ) - 0.0) * (1.0 - 0.0) / (temp_output_9_0 - 0.0)) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=7003
-1;547;1906;1004;1490.04;-180.1475;1.372341;True;True
Node;AmplifyShaderEditor.RangedFloatNode;30;-822.9443,592.8213;Float;False;Property;_SpeedY;SpeedY;0;0;10;0;0;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;34;-663.8511,72.9519;Float;False;Property;_SpeedX;SpeedX;0;0;10;0;0;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;44;-981.6188,-364.5544;Float;False;Property;_SpeedZ;SpeedZ;0;0;10;0;0;FLOAT
Node;AmplifyShaderEditor.SimpleTimeNode;35;-544.8528,-52.54797;Float;False;0;FLOAT;50.0;False;FLOAT
Node;AmplifyShaderEditor.SimpleTimeNode;28;-703.946,467.3214;Float;False;0;FLOAT;50.0;False;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;57;-763.6169,-331.0705;Float;False;Property;_OffsetZ;OffsetZ;6;0;0;0;0;FLOAT
Node;AmplifyShaderEditor.SimpleTimeNode;45;-791.2058,-479.8521;Float;False;0;FLOAT;50.0;False;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;55;-571.8171,-449.4152;Float;False;0;FLOAT;0.0;False;1;FLOAT;0.0;False;FLOAT
Node;AmplifyShaderEditor.CosOpNode;53;-322.3763,-45.55121;Float;False;0;FLOAT;0.0;False;FLOAT
Node;AmplifyShaderEditor.SinOpNode;29;-493.5457,469.6212;Float;False;0;FLOAT;0.0;False;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;24;-321.1451,482.6213;Float;False;0;FLOAT;0.0;False;1;FLOAT;1.0;False;FLOAT
Node;AmplifyShaderEditor.SinOpNode;46;-384.9248,-471.4312;Float;False;0;FLOAT;0.0;False;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;37;-162.0519,-37.24808;Float;False;0;FLOAT;0.0;False;1;FLOAT;1.0;False;FLOAT
Node;AmplifyShaderEditor.PosVertexDataNode;1;-1175.397,297.0341;Float;True;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleDivideOpNode;38;-15.15193,-41.14767;Float;False;0;FLOAT;0.0;False;1;FLOAT;2.0;False;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;31;-208.0234,592.3792;Float;False;Property;_IntensityY;IntensityY;1;0;0;0;0;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;33;91.04849,115.0518;Float;False;Property;_IntensityX;IntensityX;1;0;0;0;0;FLOAT
Node;AmplifyShaderEditor.SimpleDivideOpNode;25;-174.2451,478.7217;Float;False;0;FLOAT;0.0;False;1;FLOAT;2.0;False;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;65;-947.3052,957.683;Float;True;0;FLOAT;0.0;False;1;FLOAT;-1.0;False;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;47;-212.5242,-458.431;Float;False;0;FLOAT;0.0;False;1;FLOAT;1.0;False;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;39;154.2941,-46.16937;Float;False;0;FLOAT;0.0;False;1;FLOAT;1.0;False;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;43;40.57619,-306.1311;Float;False;Property;_IntensityZ;IntensityZ;1;0;0;0;0;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-4.799024,473.7;Float;False;0;FLOAT;0.0;False;1;FLOAT;1.0;False;FLOAT
Node;AmplifyShaderEditor.ClampOpNode;69;-651.5397,885.5316;Float;False;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;1.0;False;FLOAT
Node;AmplifyShaderEditor.ClampOpNode;70;-639.1882,1106.478;Float;False;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;1.0;False;FLOAT
Node;AmplifyShaderEditor.SimpleDivideOpNode;48;-65.62421,-462.3306;Float;False;0;FLOAT;0.0;False;1;FLOAT;2.0;False;FLOAT
Node;AmplifyShaderEditor.Vector3Node;10;178.4004,516.1;Float;False;Constant;_Vector0;Vector 0;0;0;0,1,0;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;49;103.8218,-467.3523;Float;False;0;FLOAT;0.0;False;1;FLOAT;1.0;False;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;177.301,366.7001;Float;False;0;FLOAT;0.0,0,0,0;False;1;FLOAT;0.0;False;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;63;-422.9499,735.8302;Float;True;0;FLOAT;0.0;False;1;FLOAT;0.0;False;FLOAT
Node;AmplifyShaderEditor.Vector3Node;40;337.4936,-3.769409;Float;False;Constant;_Vector1;Vector 1;0;0;1,0,0;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;41;336.3942,-153.1693;Float;False;0;FLOAT;0.0;False;1;FLOAT;0.0;False;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;394.4004,452.1;Float;False;0;FLOAT;0.0;False;1;FLOAT3;0.0;False;FLOAT3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;66;-46.43192,933.2689;Float;False;0;FLOAT;0.0;False;1;FLOAT;0.0;False;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;51;351.0091,-572.3797;Float;False;0;FLOAT;0.0;False;1;FLOAT;0.0;False;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;42;536.0894,-92.13533;Float;False;0;FLOAT;0.0;False;1;FLOAT3;0.0;False;FLOAT3
Node;AmplifyShaderEditor.Vector3Node;50;287.0213,-424.9524;Float;False;Constant;_Vector2;Vector 2;0;0;0,0,1;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.TFHCRemap;67;180.8061,855.8495;Float;False;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;1.0;False;3;FLOAT;0.0;False;4;FLOAT;1.0;False;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;18;717.3572,167.5934;Float;False;0;FLOAT3;0,0,0;False;1;FLOAT3;0.0;False;FLOAT3
Node;AmplifyShaderEditor.ColorNode;59;-184.2634,1097.524;Float;False;Property;_Color0;Color 0;7;0;0,0,0,0;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;52;503.0213,-488.9523;Float;False;0;FLOAT;0.0;False;1;FLOAT3;0.0;False;FLOAT3
Node;AmplifyShaderEditor.SimpleAddOpNode;54;961.8451,168.5209;Float;False;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;FLOAT3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;60;394.1943,1018.822;Float;False;0;COLOR;0.0;False;1;FLOAT;0.0,0,0,0;False;COLOR
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1285.882,-359.985;Float;False;True;2;Float;ASEMaterialInspector;0;Standard;Tim/Stretch;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;False;0;4;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;Add;Add;0;False;0;0,0,0,0;VertexOffset;False;Cylindrical;Relative;0;;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;OBJECT;0.0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;13;OBJECT;0.0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False
WireConnection;35;0;34;0
WireConnection;28;0;30;0
WireConnection;45;0;44;0
WireConnection;55;0;45;0
WireConnection;55;1;57;0
WireConnection;53;0;35;0
WireConnection;29;0;28;0
WireConnection;24;0;29;0
WireConnection;46;0;55;0
WireConnection;37;0;53;0
WireConnection;38;0;37;0
WireConnection;25;0;24;0
WireConnection;65;0;1;2
WireConnection;47;0;46;0
WireConnection;39;0;38;0
WireConnection;39;1;33;0
WireConnection;9;0;25;0
WireConnection;9;1;31;0
WireConnection;69;0;65;0
WireConnection;70;0;1;2
WireConnection;48;0;47;0
WireConnection;49;0;48;0
WireConnection;49;1;43;0
WireConnection;7;0;1;2
WireConnection;7;1;9;0
WireConnection;63;0;69;0
WireConnection;63;1;70;0
WireConnection;41;0;1;1
WireConnection;41;1;39;0
WireConnection;11;0;7;0
WireConnection;11;1;10;0
WireConnection;66;0;9;0
WireConnection;66;1;63;0
WireConnection;51;0;1;3
WireConnection;51;1;49;0
WireConnection;42;0;41;0
WireConnection;42;1;40;0
WireConnection;67;0;66;0
WireConnection;67;2;9;0
WireConnection;18;0;42;0
WireConnection;18;1;11;0
WireConnection;52;0;51;0
WireConnection;52;1;50;0
WireConnection;54;0;52;0
WireConnection;54;1;18;0
WireConnection;60;0;59;0
WireConnection;60;1;67;0
WireConnection;0;2;60;0
WireConnection;0;11;54;0
ASEEND*/
//CHKSM=A0CAD6EB5248506642484B30CD424D7D761C37D6