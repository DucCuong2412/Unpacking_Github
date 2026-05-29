using System;
using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

public class timeOfDayScript : MonoBehaviour
{
	[Serializable]
	public class timeOfDayPoint
	{
		public PostProcessVolume m_layer;

		public float m_time;
	}

	[Serializable]
	public class tintTrack
	{
		public SpriteRenderer[] m_sprites;

		public Gradient m_tint;

		public bool m_perlin;

		public float m_perlinScale;

		public float m_perlinSpeed = 1f;

		public float m_perlinSpread;
	}

	private static timeOfDayScript s_instance;

	public bool m_showDebug;

	public timeOfDayPoint[] m_points;

	public tintTrack[] m_tints;

	private int m_todItemFull;

	private int m_todItemCurrent;

	private float m_todCurrent;

	public float m_todStartTime;

	public float m_todEndTime = 4f;

	public AnimationCurve m_activity;

	private float m_intervalMin;

	private float m_intervalMax = 1f;

	private float m_realTime;

	private float m_syncTimer;

	private int m_currentHour;

	private int m_currentMinute;

	private uint m_audioId;

	private GameObject m_audioGO;

	public static int hour
	{
		get
		{
			if (!(s_instance == null))
			{
				return s_instance.GetHour();
			}
			return DateTime.Now.Hour;
		}
	}

	public static int minute
	{
		get
		{
			if (!(s_instance == null))
			{
				return s_instance.GetMinute();
			}
			return DateTime.Now.Minute;
		}
	}

	public static float activity
	{
		get
		{
			if (!(s_instance == null))
			{
				return s_instance.GetActivity();
			}
			return 0f;
		}
	}

	protected int GetHour()
	{
		return m_currentHour;
	}

	protected int GetMinute()
	{
		return m_currentMinute;
	}

	protected float GetActivity()
	{
		return m_activity.Evaluate(m_todCurrent);
	}

	public void SetItemFull(int _itemCount)
	{
		m_todItemFull = _itemCount;
	}

	public void SetItemCurrent(int _itemCurrent)
	{
		m_todItemCurrent = _itemCurrent;
	}

	public void Reset()
	{
		m_todItemCurrent = 0;
		m_todCurrent = 0f;
	}

	public void IncreaseItem()
	{
		m_todItemCurrent++;
	}

	public void MaxItem()
	{
		m_todItemCurrent = m_todItemFull;
	}

	private void Awake()
	{
		s_instance = this;
		float num = m_todEndTime - m_todStartTime;
		m_intervalMin = 0.00013888889f / num;
		m_intervalMax = 0.27777776f / num;
		m_audioId = AkSoundEngine.GetIDFromString("time_of_day");
		m_audioGO = UnityEngine.Object.FindObjectOfType<gameScript>().gameObject;
	}

	private void Update()
	{
		float num = Mathf.InverseLerp(0f, m_todItemFull, m_todItemCurrent);
		m_todCurrent += Mathf.Clamp((num - m_todCurrent) * 0.5f, m_intervalMin, m_intervalMax) * Time.deltaTime;
		float num2 = Mathf.Lerp(m_todStartTime, m_todEndTime, m_todCurrent);
		AkSoundEngine.SetRTPCValue(m_audioId, num2, m_audioGO);
		m_realTime += Time.deltaTime / 60f / 60f;
		for (int i = 1; i < m_points.Length; i++)
		{
			if (num2 >= m_points[i].m_time)
			{
				m_points[i].m_layer.weight = 1f;
			}
			else if (num2 < m_points[i - 1].m_time)
			{
				m_points[i].m_layer.weight = 0f;
			}
			else
			{
				m_points[i].m_layer.weight = Mathf.InverseLerp(m_points[i - 1].m_time, m_points[i].m_time, num2);
			}
		}
		for (int j = 0; j < m_tints.Length; j++)
		{
			Color color = m_tints[j].m_tint.Evaluate(m_todCurrent);
			for (int k = 0; k < m_tints[j].m_sprites.Length; k++)
			{
				Color color2 = color;
				if (m_tints[j].m_perlin)
				{
					float num3 = Mathf.PerlinNoise(Time.time * m_tints[j].m_perlinSpeed, m_tints[j].m_perlinSpread * (float)k);
					num3 *= num3;
					num3 = 1f - num3;
					color2.a -= num3 * m_tints[j].m_perlinScale;
				}
				m_tints[j].m_sprites[k].color = color2;
			}
		}
		m_syncTimer -= Time.deltaTime;
		if (m_syncTimer < 0f)
		{
			m_syncTimer = 10f;
			TimeSpan timeSpan = TimeSpan.FromHours(Mathf.Lerp(m_todStartTime, m_todEndTime, m_todCurrent));
			m_currentHour = timeSpan.Hours;
			m_currentMinute = timeSpan.Minutes;
		}
	}

	public void HideSunbeams()
	{
		for (int i = 0; i < m_tints.Length; i++)
		{
			if (m_tints[i].m_perlin)
			{
				for (int j = 0; j < m_tints[i].m_sprites.Length; j++)
				{
					m_tints[i].m_sprites[j].gameObject.SetActive(value: false);
				}
			}
		}
	}

	public int GetSaveData()
	{
		return Mathf.RoundToInt(m_todCurrent * 1000f);
	}

	public void SetSaveData(int _value)
	{
		m_todCurrent = (float)_value / 1000f;
	}
}
