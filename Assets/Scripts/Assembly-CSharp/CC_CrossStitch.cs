using UnityEngine;

[ExecuteInEditMode]
[AddComponentMenu("Colorful/Cross Stitch")]
public class CC_CrossStitch : CC_Base
{
	[Range(1f, 128f)]
	public int size = 8;

	public float brightness = 1.5f;

	public bool invert;

	public bool pixelize = true;

	protected Camera m_Camera;

	protected override void Start()
	{
		base.Start();
		m_Camera = GetComponent<Camera>();
	}

	protected virtual void OnRenderImage(RenderTexture source, RenderTexture destination)
	{
		base.material.SetFloat("_StitchSize", size);
		base.material.SetFloat("_Brightness", brightness);
		int num = (invert ? 1 : 0);
		if (pixelize)
		{
			num += 2;
			base.material.SetFloat("_Scale", m_Camera.pixelWidth / size);
			base.material.SetFloat("_Ratio", m_Camera.pixelWidth / m_Camera.pixelHeight);
		}
		Graphics.Blit(source, destination, base.material, num);
	}
}
