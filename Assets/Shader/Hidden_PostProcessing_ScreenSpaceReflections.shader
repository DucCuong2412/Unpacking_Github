Shader "Hidden/PostProcessing/ScreenSpaceReflections"
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
			GpuProgramID 60921

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0


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
				vertex_output_1.x = mad(vertex_input_0.x + 1.0f, 0.5f, 0.0f);
				vertex_output_1.y = mad(vertex_input_0.y + 1.0f, -0.5f, 1.0f);
				vertex_output_1.x = mad(vertex_input_0.x + 1.0f, 0.5f, 0.0f);
				vertex_output_1.y = mad(vertex_input_0.y + 1.0f, -0.5f, 1.0f);
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}


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
				float2 vertex_output_0 : TEXCOORD0; // vs_TEXCOORD0
				float2 vertex_output_1 : TEXCOORD1; // vs_TEXCOORD1
				float4 gl_Position : SV_Position;
			};

			static float4 vertex_unnamed_33;
			static float4 vertex_unnamed_38;

			void vert_main()
			{
				gl_Position = float4(vertex_input_0.xy.x, vertex_input_0.xy.y, gl_Position.z, gl_Position.w);
				gl_Position = float4(gl_Position.x, gl_Position.y, float2(0.0f, 1.0f).x, float2(0.0f, 1.0f).y);
				vertex_unnamed_33 = vertex_input_0.xyxy + 1.0f.xxxx;
				vertex_unnamed_38 = (vertex_unnamed_33 * float4(0.5f, -0.5f, 0.5f, -0.5f)) + float4(0.0f, 1.0f, 0.0f, 1.0f);
				vertex_output_0 = vertex_unnamed_38.xy;
				vertex_output_1 = vertex_unnamed_38.zw;
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

			float3 _WorldSpaceCameraPos;
			float4 _ProjectionParams;
			float4 _ZBufferParams;
			float4 _Test_TexelSize;
			float4x4 _ViewMatrix;
			float4x4 _InverseProjectionMatrix;
			float4x4 _ScreenSpaceProjectionMatrix;
			float4 _Params;
			float4 _Params2;

			static float4 _ViewMatrix__array[4];
			static float4 _InverseProjectionMatrix__array[4];
			static float4 _ScreenSpaceProjectionMatrix__array[4];
			Texture2D<float4> _CameraGBufferTexture2;
			SamplerState sampler_CameraGBufferTexture2;
			Texture2D<float4> _CameraDepthTexture;
			SamplerState sampler_CameraDepthTexture;
			Texture2D<float4> _Noise;
			SamplerState sampler_Noise;

			static float2 fragment_input_1;
			static float4 fragment_output_0;
			static float2 fragment_input_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_0 : TEXCOORD0; // vs_TEXCOORD0
				float2 fragment_input_1 : TEXCOORD1; // vs_TEXCOORD1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static float4 fragment_unnamed_9;
			static float fragment_unnamed_26;
			static bool fragment_unnamed_33;
			static float4 fragment_unnamed_55;
			static float4 fragment_unnamed_65;
			static float fragment_unnamed_231;
			static float4 fragment_unnamed_272;
			static float4 fragment_unnamed_335;
			static float4 fragment_unnamed_342;
			static bool fragment_unnamed_365;
			static float fragment_unnamed_373;
			static int fragment_unnamed_418;
			static int fragment_unnamed_425;
			static float2 fragment_unnamed_444;
			static float4 fragment_unnamed_544;
			static float4 fragment_unnamed_546;
			static int fragment_unnamed_552;
			static bool fragment_unnamed_562;
			static float4 fragment_unnamed_568;
			static bool fragment_unnamed_596;
			static bool fragment_unnamed_676;

			void frag_main()
			{
				fragment_unnamed_9 = _CameraGBufferTexture2.Sample(sampler_CameraGBufferTexture2, fragment_input_1);
				fragment_unnamed_26 = dot(fragment_unnamed_9, 1.0f.xxxx);
				fragment_unnamed_33 = fragment_unnamed_26 == 0.0f;
				if (fragment_unnamed_33)
				{
					fragment_output_0 = 0.0f.xxxx;
					return;
				}
				fragment_unnamed_26 = _CameraDepthTexture.SampleLevel(sampler_CameraDepthTexture, fragment_input_0, 0.0f).x;
				float2 fragment_unnamed_62 = (fragment_input_0 * 2.0f.xx) + (-1.0f).xx;
				fragment_unnamed_55 = float4(fragment_unnamed_62.x, fragment_unnamed_62.y, fragment_unnamed_55.z, fragment_unnamed_55.w);
				fragment_unnamed_65 = fragment_unnamed_55.yyyy * _InverseProjectionMatrix__array[1];
				fragment_unnamed_55 = (_InverseProjectionMatrix__array[0] * fragment_unnamed_55.xxxx) + fragment_unnamed_65;
				fragment_unnamed_55 = (_InverseProjectionMatrix__array[2] * fragment_unnamed_26.xxxx) + fragment_unnamed_55;
				fragment_unnamed_55 += _InverseProjectionMatrix__array[3];
				float3 fragment_unnamed_108 = fragment_unnamed_55.xyz / fragment_unnamed_55.www;
				fragment_unnamed_55 = float4(fragment_unnamed_108.x, fragment_unnamed_108.y, fragment_unnamed_108.z, fragment_unnamed_55.w);
				fragment_unnamed_33 = fragment_unnamed_55.z < (-_Params.z);
				if (fragment_unnamed_33)
				{
					fragment_output_0 = 0.0f.xxxx;
					return;
				}
				float3 fragment_unnamed_129 = (fragment_unnamed_9.xyz * 2.0f.xxx) + (-1.0f).xxx;
				fragment_unnamed_9 = float4(fragment_unnamed_129.x, fragment_unnamed_129.y, fragment_unnamed_129.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_138 = fragment_unnamed_9.yyy * _ViewMatrix__array[1].xyz;
				fragment_unnamed_65 = float4(fragment_unnamed_138.x, fragment_unnamed_138.y, fragment_unnamed_138.z, fragment_unnamed_65.w);
				float3 fragment_unnamed_149 = (_ViewMatrix__array[0].xyz * fragment_unnamed_9.xxx) + fragment_unnamed_65.xyz;
				fragment_unnamed_9 = float4(fragment_unnamed_149.x, fragment_unnamed_149.y, fragment_unnamed_9.z, fragment_unnamed_149.z);
				float3 fragment_unnamed_160 = (_ViewMatrix__array[2].xyz * fragment_unnamed_9.zzz) + fragment_unnamed_9.xyw;
				fragment_unnamed_9 = float4(fragment_unnamed_160.x, fragment_unnamed_160.y, fragment_unnamed_160.z, fragment_unnamed_9.w);
				fragment_unnamed_26 = dot(fragment_unnamed_55.xyz, fragment_unnamed_55.xyz);
				fragment_unnamed_26 = rsqrt(fragment_unnamed_26);
				float3 fragment_unnamed_174 = fragment_unnamed_26.xxx * fragment_unnamed_55.xyz;
				fragment_unnamed_65 = float4(fragment_unnamed_174.x, fragment_unnamed_174.y, fragment_unnamed_174.z, fragment_unnamed_65.w);
				fragment_unnamed_26 = dot(fragment_unnamed_65.xyz, fragment_unnamed_9.xyz);
				fragment_unnamed_26 += fragment_unnamed_26;
				float3 fragment_unnamed_193 = (fragment_unnamed_9.xyz * (-fragment_unnamed_26.xxx)) + fragment_unnamed_65.xyz;
				fragment_unnamed_9 = float4(fragment_unnamed_193.x, fragment_unnamed_193.y, fragment_unnamed_193.z, fragment_unnamed_9.w);
				fragment_unnamed_26 = dot(fragment_unnamed_9.xyz, fragment_unnamed_9.xyz);
				fragment_unnamed_26 = rsqrt(fragment_unnamed_26);
				float3 fragment_unnamed_207 = fragment_unnamed_26.xxx * fragment_unnamed_9.xyz;
				fragment_unnamed_9 = float4(fragment_unnamed_207.x, fragment_unnamed_207.y, fragment_unnamed_207.z, fragment_unnamed_9.w);
				fragment_unnamed_33 = 0.0f < fragment_unnamed_9.z;
				if (fragment_unnamed_33)
				{
					fragment_output_0 = 0.0f.xxxx;
					return;
				}
				fragment_unnamed_26 = (fragment_unnamed_9.z * _Params.z) + fragment_unnamed_55.z;
				fragment_unnamed_33 = (-_ProjectionParams.y) < fragment_unnamed_26;
				fragment_unnamed_231 = (-fragment_unnamed_55.z) + (-_ProjectionParams.y);
				fragment_unnamed_231 /= fragment_unnamed_9.z;
				float fragment_unnamed_245;
				if (fragment_unnamed_33)
				{
					fragment_unnamed_245 = fragment_unnamed_231;
				}
				else
				{
					fragment_unnamed_245 = _Params.z;
				}
				fragment_unnamed_26 = fragment_unnamed_245;
				float3 fragment_unnamed_260 = (fragment_unnamed_9.xyz * fragment_unnamed_26.xxx) + fragment_unnamed_55.xyz;
				fragment_unnamed_9 = float4(fragment_unnamed_260.x, fragment_unnamed_260.y, fragment_unnamed_260.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_269 = fragment_unnamed_55.zzz * _ScreenSpaceProjectionMatrix__array[2].xyw;
				fragment_unnamed_65 = float4(fragment_unnamed_269.x, fragment_unnamed_269.y, fragment_unnamed_269.z, fragment_unnamed_65.w);
				fragment_unnamed_272.z = (_ScreenSpaceProjectionMatrix__array[0].x * fragment_unnamed_55.x) + fragment_unnamed_65.x;
				fragment_unnamed_272.w = (_ScreenSpaceProjectionMatrix__array[1].y * fragment_unnamed_55.y) + fragment_unnamed_65.y;
				float3 fragment_unnamed_297 = fragment_unnamed_9.zzz * _ScreenSpaceProjectionMatrix__array[2].xyw;
				fragment_unnamed_55 = float4(fragment_unnamed_297.x, fragment_unnamed_297.y, fragment_unnamed_55.z, fragment_unnamed_297.z);
				fragment_unnamed_272.x = (_ScreenSpaceProjectionMatrix__array[0].x * fragment_unnamed_9.x) + fragment_unnamed_55.x;
				fragment_unnamed_272.y = (_ScreenSpaceProjectionMatrix__array[1].y * fragment_unnamed_9.y) + fragment_unnamed_55.y;
				float2 fragment_unnamed_324 = 1.0f.xx / float2(fragment_unnamed_65.zz);
				fragment_unnamed_65 = float4(fragment_unnamed_65.x, fragment_unnamed_65.y, fragment_unnamed_324.x, fragment_unnamed_324.y);
				float2 fragment_unnamed_332 = 1.0f.xx / float2(fragment_unnamed_55.ww);
				fragment_unnamed_65 = float4(fragment_unnamed_332.x, fragment_unnamed_332.y, fragment_unnamed_65.z, fragment_unnamed_65.w);
				fragment_unnamed_335.w = fragment_unnamed_55.z * fragment_unnamed_65.w;
				fragment_unnamed_342 = fragment_unnamed_65.wzxy * fragment_unnamed_272.wzxy;
				float2 fragment_unnamed_356 = (fragment_unnamed_272.zw * fragment_unnamed_65.zw) + (-fragment_unnamed_342.zw);
				fragment_unnamed_9 = float4(fragment_unnamed_356.x, fragment_unnamed_356.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
				fragment_unnamed_9.x = dot(fragment_unnamed_9.xy, fragment_unnamed_9.xy);
				fragment_unnamed_365 = 9.9999997473787516355514526367188e-05f >= fragment_unnamed_9.x;
				fragment_unnamed_9.x = float(fragment_unnamed_365);
				fragment_unnamed_373 = max(_Test_TexelSize.y, _Test_TexelSize.x);
				float2 fragment_unnamed_386 = (fragment_unnamed_9.xx * fragment_unnamed_373.xx) + fragment_unnamed_342.wz;
				fragment_unnamed_9 = float4(fragment_unnamed_386.x, fragment_unnamed_386.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
				float2 fragment_unnamed_397 = ((-fragment_unnamed_272.wz) * fragment_unnamed_65.wz) + fragment_unnamed_9.xy;
				fragment_unnamed_342 = float4(fragment_unnamed_342.x, fragment_unnamed_342.y, fragment_unnamed_397.x, fragment_unnamed_397.y);
				fragment_unnamed_365 = abs(fragment_unnamed_342.w) < abs(fragment_unnamed_342.z);
				float4 fragment_unnamed_409;
				if (fragment_unnamed_365)
				{
					fragment_unnamed_409 = fragment_unnamed_342;
				}
				else
				{
					fragment_unnamed_409 = fragment_unnamed_342.yxwz;
				}
				fragment_unnamed_272 = fragment_unnamed_409;
				fragment_unnamed_418 = int((0.0f < fragment_unnamed_272.z) ? 4294967295u : 0u);
				fragment_unnamed_425 = int((fragment_unnamed_272.z < 0.0f) ? 4294967295u : 0u);
				fragment_unnamed_418 = (-fragment_unnamed_418) + fragment_unnamed_425;
				fragment_unnamed_342.x = float(fragment_unnamed_418);
				fragment_unnamed_373 = fragment_unnamed_342.x / fragment_unnamed_272.z;
				fragment_unnamed_444.x = (fragment_unnamed_9.z * fragment_unnamed_65.y) + (-fragment_unnamed_335.w);
				fragment_unnamed_342.w = fragment_unnamed_373 * fragment_unnamed_444.x;
				fragment_unnamed_342.y = fragment_unnamed_373 * fragment_unnamed_272.w;
				fragment_unnamed_444.x = (-fragment_unnamed_65.w) + fragment_unnamed_65.y;
				fragment_unnamed_342.z = fragment_unnamed_373 * fragment_unnamed_444.x;
				fragment_unnamed_373 = fragment_unnamed_55.z * (-0.00999999977648258209228515625f);
				fragment_unnamed_373 = min(fragment_unnamed_373, 1.0f);
				fragment_unnamed_373 = (-fragment_unnamed_373) + 1.0f;
				float2 fragment_unnamed_491 = fragment_input_0 * _Params2.yy;
				fragment_unnamed_55 = float4(fragment_unnamed_491.x, fragment_unnamed_491.y, fragment_unnamed_55.z, fragment_unnamed_55.w);
				fragment_unnamed_55.z = fragment_unnamed_55.y * _Params2.x;
				fragment_unnamed_444 = fragment_unnamed_55.xz + _WorldSpaceCameraPos.xz;
				fragment_unnamed_444.x = _Noise.SampleLevel(sampler_Noise, fragment_unnamed_444, 0.0f).w;
				fragment_unnamed_373 *= _Params2.z;
				fragment_unnamed_55 = fragment_unnamed_373.xxxx * fragment_unnamed_342;
				fragment_unnamed_335 = float4(fragment_unnamed_272.xy.x, fragment_unnamed_272.xy.y, fragment_unnamed_335.z, fragment_unnamed_335.w);
				fragment_unnamed_335.z = fragment_unnamed_65.w;
				fragment_unnamed_65 = (fragment_unnamed_55 * fragment_unnamed_444.xxxx) + fragment_unnamed_335;
				fragment_unnamed_272.x = asfloat(-1);
				fragment_unnamed_335.x = 0.0f;
				fragment_unnamed_335.y = 0.0f;
				fragment_unnamed_335.z = 0.0f;
				fragment_unnamed_335.w = 0.0f;
				fragment_unnamed_544 = fragment_unnamed_65;
				fragment_unnamed_546.x = 0.0f;
				fragment_unnamed_546.y = 0.0f;
				fragment_unnamed_546.z = 0.0f;
				fragment_unnamed_546.w = 0.0f;
				fragment_unnamed_444.x = 0.0f;
				fragment_unnamed_425 = 0;
				fragment_unnamed_552 = 0;
				float fragment_unnamed_603;
				float2 fragment_unnamed_615;
				while (true)
				{
					fragment_unnamed_55.x = float(fragment_unnamed_425);
					fragment_unnamed_562 = fragment_unnamed_55.x >= _Params2.w;
					fragment_unnamed_568.x = 0.0f;
					if (fragment_unnamed_562)
					{
						break;
					}
					fragment_unnamed_544 = (fragment_unnamed_342 * fragment_unnamed_373.xxxx) + fragment_unnamed_544;
					float2 fragment_unnamed_587 = (fragment_unnamed_55.wz * 0.5f.xx) + fragment_unnamed_544.wz;
					fragment_unnamed_55 = float4(fragment_unnamed_587.x, fragment_unnamed_587.y, fragment_unnamed_55.z, fragment_unnamed_55.w);
					fragment_unnamed_55.x /= fragment_unnamed_55.y;
					fragment_unnamed_596 = fragment_unnamed_444.x < fragment_unnamed_55.x;
					if (fragment_unnamed_596)
					{
						fragment_unnamed_603 = fragment_unnamed_444.x;
					}
					else
					{
						fragment_unnamed_603 = fragment_unnamed_55.x;
					}
					fragment_unnamed_444.x = fragment_unnamed_603;
					if (fragment_unnamed_365)
					{
						fragment_unnamed_615 = fragment_unnamed_544.yx;
					}
					else
					{
						fragment_unnamed_615 = fragment_unnamed_544.xy;
					}
					fragment_unnamed_55 = float4(fragment_unnamed_615.x, fragment_unnamed_615.y, fragment_unnamed_55.z, fragment_unnamed_55.w);
					float2 fragment_unnamed_631 = fragment_unnamed_55.xy * _Test_TexelSize.xy;
					fragment_unnamed_272 = float4(fragment_unnamed_272.x, fragment_unnamed_631.x, fragment_unnamed_631.y, fragment_unnamed_272.w);
					fragment_unnamed_55.x = _CameraDepthTexture.SampleLevel(sampler_CameraDepthTexture, fragment_unnamed_272.yz, 0.0f).x;
					fragment_unnamed_55.x = (_ZBufferParams.z * fragment_unnamed_55.x) + _ZBufferParams.w;
					fragment_unnamed_55.x = 1.0f / fragment_unnamed_55.x;
					fragment_unnamed_562 = fragment_unnamed_444.x < (-fragment_unnamed_55.x);
					fragment_unnamed_272.w = asfloat(fragment_unnamed_425 + 1);
					bool4 fragment_unnamed_668 = fragment_unnamed_562.xxxx;
					fragment_unnamed_568 = float4(fragment_unnamed_668.x ? fragment_unnamed_272.x : 0.0f.xxxx.x, fragment_unnamed_668.y ? fragment_unnamed_272.y : 0.0f.xxxx.y, fragment_unnamed_668.z ? fragment_unnamed_272.z : 0.0f.xxxx.z, fragment_unnamed_668.w ? fragment_unnamed_272.w : 0.0f.xxxx.w);
					fragment_unnamed_335 = fragment_unnamed_568;
					fragment_unnamed_546 = fragment_unnamed_568;
					if (fragment_unnamed_562)
					{
						break;
					}
					fragment_unnamed_676 = fragment_unnamed_562;
					fragment_unnamed_425++;
					fragment_unnamed_335.x = 0.0f;
					fragment_unnamed_335.y = 0.0f;
					fragment_unnamed_335.z = 0.0f;
					fragment_unnamed_335.w = 0.0f;
					fragment_unnamed_546.x = 0.0f;
					fragment_unnamed_546.y = 0.0f;
					fragment_unnamed_546.z = 0.0f;
					fragment_unnamed_546.w = 0.0f;
				}
				bool4 fragment_unnamed_694 = (asint(fragment_unnamed_568.x) != 0).xxxx;
				fragment_unnamed_9 = float4(fragment_unnamed_694.x ? fragment_unnamed_335.x : fragment_unnamed_546.x, fragment_unnamed_694.y ? fragment_unnamed_335.y : fragment_unnamed_546.y, fragment_unnamed_694.z ? fragment_unnamed_335.z : fragment_unnamed_546.z, fragment_unnamed_694.w ? fragment_unnamed_335.w : fragment_unnamed_546.w);
				fragment_unnamed_26 = float(asint(fragment_unnamed_9.w));
				fragment_output_0.z = fragment_unnamed_26 / _Params2.w;
				fragment_output_0.w = asfloat(asuint(fragment_unnamed_9.x) & 1065353216u);
				fragment_output_0 = float4(fragment_unnamed_9.yz.x, fragment_unnamed_9.yz.y, fragment_output_0.z, fragment_output_0.w);
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				_ViewMatrix__array[0] = float4(_ViewMatrix[0][0], _ViewMatrix[1][0], _ViewMatrix[2][0], _ViewMatrix[3][0]);
				_ViewMatrix__array[1] = float4(_ViewMatrix[0][1], _ViewMatrix[1][1], _ViewMatrix[2][1], _ViewMatrix[3][1]);
				_ViewMatrix__array[2] = float4(_ViewMatrix[0][2], _ViewMatrix[1][2], _ViewMatrix[2][2], _ViewMatrix[3][2]);
				_ViewMatrix__array[3] = float4(_ViewMatrix[0][3], _ViewMatrix[1][3], _ViewMatrix[2][3], _ViewMatrix[3][3]);

				_InverseProjectionMatrix__array[0] = float4(_InverseProjectionMatrix[0][0], _InverseProjectionMatrix[1][0], _InverseProjectionMatrix[2][0], _InverseProjectionMatrix[3][0]);
				_InverseProjectionMatrix__array[1] = float4(_InverseProjectionMatrix[0][1], _InverseProjectionMatrix[1][1], _InverseProjectionMatrix[2][1], _InverseProjectionMatrix[3][1]);
				_InverseProjectionMatrix__array[2] = float4(_InverseProjectionMatrix[0][2], _InverseProjectionMatrix[1][2], _InverseProjectionMatrix[2][2], _InverseProjectionMatrix[3][2]);
				_InverseProjectionMatrix__array[3] = float4(_InverseProjectionMatrix[0][3], _InverseProjectionMatrix[1][3], _InverseProjectionMatrix[2][3], _InverseProjectionMatrix[3][3]);

				_ScreenSpaceProjectionMatrix__array[0] = float4(_ScreenSpaceProjectionMatrix[0][0], _ScreenSpaceProjectionMatrix[1][0], _ScreenSpaceProjectionMatrix[2][0], _ScreenSpaceProjectionMatrix[3][0]);
				_ScreenSpaceProjectionMatrix__array[1] = float4(_ScreenSpaceProjectionMatrix[0][1], _ScreenSpaceProjectionMatrix[1][1], _ScreenSpaceProjectionMatrix[2][1], _ScreenSpaceProjectionMatrix[3][1]);
				_ScreenSpaceProjectionMatrix__array[2] = float4(_ScreenSpaceProjectionMatrix[0][2], _ScreenSpaceProjectionMatrix[1][2], _ScreenSpaceProjectionMatrix[2][2], _ScreenSpaceProjectionMatrix[3][2]);
				_ScreenSpaceProjectionMatrix__array[3] = float4(_ScreenSpaceProjectionMatrix[0][3], _ScreenSpaceProjectionMatrix[1][3], _ScreenSpaceProjectionMatrix[2][3], _ScreenSpaceProjectionMatrix[3][3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_0 = stage_input.fragment_input_0;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			float4 _Test_TexelSize;
			float4x4 _ViewMatrix;
			float4x4 _InverseProjectionMatrix;
			float4x4 _ScreenSpaceProjectionMatrix;
			float4 _Params;
			float4 _Params2;
			float3 _WorldSpaceCameraPos;
			float4 _ProjectionParams;
			float4 _ZBufferParams;

			static float4 fragment_uniform_buffer_0[24];
			static float4 fragment_uniform_buffer_1[8];
			Texture2D<float4> _CameraDepthTexture;
			Texture2D<float4> _CameraGBufferTexture2;
			Texture2D<float4> _Noise;
			SamplerState sampler_CameraDepthTexture;
			SamplerState sampler_CameraGBufferTexture2;
			SamplerState sampler_Noise;

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
				float4 fragment_unnamed_52 = _CameraGBufferTexture2.Sample(sampler_CameraGBufferTexture2, float2(fragment_input_1.x, fragment_input_1.y));
				float fragment_unnamed_54 = fragment_unnamed_52.x;
				if (dot(float4(fragment_unnamed_54, fragment_unnamed_52.yzw), 1.0f.xxxx) == 0.0f)
				{
					fragment_output_0.x = 0.0f;
					fragment_output_0.y = 0.0f;
					fragment_output_0.z = 0.0f;
					fragment_output_0.w = 0.0f;
					return;
				}
				else
				{
					float4 fragment_unnamed_76 = _CameraDepthTexture.SampleLevel(sampler_CameraDepthTexture, float2(fragment_input_1.x, fragment_input_1.y), 0.0f);
					float fragment_unnamed_78 = fragment_unnamed_76.x;
					float fragment_unnamed_84 = mad(fragment_input_1.x, 2.0f, -1.0f);
					float fragment_unnamed_87 = mad(fragment_input_1.y, 2.0f, -1.0f);
					float fragment_unnamed_132 = mad(fragment_uniform_buffer_0[16u].w, fragment_unnamed_78, mad(fragment_uniform_buffer_0[14u].w, fragment_unnamed_84, fragment_unnamed_87 * fragment_uniform_buffer_0[15u].w)) + fragment_uniform_buffer_0[17u].w;
					float fragment_unnamed_133 = (mad(fragment_uniform_buffer_0[16u].x, fragment_unnamed_78, mad(fragment_uniform_buffer_0[14u].x, fragment_unnamed_84, fragment_unnamed_87 * fragment_uniform_buffer_0[15u].x)) + fragment_uniform_buffer_0[17u].x) / fragment_unnamed_132;
					float fragment_unnamed_134 = (mad(fragment_uniform_buffer_0[16u].y, fragment_unnamed_78, mad(fragment_uniform_buffer_0[14u].y, fragment_unnamed_84, fragment_unnamed_87 * fragment_uniform_buffer_0[15u].y)) + fragment_uniform_buffer_0[17u].y) / fragment_unnamed_132;
					float fragment_unnamed_135 = (mad(fragment_uniform_buffer_0[16u].z, fragment_unnamed_78, mad(fragment_uniform_buffer_0[14u].z, fragment_unnamed_84, fragment_unnamed_87 * fragment_uniform_buffer_0[15u].z)) + fragment_uniform_buffer_0[17u].z) / fragment_unnamed_132;
					if (fragment_unnamed_135 < ((-0.0f) - fragment_uniform_buffer_0[22u].z))
					{
						fragment_output_0.x = 0.0f;
						fragment_output_0.y = 0.0f;
						fragment_output_0.z = 0.0f;
						fragment_output_0.w = 0.0f;
						return;
					}
					else
					{
						float fragment_unnamed_147 = mad(fragment_unnamed_54, 2.0f, -1.0f);
						float fragment_unnamed_148 = mad(fragment_unnamed_52.y, 2.0f, -1.0f);
						float fragment_unnamed_149 = mad(fragment_unnamed_52.z, 2.0f, -1.0f);
						float fragment_unnamed_173 = mad(fragment_uniform_buffer_0[8u].x, fragment_unnamed_149, mad(fragment_uniform_buffer_0[6u].x, fragment_unnamed_147, fragment_unnamed_148 * fragment_uniform_buffer_0[7u].x));
						float fragment_unnamed_174 = mad(fragment_uniform_buffer_0[8u].y, fragment_unnamed_149, mad(fragment_uniform_buffer_0[6u].y, fragment_unnamed_147, fragment_unnamed_148 * fragment_uniform_buffer_0[7u].y));
						float fragment_unnamed_175 = mad(fragment_uniform_buffer_0[8u].z, fragment_unnamed_149, mad(fragment_uniform_buffer_0[6u].z, fragment_unnamed_147, fragment_unnamed_148 * fragment_uniform_buffer_0[7u].z));
						float fragment_unnamed_180 = rsqrt(dot(float3(fragment_unnamed_133, fragment_unnamed_134, fragment_unnamed_135), float3(fragment_unnamed_133, fragment_unnamed_134, fragment_unnamed_135)));
						float fragment_unnamed_181 = fragment_unnamed_180 * fragment_unnamed_133;
						float fragment_unnamed_182 = fragment_unnamed_180 * fragment_unnamed_134;
						float fragment_unnamed_183 = fragment_unnamed_180 * fragment_unnamed_135;
						float fragment_unnamed_184 = dot(float3(fragment_unnamed_181, fragment_unnamed_182, fragment_unnamed_183), float3(fragment_unnamed_173, fragment_unnamed_174, fragment_unnamed_175));
						float fragment_unnamed_188 = (-0.0f) - (fragment_unnamed_184 + fragment_unnamed_184);
						float fragment_unnamed_189 = mad(fragment_unnamed_173, fragment_unnamed_188, fragment_unnamed_181);
						float fragment_unnamed_190 = mad(fragment_unnamed_174, fragment_unnamed_188, fragment_unnamed_182);
						float fragment_unnamed_191 = mad(fragment_unnamed_175, fragment_unnamed_188, fragment_unnamed_183);
						float fragment_unnamed_195 = rsqrt(dot(float3(fragment_unnamed_189, fragment_unnamed_190, fragment_unnamed_191), float3(fragment_unnamed_189, fragment_unnamed_190, fragment_unnamed_191)));
						float fragment_unnamed_198 = fragment_unnamed_195 * fragment_unnamed_191;
						if (0.0f < fragment_unnamed_198)
						{
							fragment_output_0.x = 0.0f;
							fragment_output_0.y = 0.0f;
							fragment_output_0.z = 0.0f;
							fragment_output_0.w = 0.0f;
							return;
						}
						else
						{
							float fragment_unnamed_228 = asfloat((((-0.0f) - fragment_uniform_buffer_1[5u].y) < mad(fragment_unnamed_198, fragment_uniform_buffer_0[22u].z, fragment_unnamed_135)) ? asuint((((-0.0f) - fragment_unnamed_135) + ((-0.0f) - fragment_uniform_buffer_1[5u].y)) / fragment_unnamed_198) : asuint(fragment_uniform_buffer_0[22u]).z);
							float fragment_unnamed_231 = mad(fragment_unnamed_198, fragment_unnamed_228, fragment_unnamed_135);
							float fragment_unnamed_240 = fragment_unnamed_135 * fragment_uniform_buffer_0[20u].w;
							float fragment_unnamed_245 = mad(fragment_uniform_buffer_0[18u].x, fragment_unnamed_133, fragment_unnamed_135 * fragment_uniform_buffer_0[20u].x);
							float fragment_unnamed_250 = mad(fragment_uniform_buffer_0[19u].y, fragment_unnamed_134, fragment_unnamed_135 * fragment_uniform_buffer_0[20u].y);
							float fragment_unnamed_258 = fragment_unnamed_231 * fragment_uniform_buffer_0[20u].w;
							float fragment_unnamed_267 = 1.0f / fragment_unnamed_240;
							float fragment_unnamed_268 = 1.0f / fragment_unnamed_240;
							float fragment_unnamed_270 = 1.0f / fragment_unnamed_258;
							float fragment_unnamed_271 = fragment_unnamed_135 * fragment_unnamed_268;
							float fragment_unnamed_272 = fragment_unnamed_268 * fragment_unnamed_250;
							float fragment_unnamed_273 = fragment_unnamed_267 * fragment_unnamed_245;
							float fragment_unnamed_274 = (1.0f / fragment_unnamed_258) * mad(fragment_uniform_buffer_0[18u].x, mad(fragment_unnamed_195 * fragment_unnamed_189, fragment_unnamed_228, fragment_unnamed_133), fragment_unnamed_231 * fragment_uniform_buffer_0[20u].x);
							float fragment_unnamed_275 = fragment_unnamed_270 * mad(fragment_uniform_buffer_0[19u].y, mad(fragment_unnamed_195 * fragment_unnamed_190, fragment_unnamed_228, fragment_unnamed_134), fragment_unnamed_231 * fragment_uniform_buffer_0[20u].y);
							float fragment_unnamed_278 = mad(fragment_unnamed_245, fragment_unnamed_267, (-0.0f) - fragment_unnamed_274);
							float fragment_unnamed_279 = mad(fragment_unnamed_250, fragment_unnamed_268, (-0.0f) - fragment_unnamed_275);
							float fragment_unnamed_289 = asfloat(((9.9999997473787516355514526367188e-05f >= dot(float2(fragment_unnamed_278, fragment_unnamed_279), float2(fragment_unnamed_278, fragment_unnamed_279))) ? 4294967295u : 0u) & 1065353216u);
							float fragment_unnamed_296 = max(fragment_uniform_buffer_0[5u].y, fragment_uniform_buffer_0[5u].x);
							float fragment_unnamed_301 = mad((-0.0f) - fragment_unnamed_250, fragment_unnamed_268, mad(fragment_unnamed_289, fragment_unnamed_296, fragment_unnamed_275));
							float fragment_unnamed_302 = mad((-0.0f) - fragment_unnamed_245, fragment_unnamed_267, mad(fragment_unnamed_289, fragment_unnamed_296, fragment_unnamed_274));
							bool fragment_unnamed_305 = abs(fragment_unnamed_302) < abs(fragment_unnamed_301);
							float fragment_unnamed_317 = asfloat(fragment_unnamed_305 ? asuint(fragment_unnamed_301) : asuint(fragment_unnamed_302));
							float fragment_unnamed_326 = float(int((-((0.0f < fragment_unnamed_317) ? 4294967295u : 0u)) + ((fragment_unnamed_317 < 0.0f) ? 4294967295u : 0u)));
							float fragment_unnamed_327 = fragment_unnamed_326 / fragment_unnamed_317;
							float fragment_unnamed_330 = fragment_unnamed_327 * mad(fragment_unnamed_231, fragment_unnamed_270, (-0.0f) - fragment_unnamed_271);
							float fragment_unnamed_331 = fragment_unnamed_327 * asfloat(fragment_unnamed_305 ? asuint(fragment_unnamed_302) : asuint(fragment_unnamed_301));
							float fragment_unnamed_334 = fragment_unnamed_327 * (((-0.0f) - fragment_unnamed_268) + fragment_unnamed_270);
							float4 fragment_unnamed_362 = _Noise.SampleLevel(sampler_Noise, float2((fragment_input_1.x * fragment_uniform_buffer_0[23u].y) + fragment_uniform_buffer_1[4u].x, ((fragment_input_1.y * fragment_uniform_buffer_0[23u].y) * fragment_uniform_buffer_0[23u].x) + fragment_uniform_buffer_1[4u].z), 0.0f);
							float fragment_unnamed_364 = fragment_unnamed_362.w;
							float fragment_unnamed_368 = (((-0.0f) - min(fragment_unnamed_135 * (-0.00999999977648258209228515625f), 1.0f)) + 1.0f) * fragment_uniform_buffer_0[23u].z;
							float fragment_unnamed_371 = fragment_unnamed_368 * fragment_unnamed_334;
							float fragment_unnamed_372 = fragment_unnamed_368 * fragment_unnamed_330;
							float fragment_unnamed_377 = mad(fragment_unnamed_371, fragment_unnamed_364, fragment_unnamed_268);
							float fragment_unnamed_378 = mad(fragment_unnamed_372, fragment_unnamed_364, fragment_unnamed_271);
							uint fragment_unnamed_379 = asuint(mad(fragment_unnamed_368 * fragment_unnamed_326, fragment_unnamed_364, asfloat(fragment_unnamed_305 ? asuint(fragment_unnamed_272) : asuint(fragment_unnamed_273))));
							uint fragment_unnamed_380 = asuint(mad(fragment_unnamed_368 * fragment_unnamed_331, fragment_unnamed_364, asfloat(fragment_unnamed_305 ? asuint(fragment_unnamed_273) : asuint(fragment_unnamed_272))));
							float fragment_unnamed_381 = asfloat(0u);
							float fragment_unnamed_382 = asfloat(0u);
							uint fragment_unnamed_386;
							uint fragment_unnamed_388;
							float fragment_unnamed_390;
							float fragment_unnamed_392;
							float fragment_unnamed_394;
							uint fragment_unnamed_401;
							uint fragment_unnamed_403;
							uint fragment_unnamed_405;
							uint fragment_unnamed_407;
							uint fragment_unnamed_409;
							uint fragment_unnamed_410;
							uint fragment_unnamed_411;
							uint fragment_unnamed_412;
							uint fragment_unnamed_413;
							float fragment_unnamed_383 = fragment_unnamed_382;
							uint fragment_unnamed_385 = fragment_unnamed_379;
							uint fragment_unnamed_387 = fragment_unnamed_380;
							float fragment_unnamed_389 = fragment_unnamed_377;
							float fragment_unnamed_391 = fragment_unnamed_378;
							float fragment_unnamed_393 = fragment_unnamed_381;
							for (;;)
							{
								if (float(int(asuint(fragment_unnamed_383))) >= fragment_uniform_buffer_0[23u].w)
								{
									fragment_unnamed_401 = 0u;
									fragment_unnamed_403 = 0u;
									fragment_unnamed_405 = 0u;
									fragment_unnamed_407 = 0u;
									fragment_unnamed_409 = 0u;
									fragment_unnamed_410 = 0u;
									fragment_unnamed_411 = 0u;
									fragment_unnamed_412 = 0u;
									fragment_unnamed_413 = 0u;
									break;
								}
								else
								{
									fragment_unnamed_386 = asuint(mad(fragment_unnamed_326, fragment_unnamed_368, asfloat(fragment_unnamed_385)));
									fragment_unnamed_388 = asuint(mad(fragment_unnamed_331, fragment_unnamed_368, asfloat(fragment_unnamed_387)));
									fragment_unnamed_390 = mad(fragment_unnamed_334, fragment_unnamed_368, fragment_unnamed_389);
									fragment_unnamed_392 = mad(fragment_unnamed_330, fragment_unnamed_368, fragment_unnamed_391);
									float fragment_unnamed_439 = mad(fragment_unnamed_372, 0.5f, fragment_unnamed_392) / mad(fragment_unnamed_371, 0.5f, fragment_unnamed_390);
									fragment_unnamed_394 = asfloat((fragment_unnamed_393 < fragment_unnamed_439) ? asuint(fragment_unnamed_393) : asuint(fragment_unnamed_439));
									float fragment_unnamed_452 = asfloat(fragment_unnamed_305 ? fragment_unnamed_388 : fragment_unnamed_386) * fragment_uniform_buffer_0[5u].x;
									float fragment_unnamed_453 = asfloat(fragment_unnamed_305 ? fragment_unnamed_386 : fragment_unnamed_388) * fragment_uniform_buffer_0[5u].y;
									bool fragment_unnamed_467 = fragment_unnamed_394 < ((-0.0f) - (1.0f / mad(fragment_uniform_buffer_1[7u].z, _CameraDepthTexture.SampleLevel(sampler_CameraDepthTexture, float2(fragment_unnamed_452, fragment_unnamed_453), 0.0f).x, fragment_uniform_buffer_1[7u].w)));
									uint fragment_unnamed_468 = fragment_unnamed_467 ? 4294967295u : 0u;
									uint fragment_unnamed_404 = fragment_unnamed_468 & 4294967295u;
									uint fragment_unnamed_406 = fragment_unnamed_468 & asuint(fragment_unnamed_452);
									uint fragment_unnamed_408 = fragment_unnamed_468 & asuint(fragment_unnamed_453);
									uint fragment_unnamed_402 = fragment_unnamed_468 & (asuint(fragment_unnamed_383) + 1u);
									if (fragment_unnamed_467)
									{
										fragment_unnamed_401 = fragment_unnamed_402;
										fragment_unnamed_403 = fragment_unnamed_404;
										fragment_unnamed_405 = fragment_unnamed_406;
										fragment_unnamed_407 = fragment_unnamed_408;
										fragment_unnamed_409 = fragment_unnamed_404;
										fragment_unnamed_410 = fragment_unnamed_406;
										fragment_unnamed_411 = fragment_unnamed_408;
										fragment_unnamed_412 = fragment_unnamed_402;
										fragment_unnamed_413 = fragment_unnamed_404;
										break;
									}
									fragment_unnamed_383 = asfloat(asuint(fragment_unnamed_383) + 1u);
									fragment_unnamed_385 = fragment_unnamed_386;
									fragment_unnamed_387 = fragment_unnamed_388;
									fragment_unnamed_389 = fragment_unnamed_390;
									fragment_unnamed_391 = fragment_unnamed_392;
									fragment_unnamed_393 = fragment_unnamed_394;
									continue;
								}
							}
							bool fragment_unnamed_414 = fragment_unnamed_413 != 0u;
							fragment_output_0.z = float(int(fragment_unnamed_414 ? fragment_unnamed_401 : fragment_unnamed_412)) / fragment_uniform_buffer_0[23u].w;
							fragment_output_0.w = asfloat((fragment_unnamed_414 ? fragment_unnamed_403 : fragment_unnamed_409) & 1065353216u);
							fragment_output_0.x = asfloat(fragment_unnamed_414 ? fragment_unnamed_405 : fragment_unnamed_410);
							fragment_output_0.y = asfloat(fragment_unnamed_414 ? fragment_unnamed_407 : fragment_unnamed_411);
							return;
						}
					}
				}
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[5] = float4(_Test_TexelSize[0], _Test_TexelSize[1], _Test_TexelSize[2], _Test_TexelSize[3]);

				fragment_uniform_buffer_0[6] = float4(_ViewMatrix[0][0], _ViewMatrix[1][0], _ViewMatrix[2][0], _ViewMatrix[3][0]);
				fragment_uniform_buffer_0[7] = float4(_ViewMatrix[0][1], _ViewMatrix[1][1], _ViewMatrix[2][1], _ViewMatrix[3][1]);
				fragment_uniform_buffer_0[8] = float4(_ViewMatrix[0][2], _ViewMatrix[1][2], _ViewMatrix[2][2], _ViewMatrix[3][2]);
				fragment_uniform_buffer_0[9] = float4(_ViewMatrix[0][3], _ViewMatrix[1][3], _ViewMatrix[2][3], _ViewMatrix[3][3]);

				fragment_uniform_buffer_0[14] = float4(_InverseProjectionMatrix[0][0], _InverseProjectionMatrix[1][0], _InverseProjectionMatrix[2][0], _InverseProjectionMatrix[3][0]);
				fragment_uniform_buffer_0[15] = float4(_InverseProjectionMatrix[0][1], _InverseProjectionMatrix[1][1], _InverseProjectionMatrix[2][1], _InverseProjectionMatrix[3][1]);
				fragment_uniform_buffer_0[16] = float4(_InverseProjectionMatrix[0][2], _InverseProjectionMatrix[1][2], _InverseProjectionMatrix[2][2], _InverseProjectionMatrix[3][2]);
				fragment_uniform_buffer_0[17] = float4(_InverseProjectionMatrix[0][3], _InverseProjectionMatrix[1][3], _InverseProjectionMatrix[2][3], _InverseProjectionMatrix[3][3]);

				fragment_uniform_buffer_0[18] = float4(_ScreenSpaceProjectionMatrix[0][0], _ScreenSpaceProjectionMatrix[1][0], _ScreenSpaceProjectionMatrix[2][0], _ScreenSpaceProjectionMatrix[3][0]);
				fragment_uniform_buffer_0[19] = float4(_ScreenSpaceProjectionMatrix[0][1], _ScreenSpaceProjectionMatrix[1][1], _ScreenSpaceProjectionMatrix[2][1], _ScreenSpaceProjectionMatrix[3][1]);
				fragment_uniform_buffer_0[20] = float4(_ScreenSpaceProjectionMatrix[0][2], _ScreenSpaceProjectionMatrix[1][2], _ScreenSpaceProjectionMatrix[2][2], _ScreenSpaceProjectionMatrix[3][2]);
				fragment_uniform_buffer_0[21] = float4(_ScreenSpaceProjectionMatrix[0][3], _ScreenSpaceProjectionMatrix[1][3], _ScreenSpaceProjectionMatrix[2][3], _ScreenSpaceProjectionMatrix[3][3]);

				fragment_uniform_buffer_0[22] = float4(_Params[0], _Params[1], _Params[2], _Params[3]);

				fragment_uniform_buffer_0[23] = float4(_Params2[0], _Params2[1], _Params2[2], _Params2[3]);

				fragment_uniform_buffer_1[4] = float4(_WorldSpaceCameraPos[0], _WorldSpaceCameraPos[1], _WorldSpaceCameraPos[2], fragment_uniform_buffer_1[4][3]);

				fragment_uniform_buffer_1[5] = float4(_ProjectionParams[0], _ProjectionParams[1], _ProjectionParams[2], _ProjectionParams[3]);

				fragment_uniform_buffer_1[7] = float4(_ZBufferParams[0], _ZBufferParams[1], _ZBufferParams[2], _ZBufferParams[3]);

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
			GpuProgramID 110939

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0


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
				vertex_output_1.x = mad(vertex_input_0.x + 1.0f, 0.5f, 0.0f);
				vertex_output_1.y = mad(vertex_input_0.y + 1.0f, -0.5f, 1.0f);
				vertex_output_1.x = mad(vertex_input_0.x + 1.0f, 0.5f, 0.0f);
				vertex_output_1.y = mad(vertex_input_0.y + 1.0f, -0.5f, 1.0f);
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}


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
				float2 vertex_output_0 : TEXCOORD1; // vs_TEXCOORD1
				float2 vertex_output_1 : TEXCOORD0; // vs_TEXCOORD0
				float4 gl_Position : SV_Position;
			};

			static float4 vertex_unnamed_33;
			static float4 vertex_unnamed_38;

			void vert_main()
			{
				gl_Position = float4(vertex_input_0.xy.x, vertex_input_0.xy.y, gl_Position.z, gl_Position.w);
				gl_Position = float4(gl_Position.x, gl_Position.y, float2(0.0f, 1.0f).x, float2(0.0f, 1.0f).y);
				vertex_unnamed_33 = vertex_input_0.xyxy + 1.0f.xxxx;
				vertex_unnamed_38 = (vertex_unnamed_33 * float4(0.5f, -0.5f, 0.5f, -0.5f)) + float4(0.0f, 1.0f, 0.0f, 1.0f);
				vertex_output_1 = vertex_unnamed_38.xy;
				vertex_output_0 = vertex_unnamed_38.zw;
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
			float4 _Params;

			Texture2D<float4> _Test;
			SamplerState sampler_MainTex;
			Texture2D<float4> _MainTex;

			static float4 gl_FragCoord;
			static float4 fragment_output_0;
			static float2 fragment_input_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_0 : TEXCOORD1; // vs_TEXCOORD1
				float4 gl_FragCoord : SV_Position;
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static uint4 fragment_unnamed_28;
			static float4 fragment_unnamed_45;
			static bool fragment_unnamed_66;
			static float3 fragment_unnamed_87;
			static float fragment_unnamed_95;
			static float3 fragment_unnamed_105;
			static float fragment_unnamed_125;
			static float fragment_unnamed_180;

			void frag_main()
			{
				float4 fragment_unnamed_9 = float4(gl_FragCoord.xyz, 1.0f / gl_FragCoord.w);
				uint2 fragment_unnamed_36 = uint2(int2(fragment_unnamed_9.xy));
				fragment_unnamed_28 = uint4(fragment_unnamed_36.x, fragment_unnamed_36.y, fragment_unnamed_28.z, fragment_unnamed_28.w);
				fragment_unnamed_28.z = 0u;
				fragment_unnamed_28.w = 0u;
				fragment_unnamed_45 = _Test.Load(int3(int2(fragment_unnamed_28.xy), int(fragment_unnamed_28.w)));
				fragment_unnamed_66 = fragment_unnamed_45.w == 0.0f;
				if (fragment_unnamed_66)
				{
					fragment_output_0 = _MainTex.Sample(sampler_MainTex, fragment_input_0);
					return;
				}
				fragment_unnamed_87 = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_45.xy, 0.0f).xyz;
				fragment_unnamed_95 = max(fragment_unnamed_45.y, fragment_unnamed_45.x);
				fragment_unnamed_95 = (-fragment_unnamed_95) + 1.0f;
				fragment_unnamed_105.x = min(fragment_unnamed_45.y, fragment_unnamed_45.x);
				fragment_unnamed_95 = min(fragment_unnamed_95, fragment_unnamed_105.x);
				fragment_unnamed_95 *= 2.1917808055877685546875f;
				fragment_unnamed_95 = clamp(fragment_unnamed_95, 0.0f, 1.0f);
				fragment_unnamed_95 = rsqrt(fragment_unnamed_95);
				fragment_unnamed_95 = 1.0f / fragment_unnamed_95;
				fragment_unnamed_125 = fragment_unnamed_45.w * fragment_unnamed_95;
				float2 fragment_unnamed_134 = fragment_unnamed_45.xy + (-0.5f).xx;
				fragment_unnamed_45 = float4(fragment_unnamed_134.x, fragment_unnamed_134.y, fragment_unnamed_45.z, fragment_unnamed_45.w);
				float2 fragment_unnamed_148 = abs(fragment_unnamed_45.xy) * _Params.xx;
				fragment_unnamed_105 = float3(fragment_unnamed_105.x, fragment_unnamed_148.x, fragment_unnamed_148.y);
				fragment_unnamed_45.x = _MainTex_TexelSize.z * _MainTex_TexelSize.y;
				fragment_unnamed_105.x = fragment_unnamed_45.x * fragment_unnamed_105.y;
				fragment_unnamed_45.x = dot(fragment_unnamed_105.xz, fragment_unnamed_105.xz);
				fragment_unnamed_45.x = (-fragment_unnamed_45.x) + 1.0f;
				fragment_unnamed_45.x = max(fragment_unnamed_45.x, 0.0f);
				fragment_unnamed_180 = fragment_unnamed_45.x * fragment_unnamed_45.x;
				fragment_unnamed_180 *= fragment_unnamed_180;
				fragment_unnamed_45.x = fragment_unnamed_180 * fragment_unnamed_45.x;
				fragment_unnamed_45.x *= fragment_unnamed_125;
				float3 fragment_unnamed_202 = fragment_unnamed_45.xxx * fragment_unnamed_87;
				fragment_output_0 = float4(fragment_unnamed_202.x, fragment_unnamed_202.y, fragment_unnamed_202.z, fragment_output_0.w);
				fragment_output_0.w = fragment_unnamed_45.z;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				gl_FragCoord = stage_input.gl_FragCoord;
				gl_FragCoord.w = 1.0 / gl_FragCoord.w;
				fragment_input_0 = stage_input.fragment_input_0;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			float4 _MainTex_TexelSize;
			float4 _Params;

			static float4 fragment_uniform_buffer_0[23];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _Test;
			SamplerState sampler_MainTex;

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
				float4 fragment_unnamed_40 = _Test.Load(int3(uint2(uint(int(gl_FragCoord.x)), uint(int(gl_FragCoord.y))), 0u));
				float fragment_unnamed_43 = fragment_unnamed_40.x;
				float fragment_unnamed_44 = fragment_unnamed_40.y;
				float fragment_unnamed_46 = fragment_unnamed_40.w;
				if (fragment_unnamed_46 == 0.0f)
				{
					float4 fragment_unnamed_56 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
					fragment_output_0.x = fragment_unnamed_56.x;
					fragment_output_0.y = fragment_unnamed_56.y;
					fragment_output_0.z = fragment_unnamed_56.z;
					fragment_output_0.w = fragment_unnamed_56.w;
					return;
				}
				else
				{
					float4 fragment_unnamed_70 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_43, fragment_unnamed_44), 0.0f);
					float fragment_unnamed_100 = abs(fragment_unnamed_44 + (-0.5f)) * fragment_uniform_buffer_0[22u].x;
					float fragment_unnamed_109 = (fragment_uniform_buffer_0[4u].z * fragment_uniform_buffer_0[4u].y) * (abs(fragment_unnamed_43 + (-0.5f)) * fragment_uniform_buffer_0[22u].x);
					float fragment_unnamed_115 = max(((-0.0f) - dot(float2(fragment_unnamed_109, fragment_unnamed_100), float2(fragment_unnamed_109, fragment_unnamed_100))) + 1.0f, 0.0f);
					float fragment_unnamed_116 = fragment_unnamed_115 * fragment_unnamed_115;
					float fragment_unnamed_119 = ((fragment_unnamed_116 * fragment_unnamed_116) * fragment_unnamed_115) * (fragment_unnamed_46 * (1.0f / rsqrt(clamp(min(((-0.0f) - max(fragment_unnamed_44, fragment_unnamed_43)) + 1.0f, min(fragment_unnamed_44, fragment_unnamed_43)) * 2.1917808055877685546875f, 0.0f, 1.0f))));
					fragment_output_0.x = fragment_unnamed_119 * fragment_unnamed_70.x;
					fragment_output_0.y = fragment_unnamed_119 * fragment_unnamed_70.y;
					fragment_output_0.z = fragment_unnamed_119 * fragment_unnamed_70.z;
					fragment_output_0.w = fragment_unnamed_40.z;
					return;
				}
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[4] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				fragment_uniform_buffer_0[22] = float4(_Params[0], _Params[1], _Params[2], _Params[3]);

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
			GpuProgramID 190959

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0


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
				vertex_output_1.x = mad(vertex_input_0.x + 1.0f, 0.5f, 0.0f);
				vertex_output_1.y = mad(vertex_input_0.y + 1.0f, -0.5f, 1.0f);
				vertex_output_1.x = mad(vertex_input_0.x + 1.0f, 0.5f, 0.0f);
				vertex_output_1.y = mad(vertex_input_0.y + 1.0f, -0.5f, 1.0f);
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}


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
				float2 vertex_output_0 : TEXCOORD0; // vs_TEXCOORD0
				float2 vertex_output_1 : TEXCOORD1; // vs_TEXCOORD1
				float4 gl_Position : SV_Position;
			};

			static float4 vertex_unnamed_33;
			static float4 vertex_unnamed_38;

			void vert_main()
			{
				gl_Position = float4(vertex_input_0.xy.x, vertex_input_0.xy.y, gl_Position.z, gl_Position.w);
				gl_Position = float4(gl_Position.x, gl_Position.y, float2(0.0f, 1.0f).x, float2(0.0f, 1.0f).y);
				vertex_unnamed_33 = vertex_input_0.xyxy + 1.0f.xxxx;
				vertex_unnamed_38 = (vertex_unnamed_33 * float4(0.5f, -0.5f, 0.5f, -0.5f)) + float4(0.0f, 1.0f, 0.0f, 1.0f);
				vertex_output_0 = vertex_unnamed_38.xy;
				vertex_output_1 = vertex_unnamed_38.zw;
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

			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;
			Texture2D<float4> _CameraMotionVectorsTexture;
			SamplerState sampler_CameraMotionVectorsTexture;
			Texture2D<float4> _History;
			SamplerState sampler_History;

			static float2 fragment_input_0;
			static float2 fragment_input_1;
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

			static float4 fragment_unnamed_9;
			static float4 fragment_unnamed_35;
			static float4 fragment_unnamed_55;
			static float4 fragment_unnamed_72;
			static float2 fragment_unnamed_100;
			static float4 fragment_unnamed_108;
			static float fragment_unnamed_266;

			void frag_main()
			{
				fragment_unnamed_9.z = 0.0f;
				float3 fragment_unnamed_25 = -_MainTex_TexelSize.xyy;
				fragment_unnamed_9 = float4(fragment_unnamed_25.x, fragment_unnamed_25.y, fragment_unnamed_9.z, fragment_unnamed_25.z);
				fragment_unnamed_9 += fragment_input_0.xyxy;
				fragment_unnamed_35 = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_9.xy, 0.0f);
				fragment_unnamed_9 = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_9.zw, 0.0f);
				fragment_unnamed_55 = min(fragment_unnamed_9, fragment_unnamed_35);
				fragment_unnamed_9 = max(fragment_unnamed_9, fragment_unnamed_35);
				fragment_unnamed_35 = (_MainTex_TexelSize.xyxy * float4(1.0f, -1.0f, -1.0f, 1.0f)) + fragment_input_0.xyxy;
				fragment_unnamed_72 = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_35.xy, 0.0f);
				fragment_unnamed_35 = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_35.zw, 0.0f);
				fragment_unnamed_55 = min(fragment_unnamed_55, fragment_unnamed_72);
				fragment_unnamed_9 = max(fragment_unnamed_9, fragment_unnamed_72);
				fragment_unnamed_72.x = -_MainTex_TexelSize.x;
				fragment_unnamed_72.y = 0.0f;
				fragment_unnamed_100.y = 0.0f;
				float2 fragment_unnamed_105 = fragment_unnamed_72.xy + fragment_input_0;
				fragment_unnamed_72 = float4(fragment_unnamed_105.x, fragment_unnamed_105.y, fragment_unnamed_72.z, fragment_unnamed_72.w);
				fragment_unnamed_108 = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_72.xy, 0.0f);
				fragment_unnamed_55 = min(fragment_unnamed_55, fragment_unnamed_108);
				fragment_unnamed_9 = max(fragment_unnamed_9, fragment_unnamed_108);
				fragment_unnamed_100.x = _MainTex_TexelSize.x;
				float2 fragment_unnamed_126 = fragment_unnamed_100 + fragment_input_0;
				fragment_unnamed_72 = float4(fragment_unnamed_126.x, fragment_unnamed_126.y, fragment_unnamed_72.z, fragment_unnamed_72.w);
				fragment_unnamed_72 = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_72.xy, 0.0f);
				fragment_unnamed_55 = min(fragment_unnamed_55, fragment_unnamed_72);
				fragment_unnamed_9 = max(fragment_unnamed_9, fragment_unnamed_72);
				fragment_unnamed_9 = max(fragment_unnamed_35, fragment_unnamed_9);
				fragment_unnamed_35 = min(fragment_unnamed_35, fragment_unnamed_55);
				fragment_unnamed_55.x = 0.0f;
				fragment_unnamed_55.y = _MainTex_TexelSize.y;
				float2 fragment_unnamed_154 = fragment_unnamed_55.xy + fragment_input_0;
				fragment_unnamed_55 = float4(fragment_unnamed_154.x, fragment_unnamed_154.y, fragment_unnamed_55.z, fragment_unnamed_55.w);
				fragment_unnamed_55 = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_55.xy, 0.0f);
				fragment_unnamed_35 = min(fragment_unnamed_35, fragment_unnamed_55);
				fragment_unnamed_9 = max(fragment_unnamed_9, fragment_unnamed_55);
				float2 fragment_unnamed_173 = fragment_input_0 + _MainTex_TexelSize.xy;
				fragment_unnamed_55 = float4(fragment_unnamed_173.x, fragment_unnamed_173.y, fragment_unnamed_55.z, fragment_unnamed_55.w);
				fragment_unnamed_55 = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_55.xy, 0.0f);
				fragment_unnamed_35 = min(fragment_unnamed_35, fragment_unnamed_55);
				fragment_unnamed_9 = max(fragment_unnamed_9, fragment_unnamed_55);
				fragment_unnamed_55 = _MainTex.SampleLevel(sampler_MainTex, fragment_input_1, 0.0f);
				fragment_unnamed_35 = min(fragment_unnamed_35, fragment_unnamed_55);
				float2 fragment_unnamed_204 = _CameraMotionVectorsTexture.SampleLevel(sampler_CameraMotionVectorsTexture, fragment_input_1, 0.0f).xy;
				fragment_unnamed_72 = float4(fragment_unnamed_204.x, fragment_unnamed_204.y, fragment_unnamed_72.z, fragment_unnamed_72.w);
				fragment_unnamed_100 = (-fragment_unnamed_72.xy) + fragment_input_0;
				fragment_unnamed_72.x = dot(fragment_unnamed_72.xy, fragment_unnamed_72.xy);
				fragment_unnamed_72.x = sqrt(fragment_unnamed_72.x);
				fragment_unnamed_72.x = ((-_MainTex_TexelSize.z) * 0.00200000009499490261077880859375f) + fragment_unnamed_72.x;
				fragment_unnamed_108 = _History.SampleLevel(sampler_History, fragment_unnamed_100, 0.0f);
				fragment_unnamed_35 = max(fragment_unnamed_35, fragment_unnamed_108);
				fragment_unnamed_9 = max(fragment_unnamed_9, fragment_unnamed_55);
				fragment_unnamed_9 = min(fragment_unnamed_9, fragment_unnamed_35);
				fragment_unnamed_35.x = _MainTex_TexelSize.z * 0.00150000001303851604461669921875f;
				fragment_unnamed_35.x = 1.0f / fragment_unnamed_35.x;
				fragment_unnamed_35.x *= fragment_unnamed_72.x;
				fragment_unnamed_35.x = clamp(fragment_unnamed_35.x, 0.0f, 1.0f);
				fragment_unnamed_266 = (fragment_unnamed_35.x * (-2.0f)) + 3.0f;
				fragment_unnamed_35.x *= fragment_unnamed_35.x;
				fragment_unnamed_35.x *= fragment_unnamed_266;
				fragment_unnamed_35.x = min(fragment_unnamed_35.x, 1.0f);
				fragment_unnamed_55.w = fragment_unnamed_35.x * 0.85000002384185791015625f;
				fragment_unnamed_35 = fragment_unnamed_9 + (-fragment_unnamed_55);
				fragment_unnamed_9.x = (fragment_unnamed_9.w * (-25.0f)) + 0.949999988079071044921875f;
				fragment_unnamed_9.x = max(fragment_unnamed_9.x, 0.699999988079071044921875f);
				fragment_unnamed_9.x = min(fragment_unnamed_9.x, 0.949999988079071044921875f);
				fragment_output_0 = (fragment_unnamed_9.xxxx * fragment_unnamed_35) + fragment_unnamed_55;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_0 = stage_input.fragment_input_0;
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			float4 _MainTex_TexelSize;

			static float4 fragment_uniform_buffer_0[5];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _History;
			Texture2D<float4> _CameraMotionVectorsTexture;
			SamplerState sampler_MainTex;
			SamplerState sampler_History;
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
				float fragment_unnamed_47 = (-0.0f) - fragment_uniform_buffer_0[4u].y;
				float4 fragment_unnamed_61 = _MainTex.SampleLevel(sampler_MainTex, float2(((-0.0f) - fragment_uniform_buffer_0[4u].x) + fragment_input_1.x, fragment_unnamed_47 + fragment_input_1.y), 0.0f);
				float fragment_unnamed_63 = fragment_unnamed_61.x;
				float fragment_unnamed_64 = fragment_unnamed_61.y;
				float fragment_unnamed_65 = fragment_unnamed_61.z;
				float fragment_unnamed_66 = fragment_unnamed_61.w;
				float4 fragment_unnamed_67 = _MainTex.SampleLevel(sampler_MainTex, float2(asfloat(0u) + fragment_input_1.x, fragment_unnamed_47 + fragment_input_1.y), 0.0f);
				float fragment_unnamed_69 = fragment_unnamed_67.x;
				float fragment_unnamed_70 = fragment_unnamed_67.y;
				float fragment_unnamed_71 = fragment_unnamed_67.z;
				float fragment_unnamed_72 = fragment_unnamed_67.w;
				float4 fragment_unnamed_96 = _MainTex.SampleLevel(sampler_MainTex, float2(mad(fragment_uniform_buffer_0[4u].x, 1.0f, fragment_input_1.x), mad(fragment_uniform_buffer_0[4u].y, -1.0f, fragment_input_1.y)), 0.0f);
				float fragment_unnamed_98 = fragment_unnamed_96.x;
				float fragment_unnamed_99 = fragment_unnamed_96.y;
				float fragment_unnamed_100 = fragment_unnamed_96.z;
				float fragment_unnamed_101 = fragment_unnamed_96.w;
				float4 fragment_unnamed_102 = _MainTex.SampleLevel(sampler_MainTex, float2(mad(fragment_uniform_buffer_0[4u].x, -1.0f, fragment_input_1.x), mad(fragment_uniform_buffer_0[4u].y, 1.0f, fragment_input_1.y)), 0.0f);
				float fragment_unnamed_104 = fragment_unnamed_102.x;
				float fragment_unnamed_105 = fragment_unnamed_102.y;
				float fragment_unnamed_106 = fragment_unnamed_102.z;
				float fragment_unnamed_107 = fragment_unnamed_102.w;
				float4 fragment_unnamed_128 = _MainTex.SampleLevel(sampler_MainTex, float2(((-0.0f) - fragment_uniform_buffer_0[4u].x) + fragment_input_1.x, asfloat(0u) + fragment_input_1.y), 0.0f);
				float fragment_unnamed_130 = fragment_unnamed_128.x;
				float fragment_unnamed_131 = fragment_unnamed_128.y;
				float fragment_unnamed_132 = fragment_unnamed_128.z;
				float fragment_unnamed_133 = fragment_unnamed_128.w;
				float4 fragment_unnamed_154 = _MainTex.SampleLevel(sampler_MainTex, float2(asfloat(asuint(fragment_uniform_buffer_0[4u]).x) + fragment_input_1.x, asfloat(0u) + fragment_input_1.y), 0.0f);
				float fragment_unnamed_156 = fragment_unnamed_154.x;
				float fragment_unnamed_157 = fragment_unnamed_154.y;
				float fragment_unnamed_158 = fragment_unnamed_154.z;
				float fragment_unnamed_159 = fragment_unnamed_154.w;
				float4 fragment_unnamed_188 = _MainTex.SampleLevel(sampler_MainTex, float2(asfloat(0u) + fragment_input_1.x, asfloat(asuint(fragment_uniform_buffer_0[4u]).y) + fragment_input_1.y), 0.0f);
				float fragment_unnamed_190 = fragment_unnamed_188.x;
				float fragment_unnamed_191 = fragment_unnamed_188.y;
				float fragment_unnamed_192 = fragment_unnamed_188.z;
				float fragment_unnamed_193 = fragment_unnamed_188.w;
				float4 fragment_unnamed_212 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_input_1.x + fragment_uniform_buffer_0[4u].x, fragment_input_1.y + fragment_uniform_buffer_0[4u].y), 0.0f);
				float fragment_unnamed_214 = fragment_unnamed_212.x;
				float fragment_unnamed_215 = fragment_unnamed_212.y;
				float fragment_unnamed_216 = fragment_unnamed_212.z;
				float fragment_unnamed_217 = fragment_unnamed_212.w;
				float4 fragment_unnamed_230 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y), 0.0f);
				float fragment_unnamed_232 = fragment_unnamed_230.x;
				float fragment_unnamed_233 = fragment_unnamed_230.y;
				float fragment_unnamed_234 = fragment_unnamed_230.z;
				float fragment_unnamed_235 = fragment_unnamed_230.w;
				float4 fragment_unnamed_245 = _CameraMotionVectorsTexture.SampleLevel(sampler_CameraMotionVectorsTexture, float2(fragment_input_1.x, fragment_input_1.y), 0.0f);
				float fragment_unnamed_247 = fragment_unnamed_245.x;
				float4 fragment_unnamed_268 = _History.SampleLevel(sampler_History, float2(((-0.0f) - fragment_unnamed_247) + fragment_input_1.x, ((-0.0f) - fragment_unnamed_245.y) + fragment_input_1.y), 0.0f);
				float fragment_unnamed_285 = min(max(max(max(max(fragment_unnamed_107, max(max(max(max(fragment_unnamed_72, fragment_unnamed_66), fragment_unnamed_101), fragment_unnamed_133), fragment_unnamed_159)), fragment_unnamed_193), fragment_unnamed_217), fragment_unnamed_235), max(min(min(min(min(fragment_unnamed_107, min(min(min(min(fragment_unnamed_72, fragment_unnamed_66), fragment_unnamed_101), fragment_unnamed_133), fragment_unnamed_159)), fragment_unnamed_193), fragment_unnamed_217), fragment_unnamed_235), fragment_unnamed_268.w));
				float fragment_unnamed_293 = clamp((1.0f / (fragment_uniform_buffer_0[4u].z * 0.00150000001303851604461669921875f)) * mad((-0.0f) - fragment_uniform_buffer_0[4u].z, 0.00200000009499490261077880859375f, sqrt(dot(float2(fragment_unnamed_247, fragment_unnamed_245.y), float2(fragment_unnamed_247, fragment_unnamed_245.y)))), 0.0f, 1.0f);
				float fragment_unnamed_300 = min((fragment_unnamed_293 * fragment_unnamed_293) * mad(fragment_unnamed_293, -2.0f, 3.0f), 1.0f) * 0.85000002384185791015625f;
				float fragment_unnamed_315 = min(max(mad(fragment_unnamed_285, -25.0f, 0.949999988079071044921875f), 0.699999988079071044921875f), 0.949999988079071044921875f);
				fragment_output_0.x = mad(fragment_unnamed_315, min(max(max(max(max(fragment_unnamed_104, max(max(max(max(fragment_unnamed_69, fragment_unnamed_63), fragment_unnamed_98), fragment_unnamed_130), fragment_unnamed_156)), fragment_unnamed_190), fragment_unnamed_214), fragment_unnamed_232), max(min(min(min(min(fragment_unnamed_104, min(min(min(min(fragment_unnamed_69, fragment_unnamed_63), fragment_unnamed_98), fragment_unnamed_130), fragment_unnamed_156)), fragment_unnamed_190), fragment_unnamed_214), fragment_unnamed_232), fragment_unnamed_268.x)) + ((-0.0f) - fragment_unnamed_232), fragment_unnamed_232);
				fragment_output_0.y = mad(fragment_unnamed_315, min(max(max(max(max(fragment_unnamed_105, max(max(max(max(fragment_unnamed_70, fragment_unnamed_64), fragment_unnamed_99), fragment_unnamed_131), fragment_unnamed_157)), fragment_unnamed_191), fragment_unnamed_215), fragment_unnamed_233), max(min(min(min(min(fragment_unnamed_105, min(min(min(min(fragment_unnamed_70, fragment_unnamed_64), fragment_unnamed_99), fragment_unnamed_131), fragment_unnamed_157)), fragment_unnamed_191), fragment_unnamed_215), fragment_unnamed_233), fragment_unnamed_268.y)) + ((-0.0f) - fragment_unnamed_233), fragment_unnamed_233);
				fragment_output_0.z = mad(fragment_unnamed_315, min(max(max(max(max(fragment_unnamed_106, max(max(max(max(fragment_unnamed_71, fragment_unnamed_65), fragment_unnamed_100), fragment_unnamed_132), fragment_unnamed_158)), fragment_unnamed_192), fragment_unnamed_216), fragment_unnamed_234), max(min(min(min(min(fragment_unnamed_106, min(min(min(min(fragment_unnamed_71, fragment_unnamed_65), fragment_unnamed_100), fragment_unnamed_132), fragment_unnamed_158)), fragment_unnamed_192), fragment_unnamed_216), fragment_unnamed_234), fragment_unnamed_268.z)) + ((-0.0f) - fragment_unnamed_234), fragment_unnamed_234);
				fragment_output_0.w = mad(fragment_unnamed_315, fragment_unnamed_285 + ((-0.0f) - fragment_unnamed_300), fragment_unnamed_300);
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[4] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

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
			GpuProgramID 236279

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0


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
				vertex_output_1.x = mad(vertex_input_0.x + 1.0f, 0.5f, 0.0f);
				vertex_output_1.y = mad(vertex_input_0.y + 1.0f, -0.5f, 1.0f);
				vertex_output_1.x = mad(vertex_input_0.x + 1.0f, 0.5f, 0.0f);
				vertex_output_1.y = mad(vertex_input_0.y + 1.0f, -0.5f, 1.0f);
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}


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
				float2 vertex_output_0 : TEXCOORD0; // vs_TEXCOORD0
				float2 vertex_output_1 : TEXCOORD1; // vs_TEXCOORD1
				float4 gl_Position : SV_Position;
			};

			static float4 vertex_unnamed_33;
			static float4 vertex_unnamed_38;

			void vert_main()
			{
				gl_Position = float4(vertex_input_0.xy.x, vertex_input_0.xy.y, gl_Position.z, gl_Position.w);
				gl_Position = float4(gl_Position.x, gl_Position.y, float2(0.0f, 1.0f).x, float2(0.0f, 1.0f).y);
				vertex_unnamed_33 = vertex_input_0.xyxy + 1.0f.xxxx;
				vertex_unnamed_38 = (vertex_unnamed_33 * float4(0.5f, -0.5f, 0.5f, -0.5f)) + float4(0.0f, 1.0f, 0.0f, 1.0f);
				vertex_output_0 = vertex_unnamed_38.xy;
				vertex_output_1 = vertex_unnamed_38.zw;
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
			float4x4 _InverseViewMatrix;
			float4x4 _InverseProjectionMatrix;
			float4 _Params;

			static float4 _InverseViewMatrix__array[4];
			static float4 _InverseProjectionMatrix__array[4];
			Texture2D<float4> _CameraDepthTexture;
			SamplerState sampler_CameraDepthTexture;
			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;
			Texture2D<float4> _CameraGBufferTexture0;
			Texture2D<float4> _CameraGBufferTexture1;
			Texture2D<float4> _CameraGBufferTexture2;
			Texture2D<float4> _Resolve;
			SamplerState sampler_Resolve;
			Texture2D<float4> _CameraReflectionsTexture;
			SamplerState sampler_CameraReflectionsTexture;

			static float4 gl_FragCoord;
			static float2 fragment_input_1;
			static float4 fragment_output_0;
			static float2 fragment_input_0;

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
			static bool fragment_unnamed_73;
			static uint4 fragment_unnamed_93;
			static float fragment_unnamed_106;
			static float4 fragment_unnamed_121;
			static float fragment_unnamed_147;
			static float3 fragment_unnamed_167;
			static float2 fragment_unnamed_177;
			static float4 fragment_unnamed_183;
			static float fragment_unnamed_261;
			static float fragment_unnamed_267;
			static float4 fragment_unnamed_275;
			static float fragment_unnamed_288;
			static float3 fragment_unnamed_324;
			static float fragment_unnamed_342;
			static float fragment_unnamed_420;
			static float fragment_unnamed_439;

			void frag_main()
			{
				float4 fragment_unnamed_9 = float4(gl_FragCoord.xyz, 1.0f / gl_FragCoord.w);
				fragment_unnamed_27.x = _CameraDepthTexture.SampleLevel(sampler_CameraDepthTexture, fragment_input_1, 0.0f).x;
				fragment_unnamed_27.x = (_ZBufferParams.x * fragment_unnamed_27.x) + _ZBufferParams.y;
				fragment_unnamed_27.x = 1.0f / fragment_unnamed_27.x;
				fragment_unnamed_73 = 0.999000012874603271484375f < fragment_unnamed_27.x;
				if (fragment_unnamed_73)
				{
					fragment_output_0 = _MainTex.Sample(sampler_MainTex, fragment_input_1);
					return;
				}
				uint2 fragment_unnamed_99 = uint2(int2(fragment_unnamed_9.xy));
				fragment_unnamed_93 = uint4(fragment_unnamed_99.x, fragment_unnamed_99.y, fragment_unnamed_93.z, fragment_unnamed_93.w);
				fragment_unnamed_93.z = 0u;
				fragment_unnamed_93.w = 0u;
				fragment_unnamed_106 = _CameraGBufferTexture0.Load(int3(int2(fragment_unnamed_93.xy), int(fragment_unnamed_93.w))).w;
				fragment_unnamed_121 = _CameraGBufferTexture1.Load(int3(int2(fragment_unnamed_93.xy), int(fragment_unnamed_93.w)));
				fragment_unnamed_27 = _CameraGBufferTexture2.Load(int3(int2(fragment_unnamed_93.xy), int(fragment_unnamed_93.w))).xyz;
				fragment_unnamed_147 = max(fragment_unnamed_121.y, fragment_unnamed_121.x);
				fragment_unnamed_147 = max(fragment_unnamed_121.z, fragment_unnamed_147);
				fragment_unnamed_147 = (-fragment_unnamed_147) + 1.0f;
				fragment_unnamed_27 = (fragment_unnamed_27 * 2.0f.xxx) + (-1.0f).xxx;
				fragment_unnamed_167.x = _CameraDepthTexture.SampleLevel(sampler_CameraDepthTexture, fragment_input_0, 0.0f).x;
				fragment_unnamed_177 = (fragment_input_0 * 2.0f.xx) + (-1.0f).xx;
				fragment_unnamed_183 = fragment_unnamed_177.yyyy * _InverseProjectionMatrix__array[1];
				fragment_unnamed_183 = (_InverseProjectionMatrix__array[0] * fragment_unnamed_177.xxxx) + fragment_unnamed_183;
				fragment_unnamed_183 = (_InverseProjectionMatrix__array[2] * fragment_unnamed_167.xxxx) + fragment_unnamed_183;
				fragment_unnamed_183 += _InverseProjectionMatrix__array[3];
				fragment_unnamed_167 = fragment_unnamed_183.xyz / fragment_unnamed_183.www;
				fragment_unnamed_183.x = dot(fragment_unnamed_167, fragment_unnamed_167);
				fragment_unnamed_183.x = rsqrt(fragment_unnamed_183.x);
				fragment_unnamed_167 *= fragment_unnamed_183.xxx;
				float3 fragment_unnamed_233 = fragment_unnamed_167.yyy * _InverseViewMatrix__array[1].xyz;
				fragment_unnamed_183 = float4(fragment_unnamed_233.x, fragment_unnamed_233.y, fragment_unnamed_233.z, fragment_unnamed_183.w);
				float3 fragment_unnamed_244 = (_InverseViewMatrix__array[0].xyz * fragment_unnamed_167.xxx) + fragment_unnamed_183.xyz;
				fragment_unnamed_183 = float4(fragment_unnamed_244.x, fragment_unnamed_244.y, fragment_unnamed_244.z, fragment_unnamed_183.w);
				fragment_unnamed_167 = (_InverseViewMatrix__array[2].xyz * fragment_unnamed_167.zzz) + fragment_unnamed_183.xyz;
				fragment_unnamed_183.x = (-fragment_unnamed_121.w) + 1.0f;
				fragment_unnamed_261 = fragment_unnamed_183.x * fragment_unnamed_183.x;
				fragment_unnamed_267 = _Params.w + (-1.0f);
				fragment_unnamed_267 = (fragment_unnamed_261 * fragment_unnamed_267) + 1.0f;
				fragment_unnamed_275 = _Resolve.SampleLevel(sampler_Resolve, fragment_input_1, fragment_unnamed_267);
				fragment_unnamed_267 = dot(-fragment_unnamed_167, fragment_unnamed_27);
				fragment_unnamed_288 = fragment_unnamed_267 + fragment_unnamed_267;
				fragment_unnamed_27 = (fragment_unnamed_27 * (-fragment_unnamed_288.xxx)) + (-fragment_unnamed_167);
				fragment_unnamed_288 = dot(fragment_unnamed_27, fragment_unnamed_27);
				fragment_unnamed_288 = rsqrt(fragment_unnamed_288);
				fragment_unnamed_27 *= fragment_unnamed_288.xxx;
				fragment_unnamed_27.x = dot(-fragment_unnamed_167, fragment_unnamed_27);
				fragment_unnamed_27.x += fragment_unnamed_27.x;
				fragment_unnamed_27.x = clamp(fragment_unnamed_27.x, 0.0f, 1.0f);
				fragment_unnamed_324.x = max(fragment_unnamed_261, 0.00200000009499490261077880859375f);
				fragment_unnamed_324.x *= fragment_unnamed_183.x;
				fragment_unnamed_324.x = ((-fragment_unnamed_324.x) * 0.2800000011920928955078125f) + 1.0f;
				fragment_unnamed_342 = (-fragment_unnamed_147) + fragment_unnamed_121.w;
				fragment_unnamed_342 += 1.0f;
				fragment_unnamed_342 = clamp(fragment_unnamed_342, 0.0f, 1.0f);
				fragment_unnamed_167 = fragment_unnamed_275.xyz * fragment_unnamed_324.xxx;
				fragment_unnamed_324.x = (-abs(fragment_unnamed_267)) + 1.0f;
				fragment_unnamed_147 = fragment_unnamed_324.x * fragment_unnamed_324.x;
				fragment_unnamed_147 *= fragment_unnamed_147;
				fragment_unnamed_324.x *= fragment_unnamed_147;
				float3 fragment_unnamed_380 = (-fragment_unnamed_121.xyz) + fragment_unnamed_342.xxx;
				fragment_unnamed_183 = float4(fragment_unnamed_380.x, fragment_unnamed_380.y, fragment_unnamed_380.z, fragment_unnamed_183.w);
				fragment_unnamed_324 = (fragment_unnamed_324.xxx * fragment_unnamed_183.xyz) + fragment_unnamed_121.xyz;
				float3 fragment_unnamed_398 = _CameraReflectionsTexture.Sample(sampler_CameraReflectionsTexture, fragment_input_1).xyz;
				fragment_unnamed_121 = float4(fragment_unnamed_398.x, fragment_unnamed_398.y, fragment_unnamed_398.z, fragment_unnamed_121.w);
				fragment_unnamed_183 = _MainTex.Sample(sampler_MainTex, fragment_input_1);
				float3 fragment_unnamed_411 = (-fragment_unnamed_121.xyz) + fragment_unnamed_183.xyz;
				fragment_unnamed_183 = float4(fragment_unnamed_411.x, fragment_unnamed_411.y, fragment_unnamed_411.z, fragment_unnamed_183.w);
				float3 fragment_unnamed_417 = max(fragment_unnamed_183.xyz, 0.0f.xxx);
				fragment_unnamed_183 = float4(fragment_unnamed_417.x, fragment_unnamed_417.y, fragment_unnamed_417.z, fragment_unnamed_183.w);
				fragment_unnamed_420 = fragment_unnamed_275.w * fragment_unnamed_275.w;
				fragment_unnamed_275.x = fragment_unnamed_420 * 3.0f;
				fragment_unnamed_420 = (fragment_unnamed_420 * 3.0f) + (-0.5f);
				fragment_unnamed_420 += fragment_unnamed_420;
				fragment_unnamed_420 = clamp(fragment_unnamed_420, 0.0f, 1.0f);
				fragment_unnamed_439 = (fragment_unnamed_420 * (-2.0f)) + 3.0f;
				fragment_unnamed_420 *= fragment_unnamed_420;
				fragment_unnamed_420 *= fragment_unnamed_439;
				fragment_unnamed_420 *= fragment_unnamed_275.x;
				fragment_unnamed_420 *= _Params.y;
				fragment_unnamed_420 = clamp(fragment_unnamed_420, 0.0f, 1.0f);
				fragment_unnamed_420 = (-fragment_unnamed_420) + 1.0f;
				fragment_unnamed_27.x *= fragment_unnamed_420;
				fragment_unnamed_324 = (fragment_unnamed_167 * fragment_unnamed_324) + (-fragment_unnamed_121.xyz);
				fragment_unnamed_27 = (fragment_unnamed_27.xxx * fragment_unnamed_324) + fragment_unnamed_121.xyz;
				float3 fragment_unnamed_488 = (fragment_unnamed_27 * fragment_unnamed_106.xxx) + fragment_unnamed_183.xyz;
				fragment_output_0 = float4(fragment_unnamed_488.x, fragment_unnamed_488.y, fragment_unnamed_488.z, fragment_output_0.w);
				fragment_output_0.w = fragment_unnamed_183.w;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				_InverseViewMatrix__array[0] = float4(_InverseViewMatrix[0][0], _InverseViewMatrix[1][0], _InverseViewMatrix[2][0], _InverseViewMatrix[3][0]);
				_InverseViewMatrix__array[1] = float4(_InverseViewMatrix[0][1], _InverseViewMatrix[1][1], _InverseViewMatrix[2][1], _InverseViewMatrix[3][1]);
				_InverseViewMatrix__array[2] = float4(_InverseViewMatrix[0][2], _InverseViewMatrix[1][2], _InverseViewMatrix[2][2], _InverseViewMatrix[3][2]);
				_InverseViewMatrix__array[3] = float4(_InverseViewMatrix[0][3], _InverseViewMatrix[1][3], _InverseViewMatrix[2][3], _InverseViewMatrix[3][3]);

				_InverseProjectionMatrix__array[0] = float4(_InverseProjectionMatrix[0][0], _InverseProjectionMatrix[1][0], _InverseProjectionMatrix[2][0], _InverseProjectionMatrix[3][0]);
				_InverseProjectionMatrix__array[1] = float4(_InverseProjectionMatrix[0][1], _InverseProjectionMatrix[1][1], _InverseProjectionMatrix[2][1], _InverseProjectionMatrix[3][1]);
				_InverseProjectionMatrix__array[2] = float4(_InverseProjectionMatrix[0][2], _InverseProjectionMatrix[1][2], _InverseProjectionMatrix[2][2], _InverseProjectionMatrix[3][2]);
				_InverseProjectionMatrix__array[3] = float4(_InverseProjectionMatrix[0][3], _InverseProjectionMatrix[1][3], _InverseProjectionMatrix[2][3], _InverseProjectionMatrix[3][3]);

				gl_FragCoord = stage_input.gl_FragCoord;
				gl_FragCoord.w = 1.0 / gl_FragCoord.w;
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_0 = stage_input.fragment_input_0;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			float4x4 _InverseViewMatrix;
			float4x4 _InverseProjectionMatrix;
			float4 _Params;
			float4 _ZBufferParams;

			static float4 fragment_uniform_buffer_0[23];
			static float4 fragment_uniform_buffer_1[8];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _CameraDepthTexture;
			Texture2D<float4> _CameraReflectionsTexture;
			Texture2D<float4> _CameraGBufferTexture0;
			Texture2D<float4> _CameraGBufferTexture1;
			Texture2D<float4> _CameraGBufferTexture2;
			Texture2D<float4> _Resolve;
			SamplerState sampler_MainTex;
			SamplerState sampler_CameraDepthTexture;
			SamplerState sampler_CameraReflectionsTexture;
			SamplerState sampler_Resolve;

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
				if (0.999000012874603271484375f < (1.0f / mad(fragment_uniform_buffer_1[7u].x, _CameraDepthTexture.SampleLevel(sampler_CameraDepthTexture, float2(fragment_input_1.x, fragment_input_1.y), 0.0f).x, fragment_uniform_buffer_1[7u].y)))
				{
					float4 fragment_unnamed_85 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
					fragment_output_0.x = fragment_unnamed_85.x;
					fragment_output_0.y = fragment_unnamed_85.y;
					fragment_output_0.z = fragment_unnamed_85.z;
					fragment_output_0.w = fragment_unnamed_85.w;
					return;
				}
				else
				{
					uint fragment_unnamed_102 = uint(int(gl_FragCoord.x));
					uint fragment_unnamed_103 = uint(int(gl_FragCoord.y));
					float4 fragment_unnamed_104 = _CameraGBufferTexture0.Load(int3(uint2(fragment_unnamed_102, fragment_unnamed_103), 0u));
					float fragment_unnamed_107 = fragment_unnamed_104.w;
					float4 fragment_unnamed_108 = _CameraGBufferTexture1.Load(int3(uint2(fragment_unnamed_102, fragment_unnamed_103), 0u));
					float fragment_unnamed_110 = fragment_unnamed_108.x;
					float fragment_unnamed_111 = fragment_unnamed_108.y;
					float fragment_unnamed_112 = fragment_unnamed_108.z;
					float fragment_unnamed_113 = fragment_unnamed_108.w;
					float4 fragment_unnamed_114 = _CameraGBufferTexture2.Load(int3(uint2(fragment_unnamed_102, fragment_unnamed_103), 0u));
					float fragment_unnamed_124 = mad(fragment_unnamed_114.x, 2.0f, -1.0f);
					float fragment_unnamed_127 = mad(fragment_unnamed_114.y, 2.0f, -1.0f);
					float fragment_unnamed_128 = mad(fragment_unnamed_114.z, 2.0f, -1.0f);
					float4 fragment_unnamed_134 = _CameraDepthTexture.SampleLevel(sampler_CameraDepthTexture, float2(fragment_input_1.x, fragment_input_1.y), 0.0f);
					float fragment_unnamed_136 = fragment_unnamed_134.x;
					float fragment_unnamed_141 = mad(fragment_input_1.x, 2.0f, -1.0f);
					float fragment_unnamed_142 = mad(fragment_input_1.y, 2.0f, -1.0f);
					float fragment_unnamed_186 = mad(fragment_uniform_buffer_0[16u].w, fragment_unnamed_136, mad(fragment_uniform_buffer_0[14u].w, fragment_unnamed_141, fragment_unnamed_142 * fragment_uniform_buffer_0[15u].w)) + fragment_uniform_buffer_0[17u].w;
					float fragment_unnamed_187 = (mad(fragment_uniform_buffer_0[16u].x, fragment_unnamed_136, mad(fragment_uniform_buffer_0[14u].x, fragment_unnamed_141, fragment_unnamed_142 * fragment_uniform_buffer_0[15u].x)) + fragment_uniform_buffer_0[17u].x) / fragment_unnamed_186;
					float fragment_unnamed_188 = (mad(fragment_uniform_buffer_0[16u].y, fragment_unnamed_136, mad(fragment_uniform_buffer_0[14u].y, fragment_unnamed_141, fragment_unnamed_142 * fragment_uniform_buffer_0[15u].y)) + fragment_uniform_buffer_0[17u].y) / fragment_unnamed_186;
					float fragment_unnamed_189 = (mad(fragment_uniform_buffer_0[16u].z, fragment_unnamed_136, mad(fragment_uniform_buffer_0[14u].z, fragment_unnamed_141, fragment_unnamed_142 * fragment_uniform_buffer_0[15u].z)) + fragment_uniform_buffer_0[17u].z) / fragment_unnamed_186;
					float fragment_unnamed_194 = rsqrt(dot(float3(fragment_unnamed_187, fragment_unnamed_188, fragment_unnamed_189), float3(fragment_unnamed_187, fragment_unnamed_188, fragment_unnamed_189)));
					float fragment_unnamed_195 = fragment_unnamed_187 * fragment_unnamed_194;
					float fragment_unnamed_196 = fragment_unnamed_188 * fragment_unnamed_194;
					float fragment_unnamed_197 = fragment_unnamed_189 * fragment_unnamed_194;
					float fragment_unnamed_222 = mad(fragment_uniform_buffer_0[12u].x, fragment_unnamed_197, mad(fragment_uniform_buffer_0[10u].x, fragment_unnamed_195, fragment_unnamed_196 * fragment_uniform_buffer_0[11u].x));
					float fragment_unnamed_223 = mad(fragment_uniform_buffer_0[12u].y, fragment_unnamed_197, mad(fragment_uniform_buffer_0[10u].y, fragment_unnamed_195, fragment_unnamed_196 * fragment_uniform_buffer_0[11u].y));
					float fragment_unnamed_224 = mad(fragment_uniform_buffer_0[12u].z, fragment_unnamed_197, mad(fragment_uniform_buffer_0[10u].z, fragment_unnamed_195, fragment_unnamed_196 * fragment_uniform_buffer_0[11u].z));
					float fragment_unnamed_226 = ((-0.0f) - fragment_unnamed_113) + 1.0f;
					float fragment_unnamed_227 = fragment_unnamed_226 * fragment_unnamed_226;
					float4 fragment_unnamed_239 = _Resolve.SampleLevel(sampler_Resolve, float2(fragment_input_1.x, fragment_input_1.y), mad(fragment_unnamed_227, fragment_uniform_buffer_0[22u].w + (-1.0f), 1.0f));
					float fragment_unnamed_244 = fragment_unnamed_239.w;
					float fragment_unnamed_248 = dot(float3((-0.0f) - fragment_unnamed_222, (-0.0f) - fragment_unnamed_223, (-0.0f) - fragment_unnamed_224), float3(fragment_unnamed_124, fragment_unnamed_127, fragment_unnamed_128));
					float fragment_unnamed_252 = (-0.0f) - (fragment_unnamed_248 + fragment_unnamed_248);
					float fragment_unnamed_256 = mad(fragment_unnamed_124, fragment_unnamed_252, (-0.0f) - fragment_unnamed_222);
					float fragment_unnamed_257 = mad(fragment_unnamed_127, fragment_unnamed_252, (-0.0f) - fragment_unnamed_223);
					float fragment_unnamed_258 = mad(fragment_unnamed_128, fragment_unnamed_252, (-0.0f) - fragment_unnamed_224);
					float fragment_unnamed_262 = rsqrt(dot(float3(fragment_unnamed_256, fragment_unnamed_257, fragment_unnamed_258), float3(fragment_unnamed_256, fragment_unnamed_257, fragment_unnamed_258)));
					float fragment_unnamed_269 = dot(float3((-0.0f) - fragment_unnamed_222, (-0.0f) - fragment_unnamed_223, (-0.0f) - fragment_unnamed_224), float3(fragment_unnamed_256 * fragment_unnamed_262, fragment_unnamed_257 * fragment_unnamed_262, fragment_unnamed_258 * fragment_unnamed_262));
					float fragment_unnamed_279 = mad((-0.0f) - (max(fragment_unnamed_227, 0.00200000009499490261077880859375f) * 0.2800000011920928955078125f), fragment_unnamed_226, 1.0f);
					float fragment_unnamed_283 = clamp((((-0.0f) - (((-0.0f) - max(fragment_unnamed_112, max(fragment_unnamed_111, fragment_unnamed_110))) + 1.0f)) + fragment_unnamed_113) + 1.0f, 0.0f, 1.0f);
					float fragment_unnamed_289 = ((-0.0f) - abs(fragment_unnamed_248)) + 1.0f;
					float fragment_unnamed_290 = fragment_unnamed_289 * fragment_unnamed_289;
					float fragment_unnamed_292 = fragment_unnamed_289 * (fragment_unnamed_290 * fragment_unnamed_290);
					float4 fragment_unnamed_307 = _CameraReflectionsTexture.Sample(sampler_CameraReflectionsTexture, float2(fragment_input_1.x, fragment_input_1.y));
					float fragment_unnamed_309 = fragment_unnamed_307.x;
					float fragment_unnamed_310 = fragment_unnamed_307.y;
					float fragment_unnamed_311 = fragment_unnamed_307.z;
					float4 fragment_unnamed_317 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
					float fragment_unnamed_332 = fragment_unnamed_244 * fragment_unnamed_244;
					float fragment_unnamed_335 = mad(fragment_unnamed_332, 3.0f, -0.5f);
					float fragment_unnamed_338 = clamp(fragment_unnamed_335 + fragment_unnamed_335, 0.0f, 1.0f);
					float fragment_unnamed_351 = clamp(fragment_unnamed_269 + fragment_unnamed_269, 0.0f, 1.0f) * (((-0.0f) - clamp((((fragment_unnamed_338 * fragment_unnamed_338) * mad(fragment_unnamed_338, -2.0f, 3.0f)) * (fragment_unnamed_332 * 3.0f)) * fragment_uniform_buffer_0[22u].y, 0.0f, 1.0f)) + 1.0f);
					fragment_output_0.x = mad(mad(fragment_unnamed_351, mad(fragment_unnamed_239.x * fragment_unnamed_279, mad(fragment_unnamed_292, ((-0.0f) - fragment_unnamed_110) + fragment_unnamed_283, fragment_unnamed_110), (-0.0f) - fragment_unnamed_309), fragment_unnamed_309), fragment_unnamed_107, max(((-0.0f) - fragment_unnamed_309) + fragment_unnamed_317.x, 0.0f));
					fragment_output_0.y = mad(mad(fragment_unnamed_351, mad(fragment_unnamed_239.y * fragment_unnamed_279, mad(fragment_unnamed_292, ((-0.0f) - fragment_unnamed_111) + fragment_unnamed_283, fragment_unnamed_111), (-0.0f) - fragment_unnamed_310), fragment_unnamed_310), fragment_unnamed_107, max(((-0.0f) - fragment_unnamed_310) + fragment_unnamed_317.y, 0.0f));
					fragment_output_0.z = mad(mad(fragment_unnamed_351, mad(fragment_unnamed_239.z * fragment_unnamed_279, mad(fragment_unnamed_292, ((-0.0f) - fragment_unnamed_112) + fragment_unnamed_283, fragment_unnamed_112), (-0.0f) - fragment_unnamed_311), fragment_unnamed_311), fragment_unnamed_107, max(((-0.0f) - fragment_unnamed_311) + fragment_unnamed_317.z, 0.0f));
					fragment_output_0.w = fragment_unnamed_317.w;
					return;
				}
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[10] = float4(_InverseViewMatrix[0][0], _InverseViewMatrix[1][0], _InverseViewMatrix[2][0], _InverseViewMatrix[3][0]);
				fragment_uniform_buffer_0[11] = float4(_InverseViewMatrix[0][1], _InverseViewMatrix[1][1], _InverseViewMatrix[2][1], _InverseViewMatrix[3][1]);
				fragment_uniform_buffer_0[12] = float4(_InverseViewMatrix[0][2], _InverseViewMatrix[1][2], _InverseViewMatrix[2][2], _InverseViewMatrix[3][2]);
				fragment_uniform_buffer_0[13] = float4(_InverseViewMatrix[0][3], _InverseViewMatrix[1][3], _InverseViewMatrix[2][3], _InverseViewMatrix[3][3]);

				fragment_uniform_buffer_0[14] = float4(_InverseProjectionMatrix[0][0], _InverseProjectionMatrix[1][0], _InverseProjectionMatrix[2][0], _InverseProjectionMatrix[3][0]);
				fragment_uniform_buffer_0[15] = float4(_InverseProjectionMatrix[0][1], _InverseProjectionMatrix[1][1], _InverseProjectionMatrix[2][1], _InverseProjectionMatrix[3][1]);
				fragment_uniform_buffer_0[16] = float4(_InverseProjectionMatrix[0][2], _InverseProjectionMatrix[1][2], _InverseProjectionMatrix[2][2], _InverseProjectionMatrix[3][2]);
				fragment_uniform_buffer_0[17] = float4(_InverseProjectionMatrix[0][3], _InverseProjectionMatrix[1][3], _InverseProjectionMatrix[2][3], _InverseProjectionMatrix[3][3]);

				fragment_uniform_buffer_0[22] = float4(_Params[0], _Params[1], _Params[2], _Params[3]);

				fragment_uniform_buffer_1[7] = float4(_ZBufferParams[0], _ZBufferParams[1], _ZBufferParams[2], _ZBufferParams[3]);

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
	}
}
