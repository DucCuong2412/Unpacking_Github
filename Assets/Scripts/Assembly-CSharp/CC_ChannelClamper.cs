using UnityEngine;

[ExecuteInEditMode]
[AddComponentMenu("Colorful/Channel Clamper")]
public class CC_ChannelClamper : CC_Base
{
	public Vector2 red = new Vector2(0f, 1f);

	public Vector2 green = new Vector2(0f, 1f);

	public Vector2 blue = new Vector2(0f, 1f);

	protected virtual void OnRenderImage(RenderTexture source, RenderTexture destination)
	{
		base.material.SetVector("_RedClamp", red);
		base.material.SetVector("_GreenClamp", green);
		base.material.SetVector("_BlueClamp", blue);
		Graphics.Blit(source, destination, base.material);
	}
}
