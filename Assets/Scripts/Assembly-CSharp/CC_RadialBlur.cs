using UnityEngine;

[ExecuteInEditMode]
[AddComponentMenu("Colorful/Radial Blur")]
public class CC_RadialBlur : CC_Base
{
	[Range(0f, 1f)]
	public float amount = 0.1f;

	[Range(2f, 24f)]
	public int samples = 10;

	public Vector2 center = new Vector2(0.5f, 0.5f);

	public int quality = 1;

	protected virtual void OnRenderImage(RenderTexture source, RenderTexture destination)
	{
		if (amount == 0f)
		{
			Graphics.Blit(source, destination);
			return;
		}
		base.material.SetFloat("_Amount", amount);
		base.material.SetVector("_Center", center);
		base.material.SetFloat("_Samples", samples);
		Graphics.Blit(source, destination, base.material, quality);
	}
}
