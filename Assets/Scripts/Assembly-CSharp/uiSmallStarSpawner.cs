using System;
using UnityEngine;
using UnityEngine.UI;

public class uiSmallStarSpawner : MonoBehaviour
{
	private class SmallStar
	{
		private bool m_active;

		private Image m_star;

		private GameObject m_starGO;

		private RectTransform m_starTransform;

		private Vector2 m_position;

		private Vector2 m_moveVector;

		private float m_lifetime;

		private float m_age;

		public bool active => m_active;

		public SmallStar(GameObject _prefab, Transform _parent)
		{
			m_active = false;
			m_starGO = UnityEngine.Object.Instantiate(_prefab, _parent);
			m_starTransform = m_starGO.GetComponent<RectTransform>();
			m_star = m_starGO.GetComponent<Image>();
			m_starGO.SetActive(value: false);
			m_position = Vector2.zero;
			m_moveVector = Vector2.zero;
			m_lifetime = 1f;
			m_age = 0f;
		}

		public void Spawn(float _angle, Color _color)
		{
			m_moveVector = new Vector2(Mathf.Sin(_angle), Mathf.Cos(_angle)) * 80f;
			m_position = m_moveVector * 0.3f;
			m_active = true;
			m_starGO.SetActive(value: true);
			m_age = 0f;
			m_lifetime = UnityEngine.Random.Range(0.5f, 1.5f);
			m_star.color = _color;
			SetPosition();
		}

		public void Spawn(float _angle, float _force, Vector2 _position, Color _color)
		{
			m_moveVector = new Vector2(Mathf.Sin(_angle), Mathf.Cos(_angle)) * _force;
			m_position = _position;
			m_active = true;
			m_starGO.SetActive(value: true);
			m_age = 0f;
			m_lifetime = UnityEngine.Random.Range(0.5f, 1.5f);
			m_star.color = _color;
			SetPosition();
		}

		private void SetPosition()
		{
			m_starTransform.localPosition = new Vector2(Mathf.Round(m_position.x / 2f) * 2f, Mathf.Round(m_position.y / 2f) * 2f);
		}

		public float Update(float _timeDelta, float _timeOffset)
		{
			m_age += _timeDelta;
			float result = m_age / m_lifetime;
			if (m_age < m_lifetime)
			{
				m_moveVector *= 1f - _timeDelta * 1f;
				m_moveVector.x += (Mathf.PerlinNoise(m_position.x * 0.05f + _timeOffset, m_position.y * 0.05f) - 0.5f) * _timeDelta * 250f;
				m_moveVector.y += (Mathf.PerlinNoise(m_position.x * 0.05f + _timeOffset, m_position.y * 0.05f + 100f) - 0.5f) * _timeDelta * 250f;
				m_position += m_moveVector * _timeDelta;
				SetPosition();
				return result;
			}
			m_active = false;
			m_starGO.SetActive(value: false);
			return result;
		}

		public void SetArt(Sprite _sprite)
		{
			m_star.sprite = _sprite;
		}
	}

	private bool m_spawn;

	private bool m_darkstar;

	public GameObject m_smallStarPrefab;

	private SmallStar[] m_smallStars;

	private float m_starSpawnTimer;

	private float m_starAngle;

	public Sprite[] m_smallStarArt;

	public Sprite[] m_smallDarkStarArt;

	public Color[] m_colors;

	public bool spawn
	{
		set
		{
			m_spawn = value;
			m_starAngle = 0.1f;
			m_starSpawnTimer = 0f;
		}
	}

	public bool darkstar
	{
		set
		{
			m_darkstar = value;
		}
	}

	private void Start()
	{
		m_smallStars = new SmallStar[26];
		for (int i = 0; i < m_smallStars.Length; i++)
		{
			m_smallStars[i] = new SmallStar(m_smallStarPrefab, base.transform);
		}
	}

	public void Burst(Vector2 _position)
	{
		int num = 24;
		float num2 = (float)Math.PI * 2f / (float)num;
		for (int i = 0; i < num; i++)
		{
			m_smallStars[i].Spawn(num2 * (float)i, 160f, _position, m_colors[2]);
			m_smallStars[i].SetArt(m_smallStarArt[0]);
		}
	}

	private void Update()
	{
		bool flag = false;
		if (m_spawn)
		{
			m_starSpawnTimer += Time.deltaTime;
			if (m_starSpawnTimer > 0.05f)
			{
				m_starSpawnTimer -= 0.05f;
				flag = true;
			}
		}
		for (int i = 0; i < m_smallStars.Length; i++)
		{
			if (m_smallStars[i].active)
			{
				float num = m_smallStars[i].Update(Time.deltaTime, Time.time);
				if (num < 1f)
				{
					num *= num;
					m_smallStars[i].SetArt(m_darkstar ? m_smallDarkStarArt[Mathf.FloorToInt(num * (float)m_smallDarkStarArt.Length)] : m_smallStarArt[Mathf.FloorToInt(num * (float)m_smallStarArt.Length)]);
				}
			}
			else if (flag)
			{
				m_smallStars[i].Spawn(m_starAngle, m_colors[m_darkstar ? 1 : 0]);
				m_smallStars[i].SetArt(m_darkstar ? m_smallDarkStarArt[0] : m_smallStarArt[0]);
				m_starAngle += 0.5f;
				flag = false;
			}
		}
		if (flag)
		{
			Debug.LogWarning("uiCompleteScript : star couldn't be spawned!");
		}
	}
}
