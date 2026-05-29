using System;
using UnityEngine;

[CreateAssetMenu(fileName = "Language", menuName = "ScriptableObjects/languageData", order = 2)]
public class languageData : ScriptableObject
{
	public enum languageId
	{
		en_US = 0,
		fr_FR = 1,
		de_DE = 2,
		es_LATAM = 3,
		ja_JP = 4,
		zh_CN = 5,
		zh_TW = 6,
		ru_RU = 7,
		ko_KR = 8,
		pt_BR = 9,
		pl_PL = 10,
		fil_PH = 11,
		id_ID = 12,
		it_IT = 13,
		ms_MY = 14,
		tr_TR = 15
	}

	[Serializable]
	public struct stringData
	{
		public string id;

		public string text;

		public stringData(string _id, string _text)
		{
			id = _id;
			text = _text;
		}
	}

	public stringData[] stringList;
}
