using UnityEngine;

public class parallaxScript : MonoBehaviour
{
	public Vector2 m_factor = Vector2.zero;

	private Transform m_camera;

	private Camera m_cameraComponent;

	private Transform m_zone;

	private gameScript m_game;

	private float m_depth;

	private const float zoneSwitch = 0.25f;

	private void Start()
	{
		m_cameraComponent = Camera.main;
		m_camera = m_cameraComponent.transform;
		m_game = m_camera.GetComponent<gameScript>();
		m_zone = base.transform.parent;
		while (m_zone.parent != null && !m_zone.GetComponent<zoneScript>())
		{
			m_zone = m_zone.parent;
		}
		m_depth = base.transform.localPosition.z;
	}

	private void Update()
	{
		if (m_game.gameActive)
		{
			Vector3 localPosition = m_camera.localPosition;
			Vector3 localPosition2 = m_zone.localPosition;
			float num = m_cameraComponent.orthographicSize / 2.7f;
			base.transform.localPosition = new Vector3(Mathf.Round((localPosition.x - localPosition2.x * 0.25f) * (m_factor.x * num) * 100f) / 100f, Mathf.Round((localPosition.y - localPosition2.y * 0.25f) * (m_factor.y * num) * 100f) / 100f, m_depth);
		}
	}
}
