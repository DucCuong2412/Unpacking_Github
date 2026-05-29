using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

public sealed class SimpleLUTRenderer : PostProcessEffectRenderer<SimpleLUT>
{
	public override void Render(PostProcessRenderContext context)
	{
		PropertySheet propertySheet = context.propertySheets.Get(Shader.Find("Hidden/Custom/SimpleLUT"));
		propertySheet.properties.SetFloat("_Blend", base.settings.blend);
		if (base.settings.lutTex.value != null)
		{
			propertySheet.properties.SetTexture("_LutTex", base.settings.lutTex);
		}
		context.command.BlitFullscreenTriangle(context.source, context.destination, propertySheet, 0);
	}
}
