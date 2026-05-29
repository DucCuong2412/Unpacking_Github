using TMPro;
using UnityEngine;

public class stringIdScript : MonoBehaviour
{
	public enum fontStyle
	{
		noneSet = 0,
		small = 1,
		large = 2,
		outline = 3,
		cover = 4,
		smallAlt = 5
	}

	public string m_stringID = "";

	public fontStyle m_style;

	private void Start()
	{
		SetStyle();
		SetString();
	}

	public void SetStyle()
	{
		if (m_style != fontStyle.noneSet)
		{
			TMP_Text component = GetComponent<TMP_Text>();
			if (component != null)
			{
				component.font = gameStateScript.GetFont(m_style);
			}
		}
	}

	public float SetString(string _stringID)
	{
		m_stringID = _stringID;
		return SetString();
	}

	public void SetSpacing(float _spacing = 0f)
	{
		TMP_Text component = GetComponent<TMP_Text>();
		if (component != null)
		{
			component.characterSpacing = _spacing;
		}
	}

	public float SetString()
	{
		TMP_Text component = GetComponent<TMP_Text>();
		if (component != null)
		{
			component.text = (string.IsNullOrEmpty(m_stringID) ? "" : (gameStateScript.GetString(m_stringID) + " "));
			return component.preferredWidth;
		}
		return 0f;
	}

	public void Fade(float _value)
	{
		TMP_Text component = GetComponent<TMP_Text>();
		string text = gameStateScript.GetString(m_stringID);
		text = text.Insert(Mathf.RoundToInt((float)text.Length * _value), "<color=#00000000>") + "</color> ";
		if (component != null)
		{
			component.text = text;
		}
	}
}
