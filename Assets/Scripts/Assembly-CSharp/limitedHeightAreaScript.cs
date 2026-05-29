using UnityEngine;

[RequireComponent(typeof(PolygonCollider2D))]
public class limitedHeightAreaScript : MonoBehaviour
{
	private int[] m_nodes;

	public void Register(zoneScript _zone)
	{
		m_nodes = _zone.GetAllGridsWithinPolygon(GetComponent<PolygonCollider2D>());
	}

	public bool Check(int _index)
	{
		for (int i = 0; i < m_nodes.Length; i++)
		{
			if (m_nodes[i].Equals(_index))
			{
				return true;
			}
		}
		return false;
	}
}
