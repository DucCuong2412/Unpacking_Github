using System.Collections;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class uiStringSelect : MonoBehaviour
{
	public enum stringSelectType
	{
		display = 0,
		zoneChange = 1,
		iconSize = 2,
		placementHints = 3,
		itemsAnywhere = 4,
		inputCooldown = 5,
		invalidHighlight = 6,
		musicShuffle = 7,
		constrainCursor = 8
	}

	public stringSelectType m_type;

	public TMP_Text m_string;

	private int m_selection;

	public Image m_colorSelect;

	public Color[] m_colorUnapplied;

	private ColorBlock[] m_colors;

	public Button[] m_buttons;

	public Toggle[] m_toggles;

	private uiApply m_apply;

	private uiApplyButton m_applyButton;

	private bool m_needsApply;

	public bool needsApply => m_needsApply;

	public FullScreenMode fullscreen => IntToFullscreenMode(m_selection);

	private void Awake()
	{
		if (m_type == stringSelectType.display)
		{
			m_colors = new ColorBlock[4];
			m_colors[0] = m_buttons[1].colors;
			m_colors[1] = m_buttons[0].colors;
			m_colors[2] = m_buttons[1].colors;
			m_colors[3] = m_buttons[0].colors;
			m_colors[2].normalColor = m_colorUnapplied[0];
			m_colors[3].normalColor = m_colorUnapplied[1];
			if (m_colorUnapplied.Length > 2)
			{
				m_colors[2].selectedColor = m_colorUnapplied[2];
				m_colors[2].highlightedColor = m_colorUnapplied[2];
				m_colors[2].pressedColor = m_colorUnapplied[2];
				m_colors[3].selectedColor = m_colorUnapplied[3];
				m_colors[3].highlightedColor = m_colorUnapplied[3];
				m_colors[3].pressedColor = m_colorUnapplied[3];
			}
		}
	}

	private int FullscreenModeToInt()
	{
		if (!Screen.fullScreen)
		{
			return 1;
		}
		return 0;
	}

	private FullScreenMode IntToFullscreenMode(int _value)
	{
		if (_value == 1)
		{
			return FullScreenMode.Windowed;
		}
		if (!gameStateScript.fullscreenExclusive)
		{
			return FullScreenMode.FullScreenWindow;
		}
		return FullScreenMode.ExclusiveFullScreen;
	}

	private void OnEnable()
	{
		if (m_type == stringSelectType.display)
		{
			m_selection = FullscreenModeToInt();
		}
		else if (m_type == stringSelectType.zoneChange)
		{
			m_selection = gameStateScript.GetAccessSetting(gameStateScript.accessSetting.zonefade);
		}
		else if (m_type == stringSelectType.iconSize)
		{
			m_selection = gameStateScript.GetAccessSetting(gameStateScript.accessSetting.iconsize);
		}
		else if (m_type == stringSelectType.placementHints)
		{
			m_selection = gameStateScript.GetAccessSetting(gameStateScript.accessSetting.placementhints);
		}
		else if (m_type == stringSelectType.itemsAnywhere)
		{
			m_toggles[0].isOn = gameStateScript.GetAccessSetting(gameStateScript.accessSetting.itemsanywhere) == 1;
		}
		else if (m_type == stringSelectType.inputCooldown)
		{
			m_selection = gameStateScript.GetAccessSetting(gameStateScript.accessSetting.inputcooldown);
		}
		else if (m_type == stringSelectType.invalidHighlight)
		{
			m_selection = gameStateScript.GetAccessSetting(gameStateScript.accessSetting.invalidhighlight);
		}
		else if (m_type == stringSelectType.musicShuffle)
		{
			m_toggles[0].isOn = gameStateScript.AudioShuffle;
		}
		else if (m_type == stringSelectType.constrainCursor)
		{
			m_toggles[0].isOn = gameStateScript.ConstrainCursor;
		}
		if (m_string != null)
		{
			m_string.font = gameStateScript.GetFont(stringIdScript.fontStyle.small);
		}
		SetOption();
	}

	public void Reset()
	{
		if (m_type == stringSelectType.display)
		{
			m_selection = 0;
		}
		else if (m_type == stringSelectType.zoneChange)
		{
			gameStateScript.ResetAccessSetting(gameStateScript.accessSetting.zonefade);
			m_selection = 0;
		}
		else if (m_type == stringSelectType.iconSize)
		{
			gameStateScript.ResetAccessSetting(gameStateScript.accessSetting.iconsize);
			m_selection = 0;
		}
		else if (m_type == stringSelectType.placementHints)
		{
			gameStateScript.ResetAccessSetting(gameStateScript.accessSetting.placementhints);
			m_selection = 0;
		}
		else if (m_type == stringSelectType.itemsAnywhere)
		{
			m_toggles[0].isOn = false;
		}
		else if (m_type == stringSelectType.inputCooldown)
		{
			gameStateScript.ResetAccessSetting(gameStateScript.accessSetting.inputcooldown);
			m_selection = 0;
		}
		else if (m_type == stringSelectType.invalidHighlight)
		{
			gameStateScript.ResetAccessSetting(gameStateScript.accessSetting.invalidhighlight);
			m_selection = 0;
		}
		else if (m_type == stringSelectType.musicShuffle)
		{
			m_toggles[0].isOn = false;
		}
		else if (m_type == stringSelectType.constrainCursor)
		{
			m_toggles[0].isOn = true;
		}
		SetOption(0, _force: true);
	}

	public void SetEvents(gameUIScript _gameUI)
	{
		for (int i = 0; i < m_buttons.Length; i++)
		{
			m_buttons[i].onClick.AddListener(delegate
			{
				_gameUI.Change();
			});
			if (i == 0)
			{
				m_buttons[i].onClick.AddListener(delegate
				{
					SetOption(-1);
				});
			}
			else
			{
				m_buttons[i].onClick.AddListener(delegate
				{
					SetOption(1);
				});
			}
		}
		for (int num = 0; num < m_toggles.Length; num++)
		{
			m_toggles[num].onValueChanged.AddListener(delegate
			{
				_gameUI.Change();
			});
			m_toggles[num].onValueChanged.AddListener(delegate
			{
				SetOption();
			});
			if (m_type == stringSelectType.itemsAnywhere)
			{
				m_toggles[num].onValueChanged.AddListener(delegate
				{
					ShowPrompt();
				});
			}
		}
	}

	public void SetEvents(frontendUIScript _frontend)
	{
		for (int i = 0; i < m_buttons.Length; i++)
		{
			m_buttons[i].onClick.AddListener(delegate
			{
				_frontend.Change();
			});
			if (i == 0)
			{
				m_buttons[i].onClick.AddListener(delegate
				{
					SetOption(-1);
				});
			}
			else
			{
				m_buttons[i].onClick.AddListener(delegate
				{
					SetOption(1);
				});
			}
		}
		for (int num = 0; num < m_toggles.Length; num++)
		{
			m_toggles[num].onValueChanged.AddListener(delegate
			{
				_frontend.Change();
			});
			m_toggles[num].onValueChanged.AddListener(delegate
			{
				SetOption();
			});
			if (m_type == stringSelectType.itemsAnywhere)
			{
				m_toggles[num].onValueChanged.AddListener(delegate
				{
					ShowPrompt();
				});
			}
		}
	}

	public void ShowPrompt()
	{
		if (m_toggles[0].isOn)
		{
			frontendUIScript frontendUIScript2 = Object.FindObjectOfType<frontendUIScript>();
			if (frontendUIScript2 != null)
			{
				frontendUIScript2.ShowPlaceAnywherePrompt();
			}
			uiGameMenuScript uiGameMenuScript2 = Object.FindObjectOfType<uiGameMenuScript>();
			if (uiGameMenuScript2 != null)
			{
				uiGameMenuScript2.ShowConfirm();
			}
		}
	}

	public void SetOption(int _direction = 0, bool _force = false)
	{
		m_selection += _direction;
		int num = 1;
		if (m_type == stringSelectType.iconSize)
		{
			num = 2;
		}
		else if (m_type == stringSelectType.invalidHighlight)
		{
			num = gameStateScript.GetValidationColorCount() - 1;
		}
		if (m_selection < 0)
		{
			m_selection = num;
		}
		else if (m_selection > num)
		{
			m_selection = 0;
		}
		if (m_type == stringSelectType.display)
		{
			m_string.text = gameStateScript.GetString((m_selection == 0) ? "menu_toggle_fullscreen" : "menu_toggle_windowed");
			m_needsApply = m_selection != FullscreenModeToInt();
			StartCoroutine(SetColorsDelay());
			if (m_apply != null)
			{
				m_apply.OptionChange();
			}
			if (m_applyButton != null)
			{
				m_applyButton.OptionChange();
			}
		}
		else if (m_type == stringSelectType.zoneChange)
		{
			m_string.text = gameStateScript.GetString((m_selection == 0) ? "menu_toggle_default" : "menu_toggle_fade");
			if (_direction != 0 || _force)
			{
				gameStateScript.SetAccessSetting(gameStateScript.accessSetting.zonefade, m_selection);
				gameScript gameScript2 = Object.FindObjectOfType<gameScript>();
				if (gameScript2 != null)
				{
					gameScript2.zoneChangeFade = m_selection == 1;
				}
			}
		}
		else if (m_type == stringSelectType.iconSize)
		{
			m_string.text = gameStateScript.GetString((new string[3] { "menu_toggle_default", "menu_toggle_2x", "menu_toggle_3x" })[m_selection]);
			if (_direction != 0 || _force)
			{
				gameStateScript.SetAccessSetting(gameStateScript.accessSetting.iconsize, m_selection);
				gameScript gameScript3 = Object.FindObjectOfType<gameScript>();
				if (gameScript3 != null)
				{
					gameScript3.SetIconSize();
				}
			}
		}
		else if (m_type == stringSelectType.placementHints)
		{
			m_string.text = gameStateScript.GetString((m_selection == 0) ? "menu_toggle_default" : "menu_toggle_on");
			if (_direction != 0 || _force)
			{
				gameStateScript.SetAccessSetting(gameStateScript.accessSetting.placementhints, m_selection);
			}
		}
		else if (m_type == stringSelectType.itemsAnywhere)
		{
			m_selection = (m_toggles[0].isOn ? 1 : 0);
			gameStateScript.SetAccessSetting(gameStateScript.accessSetting.itemsanywhere, m_selection);
			gameScript gameScript4 = Object.FindObjectOfType<gameScript>();
			if (gameScript4 != null)
			{
				gameScript4.SetItemsValidAnywhere();
			}
		}
		else if (m_type == stringSelectType.inputCooldown)
		{
			m_string.text = gameStateScript.GetString((m_selection == 0) ? "menu_toggle_default" : "menu_toggle_on");
			if (_direction != 0 || _force)
			{
				gameStateScript.SetAccessSetting(gameStateScript.accessSetting.inputcooldown, m_selection);
			}
		}
		else if (m_type == stringSelectType.invalidHighlight)
		{
			m_colorSelect.color = gameStateScript.GetValidationColor(m_selection);
			if (_direction != 0 || _force)
			{
				gameStateScript.SetAccessSetting(gameStateScript.accessSetting.invalidhighlight, m_selection);
				gameScript gameScript5 = Object.FindObjectOfType<gameScript>();
				if (gameScript5 != null)
				{
					gameScript5.SetInvalidHighlight();
				}
			}
		}
		else if (m_type == stringSelectType.musicShuffle)
		{
			m_selection = (m_toggles[0].isOn ? 1 : 0);
			gameStateScript.AudioShuffle = m_selection == 1;
			gameScript gameScript6 = Object.FindObjectOfType<gameScript>();
			if (gameScript6 != null)
			{
				gameScript6.MusicShuffle(m_selection == 1);
			}
		}
		else if (m_type == stringSelectType.constrainCursor)
		{
			m_selection = (m_toggles[0].isOn ? 1 : 0);
			gameStateScript.ConstrainCursor = m_selection == 1;
		}
	}

	public void RegisterApply(uiApply _apply)
	{
		m_apply = _apply;
	}

	public void RegisterApply(uiApplyButton _apply)
	{
		m_applyButton = _apply;
	}

	public void MarkApplied()
	{
		m_needsApply = false;
		StartCoroutine(SetColorsDelay());
	}

	private void SetColors()
	{
		m_buttons[0].colors = m_colors[(!m_needsApply) ? 1 : 3];
		m_buttons[1].colors = m_colors[m_needsApply ? 2 : 0];
		m_buttons[2].colors = m_colors[(!m_needsApply) ? 1 : 3];
		GetComponent<TMP_Text>().color = m_colors[m_needsApply ? 2 : 0].normalColor;
	}

	private IEnumerator SetColorsDelay()
	{
		yield return new WaitForEndOfFrame();
		SetColors();
	}

	public void OnMove(int dir)
	{
		if (dir > 0)
		{
			m_buttons[2].onClick.Invoke();
		}
		else if (dir < 0)
		{
			m_buttons[0].onClick.Invoke();
		}
	}
}
