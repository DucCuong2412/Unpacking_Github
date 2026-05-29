using System;
using UnityEngine;

public class whiteboardScript : attachmentBaseScript
{
	[Serializable]
	public struct drawings
	{
		public int stage;

		public int variantBase;

		public int variantDraw;

		public Sprite[] draw;

		public Sprite[] drawFlipped;

		public Sprite[] erase;

		public Sprite[] eraseFlipped;
	}

	private enum animMode
	{
		none = 0,
		draw = 1,
		erase = 2
	}

	[Header("WWise Events")]
	public string m_audioDraw;

	public string m_audioErase;

	[Space(20f)]
	public drawings[] m_drawings;

	private bool m_init;

	private int m_animIndex = -1;

	private animMode m_anim;

	private float m_animTimer;

	private int m_animFrame;

	public override bool canPlacedInteract => base.transform.parent.GetComponent<itemScript>().isNonFlatState;

	private void Init()
	{
		if (m_init)
		{
			return;
		}
		m_init = true;
		int currentStage = UnityEngine.Object.FindObjectOfType<gameScript>().currentStage;
		for (int i = 0; i < m_drawings.Length; i++)
		{
			if (m_drawings[i].stage == currentStage)
			{
				m_animIndex = i;
				break;
			}
		}
	}

	public override bool PlacedInteract(bool _instant = false)
	{
		Init();
		if (m_animIndex != -1)
		{
			itemScript component = base.transform.parent.GetComponent<itemScript>();
			if (!component.isNonFlatState)
			{
				return false;
			}
			if (component.GetVariant() == m_drawings[m_animIndex].variantBase)
			{
				component.SetVariant(m_drawings[m_animIndex].variantDraw);
				if (!string.IsNullOrEmpty(m_audioErase))
				{
					AkSoundEngine.PostEvent(m_audioDraw, component.audioGO);
				}
				if (!_instant)
				{
					m_animFrame = 0;
					m_animTimer = 0f;
					m_anim = animMode.draw;
				}
			}
			else
			{
				component.SetVariant(m_drawings[m_animIndex].variantBase);
				if (!string.IsNullOrEmpty(m_audioErase))
				{
					AkSoundEngine.PostEvent(m_audioErase, component.audioGO);
				}
				if (!_instant)
				{
					m_animFrame = 0;
					m_animTimer = 0f;
					m_anim = animMode.erase;
				}
			}
			SetFrame();
			return true;
		}
		return false;
	}

	public override void ChangePlaced(bool _value)
	{
		m_anim = animMode.none;
	}

	public void Update()
	{
		if (m_anim == animMode.none)
		{
			return;
		}
		m_animTimer += Time.deltaTime;
		if (m_animTimer > 0.15f)
		{
			m_animTimer = 0f;
			m_animFrame++;
			if (m_animFrame >= ((m_anim == animMode.draw) ? m_drawings[m_animIndex].draw.Length : m_drawings[m_animIndex].erase.Length))
			{
				m_anim = animMode.none;
			}
			SetFrame();
		}
	}

	private void SetFrame()
	{
		itemScript component = base.transform.parent.GetComponent<itemScript>();
		if (m_anim == animMode.draw)
		{
			component.SetArt(m_drawings[m_animIndex].draw[m_animFrame], m_drawings[m_animIndex].drawFlipped[m_animFrame]);
		}
		else if (m_anim == animMode.erase)
		{
			component.SetArt(m_drawings[m_animIndex].erase[m_animFrame], m_drawings[m_animIndex].eraseFlipped[m_animFrame]);
		}
		else
		{
			component.SetArt();
		}
	}
}
