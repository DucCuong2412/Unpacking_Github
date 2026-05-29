using UnityEngine;

public class uiElementMenuScript : MonoBehaviour
{
	private SpriteRenderer m_sprite;

	private float m_fadeTarget;

	private float m_fade;

	private Color m_fadeColor = new Color(1f, 1f, 1f, 0.25f);

	private bool m_fadeApply;

	private void Start()
	{
		m_sprite = GetComponent<SpriteRenderer>();
		m_sprite.color = m_fadeColor;
		m_fadeApply = true;
	}

	private void Update()
	{
		if (m_fade != m_fadeTarget)
		{
			m_fade = Mathf.Lerp(m_fade, m_fadeTarget, Time.deltaTime * 10f);
			m_fadeApply = true;
		}
		if (m_fadeApply)
		{
			m_sprite.color = Color.Lerp(m_fadeColor, Color.white, m_fade);
		}
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
		gameScript component = Camera.main.GetComponent<gameScript>();
		if (component != null)
		{
			component.LoadTitle();
		}
		else
		{
			Application.Quit();
		}
		GetComponent<Collider2D>().enabled = false;
	}
}
