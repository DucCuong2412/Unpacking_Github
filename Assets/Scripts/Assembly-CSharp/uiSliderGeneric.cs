using UnityEngine;
using UnityEngine.UI;

public class uiSliderGeneric : MonoBehaviour
{
	private float m_value = 1f;

	private photoModeScript m_script;

	private Slider m_slider;

	public GameObject[] m_iconNodes;

	public float value => m_value;

	public void SetSlide(float _value, photoModeScript _script)
	{
		m_script = _script;
		m_slider = GetComponentInChildren<Slider>();
		SetSlide(_value);
	}

	public void SetSlide(float _value)
	{
		m_value = _value;
		if (m_slider != null)
		{
			m_slider.value = m_value * 10f;
		}
	}

	public void Set(float _value)
	{
		float num = _value / 10f;
		if (m_script != null && num != m_value)
		{
			m_script.SetSlide(num, num > m_value);
		}
		m_value = num;
	}

	public void Enable(bool _value)
	{
		m_slider.interactable = _value;
		for (int i = 0; i < m_iconNodes.Length; i++)
		{
			m_iconNodes[i].SetActive(_value);
		}
	}

	public void Increase()
	{
		if (!(m_slider == null) && m_slider.interactable && !(m_slider.value >= m_slider.maxValue))
		{
			m_slider.value += 1f;
			Set(m_slider.value);
		}
	}

	public void Decrease()
	{
		if (!(m_slider == null) && m_slider.interactable && !(m_slider.value <= m_slider.minValue))
		{
			m_slider.value -= 1f;
			Set(m_slider.value);
		}
	}
}
