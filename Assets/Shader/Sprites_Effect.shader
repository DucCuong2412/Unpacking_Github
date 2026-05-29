Shader "Sprites/Effect"
{
    Properties
    {
        [PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
        _Color ("Tint", Color) = (1,1,1,1)
        [MaterialToggle] PixelSnap ("Pixel snap", Float) = 0
        [HideInInspector] _RendererColor ("RendererColor", Color) = (1,1,1,1)
        [HideInInspector] _Flip ("Flip", Vector) = (1,1,1,1)
        [PerRendererData] _AlphaTex ("External Alpha", 2D) = "white" {}
        [PerRendererData] _EnableExternalAlpha ("Enable External Alpha", Float) = 0
    }

    SubShader
    {
        Tags
        {
            "Queue"            = "Transparent"
            "IgnoreProjector"  = "True"
            "RenderType"       = "Transparent"
            "PreviewType"      = "Plane"
            "CanUseSpriteAtlas"= "True"
        }

        Cull Off
        Lighting Off
        ZWrite Off
        Blend One OneMinusSrcAlpha   // premultiplied alpha (giống bản gốc)

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma target 2.0
            #pragma multi_compile_instancing
            #pragma multi_compile_local _ PIXELSNAP_ON
            #pragma multi_compile _ ETC1_EXTERNAL_ALPHA
            #include "UnityCG.cginc"

            struct appdata_t
            {
                float4 vertex   : POSITION;
                float4 color    : COLOR;
                float2 texcoord : TEXCOORD0;
                UNITY_VERTEX_INPUT_INSTANCE_ID
            };

            struct v2f
            {
                float4 vertex   : SV_POSITION;
                fixed4 color    : COLOR;
                float2 texcoord : TEXCOORD0;
                UNITY_VERTEX_OUTPUT_STEREO
            };

            fixed4 _Color;
            fixed4 _RendererColor;

            v2f vert(appdata_t IN)
            {
                v2f OUT;
                UNITY_SETUP_INSTANCE_ID(IN);
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(OUT);

                OUT.vertex   = UnityObjectToClipPos(IN.vertex);
                OUT.texcoord = IN.texcoord;
                OUT.color    = IN.color * _Color * _RendererColor;

                #ifdef PIXELSNAP_ON
                OUT.vertex = UnityPixelSnap(OUT.vertex);
                #endif

                return OUT;
            }

            sampler2D _MainTex;
            sampler2D _AlphaTex;
            float _EnableExternalAlpha;

            fixed4 SampleSpriteTexture(float2 uv)
            {
                fixed4 color = tex2D(_MainTex, uv);
                #if ETC1_EXTERNAL_ALPHA
                    fixed4 alpha = tex2D(_AlphaTex, uv);
                    color.a = lerp(color.a, alpha.r, _EnableExternalAlpha);
                #endif
                return color;
            }

            fixed4 frag(v2f IN) : SV_Target
            {
                // Alpha của sprite tại UV gốc
                float a = SampleSpriteTexture(IN.texcoord).a;

                // Mask cứng: alpha > 0 -> 1, ngược lại 0
                float mask = a > 0.0 ? 1.0 : 0.0;

                // Vertex color (red) + alpha lái việc lookup ngang vào dải gradient
                // nằm trong chính _MainTex (hàng giữa, v = 0.5)
                float u = IN.color.r * 1.5 + a * 0.25 - 0.5;
                fixed3 ramp = tex2D(_MainTex, float2(u, 0.5)).rgb;

                // rgb đã premultiply bằng mask (= alpha xuất ra) -> khớp blend mode
                return fixed4(ramp * mask, mask);
            }
            ENDCG
        }
    }

    Fallback "Sprites/Default"
}
