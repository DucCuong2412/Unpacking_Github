using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class stickerSceneScriptUINavOverride : MonoBehaviour
{
	[Serializable]
	public class IndexedUINavigation
	{
		public int up;

		public int down;

		public int left;

		public int right;
	}

	public RectTransform m_stickerSheetsRoot;

	public List<IndexedUINavigation> m_indexedUINavigations = new List<IndexedUINavigation>();

	private List<Selectable> m_stickerSelectables = new List<Selectable>();

	private bool m_pendingRefresh = true;

	private void LateUpdate()
	{
		if (m_pendingRefresh)
		{
			Refresh();
		}
	}

	[ContextMenu("Refresh")]
	private void Refresh()
	{
		m_pendingRefresh = false;
		m_stickerSelectables.Clear();
		m_stickerSelectables.AddRange(m_stickerSheetsRoot.GetComponentsInChildren<Selectable>());
		int num = Mathf.Min(m_stickerSelectables.Count, m_indexedUINavigations.Count);
		for (int i = 0; i < num; i++)
		{
			Selectable selectable = m_stickerSelectables[i];
			IndexedUINavigation indexedUINavigation = m_indexedUINavigations[i];
			if (!(selectable == null) && indexedUINavigation != null)
			{
				selectable.navigation = new Navigation
				{
					mode = Navigation.Mode.Explicit,
					selectOnUp = ((indexedUINavigation.up >= 0 && indexedUINavigation.up < num) ? m_stickerSelectables[indexedUINavigation.up] : null),
					selectOnDown = ((indexedUINavigation.down >= 0 && indexedUINavigation.down < num) ? m_stickerSelectables[indexedUINavigation.down] : null),
					selectOnLeft = ((indexedUINavigation.left >= 0 && indexedUINavigation.left < num) ? m_stickerSelectables[indexedUINavigation.left] : null),
					selectOnRight = ((indexedUINavigation.right >= 0 && indexedUINavigation.right < num) ? m_stickerSelectables[indexedUINavigation.right] : null)
				};
			}
		}
	}
}
