Shader "Hidden/PostProcessing/DepthOfField"
{
	Properties
	{
	}
	SubShader
	{
		Pass
		{
			Name "CoC Calculation"
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 38108

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

			float4 _ZBufferParams;
			float _Distance;
			float _LensCoeff;
			float _RcpMaxCoC;

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
			static float fragment_unnamed_46;

			void frag_main()
			{
				fragment_unnamed_8 = _CameraDepthTexture.Sample(sampler_CameraDepthTexture, fragment_input_0).x;
				fragment_unnamed_8 = (_ZBufferParams.z * fragment_unnamed_8) + _ZBufferParams.w;
				fragment_unnamed_8 = 1.0f / fragment_unnamed_8;
				fragment_unnamed_46 = fragment_unnamed_8 + (-_Distance);
				fragment_unnamed_8 = max(fragment_unnamed_8, 9.9999997473787516355514526367188e-05f);
				fragment_unnamed_46 *= _LensCoeff;
				fragment_unnamed_8 = fragment_unnamed_46 / fragment_unnamed_8;
				fragment_unnamed_8 *= 0.5f;
				fragment_unnamed_8 = (fragment_unnamed_8 * _RcpMaxCoC) + 0.5f;
				fragment_output_0 = fragment_unnamed_8.xxxx;
				fragment_output_0 = clamp(fragment_output_0, 0.0f.xxxx, 1.0f.xxxx);
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_0 = stage_input.fragment_input_0;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			float4 _ZBufferParams;
			float _Distance;
			float _LensCoeff;
			float _RcpMaxCoC;

			static float4 fragment_uniform_buffer_0[31];
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
				precise float fragment_unnamed_52 = 1.0f / mad(fragment_uniform_buffer_0[21u].z, _CameraDepthTexture.Sample(sampler_CameraDepthTexture, float2(fragment_input_1.x, fragment_input_1.y)).x, fragment_uniform_buffer_0[21u].w);
				precise float fragment_unnamed_58 = (-0.0f) - fragment_uniform_buffer_0[30u].x;
				precise float fragment_unnamed_60 = fragment_unnamed_52 + fragment_unnamed_58;
				precise float fragment_unnamed_66 = fragment_unnamed_60 * fragment_uniform_buffer_0[30u].y;
				precise float fragment_unnamed_67 = fragment_unnamed_66 / max(fragment_unnamed_52, 9.9999997473787516355514526367188e-05f);
				precise float fragment_unnamed_68 = fragment_unnamed_67 * 0.5f;
				float fragment_unnamed_74 = clamp(mad(fragment_unnamed_68, fragment_uniform_buffer_0[30u].w, 0.5f), 0.0f, 1.0f);
				fragment_output_0.x = fragment_unnamed_74;
				fragment_output_0.y = fragment_unnamed_74;
				fragment_output_0.z = fragment_unnamed_74;
				fragment_output_0.w = fragment_unnamed_74;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[21] = float4(_ZBufferParams[0], _ZBufferParams[1], _ZBufferParams[2], _ZBufferParams[3]);

				fragment_uniform_buffer_0[30] = float4(_Distance, fragment_uniform_buffer_0[30][1], fragment_uniform_buffer_0[30][2], fragment_uniform_buffer_0[30][3]);

				fragment_uniform_buffer_0[30] = float4(fragment_uniform_buffer_0[30][0], _LensCoeff, fragment_uniform_buffer_0[30][2], fragment_uniform_buffer_0[30][3]);

				fragment_uniform_buffer_0[30] = float4(fragment_uniform_buffer_0[30][0], fragment_uniform_buffer_0[30][1], fragment_uniform_buffer_0[30][2], _RcpMaxCoC);

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
			Name "CoC Temporal Filter"
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 74593

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
			float3 _TaaParams;

			Texture2D<float4> _CoCTex;
			SamplerState sampler_CoCTex;
			Texture2D<float4> _CameraMotionVectorsTexture;
			SamplerState sampler_CameraMotionVectorsTexture;
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

			static float3 fragment_unnamed_9;
			static float4 fragment_unnamed_28;
			static float fragment_unnamed_54;
			static bool fragment_unnamed_115;
			static float4 fragment_unnamed_120;
			static bool fragment_unnamed_140;
			static float2 fragment_unnamed_147;
			static float2 fragment_unnamed_153;
			static float3 fragment_unnamed_194;
			static bool fragment_unnamed_211;
			static float fragment_unnamed_245;

			void frag_main()
			{
				float2 fragment_unnamed_24 = _MainTex_TexelSize.yy * float2(-0.0f, -1.0f);
				fragment_unnamed_9 = float3(fragment_unnamed_24.x, fragment_unnamed_24.y, fragment_unnamed_9.z);
				fragment_unnamed_28 = ((-_MainTex_TexelSize.xyyy) * float4(1.0f, 0.0f, 0.0f, 1.0f)) + fragment_input_0.xyxy;
				fragment_unnamed_28 = clamp(fragment_unnamed_28, 0.0f.xxxx, 1.0f.xxxx);
				fragment_unnamed_28 *= _RenderViewportScaleFactor.xxxx;
				fragment_unnamed_54 = _CoCTex.Sample(sampler_CoCTex, fragment_unnamed_28.xy).x;
				fragment_unnamed_9.z = _CoCTex.Sample(sampler_CoCTex, fragment_unnamed_28.zw).x;
				float2 fragment_unnamed_87 = fragment_input_0 + (-_TaaParams.xy);
				fragment_unnamed_28 = float4(fragment_unnamed_87.x, fragment_unnamed_87.y, fragment_unnamed_28.z, fragment_unnamed_28.w);
				float2 fragment_unnamed_94 = clamp(fragment_unnamed_28.xy, 0.0f.xx, 1.0f.xx);
				fragment_unnamed_28 = float4(fragment_unnamed_94.x, fragment_unnamed_94.y, fragment_unnamed_28.z, fragment_unnamed_28.w);
				float2 fragment_unnamed_102 = fragment_unnamed_28.xy * _RenderViewportScaleFactor.xx;
				fragment_unnamed_28 = float4(fragment_unnamed_102.x, fragment_unnamed_102.y, fragment_unnamed_28.z, fragment_unnamed_28.w);
				fragment_unnamed_28.x = _CoCTex.Sample(sampler_CoCTex, fragment_unnamed_28.xy).x;
				fragment_unnamed_115 = fragment_unnamed_54 < fragment_unnamed_28.x;
				float fragment_unnamed_123;
				if (fragment_unnamed_115)
				{
					fragment_unnamed_123 = fragment_unnamed_54;
				}
				else
				{
					fragment_unnamed_123 = fragment_unnamed_28.x;
				}
				fragment_unnamed_120.z = fragment_unnamed_123;
				fragment_unnamed_54 = max(fragment_unnamed_54, fragment_unnamed_28.x);
				fragment_unnamed_54 = max(fragment_unnamed_9.z, fragment_unnamed_54);
				fragment_unnamed_140 = fragment_unnamed_9.z < fragment_unnamed_120.z;
				fragment_unnamed_147 = _MainTex_TexelSize.xy * float2(1.0f, 0.0f);
				fragment_unnamed_153 = -fragment_unnamed_147;
				float2 fragment_unnamed_158;
				if (fragment_unnamed_115)
				{
					fragment_unnamed_158 = fragment_unnamed_153;
				}
				else
				{
					fragment_unnamed_158 = 0.0f.xx;
				}
				fragment_unnamed_120 = float4(fragment_unnamed_158.x, fragment_unnamed_158.y, fragment_unnamed_120.z, fragment_unnamed_120.w);
				float3 fragment_unnamed_169;
				if (fragment_unnamed_140)
				{
					fragment_unnamed_169 = fragment_unnamed_9;
				}
				else
				{
					fragment_unnamed_169 = fragment_unnamed_120.xyz;
				}
				fragment_unnamed_9 = fragment_unnamed_169;
				fragment_unnamed_120 = (_MainTex_TexelSize.yyxy * float4(0.0f, 1.0f, 1.0f, 0.0f)) + fragment_input_0.xyxy;
				fragment_unnamed_120 = clamp(fragment_unnamed_120, 0.0f.xxxx, 1.0f.xxxx);
				fragment_unnamed_120 *= _RenderViewportScaleFactor.xxxx;
				fragment_unnamed_194.z = _CoCTex.Sample(sampler_CoCTex, fragment_unnamed_120.xy).x;
				fragment_unnamed_120.x = _CoCTex.Sample(sampler_CoCTex, fragment_unnamed_120.zw).x;
				fragment_unnamed_211 = fragment_unnamed_194.z < fragment_unnamed_9.z;
				float2 fragment_unnamed_221 = _MainTex_TexelSize.yy * float2(0.0f, 1.0f);
				fragment_unnamed_194 = float3(fragment_unnamed_221.x, fragment_unnamed_221.y, fragment_unnamed_194.z);
				fragment_unnamed_54 = max(fragment_unnamed_54, fragment_unnamed_194.z);
				fragment_unnamed_54 = max(fragment_unnamed_120.x, fragment_unnamed_54);
				float3 fragment_unnamed_233;
				if (fragment_unnamed_211)
				{
					fragment_unnamed_233 = fragment_unnamed_194;
				}
				else
				{
					fragment_unnamed_233 = fragment_unnamed_9;
				}
				fragment_unnamed_9 = fragment_unnamed_233;
				fragment_unnamed_115 = fragment_unnamed_120.x < fragment_unnamed_9.z;
				fragment_unnamed_245 = min(fragment_unnamed_120.x, fragment_unnamed_9.z);
				float2 fragment_unnamed_252;
				if (fragment_unnamed_115)
				{
					fragment_unnamed_252 = fragment_unnamed_147;
				}
				else
				{
					fragment_unnamed_252 = fragment_unnamed_9.xy;
				}
				fragment_unnamed_9 = float3(fragment_unnamed_252.x, fragment_unnamed_252.y, fragment_unnamed_9.z);
				float2 fragment_unnamed_265 = fragment_unnamed_9.xy + fragment_input_0;
				fragment_unnamed_9 = float3(fragment_unnamed_265.x, fragment_unnamed_265.y, fragment_unnamed_9.z);
				float2 fragment_unnamed_272 = clamp(fragment_unnamed_9.xy, 0.0f.xx, 1.0f.xx);
				fragment_unnamed_9 = float3(fragment_unnamed_272.x, fragment_unnamed_272.y, fragment_unnamed_9.z);
				float2 fragment_unnamed_280 = fragment_unnamed_9.xy * _RenderViewportScaleFactor.xx;
				fragment_unnamed_9 = float3(fragment_unnamed_280.x, fragment_unnamed_280.y, fragment_unnamed_9.z);
				float2 fragment_unnamed_291 = _CameraMotionVectorsTexture.Sample(sampler_CameraMotionVectorsTexture, fragment_unnamed_9.xy).xy;
				fragment_unnamed_9 = float3(fragment_unnamed_291.x, fragment_unnamed_291.y, fragment_unnamed_9.z);
				float2 fragment_unnamed_298 = (-fragment_unnamed_9.xy) + fragment_input_0;
				fragment_unnamed_9 = float3(fragment_unnamed_298.x, fragment_unnamed_298.y, fragment_unnamed_9.z);
				float2 fragment_unnamed_305 = clamp(fragment_unnamed_9.xy, 0.0f.xx, 1.0f.xx);
				fragment_unnamed_9 = float3(fragment_unnamed_305.x, fragment_unnamed_305.y, fragment_unnamed_9.z);
				float2 fragment_unnamed_313 = fragment_unnamed_9.xy * _RenderViewportScaleFactor.xx;
				fragment_unnamed_9 = float3(fragment_unnamed_313.x, fragment_unnamed_313.y, fragment_unnamed_9.z);
				fragment_unnamed_9.x = _MainTex.Sample(sampler_MainTex, fragment_unnamed_9.xy).x;
				fragment_unnamed_9.x = max(fragment_unnamed_245, fragment_unnamed_9.x);
				fragment_unnamed_9.x = min(fragment_unnamed_54, fragment_unnamed_9.x);
				fragment_unnamed_9.x = (-fragment_unnamed_28.x) + fragment_unnamed_9.x;
				fragment_output_0 = (float4(_TaaParams.z, _TaaParams.z, _TaaParams.z, _TaaParams.z) * fragment_unnamed_9.xxxx) + fragment_unnamed_28.xxxx;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_0 = stage_input.fragment_input_0;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			float _RenderViewportScaleFactor;
			float4 _MainTex_TexelSize;
			float3 _TaaParams;

			static float4 fragment_uniform_buffer_0[32];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _CameraMotionVectorsTexture;
			Texture2D<float4> _CoCTex;
			SamplerState sampler_MainTex;
			SamplerState sampler_CameraMotionVectorsTexture;
			SamplerState sampler_CoCTex;

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
				float fragment_unnamed_52 = (-0.0f) - fragment_uniform_buffer_0[28u].y;
				float4 fragment_unnamed_80 = _CoCTex.Sample(sampler_CoCTex, float2(clamp(mad((-0.0f) - fragment_uniform_buffer_0[28u].x, 1.0f, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(mad(fragment_unnamed_52, 0.0f, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x));
				float fragment_unnamed_82 = fragment_unnamed_80.x;
				float4 fragment_unnamed_83 = _CoCTex.Sample(sampler_CoCTex, float2(clamp(mad(fragment_unnamed_52, 0.0f, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(mad(fragment_unnamed_52, 1.0f, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x));
				float fragment_unnamed_85 = fragment_unnamed_83.x;
				float4 fragment_unnamed_106 = _CoCTex.Sample(sampler_CoCTex, float2(clamp(fragment_input_1.x + ((-0.0f) - fragment_uniform_buffer_0[31u].y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_input_1.y + ((-0.0f) - fragment_uniform_buffer_0[31u].z), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x));
				float fragment_unnamed_108 = fragment_unnamed_106.x;
				bool fragment_unnamed_110 = fragment_unnamed_82 < fragment_unnamed_108;
				uint fragment_unnamed_112 = fragment_unnamed_110 ? 4294967295u : 0u;
				uint fragment_unnamed_115 = fragment_unnamed_110 ? asuint(fragment_unnamed_82) : asuint(fragment_unnamed_108);
				bool fragment_unnamed_119 = fragment_unnamed_85 < asfloat(fragment_unnamed_115);
				float fragment_unnamed_124 = fragment_uniform_buffer_0[28u].x * 1.0f;
				float fragment_unnamed_125 = fragment_uniform_buffer_0[28u].y * 0.0f;
				uint fragment_unnamed_137 = fragment_unnamed_119 ? asuint(fragment_unnamed_85) : fragment_unnamed_115;
				float4 fragment_unnamed_162 = _CoCTex.Sample(sampler_CoCTex, float2(clamp(mad(fragment_uniform_buffer_0[28u].y, 0.0f, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(mad(fragment_uniform_buffer_0[28u].y, 1.0f, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x));
				float fragment_unnamed_164 = fragment_unnamed_162.x;
				float4 fragment_unnamed_165 = _CoCTex.Sample(sampler_CoCTex, float2(clamp(mad(fragment_uniform_buffer_0[28u].x, 1.0f, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(mad(fragment_uniform_buffer_0[28u].y, 0.0f, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x));
				float fragment_unnamed_167 = fragment_unnamed_165.x;
				bool fragment_unnamed_168 = fragment_unnamed_164 < asfloat(fragment_unnamed_137);
				float fragment_unnamed_182 = asfloat(fragment_unnamed_168 ? asuint(fragment_unnamed_164) : fragment_unnamed_137);
				bool fragment_unnamed_183 = fragment_unnamed_167 < fragment_unnamed_182;
				float4 fragment_unnamed_205 = _CameraMotionVectorsTexture.Sample(sampler_CameraMotionVectorsTexture, float2(clamp(asfloat(fragment_unnamed_183 ? asuint(fragment_unnamed_124) : (fragment_unnamed_168 ? asuint(fragment_uniform_buffer_0[28u].y * 0.0f) : (fragment_unnamed_119 ? asuint(fragment_uniform_buffer_0[28u].y * (-0.0f)) : (fragment_unnamed_112 & asuint((-0.0f) - fragment_unnamed_124))))) + fragment_input_1.x, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(asfloat(fragment_unnamed_183 ? asuint(fragment_unnamed_125) : (fragment_unnamed_168 ? asuint(fragment_uniform_buffer_0[28u].y * 1.0f) : (fragment_unnamed_119 ? asuint(fragment_uniform_buffer_0[28u].y * (-1.0f)) : (fragment_unnamed_112 & asuint((-0.0f) - fragment_unnamed_125))))) + fragment_input_1.y, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x));
				float fragment_unnamed_231 = ((-0.0f) - fragment_unnamed_108) + min(max(fragment_unnamed_167, max(max(fragment_unnamed_85, max(fragment_unnamed_82, fragment_unnamed_108)), fragment_unnamed_164)), max(min(fragment_unnamed_167, fragment_unnamed_182), _MainTex.Sample(sampler_MainTex, float2(clamp(((-0.0f) - fragment_unnamed_205.x) + fragment_input_1.x, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(((-0.0f) - fragment_unnamed_205.y) + fragment_input_1.y, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x)).x));
				fragment_output_0.x = mad(fragment_uniform_buffer_0[31u].w, fragment_unnamed_231, fragment_unnamed_108);
				fragment_output_0.y = mad(fragment_uniform_buffer_0[31u].w, fragment_unnamed_231, fragment_unnamed_108);
				fragment_output_0.z = mad(fragment_uniform_buffer_0[31u].w, fragment_unnamed_231, fragment_unnamed_108);
				fragment_output_0.w = mad(fragment_uniform_buffer_0[31u].w, fragment_unnamed_231, fragment_unnamed_108);
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, fragment_uniform_buffer_0[26][1], fragment_uniform_buffer_0[26][2], fragment_uniform_buffer_0[26][3]);

				fragment_uniform_buffer_0[28] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				fragment_uniform_buffer_0[31] = float4(fragment_uniform_buffer_0[31][0], _TaaParams[0], _TaaParams[1], _TaaParams[2]);

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
			Name "Downsample and Prefilter"
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 155771

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
			float _MaxCoC;

			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;
			Texture2D<float4> _CoCTex;
			SamplerState sampler_CoCTex;

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
			static float3 fragment_unnamed_45;
			static float fragment_unnamed_61;
			static float fragment_unnamed_77;
			static float fragment_unnamed_92;
			static float4 fragment_unnamed_101;
			static float3 fragment_unnamed_124;
			static float3 fragment_unnamed_177;
			static bool fragment_unnamed_309;
			static bool3 fragment_unnamed_432;

			void frag_main()
			{
				fragment_unnamed_9 = ((-_MainTex_TexelSize.xyxy) * float4(0.5f, 0.5f, -0.5f, 0.5f)) + fragment_input_0.xyxy;
				fragment_unnamed_9 = clamp(fragment_unnamed_9, 0.0f.xxxx, 1.0f.xxxx);
				fragment_unnamed_9 *= _RenderViewportScaleFactor.xxxx;
				fragment_unnamed_45 = _MainTex.Sample(sampler_MainTex, fragment_unnamed_9.zw).xyz;
				fragment_unnamed_61 = max(fragment_unnamed_45.y, fragment_unnamed_45.x);
				fragment_unnamed_61 = max(fragment_unnamed_45.z, fragment_unnamed_61);
				fragment_unnamed_61 += 1.0f;
				fragment_unnamed_77 = _CoCTex.Sample(sampler_CoCTex, fragment_unnamed_9.zw).x;
				fragment_unnamed_77 = (fragment_unnamed_77 * 2.0f) + (-1.0f);
				fragment_unnamed_92 = abs(fragment_unnamed_77) / fragment_unnamed_61;
				fragment_unnamed_45 = fragment_unnamed_92.xxx * fragment_unnamed_45;
				float3 fragment_unnamed_108 = _MainTex.Sample(sampler_MainTex, fragment_unnamed_9.xy).xyz;
				fragment_unnamed_101 = float4(fragment_unnamed_108.x, fragment_unnamed_108.y, fragment_unnamed_108.z, fragment_unnamed_101.w);
				fragment_unnamed_9.x = _CoCTex.Sample(sampler_CoCTex, fragment_unnamed_9.xy).x;
				fragment_unnamed_9.x = (fragment_unnamed_9.x * 2.0f) + (-1.0f);
				fragment_unnamed_124.x = max(fragment_unnamed_101.y, fragment_unnamed_101.x);
				fragment_unnamed_124.x = max(fragment_unnamed_101.z, fragment_unnamed_124.x);
				fragment_unnamed_124.x += 1.0f;
				fragment_unnamed_124.x = abs(fragment_unnamed_9.x) / fragment_unnamed_124.x;
				fragment_unnamed_45 = (fragment_unnamed_101.xyz * fragment_unnamed_124.xxx) + fragment_unnamed_45;
				fragment_unnamed_124.x = fragment_unnamed_92 + fragment_unnamed_124.x;
				fragment_unnamed_101 = (_MainTex_TexelSize.xyxy * float4(-0.5f, 0.5f, 0.5f, 0.5f)) + fragment_input_0.xyxy;
				fragment_unnamed_101 = clamp(fragment_unnamed_101, 0.0f.xxxx, 1.0f.xxxx);
				fragment_unnamed_101 *= _RenderViewportScaleFactor.xxxx;
				fragment_unnamed_177 = _MainTex.Sample(sampler_MainTex, fragment_unnamed_101.xy).xyz;
				fragment_unnamed_92 = max(fragment_unnamed_177.y, fragment_unnamed_177.x);
				fragment_unnamed_92 = max(fragment_unnamed_177.z, fragment_unnamed_92);
				fragment_unnamed_92 += 1.0f;
				fragment_unnamed_61 = _CoCTex.Sample(sampler_CoCTex, fragment_unnamed_101.xy).x;
				fragment_unnamed_61 = (fragment_unnamed_61 * 2.0f) + (-1.0f);
				fragment_unnamed_92 = abs(fragment_unnamed_61) / fragment_unnamed_92;
				fragment_unnamed_45 = (fragment_unnamed_177 * fragment_unnamed_92.xxx) + fragment_unnamed_45;
				fragment_unnamed_124.x = fragment_unnamed_92 + fragment_unnamed_124.x;
				fragment_unnamed_177 = _MainTex.Sample(sampler_MainTex, fragment_unnamed_101.zw).xyz;
				fragment_unnamed_92 = _CoCTex.Sample(sampler_CoCTex, fragment_unnamed_101.zw).x;
				fragment_unnamed_92 = (fragment_unnamed_92 * 2.0f) + (-1.0f);
				fragment_unnamed_101.x = max(fragment_unnamed_177.y, fragment_unnamed_177.x);
				fragment_unnamed_101.x = max(fragment_unnamed_177.z, fragment_unnamed_101.x);
				fragment_unnamed_101.x += 1.0f;
				fragment_unnamed_101.x = abs(fragment_unnamed_92) / fragment_unnamed_101.x;
				fragment_unnamed_45 = (fragment_unnamed_177 * fragment_unnamed_101.xxx) + fragment_unnamed_45;
				fragment_unnamed_124.x += fragment_unnamed_101.x;
				fragment_unnamed_124.x = max(fragment_unnamed_124.x, 9.9999997473787516355514526367188e-05f);
				fragment_unnamed_45 /= fragment_unnamed_124.xxx;
				fragment_unnamed_124.x = min(fragment_unnamed_77, fragment_unnamed_61);
				fragment_unnamed_77 = max(fragment_unnamed_77, fragment_unnamed_61);
				fragment_unnamed_77 = max(fragment_unnamed_92, fragment_unnamed_77);
				fragment_unnamed_124.x = min(fragment_unnamed_92, fragment_unnamed_124.x);
				fragment_unnamed_124.x = min(fragment_unnamed_124.x, fragment_unnamed_9.x);
				fragment_unnamed_9.x = max(fragment_unnamed_77, fragment_unnamed_9.x);
				fragment_unnamed_309 = fragment_unnamed_9.x < (-fragment_unnamed_124.x);
				float fragment_unnamed_318;
				if (fragment_unnamed_309)
				{
					fragment_unnamed_318 = fragment_unnamed_124.x;
				}
				else
				{
					fragment_unnamed_318 = fragment_unnamed_9.x;
				}
				fragment_unnamed_9.x = fragment_unnamed_318;
				fragment_unnamed_9.x *= _MaxCoC;
				fragment_unnamed_124.x = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
				fragment_unnamed_124.x = 1.0f / fragment_unnamed_124.x;
				fragment_unnamed_124.x *= abs(fragment_unnamed_9.x);
				fragment_unnamed_124.x = clamp(fragment_unnamed_124.x, 0.0f, 1.0f);
				fragment_output_0.w = fragment_unnamed_9.x;
				fragment_unnamed_9.x = (fragment_unnamed_124.x * (-2.0f)) + 3.0f;
				fragment_unnamed_124.x *= fragment_unnamed_124.x;
				fragment_unnamed_9.x = fragment_unnamed_124.x * fragment_unnamed_9.x;
				fragment_unnamed_124 = (fragment_unnamed_45 * fragment_unnamed_9.xxx) + 0.054999999701976776123046875f.xxx;
				fragment_unnamed_45 = fragment_unnamed_9.xxx * fragment_unnamed_45;
				float3 fragment_unnamed_396 = fragment_unnamed_124 * 0.947867333889007568359375f.xxx;
				fragment_unnamed_9 = float4(fragment_unnamed_396.x, fragment_unnamed_396.y, fragment_unnamed_396.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_404 = max(abs(fragment_unnamed_9.xyz), 1.1920928955078125e-07f.xxx);
				fragment_unnamed_9 = float4(fragment_unnamed_404.x, fragment_unnamed_404.y, fragment_unnamed_404.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_409 = log2(fragment_unnamed_9.xyz);
				fragment_unnamed_9 = float4(fragment_unnamed_409.x, fragment_unnamed_409.y, fragment_unnamed_409.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_416 = fragment_unnamed_9.xyz * 2.400000095367431640625f.xxx;
				fragment_unnamed_9 = float4(fragment_unnamed_416.x, fragment_unnamed_416.y, fragment_unnamed_416.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_421 = exp2(fragment_unnamed_9.xyz);
				fragment_unnamed_9 = float4(fragment_unnamed_421.x, fragment_unnamed_421.y, fragment_unnamed_421.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_427 = fragment_unnamed_45 * 0.077399380505084991455078125f.xxx;
				fragment_unnamed_101 = float4(fragment_unnamed_427.x, fragment_unnamed_427.y, fragment_unnamed_427.z, fragment_unnamed_101.w);
				fragment_unnamed_432 = bool4(float4(0.040449999272823333740234375f, 0.040449999272823333740234375f, 0.040449999272823333740234375f, 0.0f).x >= fragment_unnamed_45.xyzx.x, float4(0.040449999272823333740234375f, 0.040449999272823333740234375f, 0.040449999272823333740234375f, 0.0f).y >= fragment_unnamed_45.xyzx.y, float4(0.040449999272823333740234375f, 0.040449999272823333740234375f, 0.040449999272823333740234375f, 0.0f).z >= fragment_unnamed_45.xyzx.z, float4(0.040449999272823333740234375f, 0.040449999272823333740234375f, 0.040449999272823333740234375f, 0.0f).w >= fragment_unnamed_45.xyzx.w).xyz;
				float fragment_unnamed_442;
				if (fragment_unnamed_432.x)
				{
					fragment_unnamed_442 = fragment_unnamed_101.x;
				}
				else
				{
					fragment_unnamed_442 = fragment_unnamed_9.x;
				}
				fragment_output_0.x = fragment_unnamed_442;
				float fragment_unnamed_454;
				if (fragment_unnamed_432.y)
				{
					fragment_unnamed_454 = fragment_unnamed_101.y;
				}
				else
				{
					fragment_unnamed_454 = fragment_unnamed_9.y;
				}
				fragment_output_0.y = fragment_unnamed_454;
				float fragment_unnamed_466;
				if (fragment_unnamed_432.z)
				{
					fragment_unnamed_466 = fragment_unnamed_101.z;
				}
				else
				{
					fragment_unnamed_466 = fragment_unnamed_9.z;
				}
				fragment_output_0.z = fragment_unnamed_466;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_0 = stage_input.fragment_input_0;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			float _RenderViewportScaleFactor;
			float4 _MainTex_TexelSize;
			float _MaxCoC;

			static float4 fragment_uniform_buffer_0[31];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _CoCTex;
			SamplerState sampler_MainTex;
			SamplerState sampler_CoCTex;

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
				float fragment_unnamed_39 = (-0.0f) - fragment_uniform_buffer_0[28u].x;
				float fragment_unnamed_42 = (-0.0f) - fragment_uniform_buffer_0[28u].y;
				float fragment_unnamed_66 = clamp(mad(fragment_unnamed_39, 0.5f, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float fragment_unnamed_67 = clamp(mad(fragment_unnamed_42, 0.5f, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float fragment_unnamed_68 = clamp(mad(fragment_unnamed_39, -0.5f, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float fragment_unnamed_69 = clamp(mad(fragment_unnamed_42, 0.5f, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_72 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_68, fragment_unnamed_69));
				float fragment_unnamed_74 = fragment_unnamed_72.x;
				float fragment_unnamed_75 = fragment_unnamed_72.y;
				float fragment_unnamed_76 = fragment_unnamed_72.z;
				float fragment_unnamed_84 = mad(_CoCTex.Sample(sampler_CoCTex, float2(fragment_unnamed_68, fragment_unnamed_69)).x, 2.0f, -1.0f);
				float fragment_unnamed_88 = abs(fragment_unnamed_84) / (max(fragment_unnamed_76, max(fragment_unnamed_75, fragment_unnamed_74)) + 1.0f);
				float4 fragment_unnamed_92 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_66, fragment_unnamed_67));
				float fragment_unnamed_94 = fragment_unnamed_92.x;
				float fragment_unnamed_95 = fragment_unnamed_92.y;
				float fragment_unnamed_96 = fragment_unnamed_92.z;
				float fragment_unnamed_100 = mad(_CoCTex.Sample(sampler_CoCTex, float2(fragment_unnamed_66, fragment_unnamed_67)).x, 2.0f, -1.0f);
				float fragment_unnamed_105 = abs(fragment_unnamed_100) / (max(fragment_unnamed_96, max(fragment_unnamed_95, fragment_unnamed_94)) + 1.0f);
				float fragment_unnamed_129 = clamp(mad(fragment_uniform_buffer_0[28u].x, -0.5f, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float fragment_unnamed_130 = clamp(mad(fragment_uniform_buffer_0[28u].y, 0.5f, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float fragment_unnamed_131 = clamp(mad(fragment_uniform_buffer_0[28u].x, 0.5f, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float fragment_unnamed_132 = clamp(mad(fragment_uniform_buffer_0[28u].y, 0.5f, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_133 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_129, fragment_unnamed_130));
				float fragment_unnamed_135 = fragment_unnamed_133.x;
				float fragment_unnamed_136 = fragment_unnamed_133.y;
				float fragment_unnamed_137 = fragment_unnamed_133.z;
				float fragment_unnamed_144 = mad(_CoCTex.Sample(sampler_CoCTex, float2(fragment_unnamed_129, fragment_unnamed_130)).x, 2.0f, -1.0f);
				float fragment_unnamed_146 = abs(fragment_unnamed_144) / (max(fragment_unnamed_137, max(fragment_unnamed_136, fragment_unnamed_135)) + 1.0f);
				float4 fragment_unnamed_151 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_131, fragment_unnamed_132));
				float fragment_unnamed_153 = fragment_unnamed_151.x;
				float fragment_unnamed_154 = fragment_unnamed_151.y;
				float fragment_unnamed_155 = fragment_unnamed_151.z;
				float fragment_unnamed_159 = mad(_CoCTex.Sample(sampler_CoCTex, float2(fragment_unnamed_131, fragment_unnamed_132)).x, 2.0f, -1.0f);
				float fragment_unnamed_164 = abs(fragment_unnamed_159) / (max(fragment_unnamed_155, max(fragment_unnamed_154, fragment_unnamed_153)) + 1.0f);
				float fragment_unnamed_169 = max((fragment_unnamed_146 + (fragment_unnamed_88 + fragment_unnamed_105)) + fragment_unnamed_164, 9.9999997473787516355514526367188e-05f);
				float fragment_unnamed_171 = mad(fragment_unnamed_153, fragment_unnamed_164, mad(fragment_unnamed_135, fragment_unnamed_146, mad(fragment_unnamed_94, fragment_unnamed_105, fragment_unnamed_88 * fragment_unnamed_74))) / fragment_unnamed_169;
				float fragment_unnamed_172 = mad(fragment_unnamed_154, fragment_unnamed_164, mad(fragment_unnamed_136, fragment_unnamed_146, mad(fragment_unnamed_95, fragment_unnamed_105, fragment_unnamed_88 * fragment_unnamed_75))) / fragment_unnamed_169;
				float fragment_unnamed_173 = mad(fragment_unnamed_155, fragment_unnamed_164, mad(fragment_unnamed_137, fragment_unnamed_146, mad(fragment_unnamed_96, fragment_unnamed_105, fragment_unnamed_88 * fragment_unnamed_76))) / fragment_unnamed_169;
				float fragment_unnamed_178 = min(min(fragment_unnamed_159, min(fragment_unnamed_84, fragment_unnamed_144)), fragment_unnamed_100);
				float fragment_unnamed_179 = max(max(fragment_unnamed_159, max(fragment_unnamed_84, fragment_unnamed_144)), fragment_unnamed_100);
				float fragment_unnamed_191 = asfloat((fragment_unnamed_179 < ((-0.0f) - fragment_unnamed_178)) ? asuint(fragment_unnamed_178) : asuint(fragment_unnamed_179)) * fragment_uniform_buffer_0[30u].z;
				float fragment_unnamed_202 = clamp((1.0f / (fragment_uniform_buffer_0[28u].y + fragment_uniform_buffer_0[28u].y)) * abs(fragment_unnamed_191), 0.0f, 1.0f);
				fragment_output_0.w = fragment_unnamed_191;
				float fragment_unnamed_210 = (fragment_unnamed_202 * fragment_unnamed_202) * mad(fragment_unnamed_202, -2.0f, 3.0f);
				float fragment_unnamed_215 = fragment_unnamed_210 * fragment_unnamed_171;
				float fragment_unnamed_216 = fragment_unnamed_210 * fragment_unnamed_172;
				float fragment_unnamed_217 = fragment_unnamed_210 * fragment_unnamed_173;
				fragment_output_0.x = (0.040449999272823333740234375f >= fragment_unnamed_215) ? (fragment_unnamed_215 * 0.077399380505084991455078125f) : exp2(log2(max(abs(mad(fragment_unnamed_171, fragment_unnamed_210, 0.054999999701976776123046875f) * 0.947867333889007568359375f), 1.1920928955078125e-07f)) * 2.400000095367431640625f);
				fragment_output_0.y = (0.040449999272823333740234375f >= fragment_unnamed_216) ? (fragment_unnamed_216 * 0.077399380505084991455078125f) : exp2(log2(max(abs(mad(fragment_unnamed_172, fragment_unnamed_210, 0.054999999701976776123046875f) * 0.947867333889007568359375f), 1.1920928955078125e-07f)) * 2.400000095367431640625f);
				fragment_output_0.z = (0.040449999272823333740234375f >= fragment_unnamed_217) ? (fragment_unnamed_217 * 0.077399380505084991455078125f) : exp2(log2(max(abs(mad(fragment_unnamed_173, fragment_unnamed_210, 0.054999999701976776123046875f) * 0.947867333889007568359375f), 1.1920928955078125e-07f)) * 2.400000095367431640625f);
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, fragment_uniform_buffer_0[26][1], fragment_uniform_buffer_0[26][2], fragment_uniform_buffer_0[26][3]);

				fragment_uniform_buffer_0[28] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				fragment_uniform_buffer_0[30] = float4(fragment_uniform_buffer_0[30][0], fragment_uniform_buffer_0[30][1], _MaxCoC, fragment_uniform_buffer_0[30][3]);

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
			Name "Bokeh Filter (small)"
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 222627

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
			float _MaxCoC;
			float _RcpAspect;

			static const uint4 fragment_unnamed_129[16] = { uint4(0u, 0u, 0u, 0u), uint4(1057727209u, 0u, 0u, 0u), uint4(1043110300u, 1057279317u, 0u, 0u), uint4(3202478008u, 1050945282u, 0u, 0u), uint4(3202478006u, 3198428933u, 0u, 0u), uint4(1043110305u, 3204762965u, 0u, 0u), uint4(1065353216u, 0u, 0u, 0u), uint4(1062149053u, 1058437400u, 0u, 0u), uint4(1050556281u, 1064532081u, 0u, 0u), uint4(3198039931u, 1064532080u, 0u, 0u), uint4(3209632702u, 1058437399u, 0u, 0u), uint4(3212836864u, 0u, 0u, 0u), uint4(3209632700u, 3205921050u, 0u, 0u), uint4(3198039918u, 3212015730u, 0u, 0u), uint4(1050556286u, 3212015728u, 0u, 0u), uint4(1062149052u, 3205921049u, 0u, 0u) };

			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

			static float2 fragment_input_1;
			static float2 fragment_input_0;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_0 : TEXCOORD0; // vs_TEXCOORD0
				float2 fragment_input_1 : TEXCOORD1; // vs_TEXCOORD1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static float3 fragment_unnamed_9;
			static float fragment_unnamed_32;
			static float4 fragment_unnamed_46;
			static float4 fragment_unnamed_49;
			static float4 fragment_unnamed_56;
			static float4 fragment_unnamed_73;
			static float fragment_unnamed_142;
			static float fragment_unnamed_185;
			static bool fragment_unnamed_225;
			static float fragment_unnamed_232;
			static bool fragment_unnamed_256;
			static bool fragment_unnamed_274;
			static int fragment_unnamed_320;

			void frag_main()
			{
				fragment_unnamed_9.x = _MainTex.Sample(sampler_MainTex, fragment_input_1).w;
				fragment_unnamed_32 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
				fragment_unnamed_46.w = 1.0f;
				fragment_unnamed_49.x = 0.0f;
				fragment_unnamed_49.y = 0.0f;
				fragment_unnamed_49.z = 0.0f;
				fragment_unnamed_49.w = 0.0f;
				fragment_unnamed_56.x = 0.0f;
				fragment_unnamed_56.y = 0.0f;
				fragment_unnamed_56.z = 0.0f;
				fragment_unnamed_56.w = 0.0f;
				for (int fragment_unnamed_62 = 0; fragment_unnamed_62 < 16; fragment_unnamed_62++)
				{
					float2 fragment_unnamed_139 = float2(float2(_MaxCoC, _MaxCoC)) * asfloat(fragment_unnamed_129[fragment_unnamed_62].xy);
					fragment_unnamed_73 = float4(fragment_unnamed_73.x, fragment_unnamed_139.x, fragment_unnamed_139.y, fragment_unnamed_73.w);
					fragment_unnamed_142 = dot(fragment_unnamed_73.yz, fragment_unnamed_73.yz);
					fragment_unnamed_142 = sqrt(fragment_unnamed_142);
					fragment_unnamed_73.x = fragment_unnamed_73.y * _RcpAspect;
					float2 fragment_unnamed_161 = fragment_unnamed_73.xz + fragment_input_0;
					fragment_unnamed_73 = float4(fragment_unnamed_161.x, fragment_unnamed_161.y, fragment_unnamed_73.z, fragment_unnamed_73.w);
					float2 fragment_unnamed_168 = clamp(fragment_unnamed_73.xy, 0.0f.xx, 1.0f.xx);
					fragment_unnamed_73 = float4(fragment_unnamed_168.x, fragment_unnamed_168.y, fragment_unnamed_73.z, fragment_unnamed_73.w);
					float2 fragment_unnamed_176 = fragment_unnamed_73.xy * _RenderViewportScaleFactor.xx;
					fragment_unnamed_73 = float4(fragment_unnamed_176.x, fragment_unnamed_176.y, fragment_unnamed_73.z, fragment_unnamed_73.w);
					fragment_unnamed_73 = _MainTex.Sample(sampler_MainTex, fragment_unnamed_73.xy);
					fragment_unnamed_185 = min(fragment_unnamed_9.x, fragment_unnamed_73.w);
					fragment_unnamed_185 = max(fragment_unnamed_185, 0.0f);
					fragment_unnamed_185 = (-fragment_unnamed_142) + fragment_unnamed_185;
					fragment_unnamed_185 = (_MainTex_TexelSize.y * 2.0f) + fragment_unnamed_185;
					fragment_unnamed_185 /= fragment_unnamed_32;
					fragment_unnamed_185 = clamp(fragment_unnamed_185, 0.0f, 1.0f);
					fragment_unnamed_142 = (-fragment_unnamed_142) + (-fragment_unnamed_73.w);
					fragment_unnamed_142 = (_MainTex_TexelSize.y * 2.0f) + fragment_unnamed_142;
					fragment_unnamed_142 /= fragment_unnamed_32;
					fragment_unnamed_142 = clamp(fragment_unnamed_142, 0.0f, 1.0f);
					fragment_unnamed_225 = (-fragment_unnamed_73.w) >= _MainTex_TexelSize.y;
					fragment_unnamed_232 = float(fragment_unnamed_225);
					fragment_unnamed_142 *= fragment_unnamed_232;
					fragment_unnamed_46 = float4(fragment_unnamed_73.xyz.x, fragment_unnamed_73.xyz.y, fragment_unnamed_73.xyz.z, fragment_unnamed_46.w);
					fragment_unnamed_49 = (fragment_unnamed_46 * fragment_unnamed_185.xxxx) + fragment_unnamed_49;
					fragment_unnamed_56 = (fragment_unnamed_46 * fragment_unnamed_142.xxxx) + fragment_unnamed_56;
				}
				fragment_unnamed_256 = fragment_unnamed_49.w == 0.0f;
				fragment_unnamed_9.x = float(fragment_unnamed_256);
				fragment_unnamed_9.x += fragment_unnamed_49.w;
				fragment_unnamed_9 = fragment_unnamed_49.xyz / fragment_unnamed_9.xxx;
				fragment_unnamed_274 = fragment_unnamed_56.w == 0.0f;
				fragment_unnamed_142 = float(fragment_unnamed_274);
				fragment_unnamed_142 += fragment_unnamed_56.w;
				float3 fragment_unnamed_288 = fragment_unnamed_56.xyz / fragment_unnamed_142.xxx;
				fragment_unnamed_46 = float4(fragment_unnamed_288.x, fragment_unnamed_288.y, fragment_unnamed_288.z, fragment_unnamed_46.w);
				fragment_unnamed_142 = fragment_unnamed_56.w * 0.19634954631328582763671875f;
				fragment_unnamed_142 = min(fragment_unnamed_142, 1.0f);
				float3 fragment_unnamed_301 = (-fragment_unnamed_9) + fragment_unnamed_46.xyz;
				fragment_unnamed_46 = float4(fragment_unnamed_301.x, fragment_unnamed_301.y, fragment_unnamed_301.z, fragment_unnamed_46.w);
				float3 fragment_unnamed_312 = (fragment_unnamed_142.xxx * fragment_unnamed_46.xyz) + fragment_unnamed_9;
				fragment_output_0 = float4(fragment_unnamed_312.x, fragment_unnamed_312.y, fragment_unnamed_312.z, fragment_output_0.w);
				fragment_output_0.w = fragment_unnamed_142;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_0 = stage_input.fragment_input_0;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			float _RenderViewportScaleFactor;
			float4 _MainTex_TexelSize;
			float _MaxCoC;
			float _RcpAspect;

			static float4 fragment_uniform_buffer_0[32];
			static const float fragment_unnamed_57[64] = { 0.0f, 0.0f, 0.0f, 0.0f, 0.545454561710357666015625f, 0.0f, 0.0f, 0.0f, 0.168554723262786865234375f, 0.518758118152618408203125f, 0.0f, 0.0f, -0.4412820339202880859375f, 0.320610105991363525390625f, 0.0f, 0.0f, -0.441281974315643310546875f, -0.3206101953983306884765625f, 0.0f, 0.0f, 0.16855479776859283447265625f, -0.518758118152618408203125f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.809017002582550048828125f, 0.587785243988037109375f, 0.0f, 0.0f, 0.3090169727802276611328125f, 0.951056540012359619140625f, 0.0f, 0.0f, -0.3090170323848724365234375f, 0.95105648040771484375f, 0.0f, 0.0f, -0.80901706218719482421875f, 0.587785184383392333984375f, 0.0f, 0.0f, -1.0f, 0.0f, 0.0f, 0.0f, -0.8090169429779052734375f, -0.58778536319732666015625f, 0.0f, 0.0f, -0.309016644954681396484375f, -0.95105659961700439453125f, 0.0f, 0.0f, 0.309017121791839599609375f, -0.95105648040771484375f, 0.0f, 0.0f, 0.8090169429779052734375f, -0.587785303592681884765625f, 0.0f, 0.0f };

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
				float4 fragment_unnamed_71 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				float fragment_unnamed_73 = fragment_unnamed_71.w;
				precise float fragment_unnamed_82 = fragment_uniform_buffer_0[28u].y + fragment_uniform_buffer_0[28u].y;
				float fragment_unnamed_83 = asfloat(1065353216u);
				float fragment_unnamed_93;
				float fragment_unnamed_95;
				float fragment_unnamed_97;
				float fragment_unnamed_99;
				float fragment_unnamed_101;
				float fragment_unnamed_103;
				float fragment_unnamed_105;
				float fragment_unnamed_107;
				fragment_unnamed_93 = asfloat(0u);
				fragment_unnamed_95 = asfloat(0u);
				fragment_unnamed_97 = asfloat(0u);
				fragment_unnamed_99 = asfloat(0u);
				fragment_unnamed_101 = asfloat(0u);
				fragment_unnamed_103 = asfloat(0u);
				fragment_unnamed_105 = asfloat(0u);
				fragment_unnamed_107 = asfloat(0u);
				precise float fragment_unnamed_166;
				precise float fragment_unnamed_167;
				float fragment_unnamed_171;
				precise float fragment_unnamed_176;
				precise float fragment_unnamed_181;
				precise float fragment_unnamed_182;
				precise float fragment_unnamed_189;
				precise float fragment_unnamed_190;
				float4 fragment_unnamed_192;
				float fragment_unnamed_194;
				float fragment_unnamed_195;
				float fragment_unnamed_196;
				float fragment_unnamed_197;
				precise float fragment_unnamed_200;
				precise float fragment_unnamed_201;
				precise float fragment_unnamed_207;
				float fragment_unnamed_208;
				precise float fragment_unnamed_209;
				precise float fragment_unnamed_210;
				precise float fragment_unnamed_211;
				precise float fragment_unnamed_216;
				precise float fragment_unnamed_218;
				precise float fragment_unnamed_226;
				for (uint fragment_unnamed_109 = 0u; !(int(fragment_unnamed_109) >= int(16u)); fragment_unnamed_166 = fragment_uniform_buffer_0[30u].z * fragment_unnamed_57[(fragment_unnamed_109 * 4u) + 0u], fragment_unnamed_167 = fragment_uniform_buffer_0[30u].z * fragment_unnamed_57[(fragment_unnamed_109 * 4u) + 1u], fragment_unnamed_171 = sqrt(dot(float2(fragment_unnamed_166, fragment_unnamed_167), float2(fragment_unnamed_166, fragment_unnamed_167))), fragment_unnamed_176 = fragment_unnamed_166 * fragment_uniform_buffer_0[31u].x, fragment_unnamed_181 = fragment_unnamed_176 + fragment_input_1.x, fragment_unnamed_182 = fragment_unnamed_167 + fragment_input_1.y, fragment_unnamed_189 = clamp(fragment_unnamed_181, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, fragment_unnamed_190 = clamp(fragment_unnamed_182, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, fragment_unnamed_192 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_189, fragment_unnamed_190)), fragment_unnamed_194 = fragment_unnamed_192.x, fragment_unnamed_195 = fragment_unnamed_192.y, fragment_unnamed_196 = fragment_unnamed_192.z, fragment_unnamed_197 = fragment_unnamed_192.w, fragment_unnamed_200 = (-0.0f) - fragment_unnamed_171, fragment_unnamed_201 = fragment_unnamed_200 + max(min(fragment_unnamed_73, fragment_unnamed_197), 0.0f), fragment_unnamed_207 = mad(fragment_uniform_buffer_0[28u].y, 2.0f, fragment_unnamed_201) / fragment_unnamed_82, fragment_unnamed_208 = clamp(fragment_unnamed_207, 0.0f, 1.0f), fragment_unnamed_209 = (-0.0f) - fragment_unnamed_171, fragment_unnamed_210 = (-0.0f) - fragment_unnamed_197, fragment_unnamed_211 = fragment_unnamed_209 + fragment_unnamed_210, fragment_unnamed_216 = mad(fragment_uniform_buffer_0[28u].y, 2.0f, fragment_unnamed_211) / fragment_unnamed_82, fragment_unnamed_218 = (-0.0f) - fragment_unnamed_197, fragment_unnamed_226 = clamp(fragment_unnamed_216, 0.0f, 1.0f) * asfloat(((fragment_unnamed_218 >= fragment_uniform_buffer_0[28u].y) ? 4294967295u : 0u) & 1065353216u), fragment_unnamed_93 = mad(fragment_unnamed_195, fragment_unnamed_208, fragment_unnamed_93), fragment_unnamed_95 = mad(fragment_unnamed_196, fragment_unnamed_208, fragment_unnamed_95), fragment_unnamed_97 = mad(fragment_unnamed_83, fragment_unnamed_208, fragment_unnamed_97), fragment_unnamed_99 = mad(fragment_unnamed_194, fragment_unnamed_226, fragment_unnamed_99), fragment_unnamed_101 = mad(fragment_unnamed_195, fragment_unnamed_226, fragment_unnamed_101), fragment_unnamed_103 = mad(fragment_unnamed_196, fragment_unnamed_226, fragment_unnamed_103), fragment_unnamed_105 = mad(fragment_unnamed_83, fragment_unnamed_226, fragment_unnamed_105), fragment_unnamed_107 = mad(fragment_unnamed_194, fragment_unnamed_208, fragment_unnamed_107), fragment_unnamed_109++)
				{
				}
				precise float fragment_unnamed_119 = asfloat(((fragment_unnamed_97 == 0.0f) ? 4294967295u : 0u) & 1065353216u) + fragment_unnamed_97;
				precise float fragment_unnamed_120 = fragment_unnamed_107 / fragment_unnamed_119;
				precise float fragment_unnamed_121 = fragment_unnamed_93 / fragment_unnamed_119;
				precise float fragment_unnamed_122 = fragment_unnamed_95 / fragment_unnamed_119;
				precise float fragment_unnamed_127 = asfloat(((fragment_unnamed_105 == 0.0f) ? 4294967295u : 0u) & 1065353216u) + fragment_unnamed_105;
				precise float fragment_unnamed_128 = fragment_unnamed_99 / fragment_unnamed_127;
				precise float fragment_unnamed_129 = fragment_unnamed_101 / fragment_unnamed_127;
				precise float fragment_unnamed_130 = fragment_unnamed_103 / fragment_unnamed_127;
				precise float fragment_unnamed_131 = fragment_unnamed_105 * 0.19634954631328582763671875f;
				float fragment_unnamed_134 = min(fragment_unnamed_131, 1.0f);
				precise float fragment_unnamed_135 = (-0.0f) - fragment_unnamed_120;
				precise float fragment_unnamed_137 = (-0.0f) - fragment_unnamed_121;
				precise float fragment_unnamed_138 = (-0.0f) - fragment_unnamed_122;
				precise float fragment_unnamed_139 = fragment_unnamed_135 + fragment_unnamed_128;
				precise float fragment_unnamed_140 = fragment_unnamed_137 + fragment_unnamed_129;
				precise float fragment_unnamed_141 = fragment_unnamed_138 + fragment_unnamed_130;
				fragment_output_0.x = mad(fragment_unnamed_134, fragment_unnamed_139, fragment_unnamed_120);
				fragment_output_0.y = mad(fragment_unnamed_134, fragment_unnamed_140, fragment_unnamed_121);
				fragment_output_0.z = mad(fragment_unnamed_134, fragment_unnamed_141, fragment_unnamed_122);
				fragment_output_0.w = fragment_unnamed_134;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, fragment_uniform_buffer_0[26][1], fragment_uniform_buffer_0[26][2], fragment_uniform_buffer_0[26][3]);

				fragment_uniform_buffer_0[28] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				fragment_uniform_buffer_0[30] = float4(fragment_uniform_buffer_0[30][0], fragment_uniform_buffer_0[30][1], _MaxCoC, fragment_uniform_buffer_0[30][3]);

				fragment_uniform_buffer_0[31] = float4(_RcpAspect, fragment_uniform_buffer_0[31][1], fragment_uniform_buffer_0[31][2], fragment_uniform_buffer_0[31][3]);

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
			Name "Bokeh Filter (medium)"
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 313855

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
			float _MaxCoC;
			float _RcpAspect;

			static const uint4 fragment_unnamed_141[22] = { uint4(0u, 0u, 0u, 0u), uint4(1057523849u, 0u, 0u, 0u), uint4(1051345177u, 1054178812u, 0u, 0u), uint4(3186822495u, 1057299508u, 0u, 0u), uint4(3203794506u, 1047328091u, 0u, 0u), uint4(3203794506u, 3194811737u, 0u, 0u), uint4(3186822466u, 3204783157u, 0u, 0u), uint4(1051345175u, 3201662463u, 0u, 0u), uint4(1065353216u, 0u, 0u, 0u), uint4(1063691749u, 1054746115u, 0u, 0u), uint4(1059036423u, 1061692956u, 0u, 0u), uint4(1046731914u, 1064932576u, 0u, 0u), uint4(3194215560u, 1064932576u, 0u, 0u), uint4(3206520074u, 1061692954u, 0u, 0u), uint4(3211175397u, 1054746117u, 0u, 0u), uint4(3212836864u, 0u, 0u, 0u), uint4(3211175397u, 3202229763u, 0u, 0u), uint4(3206520068u, 3209176606u, 0u, 0u), uint4(3194215533u, 3212416226u, 0u, 0u), uint4(1046731949u, 3212416222u, 0u, 0u), uint4(1059036421u, 3209176606u, 0u, 0u), uint4(1063691749u, 3202229763u, 0u, 0u) };

			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

			static float2 fragment_input_1;
			static float2 fragment_input_0;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_0 : TEXCOORD0; // vs_TEXCOORD0
				float2 fragment_input_1 : TEXCOORD1; // vs_TEXCOORD1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static float3 fragment_unnamed_9;
			static float fragment_unnamed_32;
			static float4 fragment_unnamed_46;
			static float4 fragment_unnamed_49;
			static float4 fragment_unnamed_56;
			static float4 fragment_unnamed_73;
			static float fragment_unnamed_154;
			static float fragment_unnamed_197;
			static bool fragment_unnamed_237;
			static float fragment_unnamed_244;
			static bool fragment_unnamed_268;
			static bool fragment_unnamed_286;
			static int fragment_unnamed_332;

			void frag_main()
			{
				fragment_unnamed_9.x = _MainTex.Sample(sampler_MainTex, fragment_input_1).w;
				fragment_unnamed_32 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
				fragment_unnamed_46.w = 1.0f;
				fragment_unnamed_49.x = 0.0f;
				fragment_unnamed_49.y = 0.0f;
				fragment_unnamed_49.z = 0.0f;
				fragment_unnamed_49.w = 0.0f;
				fragment_unnamed_56.x = 0.0f;
				fragment_unnamed_56.y = 0.0f;
				fragment_unnamed_56.z = 0.0f;
				fragment_unnamed_56.w = 0.0f;
				for (int fragment_unnamed_62 = 0; fragment_unnamed_62 < 22; fragment_unnamed_62++)
				{
					float2 fragment_unnamed_151 = float2(float2(_MaxCoC, _MaxCoC)) * asfloat(fragment_unnamed_141[fragment_unnamed_62].xy);
					fragment_unnamed_73 = float4(fragment_unnamed_73.x, fragment_unnamed_151.x, fragment_unnamed_151.y, fragment_unnamed_73.w);
					fragment_unnamed_154 = dot(fragment_unnamed_73.yz, fragment_unnamed_73.yz);
					fragment_unnamed_154 = sqrt(fragment_unnamed_154);
					fragment_unnamed_73.x = fragment_unnamed_73.y * _RcpAspect;
					float2 fragment_unnamed_173 = fragment_unnamed_73.xz + fragment_input_0;
					fragment_unnamed_73 = float4(fragment_unnamed_173.x, fragment_unnamed_173.y, fragment_unnamed_73.z, fragment_unnamed_73.w);
					float2 fragment_unnamed_180 = clamp(fragment_unnamed_73.xy, 0.0f.xx, 1.0f.xx);
					fragment_unnamed_73 = float4(fragment_unnamed_180.x, fragment_unnamed_180.y, fragment_unnamed_73.z, fragment_unnamed_73.w);
					float2 fragment_unnamed_188 = fragment_unnamed_73.xy * _RenderViewportScaleFactor.xx;
					fragment_unnamed_73 = float4(fragment_unnamed_188.x, fragment_unnamed_188.y, fragment_unnamed_73.z, fragment_unnamed_73.w);
					fragment_unnamed_73 = _MainTex.Sample(sampler_MainTex, fragment_unnamed_73.xy);
					fragment_unnamed_197 = min(fragment_unnamed_9.x, fragment_unnamed_73.w);
					fragment_unnamed_197 = max(fragment_unnamed_197, 0.0f);
					fragment_unnamed_197 = (-fragment_unnamed_154) + fragment_unnamed_197;
					fragment_unnamed_197 = (_MainTex_TexelSize.y * 2.0f) + fragment_unnamed_197;
					fragment_unnamed_197 /= fragment_unnamed_32;
					fragment_unnamed_197 = clamp(fragment_unnamed_197, 0.0f, 1.0f);
					fragment_unnamed_154 = (-fragment_unnamed_154) + (-fragment_unnamed_73.w);
					fragment_unnamed_154 = (_MainTex_TexelSize.y * 2.0f) + fragment_unnamed_154;
					fragment_unnamed_154 /= fragment_unnamed_32;
					fragment_unnamed_154 = clamp(fragment_unnamed_154, 0.0f, 1.0f);
					fragment_unnamed_237 = (-fragment_unnamed_73.w) >= _MainTex_TexelSize.y;
					fragment_unnamed_244 = float(fragment_unnamed_237);
					fragment_unnamed_154 *= fragment_unnamed_244;
					fragment_unnamed_46 = float4(fragment_unnamed_73.xyz.x, fragment_unnamed_73.xyz.y, fragment_unnamed_73.xyz.z, fragment_unnamed_46.w);
					fragment_unnamed_49 = (fragment_unnamed_46 * fragment_unnamed_197.xxxx) + fragment_unnamed_49;
					fragment_unnamed_56 = (fragment_unnamed_46 * fragment_unnamed_154.xxxx) + fragment_unnamed_56;
				}
				fragment_unnamed_268 = fragment_unnamed_49.w == 0.0f;
				fragment_unnamed_9.x = float(fragment_unnamed_268);
				fragment_unnamed_9.x += fragment_unnamed_49.w;
				fragment_unnamed_9 = fragment_unnamed_49.xyz / fragment_unnamed_9.xxx;
				fragment_unnamed_286 = fragment_unnamed_56.w == 0.0f;
				fragment_unnamed_154 = float(fragment_unnamed_286);
				fragment_unnamed_154 += fragment_unnamed_56.w;
				float3 fragment_unnamed_300 = fragment_unnamed_56.xyz / fragment_unnamed_154.xxx;
				fragment_unnamed_46 = float4(fragment_unnamed_300.x, fragment_unnamed_300.y, fragment_unnamed_300.z, fragment_unnamed_46.w);
				fragment_unnamed_154 = fragment_unnamed_56.w * 0.14279966056346893310546875f;
				fragment_unnamed_154 = min(fragment_unnamed_154, 1.0f);
				float3 fragment_unnamed_313 = (-fragment_unnamed_9) + fragment_unnamed_46.xyz;
				fragment_unnamed_46 = float4(fragment_unnamed_313.x, fragment_unnamed_313.y, fragment_unnamed_313.z, fragment_unnamed_46.w);
				float3 fragment_unnamed_324 = (fragment_unnamed_154.xxx * fragment_unnamed_46.xyz) + fragment_unnamed_9;
				fragment_output_0 = float4(fragment_unnamed_324.x, fragment_unnamed_324.y, fragment_unnamed_324.z, fragment_output_0.w);
				fragment_output_0.w = fragment_unnamed_154;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_0 = stage_input.fragment_input_0;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			float _RenderViewportScaleFactor;
			float4 _MainTex_TexelSize;
			float _MaxCoC;
			float _RcpAspect;

			static float4 fragment_uniform_buffer_0[32];
			static const float fragment_unnamed_63[88] = { 0.0f, 0.0f, 0.0f, 0.0f, 0.533333361148834228515625f, 0.0f, 0.0f, 0.0f, 0.3325279057025909423828125f, 0.41697680950164794921875f, 0.0f, 0.0f, -0.118677847087383270263671875f, 0.5199615955352783203125f, 0.0f, 0.0f, -0.480516731739044189453125f, 0.23140470683574676513671875f, 0.0f, 0.0f, -0.480516731739044189453125f, -0.23140467703342437744140625f, 0.0f, 0.0f, -0.11867763102054595947265625f, -0.519961655139923095703125f, 0.0f, 0.0f, 0.3325278460979461669921875f, -0.4169768989086151123046875f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.900968849658966064453125f, 0.4338837563991546630859375f, 0.0f, 0.0f, 0.623489797115325927734375f, 0.7818315029144287109375f, 0.0f, 0.0f, 0.2225209772586822509765625f, 0.9749279022216796875f, 0.0f, 0.0f, -0.22252094745635986328125f, 0.9749279022216796875f, 0.0f, 0.0f, -0.62348997592926025390625f, 0.78183138370513916015625f, 0.0f, 0.0f, -0.900968849658966064453125f, 0.4338838160037994384765625f, 0.0f, 0.0f, -1.0f, 0.0f, 0.0f, 0.0f, -0.900968849658966064453125f, -0.4338837563991546630859375f, 0.0f, 0.0f, -0.6234896183013916015625f, -0.78183162212371826171875f, 0.0f, 0.0f, -0.22252054512500762939453125f, -0.97492802143096923828125f, 0.0f, 0.0f, 0.22252149879932403564453125f, -0.97492778301239013671875f, 0.0f, 0.0f, 0.623489677906036376953125f, -0.78183162212371826171875f, 0.0f, 0.0f, 0.900968849658966064453125f, -0.4338837563991546630859375f, 0.0f, 0.0f };

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
				float4 fragment_unnamed_77 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				float fragment_unnamed_79 = fragment_unnamed_77.w;
				precise float fragment_unnamed_88 = fragment_uniform_buffer_0[28u].y + fragment_uniform_buffer_0[28u].y;
				float fragment_unnamed_89 = asfloat(1065353216u);
				float fragment_unnamed_99;
				float fragment_unnamed_101;
				float fragment_unnamed_103;
				float fragment_unnamed_105;
				float fragment_unnamed_107;
				float fragment_unnamed_109;
				float fragment_unnamed_111;
				float fragment_unnamed_113;
				fragment_unnamed_99 = asfloat(0u);
				fragment_unnamed_101 = asfloat(0u);
				fragment_unnamed_103 = asfloat(0u);
				fragment_unnamed_105 = asfloat(0u);
				fragment_unnamed_107 = asfloat(0u);
				fragment_unnamed_109 = asfloat(0u);
				fragment_unnamed_111 = asfloat(0u);
				fragment_unnamed_113 = asfloat(0u);
				precise float fragment_unnamed_172;
				precise float fragment_unnamed_173;
				float fragment_unnamed_177;
				precise float fragment_unnamed_182;
				precise float fragment_unnamed_187;
				precise float fragment_unnamed_188;
				precise float fragment_unnamed_195;
				precise float fragment_unnamed_196;
				float4 fragment_unnamed_198;
				float fragment_unnamed_200;
				float fragment_unnamed_201;
				float fragment_unnamed_202;
				float fragment_unnamed_203;
				precise float fragment_unnamed_206;
				precise float fragment_unnamed_207;
				precise float fragment_unnamed_213;
				float fragment_unnamed_214;
				precise float fragment_unnamed_215;
				precise float fragment_unnamed_216;
				precise float fragment_unnamed_217;
				precise float fragment_unnamed_222;
				precise float fragment_unnamed_224;
				precise float fragment_unnamed_232;
				for (uint fragment_unnamed_115 = 0u; !(int(fragment_unnamed_115) >= int(22u)); fragment_unnamed_172 = fragment_uniform_buffer_0[30u].z * fragment_unnamed_63[(fragment_unnamed_115 * 4u) + 0u], fragment_unnamed_173 = fragment_uniform_buffer_0[30u].z * fragment_unnamed_63[(fragment_unnamed_115 * 4u) + 1u], fragment_unnamed_177 = sqrt(dot(float2(fragment_unnamed_172, fragment_unnamed_173), float2(fragment_unnamed_172, fragment_unnamed_173))), fragment_unnamed_182 = fragment_unnamed_172 * fragment_uniform_buffer_0[31u].x, fragment_unnamed_187 = fragment_unnamed_182 + fragment_input_1.x, fragment_unnamed_188 = fragment_unnamed_173 + fragment_input_1.y, fragment_unnamed_195 = clamp(fragment_unnamed_187, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, fragment_unnamed_196 = clamp(fragment_unnamed_188, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, fragment_unnamed_198 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_195, fragment_unnamed_196)), fragment_unnamed_200 = fragment_unnamed_198.x, fragment_unnamed_201 = fragment_unnamed_198.y, fragment_unnamed_202 = fragment_unnamed_198.z, fragment_unnamed_203 = fragment_unnamed_198.w, fragment_unnamed_206 = (-0.0f) - fragment_unnamed_177, fragment_unnamed_207 = fragment_unnamed_206 + max(min(fragment_unnamed_79, fragment_unnamed_203), 0.0f), fragment_unnamed_213 = mad(fragment_uniform_buffer_0[28u].y, 2.0f, fragment_unnamed_207) / fragment_unnamed_88, fragment_unnamed_214 = clamp(fragment_unnamed_213, 0.0f, 1.0f), fragment_unnamed_215 = (-0.0f) - fragment_unnamed_177, fragment_unnamed_216 = (-0.0f) - fragment_unnamed_203, fragment_unnamed_217 = fragment_unnamed_215 + fragment_unnamed_216, fragment_unnamed_222 = mad(fragment_uniform_buffer_0[28u].y, 2.0f, fragment_unnamed_217) / fragment_unnamed_88, fragment_unnamed_224 = (-0.0f) - fragment_unnamed_203, fragment_unnamed_232 = clamp(fragment_unnamed_222, 0.0f, 1.0f) * asfloat(((fragment_unnamed_224 >= fragment_uniform_buffer_0[28u].y) ? 4294967295u : 0u) & 1065353216u), fragment_unnamed_99 = mad(fragment_unnamed_201, fragment_unnamed_214, fragment_unnamed_99), fragment_unnamed_101 = mad(fragment_unnamed_202, fragment_unnamed_214, fragment_unnamed_101), fragment_unnamed_103 = mad(fragment_unnamed_89, fragment_unnamed_214, fragment_unnamed_103), fragment_unnamed_105 = mad(fragment_unnamed_200, fragment_unnamed_232, fragment_unnamed_105), fragment_unnamed_107 = mad(fragment_unnamed_201, fragment_unnamed_232, fragment_unnamed_107), fragment_unnamed_109 = mad(fragment_unnamed_202, fragment_unnamed_232, fragment_unnamed_109), fragment_unnamed_111 = mad(fragment_unnamed_89, fragment_unnamed_232, fragment_unnamed_111), fragment_unnamed_113 = mad(fragment_unnamed_200, fragment_unnamed_214, fragment_unnamed_113), fragment_unnamed_115++)
				{
				}
				precise float fragment_unnamed_125 = asfloat(((fragment_unnamed_103 == 0.0f) ? 4294967295u : 0u) & 1065353216u) + fragment_unnamed_103;
				precise float fragment_unnamed_126 = fragment_unnamed_113 / fragment_unnamed_125;
				precise float fragment_unnamed_127 = fragment_unnamed_99 / fragment_unnamed_125;
				precise float fragment_unnamed_128 = fragment_unnamed_101 / fragment_unnamed_125;
				precise float fragment_unnamed_133 = asfloat(((fragment_unnamed_111 == 0.0f) ? 4294967295u : 0u) & 1065353216u) + fragment_unnamed_111;
				precise float fragment_unnamed_134 = fragment_unnamed_105 / fragment_unnamed_133;
				precise float fragment_unnamed_135 = fragment_unnamed_107 / fragment_unnamed_133;
				precise float fragment_unnamed_136 = fragment_unnamed_109 / fragment_unnamed_133;
				precise float fragment_unnamed_137 = fragment_unnamed_111 * 0.14279966056346893310546875f;
				float fragment_unnamed_140 = min(fragment_unnamed_137, 1.0f);
				precise float fragment_unnamed_141 = (-0.0f) - fragment_unnamed_126;
				precise float fragment_unnamed_143 = (-0.0f) - fragment_unnamed_127;
				precise float fragment_unnamed_144 = (-0.0f) - fragment_unnamed_128;
				precise float fragment_unnamed_145 = fragment_unnamed_141 + fragment_unnamed_134;
				precise float fragment_unnamed_146 = fragment_unnamed_143 + fragment_unnamed_135;
				precise float fragment_unnamed_147 = fragment_unnamed_144 + fragment_unnamed_136;
				fragment_output_0.x = mad(fragment_unnamed_140, fragment_unnamed_145, fragment_unnamed_126);
				fragment_output_0.y = mad(fragment_unnamed_140, fragment_unnamed_146, fragment_unnamed_127);
				fragment_output_0.z = mad(fragment_unnamed_140, fragment_unnamed_147, fragment_unnamed_128);
				fragment_output_0.w = fragment_unnamed_140;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, fragment_uniform_buffer_0[26][1], fragment_uniform_buffer_0[26][2], fragment_uniform_buffer_0[26][3]);

				fragment_uniform_buffer_0[28] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				fragment_uniform_buffer_0[30] = float4(fragment_uniform_buffer_0[30][0], fragment_uniform_buffer_0[30][1], _MaxCoC, fragment_uniform_buffer_0[30][3]);

				fragment_uniform_buffer_0[31] = float4(_RcpAspect, fragment_uniform_buffer_0[31][1], fragment_uniform_buffer_0[31][2], fragment_uniform_buffer_0[31][3]);

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
			Name "Bokeh Filter (large)"
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 364199

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
			float _MaxCoC;
			float _RcpAspect;

			static const uint4 fragment_unnamed_202[43] = { uint4(0u, 0u, 0u, 0u), uint4(1052389004u, 0u, 0u, 0u), uint4(1047013945u, 1049726997u, 0u, 0u), uint4(3181754281u, 1052083084u, 0u, 0u), uint4(3198664312u, 1042386948u, 0u, 0u), uint4(3198664312u, 3189870594u, 0u, 0u), uint4(3181754261u, 3199566733u, 0u, 0u), uint4(1047013942u, 3197210646u, 0u, 0u), uint4(1060015011u, 0u, 0u, 0u), uint4(1058882193u, 1050113794u, 0u, 0u), uint4(1054451605u, 1057519379u, 0u, 0u), uint4(1041980464u, 1059728211u, 0u, 0u), uint4(3189464110u, 1059728211u, 0u, 0u), uint4(3201935257u, 1057519378u, 0u, 0u), uint4(3206365841u, 1050113795u, 0u, 0u), uint4(3207498659u, 0u, 0u, 0u), uint4(3206365841u, 3197597442u, 0u, 0u), uint4(3201935249u, 3205003029u, 0u, 0u), uint4(3189464092u, 3207211860u, 0u, 0u), uint4(1041980487u, 3207211858u, 0u, 0u), uint4(1054451603u, 3205003029u, 0u, 0u), uint4(1058882193u, 3197597442u, 0u, 0u), uint4(1065353216u, 0u, 0u, 0u), uint4(1064607851u, 1050077735u, 0u, 0u), uint4(1062437986u, 1058026943u, 0u, 0u), uint4(1059036423u, 1061692956u, 0u, 0u), uint4(1052446201u, 1064193470u, 0u, 0u), uint4(1033440267u, 1065306304u, 0u, 0u), uint4(3194215560u, 1064932576u, 0u, 0u), uint4(3204448257u, 1063105495u, 0u, 0u), uint4(3208358219u, 1059987404u, 0u, 0u), uint4(3211175397u, 1054746117u, 0u, 0u), uint4(3212649477u, 1041800829u, 0u, 0u), uint4(3212649476u, 3189284504u, 0u, 0u), uint4(3211175397u, 3202229763u, 0u, 0u), uint4(3208358217u, 3207471054u, 0u, 0u), uint4(3204448253u, 3210589144u, 0u, 0u), uint4(3194215564u, 3212416224u, 0u, 0u), uint4(1033440306u, 3212789951u, 0u, 0u), uint4(1052446218u, 3211677115u, 0u, 0u), uint4(1059036421u, 3209176606u, 0u, 0u), uint4(1062437987u, 3205510589u, 0u, 0u), uint4(1064607853u, 3197561371u, 0u, 0u) };

			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

			static float2 fragment_input_1;
			static float2 fragment_input_0;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_0 : TEXCOORD0; // vs_TEXCOORD0
				float2 fragment_input_1 : TEXCOORD1; // vs_TEXCOORD1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static float3 fragment_unnamed_9;
			static float fragment_unnamed_32;
			static float4 fragment_unnamed_46;
			static float4 fragment_unnamed_49;
			static float4 fragment_unnamed_56;
			static float4 fragment_unnamed_73;
			static float fragment_unnamed_215;
			static float fragment_unnamed_258;
			static bool fragment_unnamed_298;
			static float fragment_unnamed_305;
			static bool fragment_unnamed_329;
			static bool fragment_unnamed_347;
			static int fragment_unnamed_393;

			void frag_main()
			{
				fragment_unnamed_9.x = _MainTex.Sample(sampler_MainTex, fragment_input_1).w;
				fragment_unnamed_32 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
				fragment_unnamed_46.w = 1.0f;
				fragment_unnamed_49.x = 0.0f;
				fragment_unnamed_49.y = 0.0f;
				fragment_unnamed_49.z = 0.0f;
				fragment_unnamed_49.w = 0.0f;
				fragment_unnamed_56.x = 0.0f;
				fragment_unnamed_56.y = 0.0f;
				fragment_unnamed_56.z = 0.0f;
				fragment_unnamed_56.w = 0.0f;
				for (int fragment_unnamed_62 = 0; fragment_unnamed_62 < 43; fragment_unnamed_62++)
				{
					float2 fragment_unnamed_212 = float2(float2(_MaxCoC, _MaxCoC)) * asfloat(fragment_unnamed_202[fragment_unnamed_62].xy);
					fragment_unnamed_73 = float4(fragment_unnamed_73.x, fragment_unnamed_212.x, fragment_unnamed_212.y, fragment_unnamed_73.w);
					fragment_unnamed_215 = dot(fragment_unnamed_73.yz, fragment_unnamed_73.yz);
					fragment_unnamed_215 = sqrt(fragment_unnamed_215);
					fragment_unnamed_73.x = fragment_unnamed_73.y * _RcpAspect;
					float2 fragment_unnamed_234 = fragment_unnamed_73.xz + fragment_input_0;
					fragment_unnamed_73 = float4(fragment_unnamed_234.x, fragment_unnamed_234.y, fragment_unnamed_73.z, fragment_unnamed_73.w);
					float2 fragment_unnamed_241 = clamp(fragment_unnamed_73.xy, 0.0f.xx, 1.0f.xx);
					fragment_unnamed_73 = float4(fragment_unnamed_241.x, fragment_unnamed_241.y, fragment_unnamed_73.z, fragment_unnamed_73.w);
					float2 fragment_unnamed_249 = fragment_unnamed_73.xy * _RenderViewportScaleFactor.xx;
					fragment_unnamed_73 = float4(fragment_unnamed_249.x, fragment_unnamed_249.y, fragment_unnamed_73.z, fragment_unnamed_73.w);
					fragment_unnamed_73 = _MainTex.Sample(sampler_MainTex, fragment_unnamed_73.xy);
					fragment_unnamed_258 = min(fragment_unnamed_9.x, fragment_unnamed_73.w);
					fragment_unnamed_258 = max(fragment_unnamed_258, 0.0f);
					fragment_unnamed_258 = (-fragment_unnamed_215) + fragment_unnamed_258;
					fragment_unnamed_258 = (_MainTex_TexelSize.y * 2.0f) + fragment_unnamed_258;
					fragment_unnamed_258 /= fragment_unnamed_32;
					fragment_unnamed_258 = clamp(fragment_unnamed_258, 0.0f, 1.0f);
					fragment_unnamed_215 = (-fragment_unnamed_215) + (-fragment_unnamed_73.w);
					fragment_unnamed_215 = (_MainTex_TexelSize.y * 2.0f) + fragment_unnamed_215;
					fragment_unnamed_215 /= fragment_unnamed_32;
					fragment_unnamed_215 = clamp(fragment_unnamed_215, 0.0f, 1.0f);
					fragment_unnamed_298 = (-fragment_unnamed_73.w) >= _MainTex_TexelSize.y;
					fragment_unnamed_305 = float(fragment_unnamed_298);
					fragment_unnamed_215 *= fragment_unnamed_305;
					fragment_unnamed_46 = float4(fragment_unnamed_73.xyz.x, fragment_unnamed_73.xyz.y, fragment_unnamed_73.xyz.z, fragment_unnamed_46.w);
					fragment_unnamed_49 = (fragment_unnamed_46 * fragment_unnamed_258.xxxx) + fragment_unnamed_49;
					fragment_unnamed_56 = (fragment_unnamed_46 * fragment_unnamed_215.xxxx) + fragment_unnamed_56;
				}
				fragment_unnamed_329 = fragment_unnamed_49.w == 0.0f;
				fragment_unnamed_9.x = float(fragment_unnamed_329);
				fragment_unnamed_9.x += fragment_unnamed_49.w;
				fragment_unnamed_9 = fragment_unnamed_49.xyz / fragment_unnamed_9.xxx;
				fragment_unnamed_347 = fragment_unnamed_56.w == 0.0f;
				fragment_unnamed_215 = float(fragment_unnamed_347);
				fragment_unnamed_215 += fragment_unnamed_56.w;
				float3 fragment_unnamed_361 = fragment_unnamed_56.xyz / fragment_unnamed_215.xxx;
				fragment_unnamed_46 = float4(fragment_unnamed_361.x, fragment_unnamed_361.y, fragment_unnamed_361.z, fragment_unnamed_46.w);
				fragment_unnamed_215 = fragment_unnamed_56.w * 0.073060296475887298583984375f;
				fragment_unnamed_215 = min(fragment_unnamed_215, 1.0f);
				float3 fragment_unnamed_374 = (-fragment_unnamed_9) + fragment_unnamed_46.xyz;
				fragment_unnamed_46 = float4(fragment_unnamed_374.x, fragment_unnamed_374.y, fragment_unnamed_374.z, fragment_unnamed_46.w);
				float3 fragment_unnamed_385 = (fragment_unnamed_215.xxx * fragment_unnamed_46.xyz) + fragment_unnamed_9;
				fragment_output_0 = float4(fragment_unnamed_385.x, fragment_unnamed_385.y, fragment_unnamed_385.z, fragment_output_0.w);
				fragment_output_0.w = fragment_unnamed_215;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_0 = stage_input.fragment_input_0;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			float _RenderViewportScaleFactor;
			float4 _MainTex_TexelSize;
			float _MaxCoC;
			float _RcpAspect;

			static float4 fragment_uniform_buffer_0[32];
			static const float fragment_unnamed_103[172] = { 0.0f, 0.0f, 0.0f, 0.0f, 0.36363637447357177734375f, 0.0f, 0.0f, 0.0f, 0.22672356665134429931640625f, 0.2843023836612701416015625f, 0.0f, 0.0f, -0.080916710197925567626953125f, 0.35451924800872802734375f, 0.0f, 0.0f, -0.3276250362396240234375f, 0.157775938510894775390625f, 0.0f, 0.0f, -0.3276250362396240234375f, -0.1577759087085723876953125f, 0.0f, 0.0f, -0.080916561186313629150390625f, -0.3545192778110504150390625f, 0.0f, 0.0f, 0.2267235219478607177734375f, -0.284302413463592529296875f, 0.0f, 0.0f, 0.681818187236785888671875f, 0.0f, 0.0f, 0.0f, 0.614296972751617431640625f, 0.295829832553863525390625f, 0.0f, 0.0f, 0.4251066744327545166015625f, 0.533066928386688232421875f, 0.0f, 0.0f, 0.1517188549041748046875f, 0.664723575115203857421875f, 0.0f, 0.0f, -0.1517188251018524169921875f, 0.664723575115203857421875f, 0.0f, 0.0f, -0.4251067936420440673828125f, 0.53306686878204345703125f, 0.0f, 0.0f, -0.614296972751617431640625f, 0.2958298623561859130859375f, 0.0f, 0.0f, -0.681818187236785888671875f, 0.0f, 0.0f, 0.0f, -0.614296972751617431640625f, -0.295829832553863525390625f, 0.0f, 0.0f, -0.4251065552234649658203125f, -0.533067047595977783203125f, 0.0f, 0.0f, -0.151718556880950927734375f, -0.6647236347198486328125f, 0.0f, 0.0f, 0.15171919763088226318359375f, -0.66472351551055908203125f, 0.0f, 0.0f, 0.4251066148281097412109375f, -0.533067047595977783203125f, 0.0f, 0.0f, 0.614296972751617431640625f, -0.295829832553863525390625f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.955572783946990966796875f, 0.2947551906108856201171875f, 0.0f, 0.0f, 0.82623875141143798828125f, 0.563320100307464599609375f, 0.0f, 0.0f, 0.623489797115325927734375f, 0.7818315029144287109375f, 0.0f, 0.0f, 0.3653409779071807861328125f, 0.93087375164031982421875f, 0.0f, 0.0f, 0.074730001389980316162109375f, 0.997203826904296875f, 0.0f, 0.0f, -0.22252094745635986328125f, 0.9749279022216796875f, 0.0f, 0.0f, -0.500000059604644775390625f, 0.866025388240814208984375f, 0.0f, 0.0f, -0.733051955699920654296875f, 0.6801726818084716796875f, 0.0f, 0.0f, -0.900968849658966064453125f, 0.4338838160037994384765625f, 0.0f, 0.0f, -0.988830864429473876953125f, 0.14904208481311798095703125f, 0.0f, 0.0f, -0.9888308048248291015625f, -0.14904248714447021484375f, 0.0f, 0.0f, -0.900968849658966064453125f, -0.4338837563991546630859375f, 0.0f, 0.0f, -0.733051836490631103515625f, -0.68017280101776123046875f, 0.0f, 0.0f, -0.4999999105930328369140625f, -0.866025447845458984375f, 0.0f, 0.0f, -0.222521007061004638671875f, -0.9749279022216796875f, 0.0f, 0.0f, 0.07473029196262359619140625f, -0.997203767299652099609375f, 0.0f, 0.0f, 0.365341484546661376953125f, -0.930873572826385498046875f, 0.0f, 0.0f, 0.623489677906036376953125f, -0.78183162212371826171875f, 0.0f, 0.0f, 0.826238811016082763671875f, -0.563319981098175048828125f, 0.0f, 0.0f, 0.955572903156280517578125f, -0.2947548329830169677734375f, 0.0f, 0.0f };

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
				float4 fragment_unnamed_117 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				float fragment_unnamed_119 = fragment_unnamed_117.w;
				precise float fragment_unnamed_128 = fragment_uniform_buffer_0[28u].y + fragment_uniform_buffer_0[28u].y;
				float fragment_unnamed_129 = asfloat(1065353216u);
				float fragment_unnamed_139;
				float fragment_unnamed_141;
				float fragment_unnamed_143;
				float fragment_unnamed_145;
				float fragment_unnamed_147;
				float fragment_unnamed_149;
				float fragment_unnamed_151;
				float fragment_unnamed_153;
				fragment_unnamed_139 = asfloat(0u);
				fragment_unnamed_141 = asfloat(0u);
				fragment_unnamed_143 = asfloat(0u);
				fragment_unnamed_145 = asfloat(0u);
				fragment_unnamed_147 = asfloat(0u);
				fragment_unnamed_149 = asfloat(0u);
				fragment_unnamed_151 = asfloat(0u);
				fragment_unnamed_153 = asfloat(0u);
				precise float fragment_unnamed_212;
				precise float fragment_unnamed_213;
				float fragment_unnamed_217;
				precise float fragment_unnamed_222;
				precise float fragment_unnamed_227;
				precise float fragment_unnamed_228;
				precise float fragment_unnamed_235;
				precise float fragment_unnamed_236;
				float4 fragment_unnamed_238;
				float fragment_unnamed_240;
				float fragment_unnamed_241;
				float fragment_unnamed_242;
				float fragment_unnamed_243;
				precise float fragment_unnamed_246;
				precise float fragment_unnamed_247;
				precise float fragment_unnamed_253;
				float fragment_unnamed_254;
				precise float fragment_unnamed_255;
				precise float fragment_unnamed_256;
				precise float fragment_unnamed_257;
				precise float fragment_unnamed_262;
				precise float fragment_unnamed_264;
				precise float fragment_unnamed_272;
				for (uint fragment_unnamed_155 = 0u; !(int(fragment_unnamed_155) >= int(43u)); fragment_unnamed_212 = fragment_uniform_buffer_0[30u].z * fragment_unnamed_103[(fragment_unnamed_155 * 4u) + 0u], fragment_unnamed_213 = fragment_uniform_buffer_0[30u].z * fragment_unnamed_103[(fragment_unnamed_155 * 4u) + 1u], fragment_unnamed_217 = sqrt(dot(float2(fragment_unnamed_212, fragment_unnamed_213), float2(fragment_unnamed_212, fragment_unnamed_213))), fragment_unnamed_222 = fragment_unnamed_212 * fragment_uniform_buffer_0[31u].x, fragment_unnamed_227 = fragment_unnamed_222 + fragment_input_1.x, fragment_unnamed_228 = fragment_unnamed_213 + fragment_input_1.y, fragment_unnamed_235 = clamp(fragment_unnamed_227, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, fragment_unnamed_236 = clamp(fragment_unnamed_228, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, fragment_unnamed_238 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_235, fragment_unnamed_236)), fragment_unnamed_240 = fragment_unnamed_238.x, fragment_unnamed_241 = fragment_unnamed_238.y, fragment_unnamed_242 = fragment_unnamed_238.z, fragment_unnamed_243 = fragment_unnamed_238.w, fragment_unnamed_246 = (-0.0f) - fragment_unnamed_217, fragment_unnamed_247 = fragment_unnamed_246 + max(min(fragment_unnamed_119, fragment_unnamed_243), 0.0f), fragment_unnamed_253 = mad(fragment_uniform_buffer_0[28u].y, 2.0f, fragment_unnamed_247) / fragment_unnamed_128, fragment_unnamed_254 = clamp(fragment_unnamed_253, 0.0f, 1.0f), fragment_unnamed_255 = (-0.0f) - fragment_unnamed_217, fragment_unnamed_256 = (-0.0f) - fragment_unnamed_243, fragment_unnamed_257 = fragment_unnamed_255 + fragment_unnamed_256, fragment_unnamed_262 = mad(fragment_uniform_buffer_0[28u].y, 2.0f, fragment_unnamed_257) / fragment_unnamed_128, fragment_unnamed_264 = (-0.0f) - fragment_unnamed_243, fragment_unnamed_272 = clamp(fragment_unnamed_262, 0.0f, 1.0f) * asfloat(((fragment_unnamed_264 >= fragment_uniform_buffer_0[28u].y) ? 4294967295u : 0u) & 1065353216u), fragment_unnamed_139 = mad(fragment_unnamed_241, fragment_unnamed_254, fragment_unnamed_139), fragment_unnamed_141 = mad(fragment_unnamed_242, fragment_unnamed_254, fragment_unnamed_141), fragment_unnamed_143 = mad(fragment_unnamed_129, fragment_unnamed_254, fragment_unnamed_143), fragment_unnamed_145 = mad(fragment_unnamed_240, fragment_unnamed_272, fragment_unnamed_145), fragment_unnamed_147 = mad(fragment_unnamed_241, fragment_unnamed_272, fragment_unnamed_147), fragment_unnamed_149 = mad(fragment_unnamed_242, fragment_unnamed_272, fragment_unnamed_149), fragment_unnamed_151 = mad(fragment_unnamed_129, fragment_unnamed_272, fragment_unnamed_151), fragment_unnamed_153 = mad(fragment_unnamed_240, fragment_unnamed_254, fragment_unnamed_153), fragment_unnamed_155++)
				{
				}
				precise float fragment_unnamed_165 = asfloat(((fragment_unnamed_143 == 0.0f) ? 4294967295u : 0u) & 1065353216u) + fragment_unnamed_143;
				precise float fragment_unnamed_166 = fragment_unnamed_153 / fragment_unnamed_165;
				precise float fragment_unnamed_167 = fragment_unnamed_139 / fragment_unnamed_165;
				precise float fragment_unnamed_168 = fragment_unnamed_141 / fragment_unnamed_165;
				precise float fragment_unnamed_173 = asfloat(((fragment_unnamed_151 == 0.0f) ? 4294967295u : 0u) & 1065353216u) + fragment_unnamed_151;
				precise float fragment_unnamed_174 = fragment_unnamed_145 / fragment_unnamed_173;
				precise float fragment_unnamed_175 = fragment_unnamed_147 / fragment_unnamed_173;
				precise float fragment_unnamed_176 = fragment_unnamed_149 / fragment_unnamed_173;
				precise float fragment_unnamed_177 = fragment_unnamed_151 * 0.073060296475887298583984375f;
				float fragment_unnamed_180 = min(fragment_unnamed_177, 1.0f);
				precise float fragment_unnamed_181 = (-0.0f) - fragment_unnamed_166;
				precise float fragment_unnamed_183 = (-0.0f) - fragment_unnamed_167;
				precise float fragment_unnamed_184 = (-0.0f) - fragment_unnamed_168;
				precise float fragment_unnamed_185 = fragment_unnamed_181 + fragment_unnamed_174;
				precise float fragment_unnamed_186 = fragment_unnamed_183 + fragment_unnamed_175;
				precise float fragment_unnamed_187 = fragment_unnamed_184 + fragment_unnamed_176;
				fragment_output_0.x = mad(fragment_unnamed_180, fragment_unnamed_185, fragment_unnamed_166);
				fragment_output_0.y = mad(fragment_unnamed_180, fragment_unnamed_186, fragment_unnamed_167);
				fragment_output_0.z = mad(fragment_unnamed_180, fragment_unnamed_187, fragment_unnamed_168);
				fragment_output_0.w = fragment_unnamed_180;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, fragment_uniform_buffer_0[26][1], fragment_uniform_buffer_0[26][2], fragment_uniform_buffer_0[26][3]);

				fragment_uniform_buffer_0[28] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				fragment_uniform_buffer_0[30] = float4(fragment_uniform_buffer_0[30][0], fragment_uniform_buffer_0[30][1], _MaxCoC, fragment_uniform_buffer_0[30][3]);

				fragment_uniform_buffer_0[31] = float4(_RcpAspect, fragment_uniform_buffer_0[31][1], fragment_uniform_buffer_0[31][2], fragment_uniform_buffer_0[31][3]);

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
			Name "Bokeh Filter (very large)"
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 412682

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
			float _MaxCoC;
			float _RcpAspect;

			static const uint4 fragment_unnamed_267[71] = { uint4(0u, 0u, 0u, 0u), uint4(1049443788u, 0u, 0u, 0u), uint4(1043341321u, 1046272668u, 0u, 0u), uint4(3178983152u, 1049211711u, 0u, 0u), uint4(3195961881u, 1039474978u, 0u, 0u), uint4(3195961881u, 3186958623u, 0u, 0u), uint4(3178983122u, 3196695360u, 0u, 0u), uint4(1043341319u, 3193756318u, 0u, 0u), uint4(1057253870u, 0u, 0u, 0u), uint4(1055824373u, 1046859531u, 0u, 0u), uint4(1051008519u, 1053756656u, 0u, 0u), uint4(1038858241u, 1057036298u, 0u, 0u), uint4(3186341887u, 1057036298u, 0u, 0u), uint4(3198492170u, 1053756654u, 0u, 0u), uint4(3203308021u, 1046859533u, 0u, 0u), uint4(3204737518u, 0u, 0u, 0u), uint4(3203308021u, 3194343179u, 0u, 0u), uint4(3198492164u, 3201240306u, 0u, 0u), uint4(3186341859u, 3204519947u, 0u, 0u), uint4(1038858277u, 3204519945u, 0u, 0u), uint4(1051008517u, 3201240306u, 0u, 0u), uint4(1055824373u, 3194343179u, 0u, 0u), uint4(1061303543u, 0u, 0u, 0u), uint4(1060738094u, 1046804821u, 0u, 0u), uint4(1059091989u, 1054526754u, 0u, 0u), uint4(1056058378u, 1058526794u, 0u, 0u), uint4(1049487178u, 1060423736u, 0u, 0u), uint4(1030239637u, 1061267955u, 0u, 0u), uint4(3190611012u, 1060984437u, 0u, 0u), uint4(3200398585u, 1059598375u, 0u, 0u), uint4(3205389598u, 1057232927u, 0u, 0u), uint4(3207526768u, 1051231942u, 0u, 0u), uint4(3208645035u, 1038585692u, 0u, 0u), uint4(3208645035u, 3186069381u, 0u, 0u), uint4(3207526768u, 3198715588u, 0u, 0u), uint4(3205389597u, 3204716577u, 0u, 0u), uint4(3200398581u, 3207082024u, 0u, 0u), uint4(3190611015u, 3208468085u, 0u, 0u), uint4(1030239696u, 3208751602u, 0u, 0u), uint4(1049487191u, 3207907381u, 0u, 0u), uint4(1056058375u, 3206010444u, 0u, 0u), uint4(1059091990u, 3202010399u, 0u, 0u), uint4(1060738095u, 3194288451u, 0u, 0u), uint4(1065353216u, 0u, 0u, 0u), uint4(1064932576u, 1046731911u, 0u, 0u), uint4(1063691749u, 1054746115u, 0u, 0u), uint4(1061692956u, 1059036423u, 0u, 0u), uint4(1059036423u, 1061692956u, 0u, 0u), uint4(1054746111u, 1063691750u, 0u, 0u), uint4(1046731914u, 1064932576u, 0u, 0u), uint4(0u, 1065353216u, 0u, 0u), uint4(3194215560u, 1064932576u, 0u, 0u), uint4(3202229766u, 1063691749u, 0u, 0u), uint4(3206520074u, 1061692954u, 0u, 0u), uint4(3209176607u, 1059036419u, 0u, 0u), uint4(3211175397u, 1054746117u, 0u, 0u), uint4(3212416224u, 1046731911u, 0u, 0u), uint4(3212836864u, 0u, 0u, 0u), uint4(3212416224u, 3194215555u, 0u, 0u), uint4(3211175397u, 3202229763u, 0u, 0u), uint4(3209176602u, 3206520073u, 0u, 0u), uint4(3206520068u, 3209176606u, 0u, 0u), uint4(3202229753u, 3211175400u, 0u, 0u), uint4(3194215533u, 3212416226u, 0u, 0u), uint4(0u, 3212836864u, 0u, 0u), uint4(1046731949u, 3212416222u, 0u, 0u), uint4(1054746106u, 3211175399u, 0u, 0u), uint4(1059036421u, 3209176606u, 0u, 0u), uint4(1061692955u, 3206520072u, 0u, 0u), uint4(1063691749u, 3202229763u, 0u, 0u), uint4(1064932576u, 3194215554u, 0u, 0u) };

			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

			static float2 fragment_input_1;
			static float2 fragment_input_0;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_0 : TEXCOORD0; // vs_TEXCOORD0
				float2 fragment_input_1 : TEXCOORD1; // vs_TEXCOORD1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static float3 fragment_unnamed_9;
			static float fragment_unnamed_32;
			static float4 fragment_unnamed_46;
			static float4 fragment_unnamed_49;
			static float4 fragment_unnamed_56;
			static float4 fragment_unnamed_73;
			static float fragment_unnamed_280;
			static float fragment_unnamed_323;
			static bool fragment_unnamed_363;
			static float fragment_unnamed_370;
			static bool fragment_unnamed_394;
			static bool fragment_unnamed_412;
			static int fragment_unnamed_458;

			void frag_main()
			{
				fragment_unnamed_9.x = _MainTex.Sample(sampler_MainTex, fragment_input_1).w;
				fragment_unnamed_32 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
				fragment_unnamed_46.w = 1.0f;
				fragment_unnamed_49.x = 0.0f;
				fragment_unnamed_49.y = 0.0f;
				fragment_unnamed_49.z = 0.0f;
				fragment_unnamed_49.w = 0.0f;
				fragment_unnamed_56.x = 0.0f;
				fragment_unnamed_56.y = 0.0f;
				fragment_unnamed_56.z = 0.0f;
				fragment_unnamed_56.w = 0.0f;
				for (int fragment_unnamed_62 = 0; fragment_unnamed_62 < 71; fragment_unnamed_62++)
				{
					float2 fragment_unnamed_277 = float2(float2(_MaxCoC, _MaxCoC)) * asfloat(fragment_unnamed_267[fragment_unnamed_62].xy);
					fragment_unnamed_73 = float4(fragment_unnamed_73.x, fragment_unnamed_277.x, fragment_unnamed_277.y, fragment_unnamed_73.w);
					fragment_unnamed_280 = dot(fragment_unnamed_73.yz, fragment_unnamed_73.yz);
					fragment_unnamed_280 = sqrt(fragment_unnamed_280);
					fragment_unnamed_73.x = fragment_unnamed_73.y * _RcpAspect;
					float2 fragment_unnamed_299 = fragment_unnamed_73.xz + fragment_input_0;
					fragment_unnamed_73 = float4(fragment_unnamed_299.x, fragment_unnamed_299.y, fragment_unnamed_73.z, fragment_unnamed_73.w);
					float2 fragment_unnamed_306 = clamp(fragment_unnamed_73.xy, 0.0f.xx, 1.0f.xx);
					fragment_unnamed_73 = float4(fragment_unnamed_306.x, fragment_unnamed_306.y, fragment_unnamed_73.z, fragment_unnamed_73.w);
					float2 fragment_unnamed_314 = fragment_unnamed_73.xy * _RenderViewportScaleFactor.xx;
					fragment_unnamed_73 = float4(fragment_unnamed_314.x, fragment_unnamed_314.y, fragment_unnamed_73.z, fragment_unnamed_73.w);
					fragment_unnamed_73 = _MainTex.Sample(sampler_MainTex, fragment_unnamed_73.xy);
					fragment_unnamed_323 = min(fragment_unnamed_9.x, fragment_unnamed_73.w);
					fragment_unnamed_323 = max(fragment_unnamed_323, 0.0f);
					fragment_unnamed_323 = (-fragment_unnamed_280) + fragment_unnamed_323;
					fragment_unnamed_323 = (_MainTex_TexelSize.y * 2.0f) + fragment_unnamed_323;
					fragment_unnamed_323 /= fragment_unnamed_32;
					fragment_unnamed_323 = clamp(fragment_unnamed_323, 0.0f, 1.0f);
					fragment_unnamed_280 = (-fragment_unnamed_280) + (-fragment_unnamed_73.w);
					fragment_unnamed_280 = (_MainTex_TexelSize.y * 2.0f) + fragment_unnamed_280;
					fragment_unnamed_280 /= fragment_unnamed_32;
					fragment_unnamed_280 = clamp(fragment_unnamed_280, 0.0f, 1.0f);
					fragment_unnamed_363 = (-fragment_unnamed_73.w) >= _MainTex_TexelSize.y;
					fragment_unnamed_370 = float(fragment_unnamed_363);
					fragment_unnamed_280 *= fragment_unnamed_370;
					fragment_unnamed_46 = float4(fragment_unnamed_73.xyz.x, fragment_unnamed_73.xyz.y, fragment_unnamed_73.xyz.z, fragment_unnamed_46.w);
					fragment_unnamed_49 = (fragment_unnamed_46 * fragment_unnamed_323.xxxx) + fragment_unnamed_49;
					fragment_unnamed_56 = (fragment_unnamed_46 * fragment_unnamed_280.xxxx) + fragment_unnamed_56;
				}
				fragment_unnamed_394 = fragment_unnamed_49.w == 0.0f;
				fragment_unnamed_9.x = float(fragment_unnamed_394);
				fragment_unnamed_9.x += fragment_unnamed_49.w;
				fragment_unnamed_9 = fragment_unnamed_49.xyz / fragment_unnamed_9.xxx;
				fragment_unnamed_412 = fragment_unnamed_56.w == 0.0f;
				fragment_unnamed_280 = float(fragment_unnamed_412);
				fragment_unnamed_280 += fragment_unnamed_56.w;
				float3 fragment_unnamed_426 = fragment_unnamed_56.xyz / fragment_unnamed_280.xxx;
				fragment_unnamed_46 = float4(fragment_unnamed_426.x, fragment_unnamed_426.y, fragment_unnamed_426.z, fragment_unnamed_46.w);
				fragment_unnamed_280 = fragment_unnamed_56.w * 0.044247783720493316650390625f;
				fragment_unnamed_280 = min(fragment_unnamed_280, 1.0f);
				float3 fragment_unnamed_439 = (-fragment_unnamed_9) + fragment_unnamed_46.xyz;
				fragment_unnamed_46 = float4(fragment_unnamed_439.x, fragment_unnamed_439.y, fragment_unnamed_439.z, fragment_unnamed_46.w);
				float3 fragment_unnamed_450 = (fragment_unnamed_280.xxx * fragment_unnamed_46.xyz) + fragment_unnamed_9;
				fragment_output_0 = float4(fragment_unnamed_450.x, fragment_unnamed_450.y, fragment_unnamed_450.z, fragment_output_0.w);
				fragment_output_0.w = fragment_unnamed_280;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_0 = stage_input.fragment_input_0;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			float _RenderViewportScaleFactor;
			float4 _MainTex_TexelSize;
			float _MaxCoC;
			float _RcpAspect;

			static float4 fragment_uniform_buffer_0[32];
			static const float fragment_unnamed_140[284] = { 0.0f, 0.0f, 0.0f, 0.0f, 0.27586209774017333984375f, 0.0f, 0.0f, 0.0f, 0.17199720442295074462890625f, 0.215677678585052490234375f, 0.0f, 0.0f, -0.061385095119476318359375f, 0.2689456641674041748046875f, 0.0f, 0.0f, -0.24854315817356109619140625f, 0.11969210207462310791015625f, 0.0f, 0.0f, -0.24854315817356109619140625f, -0.119692079722881317138671875f, 0.0f, 0.0f, -0.061384983360767364501953125f, -0.2689456939697265625f, 0.0f, 0.0f, 0.17199717462062835693359375f, -0.2156777083873748779296875f, 0.0f, 0.0f, 0.51724135875701904296875f, 0.0f, 0.0f, 0.0f, 0.4660183489322662353515625f, 0.22442261874675750732421875f, 0.0f, 0.0f, 0.3224947154521942138671875f, 0.404395580291748046875f, 0.0f, 0.0f, 0.115097053349018096923828125f, 0.50427305698394775390625f, 0.0f, 0.0f, -0.115097038447856903076171875f, 0.50427305698394775390625f, 0.0f, 0.0f, -0.322494804859161376953125f, 0.404395520687103271484375f, 0.0f, 0.0f, -0.4660183489322662353515625f, 0.22442264854907989501953125f, 0.0f, 0.0f, -0.51724135875701904296875f, 0.0f, 0.0f, 0.0f, -0.4660183489322662353515625f, -0.22442261874675750732421875f, 0.0f, 0.0f, -0.32249462604522705078125f, -0.404395639896392822265625f, 0.0f, 0.0f, -0.115096829831600189208984375f, -0.504273116588592529296875f, 0.0f, 0.0f, 0.115097321569919586181640625f, -0.504272997379302978515625f, 0.0f, 0.0f, 0.3224946558475494384765625f, -0.404395639896392822265625f, 0.0f, 0.0f, 0.4660183489322662353515625f, -0.22442261874675750732421875f, 0.0f, 0.0f, 0.758620679378509521484375f, 0.0f, 0.0f, 0.0f, 0.72491729259490966796875f, 0.22360737621784210205078125f, 0.0f, 0.0f, 0.626801788806915283203125f, 0.427346289157867431640625f, 0.0f, 0.0f, 0.472992241382598876953125f, 0.59311354160308837890625f, 0.0f, 0.0f, 0.277155220508575439453125f, 0.706180095672607421875f, 0.0f, 0.0f, 0.0566917248070240020751953125f, 0.756499469280242919921875f, 0.0f, 0.0f, -0.168808996677398681640625f, 0.739600479602813720703125f, 0.0f, 0.0f, -0.3793103992938995361328125f, 0.656984746456146240234375f, 0.0f, 0.0f, -0.55610835552215576171875f, 0.515993058681488037109375f, 0.0f, 0.0f, -0.68349361419677734375f, 0.329153239727020263671875f, 0.0f, 0.0f, -0.750147521495819091796875f, 0.1130664050579071044921875f, 0.0f, 0.0f, -0.750147521495819091796875f, -0.113066710531711578369140625f, 0.0f, 0.0f, -0.68349361419677734375f, -0.32915318012237548828125f, 0.0f, 0.0f, -0.556108295917510986328125f, -0.515993177890777587890625f, 0.0f, 0.0f, -0.3793102800846099853515625f, -0.656984806060791015625f, 0.0f, 0.0f, -0.16880904138088226318359375f, -0.739600479602813720703125f, 0.0f, 0.0f, 0.056691944599151611328125f, -0.75649940967559814453125f, 0.0f, 0.0f, 0.2771556079387664794921875f, -0.706179916858673095703125f, 0.0f, 0.0f, 0.4729921519756317138671875f, -0.5931136608123779296875f, 0.0f, 0.0f, 0.62680184841156005859375f, -0.4273461997509002685546875f, 0.0f, 0.0f, 0.724917352199554443359375f, -0.22360710799694061279296875f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.9749279022216796875f, 0.22252093255519866943359375f, 0.0f, 0.0f, 0.900968849658966064453125f, 0.4338837563991546630859375f, 0.0f, 0.0f, 0.7818315029144287109375f, 0.623489797115325927734375f, 0.0f, 0.0f, 0.623489797115325927734375f, 0.7818315029144287109375f, 0.0f, 0.0f, 0.4338836371898651123046875f, 0.90096890926361083984375f, 0.0f, 0.0f, 0.2225209772586822509765625f, 0.9749279022216796875f, 0.0f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f, -0.22252094745635986328125f, 0.9749279022216796875f, 0.0f, 0.0f, -0.433883845806121826171875f, 0.900968849658966064453125f, 0.0f, 0.0f, -0.62348997592926025390625f, 0.78183138370513916015625f, 0.0f, 0.0f, -0.781831681728363037109375f, 0.623489558696746826171875f, 0.0f, 0.0f, -0.900968849658966064453125f, 0.4338838160037994384765625f, 0.0f, 0.0f, -0.9749279022216796875f, 0.22252093255519866943359375f, 0.0f, 0.0f, -1.0f, 0.0f, 0.0f, 0.0f, -0.9749279022216796875f, -0.22252087295055389404296875f, 0.0f, 0.0f, -0.900968849658966064453125f, -0.4338837563991546630859375f, 0.0f, 0.0f, -0.78183138370513916015625f, -0.623489916324615478515625f, 0.0f, 0.0f, -0.6234896183013916015625f, -0.78183162212371826171875f, 0.0f, 0.0f, -0.4338834583759307861328125f, -0.900969028472900390625f, 0.0f, 0.0f, -0.22252054512500762939453125f, -0.97492802143096923828125f, 0.0f, 0.0f, 0.0f, -1.0f, 0.0f, 0.0f, 0.22252149879932403564453125f, -0.97492778301239013671875f, 0.0f, 0.0f, 0.433883488178253173828125f, -0.900968968868255615234375f, 0.0f, 0.0f, 0.623489677906036376953125f, -0.78183162212371826171875f, 0.0f, 0.0f, 0.781831443309783935546875f, -0.623489856719970703125f, 0.0f, 0.0f, 0.900968849658966064453125f, -0.4338837563991546630859375f, 0.0f, 0.0f, 0.9749279022216796875f, -0.2225208580493927001953125f, 0.0f, 0.0f };

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
				float4 fragment_unnamed_154 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				float fragment_unnamed_156 = fragment_unnamed_154.w;
				precise float fragment_unnamed_165 = fragment_uniform_buffer_0[28u].y + fragment_uniform_buffer_0[28u].y;
				float fragment_unnamed_166 = asfloat(1065353216u);
				float fragment_unnamed_176;
				float fragment_unnamed_178;
				float fragment_unnamed_180;
				float fragment_unnamed_182;
				float fragment_unnamed_184;
				float fragment_unnamed_186;
				float fragment_unnamed_188;
				float fragment_unnamed_190;
				fragment_unnamed_176 = asfloat(0u);
				fragment_unnamed_178 = asfloat(0u);
				fragment_unnamed_180 = asfloat(0u);
				fragment_unnamed_182 = asfloat(0u);
				fragment_unnamed_184 = asfloat(0u);
				fragment_unnamed_186 = asfloat(0u);
				fragment_unnamed_188 = asfloat(0u);
				fragment_unnamed_190 = asfloat(0u);
				precise float fragment_unnamed_249;
				precise float fragment_unnamed_250;
				float fragment_unnamed_254;
				precise float fragment_unnamed_259;
				precise float fragment_unnamed_264;
				precise float fragment_unnamed_265;
				precise float fragment_unnamed_272;
				precise float fragment_unnamed_273;
				float4 fragment_unnamed_275;
				float fragment_unnamed_277;
				float fragment_unnamed_278;
				float fragment_unnamed_279;
				float fragment_unnamed_280;
				precise float fragment_unnamed_283;
				precise float fragment_unnamed_284;
				precise float fragment_unnamed_290;
				float fragment_unnamed_291;
				precise float fragment_unnamed_292;
				precise float fragment_unnamed_293;
				precise float fragment_unnamed_294;
				precise float fragment_unnamed_299;
				precise float fragment_unnamed_301;
				precise float fragment_unnamed_309;
				for (uint fragment_unnamed_192 = 0u; !(int(fragment_unnamed_192) >= int(71u)); fragment_unnamed_249 = fragment_uniform_buffer_0[30u].z * fragment_unnamed_140[(fragment_unnamed_192 * 4u) + 0u], fragment_unnamed_250 = fragment_uniform_buffer_0[30u].z * fragment_unnamed_140[(fragment_unnamed_192 * 4u) + 1u], fragment_unnamed_254 = sqrt(dot(float2(fragment_unnamed_249, fragment_unnamed_250), float2(fragment_unnamed_249, fragment_unnamed_250))), fragment_unnamed_259 = fragment_unnamed_249 * fragment_uniform_buffer_0[31u].x, fragment_unnamed_264 = fragment_unnamed_259 + fragment_input_1.x, fragment_unnamed_265 = fragment_unnamed_250 + fragment_input_1.y, fragment_unnamed_272 = clamp(fragment_unnamed_264, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, fragment_unnamed_273 = clamp(fragment_unnamed_265, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, fragment_unnamed_275 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_272, fragment_unnamed_273)), fragment_unnamed_277 = fragment_unnamed_275.x, fragment_unnamed_278 = fragment_unnamed_275.y, fragment_unnamed_279 = fragment_unnamed_275.z, fragment_unnamed_280 = fragment_unnamed_275.w, fragment_unnamed_283 = (-0.0f) - fragment_unnamed_254, fragment_unnamed_284 = fragment_unnamed_283 + max(min(fragment_unnamed_156, fragment_unnamed_280), 0.0f), fragment_unnamed_290 = mad(fragment_uniform_buffer_0[28u].y, 2.0f, fragment_unnamed_284) / fragment_unnamed_165, fragment_unnamed_291 = clamp(fragment_unnamed_290, 0.0f, 1.0f), fragment_unnamed_292 = (-0.0f) - fragment_unnamed_254, fragment_unnamed_293 = (-0.0f) - fragment_unnamed_280, fragment_unnamed_294 = fragment_unnamed_292 + fragment_unnamed_293, fragment_unnamed_299 = mad(fragment_uniform_buffer_0[28u].y, 2.0f, fragment_unnamed_294) / fragment_unnamed_165, fragment_unnamed_301 = (-0.0f) - fragment_unnamed_280, fragment_unnamed_309 = clamp(fragment_unnamed_299, 0.0f, 1.0f) * asfloat(((fragment_unnamed_301 >= fragment_uniform_buffer_0[28u].y) ? 4294967295u : 0u) & 1065353216u), fragment_unnamed_176 = mad(fragment_unnamed_278, fragment_unnamed_291, fragment_unnamed_176), fragment_unnamed_178 = mad(fragment_unnamed_279, fragment_unnamed_291, fragment_unnamed_178), fragment_unnamed_180 = mad(fragment_unnamed_166, fragment_unnamed_291, fragment_unnamed_180), fragment_unnamed_182 = mad(fragment_unnamed_277, fragment_unnamed_309, fragment_unnamed_182), fragment_unnamed_184 = mad(fragment_unnamed_278, fragment_unnamed_309, fragment_unnamed_184), fragment_unnamed_186 = mad(fragment_unnamed_279, fragment_unnamed_309, fragment_unnamed_186), fragment_unnamed_188 = mad(fragment_unnamed_166, fragment_unnamed_309, fragment_unnamed_188), fragment_unnamed_190 = mad(fragment_unnamed_277, fragment_unnamed_291, fragment_unnamed_190), fragment_unnamed_192++)
				{
				}
				precise float fragment_unnamed_202 = asfloat(((fragment_unnamed_180 == 0.0f) ? 4294967295u : 0u) & 1065353216u) + fragment_unnamed_180;
				precise float fragment_unnamed_203 = fragment_unnamed_190 / fragment_unnamed_202;
				precise float fragment_unnamed_204 = fragment_unnamed_176 / fragment_unnamed_202;
				precise float fragment_unnamed_205 = fragment_unnamed_178 / fragment_unnamed_202;
				precise float fragment_unnamed_210 = asfloat(((fragment_unnamed_188 == 0.0f) ? 4294967295u : 0u) & 1065353216u) + fragment_unnamed_188;
				precise float fragment_unnamed_211 = fragment_unnamed_182 / fragment_unnamed_210;
				precise float fragment_unnamed_212 = fragment_unnamed_184 / fragment_unnamed_210;
				precise float fragment_unnamed_213 = fragment_unnamed_186 / fragment_unnamed_210;
				precise float fragment_unnamed_214 = fragment_unnamed_188 * 0.044247783720493316650390625f;
				float fragment_unnamed_217 = min(fragment_unnamed_214, 1.0f);
				precise float fragment_unnamed_218 = (-0.0f) - fragment_unnamed_203;
				precise float fragment_unnamed_220 = (-0.0f) - fragment_unnamed_204;
				precise float fragment_unnamed_221 = (-0.0f) - fragment_unnamed_205;
				precise float fragment_unnamed_222 = fragment_unnamed_218 + fragment_unnamed_211;
				precise float fragment_unnamed_223 = fragment_unnamed_220 + fragment_unnamed_212;
				precise float fragment_unnamed_224 = fragment_unnamed_221 + fragment_unnamed_213;
				fragment_output_0.x = mad(fragment_unnamed_217, fragment_unnamed_222, fragment_unnamed_203);
				fragment_output_0.y = mad(fragment_unnamed_217, fragment_unnamed_223, fragment_unnamed_204);
				fragment_output_0.z = mad(fragment_unnamed_217, fragment_unnamed_224, fragment_unnamed_205);
				fragment_output_0.w = fragment_unnamed_217;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, fragment_uniform_buffer_0[26][1], fragment_uniform_buffer_0[26][2], fragment_uniform_buffer_0[26][3]);

				fragment_uniform_buffer_0[28] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				fragment_uniform_buffer_0[30] = float4(fragment_uniform_buffer_0[30][0], fragment_uniform_buffer_0[30][1], _MaxCoC, fragment_uniform_buffer_0[30][3]);

				fragment_uniform_buffer_0[31] = float4(_RcpAspect, fragment_uniform_buffer_0[31][1], fragment_uniform_buffer_0[31][2], fragment_uniform_buffer_0[31][3]);

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
			Name "Postfilter"
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 473214

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
			static float4 fragment_unnamed_43;
			static float4 fragment_unnamed_83;

			void frag_main()
			{
				fragment_unnamed_9 = ((-_MainTex_TexelSize.xyxy) * float4(0.5f, 0.5f, -0.5f, 0.5f)) + fragment_input_0.xyxy;
				fragment_unnamed_9 = clamp(fragment_unnamed_9, 0.0f.xxxx, 1.0f.xxxx);
				fragment_unnamed_9 *= _RenderViewportScaleFactor.xxxx;
				fragment_unnamed_43 = _MainTex.Sample(sampler_MainTex, fragment_unnamed_9.xy);
				fragment_unnamed_9 = _MainTex.Sample(sampler_MainTex, fragment_unnamed_9.zw);
				fragment_unnamed_9 += fragment_unnamed_43;
				fragment_unnamed_43 = (_MainTex_TexelSize.xyxy * float4(-0.5f, 0.5f, 0.5f, 0.5f)) + fragment_input_0.xyxy;
				fragment_unnamed_43 = clamp(fragment_unnamed_43, 0.0f.xxxx, 1.0f.xxxx);
				fragment_unnamed_43 *= _RenderViewportScaleFactor.xxxx;
				fragment_unnamed_83 = _MainTex.Sample(sampler_MainTex, fragment_unnamed_43.xy);
				fragment_unnamed_43 = _MainTex.Sample(sampler_MainTex, fragment_unnamed_43.zw);
				fragment_unnamed_9 += fragment_unnamed_83;
				fragment_unnamed_9 = fragment_unnamed_43 + fragment_unnamed_9;
				fragment_output_0 = fragment_unnamed_9 * 0.25f.xxxx;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_0 = stage_input.fragment_input_0;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			float _RenderViewportScaleFactor;
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
				precise float fragment_unnamed_35 = (-0.0f) - fragment_uniform_buffer_0[28u].x;
				precise float fragment_unnamed_38 = (-0.0f) - fragment_uniform_buffer_0[28u].y;
				precise float fragment_unnamed_62 = clamp(mad(fragment_unnamed_35, 0.5f, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_63 = clamp(mad(fragment_unnamed_38, 0.5f, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_64 = clamp(mad(fragment_unnamed_35, -0.5f, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_65 = clamp(mad(fragment_unnamed_38, 0.5f, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_68 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_62, fragment_unnamed_63));
				float4 fragment_unnamed_74 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_64, fragment_unnamed_65));
				precise float fragment_unnamed_80 = fragment_unnamed_74.x + fragment_unnamed_68.x;
				precise float fragment_unnamed_81 = fragment_unnamed_74.y + fragment_unnamed_68.y;
				precise float fragment_unnamed_82 = fragment_unnamed_74.z + fragment_unnamed_68.z;
				precise float fragment_unnamed_83 = fragment_unnamed_74.w + fragment_unnamed_68.w;
				precise float fragment_unnamed_103 = clamp(mad(fragment_uniform_buffer_0[28u].x, -0.5f, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_104 = clamp(mad(fragment_uniform_buffer_0[28u].y, 0.5f, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_105 = clamp(mad(fragment_uniform_buffer_0[28u].x, 0.5f, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_106 = clamp(mad(fragment_uniform_buffer_0[28u].y, 0.5f, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_107 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_103, fragment_unnamed_104));
				float4 fragment_unnamed_113 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_105, fragment_unnamed_106));
				precise float fragment_unnamed_119 = fragment_unnamed_80 + fragment_unnamed_107.x;
				precise float fragment_unnamed_120 = fragment_unnamed_81 + fragment_unnamed_107.y;
				precise float fragment_unnamed_121 = fragment_unnamed_82 + fragment_unnamed_107.z;
				precise float fragment_unnamed_122 = fragment_unnamed_83 + fragment_unnamed_107.w;
				precise float fragment_unnamed_123 = fragment_unnamed_113.x + fragment_unnamed_119;
				precise float fragment_unnamed_124 = fragment_unnamed_113.y + fragment_unnamed_120;
				precise float fragment_unnamed_125 = fragment_unnamed_113.z + fragment_unnamed_121;
				precise float fragment_unnamed_126 = fragment_unnamed_113.w + fragment_unnamed_122;
				precise float fragment_unnamed_127 = fragment_unnamed_123 * 0.25f;
				precise float fragment_unnamed_129 = fragment_unnamed_124 * 0.25f;
				precise float fragment_unnamed_130 = fragment_unnamed_125 * 0.25f;
				precise float fragment_unnamed_131 = fragment_unnamed_126 * 0.25f;
				fragment_output_0.x = fragment_unnamed_127;
				fragment_output_0.y = fragment_unnamed_129;
				fragment_output_0.z = fragment_unnamed_130;
				fragment_output_0.w = fragment_unnamed_131;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, fragment_uniform_buffer_0[26][1], fragment_uniform_buffer_0[26][2], fragment_uniform_buffer_0[26][3]);

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
			Name "Combine"
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 581092

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

			float4 _MainTex_TexelSize;
			float _MaxCoC;

			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;
			Texture2D<float4> _CoCTex;
			SamplerState sampler_CoCTex;
			Texture2D<float4> _DepthOfFieldTex;
			SamplerState sampler_DepthOfFieldTex;

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
			static float3 fragment_unnamed_27;
			static float4 fragment_unnamed_50;
			static bool3 fragment_unnamed_61;
			static float fragment_unnamed_133;
			static float fragment_unnamed_179;
			static bool3 fragment_unnamed_255;

			void frag_main()
			{
				fragment_unnamed_9 = _MainTex.Sample(sampler_MainTex, fragment_input_0);
				fragment_unnamed_27 = fragment_unnamed_9.xyz + 0.054999999701976776123046875f.xxx;
				fragment_unnamed_27 *= 0.947867333889007568359375f.xxx;
				fragment_unnamed_27 = max(abs(fragment_unnamed_27), 1.1920928955078125e-07f.xxx);
				fragment_unnamed_27 = log2(fragment_unnamed_27);
				fragment_unnamed_27 *= 2.400000095367431640625f.xxx;
				fragment_unnamed_27 = exp2(fragment_unnamed_27);
				float3 fragment_unnamed_55 = fragment_unnamed_9.xyz * 0.077399380505084991455078125f.xxx;
				fragment_unnamed_50 = float4(fragment_unnamed_55.x, fragment_unnamed_55.y, fragment_unnamed_55.z, fragment_unnamed_50.w);
				fragment_unnamed_61 = bool4(float4(0.040449999272823333740234375f, 0.040449999272823333740234375f, 0.040449999272823333740234375f, 0.0f).x >= fragment_unnamed_9.xyzx.x, float4(0.040449999272823333740234375f, 0.040449999272823333740234375f, 0.040449999272823333740234375f, 0.0f).y >= fragment_unnamed_9.xyzx.y, float4(0.040449999272823333740234375f, 0.040449999272823333740234375f, 0.040449999272823333740234375f, 0.0f).z >= fragment_unnamed_9.xyzx.z, float4(0.040449999272823333740234375f, 0.040449999272823333740234375f, 0.040449999272823333740234375f, 0.0f).w >= fragment_unnamed_9.xyzx.w).xyz;
				float fragment_unnamed_76;
				if (fragment_unnamed_61.x)
				{
					fragment_unnamed_76 = fragment_unnamed_50.x;
				}
				else
				{
					fragment_unnamed_76 = fragment_unnamed_27.x;
				}
				fragment_unnamed_9.x = fragment_unnamed_76;
				float fragment_unnamed_90;
				if (fragment_unnamed_61.y)
				{
					fragment_unnamed_90 = fragment_unnamed_50.y;
				}
				else
				{
					fragment_unnamed_90 = fragment_unnamed_27.y;
				}
				fragment_unnamed_9.y = fragment_unnamed_90;
				float fragment_unnamed_103;
				if (fragment_unnamed_61.z)
				{
					fragment_unnamed_103 = fragment_unnamed_50.z;
				}
				else
				{
					fragment_unnamed_103 = fragment_unnamed_27.z;
				}
				fragment_unnamed_9.z = fragment_unnamed_103;
				fragment_unnamed_27.x = _CoCTex.Sample(sampler_CoCTex, fragment_input_0).x;
				fragment_unnamed_27.x += (-0.5f);
				fragment_unnamed_27.x += fragment_unnamed_27.x;
				fragment_unnamed_133 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
				fragment_unnamed_27.x = (fragment_unnamed_27.x * _MaxCoC) + (-fragment_unnamed_133);
				fragment_unnamed_133 = 1.0f / fragment_unnamed_133;
				fragment_unnamed_27.x = fragment_unnamed_133 * fragment_unnamed_27.x;
				fragment_unnamed_27.x = clamp(fragment_unnamed_27.x, 0.0f, 1.0f);
				fragment_unnamed_133 = (fragment_unnamed_27.x * (-2.0f)) + 3.0f;
				fragment_unnamed_27.x *= fragment_unnamed_27.x;
				fragment_unnamed_179 = fragment_unnamed_27.x * fragment_unnamed_133;
				fragment_unnamed_50 = _DepthOfFieldTex.Sample(sampler_DepthOfFieldTex, fragment_input_0);
				fragment_unnamed_27.x = (fragment_unnamed_133 * fragment_unnamed_27.x) + fragment_unnamed_50.w;
				fragment_unnamed_27.x = ((-fragment_unnamed_179) * fragment_unnamed_50.w) + fragment_unnamed_27.x;
				fragment_unnamed_133 = max(fragment_unnamed_50.y, fragment_unnamed_50.x);
				fragment_unnamed_50.w = max(fragment_unnamed_50.z, fragment_unnamed_133);
				fragment_unnamed_50 = (-fragment_unnamed_9) + fragment_unnamed_50;
				fragment_unnamed_9 = (fragment_unnamed_27.xxxx * fragment_unnamed_50) + fragment_unnamed_9;
				fragment_unnamed_27 = max(abs(fragment_unnamed_9.xyz), 1.1920928955078125e-07f.xxx);
				fragment_unnamed_27 = log2(fragment_unnamed_27);
				fragment_unnamed_27 *= 0.4166666567325592041015625f.xxx;
				fragment_unnamed_27 = exp2(fragment_unnamed_27);
				fragment_unnamed_27 = (fragment_unnamed_27 * 1.05499994754791259765625f.xxx) + (-0.054999999701976776123046875f).xxx;
				float3 fragment_unnamed_252 = fragment_unnamed_9.xyz * 12.9200000762939453125f.xxx;
				fragment_unnamed_50 = float4(fragment_unnamed_252.x, fragment_unnamed_252.y, fragment_unnamed_252.z, fragment_unnamed_50.w);
				fragment_unnamed_255 = bool4(float4(0.003130800090730190277099609375f, 0.003130800090730190277099609375f, 0.003130800090730190277099609375f, 0.0f).x >= fragment_unnamed_9.xyzx.x, float4(0.003130800090730190277099609375f, 0.003130800090730190277099609375f, 0.003130800090730190277099609375f, 0.0f).y >= fragment_unnamed_9.xyzx.y, float4(0.003130800090730190277099609375f, 0.003130800090730190277099609375f, 0.003130800090730190277099609375f, 0.0f).z >= fragment_unnamed_9.xyzx.z, float4(0.003130800090730190277099609375f, 0.003130800090730190277099609375f, 0.003130800090730190277099609375f, 0.0f).w >= fragment_unnamed_9.xyzx.w).xyz;
				fragment_output_0.w = fragment_unnamed_9.w;
				float fragment_unnamed_270;
				if (fragment_unnamed_255.x)
				{
					fragment_unnamed_270 = fragment_unnamed_50.x;
				}
				else
				{
					fragment_unnamed_270 = fragment_unnamed_27.x;
				}
				fragment_output_0.x = fragment_unnamed_270;
				float fragment_unnamed_282;
				if (fragment_unnamed_255.y)
				{
					fragment_unnamed_282 = fragment_unnamed_50.y;
				}
				else
				{
					fragment_unnamed_282 = fragment_unnamed_27.y;
				}
				fragment_output_0.y = fragment_unnamed_282;
				float fragment_unnamed_294;
				if (fragment_unnamed_255.z)
				{
					fragment_unnamed_294 = fragment_unnamed_50.z;
				}
				else
				{
					fragment_unnamed_294 = fragment_unnamed_27.z;
				}
				fragment_output_0.z = fragment_unnamed_294;
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
			float _MaxCoC;

			static float4 fragment_uniform_buffer_0[31];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _CoCTex;
			Texture2D<float4> _DepthOfFieldTex;
			SamplerState sampler_MainTex;
			SamplerState sampler_CoCTex;
			SamplerState sampler_DepthOfFieldTex;

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
				precise float fragment_unnamed_53 = fragment_unnamed_49 + 0.054999999701976776123046875f;
				precise float fragment_unnamed_55 = fragment_unnamed_50 + 0.054999999701976776123046875f;
				precise float fragment_unnamed_56 = fragment_unnamed_51 + 0.054999999701976776123046875f;
				precise float fragment_unnamed_57 = fragment_unnamed_53 * 0.947867333889007568359375f;
				precise float fragment_unnamed_59 = fragment_unnamed_55 * 0.947867333889007568359375f;
				precise float fragment_unnamed_60 = fragment_unnamed_56 * 0.947867333889007568359375f;
				precise float fragment_unnamed_72 = log2(max(abs(fragment_unnamed_57), 1.1920928955078125e-07f)) * 2.400000095367431640625f;
				precise float fragment_unnamed_74 = log2(max(abs(fragment_unnamed_59), 1.1920928955078125e-07f)) * 2.400000095367431640625f;
				precise float fragment_unnamed_75 = log2(max(abs(fragment_unnamed_60), 1.1920928955078125e-07f)) * 2.400000095367431640625f;
				precise float fragment_unnamed_79 = fragment_unnamed_49 * 0.077399380505084991455078125f;
				precise float fragment_unnamed_81 = fragment_unnamed_50 * 0.077399380505084991455078125f;
				precise float fragment_unnamed_82 = fragment_unnamed_51 * 0.077399380505084991455078125f;
				float fragment_unnamed_95 = asfloat((0.040449999272823333740234375f >= fragment_unnamed_49) ? asuint(fragment_unnamed_79) : asuint(exp2(fragment_unnamed_72)));
				float fragment_unnamed_97 = asfloat((0.040449999272823333740234375f >= fragment_unnamed_50) ? asuint(fragment_unnamed_81) : asuint(exp2(fragment_unnamed_74)));
				float fragment_unnamed_99 = asfloat((0.040449999272823333740234375f >= fragment_unnamed_51) ? asuint(fragment_unnamed_82) : asuint(exp2(fragment_unnamed_75)));
				precise float fragment_unnamed_108 = _CoCTex.Sample(sampler_CoCTex, float2(fragment_input_1.x, fragment_input_1.y)).x + (-0.5f);
				precise float fragment_unnamed_110 = fragment_unnamed_108 + fragment_unnamed_108;
				precise float fragment_unnamed_119 = fragment_uniform_buffer_0[28u].y + fragment_uniform_buffer_0[28u].y;
				precise float fragment_unnamed_124 = (-0.0f) - fragment_unnamed_119;
				precise float fragment_unnamed_127 = 1.0f / fragment_unnamed_119;
				precise float fragment_unnamed_129 = fragment_unnamed_127 * mad(fragment_unnamed_110, fragment_uniform_buffer_0[30u].z, fragment_unnamed_124);
				float fragment_unnamed_130 = clamp(fragment_unnamed_129, 0.0f, 1.0f);
				float fragment_unnamed_131 = mad(fragment_unnamed_130, -2.0f, 3.0f);
				precise float fragment_unnamed_134 = fragment_unnamed_130 * fragment_unnamed_130;
				precise float fragment_unnamed_135 = fragment_unnamed_134 * fragment_unnamed_131;
				float4 fragment_unnamed_141 = _DepthOfFieldTex.Sample(sampler_DepthOfFieldTex, float2(fragment_input_1.x, fragment_input_1.y));
				float fragment_unnamed_143 = fragment_unnamed_141.x;
				float fragment_unnamed_144 = fragment_unnamed_141.y;
				float fragment_unnamed_145 = fragment_unnamed_141.z;
				float fragment_unnamed_146 = fragment_unnamed_141.w;
				precise float fragment_unnamed_148 = (-0.0f) - fragment_unnamed_135;
				float fragment_unnamed_149 = mad(fragment_unnamed_148, fragment_unnamed_146, mad(fragment_unnamed_131, fragment_unnamed_134, fragment_unnamed_146));
				precise float fragment_unnamed_152 = (-0.0f) - fragment_unnamed_95;
				precise float fragment_unnamed_153 = (-0.0f) - fragment_unnamed_97;
				precise float fragment_unnamed_154 = (-0.0f) - fragment_unnamed_99;
				precise float fragment_unnamed_155 = (-0.0f) - fragment_unnamed_52;
				precise float fragment_unnamed_156 = fragment_unnamed_152 + fragment_unnamed_143;
				precise float fragment_unnamed_157 = fragment_unnamed_153 + fragment_unnamed_144;
				precise float fragment_unnamed_158 = fragment_unnamed_154 + fragment_unnamed_145;
				precise float fragment_unnamed_159 = fragment_unnamed_155 + max(fragment_unnamed_145, max(fragment_unnamed_144, fragment_unnamed_143));
				float fragment_unnamed_160 = mad(fragment_unnamed_149, fragment_unnamed_156, fragment_unnamed_95);
				float fragment_unnamed_161 = mad(fragment_unnamed_149, fragment_unnamed_157, fragment_unnamed_97);
				float fragment_unnamed_162 = mad(fragment_unnamed_149, fragment_unnamed_158, fragment_unnamed_99);
				precise float fragment_unnamed_173 = log2(max(abs(fragment_unnamed_160), 1.1920928955078125e-07f)) * 0.4166666567325592041015625f;
				precise float fragment_unnamed_175 = log2(max(abs(fragment_unnamed_161), 1.1920928955078125e-07f)) * 0.4166666567325592041015625f;
				precise float fragment_unnamed_176 = log2(max(abs(fragment_unnamed_162), 1.1920928955078125e-07f)) * 0.4166666567325592041015625f;
				precise float fragment_unnamed_185 = fragment_unnamed_160 * 12.9200000762939453125f;
				precise float fragment_unnamed_187 = fragment_unnamed_161 * 12.9200000762939453125f;
				precise float fragment_unnamed_188 = fragment_unnamed_162 * 12.9200000762939453125f;
				fragment_output_0.w = mad(fragment_unnamed_149, fragment_unnamed_159, fragment_unnamed_52);
				fragment_output_0.x = (0.003130800090730190277099609375f >= fragment_unnamed_160) ? fragment_unnamed_185 : mad(exp2(fragment_unnamed_173), 1.05499994754791259765625f, -0.054999999701976776123046875f);
				fragment_output_0.y = (0.003130800090730190277099609375f >= fragment_unnamed_161) ? fragment_unnamed_187 : mad(exp2(fragment_unnamed_175), 1.05499994754791259765625f, -0.054999999701976776123046875f);
				fragment_output_0.z = (0.003130800090730190277099609375f >= fragment_unnamed_162) ? fragment_unnamed_188 : mad(exp2(fragment_unnamed_176), 1.05499994754791259765625f, -0.054999999701976776123046875f);
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[28] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				fragment_uniform_buffer_0[30] = float4(fragment_uniform_buffer_0[30][0], fragment_uniform_buffer_0[30][1], _MaxCoC, fragment_uniform_buffer_0[30][3]);

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
			Name "Debug Overlay"
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 608515

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

			float4 _ZBufferParams;
			float _Distance;
			float _LensCoeff;

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

			static float4 fragment_unnamed_9;
			static float fragment_unnamed_52;
			static float3 fragment_unnamed_98;
			static float fragment_unnamed_122;

			void frag_main()
			{
				fragment_unnamed_9.x = _CameraDepthTexture.Sample(sampler_CameraDepthTexture, fragment_input_0).x;
				fragment_unnamed_9.x = (_ZBufferParams.z * fragment_unnamed_9.x) + _ZBufferParams.w;
				fragment_unnamed_9.x = 1.0f / fragment_unnamed_9.x;
				fragment_unnamed_52 = fragment_unnamed_9.x + (-_Distance);
				fragment_unnamed_52 *= _LensCoeff;
				fragment_unnamed_9.x = fragment_unnamed_52 / fragment_unnamed_9.x;
				fragment_unnamed_9.x *= 80.0f;
				fragment_unnamed_52 = fragment_unnamed_9.x;
				fragment_unnamed_52 = clamp(fragment_unnamed_52, 0.0f, 1.0f);
				fragment_unnamed_9.x = -fragment_unnamed_9.x;
				fragment_unnamed_9.x = clamp(fragment_unnamed_9.x, 0.0f, 1.0f);
				float3 fragment_unnamed_94 = (fragment_unnamed_9.xxx * float3(0.0f, 1.0f, 1.0f)) + float3(1.0f, 0.0f, 0.0f);
				fragment_unnamed_9 = float4(fragment_unnamed_94.x, fragment_unnamed_9.y, fragment_unnamed_94.y, fragment_unnamed_94.z);
				fragment_unnamed_98 = (-fragment_unnamed_9.xww) + 0.4000000059604644775390625f.xxx;
				float3 fragment_unnamed_111 = (fragment_unnamed_52.xxx * fragment_unnamed_98) + fragment_unnamed_9.xzw;
				fragment_unnamed_9 = float4(fragment_unnamed_111.x, fragment_unnamed_111.y, fragment_unnamed_111.z, fragment_unnamed_9.w);
				fragment_unnamed_98 = _MainTex.Sample(sampler_MainTex, fragment_input_0).xyz;
				fragment_unnamed_122 = dot(fragment_unnamed_98, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f));
				fragment_unnamed_122 += 0.5f;
				float3 fragment_unnamed_138 = fragment_unnamed_122.xxx * fragment_unnamed_9.xyz;
				fragment_output_0 = float4(fragment_unnamed_138.x, fragment_unnamed_138.y, fragment_unnamed_138.z, fragment_output_0.w);
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


			float4 _ZBufferParams;
			float _Distance;
			float _LensCoeff;

			static float4 fragment_uniform_buffer_0[31];
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
				precise float fragment_unnamed_56 = 1.0f / mad(fragment_uniform_buffer_0[21u].z, _CameraDepthTexture.Sample(sampler_CameraDepthTexture, float2(fragment_input_1.x, fragment_input_1.y)).x, fragment_uniform_buffer_0[21u].w);
				precise float fragment_unnamed_62 = (-0.0f) - fragment_uniform_buffer_0[30u].x;
				precise float fragment_unnamed_64 = fragment_unnamed_56 + fragment_unnamed_62;
				precise float fragment_unnamed_68 = fragment_unnamed_64 * fragment_uniform_buffer_0[30u].y;
				precise float fragment_unnamed_69 = fragment_unnamed_68 / fragment_unnamed_56;
				precise float fragment_unnamed_70 = fragment_unnamed_69 * 80.0f;
				float fragment_unnamed_72 = clamp(fragment_unnamed_70, 0.0f, 1.0f);
				precise float fragment_unnamed_73 = (-0.0f) - fragment_unnamed_70;
				float fragment_unnamed_74 = clamp(fragment_unnamed_73, 0.0f, 1.0f);
				float fragment_unnamed_75 = mad(fragment_unnamed_74, 0.0f, 1.0f);
				float fragment_unnamed_77 = mad(fragment_unnamed_74, 1.0f, 0.0f);
				precise float fragment_unnamed_78 = (-0.0f) - fragment_unnamed_75;
				precise float fragment_unnamed_79 = (-0.0f) - fragment_unnamed_77;
				precise float fragment_unnamed_80 = fragment_unnamed_78 + 0.4000000059604644775390625f;
				precise float fragment_unnamed_82 = fragment_unnamed_79 + 0.4000000059604644775390625f;
				precise float fragment_unnamed_83 = fragment_unnamed_79 + 0.4000000059604644775390625f;
				precise float fragment_unnamed_104 = dot(float3(_MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y)).xyz), float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)) + 0.5f;
				precise float fragment_unnamed_106 = fragment_unnamed_104 * mad(fragment_unnamed_72, fragment_unnamed_80, fragment_unnamed_75);
				precise float fragment_unnamed_107 = fragment_unnamed_104 * mad(fragment_unnamed_72, fragment_unnamed_82, mad(fragment_unnamed_74, 1.0f, 0.0f));
				precise float fragment_unnamed_108 = fragment_unnamed_104 * mad(fragment_unnamed_72, fragment_unnamed_83, fragment_unnamed_77);
				fragment_output_0.x = fragment_unnamed_106;
				fragment_output_0.y = fragment_unnamed_107;
				fragment_output_0.z = fragment_unnamed_108;
				fragment_output_0.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[21] = float4(_ZBufferParams[0], _ZBufferParams[1], _ZBufferParams[2], _ZBufferParams[3]);

				fragment_uniform_buffer_0[30] = float4(_Distance, fragment_uniform_buffer_0[30][1], fragment_uniform_buffer_0[30][2], fragment_uniform_buffer_0[30][3]);

				fragment_uniform_buffer_0[30] = float4(fragment_uniform_buffer_0[30][0], _LensCoeff, fragment_uniform_buffer_0[30][2], fragment_uniform_buffer_0[30][3]);

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
	SubShader
	{
		Pass
		{
			Name "CoC Calculation"
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 703831

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

			float4 _ZBufferParams;
			float _Distance;
			float _LensCoeff;
			float _RcpMaxCoC;

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
			static float fragment_unnamed_46;

			void frag_main()
			{
				fragment_unnamed_8 = _CameraDepthTexture.Sample(sampler_CameraDepthTexture, fragment_input_0).x;
				fragment_unnamed_8 = (_ZBufferParams.z * fragment_unnamed_8) + _ZBufferParams.w;
				fragment_unnamed_8 = 1.0f / fragment_unnamed_8;
				fragment_unnamed_46 = fragment_unnamed_8 + (-_Distance);
				fragment_unnamed_8 = max(fragment_unnamed_8, 9.9999997473787516355514526367188e-05f);
				fragment_unnamed_46 *= _LensCoeff;
				fragment_unnamed_8 = fragment_unnamed_46 / fragment_unnamed_8;
				fragment_unnamed_8 *= 0.5f;
				fragment_unnamed_8 = (fragment_unnamed_8 * _RcpMaxCoC) + 0.5f;
				fragment_output_0 = fragment_unnamed_8.xxxx;
				fragment_output_0 = clamp(fragment_output_0, 0.0f.xxxx, 1.0f.xxxx);
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_0 = stage_input.fragment_input_0;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			float4 _ZBufferParams;
			float _Distance;
			float _LensCoeff;
			float _RcpMaxCoC;

			static float4 fragment_uniform_buffer_0[31];
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
				precise float fragment_unnamed_52 = 1.0f / mad(fragment_uniform_buffer_0[21u].z, _CameraDepthTexture.Sample(sampler_CameraDepthTexture, float2(fragment_input_1.x, fragment_input_1.y)).x, fragment_uniform_buffer_0[21u].w);
				precise float fragment_unnamed_58 = (-0.0f) - fragment_uniform_buffer_0[30u].x;
				precise float fragment_unnamed_60 = fragment_unnamed_52 + fragment_unnamed_58;
				precise float fragment_unnamed_66 = fragment_unnamed_60 * fragment_uniform_buffer_0[30u].y;
				precise float fragment_unnamed_67 = fragment_unnamed_66 / max(fragment_unnamed_52, 9.9999997473787516355514526367188e-05f);
				precise float fragment_unnamed_68 = fragment_unnamed_67 * 0.5f;
				float fragment_unnamed_74 = clamp(mad(fragment_unnamed_68, fragment_uniform_buffer_0[30u].w, 0.5f), 0.0f, 1.0f);
				fragment_output_0.x = fragment_unnamed_74;
				fragment_output_0.y = fragment_unnamed_74;
				fragment_output_0.z = fragment_unnamed_74;
				fragment_output_0.w = fragment_unnamed_74;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[21] = float4(_ZBufferParams[0], _ZBufferParams[1], _ZBufferParams[2], _ZBufferParams[3]);

				fragment_uniform_buffer_0[30] = float4(_Distance, fragment_uniform_buffer_0[30][1], fragment_uniform_buffer_0[30][2], fragment_uniform_buffer_0[30][3]);

				fragment_uniform_buffer_0[30] = float4(fragment_uniform_buffer_0[30][0], _LensCoeff, fragment_uniform_buffer_0[30][2], fragment_uniform_buffer_0[30][3]);

				fragment_uniform_buffer_0[30] = float4(fragment_uniform_buffer_0[30][0], fragment_uniform_buffer_0[30][1], fragment_uniform_buffer_0[30][2], _RcpMaxCoC);

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
			Name "CoC Temporal Filter"
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 732018

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
			float3 _TaaParams;

			Texture2D<float4> _CoCTex;
			SamplerState sampler_CoCTex;
			Texture2D<float4> _CameraMotionVectorsTexture;
			SamplerState sampler_CameraMotionVectorsTexture;
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

			static float3 fragment_unnamed_9;
			static float4 fragment_unnamed_28;
			static float fragment_unnamed_54;
			static bool fragment_unnamed_115;
			static float4 fragment_unnamed_120;
			static bool fragment_unnamed_140;
			static float2 fragment_unnamed_147;
			static float2 fragment_unnamed_153;
			static float3 fragment_unnamed_194;
			static bool fragment_unnamed_211;
			static float fragment_unnamed_245;

			void frag_main()
			{
				float2 fragment_unnamed_24 = _MainTex_TexelSize.yy * float2(-0.0f, -1.0f);
				fragment_unnamed_9 = float3(fragment_unnamed_24.x, fragment_unnamed_24.y, fragment_unnamed_9.z);
				fragment_unnamed_28 = ((-_MainTex_TexelSize.xyyy) * float4(1.0f, 0.0f, 0.0f, 1.0f)) + fragment_input_0.xyxy;
				fragment_unnamed_28 = clamp(fragment_unnamed_28, 0.0f.xxxx, 1.0f.xxxx);
				fragment_unnamed_28 *= _RenderViewportScaleFactor.xxxx;
				fragment_unnamed_54 = _CoCTex.Sample(sampler_CoCTex, fragment_unnamed_28.xy).x;
				fragment_unnamed_9.z = _CoCTex.Sample(sampler_CoCTex, fragment_unnamed_28.zw).x;
				float2 fragment_unnamed_87 = fragment_input_0 + (-_TaaParams.xy);
				fragment_unnamed_28 = float4(fragment_unnamed_87.x, fragment_unnamed_87.y, fragment_unnamed_28.z, fragment_unnamed_28.w);
				float2 fragment_unnamed_94 = clamp(fragment_unnamed_28.xy, 0.0f.xx, 1.0f.xx);
				fragment_unnamed_28 = float4(fragment_unnamed_94.x, fragment_unnamed_94.y, fragment_unnamed_28.z, fragment_unnamed_28.w);
				float2 fragment_unnamed_102 = fragment_unnamed_28.xy * _RenderViewportScaleFactor.xx;
				fragment_unnamed_28 = float4(fragment_unnamed_102.x, fragment_unnamed_102.y, fragment_unnamed_28.z, fragment_unnamed_28.w);
				fragment_unnamed_28.x = _CoCTex.Sample(sampler_CoCTex, fragment_unnamed_28.xy).x;
				fragment_unnamed_115 = fragment_unnamed_54 < fragment_unnamed_28.x;
				float fragment_unnamed_123;
				if (fragment_unnamed_115)
				{
					fragment_unnamed_123 = fragment_unnamed_54;
				}
				else
				{
					fragment_unnamed_123 = fragment_unnamed_28.x;
				}
				fragment_unnamed_120.z = fragment_unnamed_123;
				fragment_unnamed_54 = max(fragment_unnamed_54, fragment_unnamed_28.x);
				fragment_unnamed_54 = max(fragment_unnamed_9.z, fragment_unnamed_54);
				fragment_unnamed_140 = fragment_unnamed_9.z < fragment_unnamed_120.z;
				fragment_unnamed_147 = _MainTex_TexelSize.xy * float2(1.0f, 0.0f);
				fragment_unnamed_153 = -fragment_unnamed_147;
				float2 fragment_unnamed_158;
				if (fragment_unnamed_115)
				{
					fragment_unnamed_158 = fragment_unnamed_153;
				}
				else
				{
					fragment_unnamed_158 = 0.0f.xx;
				}
				fragment_unnamed_120 = float4(fragment_unnamed_158.x, fragment_unnamed_158.y, fragment_unnamed_120.z, fragment_unnamed_120.w);
				float3 fragment_unnamed_169;
				if (fragment_unnamed_140)
				{
					fragment_unnamed_169 = fragment_unnamed_9;
				}
				else
				{
					fragment_unnamed_169 = fragment_unnamed_120.xyz;
				}
				fragment_unnamed_9 = fragment_unnamed_169;
				fragment_unnamed_120 = (_MainTex_TexelSize.yyxy * float4(0.0f, 1.0f, 1.0f, 0.0f)) + fragment_input_0.xyxy;
				fragment_unnamed_120 = clamp(fragment_unnamed_120, 0.0f.xxxx, 1.0f.xxxx);
				fragment_unnamed_120 *= _RenderViewportScaleFactor.xxxx;
				fragment_unnamed_194.z = _CoCTex.Sample(sampler_CoCTex, fragment_unnamed_120.xy).x;
				fragment_unnamed_120.x = _CoCTex.Sample(sampler_CoCTex, fragment_unnamed_120.zw).x;
				fragment_unnamed_211 = fragment_unnamed_194.z < fragment_unnamed_9.z;
				float2 fragment_unnamed_221 = _MainTex_TexelSize.yy * float2(0.0f, 1.0f);
				fragment_unnamed_194 = float3(fragment_unnamed_221.x, fragment_unnamed_221.y, fragment_unnamed_194.z);
				fragment_unnamed_54 = max(fragment_unnamed_54, fragment_unnamed_194.z);
				fragment_unnamed_54 = max(fragment_unnamed_120.x, fragment_unnamed_54);
				float3 fragment_unnamed_233;
				if (fragment_unnamed_211)
				{
					fragment_unnamed_233 = fragment_unnamed_194;
				}
				else
				{
					fragment_unnamed_233 = fragment_unnamed_9;
				}
				fragment_unnamed_9 = fragment_unnamed_233;
				fragment_unnamed_115 = fragment_unnamed_120.x < fragment_unnamed_9.z;
				fragment_unnamed_245 = min(fragment_unnamed_120.x, fragment_unnamed_9.z);
				float2 fragment_unnamed_252;
				if (fragment_unnamed_115)
				{
					fragment_unnamed_252 = fragment_unnamed_147;
				}
				else
				{
					fragment_unnamed_252 = fragment_unnamed_9.xy;
				}
				fragment_unnamed_9 = float3(fragment_unnamed_252.x, fragment_unnamed_252.y, fragment_unnamed_9.z);
				float2 fragment_unnamed_265 = fragment_unnamed_9.xy + fragment_input_0;
				fragment_unnamed_9 = float3(fragment_unnamed_265.x, fragment_unnamed_265.y, fragment_unnamed_9.z);
				float2 fragment_unnamed_272 = clamp(fragment_unnamed_9.xy, 0.0f.xx, 1.0f.xx);
				fragment_unnamed_9 = float3(fragment_unnamed_272.x, fragment_unnamed_272.y, fragment_unnamed_9.z);
				float2 fragment_unnamed_280 = fragment_unnamed_9.xy * _RenderViewportScaleFactor.xx;
				fragment_unnamed_9 = float3(fragment_unnamed_280.x, fragment_unnamed_280.y, fragment_unnamed_9.z);
				float2 fragment_unnamed_291 = _CameraMotionVectorsTexture.Sample(sampler_CameraMotionVectorsTexture, fragment_unnamed_9.xy).xy;
				fragment_unnamed_9 = float3(fragment_unnamed_291.x, fragment_unnamed_291.y, fragment_unnamed_9.z);
				float2 fragment_unnamed_298 = (-fragment_unnamed_9.xy) + fragment_input_0;
				fragment_unnamed_9 = float3(fragment_unnamed_298.x, fragment_unnamed_298.y, fragment_unnamed_9.z);
				float2 fragment_unnamed_305 = clamp(fragment_unnamed_9.xy, 0.0f.xx, 1.0f.xx);
				fragment_unnamed_9 = float3(fragment_unnamed_305.x, fragment_unnamed_305.y, fragment_unnamed_9.z);
				float2 fragment_unnamed_313 = fragment_unnamed_9.xy * _RenderViewportScaleFactor.xx;
				fragment_unnamed_9 = float3(fragment_unnamed_313.x, fragment_unnamed_313.y, fragment_unnamed_9.z);
				fragment_unnamed_9.x = _MainTex.Sample(sampler_MainTex, fragment_unnamed_9.xy).x;
				fragment_unnamed_9.x = max(fragment_unnamed_245, fragment_unnamed_9.x);
				fragment_unnamed_9.x = min(fragment_unnamed_54, fragment_unnamed_9.x);
				fragment_unnamed_9.x = (-fragment_unnamed_28.x) + fragment_unnamed_9.x;
				fragment_output_0 = (float4(_TaaParams.z, _TaaParams.z, _TaaParams.z, _TaaParams.z) * fragment_unnamed_9.xxxx) + fragment_unnamed_28.xxxx;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_0 = stage_input.fragment_input_0;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			float _RenderViewportScaleFactor;
			float4 _MainTex_TexelSize;
			float3 _TaaParams;

			static float4 fragment_uniform_buffer_0[32];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _CameraMotionVectorsTexture;
			Texture2D<float4> _CoCTex;
			SamplerState sampler_MainTex;
			SamplerState sampler_CameraMotionVectorsTexture;
			SamplerState sampler_CoCTex;

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
				precise float fragment_unnamed_43 = fragment_uniform_buffer_0[28u].y * (-0.0f);
				precise float fragment_unnamed_45 = fragment_uniform_buffer_0[28u].y * (-1.0f);
				precise float fragment_unnamed_50 = (-0.0f) - fragment_uniform_buffer_0[28u].x;
				precise float fragment_unnamed_52 = (-0.0f) - fragment_uniform_buffer_0[28u].y;
				precise float fragment_unnamed_74 = clamp(mad(fragment_unnamed_50, 1.0f, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_75 = clamp(mad(fragment_unnamed_52, 0.0f, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_76 = clamp(mad(fragment_unnamed_52, 0.0f, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_77 = clamp(mad(fragment_unnamed_52, 1.0f, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_80 = _CoCTex.Sample(sampler_CoCTex, float2(fragment_unnamed_74, fragment_unnamed_75));
				float fragment_unnamed_82 = fragment_unnamed_80.x;
				float4 fragment_unnamed_83 = _CoCTex.Sample(sampler_CoCTex, float2(fragment_unnamed_76, fragment_unnamed_77));
				float fragment_unnamed_85 = fragment_unnamed_83.x;
				precise float fragment_unnamed_94 = (-0.0f) - fragment_uniform_buffer_0[31u].y;
				precise float fragment_unnamed_96 = (-0.0f) - fragment_uniform_buffer_0[31u].z;
				precise float fragment_unnamed_97 = fragment_input_1.x + fragment_unnamed_94;
				precise float fragment_unnamed_98 = fragment_input_1.y + fragment_unnamed_96;
				precise float fragment_unnamed_104 = clamp(fragment_unnamed_97, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_105 = clamp(fragment_unnamed_98, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_106 = _CoCTex.Sample(sampler_CoCTex, float2(fragment_unnamed_104, fragment_unnamed_105));
				float fragment_unnamed_108 = fragment_unnamed_106.x;
				bool fragment_unnamed_110 = fragment_unnamed_82 < fragment_unnamed_108;
				uint fragment_unnamed_112 = fragment_unnamed_110 ? 4294967295u : 0u;
				uint fragment_unnamed_115 = fragment_unnamed_110 ? asuint(fragment_unnamed_82) : asuint(fragment_unnamed_108);
				bool fragment_unnamed_119 = fragment_unnamed_85 < asfloat(fragment_unnamed_115);
				precise float fragment_unnamed_124 = fragment_uniform_buffer_0[28u].x * 1.0f;
				precise float fragment_unnamed_125 = fragment_uniform_buffer_0[28u].y * 0.0f;
				precise float fragment_unnamed_126 = (-0.0f) - fragment_unnamed_124;
				precise float fragment_unnamed_127 = (-0.0f) - fragment_unnamed_125;
				uint fragment_unnamed_137 = fragment_unnamed_119 ? asuint(fragment_unnamed_85) : fragment_unnamed_115;
				precise float fragment_unnamed_158 = clamp(mad(fragment_uniform_buffer_0[28u].y, 0.0f, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_159 = clamp(mad(fragment_uniform_buffer_0[28u].y, 1.0f, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_160 = clamp(mad(fragment_uniform_buffer_0[28u].x, 1.0f, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_161 = clamp(mad(fragment_uniform_buffer_0[28u].y, 0.0f, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_162 = _CoCTex.Sample(sampler_CoCTex, float2(fragment_unnamed_158, fragment_unnamed_159));
				float fragment_unnamed_164 = fragment_unnamed_162.x;
				float4 fragment_unnamed_165 = _CoCTex.Sample(sampler_CoCTex, float2(fragment_unnamed_160, fragment_unnamed_161));
				float fragment_unnamed_167 = fragment_unnamed_165.x;
				bool fragment_unnamed_168 = fragment_unnamed_164 < asfloat(fragment_unnamed_137);
				precise float fragment_unnamed_172 = fragment_uniform_buffer_0[28u].y * 0.0f;
				precise float fragment_unnamed_174 = fragment_uniform_buffer_0[28u].y * 1.0f;
				float fragment_unnamed_182 = asfloat(fragment_unnamed_168 ? asuint(fragment_unnamed_164) : fragment_unnamed_137);
				bool fragment_unnamed_183 = fragment_unnamed_167 < fragment_unnamed_182;
				precise float fragment_unnamed_195 = asfloat(fragment_unnamed_183 ? asuint(fragment_unnamed_124) : (fragment_unnamed_168 ? asuint(fragment_unnamed_172) : (fragment_unnamed_119 ? asuint(fragment_unnamed_43) : (fragment_unnamed_112 & asuint(fragment_unnamed_126))))) + fragment_input_1.x;
				precise float fragment_unnamed_196 = asfloat(fragment_unnamed_183 ? asuint(fragment_unnamed_125) : (fragment_unnamed_168 ? asuint(fragment_unnamed_174) : (fragment_unnamed_119 ? asuint(fragment_unnamed_45) : (fragment_unnamed_112 & asuint(fragment_unnamed_127))))) + fragment_input_1.y;
				precise float fragment_unnamed_202 = clamp(fragment_unnamed_195, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_203 = clamp(fragment_unnamed_196, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_205 = _CameraMotionVectorsTexture.Sample(sampler_CameraMotionVectorsTexture, float2(fragment_unnamed_202, fragment_unnamed_203));
				precise float fragment_unnamed_209 = (-0.0f) - fragment_unnamed_205.x;
				precise float fragment_unnamed_210 = (-0.0f) - fragment_unnamed_205.y;
				precise float fragment_unnamed_215 = fragment_unnamed_209 + fragment_input_1.x;
				precise float fragment_unnamed_216 = fragment_unnamed_210 + fragment_input_1.y;
				precise float fragment_unnamed_222 = clamp(fragment_unnamed_215, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_223 = clamp(fragment_unnamed_216, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_230 = (-0.0f) - fragment_unnamed_108;
				precise float fragment_unnamed_231 = fragment_unnamed_230 + min(max(fragment_unnamed_167, max(max(fragment_unnamed_85, max(fragment_unnamed_82, fragment_unnamed_108)), fragment_unnamed_164)), max(min(fragment_unnamed_167, fragment_unnamed_182), _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_222, fragment_unnamed_223)).x));
				fragment_output_0.x = mad(fragment_uniform_buffer_0[31u].w, fragment_unnamed_231, fragment_unnamed_108);
				fragment_output_0.y = mad(fragment_uniform_buffer_0[31u].w, fragment_unnamed_231, fragment_unnamed_108);
				fragment_output_0.z = mad(fragment_uniform_buffer_0[31u].w, fragment_unnamed_231, fragment_unnamed_108);
				fragment_output_0.w = mad(fragment_uniform_buffer_0[31u].w, fragment_unnamed_231, fragment_unnamed_108);
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, fragment_uniform_buffer_0[26][1], fragment_uniform_buffer_0[26][2], fragment_uniform_buffer_0[26][3]);

				fragment_uniform_buffer_0[28] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				fragment_uniform_buffer_0[31] = float4(fragment_uniform_buffer_0[31][0], _TaaParams[0], _TaaParams[1], _TaaParams[2]);

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
			Name "Downsample and Prefilter"
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 793451

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
			float _MaxCoC;

			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;
			Texture2D<float4> _CoCTex;
			SamplerState sampler_CoCTex;

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
			static float3 fragment_unnamed_45;
			static float fragment_unnamed_61;
			static float fragment_unnamed_77;
			static float fragment_unnamed_92;
			static float4 fragment_unnamed_101;
			static float3 fragment_unnamed_124;
			static float3 fragment_unnamed_177;
			static bool fragment_unnamed_309;
			static bool3 fragment_unnamed_432;

			void frag_main()
			{
				fragment_unnamed_9 = ((-_MainTex_TexelSize.xyxy) * float4(0.5f, 0.5f, -0.5f, 0.5f)) + fragment_input_0.xyxy;
				fragment_unnamed_9 = clamp(fragment_unnamed_9, 0.0f.xxxx, 1.0f.xxxx);
				fragment_unnamed_9 *= _RenderViewportScaleFactor.xxxx;
				fragment_unnamed_45 = _MainTex.Sample(sampler_MainTex, fragment_unnamed_9.zw).xyz;
				fragment_unnamed_61 = max(fragment_unnamed_45.y, fragment_unnamed_45.x);
				fragment_unnamed_61 = max(fragment_unnamed_45.z, fragment_unnamed_61);
				fragment_unnamed_61 += 1.0f;
				fragment_unnamed_77 = _CoCTex.Sample(sampler_CoCTex, fragment_unnamed_9.zw).x;
				fragment_unnamed_77 = (fragment_unnamed_77 * 2.0f) + (-1.0f);
				fragment_unnamed_92 = abs(fragment_unnamed_77) / fragment_unnamed_61;
				fragment_unnamed_45 = fragment_unnamed_92.xxx * fragment_unnamed_45;
				float3 fragment_unnamed_108 = _MainTex.Sample(sampler_MainTex, fragment_unnamed_9.xy).xyz;
				fragment_unnamed_101 = float4(fragment_unnamed_108.x, fragment_unnamed_108.y, fragment_unnamed_108.z, fragment_unnamed_101.w);
				fragment_unnamed_9.x = _CoCTex.Sample(sampler_CoCTex, fragment_unnamed_9.xy).x;
				fragment_unnamed_9.x = (fragment_unnamed_9.x * 2.0f) + (-1.0f);
				fragment_unnamed_124.x = max(fragment_unnamed_101.y, fragment_unnamed_101.x);
				fragment_unnamed_124.x = max(fragment_unnamed_101.z, fragment_unnamed_124.x);
				fragment_unnamed_124.x += 1.0f;
				fragment_unnamed_124.x = abs(fragment_unnamed_9.x) / fragment_unnamed_124.x;
				fragment_unnamed_45 = (fragment_unnamed_101.xyz * fragment_unnamed_124.xxx) + fragment_unnamed_45;
				fragment_unnamed_124.x = fragment_unnamed_92 + fragment_unnamed_124.x;
				fragment_unnamed_101 = (_MainTex_TexelSize.xyxy * float4(-0.5f, 0.5f, 0.5f, 0.5f)) + fragment_input_0.xyxy;
				fragment_unnamed_101 = clamp(fragment_unnamed_101, 0.0f.xxxx, 1.0f.xxxx);
				fragment_unnamed_101 *= _RenderViewportScaleFactor.xxxx;
				fragment_unnamed_177 = _MainTex.Sample(sampler_MainTex, fragment_unnamed_101.xy).xyz;
				fragment_unnamed_92 = max(fragment_unnamed_177.y, fragment_unnamed_177.x);
				fragment_unnamed_92 = max(fragment_unnamed_177.z, fragment_unnamed_92);
				fragment_unnamed_92 += 1.0f;
				fragment_unnamed_61 = _CoCTex.Sample(sampler_CoCTex, fragment_unnamed_101.xy).x;
				fragment_unnamed_61 = (fragment_unnamed_61 * 2.0f) + (-1.0f);
				fragment_unnamed_92 = abs(fragment_unnamed_61) / fragment_unnamed_92;
				fragment_unnamed_45 = (fragment_unnamed_177 * fragment_unnamed_92.xxx) + fragment_unnamed_45;
				fragment_unnamed_124.x = fragment_unnamed_92 + fragment_unnamed_124.x;
				fragment_unnamed_177 = _MainTex.Sample(sampler_MainTex, fragment_unnamed_101.zw).xyz;
				fragment_unnamed_92 = _CoCTex.Sample(sampler_CoCTex, fragment_unnamed_101.zw).x;
				fragment_unnamed_92 = (fragment_unnamed_92 * 2.0f) + (-1.0f);
				fragment_unnamed_101.x = max(fragment_unnamed_177.y, fragment_unnamed_177.x);
				fragment_unnamed_101.x = max(fragment_unnamed_177.z, fragment_unnamed_101.x);
				fragment_unnamed_101.x += 1.0f;
				fragment_unnamed_101.x = abs(fragment_unnamed_92) / fragment_unnamed_101.x;
				fragment_unnamed_45 = (fragment_unnamed_177 * fragment_unnamed_101.xxx) + fragment_unnamed_45;
				fragment_unnamed_124.x += fragment_unnamed_101.x;
				fragment_unnamed_124.x = max(fragment_unnamed_124.x, 9.9999997473787516355514526367188e-05f);
				fragment_unnamed_45 /= fragment_unnamed_124.xxx;
				fragment_unnamed_124.x = min(fragment_unnamed_77, fragment_unnamed_61);
				fragment_unnamed_77 = max(fragment_unnamed_77, fragment_unnamed_61);
				fragment_unnamed_77 = max(fragment_unnamed_92, fragment_unnamed_77);
				fragment_unnamed_124.x = min(fragment_unnamed_92, fragment_unnamed_124.x);
				fragment_unnamed_124.x = min(fragment_unnamed_124.x, fragment_unnamed_9.x);
				fragment_unnamed_9.x = max(fragment_unnamed_77, fragment_unnamed_9.x);
				fragment_unnamed_309 = fragment_unnamed_9.x < (-fragment_unnamed_124.x);
				float fragment_unnamed_318;
				if (fragment_unnamed_309)
				{
					fragment_unnamed_318 = fragment_unnamed_124.x;
				}
				else
				{
					fragment_unnamed_318 = fragment_unnamed_9.x;
				}
				fragment_unnamed_9.x = fragment_unnamed_318;
				fragment_unnamed_9.x *= _MaxCoC;
				fragment_unnamed_124.x = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
				fragment_unnamed_124.x = 1.0f / fragment_unnamed_124.x;
				fragment_unnamed_124.x *= abs(fragment_unnamed_9.x);
				fragment_unnamed_124.x = clamp(fragment_unnamed_124.x, 0.0f, 1.0f);
				fragment_output_0.w = fragment_unnamed_9.x;
				fragment_unnamed_9.x = (fragment_unnamed_124.x * (-2.0f)) + 3.0f;
				fragment_unnamed_124.x *= fragment_unnamed_124.x;
				fragment_unnamed_9.x = fragment_unnamed_124.x * fragment_unnamed_9.x;
				fragment_unnamed_124 = (fragment_unnamed_45 * fragment_unnamed_9.xxx) + 0.054999999701976776123046875f.xxx;
				fragment_unnamed_45 = fragment_unnamed_9.xxx * fragment_unnamed_45;
				float3 fragment_unnamed_396 = fragment_unnamed_124 * 0.947867333889007568359375f.xxx;
				fragment_unnamed_9 = float4(fragment_unnamed_396.x, fragment_unnamed_396.y, fragment_unnamed_396.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_404 = max(abs(fragment_unnamed_9.xyz), 1.1920928955078125e-07f.xxx);
				fragment_unnamed_9 = float4(fragment_unnamed_404.x, fragment_unnamed_404.y, fragment_unnamed_404.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_409 = log2(fragment_unnamed_9.xyz);
				fragment_unnamed_9 = float4(fragment_unnamed_409.x, fragment_unnamed_409.y, fragment_unnamed_409.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_416 = fragment_unnamed_9.xyz * 2.400000095367431640625f.xxx;
				fragment_unnamed_9 = float4(fragment_unnamed_416.x, fragment_unnamed_416.y, fragment_unnamed_416.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_421 = exp2(fragment_unnamed_9.xyz);
				fragment_unnamed_9 = float4(fragment_unnamed_421.x, fragment_unnamed_421.y, fragment_unnamed_421.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_427 = fragment_unnamed_45 * 0.077399380505084991455078125f.xxx;
				fragment_unnamed_101 = float4(fragment_unnamed_427.x, fragment_unnamed_427.y, fragment_unnamed_427.z, fragment_unnamed_101.w);
				fragment_unnamed_432 = bool4(float4(0.040449999272823333740234375f, 0.040449999272823333740234375f, 0.040449999272823333740234375f, 0.0f).x >= fragment_unnamed_45.xyzx.x, float4(0.040449999272823333740234375f, 0.040449999272823333740234375f, 0.040449999272823333740234375f, 0.0f).y >= fragment_unnamed_45.xyzx.y, float4(0.040449999272823333740234375f, 0.040449999272823333740234375f, 0.040449999272823333740234375f, 0.0f).z >= fragment_unnamed_45.xyzx.z, float4(0.040449999272823333740234375f, 0.040449999272823333740234375f, 0.040449999272823333740234375f, 0.0f).w >= fragment_unnamed_45.xyzx.w).xyz;
				float fragment_unnamed_442;
				if (fragment_unnamed_432.x)
				{
					fragment_unnamed_442 = fragment_unnamed_101.x;
				}
				else
				{
					fragment_unnamed_442 = fragment_unnamed_9.x;
				}
				fragment_output_0.x = fragment_unnamed_442;
				float fragment_unnamed_454;
				if (fragment_unnamed_432.y)
				{
					fragment_unnamed_454 = fragment_unnamed_101.y;
				}
				else
				{
					fragment_unnamed_454 = fragment_unnamed_9.y;
				}
				fragment_output_0.y = fragment_unnamed_454;
				float fragment_unnamed_466;
				if (fragment_unnamed_432.z)
				{
					fragment_unnamed_466 = fragment_unnamed_101.z;
				}
				else
				{
					fragment_unnamed_466 = fragment_unnamed_9.z;
				}
				fragment_output_0.z = fragment_unnamed_466;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_0 = stage_input.fragment_input_0;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			float _RenderViewportScaleFactor;
			float4 _MainTex_TexelSize;
			float _MaxCoC;

			static float4 fragment_uniform_buffer_0[31];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _CoCTex;
			SamplerState sampler_MainTex;
			SamplerState sampler_CoCTex;

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
				precise float fragment_unnamed_39 = (-0.0f) - fragment_uniform_buffer_0[28u].x;
				precise float fragment_unnamed_42 = (-0.0f) - fragment_uniform_buffer_0[28u].y;
				precise float fragment_unnamed_66 = clamp(mad(fragment_unnamed_39, 0.5f, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_67 = clamp(mad(fragment_unnamed_42, 0.5f, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_68 = clamp(mad(fragment_unnamed_39, -0.5f, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_69 = clamp(mad(fragment_unnamed_42, 0.5f, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_72 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_68, fragment_unnamed_69));
				float fragment_unnamed_74 = fragment_unnamed_72.x;
				float fragment_unnamed_75 = fragment_unnamed_72.y;
				float fragment_unnamed_76 = fragment_unnamed_72.z;
				precise float fragment_unnamed_79 = max(fragment_unnamed_76, max(fragment_unnamed_75, fragment_unnamed_74)) + 1.0f;
				float fragment_unnamed_84 = mad(_CoCTex.Sample(sampler_CoCTex, float2(fragment_unnamed_68, fragment_unnamed_69)).x, 2.0f, -1.0f);
				precise float fragment_unnamed_88 = abs(fragment_unnamed_84) / fragment_unnamed_79;
				precise float fragment_unnamed_89 = fragment_unnamed_88 * fragment_unnamed_74;
				precise float fragment_unnamed_90 = fragment_unnamed_88 * fragment_unnamed_75;
				precise float fragment_unnamed_91 = fragment_unnamed_88 * fragment_unnamed_76;
				float4 fragment_unnamed_92 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_66, fragment_unnamed_67));
				float fragment_unnamed_94 = fragment_unnamed_92.x;
				float fragment_unnamed_95 = fragment_unnamed_92.y;
				float fragment_unnamed_96 = fragment_unnamed_92.z;
				float fragment_unnamed_100 = mad(_CoCTex.Sample(sampler_CoCTex, float2(fragment_unnamed_66, fragment_unnamed_67)).x, 2.0f, -1.0f);
				precise float fragment_unnamed_103 = max(fragment_unnamed_96, max(fragment_unnamed_95, fragment_unnamed_94)) + 1.0f;
				precise float fragment_unnamed_105 = abs(fragment_unnamed_100) / fragment_unnamed_103;
				precise float fragment_unnamed_109 = fragment_unnamed_88 + fragment_unnamed_105;
				precise float fragment_unnamed_129 = clamp(mad(fragment_uniform_buffer_0[28u].x, -0.5f, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_130 = clamp(mad(fragment_uniform_buffer_0[28u].y, 0.5f, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_131 = clamp(mad(fragment_uniform_buffer_0[28u].x, 0.5f, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_132 = clamp(mad(fragment_uniform_buffer_0[28u].y, 0.5f, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_133 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_129, fragment_unnamed_130));
				float fragment_unnamed_135 = fragment_unnamed_133.x;
				float fragment_unnamed_136 = fragment_unnamed_133.y;
				float fragment_unnamed_137 = fragment_unnamed_133.z;
				precise float fragment_unnamed_140 = max(fragment_unnamed_137, max(fragment_unnamed_136, fragment_unnamed_135)) + 1.0f;
				float fragment_unnamed_144 = mad(_CoCTex.Sample(sampler_CoCTex, float2(fragment_unnamed_129, fragment_unnamed_130)).x, 2.0f, -1.0f);
				precise float fragment_unnamed_146 = abs(fragment_unnamed_144) / fragment_unnamed_140;
				precise float fragment_unnamed_150 = fragment_unnamed_146 + fragment_unnamed_109;
				float4 fragment_unnamed_151 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_131, fragment_unnamed_132));
				float fragment_unnamed_153 = fragment_unnamed_151.x;
				float fragment_unnamed_154 = fragment_unnamed_151.y;
				float fragment_unnamed_155 = fragment_unnamed_151.z;
				float fragment_unnamed_159 = mad(_CoCTex.Sample(sampler_CoCTex, float2(fragment_unnamed_131, fragment_unnamed_132)).x, 2.0f, -1.0f);
				precise float fragment_unnamed_162 = max(fragment_unnamed_155, max(fragment_unnamed_154, fragment_unnamed_153)) + 1.0f;
				precise float fragment_unnamed_164 = abs(fragment_unnamed_159) / fragment_unnamed_162;
				precise float fragment_unnamed_168 = fragment_unnamed_150 + fragment_unnamed_164;
				float fragment_unnamed_169 = max(fragment_unnamed_168, 9.9999997473787516355514526367188e-05f);
				precise float fragment_unnamed_171 = mad(fragment_unnamed_153, fragment_unnamed_164, mad(fragment_unnamed_135, fragment_unnamed_146, mad(fragment_unnamed_94, fragment_unnamed_105, fragment_unnamed_89))) / fragment_unnamed_169;
				precise float fragment_unnamed_172 = mad(fragment_unnamed_154, fragment_unnamed_164, mad(fragment_unnamed_136, fragment_unnamed_146, mad(fragment_unnamed_95, fragment_unnamed_105, fragment_unnamed_90))) / fragment_unnamed_169;
				precise float fragment_unnamed_173 = mad(fragment_unnamed_155, fragment_unnamed_164, mad(fragment_unnamed_137, fragment_unnamed_146, mad(fragment_unnamed_96, fragment_unnamed_105, fragment_unnamed_91))) / fragment_unnamed_169;
				float fragment_unnamed_178 = min(min(fragment_unnamed_159, min(fragment_unnamed_84, fragment_unnamed_144)), fragment_unnamed_100);
				float fragment_unnamed_179 = max(max(fragment_unnamed_159, max(fragment_unnamed_84, fragment_unnamed_144)), fragment_unnamed_100);
				precise float fragment_unnamed_180 = (-0.0f) - fragment_unnamed_178;
				precise float fragment_unnamed_191 = asfloat((fragment_unnamed_179 < fragment_unnamed_180) ? asuint(fragment_unnamed_178) : asuint(fragment_unnamed_179)) * fragment_uniform_buffer_0[30u].z;
				precise float fragment_unnamed_198 = fragment_uniform_buffer_0[28u].y + fragment_uniform_buffer_0[28u].y;
				precise float fragment_unnamed_199 = 1.0f / fragment_unnamed_198;
				precise float fragment_unnamed_201 = fragment_unnamed_199 * abs(fragment_unnamed_191);
				float fragment_unnamed_202 = clamp(fragment_unnamed_201, 0.0f, 1.0f);
				fragment_output_0.w = fragment_unnamed_191;
				precise float fragment_unnamed_209 = fragment_unnamed_202 * fragment_unnamed_202;
				precise float fragment_unnamed_210 = fragment_unnamed_209 * mad(fragment_unnamed_202, -2.0f, 3.0f);
				precise float fragment_unnamed_215 = fragment_unnamed_210 * fragment_unnamed_171;
				precise float fragment_unnamed_216 = fragment_unnamed_210 * fragment_unnamed_172;
				precise float fragment_unnamed_217 = fragment_unnamed_210 * fragment_unnamed_173;
				precise float fragment_unnamed_218 = mad(fragment_unnamed_171, fragment_unnamed_210, 0.054999999701976776123046875f) * 0.947867333889007568359375f;
				precise float fragment_unnamed_220 = mad(fragment_unnamed_172, fragment_unnamed_210, 0.054999999701976776123046875f) * 0.947867333889007568359375f;
				precise float fragment_unnamed_221 = mad(fragment_unnamed_173, fragment_unnamed_210, 0.054999999701976776123046875f) * 0.947867333889007568359375f;
				precise float fragment_unnamed_232 = log2(max(abs(fragment_unnamed_218), 1.1920928955078125e-07f)) * 2.400000095367431640625f;
				precise float fragment_unnamed_234 = log2(max(abs(fragment_unnamed_220), 1.1920928955078125e-07f)) * 2.400000095367431640625f;
				precise float fragment_unnamed_235 = log2(max(abs(fragment_unnamed_221), 1.1920928955078125e-07f)) * 2.400000095367431640625f;
				precise float fragment_unnamed_239 = fragment_unnamed_215 * 0.077399380505084991455078125f;
				precise float fragment_unnamed_241 = fragment_unnamed_216 * 0.077399380505084991455078125f;
				precise float fragment_unnamed_242 = fragment_unnamed_217 * 0.077399380505084991455078125f;
				fragment_output_0.x = (0.040449999272823333740234375f >= fragment_unnamed_215) ? fragment_unnamed_239 : exp2(fragment_unnamed_232);
				fragment_output_0.y = (0.040449999272823333740234375f >= fragment_unnamed_216) ? fragment_unnamed_241 : exp2(fragment_unnamed_234);
				fragment_output_0.z = (0.040449999272823333740234375f >= fragment_unnamed_217) ? fragment_unnamed_242 : exp2(fragment_unnamed_235);
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, fragment_uniform_buffer_0[26][1], fragment_uniform_buffer_0[26][2], fragment_uniform_buffer_0[26][3]);

				fragment_uniform_buffer_0[28] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				fragment_uniform_buffer_0[30] = float4(fragment_uniform_buffer_0[30][0], fragment_uniform_buffer_0[30][1], _MaxCoC, fragment_uniform_buffer_0[30][3]);

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
			Name "Bokeh Filter (small)"
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 890411

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
			float _MaxCoC;
			float _RcpAspect;

			static const uint4 fragment_unnamed_129[16] = { uint4(0u, 0u, 0u, 0u), uint4(1057727209u, 0u, 0u, 0u), uint4(1043110300u, 1057279317u, 0u, 0u), uint4(3202478008u, 1050945282u, 0u, 0u), uint4(3202478006u, 3198428933u, 0u, 0u), uint4(1043110305u, 3204762965u, 0u, 0u), uint4(1065353216u, 0u, 0u, 0u), uint4(1062149053u, 1058437400u, 0u, 0u), uint4(1050556281u, 1064532081u, 0u, 0u), uint4(3198039931u, 1064532080u, 0u, 0u), uint4(3209632702u, 1058437399u, 0u, 0u), uint4(3212836864u, 0u, 0u, 0u), uint4(3209632700u, 3205921050u, 0u, 0u), uint4(3198039918u, 3212015730u, 0u, 0u), uint4(1050556286u, 3212015728u, 0u, 0u), uint4(1062149052u, 3205921049u, 0u, 0u) };

			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

			static float2 fragment_input_1;
			static float2 fragment_input_0;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_0 : TEXCOORD0; // vs_TEXCOORD0
				float2 fragment_input_1 : TEXCOORD1; // vs_TEXCOORD1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static float3 fragment_unnamed_9;
			static float fragment_unnamed_32;
			static float4 fragment_unnamed_46;
			static float4 fragment_unnamed_49;
			static float4 fragment_unnamed_56;
			static float4 fragment_unnamed_73;
			static float fragment_unnamed_142;
			static float fragment_unnamed_185;
			static bool fragment_unnamed_225;
			static float fragment_unnamed_232;
			static bool fragment_unnamed_256;
			static bool fragment_unnamed_274;
			static int fragment_unnamed_320;

			void frag_main()
			{
				fragment_unnamed_9.x = _MainTex.Sample(sampler_MainTex, fragment_input_1).w;
				fragment_unnamed_32 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
				fragment_unnamed_46.w = 1.0f;
				fragment_unnamed_49.x = 0.0f;
				fragment_unnamed_49.y = 0.0f;
				fragment_unnamed_49.z = 0.0f;
				fragment_unnamed_49.w = 0.0f;
				fragment_unnamed_56.x = 0.0f;
				fragment_unnamed_56.y = 0.0f;
				fragment_unnamed_56.z = 0.0f;
				fragment_unnamed_56.w = 0.0f;
				for (int fragment_unnamed_62 = 0; fragment_unnamed_62 < 16; fragment_unnamed_62++)
				{
					float2 fragment_unnamed_139 = float2(float2(_MaxCoC, _MaxCoC)) * asfloat(fragment_unnamed_129[fragment_unnamed_62].xy);
					fragment_unnamed_73 = float4(fragment_unnamed_73.x, fragment_unnamed_139.x, fragment_unnamed_139.y, fragment_unnamed_73.w);
					fragment_unnamed_142 = dot(fragment_unnamed_73.yz, fragment_unnamed_73.yz);
					fragment_unnamed_142 = sqrt(fragment_unnamed_142);
					fragment_unnamed_73.x = fragment_unnamed_73.y * _RcpAspect;
					float2 fragment_unnamed_161 = fragment_unnamed_73.xz + fragment_input_0;
					fragment_unnamed_73 = float4(fragment_unnamed_161.x, fragment_unnamed_161.y, fragment_unnamed_73.z, fragment_unnamed_73.w);
					float2 fragment_unnamed_168 = clamp(fragment_unnamed_73.xy, 0.0f.xx, 1.0f.xx);
					fragment_unnamed_73 = float4(fragment_unnamed_168.x, fragment_unnamed_168.y, fragment_unnamed_73.z, fragment_unnamed_73.w);
					float2 fragment_unnamed_176 = fragment_unnamed_73.xy * _RenderViewportScaleFactor.xx;
					fragment_unnamed_73 = float4(fragment_unnamed_176.x, fragment_unnamed_176.y, fragment_unnamed_73.z, fragment_unnamed_73.w);
					fragment_unnamed_73 = _MainTex.Sample(sampler_MainTex, fragment_unnamed_73.xy);
					fragment_unnamed_185 = min(fragment_unnamed_9.x, fragment_unnamed_73.w);
					fragment_unnamed_185 = max(fragment_unnamed_185, 0.0f);
					fragment_unnamed_185 = (-fragment_unnamed_142) + fragment_unnamed_185;
					fragment_unnamed_185 = (_MainTex_TexelSize.y * 2.0f) + fragment_unnamed_185;
					fragment_unnamed_185 /= fragment_unnamed_32;
					fragment_unnamed_185 = clamp(fragment_unnamed_185, 0.0f, 1.0f);
					fragment_unnamed_142 = (-fragment_unnamed_142) + (-fragment_unnamed_73.w);
					fragment_unnamed_142 = (_MainTex_TexelSize.y * 2.0f) + fragment_unnamed_142;
					fragment_unnamed_142 /= fragment_unnamed_32;
					fragment_unnamed_142 = clamp(fragment_unnamed_142, 0.0f, 1.0f);
					fragment_unnamed_225 = (-fragment_unnamed_73.w) >= _MainTex_TexelSize.y;
					fragment_unnamed_232 = float(fragment_unnamed_225);
					fragment_unnamed_142 *= fragment_unnamed_232;
					fragment_unnamed_46 = float4(fragment_unnamed_73.xyz.x, fragment_unnamed_73.xyz.y, fragment_unnamed_73.xyz.z, fragment_unnamed_46.w);
					fragment_unnamed_49 = (fragment_unnamed_46 * fragment_unnamed_185.xxxx) + fragment_unnamed_49;
					fragment_unnamed_56 = (fragment_unnamed_46 * fragment_unnamed_142.xxxx) + fragment_unnamed_56;
				}
				fragment_unnamed_256 = fragment_unnamed_49.w == 0.0f;
				fragment_unnamed_9.x = float(fragment_unnamed_256);
				fragment_unnamed_9.x += fragment_unnamed_49.w;
				fragment_unnamed_9 = fragment_unnamed_49.xyz / fragment_unnamed_9.xxx;
				fragment_unnamed_274 = fragment_unnamed_56.w == 0.0f;
				fragment_unnamed_142 = float(fragment_unnamed_274);
				fragment_unnamed_142 += fragment_unnamed_56.w;
				float3 fragment_unnamed_288 = fragment_unnamed_56.xyz / fragment_unnamed_142.xxx;
				fragment_unnamed_46 = float4(fragment_unnamed_288.x, fragment_unnamed_288.y, fragment_unnamed_288.z, fragment_unnamed_46.w);
				fragment_unnamed_142 = fragment_unnamed_56.w * 0.19634954631328582763671875f;
				fragment_unnamed_142 = min(fragment_unnamed_142, 1.0f);
				float3 fragment_unnamed_301 = (-fragment_unnamed_9) + fragment_unnamed_46.xyz;
				fragment_unnamed_46 = float4(fragment_unnamed_301.x, fragment_unnamed_301.y, fragment_unnamed_301.z, fragment_unnamed_46.w);
				float3 fragment_unnamed_312 = (fragment_unnamed_142.xxx * fragment_unnamed_46.xyz) + fragment_unnamed_9;
				fragment_output_0 = float4(fragment_unnamed_312.x, fragment_unnamed_312.y, fragment_unnamed_312.z, fragment_output_0.w);
				fragment_output_0.w = fragment_unnamed_142;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_0 = stage_input.fragment_input_0;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			float _RenderViewportScaleFactor;
			float4 _MainTex_TexelSize;
			float _MaxCoC;
			float _RcpAspect;

			static float4 fragment_uniform_buffer_0[32];
			static const float fragment_unnamed_57[64] = { 0.0f, 0.0f, 0.0f, 0.0f, 0.545454561710357666015625f, 0.0f, 0.0f, 0.0f, 0.168554723262786865234375f, 0.518758118152618408203125f, 0.0f, 0.0f, -0.4412820339202880859375f, 0.320610105991363525390625f, 0.0f, 0.0f, -0.441281974315643310546875f, -0.3206101953983306884765625f, 0.0f, 0.0f, 0.16855479776859283447265625f, -0.518758118152618408203125f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.809017002582550048828125f, 0.587785243988037109375f, 0.0f, 0.0f, 0.3090169727802276611328125f, 0.951056540012359619140625f, 0.0f, 0.0f, -0.3090170323848724365234375f, 0.95105648040771484375f, 0.0f, 0.0f, -0.80901706218719482421875f, 0.587785184383392333984375f, 0.0f, 0.0f, -1.0f, 0.0f, 0.0f, 0.0f, -0.8090169429779052734375f, -0.58778536319732666015625f, 0.0f, 0.0f, -0.309016644954681396484375f, -0.95105659961700439453125f, 0.0f, 0.0f, 0.309017121791839599609375f, -0.95105648040771484375f, 0.0f, 0.0f, 0.8090169429779052734375f, -0.587785303592681884765625f, 0.0f, 0.0f };

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
				float4 fragment_unnamed_71 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				float fragment_unnamed_73 = fragment_unnamed_71.w;
				precise float fragment_unnamed_82 = fragment_uniform_buffer_0[28u].y + fragment_uniform_buffer_0[28u].y;
				float fragment_unnamed_83 = asfloat(1065353216u);
				float fragment_unnamed_93;
				float fragment_unnamed_95;
				float fragment_unnamed_97;
				float fragment_unnamed_99;
				float fragment_unnamed_101;
				float fragment_unnamed_103;
				float fragment_unnamed_105;
				float fragment_unnamed_107;
				fragment_unnamed_93 = asfloat(0u);
				fragment_unnamed_95 = asfloat(0u);
				fragment_unnamed_97 = asfloat(0u);
				fragment_unnamed_99 = asfloat(0u);
				fragment_unnamed_101 = asfloat(0u);
				fragment_unnamed_103 = asfloat(0u);
				fragment_unnamed_105 = asfloat(0u);
				fragment_unnamed_107 = asfloat(0u);
				precise float fragment_unnamed_166;
				precise float fragment_unnamed_167;
				float fragment_unnamed_171;
				precise float fragment_unnamed_176;
				precise float fragment_unnamed_181;
				precise float fragment_unnamed_182;
				precise float fragment_unnamed_189;
				precise float fragment_unnamed_190;
				float4 fragment_unnamed_192;
				float fragment_unnamed_194;
				float fragment_unnamed_195;
				float fragment_unnamed_196;
				float fragment_unnamed_197;
				precise float fragment_unnamed_200;
				precise float fragment_unnamed_201;
				precise float fragment_unnamed_207;
				float fragment_unnamed_208;
				precise float fragment_unnamed_209;
				precise float fragment_unnamed_210;
				precise float fragment_unnamed_211;
				precise float fragment_unnamed_216;
				precise float fragment_unnamed_218;
				precise float fragment_unnamed_226;
				for (uint fragment_unnamed_109 = 0u; !(int(fragment_unnamed_109) >= int(16u)); fragment_unnamed_166 = fragment_uniform_buffer_0[30u].z * fragment_unnamed_57[(fragment_unnamed_109 * 4u) + 0u], fragment_unnamed_167 = fragment_uniform_buffer_0[30u].z * fragment_unnamed_57[(fragment_unnamed_109 * 4u) + 1u], fragment_unnamed_171 = sqrt(dot(float2(fragment_unnamed_166, fragment_unnamed_167), float2(fragment_unnamed_166, fragment_unnamed_167))), fragment_unnamed_176 = fragment_unnamed_166 * fragment_uniform_buffer_0[31u].x, fragment_unnamed_181 = fragment_unnamed_176 + fragment_input_1.x, fragment_unnamed_182 = fragment_unnamed_167 + fragment_input_1.y, fragment_unnamed_189 = clamp(fragment_unnamed_181, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, fragment_unnamed_190 = clamp(fragment_unnamed_182, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, fragment_unnamed_192 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_189, fragment_unnamed_190)), fragment_unnamed_194 = fragment_unnamed_192.x, fragment_unnamed_195 = fragment_unnamed_192.y, fragment_unnamed_196 = fragment_unnamed_192.z, fragment_unnamed_197 = fragment_unnamed_192.w, fragment_unnamed_200 = (-0.0f) - fragment_unnamed_171, fragment_unnamed_201 = fragment_unnamed_200 + max(min(fragment_unnamed_73, fragment_unnamed_197), 0.0f), fragment_unnamed_207 = mad(fragment_uniform_buffer_0[28u].y, 2.0f, fragment_unnamed_201) / fragment_unnamed_82, fragment_unnamed_208 = clamp(fragment_unnamed_207, 0.0f, 1.0f), fragment_unnamed_209 = (-0.0f) - fragment_unnamed_171, fragment_unnamed_210 = (-0.0f) - fragment_unnamed_197, fragment_unnamed_211 = fragment_unnamed_209 + fragment_unnamed_210, fragment_unnamed_216 = mad(fragment_uniform_buffer_0[28u].y, 2.0f, fragment_unnamed_211) / fragment_unnamed_82, fragment_unnamed_218 = (-0.0f) - fragment_unnamed_197, fragment_unnamed_226 = clamp(fragment_unnamed_216, 0.0f, 1.0f) * asfloat(((fragment_unnamed_218 >= fragment_uniform_buffer_0[28u].y) ? 4294967295u : 0u) & 1065353216u), fragment_unnamed_93 = mad(fragment_unnamed_195, fragment_unnamed_208, fragment_unnamed_93), fragment_unnamed_95 = mad(fragment_unnamed_196, fragment_unnamed_208, fragment_unnamed_95), fragment_unnamed_97 = mad(fragment_unnamed_83, fragment_unnamed_208, fragment_unnamed_97), fragment_unnamed_99 = mad(fragment_unnamed_194, fragment_unnamed_226, fragment_unnamed_99), fragment_unnamed_101 = mad(fragment_unnamed_195, fragment_unnamed_226, fragment_unnamed_101), fragment_unnamed_103 = mad(fragment_unnamed_196, fragment_unnamed_226, fragment_unnamed_103), fragment_unnamed_105 = mad(fragment_unnamed_83, fragment_unnamed_226, fragment_unnamed_105), fragment_unnamed_107 = mad(fragment_unnamed_194, fragment_unnamed_208, fragment_unnamed_107), fragment_unnamed_109++)
				{
				}
				precise float fragment_unnamed_119 = asfloat(((fragment_unnamed_97 == 0.0f) ? 4294967295u : 0u) & 1065353216u) + fragment_unnamed_97;
				precise float fragment_unnamed_120 = fragment_unnamed_107 / fragment_unnamed_119;
				precise float fragment_unnamed_121 = fragment_unnamed_93 / fragment_unnamed_119;
				precise float fragment_unnamed_122 = fragment_unnamed_95 / fragment_unnamed_119;
				precise float fragment_unnamed_127 = asfloat(((fragment_unnamed_105 == 0.0f) ? 4294967295u : 0u) & 1065353216u) + fragment_unnamed_105;
				precise float fragment_unnamed_128 = fragment_unnamed_99 / fragment_unnamed_127;
				precise float fragment_unnamed_129 = fragment_unnamed_101 / fragment_unnamed_127;
				precise float fragment_unnamed_130 = fragment_unnamed_103 / fragment_unnamed_127;
				precise float fragment_unnamed_131 = fragment_unnamed_105 * 0.19634954631328582763671875f;
				float fragment_unnamed_134 = min(fragment_unnamed_131, 1.0f);
				precise float fragment_unnamed_135 = (-0.0f) - fragment_unnamed_120;
				precise float fragment_unnamed_137 = (-0.0f) - fragment_unnamed_121;
				precise float fragment_unnamed_138 = (-0.0f) - fragment_unnamed_122;
				precise float fragment_unnamed_139 = fragment_unnamed_135 + fragment_unnamed_128;
				precise float fragment_unnamed_140 = fragment_unnamed_137 + fragment_unnamed_129;
				precise float fragment_unnamed_141 = fragment_unnamed_138 + fragment_unnamed_130;
				fragment_output_0.x = mad(fragment_unnamed_134, fragment_unnamed_139, fragment_unnamed_120);
				fragment_output_0.y = mad(fragment_unnamed_134, fragment_unnamed_140, fragment_unnamed_121);
				fragment_output_0.z = mad(fragment_unnamed_134, fragment_unnamed_141, fragment_unnamed_122);
				fragment_output_0.w = fragment_unnamed_134;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, fragment_uniform_buffer_0[26][1], fragment_uniform_buffer_0[26][2], fragment_uniform_buffer_0[26][3]);

				fragment_uniform_buffer_0[28] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				fragment_uniform_buffer_0[30] = float4(fragment_uniform_buffer_0[30][0], fragment_uniform_buffer_0[30][1], _MaxCoC, fragment_uniform_buffer_0[30][3]);

				fragment_uniform_buffer_0[31] = float4(_RcpAspect, fragment_uniform_buffer_0[31][1], fragment_uniform_buffer_0[31][2], fragment_uniform_buffer_0[31][3]);

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
			Name "Bokeh Filter (medium)"
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 966469

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
			float _MaxCoC;
			float _RcpAspect;

			static const uint4 fragment_unnamed_141[22] = { uint4(0u, 0u, 0u, 0u), uint4(1057523849u, 0u, 0u, 0u), uint4(1051345177u, 1054178812u, 0u, 0u), uint4(3186822495u, 1057299508u, 0u, 0u), uint4(3203794506u, 1047328091u, 0u, 0u), uint4(3203794506u, 3194811737u, 0u, 0u), uint4(3186822466u, 3204783157u, 0u, 0u), uint4(1051345175u, 3201662463u, 0u, 0u), uint4(1065353216u, 0u, 0u, 0u), uint4(1063691749u, 1054746115u, 0u, 0u), uint4(1059036423u, 1061692956u, 0u, 0u), uint4(1046731914u, 1064932576u, 0u, 0u), uint4(3194215560u, 1064932576u, 0u, 0u), uint4(3206520074u, 1061692954u, 0u, 0u), uint4(3211175397u, 1054746117u, 0u, 0u), uint4(3212836864u, 0u, 0u, 0u), uint4(3211175397u, 3202229763u, 0u, 0u), uint4(3206520068u, 3209176606u, 0u, 0u), uint4(3194215533u, 3212416226u, 0u, 0u), uint4(1046731949u, 3212416222u, 0u, 0u), uint4(1059036421u, 3209176606u, 0u, 0u), uint4(1063691749u, 3202229763u, 0u, 0u) };

			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

			static float2 fragment_input_1;
			static float2 fragment_input_0;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_0 : TEXCOORD0; // vs_TEXCOORD0
				float2 fragment_input_1 : TEXCOORD1; // vs_TEXCOORD1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static float3 fragment_unnamed_9;
			static float fragment_unnamed_32;
			static float4 fragment_unnamed_46;
			static float4 fragment_unnamed_49;
			static float4 fragment_unnamed_56;
			static float4 fragment_unnamed_73;
			static float fragment_unnamed_154;
			static float fragment_unnamed_197;
			static bool fragment_unnamed_237;
			static float fragment_unnamed_244;
			static bool fragment_unnamed_268;
			static bool fragment_unnamed_286;
			static int fragment_unnamed_332;

			void frag_main()
			{
				fragment_unnamed_9.x = _MainTex.Sample(sampler_MainTex, fragment_input_1).w;
				fragment_unnamed_32 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
				fragment_unnamed_46.w = 1.0f;
				fragment_unnamed_49.x = 0.0f;
				fragment_unnamed_49.y = 0.0f;
				fragment_unnamed_49.z = 0.0f;
				fragment_unnamed_49.w = 0.0f;
				fragment_unnamed_56.x = 0.0f;
				fragment_unnamed_56.y = 0.0f;
				fragment_unnamed_56.z = 0.0f;
				fragment_unnamed_56.w = 0.0f;
				for (int fragment_unnamed_62 = 0; fragment_unnamed_62 < 22; fragment_unnamed_62++)
				{
					float2 fragment_unnamed_151 = float2(float2(_MaxCoC, _MaxCoC)) * asfloat(fragment_unnamed_141[fragment_unnamed_62].xy);
					fragment_unnamed_73 = float4(fragment_unnamed_73.x, fragment_unnamed_151.x, fragment_unnamed_151.y, fragment_unnamed_73.w);
					fragment_unnamed_154 = dot(fragment_unnamed_73.yz, fragment_unnamed_73.yz);
					fragment_unnamed_154 = sqrt(fragment_unnamed_154);
					fragment_unnamed_73.x = fragment_unnamed_73.y * _RcpAspect;
					float2 fragment_unnamed_173 = fragment_unnamed_73.xz + fragment_input_0;
					fragment_unnamed_73 = float4(fragment_unnamed_173.x, fragment_unnamed_173.y, fragment_unnamed_73.z, fragment_unnamed_73.w);
					float2 fragment_unnamed_180 = clamp(fragment_unnamed_73.xy, 0.0f.xx, 1.0f.xx);
					fragment_unnamed_73 = float4(fragment_unnamed_180.x, fragment_unnamed_180.y, fragment_unnamed_73.z, fragment_unnamed_73.w);
					float2 fragment_unnamed_188 = fragment_unnamed_73.xy * _RenderViewportScaleFactor.xx;
					fragment_unnamed_73 = float4(fragment_unnamed_188.x, fragment_unnamed_188.y, fragment_unnamed_73.z, fragment_unnamed_73.w);
					fragment_unnamed_73 = _MainTex.Sample(sampler_MainTex, fragment_unnamed_73.xy);
					fragment_unnamed_197 = min(fragment_unnamed_9.x, fragment_unnamed_73.w);
					fragment_unnamed_197 = max(fragment_unnamed_197, 0.0f);
					fragment_unnamed_197 = (-fragment_unnamed_154) + fragment_unnamed_197;
					fragment_unnamed_197 = (_MainTex_TexelSize.y * 2.0f) + fragment_unnamed_197;
					fragment_unnamed_197 /= fragment_unnamed_32;
					fragment_unnamed_197 = clamp(fragment_unnamed_197, 0.0f, 1.0f);
					fragment_unnamed_154 = (-fragment_unnamed_154) + (-fragment_unnamed_73.w);
					fragment_unnamed_154 = (_MainTex_TexelSize.y * 2.0f) + fragment_unnamed_154;
					fragment_unnamed_154 /= fragment_unnamed_32;
					fragment_unnamed_154 = clamp(fragment_unnamed_154, 0.0f, 1.0f);
					fragment_unnamed_237 = (-fragment_unnamed_73.w) >= _MainTex_TexelSize.y;
					fragment_unnamed_244 = float(fragment_unnamed_237);
					fragment_unnamed_154 *= fragment_unnamed_244;
					fragment_unnamed_46 = float4(fragment_unnamed_73.xyz.x, fragment_unnamed_73.xyz.y, fragment_unnamed_73.xyz.z, fragment_unnamed_46.w);
					fragment_unnamed_49 = (fragment_unnamed_46 * fragment_unnamed_197.xxxx) + fragment_unnamed_49;
					fragment_unnamed_56 = (fragment_unnamed_46 * fragment_unnamed_154.xxxx) + fragment_unnamed_56;
				}
				fragment_unnamed_268 = fragment_unnamed_49.w == 0.0f;
				fragment_unnamed_9.x = float(fragment_unnamed_268);
				fragment_unnamed_9.x += fragment_unnamed_49.w;
				fragment_unnamed_9 = fragment_unnamed_49.xyz / fragment_unnamed_9.xxx;
				fragment_unnamed_286 = fragment_unnamed_56.w == 0.0f;
				fragment_unnamed_154 = float(fragment_unnamed_286);
				fragment_unnamed_154 += fragment_unnamed_56.w;
				float3 fragment_unnamed_300 = fragment_unnamed_56.xyz / fragment_unnamed_154.xxx;
				fragment_unnamed_46 = float4(fragment_unnamed_300.x, fragment_unnamed_300.y, fragment_unnamed_300.z, fragment_unnamed_46.w);
				fragment_unnamed_154 = fragment_unnamed_56.w * 0.14279966056346893310546875f;
				fragment_unnamed_154 = min(fragment_unnamed_154, 1.0f);
				float3 fragment_unnamed_313 = (-fragment_unnamed_9) + fragment_unnamed_46.xyz;
				fragment_unnamed_46 = float4(fragment_unnamed_313.x, fragment_unnamed_313.y, fragment_unnamed_313.z, fragment_unnamed_46.w);
				float3 fragment_unnamed_324 = (fragment_unnamed_154.xxx * fragment_unnamed_46.xyz) + fragment_unnamed_9;
				fragment_output_0 = float4(fragment_unnamed_324.x, fragment_unnamed_324.y, fragment_unnamed_324.z, fragment_output_0.w);
				fragment_output_0.w = fragment_unnamed_154;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_0 = stage_input.fragment_input_0;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			float _RenderViewportScaleFactor;
			float4 _MainTex_TexelSize;
			float _MaxCoC;
			float _RcpAspect;

			static float4 fragment_uniform_buffer_0[32];
			static const float fragment_unnamed_63[88] = { 0.0f, 0.0f, 0.0f, 0.0f, 0.533333361148834228515625f, 0.0f, 0.0f, 0.0f, 0.3325279057025909423828125f, 0.41697680950164794921875f, 0.0f, 0.0f, -0.118677847087383270263671875f, 0.5199615955352783203125f, 0.0f, 0.0f, -0.480516731739044189453125f, 0.23140470683574676513671875f, 0.0f, 0.0f, -0.480516731739044189453125f, -0.23140467703342437744140625f, 0.0f, 0.0f, -0.11867763102054595947265625f, -0.519961655139923095703125f, 0.0f, 0.0f, 0.3325278460979461669921875f, -0.4169768989086151123046875f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.900968849658966064453125f, 0.4338837563991546630859375f, 0.0f, 0.0f, 0.623489797115325927734375f, 0.7818315029144287109375f, 0.0f, 0.0f, 0.2225209772586822509765625f, 0.9749279022216796875f, 0.0f, 0.0f, -0.22252094745635986328125f, 0.9749279022216796875f, 0.0f, 0.0f, -0.62348997592926025390625f, 0.78183138370513916015625f, 0.0f, 0.0f, -0.900968849658966064453125f, 0.4338838160037994384765625f, 0.0f, 0.0f, -1.0f, 0.0f, 0.0f, 0.0f, -0.900968849658966064453125f, -0.4338837563991546630859375f, 0.0f, 0.0f, -0.6234896183013916015625f, -0.78183162212371826171875f, 0.0f, 0.0f, -0.22252054512500762939453125f, -0.97492802143096923828125f, 0.0f, 0.0f, 0.22252149879932403564453125f, -0.97492778301239013671875f, 0.0f, 0.0f, 0.623489677906036376953125f, -0.78183162212371826171875f, 0.0f, 0.0f, 0.900968849658966064453125f, -0.4338837563991546630859375f, 0.0f, 0.0f };

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
				float4 fragment_unnamed_77 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				float fragment_unnamed_79 = fragment_unnamed_77.w;
				precise float fragment_unnamed_88 = fragment_uniform_buffer_0[28u].y + fragment_uniform_buffer_0[28u].y;
				float fragment_unnamed_89 = asfloat(1065353216u);
				float fragment_unnamed_99;
				float fragment_unnamed_101;
				float fragment_unnamed_103;
				float fragment_unnamed_105;
				float fragment_unnamed_107;
				float fragment_unnamed_109;
				float fragment_unnamed_111;
				float fragment_unnamed_113;
				fragment_unnamed_99 = asfloat(0u);
				fragment_unnamed_101 = asfloat(0u);
				fragment_unnamed_103 = asfloat(0u);
				fragment_unnamed_105 = asfloat(0u);
				fragment_unnamed_107 = asfloat(0u);
				fragment_unnamed_109 = asfloat(0u);
				fragment_unnamed_111 = asfloat(0u);
				fragment_unnamed_113 = asfloat(0u);
				precise float fragment_unnamed_172;
				precise float fragment_unnamed_173;
				float fragment_unnamed_177;
				precise float fragment_unnamed_182;
				precise float fragment_unnamed_187;
				precise float fragment_unnamed_188;
				precise float fragment_unnamed_195;
				precise float fragment_unnamed_196;
				float4 fragment_unnamed_198;
				float fragment_unnamed_200;
				float fragment_unnamed_201;
				float fragment_unnamed_202;
				float fragment_unnamed_203;
				precise float fragment_unnamed_206;
				precise float fragment_unnamed_207;
				precise float fragment_unnamed_213;
				float fragment_unnamed_214;
				precise float fragment_unnamed_215;
				precise float fragment_unnamed_216;
				precise float fragment_unnamed_217;
				precise float fragment_unnamed_222;
				precise float fragment_unnamed_224;
				precise float fragment_unnamed_232;
				for (uint fragment_unnamed_115 = 0u; !(int(fragment_unnamed_115) >= int(22u)); fragment_unnamed_172 = fragment_uniform_buffer_0[30u].z * fragment_unnamed_63[(fragment_unnamed_115 * 4u) + 0u], fragment_unnamed_173 = fragment_uniform_buffer_0[30u].z * fragment_unnamed_63[(fragment_unnamed_115 * 4u) + 1u], fragment_unnamed_177 = sqrt(dot(float2(fragment_unnamed_172, fragment_unnamed_173), float2(fragment_unnamed_172, fragment_unnamed_173))), fragment_unnamed_182 = fragment_unnamed_172 * fragment_uniform_buffer_0[31u].x, fragment_unnamed_187 = fragment_unnamed_182 + fragment_input_1.x, fragment_unnamed_188 = fragment_unnamed_173 + fragment_input_1.y, fragment_unnamed_195 = clamp(fragment_unnamed_187, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, fragment_unnamed_196 = clamp(fragment_unnamed_188, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, fragment_unnamed_198 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_195, fragment_unnamed_196)), fragment_unnamed_200 = fragment_unnamed_198.x, fragment_unnamed_201 = fragment_unnamed_198.y, fragment_unnamed_202 = fragment_unnamed_198.z, fragment_unnamed_203 = fragment_unnamed_198.w, fragment_unnamed_206 = (-0.0f) - fragment_unnamed_177, fragment_unnamed_207 = fragment_unnamed_206 + max(min(fragment_unnamed_79, fragment_unnamed_203), 0.0f), fragment_unnamed_213 = mad(fragment_uniform_buffer_0[28u].y, 2.0f, fragment_unnamed_207) / fragment_unnamed_88, fragment_unnamed_214 = clamp(fragment_unnamed_213, 0.0f, 1.0f), fragment_unnamed_215 = (-0.0f) - fragment_unnamed_177, fragment_unnamed_216 = (-0.0f) - fragment_unnamed_203, fragment_unnamed_217 = fragment_unnamed_215 + fragment_unnamed_216, fragment_unnamed_222 = mad(fragment_uniform_buffer_0[28u].y, 2.0f, fragment_unnamed_217) / fragment_unnamed_88, fragment_unnamed_224 = (-0.0f) - fragment_unnamed_203, fragment_unnamed_232 = clamp(fragment_unnamed_222, 0.0f, 1.0f) * asfloat(((fragment_unnamed_224 >= fragment_uniform_buffer_0[28u].y) ? 4294967295u : 0u) & 1065353216u), fragment_unnamed_99 = mad(fragment_unnamed_201, fragment_unnamed_214, fragment_unnamed_99), fragment_unnamed_101 = mad(fragment_unnamed_202, fragment_unnamed_214, fragment_unnamed_101), fragment_unnamed_103 = mad(fragment_unnamed_89, fragment_unnamed_214, fragment_unnamed_103), fragment_unnamed_105 = mad(fragment_unnamed_200, fragment_unnamed_232, fragment_unnamed_105), fragment_unnamed_107 = mad(fragment_unnamed_201, fragment_unnamed_232, fragment_unnamed_107), fragment_unnamed_109 = mad(fragment_unnamed_202, fragment_unnamed_232, fragment_unnamed_109), fragment_unnamed_111 = mad(fragment_unnamed_89, fragment_unnamed_232, fragment_unnamed_111), fragment_unnamed_113 = mad(fragment_unnamed_200, fragment_unnamed_214, fragment_unnamed_113), fragment_unnamed_115++)
				{
				}
				precise float fragment_unnamed_125 = asfloat(((fragment_unnamed_103 == 0.0f) ? 4294967295u : 0u) & 1065353216u) + fragment_unnamed_103;
				precise float fragment_unnamed_126 = fragment_unnamed_113 / fragment_unnamed_125;
				precise float fragment_unnamed_127 = fragment_unnamed_99 / fragment_unnamed_125;
				precise float fragment_unnamed_128 = fragment_unnamed_101 / fragment_unnamed_125;
				precise float fragment_unnamed_133 = asfloat(((fragment_unnamed_111 == 0.0f) ? 4294967295u : 0u) & 1065353216u) + fragment_unnamed_111;
				precise float fragment_unnamed_134 = fragment_unnamed_105 / fragment_unnamed_133;
				precise float fragment_unnamed_135 = fragment_unnamed_107 / fragment_unnamed_133;
				precise float fragment_unnamed_136 = fragment_unnamed_109 / fragment_unnamed_133;
				precise float fragment_unnamed_137 = fragment_unnamed_111 * 0.14279966056346893310546875f;
				float fragment_unnamed_140 = min(fragment_unnamed_137, 1.0f);
				precise float fragment_unnamed_141 = (-0.0f) - fragment_unnamed_126;
				precise float fragment_unnamed_143 = (-0.0f) - fragment_unnamed_127;
				precise float fragment_unnamed_144 = (-0.0f) - fragment_unnamed_128;
				precise float fragment_unnamed_145 = fragment_unnamed_141 + fragment_unnamed_134;
				precise float fragment_unnamed_146 = fragment_unnamed_143 + fragment_unnamed_135;
				precise float fragment_unnamed_147 = fragment_unnamed_144 + fragment_unnamed_136;
				fragment_output_0.x = mad(fragment_unnamed_140, fragment_unnamed_145, fragment_unnamed_126);
				fragment_output_0.y = mad(fragment_unnamed_140, fragment_unnamed_146, fragment_unnamed_127);
				fragment_output_0.z = mad(fragment_unnamed_140, fragment_unnamed_147, fragment_unnamed_128);
				fragment_output_0.w = fragment_unnamed_140;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, fragment_uniform_buffer_0[26][1], fragment_uniform_buffer_0[26][2], fragment_uniform_buffer_0[26][3]);

				fragment_uniform_buffer_0[28] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				fragment_uniform_buffer_0[30] = float4(fragment_uniform_buffer_0[30][0], fragment_uniform_buffer_0[30][1], _MaxCoC, fragment_uniform_buffer_0[30][3]);

				fragment_uniform_buffer_0[31] = float4(_RcpAspect, fragment_uniform_buffer_0[31][1], fragment_uniform_buffer_0[31][2], fragment_uniform_buffer_0[31][3]);

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
			Name "Bokeh Filter (large)"
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 1035014

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
			float _MaxCoC;
			float _RcpAspect;

			static const uint4 fragment_unnamed_202[43] = { uint4(0u, 0u, 0u, 0u), uint4(1052389004u, 0u, 0u, 0u), uint4(1047013945u, 1049726997u, 0u, 0u), uint4(3181754281u, 1052083084u, 0u, 0u), uint4(3198664312u, 1042386948u, 0u, 0u), uint4(3198664312u, 3189870594u, 0u, 0u), uint4(3181754261u, 3199566733u, 0u, 0u), uint4(1047013942u, 3197210646u, 0u, 0u), uint4(1060015011u, 0u, 0u, 0u), uint4(1058882193u, 1050113794u, 0u, 0u), uint4(1054451605u, 1057519379u, 0u, 0u), uint4(1041980464u, 1059728211u, 0u, 0u), uint4(3189464110u, 1059728211u, 0u, 0u), uint4(3201935257u, 1057519378u, 0u, 0u), uint4(3206365841u, 1050113795u, 0u, 0u), uint4(3207498659u, 0u, 0u, 0u), uint4(3206365841u, 3197597442u, 0u, 0u), uint4(3201935249u, 3205003029u, 0u, 0u), uint4(3189464092u, 3207211860u, 0u, 0u), uint4(1041980487u, 3207211858u, 0u, 0u), uint4(1054451603u, 3205003029u, 0u, 0u), uint4(1058882193u, 3197597442u, 0u, 0u), uint4(1065353216u, 0u, 0u, 0u), uint4(1064607851u, 1050077735u, 0u, 0u), uint4(1062437986u, 1058026943u, 0u, 0u), uint4(1059036423u, 1061692956u, 0u, 0u), uint4(1052446201u, 1064193470u, 0u, 0u), uint4(1033440267u, 1065306304u, 0u, 0u), uint4(3194215560u, 1064932576u, 0u, 0u), uint4(3204448257u, 1063105495u, 0u, 0u), uint4(3208358219u, 1059987404u, 0u, 0u), uint4(3211175397u, 1054746117u, 0u, 0u), uint4(3212649477u, 1041800829u, 0u, 0u), uint4(3212649476u, 3189284504u, 0u, 0u), uint4(3211175397u, 3202229763u, 0u, 0u), uint4(3208358217u, 3207471054u, 0u, 0u), uint4(3204448253u, 3210589144u, 0u, 0u), uint4(3194215564u, 3212416224u, 0u, 0u), uint4(1033440306u, 3212789951u, 0u, 0u), uint4(1052446218u, 3211677115u, 0u, 0u), uint4(1059036421u, 3209176606u, 0u, 0u), uint4(1062437987u, 3205510589u, 0u, 0u), uint4(1064607853u, 3197561371u, 0u, 0u) };

			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

			static float2 fragment_input_1;
			static float2 fragment_input_0;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_0 : TEXCOORD0; // vs_TEXCOORD0
				float2 fragment_input_1 : TEXCOORD1; // vs_TEXCOORD1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static float3 fragment_unnamed_9;
			static float fragment_unnamed_32;
			static float4 fragment_unnamed_46;
			static float4 fragment_unnamed_49;
			static float4 fragment_unnamed_56;
			static float4 fragment_unnamed_73;
			static float fragment_unnamed_215;
			static float fragment_unnamed_258;
			static bool fragment_unnamed_298;
			static float fragment_unnamed_305;
			static bool fragment_unnamed_329;
			static bool fragment_unnamed_347;
			static int fragment_unnamed_393;

			void frag_main()
			{
				fragment_unnamed_9.x = _MainTex.Sample(sampler_MainTex, fragment_input_1).w;
				fragment_unnamed_32 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
				fragment_unnamed_46.w = 1.0f;
				fragment_unnamed_49.x = 0.0f;
				fragment_unnamed_49.y = 0.0f;
				fragment_unnamed_49.z = 0.0f;
				fragment_unnamed_49.w = 0.0f;
				fragment_unnamed_56.x = 0.0f;
				fragment_unnamed_56.y = 0.0f;
				fragment_unnamed_56.z = 0.0f;
				fragment_unnamed_56.w = 0.0f;
				for (int fragment_unnamed_62 = 0; fragment_unnamed_62 < 43; fragment_unnamed_62++)
				{
					float2 fragment_unnamed_212 = float2(float2(_MaxCoC, _MaxCoC)) * asfloat(fragment_unnamed_202[fragment_unnamed_62].xy);
					fragment_unnamed_73 = float4(fragment_unnamed_73.x, fragment_unnamed_212.x, fragment_unnamed_212.y, fragment_unnamed_73.w);
					fragment_unnamed_215 = dot(fragment_unnamed_73.yz, fragment_unnamed_73.yz);
					fragment_unnamed_215 = sqrt(fragment_unnamed_215);
					fragment_unnamed_73.x = fragment_unnamed_73.y * _RcpAspect;
					float2 fragment_unnamed_234 = fragment_unnamed_73.xz + fragment_input_0;
					fragment_unnamed_73 = float4(fragment_unnamed_234.x, fragment_unnamed_234.y, fragment_unnamed_73.z, fragment_unnamed_73.w);
					float2 fragment_unnamed_241 = clamp(fragment_unnamed_73.xy, 0.0f.xx, 1.0f.xx);
					fragment_unnamed_73 = float4(fragment_unnamed_241.x, fragment_unnamed_241.y, fragment_unnamed_73.z, fragment_unnamed_73.w);
					float2 fragment_unnamed_249 = fragment_unnamed_73.xy * _RenderViewportScaleFactor.xx;
					fragment_unnamed_73 = float4(fragment_unnamed_249.x, fragment_unnamed_249.y, fragment_unnamed_73.z, fragment_unnamed_73.w);
					fragment_unnamed_73 = _MainTex.Sample(sampler_MainTex, fragment_unnamed_73.xy);
					fragment_unnamed_258 = min(fragment_unnamed_9.x, fragment_unnamed_73.w);
					fragment_unnamed_258 = max(fragment_unnamed_258, 0.0f);
					fragment_unnamed_258 = (-fragment_unnamed_215) + fragment_unnamed_258;
					fragment_unnamed_258 = (_MainTex_TexelSize.y * 2.0f) + fragment_unnamed_258;
					fragment_unnamed_258 /= fragment_unnamed_32;
					fragment_unnamed_258 = clamp(fragment_unnamed_258, 0.0f, 1.0f);
					fragment_unnamed_215 = (-fragment_unnamed_215) + (-fragment_unnamed_73.w);
					fragment_unnamed_215 = (_MainTex_TexelSize.y * 2.0f) + fragment_unnamed_215;
					fragment_unnamed_215 /= fragment_unnamed_32;
					fragment_unnamed_215 = clamp(fragment_unnamed_215, 0.0f, 1.0f);
					fragment_unnamed_298 = (-fragment_unnamed_73.w) >= _MainTex_TexelSize.y;
					fragment_unnamed_305 = float(fragment_unnamed_298);
					fragment_unnamed_215 *= fragment_unnamed_305;
					fragment_unnamed_46 = float4(fragment_unnamed_73.xyz.x, fragment_unnamed_73.xyz.y, fragment_unnamed_73.xyz.z, fragment_unnamed_46.w);
					fragment_unnamed_49 = (fragment_unnamed_46 * fragment_unnamed_258.xxxx) + fragment_unnamed_49;
					fragment_unnamed_56 = (fragment_unnamed_46 * fragment_unnamed_215.xxxx) + fragment_unnamed_56;
				}
				fragment_unnamed_329 = fragment_unnamed_49.w == 0.0f;
				fragment_unnamed_9.x = float(fragment_unnamed_329);
				fragment_unnamed_9.x += fragment_unnamed_49.w;
				fragment_unnamed_9 = fragment_unnamed_49.xyz / fragment_unnamed_9.xxx;
				fragment_unnamed_347 = fragment_unnamed_56.w == 0.0f;
				fragment_unnamed_215 = float(fragment_unnamed_347);
				fragment_unnamed_215 += fragment_unnamed_56.w;
				float3 fragment_unnamed_361 = fragment_unnamed_56.xyz / fragment_unnamed_215.xxx;
				fragment_unnamed_46 = float4(fragment_unnamed_361.x, fragment_unnamed_361.y, fragment_unnamed_361.z, fragment_unnamed_46.w);
				fragment_unnamed_215 = fragment_unnamed_56.w * 0.073060296475887298583984375f;
				fragment_unnamed_215 = min(fragment_unnamed_215, 1.0f);
				float3 fragment_unnamed_374 = (-fragment_unnamed_9) + fragment_unnamed_46.xyz;
				fragment_unnamed_46 = float4(fragment_unnamed_374.x, fragment_unnamed_374.y, fragment_unnamed_374.z, fragment_unnamed_46.w);
				float3 fragment_unnamed_385 = (fragment_unnamed_215.xxx * fragment_unnamed_46.xyz) + fragment_unnamed_9;
				fragment_output_0 = float4(fragment_unnamed_385.x, fragment_unnamed_385.y, fragment_unnamed_385.z, fragment_output_0.w);
				fragment_output_0.w = fragment_unnamed_215;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_0 = stage_input.fragment_input_0;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			float _RenderViewportScaleFactor;
			float4 _MainTex_TexelSize;
			float _MaxCoC;
			float _RcpAspect;

			static float4 fragment_uniform_buffer_0[32];
			static const float fragment_unnamed_103[172] = { 0.0f, 0.0f, 0.0f, 0.0f, 0.36363637447357177734375f, 0.0f, 0.0f, 0.0f, 0.22672356665134429931640625f, 0.2843023836612701416015625f, 0.0f, 0.0f, -0.080916710197925567626953125f, 0.35451924800872802734375f, 0.0f, 0.0f, -0.3276250362396240234375f, 0.157775938510894775390625f, 0.0f, 0.0f, -0.3276250362396240234375f, -0.1577759087085723876953125f, 0.0f, 0.0f, -0.080916561186313629150390625f, -0.3545192778110504150390625f, 0.0f, 0.0f, 0.2267235219478607177734375f, -0.284302413463592529296875f, 0.0f, 0.0f, 0.681818187236785888671875f, 0.0f, 0.0f, 0.0f, 0.614296972751617431640625f, 0.295829832553863525390625f, 0.0f, 0.0f, 0.4251066744327545166015625f, 0.533066928386688232421875f, 0.0f, 0.0f, 0.1517188549041748046875f, 0.664723575115203857421875f, 0.0f, 0.0f, -0.1517188251018524169921875f, 0.664723575115203857421875f, 0.0f, 0.0f, -0.4251067936420440673828125f, 0.53306686878204345703125f, 0.0f, 0.0f, -0.614296972751617431640625f, 0.2958298623561859130859375f, 0.0f, 0.0f, -0.681818187236785888671875f, 0.0f, 0.0f, 0.0f, -0.614296972751617431640625f, -0.295829832553863525390625f, 0.0f, 0.0f, -0.4251065552234649658203125f, -0.533067047595977783203125f, 0.0f, 0.0f, -0.151718556880950927734375f, -0.6647236347198486328125f, 0.0f, 0.0f, 0.15171919763088226318359375f, -0.66472351551055908203125f, 0.0f, 0.0f, 0.4251066148281097412109375f, -0.533067047595977783203125f, 0.0f, 0.0f, 0.614296972751617431640625f, -0.295829832553863525390625f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.955572783946990966796875f, 0.2947551906108856201171875f, 0.0f, 0.0f, 0.82623875141143798828125f, 0.563320100307464599609375f, 0.0f, 0.0f, 0.623489797115325927734375f, 0.7818315029144287109375f, 0.0f, 0.0f, 0.3653409779071807861328125f, 0.93087375164031982421875f, 0.0f, 0.0f, 0.074730001389980316162109375f, 0.997203826904296875f, 0.0f, 0.0f, -0.22252094745635986328125f, 0.9749279022216796875f, 0.0f, 0.0f, -0.500000059604644775390625f, 0.866025388240814208984375f, 0.0f, 0.0f, -0.733051955699920654296875f, 0.6801726818084716796875f, 0.0f, 0.0f, -0.900968849658966064453125f, 0.4338838160037994384765625f, 0.0f, 0.0f, -0.988830864429473876953125f, 0.14904208481311798095703125f, 0.0f, 0.0f, -0.9888308048248291015625f, -0.14904248714447021484375f, 0.0f, 0.0f, -0.900968849658966064453125f, -0.4338837563991546630859375f, 0.0f, 0.0f, -0.733051836490631103515625f, -0.68017280101776123046875f, 0.0f, 0.0f, -0.4999999105930328369140625f, -0.866025447845458984375f, 0.0f, 0.0f, -0.222521007061004638671875f, -0.9749279022216796875f, 0.0f, 0.0f, 0.07473029196262359619140625f, -0.997203767299652099609375f, 0.0f, 0.0f, 0.365341484546661376953125f, -0.930873572826385498046875f, 0.0f, 0.0f, 0.623489677906036376953125f, -0.78183162212371826171875f, 0.0f, 0.0f, 0.826238811016082763671875f, -0.563319981098175048828125f, 0.0f, 0.0f, 0.955572903156280517578125f, -0.2947548329830169677734375f, 0.0f, 0.0f };

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
				float4 fragment_unnamed_117 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				float fragment_unnamed_119 = fragment_unnamed_117.w;
				precise float fragment_unnamed_128 = fragment_uniform_buffer_0[28u].y + fragment_uniform_buffer_0[28u].y;
				float fragment_unnamed_129 = asfloat(1065353216u);
				float fragment_unnamed_139;
				float fragment_unnamed_141;
				float fragment_unnamed_143;
				float fragment_unnamed_145;
				float fragment_unnamed_147;
				float fragment_unnamed_149;
				float fragment_unnamed_151;
				float fragment_unnamed_153;
				fragment_unnamed_139 = asfloat(0u);
				fragment_unnamed_141 = asfloat(0u);
				fragment_unnamed_143 = asfloat(0u);
				fragment_unnamed_145 = asfloat(0u);
				fragment_unnamed_147 = asfloat(0u);
				fragment_unnamed_149 = asfloat(0u);
				fragment_unnamed_151 = asfloat(0u);
				fragment_unnamed_153 = asfloat(0u);
				precise float fragment_unnamed_212;
				precise float fragment_unnamed_213;
				float fragment_unnamed_217;
				precise float fragment_unnamed_222;
				precise float fragment_unnamed_227;
				precise float fragment_unnamed_228;
				precise float fragment_unnamed_235;
				precise float fragment_unnamed_236;
				float4 fragment_unnamed_238;
				float fragment_unnamed_240;
				float fragment_unnamed_241;
				float fragment_unnamed_242;
				float fragment_unnamed_243;
				precise float fragment_unnamed_246;
				precise float fragment_unnamed_247;
				precise float fragment_unnamed_253;
				float fragment_unnamed_254;
				precise float fragment_unnamed_255;
				precise float fragment_unnamed_256;
				precise float fragment_unnamed_257;
				precise float fragment_unnamed_262;
				precise float fragment_unnamed_264;
				precise float fragment_unnamed_272;
				for (uint fragment_unnamed_155 = 0u; !(int(fragment_unnamed_155) >= int(43u)); fragment_unnamed_212 = fragment_uniform_buffer_0[30u].z * fragment_unnamed_103[(fragment_unnamed_155 * 4u) + 0u], fragment_unnamed_213 = fragment_uniform_buffer_0[30u].z * fragment_unnamed_103[(fragment_unnamed_155 * 4u) + 1u], fragment_unnamed_217 = sqrt(dot(float2(fragment_unnamed_212, fragment_unnamed_213), float2(fragment_unnamed_212, fragment_unnamed_213))), fragment_unnamed_222 = fragment_unnamed_212 * fragment_uniform_buffer_0[31u].x, fragment_unnamed_227 = fragment_unnamed_222 + fragment_input_1.x, fragment_unnamed_228 = fragment_unnamed_213 + fragment_input_1.y, fragment_unnamed_235 = clamp(fragment_unnamed_227, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, fragment_unnamed_236 = clamp(fragment_unnamed_228, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, fragment_unnamed_238 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_235, fragment_unnamed_236)), fragment_unnamed_240 = fragment_unnamed_238.x, fragment_unnamed_241 = fragment_unnamed_238.y, fragment_unnamed_242 = fragment_unnamed_238.z, fragment_unnamed_243 = fragment_unnamed_238.w, fragment_unnamed_246 = (-0.0f) - fragment_unnamed_217, fragment_unnamed_247 = fragment_unnamed_246 + max(min(fragment_unnamed_119, fragment_unnamed_243), 0.0f), fragment_unnamed_253 = mad(fragment_uniform_buffer_0[28u].y, 2.0f, fragment_unnamed_247) / fragment_unnamed_128, fragment_unnamed_254 = clamp(fragment_unnamed_253, 0.0f, 1.0f), fragment_unnamed_255 = (-0.0f) - fragment_unnamed_217, fragment_unnamed_256 = (-0.0f) - fragment_unnamed_243, fragment_unnamed_257 = fragment_unnamed_255 + fragment_unnamed_256, fragment_unnamed_262 = mad(fragment_uniform_buffer_0[28u].y, 2.0f, fragment_unnamed_257) / fragment_unnamed_128, fragment_unnamed_264 = (-0.0f) - fragment_unnamed_243, fragment_unnamed_272 = clamp(fragment_unnamed_262, 0.0f, 1.0f) * asfloat(((fragment_unnamed_264 >= fragment_uniform_buffer_0[28u].y) ? 4294967295u : 0u) & 1065353216u), fragment_unnamed_139 = mad(fragment_unnamed_241, fragment_unnamed_254, fragment_unnamed_139), fragment_unnamed_141 = mad(fragment_unnamed_242, fragment_unnamed_254, fragment_unnamed_141), fragment_unnamed_143 = mad(fragment_unnamed_129, fragment_unnamed_254, fragment_unnamed_143), fragment_unnamed_145 = mad(fragment_unnamed_240, fragment_unnamed_272, fragment_unnamed_145), fragment_unnamed_147 = mad(fragment_unnamed_241, fragment_unnamed_272, fragment_unnamed_147), fragment_unnamed_149 = mad(fragment_unnamed_242, fragment_unnamed_272, fragment_unnamed_149), fragment_unnamed_151 = mad(fragment_unnamed_129, fragment_unnamed_272, fragment_unnamed_151), fragment_unnamed_153 = mad(fragment_unnamed_240, fragment_unnamed_254, fragment_unnamed_153), fragment_unnamed_155++)
				{
				}
				precise float fragment_unnamed_165 = asfloat(((fragment_unnamed_143 == 0.0f) ? 4294967295u : 0u) & 1065353216u) + fragment_unnamed_143;
				precise float fragment_unnamed_166 = fragment_unnamed_153 / fragment_unnamed_165;
				precise float fragment_unnamed_167 = fragment_unnamed_139 / fragment_unnamed_165;
				precise float fragment_unnamed_168 = fragment_unnamed_141 / fragment_unnamed_165;
				precise float fragment_unnamed_173 = asfloat(((fragment_unnamed_151 == 0.0f) ? 4294967295u : 0u) & 1065353216u) + fragment_unnamed_151;
				precise float fragment_unnamed_174 = fragment_unnamed_145 / fragment_unnamed_173;
				precise float fragment_unnamed_175 = fragment_unnamed_147 / fragment_unnamed_173;
				precise float fragment_unnamed_176 = fragment_unnamed_149 / fragment_unnamed_173;
				precise float fragment_unnamed_177 = fragment_unnamed_151 * 0.073060296475887298583984375f;
				float fragment_unnamed_180 = min(fragment_unnamed_177, 1.0f);
				precise float fragment_unnamed_181 = (-0.0f) - fragment_unnamed_166;
				precise float fragment_unnamed_183 = (-0.0f) - fragment_unnamed_167;
				precise float fragment_unnamed_184 = (-0.0f) - fragment_unnamed_168;
				precise float fragment_unnamed_185 = fragment_unnamed_181 + fragment_unnamed_174;
				precise float fragment_unnamed_186 = fragment_unnamed_183 + fragment_unnamed_175;
				precise float fragment_unnamed_187 = fragment_unnamed_184 + fragment_unnamed_176;
				fragment_output_0.x = mad(fragment_unnamed_180, fragment_unnamed_185, fragment_unnamed_166);
				fragment_output_0.y = mad(fragment_unnamed_180, fragment_unnamed_186, fragment_unnamed_167);
				fragment_output_0.z = mad(fragment_unnamed_180, fragment_unnamed_187, fragment_unnamed_168);
				fragment_output_0.w = fragment_unnamed_180;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, fragment_uniform_buffer_0[26][1], fragment_uniform_buffer_0[26][2], fragment_uniform_buffer_0[26][3]);

				fragment_uniform_buffer_0[28] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				fragment_uniform_buffer_0[30] = float4(fragment_uniform_buffer_0[30][0], fragment_uniform_buffer_0[30][1], _MaxCoC, fragment_uniform_buffer_0[30][3]);

				fragment_uniform_buffer_0[31] = float4(_RcpAspect, fragment_uniform_buffer_0[31][1], fragment_uniform_buffer_0[31][2], fragment_uniform_buffer_0[31][3]);

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
			Name "Bokeh Filter (very large)"
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 1051185

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
			float _MaxCoC;
			float _RcpAspect;

			static const uint4 fragment_unnamed_267[71] = { uint4(0u, 0u, 0u, 0u), uint4(1049443788u, 0u, 0u, 0u), uint4(1043341321u, 1046272668u, 0u, 0u), uint4(3178983152u, 1049211711u, 0u, 0u), uint4(3195961881u, 1039474978u, 0u, 0u), uint4(3195961881u, 3186958623u, 0u, 0u), uint4(3178983122u, 3196695360u, 0u, 0u), uint4(1043341319u, 3193756318u, 0u, 0u), uint4(1057253870u, 0u, 0u, 0u), uint4(1055824373u, 1046859531u, 0u, 0u), uint4(1051008519u, 1053756656u, 0u, 0u), uint4(1038858241u, 1057036298u, 0u, 0u), uint4(3186341887u, 1057036298u, 0u, 0u), uint4(3198492170u, 1053756654u, 0u, 0u), uint4(3203308021u, 1046859533u, 0u, 0u), uint4(3204737518u, 0u, 0u, 0u), uint4(3203308021u, 3194343179u, 0u, 0u), uint4(3198492164u, 3201240306u, 0u, 0u), uint4(3186341859u, 3204519947u, 0u, 0u), uint4(1038858277u, 3204519945u, 0u, 0u), uint4(1051008517u, 3201240306u, 0u, 0u), uint4(1055824373u, 3194343179u, 0u, 0u), uint4(1061303543u, 0u, 0u, 0u), uint4(1060738094u, 1046804821u, 0u, 0u), uint4(1059091989u, 1054526754u, 0u, 0u), uint4(1056058378u, 1058526794u, 0u, 0u), uint4(1049487178u, 1060423736u, 0u, 0u), uint4(1030239637u, 1061267955u, 0u, 0u), uint4(3190611012u, 1060984437u, 0u, 0u), uint4(3200398585u, 1059598375u, 0u, 0u), uint4(3205389598u, 1057232927u, 0u, 0u), uint4(3207526768u, 1051231942u, 0u, 0u), uint4(3208645035u, 1038585692u, 0u, 0u), uint4(3208645035u, 3186069381u, 0u, 0u), uint4(3207526768u, 3198715588u, 0u, 0u), uint4(3205389597u, 3204716577u, 0u, 0u), uint4(3200398581u, 3207082024u, 0u, 0u), uint4(3190611015u, 3208468085u, 0u, 0u), uint4(1030239696u, 3208751602u, 0u, 0u), uint4(1049487191u, 3207907381u, 0u, 0u), uint4(1056058375u, 3206010444u, 0u, 0u), uint4(1059091990u, 3202010399u, 0u, 0u), uint4(1060738095u, 3194288451u, 0u, 0u), uint4(1065353216u, 0u, 0u, 0u), uint4(1064932576u, 1046731911u, 0u, 0u), uint4(1063691749u, 1054746115u, 0u, 0u), uint4(1061692956u, 1059036423u, 0u, 0u), uint4(1059036423u, 1061692956u, 0u, 0u), uint4(1054746111u, 1063691750u, 0u, 0u), uint4(1046731914u, 1064932576u, 0u, 0u), uint4(0u, 1065353216u, 0u, 0u), uint4(3194215560u, 1064932576u, 0u, 0u), uint4(3202229766u, 1063691749u, 0u, 0u), uint4(3206520074u, 1061692954u, 0u, 0u), uint4(3209176607u, 1059036419u, 0u, 0u), uint4(3211175397u, 1054746117u, 0u, 0u), uint4(3212416224u, 1046731911u, 0u, 0u), uint4(3212836864u, 0u, 0u, 0u), uint4(3212416224u, 3194215555u, 0u, 0u), uint4(3211175397u, 3202229763u, 0u, 0u), uint4(3209176602u, 3206520073u, 0u, 0u), uint4(3206520068u, 3209176606u, 0u, 0u), uint4(3202229753u, 3211175400u, 0u, 0u), uint4(3194215533u, 3212416226u, 0u, 0u), uint4(0u, 3212836864u, 0u, 0u), uint4(1046731949u, 3212416222u, 0u, 0u), uint4(1054746106u, 3211175399u, 0u, 0u), uint4(1059036421u, 3209176606u, 0u, 0u), uint4(1061692955u, 3206520072u, 0u, 0u), uint4(1063691749u, 3202229763u, 0u, 0u), uint4(1064932576u, 3194215554u, 0u, 0u) };

			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

			static float2 fragment_input_1;
			static float2 fragment_input_0;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_0 : TEXCOORD0; // vs_TEXCOORD0
				float2 fragment_input_1 : TEXCOORD1; // vs_TEXCOORD1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static float3 fragment_unnamed_9;
			static float fragment_unnamed_32;
			static float4 fragment_unnamed_46;
			static float4 fragment_unnamed_49;
			static float4 fragment_unnamed_56;
			static float4 fragment_unnamed_73;
			static float fragment_unnamed_280;
			static float fragment_unnamed_323;
			static bool fragment_unnamed_363;
			static float fragment_unnamed_370;
			static bool fragment_unnamed_394;
			static bool fragment_unnamed_412;
			static int fragment_unnamed_458;

			void frag_main()
			{
				fragment_unnamed_9.x = _MainTex.Sample(sampler_MainTex, fragment_input_1).w;
				fragment_unnamed_32 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
				fragment_unnamed_46.w = 1.0f;
				fragment_unnamed_49.x = 0.0f;
				fragment_unnamed_49.y = 0.0f;
				fragment_unnamed_49.z = 0.0f;
				fragment_unnamed_49.w = 0.0f;
				fragment_unnamed_56.x = 0.0f;
				fragment_unnamed_56.y = 0.0f;
				fragment_unnamed_56.z = 0.0f;
				fragment_unnamed_56.w = 0.0f;
				for (int fragment_unnamed_62 = 0; fragment_unnamed_62 < 71; fragment_unnamed_62++)
				{
					float2 fragment_unnamed_277 = float2(float2(_MaxCoC, _MaxCoC)) * asfloat(fragment_unnamed_267[fragment_unnamed_62].xy);
					fragment_unnamed_73 = float4(fragment_unnamed_73.x, fragment_unnamed_277.x, fragment_unnamed_277.y, fragment_unnamed_73.w);
					fragment_unnamed_280 = dot(fragment_unnamed_73.yz, fragment_unnamed_73.yz);
					fragment_unnamed_280 = sqrt(fragment_unnamed_280);
					fragment_unnamed_73.x = fragment_unnamed_73.y * _RcpAspect;
					float2 fragment_unnamed_299 = fragment_unnamed_73.xz + fragment_input_0;
					fragment_unnamed_73 = float4(fragment_unnamed_299.x, fragment_unnamed_299.y, fragment_unnamed_73.z, fragment_unnamed_73.w);
					float2 fragment_unnamed_306 = clamp(fragment_unnamed_73.xy, 0.0f.xx, 1.0f.xx);
					fragment_unnamed_73 = float4(fragment_unnamed_306.x, fragment_unnamed_306.y, fragment_unnamed_73.z, fragment_unnamed_73.w);
					float2 fragment_unnamed_314 = fragment_unnamed_73.xy * _RenderViewportScaleFactor.xx;
					fragment_unnamed_73 = float4(fragment_unnamed_314.x, fragment_unnamed_314.y, fragment_unnamed_73.z, fragment_unnamed_73.w);
					fragment_unnamed_73 = _MainTex.Sample(sampler_MainTex, fragment_unnamed_73.xy);
					fragment_unnamed_323 = min(fragment_unnamed_9.x, fragment_unnamed_73.w);
					fragment_unnamed_323 = max(fragment_unnamed_323, 0.0f);
					fragment_unnamed_323 = (-fragment_unnamed_280) + fragment_unnamed_323;
					fragment_unnamed_323 = (_MainTex_TexelSize.y * 2.0f) + fragment_unnamed_323;
					fragment_unnamed_323 /= fragment_unnamed_32;
					fragment_unnamed_323 = clamp(fragment_unnamed_323, 0.0f, 1.0f);
					fragment_unnamed_280 = (-fragment_unnamed_280) + (-fragment_unnamed_73.w);
					fragment_unnamed_280 = (_MainTex_TexelSize.y * 2.0f) + fragment_unnamed_280;
					fragment_unnamed_280 /= fragment_unnamed_32;
					fragment_unnamed_280 = clamp(fragment_unnamed_280, 0.0f, 1.0f);
					fragment_unnamed_363 = (-fragment_unnamed_73.w) >= _MainTex_TexelSize.y;
					fragment_unnamed_370 = float(fragment_unnamed_363);
					fragment_unnamed_280 *= fragment_unnamed_370;
					fragment_unnamed_46 = float4(fragment_unnamed_73.xyz.x, fragment_unnamed_73.xyz.y, fragment_unnamed_73.xyz.z, fragment_unnamed_46.w);
					fragment_unnamed_49 = (fragment_unnamed_46 * fragment_unnamed_323.xxxx) + fragment_unnamed_49;
					fragment_unnamed_56 = (fragment_unnamed_46 * fragment_unnamed_280.xxxx) + fragment_unnamed_56;
				}
				fragment_unnamed_394 = fragment_unnamed_49.w == 0.0f;
				fragment_unnamed_9.x = float(fragment_unnamed_394);
				fragment_unnamed_9.x += fragment_unnamed_49.w;
				fragment_unnamed_9 = fragment_unnamed_49.xyz / fragment_unnamed_9.xxx;
				fragment_unnamed_412 = fragment_unnamed_56.w == 0.0f;
				fragment_unnamed_280 = float(fragment_unnamed_412);
				fragment_unnamed_280 += fragment_unnamed_56.w;
				float3 fragment_unnamed_426 = fragment_unnamed_56.xyz / fragment_unnamed_280.xxx;
				fragment_unnamed_46 = float4(fragment_unnamed_426.x, fragment_unnamed_426.y, fragment_unnamed_426.z, fragment_unnamed_46.w);
				fragment_unnamed_280 = fragment_unnamed_56.w * 0.044247783720493316650390625f;
				fragment_unnamed_280 = min(fragment_unnamed_280, 1.0f);
				float3 fragment_unnamed_439 = (-fragment_unnamed_9) + fragment_unnamed_46.xyz;
				fragment_unnamed_46 = float4(fragment_unnamed_439.x, fragment_unnamed_439.y, fragment_unnamed_439.z, fragment_unnamed_46.w);
				float3 fragment_unnamed_450 = (fragment_unnamed_280.xxx * fragment_unnamed_46.xyz) + fragment_unnamed_9;
				fragment_output_0 = float4(fragment_unnamed_450.x, fragment_unnamed_450.y, fragment_unnamed_450.z, fragment_output_0.w);
				fragment_output_0.w = fragment_unnamed_280;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_0 = stage_input.fragment_input_0;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			float _RenderViewportScaleFactor;
			float4 _MainTex_TexelSize;
			float _MaxCoC;
			float _RcpAspect;

			static float4 fragment_uniform_buffer_0[32];
			static const float fragment_unnamed_140[284] = { 0.0f, 0.0f, 0.0f, 0.0f, 0.27586209774017333984375f, 0.0f, 0.0f, 0.0f, 0.17199720442295074462890625f, 0.215677678585052490234375f, 0.0f, 0.0f, -0.061385095119476318359375f, 0.2689456641674041748046875f, 0.0f, 0.0f, -0.24854315817356109619140625f, 0.11969210207462310791015625f, 0.0f, 0.0f, -0.24854315817356109619140625f, -0.119692079722881317138671875f, 0.0f, 0.0f, -0.061384983360767364501953125f, -0.2689456939697265625f, 0.0f, 0.0f, 0.17199717462062835693359375f, -0.2156777083873748779296875f, 0.0f, 0.0f, 0.51724135875701904296875f, 0.0f, 0.0f, 0.0f, 0.4660183489322662353515625f, 0.22442261874675750732421875f, 0.0f, 0.0f, 0.3224947154521942138671875f, 0.404395580291748046875f, 0.0f, 0.0f, 0.115097053349018096923828125f, 0.50427305698394775390625f, 0.0f, 0.0f, -0.115097038447856903076171875f, 0.50427305698394775390625f, 0.0f, 0.0f, -0.322494804859161376953125f, 0.404395520687103271484375f, 0.0f, 0.0f, -0.4660183489322662353515625f, 0.22442264854907989501953125f, 0.0f, 0.0f, -0.51724135875701904296875f, 0.0f, 0.0f, 0.0f, -0.4660183489322662353515625f, -0.22442261874675750732421875f, 0.0f, 0.0f, -0.32249462604522705078125f, -0.404395639896392822265625f, 0.0f, 0.0f, -0.115096829831600189208984375f, -0.504273116588592529296875f, 0.0f, 0.0f, 0.115097321569919586181640625f, -0.504272997379302978515625f, 0.0f, 0.0f, 0.3224946558475494384765625f, -0.404395639896392822265625f, 0.0f, 0.0f, 0.4660183489322662353515625f, -0.22442261874675750732421875f, 0.0f, 0.0f, 0.758620679378509521484375f, 0.0f, 0.0f, 0.0f, 0.72491729259490966796875f, 0.22360737621784210205078125f, 0.0f, 0.0f, 0.626801788806915283203125f, 0.427346289157867431640625f, 0.0f, 0.0f, 0.472992241382598876953125f, 0.59311354160308837890625f, 0.0f, 0.0f, 0.277155220508575439453125f, 0.706180095672607421875f, 0.0f, 0.0f, 0.0566917248070240020751953125f, 0.756499469280242919921875f, 0.0f, 0.0f, -0.168808996677398681640625f, 0.739600479602813720703125f, 0.0f, 0.0f, -0.3793103992938995361328125f, 0.656984746456146240234375f, 0.0f, 0.0f, -0.55610835552215576171875f, 0.515993058681488037109375f, 0.0f, 0.0f, -0.68349361419677734375f, 0.329153239727020263671875f, 0.0f, 0.0f, -0.750147521495819091796875f, 0.1130664050579071044921875f, 0.0f, 0.0f, -0.750147521495819091796875f, -0.113066710531711578369140625f, 0.0f, 0.0f, -0.68349361419677734375f, -0.32915318012237548828125f, 0.0f, 0.0f, -0.556108295917510986328125f, -0.515993177890777587890625f, 0.0f, 0.0f, -0.3793102800846099853515625f, -0.656984806060791015625f, 0.0f, 0.0f, -0.16880904138088226318359375f, -0.739600479602813720703125f, 0.0f, 0.0f, 0.056691944599151611328125f, -0.75649940967559814453125f, 0.0f, 0.0f, 0.2771556079387664794921875f, -0.706179916858673095703125f, 0.0f, 0.0f, 0.4729921519756317138671875f, -0.5931136608123779296875f, 0.0f, 0.0f, 0.62680184841156005859375f, -0.4273461997509002685546875f, 0.0f, 0.0f, 0.724917352199554443359375f, -0.22360710799694061279296875f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.9749279022216796875f, 0.22252093255519866943359375f, 0.0f, 0.0f, 0.900968849658966064453125f, 0.4338837563991546630859375f, 0.0f, 0.0f, 0.7818315029144287109375f, 0.623489797115325927734375f, 0.0f, 0.0f, 0.623489797115325927734375f, 0.7818315029144287109375f, 0.0f, 0.0f, 0.4338836371898651123046875f, 0.90096890926361083984375f, 0.0f, 0.0f, 0.2225209772586822509765625f, 0.9749279022216796875f, 0.0f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f, -0.22252094745635986328125f, 0.9749279022216796875f, 0.0f, 0.0f, -0.433883845806121826171875f, 0.900968849658966064453125f, 0.0f, 0.0f, -0.62348997592926025390625f, 0.78183138370513916015625f, 0.0f, 0.0f, -0.781831681728363037109375f, 0.623489558696746826171875f, 0.0f, 0.0f, -0.900968849658966064453125f, 0.4338838160037994384765625f, 0.0f, 0.0f, -0.9749279022216796875f, 0.22252093255519866943359375f, 0.0f, 0.0f, -1.0f, 0.0f, 0.0f, 0.0f, -0.9749279022216796875f, -0.22252087295055389404296875f, 0.0f, 0.0f, -0.900968849658966064453125f, -0.4338837563991546630859375f, 0.0f, 0.0f, -0.78183138370513916015625f, -0.623489916324615478515625f, 0.0f, 0.0f, -0.6234896183013916015625f, -0.78183162212371826171875f, 0.0f, 0.0f, -0.4338834583759307861328125f, -0.900969028472900390625f, 0.0f, 0.0f, -0.22252054512500762939453125f, -0.97492802143096923828125f, 0.0f, 0.0f, 0.0f, -1.0f, 0.0f, 0.0f, 0.22252149879932403564453125f, -0.97492778301239013671875f, 0.0f, 0.0f, 0.433883488178253173828125f, -0.900968968868255615234375f, 0.0f, 0.0f, 0.623489677906036376953125f, -0.78183162212371826171875f, 0.0f, 0.0f, 0.781831443309783935546875f, -0.623489856719970703125f, 0.0f, 0.0f, 0.900968849658966064453125f, -0.4338837563991546630859375f, 0.0f, 0.0f, 0.9749279022216796875f, -0.2225208580493927001953125f, 0.0f, 0.0f };

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
				float4 fragment_unnamed_154 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				float fragment_unnamed_156 = fragment_unnamed_154.w;
				precise float fragment_unnamed_165 = fragment_uniform_buffer_0[28u].y + fragment_uniform_buffer_0[28u].y;
				float fragment_unnamed_166 = asfloat(1065353216u);
				float fragment_unnamed_176;
				float fragment_unnamed_178;
				float fragment_unnamed_180;
				float fragment_unnamed_182;
				float fragment_unnamed_184;
				float fragment_unnamed_186;
				float fragment_unnamed_188;
				float fragment_unnamed_190;
				fragment_unnamed_176 = asfloat(0u);
				fragment_unnamed_178 = asfloat(0u);
				fragment_unnamed_180 = asfloat(0u);
				fragment_unnamed_182 = asfloat(0u);
				fragment_unnamed_184 = asfloat(0u);
				fragment_unnamed_186 = asfloat(0u);
				fragment_unnamed_188 = asfloat(0u);
				fragment_unnamed_190 = asfloat(0u);
				precise float fragment_unnamed_249;
				precise float fragment_unnamed_250;
				float fragment_unnamed_254;
				precise float fragment_unnamed_259;
				precise float fragment_unnamed_264;
				precise float fragment_unnamed_265;
				precise float fragment_unnamed_272;
				precise float fragment_unnamed_273;
				float4 fragment_unnamed_275;
				float fragment_unnamed_277;
				float fragment_unnamed_278;
				float fragment_unnamed_279;
				float fragment_unnamed_280;
				precise float fragment_unnamed_283;
				precise float fragment_unnamed_284;
				precise float fragment_unnamed_290;
				float fragment_unnamed_291;
				precise float fragment_unnamed_292;
				precise float fragment_unnamed_293;
				precise float fragment_unnamed_294;
				precise float fragment_unnamed_299;
				precise float fragment_unnamed_301;
				precise float fragment_unnamed_309;
				for (uint fragment_unnamed_192 = 0u; !(int(fragment_unnamed_192) >= int(71u)); fragment_unnamed_249 = fragment_uniform_buffer_0[30u].z * fragment_unnamed_140[(fragment_unnamed_192 * 4u) + 0u], fragment_unnamed_250 = fragment_uniform_buffer_0[30u].z * fragment_unnamed_140[(fragment_unnamed_192 * 4u) + 1u], fragment_unnamed_254 = sqrt(dot(float2(fragment_unnamed_249, fragment_unnamed_250), float2(fragment_unnamed_249, fragment_unnamed_250))), fragment_unnamed_259 = fragment_unnamed_249 * fragment_uniform_buffer_0[31u].x, fragment_unnamed_264 = fragment_unnamed_259 + fragment_input_1.x, fragment_unnamed_265 = fragment_unnamed_250 + fragment_input_1.y, fragment_unnamed_272 = clamp(fragment_unnamed_264, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, fragment_unnamed_273 = clamp(fragment_unnamed_265, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, fragment_unnamed_275 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_272, fragment_unnamed_273)), fragment_unnamed_277 = fragment_unnamed_275.x, fragment_unnamed_278 = fragment_unnamed_275.y, fragment_unnamed_279 = fragment_unnamed_275.z, fragment_unnamed_280 = fragment_unnamed_275.w, fragment_unnamed_283 = (-0.0f) - fragment_unnamed_254, fragment_unnamed_284 = fragment_unnamed_283 + max(min(fragment_unnamed_156, fragment_unnamed_280), 0.0f), fragment_unnamed_290 = mad(fragment_uniform_buffer_0[28u].y, 2.0f, fragment_unnamed_284) / fragment_unnamed_165, fragment_unnamed_291 = clamp(fragment_unnamed_290, 0.0f, 1.0f), fragment_unnamed_292 = (-0.0f) - fragment_unnamed_254, fragment_unnamed_293 = (-0.0f) - fragment_unnamed_280, fragment_unnamed_294 = fragment_unnamed_292 + fragment_unnamed_293, fragment_unnamed_299 = mad(fragment_uniform_buffer_0[28u].y, 2.0f, fragment_unnamed_294) / fragment_unnamed_165, fragment_unnamed_301 = (-0.0f) - fragment_unnamed_280, fragment_unnamed_309 = clamp(fragment_unnamed_299, 0.0f, 1.0f) * asfloat(((fragment_unnamed_301 >= fragment_uniform_buffer_0[28u].y) ? 4294967295u : 0u) & 1065353216u), fragment_unnamed_176 = mad(fragment_unnamed_278, fragment_unnamed_291, fragment_unnamed_176), fragment_unnamed_178 = mad(fragment_unnamed_279, fragment_unnamed_291, fragment_unnamed_178), fragment_unnamed_180 = mad(fragment_unnamed_166, fragment_unnamed_291, fragment_unnamed_180), fragment_unnamed_182 = mad(fragment_unnamed_277, fragment_unnamed_309, fragment_unnamed_182), fragment_unnamed_184 = mad(fragment_unnamed_278, fragment_unnamed_309, fragment_unnamed_184), fragment_unnamed_186 = mad(fragment_unnamed_279, fragment_unnamed_309, fragment_unnamed_186), fragment_unnamed_188 = mad(fragment_unnamed_166, fragment_unnamed_309, fragment_unnamed_188), fragment_unnamed_190 = mad(fragment_unnamed_277, fragment_unnamed_291, fragment_unnamed_190), fragment_unnamed_192++)
				{
				}
				precise float fragment_unnamed_202 = asfloat(((fragment_unnamed_180 == 0.0f) ? 4294967295u : 0u) & 1065353216u) + fragment_unnamed_180;
				precise float fragment_unnamed_203 = fragment_unnamed_190 / fragment_unnamed_202;
				precise float fragment_unnamed_204 = fragment_unnamed_176 / fragment_unnamed_202;
				precise float fragment_unnamed_205 = fragment_unnamed_178 / fragment_unnamed_202;
				precise float fragment_unnamed_210 = asfloat(((fragment_unnamed_188 == 0.0f) ? 4294967295u : 0u) & 1065353216u) + fragment_unnamed_188;
				precise float fragment_unnamed_211 = fragment_unnamed_182 / fragment_unnamed_210;
				precise float fragment_unnamed_212 = fragment_unnamed_184 / fragment_unnamed_210;
				precise float fragment_unnamed_213 = fragment_unnamed_186 / fragment_unnamed_210;
				precise float fragment_unnamed_214 = fragment_unnamed_188 * 0.044247783720493316650390625f;
				float fragment_unnamed_217 = min(fragment_unnamed_214, 1.0f);
				precise float fragment_unnamed_218 = (-0.0f) - fragment_unnamed_203;
				precise float fragment_unnamed_220 = (-0.0f) - fragment_unnamed_204;
				precise float fragment_unnamed_221 = (-0.0f) - fragment_unnamed_205;
				precise float fragment_unnamed_222 = fragment_unnamed_218 + fragment_unnamed_211;
				precise float fragment_unnamed_223 = fragment_unnamed_220 + fragment_unnamed_212;
				precise float fragment_unnamed_224 = fragment_unnamed_221 + fragment_unnamed_213;
				fragment_output_0.x = mad(fragment_unnamed_217, fragment_unnamed_222, fragment_unnamed_203);
				fragment_output_0.y = mad(fragment_unnamed_217, fragment_unnamed_223, fragment_unnamed_204);
				fragment_output_0.z = mad(fragment_unnamed_217, fragment_unnamed_224, fragment_unnamed_205);
				fragment_output_0.w = fragment_unnamed_217;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, fragment_uniform_buffer_0[26][1], fragment_uniform_buffer_0[26][2], fragment_uniform_buffer_0[26][3]);

				fragment_uniform_buffer_0[28] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				fragment_uniform_buffer_0[30] = float4(fragment_uniform_buffer_0[30][0], fragment_uniform_buffer_0[30][1], _MaxCoC, fragment_uniform_buffer_0[30][3]);

				fragment_uniform_buffer_0[31] = float4(_RcpAspect, fragment_uniform_buffer_0[31][1], fragment_uniform_buffer_0[31][2], fragment_uniform_buffer_0[31][3]);

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
			Name "Postfilter"
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 1120897

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
			static float4 fragment_unnamed_43;
			static float4 fragment_unnamed_83;

			void frag_main()
			{
				fragment_unnamed_9 = ((-_MainTex_TexelSize.xyxy) * float4(0.5f, 0.5f, -0.5f, 0.5f)) + fragment_input_0.xyxy;
				fragment_unnamed_9 = clamp(fragment_unnamed_9, 0.0f.xxxx, 1.0f.xxxx);
				fragment_unnamed_9 *= _RenderViewportScaleFactor.xxxx;
				fragment_unnamed_43 = _MainTex.Sample(sampler_MainTex, fragment_unnamed_9.xy);
				fragment_unnamed_9 = _MainTex.Sample(sampler_MainTex, fragment_unnamed_9.zw);
				fragment_unnamed_9 += fragment_unnamed_43;
				fragment_unnamed_43 = (_MainTex_TexelSize.xyxy * float4(-0.5f, 0.5f, 0.5f, 0.5f)) + fragment_input_0.xyxy;
				fragment_unnamed_43 = clamp(fragment_unnamed_43, 0.0f.xxxx, 1.0f.xxxx);
				fragment_unnamed_43 *= _RenderViewportScaleFactor.xxxx;
				fragment_unnamed_83 = _MainTex.Sample(sampler_MainTex, fragment_unnamed_43.xy);
				fragment_unnamed_43 = _MainTex.Sample(sampler_MainTex, fragment_unnamed_43.zw);
				fragment_unnamed_9 += fragment_unnamed_83;
				fragment_unnamed_9 = fragment_unnamed_43 + fragment_unnamed_9;
				fragment_output_0 = fragment_unnamed_9 * 0.25f.xxxx;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_0 = stage_input.fragment_input_0;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			float _RenderViewportScaleFactor;
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
				precise float fragment_unnamed_35 = (-0.0f) - fragment_uniform_buffer_0[28u].x;
				precise float fragment_unnamed_38 = (-0.0f) - fragment_uniform_buffer_0[28u].y;
				precise float fragment_unnamed_62 = clamp(mad(fragment_unnamed_35, 0.5f, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_63 = clamp(mad(fragment_unnamed_38, 0.5f, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_64 = clamp(mad(fragment_unnamed_35, -0.5f, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_65 = clamp(mad(fragment_unnamed_38, 0.5f, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_68 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_62, fragment_unnamed_63));
				float4 fragment_unnamed_74 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_64, fragment_unnamed_65));
				precise float fragment_unnamed_80 = fragment_unnamed_74.x + fragment_unnamed_68.x;
				precise float fragment_unnamed_81 = fragment_unnamed_74.y + fragment_unnamed_68.y;
				precise float fragment_unnamed_82 = fragment_unnamed_74.z + fragment_unnamed_68.z;
				precise float fragment_unnamed_83 = fragment_unnamed_74.w + fragment_unnamed_68.w;
				precise float fragment_unnamed_103 = clamp(mad(fragment_uniform_buffer_0[28u].x, -0.5f, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_104 = clamp(mad(fragment_uniform_buffer_0[28u].y, 0.5f, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_105 = clamp(mad(fragment_uniform_buffer_0[28u].x, 0.5f, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_106 = clamp(mad(fragment_uniform_buffer_0[28u].y, 0.5f, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_107 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_103, fragment_unnamed_104));
				float4 fragment_unnamed_113 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_105, fragment_unnamed_106));
				precise float fragment_unnamed_119 = fragment_unnamed_80 + fragment_unnamed_107.x;
				precise float fragment_unnamed_120 = fragment_unnamed_81 + fragment_unnamed_107.y;
				precise float fragment_unnamed_121 = fragment_unnamed_82 + fragment_unnamed_107.z;
				precise float fragment_unnamed_122 = fragment_unnamed_83 + fragment_unnamed_107.w;
				precise float fragment_unnamed_123 = fragment_unnamed_113.x + fragment_unnamed_119;
				precise float fragment_unnamed_124 = fragment_unnamed_113.y + fragment_unnamed_120;
				precise float fragment_unnamed_125 = fragment_unnamed_113.z + fragment_unnamed_121;
				precise float fragment_unnamed_126 = fragment_unnamed_113.w + fragment_unnamed_122;
				precise float fragment_unnamed_127 = fragment_unnamed_123 * 0.25f;
				precise float fragment_unnamed_129 = fragment_unnamed_124 * 0.25f;
				precise float fragment_unnamed_130 = fragment_unnamed_125 * 0.25f;
				precise float fragment_unnamed_131 = fragment_unnamed_126 * 0.25f;
				fragment_output_0.x = fragment_unnamed_127;
				fragment_output_0.y = fragment_unnamed_129;
				fragment_output_0.z = fragment_unnamed_130;
				fragment_output_0.w = fragment_unnamed_131;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, fragment_uniform_buffer_0[26][1], fragment_uniform_buffer_0[26][2], fragment_uniform_buffer_0[26][3]);

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
			Name "Combine"
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 1218761

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

			float4 _MainTex_TexelSize;
			float _MaxCoC;

			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;
			Texture2D<float4> _CoCTex;
			SamplerState sampler_CoCTex;
			Texture2D<float4> _DepthOfFieldTex;
			SamplerState sampler_DepthOfFieldTex;

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
			static float3 fragment_unnamed_27;
			static float4 fragment_unnamed_50;
			static bool3 fragment_unnamed_61;
			static float fragment_unnamed_133;
			static float fragment_unnamed_179;
			static bool3 fragment_unnamed_255;

			void frag_main()
			{
				fragment_unnamed_9 = _MainTex.Sample(sampler_MainTex, fragment_input_0);
				fragment_unnamed_27 = fragment_unnamed_9.xyz + 0.054999999701976776123046875f.xxx;
				fragment_unnamed_27 *= 0.947867333889007568359375f.xxx;
				fragment_unnamed_27 = max(abs(fragment_unnamed_27), 1.1920928955078125e-07f.xxx);
				fragment_unnamed_27 = log2(fragment_unnamed_27);
				fragment_unnamed_27 *= 2.400000095367431640625f.xxx;
				fragment_unnamed_27 = exp2(fragment_unnamed_27);
				float3 fragment_unnamed_55 = fragment_unnamed_9.xyz * 0.077399380505084991455078125f.xxx;
				fragment_unnamed_50 = float4(fragment_unnamed_55.x, fragment_unnamed_55.y, fragment_unnamed_55.z, fragment_unnamed_50.w);
				fragment_unnamed_61 = bool4(float4(0.040449999272823333740234375f, 0.040449999272823333740234375f, 0.040449999272823333740234375f, 0.0f).x >= fragment_unnamed_9.xyzx.x, float4(0.040449999272823333740234375f, 0.040449999272823333740234375f, 0.040449999272823333740234375f, 0.0f).y >= fragment_unnamed_9.xyzx.y, float4(0.040449999272823333740234375f, 0.040449999272823333740234375f, 0.040449999272823333740234375f, 0.0f).z >= fragment_unnamed_9.xyzx.z, float4(0.040449999272823333740234375f, 0.040449999272823333740234375f, 0.040449999272823333740234375f, 0.0f).w >= fragment_unnamed_9.xyzx.w).xyz;
				float fragment_unnamed_76;
				if (fragment_unnamed_61.x)
				{
					fragment_unnamed_76 = fragment_unnamed_50.x;
				}
				else
				{
					fragment_unnamed_76 = fragment_unnamed_27.x;
				}
				fragment_unnamed_9.x = fragment_unnamed_76;
				float fragment_unnamed_90;
				if (fragment_unnamed_61.y)
				{
					fragment_unnamed_90 = fragment_unnamed_50.y;
				}
				else
				{
					fragment_unnamed_90 = fragment_unnamed_27.y;
				}
				fragment_unnamed_9.y = fragment_unnamed_90;
				float fragment_unnamed_103;
				if (fragment_unnamed_61.z)
				{
					fragment_unnamed_103 = fragment_unnamed_50.z;
				}
				else
				{
					fragment_unnamed_103 = fragment_unnamed_27.z;
				}
				fragment_unnamed_9.z = fragment_unnamed_103;
				fragment_unnamed_27.x = _CoCTex.Sample(sampler_CoCTex, fragment_input_0).x;
				fragment_unnamed_27.x += (-0.5f);
				fragment_unnamed_27.x += fragment_unnamed_27.x;
				fragment_unnamed_133 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
				fragment_unnamed_27.x = (fragment_unnamed_27.x * _MaxCoC) + (-fragment_unnamed_133);
				fragment_unnamed_133 = 1.0f / fragment_unnamed_133;
				fragment_unnamed_27.x = fragment_unnamed_133 * fragment_unnamed_27.x;
				fragment_unnamed_27.x = clamp(fragment_unnamed_27.x, 0.0f, 1.0f);
				fragment_unnamed_133 = (fragment_unnamed_27.x * (-2.0f)) + 3.0f;
				fragment_unnamed_27.x *= fragment_unnamed_27.x;
				fragment_unnamed_179 = fragment_unnamed_27.x * fragment_unnamed_133;
				fragment_unnamed_50 = _DepthOfFieldTex.Sample(sampler_DepthOfFieldTex, fragment_input_0);
				fragment_unnamed_27.x = (fragment_unnamed_133 * fragment_unnamed_27.x) + fragment_unnamed_50.w;
				fragment_unnamed_27.x = ((-fragment_unnamed_179) * fragment_unnamed_50.w) + fragment_unnamed_27.x;
				fragment_unnamed_133 = max(fragment_unnamed_50.y, fragment_unnamed_50.x);
				fragment_unnamed_50.w = max(fragment_unnamed_50.z, fragment_unnamed_133);
				fragment_unnamed_50 = (-fragment_unnamed_9) + fragment_unnamed_50;
				fragment_unnamed_9 = (fragment_unnamed_27.xxxx * fragment_unnamed_50) + fragment_unnamed_9;
				fragment_unnamed_27 = max(abs(fragment_unnamed_9.xyz), 1.1920928955078125e-07f.xxx);
				fragment_unnamed_27 = log2(fragment_unnamed_27);
				fragment_unnamed_27 *= 0.4166666567325592041015625f.xxx;
				fragment_unnamed_27 = exp2(fragment_unnamed_27);
				fragment_unnamed_27 = (fragment_unnamed_27 * 1.05499994754791259765625f.xxx) + (-0.054999999701976776123046875f).xxx;
				float3 fragment_unnamed_252 = fragment_unnamed_9.xyz * 12.9200000762939453125f.xxx;
				fragment_unnamed_50 = float4(fragment_unnamed_252.x, fragment_unnamed_252.y, fragment_unnamed_252.z, fragment_unnamed_50.w);
				fragment_unnamed_255 = bool4(float4(0.003130800090730190277099609375f, 0.003130800090730190277099609375f, 0.003130800090730190277099609375f, 0.0f).x >= fragment_unnamed_9.xyzx.x, float4(0.003130800090730190277099609375f, 0.003130800090730190277099609375f, 0.003130800090730190277099609375f, 0.0f).y >= fragment_unnamed_9.xyzx.y, float4(0.003130800090730190277099609375f, 0.003130800090730190277099609375f, 0.003130800090730190277099609375f, 0.0f).z >= fragment_unnamed_9.xyzx.z, float4(0.003130800090730190277099609375f, 0.003130800090730190277099609375f, 0.003130800090730190277099609375f, 0.0f).w >= fragment_unnamed_9.xyzx.w).xyz;
				fragment_output_0.w = fragment_unnamed_9.w;
				float fragment_unnamed_270;
				if (fragment_unnamed_255.x)
				{
					fragment_unnamed_270 = fragment_unnamed_50.x;
				}
				else
				{
					fragment_unnamed_270 = fragment_unnamed_27.x;
				}
				fragment_output_0.x = fragment_unnamed_270;
				float fragment_unnamed_282;
				if (fragment_unnamed_255.y)
				{
					fragment_unnamed_282 = fragment_unnamed_50.y;
				}
				else
				{
					fragment_unnamed_282 = fragment_unnamed_27.y;
				}
				fragment_output_0.y = fragment_unnamed_282;
				float fragment_unnamed_294;
				if (fragment_unnamed_255.z)
				{
					fragment_unnamed_294 = fragment_unnamed_50.z;
				}
				else
				{
					fragment_unnamed_294 = fragment_unnamed_27.z;
				}
				fragment_output_0.z = fragment_unnamed_294;
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
			float _MaxCoC;

			static float4 fragment_uniform_buffer_0[31];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _CoCTex;
			Texture2D<float4> _DepthOfFieldTex;
			SamplerState sampler_MainTex;
			SamplerState sampler_CoCTex;
			SamplerState sampler_DepthOfFieldTex;

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
				precise float fragment_unnamed_53 = fragment_unnamed_49 + 0.054999999701976776123046875f;
				precise float fragment_unnamed_55 = fragment_unnamed_50 + 0.054999999701976776123046875f;
				precise float fragment_unnamed_56 = fragment_unnamed_51 + 0.054999999701976776123046875f;
				precise float fragment_unnamed_57 = fragment_unnamed_53 * 0.947867333889007568359375f;
				precise float fragment_unnamed_59 = fragment_unnamed_55 * 0.947867333889007568359375f;
				precise float fragment_unnamed_60 = fragment_unnamed_56 * 0.947867333889007568359375f;
				precise float fragment_unnamed_72 = log2(max(abs(fragment_unnamed_57), 1.1920928955078125e-07f)) * 2.400000095367431640625f;
				precise float fragment_unnamed_74 = log2(max(abs(fragment_unnamed_59), 1.1920928955078125e-07f)) * 2.400000095367431640625f;
				precise float fragment_unnamed_75 = log2(max(abs(fragment_unnamed_60), 1.1920928955078125e-07f)) * 2.400000095367431640625f;
				precise float fragment_unnamed_79 = fragment_unnamed_49 * 0.077399380505084991455078125f;
				precise float fragment_unnamed_81 = fragment_unnamed_50 * 0.077399380505084991455078125f;
				precise float fragment_unnamed_82 = fragment_unnamed_51 * 0.077399380505084991455078125f;
				float fragment_unnamed_95 = asfloat((0.040449999272823333740234375f >= fragment_unnamed_49) ? asuint(fragment_unnamed_79) : asuint(exp2(fragment_unnamed_72)));
				float fragment_unnamed_97 = asfloat((0.040449999272823333740234375f >= fragment_unnamed_50) ? asuint(fragment_unnamed_81) : asuint(exp2(fragment_unnamed_74)));
				float fragment_unnamed_99 = asfloat((0.040449999272823333740234375f >= fragment_unnamed_51) ? asuint(fragment_unnamed_82) : asuint(exp2(fragment_unnamed_75)));
				precise float fragment_unnamed_108 = _CoCTex.Sample(sampler_CoCTex, float2(fragment_input_1.x, fragment_input_1.y)).x + (-0.5f);
				precise float fragment_unnamed_110 = fragment_unnamed_108 + fragment_unnamed_108;
				precise float fragment_unnamed_119 = fragment_uniform_buffer_0[28u].y + fragment_uniform_buffer_0[28u].y;
				precise float fragment_unnamed_124 = (-0.0f) - fragment_unnamed_119;
				precise float fragment_unnamed_127 = 1.0f / fragment_unnamed_119;
				precise float fragment_unnamed_129 = fragment_unnamed_127 * mad(fragment_unnamed_110, fragment_uniform_buffer_0[30u].z, fragment_unnamed_124);
				float fragment_unnamed_130 = clamp(fragment_unnamed_129, 0.0f, 1.0f);
				float fragment_unnamed_131 = mad(fragment_unnamed_130, -2.0f, 3.0f);
				precise float fragment_unnamed_134 = fragment_unnamed_130 * fragment_unnamed_130;
				precise float fragment_unnamed_135 = fragment_unnamed_134 * fragment_unnamed_131;
				float4 fragment_unnamed_141 = _DepthOfFieldTex.Sample(sampler_DepthOfFieldTex, float2(fragment_input_1.x, fragment_input_1.y));
				float fragment_unnamed_143 = fragment_unnamed_141.x;
				float fragment_unnamed_144 = fragment_unnamed_141.y;
				float fragment_unnamed_145 = fragment_unnamed_141.z;
				float fragment_unnamed_146 = fragment_unnamed_141.w;
				precise float fragment_unnamed_148 = (-0.0f) - fragment_unnamed_135;
				float fragment_unnamed_149 = mad(fragment_unnamed_148, fragment_unnamed_146, mad(fragment_unnamed_131, fragment_unnamed_134, fragment_unnamed_146));
				precise float fragment_unnamed_152 = (-0.0f) - fragment_unnamed_95;
				precise float fragment_unnamed_153 = (-0.0f) - fragment_unnamed_97;
				precise float fragment_unnamed_154 = (-0.0f) - fragment_unnamed_99;
				precise float fragment_unnamed_155 = (-0.0f) - fragment_unnamed_52;
				precise float fragment_unnamed_156 = fragment_unnamed_152 + fragment_unnamed_143;
				precise float fragment_unnamed_157 = fragment_unnamed_153 + fragment_unnamed_144;
				precise float fragment_unnamed_158 = fragment_unnamed_154 + fragment_unnamed_145;
				precise float fragment_unnamed_159 = fragment_unnamed_155 + max(fragment_unnamed_145, max(fragment_unnamed_144, fragment_unnamed_143));
				float fragment_unnamed_160 = mad(fragment_unnamed_149, fragment_unnamed_156, fragment_unnamed_95);
				float fragment_unnamed_161 = mad(fragment_unnamed_149, fragment_unnamed_157, fragment_unnamed_97);
				float fragment_unnamed_162 = mad(fragment_unnamed_149, fragment_unnamed_158, fragment_unnamed_99);
				precise float fragment_unnamed_173 = log2(max(abs(fragment_unnamed_160), 1.1920928955078125e-07f)) * 0.4166666567325592041015625f;
				precise float fragment_unnamed_175 = log2(max(abs(fragment_unnamed_161), 1.1920928955078125e-07f)) * 0.4166666567325592041015625f;
				precise float fragment_unnamed_176 = log2(max(abs(fragment_unnamed_162), 1.1920928955078125e-07f)) * 0.4166666567325592041015625f;
				precise float fragment_unnamed_185 = fragment_unnamed_160 * 12.9200000762939453125f;
				precise float fragment_unnamed_187 = fragment_unnamed_161 * 12.9200000762939453125f;
				precise float fragment_unnamed_188 = fragment_unnamed_162 * 12.9200000762939453125f;
				fragment_output_0.w = mad(fragment_unnamed_149, fragment_unnamed_159, fragment_unnamed_52);
				fragment_output_0.x = (0.003130800090730190277099609375f >= fragment_unnamed_160) ? fragment_unnamed_185 : mad(exp2(fragment_unnamed_173), 1.05499994754791259765625f, -0.054999999701976776123046875f);
				fragment_output_0.y = (0.003130800090730190277099609375f >= fragment_unnamed_161) ? fragment_unnamed_187 : mad(exp2(fragment_unnamed_175), 1.05499994754791259765625f, -0.054999999701976776123046875f);
				fragment_output_0.z = (0.003130800090730190277099609375f >= fragment_unnamed_162) ? fragment_unnamed_188 : mad(exp2(fragment_unnamed_176), 1.05499994754791259765625f, -0.054999999701976776123046875f);
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[28] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				fragment_uniform_buffer_0[30] = float4(fragment_uniform_buffer_0[30][0], fragment_uniform_buffer_0[30][1], _MaxCoC, fragment_uniform_buffer_0[30][3]);

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
			Name "Debug Overlay"
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 1269419

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

			float4 _ZBufferParams;
			float _Distance;
			float _LensCoeff;

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

			static float4 fragment_unnamed_9;
			static float fragment_unnamed_52;
			static float3 fragment_unnamed_98;
			static float fragment_unnamed_122;

			void frag_main()
			{
				fragment_unnamed_9.x = _CameraDepthTexture.Sample(sampler_CameraDepthTexture, fragment_input_0).x;
				fragment_unnamed_9.x = (_ZBufferParams.z * fragment_unnamed_9.x) + _ZBufferParams.w;
				fragment_unnamed_9.x = 1.0f / fragment_unnamed_9.x;
				fragment_unnamed_52 = fragment_unnamed_9.x + (-_Distance);
				fragment_unnamed_52 *= _LensCoeff;
				fragment_unnamed_9.x = fragment_unnamed_52 / fragment_unnamed_9.x;
				fragment_unnamed_9.x *= 80.0f;
				fragment_unnamed_52 = fragment_unnamed_9.x;
				fragment_unnamed_52 = clamp(fragment_unnamed_52, 0.0f, 1.0f);
				fragment_unnamed_9.x = -fragment_unnamed_9.x;
				fragment_unnamed_9.x = clamp(fragment_unnamed_9.x, 0.0f, 1.0f);
				float3 fragment_unnamed_94 = (fragment_unnamed_9.xxx * float3(0.0f, 1.0f, 1.0f)) + float3(1.0f, 0.0f, 0.0f);
				fragment_unnamed_9 = float4(fragment_unnamed_94.x, fragment_unnamed_9.y, fragment_unnamed_94.y, fragment_unnamed_94.z);
				fragment_unnamed_98 = (-fragment_unnamed_9.xww) + 0.4000000059604644775390625f.xxx;
				float3 fragment_unnamed_111 = (fragment_unnamed_52.xxx * fragment_unnamed_98) + fragment_unnamed_9.xzw;
				fragment_unnamed_9 = float4(fragment_unnamed_111.x, fragment_unnamed_111.y, fragment_unnamed_111.z, fragment_unnamed_9.w);
				fragment_unnamed_98 = _MainTex.Sample(sampler_MainTex, fragment_input_0).xyz;
				fragment_unnamed_122 = dot(fragment_unnamed_98, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f));
				fragment_unnamed_122 += 0.5f;
				float3 fragment_unnamed_138 = fragment_unnamed_122.xxx * fragment_unnamed_9.xyz;
				fragment_output_0 = float4(fragment_unnamed_138.x, fragment_unnamed_138.y, fragment_unnamed_138.z, fragment_output_0.w);
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


			float4 _ZBufferParams;
			float _Distance;
			float _LensCoeff;

			static float4 fragment_uniform_buffer_0[31];
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
				precise float fragment_unnamed_56 = 1.0f / mad(fragment_uniform_buffer_0[21u].z, _CameraDepthTexture.Sample(sampler_CameraDepthTexture, float2(fragment_input_1.x, fragment_input_1.y)).x, fragment_uniform_buffer_0[21u].w);
				precise float fragment_unnamed_62 = (-0.0f) - fragment_uniform_buffer_0[30u].x;
				precise float fragment_unnamed_64 = fragment_unnamed_56 + fragment_unnamed_62;
				precise float fragment_unnamed_68 = fragment_unnamed_64 * fragment_uniform_buffer_0[30u].y;
				precise float fragment_unnamed_69 = fragment_unnamed_68 / fragment_unnamed_56;
				precise float fragment_unnamed_70 = fragment_unnamed_69 * 80.0f;
				float fragment_unnamed_72 = clamp(fragment_unnamed_70, 0.0f, 1.0f);
				precise float fragment_unnamed_73 = (-0.0f) - fragment_unnamed_70;
				float fragment_unnamed_74 = clamp(fragment_unnamed_73, 0.0f, 1.0f);
				float fragment_unnamed_75 = mad(fragment_unnamed_74, 0.0f, 1.0f);
				float fragment_unnamed_77 = mad(fragment_unnamed_74, 1.0f, 0.0f);
				precise float fragment_unnamed_78 = (-0.0f) - fragment_unnamed_75;
				precise float fragment_unnamed_79 = (-0.0f) - fragment_unnamed_77;
				precise float fragment_unnamed_80 = fragment_unnamed_78 + 0.4000000059604644775390625f;
				precise float fragment_unnamed_82 = fragment_unnamed_79 + 0.4000000059604644775390625f;
				precise float fragment_unnamed_83 = fragment_unnamed_79 + 0.4000000059604644775390625f;
				precise float fragment_unnamed_104 = dot(float3(_MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y)).xyz), float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)) + 0.5f;
				precise float fragment_unnamed_106 = fragment_unnamed_104 * mad(fragment_unnamed_72, fragment_unnamed_80, fragment_unnamed_75);
				precise float fragment_unnamed_107 = fragment_unnamed_104 * mad(fragment_unnamed_72, fragment_unnamed_82, mad(fragment_unnamed_74, 1.0f, 0.0f));
				precise float fragment_unnamed_108 = fragment_unnamed_104 * mad(fragment_unnamed_72, fragment_unnamed_83, fragment_unnamed_77);
				fragment_output_0.x = fragment_unnamed_106;
				fragment_output_0.y = fragment_unnamed_107;
				fragment_output_0.z = fragment_unnamed_108;
				fragment_output_0.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[21] = float4(_ZBufferParams[0], _ZBufferParams[1], _ZBufferParams[2], _ZBufferParams[3]);

				fragment_uniform_buffer_0[30] = float4(_Distance, fragment_uniform_buffer_0[30][1], fragment_uniform_buffer_0[30][2], fragment_uniform_buffer_0[30][3]);

				fragment_uniform_buffer_0[30] = float4(fragment_uniform_buffer_0[30][0], _LensCoeff, fragment_uniform_buffer_0[30][2], fragment_uniform_buffer_0[30][3]);

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
