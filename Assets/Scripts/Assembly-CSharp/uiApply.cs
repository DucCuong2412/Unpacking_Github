using System.Collections;
using UnityEngine;
using UnityEngine.UI;

public class uiApply : MonoBehaviour
{
	public Color m_colorUnapplied;

	private uiResolutionSelect[] m_resolutions;

	private uiStringSelect[] m_stringSelects;

	private void Start()
	{
		GetComponent<Button>().onClick.AddListener(Apply);
	}

	public void SetOptions(uiResolutionSelect[] _resolutions, uiStringSelect[] _stringSelects)
	{
		m_resolutions = _resolutions;
		m_stringSelects = _stringSelects;
		for (int i = 0; i < m_resolutions.Length; i++)
		{
			m_resolutions[i].RegisterApply(this);
		}
		for (int j = 0; j < m_stringSelects.Length; j++)
		{
			m_stringSelects[j].RegisterApply(this);
		}
	}

	public void OptionChange()
	{
		Debug.Log("OptionChange activated");
		bool flag = false;
		for (int i = 0; i < m_resolutions.Length; i++)
		{
			flag |= m_resolutions[i].needsApply;
		}
		for (int j = 0; j < m_stringSelects.Length; j++)
		{
			flag |= m_stringSelects[j].needsApply;
		}
		GetComponent<Button>().interactable = flag;
	}

	public void Reset()
	{
		StartCoroutine("DefaultResolution");
	}

	private IEnumerator DefaultResolution()
	{
		Screen.fullScreenMode = FullScreenMode.Windowed;
		yield return new WaitUntil(() => Screen.fullScreenMode == FullScreenMode.Windowed);
		for (int num = 0; num < m_resolutions.Length; num++)
		{
			m_resolutions[num].Reset();
		}
		for (int num2 = 0; num2 < m_stringSelects.Length; num2++)
		{
			m_stringSelects[num2].Reset();
		}
		Apply();
	}

	public void Apply()
	{
		Debug.Log("Apply activated");
		int width = Screen.width;
		int height = Screen.height;
		FullScreenMode fullscreenMode = Screen.fullScreenMode;
		for (int i = 0; i < m_resolutions.Length; i++)
		{
			width = m_resolutions[i].width;
			height = m_resolutions[i].height;
		}
		for (int j = 0; j < m_stringSelects.Length; j++)
		{
			fullscreenMode = m_stringSelects[j].fullscreen;
		}
		Screen.SetResolution(width, height, fullscreenMode);
		gameStateScript.SetResolution(width, height);
		for (int k = 0; k < m_resolutions.Length; k++)
		{
			m_resolutions[k].MarkApplied();
		}
		for (int l = 0; l < m_stringSelects.Length; l++)
		{
			m_stringSelects[l].MarkApplied();
		}
		GetComponent<Button>().interactable = false;
		uiGamepadNavigationGroup componentInParent = GetComponentInParent<uiGamepadNavigationGroup>();
		if (componentInParent != null)
		{
			componentInParent.enabled = false;
			componentInParent.enabled = true;
		}
	}
}
