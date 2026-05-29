Shader "Hidden/PostProcessing/TemporalAntialiasing"
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
			GpuProgramID 63221

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

			float _RenderViewportScaleFactor;
			float4 _MainTex_TexelSize;
			float4 _CameraDepthTexture_TexelSize;
			float2 _Jitter;
			float4 _FinalBlendParameters;
			float _Sharpness;

			Texture2D<float4> _CameraDepthTexture;
			SamplerState sampler_CameraDepthTexture;
			Texture2D<float4> _CameraMotionVectorsTexture;
			SamplerState sampler_CameraMotionVectorsTexture;
			Texture2D<float4> _HistoryTex;
			SamplerState sampler_HistoryTex;
			Texture2D<float4> _MainTex;
			SamplerState fragment_unnamed_374;

			static float2 fragment_input_0;
			static float4 fragment_output_0;
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

			static float4 fragment_unnamed_9;
			static float4 fragment_unnamed_63;
			static bool fragment_unnamed_73;
			static float fragment_unnamed_79;
			static float4 fragment_unnamed_110;
			static bool fragment_unnamed_222;
			static float2 fragment_unnamed_228;
			static float3 fragment_unnamed_309;
			static float4 fragment_unnamed_380;
			static float4 fragment_unnamed_389;
			static float4 fragment_unnamed_408;
			static float4 fragment_unnamed_412;

			void frag_main()
			{
				float2 fragment_unnamed_24 = fragment_input_0 + (-_CameraDepthTexture_TexelSize.xy);
				fragment_unnamed_9 = float4(fragment_unnamed_24.x, fragment_unnamed_24.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
				float2 fragment_unnamed_31 = max(fragment_unnamed_9.xy, 0.0f.xx);
				fragment_unnamed_9 = float4(fragment_unnamed_31.x, fragment_unnamed_31.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
				float2 fragment_unnamed_41 = min(fragment_unnamed_9.xy, _RenderViewportScaleFactor.xx);
				fragment_unnamed_9 = float4(fragment_unnamed_41.x, fragment_unnamed_41.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
				fragment_unnamed_9.z = _CameraDepthTexture.Sample(sampler_CameraDepthTexture, fragment_unnamed_9.xy).x;
				fragment_unnamed_63.z = _CameraDepthTexture.Sample(sampler_CameraDepthTexture, fragment_input_0).x;
				fragment_unnamed_73 = fragment_unnamed_9.z >= fragment_unnamed_63.z;
				fragment_unnamed_79 = float(fragment_unnamed_73);
				fragment_unnamed_9.x = -1.0f;
				fragment_unnamed_9.y = -1.0f;
				fragment_unnamed_63.x = 0.0f;
				fragment_unnamed_63.y = 0.0f;
				float3 fragment_unnamed_95 = fragment_unnamed_9.xyz + (-fragment_unnamed_63.yyz);
				fragment_unnamed_9 = float4(fragment_unnamed_95.x, fragment_unnamed_95.y, fragment_unnamed_95.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_105 = (fragment_unnamed_79.xxx * fragment_unnamed_9.xyz) + fragment_unnamed_63.xyz;
				fragment_unnamed_9 = float4(fragment_unnamed_105.x, fragment_unnamed_105.y, fragment_unnamed_105.z, fragment_unnamed_9.w);
				fragment_unnamed_63.x = 1.0f;
				fragment_unnamed_63.y = -1.0f;
				fragment_unnamed_110 = (_CameraDepthTexture_TexelSize.xyxy * float4(1.0f, -1.0f, -1.0f, 1.0f)) + fragment_input_0.xyxy;
				fragment_unnamed_110 = max(fragment_unnamed_110, 0.0f.xxxx);
				fragment_unnamed_110 = min(fragment_unnamed_110, _RenderViewportScaleFactor.xxxx);
				fragment_unnamed_63.z = _CameraDepthTexture.Sample(sampler_CameraDepthTexture, fragment_unnamed_110.xy).x;
				fragment_unnamed_110.z = _CameraDepthTexture.Sample(sampler_CameraDepthTexture, fragment_unnamed_110.zw).x;
				fragment_unnamed_73 = fragment_unnamed_63.z >= fragment_unnamed_9.z;
				fragment_unnamed_79 = float(fragment_unnamed_73);
				float3 fragment_unnamed_155 = (-fragment_unnamed_9.yyz) + fragment_unnamed_63.xyz;
				fragment_unnamed_63 = float4(fragment_unnamed_155.x, fragment_unnamed_155.y, fragment_unnamed_155.z, fragment_unnamed_63.w);
				float3 fragment_unnamed_165 = (fragment_unnamed_79.xxx * fragment_unnamed_63.xyz) + fragment_unnamed_9.xyz;
				fragment_unnamed_9 = float4(fragment_unnamed_165.x, fragment_unnamed_165.y, fragment_unnamed_165.z, fragment_unnamed_9.w);
				fragment_unnamed_110.x = -1.0f;
				fragment_unnamed_110.y = 1.0f;
				fragment_unnamed_73 = fragment_unnamed_110.z >= fragment_unnamed_9.z;
				fragment_unnamed_79 = float(fragment_unnamed_73);
				float3 fragment_unnamed_182 = (-fragment_unnamed_9.xyz) + fragment_unnamed_110.xyz;
				fragment_unnamed_63 = float4(fragment_unnamed_182.x, fragment_unnamed_182.y, fragment_unnamed_182.z, fragment_unnamed_63.w);
				float3 fragment_unnamed_192 = (fragment_unnamed_79.xxx * fragment_unnamed_63.xyz) + fragment_unnamed_9.xyz;
				fragment_unnamed_9 = float4(fragment_unnamed_192.x, fragment_unnamed_192.y, fragment_unnamed_192.z, fragment_unnamed_9.w);
				float2 fragment_unnamed_199 = fragment_input_0 + _CameraDepthTexture_TexelSize.xy;
				fragment_unnamed_63 = float4(fragment_unnamed_199.x, fragment_unnamed_199.y, fragment_unnamed_63.z, fragment_unnamed_63.w);
				float2 fragment_unnamed_204 = max(fragment_unnamed_63.xy, 0.0f.xx);
				fragment_unnamed_63 = float4(fragment_unnamed_204.x, fragment_unnamed_204.y, fragment_unnamed_63.z, fragment_unnamed_63.w);
				float2 fragment_unnamed_212 = min(fragment_unnamed_63.xy, _RenderViewportScaleFactor.xx);
				fragment_unnamed_63 = float4(fragment_unnamed_212.x, fragment_unnamed_212.y, fragment_unnamed_63.z, fragment_unnamed_63.w);
				fragment_unnamed_79 = _CameraDepthTexture.Sample(sampler_CameraDepthTexture, fragment_unnamed_63.xy).x;
				fragment_unnamed_222 = fragment_unnamed_79 >= fragment_unnamed_9.z;
				fragment_unnamed_228.x = float(fragment_unnamed_222);
				float2 fragment_unnamed_236 = (-fragment_unnamed_9.xy) + 1.0f.xx;
				fragment_unnamed_63 = float4(fragment_unnamed_236.x, fragment_unnamed_236.y, fragment_unnamed_63.z, fragment_unnamed_63.w);
				float2 fragment_unnamed_246 = (fragment_unnamed_228.xx * fragment_unnamed_63.xy) + fragment_unnamed_9.xy;
				fragment_unnamed_9 = float4(fragment_unnamed_246.x, fragment_unnamed_246.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
				float2 fragment_unnamed_256 = (fragment_unnamed_9.xy * _CameraDepthTexture_TexelSize.xy) + fragment_input_0;
				fragment_unnamed_9 = float4(fragment_unnamed_256.x, fragment_unnamed_256.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
				float2 fragment_unnamed_267 = _CameraMotionVectorsTexture.Sample(sampler_CameraMotionVectorsTexture, fragment_unnamed_9.xy).xy;
				fragment_unnamed_9 = float4(fragment_unnamed_267.x, fragment_unnamed_267.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
				fragment_unnamed_228.x = dot(fragment_unnamed_9.xy, fragment_unnamed_9.xy);
				float2 fragment_unnamed_280 = (-fragment_unnamed_9.xy) + fragment_input_0;
				fragment_unnamed_9 = float4(fragment_unnamed_280.x, fragment_unnamed_280.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
				float2 fragment_unnamed_285 = max(fragment_unnamed_9.xy, 0.0f.xx);
				fragment_unnamed_9 = float4(fragment_unnamed_285.x, fragment_unnamed_285.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
				float2 fragment_unnamed_293 = min(fragment_unnamed_9.xy, _RenderViewportScaleFactor.xx);
				fragment_unnamed_9 = float4(fragment_unnamed_293.x, fragment_unnamed_293.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
				fragment_unnamed_63 = _HistoryTex.Sample(sampler_HistoryTex, fragment_unnamed_9.xy);
				fragment_unnamed_9.x = sqrt(fragment_unnamed_228.x);
				fragment_unnamed_309.x = fragment_unnamed_9.x * 100.0f;
				fragment_unnamed_9.x *= _FinalBlendParameters.z;
				fragment_unnamed_309.x = min(fragment_unnamed_309.x, 1.0f);
				fragment_unnamed_309.x = (fragment_unnamed_309.x * (-3.75f)) + 4.0f;
				fragment_unnamed_228 = fragment_input_0 + (-_Jitter);
				fragment_unnamed_228 = max(fragment_unnamed_228, 0.0f.xx);
				fragment_unnamed_228 = min(fragment_unnamed_228, _RenderViewportScaleFactor.xx);
				float2 fragment_unnamed_356 = ((-_MainTex_TexelSize.xy) * 0.5f.xx) + fragment_unnamed_228;
				fragment_unnamed_110 = float4(fragment_unnamed_356.x, fragment_unnamed_356.y, fragment_unnamed_110.z, fragment_unnamed_110.w);
				float2 fragment_unnamed_361 = max(fragment_unnamed_110.xy, 0.0f.xx);
				fragment_unnamed_110 = float4(fragment_unnamed_361.x, fragment_unnamed_361.y, fragment_unnamed_110.z, fragment_unnamed_110.w);
				float2 fragment_unnamed_369 = min(fragment_unnamed_110.xy, _RenderViewportScaleFactor.xx);
				fragment_unnamed_110 = float4(fragment_unnamed_369.x, fragment_unnamed_369.y, fragment_unnamed_110.z, fragment_unnamed_110.w);
				fragment_unnamed_110 = _MainTex.Sample(fragment_unnamed_374, fragment_unnamed_110.xy);
				float2 fragment_unnamed_386 = (_MainTex_TexelSize.xy * 0.5f.xx) + fragment_unnamed_228;
				fragment_unnamed_380 = float4(fragment_unnamed_386.x, fragment_unnamed_386.y, fragment_unnamed_380.z, fragment_unnamed_380.w);
				fragment_unnamed_389 = _MainTex.Sample(fragment_unnamed_374, fragment_unnamed_228);
				fragment_unnamed_228 = max(fragment_unnamed_380.xy, 0.0f.xx);
				fragment_unnamed_228 = min(fragment_unnamed_228, _RenderViewportScaleFactor.xx);
				fragment_unnamed_380 = _MainTex.Sample(fragment_unnamed_374, fragment_unnamed_228);
				fragment_unnamed_408 = fragment_unnamed_110 + fragment_unnamed_380;
				fragment_unnamed_412 = fragment_unnamed_389 + fragment_unnamed_389;
				fragment_unnamed_408 = (fragment_unnamed_408 * 4.0f.xxxx) + (-fragment_unnamed_412);
				fragment_unnamed_412 = ((-fragment_unnamed_408) * 0.16666699945926666259765625f.xxxx) + fragment_unnamed_389;
				fragment_unnamed_412 *= _Sharpness.xxxx;
				fragment_unnamed_389 = (fragment_unnamed_412 * 2.7182819843292236328125f.xxxx) + fragment_unnamed_389;
				fragment_unnamed_389 = max(fragment_unnamed_389, 0.0f.xxxx);
				fragment_unnamed_389 = min(fragment_unnamed_389, 65472.0f.xxxx);
				float3 fragment_unnamed_451 = fragment_unnamed_389.xyz + fragment_unnamed_408.xyz;
				fragment_unnamed_408 = float4(fragment_unnamed_451.x, fragment_unnamed_451.y, fragment_unnamed_451.z, fragment_unnamed_408.w);
				float3 fragment_unnamed_458 = fragment_unnamed_408.xyz * 0.14285700023174285888671875f.xxx;
				fragment_unnamed_408 = float4(fragment_unnamed_458.x, fragment_unnamed_458.y, fragment_unnamed_458.z, fragment_unnamed_408.w);
				fragment_unnamed_228.x = dot(fragment_unnamed_408.xyz, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f));
				fragment_unnamed_79 = dot(fragment_unnamed_389.xyz, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f));
				fragment_unnamed_228.x = (-fragment_unnamed_79) + fragment_unnamed_228.x;
				float3 fragment_unnamed_482 = min(fragment_unnamed_110.xyz, fragment_unnamed_380.xyz);
				fragment_unnamed_408 = float4(fragment_unnamed_482.x, fragment_unnamed_482.y, fragment_unnamed_482.z, fragment_unnamed_408.w);
				float3 fragment_unnamed_489 = max(fragment_unnamed_110.xyz, fragment_unnamed_380.xyz);
				fragment_unnamed_110 = float4(fragment_unnamed_489.x, fragment_unnamed_489.y, fragment_unnamed_489.z, fragment_unnamed_110.w);
				float3 fragment_unnamed_500 = (fragment_unnamed_309.xxx * abs(fragment_unnamed_228.xxx)) + fragment_unnamed_110.xyz;
				fragment_unnamed_110 = float4(fragment_unnamed_500.x, fragment_unnamed_500.y, fragment_unnamed_500.z, fragment_unnamed_110.w);
				fragment_unnamed_309 = ((-fragment_unnamed_309.xxx) * abs(fragment_unnamed_228.xxx)) + fragment_unnamed_408.xyz;
				float3 fragment_unnamed_517 = (-fragment_unnamed_309) + fragment_unnamed_110.xyz;
				fragment_unnamed_380 = float4(fragment_unnamed_517.x, fragment_unnamed_517.y, fragment_unnamed_517.z, fragment_unnamed_380.w);
				fragment_unnamed_309 += fragment_unnamed_110.xyz;
				float3 fragment_unnamed_527 = fragment_unnamed_380.xyz * 0.5f.xxx;
				fragment_unnamed_110 = float4(fragment_unnamed_527.x, fragment_unnamed_527.y, fragment_unnamed_527.z, fragment_unnamed_110.w);
				float3 fragment_unnamed_535 = ((-fragment_unnamed_309) * 0.5f.xxx) + fragment_unnamed_63.xyz;
				fragment_unnamed_380 = float4(fragment_unnamed_535.x, fragment_unnamed_535.y, fragment_unnamed_535.z, fragment_unnamed_380.w);
				fragment_unnamed_309 *= 0.5f.xxx;
				float3 fragment_unnamed_544 = fragment_unnamed_380.xyz + 9.9999997473787516355514526367188e-05f.xxx;
				fragment_unnamed_408 = float4(fragment_unnamed_544.x, fragment_unnamed_544.y, fragment_unnamed_544.z, fragment_unnamed_408.w);
				float3 fragment_unnamed_551 = fragment_unnamed_110.xyz / fragment_unnamed_408.xyz;
				fragment_unnamed_110 = float4(fragment_unnamed_551.x, fragment_unnamed_551.y, fragment_unnamed_551.z, fragment_unnamed_110.w);
				fragment_unnamed_110.x = min(abs(fragment_unnamed_110.y), abs(fragment_unnamed_110.x));
				fragment_unnamed_110.x = min(abs(fragment_unnamed_110.z), fragment_unnamed_110.x);
				fragment_unnamed_110.x = min(fragment_unnamed_110.x, 1.0f);
				float3 fragment_unnamed_579 = (fragment_unnamed_380.xyz * fragment_unnamed_110.xxx) + fragment_unnamed_309;
				fragment_unnamed_63 = float4(fragment_unnamed_579.x, fragment_unnamed_579.y, fragment_unnamed_579.z, fragment_unnamed_63.w);
				fragment_unnamed_63 = (-fragment_unnamed_389) + fragment_unnamed_63;
				fragment_unnamed_309.x = (-_FinalBlendParameters.x) + _FinalBlendParameters.y;
				fragment_unnamed_9.x = (fragment_unnamed_9.x * fragment_unnamed_309.x) + _FinalBlendParameters.x;
				fragment_unnamed_9.x = max(fragment_unnamed_9.x, _FinalBlendParameters.y);
				fragment_unnamed_9.x = min(fragment_unnamed_9.x, _FinalBlendParameters.x);
				fragment_unnamed_9 = (fragment_unnamed_9.xxxx * fragment_unnamed_63) + fragment_unnamed_389;
				fragment_unnamed_9 = max(fragment_unnamed_9, 0.0f.xxxx);
				fragment_unnamed_9 = min(fragment_unnamed_9, 65472.0f.xxxx);
				fragment_output_0 = fragment_unnamed_9;
				fragment_output_1 = fragment_unnamed_9;
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


			float _RenderViewportScaleFactor;
			float4 _MainTex_TexelSize;
			float4 _CameraDepthTexture_TexelSize;
			float2 _Jitter;
			float4 _FinalBlendParameters;
			float _Sharpness;

			static float4 fragment_uniform_buffer_0[33];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _HistoryTex;
			Texture2D<float4> _CameraDepthTexture;
			Texture2D<float4> _CameraMotionVectorsTexture;
			SamplerState S0;
			SamplerState sampler_HistoryTex;
			SamplerState sampler_CameraDepthTexture;
			SamplerState sampler_CameraMotionVectorsTexture;

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
				precise float fragment_unnamed_54 = (-0.0f) - fragment_uniform_buffer_0[29u].x;
				precise float fragment_unnamed_57 = (-0.0f) - fragment_uniform_buffer_0[29u].y;
				precise float fragment_unnamed_58 = fragment_input_1.x + fragment_unnamed_54;
				precise float fragment_unnamed_59 = fragment_input_1.y + fragment_unnamed_57;
				float4 fragment_unnamed_72 = _CameraDepthTexture.Sample(sampler_CameraDepthTexture, float2(min(max(fragment_unnamed_58, 0.0f), fragment_uniform_buffer_0[26u].x), min(max(fragment_unnamed_59, 0.0f), fragment_uniform_buffer_0[26u].x)));
				float fragment_unnamed_74 = fragment_unnamed_72.x;
				float4 fragment_unnamed_79 = _CameraDepthTexture.Sample(sampler_CameraDepthTexture, float2(fragment_input_1.x, fragment_input_1.y));
				float fragment_unnamed_81 = fragment_unnamed_79.x;
				float fragment_unnamed_88 = asfloat(((fragment_unnamed_74 >= fragment_unnamed_81) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_93 = asfloat(0u);
				precise float fragment_unnamed_94 = (-0.0f) - fragment_unnamed_93;
				precise float fragment_unnamed_95 = (-0.0f) - fragment_unnamed_81;
				precise float fragment_unnamed_96 = asfloat(3212836864u) + fragment_unnamed_94;
				precise float fragment_unnamed_97 = asfloat(3212836864u) + fragment_unnamed_94;
				precise float fragment_unnamed_98 = fragment_unnamed_74 + fragment_unnamed_95;
				float fragment_unnamed_100 = mad(fragment_unnamed_88, fragment_unnamed_97, fragment_unnamed_93);
				float fragment_unnamed_101 = mad(fragment_unnamed_88, fragment_unnamed_98, fragment_unnamed_81);
				float4 fragment_unnamed_129 = _CameraDepthTexture.Sample(sampler_CameraDepthTexture, float2(min(max(mad(fragment_uniform_buffer_0[29u].x, 1.0f, fragment_input_1.x), 0.0f), fragment_uniform_buffer_0[26u].x), min(max(mad(fragment_uniform_buffer_0[29u].y, -1.0f, fragment_input_1.y), 0.0f), fragment_uniform_buffer_0[26u].x)));
				float fragment_unnamed_131 = fragment_unnamed_129.x;
				float4 fragment_unnamed_132 = _CameraDepthTexture.Sample(sampler_CameraDepthTexture, float2(min(max(mad(fragment_uniform_buffer_0[29u].x, -1.0f, fragment_input_1.x), 0.0f), fragment_uniform_buffer_0[26u].x), min(max(mad(fragment_uniform_buffer_0[29u].y, 1.0f, fragment_input_1.y), 0.0f), fragment_uniform_buffer_0[26u].x)));
				float fragment_unnamed_134 = fragment_unnamed_132.x;
				float fragment_unnamed_138 = asfloat(((fragment_unnamed_131 >= fragment_unnamed_101) ? 4294967295u : 0u) & 1065353216u);
				precise float fragment_unnamed_139 = (-0.0f) - fragment_unnamed_100;
				precise float fragment_unnamed_140 = (-0.0f) - fragment_unnamed_101;
				precise float fragment_unnamed_141 = fragment_unnamed_139 + asfloat(1065353216u);
				precise float fragment_unnamed_142 = fragment_unnamed_139 + asfloat(3212836864u);
				precise float fragment_unnamed_143 = fragment_unnamed_140 + fragment_unnamed_131;
				float fragment_unnamed_144 = mad(fragment_unnamed_138, fragment_unnamed_141, mad(fragment_unnamed_88, fragment_unnamed_96, asfloat(0u)));
				float fragment_unnamed_145 = mad(fragment_unnamed_138, fragment_unnamed_142, fragment_unnamed_100);
				float fragment_unnamed_146 = mad(fragment_unnamed_138, fragment_unnamed_143, fragment_unnamed_101);
				float fragment_unnamed_152 = asfloat(((fragment_unnamed_134 >= fragment_unnamed_146) ? 4294967295u : 0u) & 1065353216u);
				precise float fragment_unnamed_153 = (-0.0f) - fragment_unnamed_144;
				precise float fragment_unnamed_154 = (-0.0f) - fragment_unnamed_145;
				precise float fragment_unnamed_155 = (-0.0f) - fragment_unnamed_146;
				precise float fragment_unnamed_156 = fragment_unnamed_153 + asfloat(3212836864u);
				precise float fragment_unnamed_157 = fragment_unnamed_154 + asfloat(1065353216u);
				precise float fragment_unnamed_158 = fragment_unnamed_155 + fragment_unnamed_134;
				float fragment_unnamed_159 = mad(fragment_unnamed_152, fragment_unnamed_156, fragment_unnamed_144);
				float fragment_unnamed_160 = mad(fragment_unnamed_152, fragment_unnamed_157, fragment_unnamed_145);
				precise float fragment_unnamed_170 = fragment_input_1.x + fragment_uniform_buffer_0[29u].x;
				precise float fragment_unnamed_171 = fragment_input_1.y + fragment_uniform_buffer_0[29u].y;
				float fragment_unnamed_185 = asfloat(((_CameraDepthTexture.Sample(sampler_CameraDepthTexture, float2(min(max(fragment_unnamed_170, 0.0f), fragment_uniform_buffer_0[26u].x), min(max(fragment_unnamed_171, 0.0f), fragment_uniform_buffer_0[26u].x))).x >= mad(fragment_unnamed_152, fragment_unnamed_158, fragment_unnamed_146)) ? 4294967295u : 0u) & 1065353216u);
				precise float fragment_unnamed_186 = (-0.0f) - fragment_unnamed_159;
				precise float fragment_unnamed_187 = (-0.0f) - fragment_unnamed_160;
				precise float fragment_unnamed_188 = fragment_unnamed_186 + 1.0f;
				precise float fragment_unnamed_189 = fragment_unnamed_187 + 1.0f;
				float4 fragment_unnamed_203 = _CameraMotionVectorsTexture.Sample(sampler_CameraMotionVectorsTexture, float2(mad(mad(fragment_unnamed_185, fragment_unnamed_188, fragment_unnamed_159), fragment_uniform_buffer_0[29u].x, fragment_input_1.x), mad(mad(fragment_unnamed_185, fragment_unnamed_189, fragment_unnamed_160), fragment_uniform_buffer_0[29u].y, fragment_input_1.y)));
				float fragment_unnamed_205 = fragment_unnamed_203.x;
				precise float fragment_unnamed_210 = (-0.0f) - fragment_unnamed_205;
				precise float fragment_unnamed_211 = (-0.0f) - fragment_unnamed_203.y;
				precise float fragment_unnamed_216 = fragment_unnamed_210 + fragment_input_1.x;
				precise float fragment_unnamed_217 = fragment_unnamed_211 + fragment_input_1.y;
				float4 fragment_unnamed_226 = _HistoryTex.Sample(sampler_HistoryTex, float2(min(max(fragment_unnamed_216, 0.0f), fragment_uniform_buffer_0[26u].x), min(max(fragment_unnamed_217, 0.0f), fragment_uniform_buffer_0[26u].x)));
				float fragment_unnamed_232 = sqrt(dot(float2(fragment_unnamed_205, fragment_unnamed_203.y), float2(fragment_unnamed_205, fragment_unnamed_203.y)));
				precise float fragment_unnamed_233 = fragment_unnamed_232 * 100.0f;
				precise float fragment_unnamed_239 = fragment_unnamed_232 * fragment_uniform_buffer_0[31u].z;
				float fragment_unnamed_241 = mad(min(fragment_unnamed_233, 1.0f), -3.75f, 4.0f);
				precise float fragment_unnamed_252 = (-0.0f) - fragment_uniform_buffer_0[30u].x;
				precise float fragment_unnamed_254 = (-0.0f) - fragment_uniform_buffer_0[30u].y;
				precise float fragment_unnamed_255 = fragment_input_1.x + fragment_unnamed_252;
				precise float fragment_unnamed_256 = fragment_input_1.y + fragment_unnamed_254;
				float fragment_unnamed_262 = min(max(fragment_unnamed_255, 0.0f), fragment_uniform_buffer_0[26u].x);
				float fragment_unnamed_263 = min(max(fragment_unnamed_256, 0.0f), fragment_uniform_buffer_0[26u].x);
				precise float fragment_unnamed_268 = (-0.0f) - fragment_uniform_buffer_0[28u].x;
				precise float fragment_unnamed_270 = (-0.0f) - fragment_uniform_buffer_0[28u].y;
				float4 fragment_unnamed_282 = _MainTex.Sample(S0, float2(min(max(mad(fragment_unnamed_268, 0.5f, fragment_unnamed_262), 0.0f), fragment_uniform_buffer_0[26u].x), min(max(mad(fragment_unnamed_270, 0.5f, fragment_unnamed_263), 0.0f), fragment_uniform_buffer_0[26u].x)));
				float fragment_unnamed_284 = fragment_unnamed_282.x;
				float fragment_unnamed_285 = fragment_unnamed_282.y;
				float fragment_unnamed_286 = fragment_unnamed_282.z;
				float4 fragment_unnamed_294 = _MainTex.Sample(S0, float2(fragment_unnamed_262, fragment_unnamed_263));
				float fragment_unnamed_296 = fragment_unnamed_294.x;
				float fragment_unnamed_297 = fragment_unnamed_294.y;
				float fragment_unnamed_298 = fragment_unnamed_294.z;
				float fragment_unnamed_299 = fragment_unnamed_294.w;
				float4 fragment_unnamed_307 = _MainTex.Sample(S0, float2(min(max(mad(fragment_uniform_buffer_0[28u].x, 0.5f, fragment_unnamed_262), 0.0f), fragment_uniform_buffer_0[26u].x), min(max(mad(fragment_uniform_buffer_0[28u].y, 0.5f, fragment_unnamed_263), 0.0f), fragment_uniform_buffer_0[26u].x)));
				float fragment_unnamed_309 = fragment_unnamed_307.x;
				float fragment_unnamed_310 = fragment_unnamed_307.y;
				float fragment_unnamed_311 = fragment_unnamed_307.z;
				precise float fragment_unnamed_313 = fragment_unnamed_284 + fragment_unnamed_309;
				precise float fragment_unnamed_314 = fragment_unnamed_285 + fragment_unnamed_310;
				precise float fragment_unnamed_315 = fragment_unnamed_286 + fragment_unnamed_311;
				precise float fragment_unnamed_316 = fragment_unnamed_282.w + fragment_unnamed_307.w;
				precise float fragment_unnamed_317 = fragment_unnamed_296 + fragment_unnamed_296;
				precise float fragment_unnamed_318 = fragment_unnamed_297 + fragment_unnamed_297;
				precise float fragment_unnamed_319 = fragment_unnamed_298 + fragment_unnamed_298;
				precise float fragment_unnamed_320 = fragment_unnamed_299 + fragment_unnamed_299;
				precise float fragment_unnamed_321 = (-0.0f) - fragment_unnamed_317;
				precise float fragment_unnamed_322 = (-0.0f) - fragment_unnamed_318;
				precise float fragment_unnamed_323 = (-0.0f) - fragment_unnamed_319;
				precise float fragment_unnamed_324 = (-0.0f) - fragment_unnamed_320;
				float fragment_unnamed_325 = mad(fragment_unnamed_313, 4.0f, fragment_unnamed_321);
				float fragment_unnamed_326 = mad(fragment_unnamed_314, 4.0f, fragment_unnamed_322);
				float fragment_unnamed_327 = mad(fragment_unnamed_315, 4.0f, fragment_unnamed_323);
				precise float fragment_unnamed_329 = (-0.0f) - fragment_unnamed_325;
				precise float fragment_unnamed_330 = (-0.0f) - fragment_unnamed_326;
				precise float fragment_unnamed_331 = (-0.0f) - fragment_unnamed_327;
				precise float fragment_unnamed_332 = (-0.0f) - mad(fragment_unnamed_316, 4.0f, fragment_unnamed_324);
				precise float fragment_unnamed_342 = mad(fragment_unnamed_329, 0.16666699945926666259765625f, fragment_unnamed_296) * fragment_uniform_buffer_0[32u].x;
				precise float fragment_unnamed_343 = mad(fragment_unnamed_330, 0.16666699945926666259765625f, fragment_unnamed_297) * fragment_uniform_buffer_0[32u].x;
				precise float fragment_unnamed_344 = mad(fragment_unnamed_331, 0.16666699945926666259765625f, fragment_unnamed_298) * fragment_uniform_buffer_0[32u].x;
				precise float fragment_unnamed_345 = mad(fragment_unnamed_332, 0.16666699945926666259765625f, fragment_unnamed_299) * fragment_uniform_buffer_0[32u].x;
				float fragment_unnamed_355 = min(max(mad(fragment_unnamed_342, 2.7182819843292236328125f, fragment_unnamed_296), 0.0f), 65472.0f);
				float fragment_unnamed_357 = min(max(mad(fragment_unnamed_343, 2.7182819843292236328125f, fragment_unnamed_297), 0.0f), 65472.0f);
				float fragment_unnamed_358 = min(max(mad(fragment_unnamed_344, 2.7182819843292236328125f, fragment_unnamed_298), 0.0f), 65472.0f);
				float fragment_unnamed_359 = min(max(mad(fragment_unnamed_345, 2.7182819843292236328125f, fragment_unnamed_299), 0.0f), 65472.0f);
				precise float fragment_unnamed_360 = fragment_unnamed_355 + fragment_unnamed_325;
				precise float fragment_unnamed_361 = fragment_unnamed_357 + fragment_unnamed_326;
				precise float fragment_unnamed_362 = fragment_unnamed_358 + fragment_unnamed_327;
				precise float fragment_unnamed_363 = fragment_unnamed_360 * 0.14285700023174285888671875f;
				precise float fragment_unnamed_365 = fragment_unnamed_361 * 0.14285700023174285888671875f;
				precise float fragment_unnamed_366 = fragment_unnamed_362 * 0.14285700023174285888671875f;
				precise float fragment_unnamed_377 = (-0.0f) - dot(float3(fragment_unnamed_355, fragment_unnamed_357, fragment_unnamed_358), float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f));
				precise float fragment_unnamed_378 = fragment_unnamed_377 + dot(float3(fragment_unnamed_363, fragment_unnamed_365, fragment_unnamed_366), float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f));
				float fragment_unnamed_385 = abs(fragment_unnamed_378);
				float fragment_unnamed_386 = mad(fragment_unnamed_241, fragment_unnamed_385, max(fragment_unnamed_284, fragment_unnamed_309));
				float fragment_unnamed_387 = mad(fragment_unnamed_241, fragment_unnamed_385, max(fragment_unnamed_285, fragment_unnamed_310));
				float fragment_unnamed_388 = mad(fragment_unnamed_241, fragment_unnamed_385, max(fragment_unnamed_286, fragment_unnamed_311));
				precise float fragment_unnamed_389 = (-0.0f) - fragment_unnamed_241;
				float fragment_unnamed_390 = abs(fragment_unnamed_378);
				float fragment_unnamed_391 = mad(fragment_unnamed_389, fragment_unnamed_390, min(fragment_unnamed_284, fragment_unnamed_309));
				float fragment_unnamed_392 = mad(fragment_unnamed_389, fragment_unnamed_390, min(fragment_unnamed_285, fragment_unnamed_310));
				float fragment_unnamed_393 = mad(fragment_unnamed_389, fragment_unnamed_390, min(fragment_unnamed_286, fragment_unnamed_311));
				precise float fragment_unnamed_394 = (-0.0f) - fragment_unnamed_391;
				precise float fragment_unnamed_395 = (-0.0f) - fragment_unnamed_392;
				precise float fragment_unnamed_396 = (-0.0f) - fragment_unnamed_393;
				precise float fragment_unnamed_397 = fragment_unnamed_394 + fragment_unnamed_386;
				precise float fragment_unnamed_398 = fragment_unnamed_395 + fragment_unnamed_387;
				precise float fragment_unnamed_399 = fragment_unnamed_396 + fragment_unnamed_388;
				precise float fragment_unnamed_400 = fragment_unnamed_391 + fragment_unnamed_386;
				precise float fragment_unnamed_401 = fragment_unnamed_392 + fragment_unnamed_387;
				precise float fragment_unnamed_402 = fragment_unnamed_393 + fragment_unnamed_388;
				precise float fragment_unnamed_403 = fragment_unnamed_397 * 0.5f;
				precise float fragment_unnamed_404 = fragment_unnamed_398 * 0.5f;
				precise float fragment_unnamed_405 = fragment_unnamed_399 * 0.5f;
				precise float fragment_unnamed_406 = (-0.0f) - fragment_unnamed_400;
				precise float fragment_unnamed_407 = (-0.0f) - fragment_unnamed_401;
				precise float fragment_unnamed_408 = (-0.0f) - fragment_unnamed_402;
				float fragment_unnamed_409 = mad(fragment_unnamed_406, 0.5f, fragment_unnamed_226.x);
				float fragment_unnamed_410 = mad(fragment_unnamed_407, 0.5f, fragment_unnamed_226.y);
				float fragment_unnamed_411 = mad(fragment_unnamed_408, 0.5f, fragment_unnamed_226.z);
				precise float fragment_unnamed_412 = fragment_unnamed_400 * 0.5f;
				precise float fragment_unnamed_413 = fragment_unnamed_401 * 0.5f;
				precise float fragment_unnamed_414 = fragment_unnamed_402 * 0.5f;
				precise float fragment_unnamed_415 = fragment_unnamed_409 + 9.9999997473787516355514526367188e-05f;
				precise float fragment_unnamed_417 = fragment_unnamed_410 + 9.9999997473787516355514526367188e-05f;
				precise float fragment_unnamed_418 = fragment_unnamed_411 + 9.9999997473787516355514526367188e-05f;
				precise float fragment_unnamed_419 = fragment_unnamed_403 / fragment_unnamed_415;
				precise float fragment_unnamed_420 = fragment_unnamed_404 / fragment_unnamed_417;
				precise float fragment_unnamed_421 = fragment_unnamed_405 / fragment_unnamed_418;
				float fragment_unnamed_427 = min(min(abs(fragment_unnamed_421), min(abs(fragment_unnamed_420), abs(fragment_unnamed_419))), 1.0f);
				precise float fragment_unnamed_431 = (-0.0f) - fragment_unnamed_355;
				precise float fragment_unnamed_432 = (-0.0f) - fragment_unnamed_357;
				precise float fragment_unnamed_433 = (-0.0f) - fragment_unnamed_358;
				precise float fragment_unnamed_434 = (-0.0f) - fragment_unnamed_359;
				precise float fragment_unnamed_435 = fragment_unnamed_431 + mad(fragment_unnamed_409, fragment_unnamed_427, fragment_unnamed_412);
				precise float fragment_unnamed_436 = fragment_unnamed_432 + mad(fragment_unnamed_410, fragment_unnamed_427, fragment_unnamed_413);
				precise float fragment_unnamed_437 = fragment_unnamed_433 + mad(fragment_unnamed_411, fragment_unnamed_427, fragment_unnamed_414);
				precise float fragment_unnamed_438 = fragment_unnamed_434 + fragment_unnamed_226.w;
				precise float fragment_unnamed_442 = (-0.0f) - fragment_uniform_buffer_0[31u].x;
				precise float fragment_unnamed_446 = fragment_unnamed_442 + fragment_uniform_buffer_0[31u].y;
				float fragment_unnamed_458 = min(max(mad(fragment_unnamed_239, fragment_unnamed_446, fragment_uniform_buffer_0[31u].x), fragment_uniform_buffer_0[31u].y), fragment_uniform_buffer_0[31u].x);
				float fragment_unnamed_467 = min(max(mad(fragment_unnamed_458, fragment_unnamed_435, fragment_unnamed_355), 0.0f), 65472.0f);
				float fragment_unnamed_468 = min(max(mad(fragment_unnamed_458, fragment_unnamed_436, fragment_unnamed_357), 0.0f), 65472.0f);
				float fragment_unnamed_469 = min(max(mad(fragment_unnamed_458, fragment_unnamed_437, fragment_unnamed_358), 0.0f), 65472.0f);
				float fragment_unnamed_470 = min(max(mad(fragment_unnamed_458, fragment_unnamed_438, fragment_unnamed_359), 0.0f), 65472.0f);
				fragment_output_0.x = fragment_unnamed_467;
				fragment_output_0.y = fragment_unnamed_468;
				fragment_output_0.z = fragment_unnamed_469;
				fragment_output_0.w = fragment_unnamed_470;
				fragment_output_1.x = fragment_unnamed_467;
				fragment_output_1.y = fragment_unnamed_468;
				fragment_output_1.z = fragment_unnamed_469;
				fragment_output_1.w = fragment_unnamed_470;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, fragment_uniform_buffer_0[26][1], fragment_uniform_buffer_0[26][2], fragment_uniform_buffer_0[26][3]);

				fragment_uniform_buffer_0[28] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				fragment_uniform_buffer_0[29] = float4(_CameraDepthTexture_TexelSize[0], _CameraDepthTexture_TexelSize[1], _CameraDepthTexture_TexelSize[2], _CameraDepthTexture_TexelSize[3]);

				fragment_uniform_buffer_0[30] = float4(_Jitter[0], _Jitter[1], fragment_uniform_buffer_0[30][2], fragment_uniform_buffer_0[30][3]);

				fragment_uniform_buffer_0[31] = float4(_FinalBlendParameters[0], _FinalBlendParameters[1], _FinalBlendParameters[2], _FinalBlendParameters[3]);

				fragment_uniform_buffer_0[32] = float4(_Sharpness, fragment_uniform_buffer_0[32][1], fragment_uniform_buffer_0[32][2], fragment_uniform_buffer_0[32][3]);

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
			GpuProgramID 92432

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

			float _RenderViewportScaleFactor;
			float4 _MainTex_TexelSize;
			float2 _Jitter;
			float4 _FinalBlendParameters;
			float _Sharpness;

			Texture2D<float4> _MainTex;
			SamplerState fragment_unnamed_71;
			Texture2D<float4> _CameraMotionVectorsTexture;
			SamplerState sampler_CameraMotionVectorsTexture;
			Texture2D<float4> _HistoryTex;
			SamplerState sampler_HistoryTex;

			static float2 fragment_input_0;
			static float4 fragment_output_0;
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

			static float4 fragment_unnamed_9;
			static float2 fragment_unnamed_44;
			static float4 fragment_unnamed_64;
			static float4 fragment_unnamed_84;
			static float4 fragment_unnamed_109;
			static float4 fragment_unnamed_113;
			static float fragment_unnamed_166;
			static float fragment_unnamed_174;
			static float fragment_unnamed_206;
			static float3 fragment_unnamed_246;
			static float3 fragment_unnamed_324;

			void frag_main()
			{
				float2 fragment_unnamed_23 = fragment_input_0 + (-_Jitter);
				fragment_unnamed_9 = float4(fragment_unnamed_23.x, fragment_unnamed_23.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
				float2 fragment_unnamed_30 = max(fragment_unnamed_9.xy, 0.0f.xx);
				fragment_unnamed_9 = float4(fragment_unnamed_30.x, fragment_unnamed_30.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
				float2 fragment_unnamed_40 = min(fragment_unnamed_9.xy, _RenderViewportScaleFactor.xx);
				fragment_unnamed_9 = float4(fragment_unnamed_40.x, fragment_unnamed_40.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
				fragment_unnamed_44 = ((-_MainTex_TexelSize.xy) * 0.5f.xx) + fragment_unnamed_9.xy;
				fragment_unnamed_44 = max(fragment_unnamed_44, 0.0f.xx);
				fragment_unnamed_44 = min(fragment_unnamed_44, _RenderViewportScaleFactor.xx);
				fragment_unnamed_64 = _MainTex.Sample(fragment_unnamed_71, fragment_unnamed_44);
				fragment_unnamed_44 = (_MainTex_TexelSize.xy * 0.5f.xx) + fragment_unnamed_9.xy;
				fragment_unnamed_84 = _MainTex.Sample(fragment_unnamed_71, fragment_unnamed_9.xy);
				float2 fragment_unnamed_92 = max(fragment_unnamed_44, 0.0f.xx);
				fragment_unnamed_9 = float4(fragment_unnamed_92.x, fragment_unnamed_92.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
				float2 fragment_unnamed_100 = min(fragment_unnamed_9.xy, _RenderViewportScaleFactor.xx);
				fragment_unnamed_9 = float4(fragment_unnamed_100.x, fragment_unnamed_100.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
				fragment_unnamed_9 = _MainTex.Sample(fragment_unnamed_71, fragment_unnamed_9.xy);
				fragment_unnamed_109 = fragment_unnamed_9 + fragment_unnamed_64;
				fragment_unnamed_113 = fragment_unnamed_84 + fragment_unnamed_84;
				fragment_unnamed_109 = (fragment_unnamed_109 * 4.0f.xxxx) + (-fragment_unnamed_113);
				fragment_unnamed_113 = ((-fragment_unnamed_109) * 0.16666699945926666259765625f.xxxx) + fragment_unnamed_84;
				fragment_unnamed_113 *= _Sharpness.xxxx;
				fragment_unnamed_84 = (fragment_unnamed_113 * 2.7182819843292236328125f.xxxx) + fragment_unnamed_84;
				fragment_unnamed_84 = max(fragment_unnamed_84, 0.0f.xxxx);
				fragment_unnamed_84 = min(fragment_unnamed_84, 65472.0f.xxxx);
				float3 fragment_unnamed_155 = fragment_unnamed_84.xyz + fragment_unnamed_109.xyz;
				fragment_unnamed_109 = float4(fragment_unnamed_155.x, fragment_unnamed_155.y, fragment_unnamed_155.z, fragment_unnamed_109.w);
				float3 fragment_unnamed_162 = fragment_unnamed_109.xyz * 0.14285700023174285888671875f.xxx;
				fragment_unnamed_109 = float4(fragment_unnamed_162.x, fragment_unnamed_162.y, fragment_unnamed_162.z, fragment_unnamed_109.w);
				fragment_unnamed_166 = dot(fragment_unnamed_109.xyz, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f));
				fragment_unnamed_174 = dot(fragment_unnamed_84.xyz, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f));
				fragment_unnamed_166 += (-fragment_unnamed_174);
				float3 fragment_unnamed_186 = min(fragment_unnamed_64.xyz, fragment_unnamed_9.xyz);
				fragment_unnamed_109 = float4(fragment_unnamed_186.x, fragment_unnamed_186.y, fragment_unnamed_186.z, fragment_unnamed_109.w);
				float3 fragment_unnamed_193 = max(fragment_unnamed_9.xyz, fragment_unnamed_64.xyz);
				fragment_unnamed_9 = float4(fragment_unnamed_193.x, fragment_unnamed_193.y, fragment_unnamed_193.z, fragment_unnamed_9.w);
				float2 fragment_unnamed_203 = _CameraMotionVectorsTexture.Sample(sampler_CameraMotionVectorsTexture, fragment_input_0).xy;
				fragment_unnamed_64 = float4(fragment_unnamed_203.x, fragment_unnamed_203.y, fragment_unnamed_64.z, fragment_unnamed_64.w);
				fragment_unnamed_206 = dot(fragment_unnamed_64.xy, fragment_unnamed_64.xy);
				float2 fragment_unnamed_216 = (-fragment_unnamed_64.xy) + fragment_input_0;
				fragment_unnamed_64 = float4(fragment_unnamed_216.x, fragment_unnamed_216.y, fragment_unnamed_64.z, fragment_unnamed_64.w);
				float2 fragment_unnamed_221 = max(fragment_unnamed_64.xy, 0.0f.xx);
				fragment_unnamed_64 = float4(fragment_unnamed_221.x, fragment_unnamed_221.y, fragment_unnamed_64.z, fragment_unnamed_64.w);
				float2 fragment_unnamed_229 = min(fragment_unnamed_64.xy, _RenderViewportScaleFactor.xx);
				fragment_unnamed_64 = float4(fragment_unnamed_229.x, fragment_unnamed_229.y, fragment_unnamed_64.z, fragment_unnamed_64.w);
				fragment_unnamed_113 = _HistoryTex.Sample(sampler_HistoryTex, fragment_unnamed_64.xy);
				fragment_unnamed_64.x = sqrt(fragment_unnamed_206);
				fragment_unnamed_246.x = fragment_unnamed_64.x * 100.0f;
				fragment_unnamed_64.x *= _FinalBlendParameters.z;
				fragment_unnamed_246.x = min(fragment_unnamed_246.x, 1.0f);
				fragment_unnamed_246.x = (fragment_unnamed_246.x * (-3.75f)) + 4.0f;
				float3 fragment_unnamed_280 = ((-fragment_unnamed_246.xxx) * abs(fragment_unnamed_166.xxx)) + fragment_unnamed_109.xyz;
				fragment_unnamed_109 = float4(fragment_unnamed_280.x, fragment_unnamed_280.y, fragment_unnamed_280.z, fragment_unnamed_109.w);
				float3 fragment_unnamed_291 = (fragment_unnamed_246.xxx * abs(fragment_unnamed_166.xxx)) + fragment_unnamed_9.xyz;
				fragment_unnamed_9 = float4(fragment_unnamed_291.x, fragment_unnamed_291.y, fragment_unnamed_291.z, fragment_unnamed_9.w);
				fragment_unnamed_246 = (-fragment_unnamed_109.xyz) + fragment_unnamed_9.xyz;
				float3 fragment_unnamed_304 = fragment_unnamed_109.xyz + fragment_unnamed_9.xyz;
				fragment_unnamed_9 = float4(fragment_unnamed_304.x, fragment_unnamed_304.y, fragment_unnamed_304.z, fragment_unnamed_9.w);
				fragment_unnamed_246 *= 0.5f.xxx;
				float3 fragment_unnamed_316 = ((-fragment_unnamed_9.xyz) * 0.5f.xxx) + fragment_unnamed_113.xyz;
				fragment_unnamed_109 = float4(fragment_unnamed_316.x, fragment_unnamed_316.y, fragment_unnamed_316.z, fragment_unnamed_109.w);
				float3 fragment_unnamed_321 = fragment_unnamed_9.xyz * 0.5f.xxx;
				fragment_unnamed_9 = float4(fragment_unnamed_321.x, fragment_unnamed_321.y, fragment_unnamed_321.z, fragment_unnamed_9.w);
				fragment_unnamed_324 = fragment_unnamed_109.xyz + 9.9999997473787516355514526367188e-05f.xxx;
				fragment_unnamed_246 /= fragment_unnamed_324;
				fragment_unnamed_166 = min(abs(fragment_unnamed_246.y), abs(fragment_unnamed_246.x));
				fragment_unnamed_166 = min(abs(fragment_unnamed_246.z), fragment_unnamed_166);
				fragment_unnamed_166 = min(fragment_unnamed_166, 1.0f);
				float3 fragment_unnamed_355 = (fragment_unnamed_109.xyz * fragment_unnamed_166.xxx) + fragment_unnamed_9.xyz;
				fragment_unnamed_113 = float4(fragment_unnamed_355.x, fragment_unnamed_355.y, fragment_unnamed_355.z, fragment_unnamed_113.w);
				fragment_unnamed_9 = (-fragment_unnamed_84) + fragment_unnamed_113;
				fragment_unnamed_246.x = (-_FinalBlendParameters.x) + _FinalBlendParameters.y;
				fragment_unnamed_64.x = (fragment_unnamed_64.x * fragment_unnamed_246.x) + _FinalBlendParameters.x;
				fragment_unnamed_64.x = max(fragment_unnamed_64.x, _FinalBlendParameters.y);
				fragment_unnamed_64.x = min(fragment_unnamed_64.x, _FinalBlendParameters.x);
				fragment_unnamed_9 = (fragment_unnamed_64.xxxx * fragment_unnamed_9) + fragment_unnamed_84;
				fragment_unnamed_9 = max(fragment_unnamed_9, 0.0f.xxxx);
				fragment_unnamed_9 = min(fragment_unnamed_9, 65472.0f.xxxx);
				fragment_output_0 = fragment_unnamed_9;
				fragment_output_1 = fragment_unnamed_9;
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


			float _RenderViewportScaleFactor;
			float4 _MainTex_TexelSize;
			float2 _Jitter;
			float4 _FinalBlendParameters;
			float _Sharpness;

			static float4 fragment_uniform_buffer_0[33];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _HistoryTex;
			Texture2D<float4> _CameraMotionVectorsTexture;
			SamplerState S0;
			SamplerState sampler_HistoryTex;
			SamplerState sampler_CameraMotionVectorsTexture;

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
				precise float fragment_unnamed_50 = (-0.0f) - fragment_uniform_buffer_0[30u].x;
				precise float fragment_unnamed_53 = (-0.0f) - fragment_uniform_buffer_0[30u].y;
				precise float fragment_unnamed_54 = fragment_input_1.x + fragment_unnamed_50;
				precise float fragment_unnamed_55 = fragment_input_1.y + fragment_unnamed_53;
				float fragment_unnamed_64 = min(max(fragment_unnamed_54, 0.0f), fragment_uniform_buffer_0[26u].x);
				float fragment_unnamed_65 = min(max(fragment_unnamed_55, 0.0f), fragment_uniform_buffer_0[26u].x);
				precise float fragment_unnamed_70 = (-0.0f) - fragment_uniform_buffer_0[28u].x;
				precise float fragment_unnamed_72 = (-0.0f) - fragment_uniform_buffer_0[28u].y;
				float4 fragment_unnamed_85 = _MainTex.Sample(S0, float2(min(max(mad(fragment_unnamed_70, 0.5f, fragment_unnamed_64), 0.0f), fragment_uniform_buffer_0[26u].x), min(max(mad(fragment_unnamed_72, 0.5f, fragment_unnamed_65), 0.0f), fragment_uniform_buffer_0[26u].x)));
				float fragment_unnamed_87 = fragment_unnamed_85.x;
				float fragment_unnamed_88 = fragment_unnamed_85.y;
				float fragment_unnamed_89 = fragment_unnamed_85.z;
				float4 fragment_unnamed_97 = _MainTex.Sample(S0, float2(fragment_unnamed_64, fragment_unnamed_65));
				float fragment_unnamed_99 = fragment_unnamed_97.x;
				float fragment_unnamed_100 = fragment_unnamed_97.y;
				float fragment_unnamed_101 = fragment_unnamed_97.z;
				float fragment_unnamed_102 = fragment_unnamed_97.w;
				float4 fragment_unnamed_110 = _MainTex.Sample(S0, float2(min(max(mad(fragment_uniform_buffer_0[28u].x, 0.5f, fragment_unnamed_64), 0.0f), fragment_uniform_buffer_0[26u].x), min(max(mad(fragment_uniform_buffer_0[28u].y, 0.5f, fragment_unnamed_65), 0.0f), fragment_uniform_buffer_0[26u].x)));
				float fragment_unnamed_112 = fragment_unnamed_110.x;
				float fragment_unnamed_113 = fragment_unnamed_110.y;
				float fragment_unnamed_114 = fragment_unnamed_110.z;
				precise float fragment_unnamed_116 = fragment_unnamed_112 + fragment_unnamed_87;
				precise float fragment_unnamed_117 = fragment_unnamed_113 + fragment_unnamed_88;
				precise float fragment_unnamed_118 = fragment_unnamed_114 + fragment_unnamed_89;
				precise float fragment_unnamed_119 = fragment_unnamed_110.w + fragment_unnamed_85.w;
				precise float fragment_unnamed_120 = fragment_unnamed_99 + fragment_unnamed_99;
				precise float fragment_unnamed_121 = fragment_unnamed_100 + fragment_unnamed_100;
				precise float fragment_unnamed_122 = fragment_unnamed_101 + fragment_unnamed_101;
				precise float fragment_unnamed_123 = fragment_unnamed_102 + fragment_unnamed_102;
				precise float fragment_unnamed_124 = (-0.0f) - fragment_unnamed_120;
				precise float fragment_unnamed_125 = (-0.0f) - fragment_unnamed_121;
				precise float fragment_unnamed_126 = (-0.0f) - fragment_unnamed_122;
				precise float fragment_unnamed_127 = (-0.0f) - fragment_unnamed_123;
				float fragment_unnamed_128 = mad(fragment_unnamed_116, 4.0f, fragment_unnamed_124);
				float fragment_unnamed_130 = mad(fragment_unnamed_117, 4.0f, fragment_unnamed_125);
				float fragment_unnamed_131 = mad(fragment_unnamed_118, 4.0f, fragment_unnamed_126);
				precise float fragment_unnamed_133 = (-0.0f) - fragment_unnamed_128;
				precise float fragment_unnamed_134 = (-0.0f) - fragment_unnamed_130;
				precise float fragment_unnamed_135 = (-0.0f) - fragment_unnamed_131;
				precise float fragment_unnamed_136 = (-0.0f) - mad(fragment_unnamed_119, 4.0f, fragment_unnamed_127);
				precise float fragment_unnamed_146 = mad(fragment_unnamed_133, 0.16666699945926666259765625f, fragment_unnamed_99) * fragment_uniform_buffer_0[32u].x;
				precise float fragment_unnamed_147 = mad(fragment_unnamed_134, 0.16666699945926666259765625f, fragment_unnamed_100) * fragment_uniform_buffer_0[32u].x;
				precise float fragment_unnamed_148 = mad(fragment_unnamed_135, 0.16666699945926666259765625f, fragment_unnamed_101) * fragment_uniform_buffer_0[32u].x;
				precise float fragment_unnamed_149 = mad(fragment_unnamed_136, 0.16666699945926666259765625f, fragment_unnamed_102) * fragment_uniform_buffer_0[32u].x;
				float fragment_unnamed_159 = min(max(mad(fragment_unnamed_146, 2.7182819843292236328125f, fragment_unnamed_99), 0.0f), 65472.0f);
				float fragment_unnamed_161 = min(max(mad(fragment_unnamed_147, 2.7182819843292236328125f, fragment_unnamed_100), 0.0f), 65472.0f);
				float fragment_unnamed_162 = min(max(mad(fragment_unnamed_148, 2.7182819843292236328125f, fragment_unnamed_101), 0.0f), 65472.0f);
				float fragment_unnamed_163 = min(max(mad(fragment_unnamed_149, 2.7182819843292236328125f, fragment_unnamed_102), 0.0f), 65472.0f);
				precise float fragment_unnamed_164 = fragment_unnamed_159 + fragment_unnamed_128;
				precise float fragment_unnamed_165 = fragment_unnamed_161 + fragment_unnamed_130;
				precise float fragment_unnamed_166 = fragment_unnamed_162 + fragment_unnamed_131;
				precise float fragment_unnamed_167 = fragment_unnamed_164 * 0.14285700023174285888671875f;
				precise float fragment_unnamed_169 = fragment_unnamed_165 * 0.14285700023174285888671875f;
				precise float fragment_unnamed_170 = fragment_unnamed_166 * 0.14285700023174285888671875f;
				precise float fragment_unnamed_181 = (-0.0f) - dot(float3(fragment_unnamed_159, fragment_unnamed_161, fragment_unnamed_162), float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f));
				precise float fragment_unnamed_182 = dot(float3(fragment_unnamed_167, fragment_unnamed_169, fragment_unnamed_170), float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)) + fragment_unnamed_181;
				float4 fragment_unnamed_194 = _CameraMotionVectorsTexture.Sample(sampler_CameraMotionVectorsTexture, float2(fragment_input_1.x, fragment_input_1.y));
				float fragment_unnamed_196 = fragment_unnamed_194.x;
				precise float fragment_unnamed_201 = (-0.0f) - fragment_unnamed_196;
				precise float fragment_unnamed_202 = (-0.0f) - fragment_unnamed_194.y;
				precise float fragment_unnamed_207 = fragment_unnamed_201 + fragment_input_1.x;
				precise float fragment_unnamed_208 = fragment_unnamed_202 + fragment_input_1.y;
				float4 fragment_unnamed_217 = _HistoryTex.Sample(sampler_HistoryTex, float2(min(max(fragment_unnamed_207, 0.0f), fragment_uniform_buffer_0[26u].x), min(max(fragment_unnamed_208, 0.0f), fragment_uniform_buffer_0[26u].x)));
				float fragment_unnamed_223 = sqrt(dot(float2(fragment_unnamed_196, fragment_unnamed_194.y), float2(fragment_unnamed_196, fragment_unnamed_194.y)));
				precise float fragment_unnamed_224 = fragment_unnamed_223 * 100.0f;
				precise float fragment_unnamed_230 = fragment_unnamed_223 * fragment_uniform_buffer_0[31u].z;
				float fragment_unnamed_233 = mad(min(fragment_unnamed_224, 1.0f), -3.75f, 4.0f);
				precise float fragment_unnamed_235 = (-0.0f) - fragment_unnamed_233;
				float fragment_unnamed_236 = abs(fragment_unnamed_182);
				float fragment_unnamed_237 = mad(fragment_unnamed_235, fragment_unnamed_236, min(fragment_unnamed_87, fragment_unnamed_112));
				float fragment_unnamed_238 = mad(fragment_unnamed_235, fragment_unnamed_236, min(fragment_unnamed_88, fragment_unnamed_113));
				float fragment_unnamed_239 = mad(fragment_unnamed_235, fragment_unnamed_236, min(fragment_unnamed_89, fragment_unnamed_114));
				float fragment_unnamed_240 = abs(fragment_unnamed_182);
				float fragment_unnamed_241 = mad(fragment_unnamed_233, fragment_unnamed_240, max(fragment_unnamed_112, fragment_unnamed_87));
				float fragment_unnamed_242 = mad(fragment_unnamed_233, fragment_unnamed_240, max(fragment_unnamed_113, fragment_unnamed_88));
				float fragment_unnamed_243 = mad(fragment_unnamed_233, fragment_unnamed_240, max(fragment_unnamed_114, fragment_unnamed_89));
				precise float fragment_unnamed_244 = (-0.0f) - fragment_unnamed_237;
				precise float fragment_unnamed_245 = (-0.0f) - fragment_unnamed_238;
				precise float fragment_unnamed_246 = (-0.0f) - fragment_unnamed_239;
				precise float fragment_unnamed_247 = fragment_unnamed_244 + fragment_unnamed_241;
				precise float fragment_unnamed_248 = fragment_unnamed_245 + fragment_unnamed_242;
				precise float fragment_unnamed_249 = fragment_unnamed_246 + fragment_unnamed_243;
				precise float fragment_unnamed_250 = fragment_unnamed_237 + fragment_unnamed_241;
				precise float fragment_unnamed_251 = fragment_unnamed_238 + fragment_unnamed_242;
				precise float fragment_unnamed_252 = fragment_unnamed_239 + fragment_unnamed_243;
				precise float fragment_unnamed_253 = fragment_unnamed_247 * 0.5f;
				precise float fragment_unnamed_254 = fragment_unnamed_248 * 0.5f;
				precise float fragment_unnamed_255 = fragment_unnamed_249 * 0.5f;
				precise float fragment_unnamed_256 = (-0.0f) - fragment_unnamed_250;
				precise float fragment_unnamed_257 = (-0.0f) - fragment_unnamed_251;
				precise float fragment_unnamed_258 = (-0.0f) - fragment_unnamed_252;
				float fragment_unnamed_259 = mad(fragment_unnamed_256, 0.5f, fragment_unnamed_217.x);
				float fragment_unnamed_260 = mad(fragment_unnamed_257, 0.5f, fragment_unnamed_217.y);
				float fragment_unnamed_261 = mad(fragment_unnamed_258, 0.5f, fragment_unnamed_217.z);
				precise float fragment_unnamed_262 = fragment_unnamed_250 * 0.5f;
				precise float fragment_unnamed_263 = fragment_unnamed_251 * 0.5f;
				precise float fragment_unnamed_264 = fragment_unnamed_252 * 0.5f;
				precise float fragment_unnamed_265 = fragment_unnamed_259 + 9.9999997473787516355514526367188e-05f;
				precise float fragment_unnamed_267 = fragment_unnamed_260 + 9.9999997473787516355514526367188e-05f;
				precise float fragment_unnamed_268 = fragment_unnamed_261 + 9.9999997473787516355514526367188e-05f;
				precise float fragment_unnamed_269 = fragment_unnamed_253 / fragment_unnamed_265;
				precise float fragment_unnamed_270 = fragment_unnamed_254 / fragment_unnamed_267;
				precise float fragment_unnamed_271 = fragment_unnamed_255 / fragment_unnamed_268;
				float fragment_unnamed_277 = min(min(abs(fragment_unnamed_271), min(abs(fragment_unnamed_270), abs(fragment_unnamed_269))), 1.0f);
				precise float fragment_unnamed_281 = (-0.0f) - fragment_unnamed_159;
				precise float fragment_unnamed_282 = (-0.0f) - fragment_unnamed_161;
				precise float fragment_unnamed_283 = (-0.0f) - fragment_unnamed_162;
				precise float fragment_unnamed_284 = (-0.0f) - fragment_unnamed_163;
				precise float fragment_unnamed_285 = fragment_unnamed_281 + mad(fragment_unnamed_259, fragment_unnamed_277, fragment_unnamed_262);
				precise float fragment_unnamed_286 = fragment_unnamed_282 + mad(fragment_unnamed_260, fragment_unnamed_277, fragment_unnamed_263);
				precise float fragment_unnamed_287 = fragment_unnamed_283 + mad(fragment_unnamed_261, fragment_unnamed_277, fragment_unnamed_264);
				precise float fragment_unnamed_288 = fragment_unnamed_284 + fragment_unnamed_217.w;
				precise float fragment_unnamed_292 = (-0.0f) - fragment_uniform_buffer_0[31u].x;
				precise float fragment_unnamed_296 = fragment_unnamed_292 + fragment_uniform_buffer_0[31u].y;
				float fragment_unnamed_308 = min(max(mad(fragment_unnamed_230, fragment_unnamed_296, fragment_uniform_buffer_0[31u].x), fragment_uniform_buffer_0[31u].y), fragment_uniform_buffer_0[31u].x);
				float fragment_unnamed_317 = min(max(mad(fragment_unnamed_308, fragment_unnamed_285, fragment_unnamed_159), 0.0f), 65472.0f);
				float fragment_unnamed_318 = min(max(mad(fragment_unnamed_308, fragment_unnamed_286, fragment_unnamed_161), 0.0f), 65472.0f);
				float fragment_unnamed_319 = min(max(mad(fragment_unnamed_308, fragment_unnamed_287, fragment_unnamed_162), 0.0f), 65472.0f);
				float fragment_unnamed_320 = min(max(mad(fragment_unnamed_308, fragment_unnamed_288, fragment_unnamed_163), 0.0f), 65472.0f);
				fragment_output_0.x = fragment_unnamed_317;
				fragment_output_0.y = fragment_unnamed_318;
				fragment_output_0.z = fragment_unnamed_319;
				fragment_output_0.w = fragment_unnamed_320;
				fragment_output_1.x = fragment_unnamed_317;
				fragment_output_1.y = fragment_unnamed_318;
				fragment_output_1.z = fragment_unnamed_319;
				fragment_output_1.w = fragment_unnamed_320;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, fragment_uniform_buffer_0[26][1], fragment_uniform_buffer_0[26][2], fragment_uniform_buffer_0[26][3]);

				fragment_uniform_buffer_0[28] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				fragment_uniform_buffer_0[30] = float4(_Jitter[0], _Jitter[1], fragment_uniform_buffer_0[30][2], fragment_uniform_buffer_0[30][3]);

				fragment_uniform_buffer_0[31] = float4(_FinalBlendParameters[0], _FinalBlendParameters[1], _FinalBlendParameters[2], _FinalBlendParameters[3]);

				fragment_uniform_buffer_0[32] = float4(_Sharpness, fragment_uniform_buffer_0[32][1], fragment_uniform_buffer_0[32][2], fragment_uniform_buffer_0[32][3]);

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
	}
}
