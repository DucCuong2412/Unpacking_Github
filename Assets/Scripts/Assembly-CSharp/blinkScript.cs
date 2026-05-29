using UnityEngine;

public class blinkScript : attachmentBaseScript
{
	public enum blinkStyle
	{
		microwave = 0,
		clockRadio = 1
	}

	public bool m_startFlipped;

	public bool m_startSet;

	public blinkStyle m_style;

	public string m_audioBeep = "Play_Microwave_Beeps";

	public string m_audioBeepComplete = "Play_Microwave_Beeps_Twice";

	private float m_time = 1f;

	private int m_mode;

	private int m_progress;

	public bool m_invert;

	public SpriteRenderer[] m_renderers;

	public SpriteRenderer m_dot;

	public Sprite[] m_numbers;

	public Sprite[] m_numbersFlipped;

	private bool m_display;

	private bool m_blink;

	private bool m_flipped;

	private float m_timer;

	public Vector3[] m_positions;

	public override bool canPlacedInteract
	{
		get
		{
			if (m_display)
			{
				return m_mode < 2;
			}
			return false;
		}
	}

	public override int attachmentValues => 1;

	public override void StartValid()
	{
		m_startSet = true;
	}

	private void Start()
	{
		if (m_progress <= 0)
		{
			SpriteRenderer[] renderers = m_renderers;
			for (int i = 0; i < renderers.Length; i++)
			{
				renderers[i].enabled = false;
			}
			if (m_dot != null)
			{
				m_dot.enabled = false;
			}
			if (m_startFlipped)
			{
				ChangeState(itemScript.itemState.flipped);
			}
			if (m_startSet)
			{
				ChangeValidity(true);
				m_progress = 10;
				Interact(_playSound: false);
				m_mode = 2;
			}
		}
	}

	private void Update()
	{
		if (!m_display)
		{
			return;
		}
		m_timer += Time.deltaTime;
		if (!(m_timer > m_time))
		{
			return;
		}
		m_timer -= m_time;
		if (m_mode == 1)
		{
			m_blink = true;
		}
		else
		{
			m_blink = !m_blink;
		}
		if (m_mode == 2)
		{
			m_renderers[4].enabled = m_blink;
			int num = timeOfDayScript.hour;
			if (num > 12)
			{
				num -= 12;
			}
			else if (num == 0)
			{
				num = 12;
			}
			int minute = timeOfDayScript.minute;
			SetNumber(new int[4]
			{
				num / 10,
				num % 10,
				minute / 10,
				minute % 10
			});
		}
		else
		{
			SpriteRenderer[] renderers = m_renderers;
			for (int i = 0; i < renderers.Length; i++)
			{
				renderers[i].enabled = m_blink;
			}
		}
	}

	public override void ChangeState(itemScript.itemState _state)
	{
		bool flag = (m_invert && _state == itemScript.itemState.normal) || (!m_invert && _state != itemScript.itemState.normal);
		for (int i = 0; i < 4; i++)
		{
			Vector3 localPosition = m_renderers[i].transform.localPosition;
			if (!flag)
			{
				switch (i)
				{
				case 0:
					localPosition.y = -0.03f;
					break;
				case 1:
					localPosition.y = -0.01f;
					break;
				case 2:
					localPosition.y = 0.02f;
					break;
				case 3:
					localPosition.y = 0.04f;
					break;
				}
			}
			else
			{
				switch (i)
				{
				case 0:
					localPosition.y = 0.03f;
					break;
				case 1:
					localPosition.y = 0.01f;
					break;
				case 2:
					localPosition.y = -0.02f;
					break;
				case 3:
					localPosition.y = -0.04f;
					break;
				}
			}
			m_renderers[i].transform.localPosition = localPosition;
		}
		if (m_dot != null)
		{
			Vector3 localPosition2 = m_dot.transform.localPosition;
			if (!flag)
			{
				localPosition2.y = -0.04f;
			}
			else
			{
				localPosition2.y = 0.04f;
			}
			m_dot.transform.localPosition = localPosition2;
		}
		if (!flag)
		{
			m_flipped = false;
			m_renderers[4].transform.localPosition = Vector3.zero;
			base.transform.localPosition = m_positions[0];
		}
		else
		{
			m_flipped = true;
			m_renderers[4].transform.localPosition = Vector3.up * -0.01f;
			base.transform.localPosition = m_positions[1];
		}
	}

	private void SetNumber(int[] _numbers)
	{
		for (int i = 0; i < _numbers.Length; i++)
		{
			m_renderers[i].sprite = (m_flipped ? m_numbersFlipped[_numbers[i]] : m_numbers[_numbers[i]]);
		}
	}

	public override void ChangeValidity(bool _valid)
	{
		m_display = _valid;
		m_blink = _valid;
		m_mode = 0;
		if (!_valid && m_dot != null)
		{
			m_dot.enabled = false;
		}
		m_progress = 0;
		SetNumber(new int[4] { 1, 2, 0, 0 });
		SpriteRenderer[] renderers = m_renderers;
		for (int i = 0; i < renderers.Length; i++)
		{
			renderers[i].enabled = _valid;
		}
		if (_valid)
		{
			m_timer = 0f;
		}
	}

	public override bool PlacedInteract(bool _instant = false)
	{
		if (m_display)
		{
			return Interact(_playSound: true);
		}
		return false;
	}

	public override int PlacedInteractFull()
	{
		if (m_display)
		{
			int num = ((m_style == blinkStyle.microwave) ? 5 : 4);
			int result = Mathf.Max(0, num - m_progress);
			m_progress = num - 1;
			Interact(_playSound: true);
			return result;
		}
		return 0;
	}

	private bool Interact(bool _playSound)
	{
		if (m_mode < 2)
		{
			SpriteRenderer[] renderers = m_renderers;
			for (int i = 0; i < renderers.Length; i++)
			{
				renderers[i].enabled = true;
			}
			if (m_mode == 0)
			{
				m_mode = 1;
				m_timer = m_time;
			}
			m_progress++;
			int num = timeOfDayScript.hour;
			bool flag = false;
			if (num > 12)
			{
				num -= 12;
				flag = true;
			}
			else if (num == 0)
			{
				num = 12;
			}
			int minute = timeOfDayScript.minute;
			if (m_style == blinkStyle.microwave)
			{
				if (m_progress == 1)
				{
					SetNumber(new int[4]
					{
						0,
						0,
						0,
						num / 10
					});
				}
				else if (m_progress == 2)
				{
					SetNumber(new int[4]
					{
						0,
						0,
						num / 10,
						num % 10
					});
				}
				else if (m_progress == 3)
				{
					SetNumber(new int[4]
					{
						0,
						num / 10,
						num % 10,
						minute / 10
					});
				}
				else
				{
					SetNumber(new int[4]
					{
						num / 10,
						num % 10,
						minute / 10,
						minute % 10
					});
					if (m_progress == 5)
					{
						m_mode = 2;
					}
				}
			}
			else
			{
				if (m_progress == 1)
				{
					int num2 = num / 2;
					SetNumber(new int[4]
					{
						num2 / 10,
						num2 % 10,
						0,
						0
					});
				}
				else if (m_progress == 2)
				{
					SetNumber(new int[4]
					{
						num / 10,
						num % 10,
						0,
						0
					});
				}
				else if (m_progress == 3)
				{
					int num3 = minute / 2;
					SetNumber(new int[4]
					{
						num / 10,
						num % 10,
						num3 / 10,
						num3 % 10
					});
				}
				else
				{
					SetNumber(new int[4]
					{
						num / 10,
						num % 10,
						minute / 10,
						minute % 10
					});
					m_mode = 2;
				}
				if (m_dot != null)
				{
					m_dot.enabled = flag;
				}
			}
			if (_playSound)
			{
				if (m_mode == 2)
				{
					AkSoundEngine.PostEvent(m_audioBeepComplete, base.transform.parent.GetComponent<itemScript>().audioGO);
					statsScript.SpecialEvent(statsScript.specialEvents.alarmSet);
					if (m_style == blinkStyle.microwave)
					{
						statsScript.AwardSticker(statsScript.stickers.sticker_microwave);
					}
				}
				else
				{
					AkSoundEngine.PostEvent(m_audioBeep, base.transform.parent.GetComponent<itemScript>().audioGO);
				}
			}
			return true;
		}
		return false;
	}

	public override int[] GetAttachmentValues()
	{
		return new int[1] { m_progress };
	}

	public override void SetAttachmentValues(int[] _values)
	{
		if (_values[0] > 0 && m_display)
		{
			m_progress = _values[0] - 1;
			Interact(_playSound: false);
		}
	}
}
