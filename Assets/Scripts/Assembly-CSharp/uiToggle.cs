using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class uiToggle : MonoBehaviour
{
	public enum toggleType
	{
		none = 0,
		fullscreen = 1,
		zoneChange = 2
	}

	public string m_stringID;

	public toggleType m_type;

	private bool m_toggle = true;

	public Color m_colorUnapplied;

	private ColorBlock[] m_colors;

	public Button[] m_buttons;

	private uiApply m_apply;

	private uiApplyButton m_applyButton;

	private bool m_needsApply;

	public bool needsApply => m_needsApply;

	public bool toggle => m_toggle;

	private void Start()
	{
		if (m_buttons != null && m_buttons.Length != 0)
		{
			m_colors = new ColorBlock[2];
			m_colors[0] = m_buttons[0].colors;
			m_colors[1] = m_buttons[0].colors;
			m_colors[1].normalColor = m_colorUnapplied;
		}
		if (m_type == toggleType.fullscreen)
		{
			m_toggle = Screen.fullScreen;
		}
		else if (m_type == toggleType.zoneChange)
		{
			m_toggle = PlayerPrefs.GetInt("access_zonefade", 0) == 1;
		}
		SetString();
		GetComponent<Button>().onClick.AddListener(Toggle);
	}

	public void RegisterApply(uiApply _apply)
	{
		m_apply = _apply;
	}

	public void RegisterApply(uiApplyButton _apply)
	{
		m_applyButton = _apply;
	}

	public void SetString()
	{
		TMP_Text component = GetComponent<TMP_Text>();
		if (m_type == toggleType.fullscreen)
		{
			component.text = gameStateScript.GetString(m_stringID) + ": " + gameStateScript.GetString(m_toggle ? "menu_toggle_fullscreen" : "menu_toggle_windowed") + " ";
			m_needsApply = Screen.fullScreen != m_toggle;
			for (int i = 0; i < m_buttons.Length; i++)
			{
				m_buttons[i].colors = m_colors[m_needsApply ? 1 : 0];
			}
			if (m_apply != null)
			{
				m_apply.OptionChange();
			}
			if (m_applyButton != null)
			{
				m_applyButton.OptionChange();
			}
		}
		else if (m_type == toggleType.zoneChange)
		{
			component.text = gameStateScript.GetString(m_stringID) + ": " + gameStateScript.GetString(m_toggle ? "menu_toggle_fade" : "menu_toggle_slide") + " ";
		}
	}

	public void MarkApplied()
	{
		m_needsApply = false;
		for (int i = 0; i < m_buttons.Length; i++)
		{
			m_buttons[i].colors = m_colors[m_needsApply ? 1 : 0];
		}
	}

	public void Toggle()
	{
		Debug.Log("toggle activated");
		m_toggle = !m_toggle;
		if (m_type != toggleType.fullscreen && m_type == toggleType.zoneChange)
		{
			if (m_toggle)
			{
				PlayerPrefs.SetInt("access_zonefade", 1);
			}
			else
			{
				PlayerPrefs.DeleteKey("access_zonefade");
			}
			gameScript gameScript2 = Object.FindObjectOfType<gameScript>();
			if ((bool)gameScript2)
			{
				gameScript2.zoneChangeFade = m_toggle;
			}
		}
		SetString();
	}
}
