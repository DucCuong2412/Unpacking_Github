using System;
using UnityEngine;

public class dateAnimateScript : MonoBehaviour
{
	[Serializable]
	public class Number
	{
		public Sprite[] frame;
	}

	public SpriteRenderer[] m_renderers = new SpriteRenderer[4];

	public Number[] m_numbers = new Number[10];

	private int[] m_year = new int[4];

	private bool m_active;

	private int m_frame;

	private bool m_newFrame = true;

	private float m_timer;

	private float m_frameInterval = 1f / 30f;

	public void SetDate(int _year, float[] _yearPos, float _rootPos)
	{
		m_year[0] = _year / 1000;
		m_year[1] = _year / 100 % 10;
		m_year[2] = _year / 10 % 10;
		m_year[3] = _year % 10;
		m_active = true;
		if (_yearPos != null)
		{
			for (int i = 0; i < Mathf.Min(m_renderers.Length, _yearPos.Length); i++)
			{
				Vector3 localPosition = m_renderers[i].transform.localPosition;
				localPosition.x = _yearPos[i];
				m_renderers[i].transform.localPosition = localPosition;
			}
		}
		Vector3 localPosition2 = base.transform.localPosition;
		localPosition2.x = _rootPos;
		base.transform.localPosition = localPosition2;
	}

	private void Update()
	{
		if (!m_active)
		{
			return;
		}
		if (m_newFrame)
		{
			int num = 41;
			int num2 = 15;
			if (m_frame >= num)
			{
				if (m_frame >= num + num2 * 4)
				{
					m_active = false;
				}
				else
				{
					int num3 = (m_frame - num) / num2;
					int num4 = (m_frame - num) % num2;
					if (num4 < m_numbers[m_year[num3]].frame.Length)
					{
						m_renderers[num3].sprite = m_numbers[m_year[num3]].frame[num4];
					}
				}
			}
			m_newFrame = false;
		}
		m_timer += Time.deltaTime;
		if (m_timer >= m_frameInterval)
		{
			m_timer -= m_frameInterval;
			m_frame++;
			m_newFrame = true;
		}
	}
}
