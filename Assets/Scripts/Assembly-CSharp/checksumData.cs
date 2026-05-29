using System;
using System.Collections.Generic;
using UnityEngine;

[CreateAssetMenu(fileName = "checksum", menuName = "ScriptableObjects/checksumData", order = 3)]
public class checksumData : ScriptableObject
{
	[Serializable]
	public struct checkOverride
	{
		public int index;

		public string checksum;
	}

	public string[] m_checksumZone;

	public string[] m_checksumItem;

	public checkOverride[] m_zoneOverride;

	public string zone(int _index)
	{
		if (m_checksumZone.Length <= _index)
		{
			return "";
		}
		return m_checksumZone[_index];
	}

	public string item(int _index)
	{
		if (m_checksumItem.Length <= _index)
		{
			return "";
		}
		return m_checksumItem[_index];
	}

	public string[] zoneOverride(int _index)
	{
		List<string> list = new List<string>();
		for (int i = 0; i < m_zoneOverride.Length; i++)
		{
			if (m_zoneOverride[i].index == _index)
			{
				list.Add(m_zoneOverride[i].checksum);
			}
		}
		return list.ToArray();
	}
}
