using System;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class creditsSubtitleScript : MonoBehaviour
{
	[Serializable]
	public struct lyrics
	{
		public string id;

		public int frameStart;

		public int frameEnd;
	}

	public TextMeshProUGUI m_text;

	public TextMeshProUGUI[] m_textBack;

	public RectTransform m_gradient;

	public Image[] m_gradientColor;

	private bool m_dark;

	public lyrics[] m_lyricsA;

	public lyrics[] m_lyricsB;

	private int m_currentLyric;

	private int m_currentFrame = -1;

	private float m_currentTime;

	private float m_gradientValue;

	private float m_gradientTarget;

	private float m_gradientAnchorOffset = -58f;

	private bool m_paused;

	private lyrics[] Lyrics
	{
		get
		{
			if (!m_dark)
			{
				return m_lyricsA;
			}
			return m_lyricsB;
		}
	}

	private void Start()
	{
		HideLyric();
		TMP_FontAsset font = gameStateScript.GetFont(stringIdScript.fontStyle.small);
		m_gradient.anchoredPosition = Vector2.up * m_gradientAnchorOffset;
		m_text.font = font;
		for (int i = 0; i < m_textBack.Length; i++)
		{
			m_textBack[i].font = font;
		}
		base.gameObject.SetActive(value: false);
	}

	public void SetResolution(int _height)
	{
		float t = Mathf.InverseLerp(360f, 372f, _height);
		GetComponent<RectTransform>().sizeDelta = Vector2.up * Mathf.Round(Mathf.Lerp(20f, 32f, t));
		m_gradientAnchorOffset = Mathf.Round(Mathf.Lerp(-20f, -58f, t));
		m_gradient.anchoredPosition = Vector2.up * (1f - Mathf.Pow(m_gradientValue, 3f)) * m_gradientAnchorOffset;
	}

	public void Play(bool _dark)
	{
		m_dark = _dark;
		base.gameObject.SetActive(value: true);
		m_currentLyric = 0;
		m_currentFrame = -1;
		m_currentTime = 0.5f;
	}

	public void Pause(bool _value)
	{
		m_paused = _value;
	}

	public void EnableGradient(bool _value)
	{
		m_gradientTarget = (_value ? 1f : 0f);
	}

	public void SetGradientColor(Color _color)
	{
		Color color = _color;
		color.r -= 0.11764706f;
		color.g -= 0.11372549f;
		color.b -= 0.101960786f;
		color.a = 1f;
		Image[] gradientColor = m_gradientColor;
		for (int i = 0; i < gradientColor.Length; i++)
		{
			gradientColor[i].color = color;
		}
	}

	private void Update()
	{
		if (m_paused)
		{
			return;
		}
		m_currentTime += Time.deltaTime;
		int num = Mathf.RoundToInt(m_currentTime * 60f);
		if (num > m_currentFrame && m_currentLyric < Lyrics.Length)
		{
			if (Lyrics[m_currentLyric].frameStart > m_currentFrame)
			{
				if (Lyrics[m_currentLyric].frameStart <= num)
				{
					ShowLyric();
				}
			}
			else if (m_currentLyric + 1 < Lyrics.Length && Lyrics[m_currentLyric + 1].frameStart <= num)
			{
				m_currentLyric++;
				ShowLyric();
			}
			else if (Lyrics[m_currentLyric].frameEnd > 0 && Lyrics[m_currentLyric].frameEnd <= num)
			{
				m_currentLyric++;
				if (m_currentLyric + 1 < Lyrics.Length && Lyrics[m_currentLyric].frameStart <= num)
				{
					ShowLyric();
				}
				else
				{
					HideLyric();
					if (m_currentLyric == Lyrics.Length)
					{
						m_gradientTarget = 0f;
					}
				}
			}
			m_currentFrame = num;
		}
		if (m_gradientValue != m_gradientTarget)
		{
			m_gradientValue = Mathf.MoveTowards(m_gradientValue, m_gradientTarget, Time.deltaTime);
			if (m_gradientTarget > 0.5f)
			{
				m_gradient.anchoredPosition = Vector2.up * (1f - Mathf.Pow(m_gradientValue, 3f)) * m_gradientAnchorOffset;
			}
			else
			{
				m_gradient.GetComponent<CanvasGroup>().alpha = Mathf.Pow(m_gradientValue, 2f);
			}
		}
	}

	private void HideLyric()
	{
		m_text.gameObject.SetActive(value: false);
		for (int i = 0; i < m_textBack.Length; i++)
		{
			m_textBack[i].gameObject.SetActive(value: false);
		}
	}

	private void ShowLyric()
	{
		string text = gameStateScript.GetString(Lyrics[m_currentLyric].id);
		m_text.text = text;
		m_text.gameObject.SetActive(value: true);
		for (int i = 0; i < m_textBack.Length; i++)
		{
			m_textBack[i].text = text;
			m_textBack[i].gameObject.SetActive(value: true);
		}
	}
}
