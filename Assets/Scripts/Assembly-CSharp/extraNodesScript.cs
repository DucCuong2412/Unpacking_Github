using UnityEngine;

public class extraNodesScript : MonoBehaviour
{
	public bool m_altColor;

	public zoneScript.itemNode.nodeType m_type = zoneScript.itemNode.nodeType.zone5;

	public zoneScript.itemNode.audioSurface m_audio = zoneScript.itemNode.audioSurface.shelf;

	public Vector3 m_offset = Vector3.zero;

	public int m_xSkip;

	public int m_ySkip;

	public int m_xWidth = 1;

	public int m_yWidth = 1;

	public int m_size = 1;

	private int m_index = -1;

	public int index => m_index;

	public void AddNodes(zoneScript _zone, Vector3 _offset, Transform _parent, int _height)
	{
		AddNodes(_zone, _offset, _parent, _height, m_size, 0);
	}

	public void AddNodes(zoneScript _zone, Vector3 _offset, Transform _parent, int _height, int _size)
	{
		AddNodes(_zone, _offset, _parent, _height, _size, 0);
	}

	public void AddNodes(zoneScript _zone, Vector3 _offset, Transform _parent, int _height, int _size, int _boxSize)
	{
		Vector3 vector = new Vector3(0.14f, 0.07f);
		Vector3 vector2 = new Vector3(-0.14f, 0.07f);
		Vector3 startPos = base.transform.position - _zone.transform.position + m_offset + _offset + m_xSkip * vector + m_ySkip * vector2;
		m_index = _zone.ExpandGrid(startPos, m_xWidth, m_yWidth, _height, _size, _parent, m_type, m_audio, _boxSize);
	}

	public void RemoveNodes(zoneScript _zone)
	{
		_zone.RemoveGrid(m_index, m_xWidth, m_yWidth);
	}

	public void SetMaskLevel(zoneScript _zone, int _maskLevel)
	{
		_zone.SetGridMaskLevel(m_index, m_xWidth, m_yWidth, _maskLevel);
	}

	public void ActivateNodes(zoneScript _zone, bool _active)
	{
		_zone.SetGridActive(m_index, m_xWidth, m_yWidth, _active);
	}

	public void SetForeground(zoneScript _zone, bool _foreground)
	{
		_zone.SetGridForeground(m_index, m_xWidth, m_yWidth, _foreground);
	}

	public void SetBoxTop(zoneScript _zone, bool _boxTop)
	{
		_zone.SetGridBoxTop(m_index, m_xWidth, m_yWidth, _boxTop);
	}

	public bool CheckNodes(zoneScript _zone)
	{
		return !_zone.CheckGrid(m_index, m_xWidth, m_yWidth, 0, zoneScript.direction.xAxis).result;
	}

	private void OnDrawGizmosSelected()
	{
		Gizmos.color = (m_altColor ? Color.blue : Color.green);
		Vector3 vector = new Vector3(0.14f, 0.07f);
		Vector3 vector2 = new Vector3(-0.14f, 0.07f);
		Vector3 vector3 = base.transform.position + m_offset + m_xSkip * vector + m_ySkip * vector2;
		Vector3 vector4 = vector3 + -vector * 0.5f + -vector2 * 0.5f;
		Vector3 vector5 = vector3 + vector * ((float)m_xWidth - 0.5f) + -vector2 * 0.5f;
		Vector3 vector6 = vector3 + -vector * 0.5f + vector2 * ((float)m_yWidth - 0.5f);
		for (int i = 0; i <= m_yWidth; i++)
		{
			Gizmos.DrawLine(vector4 + vector2 * i, vector5 + vector2 * i);
		}
		for (int j = 0; j <= m_xWidth; j++)
		{
			Gizmos.DrawLine(vector6 + vector * j, vector4 + vector * j);
		}
		if (m_size > 1)
		{
			Gizmos.color = Color.yellow;
			Gizmos.DrawRay(vector4, Vector3.up * m_size * 0.14f);
			Gizmos.DrawRay(vector5, Vector3.up * m_size * 0.14f);
			Gizmos.DrawRay(vector5 + vector2 * m_yWidth, Vector3.up * m_size * 0.14f);
			Gizmos.DrawRay(vector6, Vector3.up * m_size * 0.14f);
		}
	}
}
