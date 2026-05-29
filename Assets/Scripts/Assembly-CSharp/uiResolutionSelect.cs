using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class uiResolutionSelect : MonoBehaviour
{
	public TMP_Text m_resolution;

	private int m_width;

	private int m_height;

	public Color[] m_colorUnapplied;

	private ColorBlock[] m_colors;

	public Button[] m_buttons;

	private uiApply m_apply;

	private uiApplyButton m_applyButton;

	private bool m_needsApply;

	public bool needsApply => m_needsApply;

	public int width => m_width;

	public int height => m_height;

	private void Awake()
	{
		if (m_buttons != null && m_buttons.Length != 0)
		{
			m_colors = new ColorBlock[4];
			m_colors[0] = m_buttons[1].colors;
			m_colors[1] = m_buttons[0].colors;
			m_colors[2] = m_buttons[1].colors;
			m_colors[3] = m_buttons[0].colors;
			m_colors[2].normalColor = m_colorUnapplied[0];
			m_colors[3].normalColor = m_colorUnapplied[1];
			if (m_colorUnapplied.Length > 2)
			{
				m_colors[2].selectedColor = m_colorUnapplied[2];
				m_colors[2].highlightedColor = m_colorUnapplied[2];
				m_colors[2].pressedColor = m_colorUnapplied[2];
				m_colors[3].selectedColor = m_colorUnapplied[3];
				m_colors[3].highlightedColor = m_colorUnapplied[3];
				m_colors[3].pressedColor = m_colorUnapplied[3];
			}
		}
	}

	private void OnEnable()
	{
		m_width = Screen.width;
		m_height = Screen.height;
		SetResolution(0);
	}

	public void Reset()
	{
		m_width = Screen.currentResolution.width;
		m_height = Screen.currentResolution.height;
		SetResolution(0);
	}

	public void SetEvents(frontendUIScript _frontend)
	{
		for (int i = 0; i < m_buttons.Length; i++)
		{
			m_buttons[i].onClick.AddListener(delegate
			{
				_frontend.Change();
			});
			if (i == 0)
			{
				m_buttons[i].onClick.AddListener(delegate
				{
					SetResolution(-1);
				});
			}
			else
			{
				m_buttons[i].onClick.AddListener(delegate
				{
					SetResolution(1);
				});
			}
		}
	}

	public void RegisterApply(uiApply _apply)
	{
		m_apply = _apply;
	}

	public void RegisterApply(uiApplyButton _apply)
	{
		m_applyButton = _apply;
	}

	public void SetResolution(int _change)
	{
		if (_change != 0)
		{
			Resolution[] resolutions = Screen.resolutions;
			int num = -1;
			for (int i = 0; i < resolutions.Length; i++)
			{
				if (resolutions[i].width == m_width && resolutions[i].height == m_height)
				{
					num = i;
				}
			}
			if (num != -1)
			{
				int num2 = num;
				do
				{
					num2 += _change;
					if (num2 < 0)
					{
						num2 = resolutions.Length - 1;
					}
					else if (num2 >= resolutions.Length)
					{
						num2 = 0;
					}
				}
				while (num != num2 && (resolutions[num2].width < 640 || resolutions[num2].height < 360 || (resolutions[num2].width == resolutions[num].width && resolutions[num2].height == resolutions[num].height)));
				num = num2;
			}
			else
			{
				num = 0;
			}
			m_width = resolutions[num].width;
			m_height = resolutions[num].height;
		}
		m_resolution.text = m_width + "x" + m_height;
		m_needsApply = Screen.width != m_width || Screen.height != m_height;
		SetColors();
		if (m_apply != null)
		{
			m_apply.OptionChange();
		}
		if (m_applyButton != null)
		{
			m_applyButton.OptionChange();
		}
	}

	public void MarkApplied()
	{
		m_needsApply = false;
		SetColors();
	}

	private void SetColors()
	{
		m_buttons[0].colors = m_colors[(!m_needsApply) ? 1 : 3];
		m_buttons[1].colors = m_colors[m_needsApply ? 2 : 0];
		m_buttons[2].colors = m_colors[(!m_needsApply) ? 1 : 3];
		GetComponent<TMP_Text>().color = m_colors[m_needsApply ? 2 : 0].normalColor;
	}

	public void OnMove(int dir)
	{
		if (dir > 0)
		{
			m_buttons[2].onClick.Invoke();
		}
		else if (dir < 0)
		{
			m_buttons[0].onClick.Invoke();
		}
	}
}
