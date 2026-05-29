using UnityEngine;

public class televisionDisplayScript : MonoBehaviour
{
	private computerConsoleScript m_activeConsole;

	private Animator m_animator;

	public string m_animOff;

	public string[] m_anim;

	public SpriteRenderer[] m_displayFlicker;

	public float m_displayFlickerFrequency = 1f;

	public float m_displayFlickerDip = 0.97f;

	public GameObject m_audio;

	public void Init()
	{
		m_animator = GetComponent<Animator>();
		m_animator.keepAnimatorStateOnDisable = true;
		zoneScript componentInParent = GetComponentInParent<zoneScript>();
		componentInParent.KeepAliveAdd(base.transform);
		if (m_audio != null)
		{
			AkAuxSendArray akAuxSendArray = new AkAuxSendArray();
			akAuxSendArray.Add(componentInParent.reverbID, 1f);
			AkSoundEngine.SetGameObjectAuxSendValues(m_audio, akAuxSendArray, 1u);
			Vector3 position = m_audio.transform.position;
			position.z = 0f;
			m_audio.transform.position = position;
			m_audio.transform.parent = Object.FindObjectOfType<gameScript>().audioWheel;
		}
	}

	public void Display(computerConsoleScript _activeConsole, bool _fast = false)
	{
		if (_activeConsole == null)
		{
			m_activeConsole = null;
			m_animator.Play(m_animOff);
			return;
		}
		if (m_activeConsole != null)
		{
			m_activeConsole.Off();
		}
		m_activeConsole = _activeConsole;
		if (!_fast)
		{
			m_animator.Play(m_anim[m_activeConsole.m_televisionId]);
		}
		else
		{
			m_animator.Play(m_anim[m_activeConsole.m_televisionId], 0, 1f);
		}
		statsScript.AwardSticker(statsScript.stickers.sticker_gaming);
	}

	private void LateUpdate()
	{
		if (m_activeConsole != null && m_displayFlicker.Length != 0)
		{
			float a = Mathf.Lerp(m_displayFlickerDip, 1f, Mathf.Sin(Time.time * m_displayFlickerFrequency) * 0.5f + 0.5f);
			for (int i = 0; i < m_displayFlicker.Length; i++)
			{
				Color color = m_displayFlicker[i].color;
				color.a = a;
				m_displayFlicker[i].color = color;
			}
		}
	}

	public void PlaySound(string _audio)
	{
		if (m_audio != null)
		{
			AkSoundEngine.PostEvent(_audio, m_audio);
		}
		else
		{
			Debug.LogWarning("Television Display does not have a audio gameobject!");
		}
	}
}
