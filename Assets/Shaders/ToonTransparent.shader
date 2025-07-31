Shader "Noob/ToonTansparent"
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
        Tags { "RenderType" = "Transparent" "Queue" = "Transparent" }

        Pass
        {
            ZWrite On
            ColorMask 0
        }

        Pass
        {
            Tags { "LightMode" = "ForwardBase" }
            Cull Back
            ZWrite Off
            Blend SrcAlpha OneMinusSrcAlpha

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_fwdbase

            #include "UnityCG.cginc"
            
            #define IS_TRANSPARENT
            #include "ShadingCommon.cginc"

            ENDCG
        }

        Pass
        {
            Tags { "LightMode" = "ForwardBase" }

            Cull Front
            Blend SrcAlpha OneMinusSrcAlpha

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_fwdbase

            #include "UnityCG.cginc"
            
            #define IS_TRANSPARENT
            #include "OutlineCommon.cginc"

            ENDCG
        }
    }
}
