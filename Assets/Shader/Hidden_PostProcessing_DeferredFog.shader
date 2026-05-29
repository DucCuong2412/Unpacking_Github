Shader "Hidden/PostProcessing/DeferredFog"
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
			GpuProgramID 46045

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

			float4 _ProjectionParams;
			float4 unity_OrthoParams;
			float4 _ZBufferParams;
			float4 _FogColor;
			float3 _FogParams;

			Texture2D<float4> _CameraDepthTexture;
			SamplerState sampler_CameraDepthTexture;
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

			static float fragment_unnamed_8;
			static float fragment_unnamed_24;
			static float4 fragment_unnamed_88;
			static float4 fragment_unnamed_96;

			void frag_main()
			{
				fragment_unnamed_8 = (-unity_OrthoParams.w) + 1.0f;
				fragment_unnamed_24 = _CameraDepthTexture.Sample(sampler_CameraDepthTexture, fragment_input_0).x;
				fragment_unnamed_24 *= _ZBufferParams.x;
				fragment_unnamed_8 = (fragment_unnamed_8 * fragment_unnamed_24) + _ZBufferParams.y;
				fragment_unnamed_24 = ((-unity_OrthoParams.w) * fragment_unnamed_24) + 1.0f;
				fragment_unnamed_8 = fragment_unnamed_24 / fragment_unnamed_8;
				fragment_unnamed_8 = (fragment_unnamed_8 * _ProjectionParams.z) + (-_ProjectionParams.y);
				fragment_unnamed_8 *= _FogParams.x;
				fragment_unnamed_8 *= (-fragment_unnamed_8);
				fragment_unnamed_8 = exp2(fragment_unnamed_8);
				fragment_unnamed_8 = (-fragment_unnamed_8) + 1.0f;
				fragment_unnamed_88 = _MainTex.Sample(sampler_MainTex, fragment_input_0);
				fragment_unnamed_96 = (-fragment_unnamed_88) + _FogColor;
				fragment_output_0 = (fragment_unnamed_8.xxxx * fragment_unnamed_96) + fragment_unnamed_88;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_0 = stage_input.fragment_input_0;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			float4 _ProjectionParams;
			float4 unity_OrthoParams;
			float4 _ZBufferParams;
			float4 _FogColor;
			float3 _FogParams;

			static float4 fragment_uniform_buffer_0[30];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _CameraDepthTexture;
			SamplerState sampler_MainTex;
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
				precise float fragment_unnamed_39 = (-0.0f) - fragment_uniform_buffer_0[20u].w;
				precise float fragment_unnamed_41 = fragment_unnamed_39 + 1.0f;
				precise float fragment_unnamed_59 = _CameraDepthTexture.Sample(sampler_CameraDepthTexture, float2(fragment_input_1.x, fragment_input_1.y)).x * fragment_uniform_buffer_0[21u].x;
				precise float fragment_unnamed_68 = (-0.0f) - fragment_uniform_buffer_0[20u].w;
				precise float fragment_unnamed_70 = mad(fragment_unnamed_68, fragment_unnamed_59, 1.0f) / mad(fragment_unnamed_41, fragment_unnamed_59, fragment_uniform_buffer_0[21u].y);
				precise float fragment_unnamed_78 = (-0.0f) - fragment_uniform_buffer_0[17u].y;
				precise float fragment_unnamed_84 = mad(fragment_unnamed_70, fragment_uniform_buffer_0[17u].z, fragment_unnamed_78) * fragment_uniform_buffer_0[29u].x;
				precise float fragment_unnamed_85 = (-0.0f) - fragment_unnamed_84;
				precise float fragment_unnamed_86 = fragment_unnamed_84 * fragment_unnamed_85;
				precise float fragment_unnamed_88 = (-0.0f) - exp2(fragment_unnamed_86);
				precise float fragment_unnamed_89 = fragment_unnamed_88 + 1.0f;
				float4 fragment_unnamed_95 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				float fragment_unnamed_97 = fragment_unnamed_95.x;
				float fragment_unnamed_98 = fragment_unnamed_95.y;
				float fragment_unnamed_99 = fragment_unnamed_95.z;
				float fragment_unnamed_100 = fragment_unnamed_95.w;
				precise float fragment_unnamed_101 = (-0.0f) - fragment_unnamed_97;
				precise float fragment_unnamed_102 = (-0.0f) - fragment_unnamed_98;
				precise float fragment_unnamed_103 = (-0.0f) - fragment_unnamed_99;
				precise float fragment_unnamed_104 = (-0.0f) - fragment_unnamed_100;
				precise float fragment_unnamed_112 = fragment_unnamed_101 + fragment_uniform_buffer_0[28u].x;
				precise float fragment_unnamed_113 = fragment_unnamed_102 + fragment_uniform_buffer_0[28u].y;
				precise float fragment_unnamed_114 = fragment_unnamed_103 + fragment_uniform_buffer_0[28u].z;
				precise float fragment_unnamed_115 = fragment_unnamed_104 + fragment_uniform_buffer_0[28u].w;
				fragment_output_0.x = mad(fragment_unnamed_89, fragment_unnamed_112, fragment_unnamed_97);
				fragment_output_0.y = mad(fragment_unnamed_89, fragment_unnamed_113, fragment_unnamed_98);
				fragment_output_0.z = mad(fragment_unnamed_89, fragment_unnamed_114, fragment_unnamed_99);
				fragment_output_0.w = mad(fragment_unnamed_89, fragment_unnamed_115, fragment_unnamed_100);
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[17] = float4(_ProjectionParams[0], _ProjectionParams[1], _ProjectionParams[2], _ProjectionParams[3]);

				fragment_uniform_buffer_0[20] = float4(unity_OrthoParams[0], unity_OrthoParams[1], unity_OrthoParams[2], unity_OrthoParams[3]);

				fragment_uniform_buffer_0[21] = float4(_ZBufferParams[0], _ZBufferParams[1], _ZBufferParams[2], _ZBufferParams[3]);

				fragment_uniform_buffer_0[28] = float4(_FogColor[0], _FogColor[1], _FogColor[2], _FogColor[3]);

				fragment_uniform_buffer_0[29] = float4(_FogParams[0], _FogParams[1], _FogParams[2], fragment_uniform_buffer_0[29][3]);

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
			GpuProgramID 125586

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

			float4 _ProjectionParams;
			float4 unity_OrthoParams;
			float4 _ZBufferParams;
			float4 _FogColor;
			float3 _FogParams;

			Texture2D<float4> _CameraDepthTexture;
			SamplerState sampler_CameraDepthTexture;
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

			static float fragment_unnamed_8;
			static float fragment_unnamed_24;
			static bool fragment_unnamed_75;
			static float4 fragment_unnamed_100;
			static float4 fragment_unnamed_108;

			void frag_main()
			{
				fragment_unnamed_8 = (-unity_OrthoParams.w) + 1.0f;
				fragment_unnamed_24 = _CameraDepthTexture.Sample(sampler_CameraDepthTexture, fragment_input_0).x;
				fragment_unnamed_24 *= _ZBufferParams.x;
				fragment_unnamed_8 = (fragment_unnamed_8 * fragment_unnamed_24) + _ZBufferParams.y;
				fragment_unnamed_24 = ((-unity_OrthoParams.w) * fragment_unnamed_24) + 1.0f;
				fragment_unnamed_8 = fragment_unnamed_24 / fragment_unnamed_8;
				fragment_unnamed_24 = (fragment_unnamed_8 * _ProjectionParams.z) + (-_ProjectionParams.y);
				fragment_unnamed_75 = fragment_unnamed_8 < 0.99989998340606689453125f;
				fragment_unnamed_8 = float(fragment_unnamed_75);
				fragment_unnamed_24 *= _FogParams.x;
				fragment_unnamed_24 *= (-fragment_unnamed_24);
				fragment_unnamed_24 = exp2(fragment_unnamed_24);
				fragment_unnamed_24 = (-fragment_unnamed_24) + 1.0f;
				fragment_unnamed_8 *= fragment_unnamed_24;
				fragment_unnamed_100 = _MainTex.Sample(sampler_MainTex, fragment_input_0);
				fragment_unnamed_108 = (-fragment_unnamed_100) + _FogColor;
				fragment_output_0 = (fragment_unnamed_8.xxxx * fragment_unnamed_108) + fragment_unnamed_100;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_0 = stage_input.fragment_input_0;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			float4 _ProjectionParams;
			float4 unity_OrthoParams;
			float4 _ZBufferParams;
			float4 _FogColor;
			float3 _FogParams;

			static float4 fragment_uniform_buffer_0[30];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _CameraDepthTexture;
			SamplerState sampler_MainTex;
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
				precise float fragment_unnamed_39 = (-0.0f) - fragment_uniform_buffer_0[20u].w;
				precise float fragment_unnamed_41 = fragment_unnamed_39 + 1.0f;
				precise float fragment_unnamed_59 = _CameraDepthTexture.Sample(sampler_CameraDepthTexture, float2(fragment_input_1.x, fragment_input_1.y)).x * fragment_uniform_buffer_0[21u].x;
				precise float fragment_unnamed_68 = (-0.0f) - fragment_uniform_buffer_0[20u].w;
				precise float fragment_unnamed_70 = mad(fragment_unnamed_68, fragment_unnamed_59, 1.0f) / mad(fragment_unnamed_41, fragment_unnamed_59, fragment_uniform_buffer_0[21u].y);
				precise float fragment_unnamed_78 = (-0.0f) - fragment_uniform_buffer_0[17u].y;
				precise float fragment_unnamed_92 = mad(fragment_unnamed_70, fragment_uniform_buffer_0[17u].z, fragment_unnamed_78) * fragment_uniform_buffer_0[29u].x;
				precise float fragment_unnamed_93 = (-0.0f) - fragment_unnamed_92;
				precise float fragment_unnamed_94 = fragment_unnamed_92 * fragment_unnamed_93;
				precise float fragment_unnamed_96 = (-0.0f) - exp2(fragment_unnamed_94);
				precise float fragment_unnamed_97 = fragment_unnamed_96 + 1.0f;
				precise float fragment_unnamed_98 = asfloat(((fragment_unnamed_70 < 0.99989998340606689453125f) ? 4294967295u : 0u) & 1065353216u) * fragment_unnamed_97;
				float4 fragment_unnamed_104 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				float fragment_unnamed_106 = fragment_unnamed_104.x;
				float fragment_unnamed_107 = fragment_unnamed_104.y;
				float fragment_unnamed_108 = fragment_unnamed_104.z;
				float fragment_unnamed_109 = fragment_unnamed_104.w;
				precise float fragment_unnamed_110 = (-0.0f) - fragment_unnamed_106;
				precise float fragment_unnamed_111 = (-0.0f) - fragment_unnamed_107;
				precise float fragment_unnamed_112 = (-0.0f) - fragment_unnamed_108;
				precise float fragment_unnamed_113 = (-0.0f) - fragment_unnamed_109;
				precise float fragment_unnamed_121 = fragment_unnamed_110 + fragment_uniform_buffer_0[28u].x;
				precise float fragment_unnamed_122 = fragment_unnamed_111 + fragment_uniform_buffer_0[28u].y;
				precise float fragment_unnamed_123 = fragment_unnamed_112 + fragment_uniform_buffer_0[28u].z;
				precise float fragment_unnamed_124 = fragment_unnamed_113 + fragment_uniform_buffer_0[28u].w;
				fragment_output_0.x = mad(fragment_unnamed_98, fragment_unnamed_121, fragment_unnamed_106);
				fragment_output_0.y = mad(fragment_unnamed_98, fragment_unnamed_122, fragment_unnamed_107);
				fragment_output_0.z = mad(fragment_unnamed_98, fragment_unnamed_123, fragment_unnamed_108);
				fragment_output_0.w = mad(fragment_unnamed_98, fragment_unnamed_124, fragment_unnamed_109);
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[17] = float4(_ProjectionParams[0], _ProjectionParams[1], _ProjectionParams[2], _ProjectionParams[3]);

				fragment_uniform_buffer_0[20] = float4(unity_OrthoParams[0], unity_OrthoParams[1], unity_OrthoParams[2], unity_OrthoParams[3]);

				fragment_uniform_buffer_0[21] = float4(_ZBufferParams[0], _ZBufferParams[1], _ZBufferParams[2], _ZBufferParams[3]);

				fragment_uniform_buffer_0[28] = float4(_FogColor[0], _FogColor[1], _FogColor[2], _FogColor[3]);

				fragment_uniform_buffer_0[29] = float4(_FogParams[0], _FogParams[1], _FogParams[2], fragment_uniform_buffer_0[29][3]);

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
