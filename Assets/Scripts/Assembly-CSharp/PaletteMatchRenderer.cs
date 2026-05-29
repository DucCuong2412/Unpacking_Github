using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

public sealed class PaletteMatchRenderer : PostProcessEffectRenderer<PaletteMatch>
{
	public override void Render(PostProcessRenderContext context)
	{
		PropertySheet propertySheet = context.propertySheets.Get(Shader.Find("Hidden/Custom/PaletteMatch"));
		propertySheet.properties.SetFloat("_Blend", base.settings.blend);
		if (base.settings.rampTex.value != null)
		{
			propertySheet.properties.SetTexture("_Palette", base.settings.rampTex);
		}
		context.command.BlitFullscreenTriangle(context.source, context.destination, propertySheet, 0);
	}
}
