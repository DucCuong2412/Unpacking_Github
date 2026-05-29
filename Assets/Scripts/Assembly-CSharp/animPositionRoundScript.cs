using UnityEngine;

public class animPositionRoundScript : MonoBehaviour
{
	public Transform[] m_items;

	public Transform[] m_itemsHorizontalA;

	public Transform[] m_itemsHorizontalB;

	private void LateUpdate()
	{
		for (int i = 0; i < m_items.Length; i++)
		{
			Vector3 localPosition = m_items[i].localPosition;
			localPosition.x = Mathf.Round(localPosition.x * 100f) * 0.01f;
			localPosition.y = Mathf.Round(localPosition.y * 100f) * 0.01f;
			m_items[i].localPosition = localPosition;
		}
		for (int j = 0; j < m_itemsHorizontalA.Length; j++)
		{
			Vector3 localPosition2 = m_itemsHorizontalA[j].localPosition;
			localPosition2.x = Mathf.Round(localPosition2.x * 50f) * 0.02f;
			localPosition2.y = localPosition2.x * 0.5f;
			m_itemsHorizontalA[j].localPosition = localPosition2;
		}
		for (int k = 0; k < m_itemsHorizontalB.Length; k++)
		{
			Vector3 localPosition3 = m_itemsHorizontalB[k].localPosition;
			localPosition3.x = Mathf.Round(localPosition3.x * 50f) * 0.02f;
			localPosition3.y = localPosition3.x * -0.5f;
			m_itemsHorizontalB[k].localPosition = localPosition3;
		}
	}
}
