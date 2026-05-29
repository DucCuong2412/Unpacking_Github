using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class uiListSelect : MonoBehaviour
{
	public TMP_Text m_select;

	private List<string> m_selectList;

	private int m_selectIndex;

	private photoModeScript m_selectScript;

	private int m_selectListID;

	public Button[] m_buttons;

	public void SetList(List<string> _list, photoModeScript _script, int _listID)
	{
		m_selectList = _list;
		m_selectScript = _script;
		m_selectListID = _listID;
		m_selectIndex = 0;
		SetSelect(0);
	}

	public void SetSelect(int _change)
	{
		if (_change != 0)
		{
			m_selectIndex += _change;
			if (m_selectIndex < 0)
			{
				m_selectIndex = m_selectList.Count - 1;
			}
			else if (m_selectIndex >= m_selectList.Count)
			{
				m_selectIndex = 0;
			}
			m_selectScript.SetSelect(m_selectListID, m_selectIndex);
		}
		m_select.text = m_selectList[m_selectIndex];
	}
}
