using System;
using UnityEngine;
using UnityEngine.UI;

public class locArtScript : MonoBehaviour
{
	[Serializable]
	public struct languageItem
	{
		public languageData.languageId m_language;

		public Sprite m_art;
	}

	public bool m_hideIfNoMatch;

	public languageItem[] m_items;

	private void Start()
	{
		Set();
	}

	public void Set()
	{
		bool active = false;
		languageData.languageId language = gameStateScript.language;
		for (int i = 0; i < m_items.Length; i++)
		{
			if (m_items[i].m_language != language)
			{
				continue;
			}
			if (m_items[i].m_art != null)
			{
				Image component = GetComponent<Image>();
				if (component != null)
				{
					component.sprite = m_items[i].m_art;
				}
				else
				{
					SpriteRenderer component2 = GetComponent<SpriteRenderer>();
					if (component2 != null)
					{
						component2.sprite = m_items[i].m_art;
					}
				}
			}
			active = true;
			break;
		}
		if (m_hideIfNoMatch)
		{
			base.gameObject.SetActive(active);
		}
	}
}
