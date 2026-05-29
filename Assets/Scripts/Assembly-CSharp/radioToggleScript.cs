using System;
using UnityEngine;

public class radioToggleScript : attachmentBaseScript
{
	[Serializable]
	public struct art
	{
		public string m_variant;

		public itemScript.itemState m_state;

		public Sprite m_sprite;

		public Sprite[] m_anim;
	}

	public string m_audio = "CassettePlayer";

	public gameScript.musicPlayerId m_playerId;

	public bool m_playerIdByVariant;

	public bool m_playWhenValidOnly;

	private bool m_valid;

	private bool m_init;

	private bool m_active;

	private bool m_animating;

	private float m_animTimer;

	private int m_animFrame;

	private gameScript m_gameScript;

	private itemScript m_itemScript;

	private itemScript.itemState m_state;

	public art[] m_activeArt;

	public bool m_rotateAudio = true;

	public itemScript item => m_itemScript;

	public override bool canPlacedInteract => true;

	public override void ChangeState(itemScript.itemState _state)
	{
		if (m_rotateAudio)
		{
			float y = 0f;
			switch (_state)
			{
			case itemScript.itemState.normal:
				y = 135f;
				break;
			case itemScript.itemState.flipped:
				y = -135f;
				break;
			case itemScript.itemState.reverse:
				y = -45f;
				break;
			case itemScript.itemState.reverseFlipped:
				y = 45f;
				break;
			}
			base.transform.localEulerAngles = new Vector3(0f, y, 0f);
		}
		m_state = _state;
		if (m_active)
		{
			SetArt();
		}
	}

	public override void ChangeValidity(bool _value)
	{
		if (m_playWhenValidOnly)
		{
			m_valid = _value;
			if (m_active && !_value)
			{
				m_active = false;
				m_gameScript.MusicPlayerStop();
				Stop();
			}
		}
	}

	private void init()
	{
		base.transform.localPosition = Vector3.forward * (0f - base.transform.parent.position.z);
		m_init = true;
		m_itemScript = base.transform.parent.GetComponent<itemScript>();
		m_gameScript = Camera.main.GetComponent<gameScript>();
		if (m_playerIdByVariant)
		{
			m_playerId = (gameScript.musicPlayerId)m_itemScript.GetVariant();
		}
	}

	public override bool PlacedInteract(bool _instant = false)
	{
		if (m_playWhenValidOnly && !m_valid)
		{
			if (!m_init)
			{
				init();
			}
			AkSoundEngine.PostEvent(m_audio + "_Play", m_itemScript.audioGO);
			return false;
		}
		m_active = !m_active;
		if (m_active)
		{
			if (!m_init)
			{
				init();
			}
			m_gameScript.MusicPlayerStart(this, m_playerId);
			AkSoundEngine.PostEvent(m_audio + "_Play", m_itemScript.audioGO);
			statsScript.SpecialEvent(statsScript.specialEvents.tapeDeck);
			statsScript.AwardSticker(statsScript.stickers.sticker_music);
			SetArt();
		}
		else
		{
			m_gameScript.MusicPlayerStop();
			Stop();
		}
		return true;
	}

	public void Stop(GameObject _go = null)
	{
		AkSoundEngine.PostEvent(m_audio + "_Stop", (_go == null) ? m_itemScript.audioGO : _go);
		m_active = false;
		SetArtOff();
	}

	private void Update()
	{
		if (m_animating)
		{
			m_animTimer += Time.deltaTime;
			if (m_animTimer > 0.1f)
			{
				m_animTimer -= 0.1f;
				m_animFrame++;
				SetArt();
			}
		}
	}

	public override void ChangePlaced(bool _value)
	{
		if (m_active)
		{
			base.transform.localPosition = Vector3.forward * (0f - base.transform.parent.position.z);
			m_gameScript.MusicPlayerPlace(_value);
		}
	}

	private void OnDrawGizmos()
	{
		Gizmos.color = (m_active ? Color.green : Color.yellow);
		Gizmos.DrawRay(base.transform.position - Vector3.up * 0.1f, Vector3.up * 0.2f);
		Gizmos.DrawRay(base.transform.position, base.transform.forward * 0.5f);
	}

	private void SetArt()
	{
		for (int i = 0; i < m_activeArt.Length; i++)
		{
			if (m_activeArt[i].m_state != m_state || (!string.IsNullOrEmpty(m_activeArt[i].m_variant) && !m_activeArt[i].m_variant.Equals(m_itemScript.GetVariantNameSimple())))
			{
				continue;
			}
			if (m_activeArt[i].m_sprite != null)
			{
				m_itemScript.SetArt(m_activeArt[i].m_sprite);
				m_animating = false;
				break;
			}
			if (m_animFrame >= m_activeArt[i].m_anim.Length)
			{
				m_animFrame = 0;
			}
			m_itemScript.SetArt(m_activeArt[i].m_anim[m_animFrame]);
			m_animating = true;
			break;
		}
	}

	private void SetArtOff()
	{
		if (!m_init)
		{
			return;
		}
		m_animating = false;
		for (int i = 0; i < m_activeArt.Length; i++)
		{
			if (m_activeArt[i].m_state == m_state)
			{
				m_itemScript.SetArt();
				break;
			}
		}
	}
}
