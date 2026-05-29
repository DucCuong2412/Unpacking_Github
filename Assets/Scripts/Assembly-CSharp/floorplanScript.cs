using UnityEngine;
using UnityEngine.UI;

public class floorplanScript : MonoBehaviour
{
	public gameUIScript m_uiScript;

	public CanvasGroup m_base;

	public RectTransform m_root;

	public GameObject m_floorButtonsRoot;

	public Button[] m_floorButtons;

	public RectTransform[] m_floor;

	public Image[] m_floorplan;

	public Image[] m_floorplanFill;

	public RectTransform m_hitboxPrefab;

	public RectTransform[] m_highlights;

	public Transform m_zoneButtonPrefab;

	private Button[] m_zoneButtons;

	public Sprite[] m_zoneIcons;

	public Material[] m_iconMaterials;

	private int m_changeDirection;

	private bool m_multiFloor;

	private bool[] m_floorValid;

	private bool[] m_floorPulse;

	private int m_currentFloor;

	private bool m_floorChange;

	private float m_floorLerp;

	private bool m_pulseActive;

	private float m_pulseValue;

	private float m_pulsePhase;

	private bool[] m_zonePulse;

	private bool m_pulseAnimate = true;

	private void Awake()
	{
		SetupFloorplan();
	}

	private void OnEnable()
	{
		m_pulseAnimate = gameStateScript.PulseAnimate;
		ConfigureFloorplan();
		m_changeDirection = 0;
	}

	private void Update()
	{
		if (m_floorChange)
		{
			m_floorLerp += Time.deltaTime * 3f;
			float num = ((m_currentFloor == 0) ? (-1f) : 1f);
			float num2 = ((m_floorLerp > 1f) ? 0f : (Mathf.Pow(1f - m_floorLerp, 1.7f) * num));
			float num3 = Mathf.Pow(m_floorLerp, 1.7f) * (0f - num);
			m_floor[m_currentFloor].anchoredPosition = Vector2.up * Mathf.Round(num2 * 600f);
			m_floor[(m_currentFloor == 0) ? 1u : 0u].anchoredPosition = Vector2.up * Mathf.Round(num3 * 600f);
			if (m_floorLerp >= 1f)
			{
				m_floor[(m_currentFloor == 0) ? 1u : 0u].gameObject.SetActive(value: false);
				m_floorChange = false;
				if (!m_floorValid[(m_currentFloor == 0) ? 1u : 0u])
				{
					m_floorButtons[m_currentFloor].GetComponent<Image>().material = m_iconMaterials[1];
				}
			}
		}
		if (!m_pulseActive)
		{
			return;
		}
		if (m_pulseAnimate)
		{
			m_pulsePhase += Time.deltaTime * 6f;
			m_pulseValue = Mathf.MoveTowards(m_pulseValue, Mathf.Cos(m_pulsePhase) * 0.5f + 0.4f, Time.deltaTime * 0.5f);
		}
		else
		{
			m_pulseValue = Mathf.MoveTowards(m_pulseValue, 0.25f, Time.deltaTime * 0.5f);
		}
		Color color = Color.Lerp(Color.white, Color.black, m_pulseValue);
		for (int i = 0; i < m_zoneButtons.Length; i++)
		{
			if (m_zonePulse[i])
			{
				m_zoneButtons[i].GetComponent<Image>().color = color;
			}
		}
		if (m_multiFloor && m_floorPulse[(m_currentFloor == 0) ? 1u : 0u])
		{
			m_floorButtons[m_currentFloor].GetComponent<Image>().color = color;
		}
	}

	private void SetupFloorplan()
	{
		gameScript game = m_uiScript.m_game;
		for (int i = 0; i < game.m_floorplanData.Length; i++)
		{
			m_floorplan[i].sprite = game.m_floorplanData[i].walls;
			m_floorplan[i].useSpriteMesh = true;
			m_floorplanFill[i].sprite = game.m_floorplanData[i].floor;
			m_floorplanFill[i].useSpriteMesh = true;
			for (int j = 0; j < game.m_floorplanData[i].hitbox.Length; j++)
			{
				RectTransform rectTransform = Object.Instantiate(m_hitboxPrefab, m_floorplanFill[i].rectTransform, worldPositionStays: false);
				rectTransform.anchoredPosition = game.m_floorplanData[i].hitbox[j].min;
				rectTransform.sizeDelta = game.m_floorplanData[i].hitbox[j].size;
			}
		}
		if (game.m_floorplanData.Length > 1)
		{
			m_multiFloor = true;
			m_floorButtonsRoot.SetActive(value: true);
			m_floorValid = new bool[2];
			m_floorPulse = new bool[2];
			for (int k = 0; k < m_floorValid.Length; k++)
			{
				m_floorValid[k] = true;
				m_floorPulse[k] = false;
			}
		}
		m_zoneButtons = new Button[game.m_zones.Length];
		m_zonePulse = new bool[game.m_zones.Length];
		for (int l = 0; l < game.m_zones.Length; l++)
		{
			m_zoneButtons[l] = Object.Instantiate(m_zoneButtonPrefab, m_floorplan[game.m_zones[l].m_floorplanFloor].transform).GetComponent<Button>();
			m_zoneButtons[l].GetComponent<Image>().sprite = m_zoneIcons[(int)game.m_zones[l].m_type];
			Vector2 floorplanPosition = game.m_zones[l].m_floorplanPosition;
			floorplanPosition.y *= -1f;
			m_zoneButtons[l].GetComponent<RectTransform>().anchoredPosition = floorplanPosition;
			int zone = l;
			m_zoneButtons[l].onClick.AddListener(delegate
			{
				ChangeZoneTo(zone);
			});
			m_zonePulse[l] = false;
		}
	}

	private void ConfigureFloorplan()
	{
		gameScript game = m_uiScript.m_game;
		if (m_multiFloor)
		{
			m_currentFloor = game.zone.m_floorplanFloor;
			for (int i = 0; i < m_floor.Length; i++)
			{
				m_floor[i].anchoredPosition = Vector2.zero;
				m_floor[i].gameObject.SetActive(m_currentFloor == i);
				m_floor[m_currentFloor].GetComponent<CanvasGroup>().interactable = true;
			}
			ColorFloorButtons(game.zone.m_color);
			for (int j = 0; j < m_floorValid.Length; j++)
			{
				m_floorValid[j] = true;
				m_floorPulse[j] = false;
			}
		}
		Color color = game.zone.m_color + new Color(0.125f, 0.125f, 0.125f);
		Color color2 = game.zone.m_color + new Color(0.4f, 0.4f, 0.4f);
		bool showInvalid = game.showInvalid;
		bool flag = !showInvalid && !game.zone.BoxesRemain();
		for (int k = 0; k < game.m_zones.Length; k++)
		{
			ColorBlock colors = m_zoneButtons[k].colors;
			colors.normalColor = ((game.zoneIndex == k) ? color2 : color);
			colors.disabledColor = ((game.zoneIndex == k) ? color2 : color);
			m_zoneButtons[k].colors = colors;
			m_zoneButtons[k].GetComponent<Image>().material = m_iconMaterials[(showInvalid && !game.m_zones[k].isZoneValid) ? 1 : 0];
			m_zonePulse[k] = flag && game.m_zones[k].BoxesRemain();
			m_zoneButtons[k].GetComponent<Image>().color = Color.grey;
			m_pulseActive |= m_zonePulse[k];
			if (m_multiFloor)
			{
				m_floorValid[game.m_zones[k].m_floorplanFloor] &= !showInvalid || game.m_zones[k].isZoneValid;
				ref bool reference = ref m_floorPulse[game.m_zones[k].m_floorplanFloor];
				reference |= m_zonePulse[k];
			}
		}
		if (m_multiFloor)
		{
			m_floorButtons[m_currentFloor].GetComponent<Image>().material = m_iconMaterials[(!m_floorValid[(m_currentFloor == 0) ? 1u : 0u]) ? 1u : 0u];
		}
		m_pulsePhase = 0f;
		m_pulseValue = 0.5f;
		int num = game.zone.m_floorplanHighlight.Length;
		Color.RGBToHSV(game.zone.m_color, out var H, out var S, out var V);
		S *= 2.5f;
		Color color3 = Color.HSVToRGB(H, S, V);
		for (int l = 0; l < m_highlights.Length; l++)
		{
			if (l < num)
			{
				m_highlights[l].SetParent(m_floor[m_currentFloor], worldPositionStays: false);
				m_highlights[l].SetSiblingIndex(1);
				Vector2 position = game.zone.m_floorplanHighlight[l].position;
				position.y *= -1f;
				m_highlights[l].anchoredPosition = position;
				m_highlights[l].sizeDelta = game.zone.m_floorplanHighlight[l].size;
				m_highlights[l].GetComponent<Graphic>().color = color3;
				m_highlights[l].gameObject.SetActive(value: true);
			}
			else
			{
				m_highlights[l].gameObject.SetActive(value: false);
			}
		}
		if (game.zoneIndex < m_zoneButtons.Length)
		{
			Button button = m_zoneButtons[game.zoneIndex];
			if (button != null)
			{
				m_uiScript.IgnoreNextMenuChange();
				button.Select();
				uiEventSystemExtension.enteredSelectable = button;
			}
		}
		float pixelSize = game.GetPixelSize();
		float num2 = (pixelSize + (float)gameStateScript.GetAccessSetting(gameStateScript.accessSetting.iconsize)) / pixelSize;
		for (int m = 0; m < m_zoneButtons.Length; m++)
		{
			m_zoneButtons[m].transform.localScale = Vector3.one * num2;
		}
		m_floorButtonsRoot.transform.localScale = new Vector3(num2, 1f, 1f);
		for (int n = 0; n < m_floorButtons.Length; n++)
		{
			m_floorButtons[n].transform.localScale = new Vector3(1f, num2 * ((n == 0) ? 1f : (-1f)), 1f);
		}
	}

	private void ColorFloorButtons(Color _color)
	{
		Color color = _color + new Color(0.25f, 0.25f, 0.25f);
		Color disabledColor = _color;
		disabledColor.r *= 0.625f;
		disabledColor.g *= 0.625f;
		disabledColor.b *= 0.625f;
		for (int i = 0; i < m_floorButtons.Length; i++)
		{
			if (m_currentFloor == i)
			{
				m_floorButtons[i].interactable = true;
				ColorBlock colors = m_floorButtons[i].colors;
				colors.normalColor = color;
				colors.disabledColor = color;
				m_floorButtons[i].colors = colors;
			}
			else
			{
				m_floorButtons[i].interactable = false;
				ColorBlock colors2 = m_floorButtons[i].colors;
				colors2.normalColor = color;
				colors2.disabledColor = disabledColor;
				m_floorButtons[i].colors = colors2;
			}
		}
	}

	public void ChangeZoneTo(int _newZone)
	{
		m_changeDirection = m_uiScript.m_game.ChangeZoneTo(_newZone);
		if (m_changeDirection == 0)
		{
			m_uiScript.ResumeFloorplan();
		}
		else
		{
			m_uiScript.ResumeFloorplan(2f);
		}
	}

	public void ControlsActive(bool _value)
	{
		GetComponent<CanvasGroup>().interactable = _value;
		m_uiScript.IgnoreNextMenuChange(_value: false);
	}

	public void Lerp(float _lerp)
	{
		m_base.alpha = _lerp;
		float num = 1f - _lerp;
		num *= num;
		if (m_changeDirection == 0)
		{
			m_root.anchoredPosition = Vector2.up * Mathf.Round(num * 600f);
		}
		else if (Mathf.Abs(m_changeDirection) == 1)
		{
			m_root.anchoredPosition = Vector2.right * Mathf.Round(num * 1200f) * -m_changeDirection;
		}
		else
		{
			m_root.anchoredPosition = Vector2.up * Mathf.Round(num * 1200f) * Mathf.Sign(m_changeDirection);
		}
		GetComponent<RectTransform>().sizeDelta = Vector2.one * Mathf.Round(60f * num) * 2f;
	}

	public void ChangeFloor(int _change)
	{
		m_floor[m_currentFloor].GetComponent<CanvasGroup>().interactable = false;
		if (_change > 0)
		{
			m_currentFloor = 1;
			AkSoundEngine.PostEvent(m_uiScript.m_audioFloorplanFloorUp, base.gameObject);
		}
		else
		{
			m_currentFloor = 0;
			AkSoundEngine.PostEvent(m_uiScript.m_audioFloorplanFloorDown, base.gameObject);
		}
		if (!m_floorValid[m_currentFloor])
		{
			m_floorButtons[(m_currentFloor == 0) ? 1u : 0u].GetComponent<Image>().material = m_iconMaterials[0];
		}
		if (m_floorPulse[m_currentFloor])
		{
			m_floorButtons[(m_currentFloor == 0) ? 1u : 0u].GetComponent<Image>().color = Color.grey;
		}
		if (!m_floorChange)
		{
			m_floorChange = true;
			m_floorLerp = 0f;
		}
		else
		{
			m_floorLerp = 1f - m_floorLerp;
		}
		m_floor[m_currentFloor].GetComponent<CanvasGroup>().interactable = true;
		m_floor[m_currentFloor].gameObject.SetActive(value: true);
		m_floor[m_currentFloor].anchoredPosition = Vector2.up * 600f * ((m_currentFloor == 0) ? 1f : (-1f));
		ColorFloorButtons(m_uiScript.m_game.zone.m_color);
	}
}
