using System;
using UnityEngine;

public class positionSaveScript : MonoBehaviour
{
	[Serializable]
	public class positionDataType
	{
		[HideInInspector]
		public string m_name;

		public Transform m_item;

		public float m_depth;

		public positionDataType(Transform _item, float _depth)
		{
			m_item = _item;
			m_name = m_item.gameObject.name;
			m_depth = _depth;
		}
	}

	public positionDataType[] m_positionData;
}
