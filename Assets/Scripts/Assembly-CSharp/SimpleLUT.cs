using System;
using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

[Serializable]
[PostProcess(typeof(SimpleLUTRenderer), PostProcessEvent.AfterStack, "Custom/SimpleLUT", true)]
public sealed class SimpleLUT : PostProcessEffectSettings
{
	[Range(0f, 1f)]
	[Tooltip("SimpleLUT effect intensity.")]
	public FloatParameter blend = new FloatParameter
	{
		value = 0f
	};

	[DisplayName("LUT Texture")]
	[Tooltip("LUT Texture")]
	public TextureParameter lutTex = new TextureParameter
	{
		value = null
	};
}
