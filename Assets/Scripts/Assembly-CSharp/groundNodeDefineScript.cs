using UnityEngine;

public class groundNodeDefineScript : MonoBehaviour
{
	public enum type
	{
		flat = 0,
		wallLeft = 1,
		wallRight = 2
	}

	private zoneScript m_zone;

	public int m_xWidth = 1;

	public int m_yWidth = 1;

	public type m_type;

	private int m_index;

	public int index => m_index;

	public void Register(zoneScript _zone)
	{
		m_zone = _zone;
		m_index = m_zone.FindClosestGrid(base.transform.position - m_zone.transform.position, m_type == type.flat);
		if (m_index == -1)
		{
			Debug.LogError(base.gameObject.name.ToString() + " could not find an index");
		}
	}

	private void OnDrawGizmosSelected()
	{
		Vector3 vector;
		if (m_zone != null)
		{
			Gizmos.color = Color.red;
			vector = m_zone.GetGrid(m_index);
		}
		else
		{
			Gizmos.color = Color.blue;
			vector = base.transform.position;
		}
		if (m_type == type.flat)
		{
			Vector3 vector2 = new Vector3(0.14f, 0.07f);
			Vector3 vector3 = new Vector3(-0.14f, 0.07f);
			Vector3 vector4 = vector + -vector2 * 0.5f + -vector3 * 0.5f;
			Vector3 vector5 = vector + vector2 * ((float)m_xWidth - 0.5f) + -vector3 * 0.5f;
			Vector3 vector6 = vector + vector2 * ((float)m_xWidth - 0.5f) + vector3 * ((float)m_yWidth - 0.5f);
			Vector3 vector7 = vector + -vector2 * 0.5f + vector3 * ((float)m_yWidth - 0.5f);
			Gizmos.DrawLine(vector4, vector5);
			Gizmos.DrawLine(vector5, vector6);
			Gizmos.DrawLine(vector6, vector7);
			Gizmos.DrawLine(vector7, vector4);
		}
		else if (m_type == type.wallLeft)
		{
			Vector3 vector8 = new Vector3(0.14f, -0.07f);
			Vector3 vector9 = vector + new Vector3(0.07f, -0.11f);
			Vector3 vector10 = vector9 - vector8 * m_xWidth;
			Vector3 vector11 = vector10 + Vector3.up * 0.17f * m_yWidth;
			Vector3 vector12 = vector11 + vector8 * m_xWidth;
			Gizmos.DrawLine(vector9, vector10);
			Gizmos.DrawLine(vector10, vector11);
			Gizmos.DrawLine(vector11, vector12);
			Gizmos.DrawLine(vector12, vector9);
		}
	}
}
