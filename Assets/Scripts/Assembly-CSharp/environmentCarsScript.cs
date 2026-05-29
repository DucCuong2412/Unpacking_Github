using UnityEngine;

public class environmentCarsScript : MonoBehaviour
{
	public zoneScript.direction m_direction;

	public int m_length;

	public int m_maxCars = 10;

	public Sprite[] m_sprites;

	private Transform[] m_cars;

	private int[] m_carsDistance;

	public int m_layer;

	private int m_activeCurrent;

	private int m_activeTarget;

	private const int c_minDistance = 6;

	public void Init(Material[] _materials)
	{
		m_cars = new Transform[m_maxCars];
		m_carsDistance = new int[m_maxCars];
		for (int i = 0; i < m_cars.Length; i++)
		{
			GameObject gameObject = new GameObject("car");
			SpriteRenderer spriteRenderer = gameObject.AddComponent<SpriteRenderer>();
			spriteRenderer.sprite = m_sprites[Random.Range(0, m_sprites.Length)];
			spriteRenderer.maskInteraction = SpriteMaskInteraction.VisibleInsideMask;
			spriteRenderer.sharedMaterial = _materials[(m_direction == zoneScript.direction.xAxis || m_direction == zoneScript.direction.yAxis) ? 1 : 0];
			spriteRenderer.sortingOrder = m_layer;
			float num = Mathf.PerlinNoise(i, 0.5f) * 0.9f + 0.1f;
			spriteRenderer.color = new Color(num, num, num);
			spriteRenderer.flipX = m_direction == zoneScript.direction.xAxis || m_direction == zoneScript.direction.xAxisNeg;
			m_cars[i] = gameObject.transform;
			m_cars[i].parent = base.transform;
		}
	}

	public void Reload()
	{
		m_activeCurrent = m_activeTarget;
		int num = 0;
		int max = ((m_activeCurrent > 0) ? (m_length / m_activeCurrent * 2) : 0);
		for (int i = 0; i < m_cars.Length; i++)
		{
			if (i < m_activeCurrent)
			{
				num += Mathf.Max(Random.Range(0, max), 6);
				m_carsDistance[i] = num;
				m_cars[i].localPosition = StepVector() * m_carsDistance[i];
				m_cars[i].gameObject.SetActive(value: true);
			}
			else
			{
				m_carsDistance[i] = m_length;
				m_cars[i].gameObject.SetActive(value: false);
			}
		}
	}

	public void SetTarget(float _percent)
	{
		m_activeTarget = Mathf.CeilToInt((float)m_cars.Length * _percent);
	}

	public void CarUpdate()
	{
		if (m_activeTarget == 0 && m_activeCurrent == 0)
		{
			return;
		}
		for (int i = 0; i < m_cars.Length; i++)
		{
			bool activeSelf = m_cars[i].gameObject.activeSelf;
			if (!activeSelf && m_activeTarget <= m_activeCurrent)
			{
				continue;
			}
			m_carsDistance[i]++;
			Vector2 vector = StepVector() * m_carsDistance[i];
			if (m_carsDistance[i] >= m_length || !activeSelf)
			{
				if (m_activeCurrent > m_activeTarget)
				{
					m_activeCurrent--;
					m_cars[i].gameObject.SetActive(value: false);
					continue;
				}
				if (!activeSelf)
				{
					m_cars[i].gameObject.SetActive(value: true);
					m_activeCurrent++;
				}
				m_carsDistance[i] = GetNewCarDistance();
			}
			m_cars[i].localPosition = (vector = StepVector() * m_carsDistance[i]);
		}
	}

	private int GetNewCarDistance()
	{
		int num = m_length;
		for (int i = 0; i < m_carsDistance.Length; i++)
		{
			if (m_carsDistance[i] < num)
			{
				num = m_carsDistance[i];
			}
		}
		num -= Mathf.Max(Random.Range(0, m_length / m_activeCurrent * 2), 6);
		return Mathf.Min(num, 0);
	}

	private Vector2 StepVector()
	{
		if (m_direction == zoneScript.direction.xAxis)
		{
			return new Vector2(0.02f, 0.01f);
		}
		if (m_direction == zoneScript.direction.xAxisNeg)
		{
			return new Vector2(-0.02f, -0.01f);
		}
		if (m_direction == zoneScript.direction.yAxis)
		{
			return new Vector2(-0.02f, 0.01f);
		}
		if (m_direction == zoneScript.direction.yAxisNeg)
		{
			return new Vector2(0.02f, -0.01f);
		}
		return Vector2.zero;
	}

	private void OnDrawGizmos()
	{
		Gizmos.color = ((m_direction == zoneScript.direction.xAxis || m_direction == zoneScript.direction.yAxis) ? Color.red : Color.yellow);
		Gizmos.DrawRay(base.transform.position, StepVector() * m_length);
	}
}
