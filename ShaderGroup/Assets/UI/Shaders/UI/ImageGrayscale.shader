Shader "UI/ImageGrayscale"
{
    Properties
    {
		_MainTex("Texture", 2D) = "white" {}
		_Saturation("Saturation", Range(0, 1)) = 1
	}
		SubShader
		{
			Tags { "RenderType" = "Transparent" "Queue" = "Transparent" }
			AlphaToMask On
			Blend SrcAlpha OneMinusSrcAlpha

			// No culling or depth
			Cull Off ZWrite Off ZTest Always

			Pass
			{
				CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag

				#include "UnityCG.cginc"

				float _Saturation;

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            sampler2D _MainTex;

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = tex2D(_MainTex, i.uv);
                // just invert the colors
				col.a = col.a;
                col.rgb = lerp((col.r + col.g + col.b) * 0.33333, col.rgb, clamp(_Saturation, 0, 1));
                return col;
            }
            ENDCG
        }
    }
}
