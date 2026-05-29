using UnityEngine;

public class uiTransitionScript : MonoBehaviour
{
	public CanvasGroup m_fade;

	public RectTransform m_slide;

	public bool m_slideReverse;

	public void ControlsActive(bool _value)
	{
		GetComponent<CanvasGroup>().blocksRaycasts = _value;
	}

	public void Lerp(float _lerp)
	{
		float num = 1f - _lerp;
		num *= num;
		GetComponent<RectTransform>().sizeDelta = Vector2.one * Mathf.Round(60f * num) * 2f;
		if (m_fade != null)
		{
			m_fade.alpha = _lerp;
		}
		if (m_slide != null)
		{
			m_slide.anchoredPosition = Vector2.up * Mathf.Round(num * (m_slideReverse ? 800f : (-600f)));
		}
	}
}
