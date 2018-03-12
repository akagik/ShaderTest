Shader "Custom/AmbientShader"
{
	Properties
	{
		_Ka ("Ambient Color", Color) = (1, 0, 0, 1)
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
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
			};

			float4 _Ka;

			v2f vert(appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				return o;
			}

			fixed4 frag(v2f i) : SV_Target
			{
				float4 ambientTerm = _Ka * _LightColor0;
				return ambientTerm;
			}

			ENDCG
		}
	}
}
