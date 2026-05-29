Shader "Hidden/PostProcessing/ScalableAO"
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
			GpuProgramID 8321

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.0
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

			#endif // APPLY_FORWARD_FOG


			#ifndef APPLY_FORWARD_FOG
			#define ANY_SHADER_VARIANT_ACTIVE

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

			float4x4 unity_CameraProjection;
			float4 _ProjectionParams;
			float4 unity_OrthoParams;
			float4 _ZBufferParams;
			float4 _ScreenParams;
			float _RenderViewportScaleFactor;
			float4 _AOParams;

			static float4 unity_CameraProjection__array[4];
			Texture2D<float4> _CameraDepthNormalsTexture;
			SamplerState sampler_CameraDepthNormalsTexture;
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

			static float3 fragment_unnamed_9;
			static float3 fragment_unnamed_43;
			static float2 fragment_unnamed_66;
			static float3 fragment_unnamed_78;
			static float3 fragment_unnamed_92;
			static float fragment_unnamed_106;
			static bool2 fragment_unnamed_146;
			static int2 fragment_unnamed_155;
			static bool2 fragment_unnamed_170;
			static bool fragment_unnamed_203;
			static float fragment_unnamed_208;
			static float3 fragment_unnamed_221;
			static float2 fragment_unnamed_250;
			static int fragment_unnamed_281;
			static float2 fragment_unnamed_318;
			static float fragment_unnamed_331;
			static float fragment_unnamed_342;
			static float3 fragment_unnamed_360;
			static float fragment_unnamed_381;
			static float2 fragment_unnamed_384;
			static float3 fragment_unnamed_417;
			static bool fragment_unnamed_426;
			static float2 fragment_unnamed_442;
			static bool2 fragment_unnamed_530;
			static bool fragment_unnamed_535;
			static int fragment_unnamed_541;
			static int fragment_unnamed_555;
			static int fragment_unnamed_690;

			void frag_main()
			{
				fragment_unnamed_9 = float3(fragment_input_0.x, fragment_input_0.y, fragment_unnamed_9.z);
				float2 fragment_unnamed_22 = clamp(fragment_unnamed_9.xy, 0.0f.xx, 1.0f.xx);
				fragment_unnamed_9 = float3(fragment_unnamed_22.x, fragment_unnamed_22.y, fragment_unnamed_9.z);
				float2 fragment_unnamed_40 = fragment_unnamed_9.xy * _RenderViewportScaleFactor.xx;
				fragment_unnamed_9 = float3(fragment_unnamed_40.x, fragment_unnamed_40.y, fragment_unnamed_9.z);
				fragment_unnamed_43 = _CameraDepthNormalsTexture.Sample(sampler_CameraDepthNormalsTexture, fragment_unnamed_9.xy).xyz;
				fragment_unnamed_43 = (fragment_unnamed_43 * float3(3.55539989471435546875f, 3.55539989471435546875f, 0.0f)) + float3(-1.777699947357177734375f, -1.777699947357177734375f, 1.0f);
				fragment_unnamed_66.x = dot(fragment_unnamed_43, fragment_unnamed_43);
				fragment_unnamed_66.x = 2.0f / fragment_unnamed_66.x;
				float2 fragment_unnamed_83 = fragment_unnamed_43.xy * fragment_unnamed_66.xx;
				fragment_unnamed_78 = float3(fragment_unnamed_83.x, fragment_unnamed_83.y, fragment_unnamed_78.z);
				fragment_unnamed_78.z = fragment_unnamed_66.x + (-1.0f);
				fragment_unnamed_92 = fragment_unnamed_78 * float3(1.0f, 1.0f, -1.0f);
				fragment_unnamed_9.x = _CameraDepthTexture.SampleLevel(sampler_CameraDepthTexture, fragment_unnamed_9.xy, 0.0f).x;
				fragment_unnamed_106 = (-unity_OrthoParams.w) + 1.0f;
				fragment_unnamed_9.x *= _ZBufferParams.x;
				fragment_unnamed_66.x = ((-unity_OrthoParams.w) * fragment_unnamed_9.x) + 1.0f;
				fragment_unnamed_9.x = (fragment_unnamed_106 * fragment_unnamed_9.x) + _ZBufferParams.y;
				fragment_unnamed_9.x = fragment_unnamed_66.x / fragment_unnamed_9.x;
				fragment_unnamed_146 = bool4(fragment_input_0.xyxy.x < 0.0f.xxxx.x, fragment_input_0.xyxy.y < 0.0f.xxxx.y, fragment_input_0.xyxy.z < 0.0f.xxxx.z, fragment_input_0.xyxy.w < 0.0f.xxxx.w).xy;
				fragment_unnamed_155.x = int((uint(fragment_unnamed_146.y) * 4294967295u) | (uint(fragment_unnamed_146.x) * 4294967295u));
				fragment_unnamed_170 = bool4(float4(1.0f, 1.0f, 0.0f, 0.0f).x < fragment_input_0.xyxx.x, float4(1.0f, 1.0f, 0.0f, 0.0f).y < fragment_input_0.xyxx.y, float4(1.0f, 1.0f, 0.0f, 0.0f).z < fragment_input_0.xyxx.z, float4(1.0f, 1.0f, 0.0f, 0.0f).w < fragment_input_0.xyxx.w).xy;
				fragment_unnamed_155.y = int((uint(fragment_unnamed_170.y) * 4294967295u) | (uint(fragment_unnamed_170.x) * 4294967295u));
				fragment_unnamed_155 = int2(uint2(fragment_unnamed_155) & uint2(1u, 1u));
				fragment_unnamed_155.x = fragment_unnamed_155.y + fragment_unnamed_155.x;
				fragment_unnamed_66.x = float(fragment_unnamed_155.x);
				fragment_unnamed_203 = 9.9999997473787516355514526367188e-06f >= fragment_unnamed_9.x;
				fragment_unnamed_208 = float(fragment_unnamed_203);
				fragment_unnamed_66.x = fragment_unnamed_208 + fragment_unnamed_66.x;
				fragment_unnamed_66.x *= 100000000.0f;
				fragment_unnamed_221.z = (fragment_unnamed_9.x * _ProjectionParams.z) + fragment_unnamed_66.x;
				float2 fragment_unnamed_236 = (fragment_input_0 * 2.0f.xx) + (-1.0f).xx;
				fragment_unnamed_9 = float3(fragment_unnamed_236.x, fragment_unnamed_9.y, fragment_unnamed_236.y);
				float2 fragment_unnamed_247 = fragment_unnamed_9.xz + (-unity_CameraProjection__array[2].xy);
				fragment_unnamed_9 = float3(fragment_unnamed_247.x, fragment_unnamed_9.y, fragment_unnamed_247.y);
				fragment_unnamed_250.x = unity_CameraProjection__array[0].x;
				fragment_unnamed_250.y = unity_CameraProjection__array[1].y;
				float2 fragment_unnamed_260 = fragment_unnamed_9.xz / fragment_unnamed_250;
				fragment_unnamed_9 = float3(fragment_unnamed_260.x, fragment_unnamed_9.y, fragment_unnamed_260.y);
				fragment_unnamed_208 = (-fragment_unnamed_221.z) + 1.0f;
				fragment_unnamed_208 = (unity_OrthoParams.w * fragment_unnamed_208) + fragment_unnamed_221.z;
				float2 fragment_unnamed_278 = fragment_unnamed_208.xx * fragment_unnamed_9.xz;
				fragment_unnamed_221 = float3(fragment_unnamed_278.x, fragment_unnamed_278.y, fragment_unnamed_221.z);
				fragment_unnamed_281 = int(_AOParams.w);
				fragment_unnamed_66 = fragment_input_0 * _AOParams.zz;
				fragment_unnamed_66 *= _ScreenParams.xy;
				fragment_unnamed_66 = floor(fragment_unnamed_66);
				fragment_unnamed_66.x = dot(float2(0.067110560834407806396484375f, 0.005837149918079376220703125f), fragment_unnamed_66);
				fragment_unnamed_66.x = frac(fragment_unnamed_66.x);
				fragment_unnamed_66.x *= 52.98291778564453125f;
				fragment_unnamed_66.x = frac(fragment_unnamed_66.x);
				fragment_unnamed_318.x = 12.98980045318603515625f;
				fragment_unnamed_208 = 0.0f;
				float3 fragment_unnamed_431;
				for (int fragment_unnamed_322 = 0; fragment_unnamed_322 < fragment_unnamed_281; fragment_unnamed_322++)
				{
					fragment_unnamed_331 = float(fragment_unnamed_322);
					fragment_unnamed_318.y = (fragment_input_0.x * 1.0000000133514319600180897396058e-10f) + fragment_unnamed_331;
					fragment_unnamed_342 = fragment_unnamed_318.y * 78.233001708984375f;
					fragment_unnamed_342 = sin(fragment_unnamed_342);
					fragment_unnamed_342 *= 43758.546875f;
					fragment_unnamed_342 = frac(fragment_unnamed_342);
					fragment_unnamed_342 = fragment_unnamed_66.x + fragment_unnamed_342;
					fragment_unnamed_342 = frac(fragment_unnamed_342);
					fragment_unnamed_360.z = (fragment_unnamed_342 * 2.0f) + (-1.0f);
					fragment_unnamed_342 = dot(fragment_unnamed_318, float2(1.0f, 78.233001708984375f));
					fragment_unnamed_342 = sin(fragment_unnamed_342);
					fragment_unnamed_342 *= 43758.546875f;
					fragment_unnamed_342 = frac(fragment_unnamed_342);
					fragment_unnamed_342 = fragment_unnamed_66.x + fragment_unnamed_342;
					fragment_unnamed_342 *= 6.283185482025146484375f;
					fragment_unnamed_381 = sin(fragment_unnamed_342);
					fragment_unnamed_384.x = cos(fragment_unnamed_342);
					fragment_unnamed_342 = ((-fragment_unnamed_360.z) * fragment_unnamed_360.z) + 1.0f;
					fragment_unnamed_342 = sqrt(fragment_unnamed_342);
					fragment_unnamed_384.y = fragment_unnamed_381;
					float2 fragment_unnamed_402 = fragment_unnamed_342.xx * fragment_unnamed_384;
					fragment_unnamed_360 = float3(fragment_unnamed_402.x, fragment_unnamed_402.y, fragment_unnamed_360.z);
					fragment_unnamed_331 += 1.0f;
					fragment_unnamed_331 /= _AOParams.w;
					fragment_unnamed_331 = sqrt(fragment_unnamed_331);
					fragment_unnamed_331 *= _AOParams.y;
					fragment_unnamed_417 = fragment_unnamed_331.xxx * fragment_unnamed_360;
					fragment_unnamed_331 = dot(-fragment_unnamed_92, fragment_unnamed_417);
					fragment_unnamed_426 = fragment_unnamed_331 >= 0.0f;
					if (fragment_unnamed_426)
					{
						fragment_unnamed_431 = -fragment_unnamed_417;
					}
					else
					{
						fragment_unnamed_431 = fragment_unnamed_417;
					}
					fragment_unnamed_417 = fragment_unnamed_431;
					fragment_unnamed_417 = fragment_unnamed_221 + fragment_unnamed_417;
					fragment_unnamed_442 = fragment_unnamed_417.yy * unity_CameraProjection__array[1].xy;
					fragment_unnamed_442 = (unity_CameraProjection__array[0].xy * fragment_unnamed_417.xx) + fragment_unnamed_442;
					fragment_unnamed_442 = (unity_CameraProjection__array[2].xy * fragment_unnamed_417.zz) + fragment_unnamed_442;
					fragment_unnamed_331 = (-fragment_unnamed_417.z) + 1.0f;
					fragment_unnamed_331 = (unity_OrthoParams.w * fragment_unnamed_331) + fragment_unnamed_417.z;
					fragment_unnamed_442 /= fragment_unnamed_331.xx;
					fragment_unnamed_442 += 1.0f.xx;
					float2 fragment_unnamed_486 = fragment_unnamed_442 * 0.5f.xx;
					fragment_unnamed_417 = float3(fragment_unnamed_486.x, fragment_unnamed_486.y, fragment_unnamed_417.z);
					float2 fragment_unnamed_493 = clamp(fragment_unnamed_417.xy, 0.0f.xx, 1.0f.xx);
					fragment_unnamed_417 = float3(fragment_unnamed_493.x, fragment_unnamed_493.y, fragment_unnamed_417.z);
					float2 fragment_unnamed_501 = fragment_unnamed_417.xy * _RenderViewportScaleFactor.xx;
					fragment_unnamed_417 = float3(fragment_unnamed_501.x, fragment_unnamed_501.y, fragment_unnamed_417.z);
					fragment_unnamed_331 = _CameraDepthTexture.SampleLevel(sampler_CameraDepthTexture, fragment_unnamed_417.xy, 0.0f).x;
					fragment_unnamed_331 *= _ZBufferParams.x;
					fragment_unnamed_342 = ((-unity_OrthoParams.w) * fragment_unnamed_331) + 1.0f;
					fragment_unnamed_331 = (fragment_unnamed_106 * fragment_unnamed_331) + _ZBufferParams.y;
					fragment_unnamed_331 = fragment_unnamed_342 / fragment_unnamed_331;
					fragment_unnamed_530 = bool4(fragment_unnamed_442.xyxx.x < 0.0f.xxxx.x, fragment_unnamed_442.xyxx.y < 0.0f.xxxx.y, fragment_unnamed_442.xyxx.z < 0.0f.xxxx.z, fragment_unnamed_442.xyxx.w < 0.0f.xxxx.w).xy;
					fragment_unnamed_535 = fragment_unnamed_530.y || fragment_unnamed_530.x;
					fragment_unnamed_541 = int(fragment_unnamed_535);
					fragment_unnamed_530 = bool4(float4(2.0f, 2.0f, 0.0f, 0.0f).x < fragment_unnamed_442.xyxx.x, float4(2.0f, 2.0f, 0.0f, 0.0f).y < fragment_unnamed_442.xyxx.y, float4(2.0f, 2.0f, 0.0f, 0.0f).z < fragment_unnamed_442.xyxx.z, float4(2.0f, 2.0f, 0.0f, 0.0f).w < fragment_unnamed_442.xyxx.w).xy;
					fragment_unnamed_530.x = fragment_unnamed_530.y || fragment_unnamed_530.x;
					fragment_unnamed_555 = int(fragment_unnamed_530.x);
					fragment_unnamed_541 += fragment_unnamed_555;
					fragment_unnamed_342 = float(fragment_unnamed_541);
					fragment_unnamed_530.x = 9.9999997473787516355514526367188e-06f >= fragment_unnamed_331;
					fragment_unnamed_417.x = float(fragment_unnamed_530.x);
					fragment_unnamed_342 += fragment_unnamed_417.x;
					fragment_unnamed_342 *= 100000000.0f;
					fragment_unnamed_360.z = (fragment_unnamed_331 * _ProjectionParams.z) + fragment_unnamed_342;
					fragment_unnamed_442 += (-unity_CameraProjection__array[2].xy);
					fragment_unnamed_442 += (-1.0f).xx;
					fragment_unnamed_442 /= fragment_unnamed_250;
					fragment_unnamed_331 = (-fragment_unnamed_360.z) + 1.0f;
					fragment_unnamed_331 = (unity_OrthoParams.w * fragment_unnamed_331) + fragment_unnamed_360.z;
					float2 fragment_unnamed_609 = fragment_unnamed_331.xx * fragment_unnamed_442;
					fragment_unnamed_360 = float3(fragment_unnamed_609.x, fragment_unnamed_609.y, fragment_unnamed_360.z);
					fragment_unnamed_417 = (-fragment_unnamed_221) + fragment_unnamed_360;
					fragment_unnamed_331 = dot(fragment_unnamed_417, fragment_unnamed_92);
					fragment_unnamed_331 = ((-fragment_unnamed_221.z) * 0.00200000009499490261077880859375f) + fragment_unnamed_331;
					fragment_unnamed_331 = max(fragment_unnamed_331, 0.0f);
					fragment_unnamed_342 = dot(fragment_unnamed_417, fragment_unnamed_417);
					fragment_unnamed_342 += 9.9999997473787516355514526367188e-05f;
					fragment_unnamed_331 /= fragment_unnamed_342;
					fragment_unnamed_208 += fragment_unnamed_331;
				}
				fragment_unnamed_9.x = fragment_unnamed_208 * _AOParams.y;
				fragment_unnamed_9.x *= _AOParams.x;
				fragment_unnamed_9.x /= _AOParams.w;
				fragment_unnamed_9.x = max(abs(fragment_unnamed_9.x), 1.1920928955078125e-07f);
				fragment_unnamed_9.x = log2(fragment_unnamed_9.x);
				fragment_unnamed_9.x *= 0.60000002384185791015625f;
				fragment_output_0.x = exp2(fragment_unnamed_9.x);
				float3 fragment_unnamed_686 = (fragment_unnamed_78 * float3(0.5f, 0.5f, -0.5f)) + 0.5f.xxx;
				fragment_output_0 = float4(fragment_output_0.x, fragment_unnamed_686.x, fragment_unnamed_686.y, fragment_unnamed_686.z);
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				unity_CameraProjection__array[0] = float4(unity_CameraProjection[0][0], unity_CameraProjection[1][0], unity_CameraProjection[2][0], unity_CameraProjection[3][0]);
				unity_CameraProjection__array[1] = float4(unity_CameraProjection[0][1], unity_CameraProjection[1][1], unity_CameraProjection[2][1], unity_CameraProjection[3][1]);
				unity_CameraProjection__array[2] = float4(unity_CameraProjection[0][2], unity_CameraProjection[1][2], unity_CameraProjection[2][2], unity_CameraProjection[3][2]);
				unity_CameraProjection__array[3] = float4(unity_CameraProjection[0][3], unity_CameraProjection[1][3], unity_CameraProjection[2][3], unity_CameraProjection[3][3]);

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

			float4x4 unity_CameraProjection;
			float4 _ProjectionParams;
			float4 unity_OrthoParams;
			float4 _ZBufferParams;
			float4 _ScreenParams;
			float _RenderViewportScaleFactor;
			float3 _FogParams;
			float4 _AOParams;

			static float4 unity_CameraProjection__array[4];
			Texture2D<float4> _CameraDepthNormalsTexture;
			SamplerState sampler_CameraDepthNormalsTexture;
			Texture2D<float4> _CameraDepthTexture;
			SamplerState sampler_CameraDepthTexture;

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

			static float3 fragment_unnamed_9;
			static float3 fragment_unnamed_43;
			static float2 fragment_unnamed_66;
			static float3 fragment_unnamed_78;
			static float3 fragment_unnamed_92;
			static float fragment_unnamed_106;
			static bool2 fragment_unnamed_146;
			static int2 fragment_unnamed_155;
			static bool2 fragment_unnamed_170;
			static bool fragment_unnamed_203;
			static float fragment_unnamed_208;
			static float3 fragment_unnamed_221;
			static float2 fragment_unnamed_250;
			static int fragment_unnamed_281;
			static float2 fragment_unnamed_318;
			static float fragment_unnamed_331;
			static float fragment_unnamed_342;
			static float3 fragment_unnamed_360;
			static float fragment_unnamed_381;
			static float2 fragment_unnamed_384;
			static float3 fragment_unnamed_417;
			static bool fragment_unnamed_426;
			static float2 fragment_unnamed_442;
			static bool2 fragment_unnamed_530;
			static bool fragment_unnamed_535;
			static int fragment_unnamed_541;
			static int fragment_unnamed_555;
			static int fragment_unnamed_745;

			void frag_main()
			{
				fragment_unnamed_9 = float3(fragment_input_0.x, fragment_input_0.y, fragment_unnamed_9.z);
				float2 fragment_unnamed_22 = clamp(fragment_unnamed_9.xy, 0.0f.xx, 1.0f.xx);
				fragment_unnamed_9 = float3(fragment_unnamed_22.x, fragment_unnamed_22.y, fragment_unnamed_9.z);
				float2 fragment_unnamed_40 = fragment_unnamed_9.xy * _RenderViewportScaleFactor.xx;
				fragment_unnamed_9 = float3(fragment_unnamed_40.x, fragment_unnamed_40.y, fragment_unnamed_9.z);
				fragment_unnamed_43 = _CameraDepthNormalsTexture.Sample(sampler_CameraDepthNormalsTexture, fragment_unnamed_9.xy).xyz;
				fragment_unnamed_43 = (fragment_unnamed_43 * float3(3.55539989471435546875f, 3.55539989471435546875f, 0.0f)) + float3(-1.777699947357177734375f, -1.777699947357177734375f, 1.0f);
				fragment_unnamed_66.x = dot(fragment_unnamed_43, fragment_unnamed_43);
				fragment_unnamed_66.x = 2.0f / fragment_unnamed_66.x;
				float2 fragment_unnamed_83 = fragment_unnamed_43.xy * fragment_unnamed_66.xx;
				fragment_unnamed_78 = float3(fragment_unnamed_83.x, fragment_unnamed_83.y, fragment_unnamed_78.z);
				fragment_unnamed_78.z = fragment_unnamed_66.x + (-1.0f);
				fragment_unnamed_92 = fragment_unnamed_78 * float3(1.0f, 1.0f, -1.0f);
				fragment_unnamed_9.x = _CameraDepthTexture.SampleLevel(sampler_CameraDepthTexture, fragment_unnamed_9.xy, 0.0f).x;
				fragment_unnamed_106 = (-unity_OrthoParams.w) + 1.0f;
				fragment_unnamed_9.x *= _ZBufferParams.x;
				fragment_unnamed_66.x = ((-unity_OrthoParams.w) * fragment_unnamed_9.x) + 1.0f;
				fragment_unnamed_9.x = (fragment_unnamed_106 * fragment_unnamed_9.x) + _ZBufferParams.y;
				fragment_unnamed_9.x = fragment_unnamed_66.x / fragment_unnamed_9.x;
				fragment_unnamed_146 = bool4(fragment_input_0.xyxy.x < 0.0f.xxxx.x, fragment_input_0.xyxy.y < 0.0f.xxxx.y, fragment_input_0.xyxy.z < 0.0f.xxxx.z, fragment_input_0.xyxy.w < 0.0f.xxxx.w).xy;
				fragment_unnamed_155.x = int((uint(fragment_unnamed_146.y) * 4294967295u) | (uint(fragment_unnamed_146.x) * 4294967295u));
				fragment_unnamed_170 = bool4(float4(1.0f, 1.0f, 0.0f, 0.0f).x < fragment_input_0.xyxx.x, float4(1.0f, 1.0f, 0.0f, 0.0f).y < fragment_input_0.xyxx.y, float4(1.0f, 1.0f, 0.0f, 0.0f).z < fragment_input_0.xyxx.z, float4(1.0f, 1.0f, 0.0f, 0.0f).w < fragment_input_0.xyxx.w).xy;
				fragment_unnamed_155.y = int((uint(fragment_unnamed_170.y) * 4294967295u) | (uint(fragment_unnamed_170.x) * 4294967295u));
				fragment_unnamed_155 = int2(uint2(fragment_unnamed_155) & uint2(1u, 1u));
				fragment_unnamed_155.x = fragment_unnamed_155.y + fragment_unnamed_155.x;
				fragment_unnamed_66.x = float(fragment_unnamed_155.x);
				fragment_unnamed_203 = 9.9999997473787516355514526367188e-06f >= fragment_unnamed_9.x;
				fragment_unnamed_208 = float(fragment_unnamed_203);
				fragment_unnamed_66.x = fragment_unnamed_208 + fragment_unnamed_66.x;
				fragment_unnamed_66.x *= 100000000.0f;
				fragment_unnamed_221.z = (fragment_unnamed_9.x * _ProjectionParams.z) + fragment_unnamed_66.x;
				float2 fragment_unnamed_236 = (fragment_input_0 * 2.0f.xx) + (-1.0f).xx;
				fragment_unnamed_9 = float3(fragment_unnamed_236.x, fragment_unnamed_9.y, fragment_unnamed_236.y);
				float2 fragment_unnamed_247 = fragment_unnamed_9.xz + (-unity_CameraProjection__array[2].xy);
				fragment_unnamed_9 = float3(fragment_unnamed_247.x, fragment_unnamed_9.y, fragment_unnamed_247.y);
				fragment_unnamed_250.x = unity_CameraProjection__array[0].x;
				fragment_unnamed_250.y = unity_CameraProjection__array[1].y;
				float2 fragment_unnamed_260 = fragment_unnamed_9.xz / fragment_unnamed_250;
				fragment_unnamed_9 = float3(fragment_unnamed_260.x, fragment_unnamed_9.y, fragment_unnamed_260.y);
				fragment_unnamed_208 = (-fragment_unnamed_221.z) + 1.0f;
				fragment_unnamed_208 = (unity_OrthoParams.w * fragment_unnamed_208) + fragment_unnamed_221.z;
				float2 fragment_unnamed_278 = fragment_unnamed_208.xx * fragment_unnamed_9.xz;
				fragment_unnamed_221 = float3(fragment_unnamed_278.x, fragment_unnamed_278.y, fragment_unnamed_221.z);
				fragment_unnamed_281 = int(_AOParams.w);
				fragment_unnamed_66 = fragment_input_0 * _AOParams.zz;
				fragment_unnamed_66 *= _ScreenParams.xy;
				fragment_unnamed_66 = floor(fragment_unnamed_66);
				fragment_unnamed_66.x = dot(float2(0.067110560834407806396484375f, 0.005837149918079376220703125f), fragment_unnamed_66);
				fragment_unnamed_66.x = frac(fragment_unnamed_66.x);
				fragment_unnamed_66.x *= 52.98291778564453125f;
				fragment_unnamed_66.x = frac(fragment_unnamed_66.x);
				fragment_unnamed_318.x = 12.98980045318603515625f;
				fragment_unnamed_208 = 0.0f;
				float3 fragment_unnamed_431;
				for (int fragment_unnamed_322 = 0; fragment_unnamed_322 < fragment_unnamed_281; fragment_unnamed_322++)
				{
					fragment_unnamed_331 = float(fragment_unnamed_322);
					fragment_unnamed_318.y = (fragment_input_0.x * 1.0000000133514319600180897396058e-10f) + fragment_unnamed_331;
					fragment_unnamed_342 = fragment_unnamed_318.y * 78.233001708984375f;
					fragment_unnamed_342 = sin(fragment_unnamed_342);
					fragment_unnamed_342 *= 43758.546875f;
					fragment_unnamed_342 = frac(fragment_unnamed_342);
					fragment_unnamed_342 = fragment_unnamed_66.x + fragment_unnamed_342;
					fragment_unnamed_342 = frac(fragment_unnamed_342);
					fragment_unnamed_360.z = (fragment_unnamed_342 * 2.0f) + (-1.0f);
					fragment_unnamed_342 = dot(fragment_unnamed_318, float2(1.0f, 78.233001708984375f));
					fragment_unnamed_342 = sin(fragment_unnamed_342);
					fragment_unnamed_342 *= 43758.546875f;
					fragment_unnamed_342 = frac(fragment_unnamed_342);
					fragment_unnamed_342 = fragment_unnamed_66.x + fragment_unnamed_342;
					fragment_unnamed_342 *= 6.283185482025146484375f;
					fragment_unnamed_381 = sin(fragment_unnamed_342);
					fragment_unnamed_384.x = cos(fragment_unnamed_342);
					fragment_unnamed_342 = ((-fragment_unnamed_360.z) * fragment_unnamed_360.z) + 1.0f;
					fragment_unnamed_342 = sqrt(fragment_unnamed_342);
					fragment_unnamed_384.y = fragment_unnamed_381;
					float2 fragment_unnamed_402 = fragment_unnamed_342.xx * fragment_unnamed_384;
					fragment_unnamed_360 = float3(fragment_unnamed_402.x, fragment_unnamed_402.y, fragment_unnamed_360.z);
					fragment_unnamed_331 += 1.0f;
					fragment_unnamed_331 /= _AOParams.w;
					fragment_unnamed_331 = sqrt(fragment_unnamed_331);
					fragment_unnamed_331 *= _AOParams.y;
					fragment_unnamed_417 = fragment_unnamed_331.xxx * fragment_unnamed_360;
					fragment_unnamed_331 = dot(-fragment_unnamed_92, fragment_unnamed_417);
					fragment_unnamed_426 = fragment_unnamed_331 >= 0.0f;
					if (fragment_unnamed_426)
					{
						fragment_unnamed_431 = -fragment_unnamed_417;
					}
					else
					{
						fragment_unnamed_431 = fragment_unnamed_417;
					}
					fragment_unnamed_417 = fragment_unnamed_431;
					fragment_unnamed_417 = fragment_unnamed_221 + fragment_unnamed_417;
					fragment_unnamed_442 = fragment_unnamed_417.yy * unity_CameraProjection__array[1].xy;
					fragment_unnamed_442 = (unity_CameraProjection__array[0].xy * fragment_unnamed_417.xx) + fragment_unnamed_442;
					fragment_unnamed_442 = (unity_CameraProjection__array[2].xy * fragment_unnamed_417.zz) + fragment_unnamed_442;
					fragment_unnamed_331 = (-fragment_unnamed_417.z) + 1.0f;
					fragment_unnamed_331 = (unity_OrthoParams.w * fragment_unnamed_331) + fragment_unnamed_417.z;
					fragment_unnamed_442 /= fragment_unnamed_331.xx;
					fragment_unnamed_442 += 1.0f.xx;
					float2 fragment_unnamed_486 = fragment_unnamed_442 * 0.5f.xx;
					fragment_unnamed_417 = float3(fragment_unnamed_486.x, fragment_unnamed_486.y, fragment_unnamed_417.z);
					float2 fragment_unnamed_493 = clamp(fragment_unnamed_417.xy, 0.0f.xx, 1.0f.xx);
					fragment_unnamed_417 = float3(fragment_unnamed_493.x, fragment_unnamed_493.y, fragment_unnamed_417.z);
					float2 fragment_unnamed_501 = fragment_unnamed_417.xy * _RenderViewportScaleFactor.xx;
					fragment_unnamed_417 = float3(fragment_unnamed_501.x, fragment_unnamed_501.y, fragment_unnamed_417.z);
					fragment_unnamed_331 = _CameraDepthTexture.SampleLevel(sampler_CameraDepthTexture, fragment_unnamed_417.xy, 0.0f).x;
					fragment_unnamed_331 *= _ZBufferParams.x;
					fragment_unnamed_342 = ((-unity_OrthoParams.w) * fragment_unnamed_331) + 1.0f;
					fragment_unnamed_331 = (fragment_unnamed_106 * fragment_unnamed_331) + _ZBufferParams.y;
					fragment_unnamed_331 = fragment_unnamed_342 / fragment_unnamed_331;
					fragment_unnamed_530 = bool4(fragment_unnamed_442.xyxx.x < 0.0f.xxxx.x, fragment_unnamed_442.xyxx.y < 0.0f.xxxx.y, fragment_unnamed_442.xyxx.z < 0.0f.xxxx.z, fragment_unnamed_442.xyxx.w < 0.0f.xxxx.w).xy;
					fragment_unnamed_535 = fragment_unnamed_530.y || fragment_unnamed_530.x;
					fragment_unnamed_541 = int(fragment_unnamed_535);
					fragment_unnamed_530 = bool4(float4(2.0f, 2.0f, 0.0f, 0.0f).x < fragment_unnamed_442.xyxx.x, float4(2.0f, 2.0f, 0.0f, 0.0f).y < fragment_unnamed_442.xyxx.y, float4(2.0f, 2.0f, 0.0f, 0.0f).z < fragment_unnamed_442.xyxx.z, float4(2.0f, 2.0f, 0.0f, 0.0f).w < fragment_unnamed_442.xyxx.w).xy;
					fragment_unnamed_530.x = fragment_unnamed_530.y || fragment_unnamed_530.x;
					fragment_unnamed_555 = int(fragment_unnamed_530.x);
					fragment_unnamed_541 += fragment_unnamed_555;
					fragment_unnamed_342 = float(fragment_unnamed_541);
					fragment_unnamed_530.x = 9.9999997473787516355514526367188e-06f >= fragment_unnamed_331;
					fragment_unnamed_417.x = float(fragment_unnamed_530.x);
					fragment_unnamed_342 += fragment_unnamed_417.x;
					fragment_unnamed_342 *= 100000000.0f;
					fragment_unnamed_360.z = (fragment_unnamed_331 * _ProjectionParams.z) + fragment_unnamed_342;
					fragment_unnamed_442 += (-unity_CameraProjection__array[2].xy);
					fragment_unnamed_442 += (-1.0f).xx;
					fragment_unnamed_442 /= fragment_unnamed_250;
					fragment_unnamed_331 = (-fragment_unnamed_360.z) + 1.0f;
					fragment_unnamed_331 = (unity_OrthoParams.w * fragment_unnamed_331) + fragment_unnamed_360.z;
					float2 fragment_unnamed_609 = fragment_unnamed_331.xx * fragment_unnamed_442;
					fragment_unnamed_360 = float3(fragment_unnamed_609.x, fragment_unnamed_609.y, fragment_unnamed_360.z);
					fragment_unnamed_417 = (-fragment_unnamed_221) + fragment_unnamed_360;
					fragment_unnamed_331 = dot(fragment_unnamed_417, fragment_unnamed_92);
					fragment_unnamed_331 = ((-fragment_unnamed_221.z) * 0.00200000009499490261077880859375f) + fragment_unnamed_331;
					fragment_unnamed_331 = max(fragment_unnamed_331, 0.0f);
					fragment_unnamed_342 = dot(fragment_unnamed_417, fragment_unnamed_417);
					fragment_unnamed_342 += 9.9999997473787516355514526367188e-05f;
					fragment_unnamed_331 /= fragment_unnamed_342;
					fragment_unnamed_208 += fragment_unnamed_331;
				}
				fragment_unnamed_9.x = fragment_unnamed_208 * _AOParams.y;
				fragment_unnamed_9.x *= _AOParams.x;
				fragment_unnamed_9.x /= _AOParams.w;
				fragment_unnamed_9.x = max(abs(fragment_unnamed_9.x), 1.1920928955078125e-07f);
				fragment_unnamed_9.x = log2(fragment_unnamed_9.x);
				fragment_unnamed_9.x *= 0.60000002384185791015625f;
				fragment_unnamed_9.x = exp2(fragment_unnamed_9.x);
				fragment_unnamed_66.x = _CameraDepthTexture.Sample(sampler_CameraDepthTexture, fragment_input_1).x;
				fragment_unnamed_66.x *= _ZBufferParams.x;
				fragment_unnamed_208 = ((-unity_OrthoParams.w) * fragment_unnamed_66.x) + 1.0f;
				fragment_unnamed_106 = (fragment_unnamed_106 * fragment_unnamed_66.x) + _ZBufferParams.y;
				fragment_unnamed_106 = fragment_unnamed_208 / fragment_unnamed_106;
				fragment_unnamed_106 = (fragment_unnamed_106 * _ProjectionParams.z) + (-_ProjectionParams.y);
				fragment_unnamed_106 *= _FogParams.x;
				fragment_unnamed_106 *= (-fragment_unnamed_106);
				fragment_unnamed_106 = exp2(fragment_unnamed_106);
				fragment_output_0.x = fragment_unnamed_106 * fragment_unnamed_9.x;
				float3 fragment_unnamed_741 = (fragment_unnamed_78 * float3(0.5f, 0.5f, -0.5f)) + 0.5f.xxx;
				fragment_output_0 = float4(fragment_output_0.x, fragment_unnamed_741.x, fragment_unnamed_741.y, fragment_unnamed_741.z);
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				unity_CameraProjection__array[0] = float4(unity_CameraProjection[0][0], unity_CameraProjection[1][0], unity_CameraProjection[2][0], unity_CameraProjection[3][0]);
				unity_CameraProjection__array[1] = float4(unity_CameraProjection[0][1], unity_CameraProjection[1][1], unity_CameraProjection[2][1], unity_CameraProjection[3][1]);
				unity_CameraProjection__array[2] = float4(unity_CameraProjection[0][2], unity_CameraProjection[1][2], unity_CameraProjection[2][2], unity_CameraProjection[3][2]);
				unity_CameraProjection__array[3] = float4(unity_CameraProjection[0][3], unity_CameraProjection[1][3], unity_CameraProjection[2][3], unity_CameraProjection[3][3]);

				fragment_input_0 = stage_input.fragment_input_0;
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // APPLY_FORWARD_FOG


			#ifndef APPLY_FORWARD_FOG
			#define ANY_SHADER_VARIANT_ACTIVE

			float4x4 unity_CameraProjection;
			float4 _ProjectionParams;
			float4 unity_OrthoParams;
			float4 _ZBufferParams;
			float4 _ScreenParams;
			float _RenderViewportScaleFactor;
			float4 _AOParams;

			static float4 fragment_uniform_buffer_0[32];
			Texture2D<float4> _CameraDepthTexture;
			Texture2D<float4> _CameraDepthNormalsTexture;
			SamplerState sampler_CameraDepthTexture;
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
				precise float fragment_unnamed_50 = clamp(fragment_input_1.x, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_51 = clamp(fragment_input_1.y, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_54 = _CameraDepthNormalsTexture.Sample(sampler_CameraDepthNormalsTexture, float2(fragment_unnamed_50, fragment_unnamed_51));
				float fragment_unnamed_59 = mad(fragment_unnamed_54.x, 3.55539989471435546875f, -1.777699947357177734375f);
				float fragment_unnamed_62 = mad(fragment_unnamed_54.y, 3.55539989471435546875f, -1.777699947357177734375f);
				float fragment_unnamed_63 = mad(fragment_unnamed_54.z, 0.0f, 1.0f);
				precise float fragment_unnamed_68 = 2.0f / dot(float3(fragment_unnamed_59, fragment_unnamed_62, fragment_unnamed_63), float3(fragment_unnamed_59, fragment_unnamed_62, fragment_unnamed_63));
				precise float fragment_unnamed_70 = fragment_unnamed_59 * fragment_unnamed_68;
				precise float fragment_unnamed_71 = fragment_unnamed_62 * fragment_unnamed_68;
				precise float fragment_unnamed_72 = fragment_unnamed_68 + (-1.0f);
				precise float fragment_unnamed_74 = fragment_unnamed_70 * 1.0f;
				precise float fragment_unnamed_75 = fragment_unnamed_71 * 1.0f;
				precise float fragment_unnamed_76 = fragment_unnamed_72 * (-1.0f);
				precise float fragment_unnamed_85 = (-0.0f) - fragment_uniform_buffer_0[20u].w;
				precise float fragment_unnamed_87 = fragment_unnamed_85 + 1.0f;
				precise float fragment_unnamed_92 = _CameraDepthTexture.SampleLevel(sampler_CameraDepthTexture, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f).x * fragment_uniform_buffer_0[21u].x;
				precise float fragment_unnamed_96 = (-0.0f) - fragment_uniform_buffer_0[20u].w;
				precise float fragment_unnamed_102 = mad(fragment_unnamed_96, fragment_unnamed_92, 1.0f) / mad(fragment_unnamed_87, fragment_unnamed_92, fragment_uniform_buffer_0[21u].y);
				precise float fragment_unnamed_133 = asfloat(((9.9999997473787516355514526367188e-06f >= fragment_unnamed_102) ? 4294967295u : 0u) & 1065353216u) + float(int(((((1.0f < fragment_input_1.y) ? 4294967295u : 0u) | ((1.0f < fragment_input_1.x) ? 4294967295u : 0u)) & 1u) + ((((fragment_input_1.y < 0.0f) ? 4294967295u : 0u) | ((fragment_input_1.x < 0.0f) ? 4294967295u : 0u)) & 1u)));
				precise float fragment_unnamed_134 = fragment_unnamed_133 * 100000000.0f;
				float fragment_unnamed_140 = mad(fragment_unnamed_102, fragment_uniform_buffer_0[17u].z, fragment_unnamed_134);
				precise float fragment_unnamed_151 = (-0.0f) - fragment_uniform_buffer_0[2u].x;
				precise float fragment_unnamed_153 = (-0.0f) - fragment_uniform_buffer_0[2u].y;
				precise float fragment_unnamed_154 = mad(fragment_input_1.x, 2.0f, -1.0f) + fragment_unnamed_151;
				precise float fragment_unnamed_155 = mad(fragment_input_1.y, 2.0f, -1.0f) + fragment_unnamed_153;
				float fragment_unnamed_161 = asfloat(asuint(fragment_uniform_buffer_0[0u]).x);
				float fragment_unnamed_166 = asfloat(asuint(fragment_uniform_buffer_0[1u]).y);
				precise float fragment_unnamed_167 = fragment_unnamed_154 / fragment_unnamed_161;
				precise float fragment_unnamed_168 = fragment_unnamed_155 / fragment_unnamed_166;
				precise float fragment_unnamed_169 = (-0.0f) - fragment_unnamed_140;
				precise float fragment_unnamed_170 = fragment_unnamed_169 + 1.0f;
				float fragment_unnamed_174 = mad(fragment_uniform_buffer_0[20u].w, fragment_unnamed_170, fragment_unnamed_140);
				precise float fragment_unnamed_175 = fragment_unnamed_174 * fragment_unnamed_167;
				precise float fragment_unnamed_176 = fragment_unnamed_174 * fragment_unnamed_168;
				uint fragment_unnamed_181 = uint(int(fragment_uniform_buffer_0[31u].w));
				precise float fragment_unnamed_189 = fragment_input_1.x * fragment_uniform_buffer_0[31u].z;
				precise float fragment_unnamed_190 = fragment_input_1.y * fragment_uniform_buffer_0[31u].z;
				precise float fragment_unnamed_196 = fragment_unnamed_189 * fragment_uniform_buffer_0[22u].x;
				precise float fragment_unnamed_197 = fragment_unnamed_190 * fragment_uniform_buffer_0[22u].y;
				precise float fragment_unnamed_206 = frac(dot(float2(0.067110560834407806396484375f, 0.005837149918079376220703125f), float2(floor(fragment_unnamed_196), floor(fragment_unnamed_197)))) * 52.98291778564453125f;
				float fragment_unnamed_208 = frac(fragment_unnamed_206);
				float fragment_unnamed_209 = asfloat(1095751225u);
				float fragment_unnamed_212 = asfloat(0u);
				float fragment_unnamed_213;
				fragment_unnamed_213 = asfloat(0u);
				precise float fragment_unnamed_214;
				precise float fragment_unnamed_251;
				float fragment_unnamed_253;
				float fragment_unnamed_256;
				precise float fragment_unnamed_258;
				precise float fragment_unnamed_261;
				precise float fragment_unnamed_264;
				float fragment_unnamed_266;
				precise float fragment_unnamed_271;
				precise float fragment_unnamed_273;
				precise float fragment_unnamed_274;
				precise float fragment_unnamed_278;
				float fragment_unnamed_280;
				precise float fragment_unnamed_281;
				precise float fragment_unnamed_282;
				precise float fragment_unnamed_283;
				precise float fragment_unnamed_287;
				precise float fragment_unnamed_292;
				precise float fragment_unnamed_293;
				precise float fragment_unnamed_294;
				precise float fragment_unnamed_295;
				precise float fragment_unnamed_296;
				precise float fragment_unnamed_297;
				precise float fragment_unnamed_298;
				bool fragment_unnamed_302;
				precise float fragment_unnamed_303;
				precise float fragment_unnamed_304;
				precise float fragment_unnamed_305;
				precise float fragment_unnamed_309;
				precise float fragment_unnamed_310;
				precise float fragment_unnamed_311;
				precise float fragment_unnamed_316;
				precise float fragment_unnamed_317;
				precise float fragment_unnamed_330;
				precise float fragment_unnamed_331;
				float fragment_unnamed_335;
				precise float fragment_unnamed_336;
				precise float fragment_unnamed_337;
				precise float fragment_unnamed_338;
				precise float fragment_unnamed_339;
				precise float fragment_unnamed_340;
				precise float fragment_unnamed_341;
				precise float fragment_unnamed_347;
				precise float fragment_unnamed_348;
				precise float fragment_unnamed_356;
				precise float fragment_unnamed_360;
				precise float fragment_unnamed_366;
				precise float fragment_unnamed_385;
				precise float fragment_unnamed_386;
				float fragment_unnamed_390;
				precise float fragment_unnamed_394;
				precise float fragment_unnamed_396;
				precise float fragment_unnamed_397;
				precise float fragment_unnamed_398;
				precise float fragment_unnamed_399;
				precise float fragment_unnamed_400;
				precise float fragment_unnamed_401;
				precise float fragment_unnamed_402;
				precise float fragment_unnamed_403;
				precise float fragment_unnamed_404;
				float fragment_unnamed_408;
				precise float fragment_unnamed_409;
				precise float fragment_unnamed_410;
				precise float fragment_unnamed_411;
				precise float fragment_unnamed_412;
				precise float fragment_unnamed_413;
				precise float fragment_unnamed_414;
				precise float fragment_unnamed_415;
				precise float fragment_unnamed_416;
				precise float fragment_unnamed_420;
				precise float fragment_unnamed_427;
				precise float fragment_unnamed_429;
				for (float fragment_unnamed_215 = fragment_unnamed_212; !(int(asuint(fragment_unnamed_215)) >= int(fragment_unnamed_181)); fragment_unnamed_251 = float(int(asuint(fragment_unnamed_215))) * 1.00010001659393310546875f, fragment_unnamed_253 = floor(fragment_unnamed_251), fragment_unnamed_256 = mad(fragment_input_1.x, 1.0000000133514319600180897396058e-10f, fragment_unnamed_253), fragment_unnamed_258 = fragment_unnamed_256 * 78.233001708984375f, fragment_unnamed_261 = sin(fragment_unnamed_258) * 43758.546875f, fragment_unnamed_264 = fragment_unnamed_208 + frac(fragment_unnamed_261), fragment_unnamed_266 = mad(frac(fragment_unnamed_264), 2.0f, -1.0f), fragment_unnamed_271 = sin(dot(float2(fragment_unnamed_209, fragment_unnamed_256), float2(1.0f, 78.233001708984375f))) * 43758.546875f, fragment_unnamed_273 = fragment_unnamed_208 + frac(fragment_unnamed_271), fragment_unnamed_274 = fragment_unnamed_273 * 6.283185482025146484375f, fragment_unnamed_278 = (-0.0f) - fragment_unnamed_266, fragment_unnamed_280 = sqrt(mad(fragment_unnamed_278, fragment_unnamed_266, 1.0f)), fragment_unnamed_281 = fragment_unnamed_280 * cos(fragment_unnamed_274), fragment_unnamed_282 = fragment_unnamed_280 * sin(fragment_unnamed_274), fragment_unnamed_283 = fragment_unnamed_253 + 1.0f, fragment_unnamed_287 = fragment_unnamed_283 / fragment_uniform_buffer_0[31u].w, fragment_unnamed_292 = sqrt(fragment_unnamed_287) * fragment_uniform_buffer_0[31u].y, fragment_unnamed_293 = fragment_unnamed_292 * fragment_unnamed_281, fragment_unnamed_294 = fragment_unnamed_292 * fragment_unnamed_282, fragment_unnamed_295 = fragment_unnamed_292 * fragment_unnamed_266, fragment_unnamed_296 = (-0.0f) - fragment_unnamed_74, fragment_unnamed_297 = (-0.0f) - fragment_unnamed_75, fragment_unnamed_298 = (-0.0f) - fragment_unnamed_76, fragment_unnamed_302 = dot(float3(fragment_unnamed_296, fragment_unnamed_297, fragment_unnamed_298), float3(fragment_unnamed_293, fragment_unnamed_294, fragment_unnamed_295)) >= 0.0f, fragment_unnamed_303 = (-0.0f) - fragment_unnamed_293, fragment_unnamed_304 = (-0.0f) - fragment_unnamed_294, fragment_unnamed_305 = (-0.0f) - fragment_unnamed_295, fragment_unnamed_309 = fragment_unnamed_175 + (fragment_unnamed_302 ? fragment_unnamed_303 : fragment_unnamed_293), fragment_unnamed_310 = fragment_unnamed_176 + (fragment_unnamed_302 ? fragment_unnamed_304 : fragment_unnamed_294), fragment_unnamed_311 = fragment_unnamed_140 + (fragment_unnamed_302 ? fragment_unnamed_305 : fragment_unnamed_295), fragment_unnamed_316 = fragment_unnamed_310 * fragment_uniform_buffer_0[1u].x, fragment_unnamed_317 = fragment_unnamed_310 * fragment_uniform_buffer_0[1u].y, fragment_unnamed_330 = (-0.0f) - fragment_unnamed_311, fragment_unnamed_331 = fragment_unnamed_330 + 1.0f, fragment_unnamed_335 = mad(fragment_uniform_buffer_0[20u].w, fragment_unnamed_331, fragment_unnamed_311), fragment_unnamed_336 = mad(fragment_uniform_buffer_0[2u].x, fragment_unnamed_311, mad(fragment_uniform_buffer_0[0u].x, fragment_unnamed_309, fragment_unnamed_316)) / fragment_unnamed_335, fragment_unnamed_337 = mad(fragment_uniform_buffer_0[2u].y, fragment_unnamed_311, mad(fragment_uniform_buffer_0[0u].y, fragment_unnamed_309, fragment_unnamed_317)) / fragment_unnamed_335, fragment_unnamed_338 = fragment_unnamed_336 + 1.0f, fragment_unnamed_339 = fragment_unnamed_337 + 1.0f, fragment_unnamed_340 = fragment_unnamed_338 * 0.5f, fragment_unnamed_341 = fragment_unnamed_339 * 0.5f, fragment_unnamed_347 = clamp(fragment_unnamed_340, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, fragment_unnamed_348 = clamp(fragment_unnamed_341, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, fragment_unnamed_356 = _CameraDepthTexture.SampleLevel(sampler_CameraDepthTexture, float2(fragment_unnamed_347, fragment_unnamed_348), 0.0f).x * fragment_uniform_buffer_0[21u].x, fragment_unnamed_360 = (-0.0f) - fragment_uniform_buffer_0[20u].w, fragment_unnamed_366 = mad(fragment_unnamed_360, fragment_unnamed_356, 1.0f) / mad(fragment_unnamed_87, fragment_unnamed_356, fragment_uniform_buffer_0[21u].y), fragment_unnamed_385 = float(int(((((fragment_unnamed_339 < 0.0f) ? 4294967295u : 0u) | ((fragment_unnamed_338 < 0.0f) ? 4294967295u : 0u)) & 1u) + ((((2.0f < fragment_unnamed_339) ? 4294967295u : 0u) | ((2.0f < fragment_unnamed_338) ? 4294967295u : 0u)) & 1u))) + asfloat(((9.9999997473787516355514526367188e-06f >= fragment_unnamed_366) ? 4294967295u : 0u) & 1065353216u), fragment_unnamed_386 = fragment_unnamed_385 * 100000000.0f, fragment_unnamed_390 = mad(fragment_unnamed_366, fragment_uniform_buffer_0[17u].z, fragment_unnamed_386), fragment_unnamed_394 = (-0.0f) - fragment_uniform_buffer_0[2u].x, fragment_unnamed_396 = (-0.0f) - fragment_uniform_buffer_0[2u].y, fragment_unnamed_397 = fragment_unnamed_338 + fragment_unnamed_394, fragment_unnamed_398 = fragment_unnamed_339 + fragment_unnamed_396, fragment_unnamed_399 = fragment_unnamed_397 + (-1.0f), fragment_unnamed_400 = fragment_unnamed_398 + (-1.0f), fragment_unnamed_401 = fragment_unnamed_399 / fragment_unnamed_161, fragment_unnamed_402 = fragment_unnamed_400 / fragment_unnamed_166, fragment_unnamed_403 = (-0.0f) - fragment_unnamed_390, fragment_unnamed_404 = fragment_unnamed_403 + 1.0f, fragment_unnamed_408 = mad(fragment_uniform_buffer_0[20u].w, fragment_unnamed_404, fragment_unnamed_390), fragment_unnamed_409 = fragment_unnamed_408 * fragment_unnamed_401, fragment_unnamed_410 = fragment_unnamed_408 * fragment_unnamed_402, fragment_unnamed_411 = (-0.0f) - fragment_unnamed_175, fragment_unnamed_412 = (-0.0f) - fragment_unnamed_176, fragment_unnamed_413 = (-0.0f) - fragment_unnamed_140, fragment_unnamed_414 = fragment_unnamed_411 + fragment_unnamed_409, fragment_unnamed_415 = fragment_unnamed_412 + fragment_unnamed_410, fragment_unnamed_416 = fragment_unnamed_413 + fragment_unnamed_390, fragment_unnamed_420 = (-0.0f) - fragment_unnamed_140, fragment_unnamed_427 = dot(float3(fragment_unnamed_414, fragment_unnamed_415, fragment_unnamed_416), float3(fragment_unnamed_414, fragment_unnamed_415, fragment_unnamed_416)) + 9.9999997473787516355514526367188e-05f, fragment_unnamed_429 = max(mad(fragment_unnamed_420, 0.00200000009499490261077880859375f, dot(float3(fragment_unnamed_414, fragment_unnamed_415, fragment_unnamed_416), float3(fragment_unnamed_74, fragment_unnamed_75, fragment_unnamed_76))), 0.0f) / fragment_unnamed_427, fragment_unnamed_214 = fragment_unnamed_213 + fragment_unnamed_429, fragment_unnamed_213 = fragment_unnamed_214, fragment_unnamed_215 = asfloat(asuint(fragment_unnamed_215) + 1u))
				{
				}
				precise float fragment_unnamed_222 = fragment_unnamed_213 * fragment_uniform_buffer_0[31u].y;
				precise float fragment_unnamed_226 = fragment_unnamed_222 * fragment_uniform_buffer_0[31u].x;
				precise float fragment_unnamed_230 = fragment_unnamed_226 / fragment_uniform_buffer_0[31u].w;
				precise float fragment_unnamed_235 = log2(max(abs(fragment_unnamed_230), 1.1920928955078125e-07f)) * 0.60000002384185791015625f;
				fragment_output_0.x = exp2(fragment_unnamed_235);
				fragment_output_0.y = mad(fragment_unnamed_70, 0.5f, 0.5f);
				fragment_output_0.z = mad(fragment_unnamed_71, 0.5f, 0.5f);
				fragment_output_0.w = mad(fragment_unnamed_72, -0.5f, 0.5f);
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[0] = float4(unity_CameraProjection[0][0], unity_CameraProjection[1][0], unity_CameraProjection[2][0], unity_CameraProjection[3][0]);
				fragment_uniform_buffer_0[1] = float4(unity_CameraProjection[0][1], unity_CameraProjection[1][1], unity_CameraProjection[2][1], unity_CameraProjection[3][1]);
				fragment_uniform_buffer_0[2] = float4(unity_CameraProjection[0][2], unity_CameraProjection[1][2], unity_CameraProjection[2][2], unity_CameraProjection[3][2]);
				fragment_uniform_buffer_0[3] = float4(unity_CameraProjection[0][3], unity_CameraProjection[1][3], unity_CameraProjection[2][3], unity_CameraProjection[3][3]);

				fragment_uniform_buffer_0[17] = float4(_ProjectionParams[0], _ProjectionParams[1], _ProjectionParams[2], _ProjectionParams[3]);

				fragment_uniform_buffer_0[20] = float4(unity_OrthoParams[0], unity_OrthoParams[1], unity_OrthoParams[2], unity_OrthoParams[3]);

				fragment_uniform_buffer_0[21] = float4(_ZBufferParams[0], _ZBufferParams[1], _ZBufferParams[2], _ZBufferParams[3]);

				fragment_uniform_buffer_0[22] = float4(_ScreenParams[0], _ScreenParams[1], _ScreenParams[2], _ScreenParams[3]);

				fragment_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, fragment_uniform_buffer_0[26][1], fragment_uniform_buffer_0[26][2], fragment_uniform_buffer_0[26][3]);

				fragment_uniform_buffer_0[31] = float4(_AOParams[0], _AOParams[1], _AOParams[2], _AOParams[3]);

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

			float4x4 unity_CameraProjection;
			float4 _ProjectionParams;
			float4 unity_OrthoParams;
			float4 _ZBufferParams;
			float4 _ScreenParams;
			float _RenderViewportScaleFactor;
			float3 _FogParams;
			float4 _AOParams;

			static float4 fragment_uniform_buffer_0[32];
			Texture2D<float4> _CameraDepthTexture;
			Texture2D<float4> _CameraDepthNormalsTexture;
			SamplerState sampler_CameraDepthTexture;
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
				precise float fragment_unnamed_50 = clamp(fragment_input_1.x, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_51 = clamp(fragment_input_1.y, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_54 = _CameraDepthNormalsTexture.Sample(sampler_CameraDepthNormalsTexture, float2(fragment_unnamed_50, fragment_unnamed_51));
				float fragment_unnamed_59 = mad(fragment_unnamed_54.x, 3.55539989471435546875f, -1.777699947357177734375f);
				float fragment_unnamed_62 = mad(fragment_unnamed_54.y, 3.55539989471435546875f, -1.777699947357177734375f);
				float fragment_unnamed_63 = mad(fragment_unnamed_54.z, 0.0f, 1.0f);
				precise float fragment_unnamed_68 = 2.0f / dot(float3(fragment_unnamed_59, fragment_unnamed_62, fragment_unnamed_63), float3(fragment_unnamed_59, fragment_unnamed_62, fragment_unnamed_63));
				precise float fragment_unnamed_70 = fragment_unnamed_59 * fragment_unnamed_68;
				precise float fragment_unnamed_71 = fragment_unnamed_62 * fragment_unnamed_68;
				precise float fragment_unnamed_72 = fragment_unnamed_68 + (-1.0f);
				precise float fragment_unnamed_74 = fragment_unnamed_70 * 1.0f;
				precise float fragment_unnamed_75 = fragment_unnamed_71 * 1.0f;
				precise float fragment_unnamed_76 = fragment_unnamed_72 * (-1.0f);
				precise float fragment_unnamed_85 = (-0.0f) - fragment_uniform_buffer_0[20u].w;
				precise float fragment_unnamed_87 = fragment_unnamed_85 + 1.0f;
				precise float fragment_unnamed_92 = _CameraDepthTexture.SampleLevel(sampler_CameraDepthTexture, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f).x * fragment_uniform_buffer_0[21u].x;
				precise float fragment_unnamed_96 = (-0.0f) - fragment_uniform_buffer_0[20u].w;
				precise float fragment_unnamed_102 = mad(fragment_unnamed_96, fragment_unnamed_92, 1.0f) / mad(fragment_unnamed_87, fragment_unnamed_92, fragment_uniform_buffer_0[21u].y);
				precise float fragment_unnamed_133 = asfloat(((9.9999997473787516355514526367188e-06f >= fragment_unnamed_102) ? 4294967295u : 0u) & 1065353216u) + float(int(((((1.0f < fragment_input_1.y) ? 4294967295u : 0u) | ((1.0f < fragment_input_1.x) ? 4294967295u : 0u)) & 1u) + ((((fragment_input_1.y < 0.0f) ? 4294967295u : 0u) | ((fragment_input_1.x < 0.0f) ? 4294967295u : 0u)) & 1u)));
				precise float fragment_unnamed_134 = fragment_unnamed_133 * 100000000.0f;
				float fragment_unnamed_140 = mad(fragment_unnamed_102, fragment_uniform_buffer_0[17u].z, fragment_unnamed_134);
				precise float fragment_unnamed_151 = (-0.0f) - fragment_uniform_buffer_0[2u].x;
				precise float fragment_unnamed_153 = (-0.0f) - fragment_uniform_buffer_0[2u].y;
				precise float fragment_unnamed_154 = mad(fragment_input_1.x, 2.0f, -1.0f) + fragment_unnamed_151;
				precise float fragment_unnamed_155 = mad(fragment_input_1.y, 2.0f, -1.0f) + fragment_unnamed_153;
				float fragment_unnamed_161 = asfloat(asuint(fragment_uniform_buffer_0[0u]).x);
				float fragment_unnamed_166 = asfloat(asuint(fragment_uniform_buffer_0[1u]).y);
				precise float fragment_unnamed_167 = fragment_unnamed_154 / fragment_unnamed_161;
				precise float fragment_unnamed_168 = fragment_unnamed_155 / fragment_unnamed_166;
				precise float fragment_unnamed_169 = (-0.0f) - fragment_unnamed_140;
				precise float fragment_unnamed_170 = fragment_unnamed_169 + 1.0f;
				float fragment_unnamed_174 = mad(fragment_uniform_buffer_0[20u].w, fragment_unnamed_170, fragment_unnamed_140);
				precise float fragment_unnamed_175 = fragment_unnamed_174 * fragment_unnamed_167;
				precise float fragment_unnamed_176 = fragment_unnamed_174 * fragment_unnamed_168;
				uint fragment_unnamed_181 = uint(int(fragment_uniform_buffer_0[31u].w));
				precise float fragment_unnamed_189 = fragment_input_1.x * fragment_uniform_buffer_0[31u].z;
				precise float fragment_unnamed_190 = fragment_input_1.y * fragment_uniform_buffer_0[31u].z;
				precise float fragment_unnamed_196 = fragment_unnamed_189 * fragment_uniform_buffer_0[22u].x;
				precise float fragment_unnamed_197 = fragment_unnamed_190 * fragment_uniform_buffer_0[22u].y;
				precise float fragment_unnamed_206 = frac(dot(float2(0.067110560834407806396484375f, 0.005837149918079376220703125f), float2(floor(fragment_unnamed_196), floor(fragment_unnamed_197)))) * 52.98291778564453125f;
				float fragment_unnamed_208 = frac(fragment_unnamed_206);
				float fragment_unnamed_209 = asfloat(1095751225u);
				float fragment_unnamed_212 = asfloat(0u);
				float fragment_unnamed_213;
				fragment_unnamed_213 = asfloat(0u);
				precise float fragment_unnamed_214;
				precise float fragment_unnamed_290;
				float fragment_unnamed_292;
				float fragment_unnamed_295;
				precise float fragment_unnamed_297;
				precise float fragment_unnamed_300;
				precise float fragment_unnamed_303;
				float fragment_unnamed_305;
				precise float fragment_unnamed_310;
				precise float fragment_unnamed_312;
				precise float fragment_unnamed_313;
				precise float fragment_unnamed_317;
				float fragment_unnamed_319;
				precise float fragment_unnamed_320;
				precise float fragment_unnamed_321;
				precise float fragment_unnamed_322;
				precise float fragment_unnamed_326;
				precise float fragment_unnamed_331;
				precise float fragment_unnamed_332;
				precise float fragment_unnamed_333;
				precise float fragment_unnamed_334;
				precise float fragment_unnamed_335;
				precise float fragment_unnamed_336;
				precise float fragment_unnamed_337;
				bool fragment_unnamed_341;
				precise float fragment_unnamed_342;
				precise float fragment_unnamed_343;
				precise float fragment_unnamed_344;
				precise float fragment_unnamed_348;
				precise float fragment_unnamed_349;
				precise float fragment_unnamed_350;
				precise float fragment_unnamed_355;
				precise float fragment_unnamed_356;
				precise float fragment_unnamed_369;
				precise float fragment_unnamed_370;
				float fragment_unnamed_374;
				precise float fragment_unnamed_375;
				precise float fragment_unnamed_376;
				precise float fragment_unnamed_377;
				precise float fragment_unnamed_378;
				precise float fragment_unnamed_379;
				precise float fragment_unnamed_380;
				precise float fragment_unnamed_386;
				precise float fragment_unnamed_387;
				precise float fragment_unnamed_395;
				precise float fragment_unnamed_399;
				precise float fragment_unnamed_405;
				precise float fragment_unnamed_424;
				precise float fragment_unnamed_425;
				float fragment_unnamed_429;
				precise float fragment_unnamed_433;
				precise float fragment_unnamed_435;
				precise float fragment_unnamed_436;
				precise float fragment_unnamed_437;
				precise float fragment_unnamed_438;
				precise float fragment_unnamed_439;
				precise float fragment_unnamed_440;
				precise float fragment_unnamed_441;
				precise float fragment_unnamed_442;
				precise float fragment_unnamed_443;
				float fragment_unnamed_447;
				precise float fragment_unnamed_448;
				precise float fragment_unnamed_449;
				precise float fragment_unnamed_450;
				precise float fragment_unnamed_451;
				precise float fragment_unnamed_452;
				precise float fragment_unnamed_453;
				precise float fragment_unnamed_454;
				precise float fragment_unnamed_455;
				precise float fragment_unnamed_459;
				precise float fragment_unnamed_466;
				precise float fragment_unnamed_468;
				for (float fragment_unnamed_215 = fragment_unnamed_212; !(int(asuint(fragment_unnamed_215)) >= int(fragment_unnamed_181)); fragment_unnamed_290 = float(int(asuint(fragment_unnamed_215))) * 1.00010001659393310546875f, fragment_unnamed_292 = floor(fragment_unnamed_290), fragment_unnamed_295 = mad(fragment_input_1.x, 1.0000000133514319600180897396058e-10f, fragment_unnamed_292), fragment_unnamed_297 = fragment_unnamed_295 * 78.233001708984375f, fragment_unnamed_300 = sin(fragment_unnamed_297) * 43758.546875f, fragment_unnamed_303 = fragment_unnamed_208 + frac(fragment_unnamed_300), fragment_unnamed_305 = mad(frac(fragment_unnamed_303), 2.0f, -1.0f), fragment_unnamed_310 = sin(dot(float2(fragment_unnamed_209, fragment_unnamed_295), float2(1.0f, 78.233001708984375f))) * 43758.546875f, fragment_unnamed_312 = fragment_unnamed_208 + frac(fragment_unnamed_310), fragment_unnamed_313 = fragment_unnamed_312 * 6.283185482025146484375f, fragment_unnamed_317 = (-0.0f) - fragment_unnamed_305, fragment_unnamed_319 = sqrt(mad(fragment_unnamed_317, fragment_unnamed_305, 1.0f)), fragment_unnamed_320 = fragment_unnamed_319 * cos(fragment_unnamed_313), fragment_unnamed_321 = fragment_unnamed_319 * sin(fragment_unnamed_313), fragment_unnamed_322 = fragment_unnamed_292 + 1.0f, fragment_unnamed_326 = fragment_unnamed_322 / fragment_uniform_buffer_0[31u].w, fragment_unnamed_331 = sqrt(fragment_unnamed_326) * fragment_uniform_buffer_0[31u].y, fragment_unnamed_332 = fragment_unnamed_331 * fragment_unnamed_320, fragment_unnamed_333 = fragment_unnamed_331 * fragment_unnamed_321, fragment_unnamed_334 = fragment_unnamed_331 * fragment_unnamed_305, fragment_unnamed_335 = (-0.0f) - fragment_unnamed_74, fragment_unnamed_336 = (-0.0f) - fragment_unnamed_75, fragment_unnamed_337 = (-0.0f) - fragment_unnamed_76, fragment_unnamed_341 = dot(float3(fragment_unnamed_335, fragment_unnamed_336, fragment_unnamed_337), float3(fragment_unnamed_332, fragment_unnamed_333, fragment_unnamed_334)) >= 0.0f, fragment_unnamed_342 = (-0.0f) - fragment_unnamed_332, fragment_unnamed_343 = (-0.0f) - fragment_unnamed_333, fragment_unnamed_344 = (-0.0f) - fragment_unnamed_334, fragment_unnamed_348 = fragment_unnamed_175 + (fragment_unnamed_341 ? fragment_unnamed_342 : fragment_unnamed_332), fragment_unnamed_349 = fragment_unnamed_176 + (fragment_unnamed_341 ? fragment_unnamed_343 : fragment_unnamed_333), fragment_unnamed_350 = fragment_unnamed_140 + (fragment_unnamed_341 ? fragment_unnamed_344 : fragment_unnamed_334), fragment_unnamed_355 = fragment_unnamed_349 * fragment_uniform_buffer_0[1u].x, fragment_unnamed_356 = fragment_unnamed_349 * fragment_uniform_buffer_0[1u].y, fragment_unnamed_369 = (-0.0f) - fragment_unnamed_350, fragment_unnamed_370 = fragment_unnamed_369 + 1.0f, fragment_unnamed_374 = mad(fragment_uniform_buffer_0[20u].w, fragment_unnamed_370, fragment_unnamed_350), fragment_unnamed_375 = mad(fragment_uniform_buffer_0[2u].x, fragment_unnamed_350, mad(fragment_uniform_buffer_0[0u].x, fragment_unnamed_348, fragment_unnamed_355)) / fragment_unnamed_374, fragment_unnamed_376 = mad(fragment_uniform_buffer_0[2u].y, fragment_unnamed_350, mad(fragment_uniform_buffer_0[0u].y, fragment_unnamed_348, fragment_unnamed_356)) / fragment_unnamed_374, fragment_unnamed_377 = fragment_unnamed_375 + 1.0f, fragment_unnamed_378 = fragment_unnamed_376 + 1.0f, fragment_unnamed_379 = fragment_unnamed_377 * 0.5f, fragment_unnamed_380 = fragment_unnamed_378 * 0.5f, fragment_unnamed_386 = clamp(fragment_unnamed_379, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, fragment_unnamed_387 = clamp(fragment_unnamed_380, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, fragment_unnamed_395 = _CameraDepthTexture.SampleLevel(sampler_CameraDepthTexture, float2(fragment_unnamed_386, fragment_unnamed_387), 0.0f).x * fragment_uniform_buffer_0[21u].x, fragment_unnamed_399 = (-0.0f) - fragment_uniform_buffer_0[20u].w, fragment_unnamed_405 = mad(fragment_unnamed_399, fragment_unnamed_395, 1.0f) / mad(fragment_unnamed_87, fragment_unnamed_395, fragment_uniform_buffer_0[21u].y), fragment_unnamed_424 = float(int(((((fragment_unnamed_378 < 0.0f) ? 4294967295u : 0u) | ((fragment_unnamed_377 < 0.0f) ? 4294967295u : 0u)) & 1u) + ((((2.0f < fragment_unnamed_378) ? 4294967295u : 0u) | ((2.0f < fragment_unnamed_377) ? 4294967295u : 0u)) & 1u))) + asfloat(((9.9999997473787516355514526367188e-06f >= fragment_unnamed_405) ? 4294967295u : 0u) & 1065353216u), fragment_unnamed_425 = fragment_unnamed_424 * 100000000.0f, fragment_unnamed_429 = mad(fragment_unnamed_405, fragment_uniform_buffer_0[17u].z, fragment_unnamed_425), fragment_unnamed_433 = (-0.0f) - fragment_uniform_buffer_0[2u].x, fragment_unnamed_435 = (-0.0f) - fragment_uniform_buffer_0[2u].y, fragment_unnamed_436 = fragment_unnamed_377 + fragment_unnamed_433, fragment_unnamed_437 = fragment_unnamed_378 + fragment_unnamed_435, fragment_unnamed_438 = fragment_unnamed_436 + (-1.0f), fragment_unnamed_439 = fragment_unnamed_437 + (-1.0f), fragment_unnamed_440 = fragment_unnamed_438 / fragment_unnamed_161, fragment_unnamed_441 = fragment_unnamed_439 / fragment_unnamed_166, fragment_unnamed_442 = (-0.0f) - fragment_unnamed_429, fragment_unnamed_443 = fragment_unnamed_442 + 1.0f, fragment_unnamed_447 = mad(fragment_uniform_buffer_0[20u].w, fragment_unnamed_443, fragment_unnamed_429), fragment_unnamed_448 = fragment_unnamed_447 * fragment_unnamed_440, fragment_unnamed_449 = fragment_unnamed_447 * fragment_unnamed_441, fragment_unnamed_450 = (-0.0f) - fragment_unnamed_175, fragment_unnamed_451 = (-0.0f) - fragment_unnamed_176, fragment_unnamed_452 = (-0.0f) - fragment_unnamed_140, fragment_unnamed_453 = fragment_unnamed_450 + fragment_unnamed_448, fragment_unnamed_454 = fragment_unnamed_451 + fragment_unnamed_449, fragment_unnamed_455 = fragment_unnamed_452 + fragment_unnamed_429, fragment_unnamed_459 = (-0.0f) - fragment_unnamed_140, fragment_unnamed_466 = dot(float3(fragment_unnamed_453, fragment_unnamed_454, fragment_unnamed_455), float3(fragment_unnamed_453, fragment_unnamed_454, fragment_unnamed_455)) + 9.9999997473787516355514526367188e-05f, fragment_unnamed_468 = max(mad(fragment_unnamed_459, 0.00200000009499490261077880859375f, dot(float3(fragment_unnamed_453, fragment_unnamed_454, fragment_unnamed_455), float3(fragment_unnamed_74, fragment_unnamed_75, fragment_unnamed_76))), 0.0f) / fragment_unnamed_466, fragment_unnamed_214 = fragment_unnamed_213 + fragment_unnamed_468, fragment_unnamed_213 = fragment_unnamed_214, fragment_unnamed_215 = asfloat(asuint(fragment_unnamed_215) + 1u))
				{
				}
				precise float fragment_unnamed_222 = fragment_unnamed_213 * fragment_uniform_buffer_0[31u].y;
				precise float fragment_unnamed_226 = fragment_unnamed_222 * fragment_uniform_buffer_0[31u].x;
				precise float fragment_unnamed_230 = fragment_unnamed_226 / fragment_uniform_buffer_0[31u].w;
				precise float fragment_unnamed_235 = log2(max(abs(fragment_unnamed_230), 1.1920928955078125e-07f)) * 0.60000002384185791015625f;
				precise float fragment_unnamed_249 = _CameraDepthTexture.Sample(sampler_CameraDepthTexture, float2(fragment_input_1.x, fragment_input_1.y)).x * fragment_uniform_buffer_0[21u].x;
				precise float fragment_unnamed_253 = (-0.0f) - fragment_uniform_buffer_0[20u].w;
				precise float fragment_unnamed_259 = mad(fragment_unnamed_253, fragment_unnamed_249, 1.0f) / mad(fragment_unnamed_87, fragment_unnamed_249, fragment_uniform_buffer_0[21u].y);
				precise float fragment_unnamed_266 = (-0.0f) - fragment_uniform_buffer_0[17u].y;
				precise float fragment_unnamed_272 = mad(fragment_unnamed_259, fragment_uniform_buffer_0[17u].z, fragment_unnamed_266) * fragment_uniform_buffer_0[29u].x;
				precise float fragment_unnamed_273 = (-0.0f) - fragment_unnamed_272;
				precise float fragment_unnamed_274 = fragment_unnamed_272 * fragment_unnamed_273;
				precise float fragment_unnamed_276 = exp2(fragment_unnamed_274) * exp2(fragment_unnamed_235);
				fragment_output_0.x = fragment_unnamed_276;
				fragment_output_0.y = mad(fragment_unnamed_70, 0.5f, 0.5f);
				fragment_output_0.z = mad(fragment_unnamed_71, 0.5f, 0.5f);
				fragment_output_0.w = mad(fragment_unnamed_72, -0.5f, 0.5f);
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[0] = float4(unity_CameraProjection[0][0], unity_CameraProjection[1][0], unity_CameraProjection[2][0], unity_CameraProjection[3][0]);
				fragment_uniform_buffer_0[1] = float4(unity_CameraProjection[0][1], unity_CameraProjection[1][1], unity_CameraProjection[2][1], unity_CameraProjection[3][1]);
				fragment_uniform_buffer_0[2] = float4(unity_CameraProjection[0][2], unity_CameraProjection[1][2], unity_CameraProjection[2][2], unity_CameraProjection[3][2]);
				fragment_uniform_buffer_0[3] = float4(unity_CameraProjection[0][3], unity_CameraProjection[1][3], unity_CameraProjection[2][3], unity_CameraProjection[3][3]);

				fragment_uniform_buffer_0[17] = float4(_ProjectionParams[0], _ProjectionParams[1], _ProjectionParams[2], _ProjectionParams[3]);

				fragment_uniform_buffer_0[20] = float4(unity_OrthoParams[0], unity_OrthoParams[1], unity_OrthoParams[2], unity_OrthoParams[3]);

				fragment_uniform_buffer_0[21] = float4(_ZBufferParams[0], _ZBufferParams[1], _ZBufferParams[2], _ZBufferParams[3]);

				fragment_uniform_buffer_0[22] = float4(_ScreenParams[0], _ScreenParams[1], _ScreenParams[2], _ScreenParams[3]);

				fragment_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, fragment_uniform_buffer_0[26][1], fragment_uniform_buffer_0[26][2], fragment_uniform_buffer_0[26][3]);

				fragment_uniform_buffer_0[29] = float4(_FogParams[0], _FogParams[1], _FogParams[2], fragment_uniform_buffer_0[29][3]);

				fragment_uniform_buffer_0[31] = float4(_AOParams[0], _AOParams[1], _AOParams[2], _AOParams[3]);

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
			GpuProgramID 130050

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.0
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

			#endif // APPLY_FORWARD_FOG


			#ifndef APPLY_FORWARD_FOG
			#define ANY_SHADER_VARIANT_ACTIVE

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

			float4x4 unity_CameraProjection;
			float4x4 unity_WorldToCamera;
			float4 _ProjectionParams;
			float4 unity_OrthoParams;
			float4 _ZBufferParams;
			float4 _ScreenParams;
			float _RenderViewportScaleFactor;
			float4 _AOParams;

			static float4 unity_CameraProjection__array[4];
			static float4 unity_WorldToCamera__array[4];
			Texture2D<float4> _CameraGBufferTexture2;
			SamplerState sampler_CameraGBufferTexture2;
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

			static float3 fragment_unnamed_9;
			static float4 fragment_unnamed_45;
			static float2 fragment_unnamed_63;
			static bool2 fragment_unnamed_75;
			static float3 fragment_unnamed_97;
			static float fragment_unnamed_139;
			static int2 fragment_unnamed_184;
			static bool2 fragment_unnamed_198;
			static bool fragment_unnamed_231;
			static float fragment_unnamed_236;
			static float2 fragment_unnamed_275;
			static int fragment_unnamed_306;
			static float2 fragment_unnamed_343;
			static float fragment_unnamed_356;
			static float2 fragment_unnamed_367;
			static float3 fragment_unnamed_396;
			static float fragment_unnamed_429;
			static float2 fragment_unnamed_433;
			static float3 fragment_unnamed_470;
			static bool fragment_unnamed_480;
			static bool2 fragment_unnamed_585;
			static int2 fragment_unnamed_590;
			static bool2 fragment_unnamed_602;
			static float fragment_unnamed_636;
			static int fragment_unnamed_767;

			void frag_main()
			{
				fragment_unnamed_9 = float3(fragment_input_0.x, fragment_input_0.y, fragment_unnamed_9.z);
				float2 fragment_unnamed_22 = clamp(fragment_unnamed_9.xy, 0.0f.xx, 1.0f.xx);
				fragment_unnamed_9 = float3(fragment_unnamed_22.x, fragment_unnamed_22.y, fragment_unnamed_9.z);
				float2 fragment_unnamed_41 = fragment_unnamed_9.xy * _RenderViewportScaleFactor.xx;
				fragment_unnamed_9 = float3(fragment_unnamed_41.x, fragment_unnamed_41.y, fragment_unnamed_9.z);
				float3 fragment_unnamed_59 = _CameraGBufferTexture2.Sample(sampler_CameraGBufferTexture2, fragment_unnamed_9.xy).xyz;
				fragment_unnamed_45 = float4(fragment_unnamed_59.x, fragment_unnamed_59.y, fragment_unnamed_59.z, fragment_unnamed_45.w);
				fragment_unnamed_63.x = dot(fragment_unnamed_45.xyz, fragment_unnamed_45.xyz);
				fragment_unnamed_75.x = fragment_unnamed_63.x != 0.0f;
				fragment_unnamed_63.x = fragment_unnamed_75.x ? (-1.0f) : (-0.0f);
				float3 fragment_unnamed_94 = (fragment_unnamed_45.xyz * 2.0f.xxx) + fragment_unnamed_63.xxx;
				fragment_unnamed_45 = float4(fragment_unnamed_94.x, fragment_unnamed_94.y, fragment_unnamed_94.z, fragment_unnamed_45.w);
				fragment_unnamed_97 = fragment_unnamed_45.yyy * unity_WorldToCamera__array[1].xyz;
				float3 fragment_unnamed_114 = (unity_WorldToCamera__array[0].xyz * fragment_unnamed_45.xxx) + fragment_unnamed_97;
				fragment_unnamed_45 = float4(fragment_unnamed_114.x, fragment_unnamed_114.y, fragment_unnamed_45.z, fragment_unnamed_114.z);
				float3 fragment_unnamed_126 = (unity_WorldToCamera__array[2].xyz * fragment_unnamed_45.zzz) + fragment_unnamed_45.xyw;
				fragment_unnamed_45 = float4(fragment_unnamed_126.x, fragment_unnamed_126.y, fragment_unnamed_126.z, fragment_unnamed_45.w);
				fragment_unnamed_9.x = _CameraDepthTexture.SampleLevel(sampler_CameraDepthTexture, fragment_unnamed_9.xy, 0.0f).x;
				fragment_unnamed_139 = (-unity_OrthoParams.w) + 1.0f;
				fragment_unnamed_9.x *= _ZBufferParams.x;
				fragment_unnamed_63.x = ((-unity_OrthoParams.w) * fragment_unnamed_9.x) + 1.0f;
				fragment_unnamed_9.x = (fragment_unnamed_139 * fragment_unnamed_9.x) + _ZBufferParams.y;
				fragment_unnamed_9.x = fragment_unnamed_63.x / fragment_unnamed_9.x;
				fragment_unnamed_75 = bool4(fragment_input_0.xyxy.x < 0.0f.xxxx.x, fragment_input_0.xyxy.y < 0.0f.xxxx.y, fragment_input_0.xyxy.z < 0.0f.xxxx.z, fragment_input_0.xyxy.w < 0.0f.xxxx.w).xy;
				fragment_unnamed_184.x = int((uint(fragment_unnamed_75.y) * 4294967295u) | (uint(fragment_unnamed_75.x) * 4294967295u));
				fragment_unnamed_198 = bool4(float4(1.0f, 1.0f, 0.0f, 0.0f).x < fragment_input_0.xyxx.x, float4(1.0f, 1.0f, 0.0f, 0.0f).y < fragment_input_0.xyxx.y, float4(1.0f, 1.0f, 0.0f, 0.0f).z < fragment_input_0.xyxx.z, float4(1.0f, 1.0f, 0.0f, 0.0f).w < fragment_input_0.xyxx.w).xy;
				fragment_unnamed_184.y = int((uint(fragment_unnamed_198.y) * 4294967295u) | (uint(fragment_unnamed_198.x) * 4294967295u));
				fragment_unnamed_184 = int2(uint2(fragment_unnamed_184) & uint2(1u, 1u));
				fragment_unnamed_184.x = fragment_unnamed_184.y + fragment_unnamed_184.x;
				fragment_unnamed_63.x = float(fragment_unnamed_184.x);
				fragment_unnamed_231 = 9.9999997473787516355514526367188e-06f >= fragment_unnamed_9.x;
				fragment_unnamed_236 = float(fragment_unnamed_231);
				fragment_unnamed_63.x = fragment_unnamed_236 + fragment_unnamed_63.x;
				fragment_unnamed_63.x *= 100000000.0f;
				fragment_unnamed_97.z = (fragment_unnamed_9.x * _ProjectionParams.z) + fragment_unnamed_63.x;
				float2 fragment_unnamed_263 = (fragment_input_0 * 2.0f.xx) + (-1.0f).xx;
				fragment_unnamed_9 = float3(fragment_unnamed_263.x, fragment_unnamed_9.y, fragment_unnamed_263.y);
				float2 fragment_unnamed_272 = fragment_unnamed_9.xz + (-unity_CameraProjection__array[2].xy);
				fragment_unnamed_9 = float3(fragment_unnamed_272.x, fragment_unnamed_9.y, fragment_unnamed_272.y);
				fragment_unnamed_275.x = unity_CameraProjection__array[0].x;
				fragment_unnamed_275.y = unity_CameraProjection__array[1].y;
				float2 fragment_unnamed_285 = fragment_unnamed_9.xz / fragment_unnamed_275;
				fragment_unnamed_9 = float3(fragment_unnamed_285.x, fragment_unnamed_9.y, fragment_unnamed_285.y);
				fragment_unnamed_236 = (-fragment_unnamed_97.z) + 1.0f;
				fragment_unnamed_236 = (unity_OrthoParams.w * fragment_unnamed_236) + fragment_unnamed_97.z;
				float2 fragment_unnamed_303 = fragment_unnamed_236.xx * fragment_unnamed_9.xz;
				fragment_unnamed_97 = float3(fragment_unnamed_303.x, fragment_unnamed_303.y, fragment_unnamed_97.z);
				fragment_unnamed_306 = int(_AOParams.w);
				fragment_unnamed_63 = fragment_input_0 * _AOParams.zz;
				fragment_unnamed_63 *= _ScreenParams.xy;
				fragment_unnamed_63 = floor(fragment_unnamed_63);
				fragment_unnamed_63.x = dot(float2(0.067110560834407806396484375f, 0.005837149918079376220703125f), fragment_unnamed_63);
				fragment_unnamed_63.x = frac(fragment_unnamed_63.x);
				fragment_unnamed_63.x *= 52.98291778564453125f;
				fragment_unnamed_63.x = frac(fragment_unnamed_63.x);
				fragment_unnamed_343.x = 12.98980045318603515625f;
				fragment_unnamed_236 = 0.0f;
				float3 fragment_unnamed_485;
				for (int fragment_unnamed_347 = 0; fragment_unnamed_347 < fragment_unnamed_306; fragment_unnamed_347++)
				{
					fragment_unnamed_356 = float(fragment_unnamed_347);
					fragment_unnamed_343.y = (fragment_input_0.x * 1.0000000133514319600180897396058e-10f) + fragment_unnamed_356;
					fragment_unnamed_367.x = fragment_unnamed_343.y * 78.233001708984375f;
					fragment_unnamed_367.x = sin(fragment_unnamed_367.x);
					fragment_unnamed_367.x *= 43758.546875f;
					fragment_unnamed_367.x = frac(fragment_unnamed_367.x);
					fragment_unnamed_367.x = fragment_unnamed_63.x + fragment_unnamed_367.x;
					fragment_unnamed_367.x = frac(fragment_unnamed_367.x);
					fragment_unnamed_396.z = (fragment_unnamed_367.x * 2.0f) + (-1.0f);
					fragment_unnamed_367.x = dot(fragment_unnamed_343, float2(1.0f, 78.233001708984375f));
					fragment_unnamed_367.x = sin(fragment_unnamed_367.x);
					fragment_unnamed_367.x *= 43758.546875f;
					fragment_unnamed_367.x = frac(fragment_unnamed_367.x);
					fragment_unnamed_367.x = fragment_unnamed_63.x + fragment_unnamed_367.x;
					fragment_unnamed_367.x *= 6.283185482025146484375f;
					fragment_unnamed_429 = sin(fragment_unnamed_367.x);
					fragment_unnamed_433.x = cos(fragment_unnamed_367.x);
					fragment_unnamed_367.x = ((-fragment_unnamed_396.z) * fragment_unnamed_396.z) + 1.0f;
					fragment_unnamed_367.x = sqrt(fragment_unnamed_367.x);
					fragment_unnamed_433.y = fragment_unnamed_429;
					float2 fragment_unnamed_455 = fragment_unnamed_367.xx * fragment_unnamed_433;
					fragment_unnamed_396 = float3(fragment_unnamed_455.x, fragment_unnamed_455.y, fragment_unnamed_396.z);
					fragment_unnamed_356 += 1.0f;
					fragment_unnamed_356 /= _AOParams.w;
					fragment_unnamed_356 = sqrt(fragment_unnamed_356);
					fragment_unnamed_356 *= _AOParams.y;
					fragment_unnamed_470 = fragment_unnamed_356.xxx * fragment_unnamed_396;
					fragment_unnamed_356 = dot(-fragment_unnamed_45.xyz, fragment_unnamed_470);
					fragment_unnamed_480 = fragment_unnamed_356 >= 0.0f;
					if (fragment_unnamed_480)
					{
						fragment_unnamed_485 = -fragment_unnamed_470;
					}
					else
					{
						fragment_unnamed_485 = fragment_unnamed_470;
					}
					fragment_unnamed_470 = fragment_unnamed_485;
					fragment_unnamed_470 = fragment_unnamed_97 + fragment_unnamed_470;
					fragment_unnamed_367 = fragment_unnamed_470.yy * unity_CameraProjection__array[1].xy;
					fragment_unnamed_367 = (unity_CameraProjection__array[0].xy * fragment_unnamed_470.xx) + fragment_unnamed_367;
					fragment_unnamed_367 = (unity_CameraProjection__array[2].xy * fragment_unnamed_470.zz) + fragment_unnamed_367;
					fragment_unnamed_356 = (-fragment_unnamed_470.z) + 1.0f;
					fragment_unnamed_356 = (unity_OrthoParams.w * fragment_unnamed_356) + fragment_unnamed_470.z;
					fragment_unnamed_367 /= fragment_unnamed_356.xx;
					fragment_unnamed_367 += 1.0f.xx;
					float2 fragment_unnamed_539 = fragment_unnamed_367 * 0.5f.xx;
					fragment_unnamed_470 = float3(fragment_unnamed_539.x, fragment_unnamed_539.y, fragment_unnamed_470.z);
					float2 fragment_unnamed_546 = clamp(fragment_unnamed_470.xy, 0.0f.xx, 1.0f.xx);
					fragment_unnamed_470 = float3(fragment_unnamed_546.x, fragment_unnamed_546.y, fragment_unnamed_470.z);
					float2 fragment_unnamed_554 = fragment_unnamed_470.xy * _RenderViewportScaleFactor.xx;
					fragment_unnamed_470 = float3(fragment_unnamed_554.x, fragment_unnamed_554.y, fragment_unnamed_470.z);
					fragment_unnamed_356 = _CameraDepthTexture.SampleLevel(sampler_CameraDepthTexture, fragment_unnamed_470.xy, 0.0f).x;
					fragment_unnamed_356 *= _ZBufferParams.x;
					fragment_unnamed_470.x = ((-unity_OrthoParams.w) * fragment_unnamed_356) + 1.0f;
					fragment_unnamed_356 = (fragment_unnamed_139 * fragment_unnamed_356) + _ZBufferParams.y;
					fragment_unnamed_356 = fragment_unnamed_470.x / fragment_unnamed_356;
					fragment_unnamed_585 = bool4(fragment_unnamed_367.xyxx.x < 0.0f.xxxx.x, fragment_unnamed_367.xyxx.y < 0.0f.xxxx.y, fragment_unnamed_367.xyxx.z < 0.0f.xxxx.z, fragment_unnamed_367.xyxx.w < 0.0f.xxxx.w).xy;
					fragment_unnamed_590.x = int((uint(fragment_unnamed_585.y) * 4294967295u) | (uint(fragment_unnamed_585.x) * 4294967295u));
					fragment_unnamed_602 = bool4(2.0f.xxxx.x < fragment_unnamed_367.xyxy.x, 2.0f.xxxx.y < fragment_unnamed_367.xyxy.y, 2.0f.xxxx.z < fragment_unnamed_367.xyxy.z, 2.0f.xxxx.w < fragment_unnamed_367.xyxy.w).xy;
					fragment_unnamed_590.y = int((uint(fragment_unnamed_602.y) * 4294967295u) | (uint(fragment_unnamed_602.x) * 4294967295u));
					fragment_unnamed_590 = int2(uint2(fragment_unnamed_590) & uint2(1u, 1u));
					fragment_unnamed_590.x = fragment_unnamed_590.y + fragment_unnamed_590.x;
					fragment_unnamed_470.x = float(fragment_unnamed_590.x);
					fragment_unnamed_602.x = 9.9999997473787516355514526367188e-06f >= fragment_unnamed_356;
					fragment_unnamed_636 = float(fragment_unnamed_602.x);
					fragment_unnamed_470.x = fragment_unnamed_636 + fragment_unnamed_470.x;
					fragment_unnamed_470.x *= 100000000.0f;
					fragment_unnamed_396.z = (fragment_unnamed_356 * _ProjectionParams.z) + fragment_unnamed_470.x;
					fragment_unnamed_367 += (-unity_CameraProjection__array[2].xy);
					fragment_unnamed_367 += (-1.0f).xx;
					fragment_unnamed_367 /= fragment_unnamed_275;
					fragment_unnamed_356 = (-fragment_unnamed_396.z) + 1.0f;
					fragment_unnamed_356 = (unity_OrthoParams.w * fragment_unnamed_356) + fragment_unnamed_396.z;
					float2 fragment_unnamed_682 = fragment_unnamed_356.xx * fragment_unnamed_367;
					fragment_unnamed_396 = float3(fragment_unnamed_682.x, fragment_unnamed_682.y, fragment_unnamed_396.z);
					fragment_unnamed_470 = (-fragment_unnamed_97) + fragment_unnamed_396;
					fragment_unnamed_356 = dot(fragment_unnamed_470, fragment_unnamed_45.xyz);
					fragment_unnamed_356 = ((-fragment_unnamed_97.z) * 0.00200000009499490261077880859375f) + fragment_unnamed_356;
					fragment_unnamed_356 = max(fragment_unnamed_356, 0.0f);
					fragment_unnamed_367.x = dot(fragment_unnamed_470, fragment_unnamed_470);
					fragment_unnamed_367.x += 9.9999997473787516355514526367188e-05f;
					fragment_unnamed_356 /= fragment_unnamed_367.x;
					fragment_unnamed_236 += fragment_unnamed_356;
				}
				fragment_unnamed_9.x = fragment_unnamed_236 * _AOParams.y;
				fragment_unnamed_9.x *= _AOParams.x;
				fragment_unnamed_9.x /= _AOParams.w;
				fragment_unnamed_9.x = max(abs(fragment_unnamed_9.x), 1.1920928955078125e-07f);
				fragment_unnamed_9.x = log2(fragment_unnamed_9.x);
				fragment_unnamed_9.x *= 0.60000002384185791015625f;
				fragment_output_0.x = exp2(fragment_unnamed_9.x);
				float3 fragment_unnamed_763 = (fragment_unnamed_45.xyz * 0.5f.xxx) + 0.5f.xxx;
				fragment_output_0 = float4(fragment_output_0.x, fragment_unnamed_763.x, fragment_unnamed_763.y, fragment_unnamed_763.z);
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				unity_CameraProjection__array[0] = float4(unity_CameraProjection[0][0], unity_CameraProjection[1][0], unity_CameraProjection[2][0], unity_CameraProjection[3][0]);
				unity_CameraProjection__array[1] = float4(unity_CameraProjection[0][1], unity_CameraProjection[1][1], unity_CameraProjection[2][1], unity_CameraProjection[3][1]);
				unity_CameraProjection__array[2] = float4(unity_CameraProjection[0][2], unity_CameraProjection[1][2], unity_CameraProjection[2][2], unity_CameraProjection[3][2]);
				unity_CameraProjection__array[3] = float4(unity_CameraProjection[0][3], unity_CameraProjection[1][3], unity_CameraProjection[2][3], unity_CameraProjection[3][3]);

				unity_WorldToCamera__array[0] = float4(unity_WorldToCamera[0][0], unity_WorldToCamera[1][0], unity_WorldToCamera[2][0], unity_WorldToCamera[3][0]);
				unity_WorldToCamera__array[1] = float4(unity_WorldToCamera[0][1], unity_WorldToCamera[1][1], unity_WorldToCamera[2][1], unity_WorldToCamera[3][1]);
				unity_WorldToCamera__array[2] = float4(unity_WorldToCamera[0][2], unity_WorldToCamera[1][2], unity_WorldToCamera[2][2], unity_WorldToCamera[3][2]);
				unity_WorldToCamera__array[3] = float4(unity_WorldToCamera[0][3], unity_WorldToCamera[1][3], unity_WorldToCamera[2][3], unity_WorldToCamera[3][3]);

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

			float4x4 unity_CameraProjection;
			float4x4 unity_WorldToCamera;
			float4 _ProjectionParams;
			float4 unity_OrthoParams;
			float4 _ZBufferParams;
			float4 _ScreenParams;
			float _RenderViewportScaleFactor;
			float3 _FogParams;
			float4 _AOParams;

			static float4 unity_CameraProjection__array[4];
			static float4 unity_WorldToCamera__array[4];
			Texture2D<float4> _CameraGBufferTexture2;
			SamplerState sampler_CameraGBufferTexture2;
			Texture2D<float4> _CameraDepthTexture;
			SamplerState sampler_CameraDepthTexture;

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

			static float3 fragment_unnamed_9;
			static float4 fragment_unnamed_45;
			static float2 fragment_unnamed_63;
			static bool2 fragment_unnamed_75;
			static float3 fragment_unnamed_97;
			static float fragment_unnamed_139;
			static int2 fragment_unnamed_184;
			static bool2 fragment_unnamed_198;
			static bool fragment_unnamed_231;
			static float fragment_unnamed_236;
			static float2 fragment_unnamed_275;
			static int fragment_unnamed_306;
			static float2 fragment_unnamed_343;
			static float fragment_unnamed_356;
			static float2 fragment_unnamed_367;
			static float3 fragment_unnamed_396;
			static float fragment_unnamed_429;
			static float2 fragment_unnamed_433;
			static float3 fragment_unnamed_470;
			static bool fragment_unnamed_480;
			static bool2 fragment_unnamed_585;
			static int2 fragment_unnamed_590;
			static bool2 fragment_unnamed_602;
			static float fragment_unnamed_636;
			static int fragment_unnamed_822;

			void frag_main()
			{
				fragment_unnamed_9 = float3(fragment_input_0.x, fragment_input_0.y, fragment_unnamed_9.z);
				float2 fragment_unnamed_22 = clamp(fragment_unnamed_9.xy, 0.0f.xx, 1.0f.xx);
				fragment_unnamed_9 = float3(fragment_unnamed_22.x, fragment_unnamed_22.y, fragment_unnamed_9.z);
				float2 fragment_unnamed_41 = fragment_unnamed_9.xy * _RenderViewportScaleFactor.xx;
				fragment_unnamed_9 = float3(fragment_unnamed_41.x, fragment_unnamed_41.y, fragment_unnamed_9.z);
				float3 fragment_unnamed_59 = _CameraGBufferTexture2.Sample(sampler_CameraGBufferTexture2, fragment_unnamed_9.xy).xyz;
				fragment_unnamed_45 = float4(fragment_unnamed_59.x, fragment_unnamed_59.y, fragment_unnamed_59.z, fragment_unnamed_45.w);
				fragment_unnamed_63.x = dot(fragment_unnamed_45.xyz, fragment_unnamed_45.xyz);
				fragment_unnamed_75.x = fragment_unnamed_63.x != 0.0f;
				fragment_unnamed_63.x = fragment_unnamed_75.x ? (-1.0f) : (-0.0f);
				float3 fragment_unnamed_94 = (fragment_unnamed_45.xyz * 2.0f.xxx) + fragment_unnamed_63.xxx;
				fragment_unnamed_45 = float4(fragment_unnamed_94.x, fragment_unnamed_94.y, fragment_unnamed_94.z, fragment_unnamed_45.w);
				fragment_unnamed_97 = fragment_unnamed_45.yyy * unity_WorldToCamera__array[1].xyz;
				float3 fragment_unnamed_114 = (unity_WorldToCamera__array[0].xyz * fragment_unnamed_45.xxx) + fragment_unnamed_97;
				fragment_unnamed_45 = float4(fragment_unnamed_114.x, fragment_unnamed_114.y, fragment_unnamed_45.z, fragment_unnamed_114.z);
				float3 fragment_unnamed_126 = (unity_WorldToCamera__array[2].xyz * fragment_unnamed_45.zzz) + fragment_unnamed_45.xyw;
				fragment_unnamed_45 = float4(fragment_unnamed_126.x, fragment_unnamed_126.y, fragment_unnamed_126.z, fragment_unnamed_45.w);
				fragment_unnamed_9.x = _CameraDepthTexture.SampleLevel(sampler_CameraDepthTexture, fragment_unnamed_9.xy, 0.0f).x;
				fragment_unnamed_139 = (-unity_OrthoParams.w) + 1.0f;
				fragment_unnamed_9.x *= _ZBufferParams.x;
				fragment_unnamed_63.x = ((-unity_OrthoParams.w) * fragment_unnamed_9.x) + 1.0f;
				fragment_unnamed_9.x = (fragment_unnamed_139 * fragment_unnamed_9.x) + _ZBufferParams.y;
				fragment_unnamed_9.x = fragment_unnamed_63.x / fragment_unnamed_9.x;
				fragment_unnamed_75 = bool4(fragment_input_0.xyxy.x < 0.0f.xxxx.x, fragment_input_0.xyxy.y < 0.0f.xxxx.y, fragment_input_0.xyxy.z < 0.0f.xxxx.z, fragment_input_0.xyxy.w < 0.0f.xxxx.w).xy;
				fragment_unnamed_184.x = int((uint(fragment_unnamed_75.y) * 4294967295u) | (uint(fragment_unnamed_75.x) * 4294967295u));
				fragment_unnamed_198 = bool4(float4(1.0f, 1.0f, 0.0f, 0.0f).x < fragment_input_0.xyxx.x, float4(1.0f, 1.0f, 0.0f, 0.0f).y < fragment_input_0.xyxx.y, float4(1.0f, 1.0f, 0.0f, 0.0f).z < fragment_input_0.xyxx.z, float4(1.0f, 1.0f, 0.0f, 0.0f).w < fragment_input_0.xyxx.w).xy;
				fragment_unnamed_184.y = int((uint(fragment_unnamed_198.y) * 4294967295u) | (uint(fragment_unnamed_198.x) * 4294967295u));
				fragment_unnamed_184 = int2(uint2(fragment_unnamed_184) & uint2(1u, 1u));
				fragment_unnamed_184.x = fragment_unnamed_184.y + fragment_unnamed_184.x;
				fragment_unnamed_63.x = float(fragment_unnamed_184.x);
				fragment_unnamed_231 = 9.9999997473787516355514526367188e-06f >= fragment_unnamed_9.x;
				fragment_unnamed_236 = float(fragment_unnamed_231);
				fragment_unnamed_63.x = fragment_unnamed_236 + fragment_unnamed_63.x;
				fragment_unnamed_63.x *= 100000000.0f;
				fragment_unnamed_97.z = (fragment_unnamed_9.x * _ProjectionParams.z) + fragment_unnamed_63.x;
				float2 fragment_unnamed_263 = (fragment_input_0 * 2.0f.xx) + (-1.0f).xx;
				fragment_unnamed_9 = float3(fragment_unnamed_263.x, fragment_unnamed_9.y, fragment_unnamed_263.y);
				float2 fragment_unnamed_272 = fragment_unnamed_9.xz + (-unity_CameraProjection__array[2].xy);
				fragment_unnamed_9 = float3(fragment_unnamed_272.x, fragment_unnamed_9.y, fragment_unnamed_272.y);
				fragment_unnamed_275.x = unity_CameraProjection__array[0].x;
				fragment_unnamed_275.y = unity_CameraProjection__array[1].y;
				float2 fragment_unnamed_285 = fragment_unnamed_9.xz / fragment_unnamed_275;
				fragment_unnamed_9 = float3(fragment_unnamed_285.x, fragment_unnamed_9.y, fragment_unnamed_285.y);
				fragment_unnamed_236 = (-fragment_unnamed_97.z) + 1.0f;
				fragment_unnamed_236 = (unity_OrthoParams.w * fragment_unnamed_236) + fragment_unnamed_97.z;
				float2 fragment_unnamed_303 = fragment_unnamed_236.xx * fragment_unnamed_9.xz;
				fragment_unnamed_97 = float3(fragment_unnamed_303.x, fragment_unnamed_303.y, fragment_unnamed_97.z);
				fragment_unnamed_306 = int(_AOParams.w);
				fragment_unnamed_63 = fragment_input_0 * _AOParams.zz;
				fragment_unnamed_63 *= _ScreenParams.xy;
				fragment_unnamed_63 = floor(fragment_unnamed_63);
				fragment_unnamed_63.x = dot(float2(0.067110560834407806396484375f, 0.005837149918079376220703125f), fragment_unnamed_63);
				fragment_unnamed_63.x = frac(fragment_unnamed_63.x);
				fragment_unnamed_63.x *= 52.98291778564453125f;
				fragment_unnamed_63.x = frac(fragment_unnamed_63.x);
				fragment_unnamed_343.x = 12.98980045318603515625f;
				fragment_unnamed_236 = 0.0f;
				float3 fragment_unnamed_485;
				for (int fragment_unnamed_347 = 0; fragment_unnamed_347 < fragment_unnamed_306; fragment_unnamed_347++)
				{
					fragment_unnamed_356 = float(fragment_unnamed_347);
					fragment_unnamed_343.y = (fragment_input_0.x * 1.0000000133514319600180897396058e-10f) + fragment_unnamed_356;
					fragment_unnamed_367.x = fragment_unnamed_343.y * 78.233001708984375f;
					fragment_unnamed_367.x = sin(fragment_unnamed_367.x);
					fragment_unnamed_367.x *= 43758.546875f;
					fragment_unnamed_367.x = frac(fragment_unnamed_367.x);
					fragment_unnamed_367.x = fragment_unnamed_63.x + fragment_unnamed_367.x;
					fragment_unnamed_367.x = frac(fragment_unnamed_367.x);
					fragment_unnamed_396.z = (fragment_unnamed_367.x * 2.0f) + (-1.0f);
					fragment_unnamed_367.x = dot(fragment_unnamed_343, float2(1.0f, 78.233001708984375f));
					fragment_unnamed_367.x = sin(fragment_unnamed_367.x);
					fragment_unnamed_367.x *= 43758.546875f;
					fragment_unnamed_367.x = frac(fragment_unnamed_367.x);
					fragment_unnamed_367.x = fragment_unnamed_63.x + fragment_unnamed_367.x;
					fragment_unnamed_367.x *= 6.283185482025146484375f;
					fragment_unnamed_429 = sin(fragment_unnamed_367.x);
					fragment_unnamed_433.x = cos(fragment_unnamed_367.x);
					fragment_unnamed_367.x = ((-fragment_unnamed_396.z) * fragment_unnamed_396.z) + 1.0f;
					fragment_unnamed_367.x = sqrt(fragment_unnamed_367.x);
					fragment_unnamed_433.y = fragment_unnamed_429;
					float2 fragment_unnamed_455 = fragment_unnamed_367.xx * fragment_unnamed_433;
					fragment_unnamed_396 = float3(fragment_unnamed_455.x, fragment_unnamed_455.y, fragment_unnamed_396.z);
					fragment_unnamed_356 += 1.0f;
					fragment_unnamed_356 /= _AOParams.w;
					fragment_unnamed_356 = sqrt(fragment_unnamed_356);
					fragment_unnamed_356 *= _AOParams.y;
					fragment_unnamed_470 = fragment_unnamed_356.xxx * fragment_unnamed_396;
					fragment_unnamed_356 = dot(-fragment_unnamed_45.xyz, fragment_unnamed_470);
					fragment_unnamed_480 = fragment_unnamed_356 >= 0.0f;
					if (fragment_unnamed_480)
					{
						fragment_unnamed_485 = -fragment_unnamed_470;
					}
					else
					{
						fragment_unnamed_485 = fragment_unnamed_470;
					}
					fragment_unnamed_470 = fragment_unnamed_485;
					fragment_unnamed_470 = fragment_unnamed_97 + fragment_unnamed_470;
					fragment_unnamed_367 = fragment_unnamed_470.yy * unity_CameraProjection__array[1].xy;
					fragment_unnamed_367 = (unity_CameraProjection__array[0].xy * fragment_unnamed_470.xx) + fragment_unnamed_367;
					fragment_unnamed_367 = (unity_CameraProjection__array[2].xy * fragment_unnamed_470.zz) + fragment_unnamed_367;
					fragment_unnamed_356 = (-fragment_unnamed_470.z) + 1.0f;
					fragment_unnamed_356 = (unity_OrthoParams.w * fragment_unnamed_356) + fragment_unnamed_470.z;
					fragment_unnamed_367 /= fragment_unnamed_356.xx;
					fragment_unnamed_367 += 1.0f.xx;
					float2 fragment_unnamed_539 = fragment_unnamed_367 * 0.5f.xx;
					fragment_unnamed_470 = float3(fragment_unnamed_539.x, fragment_unnamed_539.y, fragment_unnamed_470.z);
					float2 fragment_unnamed_546 = clamp(fragment_unnamed_470.xy, 0.0f.xx, 1.0f.xx);
					fragment_unnamed_470 = float3(fragment_unnamed_546.x, fragment_unnamed_546.y, fragment_unnamed_470.z);
					float2 fragment_unnamed_554 = fragment_unnamed_470.xy * _RenderViewportScaleFactor.xx;
					fragment_unnamed_470 = float3(fragment_unnamed_554.x, fragment_unnamed_554.y, fragment_unnamed_470.z);
					fragment_unnamed_356 = _CameraDepthTexture.SampleLevel(sampler_CameraDepthTexture, fragment_unnamed_470.xy, 0.0f).x;
					fragment_unnamed_356 *= _ZBufferParams.x;
					fragment_unnamed_470.x = ((-unity_OrthoParams.w) * fragment_unnamed_356) + 1.0f;
					fragment_unnamed_356 = (fragment_unnamed_139 * fragment_unnamed_356) + _ZBufferParams.y;
					fragment_unnamed_356 = fragment_unnamed_470.x / fragment_unnamed_356;
					fragment_unnamed_585 = bool4(fragment_unnamed_367.xyxx.x < 0.0f.xxxx.x, fragment_unnamed_367.xyxx.y < 0.0f.xxxx.y, fragment_unnamed_367.xyxx.z < 0.0f.xxxx.z, fragment_unnamed_367.xyxx.w < 0.0f.xxxx.w).xy;
					fragment_unnamed_590.x = int((uint(fragment_unnamed_585.y) * 4294967295u) | (uint(fragment_unnamed_585.x) * 4294967295u));
					fragment_unnamed_602 = bool4(2.0f.xxxx.x < fragment_unnamed_367.xyxy.x, 2.0f.xxxx.y < fragment_unnamed_367.xyxy.y, 2.0f.xxxx.z < fragment_unnamed_367.xyxy.z, 2.0f.xxxx.w < fragment_unnamed_367.xyxy.w).xy;
					fragment_unnamed_590.y = int((uint(fragment_unnamed_602.y) * 4294967295u) | (uint(fragment_unnamed_602.x) * 4294967295u));
					fragment_unnamed_590 = int2(uint2(fragment_unnamed_590) & uint2(1u, 1u));
					fragment_unnamed_590.x = fragment_unnamed_590.y + fragment_unnamed_590.x;
					fragment_unnamed_470.x = float(fragment_unnamed_590.x);
					fragment_unnamed_602.x = 9.9999997473787516355514526367188e-06f >= fragment_unnamed_356;
					fragment_unnamed_636 = float(fragment_unnamed_602.x);
					fragment_unnamed_470.x = fragment_unnamed_636 + fragment_unnamed_470.x;
					fragment_unnamed_470.x *= 100000000.0f;
					fragment_unnamed_396.z = (fragment_unnamed_356 * _ProjectionParams.z) + fragment_unnamed_470.x;
					fragment_unnamed_367 += (-unity_CameraProjection__array[2].xy);
					fragment_unnamed_367 += (-1.0f).xx;
					fragment_unnamed_367 /= fragment_unnamed_275;
					fragment_unnamed_356 = (-fragment_unnamed_396.z) + 1.0f;
					fragment_unnamed_356 = (unity_OrthoParams.w * fragment_unnamed_356) + fragment_unnamed_396.z;
					float2 fragment_unnamed_682 = fragment_unnamed_356.xx * fragment_unnamed_367;
					fragment_unnamed_396 = float3(fragment_unnamed_682.x, fragment_unnamed_682.y, fragment_unnamed_396.z);
					fragment_unnamed_470 = (-fragment_unnamed_97) + fragment_unnamed_396;
					fragment_unnamed_356 = dot(fragment_unnamed_470, fragment_unnamed_45.xyz);
					fragment_unnamed_356 = ((-fragment_unnamed_97.z) * 0.00200000009499490261077880859375f) + fragment_unnamed_356;
					fragment_unnamed_356 = max(fragment_unnamed_356, 0.0f);
					fragment_unnamed_367.x = dot(fragment_unnamed_470, fragment_unnamed_470);
					fragment_unnamed_367.x += 9.9999997473787516355514526367188e-05f;
					fragment_unnamed_356 /= fragment_unnamed_367.x;
					fragment_unnamed_236 += fragment_unnamed_356;
				}
				fragment_unnamed_9.x = fragment_unnamed_236 * _AOParams.y;
				fragment_unnamed_9.x *= _AOParams.x;
				fragment_unnamed_9.x /= _AOParams.w;
				fragment_unnamed_9.x = max(abs(fragment_unnamed_9.x), 1.1920928955078125e-07f);
				fragment_unnamed_9.x = log2(fragment_unnamed_9.x);
				fragment_unnamed_9.x *= 0.60000002384185791015625f;
				fragment_unnamed_9.x = exp2(fragment_unnamed_9.x);
				fragment_unnamed_63.x = _CameraDepthTexture.Sample(sampler_CameraDepthTexture, fragment_input_1).x;
				fragment_unnamed_63.x *= _ZBufferParams.x;
				fragment_unnamed_236 = ((-unity_OrthoParams.w) * fragment_unnamed_63.x) + 1.0f;
				fragment_unnamed_139 = (fragment_unnamed_139 * fragment_unnamed_63.x) + _ZBufferParams.y;
				fragment_unnamed_139 = fragment_unnamed_236 / fragment_unnamed_139;
				fragment_unnamed_139 = (fragment_unnamed_139 * _ProjectionParams.z) + (-_ProjectionParams.y);
				fragment_unnamed_139 *= _FogParams.x;
				fragment_unnamed_139 *= (-fragment_unnamed_139);
				fragment_unnamed_139 = exp2(fragment_unnamed_139);
				fragment_output_0.x = fragment_unnamed_139 * fragment_unnamed_9.x;
				float3 fragment_unnamed_818 = (fragment_unnamed_45.xyz * 0.5f.xxx) + 0.5f.xxx;
				fragment_output_0 = float4(fragment_output_0.x, fragment_unnamed_818.x, fragment_unnamed_818.y, fragment_unnamed_818.z);
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				unity_CameraProjection__array[0] = float4(unity_CameraProjection[0][0], unity_CameraProjection[1][0], unity_CameraProjection[2][0], unity_CameraProjection[3][0]);
				unity_CameraProjection__array[1] = float4(unity_CameraProjection[0][1], unity_CameraProjection[1][1], unity_CameraProjection[2][1], unity_CameraProjection[3][1]);
				unity_CameraProjection__array[2] = float4(unity_CameraProjection[0][2], unity_CameraProjection[1][2], unity_CameraProjection[2][2], unity_CameraProjection[3][2]);
				unity_CameraProjection__array[3] = float4(unity_CameraProjection[0][3], unity_CameraProjection[1][3], unity_CameraProjection[2][3], unity_CameraProjection[3][3]);

				unity_WorldToCamera__array[0] = float4(unity_WorldToCamera[0][0], unity_WorldToCamera[1][0], unity_WorldToCamera[2][0], unity_WorldToCamera[3][0]);
				unity_WorldToCamera__array[1] = float4(unity_WorldToCamera[0][1], unity_WorldToCamera[1][1], unity_WorldToCamera[2][1], unity_WorldToCamera[3][1]);
				unity_WorldToCamera__array[2] = float4(unity_WorldToCamera[0][2], unity_WorldToCamera[1][2], unity_WorldToCamera[2][2], unity_WorldToCamera[3][2]);
				unity_WorldToCamera__array[3] = float4(unity_WorldToCamera[0][3], unity_WorldToCamera[1][3], unity_WorldToCamera[2][3], unity_WorldToCamera[3][3]);

				fragment_input_0 = stage_input.fragment_input_0;
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // APPLY_FORWARD_FOG


			#ifndef APPLY_FORWARD_FOG
			#define ANY_SHADER_VARIANT_ACTIVE

			float4x4 unity_CameraProjection;
			float4x4 unity_WorldToCamera;
			float4 _ProjectionParams;
			float4 unity_OrthoParams;
			float4 _ZBufferParams;
			float4 _ScreenParams;
			float _RenderViewportScaleFactor;
			float4 _AOParams;

			static float4 fragment_uniform_buffer_0[32];
			Texture2D<float4> _CameraGBufferTexture2;
			Texture2D<float4> _CameraDepthTexture;
			SamplerState sampler_CameraGBufferTexture2;
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
				precise float fragment_unnamed_50 = clamp(fragment_input_1.x, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_51 = clamp(fragment_input_1.y, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_54 = _CameraGBufferTexture2.Sample(sampler_CameraGBufferTexture2, float2(fragment_unnamed_50, fragment_unnamed_51));
				float fragment_unnamed_56 = fragment_unnamed_54.x;
				float fragment_unnamed_68 = asfloat((dot(float3(fragment_unnamed_56, fragment_unnamed_54.yz), float3(fragment_unnamed_56, fragment_unnamed_54.yz)) != 0.0f) ? 3212836864u : 2147483648u);
				float fragment_unnamed_69 = mad(fragment_unnamed_56, 2.0f, fragment_unnamed_68);
				float fragment_unnamed_71 = mad(fragment_unnamed_54.y, 2.0f, fragment_unnamed_68);
				float fragment_unnamed_72 = mad(fragment_unnamed_54.z, 2.0f, fragment_unnamed_68);
				precise float fragment_unnamed_79 = fragment_unnamed_71 * fragment_uniform_buffer_0[13u].x;
				precise float fragment_unnamed_80 = fragment_unnamed_71 * fragment_uniform_buffer_0[13u].y;
				precise float fragment_unnamed_81 = fragment_unnamed_71 * fragment_uniform_buffer_0[13u].z;
				float fragment_unnamed_97 = mad(fragment_uniform_buffer_0[14u].x, fragment_unnamed_72, mad(fragment_uniform_buffer_0[12u].x, fragment_unnamed_69, fragment_unnamed_79));
				float fragment_unnamed_98 = mad(fragment_uniform_buffer_0[14u].y, fragment_unnamed_72, mad(fragment_uniform_buffer_0[12u].y, fragment_unnamed_69, fragment_unnamed_80));
				float fragment_unnamed_99 = mad(fragment_uniform_buffer_0[14u].z, fragment_unnamed_72, mad(fragment_uniform_buffer_0[12u].z, fragment_unnamed_69, fragment_unnamed_81));
				precise float fragment_unnamed_108 = (-0.0f) - fragment_uniform_buffer_0[20u].w;
				precise float fragment_unnamed_110 = fragment_unnamed_108 + 1.0f;
				precise float fragment_unnamed_115 = _CameraDepthTexture.SampleLevel(sampler_CameraDepthTexture, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f).x * fragment_uniform_buffer_0[21u].x;
				precise float fragment_unnamed_119 = (-0.0f) - fragment_uniform_buffer_0[20u].w;
				precise float fragment_unnamed_125 = mad(fragment_unnamed_119, fragment_unnamed_115, 1.0f) / mad(fragment_unnamed_110, fragment_unnamed_115, fragment_uniform_buffer_0[21u].y);
				precise float fragment_unnamed_155 = asfloat(((9.9999997473787516355514526367188e-06f >= fragment_unnamed_125) ? 4294967295u : 0u) & 1065353216u) + float(int(((((1.0f < fragment_input_1.y) ? 4294967295u : 0u) | ((1.0f < fragment_input_1.x) ? 4294967295u : 0u)) & 1u) + ((((fragment_input_1.y < 0.0f) ? 4294967295u : 0u) | ((fragment_input_1.x < 0.0f) ? 4294967295u : 0u)) & 1u)));
				precise float fragment_unnamed_156 = fragment_unnamed_155 * 100000000.0f;
				float fragment_unnamed_162 = mad(fragment_unnamed_125, fragment_uniform_buffer_0[17u].z, fragment_unnamed_156);
				precise float fragment_unnamed_174 = (-0.0f) - fragment_uniform_buffer_0[2u].x;
				precise float fragment_unnamed_176 = (-0.0f) - fragment_uniform_buffer_0[2u].y;
				precise float fragment_unnamed_177 = mad(fragment_input_1.x, 2.0f, -1.0f) + fragment_unnamed_174;
				precise float fragment_unnamed_178 = mad(fragment_input_1.y, 2.0f, -1.0f) + fragment_unnamed_176;
				float fragment_unnamed_184 = asfloat(asuint(fragment_uniform_buffer_0[0u]).x);
				float fragment_unnamed_189 = asfloat(asuint(fragment_uniform_buffer_0[1u]).y);
				precise float fragment_unnamed_190 = fragment_unnamed_177 / fragment_unnamed_184;
				precise float fragment_unnamed_191 = fragment_unnamed_178 / fragment_unnamed_189;
				precise float fragment_unnamed_192 = (-0.0f) - fragment_unnamed_162;
				precise float fragment_unnamed_193 = fragment_unnamed_192 + 1.0f;
				float fragment_unnamed_197 = mad(fragment_uniform_buffer_0[20u].w, fragment_unnamed_193, fragment_unnamed_162);
				precise float fragment_unnamed_198 = fragment_unnamed_197 * fragment_unnamed_190;
				precise float fragment_unnamed_199 = fragment_unnamed_197 * fragment_unnamed_191;
				uint fragment_unnamed_204 = uint(int(fragment_uniform_buffer_0[31u].w));
				precise float fragment_unnamed_212 = fragment_input_1.x * fragment_uniform_buffer_0[31u].z;
				precise float fragment_unnamed_213 = fragment_input_1.y * fragment_uniform_buffer_0[31u].z;
				precise float fragment_unnamed_219 = fragment_unnamed_212 * fragment_uniform_buffer_0[22u].x;
				precise float fragment_unnamed_220 = fragment_unnamed_213 * fragment_uniform_buffer_0[22u].y;
				precise float fragment_unnamed_229 = frac(dot(float2(0.067110560834407806396484375f, 0.005837149918079376220703125f), float2(floor(fragment_unnamed_219), floor(fragment_unnamed_220)))) * 52.98291778564453125f;
				float fragment_unnamed_231 = frac(fragment_unnamed_229);
				float fragment_unnamed_232 = asfloat(1095751225u);
				float fragment_unnamed_235;
				fragment_unnamed_235 = asfloat(0u);
				precise float fragment_unnamed_236;
				precise float fragment_unnamed_270;
				float fragment_unnamed_272;
				float fragment_unnamed_275;
				precise float fragment_unnamed_277;
				precise float fragment_unnamed_280;
				precise float fragment_unnamed_283;
				float fragment_unnamed_285;
				precise float fragment_unnamed_290;
				precise float fragment_unnamed_292;
				precise float fragment_unnamed_293;
				precise float fragment_unnamed_297;
				float fragment_unnamed_299;
				precise float fragment_unnamed_300;
				precise float fragment_unnamed_301;
				precise float fragment_unnamed_302;
				precise float fragment_unnamed_306;
				precise float fragment_unnamed_311;
				precise float fragment_unnamed_312;
				precise float fragment_unnamed_313;
				precise float fragment_unnamed_314;
				precise float fragment_unnamed_315;
				precise float fragment_unnamed_316;
				precise float fragment_unnamed_317;
				bool fragment_unnamed_321;
				precise float fragment_unnamed_322;
				precise float fragment_unnamed_323;
				precise float fragment_unnamed_324;
				precise float fragment_unnamed_328;
				precise float fragment_unnamed_329;
				precise float fragment_unnamed_330;
				precise float fragment_unnamed_335;
				precise float fragment_unnamed_336;
				precise float fragment_unnamed_349;
				precise float fragment_unnamed_350;
				float fragment_unnamed_354;
				precise float fragment_unnamed_355;
				precise float fragment_unnamed_356;
				precise float fragment_unnamed_357;
				precise float fragment_unnamed_358;
				precise float fragment_unnamed_359;
				precise float fragment_unnamed_360;
				precise float fragment_unnamed_366;
				precise float fragment_unnamed_367;
				precise float fragment_unnamed_375;
				precise float fragment_unnamed_379;
				precise float fragment_unnamed_385;
				precise float fragment_unnamed_404;
				precise float fragment_unnamed_405;
				float fragment_unnamed_409;
				precise float fragment_unnamed_413;
				precise float fragment_unnamed_415;
				precise float fragment_unnamed_416;
				precise float fragment_unnamed_417;
				precise float fragment_unnamed_418;
				precise float fragment_unnamed_419;
				precise float fragment_unnamed_420;
				precise float fragment_unnamed_421;
				precise float fragment_unnamed_422;
				precise float fragment_unnamed_423;
				float fragment_unnamed_427;
				precise float fragment_unnamed_428;
				precise float fragment_unnamed_429;
				precise float fragment_unnamed_430;
				precise float fragment_unnamed_431;
				precise float fragment_unnamed_432;
				precise float fragment_unnamed_433;
				precise float fragment_unnamed_434;
				precise float fragment_unnamed_435;
				precise float fragment_unnamed_439;
				precise float fragment_unnamed_446;
				precise float fragment_unnamed_448;
				for (uint fragment_unnamed_237 = 0u; !(int(fragment_unnamed_237) >= int(fragment_unnamed_204)); fragment_unnamed_270 = float(int(fragment_unnamed_237)) * 1.00010001659393310546875f, fragment_unnamed_272 = floor(fragment_unnamed_270), fragment_unnamed_275 = mad(fragment_input_1.x, 1.0000000133514319600180897396058e-10f, fragment_unnamed_272), fragment_unnamed_277 = fragment_unnamed_275 * 78.233001708984375f, fragment_unnamed_280 = sin(fragment_unnamed_277) * 43758.546875f, fragment_unnamed_283 = fragment_unnamed_231 + frac(fragment_unnamed_280), fragment_unnamed_285 = mad(frac(fragment_unnamed_283), 2.0f, -1.0f), fragment_unnamed_290 = sin(dot(float2(fragment_unnamed_232, fragment_unnamed_275), float2(1.0f, 78.233001708984375f))) * 43758.546875f, fragment_unnamed_292 = fragment_unnamed_231 + frac(fragment_unnamed_290), fragment_unnamed_293 = fragment_unnamed_292 * 6.283185482025146484375f, fragment_unnamed_297 = (-0.0f) - fragment_unnamed_285, fragment_unnamed_299 = sqrt(mad(fragment_unnamed_297, fragment_unnamed_285, 1.0f)), fragment_unnamed_300 = fragment_unnamed_299 * cos(fragment_unnamed_293), fragment_unnamed_301 = fragment_unnamed_299 * sin(fragment_unnamed_293), fragment_unnamed_302 = fragment_unnamed_272 + 1.0f, fragment_unnamed_306 = fragment_unnamed_302 / fragment_uniform_buffer_0[31u].w, fragment_unnamed_311 = sqrt(fragment_unnamed_306) * fragment_uniform_buffer_0[31u].y, fragment_unnamed_312 = fragment_unnamed_311 * fragment_unnamed_300, fragment_unnamed_313 = fragment_unnamed_311 * fragment_unnamed_301, fragment_unnamed_314 = fragment_unnamed_311 * fragment_unnamed_285, fragment_unnamed_315 = (-0.0f) - fragment_unnamed_97, fragment_unnamed_316 = (-0.0f) - fragment_unnamed_98, fragment_unnamed_317 = (-0.0f) - fragment_unnamed_99, fragment_unnamed_321 = dot(float3(fragment_unnamed_315, fragment_unnamed_316, fragment_unnamed_317), float3(fragment_unnamed_312, fragment_unnamed_313, fragment_unnamed_314)) >= 0.0f, fragment_unnamed_322 = (-0.0f) - fragment_unnamed_312, fragment_unnamed_323 = (-0.0f) - fragment_unnamed_313, fragment_unnamed_324 = (-0.0f) - fragment_unnamed_314, fragment_unnamed_328 = fragment_unnamed_198 + (fragment_unnamed_321 ? fragment_unnamed_322 : fragment_unnamed_312), fragment_unnamed_329 = fragment_unnamed_199 + (fragment_unnamed_321 ? fragment_unnamed_323 : fragment_unnamed_313), fragment_unnamed_330 = fragment_unnamed_162 + (fragment_unnamed_321 ? fragment_unnamed_324 : fragment_unnamed_314), fragment_unnamed_335 = fragment_unnamed_329 * fragment_uniform_buffer_0[1u].x, fragment_unnamed_336 = fragment_unnamed_329 * fragment_uniform_buffer_0[1u].y, fragment_unnamed_349 = (-0.0f) - fragment_unnamed_330, fragment_unnamed_350 = fragment_unnamed_349 + 1.0f, fragment_unnamed_354 = mad(fragment_uniform_buffer_0[20u].w, fragment_unnamed_350, fragment_unnamed_330), fragment_unnamed_355 = mad(fragment_uniform_buffer_0[2u].x, fragment_unnamed_330, mad(fragment_uniform_buffer_0[0u].x, fragment_unnamed_328, fragment_unnamed_335)) / fragment_unnamed_354, fragment_unnamed_356 = mad(fragment_uniform_buffer_0[2u].y, fragment_unnamed_330, mad(fragment_uniform_buffer_0[0u].y, fragment_unnamed_328, fragment_unnamed_336)) / fragment_unnamed_354, fragment_unnamed_357 = fragment_unnamed_355 + 1.0f, fragment_unnamed_358 = fragment_unnamed_356 + 1.0f, fragment_unnamed_359 = fragment_unnamed_357 * 0.5f, fragment_unnamed_360 = fragment_unnamed_358 * 0.5f, fragment_unnamed_366 = clamp(fragment_unnamed_359, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, fragment_unnamed_367 = clamp(fragment_unnamed_360, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, fragment_unnamed_375 = _CameraDepthTexture.SampleLevel(sampler_CameraDepthTexture, float2(fragment_unnamed_366, fragment_unnamed_367), 0.0f).x * fragment_uniform_buffer_0[21u].x, fragment_unnamed_379 = (-0.0f) - fragment_uniform_buffer_0[20u].w, fragment_unnamed_385 = mad(fragment_unnamed_379, fragment_unnamed_375, 1.0f) / mad(fragment_unnamed_110, fragment_unnamed_375, fragment_uniform_buffer_0[21u].y), fragment_unnamed_404 = asfloat(((9.9999997473787516355514526367188e-06f >= fragment_unnamed_385) ? 4294967295u : 0u) & 1065353216u) + float(int(((((2.0f < fragment_unnamed_358) ? 4294967295u : 0u) | ((2.0f < fragment_unnamed_357) ? 4294967295u : 0u)) & 1u) + ((((fragment_unnamed_358 < 0.0f) ? 4294967295u : 0u) | ((fragment_unnamed_357 < 0.0f) ? 4294967295u : 0u)) & 1u))), fragment_unnamed_405 = fragment_unnamed_404 * 100000000.0f, fragment_unnamed_409 = mad(fragment_unnamed_385, fragment_uniform_buffer_0[17u].z, fragment_unnamed_405), fragment_unnamed_413 = (-0.0f) - fragment_uniform_buffer_0[2u].x, fragment_unnamed_415 = (-0.0f) - fragment_uniform_buffer_0[2u].y, fragment_unnamed_416 = fragment_unnamed_357 + fragment_unnamed_413, fragment_unnamed_417 = fragment_unnamed_358 + fragment_unnamed_415, fragment_unnamed_418 = fragment_unnamed_416 + (-1.0f), fragment_unnamed_419 = fragment_unnamed_417 + (-1.0f), fragment_unnamed_420 = fragment_unnamed_418 / fragment_unnamed_184, fragment_unnamed_421 = fragment_unnamed_419 / fragment_unnamed_189, fragment_unnamed_422 = (-0.0f) - fragment_unnamed_409, fragment_unnamed_423 = fragment_unnamed_422 + 1.0f, fragment_unnamed_427 = mad(fragment_uniform_buffer_0[20u].w, fragment_unnamed_423, fragment_unnamed_409), fragment_unnamed_428 = fragment_unnamed_427 * fragment_unnamed_420, fragment_unnamed_429 = fragment_unnamed_427 * fragment_unnamed_421, fragment_unnamed_430 = (-0.0f) - fragment_unnamed_198, fragment_unnamed_431 = (-0.0f) - fragment_unnamed_199, fragment_unnamed_432 = (-0.0f) - fragment_unnamed_162, fragment_unnamed_433 = fragment_unnamed_430 + fragment_unnamed_428, fragment_unnamed_434 = fragment_unnamed_431 + fragment_unnamed_429, fragment_unnamed_435 = fragment_unnamed_432 + fragment_unnamed_409, fragment_unnamed_439 = (-0.0f) - fragment_unnamed_162, fragment_unnamed_446 = dot(float3(fragment_unnamed_433, fragment_unnamed_434, fragment_unnamed_435), float3(fragment_unnamed_433, fragment_unnamed_434, fragment_unnamed_435)) + 9.9999997473787516355514526367188e-05f, fragment_unnamed_448 = max(mad(fragment_unnamed_439, 0.00200000009499490261077880859375f, dot(float3(fragment_unnamed_433, fragment_unnamed_434, fragment_unnamed_435), float3(fragment_unnamed_97, fragment_unnamed_98, fragment_unnamed_99))), 0.0f) / fragment_unnamed_446, fragment_unnamed_236 = fragment_unnamed_235 + fragment_unnamed_448, fragment_unnamed_235 = fragment_unnamed_236, fragment_unnamed_237++)
				{
				}
				precise float fragment_unnamed_243 = fragment_unnamed_235 * fragment_uniform_buffer_0[31u].y;
				precise float fragment_unnamed_247 = fragment_unnamed_243 * fragment_uniform_buffer_0[31u].x;
				precise float fragment_unnamed_251 = fragment_unnamed_247 / fragment_uniform_buffer_0[31u].w;
				precise float fragment_unnamed_256 = log2(max(abs(fragment_unnamed_251), 1.1920928955078125e-07f)) * 0.60000002384185791015625f;
				fragment_output_0.x = exp2(fragment_unnamed_256);
				fragment_output_0.y = mad(fragment_unnamed_97, 0.5f, 0.5f);
				fragment_output_0.z = mad(fragment_unnamed_98, 0.5f, 0.5f);
				fragment_output_0.w = mad(fragment_unnamed_99, 0.5f, 0.5f);
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[0] = float4(unity_CameraProjection[0][0], unity_CameraProjection[1][0], unity_CameraProjection[2][0], unity_CameraProjection[3][0]);
				fragment_uniform_buffer_0[1] = float4(unity_CameraProjection[0][1], unity_CameraProjection[1][1], unity_CameraProjection[2][1], unity_CameraProjection[3][1]);
				fragment_uniform_buffer_0[2] = float4(unity_CameraProjection[0][2], unity_CameraProjection[1][2], unity_CameraProjection[2][2], unity_CameraProjection[3][2]);
				fragment_uniform_buffer_0[3] = float4(unity_CameraProjection[0][3], unity_CameraProjection[1][3], unity_CameraProjection[2][3], unity_CameraProjection[3][3]);

				fragment_uniform_buffer_0[12] = float4(unity_WorldToCamera[0][0], unity_WorldToCamera[1][0], unity_WorldToCamera[2][0], unity_WorldToCamera[3][0]);
				fragment_uniform_buffer_0[13] = float4(unity_WorldToCamera[0][1], unity_WorldToCamera[1][1], unity_WorldToCamera[2][1], unity_WorldToCamera[3][1]);
				fragment_uniform_buffer_0[14] = float4(unity_WorldToCamera[0][2], unity_WorldToCamera[1][2], unity_WorldToCamera[2][2], unity_WorldToCamera[3][2]);
				fragment_uniform_buffer_0[15] = float4(unity_WorldToCamera[0][3], unity_WorldToCamera[1][3], unity_WorldToCamera[2][3], unity_WorldToCamera[3][3]);

				fragment_uniform_buffer_0[17] = float4(_ProjectionParams[0], _ProjectionParams[1], _ProjectionParams[2], _ProjectionParams[3]);

				fragment_uniform_buffer_0[20] = float4(unity_OrthoParams[0], unity_OrthoParams[1], unity_OrthoParams[2], unity_OrthoParams[3]);

				fragment_uniform_buffer_0[21] = float4(_ZBufferParams[0], _ZBufferParams[1], _ZBufferParams[2], _ZBufferParams[3]);

				fragment_uniform_buffer_0[22] = float4(_ScreenParams[0], _ScreenParams[1], _ScreenParams[2], _ScreenParams[3]);

				fragment_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, fragment_uniform_buffer_0[26][1], fragment_uniform_buffer_0[26][2], fragment_uniform_buffer_0[26][3]);

				fragment_uniform_buffer_0[31] = float4(_AOParams[0], _AOParams[1], _AOParams[2], _AOParams[3]);

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

			float4x4 unity_CameraProjection;
			float4x4 unity_WorldToCamera;
			float4 _ProjectionParams;
			float4 unity_OrthoParams;
			float4 _ZBufferParams;
			float4 _ScreenParams;
			float _RenderViewportScaleFactor;
			float3 _FogParams;
			float4 _AOParams;

			static float4 fragment_uniform_buffer_0[32];
			Texture2D<float4> _CameraGBufferTexture2;
			Texture2D<float4> _CameraDepthTexture;
			SamplerState sampler_CameraGBufferTexture2;
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
				precise float fragment_unnamed_50 = clamp(fragment_input_1.x, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_51 = clamp(fragment_input_1.y, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_54 = _CameraGBufferTexture2.Sample(sampler_CameraGBufferTexture2, float2(fragment_unnamed_50, fragment_unnamed_51));
				float fragment_unnamed_56 = fragment_unnamed_54.x;
				float fragment_unnamed_68 = asfloat((dot(float3(fragment_unnamed_56, fragment_unnamed_54.yz), float3(fragment_unnamed_56, fragment_unnamed_54.yz)) != 0.0f) ? 3212836864u : 2147483648u);
				float fragment_unnamed_69 = mad(fragment_unnamed_56, 2.0f, fragment_unnamed_68);
				float fragment_unnamed_71 = mad(fragment_unnamed_54.y, 2.0f, fragment_unnamed_68);
				float fragment_unnamed_72 = mad(fragment_unnamed_54.z, 2.0f, fragment_unnamed_68);
				precise float fragment_unnamed_79 = fragment_unnamed_71 * fragment_uniform_buffer_0[13u].x;
				precise float fragment_unnamed_80 = fragment_unnamed_71 * fragment_uniform_buffer_0[13u].y;
				precise float fragment_unnamed_81 = fragment_unnamed_71 * fragment_uniform_buffer_0[13u].z;
				float fragment_unnamed_97 = mad(fragment_uniform_buffer_0[14u].x, fragment_unnamed_72, mad(fragment_uniform_buffer_0[12u].x, fragment_unnamed_69, fragment_unnamed_79));
				float fragment_unnamed_98 = mad(fragment_uniform_buffer_0[14u].y, fragment_unnamed_72, mad(fragment_uniform_buffer_0[12u].y, fragment_unnamed_69, fragment_unnamed_80));
				float fragment_unnamed_99 = mad(fragment_uniform_buffer_0[14u].z, fragment_unnamed_72, mad(fragment_uniform_buffer_0[12u].z, fragment_unnamed_69, fragment_unnamed_81));
				precise float fragment_unnamed_108 = (-0.0f) - fragment_uniform_buffer_0[20u].w;
				precise float fragment_unnamed_110 = fragment_unnamed_108 + 1.0f;
				precise float fragment_unnamed_115 = _CameraDepthTexture.SampleLevel(sampler_CameraDepthTexture, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f).x * fragment_uniform_buffer_0[21u].x;
				precise float fragment_unnamed_119 = (-0.0f) - fragment_uniform_buffer_0[20u].w;
				precise float fragment_unnamed_125 = mad(fragment_unnamed_119, fragment_unnamed_115, 1.0f) / mad(fragment_unnamed_110, fragment_unnamed_115, fragment_uniform_buffer_0[21u].y);
				precise float fragment_unnamed_155 = asfloat(((9.9999997473787516355514526367188e-06f >= fragment_unnamed_125) ? 4294967295u : 0u) & 1065353216u) + float(int(((((1.0f < fragment_input_1.y) ? 4294967295u : 0u) | ((1.0f < fragment_input_1.x) ? 4294967295u : 0u)) & 1u) + ((((fragment_input_1.y < 0.0f) ? 4294967295u : 0u) | ((fragment_input_1.x < 0.0f) ? 4294967295u : 0u)) & 1u)));
				precise float fragment_unnamed_156 = fragment_unnamed_155 * 100000000.0f;
				float fragment_unnamed_162 = mad(fragment_unnamed_125, fragment_uniform_buffer_0[17u].z, fragment_unnamed_156);
				precise float fragment_unnamed_174 = (-0.0f) - fragment_uniform_buffer_0[2u].x;
				precise float fragment_unnamed_176 = (-0.0f) - fragment_uniform_buffer_0[2u].y;
				precise float fragment_unnamed_177 = mad(fragment_input_1.x, 2.0f, -1.0f) + fragment_unnamed_174;
				precise float fragment_unnamed_178 = mad(fragment_input_1.y, 2.0f, -1.0f) + fragment_unnamed_176;
				float fragment_unnamed_184 = asfloat(asuint(fragment_uniform_buffer_0[0u]).x);
				float fragment_unnamed_189 = asfloat(asuint(fragment_uniform_buffer_0[1u]).y);
				precise float fragment_unnamed_190 = fragment_unnamed_177 / fragment_unnamed_184;
				precise float fragment_unnamed_191 = fragment_unnamed_178 / fragment_unnamed_189;
				precise float fragment_unnamed_192 = (-0.0f) - fragment_unnamed_162;
				precise float fragment_unnamed_193 = fragment_unnamed_192 + 1.0f;
				float fragment_unnamed_197 = mad(fragment_uniform_buffer_0[20u].w, fragment_unnamed_193, fragment_unnamed_162);
				precise float fragment_unnamed_198 = fragment_unnamed_197 * fragment_unnamed_190;
				precise float fragment_unnamed_199 = fragment_unnamed_197 * fragment_unnamed_191;
				uint fragment_unnamed_204 = uint(int(fragment_uniform_buffer_0[31u].w));
				precise float fragment_unnamed_212 = fragment_input_1.x * fragment_uniform_buffer_0[31u].z;
				precise float fragment_unnamed_213 = fragment_input_1.y * fragment_uniform_buffer_0[31u].z;
				precise float fragment_unnamed_219 = fragment_unnamed_212 * fragment_uniform_buffer_0[22u].x;
				precise float fragment_unnamed_220 = fragment_unnamed_213 * fragment_uniform_buffer_0[22u].y;
				precise float fragment_unnamed_229 = frac(dot(float2(0.067110560834407806396484375f, 0.005837149918079376220703125f), float2(floor(fragment_unnamed_219), floor(fragment_unnamed_220)))) * 52.98291778564453125f;
				float fragment_unnamed_231 = frac(fragment_unnamed_229);
				float fragment_unnamed_232 = asfloat(1095751225u);
				float fragment_unnamed_235;
				fragment_unnamed_235 = asfloat(0u);
				precise float fragment_unnamed_236;
				precise float fragment_unnamed_309;
				float fragment_unnamed_311;
				float fragment_unnamed_314;
				precise float fragment_unnamed_316;
				precise float fragment_unnamed_319;
				precise float fragment_unnamed_322;
				float fragment_unnamed_324;
				precise float fragment_unnamed_329;
				precise float fragment_unnamed_331;
				precise float fragment_unnamed_332;
				precise float fragment_unnamed_336;
				float fragment_unnamed_338;
				precise float fragment_unnamed_339;
				precise float fragment_unnamed_340;
				precise float fragment_unnamed_341;
				precise float fragment_unnamed_345;
				precise float fragment_unnamed_350;
				precise float fragment_unnamed_351;
				precise float fragment_unnamed_352;
				precise float fragment_unnamed_353;
				precise float fragment_unnamed_354;
				precise float fragment_unnamed_355;
				precise float fragment_unnamed_356;
				bool fragment_unnamed_360;
				precise float fragment_unnamed_361;
				precise float fragment_unnamed_362;
				precise float fragment_unnamed_363;
				precise float fragment_unnamed_367;
				precise float fragment_unnamed_368;
				precise float fragment_unnamed_369;
				precise float fragment_unnamed_374;
				precise float fragment_unnamed_375;
				precise float fragment_unnamed_388;
				precise float fragment_unnamed_389;
				float fragment_unnamed_393;
				precise float fragment_unnamed_394;
				precise float fragment_unnamed_395;
				precise float fragment_unnamed_396;
				precise float fragment_unnamed_397;
				precise float fragment_unnamed_398;
				precise float fragment_unnamed_399;
				precise float fragment_unnamed_405;
				precise float fragment_unnamed_406;
				precise float fragment_unnamed_414;
				precise float fragment_unnamed_418;
				precise float fragment_unnamed_424;
				precise float fragment_unnamed_443;
				precise float fragment_unnamed_444;
				float fragment_unnamed_448;
				precise float fragment_unnamed_452;
				precise float fragment_unnamed_454;
				precise float fragment_unnamed_455;
				precise float fragment_unnamed_456;
				precise float fragment_unnamed_457;
				precise float fragment_unnamed_458;
				precise float fragment_unnamed_459;
				precise float fragment_unnamed_460;
				precise float fragment_unnamed_461;
				precise float fragment_unnamed_462;
				float fragment_unnamed_466;
				precise float fragment_unnamed_467;
				precise float fragment_unnamed_468;
				precise float fragment_unnamed_469;
				precise float fragment_unnamed_470;
				precise float fragment_unnamed_471;
				precise float fragment_unnamed_472;
				precise float fragment_unnamed_473;
				precise float fragment_unnamed_474;
				precise float fragment_unnamed_478;
				precise float fragment_unnamed_485;
				precise float fragment_unnamed_487;
				for (uint fragment_unnamed_237 = 0u; !(int(fragment_unnamed_237) >= int(fragment_unnamed_204)); fragment_unnamed_309 = float(int(fragment_unnamed_237)) * 1.00010001659393310546875f, fragment_unnamed_311 = floor(fragment_unnamed_309), fragment_unnamed_314 = mad(fragment_input_1.x, 1.0000000133514319600180897396058e-10f, fragment_unnamed_311), fragment_unnamed_316 = fragment_unnamed_314 * 78.233001708984375f, fragment_unnamed_319 = sin(fragment_unnamed_316) * 43758.546875f, fragment_unnamed_322 = fragment_unnamed_231 + frac(fragment_unnamed_319), fragment_unnamed_324 = mad(frac(fragment_unnamed_322), 2.0f, -1.0f), fragment_unnamed_329 = sin(dot(float2(fragment_unnamed_232, fragment_unnamed_314), float2(1.0f, 78.233001708984375f))) * 43758.546875f, fragment_unnamed_331 = fragment_unnamed_231 + frac(fragment_unnamed_329), fragment_unnamed_332 = fragment_unnamed_331 * 6.283185482025146484375f, fragment_unnamed_336 = (-0.0f) - fragment_unnamed_324, fragment_unnamed_338 = sqrt(mad(fragment_unnamed_336, fragment_unnamed_324, 1.0f)), fragment_unnamed_339 = fragment_unnamed_338 * cos(fragment_unnamed_332), fragment_unnamed_340 = fragment_unnamed_338 * sin(fragment_unnamed_332), fragment_unnamed_341 = fragment_unnamed_311 + 1.0f, fragment_unnamed_345 = fragment_unnamed_341 / fragment_uniform_buffer_0[31u].w, fragment_unnamed_350 = sqrt(fragment_unnamed_345) * fragment_uniform_buffer_0[31u].y, fragment_unnamed_351 = fragment_unnamed_350 * fragment_unnamed_339, fragment_unnamed_352 = fragment_unnamed_350 * fragment_unnamed_340, fragment_unnamed_353 = fragment_unnamed_350 * fragment_unnamed_324, fragment_unnamed_354 = (-0.0f) - fragment_unnamed_97, fragment_unnamed_355 = (-0.0f) - fragment_unnamed_98, fragment_unnamed_356 = (-0.0f) - fragment_unnamed_99, fragment_unnamed_360 = dot(float3(fragment_unnamed_354, fragment_unnamed_355, fragment_unnamed_356), float3(fragment_unnamed_351, fragment_unnamed_352, fragment_unnamed_353)) >= 0.0f, fragment_unnamed_361 = (-0.0f) - fragment_unnamed_351, fragment_unnamed_362 = (-0.0f) - fragment_unnamed_352, fragment_unnamed_363 = (-0.0f) - fragment_unnamed_353, fragment_unnamed_367 = fragment_unnamed_198 + (fragment_unnamed_360 ? fragment_unnamed_361 : fragment_unnamed_351), fragment_unnamed_368 = fragment_unnamed_199 + (fragment_unnamed_360 ? fragment_unnamed_362 : fragment_unnamed_352), fragment_unnamed_369 = fragment_unnamed_162 + (fragment_unnamed_360 ? fragment_unnamed_363 : fragment_unnamed_353), fragment_unnamed_374 = fragment_unnamed_368 * fragment_uniform_buffer_0[1u].x, fragment_unnamed_375 = fragment_unnamed_368 * fragment_uniform_buffer_0[1u].y, fragment_unnamed_388 = (-0.0f) - fragment_unnamed_369, fragment_unnamed_389 = fragment_unnamed_388 + 1.0f, fragment_unnamed_393 = mad(fragment_uniform_buffer_0[20u].w, fragment_unnamed_389, fragment_unnamed_369), fragment_unnamed_394 = mad(fragment_uniform_buffer_0[2u].x, fragment_unnamed_369, mad(fragment_uniform_buffer_0[0u].x, fragment_unnamed_367, fragment_unnamed_374)) / fragment_unnamed_393, fragment_unnamed_395 = mad(fragment_uniform_buffer_0[2u].y, fragment_unnamed_369, mad(fragment_uniform_buffer_0[0u].y, fragment_unnamed_367, fragment_unnamed_375)) / fragment_unnamed_393, fragment_unnamed_396 = fragment_unnamed_394 + 1.0f, fragment_unnamed_397 = fragment_unnamed_395 + 1.0f, fragment_unnamed_398 = fragment_unnamed_396 * 0.5f, fragment_unnamed_399 = fragment_unnamed_397 * 0.5f, fragment_unnamed_405 = clamp(fragment_unnamed_398, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, fragment_unnamed_406 = clamp(fragment_unnamed_399, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, fragment_unnamed_414 = _CameraDepthTexture.SampleLevel(sampler_CameraDepthTexture, float2(fragment_unnamed_405, fragment_unnamed_406), 0.0f).x * fragment_uniform_buffer_0[21u].x, fragment_unnamed_418 = (-0.0f) - fragment_uniform_buffer_0[20u].w, fragment_unnamed_424 = mad(fragment_unnamed_418, fragment_unnamed_414, 1.0f) / mad(fragment_unnamed_110, fragment_unnamed_414, fragment_uniform_buffer_0[21u].y), fragment_unnamed_443 = asfloat(((9.9999997473787516355514526367188e-06f >= fragment_unnamed_424) ? 4294967295u : 0u) & 1065353216u) + float(int(((((2.0f < fragment_unnamed_397) ? 4294967295u : 0u) | ((2.0f < fragment_unnamed_396) ? 4294967295u : 0u)) & 1u) + ((((fragment_unnamed_397 < 0.0f) ? 4294967295u : 0u) | ((fragment_unnamed_396 < 0.0f) ? 4294967295u : 0u)) & 1u))), fragment_unnamed_444 = fragment_unnamed_443 * 100000000.0f, fragment_unnamed_448 = mad(fragment_unnamed_424, fragment_uniform_buffer_0[17u].z, fragment_unnamed_444), fragment_unnamed_452 = (-0.0f) - fragment_uniform_buffer_0[2u].x, fragment_unnamed_454 = (-0.0f) - fragment_uniform_buffer_0[2u].y, fragment_unnamed_455 = fragment_unnamed_396 + fragment_unnamed_452, fragment_unnamed_456 = fragment_unnamed_397 + fragment_unnamed_454, fragment_unnamed_457 = fragment_unnamed_455 + (-1.0f), fragment_unnamed_458 = fragment_unnamed_456 + (-1.0f), fragment_unnamed_459 = fragment_unnamed_457 / fragment_unnamed_184, fragment_unnamed_460 = fragment_unnamed_458 / fragment_unnamed_189, fragment_unnamed_461 = (-0.0f) - fragment_unnamed_448, fragment_unnamed_462 = fragment_unnamed_461 + 1.0f, fragment_unnamed_466 = mad(fragment_uniform_buffer_0[20u].w, fragment_unnamed_462, fragment_unnamed_448), fragment_unnamed_467 = fragment_unnamed_466 * fragment_unnamed_459, fragment_unnamed_468 = fragment_unnamed_466 * fragment_unnamed_460, fragment_unnamed_469 = (-0.0f) - fragment_unnamed_198, fragment_unnamed_470 = (-0.0f) - fragment_unnamed_199, fragment_unnamed_471 = (-0.0f) - fragment_unnamed_162, fragment_unnamed_472 = fragment_unnamed_469 + fragment_unnamed_467, fragment_unnamed_473 = fragment_unnamed_470 + fragment_unnamed_468, fragment_unnamed_474 = fragment_unnamed_471 + fragment_unnamed_448, fragment_unnamed_478 = (-0.0f) - fragment_unnamed_162, fragment_unnamed_485 = dot(float3(fragment_unnamed_472, fragment_unnamed_473, fragment_unnamed_474), float3(fragment_unnamed_472, fragment_unnamed_473, fragment_unnamed_474)) + 9.9999997473787516355514526367188e-05f, fragment_unnamed_487 = max(mad(fragment_unnamed_478, 0.00200000009499490261077880859375f, dot(float3(fragment_unnamed_472, fragment_unnamed_473, fragment_unnamed_474), float3(fragment_unnamed_97, fragment_unnamed_98, fragment_unnamed_99))), 0.0f) / fragment_unnamed_485, fragment_unnamed_236 = fragment_unnamed_235 + fragment_unnamed_487, fragment_unnamed_235 = fragment_unnamed_236, fragment_unnamed_237++)
				{
				}
				precise float fragment_unnamed_243 = fragment_unnamed_235 * fragment_uniform_buffer_0[31u].y;
				precise float fragment_unnamed_247 = fragment_unnamed_243 * fragment_uniform_buffer_0[31u].x;
				precise float fragment_unnamed_251 = fragment_unnamed_247 / fragment_uniform_buffer_0[31u].w;
				precise float fragment_unnamed_256 = log2(max(abs(fragment_unnamed_251), 1.1920928955078125e-07f)) * 0.60000002384185791015625f;
				precise float fragment_unnamed_270 = _CameraDepthTexture.Sample(sampler_CameraDepthTexture, float2(fragment_input_1.x, fragment_input_1.y)).x * fragment_uniform_buffer_0[21u].x;
				precise float fragment_unnamed_274 = (-0.0f) - fragment_uniform_buffer_0[20u].w;
				precise float fragment_unnamed_280 = mad(fragment_unnamed_274, fragment_unnamed_270, 1.0f) / mad(fragment_unnamed_110, fragment_unnamed_270, fragment_uniform_buffer_0[21u].y);
				precise float fragment_unnamed_287 = (-0.0f) - fragment_uniform_buffer_0[17u].y;
				precise float fragment_unnamed_293 = mad(fragment_unnamed_280, fragment_uniform_buffer_0[17u].z, fragment_unnamed_287) * fragment_uniform_buffer_0[29u].x;
				precise float fragment_unnamed_294 = (-0.0f) - fragment_unnamed_293;
				precise float fragment_unnamed_295 = fragment_unnamed_293 * fragment_unnamed_294;
				precise float fragment_unnamed_297 = exp2(fragment_unnamed_295) * exp2(fragment_unnamed_256);
				fragment_output_0.x = fragment_unnamed_297;
				fragment_output_0.y = mad(fragment_unnamed_97, 0.5f, 0.5f);
				fragment_output_0.z = mad(fragment_unnamed_98, 0.5f, 0.5f);
				fragment_output_0.w = mad(fragment_unnamed_99, 0.5f, 0.5f);
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[0] = float4(unity_CameraProjection[0][0], unity_CameraProjection[1][0], unity_CameraProjection[2][0], unity_CameraProjection[3][0]);
				fragment_uniform_buffer_0[1] = float4(unity_CameraProjection[0][1], unity_CameraProjection[1][1], unity_CameraProjection[2][1], unity_CameraProjection[3][1]);
				fragment_uniform_buffer_0[2] = float4(unity_CameraProjection[0][2], unity_CameraProjection[1][2], unity_CameraProjection[2][2], unity_CameraProjection[3][2]);
				fragment_uniform_buffer_0[3] = float4(unity_CameraProjection[0][3], unity_CameraProjection[1][3], unity_CameraProjection[2][3], unity_CameraProjection[3][3]);

				fragment_uniform_buffer_0[12] = float4(unity_WorldToCamera[0][0], unity_WorldToCamera[1][0], unity_WorldToCamera[2][0], unity_WorldToCamera[3][0]);
				fragment_uniform_buffer_0[13] = float4(unity_WorldToCamera[0][1], unity_WorldToCamera[1][1], unity_WorldToCamera[2][1], unity_WorldToCamera[3][1]);
				fragment_uniform_buffer_0[14] = float4(unity_WorldToCamera[0][2], unity_WorldToCamera[1][2], unity_WorldToCamera[2][2], unity_WorldToCamera[3][2]);
				fragment_uniform_buffer_0[15] = float4(unity_WorldToCamera[0][3], unity_WorldToCamera[1][3], unity_WorldToCamera[2][3], unity_WorldToCamera[3][3]);

				fragment_uniform_buffer_0[17] = float4(_ProjectionParams[0], _ProjectionParams[1], _ProjectionParams[2], _ProjectionParams[3]);

				fragment_uniform_buffer_0[20] = float4(unity_OrthoParams[0], unity_OrthoParams[1], unity_OrthoParams[2], unity_OrthoParams[3]);

				fragment_uniform_buffer_0[21] = float4(_ZBufferParams[0], _ZBufferParams[1], _ZBufferParams[2], _ZBufferParams[3]);

				fragment_uniform_buffer_0[22] = float4(_ScreenParams[0], _ScreenParams[1], _ScreenParams[2], _ScreenParams[3]);

				fragment_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, fragment_uniform_buffer_0[26][1], fragment_uniform_buffer_0[26][2], fragment_uniform_buffer_0[26][3]);

				fragment_uniform_buffer_0[29] = float4(_FogParams[0], _FogParams[1], _FogParams[2], fragment_uniform_buffer_0[29][3]);

				fragment_uniform_buffer_0[31] = float4(_AOParams[0], _AOParams[1], _AOParams[2], _AOParams[3]);

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
			GpuProgramID 186726

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
			Texture2D<float4> _CameraDepthNormalsTexture;
			SamplerState sampler_CameraDepthNormalsTexture;

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
			static float4 fragment_unnamed_25;
			static float4 fragment_unnamed_67;
			static float3 fragment_unnamed_89;
			static float3 fragment_unnamed_98;
			static float fragment_unnamed_115;
			static float3 fragment_unnamed_121;
			static float fragment_unnamed_165;
			static float4 fragment_unnamed_207;
			static float fragment_unnamed_233;
			static float3 fragment_unnamed_259;
			static float fragment_unnamed_280;
			static float3 fragment_unnamed_315;
			static float fragment_unnamed_336;

			void frag_main()
			{
				fragment_unnamed_9.x = _MainTex_TexelSize.x;
				fragment_unnamed_9.y = 0.0f;
				fragment_unnamed_25 = ((-fragment_unnamed_9.xyxy) * float4(2.76923084259033203125f, 1.384615421295166015625f, 6.4615383148193359375f, 3.23076915740966796875f)) + fragment_input_0.xyxy;
				fragment_unnamed_25 = clamp(fragment_unnamed_25, 0.0f.xxxx, 1.0f.xxxx);
				fragment_unnamed_9 = (fragment_unnamed_9.xyxy * float4(2.76923084259033203125f, 1.384615421295166015625f, 6.4615383148193359375f, 3.23076915740966796875f)) + fragment_input_0.xyxy;
				fragment_unnamed_9 = clamp(fragment_unnamed_9, 0.0f.xxxx, 1.0f.xxxx);
				fragment_unnamed_9 *= _RenderViewportScaleFactor.xxxx;
				fragment_unnamed_25 *= _RenderViewportScaleFactor.xxxx;
				fragment_unnamed_67 = _MainTex.Sample(sampler_MainTex, fragment_unnamed_25.xy);
				fragment_unnamed_25 = _MainTex.Sample(sampler_MainTex, fragment_unnamed_25.zw);
				fragment_unnamed_89 = (fragment_unnamed_67.yzw * 2.0f.xxx) + (-1.0f).xxx;
				fragment_unnamed_98 = _CameraDepthNormalsTexture.Sample(sampler_CameraDepthNormalsTexture, fragment_input_1).xyz;
				fragment_unnamed_98 = (fragment_unnamed_98 * float3(3.55539989471435546875f, 3.55539989471435546875f, 0.0f)) + float3(-1.777699947357177734375f, -1.777699947357177734375f, 1.0f);
				fragment_unnamed_115 = dot(fragment_unnamed_98, fragment_unnamed_98);
				fragment_unnamed_115 = 2.0f / fragment_unnamed_115;
				float2 fragment_unnamed_126 = fragment_unnamed_98.xy * fragment_unnamed_115.xx;
				fragment_unnamed_121 = float3(fragment_unnamed_126.x, fragment_unnamed_126.y, fragment_unnamed_121.z);
				fragment_unnamed_121.z = fragment_unnamed_115 + (-1.0f);
				fragment_unnamed_98 = fragment_unnamed_121 * float3(1.0f, 1.0f, -1.0f);
				float3 fragment_unnamed_144 = (fragment_unnamed_121 * float3(0.5f, 0.5f, -0.5f)) + 0.5f.xxx;
				fragment_output_0 = float4(fragment_output_0.x, fragment_unnamed_144.x, fragment_unnamed_144.y, fragment_unnamed_144.z);
				fragment_unnamed_89.x = dot(fragment_unnamed_98, fragment_unnamed_89);
				fragment_unnamed_89.x += (-0.800000011920928955078125f);
				fragment_unnamed_89.x *= 5.000000476837158203125f;
				fragment_unnamed_89.x = clamp(fragment_unnamed_89.x, 0.0f, 1.0f);
				fragment_unnamed_165 = (fragment_unnamed_89.x * (-2.0f)) + 3.0f;
				fragment_unnamed_89.x *= fragment_unnamed_89.x;
				fragment_unnamed_89.x *= fragment_unnamed_165;
				fragment_unnamed_89.x *= 0.3162162303924560546875f;
				fragment_unnamed_67.x = fragment_unnamed_89.x * fragment_unnamed_67.x;
				fragment_unnamed_165 = _MainTex.Sample(sampler_MainTex, fragment_input_1).x;
				fragment_unnamed_67.x = (fragment_unnamed_165 * 0.2270270287990570068359375f) + fragment_unnamed_67.x;
				fragment_unnamed_207 = _MainTex.Sample(sampler_MainTex, fragment_unnamed_9.xy);
				fragment_unnamed_9 = _MainTex.Sample(sampler_MainTex, fragment_unnamed_9.zw);
				fragment_unnamed_121 = (fragment_unnamed_207.yzw * 2.0f.xxx) + (-1.0f).xxx;
				fragment_unnamed_165 = dot(fragment_unnamed_98, fragment_unnamed_121);
				fragment_unnamed_165 += (-0.800000011920928955078125f);
				fragment_unnamed_165 *= 5.000000476837158203125f;
				fragment_unnamed_165 = clamp(fragment_unnamed_165, 0.0f, 1.0f);
				fragment_unnamed_233 = (fragment_unnamed_165 * (-2.0f)) + 3.0f;
				fragment_unnamed_165 *= fragment_unnamed_165;
				fragment_unnamed_165 *= fragment_unnamed_233;
				fragment_unnamed_233 = fragment_unnamed_165 * 0.3162162303924560546875f;
				fragment_unnamed_89.x = (fragment_unnamed_165 * 0.3162162303924560546875f) + fragment_unnamed_89.x;
				fragment_unnamed_67.x = (fragment_unnamed_207.x * fragment_unnamed_233) + fragment_unnamed_67.x;
				fragment_unnamed_259 = (fragment_unnamed_25.yzw * 2.0f.xxx) + (-1.0f).xxx;
				fragment_unnamed_259.x = dot(fragment_unnamed_98, fragment_unnamed_259);
				fragment_unnamed_259.x += (-0.800000011920928955078125f);
				fragment_unnamed_259.x *= 5.000000476837158203125f;
				fragment_unnamed_259.x = clamp(fragment_unnamed_259.x, 0.0f, 1.0f);
				fragment_unnamed_280 = (fragment_unnamed_259.x * (-2.0f)) + 3.0f;
				fragment_unnamed_259.x *= fragment_unnamed_259.x;
				fragment_unnamed_259.x *= fragment_unnamed_280;
				fragment_unnamed_280 = fragment_unnamed_259.x * 0.0702702701091766357421875f;
				fragment_unnamed_259.x = (fragment_unnamed_259.x * 0.0702702701091766357421875f) + fragment_unnamed_89.x;
				fragment_unnamed_25.x = (fragment_unnamed_25.x * fragment_unnamed_280) + fragment_unnamed_67.x;
				fragment_unnamed_315 = (fragment_unnamed_9.yzw * 2.0f.xxx) + (-1.0f).xxx;
				fragment_unnamed_315.x = dot(fragment_unnamed_98, fragment_unnamed_315);
				fragment_unnamed_315.x += (-0.800000011920928955078125f);
				fragment_unnamed_315.x *= 5.000000476837158203125f;
				fragment_unnamed_315.x = clamp(fragment_unnamed_315.x, 0.0f, 1.0f);
				fragment_unnamed_336 = (fragment_unnamed_315.x * (-2.0f)) + 3.0f;
				fragment_unnamed_315.x *= fragment_unnamed_315.x;
				fragment_unnamed_315.x *= fragment_unnamed_336;
				fragment_unnamed_336 = fragment_unnamed_315.x * 0.0702702701091766357421875f;
				fragment_unnamed_315.x = (fragment_unnamed_315.x * 0.0702702701091766357421875f) + fragment_unnamed_259.x;
				fragment_unnamed_315.x += 0.2270270287990570068359375f;
				fragment_unnamed_9.x = (fragment_unnamed_9.x * fragment_unnamed_336) + fragment_unnamed_25.x;
				fragment_output_0.x = fragment_unnamed_9.x / fragment_unnamed_315.x;
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


			float _RenderViewportScaleFactor;
			float4 _MainTex_TexelSize;

			static float4 fragment_uniform_buffer_0[31];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _CameraDepthNormalsTexture;
			SamplerState sampler_MainTex;
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
				float fragment_unnamed_41 = asfloat(asuint(fragment_uniform_buffer_0[30u]).x);
				float fragment_unnamed_42 = asfloat(0u);
				precise float fragment_unnamed_43 = (-0.0f) - fragment_unnamed_41;
				precise float fragment_unnamed_45 = (-0.0f) - fragment_unnamed_42;
				precise float fragment_unnamed_83 = clamp(mad(fragment_unnamed_41, 2.76923084259033203125f, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_84 = clamp(mad(fragment_unnamed_42, 1.384615421295166015625f, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_85 = clamp(mad(fragment_unnamed_41, 6.4615383148193359375f, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_86 = clamp(mad(fragment_unnamed_42, 3.23076915740966796875f, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_90 = clamp(mad(fragment_unnamed_43, 2.76923084259033203125f, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_91 = clamp(mad(fragment_unnamed_45, 1.384615421295166015625f, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_92 = clamp(mad(fragment_unnamed_43, 6.4615383148193359375f, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_93 = clamp(mad(fragment_unnamed_45, 3.23076915740966796875f, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_96 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_90, fragment_unnamed_91));
				float4 fragment_unnamed_102 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_92, fragment_unnamed_93));
				float4 fragment_unnamed_118 = _CameraDepthNormalsTexture.Sample(sampler_CameraDepthNormalsTexture, float2(fragment_input_1.x, fragment_input_1.y));
				float fragment_unnamed_123 = mad(fragment_unnamed_118.x, 3.55539989471435546875f, -1.777699947357177734375f);
				float fragment_unnamed_126 = mad(fragment_unnamed_118.y, 3.55539989471435546875f, -1.777699947357177734375f);
				float fragment_unnamed_127 = mad(fragment_unnamed_118.z, 0.0f, 1.0f);
				precise float fragment_unnamed_132 = 2.0f / dot(float3(fragment_unnamed_123, fragment_unnamed_126, fragment_unnamed_127), float3(fragment_unnamed_123, fragment_unnamed_126, fragment_unnamed_127));
				precise float fragment_unnamed_133 = fragment_unnamed_123 * fragment_unnamed_132;
				precise float fragment_unnamed_134 = fragment_unnamed_126 * fragment_unnamed_132;
				precise float fragment_unnamed_135 = fragment_unnamed_132 + (-1.0f);
				precise float fragment_unnamed_136 = fragment_unnamed_133 * 1.0f;
				precise float fragment_unnamed_137 = fragment_unnamed_134 * 1.0f;
				precise float fragment_unnamed_138 = fragment_unnamed_135 * (-1.0f);
				fragment_output_0.y = mad(fragment_unnamed_133, 0.5f, 0.5f);
				fragment_output_0.z = mad(fragment_unnamed_134, 0.5f, 0.5f);
				fragment_output_0.w = mad(fragment_unnamed_135, -0.5f, 0.5f);
				precise float fragment_unnamed_153 = dot(float3(fragment_unnamed_136, fragment_unnamed_137, fragment_unnamed_138), float3(mad(fragment_unnamed_96.y, 2.0f, -1.0f), mad(fragment_unnamed_96.z, 2.0f, -1.0f), mad(fragment_unnamed_96.w, 2.0f, -1.0f))) + (-0.800000011920928955078125f);
				precise float fragment_unnamed_155 = fragment_unnamed_153 * 5.000000476837158203125f;
				float fragment_unnamed_157 = clamp(fragment_unnamed_155, 0.0f, 1.0f);
				precise float fragment_unnamed_161 = fragment_unnamed_157 * fragment_unnamed_157;
				precise float fragment_unnamed_162 = fragment_unnamed_161 * mad(fragment_unnamed_157, -2.0f, 3.0f);
				precise float fragment_unnamed_163 = fragment_unnamed_162 * 0.3162162303924560546875f;
				precise float fragment_unnamed_165 = fragment_unnamed_163 * fragment_unnamed_96.x;
				float4 fragment_unnamed_175 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_83, fragment_unnamed_84));
				float4 fragment_unnamed_181 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_85, fragment_unnamed_86));
				precise float fragment_unnamed_193 = dot(float3(fragment_unnamed_136, fragment_unnamed_137, fragment_unnamed_138), float3(mad(fragment_unnamed_175.y, 2.0f, -1.0f), mad(fragment_unnamed_175.z, 2.0f, -1.0f), mad(fragment_unnamed_175.w, 2.0f, -1.0f))) + (-0.800000011920928955078125f);
				precise float fragment_unnamed_194 = fragment_unnamed_193 * 5.000000476837158203125f;
				float fragment_unnamed_195 = clamp(fragment_unnamed_194, 0.0f, 1.0f);
				precise float fragment_unnamed_197 = fragment_unnamed_195 * fragment_unnamed_195;
				precise float fragment_unnamed_198 = fragment_unnamed_197 * mad(fragment_unnamed_195, -2.0f, 3.0f);
				precise float fragment_unnamed_199 = fragment_unnamed_198 * 0.3162162303924560546875f;
				precise float fragment_unnamed_208 = dot(float3(fragment_unnamed_136, fragment_unnamed_137, fragment_unnamed_138), float3(mad(fragment_unnamed_102.y, 2.0f, -1.0f), mad(fragment_unnamed_102.z, 2.0f, -1.0f), mad(fragment_unnamed_102.w, 2.0f, -1.0f))) + (-0.800000011920928955078125f);
				precise float fragment_unnamed_209 = fragment_unnamed_208 * 5.000000476837158203125f;
				float fragment_unnamed_210 = clamp(fragment_unnamed_209, 0.0f, 1.0f);
				precise float fragment_unnamed_212 = fragment_unnamed_210 * fragment_unnamed_210;
				precise float fragment_unnamed_213 = fragment_unnamed_212 * mad(fragment_unnamed_210, -2.0f, 3.0f);
				precise float fragment_unnamed_214 = fragment_unnamed_213 * 0.0702702701091766357421875f;
				precise float fragment_unnamed_224 = dot(float3(fragment_unnamed_136, fragment_unnamed_137, fragment_unnamed_138), float3(mad(fragment_unnamed_181.y, 2.0f, -1.0f), mad(fragment_unnamed_181.z, 2.0f, -1.0f), mad(fragment_unnamed_181.w, 2.0f, -1.0f))) + (-0.800000011920928955078125f);
				precise float fragment_unnamed_225 = fragment_unnamed_224 * 5.000000476837158203125f;
				float fragment_unnamed_226 = clamp(fragment_unnamed_225, 0.0f, 1.0f);
				precise float fragment_unnamed_228 = fragment_unnamed_226 * fragment_unnamed_226;
				precise float fragment_unnamed_229 = fragment_unnamed_228 * mad(fragment_unnamed_226, -2.0f, 3.0f);
				precise float fragment_unnamed_230 = fragment_unnamed_229 * 0.0702702701091766357421875f;
				precise float fragment_unnamed_232 = mad(fragment_unnamed_229, 0.0702702701091766357421875f, mad(fragment_unnamed_213, 0.0702702701091766357421875f, mad(fragment_unnamed_198, 0.3162162303924560546875f, fragment_unnamed_163))) + 0.2270270287990570068359375f;
				precise float fragment_unnamed_234 = mad(fragment_unnamed_181.x, fragment_unnamed_230, mad(fragment_unnamed_102.x, fragment_unnamed_214, mad(fragment_unnamed_175.x, fragment_unnamed_199, mad(_MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y)).x, 0.2270270287990570068359375f, fragment_unnamed_165)))) / fragment_unnamed_232;
				fragment_output_0.x = fragment_unnamed_234;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, fragment_uniform_buffer_0[26][1], fragment_uniform_buffer_0[26][2], fragment_uniform_buffer_0[26][3]);

				fragment_uniform_buffer_0[30] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

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
			GpuProgramID 202765

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

			float4x4 unity_WorldToCamera;
			float _RenderViewportScaleFactor;
			float4 _MainTex_TexelSize;

			static float4 unity_WorldToCamera__array[4];
			Texture2D<float4> _CameraGBufferTexture2;
			SamplerState sampler_CameraGBufferTexture2;
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

			static float4 fragment_unnamed_9;
			static float fragment_unnamed_30;
			static bool fragment_unnamed_38;
			static float4 fragment_unnamed_56;
			static float4 fragment_unnamed_105;
			static float4 fragment_unnamed_144;
			static float3 fragment_unnamed_160;
			static float4 fragment_unnamed_214;
			static float fragment_unnamed_248;
			static float3 fragment_unnamed_280;
			static float fragment_unnamed_302;
			static float3 fragment_unnamed_335;
			static float fragment_unnamed_367;

			void frag_main()
			{
				float3 fragment_unnamed_26 = _CameraGBufferTexture2.Sample(sampler_CameraGBufferTexture2, fragment_input_1).xyz;
				fragment_unnamed_9 = float4(fragment_unnamed_26.x, fragment_unnamed_26.y, fragment_unnamed_26.z, fragment_unnamed_9.w);
				fragment_unnamed_30 = dot(fragment_unnamed_9.xyz, fragment_unnamed_9.xyz);
				fragment_unnamed_38 = fragment_unnamed_30 != 0.0f;
				fragment_unnamed_30 = fragment_unnamed_38 ? (-1.0f) : (-0.0f);
				float3 fragment_unnamed_53 = (fragment_unnamed_9.xyz * 2.0f.xxx) + fragment_unnamed_30.xxx;
				fragment_unnamed_9 = float4(fragment_unnamed_53.x, fragment_unnamed_53.y, fragment_unnamed_53.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_72 = fragment_unnamed_9.yyy * unity_WorldToCamera__array[1].xyz;
				fragment_unnamed_56 = float4(fragment_unnamed_72.x, fragment_unnamed_72.y, fragment_unnamed_72.z, fragment_unnamed_56.w);
				float3 fragment_unnamed_83 = (unity_WorldToCamera__array[0].xyz * fragment_unnamed_9.xxx) + fragment_unnamed_56.xyz;
				fragment_unnamed_9 = float4(fragment_unnamed_83.x, fragment_unnamed_83.y, fragment_unnamed_9.z, fragment_unnamed_83.z);
				float3 fragment_unnamed_95 = (unity_WorldToCamera__array[2].xyz * fragment_unnamed_9.zzz) + fragment_unnamed_9.xyw;
				fragment_unnamed_9 = float4(fragment_unnamed_95.x, fragment_unnamed_95.y, fragment_unnamed_95.z, fragment_unnamed_9.w);
				fragment_unnamed_56.x = _MainTex_TexelSize.x;
				fragment_unnamed_56.y = 0.0f;
				fragment_unnamed_105 = ((-fragment_unnamed_56.xyxy) * float4(2.76923084259033203125f, 1.384615421295166015625f, 6.4615383148193359375f, 3.23076915740966796875f)) + fragment_input_0.xyxy;
				fragment_unnamed_105 = clamp(fragment_unnamed_105, 0.0f.xxxx, 1.0f.xxxx);
				fragment_unnamed_56 = (fragment_unnamed_56.xyxy * float4(2.76923084259033203125f, 1.384615421295166015625f, 6.4615383148193359375f, 3.23076915740966796875f)) + fragment_input_0.xyxy;
				fragment_unnamed_56 = clamp(fragment_unnamed_56, 0.0f.xxxx, 1.0f.xxxx);
				fragment_unnamed_56 *= _RenderViewportScaleFactor.xxxx;
				fragment_unnamed_105 *= _RenderViewportScaleFactor.xxxx;
				fragment_unnamed_144 = _MainTex.Sample(sampler_MainTex, fragment_unnamed_105.xy);
				fragment_unnamed_105 = _MainTex.Sample(sampler_MainTex, fragment_unnamed_105.zw);
				fragment_unnamed_160 = (fragment_unnamed_144.yzw * 2.0f.xxx) + (-1.0f).xxx;
				fragment_unnamed_30 = dot(fragment_unnamed_9.xyz, fragment_unnamed_160);
				fragment_unnamed_30 += (-0.800000011920928955078125f);
				fragment_unnamed_30 *= 5.000000476837158203125f;
				fragment_unnamed_30 = clamp(fragment_unnamed_30, 0.0f, 1.0f);
				fragment_unnamed_160.x = (fragment_unnamed_30 * (-2.0f)) + 3.0f;
				fragment_unnamed_30 *= fragment_unnamed_30;
				fragment_unnamed_30 *= fragment_unnamed_160.x;
				fragment_unnamed_30 *= 0.3162162303924560546875f;
				fragment_unnamed_144.x = fragment_unnamed_30 * fragment_unnamed_144.x;
				fragment_unnamed_160.x = _MainTex.Sample(sampler_MainTex, fragment_input_1).x;
				fragment_unnamed_144.x = (fragment_unnamed_160.x * 0.2270270287990570068359375f) + fragment_unnamed_144.x;
				fragment_unnamed_214 = _MainTex.Sample(sampler_MainTex, fragment_unnamed_56.xy);
				fragment_unnamed_56 = _MainTex.Sample(sampler_MainTex, fragment_unnamed_56.zw);
				fragment_unnamed_160 = (fragment_unnamed_214.yzw * 2.0f.xxx) + (-1.0f).xxx;
				fragment_unnamed_160.x = dot(fragment_unnamed_9.xyz, fragment_unnamed_160);
				fragment_unnamed_160.x += (-0.800000011920928955078125f);
				fragment_unnamed_160.x *= 5.000000476837158203125f;
				fragment_unnamed_160.x = clamp(fragment_unnamed_160.x, 0.0f, 1.0f);
				fragment_unnamed_248 = (fragment_unnamed_160.x * (-2.0f)) + 3.0f;
				fragment_unnamed_160.x *= fragment_unnamed_160.x;
				fragment_unnamed_160.x *= fragment_unnamed_248;
				fragment_unnamed_248 = fragment_unnamed_160.x * 0.3162162303924560546875f;
				fragment_unnamed_30 = (fragment_unnamed_160.x * 0.3162162303924560546875f) + fragment_unnamed_30;
				fragment_unnamed_144.x = (fragment_unnamed_214.x * fragment_unnamed_248) + fragment_unnamed_144.x;
				fragment_unnamed_280 = (fragment_unnamed_105.yzw * 2.0f.xxx) + (-1.0f).xxx;
				fragment_unnamed_280.x = dot(fragment_unnamed_9.xyz, fragment_unnamed_280);
				fragment_unnamed_280.x += (-0.800000011920928955078125f);
				fragment_unnamed_280.x *= 5.000000476837158203125f;
				fragment_unnamed_280.x = clamp(fragment_unnamed_280.x, 0.0f, 1.0f);
				fragment_unnamed_302 = (fragment_unnamed_280.x * (-2.0f)) + 3.0f;
				fragment_unnamed_280.x *= fragment_unnamed_280.x;
				fragment_unnamed_280.x *= fragment_unnamed_302;
				fragment_unnamed_302 = fragment_unnamed_280.x * 0.0702702701091766357421875f;
				fragment_unnamed_30 = (fragment_unnamed_280.x * 0.0702702701091766357421875f) + fragment_unnamed_30;
				fragment_unnamed_105.x = (fragment_unnamed_105.x * fragment_unnamed_302) + fragment_unnamed_144.x;
				fragment_unnamed_335 = (fragment_unnamed_56.yzw * 2.0f.xxx) + (-1.0f).xxx;
				fragment_unnamed_335.x = dot(fragment_unnamed_9.xyz, fragment_unnamed_335);
				float3 fragment_unnamed_352 = (fragment_unnamed_9.xyz * 0.5f.xxx) + 0.5f.xxx;
				fragment_output_0 = float4(fragment_output_0.x, fragment_unnamed_352.x, fragment_unnamed_352.y, fragment_unnamed_352.z);
				fragment_unnamed_9.x = fragment_unnamed_335.x + (-0.800000011920928955078125f);
				fragment_unnamed_9.x *= 5.000000476837158203125f;
				fragment_unnamed_9.x = clamp(fragment_unnamed_9.x, 0.0f, 1.0f);
				fragment_unnamed_367 = (fragment_unnamed_9.x * (-2.0f)) + 3.0f;
				fragment_unnamed_9.x *= fragment_unnamed_9.x;
				fragment_unnamed_9.x *= fragment_unnamed_367;
				fragment_unnamed_367 = fragment_unnamed_9.x * 0.0702702701091766357421875f;
				fragment_unnamed_9.x = (fragment_unnamed_9.x * 0.0702702701091766357421875f) + fragment_unnamed_30;
				fragment_unnamed_9.x += 0.2270270287990570068359375f;
				fragment_unnamed_367 = (fragment_unnamed_56.x * fragment_unnamed_367) + fragment_unnamed_105.x;
				fragment_output_0.x = fragment_unnamed_367 / fragment_unnamed_9.x;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				unity_WorldToCamera__array[0] = float4(unity_WorldToCamera[0][0], unity_WorldToCamera[1][0], unity_WorldToCamera[2][0], unity_WorldToCamera[3][0]);
				unity_WorldToCamera__array[1] = float4(unity_WorldToCamera[0][1], unity_WorldToCamera[1][1], unity_WorldToCamera[2][1], unity_WorldToCamera[3][1]);
				unity_WorldToCamera__array[2] = float4(unity_WorldToCamera[0][2], unity_WorldToCamera[1][2], unity_WorldToCamera[2][2], unity_WorldToCamera[3][2]);
				unity_WorldToCamera__array[3] = float4(unity_WorldToCamera[0][3], unity_WorldToCamera[1][3], unity_WorldToCamera[2][3], unity_WorldToCamera[3][3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_0 = stage_input.fragment_input_0;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			float4x4 unity_WorldToCamera;
			float _RenderViewportScaleFactor;
			float4 _MainTex_TexelSize;

			static float4 fragment_uniform_buffer_0[31];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _CameraGBufferTexture2;
			SamplerState sampler_MainTex;
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
				float4 fragment_unnamed_43 = _CameraGBufferTexture2.Sample(sampler_CameraGBufferTexture2, float2(fragment_input_1.x, fragment_input_1.y));
				float fragment_unnamed_45 = fragment_unnamed_43.x;
				float fragment_unnamed_57 = asfloat((dot(float3(fragment_unnamed_45, fragment_unnamed_43.yz), float3(fragment_unnamed_45, fragment_unnamed_43.yz)) != 0.0f) ? 3212836864u : 2147483648u);
				float fragment_unnamed_59 = mad(fragment_unnamed_45, 2.0f, fragment_unnamed_57);
				float fragment_unnamed_61 = mad(fragment_unnamed_43.y, 2.0f, fragment_unnamed_57);
				float fragment_unnamed_62 = mad(fragment_unnamed_43.z, 2.0f, fragment_unnamed_57);
				precise float fragment_unnamed_70 = fragment_unnamed_61 * fragment_uniform_buffer_0[13u].x;
				precise float fragment_unnamed_71 = fragment_unnamed_61 * fragment_uniform_buffer_0[13u].y;
				precise float fragment_unnamed_72 = fragment_unnamed_61 * fragment_uniform_buffer_0[13u].z;
				float fragment_unnamed_88 = mad(fragment_uniform_buffer_0[14u].x, fragment_unnamed_62, mad(fragment_uniform_buffer_0[12u].x, fragment_unnamed_59, fragment_unnamed_70));
				float fragment_unnamed_89 = mad(fragment_uniform_buffer_0[14u].y, fragment_unnamed_62, mad(fragment_uniform_buffer_0[12u].y, fragment_unnamed_59, fragment_unnamed_71));
				float fragment_unnamed_90 = mad(fragment_uniform_buffer_0[14u].z, fragment_unnamed_62, mad(fragment_uniform_buffer_0[12u].z, fragment_unnamed_59, fragment_unnamed_72));
				float fragment_unnamed_97 = asfloat(asuint(fragment_uniform_buffer_0[30u]).x);
				float fragment_unnamed_98 = asfloat(0u);
				precise float fragment_unnamed_99 = (-0.0f) - fragment_unnamed_97;
				precise float fragment_unnamed_101 = (-0.0f) - fragment_unnamed_98;
				precise float fragment_unnamed_135 = clamp(mad(fragment_unnamed_97, 2.76923084259033203125f, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_136 = clamp(mad(fragment_unnamed_98, 1.384615421295166015625f, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_137 = clamp(mad(fragment_unnamed_97, 6.4615383148193359375f, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_138 = clamp(mad(fragment_unnamed_98, 3.23076915740966796875f, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_142 = clamp(mad(fragment_unnamed_99, 2.76923084259033203125f, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_143 = clamp(mad(fragment_unnamed_101, 1.384615421295166015625f, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_144 = clamp(mad(fragment_unnamed_99, 6.4615383148193359375f, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_145 = clamp(mad(fragment_unnamed_101, 3.23076915740966796875f, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_147 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_142, fragment_unnamed_143));
				float4 fragment_unnamed_153 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_144, fragment_unnamed_145));
				precise float fragment_unnamed_166 = dot(float3(fragment_unnamed_88, fragment_unnamed_89, fragment_unnamed_90), float3(mad(fragment_unnamed_147.y, 2.0f, -1.0f), mad(fragment_unnamed_147.z, 2.0f, -1.0f), mad(fragment_unnamed_147.w, 2.0f, -1.0f))) + (-0.800000011920928955078125f);
				precise float fragment_unnamed_168 = fragment_unnamed_166 * 5.000000476837158203125f;
				float fragment_unnamed_170 = clamp(fragment_unnamed_168, 0.0f, 1.0f);
				precise float fragment_unnamed_174 = fragment_unnamed_170 * fragment_unnamed_170;
				precise float fragment_unnamed_175 = fragment_unnamed_174 * mad(fragment_unnamed_170, -2.0f, 3.0f);
				precise float fragment_unnamed_176 = fragment_unnamed_175 * 0.3162162303924560546875f;
				precise float fragment_unnamed_178 = fragment_unnamed_176 * fragment_unnamed_147.x;
				float4 fragment_unnamed_188 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_135, fragment_unnamed_136));
				float4 fragment_unnamed_194 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_137, fragment_unnamed_138));
				precise float fragment_unnamed_206 = dot(float3(fragment_unnamed_88, fragment_unnamed_89, fragment_unnamed_90), float3(mad(fragment_unnamed_188.y, 2.0f, -1.0f), mad(fragment_unnamed_188.z, 2.0f, -1.0f), mad(fragment_unnamed_188.w, 2.0f, -1.0f))) + (-0.800000011920928955078125f);
				precise float fragment_unnamed_207 = fragment_unnamed_206 * 5.000000476837158203125f;
				float fragment_unnamed_208 = clamp(fragment_unnamed_207, 0.0f, 1.0f);
				precise float fragment_unnamed_210 = fragment_unnamed_208 * fragment_unnamed_208;
				precise float fragment_unnamed_211 = fragment_unnamed_210 * mad(fragment_unnamed_208, -2.0f, 3.0f);
				precise float fragment_unnamed_212 = fragment_unnamed_211 * 0.3162162303924560546875f;
				precise float fragment_unnamed_221 = dot(float3(fragment_unnamed_88, fragment_unnamed_89, fragment_unnamed_90), float3(mad(fragment_unnamed_153.y, 2.0f, -1.0f), mad(fragment_unnamed_153.z, 2.0f, -1.0f), mad(fragment_unnamed_153.w, 2.0f, -1.0f))) + (-0.800000011920928955078125f);
				precise float fragment_unnamed_222 = fragment_unnamed_221 * 5.000000476837158203125f;
				float fragment_unnamed_223 = clamp(fragment_unnamed_222, 0.0f, 1.0f);
				precise float fragment_unnamed_225 = fragment_unnamed_223 * fragment_unnamed_223;
				precise float fragment_unnamed_226 = fragment_unnamed_225 * mad(fragment_unnamed_223, -2.0f, 3.0f);
				precise float fragment_unnamed_227 = fragment_unnamed_226 * 0.0702702701091766357421875f;
				fragment_output_0.y = mad(fragment_unnamed_88, 0.5f, 0.5f);
				fragment_output_0.z = mad(fragment_unnamed_89, 0.5f, 0.5f);
				fragment_output_0.w = mad(fragment_unnamed_90, 0.5f, 0.5f);
				precise float fragment_unnamed_247 = dot(float3(fragment_unnamed_88, fragment_unnamed_89, fragment_unnamed_90), float3(mad(fragment_unnamed_194.y, 2.0f, -1.0f), mad(fragment_unnamed_194.z, 2.0f, -1.0f), mad(fragment_unnamed_194.w, 2.0f, -1.0f))) + (-0.800000011920928955078125f);
				precise float fragment_unnamed_248 = fragment_unnamed_247 * 5.000000476837158203125f;
				float fragment_unnamed_249 = clamp(fragment_unnamed_248, 0.0f, 1.0f);
				precise float fragment_unnamed_251 = fragment_unnamed_249 * fragment_unnamed_249;
				precise float fragment_unnamed_252 = fragment_unnamed_251 * mad(fragment_unnamed_249, -2.0f, 3.0f);
				precise float fragment_unnamed_253 = fragment_unnamed_252 * 0.0702702701091766357421875f;
				precise float fragment_unnamed_255 = mad(fragment_unnamed_252, 0.0702702701091766357421875f, mad(fragment_unnamed_226, 0.0702702701091766357421875f, mad(fragment_unnamed_211, 0.3162162303924560546875f, fragment_unnamed_176))) + 0.2270270287990570068359375f;
				precise float fragment_unnamed_257 = mad(fragment_unnamed_194.x, fragment_unnamed_253, mad(fragment_unnamed_153.x, fragment_unnamed_227, mad(fragment_unnamed_188.x, fragment_unnamed_212, mad(_MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y)).x, 0.2270270287990570068359375f, fragment_unnamed_178)))) / fragment_unnamed_255;
				fragment_output_0.x = fragment_unnamed_257;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[12] = float4(unity_WorldToCamera[0][0], unity_WorldToCamera[1][0], unity_WorldToCamera[2][0], unity_WorldToCamera[3][0]);
				fragment_uniform_buffer_0[13] = float4(unity_WorldToCamera[0][1], unity_WorldToCamera[1][1], unity_WorldToCamera[2][1], unity_WorldToCamera[3][1]);
				fragment_uniform_buffer_0[14] = float4(unity_WorldToCamera[0][2], unity_WorldToCamera[1][2], unity_WorldToCamera[2][2], unity_WorldToCamera[3][2]);
				fragment_uniform_buffer_0[15] = float4(unity_WorldToCamera[0][3], unity_WorldToCamera[1][3], unity_WorldToCamera[2][3], unity_WorldToCamera[3][3]);

				fragment_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, fragment_uniform_buffer_0[26][1], fragment_uniform_buffer_0[26][2], fragment_uniform_buffer_0[26][3]);

				fragment_uniform_buffer_0[30] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

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
			GpuProgramID 311286

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
			float4 _AOParams;

			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

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
			static float4 fragment_unnamed_32;
			static float4 fragment_unnamed_76;
			static float3 fragment_unnamed_98;
			static float4 fragment_unnamed_107;
			static float3 fragment_unnamed_114;
			static float fragment_unnamed_137;
			static float4 fragment_unnamed_174;
			static float3 fragment_unnamed_187;
			static float fragment_unnamed_201;
			static float3 fragment_unnamed_227;
			static float fragment_unnamed_248;
			static float3 fragment_unnamed_283;
			static float fragment_unnamed_313;

			void frag_main()
			{
				fragment_unnamed_9.x = _MainTex_TexelSize.y / _AOParams.z;
				fragment_unnamed_9.y = 1.384615421295166015625f;
				fragment_unnamed_9.z = 3.23076915740966796875f;
				fragment_unnamed_32 = (float4(-0.0f, -2.76923084259033203125f, -0.0f, -6.4615383148193359375f) * fragment_unnamed_9.yxzx) + fragment_input_0.xyxy;
				fragment_unnamed_32 = clamp(fragment_unnamed_32, 0.0f.xxxx, 1.0f.xxxx);
				fragment_unnamed_9 = (float4(0.0f, 2.76923084259033203125f, 0.0f, 6.4615383148193359375f) * fragment_unnamed_9.yxzx) + fragment_input_0.xyxy;
				fragment_unnamed_9 = clamp(fragment_unnamed_9, 0.0f.xxxx, 1.0f.xxxx);
				fragment_unnamed_9 *= _RenderViewportScaleFactor.xxxx;
				fragment_unnamed_32 *= _RenderViewportScaleFactor.xxxx;
				fragment_unnamed_76 = _MainTex.Sample(sampler_MainTex, fragment_unnamed_32.xy);
				fragment_unnamed_32 = _MainTex.Sample(sampler_MainTex, fragment_unnamed_32.zw);
				fragment_unnamed_98 = (fragment_unnamed_76.yzw * 2.0f.xxx) + (-1.0f).xxx;
				fragment_unnamed_107 = _MainTex.Sample(sampler_MainTex, fragment_input_1);
				fragment_unnamed_114 = (fragment_unnamed_107.yzw * 2.0f.xxx) + (-1.0f).xxx;
				fragment_unnamed_98.x = dot(fragment_unnamed_114, fragment_unnamed_98);
				fragment_unnamed_98.x += (-0.800000011920928955078125f);
				fragment_unnamed_98.x *= 5.000000476837158203125f;
				fragment_unnamed_98.x = clamp(fragment_unnamed_98.x, 0.0f, 1.0f);
				fragment_unnamed_137 = (fragment_unnamed_98.x * (-2.0f)) + 3.0f;
				fragment_unnamed_98.x *= fragment_unnamed_98.x;
				fragment_unnamed_98.x *= fragment_unnamed_137;
				fragment_unnamed_98.x *= 0.3162162303924560546875f;
				fragment_unnamed_76.x = fragment_unnamed_98.x * fragment_unnamed_76.x;
				fragment_unnamed_76.x = (fragment_unnamed_107.x * 0.2270270287990570068359375f) + fragment_unnamed_76.x;
				fragment_unnamed_174 = _MainTex.Sample(sampler_MainTex, fragment_unnamed_9.xy);
				fragment_unnamed_9 = _MainTex.Sample(sampler_MainTex, fragment_unnamed_9.zw);
				fragment_unnamed_187 = (fragment_unnamed_174.yzw * 2.0f.xxx) + (-1.0f).xxx;
				fragment_unnamed_137 = dot(fragment_unnamed_114, fragment_unnamed_187);
				fragment_unnamed_137 += (-0.800000011920928955078125f);
				fragment_unnamed_137 *= 5.000000476837158203125f;
				fragment_unnamed_137 = clamp(fragment_unnamed_137, 0.0f, 1.0f);
				fragment_unnamed_201 = (fragment_unnamed_137 * (-2.0f)) + 3.0f;
				fragment_unnamed_137 *= fragment_unnamed_137;
				fragment_unnamed_137 *= fragment_unnamed_201;
				fragment_unnamed_201 = fragment_unnamed_137 * 0.3162162303924560546875f;
				fragment_unnamed_98.x = (fragment_unnamed_137 * 0.3162162303924560546875f) + fragment_unnamed_98.x;
				fragment_unnamed_76.x = (fragment_unnamed_174.x * fragment_unnamed_201) + fragment_unnamed_76.x;
				fragment_unnamed_227 = (fragment_unnamed_32.yzw * 2.0f.xxx) + (-1.0f).xxx;
				fragment_unnamed_227.x = dot(fragment_unnamed_114, fragment_unnamed_227);
				fragment_unnamed_227.x += (-0.800000011920928955078125f);
				fragment_unnamed_227.x *= 5.000000476837158203125f;
				fragment_unnamed_227.x = clamp(fragment_unnamed_227.x, 0.0f, 1.0f);
				fragment_unnamed_248 = (fragment_unnamed_227.x * (-2.0f)) + 3.0f;
				fragment_unnamed_227.x *= fragment_unnamed_227.x;
				fragment_unnamed_227.x *= fragment_unnamed_248;
				fragment_unnamed_248 = fragment_unnamed_227.x * 0.0702702701091766357421875f;
				fragment_unnamed_227.x = (fragment_unnamed_227.x * 0.0702702701091766357421875f) + fragment_unnamed_98.x;
				fragment_unnamed_32.x = (fragment_unnamed_32.x * fragment_unnamed_248) + fragment_unnamed_76.x;
				fragment_unnamed_283 = (fragment_unnamed_9.yzw * 2.0f.xxx) + (-1.0f).xxx;
				fragment_unnamed_283.x = dot(fragment_unnamed_114, fragment_unnamed_283);
				float3 fragment_unnamed_298 = (fragment_unnamed_114 * 0.5f.xxx) + 0.5f.xxx;
				fragment_output_0 = float4(fragment_output_0.x, fragment_unnamed_298.x, fragment_unnamed_298.y, fragment_unnamed_298.z);
				fragment_unnamed_283.x += (-0.800000011920928955078125f);
				fragment_unnamed_283.x *= 5.000000476837158203125f;
				fragment_unnamed_283.x = clamp(fragment_unnamed_283.x, 0.0f, 1.0f);
				fragment_unnamed_313 = (fragment_unnamed_283.x * (-2.0f)) + 3.0f;
				fragment_unnamed_283.x *= fragment_unnamed_283.x;
				fragment_unnamed_283.x *= fragment_unnamed_313;
				fragment_unnamed_313 = fragment_unnamed_283.x * 0.0702702701091766357421875f;
				fragment_unnamed_283.x = (fragment_unnamed_283.x * 0.0702702701091766357421875f) + fragment_unnamed_227.x;
				fragment_unnamed_283.x += 0.2270270287990570068359375f;
				fragment_unnamed_9.x = (fragment_unnamed_9.x * fragment_unnamed_313) + fragment_unnamed_32.x;
				fragment_output_0.x = fragment_unnamed_9.x / fragment_unnamed_283.x;
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


			float _RenderViewportScaleFactor;
			float4 _MainTex_TexelSize;
			float4 _AOParams;

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
				precise float fragment_unnamed_39 = fragment_uniform_buffer_0[30u].y / fragment_uniform_buffer_0[31u].z;
				float fragment_unnamed_40 = asfloat(1068579604u);
				float fragment_unnamed_42 = asfloat(1078904044u);
				precise float fragment_unnamed_82 = clamp(mad(0.0f, fragment_unnamed_40, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_83 = clamp(mad(2.76923084259033203125f, fragment_unnamed_39, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_84 = clamp(mad(0.0f, fragment_unnamed_42, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_85 = clamp(mad(6.4615383148193359375f, fragment_unnamed_39, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_89 = clamp(mad(-0.0f, fragment_unnamed_40, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_90 = clamp(mad(-2.76923084259033203125f, fragment_unnamed_39, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_91 = clamp(mad(-0.0f, fragment_unnamed_42, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_92 = clamp(mad(-6.4615383148193359375f, fragment_unnamed_39, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_95 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_89, fragment_unnamed_90));
				float4 fragment_unnamed_101 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_91, fragment_unnamed_92));
				float4 fragment_unnamed_116 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				float fragment_unnamed_122 = mad(fragment_unnamed_116.y, 2.0f, -1.0f);
				float fragment_unnamed_123 = mad(fragment_unnamed_116.z, 2.0f, -1.0f);
				float fragment_unnamed_124 = mad(fragment_unnamed_116.w, 2.0f, -1.0f);
				precise float fragment_unnamed_129 = dot(float3(fragment_unnamed_122, fragment_unnamed_123, fragment_unnamed_124), float3(mad(fragment_unnamed_95.y, 2.0f, -1.0f), mad(fragment_unnamed_95.z, 2.0f, -1.0f), mad(fragment_unnamed_95.w, 2.0f, -1.0f))) + (-0.800000011920928955078125f);
				precise float fragment_unnamed_131 = fragment_unnamed_129 * 5.000000476837158203125f;
				float fragment_unnamed_133 = clamp(fragment_unnamed_131, 0.0f, 1.0f);
				precise float fragment_unnamed_137 = fragment_unnamed_133 * fragment_unnamed_133;
				precise float fragment_unnamed_138 = fragment_unnamed_137 * mad(fragment_unnamed_133, -2.0f, 3.0f);
				precise float fragment_unnamed_139 = fragment_unnamed_138 * 0.3162162303924560546875f;
				precise float fragment_unnamed_141 = fragment_unnamed_139 * fragment_unnamed_95.x;
				float4 fragment_unnamed_144 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_82, fragment_unnamed_83));
				float4 fragment_unnamed_150 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_84, fragment_unnamed_85));
				precise float fragment_unnamed_162 = dot(float3(fragment_unnamed_122, fragment_unnamed_123, fragment_unnamed_124), float3(mad(fragment_unnamed_144.y, 2.0f, -1.0f), mad(fragment_unnamed_144.z, 2.0f, -1.0f), mad(fragment_unnamed_144.w, 2.0f, -1.0f))) + (-0.800000011920928955078125f);
				precise float fragment_unnamed_163 = fragment_unnamed_162 * 5.000000476837158203125f;
				float fragment_unnamed_164 = clamp(fragment_unnamed_163, 0.0f, 1.0f);
				precise float fragment_unnamed_166 = fragment_unnamed_164 * fragment_unnamed_164;
				precise float fragment_unnamed_167 = fragment_unnamed_166 * mad(fragment_unnamed_164, -2.0f, 3.0f);
				precise float fragment_unnamed_168 = fragment_unnamed_167 * 0.3162162303924560546875f;
				precise float fragment_unnamed_177 = dot(float3(fragment_unnamed_122, fragment_unnamed_123, fragment_unnamed_124), float3(mad(fragment_unnamed_101.y, 2.0f, -1.0f), mad(fragment_unnamed_101.z, 2.0f, -1.0f), mad(fragment_unnamed_101.w, 2.0f, -1.0f))) + (-0.800000011920928955078125f);
				precise float fragment_unnamed_178 = fragment_unnamed_177 * 5.000000476837158203125f;
				float fragment_unnamed_179 = clamp(fragment_unnamed_178, 0.0f, 1.0f);
				precise float fragment_unnamed_181 = fragment_unnamed_179 * fragment_unnamed_179;
				precise float fragment_unnamed_182 = fragment_unnamed_181 * mad(fragment_unnamed_179, -2.0f, 3.0f);
				precise float fragment_unnamed_183 = fragment_unnamed_182 * 0.0702702701091766357421875f;
				fragment_output_0.y = mad(fragment_unnamed_122, 0.5f, 0.5f);
				fragment_output_0.z = mad(fragment_unnamed_123, 0.5f, 0.5f);
				fragment_output_0.w = mad(fragment_unnamed_124, 0.5f, 0.5f);
				precise float fragment_unnamed_203 = dot(float3(fragment_unnamed_122, fragment_unnamed_123, fragment_unnamed_124), float3(mad(fragment_unnamed_150.y, 2.0f, -1.0f), mad(fragment_unnamed_150.z, 2.0f, -1.0f), mad(fragment_unnamed_150.w, 2.0f, -1.0f))) + (-0.800000011920928955078125f);
				precise float fragment_unnamed_204 = fragment_unnamed_203 * 5.000000476837158203125f;
				float fragment_unnamed_205 = clamp(fragment_unnamed_204, 0.0f, 1.0f);
				precise float fragment_unnamed_207 = fragment_unnamed_205 * fragment_unnamed_205;
				precise float fragment_unnamed_208 = fragment_unnamed_207 * mad(fragment_unnamed_205, -2.0f, 3.0f);
				precise float fragment_unnamed_209 = fragment_unnamed_208 * 0.0702702701091766357421875f;
				precise float fragment_unnamed_211 = mad(fragment_unnamed_208, 0.0702702701091766357421875f, mad(fragment_unnamed_182, 0.0702702701091766357421875f, mad(fragment_unnamed_167, 0.3162162303924560546875f, fragment_unnamed_139))) + 0.2270270287990570068359375f;
				precise float fragment_unnamed_213 = mad(fragment_unnamed_150.x, fragment_unnamed_209, mad(fragment_unnamed_101.x, fragment_unnamed_183, mad(fragment_unnamed_144.x, fragment_unnamed_168, mad(fragment_unnamed_116.x, 0.2270270287990570068359375f, fragment_unnamed_141)))) / fragment_unnamed_211;
				fragment_output_0.x = fragment_unnamed_213;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, fragment_uniform_buffer_0[26][1], fragment_uniform_buffer_0[26][2], fragment_uniform_buffer_0[26][3]);

				fragment_uniform_buffer_0[30] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				fragment_uniform_buffer_0[31] = float4(_AOParams[0], _AOParams[1], _AOParams[2], _AOParams[3]);

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
			GpuProgramID 356579

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
			float4 _AOParams;
			float3 _AOColor;
			float4 _SAOcclusionTexture_TexelSize;

			Texture2D<float4> _SAOcclusionTexture;
			SamplerState sampler_SAOcclusionTexture;

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
			static float3 fragment_unnamed_54;
			static float4 fragment_unnamed_63;
			static float4 fragment_unnamed_76;
			static float3 fragment_unnamed_105;
			static float fragment_unnamed_131;
			static float4 fragment_unnamed_163;
			static float4 fragment_unnamed_205;
			static float fragment_unnamed_251;
			static float3 fragment_unnamed_322;
			static float fragment_unnamed_343;
			static float fragment_unnamed_354;
			static bool fragment_unnamed_425;

			void frag_main()
			{
				fragment_unnamed_9 = float4(fragment_input_0.x, fragment_input_0.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
				float2 fragment_unnamed_22 = clamp(fragment_unnamed_9.xy, 0.0f.xx, 1.0f.xx);
				fragment_unnamed_9 = float4(fragment_unnamed_22.x, fragment_unnamed_22.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
				float2 fragment_unnamed_37 = fragment_unnamed_9.xy * _RenderViewportScaleFactor.xx;
				fragment_unnamed_9 = float4(fragment_unnamed_37.x, fragment_unnamed_37.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
				fragment_unnamed_9 = _SAOcclusionTexture.Sample(sampler_SAOcclusionTexture, fragment_unnamed_9.xy);
				fragment_unnamed_54 = (fragment_unnamed_9.yzw * 2.0f.xxx) + (-1.0f).xxx;
				float2 fragment_unnamed_73 = _SAOcclusionTexture_TexelSize.xy / _AOParams.zz;
				fragment_unnamed_63 = float4(fragment_unnamed_73.x, fragment_unnamed_73.y, fragment_unnamed_63.z, fragment_unnamed_63.w);
				float2 fragment_unnamed_81 = (-fragment_unnamed_63.xy) + fragment_input_0;
				fragment_unnamed_76 = float4(fragment_unnamed_81.x, fragment_unnamed_81.y, fragment_unnamed_76.z, fragment_unnamed_76.w);
				float2 fragment_unnamed_88 = clamp(fragment_unnamed_76.xy, 0.0f.xx, 1.0f.xx);
				fragment_unnamed_76 = float4(fragment_unnamed_88.x, fragment_unnamed_88.y, fragment_unnamed_76.z, fragment_unnamed_76.w);
				float2 fragment_unnamed_96 = fragment_unnamed_76.xy * _RenderViewportScaleFactor.xx;
				fragment_unnamed_76 = float4(fragment_unnamed_96.x, fragment_unnamed_96.y, fragment_unnamed_76.z, fragment_unnamed_76.w);
				fragment_unnamed_76 = _SAOcclusionTexture.Sample(sampler_SAOcclusionTexture, fragment_unnamed_76.xy);
				fragment_unnamed_105 = (fragment_unnamed_76.yzw * 2.0f.xxx) + (-1.0f).xxx;
				fragment_unnamed_105.x = dot(fragment_unnamed_54, fragment_unnamed_105);
				fragment_unnamed_105.x += (-0.800000011920928955078125f);
				fragment_unnamed_105.x *= 5.000000476837158203125f;
				fragment_unnamed_105.x = clamp(fragment_unnamed_105.x, 0.0f, 1.0f);
				fragment_unnamed_131 = (fragment_unnamed_105.x * (-2.0f)) + 3.0f;
				fragment_unnamed_105.x *= fragment_unnamed_105.x;
				fragment_unnamed_105.x *= fragment_unnamed_131;
				fragment_unnamed_9.x = (fragment_unnamed_76.x * fragment_unnamed_105.x) + fragment_unnamed_9.x;
				float2 fragment_unnamed_160 = -fragment_unnamed_63.yx;
				fragment_unnamed_63 = float4(fragment_unnamed_63.x, fragment_unnamed_63.y, fragment_unnamed_160.x, fragment_unnamed_160.y);
				fragment_unnamed_163 = fragment_unnamed_63.xzwy + fragment_input_0.xyxy;
				fragment_unnamed_163 = clamp(fragment_unnamed_163, 0.0f.xxxx, 1.0f.xxxx);
				float2 fragment_unnamed_176 = fragment_unnamed_63.xy + fragment_input_0;
				fragment_unnamed_63 = float4(fragment_unnamed_176.x, fragment_unnamed_176.y, fragment_unnamed_63.z, fragment_unnamed_63.w);
				float2 fragment_unnamed_183 = clamp(fragment_unnamed_63.xy, 0.0f.xx, 1.0f.xx);
				fragment_unnamed_63 = float4(fragment_unnamed_183.x, fragment_unnamed_183.y, fragment_unnamed_63.z, fragment_unnamed_63.w);
				float2 fragment_unnamed_191 = fragment_unnamed_63.xy * _RenderViewportScaleFactor.xx;
				fragment_unnamed_63 = float4(fragment_unnamed_191.x, fragment_unnamed_191.y, fragment_unnamed_63.z, fragment_unnamed_63.w);
				fragment_unnamed_63 = _SAOcclusionTexture.Sample(sampler_SAOcclusionTexture, fragment_unnamed_63.xy);
				fragment_unnamed_163 *= _RenderViewportScaleFactor.xxxx;
				fragment_unnamed_205 = _SAOcclusionTexture.Sample(sampler_SAOcclusionTexture, fragment_unnamed_163.xy);
				fragment_unnamed_163 = _SAOcclusionTexture.Sample(sampler_SAOcclusionTexture, fragment_unnamed_163.zw);
				float3 fragment_unnamed_221 = (fragment_unnamed_205.yzw * 2.0f.xxx) + (-1.0f).xxx;
				fragment_unnamed_76 = float4(fragment_unnamed_221.x, fragment_unnamed_76.y, fragment_unnamed_221.y, fragment_unnamed_221.z);
				fragment_unnamed_76.x = dot(fragment_unnamed_54, fragment_unnamed_76.xzw);
				fragment_unnamed_76.x += (-0.800000011920928955078125f);
				fragment_unnamed_76.x *= 5.000000476837158203125f;
				fragment_unnamed_76.x = clamp(fragment_unnamed_76.x, 0.0f, 1.0f);
				fragment_unnamed_131 = (fragment_unnamed_76.x * (-2.0f)) + 3.0f;
				fragment_unnamed_76.x *= fragment_unnamed_76.x;
				fragment_unnamed_251 = fragment_unnamed_76.x * fragment_unnamed_131;
				fragment_unnamed_76.x = (fragment_unnamed_131 * fragment_unnamed_76.x) + fragment_unnamed_105.x;
				fragment_unnamed_9.x = (fragment_unnamed_205.x * fragment_unnamed_251) + fragment_unnamed_9.x;
				fragment_unnamed_105 = (fragment_unnamed_163.yzw * 2.0f.xxx) + (-1.0f).xxx;
				fragment_unnamed_105.x = dot(fragment_unnamed_54, fragment_unnamed_105);
				fragment_unnamed_105.x += (-0.800000011920928955078125f);
				fragment_unnamed_105.x *= 5.000000476837158203125f;
				fragment_unnamed_105.x = clamp(fragment_unnamed_105.x, 0.0f, 1.0f);
				fragment_unnamed_131 = (fragment_unnamed_105.x * (-2.0f)) + 3.0f;
				fragment_unnamed_105.x *= fragment_unnamed_105.x;
				fragment_unnamed_251 = fragment_unnamed_105.x * fragment_unnamed_131;
				fragment_unnamed_76.x = (fragment_unnamed_131 * fragment_unnamed_105.x) + fragment_unnamed_76.x;
				fragment_unnamed_9.x = (fragment_unnamed_163.x * fragment_unnamed_251) + fragment_unnamed_9.x;
				fragment_unnamed_322 = (fragment_unnamed_63.yzw * 2.0f.xxx) + (-1.0f).xxx;
				fragment_unnamed_54.x = dot(fragment_unnamed_54, fragment_unnamed_322);
				fragment_unnamed_54.x += (-0.800000011920928955078125f);
				fragment_unnamed_54.x *= 5.000000476837158203125f;
				fragment_unnamed_54.x = clamp(fragment_unnamed_54.x, 0.0f, 1.0f);
				fragment_unnamed_343 = (fragment_unnamed_54.x * (-2.0f)) + 3.0f;
				fragment_unnamed_54.x *= fragment_unnamed_54.x;
				fragment_unnamed_354 = fragment_unnamed_54.x * fragment_unnamed_343;
				fragment_unnamed_54.x = (fragment_unnamed_343 * fragment_unnamed_54.x) + fragment_unnamed_76.x;
				fragment_unnamed_54.x += 1.0f;
				fragment_unnamed_9.x = (fragment_unnamed_63.x * fragment_unnamed_354) + fragment_unnamed_9.x;
				fragment_unnamed_9.x /= fragment_unnamed_54.x;
				fragment_unnamed_9.x = clamp(fragment_unnamed_9.x, 0.0f, 1.0f);
				fragment_unnamed_9.x = (-fragment_unnamed_9.x) + 1.0f;
				fragment_unnamed_54.x = max(fragment_unnamed_9.x, 1.1920928955078125e-07f);
				fragment_unnamed_9.y = log2(fragment_unnamed_54.x);
				float2 fragment_unnamed_409 = fragment_unnamed_9.yx * float2(0.4166666567325592041015625f, 12.9200000762939453125f);
				fragment_unnamed_54 = float3(fragment_unnamed_409.x, fragment_unnamed_409.y, fragment_unnamed_54.z);
				fragment_unnamed_54.x = exp2(fragment_unnamed_54.x);
				fragment_unnamed_54.x = (fragment_unnamed_54.x * 1.05499994754791259765625f) + (-0.054999999701976776123046875f);
				fragment_unnamed_425 = 0.003130800090730190277099609375f >= fragment_unnamed_9.x;
				float fragment_unnamed_432;
				if (fragment_unnamed_425)
				{
					fragment_unnamed_432 = fragment_unnamed_54.y;
				}
				else
				{
					fragment_unnamed_432 = fragment_unnamed_54.x;
				}
				fragment_unnamed_9.x = fragment_unnamed_432;
				fragment_unnamed_9.x = max(fragment_unnamed_9.x, 0.0f);
				fragment_unnamed_9.x = (-fragment_unnamed_9.x) + 1.0f;
				float3 fragment_unnamed_459 = fragment_unnamed_9.xxx * _AOColor;
				fragment_output_0 = float4(fragment_unnamed_459.x, fragment_unnamed_459.y, fragment_unnamed_459.z, fragment_output_0.w);
				fragment_output_0.w = fragment_unnamed_9.x;
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
			float4 _AOParams;
			float3 _AOColor;
			float4 _SAOcclusionTexture_TexelSize;

			static float4 fragment_uniform_buffer_0[34];
			Texture2D<float4> _SAOcclusionTexture;
			SamplerState sampler_SAOcclusionTexture;

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
				precise float fragment_unnamed_46 = clamp(fragment_input_1.x, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_47 = clamp(fragment_input_1.y, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_50 = _SAOcclusionTexture.Sample(sampler_SAOcclusionTexture, float2(fragment_unnamed_46, fragment_unnamed_47));
				float fragment_unnamed_56 = mad(fragment_unnamed_50.y, 2.0f, -1.0f);
				float fragment_unnamed_59 = mad(fragment_unnamed_50.z, 2.0f, -1.0f);
				float fragment_unnamed_60 = mad(fragment_unnamed_50.w, 2.0f, -1.0f);
				precise float fragment_unnamed_70 = fragment_uniform_buffer_0[33u].x / fragment_uniform_buffer_0[31u].z;
				precise float fragment_unnamed_71 = fragment_uniform_buffer_0[33u].y / fragment_uniform_buffer_0[31u].z;
				precise float fragment_unnamed_72 = (-0.0f) - fragment_unnamed_70;
				precise float fragment_unnamed_74 = (-0.0f) - fragment_unnamed_71;
				precise float fragment_unnamed_79 = fragment_unnamed_72 + fragment_input_1.x;
				precise float fragment_unnamed_80 = fragment_unnamed_74 + fragment_input_1.y;
				precise float fragment_unnamed_86 = clamp(fragment_unnamed_79, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_87 = clamp(fragment_unnamed_80, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_88 = _SAOcclusionTexture.Sample(sampler_SAOcclusionTexture, float2(fragment_unnamed_86, fragment_unnamed_87));
				precise float fragment_unnamed_101 = dot(float3(fragment_unnamed_56, fragment_unnamed_59, fragment_unnamed_60), float3(mad(fragment_unnamed_88.y, 2.0f, -1.0f), mad(fragment_unnamed_88.z, 2.0f, -1.0f), mad(fragment_unnamed_88.w, 2.0f, -1.0f))) + (-0.800000011920928955078125f);
				precise float fragment_unnamed_103 = fragment_unnamed_101 * 5.000000476837158203125f;
				float fragment_unnamed_105 = clamp(fragment_unnamed_103, 0.0f, 1.0f);
				precise float fragment_unnamed_109 = fragment_unnamed_105 * fragment_unnamed_105;
				precise float fragment_unnamed_110 = fragment_unnamed_109 * mad(fragment_unnamed_105, -2.0f, 3.0f);
				precise float fragment_unnamed_112 = (-0.0f) - fragment_unnamed_71;
				precise float fragment_unnamed_113 = (-0.0f) - fragment_unnamed_70;
				precise float fragment_unnamed_118 = fragment_unnamed_70 + fragment_input_1.x;
				precise float fragment_unnamed_119 = fragment_unnamed_112 + fragment_input_1.y;
				precise float fragment_unnamed_120 = fragment_unnamed_113 + fragment_input_1.x;
				precise float fragment_unnamed_121 = fragment_unnamed_71 + fragment_input_1.y;
				precise float fragment_unnamed_130 = fragment_unnamed_70 + fragment_input_1.x;
				precise float fragment_unnamed_131 = fragment_unnamed_71 + fragment_input_1.y;
				precise float fragment_unnamed_137 = clamp(fragment_unnamed_130, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_138 = clamp(fragment_unnamed_131, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_139 = _SAOcclusionTexture.Sample(sampler_SAOcclusionTexture, float2(fragment_unnamed_137, fragment_unnamed_138));
				precise float fragment_unnamed_148 = clamp(fragment_unnamed_118, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_149 = clamp(fragment_unnamed_119, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_150 = clamp(fragment_unnamed_120, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_151 = clamp(fragment_unnamed_121, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_152 = _SAOcclusionTexture.Sample(sampler_SAOcclusionTexture, float2(fragment_unnamed_148, fragment_unnamed_149));
				float4 fragment_unnamed_158 = _SAOcclusionTexture.Sample(sampler_SAOcclusionTexture, float2(fragment_unnamed_150, fragment_unnamed_151));
				precise float fragment_unnamed_170 = dot(float3(fragment_unnamed_56, fragment_unnamed_59, fragment_unnamed_60), float3(mad(fragment_unnamed_152.y, 2.0f, -1.0f), mad(fragment_unnamed_152.z, 2.0f, -1.0f), mad(fragment_unnamed_152.w, 2.0f, -1.0f))) + (-0.800000011920928955078125f);
				precise float fragment_unnamed_171 = fragment_unnamed_170 * 5.000000476837158203125f;
				float fragment_unnamed_172 = clamp(fragment_unnamed_171, 0.0f, 1.0f);
				float fragment_unnamed_173 = mad(fragment_unnamed_172, -2.0f, 3.0f);
				precise float fragment_unnamed_174 = fragment_unnamed_172 * fragment_unnamed_172;
				precise float fragment_unnamed_175 = fragment_unnamed_174 * fragment_unnamed_173;
				precise float fragment_unnamed_184 = dot(float3(fragment_unnamed_56, fragment_unnamed_59, fragment_unnamed_60), float3(mad(fragment_unnamed_158.y, 2.0f, -1.0f), mad(fragment_unnamed_158.z, 2.0f, -1.0f), mad(fragment_unnamed_158.w, 2.0f, -1.0f))) + (-0.800000011920928955078125f);
				precise float fragment_unnamed_185 = fragment_unnamed_184 * 5.000000476837158203125f;
				float fragment_unnamed_186 = clamp(fragment_unnamed_185, 0.0f, 1.0f);
				float fragment_unnamed_187 = mad(fragment_unnamed_186, -2.0f, 3.0f);
				precise float fragment_unnamed_188 = fragment_unnamed_186 * fragment_unnamed_186;
				precise float fragment_unnamed_189 = fragment_unnamed_188 * fragment_unnamed_187;
				precise float fragment_unnamed_198 = dot(float3(fragment_unnamed_56, fragment_unnamed_59, fragment_unnamed_60), float3(mad(fragment_unnamed_139.y, 2.0f, -1.0f), mad(fragment_unnamed_139.z, 2.0f, -1.0f), mad(fragment_unnamed_139.w, 2.0f, -1.0f))) + (-0.800000011920928955078125f);
				precise float fragment_unnamed_199 = fragment_unnamed_198 * 5.000000476837158203125f;
				float fragment_unnamed_200 = clamp(fragment_unnamed_199, 0.0f, 1.0f);
				float fragment_unnamed_201 = mad(fragment_unnamed_200, -2.0f, 3.0f);
				precise float fragment_unnamed_202 = fragment_unnamed_200 * fragment_unnamed_200;
				precise float fragment_unnamed_203 = fragment_unnamed_202 * fragment_unnamed_201;
				precise float fragment_unnamed_205 = mad(fragment_unnamed_201, fragment_unnamed_202, mad(fragment_unnamed_187, fragment_unnamed_188, mad(fragment_unnamed_173, fragment_unnamed_174, fragment_unnamed_110))) + 1.0f;
				precise float fragment_unnamed_207 = mad(fragment_unnamed_139.x, fragment_unnamed_203, mad(fragment_unnamed_158.x, fragment_unnamed_189, mad(fragment_unnamed_152.x, fragment_unnamed_175, mad(fragment_unnamed_88.x, fragment_unnamed_110, fragment_unnamed_50.x)))) / fragment_unnamed_205;
				precise float fragment_unnamed_209 = (-0.0f) - clamp(fragment_unnamed_207, 0.0f, 1.0f);
				precise float fragment_unnamed_210 = fragment_unnamed_209 + 1.0f;
				precise float fragment_unnamed_214 = log2(max(fragment_unnamed_210, 1.1920928955078125e-07f)) * 0.4166666567325592041015625f;
				precise float fragment_unnamed_216 = fragment_unnamed_210 * 12.9200000762939453125f;
				precise float fragment_unnamed_230 = (-0.0f) - max(asfloat((0.003130800090730190277099609375f >= fragment_unnamed_210) ? asuint(fragment_unnamed_216) : asuint(mad(exp2(fragment_unnamed_214), 1.05499994754791259765625f, -0.054999999701976776123046875f))), 0.0f);
				precise float fragment_unnamed_231 = fragment_unnamed_230 + 1.0f;
				precise float fragment_unnamed_238 = fragment_unnamed_231 * fragment_uniform_buffer_0[32u].x;
				precise float fragment_unnamed_239 = fragment_unnamed_231 * fragment_uniform_buffer_0[32u].y;
				precise float fragment_unnamed_240 = fragment_unnamed_231 * fragment_uniform_buffer_0[32u].z;
				fragment_output_0.x = fragment_unnamed_238;
				fragment_output_0.y = fragment_unnamed_239;
				fragment_output_0.z = fragment_unnamed_240;
				fragment_output_0.w = fragment_unnamed_231;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, fragment_uniform_buffer_0[26][1], fragment_uniform_buffer_0[26][2], fragment_uniform_buffer_0[26][3]);

				fragment_uniform_buffer_0[31] = float4(_AOParams[0], _AOParams[1], _AOParams[2], _AOParams[3]);

				fragment_uniform_buffer_0[32] = float4(_AOColor[0], _AOColor[1], _AOColor[2], fragment_uniform_buffer_0[32][3]);

				fragment_uniform_buffer_0[33] = float4(_SAOcclusionTexture_TexelSize[0], _SAOcclusionTexture_TexelSize[1], _SAOcclusionTexture_TexelSize[2], _SAOcclusionTexture_TexelSize[3]);

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
			GpuProgramID 448316

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
			float _RenderViewportScaleFactor;
			float4 _AOParams;
			float3 _AOColor;

			Texture2D<float4> _SAOcclusionTexture;
			SamplerState sampler_SAOcclusionTexture;

			static float2 fragment_input_0;
			static float4 fragment_output_0;
			static float4 fragment_output_1;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_0 : TEXCOORD0; // vs_TEXCOORD0
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
				float4 fragment_output_1 : SV_Target1;
			};

			static float4 fragment_unnamed_9;
			static float4 fragment_unnamed_53;
			static float4 fragment_unnamed_73;
			static float3 fragment_unnamed_103;
			static float3 fragment_unnamed_111;
			static float fragment_unnamed_137;
			static float4 fragment_unnamed_169;
			static float4 fragment_unnamed_211;
			static float fragment_unnamed_257;
			static float3 fragment_unnamed_328;
			static float fragment_unnamed_349;
			static float fragment_unnamed_360;
			static bool fragment_unnamed_444;

			void frag_main()
			{
				fragment_unnamed_9 = float4(fragment_input_0.x, fragment_input_0.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
				float2 fragment_unnamed_22 = clamp(fragment_unnamed_9.xy, 0.0f.xx, 1.0f.xx);
				fragment_unnamed_9 = float4(fragment_unnamed_22.x, fragment_unnamed_22.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
				float2 fragment_unnamed_37 = fragment_unnamed_9.xy * _RenderViewportScaleFactor.xx;
				fragment_unnamed_9 = float4(fragment_unnamed_37.x, fragment_unnamed_37.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
				fragment_unnamed_9 = _SAOcclusionTexture.Sample(sampler_SAOcclusionTexture, fragment_unnamed_9.xy);
				float2 fragment_unnamed_61 = _ScreenParams.zw + (-1.0f).xx;
				fragment_unnamed_53 = float4(fragment_unnamed_61.x, fragment_unnamed_61.y, fragment_unnamed_53.z, fragment_unnamed_53.w);
				float2 fragment_unnamed_70 = fragment_unnamed_53.xy / _AOParams.zz;
				fragment_unnamed_53 = float4(fragment_unnamed_70.x, fragment_unnamed_70.y, fragment_unnamed_53.z, fragment_unnamed_53.w);
				float2 fragment_unnamed_78 = (-fragment_unnamed_53.xy) + fragment_input_0;
				fragment_unnamed_73 = float4(fragment_unnamed_78.x, fragment_unnamed_78.y, fragment_unnamed_73.z, fragment_unnamed_73.w);
				float2 fragment_unnamed_85 = clamp(fragment_unnamed_73.xy, 0.0f.xx, 1.0f.xx);
				fragment_unnamed_73 = float4(fragment_unnamed_85.x, fragment_unnamed_85.y, fragment_unnamed_73.z, fragment_unnamed_73.w);
				float2 fragment_unnamed_93 = fragment_unnamed_73.xy * _RenderViewportScaleFactor.xx;
				fragment_unnamed_73 = float4(fragment_unnamed_93.x, fragment_unnamed_93.y, fragment_unnamed_73.z, fragment_unnamed_73.w);
				fragment_unnamed_73 = _SAOcclusionTexture.Sample(sampler_SAOcclusionTexture, fragment_unnamed_73.xy);
				fragment_unnamed_103 = (fragment_unnamed_73.yzw * 2.0f.xxx) + (-1.0f).xxx;
				fragment_unnamed_111 = (fragment_unnamed_9.yzw * 2.0f.xxx) + (-1.0f).xxx;
				fragment_unnamed_103.x = dot(fragment_unnamed_111, fragment_unnamed_103);
				fragment_unnamed_103.x += (-0.800000011920928955078125f);
				fragment_unnamed_103.x *= 5.000000476837158203125f;
				fragment_unnamed_103.x = clamp(fragment_unnamed_103.x, 0.0f, 1.0f);
				fragment_unnamed_137 = (fragment_unnamed_103.x * (-2.0f)) + 3.0f;
				fragment_unnamed_103.x *= fragment_unnamed_103.x;
				fragment_unnamed_103.x *= fragment_unnamed_137;
				fragment_unnamed_9.x = (fragment_unnamed_73.x * fragment_unnamed_103.x) + fragment_unnamed_9.x;
				float2 fragment_unnamed_166 = -fragment_unnamed_53.yx;
				fragment_unnamed_53 = float4(fragment_unnamed_53.x, fragment_unnamed_53.y, fragment_unnamed_166.x, fragment_unnamed_166.y);
				fragment_unnamed_169 = fragment_unnamed_53.xzwy + fragment_input_0.xyxy;
				fragment_unnamed_169 = clamp(fragment_unnamed_169, 0.0f.xxxx, 1.0f.xxxx);
				float2 fragment_unnamed_182 = fragment_unnamed_53.xy + fragment_input_0;
				fragment_unnamed_53 = float4(fragment_unnamed_182.x, fragment_unnamed_182.y, fragment_unnamed_53.z, fragment_unnamed_53.w);
				float2 fragment_unnamed_189 = clamp(fragment_unnamed_53.xy, 0.0f.xx, 1.0f.xx);
				fragment_unnamed_53 = float4(fragment_unnamed_189.x, fragment_unnamed_189.y, fragment_unnamed_53.z, fragment_unnamed_53.w);
				float2 fragment_unnamed_197 = fragment_unnamed_53.xy * _RenderViewportScaleFactor.xx;
				fragment_unnamed_53 = float4(fragment_unnamed_197.x, fragment_unnamed_197.y, fragment_unnamed_53.z, fragment_unnamed_53.w);
				fragment_unnamed_53 = _SAOcclusionTexture.Sample(sampler_SAOcclusionTexture, fragment_unnamed_53.xy);
				fragment_unnamed_169 *= _RenderViewportScaleFactor.xxxx;
				fragment_unnamed_211 = _SAOcclusionTexture.Sample(sampler_SAOcclusionTexture, fragment_unnamed_169.xy);
				fragment_unnamed_169 = _SAOcclusionTexture.Sample(sampler_SAOcclusionTexture, fragment_unnamed_169.zw);
				float3 fragment_unnamed_227 = (fragment_unnamed_211.yzw * 2.0f.xxx) + (-1.0f).xxx;
				fragment_unnamed_73 = float4(fragment_unnamed_227.x, fragment_unnamed_73.y, fragment_unnamed_227.y, fragment_unnamed_227.z);
				fragment_unnamed_73.x = dot(fragment_unnamed_111, fragment_unnamed_73.xzw);
				fragment_unnamed_73.x += (-0.800000011920928955078125f);
				fragment_unnamed_73.x *= 5.000000476837158203125f;
				fragment_unnamed_73.x = clamp(fragment_unnamed_73.x, 0.0f, 1.0f);
				fragment_unnamed_137 = (fragment_unnamed_73.x * (-2.0f)) + 3.0f;
				fragment_unnamed_73.x *= fragment_unnamed_73.x;
				fragment_unnamed_257 = fragment_unnamed_73.x * fragment_unnamed_137;
				fragment_unnamed_73.x = (fragment_unnamed_137 * fragment_unnamed_73.x) + fragment_unnamed_103.x;
				fragment_unnamed_9.x = (fragment_unnamed_211.x * fragment_unnamed_257) + fragment_unnamed_9.x;
				fragment_unnamed_103 = (fragment_unnamed_169.yzw * 2.0f.xxx) + (-1.0f).xxx;
				fragment_unnamed_103.x = dot(fragment_unnamed_111, fragment_unnamed_103);
				fragment_unnamed_103.x += (-0.800000011920928955078125f);
				fragment_unnamed_103.x *= 5.000000476837158203125f;
				fragment_unnamed_103.x = clamp(fragment_unnamed_103.x, 0.0f, 1.0f);
				fragment_unnamed_137 = (fragment_unnamed_103.x * (-2.0f)) + 3.0f;
				fragment_unnamed_103.x *= fragment_unnamed_103.x;
				fragment_unnamed_257 = fragment_unnamed_103.x * fragment_unnamed_137;
				fragment_unnamed_73.x = (fragment_unnamed_137 * fragment_unnamed_103.x) + fragment_unnamed_73.x;
				fragment_unnamed_9.x = (fragment_unnamed_169.x * fragment_unnamed_257) + fragment_unnamed_9.x;
				fragment_unnamed_328 = (fragment_unnamed_53.yzw * 2.0f.xxx) + (-1.0f).xxx;
				fragment_unnamed_111.x = dot(fragment_unnamed_111, fragment_unnamed_328);
				fragment_unnamed_111.x += (-0.800000011920928955078125f);
				fragment_unnamed_111.x *= 5.000000476837158203125f;
				fragment_unnamed_111.x = clamp(fragment_unnamed_111.x, 0.0f, 1.0f);
				fragment_unnamed_349 = (fragment_unnamed_111.x * (-2.0f)) + 3.0f;
				fragment_unnamed_111.x *= fragment_unnamed_111.x;
				fragment_unnamed_360 = fragment_unnamed_111.x * fragment_unnamed_349;
				fragment_unnamed_111.x = (fragment_unnamed_349 * fragment_unnamed_111.x) + fragment_unnamed_73.x;
				fragment_unnamed_111.x += 1.0f;
				fragment_unnamed_9.x = (fragment_unnamed_53.x * fragment_unnamed_360) + fragment_unnamed_9.x;
				fragment_unnamed_9.x /= fragment_unnamed_111.x;
				fragment_output_0.w = fragment_unnamed_9.x;
				fragment_unnamed_9.x = fragment_unnamed_9.x;
				fragment_unnamed_9.x = clamp(fragment_unnamed_9.x, 0.0f, 1.0f);
				fragment_unnamed_9.x = (-fragment_unnamed_9.x) + 1.0f;
				fragment_output_0 = float4(0.0f.xxx.x, 0.0f.xxx.y, 0.0f.xxx.z, fragment_output_0.w);
				fragment_unnamed_111.x = max(fragment_unnamed_9.x, 1.1920928955078125e-07f);
				fragment_unnamed_9.y = log2(fragment_unnamed_111.x);
				float2 fragment_unnamed_428 = fragment_unnamed_9.yx * float2(0.4166666567325592041015625f, 12.9200000762939453125f);
				fragment_unnamed_111 = float3(fragment_unnamed_428.x, fragment_unnamed_428.y, fragment_unnamed_111.z);
				fragment_unnamed_111.x = exp2(fragment_unnamed_111.x);
				fragment_unnamed_111.x = (fragment_unnamed_111.x * 1.05499994754791259765625f) + (-0.054999999701976776123046875f);
				fragment_unnamed_444 = 0.003130800090730190277099609375f >= fragment_unnamed_9.x;
				float fragment_unnamed_451;
				if (fragment_unnamed_444)
				{
					fragment_unnamed_451 = fragment_unnamed_111.y;
				}
				else
				{
					fragment_unnamed_451 = fragment_unnamed_111.x;
				}
				fragment_unnamed_9.x = fragment_unnamed_451;
				fragment_unnamed_9.x = max(fragment_unnamed_9.x, 0.0f);
				fragment_unnamed_9.x = (-fragment_unnamed_9.x) + 1.0f;
				float3 fragment_unnamed_477 = fragment_unnamed_9.xxx * _AOColor;
				fragment_output_1 = float4(fragment_unnamed_477.x, fragment_unnamed_477.y, fragment_unnamed_477.z, fragment_output_1.w);
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


			float4 _ScreenParams;
			float _RenderViewportScaleFactor;
			float4 _AOParams;
			float3 _AOColor;

			static float4 fragment_uniform_buffer_0[33];
			Texture2D<float4> _SAOcclusionTexture;
			SamplerState sampler_SAOcclusionTexture;

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
				precise float fragment_unnamed_47 = clamp(fragment_input_1.x, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_48 = clamp(fragment_input_1.y, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_51 = _SAOcclusionTexture.Sample(sampler_SAOcclusionTexture, float2(fragment_unnamed_47, fragment_unnamed_48));
				precise float fragment_unnamed_62 = fragment_uniform_buffer_0[22u].z + (-1.0f);
				precise float fragment_unnamed_64 = fragment_uniform_buffer_0[22u].w + (-1.0f);
				precise float fragment_unnamed_69 = fragment_unnamed_62 / fragment_uniform_buffer_0[31u].z;
				precise float fragment_unnamed_70 = fragment_unnamed_64 / fragment_uniform_buffer_0[31u].z;
				precise float fragment_unnamed_71 = (-0.0f) - fragment_unnamed_69;
				precise float fragment_unnamed_73 = (-0.0f) - fragment_unnamed_70;
				precise float fragment_unnamed_78 = fragment_unnamed_71 + fragment_input_1.x;
				precise float fragment_unnamed_79 = fragment_unnamed_73 + fragment_input_1.y;
				precise float fragment_unnamed_85 = clamp(fragment_unnamed_78, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_86 = clamp(fragment_unnamed_79, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_87 = _SAOcclusionTexture.Sample(sampler_SAOcclusionTexture, float2(fragment_unnamed_85, fragment_unnamed_86));
				float fragment_unnamed_97 = mad(fragment_unnamed_51.y, 2.0f, -1.0f);
				float fragment_unnamed_98 = mad(fragment_unnamed_51.z, 2.0f, -1.0f);
				float fragment_unnamed_99 = mad(fragment_unnamed_51.w, 2.0f, -1.0f);
				precise float fragment_unnamed_104 = dot(float3(fragment_unnamed_97, fragment_unnamed_98, fragment_unnamed_99), float3(mad(fragment_unnamed_87.y, 2.0f, -1.0f), mad(fragment_unnamed_87.z, 2.0f, -1.0f), mad(fragment_unnamed_87.w, 2.0f, -1.0f))) + (-0.800000011920928955078125f);
				precise float fragment_unnamed_106 = fragment_unnamed_104 * 5.000000476837158203125f;
				float fragment_unnamed_108 = clamp(fragment_unnamed_106, 0.0f, 1.0f);
				precise float fragment_unnamed_112 = fragment_unnamed_108 * fragment_unnamed_108;
				precise float fragment_unnamed_113 = fragment_unnamed_112 * mad(fragment_unnamed_108, -2.0f, 3.0f);
				precise float fragment_unnamed_115 = (-0.0f) - fragment_unnamed_70;
				precise float fragment_unnamed_116 = (-0.0f) - fragment_unnamed_69;
				precise float fragment_unnamed_121 = fragment_unnamed_69 + fragment_input_1.x;
				precise float fragment_unnamed_122 = fragment_unnamed_115 + fragment_input_1.y;
				precise float fragment_unnamed_123 = fragment_unnamed_116 + fragment_input_1.x;
				precise float fragment_unnamed_124 = fragment_unnamed_70 + fragment_input_1.y;
				precise float fragment_unnamed_133 = fragment_unnamed_69 + fragment_input_1.x;
				precise float fragment_unnamed_134 = fragment_unnamed_70 + fragment_input_1.y;
				precise float fragment_unnamed_140 = clamp(fragment_unnamed_133, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_141 = clamp(fragment_unnamed_134, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_142 = _SAOcclusionTexture.Sample(sampler_SAOcclusionTexture, float2(fragment_unnamed_140, fragment_unnamed_141));
				precise float fragment_unnamed_151 = clamp(fragment_unnamed_121, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_152 = clamp(fragment_unnamed_122, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_153 = clamp(fragment_unnamed_123, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_154 = clamp(fragment_unnamed_124, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_155 = _SAOcclusionTexture.Sample(sampler_SAOcclusionTexture, float2(fragment_unnamed_151, fragment_unnamed_152));
				float4 fragment_unnamed_161 = _SAOcclusionTexture.Sample(sampler_SAOcclusionTexture, float2(fragment_unnamed_153, fragment_unnamed_154));
				precise float fragment_unnamed_173 = dot(float3(fragment_unnamed_97, fragment_unnamed_98, fragment_unnamed_99), float3(mad(fragment_unnamed_155.y, 2.0f, -1.0f), mad(fragment_unnamed_155.z, 2.0f, -1.0f), mad(fragment_unnamed_155.w, 2.0f, -1.0f))) + (-0.800000011920928955078125f);
				precise float fragment_unnamed_174 = fragment_unnamed_173 * 5.000000476837158203125f;
				float fragment_unnamed_175 = clamp(fragment_unnamed_174, 0.0f, 1.0f);
				float fragment_unnamed_176 = mad(fragment_unnamed_175, -2.0f, 3.0f);
				precise float fragment_unnamed_177 = fragment_unnamed_175 * fragment_unnamed_175;
				precise float fragment_unnamed_178 = fragment_unnamed_177 * fragment_unnamed_176;
				precise float fragment_unnamed_187 = dot(float3(fragment_unnamed_97, fragment_unnamed_98, fragment_unnamed_99), float3(mad(fragment_unnamed_161.y, 2.0f, -1.0f), mad(fragment_unnamed_161.z, 2.0f, -1.0f), mad(fragment_unnamed_161.w, 2.0f, -1.0f))) + (-0.800000011920928955078125f);
				precise float fragment_unnamed_188 = fragment_unnamed_187 * 5.000000476837158203125f;
				float fragment_unnamed_189 = clamp(fragment_unnamed_188, 0.0f, 1.0f);
				float fragment_unnamed_190 = mad(fragment_unnamed_189, -2.0f, 3.0f);
				precise float fragment_unnamed_191 = fragment_unnamed_189 * fragment_unnamed_189;
				precise float fragment_unnamed_192 = fragment_unnamed_191 * fragment_unnamed_190;
				precise float fragment_unnamed_201 = dot(float3(fragment_unnamed_97, fragment_unnamed_98, fragment_unnamed_99), float3(mad(fragment_unnamed_142.y, 2.0f, -1.0f), mad(fragment_unnamed_142.z, 2.0f, -1.0f), mad(fragment_unnamed_142.w, 2.0f, -1.0f))) + (-0.800000011920928955078125f);
				precise float fragment_unnamed_202 = fragment_unnamed_201 * 5.000000476837158203125f;
				float fragment_unnamed_203 = clamp(fragment_unnamed_202, 0.0f, 1.0f);
				float fragment_unnamed_204 = mad(fragment_unnamed_203, -2.0f, 3.0f);
				precise float fragment_unnamed_205 = fragment_unnamed_203 * fragment_unnamed_203;
				precise float fragment_unnamed_206 = fragment_unnamed_205 * fragment_unnamed_204;
				precise float fragment_unnamed_208 = mad(fragment_unnamed_204, fragment_unnamed_205, mad(fragment_unnamed_190, fragment_unnamed_191, mad(fragment_unnamed_176, fragment_unnamed_177, fragment_unnamed_113))) + 1.0f;
				precise float fragment_unnamed_210 = mad(fragment_unnamed_142.x, fragment_unnamed_206, mad(fragment_unnamed_161.x, fragment_unnamed_192, mad(fragment_unnamed_155.x, fragment_unnamed_178, mad(fragment_unnamed_87.x, fragment_unnamed_113, fragment_unnamed_51.x)))) / fragment_unnamed_208;
				fragment_output_0.w = fragment_unnamed_210;
				precise float fragment_unnamed_215 = (-0.0f) - clamp(fragment_unnamed_210, 0.0f, 1.0f);
				precise float fragment_unnamed_216 = fragment_unnamed_215 + 1.0f;
				fragment_output_0.x = 0.0f;
				fragment_output_0.y = 0.0f;
				fragment_output_0.z = 0.0f;
				precise float fragment_unnamed_224 = log2(max(fragment_unnamed_216, 1.1920928955078125e-07f)) * 0.4166666567325592041015625f;
				precise float fragment_unnamed_226 = fragment_unnamed_216 * 12.9200000762939453125f;
				precise float fragment_unnamed_240 = (-0.0f) - max(asfloat((0.003130800090730190277099609375f >= fragment_unnamed_216) ? asuint(fragment_unnamed_226) : asuint(mad(exp2(fragment_unnamed_224), 1.05499994754791259765625f, -0.054999999701976776123046875f))), 0.0f);
				precise float fragment_unnamed_241 = fragment_unnamed_240 + 1.0f;
				precise float fragment_unnamed_248 = fragment_unnamed_241 * fragment_uniform_buffer_0[32u].x;
				precise float fragment_unnamed_249 = fragment_unnamed_241 * fragment_uniform_buffer_0[32u].y;
				precise float fragment_unnamed_250 = fragment_unnamed_241 * fragment_uniform_buffer_0[32u].z;
				fragment_output_1.x = fragment_unnamed_248;
				fragment_output_1.y = fragment_unnamed_249;
				fragment_output_1.z = fragment_unnamed_250;
				fragment_output_1.w = 0.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[22] = float4(_ScreenParams[0], _ScreenParams[1], _ScreenParams[2], _ScreenParams[3]);

				fragment_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, fragment_uniform_buffer_0[26][1], fragment_uniform_buffer_0[26][2], fragment_uniform_buffer_0[26][3]);

				fragment_uniform_buffer_0[31] = float4(_AOParams[0], _AOParams[1], _AOParams[2], _AOParams[3]);

				fragment_uniform_buffer_0[32] = float4(_AOColor[0], _AOColor[1], _AOColor[2], fragment_uniform_buffer_0[32][3]);

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
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 519670

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
			float4 _AOParams;
			float4 _SAOcclusionTexture_TexelSize;

			Texture2D<float4> _SAOcclusionTexture;
			SamplerState sampler_SAOcclusionTexture;

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
			static float3 fragment_unnamed_54;
			static float4 fragment_unnamed_63;
			static float4 fragment_unnamed_76;
			static float3 fragment_unnamed_105;
			static float fragment_unnamed_131;
			static float fragment_unnamed_144;
			static float4 fragment_unnamed_168;
			static float4 fragment_unnamed_210;
			static float3 fragment_unnamed_326;
			static float fragment_unnamed_347;
			static float fragment_unnamed_358;
			static bool fragment_unnamed_425;

			void frag_main()
			{
				fragment_unnamed_9 = float4(fragment_input_0.x, fragment_input_0.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
				float2 fragment_unnamed_22 = clamp(fragment_unnamed_9.xy, 0.0f.xx, 1.0f.xx);
				fragment_unnamed_9 = float4(fragment_unnamed_22.x, fragment_unnamed_22.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
				float2 fragment_unnamed_36 = fragment_unnamed_9.xy * _RenderViewportScaleFactor.xx;
				fragment_unnamed_9 = float4(fragment_unnamed_36.x, fragment_unnamed_36.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
				fragment_unnamed_9 = _SAOcclusionTexture.Sample(sampler_SAOcclusionTexture, fragment_unnamed_9.xy);
				fragment_unnamed_54 = (fragment_unnamed_9.yzw * 2.0f.xxx) + (-1.0f).xxx;
				float2 fragment_unnamed_73 = _SAOcclusionTexture_TexelSize.xy / _AOParams.zz;
				fragment_unnamed_63 = float4(fragment_unnamed_73.x, fragment_unnamed_73.y, fragment_unnamed_63.z, fragment_unnamed_63.w);
				float2 fragment_unnamed_81 = (-fragment_unnamed_63.xy) + fragment_input_0;
				fragment_unnamed_76 = float4(fragment_unnamed_81.x, fragment_unnamed_81.y, fragment_unnamed_76.z, fragment_unnamed_76.w);
				float2 fragment_unnamed_88 = clamp(fragment_unnamed_76.xy, 0.0f.xx, 1.0f.xx);
				fragment_unnamed_76 = float4(fragment_unnamed_88.x, fragment_unnamed_88.y, fragment_unnamed_76.z, fragment_unnamed_76.w);
				float2 fragment_unnamed_96 = fragment_unnamed_76.xy * _RenderViewportScaleFactor.xx;
				fragment_unnamed_76 = float4(fragment_unnamed_96.x, fragment_unnamed_96.y, fragment_unnamed_76.z, fragment_unnamed_76.w);
				fragment_unnamed_76 = _SAOcclusionTexture.Sample(sampler_SAOcclusionTexture, fragment_unnamed_76.xy);
				fragment_unnamed_105 = (fragment_unnamed_76.yzw * 2.0f.xxx) + (-1.0f).xxx;
				fragment_unnamed_105.x = dot(fragment_unnamed_54, fragment_unnamed_105);
				fragment_unnamed_105.x += (-0.800000011920928955078125f);
				fragment_unnamed_105.x *= 5.000000476837158203125f;
				fragment_unnamed_105.x = clamp(fragment_unnamed_105.x, 0.0f, 1.0f);
				fragment_unnamed_131 = (fragment_unnamed_105.x * (-2.0f)) + 3.0f;
				fragment_unnamed_105.x *= fragment_unnamed_105.x;
				fragment_unnamed_144 = fragment_unnamed_105.x * fragment_unnamed_131;
				fragment_unnamed_105.x = (fragment_unnamed_131 * fragment_unnamed_105.x) + 1.0f;
				fragment_unnamed_9.x = (fragment_unnamed_76.x * fragment_unnamed_144) + fragment_unnamed_9.x;
				float2 fragment_unnamed_165 = -fragment_unnamed_63.yx;
				fragment_unnamed_63 = float4(fragment_unnamed_63.x, fragment_unnamed_63.y, fragment_unnamed_165.x, fragment_unnamed_165.y);
				fragment_unnamed_168 = fragment_unnamed_63.xzwy + fragment_input_0.xyxy;
				fragment_unnamed_168 = clamp(fragment_unnamed_168, 0.0f.xxxx, 1.0f.xxxx);
				float2 fragment_unnamed_181 = fragment_unnamed_63.xy + fragment_input_0;
				fragment_unnamed_63 = float4(fragment_unnamed_181.x, fragment_unnamed_181.y, fragment_unnamed_63.z, fragment_unnamed_63.w);
				float2 fragment_unnamed_188 = clamp(fragment_unnamed_63.xy, 0.0f.xx, 1.0f.xx);
				fragment_unnamed_63 = float4(fragment_unnamed_188.x, fragment_unnamed_188.y, fragment_unnamed_63.z, fragment_unnamed_63.w);
				float2 fragment_unnamed_196 = fragment_unnamed_63.xy * _RenderViewportScaleFactor.xx;
				fragment_unnamed_63 = float4(fragment_unnamed_196.x, fragment_unnamed_196.y, fragment_unnamed_63.z, fragment_unnamed_63.w);
				fragment_unnamed_63 = _SAOcclusionTexture.Sample(sampler_SAOcclusionTexture, fragment_unnamed_63.xy);
				fragment_unnamed_168 *= _RenderViewportScaleFactor.xxxx;
				fragment_unnamed_210 = _SAOcclusionTexture.Sample(sampler_SAOcclusionTexture, fragment_unnamed_168.xy);
				fragment_unnamed_168 = _SAOcclusionTexture.Sample(sampler_SAOcclusionTexture, fragment_unnamed_168.zw);
				float3 fragment_unnamed_226 = (fragment_unnamed_210.yzw * 2.0f.xxx) + (-1.0f).xxx;
				fragment_unnamed_76 = float4(fragment_unnamed_226.x, fragment_unnamed_76.y, fragment_unnamed_226.y, fragment_unnamed_226.z);
				fragment_unnamed_76.x = dot(fragment_unnamed_54, fragment_unnamed_76.xzw);
				fragment_unnamed_76.x += (-0.800000011920928955078125f);
				fragment_unnamed_76.x *= 5.000000476837158203125f;
				fragment_unnamed_76.x = clamp(fragment_unnamed_76.x, 0.0f, 1.0f);
				fragment_unnamed_131 = (fragment_unnamed_76.x * (-2.0f)) + 3.0f;
				fragment_unnamed_76.x *= fragment_unnamed_76.x;
				fragment_unnamed_144 = fragment_unnamed_76.x * fragment_unnamed_131;
				fragment_unnamed_76.x = (fragment_unnamed_131 * fragment_unnamed_76.x) + fragment_unnamed_105.x;
				fragment_unnamed_9.x = (fragment_unnamed_210.x * fragment_unnamed_144) + fragment_unnamed_9.x;
				fragment_unnamed_105 = (fragment_unnamed_168.yzw * 2.0f.xxx) + (-1.0f).xxx;
				fragment_unnamed_105.x = dot(fragment_unnamed_54, fragment_unnamed_105);
				fragment_unnamed_105.x += (-0.800000011920928955078125f);
				fragment_unnamed_105.x *= 5.000000476837158203125f;
				fragment_unnamed_105.x = clamp(fragment_unnamed_105.x, 0.0f, 1.0f);
				fragment_unnamed_131 = (fragment_unnamed_105.x * (-2.0f)) + 3.0f;
				fragment_unnamed_105.x *= fragment_unnamed_105.x;
				fragment_unnamed_144 = fragment_unnamed_105.x * fragment_unnamed_131;
				fragment_unnamed_76.x = (fragment_unnamed_131 * fragment_unnamed_105.x) + fragment_unnamed_76.x;
				fragment_unnamed_9.x = (fragment_unnamed_168.x * fragment_unnamed_144) + fragment_unnamed_9.x;
				fragment_unnamed_326 = (fragment_unnamed_63.yzw * 2.0f.xxx) + (-1.0f).xxx;
				fragment_unnamed_54.x = dot(fragment_unnamed_54, fragment_unnamed_326);
				fragment_unnamed_54.x += (-0.800000011920928955078125f);
				fragment_unnamed_54.x *= 5.000000476837158203125f;
				fragment_unnamed_54.x = clamp(fragment_unnamed_54.x, 0.0f, 1.0f);
				fragment_unnamed_347 = (fragment_unnamed_54.x * (-2.0f)) + 3.0f;
				fragment_unnamed_54.x *= fragment_unnamed_54.x;
				fragment_unnamed_358 = fragment_unnamed_54.x * fragment_unnamed_347;
				fragment_unnamed_54.x = (fragment_unnamed_347 * fragment_unnamed_54.x) + fragment_unnamed_76.x;
				fragment_unnamed_9.x = (fragment_unnamed_63.x * fragment_unnamed_358) + fragment_unnamed_9.x;
				fragment_unnamed_9.x /= fragment_unnamed_54.x;
				fragment_unnamed_9.x = clamp(fragment_unnamed_9.x, 0.0f, 1.0f);
				fragment_unnamed_9.x = (-fragment_unnamed_9.x) + 1.0f;
				fragment_unnamed_54.x = max(fragment_unnamed_9.x, 1.1920928955078125e-07f);
				fragment_unnamed_9.y = log2(fragment_unnamed_54.x);
				float2 fragment_unnamed_409 = fragment_unnamed_9.yx * float2(0.4166666567325592041015625f, 12.9200000762939453125f);
				fragment_unnamed_54 = float3(fragment_unnamed_409.x, fragment_unnamed_409.y, fragment_unnamed_54.z);
				fragment_unnamed_54.x = exp2(fragment_unnamed_54.x);
				fragment_unnamed_54.x = (fragment_unnamed_54.x * 1.05499994754791259765625f) + (-0.054999999701976776123046875f);
				fragment_unnamed_425 = 0.003130800090730190277099609375f >= fragment_unnamed_9.x;
				float fragment_unnamed_432;
				if (fragment_unnamed_425)
				{
					fragment_unnamed_432 = fragment_unnamed_54.y;
				}
				else
				{
					fragment_unnamed_432 = fragment_unnamed_54.x;
				}
				fragment_unnamed_9.x = fragment_unnamed_432;
				fragment_unnamed_9.x = max(fragment_unnamed_9.x, 0.0f);
				fragment_unnamed_9.x = (-fragment_unnamed_9.x) + 1.0f;
				float3 fragment_unnamed_457 = (-fragment_unnamed_9.xxx) + 1.0f.xxx;
				fragment_output_0 = float4(fragment_unnamed_457.x, fragment_unnamed_457.y, fragment_unnamed_457.z, fragment_output_0.w);
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


			float _RenderViewportScaleFactor;
			float4 _AOParams;
			float4 _SAOcclusionTexture_TexelSize;

			static float4 fragment_uniform_buffer_0[34];
			Texture2D<float4> _SAOcclusionTexture;
			SamplerState sampler_SAOcclusionTexture;

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
				precise float fragment_unnamed_46 = clamp(fragment_input_1.x, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_47 = clamp(fragment_input_1.y, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_50 = _SAOcclusionTexture.Sample(sampler_SAOcclusionTexture, float2(fragment_unnamed_46, fragment_unnamed_47));
				float fragment_unnamed_56 = mad(fragment_unnamed_50.y, 2.0f, -1.0f);
				float fragment_unnamed_59 = mad(fragment_unnamed_50.z, 2.0f, -1.0f);
				float fragment_unnamed_60 = mad(fragment_unnamed_50.w, 2.0f, -1.0f);
				precise float fragment_unnamed_70 = fragment_uniform_buffer_0[33u].x / fragment_uniform_buffer_0[31u].z;
				precise float fragment_unnamed_71 = fragment_uniform_buffer_0[33u].y / fragment_uniform_buffer_0[31u].z;
				precise float fragment_unnamed_72 = (-0.0f) - fragment_unnamed_70;
				precise float fragment_unnamed_74 = (-0.0f) - fragment_unnamed_71;
				precise float fragment_unnamed_79 = fragment_unnamed_72 + fragment_input_1.x;
				precise float fragment_unnamed_80 = fragment_unnamed_74 + fragment_input_1.y;
				precise float fragment_unnamed_86 = clamp(fragment_unnamed_79, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_87 = clamp(fragment_unnamed_80, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_88 = _SAOcclusionTexture.Sample(sampler_SAOcclusionTexture, float2(fragment_unnamed_86, fragment_unnamed_87));
				precise float fragment_unnamed_101 = dot(float3(fragment_unnamed_56, fragment_unnamed_59, fragment_unnamed_60), float3(mad(fragment_unnamed_88.y, 2.0f, -1.0f), mad(fragment_unnamed_88.z, 2.0f, -1.0f), mad(fragment_unnamed_88.w, 2.0f, -1.0f))) + (-0.800000011920928955078125f);
				precise float fragment_unnamed_103 = fragment_unnamed_101 * 5.000000476837158203125f;
				float fragment_unnamed_105 = clamp(fragment_unnamed_103, 0.0f, 1.0f);
				float fragment_unnamed_106 = mad(fragment_unnamed_105, -2.0f, 3.0f);
				precise float fragment_unnamed_109 = fragment_unnamed_105 * fragment_unnamed_105;
				precise float fragment_unnamed_110 = fragment_unnamed_109 * fragment_unnamed_106;
				precise float fragment_unnamed_113 = (-0.0f) - fragment_unnamed_71;
				precise float fragment_unnamed_114 = (-0.0f) - fragment_unnamed_70;
				precise float fragment_unnamed_119 = fragment_unnamed_70 + fragment_input_1.x;
				precise float fragment_unnamed_120 = fragment_unnamed_113 + fragment_input_1.y;
				precise float fragment_unnamed_121 = fragment_unnamed_114 + fragment_input_1.x;
				precise float fragment_unnamed_122 = fragment_unnamed_71 + fragment_input_1.y;
				precise float fragment_unnamed_131 = fragment_unnamed_70 + fragment_input_1.x;
				precise float fragment_unnamed_132 = fragment_unnamed_71 + fragment_input_1.y;
				precise float fragment_unnamed_138 = clamp(fragment_unnamed_131, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_139 = clamp(fragment_unnamed_132, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_140 = _SAOcclusionTexture.Sample(sampler_SAOcclusionTexture, float2(fragment_unnamed_138, fragment_unnamed_139));
				precise float fragment_unnamed_149 = clamp(fragment_unnamed_119, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_150 = clamp(fragment_unnamed_120, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_151 = clamp(fragment_unnamed_121, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_152 = clamp(fragment_unnamed_122, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_153 = _SAOcclusionTexture.Sample(sampler_SAOcclusionTexture, float2(fragment_unnamed_149, fragment_unnamed_150));
				float4 fragment_unnamed_159 = _SAOcclusionTexture.Sample(sampler_SAOcclusionTexture, float2(fragment_unnamed_151, fragment_unnamed_152));
				precise float fragment_unnamed_171 = dot(float3(fragment_unnamed_56, fragment_unnamed_59, fragment_unnamed_60), float3(mad(fragment_unnamed_153.y, 2.0f, -1.0f), mad(fragment_unnamed_153.z, 2.0f, -1.0f), mad(fragment_unnamed_153.w, 2.0f, -1.0f))) + (-0.800000011920928955078125f);
				precise float fragment_unnamed_172 = fragment_unnamed_171 * 5.000000476837158203125f;
				float fragment_unnamed_173 = clamp(fragment_unnamed_172, 0.0f, 1.0f);
				float fragment_unnamed_174 = mad(fragment_unnamed_173, -2.0f, 3.0f);
				precise float fragment_unnamed_175 = fragment_unnamed_173 * fragment_unnamed_173;
				precise float fragment_unnamed_176 = fragment_unnamed_175 * fragment_unnamed_174;
				precise float fragment_unnamed_185 = dot(float3(fragment_unnamed_56, fragment_unnamed_59, fragment_unnamed_60), float3(mad(fragment_unnamed_159.y, 2.0f, -1.0f), mad(fragment_unnamed_159.z, 2.0f, -1.0f), mad(fragment_unnamed_159.w, 2.0f, -1.0f))) + (-0.800000011920928955078125f);
				precise float fragment_unnamed_186 = fragment_unnamed_185 * 5.000000476837158203125f;
				float fragment_unnamed_187 = clamp(fragment_unnamed_186, 0.0f, 1.0f);
				float fragment_unnamed_188 = mad(fragment_unnamed_187, -2.0f, 3.0f);
				precise float fragment_unnamed_189 = fragment_unnamed_187 * fragment_unnamed_187;
				precise float fragment_unnamed_190 = fragment_unnamed_189 * fragment_unnamed_188;
				precise float fragment_unnamed_199 = dot(float3(fragment_unnamed_56, fragment_unnamed_59, fragment_unnamed_60), float3(mad(fragment_unnamed_140.y, 2.0f, -1.0f), mad(fragment_unnamed_140.z, 2.0f, -1.0f), mad(fragment_unnamed_140.w, 2.0f, -1.0f))) + (-0.800000011920928955078125f);
				precise float fragment_unnamed_200 = fragment_unnamed_199 * 5.000000476837158203125f;
				float fragment_unnamed_201 = clamp(fragment_unnamed_200, 0.0f, 1.0f);
				float fragment_unnamed_202 = mad(fragment_unnamed_201, -2.0f, 3.0f);
				precise float fragment_unnamed_203 = fragment_unnamed_201 * fragment_unnamed_201;
				precise float fragment_unnamed_204 = fragment_unnamed_203 * fragment_unnamed_202;
				precise float fragment_unnamed_207 = mad(fragment_unnamed_140.x, fragment_unnamed_204, mad(fragment_unnamed_159.x, fragment_unnamed_190, mad(fragment_unnamed_153.x, fragment_unnamed_176, mad(fragment_unnamed_88.x, fragment_unnamed_110, fragment_unnamed_50.x)))) / mad(fragment_unnamed_202, fragment_unnamed_203, mad(fragment_unnamed_188, fragment_unnamed_189, mad(fragment_unnamed_174, fragment_unnamed_175, mad(fragment_unnamed_106, fragment_unnamed_109, 1.0f))));
				precise float fragment_unnamed_209 = (-0.0f) - clamp(fragment_unnamed_207, 0.0f, 1.0f);
				precise float fragment_unnamed_210 = fragment_unnamed_209 + 1.0f;
				precise float fragment_unnamed_214 = log2(max(fragment_unnamed_210, 1.1920928955078125e-07f)) * 0.4166666567325592041015625f;
				precise float fragment_unnamed_216 = fragment_unnamed_210 * 12.9200000762939453125f;
				precise float fragment_unnamed_230 = (-0.0f) - max(asfloat((0.003130800090730190277099609375f >= fragment_unnamed_210) ? asuint(fragment_unnamed_216) : asuint(mad(exp2(fragment_unnamed_214), 1.05499994754791259765625f, -0.054999999701976776123046875f))), 0.0f);
				precise float fragment_unnamed_231 = fragment_unnamed_230 + 1.0f;
				precise float fragment_unnamed_232 = (-0.0f) - fragment_unnamed_231;
				precise float fragment_unnamed_233 = fragment_unnamed_232 + 1.0f;
				precise float fragment_unnamed_234 = fragment_unnamed_232 + 1.0f;
				precise float fragment_unnamed_235 = fragment_unnamed_232 + 1.0f;
				fragment_output_0.x = fragment_unnamed_233;
				fragment_output_0.y = fragment_unnamed_234;
				fragment_output_0.z = fragment_unnamed_235;
				fragment_output_0.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, fragment_uniform_buffer_0[26][1], fragment_uniform_buffer_0[26][2], fragment_uniform_buffer_0[26][3]);

				fragment_uniform_buffer_0[31] = float4(_AOParams[0], _AOParams[1], _AOParams[2], _AOParams[3]);

				fragment_uniform_buffer_0[33] = float4(_SAOcclusionTexture_TexelSize[0], _SAOcclusionTexture_TexelSize[1], _SAOcclusionTexture_TexelSize[2], _SAOcclusionTexture_TexelSize[3]);

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
