using UnityEngine;

public class computerDisplayScript : attachmentBaseScript
{
	private bool m_active;

	public Animator m_animator;

	public string m_anim;

	public string m_animFlipped;

	public string m_animOff;

	private bool m_flipped;

	private itemAnimAudioScript m_audio;

	public SpriteRenderer[] m_displayFlicker;

	public float m_displayFlickerFrequency = 1f;

	private bool m_init;

	private Transform m_audioWheel;

	private gameScript m_gameScript;

	public float m_timeCap = 1f;

	public bool m_timeSync;

	private void Init()
	{
		if (!m_init)
		{
			m_init = true;
			m_audio = m_animator.GetComponent<itemAnimAudioScript>();
			m_gameScript = Camera.main.GetComponent<gameScript>();
			if (!(m_gameScript == null))
			{
				m_audioWheel = m_gameScript.audioWheel;
			}
		}
	}

	public override void ChangeState(itemScript.itemState _state)
	{
		m_flipped = _state == itemScript.itemState.flipped || _state == itemScript.itemState.reverseFlipped;
	}

	public override float GetAnimTime()
	{
		if (!m_timeSync)
		{
			return 1f;
		}
		return m_animator.GetCurrentAnimatorStateInfo(0).normalizedTime;
	}

	public override void ComputerDisplay(int _function, float _time = 0f)
	{
		Init();
		if (_function < 0)
		{
			m_active = false;
			m_animator.Play(m_animOff);
		}
		else
		{
			m_active = true;
			m_animator.keepAnimatorStateOnDisable = true;
			if (_function == 0)
			{
				m_animator.Play(m_flipped ? m_animFlipped : m_anim, 0, Mathf.Min(m_timeCap, _time));
			}
			else
			{
				m_animator.Play(m_flipped ? m_animFlipped : m_anim, 0, 1f);
			}
		}
		if (m_active)
		{
			m_gameScript.zone.KeepAliveAdd(m_animator.transform);
			if (m_audio != null)
			{
				m_audio.SetReverb(m_gameScript.reverbID);
				m_audio.audioTransform.parent = m_audioWheel;
			}
		}
		else
		{
			m_gameScript.zone.KeepAliveRemove(m_animator.transform);
			if (m_audio != null)
			{
				m_audio.audioTransform.parent = m_animator.transform;
			}
		}
	}

	private void LateUpdate()
	{
		if (m_active && m_displayFlicker.Length != 0)
		{
			float a = Mathf.Lerp(0.97f, 1f, Mathf.Sin(Time.time * m_displayFlickerFrequency) * 0.5f + 0.5f);
			for (int i = 0; i < m_displayFlicker.Length; i++)
			{
				Color color = m_displayFlicker[i].color;
				color.a = a;
				m_displayFlicker[i].color = color;
			}
		}
	}

	public override void DestroyItem()
	{
		m_animator.transform.SetParent(base.transform, worldPositionStays: false);
	}
}
