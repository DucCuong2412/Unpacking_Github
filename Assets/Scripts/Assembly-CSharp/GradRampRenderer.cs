using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

public sealed class GradRampRenderer : PostProcessEffectRenderer<GradRamp>
{
	public override void Render(PostProcessRenderContext context)
	{
		PropertySheet propertySheet = context.propertySheets.Get(Shader.Find("Hidden/Custom/GradRamp"));
		propertySheet.properties.SetFloat("_Blend", base.settings.blend);
		if (base.settings.rampTex.value != null)
		{
			propertySheet.properties.SetTexture("_RampTex", base.settings.rampTex);
		}
		context.command.BlitFullscreenTriangle(context.source, context.destination, propertySheet, 0);
	}
}
