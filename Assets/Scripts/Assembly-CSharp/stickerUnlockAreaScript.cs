using System.Collections.Generic;
using UnityEngine;

public class stickerUnlockAreaScript : MonoBehaviour
{
	public enum unlockType
	{
		any = 0,
		all = 1,
		eletrical = 2,
		magnet = 3
	}

	public enum areaType
	{
		polygon = 0,
		floodfill = 1,
		extraGrid = 2
	}

	public statsScript.stickers m_stickerUnlock;

	public unlockType m_type;

	public areaType m_areaType = areaType.floodfill;

	public string[] m_items;

	private int[] m_itemVariants;

	public bool m_useVariants;

	public bool m_includeWalls;

	private int[] m_nodes;

	private zoneScript m_zone;

	public void Register(zoneScript _zone)
	{
		if (m_areaType == areaType.polygon)
		{
			m_nodes = _zone.GetAllGridsWithinPolygon(GetComponent<PolygonCollider2D>(), m_includeWalls);
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
		if (m_type == unlockType.all || m_type == unlockType.magnet)
		{
			m_zone = _zone;
		}
		if (m_useVariants)
		{
			MatchVariants();
		}
	}

	private void MatchVariants()
	{
		gameScript gameScript2 = Object.FindObjectOfType<gameScript>();
		m_itemVariants = new int[m_items.Length];
		for (int i = 0; i < m_items.Length; i++)
		{
			string[] array = m_items[i].Split('|');
			itemScript itemType = gameScript2.GetItemType("item" + array[0]);
			if (itemType != null)
			{
				m_items[i] = array[0];
				m_itemVariants[i] = itemType.FindVariant(array[1]);
			}
			else
			{
				Debug.LogError(base.name + " could not find item : item" + array[0]);
			}
		}
	}

	private void OnDrawGizmosSelected()
	{
		if (m_zone != null)
		{
			for (int i = 0; i < m_nodes.Length; i++)
			{
				Gizmos.color = Color.green;
				Gizmos.DrawWireSphere(m_zone.transform.TransformPoint(m_zone.GetGrid(m_nodes[i])), 0.025f);
			}
		}
		else if (m_areaType == areaType.floodfill)
		{
			Gizmos.color = Color.blue;
			Gizmos.DrawWireSphere(base.transform.position, 0.05f);
		}
	}

	public void Check(itemScript _item)
	{
		int num = _item.Node();
		bool flag = false;
		for (int i = 0; i < m_nodes.Length; i++)
		{
			if (num == m_nodes[i])
			{
				flag = true;
				break;
			}
		}
		if (!flag)
		{
			return;
		}
		if (m_type == unlockType.any)
		{
			string value = _item.name.Substring(4).Replace("(Clone)", "");
			for (int j = 0; j < m_items.Length; j++)
			{
				if (m_items[j].Equals(value) && (!m_useVariants || _item.GetVariant().Equals(m_itemVariants[j])))
				{
					statsScript.AwardSticker(m_stickerUnlock);
					break;
				}
			}
		}
		else if (m_type == unlockType.all)
		{
			bool[] array = new bool[m_items.Length];
			itemScript[] itemsOnGrids = m_zone.GetItemsOnGrids(m_nodes, 0);
			for (int k = 0; k < m_items.Length; k++)
			{
				for (int l = 0; l < itemsOnGrids.Length; l++)
				{
					if (itemsOnGrids[l] != null && itemsOnGrids[l].name.Substring(4).Replace("(Clone)", "").Equals(m_items[k]) && (!m_useVariants || itemsOnGrids[l].GetVariant().Equals(m_itemVariants[k])))
					{
						array[k] = true;
						itemsOnGrids[l] = null;
						break;
					}
				}
				if (!array[k])
				{
					return;
				}
			}
			statsScript.AwardSticker(m_stickerUnlock);
		}
		else if (m_type == unlockType.eletrical)
		{
			if (_item.m_eletrical)
			{
				statsScript.AwardSticker(m_stickerUnlock);
			}
		}
		else
		{
			if (m_type != unlockType.magnet || !_item.m_magnet)
			{
				return;
			}
			List<itemScript> list = new List<itemScript>();
			list.Add(_item);
			int num2 = _item.Node();
			int num3 = num2;
			while (num3 > -1)
			{
				itemScript itemOnGrid = m_zone.GetItemOnGrid(num3, -1);
				if (itemOnGrid != null && itemOnGrid.m_magnet)
				{
					num3 = itemOnGrid.Node();
					list.Insert(0, itemOnGrid);
				}
				else
				{
					num3 = -1;
				}
			}
			num3 = num2;
			while (num3 > -1)
			{
				itemScript itemOnGrid2 = m_zone.GetItemOnGrid(num3, 1);
				if (itemOnGrid2 != null && itemOnGrid2.m_magnet)
				{
					num3 = itemOnGrid2.Node();
					list.Add(itemOnGrid2);
				}
				else
				{
					num3 = -1;
				}
			}
			if (list.Count == 5 && (list[1].MatchVariant("Plus") || list[1].MatchVariant("Equals")) && (list[3].MatchVariant("Plus") || list[3].MatchVariant("Equals")))
			{
				statsScript.AwardSticker(m_stickerUnlock);
			}
		}
	}
}
