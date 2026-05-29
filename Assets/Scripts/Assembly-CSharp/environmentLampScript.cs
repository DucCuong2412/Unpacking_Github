using UnityEngine;

[RequireComponent(typeof(PolygonCollider2D))]
public class environmentLampScript : MonoBehaviour
{
	[Header("WWise Events")]
	public string m_audioOn;

	public string m_audioOff;

	[Space(20f)]
	private SpriteRenderer m_renderer;

	private Sprite m_base;

	public Sprite m_lit;

	public Transform m_lampPull;

	private Vector3 m_lampPullPosition;

	private SpriteRenderer m_lampPullRenderer;

	private Sprite m_lampPullBase;

	public Sprite m_lampPullLit;

	public AnimationCurve m_lampPullCurve;

	private float m_lampPullLerp = 1f;

	public SpriteRenderer m_glow;

	public AnimationCurve m_glowSize;

	public Gradient m_glowColor;

	public float m_glowOnRate = 1f;

	public float m_glowOffRate = 1f;

	private bool m_active;

	private float m_lerp;

	public GameObject m_audioPosition;

	private gameScript m_game;

	private int m_usableIndex = -1;

	public bool isOn => m_active;

	public void Register(zoneScript _zone, int _usableIndex)
	{
		m_usableIndex = _usableIndex;
		if (m_audioPosition == null)
		{
			m_audioPosition = base.gameObject;
		}
		Vector3 position = m_audioPosition.transform.position;
		position.z = 0f;
		m_audioPosition.transform.position = position;
		AkAuxSendArray akAuxSendArray = new AkAuxSendArray();
		akAuxSendArray.Add(_zone.reverbID, 1f);
		AkSoundEngine.SetGameObjectAuxSendValues(m_audioPosition, akAuxSendArray, 1u);
		m_game = Object.FindObjectOfType<gameScript>();
		m_renderer = base.transform.parent.GetComponent<SpriteRenderer>();
		m_base = m_renderer.sprite;
		m_lampPullPosition = m_lampPull.localPosition;
		m_lampPullRenderer = m_lampPull.GetComponent<SpriteRenderer>();
		m_lampPullBase = m_lampPullRenderer.sprite;
	}

	public void Use()
	{
		SetLamp((!m_active) ? 1 : 0);
		m_game.HistorySave(m_usableIndex);
		m_lampPullLerp = 0f;
	}

	private void SetLamp(int _value)
	{
		if (_value == 0)
		{
			m_active = false;
			m_renderer.sprite = m_base;
			m_lampPullRenderer.sprite = m_lampPullBase;
			if (!string.IsNullOrEmpty(m_audioOff))
			{
				AkSoundEngine.PostEvent(m_audioOff, m_audioPosition);
			}
		}
		else
		{
			m_active = true;
			m_renderer.sprite = m_lit;
			m_lampPullRenderer.sprite = m_lampPullLit;
			if (_value == 1)
			{
				if (!string.IsNullOrEmpty(m_audioOn))
				{
					AkSoundEngine.PostEvent(m_audioOn, m_audioPosition);
				}
			}
			else
			{
				m_lerp = 1f;
			}
		}
		SetColor();
	}

	private void Update()
	{
		if (m_active && m_lerp < 1f)
		{
			m_lerp = Mathf.MoveTowards(m_lerp, 1f, Time.deltaTime * m_glowOnRate);
			SetColor();
		}
		else if (!m_active && m_lerp > 0f)
		{
			m_lerp = Mathf.MoveTowards(m_lerp, 0f, Time.deltaTime * m_glowOffRate);
			SetColor();
		}
		if (m_lampPullLerp < 1f)
		{
			m_lampPullLerp = Mathf.MoveTowards(m_lampPullLerp, 1f, Time.deltaTime * 2f);
			float num = Mathf.Round(m_lampPullCurve.Evaluate(m_lampPullLerp) * 6f);
			m_lampPull.localPosition = m_lampPullPosition + Vector3.up * num * 0.01f;
		}
	}

	private void SetColor()
	{
		m_glow.enabled = m_lerp > 0f;
		m_glow.color = m_glowColor.Evaluate(m_lerp);
		m_glow.transform.localScale = Vector3.one * m_glowSize.Evaluate(m_lerp);
	}

	public void SetSaveData(bool _value)
	{
		if (_value)
		{
			SetLamp(2);
		}
	}

	public bool PlaybackUse(int _index, bool _animate)
	{
		if (m_usableIndex != _index)
		{
			return false;
		}
		if (_animate)
		{
			SetLamp((!m_active) ? 1 : 0);
		}
		else
		{
			m_active = !m_active;
			m_lerp = 1f;
			SetColor();
		}
		return true;
	}
}
