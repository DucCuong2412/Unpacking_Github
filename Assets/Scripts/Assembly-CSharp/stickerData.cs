using System;
using UnityEngine;

[CreateAssetMenu(fileName = "stickers", menuName = "ScriptableObjects/stickerData", order = 3)]
public class stickerData : ScriptableObject
{
	[Serializable]
	public struct sticker
	{
		public string id;

		public Sprite sprite;

		public int page;

		public Vector2 position;
	}

	public sticker[] stickers;
}
