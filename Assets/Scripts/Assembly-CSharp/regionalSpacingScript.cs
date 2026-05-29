using UnityEngine;

[RequireComponent(typeof(stringIdScript))]
public class regionalSpacingScript : MonoBehaviour
{
	public languageData.languageId m_language;

	public float m_spacing;

	private void Awake()
	{
		if (gameStateScript.language == m_language)
		{
			GetComponent<stringIdScript>().SetSpacing(m_spacing);
		}
	}
}
