using System;
using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

[Serializable]
[PostProcess(typeof(PaletteMatchRenderer), PostProcessEvent.BeforeStack, "Custom/PaletteMatch", true)]
public sealed class PaletteMatch : PostProcessEffectSettings
{
	[Range(0f, 1f)]
	[Tooltip("Effect intensity.")]
	public FloatParameter blend = new FloatParameter
	{
		value = 0f
	};

	[DisplayName("Ramp Texture")]
	[Tooltip("Ramp Texture")]
	public TextureParameter rampTex = new TextureParameter
	{
		value = null
	};
}
