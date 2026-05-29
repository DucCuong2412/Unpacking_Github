using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class uiMenuBuilder : MonoBehaviour
{
	public enum menuType
	{
		none = 0,
		item = 1,
		volumeMusic = 2,
		volumeSfx = 3,
		volumeMaster = 4,
		resolution = 5,
		zoneChange = 6,
		fullscreen = 7,
		apply = 8
	}

	public enum showType
	{
		none = 0,
		show = 1,
		hide = 2
	}

	[Serializable]
	public struct MenuItem
	{
		public string m_stringId;

		public Sprite m_icon;

		public menuType m_type;

		public showType m_demo;

		public showType m_console;

		public showType m_resume;

		public showType m_initial;

		public showType m_stickers;

		public showType m_xbox;

		public Button.ButtonClickedEvent m_event;
	}

	public RectTransform m_menuItemPrefab;

	public RectTransform m_menuSliderPrefab;

	public RectTransform m_menuTogglePrefab;

	public RectTransform m_menuResolutionPrefab;

	public RectTransform m_menuApplyPrefab;

	[Space(10f)]
	public GameObject m_menuObject;

	[Space(10f)]
	public Vector2 m_offset = Vector2.zero;

	public float m_spacing = 40f;

	public bool generateLinkedNavigation;

	public MenuItem[] m_menuItems;

	private List<RectTransform> m_createdItems = new List<RectTransform>();

	public void ResolutionAlign(int _height)
	{
		if (m_createdItems.Count != 0)
		{
			float num = (m_offset.y + 10f + m_spacing * (float)(m_createdItems.Count - 1)) * 2f;
			Vector2 offset = m_offset;
			float num2 = m_spacing;
			if (num > (float)_height)
			{
				num2 -= Mathf.Ceil((num - (float)_height) * 0.5f / (float)m_createdItems.Count);
			}
			for (int i = 0; i < m_createdItems.Count; i++)
			{
				m_createdItems[i].anchoredPosition = offset;
				offset.y -= num2;
			}
		}
	}

	private IEnumerator Start()
	{
		Transform parent = base.transform;
		while (!saveData.SaveDataLoaded())
		{
			yield return null;
		}
		bool flag = false;
		bool flag2 = saveData.CheckResume();
		bool flag3 = !saveData.AlbumsExist();
		bool flag4 = saveData.HasStickers();
		bool flag5 = false;
		bool flag6 = false;
		Vector2 offset = m_offset;
		List<uiResolutionSelect> list = new List<uiResolutionSelect>();
		uiGamepadNavigationElement uiGamepadNavigationElement2 = null;
		for (int i = 0; i < m_menuItems.Length; i++)
		{
			if ((m_menuItems[i].m_resume == showType.hide && flag2) || (m_menuItems[i].m_resume == showType.show && !flag2) || (m_menuItems[i].m_initial == showType.hide && flag3) || (m_menuItems[i].m_initial == showType.show && !flag3) || (m_menuItems[i].m_demo == showType.hide && flag) || (m_menuItems[i].m_demo == showType.show && !flag) || (m_menuItems[i].m_console == showType.hide && flag5) || (m_menuItems[i].m_console == showType.show && !flag5) || (m_menuItems[i].m_stickers == showType.hide && flag4) || (m_menuItems[i].m_stickers == showType.show && !flag4) || (m_menuItems[i].m_xbox == showType.hide && flag6) || (m_menuItems[i].m_xbox == showType.show && !flag6))
			{
				continue;
			}
			RectTransform rectTransform = null;
			if (m_menuItems[i].m_type == menuType.item)
			{
				rectTransform = UnityEngine.Object.Instantiate(m_menuItemPrefab, parent);
				rectTransform.anchoredPosition = offset;
				rectTransform.GetComponent<stringIdScript>().m_stringID = m_menuItems[i].m_stringId;
				Image componentInChildren = rectTransform.GetComponentInChildren<Image>();
				if (componentInChildren != null)
				{
					if (m_menuItems[i].m_icon != null)
					{
						componentInChildren.sprite = m_menuItems[i].m_icon;
					}
					else
					{
						componentInChildren.gameObject.SetActive(value: false);
					}
				}
				rectTransform.GetComponent<Button>().onClick = m_menuItems[i].m_event;
			}
			else if (m_menuItems[i].m_type == menuType.volumeMusic || m_menuItems[i].m_type == menuType.volumeSfx || m_menuItems[i].m_type == menuType.volumeMaster)
			{
				rectTransform = UnityEngine.Object.Instantiate(m_menuSliderPrefab, parent);
				rectTransform.anchoredPosition = offset;
				rectTransform.GetComponent<stringIdScript>().m_stringID = m_menuItems[i].m_stringId;
				if (m_menuItems[i].m_type == menuType.volumeMusic)
				{
					rectTransform.GetComponent<uiSlider>().m_type = "volume_music";
				}
				else if (m_menuItems[i].m_type == menuType.volumeSfx)
				{
					rectTransform.GetComponent<uiSlider>().m_type = "volume_sfx";
				}
				else if (m_menuItems[i].m_type == menuType.volumeMaster)
				{
					rectTransform.GetComponent<uiSlider>().m_type = "volume_master";
				}
				rectTransform.GetComponent<uiSlider>().m_uiScript = m_menuObject;
			}
			else if (m_menuItems[i].m_type == menuType.resolution)
			{
				rectTransform = UnityEngine.Object.Instantiate(m_menuResolutionPrefab, parent);
				rectTransform.anchoredPosition = offset;
				rectTransform.GetComponent<stringIdScript>().m_stringID = m_menuItems[i].m_stringId;
				rectTransform.GetComponent<uiResolutionSelect>().SetEvents(base.transform.parent.GetComponent<frontendUIScript>());
				list.Add(rectTransform.GetComponent<uiResolutionSelect>());
			}
			if (m_menuItems[i].m_type == menuType.apply)
			{
				rectTransform = UnityEngine.Object.Instantiate(m_menuApplyPrefab, parent);
				rectTransform.anchoredPosition = offset;
				rectTransform.GetComponent<stringIdScript>().m_stringID = m_menuItems[i].m_stringId;
				rectTransform.GetComponent<Button>().onClick = m_menuItems[i].m_event;
				Debug.Log("apply events added");
				rectTransform.GetComponent<uiApply>().SetOptions(list.ToArray(), new uiStringSelect[0]);
				list.Clear();
			}
			if (rectTransform != null)
			{
				rectTransform.gameObject.SetActive(value: true);
				uiGamepadNavigationElement componentInChildren2 = rectTransform.GetComponentInChildren<uiGamepadNavigationElement>();
				if (componentInChildren2 != null)
				{
					if (generateLinkedNavigation && uiGamepadNavigationElement2 != null)
					{
						UI.CreateVerticalNavigationLink(uiGamepadNavigationElement2, componentInChildren2);
					}
					uiGamepadNavigationElement2 = componentInChildren2;
				}
				m_createdItems.Add(rectTransform);
			}
			offset.y -= m_spacing;
		}
		GetComponent<uiGamepadNavigationGroup>()?.Refresh();
		ResolutionAlign(Screen.height / (int)GetComponentInParent<CanvasScaler>().scaleFactor);
	}
}
