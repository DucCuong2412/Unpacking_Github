Shader "Hidden/PostProcessing/MultiScaleVO"
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
			GpuProgramID 22536

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0


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
				vertex_output_1.x = mad(vertex_input_0.x + 1.0f, 0.5f, 0.0f) * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.y = mad(vertex_input_0.y + 1.0f, -0.5f, 1.0f) * vertex_uniform_buffer_0[26u].x;
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

			void frag_main()
			{
				fragment_unnamed_8 = _CameraDepthTexture.Sample(sampler_CameraDepthTexture, fragment_input_0).x;
				fragment_output_0 = fragment_unnamed_8.xxxx;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_0 = stage_input.fragment_input_0;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


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
				float4 fragment_unnamed_34 = _CameraDepthTexture.Sample(sampler_CameraDepthTexture, float2(fragment_input_1.x, fragment_input_1.y));
				float fragment_unnamed_36 = fragment_unnamed_34.x;
				fragment_output_0.x = fragment_unnamed_36;
				fragment_output_0.y = fragment_unnamed_36;
				fragment_output_0.z = fragment_unnamed_36;
				fragment_output_0.w = fragment_unnamed_36;
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
			Blend Zero OneMinusSrcColor, Zero OneMinusSrcAlpha
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 125459

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0


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
				vertex_output_1.x = mad(vertex_input_0.x + 1.0f, 0.5f, 0.0f) * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.y = mad(vertex_input_0.y + 1.0f, -0.5f, 1.0f) * vertex_uniform_buffer_0[26u].x;
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

			float3 _AOColor;

			Texture2D<float4> _MSVOcclusionTexture;
			SamplerState sampler_MSVOcclusionTexture;

			static float4 fragment_output_0;
			static float2 fragment_input_0;
			static float4 fragment_output_1;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_0 : TEXCOORD1; // vs_TEXCOORD1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
				float4 fragment_output_1 : SV_Target1;
			};

			static float fragment_unnamed_16;

			void frag_main()
			{
				fragment_output_0 = float4(0.0f.xxx.x, 0.0f.xxx.y, 0.0f.xxx.z, fragment_output_0.w);
				fragment_unnamed_16 = _MSVOcclusionTexture.Sample(sampler_MSVOcclusionTexture, fragment_input_0).x;
				fragment_unnamed_16 = (-fragment_unnamed_16) + 1.0f;
				fragment_output_0.w = fragment_unnamed_16;
				float3 fragment_unnamed_54 = fragment_unnamed_16.xxx * _AOColor;
				fragment_output_1 = float4(fragment_unnamed_54.x, fragment_unnamed_54.y, fragment_unnamed_54.z, fragment_output_1.w);
				fragment_output_1.w = 0.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_0 = stage_input.fragment_input_0;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				stage_output.fragment_output_1 = fragment_output_1;
				return stage_output;
			}


			float3 _AOColor;

			static float4 fragment_uniform_buffer_0[31];
			Texture2D<float4> _MSVOcclusionTexture;
			SamplerState sampler_MSVOcclusionTexture;

			static float2 fragment_input_1;
			static float2 fragment_input_1;
			static float4 fragment_output_0;
			static float4 fragment_output_1;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD; // TEXCOORD
				float2 fragment_input_1 : TEXCOORD1; // TEXCOORD_1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
				float4 fragment_output_1 : SV_Target1;
			};

			void frag_main()
			{
				fragment_output_0.x = 0.0f;
				fragment_output_0.y = 0.0f;
				fragment_output_0.z = 0.0f;
				float fragment_unnamed_50 = ((-0.0f) - _MSVOcclusionTexture.Sample(sampler_MSVOcclusionTexture, float2(fragment_input_1.x, fragment_input_1.y)).x) + 1.0f;
				fragment_output_0.w = fragment_unnamed_50;
				fragment_output_1.x = fragment_unnamed_50 * fragment_uniform_buffer_0[30u].x;
				fragment_output_1.y = fragment_unnamed_50 * fragment_uniform_buffer_0[30u].y;
				fragment_output_1.z = fragment_unnamed_50 * fragment_uniform_buffer_0[30u].z;
				fragment_output_1.w = 0.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[30] = float4(_AOColor[0], _AOColor[1], _AOColor[2], fragment_uniform_buffer_0[30][3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				stage_output.fragment_output_1 = fragment_output_1;
				return stage_output;
			}


			ENDHLSL
		}
		Pass
		{
			Blend Zero OneMinusSrcColor, Zero OneMinusSrcAlpha
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 161131

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0
			#pragma multi_compile _ APPLY_FORWARD_FOG


			#ifndef APPLY_FORWARD_FOG
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
				vertex_output_1.x = mad(vertex_input_0.x + 1.0f, 0.5f, 0.0f) * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.y = mad(vertex_input_0.y + 1.0f, -0.5f, 1.0f) * vertex_uniform_buffer_0[26u].x;
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

			#endif // !APPLY_FORWARD_FOG


			#ifdef APPLY_FORWARD_FOG
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
				vertex_output_1.x = mad(vertex_input_0.x + 1.0f, 0.5f, 0.0f) * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.y = mad(vertex_input_0.y + 1.0f, -0.5f, 1.0f) * vertex_uniform_buffer_0[26u].x;
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

			#endif // APPLY_FORWARD_FOG


			#ifndef APPLY_FORWARD_FOG
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

			float3 _AOColor;

			Texture2D<float4> _MSVOcclusionTexture;
			SamplerState sampler_MSVOcclusionTexture;

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

			void frag_main()
			{
				fragment_unnamed_8 = _MSVOcclusionTexture.Sample(sampler_MSVOcclusionTexture, fragment_input_0).x;
				fragment_unnamed_8 = (-fragment_unnamed_8) + 1.0f;
				float3 fragment_unnamed_45 = fragment_unnamed_8.xxx * _AOColor;
				fragment_output_0 = float4(fragment_unnamed_45.x, fragment_unnamed_45.y, fragment_unnamed_45.z, fragment_output_0.w);
				fragment_output_0.w = 0.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_0 = stage_input.fragment_input_0;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // !APPLY_FORWARD_FOG


			#ifdef APPLY_FORWARD_FOG
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

			float4 _ProjectionParams;
			float4 unity_OrthoParams;
			float4 _ZBufferParams;
			float3 _FogParams;
			float3 _AOColor;

			Texture2D<float4> _CameraDepthTexture;
			SamplerState sampler_CameraDepthTexture;
			Texture2D<float4> _MSVOcclusionTexture;
			SamplerState sampler_MSVOcclusionTexture;

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
				fragment_unnamed_24 = _MSVOcclusionTexture.Sample(sampler_MSVOcclusionTexture, fragment_input_0).x;
				fragment_unnamed_24 = (-fragment_unnamed_24) + 1.0f;
				fragment_unnamed_8 *= fragment_unnamed_24;
				float3 fragment_unnamed_106 = fragment_unnamed_8.xxx * _AOColor;
				fragment_output_0 = float4(fragment_unnamed_106.x, fragment_unnamed_106.y, fragment_unnamed_106.z, fragment_output_0.w);
				fragment_output_0.w = 0.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_0 = stage_input.fragment_input_0;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // APPLY_FORWARD_FOG


			#ifndef APPLY_FORWARD_FOG
			#define ANY_SHADER_VARIANT_ACTIVE

			float3 _AOColor;

			static float4 fragment_uniform_buffer_0[31];
			Texture2D<float4> _MSVOcclusionTexture;
			SamplerState sampler_MSVOcclusionTexture;

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
				float fragment_unnamed_44 = ((-0.0f) - _MSVOcclusionTexture.Sample(sampler_MSVOcclusionTexture, float2(fragment_input_1.x, fragment_input_1.y)).x) + 1.0f;
				fragment_output_0.x = fragment_unnamed_44 * fragment_uniform_buffer_0[30u].x;
				fragment_output_0.y = fragment_unnamed_44 * fragment_uniform_buffer_0[30u].y;
				fragment_output_0.z = fragment_unnamed_44 * fragment_uniform_buffer_0[30u].z;
				fragment_output_0.w = 0.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[30] = float4(_AOColor[0], _AOColor[1], _AOColor[2], fragment_uniform_buffer_0[30][3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // !APPLY_FORWARD_FOG


			#ifdef APPLY_FORWARD_FOG
			#define ANY_SHADER_VARIANT_ACTIVE

			float4 _ProjectionParams;
			float4 unity_OrthoParams;
			float4 _ZBufferParams;
			float3 _FogParams;
			float3 _AOColor;

			static float4 fragment_uniform_buffer_0[31];
			Texture2D<float4> _CameraDepthTexture;
			Texture2D<float4> _MSVOcclusionTexture;
			SamplerState sampler_CameraDepthTexture;
			SamplerState sampler_MSVOcclusionTexture;

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
				float fragment_unnamed_59 = _CameraDepthTexture.Sample(sampler_CameraDepthTexture, float2(fragment_input_1.x, fragment_input_1.y)).x * fragment_uniform_buffer_0[21u].x;
				float fragment_unnamed_84 = mad(mad((-0.0f) - fragment_uniform_buffer_0[20u].w, fragment_unnamed_59, 1.0f) / mad(((-0.0f) - fragment_uniform_buffer_0[20u].w) + 1.0f, fragment_unnamed_59, fragment_uniform_buffer_0[21u].y), fragment_uniform_buffer_0[17u].z, (-0.0f) - fragment_uniform_buffer_0[17u].y) * fragment_uniform_buffer_0[29u].x;
				float fragment_unnamed_98 = exp2(fragment_unnamed_84 * ((-0.0f) - fragment_unnamed_84)) * (((-0.0f) - _MSVOcclusionTexture.Sample(sampler_MSVOcclusionTexture, float2(fragment_input_1.x, fragment_input_1.y)).x) + 1.0f);
				fragment_output_0.x = fragment_unnamed_98 * fragment_uniform_buffer_0[30u].x;
				fragment_output_0.y = fragment_unnamed_98 * fragment_uniform_buffer_0[30u].y;
				fragment_output_0.z = fragment_unnamed_98 * fragment_uniform_buffer_0[30u].z;
				fragment_output_0.w = 0.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[17] = float4(_ProjectionParams[0], _ProjectionParams[1], _ProjectionParams[2], _ProjectionParams[3]);

				fragment_uniform_buffer_0[20] = float4(unity_OrthoParams[0], unity_OrthoParams[1], unity_OrthoParams[2], unity_OrthoParams[3]);

				fragment_uniform_buffer_0[21] = float4(_ZBufferParams[0], _ZBufferParams[1], _ZBufferParams[2], _ZBufferParams[3]);

				fragment_uniform_buffer_0[29] = float4(_FogParams[0], _FogParams[1], _FogParams[2], fragment_uniform_buffer_0[29][3]);

				fragment_uniform_buffer_0[30] = float4(_AOColor[0], _AOColor[1], _AOColor[2], fragment_uniform_buffer_0[30][3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // APPLY_FORWARD_FOG


			ENDHLSL
		}
		Pass
		{
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 197183

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0


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
				vertex_output_1.x = mad(vertex_input_0.x + 1.0f, 0.5f, 0.0f) * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.y = mad(vertex_input_0.y + 1.0f, -0.5f, 1.0f) * vertex_uniform_buffer_0[26u].x;
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

			Texture2D<float4> _MSVOcclusionTexture;
			SamplerState sampler_MSVOcclusionTexture;

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

			void frag_main()
			{
				fragment_unnamed_8 = _MSVOcclusionTexture.Sample(sampler_MSVOcclusionTexture, fragment_input_0).x;
				float3 fragment_unnamed_32 = fragment_unnamed_8.xxx;
				fragment_output_0 = float4(fragment_unnamed_32.x, fragment_unnamed_32.y, fragment_unnamed_32.z, fragment_output_0.w);
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


			Texture2D<float4> _MSVOcclusionTexture;
			SamplerState sampler_MSVOcclusionTexture;

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
				float4 fragment_unnamed_34 = _MSVOcclusionTexture.Sample(sampler_MSVOcclusionTexture, float2(fragment_input_1.x, fragment_input_1.y));
				float fragment_unnamed_36 = fragment_unnamed_34.x;
				fragment_output_0.x = fragment_unnamed_36;
				fragment_output_0.y = fragment_unnamed_36;
				fragment_output_0.z = fragment_unnamed_36;
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


			ENDHLSL
		}
	}
}
