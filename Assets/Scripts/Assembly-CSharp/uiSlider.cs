using UnityEngine;
using UnityEngine.UI;

public class uiSlider : MonoBehaviour
{
	private const float c_default = 1f;

	public string m_type = "";

	public GameObject m_uiScript;

	private void Start()
	{
		if (!string.IsNullOrEmpty(m_type))
		{
			Slider componentInChildren = GetComponentInChildren<Slider>();
			if (componentInChildren != null)
			{
				componentInChildren.value = PlayerPrefs.GetFloat(m_type, 1f) * 10f;
			}
		}
	}

	public void Reset()
	{
		if (!string.IsNullOrEmpty(m_type))
		{
			PlayerPrefs.DeleteKey(m_type);
			gameStateScript.PrefSaveDirty();
			Slider componentInChildren = GetComponentInChildren<Slider>();
			if (componentInChildren != null)
			{
				componentInChildren.value = 10f;
			}
			AkSoundEngine.SetRTPCValue(m_type, 1f);
		}
	}

	public void Set(float _value)
	{
		if (string.IsNullOrEmpty(m_type))
		{
			return;
		}
		float num = _value / 10f;
		if (m_uiScript != null)
		{
			float num2 = PlayerPrefs.GetFloat(m_type, 1f);
			if (num != num2)
			{
				m_uiScript.SendMessage("Slide", num > num2);
			}
		}
		PlayerPrefs.SetFloat(m_type, num);
		gameStateScript.PrefSaveDirty();
		AkSoundEngine.SetRTPCValue(m_type, num);
	}
}
