using UnityEngine;
using UnityEngine.UI;

public class uiJoystickSensitivity : MonoBehaviour
{
	public Slider m_slider;

	public frontendUIScript m_frontend;

	public gameUIScript m_gameUi;

	private bool m_apply;

	private void Start()
	{
		Debug.Log("setting value to " + inputHandler.CurrentJoystickSensitivity);
		m_apply = false;
		m_slider.maxValue = inputHandler.JoystickSensitivityTickLength - 1;
		m_slider.value = inputHandler.CurrentJoystickSensitivity;
		m_apply = true;
	}

	public void OnValueChanged()
	{
		if (m_apply)
		{
			int currentJoystickSensitivity = inputHandler.CurrentJoystickSensitivity;
			int num = (inputHandler.CurrentJoystickSensitivity = (int)m_slider.value);
			if ((bool)m_frontend && num != currentJoystickSensitivity)
			{
				m_frontend.Slide(num > currentJoystickSensitivity);
			}
			if ((bool)m_gameUi && num != currentJoystickSensitivity)
			{
				m_gameUi.Slide(num > currentJoystickSensitivity);
			}
		}
	}

	public void Revert()
	{
		m_apply = false;
		m_slider.value = (inputHandler.CurrentJoystickSensitivity = inputHandler.DefaultJoystickSensitivity);
		m_apply = true;
	}
}
