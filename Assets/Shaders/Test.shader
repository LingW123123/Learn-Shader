Shader "Noob/Test"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        Cull Off

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct a2v
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                float3 normal : NORMAL;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float2 uv : TEXCOORD0;
                float3 worldNormal : TEXCOORD1;
                float3 worldPos : TEXCOORD2;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert (a2v v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                
                o.worldNormal = UnityObjectToWorldNormal(v.normal);
                o.worldPos = mul(UNITY_MATRIX_M, v.vertex).xyz;

                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed3 viewDir = normalize(UnityWorldSpaceViewDir(i.worldPos));
                float frontFace = dot(i.worldNormal, viewDir);
                if (frontFace > 0) // 正面
                    return fixed4(1, 1, 1, 1); // 白色
                else // 背面
                    return fixed4(1, 0, 0, 1); // 红色
            }

            ENDCG
        }

        Pass
        {
            Cull Front
            CGPROGRAM

            #pragma vertex vert
            #pragma fragment frag
            
            #include "UnityCG.cginc"

            struct a2v
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                float3 normal : NORMAL;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float2 uv : TEXCOORD0;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            
            v2f vert (a2v v)
            {
                v2f o;

                float3 viewPos = UnityObjectToViewPos(v.vertex);
                float3 viewNormal = mul((float3x3)UNITY_MATRIX_IT_MV, v.normal);
                viewNormal.z = -0.001;
                viewPos = viewPos + normalize(viewNormal) * 1.0 * 0.002;

                o.vertex = mul(UNITY_MATRIX_P, float4(viewPos, 1.0));
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);

                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                half3 col = tex2D(_MainTex, i.uv) * half3(0.0, 0.0, 0.0);
                return half4(col, 1.0);
            }

            ENDCG
        }
    }
}