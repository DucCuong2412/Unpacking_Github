Shader "Unlit/Gradient"
{
    Properties
    {
        _Color ("Main Color", Color) = (1,1,1,1)
        _Amount ("Amount", Range(0, 1)) = 1
    }
    SubShader
    {
        LOD 100
        Tags { "IgnoreProjector"="True" "Queue"="Transparent" "RenderType"="Transparent" }

        Pass
        {
            Blend DstColor OneMinusSrcAlpha
            ZWrite Off
            Cull Off

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma target 2.0
            #include "UnityCG.cginc"

            float4 _Color;
            float  _Amount;

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv     : TEXCOORD0;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float4 color  : COLOR;
            };

            v2f vert(appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.color  = v.uv.y * _Color;
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                return i.color * _Amount;
            }
            ENDCG
        }
    }
}