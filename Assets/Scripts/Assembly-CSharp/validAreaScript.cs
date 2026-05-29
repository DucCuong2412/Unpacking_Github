using UnityEngine;

public class validAreaScript : MonoBehaviour
{
	public enum areaType
	{
		polygon = 0,
		floodfill = 1,
		extraGrid = 2
	}

	public areaType m_areaType;

	public bool m_useState;

	public itemScript.itemState m_state;

	public bool m_forceValid = true;

	public string[] m_items;

	public bool m_includeWalls;

	private int[] m_nodes;

	public void Register(zoneScript _zone)
	{
		if (m_areaType == areaType.polygon)
		{
			m_nodes = _zone.GetAllGridsWithinPolygon(GetComponent<PolygonCollider2D>(), m_includeWalls);
			base.gameObject.layer = 2;
		}
		else if (m_areaType == areaType.floodfill)
		{
			m_nodes = _zone.GetAllGridsConnected(base.transform.position);
		}
		else if (m_areaType == areaType.extraGrid)
		{
			m_nodes = _zone.GetAllGridsConnected(GetComponent<extraNodesScript>().index);
		}
		else
		{
			m_nodes = new int[0];
		}
	}

	private void OnDrawGizmosSelected()
	{
		if (m_areaType == areaType.floodfill)
		{
			Gizmos.color = Color.blue;
			Gizmos.DrawWireSphere(base.transform.position, 0.05f);
		}
	}

	public bool Check(int _index, itemScript _item)
	{
		for (int i = 0; i < m_nodes.Length; i++)
		{
			if (_index != m_nodes[i])
			{
				continue;
			}
			string value = _item.name.Substring(4).Replace("(Clone)", "");
			for (int j = 0; j < m_items.Length; j++)
			{
				if (m_items[j].Equals(value))
				{
					if (m_useState)
					{
						return _item.GetState() == (int)m_state;
					}
					return true;
				}
			}
			return false;
		}
		return false;
	}
}
