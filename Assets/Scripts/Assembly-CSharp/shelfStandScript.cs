using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(PolygonCollider2D))]
public class shelfStandScript : MonoBehaviour
{
	private zoneScript m_zone;

	private int m_index = -1;

	private Vector3 m_position = Vector3.zero;

	public shelfStandScript m_pair;

	public zoneScript.direction m_direction;

	public int m_depth = 2;

	public int m_size = 3;

	public int m_pixelStart;

	private int m_pixelSize;

	private int m_shelfSize;

	private int m_shelfSizePixel;

	private int m_offset;

	private List<itemScript> m_items = new List<itemScript>();

	public int index => m_index;

	public int getPixelSize => m_pixelSize;

	public itemScript.nodeStyle NodeStyle()
	{
		if (m_direction != zoneScript.direction.yAxis && m_direction != zoneScript.direction.yAxisNeg)
		{
			return itemScript.nodeStyle.standingFlipped;
		}
		return itemScript.nodeStyle.standing;
	}

	public void Register(zoneScript _zone)
	{
		m_zone = _zone;
		m_index = m_zone.GetClosestGridNoCheck(base.transform.position);
		ConfigurePosition(m_zone.GetGrid(m_index));
		m_shelfSize = m_zone.FindGridSpan(m_index, m_depth, m_direction);
		m_shelfSizePixel = m_shelfSize * 14 - ((m_pair != null) ? m_pair.m_pixelStart : 0);
		m_position = base.transform.position + StepVector() * 0.5f;
		m_position.z = base.transform.position.z - (float)(m_depth - 1) * ((m_direction == zoneScript.direction.xAxis || m_direction == zoneScript.direction.yAxis) ? 0.035f : 0f);
		if (m_direction == zoneScript.direction.xAxis || m_direction == zoneScript.direction.yAxis)
		{
			m_offset = -1;
		}
		float num = ((m_direction == zoneScript.direction.xAxisNeg || m_direction == zoneScript.direction.yAxis) ? 0.005f : (-0.005f));
		m_position.x = Mathf.Floor((m_position.x + num) * 100f) / 100f;
		m_position.y = Mathf.Floor((m_position.y - 0.005f) * 100f) / 100f + 0.0125f + (float)m_offset * 0.005f;
	}

	public void ConfigurePosition(Vector3 _position)
	{
		_position.z += (float)(m_depth - 1) * ((m_direction == zoneScript.direction.xAxis || m_direction == zoneScript.direction.yAxis) ? 0.07f : 0f) + ((m_direction == zoneScript.direction.xAxis || m_direction == zoneScript.direction.yAxis) ? 0f : (-0.035f));
		base.transform.position = _position;
	}

	public int Overlap(int _grid, int _pixelOverlap)
	{
		int num = Mathf.CeilToInt((float)m_pixelSize / 14f);
		if (_grid > num)
		{
			return 0;
		}
		if (_grid < num)
		{
			return 2;
		}
		if (m_pixelSize - (num - 1) * 14 + _pixelOverlap <= 14)
		{
			return 1;
		}
		return 2;
	}

	public bool CheckFit(itemScript _item)
	{
		return CheckFit(_item, _checkActive: true);
	}

	public bool CheckFit(itemScript _item, bool _checkActive)
	{
		if (_item.standingSize > m_size || _item.standingDepth > m_depth || (_checkActive && !m_zone.GetGridActive(m_index)))
		{
			return false;
		}
		int num = m_pixelSize + _item.standPixelSize;
		if (num > m_shelfSizePixel)
		{
			return false;
		}
		int num2 = ((m_items.Count != 0) ? Mathf.CeilToInt((float)m_pixelSize / 14f) : 0);
		int num3 = Mathf.Min(Mathf.CeilToInt((float)num / 14f), m_shelfSize);
		switch ((m_pair != null) ? m_pair.Overlap(m_shelfSize - num3 + 1, num - (num3 - 1) * 14) : 0)
		{
		case 2:
			return false;
		case 0:
			if (num3 > num2)
			{
				int startIndex = m_zone.FindGridIndex(m_index, num3 - 1, m_direction);
				if (m_zone.GetGridUsed(startIndex, (m_direction == zoneScript.direction.xAxis || m_direction == zoneScript.direction.xAxisNeg) ? 1 : m_depth, (m_direction == zoneScript.direction.yAxis || m_direction == zoneScript.direction.yAxisNeg) ? 1 : m_depth))
				{
					return false;
				}
			}
			break;
		}
		return true;
	}

	public void AddItem(itemScript _item)
	{
		AddItem(_item, -1);
	}

	public void AddItem(itemScript _item, int _index)
	{
		int num = ((m_pixelSize != m_pixelStart) ? Mathf.CeilToInt((float)m_pixelSize / 14f) : 0);
		m_pixelSize += _item.standPixelSize;
		if (_index < -1 || _index > m_items.Count)
		{
			m_items.Add(_item);
		}
		else
		{
			m_items.Insert(_index + 1, _item);
		}
		_item.Shelf(this);
		for (int i = 0; i < m_items.Count; i++)
		{
			m_items[i].ShelfShuffle(i);
		}
		int num2 = Mathf.CeilToInt((float)m_pixelSize / 14f);
		if (num2 > num)
		{
			int startIndex = m_zone.FindGridIndex(m_index, num2 - 1, m_direction);
			m_zone.SetGrid(startIndex, (m_direction == zoneScript.direction.xAxis || m_direction == zoneScript.direction.xAxisNeg) ? 1 : m_depth, (m_direction == zoneScript.direction.yAxis || m_direction == zoneScript.direction.yAxisNeg) ? 1 : m_depth, _used: true, m_size);
		}
	}

	public void SimpleAddAtIndex(itemScript _item, int _index)
	{
		if (m_items.Count <= _index)
		{
			int num = _index - m_items.Count;
			for (int i = 0; i <= num; i++)
			{
				m_items.Add(null);
			}
		}
		else if (m_items[_index] != null)
		{
			SimpleAdd(_item);
			return;
		}
		m_items[_index] = _item;
		_item.Shelf(this);
	}

	public void SimpleAdd(itemScript _item)
	{
		m_items.Add(_item);
		_item.Shelf(this);
	}

	public void RemoveItem(itemScript _item)
	{
		if (m_items.Count == 0)
		{
			return;
		}
		if (m_pair != null && m_shelfSize * 14 - (getPixelSize + m_pair.getPixelSize) < 2)
		{
			int num = GetIndex(_item);
			if (num < m_items.Count - 1)
			{
				List<itemScript> list = new List<itemScript>();
				for (int i = num + 1; i < m_items.Count; i++)
				{
					list.Insert(0, m_items[i]);
				}
				foreach (itemScript item in list)
				{
					m_pair.SimpleAdd(item);
					m_items.Remove(item);
				}
				m_pair.ResetPosition();
				m_pixelSize = m_pixelStart;
				for (int j = 0; j < m_items.Count; j++)
				{
					m_pixelSize += m_items[j].standPixelSize;
				}
			}
		}
		int num2 = Mathf.CeilToInt((float)m_pixelSize / 14f);
		int num3 = ((m_pair != null) ? m_pair.Overlap(m_shelfSize - num2 + 1, m_pixelSize - (num2 - 1) * 14) : 0);
		m_items.Remove(_item);
		m_pixelSize = m_pixelStart;
		for (int k = 0; k < m_items.Count; k++)
		{
			if (m_items[k] != null)
			{
				m_pixelSize += m_items[k].standPixelSize;
				continue;
			}
			Debug.LogWarning("shelfStandScript " + base.name + " : missing item at index " + k);
		}
		if (((m_pixelSize != m_pixelStart) ? Mathf.CeilToInt((float)m_pixelSize / 14f) : 0) < num2 && num3 != 1)
		{
			int startIndex = m_zone.FindGridIndex(m_index, num2 - 1, m_direction);
			m_zone.SetGrid(startIndex, (m_direction == zoneScript.direction.xAxis || m_direction == zoneScript.direction.xAxisNeg) ? 1 : m_depth, (m_direction == zoneScript.direction.yAxis || m_direction == zoneScript.direction.yAxisNeg) ? 1 : m_depth, _used: false, m_size);
		}
	}

	public int GetIndex(itemScript _item)
	{
		if (m_items.Contains(_item))
		{
			for (int i = 0; i < m_items.Count; i++)
			{
				if (m_items[i] == _item)
				{
					return i;
				}
			}
		}
		return -1;
	}

	public void RemoveGaps()
	{
		for (int i = 0; i < m_items.Count; i++)
		{
			if (m_items[i] == null)
			{
				m_items.RemoveAt(i);
				i--;
			}
		}
		for (int j = 0; j < m_items.Count; j++)
		{
			m_items[j].ShelfShuffle(j);
		}
		ResetPosition();
	}

	public void ResetPosition()
	{
		m_pixelSize = m_pixelStart;
		for (int i = 0; i < m_items.Count; i++)
		{
			m_items[i].SimplePosition(Position(m_pixelSize + (m_items[i].standPixelSize + m_offset) / 2));
			m_pixelSize += m_items[i].standPixelSize;
		}
	}

	public void SetGrid()
	{
		int startIndex = m_index;
		int num = ((m_pixelSize != m_pixelStart) ? Mathf.Min(Mathf.CeilToInt((float)m_pixelSize / 14f), m_shelfSize) : 0);
		if (m_direction == zoneScript.direction.xAxis || m_direction == zoneScript.direction.yAxis)
		{
			startIndex = m_zone.FindGridIndex(m_index, num - 1, m_direction);
		}
		m_zone.SetGrid(startIndex, (m_direction == zoneScript.direction.xAxis || m_direction == zoneScript.direction.xAxisNeg) ? num : m_depth, (m_direction == zoneScript.direction.yAxis || m_direction == zoneScript.direction.yAxisNeg) ? num : m_depth, _used: true, m_size);
	}

	public Vector3 GetPosition(itemScript _item, int _index)
	{
		int num = m_pixelStart;
		int num2 = m_pixelStart;
		Vector2 offset = StepVector() * ((float)_item.standPixelSize / 14f);
		for (int i = 0; i < m_items.Count; i++)
		{
			if (i == _index + 1)
			{
				num2 += _item.standPixelSize;
			}
			else if (i <= _index)
			{
				num += m_items[i].standPixelSize;
			}
			m_items[i].SimplePosition(Position(num2 + (m_items[i].standPixelSize + m_offset) / 2));
			num2 += m_items[i].standPixelSize;
			if (i <= _index)
			{
				m_items[i].ShelfOffset(offset, i == m_items.Count - 1 || !m_items[i + 1].unmovable);
			}
			else
			{
				m_items[i].ShelfOffset(Vector2.zero, _enableUnmovable: false);
			}
		}
		return Position(num + (_item.standPixelSize + m_offset) / 2);
	}

	private Vector3 Position(int _pixelPosition)
	{
		return m_position - PixelToPosition(_pixelPosition);
	}

	private Vector3 PixelToPosition(int _pixels)
	{
		Vector3 zero = Vector3.zero;
		zero.x = (float)_pixels * 0.01f * ((m_direction == zoneScript.direction.xAxisNeg || m_direction == zoneScript.direction.yAxis) ? (-1f) : 1f);
		zero.y = (float)_pixels * 0.005f * ((m_direction == zoneScript.direction.xAxisNeg || m_direction == zoneScript.direction.yAxisNeg) ? (-1f) : 1f);
		zero.z = (float)_pixels * 0.005f * ((m_direction == zoneScript.direction.xAxisNeg || m_direction == zoneScript.direction.yAxisNeg) ? (-1f) : 1f);
		return zero;
	}

	private Vector3 StepVector()
	{
		Vector3 result = Vector3.zero;
		if (m_direction == zoneScript.direction.xAxis)
		{
			result = new Vector3(0.14f, 0.07f, 0.07f);
		}
		else if (m_direction == zoneScript.direction.xAxisNeg)
		{
			result = new Vector3(-0.14f, -0.07f, -0.07f);
		}
		else if (m_direction == zoneScript.direction.yAxis)
		{
			result = new Vector3(-0.14f, 0.07f, 0.07f);
		}
		else if (m_direction == zoneScript.direction.yAxisNeg)
		{
			result = new Vector3(0.14f, -0.07f, -0.07f);
		}
		return result;
	}

	public void SetCollision(bool _value)
	{
		GetComponent<Collider2D>().enabled = _value;
	}

	public void SetCollisionIfUnmovable()
	{
		GetComponent<Collider2D>().enabled = m_items.Count <= 0 || !m_items[0].unmovable;
	}

	public void SetPolyPoints(itemScript _item)
	{
		PolygonCollider2D component = GetComponent<PolygonCollider2D>();
		component.points = _item.GetPolyCollision(NodeStyle());
		component.offset = -PixelToPosition(m_pixelStart + (_item.m_standPixelSize + m_offset) / 2 - 7);
	}

	public void AdjustAllOffsets(int _value)
	{
		Vector2 offset = ((_value == 0) ? Vector2.zero : ((Vector2)StepVector() * ((float)_value / 14f)));
		for (int i = 0; i < m_items.Count; i++)
		{
			m_items[i].ShelfOffset(offset, i == m_items.Count - 1 || !m_items[i + 1].unmovable);
		}
	}

	private void OnDrawGizmosSelected()
	{
		Vector3 position = base.transform.position;
		Gizmos.color = Color.blue;
		Vector3 vector = new Vector3(0.14f, 0.07f);
		Vector3 vector2 = new Vector3(-0.14f, 0.07f);
		float num = ((m_direction != zoneScript.direction.yAxis && m_direction != zoneScript.direction.yAxisNeg) ? 1 : m_depth);
		float num2 = ((m_direction != zoneScript.direction.xAxis && m_direction != zoneScript.direction.xAxisNeg) ? 1 : m_depth);
		Vector3 vector3 = position + -vector * 0.5f + -vector2 * 0.5f;
		Vector3 vector4 = position + vector * (num - 0.5f) + -vector2 * 0.5f;
		Vector3 vector5 = position + vector * (num - 0.5f) + vector2 * (num2 - 0.5f);
		Vector3 vector6 = position + -vector * 0.5f + vector2 * (num2 - 0.5f);
		Gizmos.DrawLine(vector3, vector4);
		Gizmos.DrawLine(vector4, vector5);
		Gizmos.DrawLine(vector5, vector6);
		Gizmos.DrawLine(vector6, vector3);
		if (m_pair != null)
		{
			Gizmos.color = Color.red;
			Gizmos.DrawLine(base.transform.position, m_pair.transform.position);
		}
		if (Application.isPlaying)
		{
			Gizmos.color = Color.green;
			Gizmos.DrawRay(new Ray(m_position, Vector3.up * 0.5f));
		}
	}
}
