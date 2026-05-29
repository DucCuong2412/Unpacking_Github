using UnityEngine;

public class uiElementScript : MonoBehaviour
{
	private gameScript m_game;

	public SpriteRenderer[] m_sprites;

	public Sprite[] m_bedroomIcon;

	public Sprite[] m_KitchenIcon;

	public Sprite[] m_livingroomIcon;

	public Sprite[] m_DiningroomIcon;

	public Sprite[] m_bathroomIcon;

	public Sprite[] m_officeIcon;

	public Sprite m_dotIcon;

	public int m_direction;

	private float m_fadeTarget;

	private float m_fade;

	private Color m_fadeColor = Color.grey;

	private bool m_fadeApply;

	private bool m_pulse;

	private bool m_pulseArrow;

	private float m_pulsePhase;

	private bool m_changeZone;

	private float m_changeLerp;

	private zoneScript.zoneType m_changeStartZone;

	private zoneScript.zoneType m_changeEndZone;

	public void ChangeZone(zoneScript.zoneType _newZone)
	{
		m_changeStartZone = m_changeEndZone;
		m_changeEndZone = _newZone;
		m_changeZone = true;
		m_changeLerp = 0f;
	}

	public void SetPulse(bool _icon, bool _arrow)
	{
		if (_icon && _arrow && !m_pulse)
		{
			m_pulsePhase = 0f;
		}
		m_pulse = _icon;
		m_pulseArrow = _arrow;
		m_fadeApply = true;
	}

	public void SetInvalid(bool _icon, bool _arrow)
	{
		if (_icon)
		{
			m_sprites[0].sharedMaterial = m_game.m_materials[6];
		}
		else
		{
			m_sprites[0].sharedMaterial = m_game.m_materials[0];
		}
		if (_arrow)
		{
			m_sprites[1].sharedMaterial = m_game.m_materials[6];
		}
		else
		{
			m_sprites[1].sharedMaterial = m_game.m_materials[0];
		}
	}

	private void Awake()
	{
		m_game = Camera.main.GetComponent<gameScript>();
		m_fadeApply = true;
	}

	public void SetColor(Color _color)
	{
		m_fadeColor = _color;
		m_fadeApply = true;
	}

	public void SetInitial(zoneScript.zoneType _type)
	{
		m_sprites[0].sprite = GetSprite(_type, 0);
		m_changeEndZone = _type;
	}

	private Sprite GetSprite(zoneScript.zoneType _zone, int _index)
	{
		switch (_zone)
		{
		case zoneScript.zoneType.bedroom:
		case zoneScript.zoneType.nursery:
		case zoneScript.zoneType.closet:
			return m_bedroomIcon[_index];
		case zoneScript.zoneType.kitchen:
			return m_KitchenIcon[_index];
		case zoneScript.zoneType.diningroom:
			return m_DiningroomIcon[_index];
		case zoneScript.zoneType.bathroom:
		case zoneScript.zoneType.toilet:
			return m_bathroomIcon[_index];
		case zoneScript.zoneType.office:
			return m_officeIcon[_index];
		default:
			return m_livingroomIcon[_index];
		}
	}

	private void Update()
	{
		if (m_fade != m_fadeTarget)
		{
			m_fade = Mathf.Lerp(m_fade, m_fadeTarget, Time.deltaTime * 10f);
			m_fadeApply = true;
		}
		if (m_fadeApply || m_pulse || m_pulseArrow)
		{
			float num = 0f;
			if (m_pulse || m_pulseArrow)
			{
				m_pulsePhase += Time.deltaTime * 6f;
				num = Mathf.Sin(m_pulsePhase) * 0.4f + 0.4f;
			}
			for (int i = 0; i < m_sprites.Length; i++)
			{
				if ((i == 0 && m_pulse) || (i == 1 && m_pulseArrow))
				{
					m_sprites[i].color = Color.Lerp(m_fadeColor + new Color(1f, 1f, 1f) * num, Color.white, m_fade);
				}
				else
				{
					m_sprites[i].color = Color.Lerp(m_fadeColor + new Color(0.4f, 0.4f, 0.4f), Color.white, m_fade);
				}
			}
		}
		if (m_changeZone)
		{
			float num2 = ((m_changeLerp > 0.45f && m_changeLerp < 0.5f) ? 0.2f : 1.25f);
			m_changeLerp = Mathf.MoveTowards(m_changeLerp, 1f, Time.deltaTime * num2);
			int num3 = Mathf.CeilToInt(m_changeLerp * 10f);
			if (num3 < 5)
			{
				m_sprites[0].sprite = GetSprite(m_changeStartZone, num3);
			}
			else if (num3 == 5)
			{
				m_sprites[0].sprite = m_dotIcon;
			}
			else if (num3 > 5)
			{
				int num4 = 0;
				num4 = ((num3 != 6) ? (10 - num3) : 5);
				m_sprites[0].sprite = GetSprite(m_changeEndZone, num4);
			}
			if (m_changeLerp == 1f)
			{
				m_changeZone = false;
			}
		}
		m_fadeApply = false;
	}

	private void OnMouseOver()
	{
		m_fadeTarget = 1f;
	}

	private void OnMouseExit()
	{
		m_fadeTarget = 0f;
	}

	private void OnMouseDown()
	{
		m_game.ChangeZone(m_direction);
	}
}
