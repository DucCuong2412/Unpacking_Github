using UnityEngine;
using UnityEngine.EventSystems;

public class loaderScript : MonoBehaviour
{
	public string m_levelToLoadDemo;

	public string m_levelToLoad;

	public GameObject m_loadPlane;

	public animAudioEventScript m_animEventScript;

	private void Update()
	{
		if (!EventSystem.current.IsPointerOverGameObject() && inputHandler.IsPressed(InputAction.Gameplay_LiftAndPlace))
		{
			Load();
		}
	}

	private void Load()
	{
		if (m_loadPlane != null)
		{
			m_loadPlane.SetActive(value: true);
		}
		gameStateScript.LoadSceneStart(m_levelToLoadDemo);
		if (m_animEventScript != null)
		{
			m_animEventScript.TriggerFadeDown();
		}
		else
		{
			gameStateScript.LoadSceneAdvance();
		}
		GetComponent<Collider2D>().enabled = false;
	}
}
