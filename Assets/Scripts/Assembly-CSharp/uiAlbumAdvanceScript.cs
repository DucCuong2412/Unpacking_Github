using UnityEngine;
using UnityEngine.UI;

public class uiAlbumAdvanceScript : MonoBehaviour
{
	private enum uiState
	{
		appear = 0,
		disappear = 1,
		hold = 2
	}

	public enum type
	{
		none = 0,
		advance = 1,
		star = 2,
		darkstar = 3
	}

	public Sprite[] m_animAppear;

	public Sprite[] m_animIdle;

	public Sprite[] m_starAppear;

	public Sprite[] m_starIdle;

	public Sprite[] m_darkStarAppear;

	public Sprite[] m_darkStarIdle;

	public uiSmallStarSpawner m_starSpawner;

	private bool m_soundQueued;

	private bool m_soundQueuedStop;

	private uiState m_state;

	private type m_type = type.advance;

	private int m_frame;

	private float m_frameTime;

	private Image m_renderer;

	private Selectable m_ui;

	private Sprite[] appear
	{
		get
		{
			switch (m_type)
			{
			case type.star:
				return m_starAppear;
			case type.darkstar:
				return m_darkStarAppear;
			default:
				return m_animAppear;
			}
		}
	}

	private Sprite[] idle
	{
		get
		{
			switch (m_type)
			{
			case type.star:
				return m_starIdle;
			case type.darkstar:
				return m_darkStarIdle;
			default:
				return m_animIdle;
			}
		}
	}

	public bool pressable
	{
		get
		{
			if (base.gameObject.activeSelf)
			{
				return m_ui.interactable;
			}
			return false;
		}
	}

	public float delay
	{
		get
		{
			if (!base.gameObject.activeSelf)
			{
				return 0f;
			}
			if (m_state == uiState.hold)
			{
				return (float)(appear.Length - 1) * 0.06f;
			}
			return (float)m_frame * 0.06f;
		}
	}

	private void Awake()
	{
		m_renderer = GetComponent<Image>();
		m_ui = GetComponent<Selectable>();
	}

	public void Active(type _value, bool _silent = false)
	{
		if (_value != type.none)
		{
			m_type = _value;
			m_starSpawner.darkstar = m_type == type.darkstar;
			if (m_type == type.darkstar)
			{
				AkSoundEngine.SetState("Game_State", "darkstar");
			}
			if (!base.gameObject.activeSelf)
			{
				base.gameObject.SetActive(value: true);
				m_ui.interactable = false;
				m_frame = 0;
				m_frameTime = 0f;
				if (appear.Length != 0)
				{
					m_renderer.sprite = appear[0];
				}
				m_state = uiState.appear;
				m_soundQueued = true;
			}
			else if (m_state == uiState.disappear)
			{
				m_frameTime = 0f;
				m_state = uiState.appear;
				if (!_silent)
				{
					m_soundQueued = true;
				}
				if (m_frame >= 4 && m_type != type.advance)
				{
					m_starSpawner.spawn = true;
				}
			}
		}
		else if (base.gameObject.activeSelf && m_state != uiState.disappear)
		{
			if (m_type == type.darkstar)
			{
				AkSoundEngine.SetState("Game_State", "gameplay");
			}
			m_ui.interactable = false;
			if (m_state == uiState.hold)
			{
				m_frame = appear.Length - 1;
			}
			m_frameTime = 0f;
			m_state = uiState.disappear;
			if (!_silent)
			{
				m_soundQueued = !m_soundQueued;
			}
			if (_silent)
			{
				m_soundQueuedStop = true;
			}
			m_starSpawner.spawn = false;
		}
	}

	private void Update()
	{
		if (m_soundQueued)
		{
			albumManagerScript albumManagerScript2 = Object.FindObjectOfType<albumManagerScript>();
			string text;
			switch (m_type)
			{
			case type.star:
				text = ((m_state == uiState.appear) ? albumManagerScript2.m_audioStarAppear : albumManagerScript2.m_audioStarCancel);
				break;
			case type.darkstar:
				text = ((m_state == uiState.appear) ? albumManagerScript2.m_audioDarkStarAppear : albumManagerScript2.m_audioDarkStarCancel);
				break;
			default:
				text = ((m_state == uiState.appear) ? albumManagerScript2.m_audioAdvanceAppear : albumManagerScript2.m_audioAdvanceCancel);
				break;
			}
			if (!string.IsNullOrEmpty(text))
			{
				AkSoundEngine.PostEvent(text, albumManagerScript2.gameObject);
			}
			m_soundQueued = false;
		}
		if (m_soundQueuedStop)
		{
			albumManagerScript albumManagerScript3 = Object.FindObjectOfType<albumManagerScript>();
			string text2 = "";
			switch (m_type)
			{
			case type.star:
				text2 = albumManagerScript3.m_audioStarStop;
				break;
			case type.darkstar:
				text2 = albumManagerScript3.m_audioDarkStarStop;
				break;
			}
			if (!string.IsNullOrEmpty(text2))
			{
				AkSoundEngine.PostEvent(text2, albumManagerScript3.gameObject);
			}
			m_soundQueuedStop = false;
		}
		m_frameTime += Time.deltaTime * ((m_state == uiState.disappear) ? 1.25f : 1f);
		if (!(m_frameTime > 0.075f))
		{
			return;
		}
		m_frameTime -= 0.075f;
		if (m_state == uiState.appear)
		{
			m_frame++;
			if (m_frame == 4 && m_type != type.advance)
			{
				m_starSpawner.spawn = true;
			}
			if (m_frame >= appear.Length)
			{
				m_frame = 0;
				m_state = uiState.hold;
				m_renderer.sprite = idle[m_frame];
				m_ui.interactable = true;
			}
			else
			{
				m_renderer.sprite = appear[m_frame];
			}
		}
		else if (m_state == uiState.hold)
		{
			m_frame++;
			if (m_frame >= idle.Length)
			{
				m_frame = 0;
				if (m_type == type.advance)
				{
					m_frameTime -= 0.3f;
				}
			}
			m_renderer.sprite = idle[m_frame];
		}
		else if (m_state == uiState.disappear)
		{
			m_frame--;
			if (m_frame < 0)
			{
				m_frame = 0;
				base.gameObject.SetActive(value: false);
			}
			else
			{
				m_renderer.sprite = appear[m_frame];
			}
		}
	}
}
