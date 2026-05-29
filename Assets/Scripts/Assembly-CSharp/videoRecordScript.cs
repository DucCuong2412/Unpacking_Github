using System;
using System.IO;
using NatSuite.Recorders;
using NatSuite.Recorders.Clocks;
using NatSuite.Recorders.Inputs;
using UnityEngine;

public class videoRecordScript : MonoBehaviour
{
	private bool m_active;

	private IClock clock;

	private MP4Recorder recorder;

	private CameraInput cameraInput;

	private AudioInput audioInput;

	private int m_vsyncCount;

	public bool isActive => m_active;

	public void StartRecording()
	{
		m_active = true;
		Application.targetFrameRate = 30;
		m_vsyncCount = QualitySettings.vSyncCount;
		QualitySettings.vSyncCount = 0;
		clock = new RealtimeClock();
		recorder = new MP4Recorder(Screen.width, Screen.height, 30f);
		cameraInput = new CameraInput(recorder, clock, Camera.main);
		audioInput = new AudioInput(recorder, clock, Camera.main.gameObject);
		Debug.Log("video recording");
	}

	public async void StopRecording()
	{
		m_active = false;
		cameraInput.Dispose();
		audioInput.Dispose();
		string text = await recorder.FinishWriting();
		QualitySettings.vSyncCount = m_vsyncCount;
		Application.targetFrameRate = -1;
		string pathVideo = gameStateScript.GetPathVideo();
		try
		{
			if (!Directory.Exists(pathVideo))
			{
				Directory.CreateDirectory(pathVideo);
			}
			string text2 = DateTime.Now.ToString("yyyyMMdd_");
			int num = 1;
			while (File.Exists(pathVideo + text2 + num.ToString("D4") + ".mp4") && num < 9999)
			{
				num++;
			}
			if (num < 9999)
			{
				string text3 = pathVideo + text2 + num.ToString("D4") + ".mp4";
				File.Move(text, text3);
				text = text3;
			}
		}
		catch (Exception ex)
		{
			Debug.LogWarning("video move failed : " + ex.ToString());
		}
		Debug.Log("video recorded to " + text.ToString());
		GetComponent<gameScript>().EncodeFinish(text);
	}
}
