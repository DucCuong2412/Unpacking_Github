using System.Collections.Generic;
using System.Text;
using TMPro;
using UnityEngine;

public class OnScreenLog : MonoBehaviour
{
	private List<string> m_logList;

	private TextMeshProUGUI m_logLabel;

	private bool m_omitStack = true;

	private void Awake()
	{
		base.transform.parent.gameObject.SetActive(value: false);
	}

	private void ApplicationOnlogMessageReceived(string message, string stacktrace, LogType type)
	{
		if (m_omitStack)
		{
			if (type == LogType.Error || type == LogType.Exception)
			{
				m_logList.Add("<color=red>" + message + "</color>");
			}
			else
			{
				m_logList.Add(message);
			}
		}
		else if (type == LogType.Error || type == LogType.Exception)
		{
			m_logList.Add("<color=red>" + message + "</color>\n" + stacktrace);
		}
		else
		{
			m_logList.Add(message + "\n" + stacktrace);
		}
		UpdateLabel();
	}

	private void UpdateLabel()
	{
		StringBuilder stringBuilder = new StringBuilder();
		for (int num = m_logList.Count - 1; num >= 0; num--)
		{
			stringBuilder.AppendLine(m_logList[num]);
		}
		m_logLabel.text = stringBuilder.ToString();
	}

	private void Update()
	{
		Debug.developerConsoleVisible = false;
	}
}
