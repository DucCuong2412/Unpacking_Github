using System;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class uiLanguageListScript : MonoBehaviour
{
	public Transform m_transform;

	public ScrollRect m_scrollRect;

	public Scrollbar m_scrollbar;

	private Selectable m_cachedEnteredSelectable;

	public frontendUIScript m_uiScript;

	public RectTransform m_menuItemPrefab;

	public float m_spacing = 25f;

	public Button m_backButton;

	private Image[] m_menuTicks;

	private void Start()
	{
		if (m_transform == null)
		{
			m_transform = base.transform;
		}
		string[] names = Enum.GetNames(typeof(languageData.languageId));
		int language = (int)gameStateScript.language;
		m_menuTicks = new Image[names.Length];
		Vector2 zero = Vector2.zero;
		RectTransform rectTransform = null;
		for (int i = 0; i < names.Length; i++)
		{
			RectTransform rectTransform2 = UnityEngine.Object.Instantiate(m_menuItemPrefab, m_transform);
			rectTransform2.anchoredPosition = zero;
			TextMeshProUGUI component = rectTransform2.GetComponent<TextMeshProUGUI>();
			component.font = gameStateScript.GetFont(stringIdScript.fontStyle.small, (languageData.languageId)i);
			component.text = gameStateScript.GetLanguageName(i);
			m_menuTicks[i] = rectTransform2.GetComponentInChildren<Image>();
			m_menuTicks[i].enabled = language == i;
			int id = i;
			rectTransform2.GetComponent<Button>().onClick.AddListener(delegate
			{
				ChangeLanguage(id);
			});
			zero.y -= m_spacing;
			if (i == 0)
			{
				if (m_backButton != null)
				{
					UI.CreateVerticalNavigationLink(m_backButton.GetComponent<uiGamepadNavigationElement>(), rectTransform2.GetComponent<uiGamepadNavigationElement>());
				}
			}
			else
			{
				UI.CreateVerticalNavigationLink(rectTransform.GetComponent<uiGamepadNavigationElement>(), rectTransform2.GetComponent<uiGamepadNavigationElement>());
			}
			rectTransform = rectTransform2;
		}
		Canvas.ForceUpdateCanvases();
		ShowCurrent();
	}

	private void OnEnable()
	{
		ShowCurrent();
	}

	private void ShowCurrent()
	{
		int language = (int)gameStateScript.language;
		if (m_menuTicks != null && m_menuTicks.Length > language)
		{
			float height = m_scrollRect.viewport.rect.height;
			float height2 = m_scrollRect.content.rect.height;
			RectTransform component = m_menuTicks[language].transform.parent.GetComponent<RectTransform>();
			float num = height2 - height;
			float num2 = 18f / num;
			float num3 = height / num;
			float num4 = 1f - (0f - component.anchoredPosition.y) / num;
			float max = Mathf.Min(1f, num4 + num3 - num2);
			float min = Mathf.Max(0f, num4);
			m_scrollRect.verticalNormalizedPosition = Mathf.Clamp(1f, min, max);
		}
	}

	private void RefreshScrollView()
	{
		uiDebug.Log(base.gameObject, "RefreshScrollView");
		if (m_scrollRect == null || m_scrollRect.content == null || m_scrollRect.viewport == null)
		{
			return;
		}
		float height = m_scrollRect.viewport.rect.height;
		float height2 = m_scrollRect.content.rect.height;
		if (height2 < height)
		{
			return;
		}
		float num = 0f;
		RectTransform rectTransform = null;
		int childCount = m_scrollRect.content.transform.childCount;
		for (int i = 0; i < childCount; i++)
		{
			Transform child = m_scrollRect.content.transform.GetChild(i);
			RectTransform component = child.GetComponent<RectTransform>();
			if (component == null)
			{
				continue;
			}
			Selectable componentInChildren = child.GetComponentInChildren<Selectable>();
			if (componentInChildren == null)
			{
				num += component.rect.height;
				continue;
			}
			if (componentInChildren == uiEventSystemExtension.enteredSelectable)
			{
				rectTransform = component;
				m_cachedEnteredSelectable = componentInChildren;
				break;
			}
			num += component.rect.height;
		}
		if (!(rectTransform == null))
		{
			float num2 = height2 - height;
			float num3 = rectTransform.rect.height / num2;
			float num4 = height / num2;
			float num5 = 1f - num / num2;
			float max = Mathf.Min(1f, num5 + num4 - num3);
			float min = Mathf.Max(0f, num5);
			m_scrollRect.verticalNormalizedPosition = Mathf.Clamp(m_scrollRect.verticalNormalizedPosition, min, max);
		}
	}

	private void Update()
	{
		if (inputHandler.CurrentControllerInputType == inputHandler.ControllerInputType.Gamepad && m_cachedEnteredSelectable != uiEventSystemExtension.enteredSelectable)
		{
			m_cachedEnteredSelectable = uiEventSystemExtension.enteredSelectable;
			if (m_cachedEnteredSelectable != null)
			{
				RefreshScrollView();
			}
		}
	}

	public void ChangeLanguage(int _language)
	{
		if (gameStateScript.language != (languageData.languageId)_language)
		{
			for (int i = 0; i < m_menuTicks.Length; i++)
			{
				m_menuTicks[i].enabled = _language == i;
			}
			gameStateScript.language = (languageData.languageId)_language;
			AkSoundEngine.PostEvent(m_uiScript.m_audioSettings, m_uiScript.gameObject);
		}
	}
}
