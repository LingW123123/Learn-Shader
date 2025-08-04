Shader "Custom/ShaderProperties"
{
    Properties
    {
        //numbers
        _Int ("Int", Int) = 1
        _Float ("Float", Float) = 1.0
        _Range ("Range", Range(0.0, 1.0)) = 0.5

        //colors
        _Color ("Color", Color) = (1.0, 1.0, 1.0, 1.0)
        _Vector ("Vector", Vector) = (2.0, 5.0, 3.0)
        
        //textures
        _2D ("2D", 2D) = "White" {}
        _Cube ("Cube", Cube) = "White" {}
        _3D ("3D", 3D) = "black" {}
    }

    SubShader
    {
        Pass
        {
            
        }
    }

    FallBack "Diffuse"
}
