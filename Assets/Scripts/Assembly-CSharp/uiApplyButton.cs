using UnityEngine;
using UnityEngine.UI;

public class uiApplyButton : MonoBehaviour
{
	public uiResolutionSelect[] m_resolutions;

	public uiToggle[] m_toggles;

	private void Start()
	{
		GetComponent<Button>().onClick.AddListener(Apply);
		for (int i = 0; i < m_resolutions.Length; i++)
		{
			m_resolutions[i].RegisterApply(this);
		}
		for (int j = 0; j < m_toggles.Length; j++)
		{
			m_toggles[j].RegisterApply(this);
		}
		GetComponent<Button>().interactable = false;
	}

	public void OptionChange()
	{
		Debug.Log("OptionChange activated");
		bool flag = false;
		for (int i = 0; i < m_resolutions.Length; i++)
		{
			flag |= m_resolutions[i].needsApply;
		}
		for (int j = 0; j < m_toggles.Length; j++)
		{
			flag |= m_toggles[j].needsApply;
		}
		GetComponent<Button>().interactable = flag;
	}

	public void Apply()
	{
		Debug.Log("Apply activated");
		int width = Screen.width;
		int height = Screen.height;
		bool fullscreen = Screen.fullScreen;
		for (int i = 0; i < m_resolutions.Length; i++)
		{
			width = m_resolutions[i].width;
			height = m_resolutions[i].height;
		}
		for (int j = 0; j < m_toggles.Length; j++)
		{
			fullscreen = m_toggles[j].toggle;
		}
		Screen.SetResolution(width, height, fullscreen);
		screenScaleScript[] array = Object.FindObjectsOfType<screenScaleScript>();
		for (int k = 0; k < array.Length; k++)
		{
			array[k].SetResolution(width, height);
		}
		titleBackgroundPan titleBackgroundPan2 = Object.FindObjectOfType<titleBackgroundPan>();
		if (titleBackgroundPan2 != null)
		{
			float orthoSize = (float)Screen.height / 200f;
			int num = Mathf.Max(1, Mathf.Min(Screen.width / 850, Screen.height / 480));
			titleBackgroundPan2.pixelScale = num;
			titleBackgroundPan2.orthoSize = orthoSize;
		}
		for (int l = 0; l < m_resolutions.Length; l++)
		{
			m_resolutions[l].MarkApplied();
		}
		for (int m = 0; m < m_toggles.Length; m++)
		{
			m_toggles[m].MarkApplied();
		}
		GetComponent<Button>().interactable = false;
		Object.FindObjectOfType<uiSceneControllerInputHandler>()?.SelectPreviousUIElement();
	}
}
