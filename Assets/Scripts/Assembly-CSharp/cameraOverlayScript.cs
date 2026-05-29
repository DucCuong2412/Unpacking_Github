using UnityEngine;

public class cameraOverlayScript : MonoBehaviour
{
	private Camera m_sourceCam;

	private Camera m_overlayCam;

	private Shader m_shader;

	private Material m_material;

	private int m_materialID;

	private int m_colorID;

	private bool m_editor;

	private int m_pixelSize = 1;

	public bool editor
	{
		set
		{
			if (m_editor != value)
			{
				m_editor = value;
				m_shader = Shader.Find(m_editor ? "Unpacking/OverlayEditor" : "Unpacking/Overlay");
				if (base.enabled)
				{
					Object.Destroy(m_material);
					m_material = new Material(Shader.Find(m_editor ? "Hidden/OverlayCompositeEditor" : "Hidden/OverlayComposite"));
				}
			}
		}
	}

	public void SetPixelSize(int _value)
	{
		m_pixelSize = Mathf.Max(1, _value);
	}

	private void Start()
	{
		m_shader = Shader.Find(m_editor ? "Unpacking/OverlayEditor" : "Unpacking/Overlay");
		Shader.SetGlobalFloat("_OutlineSize", 0.01f);
		GameObject gameObject = new GameObject("overlay camera");
		m_overlayCam = gameObject.AddComponent<Camera>();
		m_overlayCam.enabled = false;
		m_sourceCam = GetComponent<Camera>();
		m_materialID = Shader.PropertyToID("_Occlude");
		m_colorID = Shader.PropertyToID("_OutlineColor");
	}

	private void OnEnable()
	{
		m_material = new Material(Shader.Find(m_editor ? "Hidden/OverlayCompositeEditor" : "Hidden/OverlayComposite"));
	}

	private void OnDisable()
	{
		Object.Destroy(m_material);
	}

	private void OnRenderImage(RenderTexture src, RenderTexture dest)
	{
		int num;
		int num2;
		if (Mathf.IsPowerOfTwo(src.width))
		{
			num = (Mathf.IsPowerOfTwo(src.height) ? 1 : 0);
			if (num != 0)
			{
				num2 = src.width / m_pixelSize;
				goto IL_0033;
			}
		}
		else
		{
			num = 0;
		}
		num2 = src.width;
		goto IL_0033;
		IL_0033:
		int width = num2;
		int height = ((num != 0) ? (src.height / m_pixelSize) : src.height);
		RenderTexture temporary = RenderTexture.GetTemporary(width, height, 16, m_editor ? RenderTextureFormat.Default : RenderTextureFormat.R8);
		temporary.filterMode = FilterMode.Point;
		m_overlayCam.CopyFrom(m_sourceCam);
		m_overlayCam.renderingPath = RenderingPath.Forward;
		m_overlayCam.clearFlags = CameraClearFlags.Color;
		m_overlayCam.backgroundColor = Color.clear;
		m_overlayCam.allowHDR = false;
		m_overlayCam.targetTexture = temporary;
		m_overlayCam.RenderWithShader(m_shader, "Outline");
		m_material.SetTexture(m_materialID, temporary);
		Graphics.Blit(src, dest, m_material);
		RenderTexture.ReleaseTemporary(temporary);
	}
}
