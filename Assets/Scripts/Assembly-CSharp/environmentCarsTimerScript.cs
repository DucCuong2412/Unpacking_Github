using UnityEngine;

public class environmentCarsTimerScript : MonoBehaviour
{
	public Material[] m_materials;

	public SpriteRenderer m_tintReference;

	private int m_colorId;

	private environmentCarsScript[] m_carScripts;

	public float m_speed = 0.075f;

	private float m_timer;

	private float m_percent = 1f;

	private void Awake()
	{
		m_carScripts = base.transform.GetComponentsInChildren<environmentCarsScript>();
		for (int i = 0; i < m_materials.Length; i++)
		{
			m_materials[i] = new Material(m_materials[i]);
		}
		m_colorId = Shader.PropertyToID("_Color");
		for (int j = 0; j < m_carScripts.Length; j++)
		{
			m_carScripts[j].Init(m_materials);
		}
	}

	private void OnEnable()
	{
		m_percent = timeOfDayScript.activity;
		_ = m_tintReference.color;
		for (int i = 0; i < m_carScripts.Length; i++)
		{
			m_carScripts[i].SetTarget(m_percent);
			m_carScripts[i].Reload();
		}
	}

	private void Update()
	{
		m_timer -= Time.deltaTime;
		for (int i = 0; i < m_materials.Length; i++)
		{
			m_materials[i].SetColor(m_colorId, m_tintReference.color);
		}
		if (m_timer <= 0f)
		{
			m_percent = timeOfDayScript.activity;
			m_timer += m_speed;
			for (int j = 0; j < m_carScripts.Length; j++)
			{
				m_carScripts[j].SetTarget(m_percent);
				m_carScripts[j].CarUpdate();
			}
		}
	}
}
