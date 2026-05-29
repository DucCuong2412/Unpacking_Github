using UnityEngine;
using UnityEngine.UI;

public class uiCompleteScript : MonoBehaviour
{
	private enum uiCompleteState
	{
		appear = 0,
		disappear = 1,
		hold = 2
	}

	private gameScript m_game;

	public ParticleSystem m_particles;

	public Sprite[] m_starAppear;

	public Sprite[] m_starIdle;

	public Sprite[] m_darkStarAppear;

	public Sprite[] m_darkStarIdle;

	private bool m_darkMode;

	public uiSmallStarSpawner m_starSpawner;

	private uiCompleteState m_state;

	private int m_frame;

	private float m_frameTime;

	private Image m_renderer;

	private Selectable m_ui;

	private bool m_silent;

	private bool m_simple;

	private bool m_init;

	public bool silent
	{
		set
		{
			m_silent = value;
		}
	}

	private void Init()
	{
		if (!m_init)
		{
			m_game = Camera.main.GetComponent<gameScript>();
			m_renderer = GetComponent<Image>();
			m_ui = GetComponent<Selectable>();
			m_init = true;
		}
	}

	public void Active(gameScript.gameEndMode _value)
	{
		Init();
		if (_value != gameScript.gameEndMode.unfinished)
		{
			m_darkMode = _value == gameScript.gameEndMode.noItemsValid;
			m_starSpawner.darkstar = m_darkMode;
			if (!base.gameObject.activeSelf)
			{
				base.gameObject.SetActive(value: true);
				m_ui.interactable = false;
				m_frame = 0;
				m_frameTime = 0f;
				m_renderer.sprite = (m_darkMode ? m_darkStarAppear[0] : m_starAppear[0]);
				m_state = uiCompleteState.appear;
			}
			else if (m_state == uiCompleteState.disappear)
			{
				m_frameTime = 0f;
				m_state = uiCompleteState.appear;
				if (m_frame >= 4)
				{
					m_starSpawner.spawn = true;
				}
			}
			if (m_silent)
			{
				return;
			}
			if (m_game.CompleteButtonSound())
			{
				string text = (m_darkMode ? m_game.m_audioDCompleteAppear : m_game.m_audioCompleteAppear);
				if (!string.IsNullOrEmpty(text))
				{
					AkSoundEngine.PostEvent(text, m_game.gameObject);
					m_simple = false;
				}
				vibrationScript.Trigger(vibrationScript.moment.stageClear);
			}
			else
			{
				string text2 = (m_darkMode ? m_game.m_audioDCompleteAppearSimple : m_game.m_audioCompleteAppearSimple);
				if (!string.IsNullOrEmpty(text2))
				{
					AkSoundEngine.PostEvent(text2, m_game.gameObject);
					m_simple = true;
				}
			}
		}
		else
		{
			if (!base.gameObject.activeSelf)
			{
				return;
			}
			m_ui.interactable = false;
			if (m_state == uiCompleteState.hold)
			{
				m_frame = m_starAppear.Length - ((!m_darkMode) ? 1 : 2);
			}
			m_state = uiCompleteState.disappear;
			m_starSpawner.spawn = false;
			if (!m_silent && !m_simple)
			{
				string text3 = (m_darkMode ? m_game.m_audioDCompleteCancel : m_game.m_audioCompleteCancel);
				if (!string.IsNullOrEmpty(text3))
				{
					AkSoundEngine.PostEvent(text3, m_game.gameObject);
				}
			}
			else
			{
				string text4 = (m_darkMode ? m_game.m_audioDCompleteCancelSimple : m_game.m_audioCompleteCancelSimple);
				if (!string.IsNullOrEmpty(text4))
				{
					AkSoundEngine.PostEvent(text4, m_game.gameObject);
				}
			}
			m_game.SetCompleteTriggered();
		}
	}

	private void Update()
	{
		m_frameTime += Time.deltaTime * ((m_state == uiCompleteState.disappear) ? 1.25f : 1f);
		if (!(m_frameTime > 0.075f))
		{
			return;
		}
		m_frameTime -= 0.075f;
		if (m_state == uiCompleteState.appear)
		{
			m_frame++;
			if (m_frame == 4)
			{
				m_starSpawner.spawn = true;
			}
			if (m_frame >= m_starAppear.Length)
			{
				m_frame = 0;
				m_state = uiCompleteState.hold;
				m_renderer.sprite = (m_darkMode ? m_darkStarIdle[m_frame] : m_starIdle[m_frame]);
				m_ui.interactable = true;
			}
			else
			{
				m_renderer.sprite = (m_darkMode ? m_darkStarAppear[m_frame] : m_starAppear[m_frame]);
			}
		}
		else if (m_state == uiCompleteState.hold)
		{
			m_frame++;
			if (m_frame >= m_starIdle.Length)
			{
				m_frame = 0;
			}
			m_renderer.sprite = (m_darkMode ? m_darkStarIdle[m_frame] : m_starIdle[m_frame]);
		}
		else if (m_state == uiCompleteState.disappear)
		{
			m_frame--;
			if (m_frame < 0)
			{
				m_frame = 0;
				base.gameObject.SetActive(value: false);
			}
			else
			{
				m_renderer.sprite = (m_darkMode ? m_darkStarAppear[m_frame] : m_starAppear[m_frame]);
			}
		}
	}
}
