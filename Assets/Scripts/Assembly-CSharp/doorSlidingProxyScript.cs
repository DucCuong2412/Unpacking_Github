using UnityEngine;

public class doorSlidingProxyScript : MonoBehaviour
{
	public zoneScript.direction m_direction = zoneScript.direction.yAxis;

	private Vector3 m_basePosition;

	public doorSlidingScript m_doorRight;

	public doorSlidingScript m_doorLeft;

	public int m_doorRangeRight = 10;

	public int m_doorRangeLeft = 10;

	public SpriteMask m_spriteMask;

	private void Start()
	{
		m_basePosition = base.transform.localPosition;
	}

	private void LateUpdate()
	{
		Vector2 vector = new Vector2((m_direction == zoneScript.direction.xAxis || m_direction == zoneScript.direction.yAxisNeg) ? (-0.02f) : 0.02f, (m_direction == zoneScript.direction.xAxisNeg || m_direction == zoneScript.direction.yAxisNeg) ? (-0.01f) : 0.01f);
		int num = Mathf.Min(0, m_doorRight.doorPosition - m_doorRangeRight) + Mathf.Max(0, m_doorLeft.doorPosition - m_doorRangeLeft);
		base.transform.localPosition = m_basePosition + new Vector3((float)num * vector.x, (float)num * vector.y, 0f);
		if (m_spriteMask != null)
		{
			m_spriteMask.enabled = m_doorLeft.m_spriteMask.enabled;
		}
	}

	public int Use()
	{
		return m_doorLeft.Use();
	}
}
