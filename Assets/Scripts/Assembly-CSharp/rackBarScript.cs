using UnityEngine;

public class rackBarScript : MonoBehaviour
{
	public enum rackBar
	{
		rack = 0,
		bar = 1
	}

	public rackBar m_rackBar;

	public zoneScript.direction m_direction = zoneScript.direction.xAxisNeg;

	public zoneScript.itemNode.nodeType m_type = zoneScript.itemNode.nodeType.zone8;

	public int m_segments = 1;

	public int m_height;

	public int m_size = 1;

	private SpriteRenderer[] m_renderers;

	public rackBarScript m_parent;

	public Vector3 m_groundPosition = Vector3.zero;

	public int m_groundDepth;

	public void Register(zoneScript _zone)
	{
		if (m_segments < 1)
		{
			return;
		}
		Vector3 vector = _zone.transform.InverseTransformPoint(base.transform.position);
		_zone.ExpandGridRackBar(m_rackBar == rackBar.rack, vector, m_direction, m_segments, m_height, m_size, m_type, vector + m_groundPosition, m_groundDepth);
		Material sharedMaterial = Object.FindObjectOfType<gameScript>().m_materials[1];
		Sprite sprite = base.transform.parent.GetComponent<SpriteRenderer>().sprite;
		base.transform.parent.GetComponent<SpriteRenderer>().enabled = false;
		Vector3 position = base.transform.position;
		position.z = position.y + (float)m_height * -0.06f - 0.001f;
		m_renderers = new SpriteRenderer[m_segments + 1];
		MaterialPropertyBlock materialPropertyBlock = new MaterialPropertyBlock();
		float num = ((m_direction == zoneScript.direction.xAxis || m_direction == zoneScript.direction.yAxisNeg) ? 0.14f : (-0.14f));
		float num2 = ((m_direction == zoneScript.direction.xAxis || m_direction == zoneScript.direction.yAxis) ? 0.07f : (-0.07f));
		int num3 = ((m_direction != zoneScript.direction.xAxis && m_direction != zoneScript.direction.yAxis) ? (-1) : 0);
		if (m_rackBar == rackBar.rack)
		{
			num3++;
		}
		float num4 = position.x - base.transform.parent.position.x + 0.01f * Mathf.Sign(num);
		bool flag = m_direction == zoneScript.direction.xAxis || m_direction == zoneScript.direction.yAxisNeg;
		for (int i = 0; i < m_segments + 1; i++)
		{
			GameObject gameObject = new GameObject(base.gameObject.name + "slice" + i);
			gameObject.transform.parent = base.transform.parent;
			gameObject.transform.localPosition = Vector3.forward * (i + num3) * num2 + Vector3.forward * 0.01f;
			m_renderers[i] = gameObject.AddComponent<SpriteRenderer>();
			m_renderers[i].sharedMaterial = sharedMaterial;
			m_renderers[i].sprite = sprite;
			m_renderers[i].GetPropertyBlock(materialPropertyBlock);
			float num5 = (flag ? (num4 + (float)(i - 1) * num) : (num4 + (float)i * num));
			float num6 = (flag ? (num5 + num) : (num5 - num));
			if (i == 0)
			{
				if (flag)
				{
					num5 -= num * 5f;
				}
				else
				{
					num6 -= num * 5f;
				}
			}
			else if (i == m_segments)
			{
				if (flag)
				{
					num6 += num * 5f;
				}
				else
				{
					num5 += num * 5f;
				}
			}
			materialPropertyBlock.SetFloat("_SplitStart", num5);
			materialPropertyBlock.SetFloat("_SplitEnd", num6);
			m_renderers[i].SetPropertyBlock(materialPropertyBlock);
		}
	}

	private void OnDrawGizmosSelected()
	{
		Vector3 vector = Vector2.zero;
		if (m_direction == zoneScript.direction.xAxis)
		{
			vector = new Vector3(0.14f, 0.07f);
		}
		else if (m_direction == zoneScript.direction.xAxisNeg)
		{
			vector = new Vector3(-0.14f, -0.07f);
		}
		else if (m_direction == zoneScript.direction.yAxis)
		{
			vector = new Vector3(-0.14f, 0.07f);
		}
		else if (m_direction == zoneScript.direction.yAxisNeg)
		{
			vector = new Vector3(0.14f, -0.07f);
		}
		Vector3 position = base.transform.position;
		position.z = position.y + (float)m_height * -0.06f - 0.001f;
		if (m_direction == zoneScript.direction.xAxisNeg || m_direction == zoneScript.direction.yAxisNeg)
		{
			position.z += 0.07f;
		}
		if (m_rackBar == rackBar.rack)
		{
			position.z -= 0.07f;
		}
		if (m_parent != null)
		{
			Gizmos.color = Color.red;
			Gizmos.DrawLine(position - vector / 7f - Vector3.up * 2f * vector.y, position - vector / 7f + Vector3.up * 2f * vector.y);
		}
		Gizmos.color = Color.green;
		Gizmos.DrawWireSphere(position, 0.01f);
		Vector3 vector2 = position - vector * 0.5f;
		Vector3 vector3 = vector2 + vector * m_segments;
		Vector3 vector4 = new Vector3(vector.x, 0f - vector.y) * 0.2857143f;
		Gizmos.DrawLine(vector2 + vector4, vector3 + vector4);
		Gizmos.DrawLine(vector2 - vector4, vector3 - vector4);
		for (int i = 0; i < m_segments; i++)
		{
			Vector3 vector5 = position + Vector3.right * vector.x * i + Vector3.forward * i * vector.y + Vector3.up * i * vector.y;
			Gizmos.DrawLine(vector5 - Vector3.up * vector.y, vector5 + Vector3.up * vector.y);
		}
		if (m_size > 0 && m_size < 99)
		{
			Gizmos.color = Color.yellow;
			Gizmos.DrawRay(position + vector * -0.5f + Vector3.up * -0.085f, Vector3.up * m_size * -0.17f);
			Gizmos.DrawRay(position + vector * ((float)m_segments - 0.5f) + Vector3.up * -0.085f, Vector3.up * m_size * -0.17f);
		}
		if (m_groundDepth > 0)
		{
			Gizmos.color = Color.blue;
			Gizmos.DrawWireSphere(position + m_groundPosition, 0.01f);
			Vector3 vector6 = position + m_groundPosition + new Vector3(vector.x, 0f - vector.y) * -0.5f - vector * 0.5f;
			Gizmos.DrawLine(vector6, vector6 + vector * m_segments);
			for (int j = 0; j < m_groundDepth; j++)
			{
				Vector3 vector7 = vector6 + new Vector3(vector.x, 0f - vector.y) * (j + 1);
				Gizmos.DrawLine(vector7, vector7 + vector * m_segments);
			}
		}
	}
}
