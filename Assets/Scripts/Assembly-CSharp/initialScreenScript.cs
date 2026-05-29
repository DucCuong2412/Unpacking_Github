using System;
using System.Collections;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.Video;

public class initialScreenScript : MonoBehaviour
{
    public SoundbankLoadScript m_mainSoundbank;

    private VideoPlayer m_video;

    public Renderer m_quad;

    private bool m_videoPlaying = true;

    private bool m_audioTrigger;

    public SpriteRenderer m_logo;

    public GameObject m_loading;

    public Color[] m_colorFade;

    private AsyncOperation m_mainMenuLoad;

    private float m_timer;

    private int m_sequence;

    private bool m_advance;

    public Texture2D m_cursor;

    private bool m_platformInitialised;

    private void Awake()
    {
        string[] commandLineArgs = Environment.GetCommandLineArgs();
        bool flag = false;
        bool flag2 = false;
        string[] array = commandLineArgs;
        foreach (string text in array)
        {
            if (text.ToLower().EndsWith("safe"))
            {
                Screen.SetResolution(1280, 720, fullscreen: false);
            }
            else if (text.ToLower().EndsWith("exclusive"))
            {
                flag = true;
            }
            else if (text.ToLower().EndsWith("uncapped"))
            {
                flag2 = true;
            }
        }
        if (Screen.fullScreen)
        {
            Screen.fullScreenMode = ((!flag) ? FullScreenMode.FullScreenWindow : FullScreenMode.ExclusiveFullScreen);
        }
        if (!flag2)
        {
            Application.targetFrameRate = 150;
        }
    }

    private void Start()
    {
        AkSoundEngine.SetState("Recording_State", "False");
        m_video = GetComponent<VideoPlayer>();
        m_logo.enabled = false;
        m_logo.color = m_colorFade[0];
        Cursor.visible = false;
        StartCoroutine(StartLoad());
    }

    private IEnumerator StartLoad()
    {
        yield return null;
        yield return new WaitForSeconds(0.1f);
        m_platformInitialised = true;
        AkSoundEngine.SetRTPCValue("volume_master", PlayerPrefs.GetFloat("volume_master", 1f));
        AkSoundEngine.SetRTPCValue("volume_sfx", PlayerPrefs.GetFloat("volume_sfx", 1f));
        AkSoundEngine.SetRTPCValue("volume_music", PlayerPrefs.GetFloat("volume_music", 1f));
        AkSoundEngine.SetRTPCValue("volume_controller", PlayerPrefs.GetFloat("volume_controller", 1f));
        AkSoundEngine.SetState("Game_State", "gameplay");
        Debug.Log("Started loading main menu");
        AsyncOperation asyncLoad = SceneManager.LoadSceneAsync("title");
        asyncLoad.allowSceneActivation = m_advance;
        Debug.Log("Loading main menu");
        Debug.Log($"Load: {m_advance} {m_mainSoundbank.loaded}");
        while (!m_advance || !m_mainSoundbank.loaded)
        {
            Debug.Log($"whileLoad: {m_advance} {m_mainSoundbank.loaded}");
            yield return null;
        }
        asyncLoad.allowSceneActivation = true;
    }

    private void Update()
    {
        if (!m_platformInitialised)
        {
            return;
        }
        if (m_video.enabled)
        {
            if (m_videoPlaying)
            {
                if (m_video.frame >= (long)(m_video.frameCount - 30))
                {
                    m_videoPlaying = false;
                    m_timer = -0.5f;
                }
                else if (Input.anyKeyDown)
                {
                    m_videoPlaying = false;
                    m_timer = 0f;
                }
            }
            else
            {
                m_timer += Time.deltaTime;
                m_video.targetCameraAlpha = Mathf.InverseLerp(-0.05f, -0.5f, m_timer);
                if (m_timer >= 0f)
                {
                    m_timer = 0f;
                    m_video.enabled = false;
                    m_logo.enabled = true;
                }
            }
        }
        else
        {
            if (!m_platformInitialised)
            {
                return;
            }
            if (!m_audioTrigger)
            {
                AkSoundEngine.PostEvent("witchbeam_voice", base.gameObject);
                m_audioTrigger = true;
            }
            if (!m_advance && Input.anyKeyDown)
            {
                m_sequence = 2;
                m_timer = 1f;
            }
            if (m_sequence == 0)
            {
                m_timer += Time.deltaTime * 1.25f;
                m_logo.color = Color.Lerp(m_colorFade[0], m_colorFade[1], m_timer);
                if (m_timer >= 1f)
                {
                    if (m_advance)
                    {
                        m_timer = 2f;
                    }
                    else
                    {
                        m_timer = 0f;
                    }
                    m_sequence++;
                }
            }
            else if (m_sequence == 1)
            {
                m_timer += Time.deltaTime;
                if (m_timer >= 2.5f)
                {
                    m_timer = 0f;
                    m_sequence++;
                }
            }
            else if (m_sequence == 2)
            {
                m_timer += Time.deltaTime;
                m_logo.color = Color.Lerp(m_colorFade[1], m_colorFade[2], m_timer);
                if (m_timer >= 1f)
                {
                    m_sequence++;
                    m_logo.enabled = false;
                    m_advance = true;
                }
            }
            else if (m_sequence == 3)
            {
                m_sequence++;
                if (m_loading != null)
                {
                    m_loading.SetActive(value: true);
                }
            }
        }
    }
}
