// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/Gradient_2Color" {
	Properties
	{
	 _TopColor("Top Color", Color) = (1, 1, 1, 1)
	 _BottomColor("Bottom Color", Color) = (1, 1, 1, 1)

	 _AdditiveTex("Additive Texture", 2D) = "white"{}
	}

	SubShader
	{
		Pass
		{
			 Blend SrcAlpha OneMinusSrcAlpha

			 CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag

			struct vertexIn {
				float4 pos : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f {
				float4 pos : SV_POSITION;
				float2 uv : TEXCOORD0;
			};

			v2f vert(vertexIn input)
			{
				v2f output;
				output.pos = UnityObjectToClipPos(input.pos);
				output.uv = input.uv;
				return output;
			}

			fixed4 _TopColor, _BottomColor;
			sampler2D _AdditiveTex;

			fixed4 frag(v2f input) : COLOR
			{ 
				fixed4 addTexColor = tex2D(_AdditiveTex, input.uv);
				fixed4 color = lerp(_BottomColor, _TopColor, input.uv.y);
			
				return color * addTexColor;
			}
			ENDCG
		}
	}
}
