using UnityEngine;
using UnityEngine.UI;

public class uiGamepadVibrationToggle : MonoBehaviour
{
	public Toggle m_toggle;

	public frontendUIScript m_frontend;

	public gameUIScript m_gameUi;

	private bool m_sound = true;

	private void Start()
	{
		m_sound = false;
		m_toggle.isOn = inputHandler.IsVibrationEnabled;
		m_sound = true;
	}

	public void OnValueChanged()
	{
		inputHandler.IsVibrationEnabled = m_toggle.isOn;
		if (m_sound && m_toggle.isOn)
		{
			TestVibrate();
		}
		if (m_sound && (bool)m_frontend)
		{
			m_frontend.Change();
		}
		if (m_sound && (bool)m_gameUi)
		{
			m_gameUi.Change();
		}
	}

	public void Revert()
	{
		m_sound = false;
		m_toggle.isOn = true;
		m_sound = true;
	}

	private void TestVibrate()
	{
		vibrationScript.Trigger(vibrationScript.moment.testRumble);
	}
}
