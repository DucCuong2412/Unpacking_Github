using UnityEngine;

[ExecuteInEditMode]
[AddComponentMenu("Colorful/Posterize")]
public class CC_Posterize : CC_Base
{
	[Range(2f, 255f)]
	public int levels = 4;

	protected virtual void OnRenderImage(RenderTexture source, RenderTexture destination)
	{
		base.material.SetFloat("_Levels", levels);
		Graphics.Blit(source, destination, base.material);
	}
}
