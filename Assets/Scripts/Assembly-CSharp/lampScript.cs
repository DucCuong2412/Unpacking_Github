using System;
using UnityEngine;

public class lampScript : attachmentBaseScript
{
	public enum type
	{
		lamp = 0,
		lavaLamp = 1
	}

	[Serializable]
	public struct lavaFrames
	{
		public SpriteRenderer m_renderer;

		public Sprite[] m_frames;

		public Sprite[] m_framesLit;
	}

	private enum lavaAnimState
	{
		off = 0,
		warming = 1,
		risingA = 2,
		risingB = 3,
		looping = 4,
		fallingA = 5,
		fallingB = 6
	}

	[Header("WWise Events")]
	public string m_audioOn;

	public string m_audioOff;

	[Space(20f)]
	public type m_type;

	public Sprite m_lit;

	public Sprite m_litFlipped;

	private bool m_flipped;

	public lavaFrames m_lavaBase;

	public lavaFrames m_lavaTop;

	public lavaFrames m_lavaRising;

	public lavaFrames m_lavaFalling;

	private float m_lavaAnimTime;

	private float m_lavaAnimSpeed;

	private int m_lavaAnimFrame;

	private bool m_lavaActive;

	private bool m_instant;

	private lavaAnimState m_lavaAnimState;

	public SpriteRenderer m_glow;

	public AnimationCurve m_glowSize;

	public Gradient m_glowColor;

	public float m_glowOnRate = 1f;

	public float m_glowOffRate = 1f;

	public float m_rotate;

	private bool m_valid;

	private bool m_active;

	private float m_lerp;

	private bool m_init;

	private itemScript m_item;

	private gameScript m_gameScript;

	private zoneScript m_zone;

	public override int attachmentValues => 1;

	public override bool canPlacedInteract => true;

	private void Init()
	{
		if (!m_init)
		{
			m_init = true;
			m_item = base.transform.parent.GetComponent<itemScript>();
			if (m_type == type.lavaLamp)
			{
				m_gameScript = Camera.main.GetComponent<gameScript>();
			}
		}
	}

	public override int[] GetAttachmentValues()
	{
		return new int[1] { m_active ? 1 : 0 };
	}

	public override void SetAttachmentValues(int[] _values)
	{
		if (_values[0] <= 0)
		{
			return;
		}
		m_active = true;
		if (m_valid)
		{
			SetLamp(2);
			if (m_type == type.lavaLamp)
			{
				m_zone = m_gameScript.zone;
				m_zone.KeepAliveAdd(base.transform);
			}
		}
	}

	public override void ChangeValidity(bool _valid)
	{
		m_valid = _valid;
		if (m_active)
		{
			SetLamp((!m_valid) ? (m_instant ? (-1) : 0) : ((!m_instant) ? 1 : 2));
		}
	}

	public override void ChangePlaced(bool _value)
	{
		if (m_type != type.lavaLamp)
		{
			return;
		}
		if (_value)
		{
			if (((m_valid && m_active) || m_lavaAnimSpeed > 0f) && m_zone == null)
			{
				m_zone = m_gameScript.zone;
				m_zone.KeepAliveAdd(base.transform);
			}
		}
		else if (m_zone != null)
		{
			m_zone.KeepAliveRemove(base.transform);
			m_zone = null;
		}
	}

	public override bool PlacedInteract(bool _instant = false)
	{
		Init();
		m_instant = _instant;
		m_active = !m_active;
		if (m_active)
		{
			if (!string.IsNullOrEmpty(m_audioOn))
			{
				AkSoundEngine.PostEvent(m_audioOn, m_item.audioGO);
			}
		}
		else if (!string.IsNullOrEmpty(m_audioOff))
		{
			AkSoundEngine.PostEvent(m_audioOff, m_item.audioGO);
		}
		if (m_valid)
		{
			SetLamp((!m_active) ? (m_instant ? (-1) : 0) : ((!m_instant) ? 1 : 2));
			if (m_type == type.lavaLamp && m_zone == null)
			{
				m_zone = m_gameScript.zone;
				m_zone.KeepAliveAdd(base.transform);
			}
		}
		return true;
	}

	public override void ChangeState(itemScript.itemState _state)
	{
		if (_state == itemScript.itemState.normal)
		{
			m_glow.transform.localEulerAngles = new Vector3(0f, 0f, m_rotate);
		}
		else
		{
			m_glow.transform.localEulerAngles = new Vector3(0f, 0f, 0f - m_rotate);
		}
		m_flipped = _state == itemScript.itemState.flipped || _state == itemScript.itemState.reverseFlipped;
	}

	private void SetLamp(int _value)
	{
		Init();
		if (_value <= 0)
		{
			m_item.SetArt();
			if (m_type == type.lavaLamp && m_lavaActive)
			{
				SetLavaFrame();
			}
			if (_value == -1)
			{
				m_lerp = 0f;
			}
		}
		else
		{
			m_item.SetArt((!m_flipped || m_litFlipped == null) ? m_lit : m_litFlipped);
			if (m_type == type.lavaLamp && m_lavaActive)
			{
				SetLavaFrame();
			}
			if (_value == 1)
			{
				if (m_type == type.lavaLamp)
				{
					SetLavaArt();
				}
			}
			else
			{
				m_lerp = 1f;
				if (m_type == type.lavaLamp)
				{
					m_lavaAnimState = lavaAnimState.looping;
					m_lavaAnimSpeed = 3.5f;
				}
			}
		}
		SetColor();
	}

	private void Update()
	{
		bool flag = m_active && m_valid;
		if (flag && m_lerp < 1f)
		{
			m_lerp = Mathf.MoveTowards(m_lerp, 1f, Time.deltaTime * m_glowOnRate);
			SetColor();
		}
		else if (!flag && m_lerp > 0f)
		{
			m_lerp = Mathf.MoveTowards(m_lerp, 0f, Time.deltaTime * m_glowOffRate);
			SetColor();
		}
		if (m_type != type.lavaLamp)
		{
			return;
		}
		if (flag || m_lavaAnimState != lavaAnimState.off)
		{
			if (flag)
			{
				m_lavaAnimSpeed = Mathf.Lerp(m_lavaAnimSpeed, 3.5f, Time.deltaTime * 0.0125f);
			}
			else
			{
				m_lavaAnimSpeed = Mathf.Lerp(m_lavaAnimSpeed, 0.25f, Time.deltaTime * 0.1f);
			}
			m_lavaAnimTime += Time.deltaTime * m_lavaAnimSpeed * 2f;
			if (!(m_lavaAnimTime >= 1f))
			{
				return;
			}
			m_lavaAnimTime -= 1f;
			m_lavaAnimFrame++;
			m_lavaAnimFrame %= 12;
			switch (m_lavaAnimState)
			{
			case lavaAnimState.off:
				m_lavaAnimFrame = 0;
				m_lavaAnimState = lavaAnimState.warming;
				break;
			case lavaAnimState.warming:
				if (flag && m_lavaAnimSpeed > 2f && m_lavaAnimFrame == 6)
				{
					m_lavaAnimState = lavaAnimState.risingA;
				}
				else if (!flag && m_lavaAnimSpeed < 0.5f && m_lavaAnimFrame == 10)
				{
					m_lavaAnimState = lavaAnimState.off;
				}
				break;
			case lavaAnimState.risingA:
				if (m_lavaAnimFrame == 2)
				{
					m_lavaAnimState = lavaAnimState.risingB;
				}
				break;
			case lavaAnimState.risingB:
				if (m_lavaAnimFrame == 8)
				{
					m_lavaAnimState = lavaAnimState.looping;
				}
				break;
			case lavaAnimState.looping:
				if (!flag && m_lavaAnimSpeed < 2f && m_lavaAnimFrame == 4)
				{
					m_lavaAnimState = lavaAnimState.fallingA;
				}
				break;
			case lavaAnimState.fallingA:
				if (m_lavaAnimFrame == 4)
				{
					m_lavaAnimState = lavaAnimState.fallingB;
				}
				break;
			case lavaAnimState.fallingB:
				if (m_lavaAnimFrame == 8)
				{
					m_lavaAnimState = lavaAnimState.warming;
				}
				break;
			}
			m_lavaActive = m_lavaAnimState != lavaAnimState.off;
			SetLavaFrame();
			if (!flag)
			{
				SetLavaArt();
			}
		}
		else if (m_lavaAnimSpeed > 0f)
		{
			m_lavaAnimSpeed = Mathf.MoveTowards(m_lavaAnimSpeed, 0f, Time.deltaTime * 0.1f);
			if (m_zone != null && m_lavaAnimSpeed.Equals(0f))
			{
				m_zone.KeepAliveRemove(base.transform);
				m_zone = null;
			}
		}
	}

	private void SetLavaArt()
	{
		int sortingLayer = m_item.sortingLayer;
		Color spriteColor = m_item.GetSpriteColor();
		m_lavaBase.m_renderer.sortingOrder = sortingLayer;
		m_lavaBase.m_renderer.color = spriteColor;
		m_lavaTop.m_renderer.sortingOrder = sortingLayer;
		m_lavaTop.m_renderer.color = spriteColor;
		m_lavaRising.m_renderer.sortingOrder = sortingLayer;
		m_lavaRising.m_renderer.color = spriteColor;
		m_lavaFalling.m_renderer.sortingOrder = sortingLayer;
		m_lavaFalling.m_renderer.color = spriteColor;
	}

	private void SetLavaFrame()
	{
		int num = 12;
		m_lavaBase.m_renderer.enabled = m_lavaAnimState != lavaAnimState.off;
		m_lavaTop.m_renderer.enabled = m_lavaAnimState == lavaAnimState.looping || m_lavaAnimState == lavaAnimState.risingB || m_lavaAnimState == lavaAnimState.fallingA || m_lavaAnimState == lavaAnimState.fallingB;
		m_lavaRising.m_renderer.enabled = m_lavaAnimState == lavaAnimState.looping || m_lavaAnimState == lavaAnimState.risingA || m_lavaAnimState == lavaAnimState.risingB;
		m_lavaFalling.m_renderer.enabled = m_lavaAnimState == lavaAnimState.looping || m_lavaAnimState == lavaAnimState.fallingA || m_lavaAnimState == lavaAnimState.fallingB;
		bool flag = m_active && m_valid;
		m_lavaBase.m_renderer.sprite = (flag ? m_lavaBase.m_framesLit[m_lavaAnimFrame % num] : m_lavaBase.m_frames[m_lavaAnimFrame % num]);
		m_lavaTop.m_renderer.sprite = (flag ? m_lavaTop.m_framesLit[m_lavaAnimFrame % num] : m_lavaTop.m_frames[m_lavaAnimFrame % num]);
		m_lavaRising.m_renderer.sprite = (flag ? m_lavaRising.m_framesLit[m_lavaAnimFrame % num] : m_lavaRising.m_frames[m_lavaAnimFrame % num]);
		m_lavaFalling.m_renderer.sprite = (flag ? m_lavaFalling.m_framesLit[m_lavaAnimFrame % num] : m_lavaFalling.m_frames[m_lavaAnimFrame % num]);
	}

	private void SetColor()
	{
		m_glow.enabled = m_lerp > 0f;
		m_glow.color = m_glowColor.Evaluate(m_lerp);
		m_glow.transform.localScale = Vector3.one * m_glowSize.Evaluate(m_lerp);
	}

	public override void DestroyItem()
	{
		UnityEngine.Object.Destroy(base.gameObject);
	}
}
