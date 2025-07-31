using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ShirtLED_Animation : MonoBehaviour
{
    [SerializeField]
    private float m_TextureSpeed = 1.0f;
    [SerializeField]
    private List<Texture2D> m_Textures = new List<Texture2D>();
    [SerializeField]
    private float m_ColorSpeed = 1.0f;
    [SerializeField]
    private Gradient m_ColorGradient = new Gradient();

    private MaterialPropertyBlock m_PropertyBlock = null;
    private SkinnedMeshRenderer m_MeshRenderer = null;

    private void Awake()
    {
        m_PropertyBlock = new MaterialPropertyBlock();
        m_MeshRenderer = GetComponent<SkinnedMeshRenderer>();
    }

    private void Update()
    {
        // Animate the texture
        float textureTime = Mathf.Sin(Time.time * m_TextureSpeed) * 0.5f + 0.5f;
        float textureStep = 1.0f / m_Textures.Count;

        Texture2D texture = null;
        for(int i = 0; i < m_Textures.Count; i++)
        {
            if(textureTime < textureStep * (i + 1))
            {
                texture = m_Textures[i];
                break;
            }
        }

        texture = texture? texture : Texture2D.blackTexture;
        m_PropertyBlock.SetTexture("_MainTex", texture);
        m_PropertyBlock.SetTexture("_ShadowColor1stTex", texture);
        m_PropertyBlock.SetTexture("_ShadowColor2ndTex", texture);

        // Animate the color
        float colorTime = Mathf.Sin(Time.time * m_ColorSpeed) * 0.5f + 0.5f;

        Color color = m_ColorGradient.Evaluate(colorTime);
        m_PropertyBlock.SetColor("_Color", color);
        m_PropertyBlock.SetColor("_ShadowColor1st", color);
        m_PropertyBlock.SetColor("_ShadowColor2nd", color);

        if (m_MeshRenderer)
        {
            m_MeshRenderer.SetPropertyBlock(m_PropertyBlock);
        }
    }
}
