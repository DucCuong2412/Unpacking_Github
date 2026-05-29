using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class albumItemScript : MonoBehaviour
{
	private enum animType
	{
		select = 0,
		pull = 1,
		place = 2,
		replace = 3
	}

	public Transform m_pivot;

	public SpriteRenderer m_cover;

	public TextMeshPro m_name;

	public TextMeshPro m_year;

	public SpriteRenderer m_star;

	public Sprite[] m_stars;

	public SpriteRenderer m_coverName;

	public GameObject m_shadowRoot;

	public SpriteRenderer m_shadow;

	public Transform m_shadowMask;

	public Transform m_shadowMaskAlt;

	private Selectable m_uiHookInstance;

	private int m_colorIndex;

	private animType m_anim;

	private float m_animTime;

	public AnimationCurve m_animCurvePull;

	public AnimationCurve m_animCurvePlace;

	private float m_position;

	private float m_positionTarget;

	private int m_pixelPosition;

	public Selectable UIHookInstance => m_uiHookInstance;

	public int colorIndex => m_colorIndex;

	public bool selected => m_positionTarget > 0f;

	public void Set(Color _color, int _colorIndex, string _name, int _stageComplete, int _completeState)
	{
		m_colorIndex = _colorIndex;
		m_cover.color = _color;
		if (string.IsNullOrEmpty(_name))
		{
			m_name.enabled = false;
			m_coverName.enabled = false;
		}
		else
		{
			string text = _name;
			while (m_name.GetPreferredValues(text).x > 21f)
			{
				text = text.Substring(0, text.Length - 1);
			}
			m_name.text = text;
		}
		if (_stageComplete < 0)
		{
			m_year.enabled = false;
			m_star.enabled = false;
			return;
		}
		m_year.font = gameStateScript.GetFont(stringIdScript.fontStyle.smallAlt);
		if (_stageComplete > 0)
		{
			m_year.text = gameStateScript.GetString("album_childroom_year") + "-\n" + gameStateScript.GetString((new string[7] { "album_studioapt_year", "album_sharehouse_year", "album_boyfriendapt_year", "album_parenthouse_year", "album_soloapt_year", "album_partnerapt_year", "album_house_year" })[Mathf.Min(_stageComplete - 1, 6)]);
		}
		else
		{
			m_year.text = gameStateScript.GetString("album_childroom_year");
		}
		if (_completeState > 0)
		{
			m_star.sprite = m_stars[_completeState - 1];
			m_star.enabled = true;
		}
		else
		{
			m_star.enabled = false;
		}
	}

	public void ShowShadow(float _horizontalOffset)
	{
		float num = Mathf.Max(0.01f, _horizontalOffset) - _horizontalOffset;
		m_shadow.transform.localPosition = Vector3.right * Mathf.Max(0.01f, _horizontalOffset);
		m_shadow.size = new Vector2(4.84f - Mathf.Abs(_horizontalOffset) - num, 1.21f);
		m_shadowRoot.SetActive(value: true);
	}

	public void SetShadow(int _value)
	{
		int num = m_pixelPosition - _value;
		m_shadowMask.localPosition = Vector3.up * num * 0.01f;
		if (num < 0)
		{
			m_shadowMaskAlt.gameObject.SetActive(value: true);
			m_shadowMaskAlt.localPosition = Vector3.up * Mathf.Round((float)num * 2.5f) * 0.01f;
		}
		else
		{
			m_shadowMaskAlt.gameObject.SetActive(value: false);
		}
	}

	public int GetPosition()
	{
		return m_pixelPosition;
	}

	public bool Select(bool _value)
	{
		if (_value && m_positionTarget < 10f)
		{
			m_positionTarget = 10f;
			return true;
		}
		if (!_value && m_positionTarget > 0f)
		{
			m_positionTarget = 0f;
			return true;
		}
		return false;
	}

	public void Replace()
	{
		m_anim = animType.replace;
		m_animTime = 0f;
		m_position = 80f;
		Position(Mathf.Round(m_position));
	}

	public void Pull()
	{
		m_anim = animType.pull;
		m_animTime = 0f;
	}

	public void Place()
	{
		m_anim = animType.place;
		m_animTime = 0f;
	}

	private void OnDestroy()
	{
		if (m_uiHookInstance != null)
		{
			Object.Destroy(m_uiHookInstance.gameObject);
		}
	}

	private void Update()
	{
		if (m_uiHookInstance != null)
		{
			switch (inputHandler.CurrentControllerInputType)
			{
			case inputHandler.ControllerInputType.Keyboard:
				m_uiHookInstance.gameObject.SetActive(value: false);
				break;
			case inputHandler.ControllerInputType.Gamepad:
				m_uiHookInstance.gameObject.SetActive(value: true);
				break;
			}
		}
		if (m_anim == animType.select)
		{
			if (m_position != m_positionTarget)
			{
				m_position = Mathf.Lerp(m_position, m_positionTarget, Time.deltaTime * 12f);
				Position(Mathf.Round(m_position));
			}
		}
		else if (m_anim == animType.pull)
		{
			m_animTime += Time.deltaTime;
			float num = m_animCurvePull.Evaluate(m_animTime) * 150f;
			Position(Mathf.RoundToInt(m_position + num));
		}
		else if (m_anim == animType.place)
		{
			m_animTime += Time.deltaTime * 1.25f;
			float f = m_animCurvePlace.Evaluate(m_animTime) * 150f;
			m_pivot.localPosition = Vector3.up * Mathf.Round(f) * 0.01f;
			if (m_animTime >= 1f)
			{
				m_anim = animType.select;
				m_position = 0f;
				Position(0f);
			}
		}
		else if (m_anim == animType.replace)
		{
			m_animTime += Time.deltaTime;
			if (m_animTime >= 0.6f)
			{
				m_anim = animType.select;
			}
		}
	}

	private void Position(float _value)
	{
		m_pixelPosition = (int)_value;
		m_pivot.localPosition = new Vector3(-0.02f, -0.01f, 0f) * _value;
	}
}
