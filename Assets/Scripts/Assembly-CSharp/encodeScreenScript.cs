using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class encodeScreenScript : MonoBehaviour
{
	private enum encodeState
	{
		none = 0,
		start = 1,
		finish = 2
	}

	public Image m_dim;

	public Color m_dimColor = Color.black;

	public RectTransform[] m_nodes;

	public TextMeshProUGUI m_title;

	public TextMeshProUGUI m_text;

	private gameUIScript m_ui;

	private encodeState m_state = encodeState.start;

	private float m_timer;

	private float m_timerFade;

	private float m_startPos;

	private void Start()
	{
		m_nodes[0].anchoredPosition = Vector2.up * -600f;
		m_nodes[1].anchoredPosition = Vector2.up * -600f;
		m_nodes[1].gameObject.SetActive(value: false);
		m_ui = Object.FindObjectOfType<gameUIScript>();
		m_ui.PlaybackEncode(_start: true);
	}

	private void Update()
	{
		if (m_timerFade < 1f)
		{
			m_timerFade += Time.deltaTime * 1f;
			m_dim.color = Color.Lerp(Color.clear, m_dimColor, Mathf.Pow(m_timerFade, 2f));
		}
		if (m_state == encodeState.start)
		{
			m_timer += Time.deltaTime * 1f;
			float t = Mathf.Pow(m_timer, 2f);
			m_nodes[0].anchoredPosition = Vector2.up * Mathf.Round(Mathf.Lerp(-600f, 0f, t));
			if (m_timer >= 1f)
			{
				m_state = encodeState.none;
				m_timer = 0f;
			}
		}
		else if (m_state == encodeState.finish)
		{
			m_timer += Time.deltaTime;
			float t2 = Mathf.Pow(m_timer, 2f);
			m_nodes[0].anchoredPosition = Vector2.up * Mathf.Round(Mathf.Lerp(m_startPos, 600f, t2));
			m_nodes[1].anchoredPosition = Vector2.up * Mathf.Round(Mathf.Lerp(-600f, 0f, t2));
			if (m_timer >= 1f)
			{
				m_nodes[0].gameObject.SetActive(value: false);
				GetComponent<CanvasGroup>().interactable = true;
				GetComponent<CanvasGroup>().blocksRaycasts = true;
				m_state = encodeState.none;
				m_timer = 0f;
			}
		}
	}

	public void Finish(bool _video, string _url)
	{
		if (m_state == encodeState.start)
		{
			if (m_timer > 0.25f)
			{
				m_startPos = m_nodes[0].anchoredPosition.y;
			}
			else
			{
				m_nodes[0].gameObject.SetActive(value: false);
			}
		}
		m_nodes[1].gameObject.SetActive(value: true);
		m_title.font = gameStateScript.GetFont(stringIdScript.fontStyle.large);
		if (_video)
		{
			Debug.Log("encodeScreenScript : video");
			m_title.text = gameStateScript.GetString("playback_video_result");
		}
		else
		{
			Debug.Log("encodeScreenScript : gif");
			m_title.text = gameStateScript.GetString("playback_gif_result");
		}
		m_text.text = _url;
		m_state = encodeState.finish;
		m_timer = 0f;
		m_ui.PlaybackEncode(_start: false);
		m_ui.PlaybackDialogShow();
	}

	public void Continue()
	{
		m_ui.PlaybackAccept();
	}
}
