Shader "FMVTexture"
{
    Properties
    {
        _MainTex   ("Luminance Texture", 2D) = "black" {}
        _ChromaTex ("Chroma Texture", 2D)    = "green" {}
    }

    SubShader
    {
        Tags { "RenderType"="Opaque" }
        Cull Off
        Lighting Off
        ZWrite On

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma target 2.0
            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex   : POSITION;
                float2 texcoord : TEXCOORD0;
            };

            struct v2f
            {
                float4 pos : SV_POSITION;
                float2 uv  : TEXCOORD0;
            };

            sampler2D _MainTex;
            float4    _MainTex_ST;
            sampler2D _ChromaTex;

            v2f vert(appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv  = TRANSFORM_TEX(v.texcoord, _MainTex);
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                // Guard: UV ngoài [0,1] -> tô đỏ (letterbox / out of frame)
                if (i.uv.x < 0.0 || i.uv.y < 0.0 || i.uv.x > 1.0 || i.uv.y > 1.0)
                    return fixed4(1.0, 0.0, 0.0, 1.0);

                // YCbCr (BT.709, limited range)
                float Y  = tex2D(_MainTex,   i.uv).r - 0.0625;          // - 16/256 (black level)
                float2 C = tex2D(_ChromaTex, i.uv).rg - 0.5;            // Cb, Cr center
                float Cb = C.x;
                float Cr = C.y;

                float3 rgb;
                rgb.r = dot(float2(1.16440, 1.79270),          float2(Y, Cr));
                rgb.g = dot(float3(1.16440, -0.21330, -0.53290), float3(Y, Cb, Cr));
                rgb.b = dot(float2(1.16440, 2.11240),          float2(Y, Cb));

                return fixed4(rgb, 1.0);
            }
            ENDCG
        }
    }
}