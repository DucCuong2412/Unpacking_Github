using UnityEngine;

public class uiDemoAdjustScript : MonoBehaviour
{
	public enum demoAdjust
	{
		hide = 0,
		disable = 1,
		shift = 2
	}

	public demoAdjust m_action;

	public float m_shift;

	private void Start()
	{
	}
}
