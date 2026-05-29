using UnityEngine;
using UnityEngine.UI;

public class uiVisualInteractiveState : MonoBehaviour
{
	public Graphic m_targetGraphic;

	public Selectable m_targetSelectable;

	public Color m_interactiveColor = Color.white;

	public Color m_nonInteractiveColor = Color.grey;

	private Color m_originalColor = Color.white;

	private Color m_preTransitionColor = Color.white;

	private Color m_targetColor = Color.white;

	[Min(0f)]
	public float m_transitionDuration = 0.1f;

	private float m_transitionTimer;

	private void Start()
	{
		m_originalColor = m_targetGraphic.color;
		Transition(0f);
	}

	private void Update()
	{
		if (m_transitionTimer > 0f)
		{
			m_transitionTimer -= Time.deltaTime;
			float t = Mathf.Min(1f, 1f - m_transitionTimer / m_transitionDuration);
			m_targetGraphic.color = Color.Lerp(m_preTransitionColor, m_targetColor, t);
		}
	}

	private void Transition(float duration)
	{
		m_targetColor = (m_targetSelectable.IsInteractable() ? m_interactiveColor : m_nonInteractiveColor) * m_originalColor;
		m_preTransitionColor = m_targetGraphic.color;
		m_transitionTimer = duration;
		if (m_transitionTimer == 0f)
		{
			m_targetGraphic.color = m_targetColor;
		}
	}

	private void OnCanvasGroupChanged()
	{
		Transition(m_transitionDuration);
	}
}
