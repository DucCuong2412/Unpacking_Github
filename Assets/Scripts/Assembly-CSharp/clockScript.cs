using System;
using UnityEngine;

public class clockScript : attachmentBaseScript
{
	[Serializable]
	public struct handFrames
	{
		public itemScript.itemState m_state;

		public Sprite[] m_hours;

		public Sprite[] m_minutes;

		public Sprite[] m_misc;

		public bool m_flip;
	}

	public SpriteRenderer m_handHours;

	public SpriteRenderer m_handMinutes;

	public SpriteRenderer[] m_misc;

	public handFrames[] m_frameSets;

	private int m_currentSet;

	private int m_hour = -1;

	private int m_minute = -1;

	public override void ChangePlaced(bool _value)
	{
		SetArt();
	}

	public override void ChangeState(itemScript.itemState _state)
	{
		for (int i = 0; i < m_misc.Length; i++)
		{
			m_misc[i].flipX = _state == itemScript.itemState.flipped;
		}
		for (int j = 0; j < m_frameSets.Length; j++)
		{
			if (m_frameSets[j].m_state == _state)
			{
				m_currentSet = j;
				SetTime();
			}
		}
	}

	private void Update()
	{
		int hour = timeOfDayScript.hour;
		int minute = timeOfDayScript.minute;
		if (hour != m_hour || minute != m_minute)
		{
			m_hour = hour;
			m_minute = minute;
			SetTime();
		}
	}

	private void SetTime()
	{
		int num = Mathf.Clamp((m_hour - ((m_minute <= 55) ? 1 : 0)) % 12, 0, m_frameSets[m_currentSet].m_hours.Length - 1);
		int num2 = Mathf.Clamp(Mathf.CeilToInt((float)m_minute / 5f) - 1, 0, m_frameSets[m_currentSet].m_minutes.Length - 1);
		m_handHours.sprite = m_frameSets[m_currentSet].m_hours[num];
		m_handMinutes.sprite = m_frameSets[m_currentSet].m_minutes[num2];
		m_handHours.flipX = m_frameSets[m_currentSet].m_flip;
		m_handMinutes.flipX = m_frameSets[m_currentSet].m_flip;
		for (int i = 0; i < m_misc.Length; i++)
		{
			if (m_frameSets[m_currentSet].m_misc.Length < i)
			{
				m_misc[i].sprite = m_frameSets[m_currentSet].m_misc[i];
			}
			m_misc[i].flipX = m_frameSets[m_currentSet].m_flip;
		}
	}

	private void SetArt()
	{
		itemScript component = base.transform.parent.GetComponent<itemScript>();
		int sortingLayer = component.sortingLayer;
		Color spriteColor = component.GetSpriteColor();
		m_handHours.sortingOrder = sortingLayer;
		m_handHours.color = spriteColor;
		m_handMinutes.sortingOrder = sortingLayer;
		m_handMinutes.color = spriteColor;
		for (int i = 0; i < m_misc.Length; i++)
		{
			m_misc[i].sortingOrder = sortingLayer;
			m_misc[i].color = spriteColor;
		}
	}
}
