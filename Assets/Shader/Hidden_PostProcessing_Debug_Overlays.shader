Shader "Hidden/PostProcessing/Debug/Overlays"
{
	Properties
	{
	}
	SubShader
	{
		Pass
		{
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 53588

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.0


			float _RenderViewportScaleFactor;

			static float4 vertex_uniform_buffer_0[27];
			static float4 gl_Position;
			static float3 vertex_input_0;
			static float2 vertex_output_1;
			static float2 vertex_output_1;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				float2 vertex_output_1 : TEXCOORD1; // TEXCOORD_1
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				gl_Position.x = vertex_input_0.x;
				gl_Position.y = vertex_input_0.y;
				gl_Position.z = 0.0f;
				gl_Position.w = 1.0f;
				precise float vertex_unnamed_42 = vertex_input_0.x + 1.0f;
				precise float vertex_unnamed_43 = vertex_input_0.y + 1.0f;
				precise float vertex_unnamed_54 = mad(vertex_unnamed_42, 0.5f, 0.0f) * vertex_uniform_buffer_0[26u].x;
				precise float vertex_unnamed_55 = mad(vertex_unnamed_43, -0.5f, 1.0f) * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.x = vertex_unnamed_54;
				vertex_output_1.y = vertex_unnamed_55;
				vertex_output_1.x = mad(vertex_input_0.x, 0.5f, 0.5f);
				vertex_output_1.y = mad(vertex_input_0.y, -0.5f, 0.5f);
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, vertex_uniform_buffer_0[26][1], vertex_uniform_buffer_0[26][2], vertex_uniform_buffer_0[26][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}


			float _RenderViewportScaleFactor;

			static float4 gl_Position;
			static float3 vertex_input_0;
			static float2 vertex_output_0;
			static float2 vertex_output_1;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION;
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_0 : TEXCOORD1; // vs_TEXCOORD1
				float2 vertex_output_1 : TEXCOORD0; // vs_TEXCOORD0
				float4 gl_Position : SV_Position;
			};

			static float2 vertex_unnamed_33;

			void vert_main()
			{
				gl_Position = float4(vertex_input_0.xy.x, vertex_input_0.xy.y, gl_Position.z, gl_Position.w);
				gl_Position = float4(gl_Position.x, gl_Position.y, float2(0.0f, 1.0f).x, float2(0.0f, 1.0f).y);
				vertex_unnamed_33 = vertex_input_0.xy + 1.0f.xx;
				vertex_unnamed_33 = (vertex_unnamed_33 * float2(0.5f, -0.5f)) + float2(0.0f, 1.0f);
				vertex_output_0 = vertex_unnamed_33 * _RenderViewportScaleFactor.xx;
				vertex_output_1 = (vertex_input_0.xy * float2(0.5f, -0.5f)) + 0.5f.xx;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_0 = vertex_output_0;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}

			float4 unity_OrthoParams;
			float4 _ZBufferParams;
			float4 _Params;

			Texture2D<float4> _CameraDepthTexture;
			SamplerState sampler_CameraDepthTexture;

			static float2 fragment_input_0;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_0 : TEXCOORD1; // vs_TEXCOORD1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static float fragment_unnamed_8;
			static float fragment_unnamed_23;
			static float fragment_unnamed_42;

			void frag_main()
			{
				fragment_unnamed_8 = (-unity_OrthoParams.w) + 1.0f;
				fragment_unnamed_23 = _CameraDepthTexture.SampleLevel(sampler_CameraDepthTexture, fragment_input_0, 0.0f).x;
				fragment_unnamed_42 = fragment_unnamed_23 * _ZBufferParams.x;
				fragment_unnamed_8 = (fragment_unnamed_8 * fragment_unnamed_42) + _ZBufferParams.y;
				fragment_unnamed_42 = ((-unity_OrthoParams.w) * fragment_unnamed_42) + 1.0f;
				fragment_unnamed_8 = fragment_unnamed_42 / fragment_unnamed_8;
				fragment_unnamed_8 = (-fragment_unnamed_23) + fragment_unnamed_8;
				float3 fragment_unnamed_81 = (_Params.xxx * fragment_unnamed_8.xxx) + fragment_unnamed_23.xxx;
				fragment_output_0 = float4(fragment_unnamed_81.x, fragment_unnamed_81.y, fragment_unnamed_81.z, fragment_output_0.w);
				fragment_output_0.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_0 = stage_input.fragment_input_0;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			float4 unity_OrthoParams;
			float4 _ZBufferParams;
			float4 _Params;

			static float4 fragment_uniform_buffer_0[30];
			Texture2D<float4> _CameraDepthTexture;
			SamplerState sampler_CameraDepthTexture;

			static float2 fragment_input_1;
			static float2 fragment_input_1;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD; // TEXCOORD
				float2 fragment_input_1 : TEXCOORD1; // TEXCOORD_1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				precise float fragment_unnamed_35 = (-0.0f) - fragment_uniform_buffer_0[20u].w;
				precise float fragment_unnamed_37 = fragment_unnamed_35 + 1.0f;
				float4 fragment_unnamed_48 = _CameraDepthTexture.SampleLevel(sampler_CameraDepthTexture, float2(fragment_input_1.x, fragment_input_1.y), 0.0f);
				float fragment_unnamed_50 = fragment_unnamed_48.x;
				precise float fragment_unnamed_55 = fragment_unnamed_50 * fragment_uniform_buffer_0[21u].x;
				precise float fragment_unnamed_64 = (-0.0f) - fragment_uniform_buffer_0[20u].w;
				precise float fragment_unnamed_66 = mad(fragment_unnamed_64, fragment_unnamed_55, 1.0f) / mad(fragment_unnamed_37, fragment_unnamed_55, fragment_uniform_buffer_0[21u].y);
				precise float fragment_unnamed_67 = (-0.0f) - fragment_unnamed_50;
				precise float fragment_unnamed_68 = fragment_unnamed_67 + fragment_unnamed_66;
				fragment_output_0.x = mad(fragment_uniform_buffer_0[29u].x, fragment_unnamed_68, fragment_unnamed_50);
				fragment_output_0.y = mad(fragment_uniform_buffer_0[29u].x, fragment_unnamed_68, fragment_unnamed_50);
				fragment_output_0.z = mad(fragment_uniform_buffer_0[29u].x, fragment_unnamed_68, fragment_unnamed_50);
				fragment_output_0.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[20] = float4(unity_OrthoParams[0], unity_OrthoParams[1], unity_OrthoParams[2], unity_OrthoParams[3]);

				fragment_uniform_buffer_0[21] = float4(_ZBufferParams[0], _ZBufferParams[1], _ZBufferParams[2], _ZBufferParams[3]);

				fragment_uniform_buffer_0[29] = float4(_Params[0], _Params[1], _Params[2], _Params[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			ENDHLSL
		}
		Pass
		{
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 91834

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.0
			#pragma multi_compile _ SOURCE_GBUFFER


			#ifndef SOURCE_GBUFFER
			#define ANY_SHADER_VARIANT_ACTIVE

			float _RenderViewportScaleFactor;

			static float4 vertex_uniform_buffer_0[27];
			static float4 gl_Position;
			static float3 vertex_input_0;
			static float2 vertex_output_1;
			static float2 vertex_output_1;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				float2 vertex_output_1 : TEXCOORD1; // TEXCOORD_1
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				gl_Position.x = vertex_input_0.x;
				gl_Position.y = vertex_input_0.y;
				gl_Position.z = 0.0f;
				gl_Position.w = 1.0f;
				precise float vertex_unnamed_42 = vertex_input_0.x + 1.0f;
				precise float vertex_unnamed_43 = vertex_input_0.y + 1.0f;
				precise float vertex_unnamed_54 = mad(vertex_unnamed_42, 0.5f, 0.0f) * vertex_uniform_buffer_0[26u].x;
				precise float vertex_unnamed_55 = mad(vertex_unnamed_43, -0.5f, 1.0f) * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.x = vertex_unnamed_54;
				vertex_output_1.y = vertex_unnamed_55;
				vertex_output_1.x = mad(vertex_input_0.x, 0.5f, 0.5f);
				vertex_output_1.y = mad(vertex_input_0.y, -0.5f, 0.5f);
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, vertex_uniform_buffer_0[26][1], vertex_uniform_buffer_0[26][2], vertex_uniform_buffer_0[26][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}

			#endif // !SOURCE_GBUFFER


			#ifdef SOURCE_GBUFFER
			#define ANY_SHADER_VARIANT_ACTIVE

			float _RenderViewportScaleFactor;

			static float4 vertex_uniform_buffer_0[27];
			static float4 gl_Position;
			static float3 vertex_input_0;
			static float2 vertex_output_1;
			static float2 vertex_output_1;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				float2 vertex_output_1 : TEXCOORD1; // TEXCOORD_1
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				gl_Position.x = vertex_input_0.x;
				gl_Position.y = vertex_input_0.y;
				gl_Position.z = 0.0f;
				gl_Position.w = 1.0f;
				precise float vertex_unnamed_42 = vertex_input_0.x + 1.0f;
				precise float vertex_unnamed_43 = vertex_input_0.y + 1.0f;
				precise float vertex_unnamed_54 = mad(vertex_unnamed_42, 0.5f, 0.0f) * vertex_uniform_buffer_0[26u].x;
				precise float vertex_unnamed_55 = mad(vertex_unnamed_43, -0.5f, 1.0f) * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.x = vertex_unnamed_54;
				vertex_output_1.y = vertex_unnamed_55;
				vertex_output_1.x = mad(vertex_input_0.x, 0.5f, 0.5f);
				vertex_output_1.y = mad(vertex_input_0.y, -0.5f, 0.5f);
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, vertex_uniform_buffer_0[26][1], vertex_uniform_buffer_0[26][2], vertex_uniform_buffer_0[26][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}

			#endif // SOURCE_GBUFFER


			#ifndef SOURCE_GBUFFER
			#define ANY_SHADER_VARIANT_ACTIVE

			float _RenderViewportScaleFactor;

			static float4 gl_Position;
			static float3 vertex_input_0;
			static float2 vertex_output_0;
			static float2 vertex_output_1;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION;
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_0 : TEXCOORD1; // vs_TEXCOORD1
				float2 vertex_output_1 : TEXCOORD0; // vs_TEXCOORD0
				float4 gl_Position : SV_Position;
			};

			static float2 vertex_unnamed_33;

			void vert_main()
			{
				gl_Position = float4(vertex_input_0.xy.x, vertex_input_0.xy.y, gl_Position.z, gl_Position.w);
				gl_Position = float4(gl_Position.x, gl_Position.y, float2(0.0f, 1.0f).x, float2(0.0f, 1.0f).y);
				vertex_unnamed_33 = vertex_input_0.xy + 1.0f.xx;
				vertex_unnamed_33 = (vertex_unnamed_33 * float2(0.5f, -0.5f)) + float2(0.0f, 1.0f);
				vertex_output_0 = vertex_unnamed_33 * _RenderViewportScaleFactor.xx;
				vertex_output_1 = (vertex_input_0.xy * float2(0.5f, -0.5f)) + 0.5f.xx;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_0 = vertex_output_0;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}

			Texture2D<float4> _CameraDepthNormalsTexture;
			SamplerState sampler_CameraDepthNormalsTexture;

			static float2 fragment_input_0;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_0 : TEXCOORD1; // vs_TEXCOORD1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static float3 fragment_unnamed_9;
			static float fragment_unnamed_37;
			static float3 fragment_unnamed_44;
			static float3 fragment_unnamed_66;
			static bool3 fragment_unnamed_75;

			void frag_main()
			{
				fragment_unnamed_9 = _CameraDepthNormalsTexture.Sample(sampler_CameraDepthNormalsTexture, fragment_input_0).xyz;
				fragment_unnamed_9 = (fragment_unnamed_9 * float3(3.55539989471435546875f, 3.55539989471435546875f, 0.0f)) + float3(-1.777699947357177734375f, -1.777699947357177734375f, 1.0f);
				fragment_unnamed_37 = dot(fragment_unnamed_9, fragment_unnamed_9);
				fragment_unnamed_37 = 2.0f / fragment_unnamed_37;
				float2 fragment_unnamed_49 = fragment_unnamed_9.xy * fragment_unnamed_37.xx;
				fragment_unnamed_44 = float3(fragment_unnamed_49.x, fragment_unnamed_49.y, fragment_unnamed_44.z);
				fragment_unnamed_44.z = fragment_unnamed_37 + (-1.0f);
				fragment_unnamed_9 = fragment_unnamed_44 * float3(1.0f, 1.0f, -1.0f);
				fragment_unnamed_44 *= float3(12.9200000762939453125f, 12.9200000762939453125f, -12.9200000762939453125f);
				fragment_unnamed_66 = max(abs(fragment_unnamed_9), 1.1920928955078125e-07f.xxx);
				fragment_unnamed_75 = bool4(float4(0.003130800090730190277099609375f, 0.003130800090730190277099609375f, 0.003130800090730190277099609375f, 0.0f).x >= fragment_unnamed_9.xyzx.x, float4(0.003130800090730190277099609375f, 0.003130800090730190277099609375f, 0.003130800090730190277099609375f, 0.0f).y >= fragment_unnamed_9.xyzx.y, float4(0.003130800090730190277099609375f, 0.003130800090730190277099609375f, 0.003130800090730190277099609375f, 0.0f).z >= fragment_unnamed_9.xyzx.z, float4(0.003130800090730190277099609375f, 0.003130800090730190277099609375f, 0.003130800090730190277099609375f, 0.0f).w >= fragment_unnamed_9.xyzx.w).xyz;
				fragment_unnamed_66 = log2(fragment_unnamed_66);
				fragment_unnamed_66 *= 0.4166666567325592041015625f.xxx;
				fragment_unnamed_66 = exp2(fragment_unnamed_66);
				fragment_unnamed_66 = (fragment_unnamed_66 * 1.05499994754791259765625f.xxx) + (-0.054999999701976776123046875f).xxx;
				float fragment_unnamed_105;
				if (fragment_unnamed_75.x)
				{
					fragment_unnamed_105 = fragment_unnamed_44.x;
				}
				else
				{
					fragment_unnamed_105 = fragment_unnamed_66.x;
				}
				fragment_output_0.x = fragment_unnamed_105;
				float fragment_unnamed_119;
				if (fragment_unnamed_75.y)
				{
					fragment_unnamed_119 = fragment_unnamed_44.y;
				}
				else
				{
					fragment_unnamed_119 = fragment_unnamed_66.y;
				}
				fragment_output_0.y = fragment_unnamed_119;
				float fragment_unnamed_131;
				if (fragment_unnamed_75.z)
				{
					fragment_unnamed_131 = fragment_unnamed_44.z;
				}
				else
				{
					fragment_unnamed_131 = fragment_unnamed_66.z;
				}
				fragment_output_0.z = fragment_unnamed_131;
				fragment_output_0.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_0 = stage_input.fragment_input_0;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // !SOURCE_GBUFFER


			#ifdef SOURCE_GBUFFER
			#define ANY_SHADER_VARIANT_ACTIVE

			float _RenderViewportScaleFactor;

			static float4 gl_Position;
			static float3 vertex_input_0;
			static float2 vertex_output_0;
			static float2 vertex_output_1;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION;
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_0 : TEXCOORD1; // vs_TEXCOORD1
				float2 vertex_output_1 : TEXCOORD0; // vs_TEXCOORD0
				float4 gl_Position : SV_Position;
			};

			static float2 vertex_unnamed_33;

			void vert_main()
			{
				gl_Position = float4(vertex_input_0.xy.x, vertex_input_0.xy.y, gl_Position.z, gl_Position.w);
				gl_Position = float4(gl_Position.x, gl_Position.y, float2(0.0f, 1.0f).x, float2(0.0f, 1.0f).y);
				vertex_unnamed_33 = vertex_input_0.xy + 1.0f.xx;
				vertex_unnamed_33 = (vertex_unnamed_33 * float2(0.5f, -0.5f)) + float2(0.0f, 1.0f);
				vertex_output_0 = vertex_unnamed_33 * _RenderViewportScaleFactor.xx;
				vertex_output_1 = (vertex_input_0.xy * float2(0.5f, -0.5f)) + 0.5f.xx;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_0 = vertex_output_0;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}

			float4x4 unity_WorldToCamera;

			static float4 fragment_uniform_buffer_0[4];
			Texture2D<float4> _CameraGBufferTexture2;
			SamplerState sampler_CameraGBufferTexture2;

			static float2 fragment_input_0;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_0 : TEXCOORD1; // vs_TEXCOORD1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static float4 fragment_unnamed_9;
			static float3 fragment_unnamed_40;
			static float3 fragment_unnamed_100;
			static bool3 fragment_unnamed_109;

			void frag_main()
			{
				float3 fragment_unnamed_26 = _CameraGBufferTexture2.Sample(sampler_CameraGBufferTexture2, fragment_input_0).xyz;
				fragment_unnamed_9 = float4(fragment_unnamed_26.x, fragment_unnamed_26.y, fragment_unnamed_26.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_36 = (fragment_unnamed_9.xyz * 2.0f.xxx) + (-1.0f).xxx;
				fragment_unnamed_9 = float4(fragment_unnamed_36.x, fragment_unnamed_36.y, fragment_unnamed_36.z, fragment_unnamed_9.w);
				fragment_unnamed_40 = fragment_unnamed_9.yyy * fragment_uniform_buffer_0[1].xyz;
				float3 fragment_unnamed_64 = (fragment_uniform_buffer_0[0].xyz * fragment_unnamed_9.xxx) + fragment_unnamed_40;
				fragment_unnamed_9 = float4(fragment_unnamed_64.x, fragment_unnamed_64.y, fragment_unnamed_9.z, fragment_unnamed_64.z);
				float3 fragment_unnamed_76 = (fragment_uniform_buffer_0[2].xyz * fragment_unnamed_9.zzz) + fragment_unnamed_9.xyw;
				fragment_unnamed_9 = float4(fragment_unnamed_76.x, fragment_unnamed_76.y, fragment_unnamed_76.z, fragment_unnamed_9.w);
				fragment_unnamed_40 = max(abs(fragment_unnamed_9.xyz), 1.1920928955078125e-07f.xxx);
				fragment_unnamed_40 = log2(fragment_unnamed_40);
				fragment_unnamed_40 *= 0.4166666567325592041015625f.xxx;
				fragment_unnamed_40 = exp2(fragment_unnamed_40);
				fragment_unnamed_40 = (fragment_unnamed_40 * 1.05499994754791259765625f.xxx) + (-0.054999999701976776123046875f).xxx;
				fragment_unnamed_100 = fragment_unnamed_9.xyz * 12.9200000762939453125f.xxx;
				fragment_unnamed_109 = bool4(float4(0.003130800090730190277099609375f, 0.003130800090730190277099609375f, 0.003130800090730190277099609375f, 0.0f).x >= fragment_unnamed_9.xyzx.x, float4(0.003130800090730190277099609375f, 0.003130800090730190277099609375f, 0.003130800090730190277099609375f, 0.0f).y >= fragment_unnamed_9.xyzx.y, float4(0.003130800090730190277099609375f, 0.003130800090730190277099609375f, 0.003130800090730190277099609375f, 0.0f).z >= fragment_unnamed_9.xyzx.z, float4(0.003130800090730190277099609375f, 0.003130800090730190277099609375f, 0.003130800090730190277099609375f, 0.0f).w >= fragment_unnamed_9.xyzx.w).xyz;
				float fragment_unnamed_125;
				if (fragment_unnamed_109.x)
				{
					fragment_unnamed_125 = fragment_unnamed_100.x;
				}
				else
				{
					fragment_unnamed_125 = fragment_unnamed_40.x;
				}
				fragment_output_0.x = fragment_unnamed_125;
				float fragment_unnamed_140;
				if (fragment_unnamed_109.y)
				{
					fragment_unnamed_140 = fragment_unnamed_100.y;
				}
				else
				{
					fragment_unnamed_140 = fragment_unnamed_40.y;
				}
				fragment_output_0.y = fragment_unnamed_140;
				float fragment_unnamed_153;
				if (fragment_unnamed_109.z)
				{
					fragment_unnamed_153 = fragment_unnamed_100.z;
				}
				else
				{
					fragment_unnamed_153 = fragment_unnamed_40.z;
				}
				fragment_output_0.z = fragment_unnamed_153;
				fragment_output_0.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[0] = float4(unity_WorldToCamera[0][0], unity_WorldToCamera[1][0], unity_WorldToCamera[2][0], unity_WorldToCamera[3][0]);
				fragment_uniform_buffer_0[1] = float4(unity_WorldToCamera[0][1], unity_WorldToCamera[1][1], unity_WorldToCamera[2][1], unity_WorldToCamera[3][1]);
				fragment_uniform_buffer_0[2] = float4(unity_WorldToCamera[0][2], unity_WorldToCamera[1][2], unity_WorldToCamera[2][2], unity_WorldToCamera[3][2]);
				fragment_uniform_buffer_0[3] = float4(unity_WorldToCamera[0][3], unity_WorldToCamera[1][3], unity_WorldToCamera[2][3], unity_WorldToCamera[3][3]);

				fragment_input_0 = stage_input.fragment_input_0;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // SOURCE_GBUFFER


			#ifndef SOURCE_GBUFFER
			#define ANY_SHADER_VARIANT_ACTIVE

			Texture2D<float4> _CameraDepthNormalsTexture;
			SamplerState sampler_CameraDepthNormalsTexture;

			static float2 fragment_input_1;
			static float2 fragment_input_1;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD; // TEXCOORD
				float2 fragment_input_1 : TEXCOORD1; // TEXCOORD_1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				float4 fragment_unnamed_34 = _CameraDepthNormalsTexture.Sample(sampler_CameraDepthNormalsTexture, float2(fragment_input_1.x, fragment_input_1.y));
				float fragment_unnamed_40 = mad(fragment_unnamed_34.x, 3.55539989471435546875f, -1.777699947357177734375f);
				float fragment_unnamed_43 = mad(fragment_unnamed_34.y, 3.55539989471435546875f, -1.777699947357177734375f);
				float fragment_unnamed_44 = mad(fragment_unnamed_34.z, 0.0f, 1.0f);
				precise float fragment_unnamed_50 = 2.0f / dot(float3(fragment_unnamed_40, fragment_unnamed_43, fragment_unnamed_44), float3(fragment_unnamed_40, fragment_unnamed_43, fragment_unnamed_44));
				precise float fragment_unnamed_52 = fragment_unnamed_40 * fragment_unnamed_50;
				precise float fragment_unnamed_53 = fragment_unnamed_43 * fragment_unnamed_50;
				precise float fragment_unnamed_54 = fragment_unnamed_50 + (-1.0f);
				precise float fragment_unnamed_56 = fragment_unnamed_52 * 1.0f;
				precise float fragment_unnamed_57 = fragment_unnamed_53 * 1.0f;
				precise float fragment_unnamed_58 = fragment_unnamed_54 * (-1.0f);
				precise float fragment_unnamed_59 = fragment_unnamed_52 * 12.9200000762939453125f;
				precise float fragment_unnamed_61 = fragment_unnamed_53 * 12.9200000762939453125f;
				precise float fragment_unnamed_62 = fragment_unnamed_54 * (-12.9200000762939453125f);
				precise float fragment_unnamed_79 = log2(max(abs(fragment_unnamed_56), 1.1920928955078125e-07f)) * 0.4166666567325592041015625f;
				precise float fragment_unnamed_81 = log2(max(abs(fragment_unnamed_57), 1.1920928955078125e-07f)) * 0.4166666567325592041015625f;
				precise float fragment_unnamed_82 = log2(max(abs(fragment_unnamed_58), 1.1920928955078125e-07f)) * 0.4166666567325592041015625f;
				fragment_output_0.x = (0.003130800090730190277099609375f >= fragment_unnamed_56) ? fragment_unnamed_59 : mad(exp2(fragment_unnamed_79), 1.05499994754791259765625f, -0.054999999701976776123046875f);
				fragment_output_0.y = (0.003130800090730190277099609375f >= fragment_unnamed_57) ? fragment_unnamed_61 : mad(exp2(fragment_unnamed_81), 1.05499994754791259765625f, -0.054999999701976776123046875f);
				fragment_output_0.z = (0.003130800090730190277099609375f >= fragment_unnamed_58) ? fragment_unnamed_62 : mad(exp2(fragment_unnamed_82), 1.05499994754791259765625f, -0.054999999701976776123046875f);
				fragment_output_0.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // !SOURCE_GBUFFER


			#ifdef SOURCE_GBUFFER
			#define ANY_SHADER_VARIANT_ACTIVE

			float4x4 unity_WorldToCamera;

			static float4 fragment_uniform_buffer_0[16];
			Texture2D<float4> _CameraGBufferTexture2;
			SamplerState sampler_CameraGBufferTexture2;

			static float2 fragment_input_1;
			static float2 fragment_input_1;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD; // TEXCOORD
				float2 fragment_input_1 : TEXCOORD1; // TEXCOORD_1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				float4 fragment_unnamed_39 = _CameraGBufferTexture2.Sample(sampler_CameraGBufferTexture2, float2(fragment_input_1.x, fragment_input_1.y));
				float fragment_unnamed_45 = mad(fragment_unnamed_39.x, 2.0f, -1.0f);
				float fragment_unnamed_48 = mad(fragment_unnamed_39.y, 2.0f, -1.0f);
				float fragment_unnamed_49 = mad(fragment_unnamed_39.z, 2.0f, -1.0f);
				precise float fragment_unnamed_57 = fragment_unnamed_48 * fragment_uniform_buffer_0[13u].x;
				precise float fragment_unnamed_58 = fragment_unnamed_48 * fragment_uniform_buffer_0[13u].y;
				precise float fragment_unnamed_59 = fragment_unnamed_48 * fragment_uniform_buffer_0[13u].z;
				float fragment_unnamed_75 = mad(fragment_uniform_buffer_0[14u].x, fragment_unnamed_49, mad(fragment_uniform_buffer_0[12u].x, fragment_unnamed_45, fragment_unnamed_57));
				float fragment_unnamed_76 = mad(fragment_uniform_buffer_0[14u].y, fragment_unnamed_49, mad(fragment_uniform_buffer_0[12u].y, fragment_unnamed_45, fragment_unnamed_58));
				float fragment_unnamed_77 = mad(fragment_uniform_buffer_0[14u].z, fragment_unnamed_49, mad(fragment_uniform_buffer_0[12u].z, fragment_unnamed_45, fragment_unnamed_59));
				precise float fragment_unnamed_88 = log2(max(abs(fragment_unnamed_75), 1.1920928955078125e-07f)) * 0.4166666567325592041015625f;
				precise float fragment_unnamed_90 = log2(max(abs(fragment_unnamed_76), 1.1920928955078125e-07f)) * 0.4166666567325592041015625f;
				precise float fragment_unnamed_91 = log2(max(abs(fragment_unnamed_77), 1.1920928955078125e-07f)) * 0.4166666567325592041015625f;
				precise float fragment_unnamed_100 = fragment_unnamed_75 * 12.9200000762939453125f;
				precise float fragment_unnamed_102 = fragment_unnamed_76 * 12.9200000762939453125f;
				precise float fragment_unnamed_103 = fragment_unnamed_77 * 12.9200000762939453125f;
				fragment_output_0.x = (0.003130800090730190277099609375f >= fragment_unnamed_75) ? fragment_unnamed_100 : mad(exp2(fragment_unnamed_88), 1.05499994754791259765625f, -0.054999999701976776123046875f);
				fragment_output_0.y = (0.003130800090730190277099609375f >= fragment_unnamed_76) ? fragment_unnamed_102 : mad(exp2(fragment_unnamed_90), 1.05499994754791259765625f, -0.054999999701976776123046875f);
				fragment_output_0.z = (0.003130800090730190277099609375f >= fragment_unnamed_77) ? fragment_unnamed_103 : mad(exp2(fragment_unnamed_91), 1.05499994754791259765625f, -0.054999999701976776123046875f);
				fragment_output_0.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[12] = float4(unity_WorldToCamera[0][0], unity_WorldToCamera[1][0], unity_WorldToCamera[2][0], unity_WorldToCamera[3][0]);
				fragment_uniform_buffer_0[13] = float4(unity_WorldToCamera[0][1], unity_WorldToCamera[1][1], unity_WorldToCamera[2][1], unity_WorldToCamera[3][1]);
				fragment_uniform_buffer_0[14] = float4(unity_WorldToCamera[0][2], unity_WorldToCamera[1][2], unity_WorldToCamera[2][2], unity_WorldToCamera[3][2]);
				fragment_uniform_buffer_0[15] = float4(unity_WorldToCamera[0][3], unity_WorldToCamera[1][3], unity_WorldToCamera[2][3], unity_WorldToCamera[3][3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // SOURCE_GBUFFER


			ENDHLSL
		}
		Pass
		{
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 163915

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.0


			float _RenderViewportScaleFactor;

			static float4 vertex_uniform_buffer_0[27];
			static float4 gl_Position;
			static float3 vertex_input_0;
			static float2 vertex_output_1;
			static float2 vertex_output_1;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				float2 vertex_output_1 : TEXCOORD1; // TEXCOORD_1
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				gl_Position.x = vertex_input_0.x;
				gl_Position.y = vertex_input_0.y;
				gl_Position.z = 0.0f;
				gl_Position.w = 1.0f;
				precise float vertex_unnamed_42 = vertex_input_0.x + 1.0f;
				precise float vertex_unnamed_43 = vertex_input_0.y + 1.0f;
				precise float vertex_unnamed_54 = mad(vertex_unnamed_42, 0.5f, 0.0f) * vertex_uniform_buffer_0[26u].x;
				precise float vertex_unnamed_55 = mad(vertex_unnamed_43, -0.5f, 1.0f) * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.x = vertex_unnamed_54;
				vertex_output_1.y = vertex_unnamed_55;
				vertex_output_1.x = mad(vertex_input_0.x, 0.5f, 0.5f);
				vertex_output_1.y = mad(vertex_input_0.y, -0.5f, 0.5f);
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, vertex_uniform_buffer_0[26][1], vertex_uniform_buffer_0[26][2], vertex_uniform_buffer_0[26][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}


			float _RenderViewportScaleFactor;

			static float4 gl_Position;
			static float3 vertex_input_0;
			static float2 vertex_output_1;
			static float2 vertex_output_0;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION;
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_0 : TEXCOORD0; // vs_TEXCOORD0
				float2 vertex_output_1 : TEXCOORD1; // vs_TEXCOORD1
				float4 gl_Position : SV_Position;
			};

			static float2 vertex_unnamed_33;

			void vert_main()
			{
				gl_Position = float4(vertex_input_0.xy.x, vertex_input_0.xy.y, gl_Position.z, gl_Position.w);
				gl_Position = float4(gl_Position.x, gl_Position.y, float2(0.0f, 1.0f).x, float2(0.0f, 1.0f).y);
				vertex_unnamed_33 = vertex_input_0.xy + 1.0f.xx;
				vertex_unnamed_33 = (vertex_unnamed_33 * float2(0.5f, -0.5f)) + float2(0.0f, 1.0f);
				vertex_output_1 = vertex_unnamed_33 * _RenderViewportScaleFactor.xx;
				vertex_output_0 = (vertex_input_0.xy * float2(0.5f, -0.5f)) + 0.5f.xx;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_0 = vertex_output_0;
				return stage_output;
			}

			float _RenderViewportScaleFactor;
			float4 _MainTex_TexelSize;
			float4 _Params;

			Texture2D<float4> _CameraMotionVectorsTexture;
			SamplerState sampler_CameraMotionVectorsTexture;
			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

			static float4 gl_FragCoord;
			static float2 fragment_input_0;
			static float2 fragment_input_1;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_0 : TEXCOORD0; // vs_TEXCOORD0
				float2 fragment_input_1 : TEXCOORD1; // vs_TEXCOORD1
				float4 gl_FragCoord : SV_Position;
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static float3 fragment_unnamed_27;
			static float fragment_unnamed_73;
			static float fragment_unnamed_78;
			static float3 fragment_unnamed_87;
			static bool fragment_unnamed_96;
			static float fragment_unnamed_110;
			static bool fragment_unnamed_154;
			static float4 fragment_unnamed_192;
			static bool fragment_unnamed_201;
			static float fragment_unnamed_273;
			static float2 fragment_unnamed_338;
			static float fragment_unnamed_399;
			static bool fragment_unnamed_408;
			static float4 fragment_unnamed_411;
			static float2 fragment_unnamed_443;
			static float3 fragment_unnamed_461;

			void frag_main()
			{
				float4 fragment_unnamed_9 = float4(gl_FragCoord.xyz, 1.0f / gl_FragCoord.w);
				fragment_unnamed_27 = float3(fragment_input_0.x, fragment_input_0.y, fragment_unnamed_27.z);
				float2 fragment_unnamed_39 = clamp(fragment_unnamed_27.xy, 0.0f.xx, 1.0f.xx);
				fragment_unnamed_27 = float3(fragment_unnamed_39.x, fragment_unnamed_39.y, fragment_unnamed_27.z);
				float2 fragment_unnamed_53 = fragment_unnamed_27.xy * _RenderViewportScaleFactor.xx;
				fragment_unnamed_27 = float3(fragment_unnamed_53.x, fragment_unnamed_53.y, fragment_unnamed_27.z);
				float2 fragment_unnamed_69 = _CameraMotionVectorsTexture.Sample(sampler_CameraMotionVectorsTexture, fragment_unnamed_27.xy).xy;
				fragment_unnamed_27 = float3(fragment_unnamed_69.x, fragment_unnamed_69.y, fragment_unnamed_27.z);
				fragment_unnamed_73 = abs(fragment_unnamed_27.y);
				fragment_unnamed_78 = max(fragment_unnamed_73, abs(fragment_unnamed_27.x));
				fragment_unnamed_78 = 1.0f / fragment_unnamed_78;
				fragment_unnamed_87.x = min(fragment_unnamed_73, abs(fragment_unnamed_27.x));
				fragment_unnamed_96 = fragment_unnamed_73 < abs(fragment_unnamed_27.x);
				fragment_unnamed_78 *= fragment_unnamed_87.x;
				fragment_unnamed_87.x = fragment_unnamed_78 * fragment_unnamed_78;
				fragment_unnamed_110 = (fragment_unnamed_87.x * 0.02083509974181652069091796875f) + (-0.08513300120830535888671875f);
				fragment_unnamed_110 = (fragment_unnamed_87.x * fragment_unnamed_110) + 0.1801410019397735595703125f;
				fragment_unnamed_110 = (fragment_unnamed_87.x * fragment_unnamed_110) + (-0.33029949665069580078125f);
				fragment_unnamed_87.x = (fragment_unnamed_87.x * fragment_unnamed_110) + 0.999866008758544921875f;
				fragment_unnamed_110 = fragment_unnamed_78 * fragment_unnamed_87.x;
				fragment_unnamed_110 = (fragment_unnamed_110 * (-2.0f)) + 1.57079637050628662109375f;
				fragment_unnamed_73 = fragment_unnamed_96 ? fragment_unnamed_110 : 0.0f;
				fragment_unnamed_73 = (fragment_unnamed_78 * fragment_unnamed_87.x) + fragment_unnamed_73;
				fragment_unnamed_154 = (-fragment_unnamed_27.y) < fragment_unnamed_27.y;
				fragment_unnamed_78 = fragment_unnamed_154 ? (-3.1415927410125732421875f) : 0.0f;
				fragment_unnamed_73 = fragment_unnamed_78 + fragment_unnamed_73;
				fragment_unnamed_78 = min(-fragment_unnamed_27.y, fragment_unnamed_27.x);
				fragment_unnamed_154 = fragment_unnamed_78 < (-fragment_unnamed_78);
				fragment_unnamed_87.x = max(-fragment_unnamed_27.y, fragment_unnamed_27.x);
				float2 fragment_unnamed_188 = fragment_unnamed_27.xy * float2(1.0f, -1.0f);
				fragment_unnamed_27 = float3(fragment_unnamed_188.x, fragment_unnamed_188.y, fragment_unnamed_27.z);
				fragment_unnamed_192 = fragment_unnamed_27.xyxy * _Params.xxyy;
				fragment_unnamed_201 = fragment_unnamed_87.x >= (-fragment_unnamed_87.x);
				fragment_unnamed_201 = fragment_unnamed_201 && fragment_unnamed_154;
				float fragment_unnamed_213;
				if (fragment_unnamed_201)
				{
					fragment_unnamed_213 = -fragment_unnamed_73;
				}
				else
				{
					fragment_unnamed_213 = fragment_unnamed_73;
				}
				fragment_unnamed_27.x = fragment_unnamed_213;
				fragment_unnamed_27.x = (fragment_unnamed_27.x * 0.3183098733425140380859375f) + 1.0f;
				fragment_unnamed_27 = (fragment_unnamed_27.xxx * 3.0f.xxx) + float3(-3.0f, -2.0f, -4.0f);
				fragment_unnamed_27 = (abs(fragment_unnamed_27) * float3(1.0f, -1.0f, -1.0f)) + float3(-1.0f, 2.0f, 2.0f);
				fragment_unnamed_27 = clamp(fragment_unnamed_27, 0.0f.xxx, 1.0f.xxx);
				fragment_unnamed_87 = _MainTex.Sample(sampler_MainTex, fragment_input_1).xyz;
				fragment_unnamed_27 += (-fragment_unnamed_87);
				fragment_unnamed_78 = dot(fragment_unnamed_192.xy, fragment_unnamed_192.xy);
				float2 fragment_unnamed_270 = fragment_unnamed_192.zw * 0.25f.xx;
				fragment_unnamed_192 = float4(fragment_unnamed_270.x, fragment_unnamed_270.y, fragment_unnamed_192.z, fragment_unnamed_192.w);
				fragment_unnamed_273 = dot(fragment_unnamed_192.xy, fragment_unnamed_192.xy);
				fragment_unnamed_273 = sqrt(fragment_unnamed_273);
				fragment_unnamed_273 = min(fragment_unnamed_273, 1.0f);
				fragment_unnamed_78 = sqrt(fragment_unnamed_78);
				fragment_unnamed_78 = clamp(fragment_unnamed_78, 0.0f, 1.0f);
				fragment_unnamed_27 = (fragment_unnamed_78.xxx * fragment_unnamed_27) + fragment_unnamed_87;
				fragment_unnamed_78 = _MainTex_TexelSize.w * _Params.y;
				fragment_unnamed_78 /= _MainTex_TexelSize.z;
				fragment_unnamed_87.y = floor(fragment_unnamed_78);
				fragment_unnamed_87.x = _Params.y;
				float2 fragment_unnamed_315 = _MainTex_TexelSize.zw / fragment_unnamed_87.xy;
				fragment_unnamed_87 = float3(fragment_unnamed_315.x, fragment_unnamed_315.y, fragment_unnamed_87.z);
				float2 fragment_unnamed_322 = fragment_unnamed_9.xy / fragment_unnamed_87.xy;
				fragment_unnamed_192 = float4(fragment_unnamed_322.x, fragment_unnamed_322.y, fragment_unnamed_192.z, fragment_unnamed_192.w);
				float2 fragment_unnamed_327 = floor(fragment_unnamed_192.xy);
				fragment_unnamed_192 = float4(fragment_unnamed_327.x, fragment_unnamed_327.y, fragment_unnamed_192.z, fragment_unnamed_192.w);
				float2 fragment_unnamed_334 = fragment_unnamed_192.xy + 0.5f.xx;
				fragment_unnamed_192 = float4(fragment_unnamed_334.x, fragment_unnamed_334.y, fragment_unnamed_192.z, fragment_unnamed_192.w);
				fragment_unnamed_338 = fragment_unnamed_87.xy * fragment_unnamed_192.xy;
				float2 fragment_unnamed_352 = ((-fragment_unnamed_192.xy) * fragment_unnamed_87.xy) + fragment_unnamed_9.xy;
				fragment_unnamed_192 = float4(fragment_unnamed_352.x, fragment_unnamed_352.y, fragment_unnamed_192.z, fragment_unnamed_192.w);
				fragment_unnamed_78 = min(fragment_unnamed_87.y, fragment_unnamed_87.x);
				fragment_unnamed_78 *= 0.707106769084930419921875f;
				float2 fragment_unnamed_367 = fragment_unnamed_338 / _MainTex_TexelSize.zw;
				fragment_unnamed_87 = float3(fragment_unnamed_367.x, fragment_unnamed_367.y, fragment_unnamed_87.z);
				float2 fragment_unnamed_374 = clamp(fragment_unnamed_87.xy, 0.0f.xx, 1.0f.xx);
				fragment_unnamed_87 = float3(fragment_unnamed_374.x, fragment_unnamed_374.y, fragment_unnamed_87.z);
				float2 fragment_unnamed_382 = fragment_unnamed_87.xy * _RenderViewportScaleFactor.xx;
				fragment_unnamed_87 = float3(fragment_unnamed_382.x, fragment_unnamed_382.y, fragment_unnamed_87.z);
				float2 fragment_unnamed_391 = _CameraMotionVectorsTexture.Sample(sampler_CameraMotionVectorsTexture, fragment_unnamed_87.xy).xy;
				fragment_unnamed_87 = float3(fragment_unnamed_391.x, fragment_unnamed_391.y, fragment_unnamed_87.z);
				float2 fragment_unnamed_396 = fragment_unnamed_87.xy * float2(1.0f, -1.0f);
				fragment_unnamed_87 = float3(fragment_unnamed_396.x, fragment_unnamed_396.y, fragment_unnamed_87.z);
				fragment_unnamed_399 = dot(fragment_unnamed_87.xy, fragment_unnamed_87.xy);
				fragment_unnamed_338.x = rsqrt(fragment_unnamed_399);
				fragment_unnamed_408 = fragment_unnamed_399 != 0.0f;
				float2 fragment_unnamed_416 = fragment_unnamed_87.xy * fragment_unnamed_338.xx;
				fragment_unnamed_411 = float4(fragment_unnamed_416.x, fragment_unnamed_416.y, fragment_unnamed_411.z, fragment_unnamed_411.w);
				fragment_unnamed_411.z = -fragment_unnamed_411.y;
				fragment_unnamed_87.x = dot(fragment_unnamed_411.xz, fragment_unnamed_192.xy);
				fragment_unnamed_87.y = dot(fragment_unnamed_411.yx, fragment_unnamed_192.xy);
				fragment_unnamed_192.x = fragment_unnamed_273 * fragment_unnamed_78;
				fragment_unnamed_78 = (fragment_unnamed_78 * fragment_unnamed_273) + (-2.0f);
				fragment_unnamed_443 = ((-fragment_unnamed_192.xx) * float2(0.375f, -0.0625f)) + fragment_unnamed_87.xy;
				float3 fragment_unnamed_458 = fragment_unnamed_192.xxx * float3(0.5f, 0.25f, -0.125f);
				fragment_unnamed_411 = float4(fragment_unnamed_458.x, fragment_unnamed_458.y, fragment_unnamed_458.z, fragment_unnamed_411.w);
				fragment_unnamed_461.x = fragment_unnamed_411.x;
				fragment_unnamed_461.y = 0.0f;
				float2 fragment_unnamed_474 = ((-fragment_unnamed_192.xx) * float2(0.25f, 0.125f)) + fragment_unnamed_461.xy;
				fragment_unnamed_411 = float4(fragment_unnamed_474.x, fragment_unnamed_411.y, fragment_unnamed_411.z, fragment_unnamed_474.y);
				float2 fragment_unnamed_482 = (-fragment_unnamed_411.xw) + fragment_unnamed_461.xy;
				fragment_unnamed_411 = float4(fragment_unnamed_482.x, fragment_unnamed_411.y, fragment_unnamed_411.z, fragment_unnamed_482.y);
				fragment_unnamed_273 = dot(fragment_unnamed_411.xw, fragment_unnamed_411.xw);
				fragment_unnamed_273 = sqrt(fragment_unnamed_273);
				float2 fragment_unnamed_496 = fragment_unnamed_411.xw / fragment_unnamed_273.xx;
				fragment_unnamed_461 = float3(fragment_unnamed_496.x, fragment_unnamed_496.y, fragment_unnamed_461.z);
				fragment_unnamed_461.z = -fragment_unnamed_461.x;
				fragment_unnamed_273 = dot(fragment_unnamed_443, fragment_unnamed_461.yz);
				fragment_unnamed_443 = ((-fragment_unnamed_192.xx) * float2(0.375f, 0.0625f)) + fragment_unnamed_87.xy;
				float2 fragment_unnamed_520 = fragment_unnamed_87.xy + float2(1.0f, -0.0f);
				fragment_unnamed_411 = float4(fragment_unnamed_520.x, fragment_unnamed_411.y, fragment_unnamed_411.z, fragment_unnamed_520.y);
				fragment_unnamed_87.x = (fragment_unnamed_192.x * (-0.25f)) + fragment_unnamed_87.x;
				fragment_unnamed_110 = dot(-fragment_unnamed_411.yz, -fragment_unnamed_411.yz);
				fragment_unnamed_110 = sqrt(fragment_unnamed_110);
				float2 fragment_unnamed_545 = (-fragment_unnamed_411.yz) / fragment_unnamed_110.xx;
				fragment_unnamed_461 = float3(fragment_unnamed_545.x, fragment_unnamed_545.y, fragment_unnamed_461.z);
				fragment_unnamed_461.z = -fragment_unnamed_461.x;
				fragment_unnamed_110 = dot(fragment_unnamed_443, fragment_unnamed_461.yz);
				fragment_unnamed_110 = max(fragment_unnamed_273, fragment_unnamed_110);
				fragment_unnamed_87.x = max(-fragment_unnamed_87.x, fragment_unnamed_110);
				fragment_unnamed_110 = fragment_unnamed_78 / abs(fragment_unnamed_78);
				fragment_unnamed_273 = fragment_unnamed_110 * fragment_unnamed_411.x;
				fragment_unnamed_110 = (-fragment_unnamed_110) * fragment_unnamed_411.w;
				fragment_unnamed_78 = ((-abs(fragment_unnamed_78)) * 0.5f) + abs(fragment_unnamed_273);
				fragment_unnamed_78 = max(fragment_unnamed_78, abs(fragment_unnamed_110));
				fragment_unnamed_78 = min(fragment_unnamed_78, fragment_unnamed_87.x);
				fragment_unnamed_78 = clamp(fragment_unnamed_78, 0.0f, 1.0f);
				fragment_unnamed_78 = (-fragment_unnamed_78) + 1.0f;
				fragment_unnamed_78 = fragment_unnamed_408 ? fragment_unnamed_78 : 0.0f;
				float3 fragment_unnamed_606 = fragment_unnamed_78.xxx + fragment_unnamed_27;
				fragment_output_0 = float4(fragment_unnamed_606.x, fragment_unnamed_606.y, fragment_unnamed_606.z, fragment_output_0.w);
				fragment_output_0.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				gl_FragCoord = stage_input.gl_FragCoord;
				gl_FragCoord.w = 1.0 / gl_FragCoord.w;
				fragment_input_0 = stage_input.fragment_input_0;
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			float _RenderViewportScaleFactor;
			float4 _MainTex_TexelSize;
			float4 _Params;

			static float4 fragment_uniform_buffer_0[30];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _CameraMotionVectorsTexture;
			SamplerState sampler_MainTex;
			SamplerState sampler_CameraMotionVectorsTexture;

			static float4 gl_FragCoord;
			static float2 fragment_input_1;
			static float2 fragment_input_1;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD; // TEXCOORD
				float2 fragment_input_1 : TEXCOORD1; // TEXCOORD_1
				float4 gl_FragCoord : SV_Position;
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				precise float fragment_unnamed_50 = clamp(fragment_input_1.x, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_51 = clamp(fragment_input_1.y, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_54 = _CameraMotionVectorsTexture.Sample(sampler_CameraMotionVectorsTexture, float2(fragment_unnamed_50, fragment_unnamed_51));
				float fragment_unnamed_56 = fragment_unnamed_54.x;
				float fragment_unnamed_57 = fragment_unnamed_54.y;
				float fragment_unnamed_58 = abs(fragment_unnamed_57);
				precise float fragment_unnamed_61 = 1.0f / max(fragment_unnamed_58, abs(fragment_unnamed_56));
				precise float fragment_unnamed_69 = fragment_unnamed_61 * min(fragment_unnamed_58, abs(fragment_unnamed_56));
				precise float fragment_unnamed_70 = fragment_unnamed_69 * fragment_unnamed_69;
				float fragment_unnamed_78 = mad(fragment_unnamed_70, mad(fragment_unnamed_70, mad(fragment_unnamed_70, mad(fragment_unnamed_70, 0.02083509974181652069091796875f, -0.08513300120830535888671875f), 0.1801410019397735595703125f), -0.33029949665069580078125f), 0.999866008758544921875f);
				precise float fragment_unnamed_80 = fragment_unnamed_69 * fragment_unnamed_78;
				precise float fragment_unnamed_88 = (-0.0f) - fragment_unnamed_57;
				precise float fragment_unnamed_95 = asfloat(((fragment_unnamed_88 < fragment_unnamed_57) ? 4294967295u : 0u) & 3226013659u) + mad(fragment_unnamed_69, fragment_unnamed_78, asfloat(((fragment_unnamed_58 < abs(fragment_unnamed_56)) ? 4294967295u : 0u) & asuint(mad(fragment_unnamed_80, -2.0f, 1.57079637050628662109375f))));
				precise float fragment_unnamed_96 = (-0.0f) - fragment_unnamed_57;
				float fragment_unnamed_97 = min(fragment_unnamed_96, fragment_unnamed_56);
				precise float fragment_unnamed_98 = (-0.0f) - fragment_unnamed_97;
				precise float fragment_unnamed_101 = (-0.0f) - fragment_unnamed_57;
				float fragment_unnamed_102 = max(fragment_unnamed_101, fragment_unnamed_56);
				precise float fragment_unnamed_103 = fragment_unnamed_56 * 1.0f;
				precise float fragment_unnamed_104 = fragment_unnamed_57 * (-1.0f);
				precise float fragment_unnamed_111 = fragment_unnamed_103 * fragment_uniform_buffer_0[29u].x;
				precise float fragment_unnamed_112 = fragment_unnamed_104 * fragment_uniform_buffer_0[29u].x;
				precise float fragment_unnamed_113 = fragment_unnamed_103 * fragment_uniform_buffer_0[29u].y;
				precise float fragment_unnamed_114 = fragment_unnamed_104 * fragment_uniform_buffer_0[29u].y;
				precise float fragment_unnamed_115 = (-0.0f) - fragment_unnamed_102;
				precise float fragment_unnamed_120 = (-0.0f) - fragment_unnamed_95;
				float fragment_unnamed_122 = mad(((((fragment_unnamed_102 >= fragment_unnamed_115) ? 4294967295u : 0u) & ((fragment_unnamed_97 < fragment_unnamed_98) ? 4294967295u : 0u)) != 0u) ? fragment_unnamed_120 : fragment_unnamed_95, 0.3183098733425140380859375f, 1.0f);
				float4 fragment_unnamed_145 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				float fragment_unnamed_147 = fragment_unnamed_145.x;
				float fragment_unnamed_148 = fragment_unnamed_145.y;
				float fragment_unnamed_149 = fragment_unnamed_145.z;
				precise float fragment_unnamed_150 = (-0.0f) - fragment_unnamed_147;
				precise float fragment_unnamed_151 = (-0.0f) - fragment_unnamed_148;
				precise float fragment_unnamed_152 = (-0.0f) - fragment_unnamed_149;
				precise float fragment_unnamed_153 = clamp(mad(abs(mad(fragment_unnamed_122, 3.0f, -3.0f)), 1.0f, -1.0f), 0.0f, 1.0f) + fragment_unnamed_150;
				precise float fragment_unnamed_154 = clamp(mad(abs(mad(fragment_unnamed_122, 3.0f, -2.0f)), -1.0f, 2.0f), 0.0f, 1.0f) + fragment_unnamed_151;
				precise float fragment_unnamed_155 = clamp(mad(abs(mad(fragment_unnamed_122, 3.0f, -4.0f)), -1.0f, 2.0f), 0.0f, 1.0f) + fragment_unnamed_152;
				precise float fragment_unnamed_159 = fragment_unnamed_113 * 0.25f;
				precise float fragment_unnamed_161 = fragment_unnamed_114 * 0.25f;
				float fragment_unnamed_166 = min(sqrt(dot(float2(fragment_unnamed_159, fragment_unnamed_161), float2(fragment_unnamed_159, fragment_unnamed_161))), 1.0f);
				float fragment_unnamed_168 = clamp(sqrt(dot(float2(fragment_unnamed_111, fragment_unnamed_112), float2(fragment_unnamed_111, fragment_unnamed_112))), 0.0f, 1.0f);
				precise float fragment_unnamed_179 = fragment_uniform_buffer_0[28u].w * fragment_uniform_buffer_0[29u].y;
				precise float fragment_unnamed_183 = fragment_unnamed_179 / fragment_uniform_buffer_0[28u].z;
				precise float fragment_unnamed_195 = fragment_uniform_buffer_0[28u].z / asfloat(asuint(fragment_uniform_buffer_0[29u]).y);
				precise float fragment_unnamed_196 = fragment_uniform_buffer_0[28u].w / floor(fragment_unnamed_183);
				precise float fragment_unnamed_201 = gl_FragCoord.x / fragment_unnamed_195;
				precise float fragment_unnamed_202 = gl_FragCoord.y / fragment_unnamed_196;
				precise float fragment_unnamed_205 = floor(fragment_unnamed_201) + 0.5f;
				precise float fragment_unnamed_207 = floor(fragment_unnamed_202) + 0.5f;
				precise float fragment_unnamed_208 = fragment_unnamed_195 * fragment_unnamed_205;
				precise float fragment_unnamed_209 = fragment_unnamed_196 * fragment_unnamed_207;
				precise float fragment_unnamed_210 = (-0.0f) - fragment_unnamed_205;
				precise float fragment_unnamed_211 = (-0.0f) - fragment_unnamed_207;
				float fragment_unnamed_216 = mad(fragment_unnamed_210, fragment_unnamed_195, gl_FragCoord.x);
				float fragment_unnamed_217 = mad(fragment_unnamed_211, fragment_unnamed_196, gl_FragCoord.y);
				precise float fragment_unnamed_219 = min(fragment_unnamed_196, fragment_unnamed_195) * 0.707106769084930419921875f;
				precise float fragment_unnamed_225 = fragment_unnamed_208 / fragment_uniform_buffer_0[28u].z;
				precise float fragment_unnamed_226 = fragment_unnamed_209 / fragment_uniform_buffer_0[28u].w;
				precise float fragment_unnamed_232 = clamp(fragment_unnamed_225, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_233 = clamp(fragment_unnamed_226, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_234 = _CameraMotionVectorsTexture.Sample(sampler_CameraMotionVectorsTexture, float2(fragment_unnamed_232, fragment_unnamed_233));
				precise float fragment_unnamed_238 = fragment_unnamed_234.x * 1.0f;
				precise float fragment_unnamed_239 = fragment_unnamed_234.y * (-1.0f);
				float fragment_unnamed_240 = dot(float2(fragment_unnamed_238, fragment_unnamed_239), float2(fragment_unnamed_238, fragment_unnamed_239));
				float fragment_unnamed_243 = rsqrt(fragment_unnamed_240);
				precise float fragment_unnamed_246 = fragment_unnamed_238 * fragment_unnamed_243;
				precise float fragment_unnamed_247 = fragment_unnamed_239 * fragment_unnamed_243;
				precise float fragment_unnamed_248 = (-0.0f) - fragment_unnamed_247;
				float fragment_unnamed_249 = dot(float2(fragment_unnamed_246, fragment_unnamed_248), float2(fragment_unnamed_216, fragment_unnamed_217));
				float fragment_unnamed_252 = dot(float2(fragment_unnamed_247, fragment_unnamed_246), float2(fragment_unnamed_216, fragment_unnamed_217));
				precise float fragment_unnamed_255 = fragment_unnamed_166 * fragment_unnamed_219;
				float fragment_unnamed_256 = mad(fragment_unnamed_219, fragment_unnamed_166, -2.0f);
				precise float fragment_unnamed_257 = (-0.0f) - fragment_unnamed_255;
				precise float fragment_unnamed_262 = fragment_unnamed_255 * 0.5f;
				precise float fragment_unnamed_263 = fragment_unnamed_255 * 0.25f;
				precise float fragment_unnamed_264 = fragment_unnamed_255 * (-0.125f);
				float fragment_unnamed_266 = asfloat(0u);
				precise float fragment_unnamed_267 = (-0.0f) - fragment_unnamed_255;
				precise float fragment_unnamed_271 = (-0.0f) - mad(fragment_unnamed_267, 0.25f, fragment_unnamed_262);
				precise float fragment_unnamed_272 = (-0.0f) - mad(fragment_unnamed_267, 0.125f, fragment_unnamed_266);
				precise float fragment_unnamed_273 = fragment_unnamed_271 + fragment_unnamed_262;
				precise float fragment_unnamed_274 = fragment_unnamed_272 + fragment_unnamed_266;
				float fragment_unnamed_278 = sqrt(dot(float2(fragment_unnamed_273, fragment_unnamed_274), float2(fragment_unnamed_273, fragment_unnamed_274)));
				precise float fragment_unnamed_279 = fragment_unnamed_273 / fragment_unnamed_278;
				precise float fragment_unnamed_280 = fragment_unnamed_274 / fragment_unnamed_278;
				precise float fragment_unnamed_281 = (-0.0f) - fragment_unnamed_279;
				precise float fragment_unnamed_285 = (-0.0f) - fragment_unnamed_255;
				precise float fragment_unnamed_289 = fragment_unnamed_249 + 1.0f;
				precise float fragment_unnamed_290 = fragment_unnamed_252 + (-0.0f);
				precise float fragment_unnamed_293 = (-0.0f) - fragment_unnamed_263;
				precise float fragment_unnamed_294 = (-0.0f) - fragment_unnamed_264;
				precise float fragment_unnamed_295 = (-0.0f) - fragment_unnamed_263;
				precise float fragment_unnamed_296 = (-0.0f) - fragment_unnamed_264;
				float fragment_unnamed_300 = sqrt(dot(float2(fragment_unnamed_293, fragment_unnamed_294), float2(fragment_unnamed_295, fragment_unnamed_296)));
				precise float fragment_unnamed_301 = (-0.0f) - fragment_unnamed_263;
				precise float fragment_unnamed_302 = (-0.0f) - fragment_unnamed_264;
				precise float fragment_unnamed_303 = fragment_unnamed_301 / fragment_unnamed_300;
				precise float fragment_unnamed_304 = fragment_unnamed_302 / fragment_unnamed_300;
				precise float fragment_unnamed_305 = (-0.0f) - fragment_unnamed_303;
				precise float fragment_unnamed_310 = (-0.0f) - mad(fragment_unnamed_255, -0.25f, fragment_unnamed_249);
				precise float fragment_unnamed_313 = fragment_unnamed_256 / abs(fragment_unnamed_256);
				precise float fragment_unnamed_314 = fragment_unnamed_313 * fragment_unnamed_289;
				precise float fragment_unnamed_315 = (-0.0f) - fragment_unnamed_313;
				precise float fragment_unnamed_316 = fragment_unnamed_315 * fragment_unnamed_290;
				precise float fragment_unnamed_318 = (-0.0f) - abs(fragment_unnamed_256);
				precise float fragment_unnamed_325 = (-0.0f) - clamp(min(max(mad(fragment_unnamed_318, 0.5f, abs(fragment_unnamed_314)), abs(fragment_unnamed_316)), max(fragment_unnamed_310, max(dot(float2(mad(fragment_unnamed_257, 0.375f, fragment_unnamed_249), mad(fragment_unnamed_257, -0.0625f, fragment_unnamed_252)), float2(fragment_unnamed_280, fragment_unnamed_281)), dot(float2(mad(fragment_unnamed_285, 0.375f, fragment_unnamed_249), mad(fragment_unnamed_285, 0.0625f, fragment_unnamed_252)), float2(fragment_unnamed_304, fragment_unnamed_305))))), 0.0f, 1.0f);
				precise float fragment_unnamed_326 = fragment_unnamed_325 + 1.0f;
				float fragment_unnamed_329 = asfloat(asuint(fragment_unnamed_326) & ((fragment_unnamed_240 != 0.0f) ? 4294967295u : 0u));
				precise float fragment_unnamed_330 = fragment_unnamed_329 + mad(fragment_unnamed_168, fragment_unnamed_153, fragment_unnamed_147);
				precise float fragment_unnamed_331 = fragment_unnamed_329 + mad(fragment_unnamed_168, fragment_unnamed_154, fragment_unnamed_148);
				precise float fragment_unnamed_332 = fragment_unnamed_329 + mad(fragment_unnamed_168, fragment_unnamed_155, fragment_unnamed_149);
				fragment_output_0.x = fragment_unnamed_330;
				fragment_output_0.y = fragment_unnamed_331;
				fragment_output_0.z = fragment_unnamed_332;
				fragment_output_0.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, fragment_uniform_buffer_0[26][1], fragment_uniform_buffer_0[26][2], fragment_uniform_buffer_0[26][3]);

				fragment_uniform_buffer_0[28] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				fragment_uniform_buffer_0[29] = float4(_Params[0], _Params[1], _Params[2], _Params[3]);

				gl_FragCoord = stage_input.gl_FragCoord;
				gl_FragCoord.w = 1.0 / gl_FragCoord.w;
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			ENDHLSL
		}
		Pass
		{
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 229093

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.0


			float _RenderViewportScaleFactor;

			static float4 vertex_uniform_buffer_0[27];
			static float4 gl_Position;
			static float3 vertex_input_0;
			static float2 vertex_output_1;
			static float2 vertex_output_1;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				float2 vertex_output_1 : TEXCOORD1; // TEXCOORD_1
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				gl_Position.x = vertex_input_0.x;
				gl_Position.y = vertex_input_0.y;
				gl_Position.z = 0.0f;
				gl_Position.w = 1.0f;
				precise float vertex_unnamed_42 = vertex_input_0.x + 1.0f;
				precise float vertex_unnamed_43 = vertex_input_0.y + 1.0f;
				precise float vertex_unnamed_54 = mad(vertex_unnamed_42, 0.5f, 0.0f) * vertex_uniform_buffer_0[26u].x;
				precise float vertex_unnamed_55 = mad(vertex_unnamed_43, -0.5f, 1.0f) * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.x = vertex_unnamed_54;
				vertex_output_1.y = vertex_unnamed_55;
				vertex_output_1.x = mad(vertex_input_0.x, 0.5f, 0.5f);
				vertex_output_1.y = mad(vertex_input_0.y, -0.5f, 0.5f);
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, vertex_uniform_buffer_0[26][1], vertex_uniform_buffer_0[26][2], vertex_uniform_buffer_0[26][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}


			float _RenderViewportScaleFactor;

			static float4 gl_Position;
			static float3 vertex_input_0;
			static float2 vertex_output_0;
			static float2 vertex_output_1;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION;
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_0 : TEXCOORD1; // vs_TEXCOORD1
				float2 vertex_output_1 : TEXCOORD0; // vs_TEXCOORD0
				float4 gl_Position : SV_Position;
			};

			static float2 vertex_unnamed_33;

			void vert_main()
			{
				gl_Position = float4(vertex_input_0.xy.x, vertex_input_0.xy.y, gl_Position.z, gl_Position.w);
				gl_Position = float4(gl_Position.x, gl_Position.y, float2(0.0f, 1.0f).x, float2(0.0f, 1.0f).y);
				vertex_unnamed_33 = vertex_input_0.xy + 1.0f.xx;
				vertex_unnamed_33 = (vertex_unnamed_33 * float2(0.5f, -0.5f)) + float2(0.0f, 1.0f);
				vertex_output_0 = vertex_unnamed_33 * _RenderViewportScaleFactor.xx;
				vertex_output_1 = (vertex_input_0.xy * float2(0.5f, -0.5f)) + 0.5f.xx;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_0 = vertex_output_0;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}

			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

			static float2 fragment_input_0;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_0 : TEXCOORD1; // vs_TEXCOORD1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static float4 fragment_unnamed_9;
			static bool4 fragment_unnamed_28;
			static bool4 fragment_unnamed_33;
			static int4 fragment_unnamed_39;

			void frag_main()
			{
				fragment_unnamed_9 = _MainTex.Sample(sampler_MainTex, fragment_input_0);
				fragment_unnamed_28 = bool4(fragment_unnamed_9.x < 0.0f.xxxx.x, fragment_unnamed_9.y < 0.0f.xxxx.y, fragment_unnamed_9.z < 0.0f.xxxx.z, fragment_unnamed_9.w < 0.0f.xxxx.w);
				fragment_unnamed_33 = bool4(0.0f.xxxx.x < fragment_unnamed_9.x, 0.0f.xxxx.y < fragment_unnamed_9.y, 0.0f.xxxx.z < fragment_unnamed_9.z, 0.0f.xxxx.w < fragment_unnamed_9.w);
				fragment_unnamed_39 = int4((uint4(fragment_unnamed_28) * uint4(4294967295u, 4294967295u, 4294967295u, 4294967295u)) | (uint4(fragment_unnamed_33) * uint4(4294967295u, 4294967295u, 4294967295u, 4294967295u)));
				fragment_unnamed_33 = bool4(fragment_unnamed_9.x == 0.0f.xxxx.x, fragment_unnamed_9.y == 0.0f.xxxx.y, fragment_unnamed_9.z == 0.0f.xxxx.z, fragment_unnamed_9.w == 0.0f.xxxx.w);
				fragment_unnamed_39 = int4(uint4(fragment_unnamed_39) | (uint4(fragment_unnamed_33) * uint4(4294967295u, 4294967295u, 4294967295u, 4294967295u)));
				fragment_unnamed_28 = bool4(fragment_unnamed_39.x == int4(0, 0, 0, 0).x, fragment_unnamed_39.y == int4(0, 0, 0, 0).y, fragment_unnamed_39.z == int4(0, 0, 0, 0).z, fragment_unnamed_39.w == int4(0, 0, 0, 0).w);
				fragment_unnamed_28.x = fragment_unnamed_28.y || fragment_unnamed_28.x;
				fragment_unnamed_28.x = fragment_unnamed_28.z || fragment_unnamed_28.x;
				fragment_unnamed_28.x = fragment_unnamed_28.w || fragment_unnamed_28.x;
				fragment_unnamed_9 = float4(fragment_unnamed_9.xyz.x, fragment_unnamed_9.xyz.y, fragment_unnamed_9.xyz.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_102 = clamp(fragment_unnamed_9.xyz, 0.0f.xxx, 1.0f.xxx);
				fragment_unnamed_9 = float4(fragment_unnamed_102.x, fragment_unnamed_102.y, fragment_unnamed_102.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_109 = fragment_unnamed_9.xyz * 0.25f.xxx;
				fragment_unnamed_9 = float4(fragment_unnamed_109.x, fragment_unnamed_109.y, fragment_unnamed_109.z, fragment_unnamed_9.w);
				bool4 fragment_unnamed_118 = fragment_unnamed_28.x.xxxx;
				fragment_output_0 = float4(fragment_unnamed_118.x ? float4(1.0f, 0.0f, 1.0f, 1.0f).x : fragment_unnamed_9.x, fragment_unnamed_118.y ? float4(1.0f, 0.0f, 1.0f, 1.0f).y : fragment_unnamed_9.y, fragment_unnamed_118.z ? float4(1.0f, 0.0f, 1.0f, 1.0f).z : fragment_unnamed_9.z, fragment_unnamed_118.w ? float4(1.0f, 0.0f, 1.0f, 1.0f).w : fragment_unnamed_9.w);
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_0 = stage_input.fragment_input_0;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

			static float2 fragment_input_1;
			static float2 fragment_input_1;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD; // TEXCOORD
				float2 fragment_input_1 : TEXCOORD1; // TEXCOORD_1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				float4 fragment_unnamed_34 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				float fragment_unnamed_36 = fragment_unnamed_34.x;
				float fragment_unnamed_37 = fragment_unnamed_34.y;
				float fragment_unnamed_38 = fragment_unnamed_34.z;
				float fragment_unnamed_39 = fragment_unnamed_34.w;
				precise float fragment_unnamed_90 = clamp(fragment_unnamed_36, 0.0f, 1.0f) * 0.25f;
				precise float fragment_unnamed_92 = clamp(fragment_unnamed_37, 0.0f, 1.0f) * 0.25f;
				precise float fragment_unnamed_93 = clamp(fragment_unnamed_38, 0.0f, 1.0f) * 0.25f;
				bool fragment_unnamed_94 = (((((((fragment_unnamed_39 < 0.0f) ? 4294967295u : 0u) | ((0.0f < fragment_unnamed_39) ? 4294967295u : 0u)) | ((fragment_unnamed_39 == 0.0f) ? 4294967295u : 0u)) == 0u) ? 4294967295u : 0u) | (((((((fragment_unnamed_38 < 0.0f) ? 4294967295u : 0u) | ((0.0f < fragment_unnamed_38) ? 4294967295u : 0u)) | ((fragment_unnamed_38 == 0.0f) ? 4294967295u : 0u)) == 0u) ? 4294967295u : 0u) | (((((((fragment_unnamed_37 < 0.0f) ? 4294967295u : 0u) | ((0.0f < fragment_unnamed_37) ? 4294967295u : 0u)) | ((fragment_unnamed_37 == 0.0f) ? 4294967295u : 0u)) == 0u) ? 4294967295u : 0u) | ((((((fragment_unnamed_36 < 0.0f) ? 4294967295u : 0u) | ((0.0f < fragment_unnamed_36) ? 4294967295u : 0u)) | ((fragment_unnamed_36 == 0.0f) ? 4294967295u : 0u)) == 0u) ? 4294967295u : 0u)))) != 0u;
				fragment_output_0.x = fragment_unnamed_94 ? 1.0f : fragment_unnamed_90;
				fragment_output_0.y = fragment_unnamed_94 ? 0.0f : fragment_unnamed_92;
				fragment_output_0.z = fragment_unnamed_94 ? 1.0f : fragment_unnamed_93;
				fragment_output_0.w = fragment_unnamed_94 ? 1.0f : fragment_unnamed_39;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			ENDHLSL
		}
		Pass
		{
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 300156

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.0


			float _RenderViewportScaleFactor;

			static float4 vertex_uniform_buffer_0[27];
			static float4 gl_Position;
			static float3 vertex_input_0;
			static float2 vertex_output_1;
			static float2 vertex_output_1;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				float2 vertex_output_1 : TEXCOORD1; // TEXCOORD_1
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				gl_Position.x = vertex_input_0.x;
				gl_Position.y = vertex_input_0.y;
				gl_Position.z = 0.0f;
				gl_Position.w = 1.0f;
				precise float vertex_unnamed_42 = vertex_input_0.x + 1.0f;
				precise float vertex_unnamed_43 = vertex_input_0.y + 1.0f;
				precise float vertex_unnamed_54 = mad(vertex_unnamed_42, 0.5f, 0.0f) * vertex_uniform_buffer_0[26u].x;
				precise float vertex_unnamed_55 = mad(vertex_unnamed_43, -0.5f, 1.0f) * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.x = vertex_unnamed_54;
				vertex_output_1.y = vertex_unnamed_55;
				vertex_output_1.x = mad(vertex_input_0.x, 0.5f, 0.5f);
				vertex_output_1.y = mad(vertex_input_0.y, -0.5f, 0.5f);
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, vertex_uniform_buffer_0[26][1], vertex_uniform_buffer_0[26][2], vertex_uniform_buffer_0[26][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}


			float _RenderViewportScaleFactor;

			static float4 gl_Position;
			static float3 vertex_input_0;
			static float2 vertex_output_0;
			static float2 vertex_output_1;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION;
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_0 : TEXCOORD1; // vs_TEXCOORD1
				float2 vertex_output_1 : TEXCOORD0; // vs_TEXCOORD0
				float4 gl_Position : SV_Position;
			};

			static float2 vertex_unnamed_33;

			void vert_main()
			{
				gl_Position = float4(vertex_input_0.xy.x, vertex_input_0.xy.y, gl_Position.z, gl_Position.w);
				gl_Position = float4(gl_Position.x, gl_Position.y, float2(0.0f, 1.0f).x, float2(0.0f, 1.0f).y);
				vertex_unnamed_33 = vertex_input_0.xy + 1.0f.xx;
				vertex_unnamed_33 = (vertex_unnamed_33 * float2(0.5f, -0.5f)) + float2(0.0f, 1.0f);
				vertex_output_0 = vertex_unnamed_33 * _RenderViewportScaleFactor.xx;
				vertex_output_1 = (vertex_input_0.xy * float2(0.5f, -0.5f)) + 0.5f.xx;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_0 = vertex_output_0;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}

			float4 _Params;

			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

			static float2 fragment_input_0;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_0 : TEXCOORD1; // vs_TEXCOORD1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static float3 fragment_unnamed_9;
			static float3 fragment_unnamed_34;
			static float3 fragment_unnamed_51;
			static bool3 fragment_unnamed_59;
			static float fragment_unnamed_110;

			void frag_main()
			{
				fragment_unnamed_9 = _MainTex.Sample(sampler_MainTex, fragment_input_0).xyz;
				fragment_unnamed_9 = fragment_unnamed_9;
				fragment_unnamed_9 = clamp(fragment_unnamed_9, 0.0f.xxx, 1.0f.xxx);
				fragment_unnamed_34 = fragment_unnamed_9 + 0.054999999701976776123046875f.xxx;
				fragment_unnamed_34 *= 0.947867333889007568359375f.xxx;
				fragment_unnamed_34 = log2(fragment_unnamed_34);
				fragment_unnamed_34 *= 2.400000095367431640625f.xxx;
				fragment_unnamed_34 = exp2(fragment_unnamed_34);
				fragment_unnamed_51 = fragment_unnamed_9 * 0.077399380505084991455078125f.xxx;
				fragment_unnamed_59 = bool4(float4(0.040449999272823333740234375f, 0.040449999272823333740234375f, 0.040449999272823333740234375f, 0.0f).x >= fragment_unnamed_9.xyzx.x, float4(0.040449999272823333740234375f, 0.040449999272823333740234375f, 0.040449999272823333740234375f, 0.0f).y >= fragment_unnamed_9.xyzx.y, float4(0.040449999272823333740234375f, 0.040449999272823333740234375f, 0.040449999272823333740234375f, 0.0f).z >= fragment_unnamed_9.xyzx.z, float4(0.040449999272823333740234375f, 0.040449999272823333740234375f, 0.040449999272823333740234375f, 0.0f).w >= fragment_unnamed_9.xyzx.w).xyz;
				float fragment_unnamed_73;
				if (fragment_unnamed_59.x)
				{
					fragment_unnamed_73 = fragment_unnamed_51.x;
				}
				else
				{
					fragment_unnamed_73 = fragment_unnamed_34.x;
				}
				fragment_unnamed_9.x = fragment_unnamed_73;
				float fragment_unnamed_87;
				if (fragment_unnamed_59.y)
				{
					fragment_unnamed_87 = fragment_unnamed_51.y;
				}
				else
				{
					fragment_unnamed_87 = fragment_unnamed_34.y;
				}
				fragment_unnamed_9.y = fragment_unnamed_87;
				float fragment_unnamed_100;
				if (fragment_unnamed_59.z)
				{
					fragment_unnamed_100 = fragment_unnamed_51.z;
				}
				else
				{
					fragment_unnamed_100 = fragment_unnamed_34.z;
				}
				fragment_unnamed_9.z = fragment_unnamed_100;
				fragment_unnamed_110 = fragment_unnamed_9.y * (-367.85711669921875f);
				fragment_unnamed_110 = (fragment_unnamed_9.x * (-367.85711669921875f)) + (-fragment_unnamed_110);
				fragment_unnamed_110 = (fragment_unnamed_9.z * 16511.744140625f) + fragment_unnamed_110;
				fragment_unnamed_34.z = fragment_unnamed_110 * 6.0796734032919630408287048339844e-05f;
				fragment_unnamed_34.z = clamp(fragment_unnamed_34.z, 0.0f, 1.0f);
				fragment_unnamed_110 = dot(fragment_unnamed_9.xy, float2(4833.0380859375f, 11677.1962890625f));
				fragment_unnamed_110 *= 6.0796734032919630408287048339844e-05f;
				float2 fragment_unnamed_146 = min(fragment_unnamed_110.xx, 1.0f.xx);
				fragment_unnamed_34 = float3(fragment_unnamed_146.x, fragment_unnamed_146.y, fragment_unnamed_34.z);
				fragment_unnamed_34 = (-fragment_unnamed_9) + fragment_unnamed_34;
				fragment_unnamed_9 = (_Params.xxx * fragment_unnamed_34) + fragment_unnamed_9;
				fragment_unnamed_34 = max(abs(fragment_unnamed_9), 1.1920928955078125e-07f.xxx);
				fragment_unnamed_34 = log2(fragment_unnamed_34);
				fragment_unnamed_34 *= 0.4166666567325592041015625f.xxx;
				fragment_unnamed_34 = exp2(fragment_unnamed_34);
				fragment_unnamed_34 = (fragment_unnamed_34 * 1.05499994754791259765625f.xxx) + (-0.054999999701976776123046875f).xxx;
				fragment_unnamed_51 = fragment_unnamed_9 * 12.9200000762939453125f.xxx;
				fragment_unnamed_59 = bool4(float4(0.003130800090730190277099609375f, 0.003130800090730190277099609375f, 0.003130800090730190277099609375f, 0.0f).x >= fragment_unnamed_9.xyzx.x, float4(0.003130800090730190277099609375f, 0.003130800090730190277099609375f, 0.003130800090730190277099609375f, 0.0f).y >= fragment_unnamed_9.xyzx.y, float4(0.003130800090730190277099609375f, 0.003130800090730190277099609375f, 0.003130800090730190277099609375f, 0.0f).z >= fragment_unnamed_9.xyzx.z, float4(0.003130800090730190277099609375f, 0.003130800090730190277099609375f, 0.003130800090730190277099609375f, 0.0f).w >= fragment_unnamed_9.xyzx.w).xyz;
				float fragment_unnamed_200;
				if (fragment_unnamed_59.x)
				{
					fragment_unnamed_200 = fragment_unnamed_51.x;
				}
				else
				{
					fragment_unnamed_200 = fragment_unnamed_34.x;
				}
				fragment_output_0.x = fragment_unnamed_200;
				float fragment_unnamed_213;
				if (fragment_unnamed_59.y)
				{
					fragment_unnamed_213 = fragment_unnamed_51.y;
				}
				else
				{
					fragment_unnamed_213 = fragment_unnamed_34.y;
				}
				fragment_output_0.y = fragment_unnamed_213;
				float fragment_unnamed_225;
				if (fragment_unnamed_59.z)
				{
					fragment_unnamed_225 = fragment_unnamed_51.z;
				}
				else
				{
					fragment_unnamed_225 = fragment_unnamed_34.z;
				}
				fragment_output_0.z = fragment_unnamed_225;
				fragment_output_0.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_0 = stage_input.fragment_input_0;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			float4 _Params;

			static float4 fragment_uniform_buffer_0[30];
			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

			static float2 fragment_input_1;
			static float2 fragment_input_1;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD; // TEXCOORD
				float2 fragment_input_1 : TEXCOORD1; // TEXCOORD_1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				float4 fragment_unnamed_39 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				float fragment_unnamed_46 = clamp(fragment_unnamed_39.x, 0.0f, 1.0f);
				float fragment_unnamed_47 = clamp(fragment_unnamed_39.y, 0.0f, 1.0f);
				float fragment_unnamed_48 = clamp(fragment_unnamed_39.z, 0.0f, 1.0f);
				precise float fragment_unnamed_49 = fragment_unnamed_46 + 0.054999999701976776123046875f;
				precise float fragment_unnamed_51 = fragment_unnamed_47 + 0.054999999701976776123046875f;
				precise float fragment_unnamed_52 = fragment_unnamed_48 + 0.054999999701976776123046875f;
				precise float fragment_unnamed_53 = fragment_unnamed_49 * 0.947867333889007568359375f;
				precise float fragment_unnamed_55 = fragment_unnamed_51 * 0.947867333889007568359375f;
				precise float fragment_unnamed_56 = fragment_unnamed_52 * 0.947867333889007568359375f;
				precise float fragment_unnamed_60 = log2(fragment_unnamed_53) * 2.400000095367431640625f;
				precise float fragment_unnamed_62 = log2(fragment_unnamed_55) * 2.400000095367431640625f;
				precise float fragment_unnamed_63 = log2(fragment_unnamed_56) * 2.400000095367431640625f;
				precise float fragment_unnamed_67 = fragment_unnamed_46 * 0.077399380505084991455078125f;
				precise float fragment_unnamed_69 = fragment_unnamed_47 * 0.077399380505084991455078125f;
				precise float fragment_unnamed_70 = fragment_unnamed_48 * 0.077399380505084991455078125f;
				float fragment_unnamed_83 = asfloat((0.040449999272823333740234375f >= fragment_unnamed_46) ? asuint(fragment_unnamed_67) : asuint(exp2(fragment_unnamed_60)));
				float fragment_unnamed_85 = asfloat((0.040449999272823333740234375f >= fragment_unnamed_47) ? asuint(fragment_unnamed_69) : asuint(exp2(fragment_unnamed_62)));
				float fragment_unnamed_87 = asfloat((0.040449999272823333740234375f >= fragment_unnamed_48) ? asuint(fragment_unnamed_70) : asuint(exp2(fragment_unnamed_63)));
				precise float fragment_unnamed_88 = fragment_unnamed_85 * (-367.85711669921875f);
				precise float fragment_unnamed_90 = (-0.0f) - fragment_unnamed_88;
				precise float fragment_unnamed_95 = mad(fragment_unnamed_87, 16511.744140625f, mad(fragment_unnamed_83, -367.85711669921875f, fragment_unnamed_90)) * 6.0796734032919630408287048339844e-05f;
				precise float fragment_unnamed_103 = dot(float2(fragment_unnamed_83, fragment_unnamed_85), float2(4833.0380859375f, 11677.1962890625f)) * 6.0796734032919630408287048339844e-05f;
				precise float fragment_unnamed_106 = (-0.0f) - fragment_unnamed_83;
				precise float fragment_unnamed_107 = (-0.0f) - fragment_unnamed_85;
				precise float fragment_unnamed_108 = (-0.0f) - fragment_unnamed_87;
				precise float fragment_unnamed_109 = fragment_unnamed_106 + min(fragment_unnamed_103, 1.0f);
				precise float fragment_unnamed_110 = fragment_unnamed_107 + min(fragment_unnamed_103, 1.0f);
				precise float fragment_unnamed_111 = fragment_unnamed_108 + clamp(fragment_unnamed_95, 0.0f, 1.0f);
				float fragment_unnamed_117 = mad(fragment_uniform_buffer_0[29u].x, fragment_unnamed_109, fragment_unnamed_83);
				float fragment_unnamed_118 = mad(fragment_uniform_buffer_0[29u].x, fragment_unnamed_110, fragment_unnamed_85);
				float fragment_unnamed_119 = mad(fragment_uniform_buffer_0[29u].x, fragment_unnamed_111, fragment_unnamed_87);
				precise float fragment_unnamed_130 = log2(max(abs(fragment_unnamed_117), 1.1920928955078125e-07f)) * 0.4166666567325592041015625f;
				precise float fragment_unnamed_132 = log2(max(abs(fragment_unnamed_118), 1.1920928955078125e-07f)) * 0.4166666567325592041015625f;
				precise float fragment_unnamed_133 = log2(max(abs(fragment_unnamed_119), 1.1920928955078125e-07f)) * 0.4166666567325592041015625f;
				precise float fragment_unnamed_142 = fragment_unnamed_117 * 12.9200000762939453125f;
				precise float fragment_unnamed_144 = fragment_unnamed_118 * 12.9200000762939453125f;
				precise float fragment_unnamed_145 = fragment_unnamed_119 * 12.9200000762939453125f;
				fragment_output_0.x = (0.003130800090730190277099609375f >= fragment_unnamed_117) ? fragment_unnamed_142 : mad(exp2(fragment_unnamed_130), 1.05499994754791259765625f, -0.054999999701976776123046875f);
				fragment_output_0.y = (0.003130800090730190277099609375f >= fragment_unnamed_118) ? fragment_unnamed_144 : mad(exp2(fragment_unnamed_132), 1.05499994754791259765625f, -0.054999999701976776123046875f);
				fragment_output_0.z = (0.003130800090730190277099609375f >= fragment_unnamed_119) ? fragment_unnamed_145 : mad(exp2(fragment_unnamed_133), 1.05499994754791259765625f, -0.054999999701976776123046875f);
				fragment_output_0.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[29] = float4(_Params[0], _Params[1], _Params[2], _Params[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			ENDHLSL
		}
		Pass
		{
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 364523

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.0


			float _RenderViewportScaleFactor;

			static float4 vertex_uniform_buffer_0[27];
			static float4 gl_Position;
			static float3 vertex_input_0;
			static float2 vertex_output_1;
			static float2 vertex_output_1;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				float2 vertex_output_1 : TEXCOORD1; // TEXCOORD_1
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				gl_Position.x = vertex_input_0.x;
				gl_Position.y = vertex_input_0.y;
				gl_Position.z = 0.0f;
				gl_Position.w = 1.0f;
				precise float vertex_unnamed_42 = vertex_input_0.x + 1.0f;
				precise float vertex_unnamed_43 = vertex_input_0.y + 1.0f;
				precise float vertex_unnamed_54 = mad(vertex_unnamed_42, 0.5f, 0.0f) * vertex_uniform_buffer_0[26u].x;
				precise float vertex_unnamed_55 = mad(vertex_unnamed_43, -0.5f, 1.0f) * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.x = vertex_unnamed_54;
				vertex_output_1.y = vertex_unnamed_55;
				vertex_output_1.x = mad(vertex_input_0.x, 0.5f, 0.5f);
				vertex_output_1.y = mad(vertex_input_0.y, -0.5f, 0.5f);
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, vertex_uniform_buffer_0[26][1], vertex_uniform_buffer_0[26][2], vertex_uniform_buffer_0[26][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}


			float _RenderViewportScaleFactor;

			static float4 gl_Position;
			static float3 vertex_input_0;
			static float2 vertex_output_0;
			static float2 vertex_output_1;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION;
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_0 : TEXCOORD1; // vs_TEXCOORD1
				float2 vertex_output_1 : TEXCOORD0; // vs_TEXCOORD0
				float4 gl_Position : SV_Position;
			};

			static float2 vertex_unnamed_33;

			void vert_main()
			{
				gl_Position = float4(vertex_input_0.xy.x, vertex_input_0.xy.y, gl_Position.z, gl_Position.w);
				gl_Position = float4(gl_Position.x, gl_Position.y, float2(0.0f, 1.0f).x, float2(0.0f, 1.0f).y);
				vertex_unnamed_33 = vertex_input_0.xy + 1.0f.xx;
				vertex_unnamed_33 = (vertex_unnamed_33 * float2(0.5f, -0.5f)) + float2(0.0f, 1.0f);
				vertex_output_0 = vertex_unnamed_33 * _RenderViewportScaleFactor.xx;
				vertex_output_1 = (vertex_input_0.xy * float2(0.5f, -0.5f)) + 0.5f.xx;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_0 = vertex_output_0;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}

			float4 _Params;

			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

			static float2 fragment_input_0;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_0 : TEXCOORD1; // vs_TEXCOORD1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static float3 fragment_unnamed_9;
			static float3 fragment_unnamed_34;
			static float3 fragment_unnamed_51;
			static bool3 fragment_unnamed_59;
			static float fragment_unnamed_110;

			void frag_main()
			{
				fragment_unnamed_9 = _MainTex.Sample(sampler_MainTex, fragment_input_0).xyz;
				fragment_unnamed_9 = fragment_unnamed_9;
				fragment_unnamed_9 = clamp(fragment_unnamed_9, 0.0f.xxx, 1.0f.xxx);
				fragment_unnamed_34 = fragment_unnamed_9 + 0.054999999701976776123046875f.xxx;
				fragment_unnamed_34 *= 0.947867333889007568359375f.xxx;
				fragment_unnamed_34 = log2(fragment_unnamed_34);
				fragment_unnamed_34 *= 2.400000095367431640625f.xxx;
				fragment_unnamed_34 = exp2(fragment_unnamed_34);
				fragment_unnamed_51 = fragment_unnamed_9 * 0.077399380505084991455078125f.xxx;
				fragment_unnamed_59 = bool4(float4(0.040449999272823333740234375f, 0.040449999272823333740234375f, 0.040449999272823333740234375f, 0.0f).x >= fragment_unnamed_9.xyzx.x, float4(0.040449999272823333740234375f, 0.040449999272823333740234375f, 0.040449999272823333740234375f, 0.0f).y >= fragment_unnamed_9.xyzx.y, float4(0.040449999272823333740234375f, 0.040449999272823333740234375f, 0.040449999272823333740234375f, 0.0f).z >= fragment_unnamed_9.xyzx.z, float4(0.040449999272823333740234375f, 0.040449999272823333740234375f, 0.040449999272823333740234375f, 0.0f).w >= fragment_unnamed_9.xyzx.w).xyz;
				float fragment_unnamed_73;
				if (fragment_unnamed_59.x)
				{
					fragment_unnamed_73 = fragment_unnamed_51.x;
				}
				else
				{
					fragment_unnamed_73 = fragment_unnamed_34.x;
				}
				fragment_unnamed_9.x = fragment_unnamed_73;
				float fragment_unnamed_87;
				if (fragment_unnamed_59.y)
				{
					fragment_unnamed_87 = fragment_unnamed_51.y;
				}
				else
				{
					fragment_unnamed_87 = fragment_unnamed_34.y;
				}
				fragment_unnamed_9.y = fragment_unnamed_87;
				float fragment_unnamed_100;
				if (fragment_unnamed_59.z)
				{
					fragment_unnamed_100 = fragment_unnamed_51.z;
				}
				else
				{
					fragment_unnamed_100 = fragment_unnamed_34.z;
				}
				fragment_unnamed_9.z = fragment_unnamed_100;
				fragment_unnamed_110 = fragment_unnamed_9.y * 66.0126495361328125f;
				fragment_unnamed_110 = (fragment_unnamed_9.x * 66.0126495361328125f) + (-fragment_unnamed_110);
				fragment_unnamed_110 = (fragment_unnamed_9.z * 16511.744140625f) + fragment_unnamed_110;
				fragment_unnamed_34.z = fragment_unnamed_110 * 6.0796734032919630408287048339844e-05f;
				fragment_unnamed_34.z = clamp(fragment_unnamed_34.z, 0.0f, 1.0f);
				fragment_unnamed_110 = dot(fragment_unnamed_9.xy, float2(1855.9146728515625f, 14655.830078125f));
				fragment_unnamed_110 *= 6.0796734032919630408287048339844e-05f;
				float2 fragment_unnamed_146 = min(fragment_unnamed_110.xx, 1.0f.xx);
				fragment_unnamed_34 = float3(fragment_unnamed_146.x, fragment_unnamed_146.y, fragment_unnamed_34.z);
				fragment_unnamed_34 = (-fragment_unnamed_9) + fragment_unnamed_34;
				fragment_unnamed_9 = (_Params.xxx * fragment_unnamed_34) + fragment_unnamed_9;
				fragment_unnamed_34 = max(abs(fragment_unnamed_9), 1.1920928955078125e-07f.xxx);
				fragment_unnamed_34 = log2(fragment_unnamed_34);
				fragment_unnamed_34 *= 0.4166666567325592041015625f.xxx;
				fragment_unnamed_34 = exp2(fragment_unnamed_34);
				fragment_unnamed_34 = (fragment_unnamed_34 * 1.05499994754791259765625f.xxx) + (-0.054999999701976776123046875f).xxx;
				fragment_unnamed_51 = fragment_unnamed_9 * 12.9200000762939453125f.xxx;
				fragment_unnamed_59 = bool4(float4(0.003130800090730190277099609375f, 0.003130800090730190277099609375f, 0.003130800090730190277099609375f, 0.0f).x >= fragment_unnamed_9.xyzx.x, float4(0.003130800090730190277099609375f, 0.003130800090730190277099609375f, 0.003130800090730190277099609375f, 0.0f).y >= fragment_unnamed_9.xyzx.y, float4(0.003130800090730190277099609375f, 0.003130800090730190277099609375f, 0.003130800090730190277099609375f, 0.0f).z >= fragment_unnamed_9.xyzx.z, float4(0.003130800090730190277099609375f, 0.003130800090730190277099609375f, 0.003130800090730190277099609375f, 0.0f).w >= fragment_unnamed_9.xyzx.w).xyz;
				float fragment_unnamed_200;
				if (fragment_unnamed_59.x)
				{
					fragment_unnamed_200 = fragment_unnamed_51.x;
				}
				else
				{
					fragment_unnamed_200 = fragment_unnamed_34.x;
				}
				fragment_output_0.x = fragment_unnamed_200;
				float fragment_unnamed_213;
				if (fragment_unnamed_59.y)
				{
					fragment_unnamed_213 = fragment_unnamed_51.y;
				}
				else
				{
					fragment_unnamed_213 = fragment_unnamed_34.y;
				}
				fragment_output_0.y = fragment_unnamed_213;
				float fragment_unnamed_225;
				if (fragment_unnamed_59.z)
				{
					fragment_unnamed_225 = fragment_unnamed_51.z;
				}
				else
				{
					fragment_unnamed_225 = fragment_unnamed_34.z;
				}
				fragment_output_0.z = fragment_unnamed_225;
				fragment_output_0.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_0 = stage_input.fragment_input_0;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			float4 _Params;

			static float4 fragment_uniform_buffer_0[30];
			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

			static float2 fragment_input_1;
			static float2 fragment_input_1;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD; // TEXCOORD
				float2 fragment_input_1 : TEXCOORD1; // TEXCOORD_1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				float4 fragment_unnamed_39 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				float fragment_unnamed_46 = clamp(fragment_unnamed_39.x, 0.0f, 1.0f);
				float fragment_unnamed_47 = clamp(fragment_unnamed_39.y, 0.0f, 1.0f);
				float fragment_unnamed_48 = clamp(fragment_unnamed_39.z, 0.0f, 1.0f);
				precise float fragment_unnamed_49 = fragment_unnamed_46 + 0.054999999701976776123046875f;
				precise float fragment_unnamed_51 = fragment_unnamed_47 + 0.054999999701976776123046875f;
				precise float fragment_unnamed_52 = fragment_unnamed_48 + 0.054999999701976776123046875f;
				precise float fragment_unnamed_53 = fragment_unnamed_49 * 0.947867333889007568359375f;
				precise float fragment_unnamed_55 = fragment_unnamed_51 * 0.947867333889007568359375f;
				precise float fragment_unnamed_56 = fragment_unnamed_52 * 0.947867333889007568359375f;
				precise float fragment_unnamed_60 = log2(fragment_unnamed_53) * 2.400000095367431640625f;
				precise float fragment_unnamed_62 = log2(fragment_unnamed_55) * 2.400000095367431640625f;
				precise float fragment_unnamed_63 = log2(fragment_unnamed_56) * 2.400000095367431640625f;
				precise float fragment_unnamed_67 = fragment_unnamed_46 * 0.077399380505084991455078125f;
				precise float fragment_unnamed_69 = fragment_unnamed_47 * 0.077399380505084991455078125f;
				precise float fragment_unnamed_70 = fragment_unnamed_48 * 0.077399380505084991455078125f;
				float fragment_unnamed_83 = asfloat((0.040449999272823333740234375f >= fragment_unnamed_46) ? asuint(fragment_unnamed_67) : asuint(exp2(fragment_unnamed_60)));
				float fragment_unnamed_85 = asfloat((0.040449999272823333740234375f >= fragment_unnamed_47) ? asuint(fragment_unnamed_69) : asuint(exp2(fragment_unnamed_62)));
				float fragment_unnamed_87 = asfloat((0.040449999272823333740234375f >= fragment_unnamed_48) ? asuint(fragment_unnamed_70) : asuint(exp2(fragment_unnamed_63)));
				precise float fragment_unnamed_88 = fragment_unnamed_85 * 66.0126495361328125f;
				precise float fragment_unnamed_90 = (-0.0f) - fragment_unnamed_88;
				precise float fragment_unnamed_95 = mad(fragment_unnamed_87, 16511.744140625f, mad(fragment_unnamed_83, 66.0126495361328125f, fragment_unnamed_90)) * 6.0796734032919630408287048339844e-05f;
				precise float fragment_unnamed_103 = dot(float2(fragment_unnamed_83, fragment_unnamed_85), float2(1855.9146728515625f, 14655.830078125f)) * 6.0796734032919630408287048339844e-05f;
				precise float fragment_unnamed_106 = (-0.0f) - fragment_unnamed_83;
				precise float fragment_unnamed_107 = (-0.0f) - fragment_unnamed_85;
				precise float fragment_unnamed_108 = (-0.0f) - fragment_unnamed_87;
				precise float fragment_unnamed_109 = fragment_unnamed_106 + min(fragment_unnamed_103, 1.0f);
				precise float fragment_unnamed_110 = fragment_unnamed_107 + min(fragment_unnamed_103, 1.0f);
				precise float fragment_unnamed_111 = fragment_unnamed_108 + clamp(fragment_unnamed_95, 0.0f, 1.0f);
				float fragment_unnamed_117 = mad(fragment_uniform_buffer_0[29u].x, fragment_unnamed_109, fragment_unnamed_83);
				float fragment_unnamed_118 = mad(fragment_uniform_buffer_0[29u].x, fragment_unnamed_110, fragment_unnamed_85);
				float fragment_unnamed_119 = mad(fragment_uniform_buffer_0[29u].x, fragment_unnamed_111, fragment_unnamed_87);
				precise float fragment_unnamed_130 = log2(max(abs(fragment_unnamed_117), 1.1920928955078125e-07f)) * 0.4166666567325592041015625f;
				precise float fragment_unnamed_132 = log2(max(abs(fragment_unnamed_118), 1.1920928955078125e-07f)) * 0.4166666567325592041015625f;
				precise float fragment_unnamed_133 = log2(max(abs(fragment_unnamed_119), 1.1920928955078125e-07f)) * 0.4166666567325592041015625f;
				precise float fragment_unnamed_142 = fragment_unnamed_117 * 12.9200000762939453125f;
				precise float fragment_unnamed_144 = fragment_unnamed_118 * 12.9200000762939453125f;
				precise float fragment_unnamed_145 = fragment_unnamed_119 * 12.9200000762939453125f;
				fragment_output_0.x = (0.003130800090730190277099609375f >= fragment_unnamed_117) ? fragment_unnamed_142 : mad(exp2(fragment_unnamed_130), 1.05499994754791259765625f, -0.054999999701976776123046875f);
				fragment_output_0.y = (0.003130800090730190277099609375f >= fragment_unnamed_118) ? fragment_unnamed_144 : mad(exp2(fragment_unnamed_132), 1.05499994754791259765625f, -0.054999999701976776123046875f);
				fragment_output_0.z = (0.003130800090730190277099609375f >= fragment_unnamed_119) ? fragment_unnamed_145 : mad(exp2(fragment_unnamed_133), 1.05499994754791259765625f, -0.054999999701976776123046875f);
				fragment_output_0.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[29] = float4(_Params[0], _Params[1], _Params[2], _Params[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			ENDHLSL
		}
		Pass
		{
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 452096

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.0


			float _RenderViewportScaleFactor;

			static float4 vertex_uniform_buffer_0[27];
			static float4 gl_Position;
			static float3 vertex_input_0;
			static float2 vertex_output_1;
			static float2 vertex_output_1;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				float2 vertex_output_1 : TEXCOORD1; // TEXCOORD_1
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				gl_Position.x = vertex_input_0.x;
				gl_Position.y = vertex_input_0.y;
				gl_Position.z = 0.0f;
				gl_Position.w = 1.0f;
				precise float vertex_unnamed_42 = vertex_input_0.x + 1.0f;
				precise float vertex_unnamed_43 = vertex_input_0.y + 1.0f;
				precise float vertex_unnamed_54 = mad(vertex_unnamed_42, 0.5f, 0.0f) * vertex_uniform_buffer_0[26u].x;
				precise float vertex_unnamed_55 = mad(vertex_unnamed_43, -0.5f, 1.0f) * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.x = vertex_unnamed_54;
				vertex_output_1.y = vertex_unnamed_55;
				vertex_output_1.x = mad(vertex_input_0.x, 0.5f, 0.5f);
				vertex_output_1.y = mad(vertex_input_0.y, -0.5f, 0.5f);
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, vertex_uniform_buffer_0[26][1], vertex_uniform_buffer_0[26][2], vertex_uniform_buffer_0[26][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}


			float _RenderViewportScaleFactor;

			static float4 gl_Position;
			static float3 vertex_input_0;
			static float2 vertex_output_0;
			static float2 vertex_output_1;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION;
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_0 : TEXCOORD1; // vs_TEXCOORD1
				float2 vertex_output_1 : TEXCOORD0; // vs_TEXCOORD0
				float4 gl_Position : SV_Position;
			};

			static float2 vertex_unnamed_33;

			void vert_main()
			{
				gl_Position = float4(vertex_input_0.xy.x, vertex_input_0.xy.y, gl_Position.z, gl_Position.w);
				gl_Position = float4(gl_Position.x, gl_Position.y, float2(0.0f, 1.0f).x, float2(0.0f, 1.0f).y);
				vertex_unnamed_33 = vertex_input_0.xy + 1.0f.xx;
				vertex_unnamed_33 = (vertex_unnamed_33 * float2(0.5f, -0.5f)) + float2(0.0f, 1.0f);
				vertex_output_0 = vertex_unnamed_33 * _RenderViewportScaleFactor.xx;
				vertex_output_1 = (vertex_input_0.xy * float2(0.5f, -0.5f)) + 0.5f.xx;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_0 = vertex_output_0;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}

			float4 _Params;

			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

			static float2 fragment_input_0;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_0 : TEXCOORD1; // vs_TEXCOORD1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static float3 fragment_unnamed_9;
			static float4 fragment_unnamed_35;
			static float3 fragment_unnamed_66;
			static bool3 fragment_unnamed_74;
			static float fragment_unnamed_125;
			static float fragment_unnamed_154;
			static bool fragment_unnamed_162;
			static float2 fragment_unnamed_168;
			static float fragment_unnamed_178;
			static float3 fragment_unnamed_203;

			void frag_main()
			{
				fragment_unnamed_9 = _MainTex.Sample(sampler_MainTex, fragment_input_0).xyz;
				fragment_unnamed_9 = fragment_unnamed_9;
				fragment_unnamed_9 = clamp(fragment_unnamed_9, 0.0f.xxx, 1.0f.xxx);
				float3 fragment_unnamed_39 = fragment_unnamed_9 + 0.054999999701976776123046875f.xxx;
				fragment_unnamed_35 = float4(fragment_unnamed_39.x, fragment_unnamed_39.y, fragment_unnamed_39.z, fragment_unnamed_35.w);
				float3 fragment_unnamed_46 = fragment_unnamed_35.xyz * 0.947867333889007568359375f.xxx;
				fragment_unnamed_35 = float4(fragment_unnamed_46.x, fragment_unnamed_46.y, fragment_unnamed_46.z, fragment_unnamed_35.w);
				float3 fragment_unnamed_51 = log2(fragment_unnamed_35.xyz);
				fragment_unnamed_35 = float4(fragment_unnamed_51.x, fragment_unnamed_51.y, fragment_unnamed_51.z, fragment_unnamed_35.w);
				float3 fragment_unnamed_58 = fragment_unnamed_35.xyz * 2.400000095367431640625f.xxx;
				fragment_unnamed_35 = float4(fragment_unnamed_58.x, fragment_unnamed_58.y, fragment_unnamed_58.z, fragment_unnamed_35.w);
				float3 fragment_unnamed_63 = exp2(fragment_unnamed_35.xyz);
				fragment_unnamed_35 = float4(fragment_unnamed_63.x, fragment_unnamed_63.y, fragment_unnamed_63.z, fragment_unnamed_35.w);
				fragment_unnamed_66 = fragment_unnamed_9 * 0.077399380505084991455078125f.xxx;
				fragment_unnamed_74 = bool4(float4(0.040449999272823333740234375f, 0.040449999272823333740234375f, 0.040449999272823333740234375f, 0.0f).x >= fragment_unnamed_9.xyzx.x, float4(0.040449999272823333740234375f, 0.040449999272823333740234375f, 0.040449999272823333740234375f, 0.0f).y >= fragment_unnamed_9.xyzx.y, float4(0.040449999272823333740234375f, 0.040449999272823333740234375f, 0.040449999272823333740234375f, 0.0f).z >= fragment_unnamed_9.xyzx.z, float4(0.040449999272823333740234375f, 0.040449999272823333740234375f, 0.040449999272823333740234375f, 0.0f).w >= fragment_unnamed_9.xyzx.w).xyz;
				float fragment_unnamed_88;
				if (fragment_unnamed_74.x)
				{
					fragment_unnamed_88 = fragment_unnamed_66.x;
				}
				else
				{
					fragment_unnamed_88 = fragment_unnamed_35.x;
				}
				fragment_unnamed_9.x = fragment_unnamed_88;
				float fragment_unnamed_102;
				if (fragment_unnamed_74.y)
				{
					fragment_unnamed_102 = fragment_unnamed_66.y;
				}
				else
				{
					fragment_unnamed_102 = fragment_unnamed_35.y;
				}
				fragment_unnamed_9.y = fragment_unnamed_102;
				float fragment_unnamed_115;
				if (fragment_unnamed_74.z)
				{
					fragment_unnamed_115 = fragment_unnamed_66.z;
				}
				else
				{
					fragment_unnamed_115 = fragment_unnamed_35.z;
				}
				fragment_unnamed_9.z = fragment_unnamed_115;
				fragment_unnamed_125 = dot(fragment_unnamed_9, float3(2.4325101375579833984375f, 11.468845367431640625f, 1.76049244403839111328125f));
				fragment_unnamed_35 = fragment_unnamed_125.xxxx * float4(0.0077822203747928142547607421875f, 5.9847738157259300351142883300781e-05f, -0.00032898582867346704006195068359375f, 0.232164323329925537109375f);
				float2 fragment_unnamed_145 = fragment_unnamed_125.xx * float2(0.1378665268421173095703125f, 0.0093313641846179962158203125f);
				fragment_unnamed_66 = float3(fragment_unnamed_145.x, fragment_unnamed_145.y, fragment_unnamed_66.z);
				fragment_unnamed_125 = dot(fragment_unnamed_9, float3(6.501978397369384765625f, 11.0320301055908203125f, 1.2238409519195556640625f));
				fragment_unnamed_154 = fragment_unnamed_125 * 0.0077822203747928142547607421875f;
				fragment_unnamed_35.x /= fragment_unnamed_154;
				fragment_unnamed_162 = fragment_unnamed_35.x < 0.834949016571044921875f;
				fragment_unnamed_168 = (fragment_unnamed_125.xx * float2(-4.5894175855210050940513610839844e-06f, 0.00019840833556372672319412231445312f)) + fragment_unnamed_35.yz;
				fragment_unnamed_178 = (fragment_unnamed_125 * 0.2399325072765350341796875f) + (-fragment_unnamed_35.w);
				fragment_unnamed_168 *= float2(98.8431854248046875f, -58.80513763427734375f);
				float fragment_unnamed_193;
				if (fragment_unnamed_162)
				{
					fragment_unnamed_193 = fragment_unnamed_168.x;
				}
				else
				{
					fragment_unnamed_193 = fragment_unnamed_168.y;
				}
				fragment_unnamed_35.x = fragment_unnamed_193;
				fragment_unnamed_203.x = (fragment_unnamed_35.x * 1.61047399044036865234375f) + fragment_unnamed_178;
				fragment_unnamed_203.x = clamp(fragment_unnamed_203.x, 0.0f, 1.0f);
				fragment_unnamed_168.x = (fragment_unnamed_125 * (-0.050440214574337005615234375f)) + fragment_unnamed_66.x;
				fragment_unnamed_125 = (fragment_unnamed_125 * (-0.00292370258830487728118896484375f)) + (-fragment_unnamed_66.y);
				fragment_unnamed_203.z = (fragment_unnamed_35.x * 14.273845672607421875f) + fragment_unnamed_125;
				fragment_unnamed_203.z = clamp(fragment_unnamed_203.z, 0.0f, 1.0f);
				fragment_unnamed_203.y = ((-fragment_unnamed_35.x) * 2.532641887664794921875f) + fragment_unnamed_168.x;
				fragment_unnamed_203.y = clamp(fragment_unnamed_203.y, 0.0f, 1.0f);
				float3 fragment_unnamed_256 = (-fragment_unnamed_9) + fragment_unnamed_203;
				fragment_unnamed_35 = float4(fragment_unnamed_256.x, fragment_unnamed_256.y, fragment_unnamed_256.z, fragment_unnamed_35.w);
				fragment_unnamed_9 = (_Params.xxx * fragment_unnamed_35.xyz) + fragment_unnamed_9;
				float3 fragment_unnamed_277 = max(abs(fragment_unnamed_9), 1.1920928955078125e-07f.xxx);
				fragment_unnamed_35 = float4(fragment_unnamed_277.x, fragment_unnamed_277.y, fragment_unnamed_277.z, fragment_unnamed_35.w);
				float3 fragment_unnamed_282 = log2(fragment_unnamed_35.xyz);
				fragment_unnamed_35 = float4(fragment_unnamed_282.x, fragment_unnamed_282.y, fragment_unnamed_282.z, fragment_unnamed_35.w);
				float3 fragment_unnamed_289 = fragment_unnamed_35.xyz * 0.4166666567325592041015625f.xxx;
				fragment_unnamed_35 = float4(fragment_unnamed_289.x, fragment_unnamed_289.y, fragment_unnamed_289.z, fragment_unnamed_35.w);
				float3 fragment_unnamed_294 = exp2(fragment_unnamed_35.xyz);
				fragment_unnamed_35 = float4(fragment_unnamed_294.x, fragment_unnamed_294.y, fragment_unnamed_294.z, fragment_unnamed_35.w);
				float3 fragment_unnamed_304 = (fragment_unnamed_35.xyz * 1.05499994754791259765625f.xxx) + (-0.054999999701976776123046875f).xxx;
				fragment_unnamed_35 = float4(fragment_unnamed_304.x, fragment_unnamed_304.y, fragment_unnamed_304.z, fragment_unnamed_35.w);
				fragment_unnamed_66 = fragment_unnamed_9 * 12.9200000762939453125f.xxx;
				fragment_unnamed_74 = bool4(float4(0.003130800090730190277099609375f, 0.003130800090730190277099609375f, 0.003130800090730190277099609375f, 0.0f).x >= fragment_unnamed_9.xyzx.x, float4(0.003130800090730190277099609375f, 0.003130800090730190277099609375f, 0.003130800090730190277099609375f, 0.0f).y >= fragment_unnamed_9.xyzx.y, float4(0.003130800090730190277099609375f, 0.003130800090730190277099609375f, 0.003130800090730190277099609375f, 0.0f).z >= fragment_unnamed_9.xyzx.z, float4(0.003130800090730190277099609375f, 0.003130800090730190277099609375f, 0.003130800090730190277099609375f, 0.0f).w >= fragment_unnamed_9.xyzx.w).xyz;
				float fragment_unnamed_321;
				if (fragment_unnamed_74.x)
				{
					fragment_unnamed_321 = fragment_unnamed_66.x;
				}
				else
				{
					fragment_unnamed_321 = fragment_unnamed_35.x;
				}
				fragment_output_0.x = fragment_unnamed_321;
				float fragment_unnamed_334;
				if (fragment_unnamed_74.y)
				{
					fragment_unnamed_334 = fragment_unnamed_66.y;
				}
				else
				{
					fragment_unnamed_334 = fragment_unnamed_35.y;
				}
				fragment_output_0.y = fragment_unnamed_334;
				float fragment_unnamed_346;
				if (fragment_unnamed_74.z)
				{
					fragment_unnamed_346 = fragment_unnamed_66.z;
				}
				else
				{
					fragment_unnamed_346 = fragment_unnamed_35.z;
				}
				fragment_output_0.z = fragment_unnamed_346;
				fragment_output_0.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_0 = stage_input.fragment_input_0;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			float4 _Params;

			static float4 fragment_uniform_buffer_0[30];
			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

			static float2 fragment_input_1;
			static float2 fragment_input_1;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD; // TEXCOORD
				float2 fragment_input_1 : TEXCOORD1; // TEXCOORD_1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				float4 fragment_unnamed_39 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				float fragment_unnamed_46 = clamp(fragment_unnamed_39.x, 0.0f, 1.0f);
				float fragment_unnamed_47 = clamp(fragment_unnamed_39.y, 0.0f, 1.0f);
				float fragment_unnamed_48 = clamp(fragment_unnamed_39.z, 0.0f, 1.0f);
				precise float fragment_unnamed_49 = fragment_unnamed_46 + 0.054999999701976776123046875f;
				precise float fragment_unnamed_51 = fragment_unnamed_47 + 0.054999999701976776123046875f;
				precise float fragment_unnamed_52 = fragment_unnamed_48 + 0.054999999701976776123046875f;
				precise float fragment_unnamed_53 = fragment_unnamed_49 * 0.947867333889007568359375f;
				precise float fragment_unnamed_55 = fragment_unnamed_51 * 0.947867333889007568359375f;
				precise float fragment_unnamed_56 = fragment_unnamed_52 * 0.947867333889007568359375f;
				precise float fragment_unnamed_60 = log2(fragment_unnamed_53) * 2.400000095367431640625f;
				precise float fragment_unnamed_62 = log2(fragment_unnamed_55) * 2.400000095367431640625f;
				precise float fragment_unnamed_63 = log2(fragment_unnamed_56) * 2.400000095367431640625f;
				precise float fragment_unnamed_67 = fragment_unnamed_46 * 0.077399380505084991455078125f;
				precise float fragment_unnamed_69 = fragment_unnamed_47 * 0.077399380505084991455078125f;
				precise float fragment_unnamed_70 = fragment_unnamed_48 * 0.077399380505084991455078125f;
				float fragment_unnamed_83 = asfloat((0.040449999272823333740234375f >= fragment_unnamed_46) ? asuint(fragment_unnamed_67) : asuint(exp2(fragment_unnamed_60)));
				float fragment_unnamed_85 = asfloat((0.040449999272823333740234375f >= fragment_unnamed_47) ? asuint(fragment_unnamed_69) : asuint(exp2(fragment_unnamed_62)));
				float fragment_unnamed_87 = asfloat((0.040449999272823333740234375f >= fragment_unnamed_48) ? asuint(fragment_unnamed_70) : asuint(exp2(fragment_unnamed_63)));
				float fragment_unnamed_88 = dot(float3(fragment_unnamed_83, fragment_unnamed_85, fragment_unnamed_87), float3(2.4325101375579833984375f, 11.468845367431640625f, 1.76049244403839111328125f));
				precise float fragment_unnamed_95 = fragment_unnamed_88 * 0.0077822203747928142547607421875f;
				precise float fragment_unnamed_97 = fragment_unnamed_88 * 5.9847738157259300351142883300781e-05f;
				precise float fragment_unnamed_99 = fragment_unnamed_88 * (-0.00032898582867346704006195068359375f);
				precise float fragment_unnamed_101 = fragment_unnamed_88 * 0.232164323329925537109375f;
				precise float fragment_unnamed_103 = fragment_unnamed_88 * 0.1378665268421173095703125f;
				precise float fragment_unnamed_105 = fragment_unnamed_88 * 0.0093313641846179962158203125f;
				float fragment_unnamed_107 = dot(float3(fragment_unnamed_83, fragment_unnamed_85, fragment_unnamed_87), float3(6.501978397369384765625f, 11.0320301055908203125f, 1.2238409519195556640625f));
				precise float fragment_unnamed_113 = fragment_unnamed_107 * 0.0077822203747928142547607421875f;
				precise float fragment_unnamed_114 = fragment_unnamed_95 / fragment_unnamed_113;
				precise float fragment_unnamed_121 = (-0.0f) - fragment_unnamed_101;
				precise float fragment_unnamed_125 = mad(fragment_unnamed_107, -4.5894175855210050940513610839844e-06f, fragment_unnamed_97) * 98.8431854248046875f;
				precise float fragment_unnamed_127 = mad(fragment_unnamed_107, 0.00019840833556372672319412231445312f, fragment_unnamed_99) * (-58.80513763427734375f);
				float fragment_unnamed_132 = asfloat((fragment_unnamed_114 < 0.834949016571044921875f) ? asuint(fragment_unnamed_125) : asuint(fragment_unnamed_127));
				precise float fragment_unnamed_138 = (-0.0f) - fragment_unnamed_105;
				precise float fragment_unnamed_144 = (-0.0f) - fragment_unnamed_132;
				precise float fragment_unnamed_148 = (-0.0f) - fragment_unnamed_83;
				precise float fragment_unnamed_149 = (-0.0f) - fragment_unnamed_85;
				precise float fragment_unnamed_150 = (-0.0f) - fragment_unnamed_87;
				precise float fragment_unnamed_151 = fragment_unnamed_148 + clamp(mad(fragment_unnamed_132, 1.61047399044036865234375f, mad(fragment_unnamed_107, 0.2399325072765350341796875f, fragment_unnamed_121)), 0.0f, 1.0f);
				precise float fragment_unnamed_152 = fragment_unnamed_149 + clamp(mad(fragment_unnamed_144, 2.532641887664794921875f, mad(fragment_unnamed_107, -0.050440214574337005615234375f, fragment_unnamed_103)), 0.0f, 1.0f);
				precise float fragment_unnamed_153 = fragment_unnamed_150 + clamp(mad(fragment_unnamed_132, 14.273845672607421875f, mad(fragment_unnamed_107, -0.00292370258830487728118896484375f, fragment_unnamed_138)), 0.0f, 1.0f);
				float fragment_unnamed_159 = mad(fragment_uniform_buffer_0[29u].x, fragment_unnamed_151, fragment_unnamed_83);
				float fragment_unnamed_160 = mad(fragment_uniform_buffer_0[29u].x, fragment_unnamed_152, fragment_unnamed_85);
				float fragment_unnamed_161 = mad(fragment_uniform_buffer_0[29u].x, fragment_unnamed_153, fragment_unnamed_87);
				precise float fragment_unnamed_172 = log2(max(abs(fragment_unnamed_159), 1.1920928955078125e-07f)) * 0.4166666567325592041015625f;
				precise float fragment_unnamed_174 = log2(max(abs(fragment_unnamed_160), 1.1920928955078125e-07f)) * 0.4166666567325592041015625f;
				precise float fragment_unnamed_175 = log2(max(abs(fragment_unnamed_161), 1.1920928955078125e-07f)) * 0.4166666567325592041015625f;
				precise float fragment_unnamed_184 = fragment_unnamed_159 * 12.9200000762939453125f;
				precise float fragment_unnamed_186 = fragment_unnamed_160 * 12.9200000762939453125f;
				precise float fragment_unnamed_187 = fragment_unnamed_161 * 12.9200000762939453125f;
				fragment_output_0.x = (0.003130800090730190277099609375f >= fragment_unnamed_159) ? fragment_unnamed_184 : mad(exp2(fragment_unnamed_172), 1.05499994754791259765625f, -0.054999999701976776123046875f);
				fragment_output_0.y = (0.003130800090730190277099609375f >= fragment_unnamed_160) ? fragment_unnamed_186 : mad(exp2(fragment_unnamed_174), 1.05499994754791259765625f, -0.054999999701976776123046875f);
				fragment_output_0.z = (0.003130800090730190277099609375f >= fragment_unnamed_161) ? fragment_unnamed_187 : mad(exp2(fragment_unnamed_175), 1.05499994754791259765625f, -0.054999999701976776123046875f);
				fragment_output_0.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[29] = float4(_Params[0], _Params[1], _Params[2], _Params[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			ENDHLSL
		}
	}
}
