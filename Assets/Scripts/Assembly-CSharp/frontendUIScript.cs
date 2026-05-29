using System.Collections;
using UnityEngine;
using UnityEngine.UI;

public class frontendUIScript : MonoBehaviour
{
	private enum confirmType
	{
		none = 0,
		deleteAll = 1,
		startOver = 2,
		allowAnywhere = 3
	}

	private enum ScreenIndex
	{
		main = 0,
		settings = 1,
		language = 2
	}

	[Header("WWise Events")]
	public string m_audioPlay = "ui_play";

	public string m_audioResume = "ui_resume";

	public string m_audioNewGame = "ui_new_game";

	public string m_audioSettings = "ui_settings";

	public string m_audioQuit = "ui_quit";

	[Space(10f)]
	public string m_audioYes = "ui_yes";

	public string m_audioNo = "ui_no";

	[Space(10f)]
	public string m_audioSliderDown = "ui_slider_down";

	public string m_audioSliderUp = "ui_slider_up";

	public string m_audioChangeSetting = "ui_change_setting";

	public string m_audioApply = "ui_apply";

	public string m_audioSettingsClose = "ui_settings_close";

	public string m_audioResetToDefault = "";

	public string m_audioGamepadMenuMove = "";

	[Space(10f)]
	public string m_audioPanelSlideIn;

	public string m_audioPanelSlideOut;

	public string m_audioDialogShow;

	[Space(20f)]
	public Transform m_logoRoot;

	public Transform m_menuRoot;

	public CanvasGroup m_dim;

	public CanvasGroup m_versionText;

	public Image m_settingsBaseImage;

	public Color m_settingsBaseImageTint;

	private Vector2 m_logoRootPosition = Vector2.zero;

	public GameObject[] m_logoSprites;

	public animAudioEventScript m_animEventScript;

	public GameObject[] m_screens;

	public RectTransform m_creditsUI;

	public uiMenuBuilder m_mainMenu;

	private confirmType m_confirmActive;

	public GameObject m_confirm;

	public stringIdScript m_confirmText;

	private int m_screen;

	private int m_screenPrevious;

	private CanvasGroup m_canvasGroup;

	private bool isScreenSwitching;

	private float m_screenSwitchLerp;

	private bool m_ignoreNextMenuChange;

	public uiInputBindings m_uiInputBindings;

	private bool m_switchUserStarted;

	private void SwitchScreen(int _screen)
	{
		m_screenPrevious = m_screen;
		m_screen = _screen;
		isScreenSwitching = true;
		m_screenSwitchLerp = 0f;
		m_ignoreNextMenuChange = true;
		GetComponent<CanvasGroup>().blocksRaycasts = false;
		if ((m_screen != 1 || m_screenPrevious == 0) && m_screenPrevious != 7)
		{
			m_screens[m_screen].SetActive(value: true);
			m_screens[m_screen].GetComponent<RectTransform>().anchoredPosition = Vector2.right * -400f;
		}
		if ((m_screen == 1 || m_screen == 8) && m_screenPrevious == 0)
		{
			m_dim.alpha = 0f;
			m_dim.gameObject.SetActive(value: true);
		}
		if (m_screen == 0 && (m_screenPrevious == 1 || m_screenPrevious == 8))
		{
			m_versionText.alpha = 0f;
			m_versionText.gameObject.SetActive(value: true);
		}
		if (m_screen == 0)
		{
			for (int i = 0; i < m_logoSprites.Length; i++)
			{
				m_logoSprites[i].SetActive(m_screen == 0);
			}
		}
		else if (m_screen == 8)
		{
			m_creditsUI.gameObject.SetActive(value: true);
			m_creditsUI.GetComponent<CanvasGroup>().interactable = false;
		}
		OnScreenDeactivate(m_screens[m_screenPrevious]);
		OnScreenDeactivate(m_screens[m_screen]);
		if (m_screen != 8 && m_screenPrevious != 8)
		{
			if (m_screen > m_screenPrevious)
			{
				AkSoundEngine.PostEvent(m_audioPanelSlideIn, base.gameObject);
			}
			else
			{
				AkSoundEngine.PostEvent(m_audioPanelSlideOut, base.gameObject);
			}
		}
		gameStateScript.PrefSaveNow();
	}

	private void OnScreenActivate(GameObject screen)
	{
		if (screen == m_screens[0])
		{
			screen.SetActive(value: false);
			screen.SetActive(value: true);
		}
		CanvasGroup component = screen.GetComponent<CanvasGroup>();
		if (component != null)
		{
			component.interactable = true;
			component.blocksRaycasts = true;
		}
		uiGamepadNavigationGroup component2 = screen.GetComponent<uiGamepadNavigationGroup>();
		if (component2 != null && component2.isActiveAndEnabled)
		{
			component2.Refresh();
		}
	}

	private void OnScreenDeactivate(GameObject screen)
	{
		uiGamepadNavigationGroup component = screen.GetComponent<uiGamepadNavigationGroup>();
		if (component != null && component.isActiveAndEnabled)
		{
			component.ClearSelectionState();
		}
		CanvasGroup component2 = screen.GetComponent<CanvasGroup>();
		if (component2 != null)
		{
			component2.interactable = false;
			component2.blocksRaycasts = false;
		}
	}

	private void Start()
	{
		m_canvasGroup = GetComponent<CanvasGroup>();
		SetResolution(Screen.width, Screen.height);
		gameStateScript.GetCursor().Behaviour = uiCursor.CursorBehaviour.Default;
		if (m_uiInputBindings != null)
		{
			m_uiInputBindings.Refresh(recreateInstances: true);
		}
	}

	public void SetResolution(int _width, int _height)
	{
		int num = Mathf.Max(1, Mathf.Min(_width / 800, _height / 400));
		if (num == 1 && _width >= 1280 && _height >= 720)
		{
			num = 2;
		}
		float t = Mathf.InverseLerp(640f, 850f, _width / num);
		m_logoRootPosition = Vector2.Lerp(new Vector2(1.18f, -0.3f), Vector2.zero, t);
		m_logoRootPosition.x = Mathf.Round(m_logoRootPosition.x * 100f) / 100f;
		m_logoRootPosition.y = Mathf.Round(m_logoRootPosition.y * 100f) / 100f + 0.005f;
		m_logoRoot.localPosition = m_logoRootPosition + Vector2.right * ((m_screen == 0) ? 0f : (-8f));
		Vector2 vector = m_menuRoot.localPosition;
		vector.x = Mathf.Round(Mathf.Lerp(120f, 0f, t));
		m_menuRoot.localPosition = vector;
		m_mainMenu.ResolutionAlign(_height / num);
	}

	private void Update()
	{
		if (isScreenSwitching)
		{
			float num = ((m_screen == 8) ? 0.8f : 0.5f);
			m_screenSwitchLerp += Time.deltaTime * 3f;
			if (m_screenSwitchLerp >= 1f)
			{
				if ((m_screenPrevious == 1 && m_screen > 1) || m_screen == 7)
				{
					m_screens[m_screenPrevious].GetComponent<CanvasGroup>().blocksRaycasts = false;
				}
				else
				{
					m_screens[m_screenPrevious].SetActive(value: false);
				}
				OnScreenActivate(m_screens[m_screen]);
				if (m_screenPrevious == 0)
				{
					for (int i = 0; i < m_logoSprites.Length; i++)
					{
						m_logoSprites[i].SetActive(value: false);
					}
				}
				else if (m_screenPrevious == 8)
				{
					m_creditsUI.gameObject.SetActive(value: false);
				}
				m_screens[m_screen].GetComponent<RectTransform>().anchoredPosition = Vector2.zero;
				GetComponent<CanvasGroup>().blocksRaycasts = true;
				if (m_screen == 0)
				{
					m_logoRoot.localPosition = m_logoRootPosition;
				}
				else if (m_screen == 8)
				{
					m_creditsUI.GetComponent<CanvasGroup>().interactable = true;
				}
				if (m_screen == 1 || m_screen == 8)
				{
					m_dim.alpha = num;
					m_versionText.gameObject.SetActive(value: false);
				}
				else if (m_screen == 0)
				{
					m_dim.gameObject.SetActive(value: false);
				}
				if (m_screen > 1 && m_screenPrevious == 1)
				{
					m_settingsBaseImage.color = m_settingsBaseImageTint;
				}
				else if (m_screen == 1 && m_screenPrevious > 1)
				{
					m_settingsBaseImage.color = Color.white;
				}
				isScreenSwitching = false;
				return;
			}
			if (m_screen == 7 || m_screenPrevious == 7)
			{
				int num2 = Mathf.RoundToInt(-600f * Mathf.Pow(1f - m_screenSwitchLerp, 3f));
				int num3 = Mathf.RoundToInt(-600f * Mathf.Pow(m_screenSwitchLerp, 3f));
				m_screens[7].GetComponent<RectTransform>().anchoredPosition = Vector2.right * ((m_screen == 7) ? num2 : num3);
			}
			else if (m_screen == 8)
			{
				int num4 = Mathf.RoundToInt(960f * Mathf.Pow(1f - m_screenSwitchLerp, 2f));
				int num5 = Mathf.RoundToInt(-400f * Mathf.Pow(m_screenSwitchLerp, 3f));
				m_screens[0].GetComponent<RectTransform>().anchoredPosition = Vector2.right * num5;
				m_logoRoot.localPosition = m_logoRootPosition + Vector2.right * num5 * 0.02f;
				m_screens[8].GetComponent<RectTransform>().anchoredPosition = Vector2.right * num4;
				m_creditsUI.sizeDelta = Vector2.one * Mathf.Round(60f * Mathf.Pow(1f - m_screenSwitchLerp, 2f)) * 2f;
			}
			else if (m_screenPrevious == 8)
			{
				int num6 = Mathf.RoundToInt(-400f * Mathf.Pow(1f - m_screenSwitchLerp, 3f));
				int num7 = Mathf.RoundToInt(1920f * Mathf.Pow(m_screenSwitchLerp, 2f));
				m_screens[0].GetComponent<RectTransform>().anchoredPosition = Vector2.right * num6;
				m_logoRoot.localPosition = m_logoRootPosition + Vector2.right * num6 * 0.02f;
				m_screens[8].GetComponent<RectTransform>().anchoredPosition = Vector2.right * num7;
				m_creditsUI.sizeDelta = Vector2.one * Mathf.Round(60f * Mathf.Pow(m_screenSwitchLerp, 2f)) * 2f;
			}
			else
			{
				int num8 = Mathf.RoundToInt(-400f * Mathf.Pow(1f - m_screenSwitchLerp, 3f));
				int num9 = Mathf.RoundToInt(-400f * Mathf.Pow(m_screenSwitchLerp, 3f));
				if (m_screenPrevious != 1 || m_screen == 0)
				{
					m_screens[m_screenPrevious].GetComponent<RectTransform>().anchoredPosition = Vector2.right * num9;
				}
				if (m_screen != 1 || m_screenPrevious == 0)
				{
					m_screens[m_screen].GetComponent<RectTransform>().anchoredPosition = Vector2.right * num8;
				}
				if (m_screen == 0 || m_screenPrevious == 0)
				{
					m_logoRoot.localPosition = m_logoRootPosition + Vector2.right * ((m_screen == 0) ? num8 : num9) * 0.02f;
				}
			}
			if ((m_screen == 1 || m_screen == 8) && m_screenPrevious == 0)
			{
				m_dim.alpha = num * m_screenSwitchLerp;
				m_versionText.alpha = 1f - m_screenSwitchLerp;
			}
			else if (m_screen == 0 && (m_screenPrevious == 1 || m_screenPrevious == 8))
			{
				m_dim.alpha = num * (1f - m_screenSwitchLerp);
				m_versionText.alpha = m_screenSwitchLerp;
			}
			if (m_screen > 1 && m_screenPrevious == 1)
			{
				m_settingsBaseImage.color = Color.Lerp(Color.white, m_settingsBaseImageTint, m_screenSwitchLerp);
			}
			else if (m_screen == 1 && m_screenPrevious > 1)
			{
				m_settingsBaseImage.color = Color.Lerp(m_settingsBaseImageTint, Color.white, m_screenSwitchLerp);
			}
			return;
		}
		switch (inputHandler.CurrentControllerInputType)
		{
		case inputHandler.ControllerInputType.Keyboard:
		case inputHandler.ControllerInputType.Touch:
			if ((m_screen <= 0 || !inputHandler.IsPointerPressed() || !m_canvasGroup.blocksRaycasts || inputHandler.IsPointerOverGameObject()) && !inputHandler.IsPressed(InputAction.Menu_Back))
			{
				break;
			}
			if (m_confirmActive != confirmType.none)
			{
				ConfirmNo();
			}
			else if (m_screen == 1 || m_screen == 8)
			{
				ShowMainMenu();
			}
			else if (m_screen == 7)
			{
				if (!m_screens[7].GetComponent<uiInputBindings>().isBinding)
				{
					ShowSettingsControls();
				}
			}
			else if (m_screen > 1)
			{
				ShowSettings();
			}
			break;
		case inputHandler.ControllerInputType.Unknown:
		case inputHandler.ControllerInputType.Gamepad:
			break;
		}
	}

	public void Play()
	{
		AkSoundEngine.PostEvent(m_audioPlay, base.gameObject);
		gameStateScript.LoadSceneFade("album", 0.25f, _fadeUp: true);
		m_canvasGroup.blocksRaycasts = false;
		m_canvasGroup.interactable = false;
	}

	public void Stickers()
	{
		AkSoundEngine.PostEvent(m_audioResume, base.gameObject);
		gameStateScript.LoadSceneFade("stickers", 0.25f, _fadeUp: true);
		m_canvasGroup.blocksRaycasts = false;
		m_canvasGroup.interactable = false;
	}

	public void Resume()
	{
		AkSoundEngine.PostEvent(m_audioResume, base.gameObject);
		if (saveData.LoadFirstSave())
		{
			int resume = saveData.GetResume();
			saveData.GetAlbumInfo();
			if (resume > -1 && saveData.GetStage(resume).state > 0)
			{
				if (gameStateScript.CompareChecksums(resume))
				{
					string[] obj = new string[8] { "1_childRoom", "2_studioApt", "3_shareHouse", "4_boyfriendApt", "5_parentHouse", "6_soloApt", "7_partnerApt", "8_house" };
					gameStateScript.SetLoadStage();
					gameStateScript.LoadSceneFade(obj[resume], 0.25f);
				}
				else
				{
					gameStateScript.albumPage = resume;
					gameStateScript.SetAlbumLoadGame();
					gameStateScript.LoadSceneFade("album", 0.25f, _fadeUp: true);
				}
			}
			else if (saveData.GetAlbumInfo().stageComplete <= 8)
			{
				gameStateScript.albumPage = saveData.GetLastStage();
				gameStateScript.SetAlbumLoadGame();
				gameStateScript.LoadSceneFade("album", 0.25f, _fadeUp: true);
			}
			else
			{
				int firstUnfinishedStage = saveData.GetFirstUnfinishedStage();
				if (firstUnfinishedStage == -1)
				{
					gameStateScript.LoadSceneFade("album", 0.25f, _fadeUp: true);
				}
				else
				{
					gameStateScript.albumPage = firstUnfinishedStage;
					gameStateScript.SetAlbumLoadGame();
					gameStateScript.LoadSceneFade("album", 0.25f, _fadeUp: true);
				}
			}
		}
		m_canvasGroup.blocksRaycasts = false;
		m_canvasGroup.interactable = false;
	}

	public void ShowMainMenu()
	{
		AkSoundEngine.SetState("Music_State", "title");
		AkSoundEngine.PostEvent(m_audioSettingsClose, base.gameObject);
		SwitchScreen(0);
	}

	public void ShowSettings()
	{
		if (m_screen == 0)
		{
			AkSoundEngine.SetState("Music_State", "settings");
		}
		AkSoundEngine.PostEvent(m_audioSettings, base.gameObject);
		SwitchScreen(1);
	}

	public void ShowSettingsLanguage()
	{
		AkSoundEngine.PostEvent(m_audioSettings, base.gameObject);
		SwitchScreen(2);
	}

	public void ShowSettingsAudio()
	{
		AkSoundEngine.PostEvent(m_audioSettings, base.gameObject);
		SwitchScreen(3);
	}

	public void ShowSettingsVideo()
	{
		AkSoundEngine.PostEvent(m_audioSettings, base.gameObject);
		SwitchScreen(4);
	}

	public void ShowSettingsControls()
	{
		AkSoundEngine.PostEvent(m_audioSettings, base.gameObject);
		SwitchScreen(5);
	}

	public void ShowSettingsA11y()
	{
		AkSoundEngine.PostEvent(m_audioSettings, base.gameObject);
		SwitchScreen(6);
	}

	public void ShowSettingsControlsRebind()
	{
		AkSoundEngine.PostEvent(m_audioSettings, base.gameObject);
		SwitchScreen(7);
	}

	public void ShowStartOverPrompt()
	{
		AkSoundEngine.PostEvent(m_audioNewGame, base.gameObject);
		m_confirmActive = confirmType.startOver;
		m_confirmText.SetString("menu_startover_prompt");
		m_confirm.gameObject.SetActive(value: true);
		m_screens[m_screen].GetComponent<CanvasGroup>().blocksRaycasts = false;
		m_screens[m_screen].GetComponent<CanvasGroup>().interactable = false;
	}

	public void ShowDeleteAllPrompt()
	{
		AkSoundEngine.PostEvent(m_audioDialogShow, base.gameObject);
		m_confirmActive = confirmType.deleteAll;
		m_confirmText.SetString("menu_clearall_prompt");
		m_confirm.gameObject.SetActive(value: true);
		m_screens[m_screen].GetComponent<CanvasGroup>().blocksRaycasts = false;
		m_screens[m_screen].GetComponent<CanvasGroup>().interactable = false;
	}

	public void ShowPlaceAnywherePrompt()
	{
		AkSoundEngine.PostEvent(m_audioDialogShow, base.gameObject);
		m_confirmActive = confirmType.allowAnywhere;
		m_confirmText.SetString("menu_allowanywhere_prompt");
		m_confirm.gameObject.SetActive(value: true);
		m_screens[m_screen].GetComponent<CanvasGroup>().blocksRaycasts = false;
		m_screens[m_screen].GetComponent<CanvasGroup>().interactable = false;
	}

	public void ConfirmYes()
	{
		AkSoundEngine.PostEvent(m_audioYes, base.gameObject);
		if (m_confirmActive == confirmType.startOver)
		{
			gameStateScript.LoadSceneFade("album", 0.25f, _fadeUp: true);
			m_canvasGroup.blocksRaycasts = false;
			m_canvasGroup.interactable = false;
		}
		else if (m_confirmActive == confirmType.deleteAll)
		{
			saveData.DeleteAllData();
			inputHandler.Instance?.RevertToDefaultBindings(currentSchemeOnly: false);
			PlayerPrefs.DeleteAll();
			StartCoroutine(DefaultResolution());
			AkSoundEngine.ResetRTPCValue("volume_master");
			AkSoundEngine.ResetRTPCValue("volume_music");
			AkSoundEngine.ResetRTPCValue("volume_sfx");
			AkSoundEngine.ResetRTPCValue("volume_controller");
			gameStateScript.LoadSceneFade("title", 0.125f);
			m_canvasGroup.blocksRaycasts = false;
			m_canvasGroup.interactable = false;
		}
		else if (m_confirmActive == confirmType.allowAnywhere)
		{
			m_confirmActive = confirmType.none;
			m_confirm.gameObject.SetActive(value: false);
			m_screens[m_screen].GetComponent<CanvasGroup>().blocksRaycasts = true;
			m_screens[m_screen].GetComponent<CanvasGroup>().interactable = true;
		}
	}

	private IEnumerator DefaultResolution()
	{
		Screen.fullScreenMode = FullScreenMode.Windowed;
		yield return new WaitUntil(() => Screen.fullScreenMode == FullScreenMode.Windowed);
		int width = Screen.currentResolution.width;
		int height = Screen.currentResolution.height;
		Screen.SetResolution(width, height, (!gameStateScript.fullscreenExclusive) ? FullScreenMode.FullScreenWindow : FullScreenMode.ExclusiveFullScreen);
		gameStateScript.SetResolution(width, height);
	}

	public void ConfirmNo()
	{
		AkSoundEngine.PostEvent(m_audioNo, base.gameObject);
		if (m_confirmActive == confirmType.allowAnywhere)
		{
			uiStringSelect[] array = Object.FindObjectsOfType<uiStringSelect>();
			for (int i = 0; i < array.Length; i++)
			{
				if (array[i].m_type == uiStringSelect.stringSelectType.itemsAnywhere)
				{
					array[i].Reset();
				}
			}
			m_confirmActive = confirmType.none;
			m_confirm.gameObject.SetActive(value: false);
			m_screens[m_screen].GetComponent<CanvasGroup>().blocksRaycasts = true;
			m_screens[m_screen].GetComponent<CanvasGroup>().interactable = true;
		}
		else
		{
			m_confirmActive = confirmType.none;
			m_confirm.gameObject.SetActive(value: false);
			m_screens[m_screen].SetActive(value: false);
			m_screens[m_screen].SetActive(value: true);
			m_screens[m_screen].GetComponent<CanvasGroup>().blocksRaycasts = true;
			m_screens[m_screen].GetComponent<CanvasGroup>().interactable = true;
		}
	}

	public void ShowCredits()
	{
		AkSoundEngine.SetState("Music_State", "settings");
		AkSoundEngine.PostEvent(m_audioSettings, base.gameObject);
		SwitchScreen(8);
	}

	public void ReturnFromCredits()
	{
		AkSoundEngine.SetState("Music_State", "title");
		AkSoundEngine.PostEvent(m_audioSettingsClose, base.gameObject);
		SwitchScreen(0);
	}

	public void Quit()
	{
		AkSoundEngine.PostEvent(m_audioQuit, base.gameObject);
		Application.Quit();
	}

	public void Apply()
	{
		AkSoundEngine.PostEvent(m_audioApply, base.gameObject);
	}

	public void ResetToDefault()
	{
		if (!string.IsNullOrEmpty(m_audioResetToDefault))
		{
			AkSoundEngine.PostEvent(m_audioResetToDefault, base.gameObject);
		}
	}

	public void Change()
	{
		AkSoundEngine.PostEvent(m_audioChangeSetting, base.gameObject);
	}

	public void Slide(bool _increase)
	{
		AkSoundEngine.PostEvent(_increase ? m_audioSliderUp : m_audioSliderDown, base.gameObject);
	}

	public void ShowControllerApplet(bool _vertical)
	{
		inputHandler.ShowControllerApplet(_vertical);
	}

	public void MenuSelectionChange()
	{
		if (m_ignoreNextMenuChange)
		{
			m_ignoreNextMenuChange = false;
		}
		else if (!string.IsNullOrEmpty(m_audioGamepadMenuMove))
		{
			AkSoundEngine.PostEvent(m_audioGamepadMenuMove, base.gameObject);
		}
	}

	public void SwitchXboxUser()
	{
	}
}
