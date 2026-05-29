using System;
using System.Text;
using TMPro;
using UnityEngine;

public class creditsCombinerScript : MonoBehaviour
{
	[Serializable]
	public struct credit
	{
		public string role;

		public string name;

		public credit(string _role, string _name)
		{
			role = _role;
			name = _name;
		}
	}

	public Color m_roleTint = new Color32(162, 188, 203, byte.MaxValue);

	public int m_width;

	public credit[] m_credits;

	public bool m_localiseRoles;

	public stringIdScript.fontStyle m_style;

	private void OnEnable()
	{
		if (m_localiseRoles)
		{
			SetStyle();
			LocaliseCredits();
		}
	}

	private void SetStyle()
	{
		if (m_style != stringIdScript.fontStyle.noneSet)
		{
			TMP_Text component = GetComponent<TMP_Text>();
			if (component != null)
			{
				component.font = gameStateScript.GetFont(m_style);
			}
		}
	}

	private void LocaliseCredits()
	{
		StringBuilder stringBuilder = new StringBuilder();
		string text = "<color=#" + ColorUtility.ToHtmlStringRGB(m_roleTint) + ">";
		for (int i = 0; i < m_credits.Length; i++)
		{
			stringBuilder.AppendLine(text + gameStateScript.GetString(m_credits[i].role) + "</color>");
			stringBuilder.AppendLine(m_credits[i].name.Replace("\\n", "\n"));
			if (i < m_credits.Length - 1)
			{
				stringBuilder.AppendLine();
			}
		}
		GetComponent<TextMeshProUGUI>().text = stringBuilder.ToString();
	}
}
