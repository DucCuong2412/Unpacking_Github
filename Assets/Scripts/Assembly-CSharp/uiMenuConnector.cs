using System;
using UnityEngine;

public class uiMenuConnector : MonoBehaviour
{
	[Serializable]
	public struct ApplySet
	{
		public uiApply m_apply;

		public uiStringSelect[] m_stringSelects;

		public uiResolutionSelect[] m_resolutionSelects;
	}

	public frontendUIScript m_uiScript;

	public gameUIScript m_gameUI;

	public uiStringSelect[] m_stringSelects;

	public ApplySet[] m_applySets;

	private void Start()
	{
		for (int i = 0; i < m_stringSelects.Length; i++)
		{
			if (m_uiScript != null)
			{
				m_stringSelects[i].SetEvents(m_uiScript);
			}
			if (m_gameUI != null)
			{
				m_stringSelects[i].SetEvents(m_gameUI);
			}
		}
		for (int j = 0; j < m_applySets.Length; j++)
		{
			m_applySets[j].m_apply.SetOptions(m_applySets[j].m_resolutionSelects, m_applySets[j].m_stringSelects);
		}
	}

	public void ResetToDefault()
	{
		for (int i = 0; i < m_applySets.Length; i++)
		{
			m_applySets[i].m_apply.Reset();
		}
	}
}
