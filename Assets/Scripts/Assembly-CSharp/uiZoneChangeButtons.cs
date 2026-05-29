using UnityEngine;
using UnityEngine.UI;

public class uiZoneChangeButtons : MonoBehaviour
{
	public gameUIScript m_ui;

	public Material[] m_materials;

	public Image[] m_left;

	public Image[] m_right;

	public Image m_floorplan;

	public Sprite[] m_bedroomIcon;

	public Sprite[] m_KitchenIcon;

	public Sprite[] m_livingroomIcon;

	public Sprite[] m_DiningroomIcon;

	public Sprite[] m_bathroomIcon;

	public Sprite[] m_officeIcon;

	public Sprite[] m_nurseryIcon;

	public Sprite[] m_toiletIcon;

	public Sprite[] m_foyerIcon;

	public Sprite[] m_closetIcon;

	public Sprite m_dotIcon;

	private bool m_pulseLeft;

	private bool m_pulseLeftArrow;

	private bool m_pulseRight;

	private bool m_pulseRightArrow;

	private bool m_pulseFloorplan;

	private float m_pulsePhase;

	private float[] m_pulseValues = new float[5];

	private bool m_floorplanTutorial;

	private bool m_floorplanTutorialShow;

	private float m_floorplanTutorialLerp;

	private bool m_change;

	private float m_changeLerp;

	private zoneScript.zoneType m_changeLeftStart;

	private zoneScript.zoneType m_changeLeftEnd;

	private zoneScript.zoneType m_changeRightStart;

	private zoneScript.zoneType m_changeRightEnd;

	private bool m_show;

	private float m_showLerp;

	public float m_showSpeed = 1f;

	public AnimationCurve m_showCurve;

	private bool m_disabled;

	private bool m_pulseAnimate = true;

	public void Fix()
	{
		m_left[0].GetComponent<Button>().interactable = false;
		m_left[0].GetComponent<Button>().interactable = true;
		m_right[0].GetComponent<Button>().interactable = false;
		m_right[0].GetComponent<Button>().interactable = true;
	}

	public void Disable()
	{
		m_left[0].gameObject.SetActive(value: false);
		m_right[0].gameObject.SetActive(value: false);
		base.gameObject.SetActive(value: false);
		m_disabled = true;
	}

	public void Hide()
	{
		Vector2 anchoredPosition = m_left[0].rectTransform.anchoredPosition;
		anchoredPosition.x = -30f;
		m_left[0].rectTransform.anchoredPosition = anchoredPosition;
		anchoredPosition = m_right[0].rectTransform.anchoredPosition;
		anchoredPosition.x = 30f;
		m_right[0].rectTransform.anchoredPosition = anchoredPosition;
	}

	public void Show(bool _instant)
	{
		if (m_disabled)
		{
			return;
		}
		m_pulseAnimate = gameStateScript.PulseAnimate;
		if (_instant)
		{
			Vector2 anchoredPosition = m_left[0].rectTransform.anchoredPosition;
			anchoredPosition.x = 30f;
			m_left[0].rectTransform.anchoredPosition = anchoredPosition;
			anchoredPosition = m_right[0].rectTransform.anchoredPosition;
			anchoredPosition.x = -30f;
			m_right[0].rectTransform.anchoredPosition = anchoredPosition;
			if (m_floorplanTutorial)
			{
				m_floorplanTutorialShow = true;
				if (!string.IsNullOrEmpty(m_ui.m_audioFloorplanIconAppear))
				{
					AkSoundEngine.PostEvent(m_ui.m_audioFloorplanIconAppear, m_ui.gameObject);
				}
			}
		}
		else
		{
			m_show = true;
			m_showLerp = 0f;
			if (!string.IsNullOrEmpty(m_ui.m_audioRoomIconsAppear))
			{
				AkSoundEngine.PostEvent(m_ui.m_audioRoomIconsAppear, m_ui.gameObject);
			}
		}
	}

	public void Shift(float _pixels)
	{
		Vector2 anchoredPosition = m_left[0].rectTransform.anchoredPosition;
		anchoredPosition.y = 20f - _pixels;
		m_left[0].rectTransform.anchoredPosition = anchoredPosition;
		anchoredPosition = m_right[0].rectTransform.anchoredPosition;
		anchoredPosition.y = 20f - _pixels;
		m_right[0].rectTransform.anchoredPosition = anchoredPosition;
	}

	public void FloorplanTutorial()
	{
		m_floorplan.gameObject.SetActive(value: false);
		m_floorplanTutorial = true;
	}

	public void FloorplanTutorialComplete()
	{
		if (m_floorplanTutorial)
		{
			m_floorplanTutorial = false;
			gameStateScript.tutorialFloorplan = true;
		}
	}

	public void ChangeZone(zoneScript.zoneType _zoneLeft, zoneScript.zoneType _zoneRight)
	{
		m_changeLeftStart = m_changeLeftEnd;
		m_changeLeftEnd = _zoneLeft;
		m_changeRightStart = m_changeRightEnd;
		m_changeRightEnd = _zoneRight;
		m_change = true;
		m_changeLerp = 0f;
	}

	public void EndChange()
	{
		m_change = false;
		m_left[0].sprite = GetSprite(m_changeLeftEnd, 0);
		m_right[0].sprite = GetSprite(m_changeRightEnd, 0);
	}

	public void SetPulse(bool _pulseLeft, bool _pulseLeftArrow, bool _pulseRight, bool _pulseRightArrow, bool _floorplan)
	{
		m_pulseLeft = _pulseLeft;
		m_pulseLeftArrow = _pulseLeftArrow;
		m_pulseRight = _pulseRight;
		m_pulseRightArrow = _pulseRightArrow;
		m_pulseFloorplan = _floorplan;
	}

	public void SetPulseOff()
	{
		m_pulseLeft = false;
		m_pulseLeftArrow = false;
		m_pulseRight = false;
		m_pulseRightArrow = false;
		m_pulseFloorplan = false;
	}

	public void SetInvalid(bool _left, bool _leftArrow, bool _right, bool _rightArrow, bool _floorplan)
	{
		m_left[0].material = (_left ? m_materials[1] : m_materials[0]);
		m_left[1].material = (_leftArrow ? m_materials[1] : m_materials[0]);
		m_right[0].material = (_right ? m_materials[1] : m_materials[0]);
		m_right[1].material = (_rightArrow ? m_materials[1] : m_materials[0]);
		m_floorplan.material = (_floorplan ? m_materials[1] : m_materials[0]);
	}

	public void SetInvalidOff()
	{
		SetInvalid(_left: false, _leftArrow: false, _right: false, _rightArrow: false, _floorplan: false);
	}

	public void SetInitial(zoneScript.zoneType _left, zoneScript.zoneType _right)
	{
		m_left[0].sprite = GetSprite(_left, 0);
		m_changeLeftEnd = _left;
		m_right[0].sprite = GetSprite(_right, 0);
		m_changeRightEnd = _right;
		for (int i = 0; i < m_pulseValues.Length; i++)
		{
			m_pulseValues[i] = 0.5f;
		}
	}

	private Sprite GetSprite(zoneScript.zoneType _zone, int _index)
	{
		if (_index >= m_livingroomIcon.Length)
		{
			Debug.LogError(_zone.ToString() + " wanted frame " + _index);
			return null;
		}
		switch (_zone)
		{
		case zoneScript.zoneType.bedroom:
			return m_bedroomIcon[_index];
		case zoneScript.zoneType.kitchen:
			return m_KitchenIcon[_index];
		case zoneScript.zoneType.diningroom:
			return m_DiningroomIcon[_index];
		case zoneScript.zoneType.bathroom:
			return m_bathroomIcon[_index];
		case zoneScript.zoneType.office:
			return m_officeIcon[_index];
		case zoneScript.zoneType.foyer:
			return m_foyerIcon[_index];
		case zoneScript.zoneType.closet:
			return m_closetIcon[_index];
		case zoneScript.zoneType.nursery:
			return m_nurseryIcon[_index];
		case zoneScript.zoneType.toilet:
			return m_toiletIcon[_index];
		default:
			return m_livingroomIcon[_index];
		}
	}

	private void Pulse(Image _image, bool _active, ref float _value)
	{
		if (!_active && _value == 0f)
		{
			return;
		}
		if (_active)
		{
			if (m_pulseAnimate)
			{
				_value = Mathf.MoveTowards(_value, Mathf.Cos(m_pulsePhase) * 0.25f + 0.4f, Time.deltaTime * 0.75f);
			}
			else
			{
				_value = Mathf.MoveTowards(_value, 0.35f, Time.deltaTime * 0.5f);
			}
		}
		else
		{
			_value = Mathf.MoveTowards(_value, 0.5f, Time.deltaTime * 0.5f);
		}
		_image.color = Color.Lerp(Color.white, Color.black, _value);
	}

	private void Update()
	{
		if (m_show)
		{
			m_showLerp += Time.deltaTime * m_showSpeed;
			if (m_showLerp >= 1f)
			{
				m_show = false;
				if (m_floorplanTutorial)
				{
					m_floorplanTutorialShow = true;
					if (!string.IsNullOrEmpty(m_ui.m_audioFloorplanIconAppear))
					{
						AkSoundEngine.PostEvent(m_ui.m_audioFloorplanIconAppear, m_ui.gameObject);
					}
				}
			}
			Vector2 anchoredPosition = m_left[0].rectTransform.anchoredPosition;
			anchoredPosition.x = Mathf.Round(Mathf.Lerp(-30f, 30f, m_showCurve.Evaluate(m_showLerp)) * 0.5f) * 2f;
			m_left[0].rectTransform.anchoredPosition = anchoredPosition;
			anchoredPosition = m_right[0].rectTransform.anchoredPosition;
			anchoredPosition.x = Mathf.Round(Mathf.Lerp(30f, -30f, m_showCurve.Evaluate(m_showLerp)) * 0.5f) * 2f;
			m_right[0].rectTransform.anchoredPosition = anchoredPosition;
		}
		else if (m_floorplanTutorialShow)
		{
			m_floorplan.gameObject.SetActive(value: true);
			m_floorplanTutorialLerp += Time.deltaTime * m_showSpeed;
			if (m_floorplanTutorialLerp >= 1f)
			{
				m_floorplanTutorialShow = false;
			}
			Vector2 anchoredPosition2 = m_floorplan.rectTransform.anchoredPosition;
			anchoredPosition2.y = Mathf.Round(Mathf.Lerp(40f, -6f, m_showCurve.Evaluate(m_floorplanTutorialLerp)) * 0.5f) * 2f;
			m_floorplan.rectTransform.anchoredPosition = anchoredPosition2;
		}
		if (m_pulseLeft || m_pulseLeftArrow || m_pulseRight || m_pulseRightArrow || m_pulseFloorplan || m_floorplanTutorial)
		{
			m_pulsePhase += Time.deltaTime * 6f;
		}
		else
		{
			m_pulsePhase = 0f;
		}
		Pulse(m_left[0], m_pulseLeft, ref m_pulseValues[0]);
		Pulse(m_left[1], m_pulseLeftArrow, ref m_pulseValues[1]);
		Pulse(m_right[0], m_pulseRight, ref m_pulseValues[2]);
		Pulse(m_right[1], m_pulseRightArrow, ref m_pulseValues[3]);
		Pulse(m_floorplan, m_pulseFloorplan || m_floorplanTutorial, ref m_pulseValues[4]);
		if (m_change)
		{
			float num = ((m_changeLerp > 0.45f && m_changeLerp < 0.5f) ? 0.2f : 1.25f);
			m_changeLerp = Mathf.MoveTowards(m_changeLerp, 1f, Time.deltaTime * num);
			int num2 = Mathf.CeilToInt(m_changeLerp * 10f);
			if (num2 < 5)
			{
				m_left[0].sprite = GetSprite(m_changeLeftStart, num2);
				m_right[0].sprite = GetSprite(m_changeRightStart, num2);
			}
			else if (num2 == 5)
			{
				m_left[0].sprite = m_dotIcon;
				m_right[0].sprite = m_dotIcon;
			}
			else if (num2 > 5)
			{
				int num3 = 0;
				num3 = ((num2 != 6) ? (10 - num2) : 5);
				m_left[0].sprite = GetSprite(m_changeLeftEnd, num3);
				m_right[0].sprite = GetSprite(m_changeRightEnd, num3);
			}
			if (m_changeLerp == 1f)
			{
				m_change = false;
			}
		}
	}
}
