using UnityEngine;

public class frontendScript : MonoBehaviour
{
	private string[] m_stageNames = new string[9] { "0", "1_childRoom", "2_studioApt", "3_shareHouse", "4_boyfriendApt", "5_parentHouse", "6_soloApt", "7_partnerApt", "8_house" };

	private void Start()
	{
	}

	public void Quit()
	{
		Application.Quit();
	}
}
