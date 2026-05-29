using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Threading;
using UnityEngine;

namespace uGIF
{
	public class capture : MonoBehaviour
	{
		private bool m_captureNextFrame;

		private List<Image> frames = new List<Image>();

		private float m_framerate = 15f;

		[NonSerialized]
		public byte[] bytes;

		public void CaptureNext()
		{
			m_captureNextFrame = true;
		}

		public void OnPostRender()
		{
			if (m_captureNextFrame)
			{
				CaptureFrame();
				m_captureNextFrame = false;
			}
		}

		private void CaptureFrame()
		{
			int num = 800;
			int num2 = 800;
			RenderTexture temporary = RenderTexture.GetTemporary(1024, 1024, 24, RenderTextureFormat.Default);
			GameObject obj = new GameObject("captureCamera");
			Camera camera = obj.AddComponent<Camera>();
			camera.enabled = false;
			camera.CopyFrom(GetComponent<Camera>());
			camera.orthographicSize = 5.12f;
			camera.targetTexture = temporary;
			camera.Render();
			RenderTexture.active = temporary;
			Texture2D texture2D = new Texture2D(num, num2, TextureFormat.RGB24, mipChain: false);
			texture2D.ReadPixels(new Rect(512 - num / 2, 512 - num2 / 2, 512 + num / 2, 512 + num2 / 2), 0, 0);
			texture2D.Apply();
			RenderTexture.active = null;
			RenderTexture.ReleaseTemporary(temporary);
			UnityEngine.Object.Destroy(obj);
			frames.Add(new Image(texture2D));
			if (frames.Count > 900)
			{
				frames.RemoveAt(0);
			}
		}

		public void Encode(float _framerate)
		{
			m_framerate = _framerate;
			Debug.Log("Starting encode with " + frames.Count + " frames");
			bytes = null;
			new Thread(_Encode).Start();
			StartCoroutine(WaitForBytes());
		}

		private IEnumerator WaitForBytes()
		{
			while (bytes == null)
			{
				yield return null;
			}
			Debug.Log("Encode Complete, writing " + bytes.Length + " bytes");
			string pathGif = gameStateScript.GetPathGif();
			string text = null;
			try
			{
				if (!Directory.Exists(pathGif))
				{
					Directory.CreateDirectory(pathGif);
				}
				string text2 = DateTime.Now.ToString("yyyyMMdd_");
				int num = 1;
				while (File.Exists(pathGif + text2 + num.ToString("D4") + ".gif") && num < 9999)
				{
					num++;
				}
				if (num < 9999)
				{
					text = pathGif + text2 + num.ToString("D4") + ".gif";
					File.WriteAllBytes(text, bytes);
				}
			}
			catch (Exception ex)
			{
				Debug.LogWarning("screenshot failed : " + ex.ToString());
			}
			bytes = null;
			GetComponent<gameScript>().EncodeFinish(text);
		}

		private void _Encode()
		{
			GIFEncoder gIFEncoder = new GIFEncoder();
			gIFEncoder.useGlobalColorTable = true;
			gIFEncoder.repeat = 0;
			gIFEncoder.FPS = m_framerate;
			gIFEncoder.transparent = new Color32(0, byte.MaxValue, 0, byte.MaxValue);
			gIFEncoder.dispose = 1;
			gIFEncoder.quality = 1;
			MemoryStream memoryStream = new MemoryStream();
			gIFEncoder.Start(memoryStream);
			gIFEncoder.UseFrameForPalette(frames[frames.Count - 1]);
			foreach (Image frame in frames)
			{
				frame.Flip();
				gIFEncoder.AddFrame(frame);
			}
			gIFEncoder.FPS = 0.75f;
			gIFEncoder.AddFrame(frames[frames.Count - 1]);
			gIFEncoder.Finish();
			bytes = memoryStream.GetBuffer();
			memoryStream.Close();
		}
	}
}
