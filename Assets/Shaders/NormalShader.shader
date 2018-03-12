Shader "Custom/Normal"
{
	Properties
	{
		_Ka("Ambient Color", Color) = (0, 0, 0, 1)
		_Kd("Diffuse Color", Color) = (0, 0, 0, 1)
		_Ks("Specular Color", Color) = (0, 0, 0, 1)
		_Alpha("Shiness", float) = 10
	}

		SubShader
	{
		Tags {
			"LightMode" = "ForwardBase"
		}

		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"
			#include "UnityLightingCommon.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float3 worldNormal: TEXCOORD0;
				float4 vertexWorld: TEXCOORD1;
			};

			float4 _Ka;
			float4 _Kd;
			float4 _Ks;
			float _Alpha;

			v2f vert(appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.vertexWorld = mul(unity_ObjectToWorld, v.vertex);
				o.worldNormal = UnityObjectToWorldNormal(v.normal);
				return o;
			}

			fixed4 frag(v2f i) : SV_Target
			{
				float3 normal = normalize(i.worldNormal);
                fixed4 color = fixed4(normal, 1);
                return color;
			}

			ENDCG
		}

	}
}
