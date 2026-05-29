using UnityEngine;

public class environmentSplitScript : MonoBehaviour
{
	public Vector3 m_startPosition = Vector3.zero;

	public int m_segments = 1;

	public int m_height;

	public bool m_negative;

	private SpriteRenderer[] m_renderers;

	private void Start()
	{
		if (m_segments < 1)
		{
			return;
		}
		m_renderers = new SpriteRenderer[m_segments];
		MaterialPropertyBlock materialPropertyBlock = new MaterialPropertyBlock();
		float num = m_startPosition.x - 0.14f;
		float num2 = (m_negative ? 0.07f : (-0.07f));
		for (int i = 0; i < m_segments; i++)
		{
			if (i == 0)
			{
				m_renderers[0] = GetComponent<SpriteRenderer>();
				m_renderers[0].sharedMaterial = Object.FindObjectOfType<gameScript>().m_materials[1];
				Vector3 localPosition = base.transform.localPosition;
				localPosition.z = m_startPosition.y + (float)m_height * -0.06f - 0.001f;
				base.transform.localPosition = localPosition;
			}
			else
			{
				GameObject gameObject = new GameObject(base.gameObject.name + "slice" + i);
				gameObject.transform.parent = base.transform;
				gameObject.transform.localPosition = Vector3.forward * i * num2;
				m_renderers[i] = gameObject.AddComponent<SpriteRenderer>();
				m_renderers[i].sharedMaterial = m_renderers[0].sharedMaterial;
				m_renderers[i].sprite = m_renderers[0].sprite;
			}
			m_renderers[i].GetPropertyBlock(materialPropertyBlock);
			if (i == 0)
			{
				materialPropertyBlock.SetFloat("_SplitStart", num - 0.5f);
			}
			else
			{
				materialPropertyBlock.SetFloat("_SplitStart", num + (float)i * 0.14f);
			}
			if (i == m_segments - 1)
			{
				materialPropertyBlock.SetFloat("_SplitEnd", num + (float)(i + 1) * 0.14f + 0.5f);
			}
			else
			{
				materialPropertyBlock.SetFloat("_SplitEnd", num + (float)(i + 1) * 0.14f);
			}
			m_renderers[i].SetPropertyBlock(materialPropertyBlock);
		}
	}

	private void Update()
	{
	}

	private void OnDrawGizmosSelected()
	{
		Vector3 startPosition = m_startPosition;
		startPosition.z = startPosition.y + (float)m_height * -0.06f - 0.001f;
		float num = (m_negative ? 0.07f : (-0.07f));
		Gizmos.color = Color.green;
		Gizmos.DrawWireSphere(startPosition, 0.01f);
		for (int i = 0; i < m_segments; i++)
		{
			Vector3 vector = startPosition + Vector3.right * 0.14f * (i - 1) + Vector3.forward * i * num;
			Gizmos.DrawLine(vector - Vector3.up * 0.5f, vector + Vector3.up * 0.5f);
		}
	}
}
