using UnityEngine;

public class simpleLoadTitleScript : MonoBehaviour
{
	public void LoadTitle()
	{
		AkSoundEngine.PostEvent("ui_main_menu", base.gameObject);
		CanvasGroup component = GetComponent<CanvasGroup>();
		component.blocksRaycasts = false;
		component.interactable = false;
		gameStateScript.LoadSceneFade("title", 0.25f);
	}
}
