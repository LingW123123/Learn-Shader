Shader "Noob/ToonOpaque"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Color("Main Color", Color) = (1.0, 1.0, 1.0, 1.0)
        _GradientMap("Gradient Map", 2D) = "white" {}

        _ShadowColor1stTex("1st Shadow Color Tex", 2D) = "white" {}
        _ShadowColor1st("1st Shadow Color", Color) = (1.0, 1.0, 1.0, 1.0)
        _ShadowColor2ndTex("1st Shadow Color Tex", 2D) = "white" {}
        _ShadowColor2nd("1st Shadow Color", Color) = (1.0, 1.0, 1.0, 1.0)

        [HDR] _SpecularColor("Specular Color", Color) = (0.0, 0.0, 0.0, 1.0)
        _SpecularPower("Specular Power", Float) = 20.0

        _OutlineWith("Outline With", Range(0.0, 3.0)) = 1.0
        _OuntlineColor("Outline Color", Color) = (0.2, 0.2, 0.2, 1.0)

    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        Pass
        {
            Tags { "LightMode" = "ForwardBase" }
            Cull Back


            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_fwdbase

            #include "UnityCG.cginc"

            #define IS_OPAQUE
            #include "ShadingCommon.cginc"

            ENDCG
        }

        Pass
        {
            Tags { "LightMode" = "ForwardBase" }

            Cull Front

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_fwdbase

            #include "UnityCG.cginc"

            #define IS_OPAQUE
            #include "OutlineCommon.cginc"
            
            ENDCG
        }
    }
}
