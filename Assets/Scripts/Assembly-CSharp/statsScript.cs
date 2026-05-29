using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class statsScript : MonoBehaviour
{
	public enum specialEvents
	{
		puzzleCube = 0,
		tapeDeck = 1,
		alarmSet = 2,
		mannequinDab = 3,
		toiletFlush = 4,
		toiletRollReverse = 5,
		computerBoot = 6
	}

	public enum stickers
	{
		none = 0,
		initial = 1,
		sticker_brain = 2,
		sticker_music = 3,
		sticker_star = 4,
		sticker_dab = 5,
		sticker_cookie = 6,
		sticker_skeleton = 7,
		sticker_graduation = 8,
		sticker_gaming = 9,
		sticker_fashion = 10,
		sticker_roleplaying = 11,
		sticker_undies = 12,
		sticker_coffee = 13,
		sticker_guitar = 14,
		sticker_dog = 15,
		sticker_returningHome = 16,
		sticker_microwave = 17,
		sticker_lightbulb = 18,
		sticker_independence = 19,
		sticker_plant = 20,
		sticker_love = 21,
		sticker_blocks = 22,
		sticker_plushToys = 23,
		sticker_toilet = 24,
		sticker_house = 25
	}

	public enum unlocks
	{
		toilet_studioapt = 0,
		toilet_sharehouse = 1,
		toilet_boyfriendapt = 2,
		toilet_soloApt = 3,
		toilet_house1 = 4,
		toilet_house2 = 5
	}

	private Dictionary<specialEvents, bool> m_specialEvents = new Dictionary<specialEvents, bool>();

	private Dictionary<stickers, int> m_stickerMap = new Dictionary<stickers, int>();

	private int[] m_stickerInitial;

	private List<stickers> m_pendingAchievements = new List<stickers>();

	private static statsScript s_instance;

	private void Start()
	{
		s_instance = this;
		foreach (specialEvents value in Enum.GetValues(typeof(specialEvents)))
		{
			m_specialEvents.Add(value, PlayerPrefs.GetInt("special_" + value, 0) == 1);
		}
		stickerData stickerData2 = GetComponent<gameStateScript>().m_stickerData;
		foreach (stickers value2 in Enum.GetValues(typeof(stickers)))
		{
			for (int i = 0; i < stickerData2.stickers.Length; i++)
			{
				stickerData2.stickers[i].id.ToLowerInvariant();
				if (value2.ToString().ToLowerInvariant().Equals(stickerData2.stickers[i].id.ToLowerInvariant()))
				{
					m_stickerMap.Add(value2, i);
					break;
				}
			}
		}
		List<int> list = new List<int>();
		for (int j = 0; j < stickerData2.stickers.Length; j++)
		{
			string text = stickerData2.stickers[j].id.ToLowerInvariant();
			if (text.Equals("sticker_exclaim") || text.Equals("sticker_thumbsup") || text.Equals("sticker_hearts"))
			{
				list.Add(j);
			}
		}
		m_stickerInitial = list.ToArray();
	}

	public static bool AwardSticker(stickers _sticker)
	{
		return AwardSticker(_sticker, _albumUnlock: false);
	}

	public static bool AwardSticker(stickers _sticker, bool _albumUnlock)
	{
		if (s_instance == null)
		{
			return false;
		}
		bool num = s_instance.AwardStickerInternal(_sticker, _albumUnlock);
		if (num)
		{
			if (_sticker == stickers.initial)
			{
				s_instance.m_pendingAchievements.Insert(0, _sticker);
				return num;
			}
			s_instance.m_pendingAchievements.Add(_sticker);
		}
		return num;
	}

	private bool AwardStickerInternal(stickers _sticker, bool _albumUnlock)
	{
		if (_sticker == stickers.initial)
		{
			if (saveData.UnlockSticker(s_instance.m_stickerInitial))
			{
				gameScript gameScript2 = UnityEngine.Object.FindObjectOfType<gameScript>();
				if (gameScript2 != null)
				{
					gameScript2.EnablePhotomode();
					return true;
				}
			}
		}
		else if (s_instance.m_stickerMap.ContainsKey(_sticker) && saveData.UnlockSticker(s_instance.m_stickerMap[_sticker]))
		{
			stickerData.sticker sticker = s_instance.GetComponent<gameStateScript>().m_stickerData.stickers[s_instance.m_stickerMap[_sticker]];
			if (_albumUnlock)
			{
				gameStateScript.SetStickerUnlock(sticker.sprite);
				return true;
			}
			gameScript gameScript3 = UnityEngine.Object.FindObjectOfType<gameScript>();
			if (gameScript3 != null)
			{
				gameScript3.UnlockSticker(sticker.sprite, sticker.page);
				return true;
			}
		}
		return false;
	}

	public static void StickerAwardEffectAll()
	{
		if (!(s_instance == null) && s_instance.m_pendingAchievements.Count != 0)
		{
			s_instance.AwardAllNow();
		}
	}

	private void AwardAllNow()
	{
		StopAllCoroutines();
		for (int i = 0; i < m_pendingAchievements.Count; i++)
		{
			GogGalaxyManager.Instance.StatsAndAchievements.SetAchievement(m_pendingAchievements[i].ToString());
		}
		m_pendingAchievements.Clear();
	}

	public static void StickerAwardEffect()
	{
		if (!(s_instance == null))
		{
			s_instance.StartDelayAward();
		}
	}

	private void StartDelayAward()
	{
		StartCoroutine(DelayAward());
	}

	private IEnumerator DelayAward()
	{
		yield return new WaitForSeconds(0.5f);
		if (m_pendingAchievements.Count > 0)
		{
			GogGalaxyManager.Instance.StatsAndAchievements.SetAchievement(m_pendingAchievements[0].ToString());
			m_pendingAchievements.RemoveAt(0);
		}
	}

	public static void ToiletFlush(unlocks _toilet)
	{
		if (_toilet <= unlocks.toilet_house2)
		{
			saveData.SetUnlock((int)_toilet);
			if (saveData.CheckUnlock(new int[6] { 0, 1, 2, 3, 4, 5 }))
			{
				AwardSticker(stickers.sticker_toilet);
			}
		}
	}

	public static void SpecialEvent(specialEvents _event)
	{
	}
}
