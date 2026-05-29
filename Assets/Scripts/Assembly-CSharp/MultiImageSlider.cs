using System;
using UnityEngine;
using UnityEngine.UI;

public class MultiImageSlider : Slider
{
	private Graphic[] m_graphics;

	protected Graphic[] Graphics
	{
		get
		{
			if (m_graphics == null)
			{
				m_graphics = base.targetGraphic.transform.GetComponentsInChildren<Graphic>();
			}
			return m_graphics;
		}
	}

	protected override void DoStateTransition(SelectionState state, bool instant)
	{
		Color color;
		switch (state)
		{
		case SelectionState.Normal:
			color = base.colors.normalColor;
			break;
		case SelectionState.Highlighted:
			color = base.colors.highlightedColor;
			break;
		case SelectionState.Pressed:
			color = base.colors.pressedColor;
			break;
		case SelectionState.Disabled:
			color = base.colors.disabledColor;
			break;
		default:
			color = Color.black;
			break;
		}
		if (base.gameObject.activeInHierarchy)
		{
			Transition transition = base.transition;
			if (transition != Transition.ColorTint)
			{
				throw new NotSupportedException();
			}
			ColorTween(color * base.colors.colorMultiplier, instant);
		}
	}

	private void ColorTween(Color targetColor, bool instant)
	{
		if (!(base.targetGraphic == null))
		{
			Graphic[] graphics = Graphics;
			for (int i = 0; i < graphics.Length; i++)
			{
				graphics[i].CrossFadeColor(targetColor, (!instant) ? base.colors.fadeDuration : 0f, ignoreTimeScale: true, useAlpha: true);
			}
		}
	}
}
