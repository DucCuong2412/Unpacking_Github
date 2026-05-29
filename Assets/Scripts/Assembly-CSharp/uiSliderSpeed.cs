using UnityEngine;
using UnityEngine.UI;

public class uiSliderSpeed : MonoBehaviour
{
	public albumManagerScript m_albumManager;

	private void Start()
	{
		Slider componentInChildren = GetComponentInChildren<Slider>();
		if (componentInChildren != null)
		{
			componentInChildren.value = gameStateScript.playbackSpeed;
		}
	}

	public void Slide(int _value)
	{
		Slider componentInChildren = GetComponentInChildren<Slider>();
		if (componentInChildren != null)
		{
			componentInChildren.value += _value;
		}
	}

	public void Set(float _value)
	{
		int num = (int)_value;
		float num2 = gameStateScript.playbackSpeed;
		if ((float)num != num2)
		{
			m_albumManager.Slide((float)num > num2);
		}
		gameStateScript.playbackSpeed = num;
	}
}
