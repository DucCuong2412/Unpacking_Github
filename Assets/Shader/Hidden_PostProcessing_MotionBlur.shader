Shader "Hidden/PostProcessing/MotionBlur"
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
			GpuProgramID 25479

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

			float4 unity_OrthoParams;
			float4 _ZBufferParams;
			float4 _CameraMotionVectorsTexture_TexelSize;
			float _VelocityScale;
			float _RcpMaxBlurRadius;

			Texture2D<float4> _CameraMotionVectorsTexture;
			SamplerState sampler_CameraMotionVectorsTexture;
			Texture2D<float4> _CameraDepthTexture;
			SamplerState sampler_CameraDepthTexture;

			static float2 fragment_input_0;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_0 : TEXCOORD0; // vs_TEXCOORD0
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static float2 fragment_unnamed_9;
			static float2 fragment_unnamed_33;
			static float fragment_unnamed_102;

			void frag_main()
			{
				fragment_unnamed_9.x = _VelocityScale * 0.5f;
				fragment_unnamed_9 = fragment_unnamed_9.xx * _CameraMotionVectorsTexture_TexelSize.zw;
				fragment_unnamed_33 = _CameraMotionVectorsTexture.Sample(sampler_CameraMotionVectorsTexture, fragment_input_0).xy;
				fragment_unnamed_9 *= fragment_unnamed_33;
				fragment_unnamed_33.x = dot(fragment_unnamed_9, fragment_unnamed_9);
				fragment_unnamed_33.x = sqrt(fragment_unnamed_33.x);
				fragment_unnamed_33.x *= _RcpMaxBlurRadius;
				fragment_unnamed_33.x = max(fragment_unnamed_33.x, 1.0f);
				fragment_unnamed_9 /= fragment_unnamed_33.xx;
				fragment_unnamed_9 = (fragment_unnamed_9 * float2(float2(_RcpMaxBlurRadius, _RcpMaxBlurRadius))) + 1.0f.xx;
				float2 fragment_unnamed_92 = fragment_unnamed_9 * 0.5f.xx;
				fragment_output_0 = float4(fragment_unnamed_92.x, fragment_unnamed_92.y, fragment_output_0.z, fragment_output_0.w);
				fragment_unnamed_9.x = (-unity_OrthoParams.w) + 1.0f;
				fragment_unnamed_102 = _CameraDepthTexture.Sample(sampler_CameraDepthTexture, fragment_input_0).x;
				fragment_unnamed_102 *= _ZBufferParams.x;
				fragment_unnamed_9.x = (fragment_unnamed_9.x * fragment_unnamed_102) + _ZBufferParams.y;
				fragment_unnamed_102 = ((-unity_OrthoParams.w) * fragment_unnamed_102) + 1.0f;
				fragment_output_0.z = fragment_unnamed_102 / fragment_unnamed_9.x;
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


			float4 unity_OrthoParams;
			float4 _ZBufferParams;
			float4 _CameraMotionVectorsTexture_TexelSize;
			float _VelocityScale;
			float _RcpMaxBlurRadius;

			static float4 fragment_uniform_buffer_0[33];
			Texture2D<float4> _CameraDepthTexture;
			Texture2D<float4> _CameraMotionVectorsTexture;
			SamplerState sampler_CameraDepthTexture;
			SamplerState sampler_CameraMotionVectorsTexture;

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
				precise float fragment_unnamed_39 = fragment_uniform_buffer_0[31u].x * 0.5f;
				precise float fragment_unnamed_46 = fragment_unnamed_39 * fragment_uniform_buffer_0[29u].z;
				precise float fragment_unnamed_47 = fragment_unnamed_39 * fragment_uniform_buffer_0[29u].w;
				float4 fragment_unnamed_57 = _CameraMotionVectorsTexture.Sample(sampler_CameraMotionVectorsTexture, float2(fragment_input_1.x, fragment_input_1.y));
				precise float fragment_unnamed_61 = fragment_unnamed_46 * fragment_unnamed_57.x;
				precise float fragment_unnamed_62 = fragment_unnamed_47 * fragment_unnamed_57.y;
				precise float fragment_unnamed_72 = sqrt(dot(float2(fragment_unnamed_61, fragment_unnamed_62), float2(fragment_unnamed_61, fragment_unnamed_62))) * fragment_uniform_buffer_0[32u].y;
				float fragment_unnamed_73 = max(fragment_unnamed_72, 1.0f);
				precise float fragment_unnamed_75 = fragment_unnamed_61 / fragment_unnamed_73;
				precise float fragment_unnamed_76 = fragment_unnamed_62 / fragment_unnamed_73;
				precise float fragment_unnamed_82 = mad(fragment_unnamed_75, fragment_uniform_buffer_0[32u].y, 1.0f) * 0.5f;
				precise float fragment_unnamed_83 = mad(fragment_unnamed_76, fragment_uniform_buffer_0[32u].y, 1.0f) * 0.5f;
				fragment_output_0.x = fragment_unnamed_82;
				fragment_output_0.y = fragment_unnamed_83;
				precise float fragment_unnamed_91 = (-0.0f) - fragment_uniform_buffer_0[20u].w;
				precise float fragment_unnamed_93 = fragment_unnamed_91 + 1.0f;
				precise float fragment_unnamed_106 = _CameraDepthTexture.Sample(sampler_CameraDepthTexture, float2(fragment_input_1.x, fragment_input_1.y)).x * fragment_uniform_buffer_0[21u].x;
				precise float fragment_unnamed_114 = (-0.0f) - fragment_uniform_buffer_0[20u].w;
				precise float fragment_unnamed_116 = mad(fragment_unnamed_114, fragment_unnamed_106, 1.0f) / mad(fragment_unnamed_93, fragment_unnamed_106, fragment_uniform_buffer_0[21u].y);
				fragment_output_0.z = fragment_unnamed_116;
				fragment_output_0.w = 0.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[20] = float4(unity_OrthoParams[0], unity_OrthoParams[1], unity_OrthoParams[2], unity_OrthoParams[3]);

				fragment_uniform_buffer_0[21] = float4(_ZBufferParams[0], _ZBufferParams[1], _ZBufferParams[2], _ZBufferParams[3]);

				fragment_uniform_buffer_0[29] = float4(_CameraMotionVectorsTexture_TexelSize[0], _CameraMotionVectorsTexture_TexelSize[1], _CameraMotionVectorsTexture_TexelSize[2], _CameraMotionVectorsTexture_TexelSize[3]);

				fragment_uniform_buffer_0[31] = float4(_VelocityScale, fragment_uniform_buffer_0[31][1], fragment_uniform_buffer_0[31][2], fragment_uniform_buffer_0[31][3]);

				fragment_uniform_buffer_0[32] = float4(fragment_uniform_buffer_0[32][0], _RcpMaxBlurRadius, fragment_uniform_buffer_0[32][2], fragment_uniform_buffer_0[32][3]);

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
			GpuProgramID 95730

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

			float4 _MainTex_TexelSize;
			float _MaxBlurRadius;

			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

			static float2 fragment_input_0;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_0 : TEXCOORD0; // vs_TEXCOORD0
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static float4 fragment_unnamed_9;
			static float2 fragment_unnamed_46;
			static float4 fragment_unnamed_76;
			static float fragment_unnamed_86;
			static bool fragment_unnamed_94;
			static float2 fragment_unnamed_135;
			static float fragment_unnamed_159;
			static bool fragment_unnamed_165;

			void frag_main()
			{
				fragment_unnamed_9 = (_MainTex_TexelSize.xyxy * float4(-0.5f, -0.5f, 0.5f, -0.5f)) + fragment_input_0.xyxy;
				float2 fragment_unnamed_42 = _MainTex.Sample(sampler_MainTex, fragment_unnamed_9.xy).xy;
				fragment_unnamed_9 = float4(fragment_unnamed_42.x, fragment_unnamed_42.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
				fragment_unnamed_46 = _MainTex.Sample(sampler_MainTex, fragment_unnamed_9.zw).xy;
				float2 fragment_unnamed_60 = (fragment_unnamed_46 * 2.0f.xx) + (-1.0f).xx;
				fragment_unnamed_9 = float4(fragment_unnamed_9.x, fragment_unnamed_9.y, fragment_unnamed_60.x, fragment_unnamed_60.y);
				float2 fragment_unnamed_66 = (fragment_unnamed_9.xy * 2.0f.xx) + (-1.0f).xx;
				fragment_unnamed_9 = float4(fragment_unnamed_66.x, fragment_unnamed_66.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
				fragment_unnamed_9 *= _MaxBlurRadius.xxxx;
				fragment_unnamed_76.x = dot(fragment_unnamed_9.xy, fragment_unnamed_9.xy);
				fragment_unnamed_86 = dot(fragment_unnamed_9.zw, fragment_unnamed_9.zw);
				fragment_unnamed_94 = fragment_unnamed_76.x < fragment_unnamed_86;
				float2 fragment_unnamed_101;
				if (fragment_unnamed_94)
				{
					fragment_unnamed_101 = fragment_unnamed_9.zw;
				}
				else
				{
					fragment_unnamed_101 = fragment_unnamed_9.xy;
				}
				fragment_unnamed_9 = float4(fragment_unnamed_101.x, fragment_unnamed_101.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
				fragment_unnamed_46.x = dot(fragment_unnamed_9.xy, fragment_unnamed_9.xy);
				fragment_unnamed_76 = (_MainTex_TexelSize.xyxy * float4(-0.5f, 0.5f, 0.5f, 0.5f)) + fragment_input_0.xyxy;
				float2 fragment_unnamed_132 = _MainTex.Sample(sampler_MainTex, fragment_unnamed_76.xy).xy;
				fragment_unnamed_76 = float4(fragment_unnamed_132.x, fragment_unnamed_132.y, fragment_unnamed_76.z, fragment_unnamed_76.w);
				fragment_unnamed_135 = _MainTex.Sample(sampler_MainTex, fragment_unnamed_76.zw).xy;
				float2 fragment_unnamed_145 = (fragment_unnamed_135 * 2.0f.xx) + (-1.0f).xx;
				fragment_unnamed_76 = float4(fragment_unnamed_76.x, fragment_unnamed_76.y, fragment_unnamed_145.x, fragment_unnamed_145.y);
				float2 fragment_unnamed_151 = (fragment_unnamed_76.xy * 2.0f.xx) + (-1.0f).xx;
				fragment_unnamed_76 = float4(fragment_unnamed_151.x, fragment_unnamed_151.y, fragment_unnamed_76.z, fragment_unnamed_76.w);
				fragment_unnamed_76 *= _MaxBlurRadius.xxxx;
				fragment_unnamed_159 = dot(fragment_unnamed_76.xy, fragment_unnamed_76.xy);
				fragment_unnamed_165 = fragment_unnamed_46.x < fragment_unnamed_159;
				float2 fragment_unnamed_171;
				if (fragment_unnamed_165)
				{
					fragment_unnamed_171 = fragment_unnamed_76.xy;
				}
				else
				{
					fragment_unnamed_171 = fragment_unnamed_9.xy;
				}
				fragment_unnamed_9 = float4(fragment_unnamed_171.x, fragment_unnamed_171.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
				fragment_unnamed_46.x = dot(fragment_unnamed_9.xy, fragment_unnamed_9.xy);
				fragment_unnamed_159 = dot(fragment_unnamed_76.zw, fragment_unnamed_76.zw);
				fragment_unnamed_165 = fragment_unnamed_46.x < fragment_unnamed_159;
				float2 fragment_unnamed_200;
				if (fragment_unnamed_165)
				{
					fragment_unnamed_200 = fragment_unnamed_76.zw;
				}
				else
				{
					fragment_unnamed_200 = fragment_unnamed_9.xy;
				}
				fragment_output_0 = float4(fragment_unnamed_200.x, fragment_unnamed_200.y, fragment_output_0.z, fragment_output_0.w);
				fragment_output_0 = float4(fragment_output_0.x, fragment_output_0.y, 0.0f.xx.x, 0.0f.xx.y);
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_0 = stage_input.fragment_input_0;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			float4 _MainTex_TexelSize;
			float _MaxBlurRadius;

			static float4 fragment_uniform_buffer_0[33];
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
				float4 fragment_unnamed_52 = _MainTex.Sample(sampler_MainTex, float2(mad(fragment_uniform_buffer_0[28u].x, -0.5f, fragment_input_1.x), mad(fragment_uniform_buffer_0[28u].y, -0.5f, fragment_input_1.y)));
				float4 fragment_unnamed_56 = _MainTex.Sample(sampler_MainTex, float2(mad(fragment_uniform_buffer_0[28u].x, 0.5f, fragment_input_1.x), mad(fragment_uniform_buffer_0[28u].y, -0.5f, fragment_input_1.y)));
				precise float fragment_unnamed_70 = mad(fragment_unnamed_56.x, 2.0f, -1.0f) * fragment_uniform_buffer_0[32u].x;
				precise float fragment_unnamed_71 = mad(fragment_unnamed_56.y, 2.0f, -1.0f) * fragment_uniform_buffer_0[32u].x;
				precise float fragment_unnamed_72 = mad(fragment_unnamed_52.x, 2.0f, -1.0f) * fragment_uniform_buffer_0[32u].x;
				precise float fragment_unnamed_73 = mad(fragment_unnamed_52.y, 2.0f, -1.0f) * fragment_uniform_buffer_0[32u].x;
				bool fragment_unnamed_81 = dot(float2(fragment_unnamed_72, fragment_unnamed_73), float2(fragment_unnamed_72, fragment_unnamed_73)) < dot(float2(fragment_unnamed_70, fragment_unnamed_71), float2(fragment_unnamed_70, fragment_unnamed_71));
				uint fragment_unnamed_86 = fragment_unnamed_81 ? asuint(fragment_unnamed_70) : asuint(fragment_unnamed_72);
				float fragment_unnamed_87 = asfloat(fragment_unnamed_86);
				uint fragment_unnamed_88 = fragment_unnamed_81 ? asuint(fragment_unnamed_71) : asuint(fragment_unnamed_73);
				float fragment_unnamed_89 = asfloat(fragment_unnamed_88);
				float4 fragment_unnamed_105 = _MainTex.Sample(sampler_MainTex, float2(mad(fragment_uniform_buffer_0[28u].x, -0.5f, fragment_input_1.x), mad(fragment_uniform_buffer_0[28u].y, 0.5f, fragment_input_1.y)));
				float4 fragment_unnamed_109 = _MainTex.Sample(sampler_MainTex, float2(mad(fragment_uniform_buffer_0[28u].x, 0.5f, fragment_input_1.x), mad(fragment_uniform_buffer_0[28u].y, 0.5f, fragment_input_1.y)));
				precise float fragment_unnamed_120 = mad(fragment_unnamed_109.x, 2.0f, -1.0f) * fragment_uniform_buffer_0[32u].x;
				precise float fragment_unnamed_121 = mad(fragment_unnamed_109.y, 2.0f, -1.0f) * fragment_uniform_buffer_0[32u].x;
				precise float fragment_unnamed_122 = mad(fragment_unnamed_105.x, 2.0f, -1.0f) * fragment_uniform_buffer_0[32u].x;
				precise float fragment_unnamed_123 = mad(fragment_unnamed_105.y, 2.0f, -1.0f) * fragment_uniform_buffer_0[32u].x;
				bool fragment_unnamed_127 = dot(float2(fragment_unnamed_87, fragment_unnamed_89), float2(fragment_unnamed_87, fragment_unnamed_89)) < dot(float2(fragment_unnamed_122, fragment_unnamed_123), float2(fragment_unnamed_122, fragment_unnamed_123));
				float fragment_unnamed_131 = asfloat(fragment_unnamed_127 ? asuint(fragment_unnamed_122) : fragment_unnamed_86);
				float fragment_unnamed_133 = asfloat(fragment_unnamed_127 ? asuint(fragment_unnamed_123) : fragment_unnamed_88);
				bool fragment_unnamed_140 = dot(float2(fragment_unnamed_131, fragment_unnamed_133), float2(fragment_unnamed_131, fragment_unnamed_133)) < dot(float2(fragment_unnamed_120, fragment_unnamed_121), float2(fragment_unnamed_120, fragment_unnamed_121));
				fragment_output_0.x = fragment_unnamed_140 ? fragment_unnamed_120 : fragment_unnamed_131;
				fragment_output_0.y = fragment_unnamed_140 ? fragment_unnamed_121 : fragment_unnamed_133;
				fragment_output_0.z = 0.0f;
				fragment_output_0.w = 0.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[28] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				fragment_uniform_buffer_0[32] = float4(_MaxBlurRadius, fragment_uniform_buffer_0[32][1], fragment_uniform_buffer_0[32][2], fragment_uniform_buffer_0[32][3]);

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
			GpuProgramID 194360

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

			float4 _MainTex_TexelSize;

			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

			static float2 fragment_input_0;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_0 : TEXCOORD0; // vs_TEXCOORD0
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static float4 fragment_unnamed_9;
			static float2 fragment_unnamed_46;
			static float4 fragment_unnamed_54;
			static float fragment_unnamed_64;
			static bool fragment_unnamed_70;
			static float2 fragment_unnamed_110;
			static float fragment_unnamed_118;
			static bool fragment_unnamed_124;

			void frag_main()
			{
				fragment_unnamed_9 = (_MainTex_TexelSize.xyxy * float4(-0.5f, -0.5f, 0.5f, -0.5f)) + fragment_input_0.xyxy;
				float2 fragment_unnamed_42 = _MainTex.Sample(sampler_MainTex, fragment_unnamed_9.xy).xy;
				fragment_unnamed_9 = float4(fragment_unnamed_42.x, fragment_unnamed_42.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
				fragment_unnamed_46 = _MainTex.Sample(sampler_MainTex, fragment_unnamed_9.zw).xy;
				fragment_unnamed_54.x = dot(fragment_unnamed_9.xy, fragment_unnamed_9.xy);
				fragment_unnamed_64 = dot(fragment_unnamed_46, fragment_unnamed_46);
				fragment_unnamed_70 = fragment_unnamed_54.x < fragment_unnamed_64;
				float2 fragment_unnamed_77;
				if (fragment_unnamed_70)
				{
					fragment_unnamed_77 = fragment_unnamed_46;
				}
				else
				{
					fragment_unnamed_77 = fragment_unnamed_9.xy;
				}
				fragment_unnamed_9 = float4(fragment_unnamed_77.x, fragment_unnamed_77.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
				fragment_unnamed_46.x = dot(fragment_unnamed_9.xy, fragment_unnamed_9.xy);
				fragment_unnamed_54 = (_MainTex_TexelSize.xyxy * float4(-0.5f, 0.5f, 0.5f, 0.5f)) + fragment_input_0.xyxy;
				float2 fragment_unnamed_107 = _MainTex.Sample(sampler_MainTex, fragment_unnamed_54.xy).xy;
				fragment_unnamed_54 = float4(fragment_unnamed_107.x, fragment_unnamed_107.y, fragment_unnamed_54.z, fragment_unnamed_54.w);
				fragment_unnamed_110 = _MainTex.Sample(sampler_MainTex, fragment_unnamed_54.zw).xy;
				fragment_unnamed_118 = dot(fragment_unnamed_54.xy, fragment_unnamed_54.xy);
				fragment_unnamed_124 = fragment_unnamed_46.x < fragment_unnamed_118;
				float2 fragment_unnamed_130;
				if (fragment_unnamed_124)
				{
					fragment_unnamed_130 = fragment_unnamed_54.xy;
				}
				else
				{
					fragment_unnamed_130 = fragment_unnamed_9.xy;
				}
				fragment_unnamed_9 = float4(fragment_unnamed_130.x, fragment_unnamed_130.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
				fragment_unnamed_46.x = dot(fragment_unnamed_9.xy, fragment_unnamed_9.xy);
				fragment_unnamed_118 = dot(fragment_unnamed_110, fragment_unnamed_110);
				fragment_unnamed_124 = fragment_unnamed_46.x < fragment_unnamed_118;
				float2 fragment_unnamed_157;
				if (fragment_unnamed_124)
				{
					fragment_unnamed_157 = fragment_unnamed_110;
				}
				else
				{
					fragment_unnamed_157 = fragment_unnamed_9.xy;
				}
				fragment_output_0 = float4(fragment_unnamed_157.x, fragment_unnamed_157.y, fragment_output_0.z, fragment_output_0.w);
				fragment_output_0 = float4(fragment_output_0.x, fragment_output_0.y, 0.0f.xx.x, 0.0f.xx.y);
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_0 = stage_input.fragment_input_0;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			float4 _MainTex_TexelSize;

			static float4 fragment_uniform_buffer_0[29];
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
				float4 fragment_unnamed_52 = _MainTex.Sample(sampler_MainTex, float2(mad(fragment_uniform_buffer_0[28u].x, -0.5f, fragment_input_1.x), mad(fragment_uniform_buffer_0[28u].y, -0.5f, fragment_input_1.y)));
				float fragment_unnamed_54 = fragment_unnamed_52.x;
				float4 fragment_unnamed_56 = _MainTex.Sample(sampler_MainTex, float2(mad(fragment_uniform_buffer_0[28u].x, 0.5f, fragment_input_1.x), mad(fragment_uniform_buffer_0[28u].y, -0.5f, fragment_input_1.y)));
				float fragment_unnamed_58 = fragment_unnamed_56.x;
				bool fragment_unnamed_67 = dot(float2(fragment_unnamed_54, fragment_unnamed_52.y), float2(fragment_unnamed_54, fragment_unnamed_52.y)) < dot(float2(fragment_unnamed_58, fragment_unnamed_56.y), float2(fragment_unnamed_58, fragment_unnamed_56.y));
				uint fragment_unnamed_72 = fragment_unnamed_67 ? asuint(fragment_unnamed_58) : asuint(fragment_unnamed_54);
				float fragment_unnamed_73 = asfloat(fragment_unnamed_72);
				uint fragment_unnamed_74 = fragment_unnamed_67 ? asuint(fragment_unnamed_56.y) : asuint(fragment_unnamed_52.y);
				float fragment_unnamed_75 = asfloat(fragment_unnamed_74);
				float4 fragment_unnamed_91 = _MainTex.Sample(sampler_MainTex, float2(mad(fragment_uniform_buffer_0[28u].x, -0.5f, fragment_input_1.x), mad(fragment_uniform_buffer_0[28u].y, 0.5f, fragment_input_1.y)));
				float fragment_unnamed_93 = fragment_unnamed_91.x;
				float4 fragment_unnamed_95 = _MainTex.Sample(sampler_MainTex, float2(mad(fragment_uniform_buffer_0[28u].x, 0.5f, fragment_input_1.x), mad(fragment_uniform_buffer_0[28u].y, 0.5f, fragment_input_1.y)));
				float fragment_unnamed_97 = fragment_unnamed_95.x;
				bool fragment_unnamed_102 = dot(float2(fragment_unnamed_73, fragment_unnamed_75), float2(fragment_unnamed_73, fragment_unnamed_75)) < dot(float2(fragment_unnamed_93, fragment_unnamed_91.y), float2(fragment_unnamed_93, fragment_unnamed_91.y));
				float fragment_unnamed_106 = asfloat(fragment_unnamed_102 ? asuint(fragment_unnamed_93) : fragment_unnamed_72);
				float fragment_unnamed_108 = asfloat(fragment_unnamed_102 ? asuint(fragment_unnamed_91.y) : fragment_unnamed_74);
				bool fragment_unnamed_115 = dot(float2(fragment_unnamed_106, fragment_unnamed_108), float2(fragment_unnamed_106, fragment_unnamed_108)) < dot(float2(fragment_unnamed_97, fragment_unnamed_95.y), float2(fragment_unnamed_97, fragment_unnamed_95.y));
				fragment_output_0.x = fragment_unnamed_115 ? fragment_unnamed_97 : fragment_unnamed_106;
				fragment_output_0.y = fragment_unnamed_115 ? fragment_unnamed_95.y : fragment_unnamed_108;
				fragment_output_0.z = 0.0f;
				fragment_output_0.w = 0.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[28] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

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
			GpuProgramID 233378

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

			float4 _MainTex_TexelSize;
			int _TileMaxLoop;
			float2 _TileMaxOffs;

			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

			static float2 fragment_input_0;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_0 : TEXCOORD0; // vs_TEXCOORD0
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static float2 fragment_unnamed_9;
			static float4 fragment_unnamed_36;
			static float2 fragment_unnamed_47;
			static float2 fragment_unnamed_64;
			static float2 fragment_unnamed_75;
			static float2 fragment_unnamed_87;
			static float fragment_unnamed_111;
			static float fragment_unnamed_115;
			static bool fragment_unnamed_120;
			static int fragment_unnamed_148;
			static bool fragment_unnamed_149;
			static bool fragment_unnamed_150;
			static int fragment_unnamed_151;

			void frag_main()
			{
				fragment_unnamed_9 = (_MainTex_TexelSize.xy * float2(_TileMaxOffs.x, _TileMaxOffs.y)) + fragment_input_0;
				fragment_unnamed_36.y = 0.0f;
				fragment_unnamed_36.z = 0.0f;
				fragment_unnamed_36 = float4(_MainTex_TexelSize.xy.x, fragment_unnamed_36.y, fragment_unnamed_36.z, _MainTex_TexelSize.xy.y);
				fragment_unnamed_47.x = 0.0f;
				fragment_unnamed_47.y = 0.0f;
				float2 fragment_unnamed_126;
				for (int fragment_unnamed_51 = 0; fragment_unnamed_51 < _TileMaxLoop; fragment_unnamed_51++)
				{
					fragment_unnamed_64.x = float(fragment_unnamed_51);
					fragment_unnamed_64 = (fragment_unnamed_36.xy * fragment_unnamed_64.xx) + fragment_unnamed_9;
					fragment_unnamed_75 = fragment_unnamed_47;
					for (int fragment_unnamed_77 = 0; fragment_unnamed_77 < _TileMaxLoop; fragment_unnamed_77++)
					{
						fragment_unnamed_87.x = float(fragment_unnamed_77);
						fragment_unnamed_87 = (fragment_unnamed_36.zw * fragment_unnamed_87.xx) + fragment_unnamed_64;
						fragment_unnamed_87 = _MainTex.Sample(sampler_MainTex, fragment_unnamed_87).xy;
						fragment_unnamed_111 = dot(fragment_unnamed_75, fragment_unnamed_75);
						fragment_unnamed_115 = dot(fragment_unnamed_87, fragment_unnamed_87);
						fragment_unnamed_120 = fragment_unnamed_111 < fragment_unnamed_115;
						if (fragment_unnamed_120)
						{
							fragment_unnamed_126 = fragment_unnamed_87;
						}
						else
						{
							fragment_unnamed_126 = fragment_unnamed_75;
						}
						fragment_unnamed_75 = fragment_unnamed_126;
					}
					fragment_unnamed_47 = fragment_unnamed_75;
				}
				fragment_output_0 = float4(fragment_unnamed_47.x, fragment_unnamed_47.y, fragment_output_0.z, fragment_output_0.w);
				fragment_output_0 = float4(fragment_output_0.x, fragment_output_0.y, 0.0f.xx.x, 0.0f.xx.y);
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_0 = stage_input.fragment_input_0;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			float4 _MainTex_TexelSize;
			int _TileMaxLoop;
			float2 _TileMaxOffs;

			static float4 fragment_uniform_buffer_0[32];
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
				float fragment_unnamed_48 = mad(fragment_uniform_buffer_0[28u].x, fragment_uniform_buffer_0[31u].z, fragment_input_1.x);
				float fragment_unnamed_49 = mad(fragment_uniform_buffer_0[28u].y, fragment_uniform_buffer_0[31u].w, fragment_input_1.y);
				float fragment_unnamed_50 = asfloat(0u);
				float fragment_unnamed_51 = asfloat(0u);
				uint4 fragment_unnamed_55 = asuint(fragment_uniform_buffer_0[28u]);
				float fragment_unnamed_57 = asfloat(fragment_unnamed_55.x);
				float fragment_unnamed_59 = asfloat(fragment_unnamed_55.y);
				uint fragment_unnamed_62;
				uint fragment_unnamed_64;
				fragment_unnamed_62 = 0u;
				fragment_unnamed_64 = 0u;
				uint fragment_unnamed_63;
				uint fragment_unnamed_65;
				for (uint fragment_unnamed_60 = 0u; !(int(fragment_unnamed_60) >= int(asuint(fragment_uniform_buffer_0[31u]).y)); fragment_unnamed_60++, fragment_unnamed_62 = fragment_unnamed_63, fragment_unnamed_64 = fragment_unnamed_65)
				{
					float fragment_unnamed_82 = float(int(fragment_unnamed_60));
					float fragment_unnamed_83 = mad(fragment_unnamed_57, fragment_unnamed_82, fragment_unnamed_48);
					float fragment_unnamed_84 = mad(fragment_unnamed_50, fragment_unnamed_82, fragment_unnamed_49);
					fragment_unnamed_63 = fragment_unnamed_62;
					fragment_unnamed_65 = fragment_unnamed_64;
					float fragment_unnamed_94;
					float4 fragment_unnamed_99;
					float fragment_unnamed_101;
					float fragment_unnamed_104;
					float fragment_unnamed_106;
					bool fragment_unnamed_113;
					for (uint fragment_unnamed_86 = 0u; !(int(fragment_unnamed_86) >= int(asuint(fragment_uniform_buffer_0[31u]).y)); fragment_unnamed_94 = float(int(fragment_unnamed_86)), fragment_unnamed_99 = _MainTex.Sample(sampler_MainTex, float2(mad(fragment_unnamed_51, fragment_unnamed_94, fragment_unnamed_83), mad(fragment_unnamed_59, fragment_unnamed_94, fragment_unnamed_84))), fragment_unnamed_101 = fragment_unnamed_99.x, fragment_unnamed_104 = asfloat(fragment_unnamed_63), fragment_unnamed_106 = asfloat(fragment_unnamed_63), fragment_unnamed_113 = dot(float2(asfloat(fragment_unnamed_65), fragment_unnamed_104), float2(asfloat(fragment_unnamed_65), fragment_unnamed_106)) < dot(float2(fragment_unnamed_101, fragment_unnamed_99.y), float2(fragment_unnamed_101, fragment_unnamed_99.y)), fragment_unnamed_63 = fragment_unnamed_113 ? asuint(fragment_unnamed_99.y) : fragment_unnamed_63, fragment_unnamed_86++, fragment_unnamed_65 = fragment_unnamed_113 ? asuint(fragment_unnamed_101) : fragment_unnamed_65)
					{
					}
				}
				fragment_output_0.x = asfloat(fragment_unnamed_64);
				fragment_output_0.y = asfloat(fragment_unnamed_62);
				fragment_output_0.z = 0.0f;
				fragment_output_0.w = 0.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[28] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				fragment_uniform_buffer_0[31] = float4(fragment_uniform_buffer_0[31][0], asfloat(_TileMaxLoop), fragment_uniform_buffer_0[31][2], fragment_uniform_buffer_0[31][3]);

				fragment_uniform_buffer_0[31] = float4(fragment_uniform_buffer_0[31][0], fragment_uniform_buffer_0[31][1], _TileMaxOffs[0], _TileMaxOffs[1]);

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
			GpuProgramID 280318

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

			float4 _MainTex_TexelSize;

			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

			static float2 fragment_input_0;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_0 : TEXCOORD0; // vs_TEXCOORD0
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static float4 fragment_unnamed_9;
			static float2 fragment_unnamed_46;
			static float4 fragment_unnamed_54;
			static float fragment_unnamed_64;
			static bool fragment_unnamed_70;
			static float2 fragment_unnamed_102;
			static float fragment_unnamed_119;
			static bool fragment_unnamed_123;
			static float4 fragment_unnamed_160;
			static bool fragment_unnamed_165;
			static float fragment_unnamed_211;

			void frag_main()
			{
				fragment_unnamed_9 = (_MainTex_TexelSize.yyxy * float4(0.0f, 1.0f, 1.0f, 1.0f)) + fragment_input_0.xyxy;
				float2 fragment_unnamed_42 = _MainTex.Sample(sampler_MainTex, fragment_unnamed_9.xy).xy;
				fragment_unnamed_9 = float4(fragment_unnamed_42.x, fragment_unnamed_42.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
				fragment_unnamed_46 = _MainTex.Sample(sampler_MainTex, fragment_unnamed_9.zw).xy;
				fragment_unnamed_54.x = dot(fragment_unnamed_9.xy, fragment_unnamed_9.xy);
				fragment_unnamed_64 = dot(fragment_unnamed_46, fragment_unnamed_46);
				fragment_unnamed_70 = fragment_unnamed_54.x < fragment_unnamed_64;
				float2 fragment_unnamed_77;
				if (fragment_unnamed_70)
				{
					fragment_unnamed_77 = fragment_unnamed_46;
				}
				else
				{
					fragment_unnamed_77 = fragment_unnamed_9.xy;
				}
				fragment_unnamed_9 = float4(fragment_unnamed_77.x, fragment_unnamed_77.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
				fragment_unnamed_46.x = dot(fragment_unnamed_9.xy, fragment_unnamed_9.xy);
				fragment_unnamed_54 = (_MainTex_TexelSize.xyxy * float4(1.0f, 0.0f, -1.0f, 1.0f)) + fragment_input_0.xyxy;
				fragment_unnamed_102 = _MainTex.Sample(sampler_MainTex, fragment_unnamed_54.zw).xy;
				float2 fragment_unnamed_116 = _MainTex.Sample(sampler_MainTex, fragment_unnamed_54.xy).xy;
				fragment_unnamed_54 = float4(fragment_unnamed_116.x, fragment_unnamed_116.y, fragment_unnamed_54.z, fragment_unnamed_54.w);
				fragment_unnamed_119 = dot(fragment_unnamed_102, fragment_unnamed_102);
				fragment_unnamed_123 = fragment_unnamed_119 < fragment_unnamed_46.x;
				float2 fragment_unnamed_129;
				if (fragment_unnamed_123)
				{
					fragment_unnamed_129 = fragment_unnamed_9.xy;
				}
				else
				{
					fragment_unnamed_129 = fragment_unnamed_102;
				}
				fragment_unnamed_9 = float4(fragment_unnamed_129.x, fragment_unnamed_129.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
				fragment_unnamed_46.x = dot(fragment_unnamed_9.xy, fragment_unnamed_9.xy);
				fragment_unnamed_119 = dot(fragment_unnamed_54.xy, fragment_unnamed_54.xy);
				fragment_unnamed_102 = _MainTex.Sample(sampler_MainTex, fragment_input_0).xy;
				fragment_unnamed_102 *= 1.0099999904632568359375f.xx;
				fragment_unnamed_160.x = dot(fragment_unnamed_102, fragment_unnamed_102);
				fragment_unnamed_165 = fragment_unnamed_160.x < fragment_unnamed_119;
				float2 fragment_unnamed_171;
				if (fragment_unnamed_165)
				{
					fragment_unnamed_171 = fragment_unnamed_54.xy;
				}
				else
				{
					fragment_unnamed_171 = fragment_unnamed_102;
				}
				fragment_unnamed_54 = float4(fragment_unnamed_171.x, fragment_unnamed_171.y, fragment_unnamed_54.z, fragment_unnamed_54.w);
				fragment_unnamed_119 = dot(fragment_unnamed_54.xy, fragment_unnamed_54.xy);
				fragment_unnamed_160 = ((-_MainTex_TexelSize.xyxy) * float4(-1.0f, 1.0f, 1.0f, 0.0f)) + fragment_input_0.xyxy;
				fragment_unnamed_102 = _MainTex.Sample(sampler_MainTex, fragment_unnamed_160.zw).xy;
				float2 fragment_unnamed_208 = _MainTex.Sample(sampler_MainTex, fragment_unnamed_160.xy).xy;
				fragment_unnamed_160 = float4(fragment_unnamed_208.x, fragment_unnamed_208.y, fragment_unnamed_160.z, fragment_unnamed_160.w);
				fragment_unnamed_211 = dot(fragment_unnamed_102, fragment_unnamed_102);
				fragment_unnamed_165 = fragment_unnamed_211 < fragment_unnamed_119;
				float2 fragment_unnamed_219;
				if (fragment_unnamed_165)
				{
					fragment_unnamed_219 = fragment_unnamed_54.xy;
				}
				else
				{
					fragment_unnamed_219 = fragment_unnamed_102;
				}
				fragment_unnamed_54 = float4(fragment_unnamed_219.x, fragment_unnamed_219.y, fragment_unnamed_54.z, fragment_unnamed_54.w);
				fragment_unnamed_119 = dot(fragment_unnamed_54.xy, fragment_unnamed_54.xy);
				fragment_unnamed_123 = fragment_unnamed_119 < fragment_unnamed_46.x;
				float2 fragment_unnamed_239;
				if (fragment_unnamed_123)
				{
					fragment_unnamed_239 = fragment_unnamed_9.xy;
				}
				else
				{
					fragment_unnamed_239 = fragment_unnamed_54.xy;
				}
				fragment_unnamed_9 = float4(fragment_unnamed_239.x, fragment_unnamed_239.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
				fragment_unnamed_46.x = dot(fragment_unnamed_9.xy, fragment_unnamed_9.xy);
				fragment_unnamed_119 = dot(fragment_unnamed_160.xy, fragment_unnamed_160.xy);
				fragment_unnamed_54 = ((-_MainTex_TexelSize.xyyy) * float4(1.0f, 1.0f, 0.0f, 1.0f)) + fragment_input_0.xyxy;
				fragment_unnamed_102 = _MainTex.Sample(sampler_MainTex, fragment_unnamed_54.zw).xy;
				float2 fragment_unnamed_283 = _MainTex.Sample(sampler_MainTex, fragment_unnamed_54.xy).xy;
				fragment_unnamed_54 = float4(fragment_unnamed_283.x, fragment_unnamed_283.y, fragment_unnamed_54.z, fragment_unnamed_54.w);
				fragment_unnamed_211 = dot(fragment_unnamed_102, fragment_unnamed_102);
				fragment_unnamed_165 = fragment_unnamed_211 < fragment_unnamed_119;
				float2 fragment_unnamed_293;
				if (fragment_unnamed_165)
				{
					fragment_unnamed_293 = fragment_unnamed_160.xy;
				}
				else
				{
					fragment_unnamed_293 = fragment_unnamed_102;
				}
				fragment_unnamed_102 = fragment_unnamed_293;
				fragment_unnamed_119 = dot(fragment_unnamed_102, fragment_unnamed_102);
				fragment_unnamed_160.x = dot(fragment_unnamed_54.xy, fragment_unnamed_54.xy);
				fragment_unnamed_165 = fragment_unnamed_160.x < fragment_unnamed_119;
				float2 fragment_unnamed_315;
				if (fragment_unnamed_165)
				{
					fragment_unnamed_315 = fragment_unnamed_102;
				}
				else
				{
					fragment_unnamed_315 = fragment_unnamed_54.xy;
				}
				fragment_unnamed_54 = float4(fragment_unnamed_315.x, fragment_unnamed_315.y, fragment_unnamed_54.z, fragment_unnamed_54.w);
				fragment_unnamed_119 = dot(fragment_unnamed_54.xy, fragment_unnamed_54.xy);
				fragment_unnamed_123 = fragment_unnamed_119 < fragment_unnamed_46.x;
				float2 fragment_unnamed_335;
				if (fragment_unnamed_123)
				{
					fragment_unnamed_335 = fragment_unnamed_9.xy;
				}
				else
				{
					fragment_unnamed_335 = fragment_unnamed_54.xy;
				}
				fragment_unnamed_9 = float4(fragment_unnamed_335.x, fragment_unnamed_335.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
				float2 fragment_unnamed_352 = fragment_unnamed_9.xy * 0.990099012851715087890625f.xx;
				fragment_output_0 = float4(fragment_unnamed_352.x, fragment_unnamed_352.y, fragment_output_0.z, fragment_output_0.w);
				fragment_output_0 = float4(fragment_output_0.x, fragment_output_0.y, 0.0f.xx.x, 0.0f.xx.y);
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_0 = stage_input.fragment_input_0;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			float4 _MainTex_TexelSize;

			static float4 fragment_uniform_buffer_0[29];
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
				float4 fragment_unnamed_51 = _MainTex.Sample(sampler_MainTex, float2(mad(fragment_uniform_buffer_0[28u].y, 0.0f, fragment_input_1.x), mad(fragment_uniform_buffer_0[28u].y, 1.0f, fragment_input_1.y)));
				float fragment_unnamed_53 = fragment_unnamed_51.x;
				float4 fragment_unnamed_55 = _MainTex.Sample(sampler_MainTex, float2(mad(fragment_uniform_buffer_0[28u].x, 1.0f, fragment_input_1.x), mad(fragment_uniform_buffer_0[28u].y, 1.0f, fragment_input_1.y)));
				float fragment_unnamed_57 = fragment_unnamed_55.x;
				bool fragment_unnamed_66 = dot(float2(fragment_unnamed_53, fragment_unnamed_51.y), float2(fragment_unnamed_53, fragment_unnamed_51.y)) < dot(float2(fragment_unnamed_57, fragment_unnamed_55.y), float2(fragment_unnamed_57, fragment_unnamed_55.y));
				uint fragment_unnamed_71 = fragment_unnamed_66 ? asuint(fragment_unnamed_57) : asuint(fragment_unnamed_53);
				float fragment_unnamed_72 = asfloat(fragment_unnamed_71);
				uint fragment_unnamed_73 = fragment_unnamed_66 ? asuint(fragment_unnamed_55.y) : asuint(fragment_unnamed_51.y);
				float fragment_unnamed_74 = asfloat(fragment_unnamed_73);
				float4 fragment_unnamed_91 = _MainTex.Sample(sampler_MainTex, float2(mad(fragment_uniform_buffer_0[28u].x, -1.0f, fragment_input_1.x), mad(fragment_uniform_buffer_0[28u].y, 1.0f, fragment_input_1.y)));
				float fragment_unnamed_93 = fragment_unnamed_91.x;
				float4 fragment_unnamed_95 = _MainTex.Sample(sampler_MainTex, float2(mad(fragment_uniform_buffer_0[28u].x, 1.0f, fragment_input_1.x), mad(fragment_uniform_buffer_0[28u].y, 0.0f, fragment_input_1.y)));
				float fragment_unnamed_97 = fragment_unnamed_95.x;
				bool fragment_unnamed_102 = dot(float2(fragment_unnamed_93, fragment_unnamed_91.y), float2(fragment_unnamed_93, fragment_unnamed_91.y)) < dot(float2(fragment_unnamed_72, fragment_unnamed_74), float2(fragment_unnamed_72, fragment_unnamed_74));
				uint fragment_unnamed_105 = fragment_unnamed_102 ? fragment_unnamed_71 : asuint(fragment_unnamed_93);
				float fragment_unnamed_106 = asfloat(fragment_unnamed_105);
				uint fragment_unnamed_107 = fragment_unnamed_102 ? fragment_unnamed_73 : asuint(fragment_unnamed_91.y);
				float fragment_unnamed_108 = asfloat(fragment_unnamed_107);
				float4 fragment_unnamed_119 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				precise float fragment_unnamed_123 = fragment_unnamed_119.x * 1.0099999904632568359375f;
				precise float fragment_unnamed_125 = fragment_unnamed_119.y * 1.0099999904632568359375f;
				bool fragment_unnamed_129 = dot(float2(fragment_unnamed_123, fragment_unnamed_125), float2(fragment_unnamed_123, fragment_unnamed_125)) < dot(float2(fragment_unnamed_97, fragment_unnamed_95.y), float2(fragment_unnamed_97, fragment_unnamed_95.y));
				uint fragment_unnamed_134 = fragment_unnamed_129 ? asuint(fragment_unnamed_97) : asuint(fragment_unnamed_123);
				float fragment_unnamed_135 = asfloat(fragment_unnamed_134);
				uint fragment_unnamed_136 = fragment_unnamed_129 ? asuint(fragment_unnamed_95.y) : asuint(fragment_unnamed_125);
				float fragment_unnamed_137 = asfloat(fragment_unnamed_136);
				precise float fragment_unnamed_144 = (-0.0f) - fragment_uniform_buffer_0[28u].x;
				precise float fragment_unnamed_147 = (-0.0f) - fragment_uniform_buffer_0[28u].y;
				float4 fragment_unnamed_156 = _MainTex.Sample(sampler_MainTex, float2(mad(fragment_unnamed_144, 1.0f, fragment_input_1.x), mad(fragment_unnamed_147, 0.0f, fragment_input_1.y)));
				float fragment_unnamed_158 = fragment_unnamed_156.x;
				float4 fragment_unnamed_160 = _MainTex.Sample(sampler_MainTex, float2(mad(fragment_unnamed_144, -1.0f, fragment_input_1.x), mad(fragment_unnamed_147, 1.0f, fragment_input_1.y)));
				float fragment_unnamed_162 = fragment_unnamed_160.x;
				bool fragment_unnamed_167 = dot(float2(fragment_unnamed_158, fragment_unnamed_156.y), float2(fragment_unnamed_158, fragment_unnamed_156.y)) < dot(float2(fragment_unnamed_135, fragment_unnamed_137), float2(fragment_unnamed_135, fragment_unnamed_137));
				uint fragment_unnamed_170 = fragment_unnamed_167 ? fragment_unnamed_134 : asuint(fragment_unnamed_158);
				float fragment_unnamed_171 = asfloat(fragment_unnamed_170);
				uint fragment_unnamed_172 = fragment_unnamed_167 ? fragment_unnamed_136 : asuint(fragment_unnamed_156.y);
				float fragment_unnamed_173 = asfloat(fragment_unnamed_172);
				bool fragment_unnamed_177 = dot(float2(fragment_unnamed_171, fragment_unnamed_173), float2(fragment_unnamed_171, fragment_unnamed_173)) < dot(float2(fragment_unnamed_106, fragment_unnamed_108), float2(fragment_unnamed_106, fragment_unnamed_108));
				uint fragment_unnamed_178 = fragment_unnamed_177 ? fragment_unnamed_105 : fragment_unnamed_170;
				float fragment_unnamed_179 = asfloat(fragment_unnamed_178);
				uint fragment_unnamed_180 = fragment_unnamed_177 ? fragment_unnamed_107 : fragment_unnamed_172;
				float fragment_unnamed_181 = asfloat(fragment_unnamed_180);
				precise float fragment_unnamed_191 = (-0.0f) - fragment_uniform_buffer_0[28u].x;
				precise float fragment_unnamed_193 = (-0.0f) - fragment_uniform_buffer_0[28u].y;
				float4 fragment_unnamed_202 = _MainTex.Sample(sampler_MainTex, float2(mad(fragment_unnamed_193, 0.0f, fragment_input_1.x), mad(fragment_unnamed_193, 1.0f, fragment_input_1.y)));
				float fragment_unnamed_204 = fragment_unnamed_202.x;
				float4 fragment_unnamed_206 = _MainTex.Sample(sampler_MainTex, float2(mad(fragment_unnamed_191, 1.0f, fragment_input_1.x), mad(fragment_unnamed_193, 1.0f, fragment_input_1.y)));
				float fragment_unnamed_208 = fragment_unnamed_206.x;
				bool fragment_unnamed_213 = dot(float2(fragment_unnamed_204, fragment_unnamed_202.y), float2(fragment_unnamed_204, fragment_unnamed_202.y)) < dot(float2(fragment_unnamed_162, fragment_unnamed_160.y), float2(fragment_unnamed_162, fragment_unnamed_160.y));
				uint fragment_unnamed_218 = fragment_unnamed_213 ? asuint(fragment_unnamed_162) : asuint(fragment_unnamed_204);
				float fragment_unnamed_219 = asfloat(fragment_unnamed_218);
				uint fragment_unnamed_220 = fragment_unnamed_213 ? asuint(fragment_unnamed_160.y) : asuint(fragment_unnamed_202.y);
				float fragment_unnamed_221 = asfloat(fragment_unnamed_220);
				bool fragment_unnamed_228 = dot(float2(fragment_unnamed_208, fragment_unnamed_206.y), float2(fragment_unnamed_208, fragment_unnamed_206.y)) < dot(float2(fragment_unnamed_219, fragment_unnamed_221), float2(fragment_unnamed_219, fragment_unnamed_221));
				uint fragment_unnamed_231 = fragment_unnamed_228 ? fragment_unnamed_218 : asuint(fragment_unnamed_208);
				float fragment_unnamed_232 = asfloat(fragment_unnamed_231);
				uint fragment_unnamed_233 = fragment_unnamed_228 ? fragment_unnamed_220 : asuint(fragment_unnamed_206.y);
				float fragment_unnamed_234 = asfloat(fragment_unnamed_233);
				bool fragment_unnamed_238 = dot(float2(fragment_unnamed_232, fragment_unnamed_234), float2(fragment_unnamed_232, fragment_unnamed_234)) < dot(float2(fragment_unnamed_179, fragment_unnamed_181), float2(fragment_unnamed_179, fragment_unnamed_181));
				precise float fragment_unnamed_243 = asfloat(fragment_unnamed_238 ? fragment_unnamed_178 : fragment_unnamed_231) * 0.990099012851715087890625f;
				precise float fragment_unnamed_245 = asfloat(fragment_unnamed_238 ? fragment_unnamed_180 : fragment_unnamed_233) * 0.990099012851715087890625f;
				fragment_output_0.x = fragment_unnamed_243;
				fragment_output_0.y = fragment_unnamed_245;
				fragment_output_0.z = 0.0f;
				fragment_output_0.w = 0.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[28] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

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
			GpuProgramID 348419

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

			float4 _ScreenParams;
			float4 _MainTex_TexelSize;
			float2 _VelocityTex_TexelSize;
			float2 _NeighborMaxTex_TexelSize;
			float _MaxBlurRadius;
			float _LoopCount;

			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;
			Texture2D<float4> _NeighborMaxTex;
			SamplerState sampler_NeighborMaxTex;
			Texture2D<float4> _VelocityTex;
			SamplerState sampler_VelocityTex;

			static float2 fragment_input_0;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_0 : TEXCOORD0; // vs_TEXCOORD0
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static float4 fragment_unnamed_9;
			static float4 fragment_unnamed_25;
			static float4 fragment_unnamed_80;
			static float fragment_unnamed_125;
			static bool fragment_unnamed_135;
			static float fragment_unnamed_174;
			static float3 fragment_unnamed_183;
			static float fragment_unnamed_196;
			static bool fragment_unnamed_202;
			static float2 fragment_unnamed_244;
			static float fragment_unnamed_272;
			static float4 fragment_unnamed_278;
			static float4 fragment_unnamed_281;
			static float fragment_unnamed_286;
			static float fragment_unnamed_288;
			static float fragment_unnamed_289;
			static bool2 fragment_unnamed_300;
			static float3 fragment_unnamed_311;
			static float fragment_unnamed_343;
			static float3 fragment_unnamed_369;
			static float fragment_unnamed_467;

			void frag_main()
			{
				fragment_unnamed_9 = _MainTex.Sample(sampler_MainTex, fragment_input_0);
				float2 fragment_unnamed_30 = fragment_input_0 + float2(2.0f, 0.0f);
				fragment_unnamed_25 = float4(fragment_unnamed_30.x, fragment_unnamed_30.y, fragment_unnamed_25.z, fragment_unnamed_25.w);
				float2 fragment_unnamed_44 = fragment_unnamed_25.xy * _ScreenParams.xy;
				fragment_unnamed_25 = float4(fragment_unnamed_44.x, fragment_unnamed_44.y, fragment_unnamed_25.z, fragment_unnamed_25.w);
				float2 fragment_unnamed_49 = floor(fragment_unnamed_25.xy);
				fragment_unnamed_25 = float4(fragment_unnamed_49.x, fragment_unnamed_49.y, fragment_unnamed_25.z, fragment_unnamed_25.w);
				fragment_unnamed_25.x = dot(float2(0.067110560834407806396484375f, 0.005837149918079376220703125f), fragment_unnamed_25.xy);
				fragment_unnamed_25.x = frac(fragment_unnamed_25.x);
				fragment_unnamed_25.x *= 52.98291778564453125f;
				fragment_unnamed_25.x = frac(fragment_unnamed_25.x);
				fragment_unnamed_25.x *= 6.283185482025146484375f;
				fragment_unnamed_80.x = cos(fragment_unnamed_25.x);
				fragment_unnamed_25.x = sin(fragment_unnamed_25.x);
				fragment_unnamed_80.y = fragment_unnamed_25.x;
				float2 fragment_unnamed_102 = fragment_unnamed_80.xy * float2(_NeighborMaxTex_TexelSize.x, _NeighborMaxTex_TexelSize.y);
				fragment_unnamed_25 = float4(fragment_unnamed_102.x, fragment_unnamed_102.y, fragment_unnamed_25.z, fragment_unnamed_25.w);
				float2 fragment_unnamed_111 = (fragment_unnamed_25.xy * 0.25f.xx) + fragment_input_0;
				fragment_unnamed_25 = float4(fragment_unnamed_111.x, fragment_unnamed_111.y, fragment_unnamed_25.z, fragment_unnamed_25.w);
				float2 fragment_unnamed_122 = _NeighborMaxTex.Sample(sampler_NeighborMaxTex, fragment_unnamed_25.xy).xy;
				fragment_unnamed_25 = float4(fragment_unnamed_122.x, fragment_unnamed_122.y, fragment_unnamed_25.z, fragment_unnamed_25.w);
				fragment_unnamed_125 = dot(fragment_unnamed_25.xy, fragment_unnamed_25.xy);
				fragment_unnamed_125 = sqrt(fragment_unnamed_125);
				fragment_unnamed_135 = fragment_unnamed_125 < 2.0f;
				if (fragment_unnamed_135)
				{
					fragment_output_0 = fragment_unnamed_9;
					return;
				}
				float3 fragment_unnamed_153 = _VelocityTex.SampleLevel(sampler_VelocityTex, fragment_input_0, 0.0f).xyz;
				fragment_unnamed_80 = float4(fragment_unnamed_153.x, fragment_unnamed_153.y, fragment_unnamed_153.z, fragment_unnamed_80.w);
				float2 fragment_unnamed_162 = (fragment_unnamed_80.xy * 2.0f.xx) + (-1.0f).xx;
				fragment_unnamed_80 = float4(fragment_unnamed_162.x, fragment_unnamed_162.y, fragment_unnamed_80.z, fragment_unnamed_80.w);
				float2 fragment_unnamed_171 = fragment_unnamed_80.xy * _MaxBlurRadius.xx;
				fragment_unnamed_80 = float4(fragment_unnamed_171.x, fragment_unnamed_171.y, fragment_unnamed_80.z, fragment_unnamed_80.w);
				fragment_unnamed_174 = dot(fragment_unnamed_80.xy, fragment_unnamed_80.xy);
				fragment_unnamed_174 = sqrt(fragment_unnamed_174);
				float2 fragment_unnamed_189 = max(fragment_unnamed_174.xx, float2(0.5f, 1.0f));
				fragment_unnamed_183 = float3(fragment_unnamed_189.x, fragment_unnamed_189.y, fragment_unnamed_183.z);
				fragment_unnamed_174 = 1.0f / fragment_unnamed_80.z;
				fragment_unnamed_196 = fragment_unnamed_183.x + fragment_unnamed_183.x;
				fragment_unnamed_202 = fragment_unnamed_125 < fragment_unnamed_196;
				fragment_unnamed_183.x = fragment_unnamed_125 / fragment_unnamed_183.x;
				float2 fragment_unnamed_215 = fragment_unnamed_80.xy * fragment_unnamed_183.xx;
				fragment_unnamed_80 = float4(fragment_unnamed_215.x, fragment_unnamed_215.y, fragment_unnamed_80.z, fragment_unnamed_80.w);
				float2 fragment_unnamed_220;
				if (fragment_unnamed_202)
				{
					fragment_unnamed_220 = fragment_unnamed_80.xy;
				}
				else
				{
					fragment_unnamed_220 = fragment_unnamed_25.xy;
				}
				fragment_unnamed_80 = float4(fragment_unnamed_220.x, fragment_unnamed_220.y, fragment_unnamed_80.z, fragment_unnamed_80.w);
				fragment_unnamed_196 = fragment_unnamed_125 * 0.5f;
				fragment_unnamed_196 = min(fragment_unnamed_196, _LoopCount);
				fragment_unnamed_196 = floor(fragment_unnamed_196);
				fragment_unnamed_183.x = 1.0f / fragment_unnamed_196;
				fragment_unnamed_244 = fragment_input_0 * _ScreenParams.xy;
				fragment_unnamed_244 = floor(fragment_unnamed_244);
				fragment_unnamed_244.x = dot(float2(0.067110560834407806396484375f, 0.005837149918079376220703125f), fragment_unnamed_244);
				fragment_unnamed_183.z = frac(fragment_unnamed_244.x);
				fragment_unnamed_244 = fragment_unnamed_183.zx * float2(52.98291778564453125f, 0.25f);
				fragment_unnamed_244.x = frac(fragment_unnamed_244.x);
				fragment_unnamed_244.x += (-0.5f);
				fragment_unnamed_272 = ((-fragment_unnamed_183.x) * 0.5f) + 1.0f;
				fragment_unnamed_278.w = 1.0f;
				fragment_unnamed_281.x = 0.0f;
				fragment_unnamed_281.y = 0.0f;
				fragment_unnamed_281.z = 0.0f;
				fragment_unnamed_281.w = 0.0f;
				fragment_unnamed_286 = fragment_unnamed_272;
				fragment_unnamed_288 = 0.0f;
				fragment_unnamed_289 = fragment_unnamed_183.y;
				float2 fragment_unnamed_332;
				float fragment_unnamed_347;
				float fragment_unnamed_507;
				while (true)
				{
					fragment_unnamed_300.x = fragment_unnamed_244.y >= fragment_unnamed_286;
					if (fragment_unnamed_300.x)
					{
						break;
					}
					float2 fragment_unnamed_315 = fragment_unnamed_288.xx * float2(0.25f, 0.5f);
					fragment_unnamed_311 = float3(fragment_unnamed_315.x, fragment_unnamed_315.y, fragment_unnamed_311.z);
					float2 fragment_unnamed_320 = frac(fragment_unnamed_311.xy);
					fragment_unnamed_311 = float3(fragment_unnamed_320.x, fragment_unnamed_320.y, fragment_unnamed_311.z);
					fragment_unnamed_300 = bool4(float4(0.499000012874603271484375f, 0.499000012874603271484375f, 0.0f, 0.0f).x < fragment_unnamed_311.xyxx.x, float4(0.499000012874603271484375f, 0.499000012874603271484375f, 0.0f, 0.0f).y < fragment_unnamed_311.xyxx.y, float4(0.499000012874603271484375f, 0.499000012874603271484375f, 0.0f, 0.0f).z < fragment_unnamed_311.xyxx.z, float4(0.499000012874603271484375f, 0.499000012874603271484375f, 0.0f, 0.0f).w < fragment_unnamed_311.xyxx.w).xy;
					if (fragment_unnamed_300.x)
					{
						fragment_unnamed_332 = fragment_unnamed_80.xy;
					}
					else
					{
						fragment_unnamed_332 = fragment_unnamed_25.xy;
					}
					fragment_unnamed_311 = float3(fragment_unnamed_332.x, fragment_unnamed_311.y, fragment_unnamed_332.y);
					if (fragment_unnamed_300.y)
					{
						fragment_unnamed_347 = -fragment_unnamed_286;
					}
					else
					{
						fragment_unnamed_347 = fragment_unnamed_286;
					}
					fragment_unnamed_343 = fragment_unnamed_347;
					fragment_unnamed_343 = (fragment_unnamed_244.x * fragment_unnamed_183.x) + fragment_unnamed_343;
					float2 fragment_unnamed_366 = fragment_unnamed_343.xx * fragment_unnamed_311.xz;
					fragment_unnamed_311 = float3(fragment_unnamed_366.x, fragment_unnamed_311.y, fragment_unnamed_366.y);
					float2 fragment_unnamed_378 = (fragment_unnamed_311.xz * _MainTex_TexelSize.xy) + fragment_input_0;
					fragment_unnamed_369 = float3(fragment_unnamed_378.x, fragment_unnamed_378.y, fragment_unnamed_369.z);
					float2 fragment_unnamed_389 = (fragment_unnamed_311.xz * _VelocityTex_TexelSize) + fragment_input_0;
					fragment_unnamed_311 = float3(fragment_unnamed_389.x, fragment_unnamed_311.y, fragment_unnamed_389.y);
					float3 fragment_unnamed_398 = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_369.xy, 0.0f).xyz;
					fragment_unnamed_278 = float4(fragment_unnamed_398.x, fragment_unnamed_398.y, fragment_unnamed_398.z, fragment_unnamed_278.w);
					fragment_unnamed_369 = _VelocityTex.SampleLevel(sampler_VelocityTex, fragment_unnamed_311.xz, 0.0f).xyz;
					float2 fragment_unnamed_411 = (fragment_unnamed_369.xy * 2.0f.xx) + (-1.0f).xx;
					fragment_unnamed_311 = float3(fragment_unnamed_411.x, fragment_unnamed_311.y, fragment_unnamed_411.y);
					float2 fragment_unnamed_419 = fragment_unnamed_311.xz * _MaxBlurRadius.xx;
					fragment_unnamed_311 = float3(fragment_unnamed_419.x, fragment_unnamed_311.y, fragment_unnamed_419.y);
					fragment_unnamed_369.x = fragment_unnamed_80.z + (-fragment_unnamed_369.z);
					fragment_unnamed_369.x = fragment_unnamed_174 * fragment_unnamed_369.x;
					fragment_unnamed_369.x *= 20.0f;
					fragment_unnamed_369.x = clamp(fragment_unnamed_369.x, 0.0f, 1.0f);
					fragment_unnamed_311.x = dot(fragment_unnamed_311.xz, fragment_unnamed_311.xz);
					fragment_unnamed_311.x = sqrt(fragment_unnamed_311.x);
					fragment_unnamed_311.x = (-fragment_unnamed_289) + fragment_unnamed_311.x;
					fragment_unnamed_311.x = (fragment_unnamed_369.x * fragment_unnamed_311.x) + fragment_unnamed_289;
					fragment_unnamed_467 = ((-fragment_unnamed_125) * abs(fragment_unnamed_343)) + fragment_unnamed_311.x;
					fragment_unnamed_467 = clamp(fragment_unnamed_467, 0.0f, 1.0f);
					fragment_unnamed_467 /= fragment_unnamed_311.x;
					fragment_unnamed_343 = (-fragment_unnamed_286) + 1.2000000476837158203125f;
					fragment_unnamed_467 = fragment_unnamed_343 * fragment_unnamed_467;
					fragment_unnamed_281 = (fragment_unnamed_278 * fragment_unnamed_467.xxxx) + fragment_unnamed_281;
					fragment_unnamed_289 = max(fragment_unnamed_289, fragment_unnamed_311.x);
					fragment_unnamed_278.x = (-fragment_unnamed_183.x) + fragment_unnamed_286;
					if (fragment_unnamed_300.y)
					{
						fragment_unnamed_507 = fragment_unnamed_278.x;
					}
					else
					{
						fragment_unnamed_507 = fragment_unnamed_286;
					}
					fragment_unnamed_286 = fragment_unnamed_507;
					fragment_unnamed_288 += 1.0f;
				}
				fragment_unnamed_25.x = dot(fragment_unnamed_289.xx, fragment_unnamed_196.xx);
				fragment_unnamed_25.x = 1.2000000476837158203125f / fragment_unnamed_25.x;
				fragment_unnamed_80 = float4(fragment_unnamed_9.xyz.x, fragment_unnamed_9.xyz.y, fragment_unnamed_9.xyz.z, fragment_unnamed_80.w);
				fragment_unnamed_80.w = 1.0f;
				fragment_unnamed_25 = (fragment_unnamed_80 * fragment_unnamed_25.xxxx) + fragment_unnamed_281;
				float3 fragment_unnamed_542 = fragment_unnamed_25.xyz / fragment_unnamed_25.www;
				fragment_output_0 = float4(fragment_unnamed_542.x, fragment_unnamed_542.y, fragment_unnamed_542.z, fragment_output_0.w);
				fragment_output_0.w = fragment_unnamed_9.w;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_0 = stage_input.fragment_input_0;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			float4 _ScreenParams;
			float4 _MainTex_TexelSize;
			float2 _VelocityTex_TexelSize;
			float2 _NeighborMaxTex_TexelSize;
			float _MaxBlurRadius;
			float _LoopCount;

			static float4 fragment_uniform_buffer_0[33];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _VelocityTex;
			Texture2D<float4> _NeighborMaxTex;
			SamplerState sampler_MainTex;
			SamplerState sampler_VelocityTex;
			SamplerState sampler_NeighborMaxTex;

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
				float4 fragment_unnamed_47 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				float fragment_unnamed_49 = fragment_unnamed_47.x;
				float fragment_unnamed_50 = fragment_unnamed_47.y;
				float fragment_unnamed_51 = fragment_unnamed_47.z;
				float fragment_unnamed_52 = fragment_unnamed_47.w;
				precise float fragment_unnamed_57 = fragment_input_1.x + 2.0f;
				precise float fragment_unnamed_59 = fragment_input_1.y + 0.0f;
				precise float fragment_unnamed_66 = fragment_unnamed_57 * fragment_uniform_buffer_0[22u].x;
				precise float fragment_unnamed_67 = fragment_unnamed_59 * fragment_uniform_buffer_0[22u].y;
				precise float fragment_unnamed_77 = frac(dot(float2(0.067110560834407806396484375f, 0.005837149918079376220703125f), float2(floor(fragment_unnamed_66), floor(fragment_unnamed_67)))) * 52.98291778564453125f;
				precise float fragment_unnamed_80 = frac(fragment_unnamed_77) * 6.283185482025146484375f;
				precise float fragment_unnamed_89 = cos(fragment_unnamed_80) * fragment_uniform_buffer_0[30u].z;
				precise float fragment_unnamed_90 = sin(fragment_unnamed_80) * fragment_uniform_buffer_0[30u].w;
				float4 fragment_unnamed_99 = _NeighborMaxTex.Sample(sampler_NeighborMaxTex, float2(mad(fragment_unnamed_89, 0.25f, fragment_input_1.x), mad(fragment_unnamed_90, 0.25f, fragment_input_1.y)));
				float fragment_unnamed_101 = fragment_unnamed_99.x;
				float fragment_unnamed_102 = fragment_unnamed_99.y;
				float fragment_unnamed_106 = sqrt(dot(float2(fragment_unnamed_101, fragment_unnamed_102), float2(fragment_unnamed_101, fragment_unnamed_102)));
				if (fragment_unnamed_106 < 2.0f)
				{
					fragment_output_0.x = fragment_unnamed_49;
					fragment_output_0.y = fragment_unnamed_50;
					fragment_output_0.z = fragment_unnamed_51;
					fragment_output_0.w = fragment_unnamed_52;
					return;
				}
				else
				{
					float4 fragment_unnamed_121 = _VelocityTex.SampleLevel(sampler_VelocityTex, float2(fragment_input_1.x, fragment_input_1.y), 0.0f);
					float fragment_unnamed_125 = fragment_unnamed_121.z;
					precise float fragment_unnamed_133 = mad(fragment_unnamed_121.x, 2.0f, -1.0f) * fragment_uniform_buffer_0[32u].x;
					precise float fragment_unnamed_134 = mad(fragment_unnamed_121.y, 2.0f, -1.0f) * fragment_uniform_buffer_0[32u].x;
					float fragment_unnamed_138 = sqrt(dot(float2(fragment_unnamed_133, fragment_unnamed_134), float2(fragment_unnamed_133, fragment_unnamed_134)));
					float fragment_unnamed_139 = max(fragment_unnamed_138, 0.5f);
					precise float fragment_unnamed_143 = 1.0f / fragment_unnamed_125;
					precise float fragment_unnamed_144 = fragment_unnamed_139 + fragment_unnamed_139;
					bool fragment_unnamed_145 = fragment_unnamed_106 < fragment_unnamed_144;
					precise float fragment_unnamed_146 = fragment_unnamed_106 / fragment_unnamed_139;
					precise float fragment_unnamed_147 = fragment_unnamed_133 * fragment_unnamed_146;
					precise float fragment_unnamed_148 = fragment_unnamed_134 * fragment_unnamed_146;
					uint fragment_unnamed_153 = fragment_unnamed_145 ? asuint(fragment_unnamed_147) : asuint(fragment_unnamed_101);
					uint fragment_unnamed_154 = fragment_unnamed_145 ? asuint(fragment_unnamed_148) : asuint(fragment_unnamed_102);
					precise float fragment_unnamed_155 = fragment_unnamed_106 * 0.5f;
					float fragment_unnamed_160 = floor(min(fragment_unnamed_155, fragment_uniform_buffer_0[32u].z));
					precise float fragment_unnamed_161 = 1.0f / fragment_unnamed_160;
					precise float fragment_unnamed_170 = fragment_input_1.x * fragment_uniform_buffer_0[22u].x;
					precise float fragment_unnamed_171 = fragment_input_1.y * fragment_uniform_buffer_0[22u].y;
					precise float fragment_unnamed_178 = frac(dot(float2(0.067110560834407806396484375f, 0.005837149918079376220703125f), float2(floor(fragment_unnamed_170), floor(fragment_unnamed_171)))) * 52.98291778564453125f;
					precise float fragment_unnamed_179 = fragment_unnamed_161 * 0.25f;
					precise float fragment_unnamed_181 = frac(fragment_unnamed_178) + (-0.5f);
					precise float fragment_unnamed_183 = (-0.0f) - fragment_unnamed_161;
					float fragment_unnamed_185 = mad(fragment_unnamed_183, 0.5f, 1.0f);
					float fragment_unnamed_186 = asfloat(1065353216u);
					float fragment_unnamed_192 = asfloat(0u);
					float fragment_unnamed_193;
					float fragment_unnamed_199;
					float fragment_unnamed_201;
					float fragment_unnamed_203;
					float fragment_unnamed_205;
					fragment_unnamed_193 = asfloat(0u);
					fragment_unnamed_199 = max(fragment_unnamed_138, 1.0f);
					fragment_unnamed_201 = asfloat(0u);
					fragment_unnamed_203 = asfloat(0u);
					fragment_unnamed_205 = asfloat(0u);
					precise float fragment_unnamed_198;
					precise float fragment_unnamed_225;
					precise float fragment_unnamed_226;
					bool fragment_unnamed_229;
					bool fragment_unnamed_231;
					precise float fragment_unnamed_238;
					float fragment_unnamed_240;
					precise float fragment_unnamed_241;
					precise float fragment_unnamed_242;
					float4 fragment_unnamed_265;
					float4 fragment_unnamed_271;
					precise float fragment_unnamed_281;
					precise float fragment_unnamed_282;
					precise float fragment_unnamed_283;
					precise float fragment_unnamed_284;
					precise float fragment_unnamed_285;
					precise float fragment_unnamed_286;
					precise float fragment_unnamed_293;
					precise float fragment_unnamed_294;
					float fragment_unnamed_295;
					precise float fragment_unnamed_296;
					precise float fragment_unnamed_300;
					precise float fragment_unnamed_301;
					precise float fragment_unnamed_302;
					precise float fragment_unnamed_303;
					precise float fragment_unnamed_304;
					precise float fragment_unnamed_305;
					for (float fragment_unnamed_195 = fragment_unnamed_185, fragment_unnamed_197 = fragment_unnamed_192; !(fragment_unnamed_179 >= fragment_unnamed_195); fragment_unnamed_225 = fragment_unnamed_197 * 0.25f, fragment_unnamed_226 = fragment_unnamed_197 * 0.5f, fragment_unnamed_229 = 0.499000012874603271484375f < frac(fragment_unnamed_225), fragment_unnamed_231 = 0.499000012874603271484375f < frac(fragment_unnamed_226), fragment_unnamed_238 = (-0.0f) - fragment_unnamed_195, fragment_unnamed_240 = mad(fragment_unnamed_181, fragment_unnamed_161, fragment_unnamed_231 ? fragment_unnamed_238 : fragment_unnamed_195), fragment_unnamed_241 = fragment_unnamed_240 * asfloat(fragment_unnamed_229 ? fragment_unnamed_153 : asuint(fragment_unnamed_101)), fragment_unnamed_242 = fragment_unnamed_240 * asfloat(fragment_unnamed_229 ? fragment_unnamed_154 : asuint(fragment_unnamed_102)), fragment_unnamed_265 = _MainTex.SampleLevel(sampler_MainTex, float2(mad(fragment_unnamed_241, fragment_uniform_buffer_0[28u].x, fragment_input_1.x), mad(fragment_unnamed_242, fragment_uniform_buffer_0[28u].y, fragment_input_1.y)), 0.0f), fragment_unnamed_271 = _VelocityTex.SampleLevel(sampler_VelocityTex, float2(mad(fragment_unnamed_241, fragment_uniform_buffer_0[30u].x, fragment_input_1.x), mad(fragment_unnamed_242, fragment_uniform_buffer_0[30u].y, fragment_input_1.y)), 0.0f), fragment_unnamed_281 = mad(fragment_unnamed_271.x, 2.0f, -1.0f) * fragment_uniform_buffer_0[32u].x, fragment_unnamed_282 = mad(fragment_unnamed_271.y, 2.0f, -1.0f) * fragment_uniform_buffer_0[32u].x, fragment_unnamed_283 = (-0.0f) - fragment_unnamed_271.z, fragment_unnamed_284 = fragment_unnamed_125 + fragment_unnamed_283, fragment_unnamed_285 = fragment_unnamed_143 * fragment_unnamed_284, fragment_unnamed_286 = fragment_unnamed_285 * 20.0f, fragment_unnamed_293 = (-0.0f) - fragment_unnamed_199, fragment_unnamed_294 = fragment_unnamed_293 + sqrt(dot(float2(fragment_unnamed_281, fragment_unnamed_282), float2(fragment_unnamed_281, fragment_unnamed_282))), fragment_unnamed_295 = mad(clamp(fragment_unnamed_286, 0.0f, 1.0f), fragment_unnamed_294, fragment_unnamed_199), fragment_unnamed_296 = (-0.0f) - fragment_unnamed_106, fragment_unnamed_300 = clamp(mad(fragment_unnamed_296, abs(fragment_unnamed_240), fragment_unnamed_295), 0.0f, 1.0f) / fragment_unnamed_295, fragment_unnamed_301 = (-0.0f) - fragment_unnamed_195, fragment_unnamed_302 = fragment_unnamed_301 + 1.2000000476837158203125f, fragment_unnamed_303 = fragment_unnamed_302 * fragment_unnamed_300, fragment_unnamed_304 = (-0.0f) - fragment_unnamed_161, fragment_unnamed_305 = fragment_unnamed_304 + fragment_unnamed_195, fragment_unnamed_198 = fragment_unnamed_197 + 1.0f, fragment_unnamed_193 = mad(fragment_unnamed_186, fragment_unnamed_303, fragment_unnamed_193), fragment_unnamed_195 = asfloat(fragment_unnamed_231 ? asuint(fragment_unnamed_305) : asuint(fragment_unnamed_195)), fragment_unnamed_197 = fragment_unnamed_198, fragment_unnamed_199 = max(fragment_unnamed_199, fragment_unnamed_295), fragment_unnamed_201 = mad(fragment_unnamed_265.z, fragment_unnamed_303, fragment_unnamed_201), fragment_unnamed_203 = mad(fragment_unnamed_265.y, fragment_unnamed_303, fragment_unnamed_203), fragment_unnamed_205 = mad(fragment_unnamed_265.x, fragment_unnamed_303, fragment_unnamed_205))
					{
					}
					precise float fragment_unnamed_211 = 1.2000000476837158203125f / dot(fragment_unnamed_199.xx, fragment_unnamed_160.xx);
					float fragment_unnamed_217 = mad(asfloat(1065353216u), fragment_unnamed_211, fragment_unnamed_193);
					precise float fragment_unnamed_218 = mad(fragment_unnamed_49, fragment_unnamed_211, fragment_unnamed_205) / fragment_unnamed_217;
					precise float fragment_unnamed_219 = mad(fragment_unnamed_50, fragment_unnamed_211, fragment_unnamed_203) / fragment_unnamed_217;
					precise float fragment_unnamed_220 = mad(fragment_unnamed_51, fragment_unnamed_211, fragment_unnamed_201) / fragment_unnamed_217;
					fragment_output_0.x = fragment_unnamed_218;
					fragment_output_0.y = fragment_unnamed_219;
					fragment_output_0.z = fragment_unnamed_220;
					fragment_output_0.w = fragment_unnamed_52;
					return;
				}
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[22] = float4(_ScreenParams[0], _ScreenParams[1], _ScreenParams[2], _ScreenParams[3]);

				fragment_uniform_buffer_0[28] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				fragment_uniform_buffer_0[30] = float4(_VelocityTex_TexelSize[0], _VelocityTex_TexelSize[1], fragment_uniform_buffer_0[30][2], fragment_uniform_buffer_0[30][3]);

				fragment_uniform_buffer_0[30] = float4(fragment_uniform_buffer_0[30][0], fragment_uniform_buffer_0[30][1], _NeighborMaxTex_TexelSize[0], _NeighborMaxTex_TexelSize[1]);

				fragment_uniform_buffer_0[32] = float4(_MaxBlurRadius, fragment_uniform_buffer_0[32][1], fragment_uniform_buffer_0[32][2], fragment_uniform_buffer_0[32][3]);

				fragment_uniform_buffer_0[32] = float4(fragment_uniform_buffer_0[32][0], fragment_uniform_buffer_0[32][1], _LoopCount, fragment_uniform_buffer_0[32][3]);

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
