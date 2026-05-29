using System;
using System.IO;
using UnityEngine;

namespace uGIF
{
	public class GIFEncoder
	{
		public bool useGlobalColorTable;

		public Color32? transparent;

		public int repeat = -1;

		public int dispose = -1;

		public int quality = 10;

		private int delay;

		private int width;

		private int height;

		private bool started;

		private MemoryStream ms;

		private Color32[] pixels;

		private byte[] indexedPixels;

		private byte[] prevIndexedPixels;

		private int colorDepth;

		private byte[] colorTab;

		private int palSize = 7;

		private bool firstFrame = true;

		private NeuQuant nq;

		public float FPS
		{
			set
			{
				delay = Mathf.RoundToInt(100f / value);
			}
		}

		public void UseFrameForPalette(Image im)
		{
			width = im.width;
			height = im.height;
			pixels = im.pixels;
			RemapPixels();
			pixels = null;
			prevIndexedPixels = null;
			WriteLSD();
			WritePalette();
			if (repeat >= 0)
			{
				WriteNetscapeExt();
			}
			firstFrame = false;
		}

		public void AddFrame(Image im)
		{
			if (im == null)
			{
				throw new ArgumentNullException("im");
			}
			if (!started)
			{
				throw new InvalidOperationException("Start() must be called before AddFrame()");
			}
			if (firstFrame)
			{
				width = im.width;
				height = im.height;
			}
			pixels = im.pixels;
			RemapPixels();
			pixels = null;
			if (firstFrame)
			{
				WriteLSD();
				WritePalette();
				if (repeat >= 0)
				{
					WriteNetscapeExt();
				}
			}
			WriteGraphicCtrlExt();
			WriteImageDesc();
			if (!firstFrame && !useGlobalColorTable)
			{
				WritePalette();
			}
			WritePixels();
			firstFrame = false;
		}

		public void Finish()
		{
			if (!started)
			{
				throw new InvalidOperationException("Start() must be called before Finish()");
			}
			started = false;
			ms.WriteByte(59);
			ms.Flush();
			pixels = null;
			indexedPixels = null;
			prevIndexedPixels = null;
			colorTab = null;
			firstFrame = true;
			nq = null;
		}

		public void Start(MemoryStream os)
		{
			if (os == null)
			{
				throw new ArgumentNullException("os");
			}
			ms = os;
			started = true;
			WriteString("GIF89a");
		}

		private void RemapPixels()
		{
			int num = pixels.Length;
			indexedPixels = new byte[num];
			if (firstFrame || !useGlobalColorTable)
			{
				nq = new NeuQuant(pixels, num, quality);
				colorTab = nq.Process();
			}
			for (int i = 0; i < num; i++)
			{
				int num2 = nq.Map(pixels[i].r & 0xFF, pixels[i].g & 0xFF, pixels[i].b & 0xFF);
				indexedPixels[i] = (byte)num2;
				if (dispose == 1 && prevIndexedPixels != null)
				{
					if (indexedPixels[i] == prevIndexedPixels[i])
					{
						indexedPixels[i] = byte.MaxValue;
					}
					else
					{
						prevIndexedPixels[i] = (byte)num2;
					}
				}
			}
			colorDepth = 8;
			palSize = 7;
			if (dispose == 1 && prevIndexedPixels == null)
			{
				prevIndexedPixels = indexedPixels.Clone() as byte[];
			}
		}

		private void WriteGraphicCtrlExt()
		{
			ms.WriteByte(33);
			ms.WriteByte(249);
			ms.WriteByte(4);
			int num;
			int num2;
			if (!transparent.HasValue)
			{
				num = 0;
				num2 = 0;
			}
			else
			{
				num = 1;
				num2 = 2;
			}
			if (dispose >= 0)
			{
				num2 = dispose & 7;
			}
			num2 <<= 2;
			ms.WriteByte(Convert.ToByte(0 | num2 | 0 | num));
			WriteShort(delay);
			ms.WriteByte(Convert.ToByte(255));
			ms.WriteByte(0);
		}

		private void WriteImageDesc()
		{
			ms.WriteByte(44);
			WriteShort(0);
			WriteShort(0);
			WriteShort(width);
			WriteShort(height);
			ms.WriteByte(0);
		}

		private void WriteLSD()
		{
			WriteShort(width);
			WriteShort(height);
			ms.WriteByte(Convert.ToByte(0xF0 | palSize));
			ms.WriteByte(0);
			ms.WriteByte(0);
		}

		private void WriteNetscapeExt()
		{
			ms.WriteByte(33);
			ms.WriteByte(byte.MaxValue);
			ms.WriteByte(11);
			WriteString("NETSCAPE2.0");
			ms.WriteByte(3);
			ms.WriteByte(1);
			WriteShort(repeat);
			ms.WriteByte(0);
		}

		private void WritePalette()
		{
			ms.Write(colorTab, 0, colorTab.Length);
			int num = 768 - colorTab.Length;
			for (int i = 0; i < num; i++)
			{
				ms.WriteByte(0);
			}
		}

		private void WritePixels()
		{
			new LZWEncoder(width, height, indexedPixels, colorDepth).Encode(ms);
		}

		private void WriteShort(int value)
		{
			ms.WriteByte(Convert.ToByte(value & 0xFF));
			ms.WriteByte(Convert.ToByte((value >> 8) & 0xFF));
		}

		private void WriteString(string s)
		{
			char[] array = s.ToCharArray();
			for (int i = 0; i < array.Length; i++)
			{
				ms.WriteByte((byte)array[i]);
			}
		}
	}
}
