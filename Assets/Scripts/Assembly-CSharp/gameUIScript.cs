using System.Collections;
using UnityEngine;

public class gameUIScript : MonoBehaviour
{
	private enum ScreenIndex
	{
		Gameplay = 0,
		MenuOptions = 1,
		MenuConfirm = 2,
		PhotoMode = 3,
		MenuSaveConfirm = 4,
		Flooplan = 5
	}

	private enum ScreenSwitch
	{
		none = 0,
		full = 1,
		delay = 2
	}

	private enum nextDest
	{
		mainMenu = 0,
		album = 1
	}

	[Header("WWise Events")]
	public string m_audioPause = "ui_pause";

	public string m_audioZoomIn = "ui_zoom_in";

	public string m_audioZoomOut = "ui_zoom_out";

	public string m_audioRotateTutorial = "ui_rotate_tutorial";

	[Space(10f)]
	public string m_audioResume = "ui_resume";

	public string m_audioStartOver = "ui_start_over";

	public string m_audioAlbum = "ui_album";

	public string m_audioSettings = "ui_settings";

	public string m_audioMainMenu = "ui_main_menu";

	public string m_audioDialog = "dialog_box";

	[Space(10f)]
	public string m_audioYes = "ui_yes";

	public string m_audioNo = "ui_no";

	[Space(10f)]
	public string m_audioPlaybackEncodeStart;

	public string m_audioPlaybackEncodeEnd;

	public string m_audioPlaybackDialogShow;

	public string m_audioPlaybackAccept;

	[Space(10f)]
	public string m_audioSliderDown = "ui_slider_down";

	public string m_audioSliderUp = "ui_slider_up";

	public string m_audioChangeSetting = "ui_change_setting";

	public string m_audioReturn = "ui_return";

	public string m_audioResetToDefault = "";

	public string m_audioGamepadMenuMove = "";

	[Space(10f)]
	public string m_audioRoomIconsAppear;

	public string m_audioFloorplanIconAppear;

	[Space(10f)]
	public string m_audioValidateAppear;

	public string m_audioValidateOn;

	public string m_audioValidateOff;

	[Space(10f)]
	public string m_audioNotepadPageForward;

	public string m_audioNotepadPageBack;

	[Header("Photomode")]
	public string m_audioPhotomodeOpen;

	public string m_audioPhotomodeClose;

	public string m_audioScreenshot;

	public string m_audioPhotoTabClick;

	public string m_audioPhotoTabOpen;

	public string m_audioPhotoTabClose;

	public string m_audioPhotoHudHide;

	public string m_audioPhotoHudShow;

	public string m_audioPhotoPanStart;

	public string m_audioPhotoPanEnd;

	public string m_audioPhotoPanClick;

	[Space(4f)]
	public string m_audioStickerPageForward;

	public string m_audioStickerPageBackward;

	public string m_audioStickerLiftSheet;

	public string m_audioStickerLiftScreen;

	public string m_audioStickerPlace;

	public string m_audioStickerReturn;

	[Space(4f)]
	public string m_audioStickerScaleUp;

	public string m_audioStickerScaleDown;

	public string m_audioStickerRotate;

	public string m_audioStickerFlip;

	[Space(4f)]
	public string m_audioQuitPhotoDialog = "dialog_box";

	public string m_audioQuitPhotoYes = "ui_yes";

	public string m_audioQuitPhotoNo = "ui_no";

	[Header("Floorplan")]
	public string m_audioFloorplanOpen;

	public string m_audioFloorplanClose;

	public string m_audioFloorplanFloorUp;

	public string m_audioFloorplanFloorDown;

	[Space(20f)]
	public gameScript m_game;

	public CanvasGroup m_canvasGroup;

	public GameObject[] m_screens;

	private ScreenIndex m_screen;

	private ScreenIndex m_pendingScreen;

	private ScreenIndex m_screenPrevious;

	private ScreenSwitch m_screenSwitch;

	private float m_screenSwitchLerp;

	private float m_screenSwitchDelay;

	private nextDest m_nextDest;

	private bool m_ignoreNextMenuChange;

	private void Update()
	{
		if (m_game != null && m_game.IsDateNodeActive)
		{
			return;
		}
		if (m_screenSwitch == ScreenSwitch.none && inputHandler.CurrentControllerInputType != inputHandler.ControllerInputType.Gamepad && inputHandler.IsPointerPressed() && m_canvasGroup.blocksRaycasts && !inputHandler.IsPointerOverGameObject())
		{
			switch (m_screen)
			{
			case ScreenIndex.MenuOptions:
				m_screens[1].GetComponent<uiGameMenuScript>().BackOut();
				break;
			case ScreenIndex.MenuConfirm:
				StartOverNo();
				break;
			case ScreenIndex.Flooplan:
				ResumeFloorplan();
				break;
			}
		}
		if (m_screenSwitch != ScreenSwitch.none)
		{
			m_screenSwitchLerp += Time.deltaTime * 4f;
			if (m_screenSwitchLerp >= m_screenSwitchDelay + 1f)
			{
				if (m_screenSwitch == ScreenSwitch.full)
				{
					m_screens[(int)m_screenPrevious].SetActive(value: false);
				}
				m_screens[(int)m_screen].SendMessage("Lerp", 1f, SendMessageOptions.DontRequireReceiver);
				m_screens[(int)m_screen].SendMessage("ControlsActive", true, SendMessageOptions.DontRequireReceiver);
				m_screenSwitch = ScreenSwitch.none;
			}
			else if (m_screenSwitch == ScreenSwitch.full && m_screenSwitchLerp >= 1f)
			{
				m_screens[(int)m_screenPrevious].SetActive(value: false);
				m_screenSwitch = ScreenSwitch.delay;
			}
			else
			{
				if (m_screenSwitch == ScreenSwitch.full)
				{
					m_screens[(int)m_screenPrevious].SendMessage("Lerp", 1f - m_screenSwitchLerp, SendMessageOptions.DontRequireReceiver);
				}
				m_screens[(int)m_screen].SendMessage("Lerp", Mathf.Max(0f, m_screenSwitchLerp - m_screenSwitchDelay), SendMessageOptions.DontRequireReceiver);
			}
		}
		if (m_pendingScreen != m_screen)
		{
			SwitchToPendingScreen();
		}
	}

	public void DisableInterface()
	{
		m_canvasGroup.interactable = false;
		m_canvasGroup.blocksRaycasts = false;
		m_screens[0].SetActive(value: false);
	}

	private void SwitchScreen(int _screen)
	{
		if (_screen != (int)m_pendingScreen)
		{
			m_pendingScreen = (ScreenIndex)_screen;
		}
	}

	private void SwitchToPendingScreen()
	{
		m_screenSwitch = ScreenSwitch.full;
		m_screenSwitchLerp = 0f;
		m_screenSwitchDelay = 0f;
		m_screenPrevious = m_screen;
		m_screen = m_pendingScreen;
		m_screens[(int)m_screen].SendMessage("ControlsActive", false, SendMessageOptions.DontRequireReceiver);
		m_screens[(int)m_screenPrevious].SendMessage("ControlsActive", false, SendMessageOptions.DontRequireReceiver);
		m_screens[(int)m_screen].SetActive(value: true);
		m_screens[(int)m_screen].SendMessage("Lerp", 0f, SendMessageOptions.DontRequireReceiver);
	}

	public void ShowOptions()
	{
		if (!m_game.m_editorOverGUI && m_game.interfaceActive && !m_game.IsDateNodeActive)
		{
			AkSoundEngine.PostEvent(m_audioPause, base.gameObject);
			m_game.GameActive(_value: false);
			m_game.InputUI();
			SwitchScreen(1);
		}
	}

	public void ShowStartOverPrompt()
	{
		AkSoundEngine.PostEvent(m_audioStartOver, base.gameObject);
		SwitchScreen(2);
	}

	public void ShowPhotoMode()
	{
		if (m_game.photomodeActive() && !m_game.m_editorOverGUI && m_game.interfaceActive && !m_game.IsDateNodeActive)
		{
			AkSoundEngine.PostEvent(m_audioPhotomodeOpen, base.gameObject);
			m_game.GameActive(_value: false);
			m_game.InputUI();
			SwitchScreen(3);
		}
	}

	public void ResumePhotomode()
	{
		AkSoundEngine.PostEvent(m_audioPhotomodeClose, base.gameObject);
		m_game.GameActive(_value: true);
		SwitchScreen(0);
	}

	public void ShowFloorplan()
	{
		if (m_game.floorplanActive() && !m_game.m_editorOverGUI && m_game.interfaceActive && !m_game.IsDateNodeActive)
		{
			AkSoundEngine.PostEvent(m_audioFloorplanOpen, base.gameObject);
			m_game.GameActive(_value: false, _timeActive: true);
			m_game.m_zoneChangeButton.FloorplanTutorialComplete();
			m_game.InputUI();
			SwitchScreen(5);
		}
	}

	public void ResumeFloorplan()
	{
		AkSoundEngine.PostEvent(m_audioFloorplanClose, base.gameObject);
		StartCoroutine(ResumeNextFrame());
		SwitchScreen(0);
	}

	public void ResumeFloorplan(float _delay)
	{
		StartCoroutine(ResumeNextFrame());
		SwitchScreen(0);
		m_screenSwitchDelay = _delay;
	}

	public void Resume()
	{
		AkSoundEngine.PostEvent(m_audioResume, base.gameObject);
		StartCoroutine(ResumeNextFrame());
		SwitchScreen(0);
	}

	private IEnumerator ResumeNextFrame()
	{
		yield return new WaitForFixedUpdate();
		m_game.GameActive(_value: true);
	}

	public void Album()
	{
		if (m_game.CheckUnsavedChanges())
		{
			AkSoundEngine.PostEvent(m_audioDialog, base.gameObject);
			m_nextDest = nextDest.album;
			SwitchScreen(4);
		}
		else
		{
			AkSoundEngine.PostEvent(m_audioAlbum, base.gameObject);
			saveData.ClearResume();
			Debug.Log("DiscardTemp result : " + saveData.DiscardTemp());
			m_canvasGroup.blocksRaycasts = false;
			m_game.LoadAlbum();
		}
	}

	public void StartOverYes()
	{
		AkSoundEngine.PostEvent(m_audioYes, base.gameObject);
		m_canvasGroup.blocksRaycasts = false;
		m_game.ReloadLevel();
	}

	public void StartOverNo()
	{
		AkSoundEngine.PostEvent(m_audioNo, base.gameObject);
		SwitchScreen(1);
	}

	public void PlaybackEncode(bool _start)
	{
		if (_start)
		{
			if (!string.IsNullOrEmpty(m_audioPlaybackEncodeStart))
			{
				AkSoundEngine.PostEvent(m_audioPlaybackEncodeStart, base.gameObject);
			}
		}
		else if (!string.IsNullOrEmpty(m_audioPlaybackEncodeEnd))
		{
			AkSoundEngine.PostEvent(m_audioPlaybackEncodeEnd, base.gameObject);
		}
	}

	public void PlaybackDialogShow()
	{
		if (!string.IsNullOrEmpty(m_audioPlaybackDialogShow))
		{
			AkSoundEngine.PostEvent(m_audioPlaybackDialogShow, base.gameObject);
		}
	}

	public void PlaybackAccept()
	{
		if (!string.IsNullOrEmpty(m_audioPlaybackAccept))
		{
			AkSoundEngine.PostEvent(m_audioPlaybackAccept, base.gameObject);
		}
		m_game.PlaybackReturn();
	}

	public void SaveReplace()
	{
		AkSoundEngine.PostEvent(m_audioYes, base.gameObject);
		m_game.FileSaveReplace();
		if (m_nextDest == nextDest.album)
		{
			saveData.ClearResume();
		}
		saveData.DiscardTemp();
		m_canvasGroup.blocksRaycasts = false;
		if (m_nextDest == nextDest.album)
		{
			m_game.LoadAlbum();
		}
		else
		{
			m_game.LoadTitle();
		}
	}

	public void SaveAbandon()
	{
		AkSoundEngine.PostEvent(m_audioYes, base.gameObject);
		saveData.ClearResume();
		saveData.DiscardTemp();
		m_canvasGroup.blocksRaycasts = false;
		if (m_nextDest == nextDest.album)
		{
			m_game.LoadAlbum();
		}
		else
		{
			m_game.LoadTitle();
		}
	}

	public void SaveCancel()
	{
		AkSoundEngine.PostEvent(m_audioNo, base.gameObject);
		SwitchScreen(1);
	}

	public void MainMenu()
	{
		if (m_game.CheckUnsavedChanges())
		{
			AkSoundEngine.PostEvent(m_audioDialog, base.gameObject);
			m_nextDest = nextDest.mainMenu;
			SwitchScreen(4);
		}
		else
		{
			AkSoundEngine.PostEvent(m_audioMainMenu, base.gameObject);
			saveData.DiscardTemp();
			m_canvasGroup.blocksRaycasts = false;
			m_game.LoadTitle();
		}
	}

	public void Return()
	{
		AkSoundEngine.PostEvent(m_audioReturn, base.gameObject);
		SwitchScreen(1);
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

	public void ZoomIn()
	{
		AkSoundEngine.PostEvent(m_audioZoomIn, base.gameObject);
		m_game.ZoomIn();
	}

	public void ZoomOut()
	{
		AkSoundEngine.PostEvent(m_audioZoomOut, base.gameObject);
		m_game.ZoomOut();
	}

	public void IgnoreNextMenuChange(bool _value = true)
	{
		m_ignoreNextMenuChange = _value;
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

	public void ValidateToggle()
	{
		m_game.ValidateToggle();
	}

	public void RotateTutorialAudio()
	{
		AkSoundEngine.PostEvent(m_audioRotateTutorial, base.gameObject);
	}

	public void Screenshot()
	{
		AkSoundEngine.PostEvent(m_audioScreenshot, base.gameObject);
	}

	public void MotionControl()
	{
		inputHandler.SetMotionControl();
	}
}
