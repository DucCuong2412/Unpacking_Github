using UnityEngine;

public class hookScript : MonoBehaviour
{
	public enum hookType
	{
		hook = 0,
		hookFlipped = 1,
		holder = 2,
		holderFlipped = 3
	}

	private zoneScript m_zone;

	private int m_index = -1;

	private Vector3 m_position = Vector3.zero;

	private Collider2D m_collision;

	public int m_size;

	public Vector3 m_groundPosition = Vector3.zero;

	public SpriteRenderer m_sprite;

	public Sprite[] m_states;

	public hookType m_hookType;

	public zoneScript.itemNode.nodeType m_nodeType = zoneScript.itemNode.nodeType.zone2;

	public int index => m_index;

	public Vector3 position => m_position;

	public void Register(zoneScript _zone)
	{
		m_zone = _zone;
		Vector3 vector = base.transform.position;
		vector.x = Mathf.Round(vector.x * 100f) / 100f;
		vector.y = Mathf.Round((vector.y - 0.005f) * 100f) / 100f + 0.005f;
		if (m_hookType == hookType.hook || m_hookType == hookType.hookFlipped)
		{
			m_position = vector - Vector3.up * 0.5f;
		}
		else
		{
			m_position = vector;
		}
		m_index = m_zone.AddGrid(m_position, base.transform, m_hookType, m_nodeType, (m_size < 1) ? 99 : m_size, vector + m_groundPosition);
		m_collision = GetComponent<Collider2D>();
	}

	public void Collision(bool _value)
	{
		m_collision.enabled = _value;
		if (m_sprite != null && m_states.Length != 0)
		{
			m_sprite.sprite = m_states[(!_value) ? 1u : 0u];
		}
	}

	private void OnDrawGizmosSelected()
	{
		Gizmos.color = Color.green;
		Vector3 vector = base.transform.position;
		vector.x = Mathf.Round(vector.x * 100f) / 100f;
		vector.y = Mathf.Round((vector.y - 0.005f) * 100f) / 100f + 0.005f;
		if (m_hookType == hookType.hook)
		{
			Gizmos.DrawLine(vector + new Vector3(-0.02f, 0.01f, 0f), vector + new Vector3(0.02f, -0.01f, 0f));
			Gizmos.DrawLine(vector + new Vector3(0.02f, -0.01f, 0f), vector + new Vector3(0f, -0.02f, 0f));
			Gizmos.DrawLine(vector + new Vector3(0f, -0.02f, 0f), vector + new Vector3(-0.04f, 0f, 0f));
			Gizmos.DrawLine(vector + new Vector3(-0.04f, 0f, 0f), vector + new Vector3(-0.02f, 0.01f, 0f));
		}
		else if (m_hookType == hookType.hookFlipped)
		{
			Gizmos.DrawLine(vector + new Vector3(0.02f, 0.01f, 0f), vector + new Vector3(-0.02f, -0.01f, 0f));
			Gizmos.DrawLine(vector + new Vector3(-0.02f, -0.01f, 0f), vector + new Vector3(0f, -0.02f, 0f));
			Gizmos.DrawLine(vector + new Vector3(0f, -0.02f, 0f), vector + new Vector3(0.04f, 0f, 0f));
			Gizmos.DrawLine(vector + new Vector3(0.04f, 0f, 0f), vector + new Vector3(0.02f, 0.01f, 0f));
		}
		else if (m_hookType == hookType.holder)
		{
			Gizmos.DrawLine(vector + new Vector3(-0.12f, 0.09f, 0f), vector + new Vector3(0.12f, -0.03f, 0f));
			Gizmos.DrawLine(vector + new Vector3(-0.12f, 0.03f, 0f), vector + new Vector3(0.12f, -0.09f, 0f));
		}
		else if (m_hookType == hookType.holderFlipped)
		{
			Gizmos.DrawLine(vector + new Vector3(0.12f, 0.09f, 0f), vector + new Vector3(-0.12f, -0.03f, 0f));
			Gizmos.DrawLine(vector + new Vector3(0.12f, 0.03f, 0f), vector + new Vector3(-0.12f, -0.09f, 0f));
		}
		if (m_size > 0 && m_size < 99)
		{
			Gizmos.color = Color.yellow;
			Gizmos.DrawRay(vector, Vector3.up * m_size * -0.17f);
			Gizmos.color = Color.blue;
			Gizmos.DrawWireSphere(vector + m_groundPosition, 0.01f);
		}
	}
}
