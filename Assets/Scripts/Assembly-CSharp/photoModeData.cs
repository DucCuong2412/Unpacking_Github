using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

[CreateAssetMenu(fileName = "PhotoMode", menuName = "ScriptableObjects/photoModeData", order = 3)]
public class photoModeData : ScriptableObject
{
	[Serializable]
	public struct photoModeBorder
	{
		public string stringID;

		public Transform prefab;

		public Sprite icon;
	}

	[Serializable]
	public struct photoModeFilter
	{
		public string stringID;

		public PostProcessProfile profile;

		public Sprite icon;

		public bool hideGradient;

		public float meshStrength;
	}

	public photoModeBorder[] m_borders;

	public photoModeFilter[] m_filters;

	public List<string> borderList
	{
		get
		{
			List<string> list = new List<string>();
			for (int i = 0; i < m_borders.Length; i++)
			{
				list.Add(m_borders[i].stringID);
			}
			return list;
		}
	}

	public List<string> filterList
	{
		get
		{
			List<string> list = new List<string>();
			for (int i = 0; i < m_filters.Length; i++)
			{
				list.Add(m_filters[i].stringID);
			}
			return list;
		}
	}
}
