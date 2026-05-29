using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class uiForceUINavigationLinking : MonoBehaviour
{
	public enum Direction
	{
		Horizontal = 0,
		Vertrical = 1
	}

	public Direction m_direction;

	public List<Selectable> m_selectableList = new List<Selectable>();

	private List<Selectable> m_currentSelectableList = new List<Selectable>();

	private List<Selectable> m_activeList = new List<Selectable>();

	private void Start()
	{
		foreach (Selectable selectable in m_selectableList)
		{
			m_currentSelectableList.Add(selectable);
		}
		Refresh();
	}

	private void Update()
	{
		foreach (Selectable currentSelectable in m_currentSelectableList)
		{
			if (currentSelectable == null)
			{
				Refresh();
				break;
			}
			bool num = currentSelectable.IsInteractable();
			bool flag = m_activeList.Contains(currentSelectable);
			if (num != flag)
			{
				Refresh();
				break;
			}
		}
	}

	private void Refresh()
	{
		m_activeList.Clear();
		List<Selectable> list = new List<Selectable>();
		foreach (Selectable currentSelectable in m_currentSelectableList)
		{
			if (!(currentSelectable == null))
			{
				list.Add(currentSelectable);
				currentSelectable.navigation = new Navigation
				{
					mode = Navigation.Mode.None
				};
				if (currentSelectable.IsInteractable())
				{
					m_activeList.Add(currentSelectable);
				}
			}
		}
		if (m_activeList.Count <= 1)
		{
			return;
		}
		switch (m_direction)
		{
		case Direction.Horizontal:
		{
			for (int j = 0; j < m_activeList.Count - 1; j++)
			{
				UI.CreateHorizontalNavigationLink(m_activeList[j], m_activeList[j + 1]);
			}
			break;
		}
		case Direction.Vertrical:
		{
			for (int i = 0; i < m_activeList.Count - 1; i++)
			{
				UI.CreateVerticalNavigationLink(m_activeList[i], m_activeList[i + 1]);
			}
			break;
		}
		}
	}
}
