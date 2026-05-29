using System;
using UnityEngine;

public class animAudioEventScript : MonoBehaviour
{
	[Serializable]
	public struct SimpleAudioEvent
	{
		public string m_description;

		public string m_audioEvent;

		[HideInInspector]
		public uint m_audioID;
	}

	private bool m_fadeUp = true;

	private bool m_fadeDownAndLoad;

	public float m_fader;

	private bool m_textFadeActive;

	public CanvasGroup m_textGroup;

	public float m_textFade = 1f;

	public CC_BrightnessContrastGamma m_brightness;

	public CanvasGroup m_canvasGroup;

	public SimpleAudioEvent[] m_events;

	public titleBackgroundPan m_background;

	public CanvasGroup m_mainMenuCanvas;

	private bool m_menuFadeUp;

	private void Start()
	{
		AkSoundEngine.SetState("Music_State", "title");
		AkSoundEngine.SetState("Game_State", "gameplay");
		if (gameStateScript.IsQuickTitleReturn())
		{
			GetComponent<Animator>().Play("start_pulse");
			m_background.enabled = true;
			m_background.Finish();
			TriggerMenuFadeUp();
		}
	}

	private void Update()
	{
		if (!m_menuFadeUp && inputHandler.IsPressed(InputAction.Gameplay_Menu, ignoreInputHandled: true))
		{
			for (int i = 0; i < m_events.Length; i++)
			{
				if (m_events[i].m_audioID != 0)
				{
					AkSoundEngine.StopPlayingID(m_events[i].m_audioID);
				}
			}
			GetComponent<Animator>().Play("start_pulse");
			m_background.enabled = true;
			m_background.Finish();
			TriggerMenuFadeUp();
			m_textFade = 1f;
			TextFadeActive(0);
		}
		if (m_fadeUp || m_fadeDownAndLoad)
		{
			if (m_fadeUp)
			{
				m_fader += Time.deltaTime * 2f;
				if (m_fader >= 1f)
				{
					m_brightness.enabled = false;
					m_fadeUp = false;
				}
			}
			else if (m_fadeDownAndLoad)
			{
				m_fader -= Time.deltaTime * 4f;
				if (m_fader <= 0f)
				{
					m_fadeDownAndLoad = false;
				}
			}
			m_canvasGroup.alpha = Mathf.InverseLerp(0.5f, 1f, m_fader);
			m_brightness.brightness = Mathf.Lerp(-30f, 0f, m_fader);
			m_brightness.gamma = Mathf.Lerp(0.1f, 1f, m_fader);
		}
		if (m_menuFadeUp && m_mainMenuCanvas.alpha < 1f)
		{
			m_mainMenuCanvas.alpha += Time.deltaTime * 1f;
		}
		if (m_textFadeActive)
		{
			m_textGroup.alpha = m_textFade;
		}
	}

	private void TextFadeActive(int _value)
	{
		m_textFadeActive = _value == 1;
		if (_value == 0)
		{
			m_textGroup.alpha = m_textFade;
		}
	}

	private void AudioEvent(int _index)
	{
		if (_index < m_events.Length && !string.IsNullOrEmpty(m_events[_index].m_audioEvent))
		{
			m_events[_index].m_audioID = AkSoundEngine.PostEvent(m_events[_index].m_audioEvent, base.gameObject);
		}
	}

	private void TriggerBackgroundScroll()
	{
		m_background.enabled = true;
	}

	private void TriggerStartActive()
	{
	}

	public void TriggerFadeDown()
	{
		m_canvasGroup.interactable = false;
		m_fadeDownAndLoad = true;
		m_brightness.enabled = true;
	}

	public void TriggerMenuFadeUp()
	{
		m_menuFadeUp = true;
		m_mainMenuCanvas.interactable = true;
		m_mainMenuCanvas.blocksRaycasts = true;
	}
}
