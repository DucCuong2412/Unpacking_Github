using System;
using UnityEngine;

public class zoneRemapScript : MonoBehaviour
{
	[Serializable]
	public struct RemapNode
	{
		public zoneScript.itemNode.nodeStyle style;

		public zoneScript.itemNode.nodeType type;

		public int x1;

		public int x2;

		public int y1;

		public int y2;

		public Vector3 position => new Vector3((float)(x2 + 1) * 0.01f, ((float)y2 + 0.5f) * 0.01f);

		public Vector3 positionOld => new Vector3((float)(x1 + 1) * 0.01f, ((float)y1 + 0.5f) * 0.01f);

		public RemapNode(zoneScript.nodeData _node, zoneScript.itemNode.nodeStyle _style)
		{
			style = _style;
			x1 = (x2 = _node.x);
			y1 = (y2 = _node.y);
			type = _node.type;
		}

		public RemapNode(zoneScript.itemNode _node)
		{
			style = _node.m_style;
			type = _node.type;
			x1 = (x2 = _node.x);
			y1 = (y2 = _node.y);
		}
	}

	public RemapNode[] m_nodes;

	public Vector2 GetNode(int _index, out zoneScript.itemNode.nodeStyle _style, out zoneScript.itemNode.nodeType _type, int _xSteps, int _ySteps)
	{
		if (_index < 0 || _index >= m_nodes.Length)
		{
			Debug.LogError(base.gameObject.name + " | index out of range - " + _index + " / " + m_nodes.Length);
			_style = zoneScript.itemNode.nodeStyle.flat;
			_type = zoneScript.itemNode.nodeType.none;
			return Vector2.zero;
		}
		_style = m_nodes[_index].style;
		_type = m_nodes[_index].type;
		if (_type == zoneScript.itemNode.nodeType.overflow)
		{
			_type = FindType(_index, _xSteps, _ySteps);
		}
		return m_nodes[_index].position;
	}

	private zoneScript.itemNode.nodeType FindType(int _index, int _xSteps, int _ySteps)
	{
		int x = m_nodes[_index].x1;
		int y = m_nodes[_index].y1;
		int[] array = new int[_xSteps * _ySteps];
		int[] array2 = new int[_xSteps * _ySteps];
		int num = 0;
		for (int i = 0; i < _xSteps; i++)
		{
			for (int j = 0; j < _ySteps; j++)
			{
				array[num] = x + (i - j) * 14;
				array2[num] = y + (i + j) * 7;
				num++;
			}
		}
		for (int k = 0; k < m_nodes.Length; k++)
		{
			for (int l = 1; l < num; l++)
			{
				if (m_nodes[k].x1 == array[l] && m_nodes[k].y1 == array2[l])
				{
					if (m_nodes[k].type == zoneScript.itemNode.nodeType.overflow)
					{
						break;
					}
					return m_nodes[k].type;
				}
			}
		}
		return m_nodes[_index].type;
	}
}
