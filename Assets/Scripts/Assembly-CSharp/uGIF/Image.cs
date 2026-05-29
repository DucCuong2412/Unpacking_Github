using System;
using UnityEngine;

namespace uGIF
{
	public class Image
	{
		public int width;

		public int height;

		public Color32[] pixels;

		public Image(Texture2D f)
		{
			pixels = f.GetPixels32();
			width = f.width;
			height = f.height;
		}

		public Image(Image image)
		{
			pixels = image.pixels.Clone() as Color32[];
			width = image.width;
			height = image.height;
		}

		public Image(int width, int height)
		{
			this.width = width;
			this.height = height;
			pixels = new Color32[width * height];
		}

		public void DrawImage(Image image, int i, int i2)
		{
			throw new NotImplementedException();
		}

		public Color32 GetPixel(int tw, int th)
		{
			int num = th * width + tw;
			return pixels[num];
		}

		public void Flip()
		{
			for (int i = 0; i < height / 2; i++)
			{
				for (int j = 0; j < width; j++)
				{
					int num = i * width + j;
					int num2 = (height - i - 1) * width + j;
					Color32 color = pixels[num];
					pixels[num] = pixels[num2];
					pixels[num2] = color;
				}
			}
		}

		public void Resize(int scale)
		{
			if (scale <= 1)
			{
				return;
			}
			int num = width / scale;
			int num2 = height / scale;
			Color32[] array = new Color32[num * num2];
			for (int i = 0; i < num2; i++)
			{
				for (int j = 0; j < num; j++)
				{
					array[i * num + j] = pixels[i * scale * width + j * scale];
				}
			}
			pixels = array;
			height = num2;
			width = num;
		}

		public void ResizeBilinear(int newWidth, int newHeight)
		{
			if (newWidth == width && newHeight == height)
			{
				return;
			}
			Color32[] array = pixels;
			Color32[] array2 = new Color32[newWidth * newHeight];
			float num = 1f / ((float)newWidth / (float)(width - 1));
			float num2 = 1f / ((float)newHeight / (float)(height - 1));
			int num3 = width;
			for (int i = 0; i < newHeight; i++)
			{
				int num4 = Mathf.FloorToInt((float)i * num2);
				int num5 = num4 * num3;
				int num6 = (num4 + 1) * num3;
				int num7 = i * newWidth;
				for (int j = 0; j < newWidth; j++)
				{
					int num8 = (int)Mathf.Floor((float)j * num);
					float p = (float)j * num - (float)num8;
					array2[num7 + j] = ColorLerpUnclamped(ColorLerpUnclamped(array[num5 + num8], array[num5 + num8 + 1], p), ColorLerpUnclamped(array[num6 + num8], array[num6 + num8 + 1], p), (float)i * num2 - (float)num4);
				}
			}
			pixels = array2;
			height = newHeight;
			width = newWidth;
		}

		private Color32 ColorLerpUnclamped(Color A, Color B, float P)
		{
			return new Color(A.r + (B.r - A.r) * P, A.g + (B.g - A.g) * P, A.b + (B.b - A.b) * P, A.a + (B.a - A.a) * P);
		}
	}
}
