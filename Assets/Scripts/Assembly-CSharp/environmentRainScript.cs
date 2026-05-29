using UnityEngine;

public class environmentRainScript : MonoBehaviour
{
	public Bounds m_bounds;

	public Sprite m_sprite;

	public bool m_flipped;

	private Transform[] m_drops;

	private int[] m_dropSpeed;

	private float m_percent = -1f;

	private int m_activeCurrent;

	private int m_activeTarget;

	private float m_timer;

	private void Awake()
	{
		int num = (int)(Mathf.Abs(m_bounds.size.x * m_bounds.size.y) * 20f);
		m_drops = new Transform[num];
		m_dropSpeed = new int[num];
		for (int i = 0; i < m_drops.Length; i++)
		{
			GameObject gameObject = new GameObject("drop");
			SpriteRenderer spriteRenderer = gameObject.AddComponent<SpriteRenderer>();
			spriteRenderer.sprite = m_sprite;
			spriteRenderer.maskInteraction = SpriteMaskInteraction.VisibleInsideMask;
			spriteRenderer.flipX = m_flipped;
			spriteRenderer.color = new Color(1f, 1f, 1f, 0.5f);
			m_drops[i] = gameObject.transform;
			m_drops[i].parent = base.transform;
			m_dropSpeed[i] = Random.Range(0, 2);
		}
	}

	private void OnEnable()
	{
		GetTarget();
		m_activeCurrent = m_activeTarget;
		for (int i = 0; i < m_drops.Length; i++)
		{
			if (i < m_activeCurrent)
			{
				Vector2 vector = new Vector2(Random.Range(m_bounds.min.x, m_bounds.max.x), Random.Range(m_bounds.min.y, m_bounds.max.y));
				vector.x = Mathf.Round(vector.x * 100f) / 100f;
				vector.y = Mathf.Round((vector.y - 0.005f) * 100f) / 100f + 0.005f;
				m_drops[i].localPosition = vector;
				m_drops[i].gameObject.SetActive(value: true);
			}
			else
			{
				m_drops[i].gameObject.SetActive(value: false);
			}
		}
	}

	private void GetTarget()
	{
		float activity = timeOfDayScript.activity;
		if (!Mathf.Approximately(m_percent, activity))
		{
			m_percent = activity;
			m_activeTarget = Mathf.FloorToInt((float)m_drops.Length * m_percent);
		}
	}

	private void Update()
	{
		m_timer -= Time.deltaTime;
		if (!(m_timer <= 0f))
		{
			return;
		}
		GetTarget();
		m_timer += 0.0333f;
		if (m_activeTarget == 0 && m_activeCurrent == 0)
		{
			return;
		}
		for (int i = 0; i < m_drops.Length; i++)
		{
			bool activeSelf = m_drops[i].gameObject.activeSelf;
			if (!activeSelf && m_activeTarget <= m_activeCurrent)
			{
				continue;
			}
			Vector2 vector = m_drops[i].localPosition;
			if (activeSelf)
			{
				vector.x += (m_flipped ? (-0.01f) : 0.01f);
				vector.y -= 0.1f;
				if (m_dropSpeed[i] > 0)
				{
					vector.x += (m_flipped ? (-0.01f) : 0.01f);
					vector.y -= 0.1f;
				}
			}
			if (vector.y < m_bounds.min.y || !activeSelf)
			{
				if (m_activeCurrent > m_activeTarget)
				{
					m_activeCurrent--;
					m_drops[i].gameObject.SetActive(value: false);
					continue;
				}
				m_dropSpeed[i] = Random.Range(0, 2);
				vector.x = Random.Range(m_bounds.min.x, m_bounds.max.x);
				vector.x = Mathf.Round(vector.x * 100f) / 100f;
				vector.y = m_bounds.max.y;
				if (m_activeCurrent != m_activeTarget)
				{
					vector.y += Random.Range(m_bounds.min.y, m_bounds.max.y);
				}
				if (!activeSelf)
				{
					m_drops[i].gameObject.SetActive(value: true);
					m_activeCurrent++;
				}
				vector.y = Mathf.Round((vector.y - 0.005f) * 100f) / 100f + 0.005f;
			}
			m_drops[i].localPosition = vector;
		}
	}

	private void OnDrawGizmos()
	{
		Gizmos.color = Color.cyan;
		Gizmos.DrawWireCube(m_bounds.center, m_bounds.size);
	}
}
