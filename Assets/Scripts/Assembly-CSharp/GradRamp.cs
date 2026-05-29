using System;
using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

[Serializable]
[PostProcess(typeof(GradRampRenderer), PostProcessEvent.BeforeStack, "Custom/GradRamp", true)]
public sealed class GradRamp : PostProcessEffectSettings
{
	[Range(0f, 1f)]
	[Tooltip("Grayscale effect intensity.")]
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
