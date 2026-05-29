Shader "Hidden/PostProcessing/Lut2DBaker"
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
			GpuProgramID 57050

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

			float4 _Lut2D_Params;
			float3 _ColorBalance;
			float3 _ColorFilter;
			float3 _HueSatCon;
			float _Brightness;
			float3 _ChannelMixerRed;
			float3 _ChannelMixerGreen;
			float3 _ChannelMixerBlue;
			float3 _Lift;
			float3 _InvGamma;
			float3 _Gain;

			Texture2D<float4> _Curves;
			SamplerState sampler_Curves;

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
			static float4 fragment_unnamed_28;
			static bool fragment_unnamed_260;
			static float fragment_unnamed_266;
			static float4 fragment_unnamed_273;
			static float3 fragment_unnamed_309;
			static float3 fragment_unnamed_345;
			static float2 fragment_unnamed_354;
			static float2 fragment_unnamed_378;
			static bool fragment_unnamed_427;
			static float2 fragment_unnamed_483;

			void frag_main()
			{
				float2 fragment_unnamed_25 = fragment_input_0 + (-_Lut2D_Params.yz);
				fragment_unnamed_9 = float4(fragment_unnamed_9.x, fragment_unnamed_25.x, fragment_unnamed_25.y, fragment_unnamed_9.w);
				fragment_unnamed_28.x = fragment_unnamed_9.y * _Lut2D_Params.x;
				fragment_unnamed_9.x = frac(fragment_unnamed_28.x);
				fragment_unnamed_28.x = fragment_unnamed_9.x / _Lut2D_Params.x;
				fragment_unnamed_9.w = fragment_unnamed_9.y + (-fragment_unnamed_28.x);
				float3 fragment_unnamed_63 = fragment_unnamed_9.xzw * _Lut2D_Params.www;
				fragment_unnamed_9 = float4(fragment_unnamed_63.x, fragment_unnamed_63.y, fragment_unnamed_63.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_83 = (fragment_unnamed_9.xyz * float3(float3(_Brightness, _Brightness, _Brightness))) + (-0.21763764321804046630859375f).xxx;
				fragment_unnamed_9 = float4(fragment_unnamed_83.x, fragment_unnamed_83.y, fragment_unnamed_83.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_96 = (fragment_unnamed_9.xyz * _HueSatCon.zzz) + 0.21763764321804046630859375f.xxx;
				fragment_unnamed_9 = float4(fragment_unnamed_96.x, fragment_unnamed_96.y, fragment_unnamed_96.z, fragment_unnamed_9.w);
				fragment_unnamed_28.x = dot(float3(0.390404999256134033203125f, 0.549941003322601318359375f, 0.008926319889724254608154296875f), fragment_unnamed_9.xyz);
				fragment_unnamed_28.y = dot(float3(0.070841602981090545654296875f, 0.963172018527984619140625f, 0.001357750035822391510009765625f), fragment_unnamed_9.xyz);
				fragment_unnamed_28.z = dot(float3(0.02310819923877716064453125f, 0.1280210018157958984375f, 0.936245024204254150390625f), fragment_unnamed_9.xyz);
				float3 fragment_unnamed_129 = fragment_unnamed_28.xyz * _ColorBalance;
				fragment_unnamed_9 = float4(fragment_unnamed_129.x, fragment_unnamed_129.y, fragment_unnamed_129.z, fragment_unnamed_9.w);
				fragment_unnamed_28.x = dot(float3(2.85846996307373046875f, -1.62879002094268798828125f, -0.0248910002410411834716796875f), fragment_unnamed_9.xyz);
				fragment_unnamed_28.y = dot(float3(-0.21018199622631072998046875f, 1.1582000255584716796875f, 0.0003242809907533228397369384765625f), fragment_unnamed_9.xyz);
				fragment_unnamed_28.z = dot(float3(-0.0418119989335536956787109375f, -0.118169002234935760498046875f, 1.0686700344085693359375f), fragment_unnamed_9.xyz);
				float3 fragment_unnamed_161 = fragment_unnamed_28.xyz * _ColorFilter;
				fragment_unnamed_9 = float4(fragment_unnamed_161.x, fragment_unnamed_161.y, fragment_unnamed_161.z, fragment_unnamed_9.w);
				fragment_unnamed_28.x = dot(fragment_unnamed_9.xyz, _ChannelMixerRed);
				fragment_unnamed_28.y = dot(fragment_unnamed_9.xyz, _ChannelMixerGreen);
				fragment_unnamed_28.z = dot(fragment_unnamed_9.xyz, _ChannelMixerBlue);
				float3 fragment_unnamed_194 = (fragment_unnamed_28.xyz * _Gain) + _Lift;
				fragment_unnamed_9 = float4(fragment_unnamed_194.x, fragment_unnamed_194.y, fragment_unnamed_194.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_200 = log2(abs(fragment_unnamed_9.xyz));
				fragment_unnamed_28 = float4(fragment_unnamed_200.x, fragment_unnamed_200.y, fragment_unnamed_200.z, fragment_unnamed_28.w);
				float3 fragment_unnamed_210 = (fragment_unnamed_9.xyz * 3.4028234663852885981170418348452e+38f.xxx) + 0.5f.xxx;
				fragment_unnamed_9 = float4(fragment_unnamed_210.x, fragment_unnamed_210.y, fragment_unnamed_210.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_219 = clamp(fragment_unnamed_9.xyz, 0.0f.xxx, 1.0f.xxx);
				fragment_unnamed_9 = float4(fragment_unnamed_219.x, fragment_unnamed_219.y, fragment_unnamed_219.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_229 = (fragment_unnamed_9.xyz * 2.0f.xxx) + (-1.0f).xxx;
				fragment_unnamed_9 = float4(fragment_unnamed_229.x, fragment_unnamed_229.y, fragment_unnamed_229.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_237 = fragment_unnamed_28.xyz * _InvGamma;
				fragment_unnamed_28 = float4(fragment_unnamed_237.x, fragment_unnamed_237.y, fragment_unnamed_237.z, fragment_unnamed_28.w);
				float3 fragment_unnamed_242 = exp2(fragment_unnamed_28.xyz);
				fragment_unnamed_28 = float4(fragment_unnamed_242.x, fragment_unnamed_242.y, fragment_unnamed_242.z, fragment_unnamed_28.w);
				float3 fragment_unnamed_249 = fragment_unnamed_9.xyz * fragment_unnamed_28.xyz;
				fragment_unnamed_9 = float4(fragment_unnamed_249.x, fragment_unnamed_249.y, fragment_unnamed_249.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_255 = max(fragment_unnamed_9.xyz, 0.0f.xxx);
				fragment_unnamed_9 = float4(fragment_unnamed_255.x, fragment_unnamed_255.y, fragment_unnamed_255.z, fragment_unnamed_9.w);
				fragment_unnamed_260 = fragment_unnamed_9.y >= fragment_unnamed_9.z;
				fragment_unnamed_266 = float(fragment_unnamed_260);
				fragment_unnamed_28 = float4(fragment_unnamed_9.zy.x, fragment_unnamed_9.zy.y, fragment_unnamed_28.z, fragment_unnamed_28.w);
				float2 fragment_unnamed_279 = fragment_unnamed_9.yz + (-fragment_unnamed_28.xy);
				fragment_unnamed_273 = float4(fragment_unnamed_279.x, fragment_unnamed_279.y, fragment_unnamed_273.z, fragment_unnamed_273.w);
				fragment_unnamed_28.z = -1.0f;
				fragment_unnamed_28.w = 0.666666686534881591796875f;
				fragment_unnamed_273.z = 1.0f;
				fragment_unnamed_273.w = -1.0f;
				fragment_unnamed_28 = (fragment_unnamed_266.xxxx * fragment_unnamed_273.xywz) + fragment_unnamed_28.xywz;
				fragment_unnamed_260 = fragment_unnamed_9.x >= fragment_unnamed_28.x;
				fragment_unnamed_266 = float(fragment_unnamed_260);
				fragment_unnamed_273.z = fragment_unnamed_28.w;
				fragment_unnamed_28.w = fragment_unnamed_9.x;
				fragment_unnamed_309.x = dot(fragment_unnamed_9.xyz, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f));
				fragment_unnamed_273 = float4(fragment_unnamed_28.wyx.x, fragment_unnamed_28.wyx.y, fragment_unnamed_273.z, fragment_unnamed_28.wyx.z);
				fragment_unnamed_273 = (-fragment_unnamed_28) + fragment_unnamed_273;
				fragment_unnamed_9 = (fragment_unnamed_266.xxxx * fragment_unnamed_273) + fragment_unnamed_28;
				fragment_unnamed_28.x = min(fragment_unnamed_9.y, fragment_unnamed_9.w);
				fragment_unnamed_28.x = fragment_unnamed_9.x + (-fragment_unnamed_28.x);
				fragment_unnamed_345.x = (fragment_unnamed_28.x * 6.0f) + 9.9999997473787516355514526367188e-05f;
				fragment_unnamed_354.x = (-fragment_unnamed_9.y) + fragment_unnamed_9.w;
				fragment_unnamed_354.x /= fragment_unnamed_345.x;
				fragment_unnamed_354.x += fragment_unnamed_9.z;
				fragment_unnamed_273.x = abs(fragment_unnamed_354.x);
				fragment_unnamed_378.x = fragment_unnamed_273.x + _HueSatCon.x;
				fragment_unnamed_309.y = 0.25f;
				fragment_unnamed_378.y = 0.25f;
				fragment_unnamed_354.x = _Curves.SampleLevel(sampler_Curves, fragment_unnamed_378, 0.0f).x;
				fragment_unnamed_354.y = _Curves.SampleLevel(sampler_Curves, fragment_unnamed_309.xy, 0.0f).w;
				fragment_unnamed_354 = fragment_unnamed_354;
				fragment_unnamed_354 = clamp(fragment_unnamed_354, 0.0f.xx, 1.0f.xx);
				fragment_unnamed_354.x = fragment_unnamed_378.x + fragment_unnamed_354.x;
				fragment_unnamed_345 = fragment_unnamed_354.xxx + float3(-0.5f, 0.5f, -1.5f);
				fragment_unnamed_427 = 1.0f < fragment_unnamed_345.x;
				float fragment_unnamed_433;
				if (fragment_unnamed_427)
				{
					fragment_unnamed_433 = fragment_unnamed_345.z;
				}
				else
				{
					fragment_unnamed_433 = fragment_unnamed_345.x;
				}
				fragment_unnamed_354.x = fragment_unnamed_433;
				fragment_unnamed_260 = fragment_unnamed_345.x < 0.0f;
				float fragment_unnamed_447;
				if (fragment_unnamed_260)
				{
					fragment_unnamed_447 = fragment_unnamed_345.y;
				}
				else
				{
					fragment_unnamed_447 = fragment_unnamed_354.x;
				}
				fragment_unnamed_354.x = fragment_unnamed_447;
				fragment_unnamed_345 = fragment_unnamed_354.xxx + float3(1.0f, 0.666666686534881591796875f, 0.3333333432674407958984375f);
				fragment_unnamed_345 = frac(fragment_unnamed_345);
				fragment_unnamed_345 = (fragment_unnamed_345 * 6.0f.xxx) + (-3.0f).xxx;
				fragment_unnamed_345 = abs(fragment_unnamed_345) + (-1.0f).xxx;
				fragment_unnamed_345 = clamp(fragment_unnamed_345, 0.0f.xxx, 1.0f.xxx);
				fragment_unnamed_345 += (-1.0f).xxx;
				fragment_unnamed_354.x = fragment_unnamed_9.x + 9.9999997473787516355514526367188e-05f;
				fragment_unnamed_483.x = fragment_unnamed_28.x / fragment_unnamed_354.x;
				float3 fragment_unnamed_495 = (fragment_unnamed_483.xxx * fragment_unnamed_345) + 1.0f.xxx;
				fragment_unnamed_28 = float4(fragment_unnamed_495.x, fragment_unnamed_495.y, fragment_unnamed_495.z, fragment_unnamed_28.w);
				fragment_unnamed_309 = fragment_unnamed_9.xxx * fragment_unnamed_28.xyz;
				fragment_unnamed_354.x = dot(fragment_unnamed_309, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f));
				float3 fragment_unnamed_514 = (fragment_unnamed_9.xxx * fragment_unnamed_28.xyz) + (-fragment_unnamed_354.xxx);
				fragment_unnamed_28 = float4(fragment_unnamed_514.x, fragment_unnamed_514.y, fragment_unnamed_514.z, fragment_unnamed_28.w);
				fragment_unnamed_273.y = 0.25f;
				fragment_unnamed_483.y = 0.25f;
				fragment_unnamed_9.x = _Curves.SampleLevel(sampler_Curves, fragment_unnamed_273.xy, 0.0f).y;
				fragment_unnamed_9.w = _Curves.SampleLevel(sampler_Curves, fragment_unnamed_483, 0.0f).z;
				fragment_unnamed_9 = float4(fragment_unnamed_9.xw.x, fragment_unnamed_9.y, fragment_unnamed_9.z, fragment_unnamed_9.xw.y);
				float2 fragment_unnamed_542 = clamp(fragment_unnamed_9.xw, 0.0f.xx, 1.0f.xx);
				fragment_unnamed_9 = float4(fragment_unnamed_542.x, fragment_unnamed_9.y, fragment_unnamed_9.z, fragment_unnamed_542.y);
				fragment_unnamed_9.x += fragment_unnamed_9.x;
				fragment_unnamed_9.x = dot(fragment_unnamed_9.ww, fragment_unnamed_9.xx);
				fragment_unnamed_9.x *= fragment_unnamed_354.y;
				fragment_unnamed_9.x = dot(_HueSatCon.yy, fragment_unnamed_9.xx);
				float3 fragment_unnamed_577 = (fragment_unnamed_9.xxx * fragment_unnamed_28.xyz) + fragment_unnamed_354.xxx;
				fragment_unnamed_9 = float4(fragment_unnamed_577.x, fragment_unnamed_577.y, fragment_unnamed_577.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_584 = clamp(fragment_unnamed_9.xyz, 0.0f.xxx, 1.0f.xxx);
				fragment_unnamed_9 = float4(fragment_unnamed_584.x, fragment_unnamed_584.y, fragment_unnamed_584.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_591 = fragment_unnamed_9.xyz + 0.00390625f.xxx;
				fragment_unnamed_9 = float4(fragment_unnamed_591.x, fragment_unnamed_591.y, fragment_unnamed_591.z, fragment_unnamed_9.w);
				fragment_unnamed_9.w = 0.75f;
				fragment_unnamed_28.x = _Curves.Sample(sampler_Curves, fragment_unnamed_9.xw).w;
				fragment_unnamed_28.x = fragment_unnamed_28.x;
				fragment_unnamed_28.x = clamp(fragment_unnamed_28.x, 0.0f, 1.0f);
				fragment_unnamed_345.x = _Curves.Sample(sampler_Curves, fragment_unnamed_9.yw).w;
				fragment_unnamed_345.y = _Curves.Sample(sampler_Curves, fragment_unnamed_9.zw).w;
				fragment_unnamed_28 = float4(fragment_unnamed_28.x, fragment_unnamed_345.xy.x, fragment_unnamed_345.xy.y, fragment_unnamed_28.w);
				float2 fragment_unnamed_635 = clamp(fragment_unnamed_28.yz, 0.0f.xx, 1.0f.xx);
				fragment_unnamed_28 = float4(fragment_unnamed_28.x, fragment_unnamed_635.x, fragment_unnamed_635.y, fragment_unnamed_28.w);
				float3 fragment_unnamed_640 = fragment_unnamed_28.xyz + 0.00390625f.xxx;
				fragment_unnamed_9 = float4(fragment_unnamed_640.x, fragment_unnamed_640.y, fragment_unnamed_640.z, fragment_unnamed_9.w);
				fragment_unnamed_9.w = 0.75f;
				fragment_unnamed_9.x = _Curves.Sample(sampler_Curves, fragment_unnamed_9.xw).x;
				fragment_output_0.x = fragment_unnamed_9.x;
				fragment_output_0.x = clamp(fragment_output_0.x, 0.0f, 1.0f);
				fragment_unnamed_9.x = _Curves.Sample(sampler_Curves, fragment_unnamed_9.yw).y;
				fragment_unnamed_9.y = _Curves.Sample(sampler_Curves, fragment_unnamed_9.zw).z;
				fragment_output_0 = float4(fragment_output_0.x, fragment_unnamed_9.xy.x, fragment_unnamed_9.xy.y, fragment_output_0.w);
				float2 fragment_unnamed_686 = clamp(fragment_output_0.yz, 0.0f.xx, 1.0f.xx);
				fragment_output_0 = float4(fragment_output_0.x, fragment_unnamed_686.x, fragment_unnamed_686.y, fragment_output_0.w);
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


			float4 _Lut2D_Params;
			float3 _ColorBalance;
			float3 _ColorFilter;
			float3 _HueSatCon;
			float _Brightness;
			float3 _ChannelMixerRed;
			float3 _ChannelMixerGreen;
			float3 _ChannelMixerBlue;
			float3 _Lift;
			float3 _InvGamma;
			float3 _Gain;

			static float4 fragment_uniform_buffer_0[39];
			Texture2D<float4> _Curves;
			SamplerState sampler_Curves;

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
				precise float fragment_unnamed_41 = (-0.0f) - fragment_uniform_buffer_0[28u].y;
				precise float fragment_unnamed_44 = (-0.0f) - fragment_uniform_buffer_0[28u].z;
				precise float fragment_unnamed_45 = fragment_input_1.x + fragment_unnamed_41;
				precise float fragment_unnamed_46 = fragment_input_1.y + fragment_unnamed_44;
				precise float fragment_unnamed_50 = fragment_unnamed_45 * fragment_uniform_buffer_0[28u].x;
				float fragment_unnamed_52 = frac(fragment_unnamed_50);
				precise float fragment_unnamed_56 = fragment_unnamed_52 / fragment_uniform_buffer_0[28u].x;
				precise float fragment_unnamed_57 = (-0.0f) - fragment_unnamed_56;
				precise float fragment_unnamed_58 = fragment_unnamed_45 + fragment_unnamed_57;
				precise float fragment_unnamed_62 = fragment_unnamed_52 * fragment_uniform_buffer_0[28u].w;
				precise float fragment_unnamed_63 = fragment_unnamed_46 * fragment_uniform_buffer_0[28u].w;
				precise float fragment_unnamed_64 = fragment_unnamed_58 * fragment_uniform_buffer_0[28u].w;
				float fragment_unnamed_76 = mad(mad(fragment_unnamed_62, fragment_uniform_buffer_0[32u].w, -0.21763764321804046630859375f), fragment_uniform_buffer_0[32u].z, 0.21763764321804046630859375f);
				float fragment_unnamed_78 = mad(mad(fragment_unnamed_63, fragment_uniform_buffer_0[32u].w, -0.21763764321804046630859375f), fragment_uniform_buffer_0[32u].z, 0.21763764321804046630859375f);
				float fragment_unnamed_79 = mad(mad(fragment_unnamed_64, fragment_uniform_buffer_0[32u].w, -0.21763764321804046630859375f), fragment_uniform_buffer_0[32u].z, 0.21763764321804046630859375f);
				precise float fragment_unnamed_105 = dot(float3(0.390404999256134033203125f, 0.549941003322601318359375f, 0.008926319889724254608154296875f), float3(fragment_unnamed_76, fragment_unnamed_78, fragment_unnamed_79)) * fragment_uniform_buffer_0[30u].x;
				precise float fragment_unnamed_106 = dot(float3(0.070841602981090545654296875f, 0.963172018527984619140625f, 0.001357750035822391510009765625f), float3(fragment_unnamed_76, fragment_unnamed_78, fragment_unnamed_79)) * fragment_uniform_buffer_0[30u].y;
				precise float fragment_unnamed_107 = dot(float3(0.02310819923877716064453125f, 0.1280210018157958984375f, 0.936245024204254150390625f), float3(fragment_unnamed_76, fragment_unnamed_78, fragment_unnamed_79)) * fragment_uniform_buffer_0[30u].z;
				precise float fragment_unnamed_132 = dot(float3(2.85846996307373046875f, -1.62879002094268798828125f, -0.0248910002410411834716796875f), float3(fragment_unnamed_105, fragment_unnamed_106, fragment_unnamed_107)) * fragment_uniform_buffer_0[31u].x;
				precise float fragment_unnamed_133 = dot(float3(-0.21018199622631072998046875f, 1.1582000255584716796875f, 0.0003242809907533228397369384765625f), float3(fragment_unnamed_105, fragment_unnamed_106, fragment_unnamed_107)) * fragment_uniform_buffer_0[31u].y;
				precise float fragment_unnamed_134 = dot(float3(-0.0418119989335536956787109375f, -0.118169002234935760498046875f, 1.0686700344085693359375f), float3(fragment_unnamed_105, fragment_unnamed_106, fragment_unnamed_107)) * fragment_uniform_buffer_0[31u].z;
				float fragment_unnamed_174 = mad(dot(float3(fragment_unnamed_132, fragment_unnamed_133, fragment_unnamed_134), float3(fragment_uniform_buffer_0[33u].xyz)), fragment_uniform_buffer_0[38u].x, fragment_uniform_buffer_0[36u].x);
				float fragment_unnamed_175 = mad(dot(float3(fragment_unnamed_132, fragment_unnamed_133, fragment_unnamed_134), float3(fragment_uniform_buffer_0[34u].xyz)), fragment_uniform_buffer_0[38u].y, fragment_uniform_buffer_0[36u].y);
				float fragment_unnamed_176 = mad(dot(float3(fragment_unnamed_132, fragment_unnamed_133, fragment_unnamed_134), float3(fragment_uniform_buffer_0[35u].xyz)), fragment_uniform_buffer_0[38u].z, fragment_uniform_buffer_0[36u].z);
				precise float fragment_unnamed_204 = log2(abs(fragment_unnamed_174)) * fragment_uniform_buffer_0[37u].x;
				precise float fragment_unnamed_205 = log2(abs(fragment_unnamed_175)) * fragment_uniform_buffer_0[37u].y;
				precise float fragment_unnamed_206 = log2(abs(fragment_unnamed_176)) * fragment_uniform_buffer_0[37u].z;
				precise float fragment_unnamed_210 = mad(clamp(mad(fragment_unnamed_174, 3.4028234663852885981170418348452e+38f, 0.5f), 0.0f, 1.0f), 2.0f, -1.0f) * exp2(fragment_unnamed_204);
				precise float fragment_unnamed_211 = mad(clamp(mad(fragment_unnamed_175, 3.4028234663852885981170418348452e+38f, 0.5f), 0.0f, 1.0f), 2.0f, -1.0f) * exp2(fragment_unnamed_205);
				precise float fragment_unnamed_212 = mad(clamp(mad(fragment_unnamed_176, 3.4028234663852885981170418348452e+38f, 0.5f), 0.0f, 1.0f), 2.0f, -1.0f) * exp2(fragment_unnamed_206);
				float fragment_unnamed_213 = max(fragment_unnamed_210, 0.0f);
				float fragment_unnamed_214 = max(fragment_unnamed_211, 0.0f);
				float fragment_unnamed_215 = max(fragment_unnamed_212, 0.0f);
				float fragment_unnamed_222 = asfloat(((fragment_unnamed_214 >= fragment_unnamed_215) ? 4294967295u : 0u) & 1065353216u);
				precise float fragment_unnamed_223 = (-0.0f) - fragment_unnamed_215;
				precise float fragment_unnamed_224 = (-0.0f) - fragment_unnamed_214;
				precise float fragment_unnamed_225 = fragment_unnamed_214 + fragment_unnamed_223;
				precise float fragment_unnamed_226 = fragment_unnamed_215 + fragment_unnamed_224;
				float fragment_unnamed_233 = mad(fragment_unnamed_222, fragment_unnamed_225, fragment_unnamed_215);
				float fragment_unnamed_234 = mad(fragment_unnamed_222, fragment_unnamed_226, fragment_unnamed_214);
				float fragment_unnamed_235 = mad(fragment_unnamed_222, asfloat(3212836864u), asfloat(1059760811u));
				float fragment_unnamed_240 = asfloat(((fragment_unnamed_213 >= fragment_unnamed_233) ? 4294967295u : 0u) & 1065353216u);
				precise float fragment_unnamed_247 = (-0.0f) - fragment_unnamed_233;
				precise float fragment_unnamed_248 = (-0.0f) - fragment_unnamed_234;
				precise float fragment_unnamed_249 = (-0.0f) - fragment_unnamed_235;
				precise float fragment_unnamed_250 = (-0.0f) - fragment_unnamed_213;
				precise float fragment_unnamed_251 = fragment_unnamed_247 + fragment_unnamed_213;
				precise float fragment_unnamed_252 = fragment_unnamed_248 + fragment_unnamed_234;
				precise float fragment_unnamed_253 = fragment_unnamed_249 + mad(fragment_unnamed_222, asfloat(1065353216u), asfloat(3212836864u));
				precise float fragment_unnamed_254 = fragment_unnamed_250 + fragment_unnamed_233;
				float fragment_unnamed_255 = mad(fragment_unnamed_240, fragment_unnamed_251, fragment_unnamed_233);
				float fragment_unnamed_256 = mad(fragment_unnamed_240, fragment_unnamed_252, fragment_unnamed_234);
				float fragment_unnamed_258 = mad(fragment_unnamed_240, fragment_unnamed_254, fragment_unnamed_213);
				precise float fragment_unnamed_260 = (-0.0f) - min(fragment_unnamed_256, fragment_unnamed_258);
				precise float fragment_unnamed_261 = fragment_unnamed_255 + fragment_unnamed_260;
				precise float fragment_unnamed_265 = (-0.0f) - fragment_unnamed_256;
				precise float fragment_unnamed_266 = fragment_unnamed_265 + fragment_unnamed_258;
				precise float fragment_unnamed_267 = fragment_unnamed_266 / mad(fragment_unnamed_261, 6.0f, 9.9999997473787516355514526367188e-05f);
				precise float fragment_unnamed_268 = fragment_unnamed_267 + mad(fragment_unnamed_240, fragment_unnamed_253, fragment_unnamed_235);
				float fragment_unnamed_269 = abs(fragment_unnamed_268);
				precise float fragment_unnamed_273 = fragment_unnamed_269 + fragment_uniform_buffer_0[32u].x;
				precise float fragment_unnamed_287 = fragment_unnamed_273 + clamp(_Curves.SampleLevel(sampler_Curves, float2(fragment_unnamed_273, asfloat(1048576000u)), 0.0f).x, 0.0f, 1.0f);
				precise float fragment_unnamed_288 = fragment_unnamed_287 + (-0.5f);
				precise float fragment_unnamed_290 = fragment_unnamed_287 + 0.5f;
				precise float fragment_unnamed_291 = fragment_unnamed_287 + (-1.5f);
				float fragment_unnamed_300 = asfloat((fragment_unnamed_288 < 0.0f) ? asuint(fragment_unnamed_290) : ((1.0f < fragment_unnamed_288) ? asuint(fragment_unnamed_291) : asuint(fragment_unnamed_288)));
				precise float fragment_unnamed_301 = fragment_unnamed_300 + 1.0f;
				precise float fragment_unnamed_302 = fragment_unnamed_300 + 0.666666686534881591796875f;
				precise float fragment_unnamed_304 = fragment_unnamed_300 + 0.3333333432674407958984375f;
				precise float fragment_unnamed_316 = abs(mad(frac(fragment_unnamed_301), 6.0f, -3.0f)) + (-1.0f);
				precise float fragment_unnamed_317 = abs(mad(frac(fragment_unnamed_302), 6.0f, -3.0f)) + (-1.0f);
				precise float fragment_unnamed_318 = abs(mad(frac(fragment_unnamed_304), 6.0f, -3.0f)) + (-1.0f);
				precise float fragment_unnamed_322 = clamp(fragment_unnamed_316, 0.0f, 1.0f) + (-1.0f);
				precise float fragment_unnamed_323 = clamp(fragment_unnamed_317, 0.0f, 1.0f) + (-1.0f);
				precise float fragment_unnamed_324 = clamp(fragment_unnamed_318, 0.0f, 1.0f) + (-1.0f);
				precise float fragment_unnamed_325 = fragment_unnamed_255 + 9.9999997473787516355514526367188e-05f;
				precise float fragment_unnamed_326 = fragment_unnamed_261 / fragment_unnamed_325;
				float fragment_unnamed_327 = mad(fragment_unnamed_326, fragment_unnamed_322, 1.0f);
				float fragment_unnamed_328 = mad(fragment_unnamed_326, fragment_unnamed_323, 1.0f);
				float fragment_unnamed_329 = mad(fragment_unnamed_326, fragment_unnamed_324, 1.0f);
				precise float fragment_unnamed_330 = fragment_unnamed_327 * fragment_unnamed_255;
				precise float fragment_unnamed_331 = fragment_unnamed_328 * fragment_unnamed_255;
				precise float fragment_unnamed_332 = fragment_unnamed_329 * fragment_unnamed_255;
				float fragment_unnamed_333 = dot(float3(fragment_unnamed_330, fragment_unnamed_331, fragment_unnamed_332), float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f));
				precise float fragment_unnamed_336 = (-0.0f) - fragment_unnamed_333;
				float fragment_unnamed_349 = clamp(_Curves.SampleLevel(sampler_Curves, float2(fragment_unnamed_269, asfloat(1048576000u)), 0.0f).y, 0.0f, 1.0f);
				precise float fragment_unnamed_350 = fragment_unnamed_349 + fragment_unnamed_349;
				precise float fragment_unnamed_354 = dot(clamp(_Curves.SampleLevel(sampler_Curves, float2(fragment_unnamed_326, asfloat(1048576000u)), 0.0f).z, 0.0f, 1.0f).xx, fragment_unnamed_350.xx) * clamp(_Curves.SampleLevel(sampler_Curves, float2(dot(float3(fragment_unnamed_213, fragment_unnamed_214, fragment_unnamed_215), float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)), asfloat(1048576000u)), 0.0f).w, 0.0f, 1.0f);
				float fragment_unnamed_358 = dot(fragment_uniform_buffer_0[32u].y.xx, fragment_unnamed_354.xx);
				precise float fragment_unnamed_367 = clamp(mad(fragment_unnamed_358, mad(fragment_unnamed_255, fragment_unnamed_327, fragment_unnamed_336), fragment_unnamed_333), 0.0f, 1.0f) + 0.00390625f;
				precise float fragment_unnamed_369 = clamp(mad(fragment_unnamed_358, mad(fragment_unnamed_255, fragment_unnamed_328, fragment_unnamed_336), fragment_unnamed_333), 0.0f, 1.0f) + 0.00390625f;
				precise float fragment_unnamed_370 = clamp(mad(fragment_unnamed_358, mad(fragment_unnamed_255, fragment_unnamed_329, fragment_unnamed_336), fragment_unnamed_333), 0.0f, 1.0f) + 0.00390625f;
				float fragment_unnamed_371 = asfloat(1061158912u);
				precise float fragment_unnamed_385 = clamp(_Curves.Sample(sampler_Curves, float2(fragment_unnamed_367, fragment_unnamed_371)).w, 0.0f, 1.0f) + 0.00390625f;
				precise float fragment_unnamed_386 = clamp(_Curves.Sample(sampler_Curves, float2(fragment_unnamed_369, fragment_unnamed_371)).w, 0.0f, 1.0f) + 0.00390625f;
				precise float fragment_unnamed_387 = clamp(_Curves.Sample(sampler_Curves, float2(fragment_unnamed_370, fragment_unnamed_371)).w, 0.0f, 1.0f) + 0.00390625f;
				float fragment_unnamed_388 = asfloat(1061158912u);
				fragment_output_0.x = clamp(_Curves.Sample(sampler_Curves, float2(fragment_unnamed_385, fragment_unnamed_388)).x, 0.0f, 1.0f);
				fragment_output_0.z = clamp(_Curves.Sample(sampler_Curves, float2(fragment_unnamed_387, fragment_unnamed_388)).z, 0.0f, 1.0f);
				fragment_output_0.y = clamp(_Curves.Sample(sampler_Curves, float2(fragment_unnamed_386, fragment_unnamed_388)).y, 0.0f, 1.0f);
				fragment_output_0.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[28] = float4(_Lut2D_Params[0], _Lut2D_Params[1], _Lut2D_Params[2], _Lut2D_Params[3]);

				fragment_uniform_buffer_0[30] = float4(_ColorBalance[0], _ColorBalance[1], _ColorBalance[2], fragment_uniform_buffer_0[30][3]);

				fragment_uniform_buffer_0[31] = float4(_ColorFilter[0], _ColorFilter[1], _ColorFilter[2], fragment_uniform_buffer_0[31][3]);

				fragment_uniform_buffer_0[32] = float4(_HueSatCon[0], _HueSatCon[1], _HueSatCon[2], fragment_uniform_buffer_0[32][3]);

				fragment_uniform_buffer_0[32] = float4(fragment_uniform_buffer_0[32][0], fragment_uniform_buffer_0[32][1], fragment_uniform_buffer_0[32][2], _Brightness);

				fragment_uniform_buffer_0[33] = float4(_ChannelMixerRed[0], _ChannelMixerRed[1], _ChannelMixerRed[2], fragment_uniform_buffer_0[33][3]);

				fragment_uniform_buffer_0[34] = float4(_ChannelMixerGreen[0], _ChannelMixerGreen[1], _ChannelMixerGreen[2], fragment_uniform_buffer_0[34][3]);

				fragment_uniform_buffer_0[35] = float4(_ChannelMixerBlue[0], _ChannelMixerBlue[1], _ChannelMixerBlue[2], fragment_uniform_buffer_0[35][3]);

				fragment_uniform_buffer_0[36] = float4(_Lift[0], _Lift[1], _Lift[2], fragment_uniform_buffer_0[36][3]);

				fragment_uniform_buffer_0[37] = float4(_InvGamma[0], _InvGamma[1], _InvGamma[2], fragment_uniform_buffer_0[37][3]);

				fragment_uniform_buffer_0[38] = float4(_Gain[0], _Gain[1], _Gain[2], fragment_uniform_buffer_0[38][3]);

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
			GpuProgramID 112774

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

			float4 _Lut2D_Params;
			float4 _UserLut2D_Params;
			float3 _ColorBalance;
			float3 _ColorFilter;
			float3 _HueSatCon;
			float _Brightness;
			float3 _ChannelMixerRed;
			float3 _ChannelMixerGreen;
			float3 _ChannelMixerBlue;
			float3 _Lift;
			float3 _InvGamma;
			float3 _Gain;

			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;
			Texture2D<float4> _Curves;
			SamplerState sampler_Curves;

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
			static float4 fragment_unnamed_24;
			static float4 fragment_unnamed_38;
			static float4 fragment_unnamed_71;
			static float2 fragment_unnamed_81;
			static float2 fragment_unnamed_127;
			static float3 fragment_unnamed_154;
			static bool fragment_unnamed_390;
			static float2 fragment_unnamed_438;
			static float3 fragment_unnamed_474;
			static float fragment_unnamed_482;
			static bool fragment_unnamed_617;
			static float fragment_unnamed_621;
			static bool fragment_unnamed_633;

			void frag_main()
			{
				fragment_unnamed_9.x = _UserLut2D_Params.y;
				float2 fragment_unnamed_35 = fragment_input_0 + (-_Lut2D_Params.yz);
				fragment_unnamed_24 = float4(fragment_unnamed_24.x, fragment_unnamed_35.x, fragment_unnamed_35.y, fragment_unnamed_24.w);
				fragment_unnamed_38.x = fragment_unnamed_24.y * _Lut2D_Params.x;
				fragment_unnamed_24.x = frac(fragment_unnamed_38.x);
				fragment_unnamed_38.x = fragment_unnamed_24.x / _Lut2D_Params.x;
				fragment_unnamed_24.w = fragment_unnamed_24.y + (-fragment_unnamed_38.x);
				float3 fragment_unnamed_68 = fragment_unnamed_24.xzw * _Lut2D_Params.www;
				fragment_unnamed_38 = float4(fragment_unnamed_68.x, fragment_unnamed_68.y, fragment_unnamed_68.z, fragment_unnamed_38.w);
				float3 fragment_unnamed_77 = fragment_unnamed_38.zxy * _UserLut2D_Params.zzz;
				fragment_unnamed_71 = float4(fragment_unnamed_77.x, fragment_unnamed_77.y, fragment_unnamed_77.z, fragment_unnamed_71.w);
				fragment_unnamed_81.x = floor(fragment_unnamed_71.x);
				float2 fragment_unnamed_91 = _UserLut2D_Params.xy * 0.5f.xx;
				fragment_unnamed_71 = float4(fragment_unnamed_91.x, fragment_unnamed_71.y, fragment_unnamed_71.z, fragment_unnamed_91.y);
				float2 fragment_unnamed_102 = (fragment_unnamed_71.yz * _UserLut2D_Params.xy) + fragment_unnamed_71.xw;
				fragment_unnamed_71 = float4(fragment_unnamed_71.x, fragment_unnamed_102.x, fragment_unnamed_102.y, fragment_unnamed_71.w);
				fragment_unnamed_71.x = (fragment_unnamed_81.x * _UserLut2D_Params.y) + fragment_unnamed_71.y;
				fragment_unnamed_81.x = (fragment_unnamed_38.z * _UserLut2D_Params.z) + (-fragment_unnamed_81.x);
				fragment_unnamed_9.y = 0.0f;
				fragment_unnamed_127.y = 0.25f;
				float2 fragment_unnamed_134 = fragment_unnamed_9.xy + fragment_unnamed_71.xz;
				fragment_unnamed_9 = float4(fragment_unnamed_134.x, fragment_unnamed_134.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_150 = _MainTex.Sample(sampler_MainTex, fragment_unnamed_71.xz).xyz;
				fragment_unnamed_71 = float4(fragment_unnamed_150.x, fragment_unnamed_150.y, fragment_unnamed_150.z, fragment_unnamed_71.w);
				fragment_unnamed_154 = _MainTex.Sample(sampler_MainTex, fragment_unnamed_9.xy).xyz;
				fragment_unnamed_154 = (-fragment_unnamed_71.xyz) + fragment_unnamed_154;
				float3 fragment_unnamed_173 = (fragment_unnamed_81.xxx * fragment_unnamed_154) + fragment_unnamed_71.xyz;
				fragment_unnamed_71 = float4(fragment_unnamed_173.x, fragment_unnamed_173.y, fragment_unnamed_173.z, fragment_unnamed_71.w);
				float3 fragment_unnamed_185 = ((-fragment_unnamed_24.xzw) * _Lut2D_Params.www) + fragment_unnamed_71.xyz;
				fragment_unnamed_24 = float4(fragment_unnamed_185.x, fragment_unnamed_185.y, fragment_unnamed_185.z, fragment_unnamed_24.w);
				float3 fragment_unnamed_196 = (_UserLut2D_Params.www * fragment_unnamed_24.xyz) + fragment_unnamed_38.xyz;
				fragment_unnamed_24 = float4(fragment_unnamed_196.x, fragment_unnamed_196.y, fragment_unnamed_196.z, fragment_unnamed_24.w);
				float3 fragment_unnamed_216 = (fragment_unnamed_24.xyz * float3(float3(_Brightness, _Brightness, _Brightness))) + (-0.21763764321804046630859375f).xxx;
				fragment_unnamed_24 = float4(fragment_unnamed_216.x, fragment_unnamed_216.y, fragment_unnamed_216.z, fragment_unnamed_24.w);
				float3 fragment_unnamed_229 = (fragment_unnamed_24.xyz * _HueSatCon.zzz) + 0.21763764321804046630859375f.xxx;
				fragment_unnamed_24 = float4(fragment_unnamed_229.x, fragment_unnamed_229.y, fragment_unnamed_229.z, fragment_unnamed_24.w);
				fragment_unnamed_38.x = dot(float3(0.390404999256134033203125f, 0.549941003322601318359375f, 0.008926319889724254608154296875f), fragment_unnamed_24.xyz);
				fragment_unnamed_38.y = dot(float3(0.070841602981090545654296875f, 0.963172018527984619140625f, 0.001357750035822391510009765625f), fragment_unnamed_24.xyz);
				fragment_unnamed_38.z = dot(float3(0.02310819923877716064453125f, 0.1280210018157958984375f, 0.936245024204254150390625f), fragment_unnamed_24.xyz);
				float3 fragment_unnamed_261 = fragment_unnamed_38.xyz * _ColorBalance;
				fragment_unnamed_24 = float4(fragment_unnamed_261.x, fragment_unnamed_261.y, fragment_unnamed_261.z, fragment_unnamed_24.w);
				fragment_unnamed_38.x = dot(float3(2.85846996307373046875f, -1.62879002094268798828125f, -0.0248910002410411834716796875f), fragment_unnamed_24.xyz);
				fragment_unnamed_38.y = dot(float3(-0.21018199622631072998046875f, 1.1582000255584716796875f, 0.0003242809907533228397369384765625f), fragment_unnamed_24.xyz);
				fragment_unnamed_38.z = dot(float3(-0.0418119989335536956787109375f, -0.118169002234935760498046875f, 1.0686700344085693359375f), fragment_unnamed_24.xyz);
				float3 fragment_unnamed_293 = fragment_unnamed_38.xyz * _ColorFilter;
				fragment_unnamed_24 = float4(fragment_unnamed_293.x, fragment_unnamed_293.y, fragment_unnamed_293.z, fragment_unnamed_24.w);
				fragment_unnamed_38.x = dot(fragment_unnamed_24.xyz, _ChannelMixerRed);
				fragment_unnamed_38.y = dot(fragment_unnamed_24.xyz, _ChannelMixerGreen);
				fragment_unnamed_38.z = dot(fragment_unnamed_24.xyz, _ChannelMixerBlue);
				float3 fragment_unnamed_326 = (fragment_unnamed_38.xyz * _Gain) + _Lift;
				fragment_unnamed_24 = float4(fragment_unnamed_326.x, fragment_unnamed_326.y, fragment_unnamed_326.z, fragment_unnamed_24.w);
				float3 fragment_unnamed_332 = log2(abs(fragment_unnamed_24.xyz));
				fragment_unnamed_38 = float4(fragment_unnamed_332.x, fragment_unnamed_332.y, fragment_unnamed_332.z, fragment_unnamed_38.w);
				float3 fragment_unnamed_341 = (fragment_unnamed_24.xyz * 3.4028234663852885981170418348452e+38f.xxx) + 0.5f.xxx;
				fragment_unnamed_24 = float4(fragment_unnamed_341.x, fragment_unnamed_341.y, fragment_unnamed_341.z, fragment_unnamed_24.w);
				float3 fragment_unnamed_349 = clamp(fragment_unnamed_24.xyz, 0.0f.xxx, 1.0f.xxx);
				fragment_unnamed_24 = float4(fragment_unnamed_349.x, fragment_unnamed_349.y, fragment_unnamed_349.z, fragment_unnamed_24.w);
				float3 fragment_unnamed_359 = (fragment_unnamed_24.xyz * 2.0f.xxx) + (-1.0f).xxx;
				fragment_unnamed_24 = float4(fragment_unnamed_359.x, fragment_unnamed_359.y, fragment_unnamed_359.z, fragment_unnamed_24.w);
				float3 fragment_unnamed_367 = fragment_unnamed_38.xyz * _InvGamma;
				fragment_unnamed_38 = float4(fragment_unnamed_367.x, fragment_unnamed_367.y, fragment_unnamed_367.z, fragment_unnamed_38.w);
				float3 fragment_unnamed_372 = exp2(fragment_unnamed_38.xyz);
				fragment_unnamed_38 = float4(fragment_unnamed_372.x, fragment_unnamed_372.y, fragment_unnamed_372.z, fragment_unnamed_38.w);
				float3 fragment_unnamed_379 = fragment_unnamed_24.xyz * fragment_unnamed_38.xyz;
				fragment_unnamed_24 = float4(fragment_unnamed_379.x, fragment_unnamed_379.y, fragment_unnamed_379.z, fragment_unnamed_24.w);
				float3 fragment_unnamed_385 = max(fragment_unnamed_24.xyz, 0.0f.xxx);
				fragment_unnamed_24 = float4(fragment_unnamed_385.x, fragment_unnamed_385.y, fragment_unnamed_385.z, fragment_unnamed_24.w);
				fragment_unnamed_390 = fragment_unnamed_24.y >= fragment_unnamed_24.z;
				fragment_unnamed_9.x = float(fragment_unnamed_390);
				fragment_unnamed_38 = float4(fragment_unnamed_24.zy.x, fragment_unnamed_24.zy.y, fragment_unnamed_38.z, fragment_unnamed_38.w);
				float2 fragment_unnamed_408 = fragment_unnamed_24.yz + (-fragment_unnamed_38.xy);
				fragment_unnamed_71 = float4(fragment_unnamed_408.x, fragment_unnamed_408.y, fragment_unnamed_71.z, fragment_unnamed_71.w);
				fragment_unnamed_38.z = -1.0f;
				fragment_unnamed_38.w = 0.666666686534881591796875f;
				fragment_unnamed_71.z = 1.0f;
				fragment_unnamed_71.w = -1.0f;
				fragment_unnamed_38 = (fragment_unnamed_9.xxxx * fragment_unnamed_71.xywz) + fragment_unnamed_38.xywz;
				fragment_unnamed_390 = fragment_unnamed_24.x >= fragment_unnamed_38.x;
				fragment_unnamed_9.x = float(fragment_unnamed_390);
				fragment_unnamed_71.z = fragment_unnamed_38.w;
				fragment_unnamed_38.w = fragment_unnamed_24.x;
				fragment_unnamed_438.x = dot(fragment_unnamed_24.xyz, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f));
				fragment_unnamed_71 = float4(fragment_unnamed_38.wyx.x, fragment_unnamed_38.wyx.y, fragment_unnamed_71.z, fragment_unnamed_38.wyx.z);
				fragment_unnamed_71 = (-fragment_unnamed_38) + fragment_unnamed_71;
				fragment_unnamed_38 = (fragment_unnamed_9.xxxx * fragment_unnamed_71) + fragment_unnamed_38;
				fragment_unnamed_9.x = min(fragment_unnamed_38.y, fragment_unnamed_38.w);
				fragment_unnamed_9.x = (-fragment_unnamed_9.x) + fragment_unnamed_38.x;
				fragment_unnamed_474.x = (fragment_unnamed_9.x * 6.0f) + 9.9999997473787516355514526367188e-05f;
				fragment_unnamed_482 = (-fragment_unnamed_38.y) + fragment_unnamed_38.w;
				fragment_unnamed_474.x = fragment_unnamed_482 / fragment_unnamed_474.x;
				fragment_unnamed_474.x += fragment_unnamed_38.z;
				fragment_unnamed_127.x = abs(fragment_unnamed_474.x);
				fragment_unnamed_474.x = _Curves.SampleLevel(sampler_Curves, fragment_unnamed_127, 0.0f).y;
				fragment_unnamed_71.x = fragment_unnamed_127.x + _HueSatCon.x;
				fragment_unnamed_474.x = fragment_unnamed_474.x;
				fragment_unnamed_474.x = clamp(fragment_unnamed_474.x, 0.0f, 1.0f);
				fragment_unnamed_474.x += fragment_unnamed_474.x;
				fragment_unnamed_127.x = fragment_unnamed_38.x + 9.9999997473787516355514526367188e-05f;
				fragment_unnamed_24.x = fragment_unnamed_9.x / fragment_unnamed_127.x;
				fragment_unnamed_24.y = 0.25f;
				fragment_unnamed_438.y = 0.25f;
				fragment_unnamed_9.x = _Curves.SampleLevel(sampler_Curves, fragment_unnamed_24.xy, 0.0f).z;
				fragment_unnamed_9.z = _Curves.SampleLevel(sampler_Curves, fragment_unnamed_438, 0.0f).w;
				fragment_unnamed_9 = float4(fragment_unnamed_9.xz.x, fragment_unnamed_9.y, fragment_unnamed_9.xz.y, fragment_unnamed_9.w);
				float2 fragment_unnamed_567 = clamp(fragment_unnamed_9.xz, 0.0f.xx, 1.0f.xx);
				fragment_unnamed_9 = float4(fragment_unnamed_567.x, fragment_unnamed_9.y, fragment_unnamed_567.y, fragment_unnamed_9.w);
				fragment_unnamed_9.x = dot(fragment_unnamed_9.xx, fragment_unnamed_474.xx);
				fragment_unnamed_9.x *= fragment_unnamed_9.z;
				fragment_unnamed_9.x = dot(_HueSatCon.yy, fragment_unnamed_9.xx);
				fragment_unnamed_71.y = 0.25f;
				fragment_unnamed_474.x = _Curves.SampleLevel(sampler_Curves, fragment_unnamed_71.xy, 0.0f).x;
				fragment_unnamed_474.x = fragment_unnamed_474.x;
				fragment_unnamed_474.x = clamp(fragment_unnamed_474.x, 0.0f, 1.0f);
				fragment_unnamed_474.x = fragment_unnamed_71.x + fragment_unnamed_474.x;
				fragment_unnamed_474 = fragment_unnamed_474.xxx + float3(-0.5f, 0.5f, -1.5f);
				fragment_unnamed_617 = 1.0f < fragment_unnamed_474.x;
				float fragment_unnamed_624;
				if (fragment_unnamed_617)
				{
					fragment_unnamed_624 = fragment_unnamed_474.z;
				}
				else
				{
					fragment_unnamed_624 = fragment_unnamed_474.x;
				}
				fragment_unnamed_621 = fragment_unnamed_624;
				fragment_unnamed_633 = fragment_unnamed_474.x < 0.0f;
				float fragment_unnamed_638;
				if (fragment_unnamed_633)
				{
					fragment_unnamed_638 = fragment_unnamed_474.y;
				}
				else
				{
					fragment_unnamed_638 = fragment_unnamed_621;
				}
				fragment_unnamed_474.x = fragment_unnamed_638;
				fragment_unnamed_474 = fragment_unnamed_474.xxx + float3(1.0f, 0.666666686534881591796875f, 0.3333333432674407958984375f);
				fragment_unnamed_474 = frac(fragment_unnamed_474);
				fragment_unnamed_474 = (fragment_unnamed_474 * 6.0f.xxx) + (-3.0f).xxx;
				fragment_unnamed_474 = abs(fragment_unnamed_474) + (-1.0f).xxx;
				fragment_unnamed_474 = clamp(fragment_unnamed_474, 0.0f.xxx, 1.0f.xxx);
				fragment_unnamed_474 += (-1.0f).xxx;
				fragment_unnamed_474 = (fragment_unnamed_24.xxx * fragment_unnamed_474) + 1.0f.xxx;
				float3 fragment_unnamed_678 = fragment_unnamed_474 * fragment_unnamed_38.xxx;
				fragment_unnamed_24 = float4(fragment_unnamed_678.x, fragment_unnamed_678.y, fragment_unnamed_678.z, fragment_unnamed_24.w);
				fragment_unnamed_24.x = dot(fragment_unnamed_24.xyz, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f));
				fragment_unnamed_474 = (fragment_unnamed_38.xxx * fragment_unnamed_474) + (-fragment_unnamed_24.xxx);
				float3 fragment_unnamed_699 = (fragment_unnamed_9.xxx * fragment_unnamed_474) + fragment_unnamed_24.xxx;
				fragment_unnamed_9 = float4(fragment_unnamed_699.x, fragment_unnamed_699.y, fragment_unnamed_699.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_706 = clamp(fragment_unnamed_9.xyz, 0.0f.xxx, 1.0f.xxx);
				fragment_unnamed_9 = float4(fragment_unnamed_706.x, fragment_unnamed_706.y, fragment_unnamed_706.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_713 = fragment_unnamed_9.xyz + 0.00390625f.xxx;
				fragment_unnamed_9 = float4(fragment_unnamed_713.x, fragment_unnamed_713.y, fragment_unnamed_713.z, fragment_unnamed_9.w);
				fragment_unnamed_9.w = 0.75f;
				fragment_unnamed_24.x = _Curves.Sample(sampler_Curves, fragment_unnamed_9.xw).w;
				fragment_unnamed_24.x = fragment_unnamed_24.x;
				fragment_unnamed_24.x = clamp(fragment_unnamed_24.x, 0.0f, 1.0f);
				fragment_unnamed_81.x = _Curves.Sample(sampler_Curves, fragment_unnamed_9.yw).w;
				fragment_unnamed_81.y = _Curves.Sample(sampler_Curves, fragment_unnamed_9.zw).w;
				fragment_unnamed_24 = float4(fragment_unnamed_24.x, fragment_unnamed_81.x, fragment_unnamed_81.y, fragment_unnamed_24.w);
				float2 fragment_unnamed_756 = clamp(fragment_unnamed_24.yz, 0.0f.xx, 1.0f.xx);
				fragment_unnamed_24 = float4(fragment_unnamed_24.x, fragment_unnamed_756.x, fragment_unnamed_756.y, fragment_unnamed_24.w);
				float3 fragment_unnamed_761 = fragment_unnamed_24.xyz + 0.00390625f.xxx;
				fragment_unnamed_9 = float4(fragment_unnamed_761.x, fragment_unnamed_761.y, fragment_unnamed_761.z, fragment_unnamed_9.w);
				fragment_unnamed_9.w = 0.75f;
				fragment_unnamed_9.x = _Curves.Sample(sampler_Curves, fragment_unnamed_9.xw).x;
				fragment_output_0.x = fragment_unnamed_9.x;
				fragment_output_0.x = clamp(fragment_output_0.x, 0.0f, 1.0f);
				fragment_unnamed_9.x = _Curves.Sample(sampler_Curves, fragment_unnamed_9.yw).y;
				fragment_unnamed_9.y = _Curves.Sample(sampler_Curves, fragment_unnamed_9.zw).z;
				fragment_output_0 = float4(fragment_output_0.x, fragment_unnamed_9.xy.x, fragment_unnamed_9.xy.y, fragment_output_0.w);
				float2 fragment_unnamed_807 = clamp(fragment_output_0.yz, 0.0f.xx, 1.0f.xx);
				fragment_output_0 = float4(fragment_output_0.x, fragment_unnamed_807.x, fragment_unnamed_807.y, fragment_output_0.w);
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


			float4 _Lut2D_Params;
			float4 _UserLut2D_Params;
			float3 _ColorBalance;
			float3 _ColorFilter;
			float3 _HueSatCon;
			float _Brightness;
			float3 _ChannelMixerRed;
			float3 _ChannelMixerGreen;
			float3 _ChannelMixerBlue;
			float3 _Lift;
			float3 _InvGamma;
			float3 _Gain;

			static float4 fragment_uniform_buffer_0[39];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _Curves;
			SamplerState sampler_MainTex;
			SamplerState sampler_Curves;

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
				precise float fragment_unnamed_52 = (-0.0f) - fragment_uniform_buffer_0[28u].y;
				precise float fragment_unnamed_55 = (-0.0f) - fragment_uniform_buffer_0[28u].z;
				precise float fragment_unnamed_56 = fragment_input_1.x + fragment_unnamed_52;
				precise float fragment_unnamed_57 = fragment_input_1.y + fragment_unnamed_55;
				precise float fragment_unnamed_61 = fragment_unnamed_56 * fragment_uniform_buffer_0[28u].x;
				float fragment_unnamed_63 = frac(fragment_unnamed_61);
				precise float fragment_unnamed_67 = fragment_unnamed_63 / fragment_uniform_buffer_0[28u].x;
				precise float fragment_unnamed_68 = (-0.0f) - fragment_unnamed_67;
				precise float fragment_unnamed_69 = fragment_unnamed_56 + fragment_unnamed_68;
				precise float fragment_unnamed_73 = fragment_unnamed_63 * fragment_uniform_buffer_0[28u].w;
				precise float fragment_unnamed_74 = fragment_unnamed_57 * fragment_uniform_buffer_0[28u].w;
				precise float fragment_unnamed_75 = fragment_unnamed_69 * fragment_uniform_buffer_0[28u].w;
				precise float fragment_unnamed_79 = fragment_unnamed_75 * fragment_uniform_buffer_0[29u].z;
				precise float fragment_unnamed_80 = fragment_unnamed_73 * fragment_uniform_buffer_0[29u].z;
				precise float fragment_unnamed_81 = fragment_unnamed_74 * fragment_uniform_buffer_0[29u].z;
				float fragment_unnamed_82 = floor(fragment_unnamed_79);
				precise float fragment_unnamed_87 = fragment_uniform_buffer_0[29u].x * 0.5f;
				precise float fragment_unnamed_89 = fragment_uniform_buffer_0[29u].y * 0.5f;
				float fragment_unnamed_95 = mad(fragment_unnamed_81, fragment_uniform_buffer_0[29u].y, fragment_unnamed_89);
				float fragment_unnamed_99 = mad(fragment_unnamed_82, fragment_uniform_buffer_0[29u].y, mad(fragment_unnamed_80, fragment_uniform_buffer_0[29u].x, fragment_unnamed_87));
				precise float fragment_unnamed_103 = (-0.0f) - fragment_unnamed_82;
				float fragment_unnamed_104 = mad(fragment_unnamed_75, fragment_uniform_buffer_0[29u].z, fragment_unnamed_103);
				precise float fragment_unnamed_108 = asfloat(asuint(fragment_uniform_buffer_0[29u]).y) + fragment_unnamed_99;
				precise float fragment_unnamed_109 = asfloat(0u) + fragment_unnamed_95;
				float4 fragment_unnamed_113 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_99, fragment_unnamed_95));
				float fragment_unnamed_115 = fragment_unnamed_113.x;
				float fragment_unnamed_116 = fragment_unnamed_113.y;
				float fragment_unnamed_117 = fragment_unnamed_113.z;
				float4 fragment_unnamed_118 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_108, fragment_unnamed_109));
				precise float fragment_unnamed_123 = (-0.0f) - fragment_unnamed_115;
				precise float fragment_unnamed_124 = (-0.0f) - fragment_unnamed_116;
				precise float fragment_unnamed_125 = (-0.0f) - fragment_unnamed_117;
				precise float fragment_unnamed_126 = fragment_unnamed_123 + fragment_unnamed_118.x;
				precise float fragment_unnamed_127 = fragment_unnamed_124 + fragment_unnamed_118.y;
				precise float fragment_unnamed_128 = fragment_unnamed_125 + fragment_unnamed_118.z;
				precise float fragment_unnamed_132 = (-0.0f) - fragment_unnamed_63;
				precise float fragment_unnamed_133 = (-0.0f) - fragment_unnamed_57;
				precise float fragment_unnamed_134 = (-0.0f) - fragment_unnamed_69;
				float fragment_unnamed_158 = mad(mad(mad(fragment_uniform_buffer_0[29u].w, mad(fragment_unnamed_132, fragment_uniform_buffer_0[28u].w, mad(fragment_unnamed_104, fragment_unnamed_126, fragment_unnamed_115)), fragment_unnamed_73), fragment_uniform_buffer_0[32u].w, -0.21763764321804046630859375f), fragment_uniform_buffer_0[32u].z, 0.21763764321804046630859375f);
				float fragment_unnamed_160 = mad(mad(mad(fragment_uniform_buffer_0[29u].w, mad(fragment_unnamed_133, fragment_uniform_buffer_0[28u].w, mad(fragment_unnamed_104, fragment_unnamed_127, fragment_unnamed_116)), fragment_unnamed_74), fragment_uniform_buffer_0[32u].w, -0.21763764321804046630859375f), fragment_uniform_buffer_0[32u].z, 0.21763764321804046630859375f);
				float fragment_unnamed_161 = mad(mad(mad(fragment_uniform_buffer_0[29u].w, mad(fragment_unnamed_134, fragment_uniform_buffer_0[28u].w, mad(fragment_unnamed_104, fragment_unnamed_128, fragment_unnamed_117)), fragment_unnamed_75), fragment_uniform_buffer_0[32u].w, -0.21763764321804046630859375f), fragment_uniform_buffer_0[32u].z, 0.21763764321804046630859375f);
				precise float fragment_unnamed_187 = dot(float3(0.390404999256134033203125f, 0.549941003322601318359375f, 0.008926319889724254608154296875f), float3(fragment_unnamed_158, fragment_unnamed_160, fragment_unnamed_161)) * fragment_uniform_buffer_0[30u].x;
				precise float fragment_unnamed_188 = dot(float3(0.070841602981090545654296875f, 0.963172018527984619140625f, 0.001357750035822391510009765625f), float3(fragment_unnamed_158, fragment_unnamed_160, fragment_unnamed_161)) * fragment_uniform_buffer_0[30u].y;
				precise float fragment_unnamed_189 = dot(float3(0.02310819923877716064453125f, 0.1280210018157958984375f, 0.936245024204254150390625f), float3(fragment_unnamed_158, fragment_unnamed_160, fragment_unnamed_161)) * fragment_uniform_buffer_0[30u].z;
				precise float fragment_unnamed_214 = dot(float3(2.85846996307373046875f, -1.62879002094268798828125f, -0.0248910002410411834716796875f), float3(fragment_unnamed_187, fragment_unnamed_188, fragment_unnamed_189)) * fragment_uniform_buffer_0[31u].x;
				precise float fragment_unnamed_215 = dot(float3(-0.21018199622631072998046875f, 1.1582000255584716796875f, 0.0003242809907533228397369384765625f), float3(fragment_unnamed_187, fragment_unnamed_188, fragment_unnamed_189)) * fragment_uniform_buffer_0[31u].y;
				precise float fragment_unnamed_216 = dot(float3(-0.0418119989335536956787109375f, -0.118169002234935760498046875f, 1.0686700344085693359375f), float3(fragment_unnamed_187, fragment_unnamed_188, fragment_unnamed_189)) * fragment_uniform_buffer_0[31u].z;
				float fragment_unnamed_256 = mad(dot(float3(fragment_unnamed_214, fragment_unnamed_215, fragment_unnamed_216), float3(fragment_uniform_buffer_0[33u].xyz)), fragment_uniform_buffer_0[38u].x, fragment_uniform_buffer_0[36u].x);
				float fragment_unnamed_257 = mad(dot(float3(fragment_unnamed_214, fragment_unnamed_215, fragment_unnamed_216), float3(fragment_uniform_buffer_0[34u].xyz)), fragment_uniform_buffer_0[38u].y, fragment_uniform_buffer_0[36u].y);
				float fragment_unnamed_258 = mad(dot(float3(fragment_unnamed_214, fragment_unnamed_215, fragment_unnamed_216), float3(fragment_uniform_buffer_0[35u].xyz)), fragment_uniform_buffer_0[38u].z, fragment_uniform_buffer_0[36u].z);
				precise float fragment_unnamed_284 = log2(abs(fragment_unnamed_256)) * fragment_uniform_buffer_0[37u].x;
				precise float fragment_unnamed_285 = log2(abs(fragment_unnamed_257)) * fragment_uniform_buffer_0[37u].y;
				precise float fragment_unnamed_286 = log2(abs(fragment_unnamed_258)) * fragment_uniform_buffer_0[37u].z;
				precise float fragment_unnamed_290 = mad(clamp(mad(fragment_unnamed_256, 3.4028234663852885981170418348452e+38f, 0.5f), 0.0f, 1.0f), 2.0f, -1.0f) * exp2(fragment_unnamed_284);
				precise float fragment_unnamed_291 = mad(clamp(mad(fragment_unnamed_257, 3.4028234663852885981170418348452e+38f, 0.5f), 0.0f, 1.0f), 2.0f, -1.0f) * exp2(fragment_unnamed_285);
				precise float fragment_unnamed_292 = mad(clamp(mad(fragment_unnamed_258, 3.4028234663852885981170418348452e+38f, 0.5f), 0.0f, 1.0f), 2.0f, -1.0f) * exp2(fragment_unnamed_286);
				float fragment_unnamed_293 = max(fragment_unnamed_290, 0.0f);
				float fragment_unnamed_294 = max(fragment_unnamed_291, 0.0f);
				float fragment_unnamed_295 = max(fragment_unnamed_292, 0.0f);
				float fragment_unnamed_302 = asfloat(((fragment_unnamed_294 >= fragment_unnamed_295) ? 4294967295u : 0u) & 1065353216u);
				precise float fragment_unnamed_303 = (-0.0f) - fragment_unnamed_295;
				precise float fragment_unnamed_304 = (-0.0f) - fragment_unnamed_294;
				precise float fragment_unnamed_305 = fragment_unnamed_294 + fragment_unnamed_303;
				precise float fragment_unnamed_306 = fragment_unnamed_295 + fragment_unnamed_304;
				float fragment_unnamed_313 = mad(fragment_unnamed_302, fragment_unnamed_305, fragment_unnamed_295);
				float fragment_unnamed_314 = mad(fragment_unnamed_302, fragment_unnamed_306, fragment_unnamed_294);
				float fragment_unnamed_315 = mad(fragment_unnamed_302, asfloat(3212836864u), asfloat(1059760811u));
				float fragment_unnamed_320 = asfloat(((fragment_unnamed_293 >= fragment_unnamed_313) ? 4294967295u : 0u) & 1065353216u);
				precise float fragment_unnamed_327 = (-0.0f) - fragment_unnamed_313;
				precise float fragment_unnamed_328 = (-0.0f) - fragment_unnamed_314;
				precise float fragment_unnamed_329 = (-0.0f) - fragment_unnamed_315;
				precise float fragment_unnamed_330 = (-0.0f) - fragment_unnamed_293;
				precise float fragment_unnamed_331 = fragment_unnamed_327 + fragment_unnamed_293;
				precise float fragment_unnamed_332 = fragment_unnamed_328 + fragment_unnamed_314;
				precise float fragment_unnamed_333 = fragment_unnamed_329 + mad(fragment_unnamed_302, asfloat(1065353216u), asfloat(3212836864u));
				precise float fragment_unnamed_334 = fragment_unnamed_330 + fragment_unnamed_313;
				float fragment_unnamed_335 = mad(fragment_unnamed_320, fragment_unnamed_331, fragment_unnamed_313);
				float fragment_unnamed_336 = mad(fragment_unnamed_320, fragment_unnamed_332, fragment_unnamed_314);
				float fragment_unnamed_338 = mad(fragment_unnamed_320, fragment_unnamed_334, fragment_unnamed_293);
				precise float fragment_unnamed_340 = (-0.0f) - min(fragment_unnamed_336, fragment_unnamed_338);
				precise float fragment_unnamed_341 = fragment_unnamed_340 + fragment_unnamed_335;
				precise float fragment_unnamed_345 = (-0.0f) - fragment_unnamed_336;
				precise float fragment_unnamed_346 = fragment_unnamed_345 + fragment_unnamed_338;
				precise float fragment_unnamed_347 = fragment_unnamed_346 / mad(fragment_unnamed_341, 6.0f, 9.9999997473787516355514526367188e-05f);
				precise float fragment_unnamed_348 = fragment_unnamed_347 + mad(fragment_unnamed_320, fragment_unnamed_333, fragment_unnamed_315);
				float fragment_unnamed_349 = abs(fragment_unnamed_348);
				precise float fragment_unnamed_357 = fragment_unnamed_349 + fragment_uniform_buffer_0[32u].x;
				float fragment_unnamed_358 = clamp(_Curves.SampleLevel(sampler_Curves, float2(fragment_unnamed_349, asfloat(1048576000u)), 0.0f).y, 0.0f, 1.0f);
				precise float fragment_unnamed_359 = fragment_unnamed_358 + fragment_unnamed_358;
				precise float fragment_unnamed_360 = fragment_unnamed_335 + 9.9999997473787516355514526367188e-05f;
				precise float fragment_unnamed_361 = fragment_unnamed_341 / fragment_unnamed_360;
				precise float fragment_unnamed_375 = dot(clamp(_Curves.SampleLevel(sampler_Curves, float2(fragment_unnamed_361, asfloat(1048576000u)), 0.0f).z, 0.0f, 1.0f).xx, fragment_unnamed_359.xx) * clamp(_Curves.SampleLevel(sampler_Curves, float2(dot(float3(fragment_unnamed_293, fragment_unnamed_294, fragment_unnamed_295), float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)), asfloat(1048576000u)), 0.0f).w, 0.0f, 1.0f);
				float fragment_unnamed_379 = dot(fragment_uniform_buffer_0[32u].y.xx, fragment_unnamed_375.xx);
				precise float fragment_unnamed_387 = fragment_unnamed_357 + clamp(_Curves.SampleLevel(sampler_Curves, float2(fragment_unnamed_357, asfloat(1048576000u)), 0.0f).x, 0.0f, 1.0f);
				precise float fragment_unnamed_388 = fragment_unnamed_387 + (-0.5f);
				precise float fragment_unnamed_390 = fragment_unnamed_387 + 0.5f;
				precise float fragment_unnamed_391 = fragment_unnamed_387 + (-1.5f);
				float fragment_unnamed_400 = asfloat((fragment_unnamed_388 < 0.0f) ? asuint(fragment_unnamed_390) : ((1.0f < fragment_unnamed_388) ? asuint(fragment_unnamed_391) : asuint(fragment_unnamed_388)));
				precise float fragment_unnamed_401 = fragment_unnamed_400 + 1.0f;
				precise float fragment_unnamed_402 = fragment_unnamed_400 + 0.666666686534881591796875f;
				precise float fragment_unnamed_404 = fragment_unnamed_400 + 0.3333333432674407958984375f;
				precise float fragment_unnamed_416 = abs(mad(frac(fragment_unnamed_401), 6.0f, -3.0f)) + (-1.0f);
				precise float fragment_unnamed_417 = abs(mad(frac(fragment_unnamed_402), 6.0f, -3.0f)) + (-1.0f);
				precise float fragment_unnamed_418 = abs(mad(frac(fragment_unnamed_404), 6.0f, -3.0f)) + (-1.0f);
				precise float fragment_unnamed_422 = clamp(fragment_unnamed_416, 0.0f, 1.0f) + (-1.0f);
				precise float fragment_unnamed_423 = clamp(fragment_unnamed_417, 0.0f, 1.0f) + (-1.0f);
				precise float fragment_unnamed_424 = clamp(fragment_unnamed_418, 0.0f, 1.0f) + (-1.0f);
				float fragment_unnamed_425 = mad(fragment_unnamed_361, fragment_unnamed_422, 1.0f);
				float fragment_unnamed_426 = mad(fragment_unnamed_361, fragment_unnamed_423, 1.0f);
				float fragment_unnamed_427 = mad(fragment_unnamed_361, fragment_unnamed_424, 1.0f);
				precise float fragment_unnamed_428 = fragment_unnamed_425 * fragment_unnamed_335;
				precise float fragment_unnamed_429 = fragment_unnamed_426 * fragment_unnamed_335;
				precise float fragment_unnamed_430 = fragment_unnamed_427 * fragment_unnamed_335;
				float fragment_unnamed_431 = dot(float3(fragment_unnamed_428, fragment_unnamed_429, fragment_unnamed_430), float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f));
				precise float fragment_unnamed_434 = (-0.0f) - fragment_unnamed_431;
				precise float fragment_unnamed_444 = clamp(mad(fragment_unnamed_379, mad(fragment_unnamed_335, fragment_unnamed_425, fragment_unnamed_434), fragment_unnamed_431), 0.0f, 1.0f) + 0.00390625f;
				precise float fragment_unnamed_446 = clamp(mad(fragment_unnamed_379, mad(fragment_unnamed_335, fragment_unnamed_426, fragment_unnamed_434), fragment_unnamed_431), 0.0f, 1.0f) + 0.00390625f;
				precise float fragment_unnamed_447 = clamp(mad(fragment_unnamed_379, mad(fragment_unnamed_335, fragment_unnamed_427, fragment_unnamed_434), fragment_unnamed_431), 0.0f, 1.0f) + 0.00390625f;
				float fragment_unnamed_448 = asfloat(1061158912u);
				precise float fragment_unnamed_462 = clamp(_Curves.Sample(sampler_Curves, float2(fragment_unnamed_444, fragment_unnamed_448)).w, 0.0f, 1.0f) + 0.00390625f;
				precise float fragment_unnamed_463 = clamp(_Curves.Sample(sampler_Curves, float2(fragment_unnamed_446, fragment_unnamed_448)).w, 0.0f, 1.0f) + 0.00390625f;
				precise float fragment_unnamed_464 = clamp(_Curves.Sample(sampler_Curves, float2(fragment_unnamed_447, fragment_unnamed_448)).w, 0.0f, 1.0f) + 0.00390625f;
				float fragment_unnamed_465 = asfloat(1061158912u);
				fragment_output_0.x = clamp(_Curves.Sample(sampler_Curves, float2(fragment_unnamed_462, fragment_unnamed_465)).x, 0.0f, 1.0f);
				fragment_output_0.z = clamp(_Curves.Sample(sampler_Curves, float2(fragment_unnamed_464, fragment_unnamed_465)).z, 0.0f, 1.0f);
				fragment_output_0.y = clamp(_Curves.Sample(sampler_Curves, float2(fragment_unnamed_463, fragment_unnamed_465)).y, 0.0f, 1.0f);
				fragment_output_0.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[28] = float4(_Lut2D_Params[0], _Lut2D_Params[1], _Lut2D_Params[2], _Lut2D_Params[3]);

				fragment_uniform_buffer_0[29] = float4(_UserLut2D_Params[0], _UserLut2D_Params[1], _UserLut2D_Params[2], _UserLut2D_Params[3]);

				fragment_uniform_buffer_0[30] = float4(_ColorBalance[0], _ColorBalance[1], _ColorBalance[2], fragment_uniform_buffer_0[30][3]);

				fragment_uniform_buffer_0[31] = float4(_ColorFilter[0], _ColorFilter[1], _ColorFilter[2], fragment_uniform_buffer_0[31][3]);

				fragment_uniform_buffer_0[32] = float4(_HueSatCon[0], _HueSatCon[1], _HueSatCon[2], fragment_uniform_buffer_0[32][3]);

				fragment_uniform_buffer_0[32] = float4(fragment_uniform_buffer_0[32][0], fragment_uniform_buffer_0[32][1], fragment_uniform_buffer_0[32][2], _Brightness);

				fragment_uniform_buffer_0[33] = float4(_ChannelMixerRed[0], _ChannelMixerRed[1], _ChannelMixerRed[2], fragment_uniform_buffer_0[33][3]);

				fragment_uniform_buffer_0[34] = float4(_ChannelMixerGreen[0], _ChannelMixerGreen[1], _ChannelMixerGreen[2], fragment_uniform_buffer_0[34][3]);

				fragment_uniform_buffer_0[35] = float4(_ChannelMixerBlue[0], _ChannelMixerBlue[1], _ChannelMixerBlue[2], fragment_uniform_buffer_0[35][3]);

				fragment_uniform_buffer_0[36] = float4(_Lift[0], _Lift[1], _Lift[2], fragment_uniform_buffer_0[36][3]);

				fragment_uniform_buffer_0[37] = float4(_InvGamma[0], _InvGamma[1], _InvGamma[2], fragment_uniform_buffer_0[37][3]);

				fragment_uniform_buffer_0[38] = float4(_Gain[0], _Gain[1], _Gain[2], fragment_uniform_buffer_0[38][3]);

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
			GpuProgramID 175109

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.0
			#pragma shader_feature TONEMAPPING_ACES
			#pragma shader_feature TONEMAPPING_CUSTOM
			#pragma shader_feature TONEMAPPING_NEUTRAL


			#ifndef TONEMAPPING_ACES
			#ifndef TONEMAPPING_CUSTOM
			#ifndef TONEMAPPING_NEUTRAL
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

			#endif // !TONEMAPPING_ACES
			#endif // !TONEMAPPING_CUSTOM
			#endif // !TONEMAPPING_NEUTRAL


			#ifdef TONEMAPPING_ACES
			#ifndef TONEMAPPING_CUSTOM
			#ifndef TONEMAPPING_NEUTRAL
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

			#endif // TONEMAPPING_ACES
			#endif // !TONEMAPPING_CUSTOM
			#endif // !TONEMAPPING_NEUTRAL


			#ifdef TONEMAPPING_NEUTRAL
			#ifndef TONEMAPPING_ACES
			#ifndef TONEMAPPING_CUSTOM
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

			#endif // TONEMAPPING_NEUTRAL
			#endif // !TONEMAPPING_ACES
			#endif // !TONEMAPPING_CUSTOM


			#ifdef TONEMAPPING_CUSTOM
			#ifndef TONEMAPPING_ACES
			#ifndef TONEMAPPING_NEUTRAL
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

			#endif // TONEMAPPING_CUSTOM
			#endif // !TONEMAPPING_ACES
			#endif // !TONEMAPPING_NEUTRAL


			#ifndef TONEMAPPING_ACES
			#ifndef TONEMAPPING_CUSTOM
			#ifndef TONEMAPPING_NEUTRAL
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

			float4 _Lut2D_Params;
			float3 _ColorBalance;
			float3 _ColorFilter;
			float3 _HueSatCon;
			float3 _ChannelMixerRed;
			float3 _ChannelMixerGreen;
			float3 _ChannelMixerBlue;
			float3 _Lift;
			float3 _InvGamma;
			float3 _Gain;

			Texture2D<float4> _Curves;
			SamplerState sampler_Curves;

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
			static float4 fragment_unnamed_28;
			static bool fragment_unnamed_269;
			static float fragment_unnamed_275;
			static float4 fragment_unnamed_282;
			static float3 fragment_unnamed_318;
			static float3 fragment_unnamed_354;
			static float2 fragment_unnamed_363;
			static float2 fragment_unnamed_387;
			static bool fragment_unnamed_436;
			static float2 fragment_unnamed_492;

			void frag_main()
			{
				float2 fragment_unnamed_25 = fragment_input_0 + (-_Lut2D_Params.yz);
				fragment_unnamed_9 = float4(fragment_unnamed_9.x, fragment_unnamed_25.x, fragment_unnamed_25.y, fragment_unnamed_9.w);
				fragment_unnamed_28.x = fragment_unnamed_9.y * _Lut2D_Params.x;
				fragment_unnamed_9.x = frac(fragment_unnamed_28.x);
				fragment_unnamed_28.x = fragment_unnamed_9.x / _Lut2D_Params.x;
				fragment_unnamed_9.w = fragment_unnamed_9.y + (-fragment_unnamed_28.x);
				float3 fragment_unnamed_66 = (fragment_unnamed_9.xzw * _Lut2D_Params.www) + (-0.41358840465545654296875f).xxx;
				fragment_unnamed_9 = float4(fragment_unnamed_66.x, fragment_unnamed_66.y, fragment_unnamed_66.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_79 = (fragment_unnamed_9.xyz * _HueSatCon.zzz) + 0.0275523960590362548828125f.xxx;
				fragment_unnamed_9 = float4(fragment_unnamed_79.x, fragment_unnamed_79.y, fragment_unnamed_79.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_86 = fragment_unnamed_9.xyz * 13.6054821014404296875f.xxx;
				fragment_unnamed_9 = float4(fragment_unnamed_86.x, fragment_unnamed_86.y, fragment_unnamed_86.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_91 = exp2(fragment_unnamed_9.xyz);
				fragment_unnamed_9 = float4(fragment_unnamed_91.x, fragment_unnamed_91.y, fragment_unnamed_91.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_98 = fragment_unnamed_9.xyz + (-0.04799599945545196533203125f).xxx;
				fragment_unnamed_9 = float4(fragment_unnamed_98.x, fragment_unnamed_98.y, fragment_unnamed_98.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_105 = fragment_unnamed_9.xyz * 0.17999999225139617919921875f.xxx;
				fragment_unnamed_9 = float4(fragment_unnamed_105.x, fragment_unnamed_105.y, fragment_unnamed_105.z, fragment_unnamed_9.w);
				fragment_unnamed_28.x = dot(float3(0.390404999256134033203125f, 0.549941003322601318359375f, 0.008926319889724254608154296875f), fragment_unnamed_9.xyz);
				fragment_unnamed_28.y = dot(float3(0.070841602981090545654296875f, 0.963172018527984619140625f, 0.001357750035822391510009765625f), fragment_unnamed_9.xyz);
				fragment_unnamed_28.z = dot(float3(0.02310819923877716064453125f, 0.1280210018157958984375f, 0.936245024204254150390625f), fragment_unnamed_9.xyz);
				float3 fragment_unnamed_138 = fragment_unnamed_28.xyz * _ColorBalance;
				fragment_unnamed_9 = float4(fragment_unnamed_138.x, fragment_unnamed_138.y, fragment_unnamed_138.z, fragment_unnamed_9.w);
				fragment_unnamed_28.x = dot(float3(2.85846996307373046875f, -1.62879002094268798828125f, -0.0248910002410411834716796875f), fragment_unnamed_9.xyz);
				fragment_unnamed_28.y = dot(float3(-0.21018199622631072998046875f, 1.1582000255584716796875f, 0.0003242809907533228397369384765625f), fragment_unnamed_9.xyz);
				fragment_unnamed_28.z = dot(float3(-0.0418119989335536956787109375f, -0.118169002234935760498046875f, 1.0686700344085693359375f), fragment_unnamed_9.xyz);
				float3 fragment_unnamed_170 = fragment_unnamed_28.xyz * _ColorFilter;
				fragment_unnamed_9 = float4(fragment_unnamed_170.x, fragment_unnamed_170.y, fragment_unnamed_170.z, fragment_unnamed_9.w);
				fragment_unnamed_28.x = dot(fragment_unnamed_9.xyz, _ChannelMixerRed);
				fragment_unnamed_28.y = dot(fragment_unnamed_9.xyz, _ChannelMixerGreen);
				fragment_unnamed_28.z = dot(fragment_unnamed_9.xyz, _ChannelMixerBlue);
				float3 fragment_unnamed_203 = (fragment_unnamed_28.xyz * _Gain) + _Lift;
				fragment_unnamed_9 = float4(fragment_unnamed_203.x, fragment_unnamed_203.y, fragment_unnamed_203.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_209 = log2(abs(fragment_unnamed_9.xyz));
				fragment_unnamed_28 = float4(fragment_unnamed_209.x, fragment_unnamed_209.y, fragment_unnamed_209.z, fragment_unnamed_28.w);
				float3 fragment_unnamed_219 = (fragment_unnamed_9.xyz * 3.4028234663852885981170418348452e+38f.xxx) + 0.5f.xxx;
				fragment_unnamed_9 = float4(fragment_unnamed_219.x, fragment_unnamed_219.y, fragment_unnamed_219.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_228 = clamp(fragment_unnamed_9.xyz, 0.0f.xxx, 1.0f.xxx);
				fragment_unnamed_9 = float4(fragment_unnamed_228.x, fragment_unnamed_228.y, fragment_unnamed_228.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_238 = (fragment_unnamed_9.xyz * 2.0f.xxx) + (-1.0f).xxx;
				fragment_unnamed_9 = float4(fragment_unnamed_238.x, fragment_unnamed_238.y, fragment_unnamed_238.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_246 = fragment_unnamed_28.xyz * _InvGamma;
				fragment_unnamed_28 = float4(fragment_unnamed_246.x, fragment_unnamed_246.y, fragment_unnamed_246.z, fragment_unnamed_28.w);
				float3 fragment_unnamed_251 = exp2(fragment_unnamed_28.xyz);
				fragment_unnamed_28 = float4(fragment_unnamed_251.x, fragment_unnamed_251.y, fragment_unnamed_251.z, fragment_unnamed_28.w);
				float3 fragment_unnamed_258 = fragment_unnamed_9.xyz * fragment_unnamed_28.xyz;
				fragment_unnamed_9 = float4(fragment_unnamed_258.x, fragment_unnamed_258.y, fragment_unnamed_258.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_264 = max(fragment_unnamed_9.xyz, 0.0f.xxx);
				fragment_unnamed_9 = float4(fragment_unnamed_264.x, fragment_unnamed_264.y, fragment_unnamed_264.z, fragment_unnamed_9.w);
				fragment_unnamed_269 = fragment_unnamed_9.y >= fragment_unnamed_9.z;
				fragment_unnamed_275 = float(fragment_unnamed_269);
				fragment_unnamed_28 = float4(fragment_unnamed_9.zy.x, fragment_unnamed_9.zy.y, fragment_unnamed_28.z, fragment_unnamed_28.w);
				float2 fragment_unnamed_288 = fragment_unnamed_9.yz + (-fragment_unnamed_28.xy);
				fragment_unnamed_282 = float4(fragment_unnamed_288.x, fragment_unnamed_288.y, fragment_unnamed_282.z, fragment_unnamed_282.w);
				fragment_unnamed_28.z = -1.0f;
				fragment_unnamed_28.w = 0.666666686534881591796875f;
				fragment_unnamed_282.z = 1.0f;
				fragment_unnamed_282.w = -1.0f;
				fragment_unnamed_28 = (fragment_unnamed_275.xxxx * fragment_unnamed_282.xywz) + fragment_unnamed_28.xywz;
				fragment_unnamed_269 = fragment_unnamed_9.x >= fragment_unnamed_28.x;
				fragment_unnamed_275 = float(fragment_unnamed_269);
				fragment_unnamed_282.z = fragment_unnamed_28.w;
				fragment_unnamed_28.w = fragment_unnamed_9.x;
				fragment_unnamed_318.x = dot(fragment_unnamed_9.xyz, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f));
				fragment_unnamed_282 = float4(fragment_unnamed_28.wyx.x, fragment_unnamed_28.wyx.y, fragment_unnamed_282.z, fragment_unnamed_28.wyx.z);
				fragment_unnamed_282 = (-fragment_unnamed_28) + fragment_unnamed_282;
				fragment_unnamed_9 = (fragment_unnamed_275.xxxx * fragment_unnamed_282) + fragment_unnamed_28;
				fragment_unnamed_28.x = min(fragment_unnamed_9.y, fragment_unnamed_9.w);
				fragment_unnamed_28.x = fragment_unnamed_9.x + (-fragment_unnamed_28.x);
				fragment_unnamed_354.x = (fragment_unnamed_28.x * 6.0f) + 9.9999997473787516355514526367188e-05f;
				fragment_unnamed_363.x = (-fragment_unnamed_9.y) + fragment_unnamed_9.w;
				fragment_unnamed_363.x /= fragment_unnamed_354.x;
				fragment_unnamed_363.x += fragment_unnamed_9.z;
				fragment_unnamed_282.x = abs(fragment_unnamed_363.x);
				fragment_unnamed_387.x = fragment_unnamed_282.x + _HueSatCon.x;
				fragment_unnamed_318.y = 0.25f;
				fragment_unnamed_387.y = 0.25f;
				fragment_unnamed_363.x = _Curves.SampleLevel(sampler_Curves, fragment_unnamed_387, 0.0f).x;
				fragment_unnamed_363.y = _Curves.SampleLevel(sampler_Curves, fragment_unnamed_318.xy, 0.0f).w;
				fragment_unnamed_363 = fragment_unnamed_363;
				fragment_unnamed_363 = clamp(fragment_unnamed_363, 0.0f.xx, 1.0f.xx);
				fragment_unnamed_363.x = fragment_unnamed_387.x + fragment_unnamed_363.x;
				fragment_unnamed_354 = fragment_unnamed_363.xxx + float3(-0.5f, 0.5f, -1.5f);
				fragment_unnamed_436 = 1.0f < fragment_unnamed_354.x;
				float fragment_unnamed_442;
				if (fragment_unnamed_436)
				{
					fragment_unnamed_442 = fragment_unnamed_354.z;
				}
				else
				{
					fragment_unnamed_442 = fragment_unnamed_354.x;
				}
				fragment_unnamed_363.x = fragment_unnamed_442;
				fragment_unnamed_269 = fragment_unnamed_354.x < 0.0f;
				float fragment_unnamed_456;
				if (fragment_unnamed_269)
				{
					fragment_unnamed_456 = fragment_unnamed_354.y;
				}
				else
				{
					fragment_unnamed_456 = fragment_unnamed_363.x;
				}
				fragment_unnamed_363.x = fragment_unnamed_456;
				fragment_unnamed_354 = fragment_unnamed_363.xxx + float3(1.0f, 0.666666686534881591796875f, 0.3333333432674407958984375f);
				fragment_unnamed_354 = frac(fragment_unnamed_354);
				fragment_unnamed_354 = (fragment_unnamed_354 * 6.0f.xxx) + (-3.0f).xxx;
				fragment_unnamed_354 = abs(fragment_unnamed_354) + (-1.0f).xxx;
				fragment_unnamed_354 = clamp(fragment_unnamed_354, 0.0f.xxx, 1.0f.xxx);
				fragment_unnamed_354 += (-1.0f).xxx;
				fragment_unnamed_363.x = fragment_unnamed_9.x + 9.9999997473787516355514526367188e-05f;
				fragment_unnamed_492.x = fragment_unnamed_28.x / fragment_unnamed_363.x;
				float3 fragment_unnamed_504 = (fragment_unnamed_492.xxx * fragment_unnamed_354) + 1.0f.xxx;
				fragment_unnamed_28 = float4(fragment_unnamed_504.x, fragment_unnamed_504.y, fragment_unnamed_504.z, fragment_unnamed_28.w);
				fragment_unnamed_318 = fragment_unnamed_9.xxx * fragment_unnamed_28.xyz;
				fragment_unnamed_363.x = dot(fragment_unnamed_318, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f));
				float3 fragment_unnamed_523 = (fragment_unnamed_9.xxx * fragment_unnamed_28.xyz) + (-fragment_unnamed_363.xxx);
				fragment_unnamed_28 = float4(fragment_unnamed_523.x, fragment_unnamed_523.y, fragment_unnamed_523.z, fragment_unnamed_28.w);
				fragment_unnamed_282.y = 0.25f;
				fragment_unnamed_492.y = 0.25f;
				fragment_unnamed_9.x = _Curves.SampleLevel(sampler_Curves, fragment_unnamed_282.xy, 0.0f).y;
				fragment_unnamed_9.w = _Curves.SampleLevel(sampler_Curves, fragment_unnamed_492, 0.0f).z;
				fragment_unnamed_9 = float4(fragment_unnamed_9.xw.x, fragment_unnamed_9.y, fragment_unnamed_9.z, fragment_unnamed_9.xw.y);
				float2 fragment_unnamed_551 = clamp(fragment_unnamed_9.xw, 0.0f.xx, 1.0f.xx);
				fragment_unnamed_9 = float4(fragment_unnamed_551.x, fragment_unnamed_9.y, fragment_unnamed_9.z, fragment_unnamed_551.y);
				fragment_unnamed_9.x += fragment_unnamed_9.x;
				fragment_unnamed_9.x = dot(fragment_unnamed_9.ww, fragment_unnamed_9.xx);
				fragment_unnamed_9.x *= fragment_unnamed_363.y;
				fragment_unnamed_9.x = dot(_HueSatCon.yy, fragment_unnamed_9.xx);
				float3 fragment_unnamed_586 = (fragment_unnamed_9.xxx * fragment_unnamed_28.xyz) + fragment_unnamed_363.xxx;
				fragment_unnamed_9 = float4(fragment_unnamed_586.x, fragment_unnamed_586.y, fragment_unnamed_586.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_593 = max(fragment_unnamed_9.xyz, 0.0f.xxx);
				fragment_output_0 = float4(fragment_unnamed_593.x, fragment_unnamed_593.y, fragment_unnamed_593.z, fragment_output_0.w);
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

			#endif // !TONEMAPPING_ACES
			#endif // !TONEMAPPING_CUSTOM
			#endif // !TONEMAPPING_NEUTRAL


			#ifdef TONEMAPPING_ACES
			#ifndef TONEMAPPING_CUSTOM
			#ifndef TONEMAPPING_NEUTRAL
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

			float4 _Lut2D_Params;
			float3 _ColorBalance;
			float3 _ColorFilter;
			float3 _HueSatCon;
			float3 _ChannelMixerRed;
			float3 _ChannelMixerGreen;
			float3 _ChannelMixerBlue;
			float3 _Lift;
			float3 _InvGamma;
			float3 _Gain;

			Texture2D<float4> _Curves;
			SamplerState sampler_Curves;

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
			static float4 fragment_unnamed_28;
			static float4 fragment_unnamed_163;
			static bool3 fragment_unnamed_172;
			static bool4 fragment_unnamed_249;
			static bool2 fragment_unnamed_268;
			static float3 fragment_unnamed_280;
			static float fragment_unnamed_308;
			static bool fragment_unnamed_538;
			static float fragment_unnamed_544;
			static float3 fragment_unnamed_585;
			static float3 fragment_unnamed_628;
			static float2 fragment_unnamed_653;
			static bool fragment_unnamed_726;
			static float2 fragment_unnamed_766;
			static float fragment_unnamed_1151;
			static bool fragment_unnamed_1187;
			static bool fragment_unnamed_1205;

			void frag_main()
			{
				float2 fragment_unnamed_25 = fragment_input_0 + (-_Lut2D_Params.yz);
				fragment_unnamed_9 = float4(fragment_unnamed_9.x, fragment_unnamed_25.x, fragment_unnamed_25.y, fragment_unnamed_9.w);
				fragment_unnamed_28.x = fragment_unnamed_9.y * _Lut2D_Params.x;
				fragment_unnamed_9.x = frac(fragment_unnamed_28.x);
				fragment_unnamed_28.x = fragment_unnamed_9.x / _Lut2D_Params.x;
				fragment_unnamed_9.w = fragment_unnamed_9.y + (-fragment_unnamed_28.x);
				float3 fragment_unnamed_66 = (fragment_unnamed_9.xzw * _Lut2D_Params.www) + (-0.3860360085964202880859375f).xxx;
				fragment_unnamed_9 = float4(fragment_unnamed_66.x, fragment_unnamed_66.y, fragment_unnamed_66.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_73 = fragment_unnamed_9.xyz * 13.6054821014404296875f.xxx;
				fragment_unnamed_9 = float4(fragment_unnamed_73.x, fragment_unnamed_73.y, fragment_unnamed_73.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_78 = exp2(fragment_unnamed_9.xyz);
				fragment_unnamed_9 = float4(fragment_unnamed_78.x, fragment_unnamed_78.y, fragment_unnamed_78.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_85 = fragment_unnamed_9.xyz + (-0.04799599945545196533203125f).xxx;
				fragment_unnamed_9 = float4(fragment_unnamed_85.x, fragment_unnamed_85.y, fragment_unnamed_85.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_92 = fragment_unnamed_9.xyz * 0.17999999225139617919921875f.xxx;
				fragment_unnamed_9 = float4(fragment_unnamed_92.x, fragment_unnamed_92.y, fragment_unnamed_92.z, fragment_unnamed_9.w);
				fragment_unnamed_28.x = dot(float3(0.4397009909152984619140625f, 0.3829779922962188720703125f, 0.1773349940776824951171875f), fragment_unnamed_9.xyz);
				fragment_unnamed_28.y = dot(float3(0.08979229629039764404296875f, 0.813422977924346923828125f, 0.09676159918308258056640625f), fragment_unnamed_9.xyz);
				fragment_unnamed_28.z = dot(float3(0.01754399947822093963623046875f, 0.11154399812221527099609375f, 0.870703995227813720703125f), fragment_unnamed_9.xyz);
				float3 fragment_unnamed_124 = max(fragment_unnamed_28.xyz, 0.0f.xxx);
				fragment_unnamed_9 = float4(fragment_unnamed_124.x, fragment_unnamed_124.y, fragment_unnamed_124.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_131 = min(fragment_unnamed_9.xyz, 65504.0f.xxx);
				fragment_unnamed_9 = float4(fragment_unnamed_131.x, fragment_unnamed_131.y, fragment_unnamed_131.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_141 = (fragment_unnamed_9.xyz * 0.5f.xxx) + 1.5258779967552982270717620849609e-05f.xxx;
				fragment_unnamed_28 = float4(fragment_unnamed_141.x, fragment_unnamed_141.y, fragment_unnamed_141.z, fragment_unnamed_28.w);
				float3 fragment_unnamed_146 = log2(fragment_unnamed_28.xyz);
				fragment_unnamed_28 = float4(fragment_unnamed_146.x, fragment_unnamed_146.y, fragment_unnamed_146.z, fragment_unnamed_28.w);
				float3 fragment_unnamed_153 = fragment_unnamed_28.xyz + 9.72000026702880859375f.xxx;
				fragment_unnamed_28 = float4(fragment_unnamed_153.x, fragment_unnamed_153.y, fragment_unnamed_153.z, fragment_unnamed_28.w);
				float3 fragment_unnamed_160 = fragment_unnamed_28.xyz * 0.057077623903751373291015625f.xxx;
				fragment_unnamed_28 = float4(fragment_unnamed_160.x, fragment_unnamed_160.y, fragment_unnamed_160.z, fragment_unnamed_28.w);
				float3 fragment_unnamed_166 = log2(fragment_unnamed_9.xyz);
				fragment_unnamed_163 = float4(fragment_unnamed_166.x, fragment_unnamed_166.y, fragment_unnamed_166.z, fragment_unnamed_163.w);
				fragment_unnamed_172 = bool4(fragment_unnamed_9.xyzx.x < float4(3.0517570849042385816574096679688e-05f, 3.0517570849042385816574096679688e-05f, 3.0517570849042385816574096679688e-05f, 0.0f).x, fragment_unnamed_9.xyzx.y < float4(3.0517570849042385816574096679688e-05f, 3.0517570849042385816574096679688e-05f, 3.0517570849042385816574096679688e-05f, 0.0f).y, fragment_unnamed_9.xyzx.z < float4(3.0517570849042385816574096679688e-05f, 3.0517570849042385816574096679688e-05f, 3.0517570849042385816574096679688e-05f, 0.0f).z, fragment_unnamed_9.xyzx.w < float4(3.0517570849042385816574096679688e-05f, 3.0517570849042385816574096679688e-05f, 3.0517570849042385816574096679688e-05f, 0.0f).w).xyz;
				float3 fragment_unnamed_182 = fragment_unnamed_163.xyz + 9.72000026702880859375f.xxx;
				fragment_unnamed_163 = float4(fragment_unnamed_182.x, fragment_unnamed_182.y, fragment_unnamed_182.z, fragment_unnamed_163.w);
				float3 fragment_unnamed_187 = fragment_unnamed_163.xyz * 0.057077623903751373291015625f.xxx;
				fragment_unnamed_163 = float4(fragment_unnamed_187.x, fragment_unnamed_187.y, fragment_unnamed_187.z, fragment_unnamed_163.w);
				float fragment_unnamed_194;
				if (fragment_unnamed_172.x)
				{
					fragment_unnamed_194 = fragment_unnamed_28.x;
				}
				else
				{
					fragment_unnamed_194 = fragment_unnamed_163.x;
				}
				fragment_unnamed_9.x = fragment_unnamed_194;
				float fragment_unnamed_206;
				if (fragment_unnamed_172.y)
				{
					fragment_unnamed_206 = fragment_unnamed_28.y;
				}
				else
				{
					fragment_unnamed_206 = fragment_unnamed_163.y;
				}
				fragment_unnamed_9.y = fragment_unnamed_206;
				float fragment_unnamed_218;
				if (fragment_unnamed_172.z)
				{
					fragment_unnamed_218 = fragment_unnamed_28.z;
				}
				else
				{
					fragment_unnamed_218 = fragment_unnamed_163.z;
				}
				fragment_unnamed_9.z = fragment_unnamed_218;
				float3 fragment_unnamed_232 = fragment_unnamed_9.xyz + (-0.41358840465545654296875f).xxx;
				fragment_unnamed_9 = float4(fragment_unnamed_232.x, fragment_unnamed_232.y, fragment_unnamed_232.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_245 = (fragment_unnamed_9.xyz * _HueSatCon.zzz) + 0.41358840465545654296875f.xxx;
				fragment_unnamed_9 = float4(fragment_unnamed_245.x, fragment_unnamed_245.y, fragment_unnamed_245.z, fragment_unnamed_9.w);
				fragment_unnamed_249 = bool4(fragment_unnamed_9.xxyy.x < float4(-0.3013698756694793701171875f, 1.4679963588714599609375f, -0.3013698756694793701171875f, 1.4679963588714599609375f).x, fragment_unnamed_9.xxyy.y < float4(-0.3013698756694793701171875f, 1.4679963588714599609375f, -0.3013698756694793701171875f, 1.4679963588714599609375f).y, fragment_unnamed_9.xxyy.z < float4(-0.3013698756694793701171875f, 1.4679963588714599609375f, -0.3013698756694793701171875f, 1.4679963588714599609375f).z, fragment_unnamed_9.xxyy.w < float4(-0.3013698756694793701171875f, 1.4679963588714599609375f, -0.3013698756694793701171875f, 1.4679963588714599609375f).w);
				float3 fragment_unnamed_263 = (fragment_unnamed_9.xyz * 17.520000457763671875f.xxx) + (-9.72000026702880859375f).xxx;
				fragment_unnamed_9 = float4(fragment_unnamed_263.x, fragment_unnamed_263.y, fragment_unnamed_9.z, fragment_unnamed_263.z);
				fragment_unnamed_268 = bool4(fragment_unnamed_9.zzzz.x < float4(-0.3013698756694793701171875f, 1.4679963588714599609375f, 0.0f, 0.0f).x, fragment_unnamed_9.zzzz.y < float4(-0.3013698756694793701171875f, 1.4679963588714599609375f, 0.0f, 0.0f).y, fragment_unnamed_9.zzzz.z < float4(-0.3013698756694793701171875f, 1.4679963588714599609375f, 0.0f, 0.0f).z, fragment_unnamed_9.zzzz.w < float4(-0.3013698756694793701171875f, 1.4679963588714599609375f, 0.0f, 0.0f).w).xy;
				float3 fragment_unnamed_276 = exp2(fragment_unnamed_9.xyw);
				fragment_unnamed_9 = float4(fragment_unnamed_276.x, fragment_unnamed_276.y, fragment_unnamed_276.z, fragment_unnamed_9.w);
				float fragment_unnamed_283;
				if (fragment_unnamed_249.y)
				{
					fragment_unnamed_283 = fragment_unnamed_9.x;
				}
				else
				{
					fragment_unnamed_283 = 65504.0f;
				}
				fragment_unnamed_280.x = fragment_unnamed_283;
				float fragment_unnamed_293;
				if (fragment_unnamed_249.w)
				{
					fragment_unnamed_293 = fragment_unnamed_9.y;
				}
				else
				{
					fragment_unnamed_293 = 65504.0f;
				}
				fragment_unnamed_280.z = fragment_unnamed_293;
				float3 fragment_unnamed_305 = fragment_unnamed_9.xyz + (-1.52587890625e-05f).xxx;
				fragment_unnamed_9 = float4(fragment_unnamed_305.x, fragment_unnamed_305.y, fragment_unnamed_9.z, fragment_unnamed_305.z);
				float fragment_unnamed_311;
				if (fragment_unnamed_268.y)
				{
					fragment_unnamed_311 = fragment_unnamed_9.z;
				}
				else
				{
					fragment_unnamed_311 = 65504.0f;
				}
				fragment_unnamed_308 = fragment_unnamed_311;
				float3 fragment_unnamed_322 = fragment_unnamed_9.xyw + fragment_unnamed_9.xyw;
				fragment_unnamed_9 = float4(fragment_unnamed_322.x, fragment_unnamed_322.y, fragment_unnamed_9.z, fragment_unnamed_322.z);
				float fragment_unnamed_327;
				if (fragment_unnamed_249.x)
				{
					fragment_unnamed_327 = fragment_unnamed_9.x;
				}
				else
				{
					fragment_unnamed_327 = fragment_unnamed_280.x;
				}
				fragment_unnamed_28.x = fragment_unnamed_327;
				float fragment_unnamed_339;
				if (fragment_unnamed_249.z)
				{
					fragment_unnamed_339 = fragment_unnamed_9.y;
				}
				else
				{
					fragment_unnamed_339 = fragment_unnamed_280.z;
				}
				fragment_unnamed_28.y = fragment_unnamed_339;
				float fragment_unnamed_351;
				if (fragment_unnamed_268.x)
				{
					fragment_unnamed_351 = fragment_unnamed_9.w;
				}
				else
				{
					fragment_unnamed_351 = fragment_unnamed_308;
				}
				fragment_unnamed_28.z = fragment_unnamed_351;
				fragment_unnamed_9.x = dot(float3(1.45143926143646240234375f, -0.236510753631591796875f, -0.214928567409515380859375f), fragment_unnamed_28.xyz);
				fragment_unnamed_9.y = dot(float3(-0.07655377686023712158203125f, 1.1762297153472900390625f, -0.0996759235858917236328125f), fragment_unnamed_28.xyz);
				fragment_unnamed_9.z = dot(float3(0.0083161480724811553955078125f, -0.0060324496589601039886474609375f, 0.99771630764007568359375f), fragment_unnamed_28.xyz);
				fragment_unnamed_28.x = dot(float3(0.390404999256134033203125f, 0.549941003322601318359375f, 0.008926319889724254608154296875f), fragment_unnamed_9.xyz);
				fragment_unnamed_28.y = dot(float3(0.070841602981090545654296875f, 0.963172018527984619140625f, 0.001357750035822391510009765625f), fragment_unnamed_9.xyz);
				fragment_unnamed_28.z = dot(float3(0.02310819923877716064453125f, 0.1280210018157958984375f, 0.936245024204254150390625f), fragment_unnamed_9.xyz);
				float3 fragment_unnamed_413 = fragment_unnamed_28.xyz * _ColorBalance;
				fragment_unnamed_9 = float4(fragment_unnamed_413.x, fragment_unnamed_413.y, fragment_unnamed_413.z, fragment_unnamed_9.w);
				fragment_unnamed_28.x = dot(float3(2.85846996307373046875f, -1.62879002094268798828125f, -0.0248910002410411834716796875f), fragment_unnamed_9.xyz);
				fragment_unnamed_28.y = dot(float3(-0.21018199622631072998046875f, 1.1582000255584716796875f, 0.0003242809907533228397369384765625f), fragment_unnamed_9.xyz);
				fragment_unnamed_28.z = dot(float3(-0.0418119989335536956787109375f, -0.118169002234935760498046875f, 1.0686700344085693359375f), fragment_unnamed_9.xyz);
				float3 fragment_unnamed_445 = fragment_unnamed_28.xyz * _ColorFilter;
				fragment_unnamed_9 = float4(fragment_unnamed_445.x, fragment_unnamed_445.y, fragment_unnamed_445.z, fragment_unnamed_9.w);
				fragment_unnamed_28.x = dot(fragment_unnamed_9.xyz, _ChannelMixerRed);
				fragment_unnamed_28.y = dot(fragment_unnamed_9.xyz, _ChannelMixerGreen);
				fragment_unnamed_28.z = dot(fragment_unnamed_9.xyz, _ChannelMixerBlue);
				float3 fragment_unnamed_478 = (fragment_unnamed_28.xyz * _Gain) + _Lift;
				fragment_unnamed_9 = float4(fragment_unnamed_478.x, fragment_unnamed_478.y, fragment_unnamed_478.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_484 = log2(abs(fragment_unnamed_9.xyz));
				fragment_unnamed_28 = float4(fragment_unnamed_484.x, fragment_unnamed_484.y, fragment_unnamed_484.z, fragment_unnamed_28.w);
				float3 fragment_unnamed_492 = (fragment_unnamed_9.xyz * 3.4028234663852885981170418348452e+38f.xxx) + 0.5f.xxx;
				fragment_unnamed_9 = float4(fragment_unnamed_492.x, fragment_unnamed_492.y, fragment_unnamed_492.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_500 = clamp(fragment_unnamed_9.xyz, 0.0f.xxx, 1.0f.xxx);
				fragment_unnamed_9 = float4(fragment_unnamed_500.x, fragment_unnamed_500.y, fragment_unnamed_500.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_510 = (fragment_unnamed_9.xyz * 2.0f.xxx) + (-1.0f).xxx;
				fragment_unnamed_9 = float4(fragment_unnamed_510.x, fragment_unnamed_510.y, fragment_unnamed_510.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_518 = fragment_unnamed_28.xyz * _InvGamma;
				fragment_unnamed_28 = float4(fragment_unnamed_518.x, fragment_unnamed_518.y, fragment_unnamed_518.z, fragment_unnamed_28.w);
				float3 fragment_unnamed_523 = exp2(fragment_unnamed_28.xyz);
				fragment_unnamed_28 = float4(fragment_unnamed_523.x, fragment_unnamed_523.y, fragment_unnamed_523.z, fragment_unnamed_28.w);
				float3 fragment_unnamed_530 = fragment_unnamed_9.xyz * fragment_unnamed_28.xyz;
				fragment_unnamed_9 = float4(fragment_unnamed_530.x, fragment_unnamed_530.y, fragment_unnamed_530.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_535 = max(fragment_unnamed_9.xyz, 0.0f.xxx);
				fragment_unnamed_9 = float4(fragment_unnamed_535.x, fragment_unnamed_535.y, fragment_unnamed_535.z, fragment_unnamed_9.w);
				fragment_unnamed_538 = fragment_unnamed_9.y >= fragment_unnamed_9.z;
				fragment_unnamed_544 = float(fragment_unnamed_538);
				fragment_unnamed_28 = float4(fragment_unnamed_9.zy.x, fragment_unnamed_9.zy.y, fragment_unnamed_28.z, fragment_unnamed_28.w);
				float2 fragment_unnamed_556 = fragment_unnamed_9.yz + (-fragment_unnamed_28.xy);
				fragment_unnamed_163 = float4(fragment_unnamed_556.x, fragment_unnamed_556.y, fragment_unnamed_163.z, fragment_unnamed_163.w);
				fragment_unnamed_28.z = -1.0f;
				fragment_unnamed_28.w = 0.666666686534881591796875f;
				fragment_unnamed_163.z = 1.0f;
				fragment_unnamed_163.w = -1.0f;
				fragment_unnamed_28 = (fragment_unnamed_544.xxxx * fragment_unnamed_163.xywz) + fragment_unnamed_28.xywz;
				fragment_unnamed_538 = fragment_unnamed_9.x >= fragment_unnamed_28.x;
				fragment_unnamed_544 = float(fragment_unnamed_538);
				fragment_unnamed_163.z = fragment_unnamed_28.w;
				fragment_unnamed_28.w = fragment_unnamed_9.x;
				fragment_unnamed_585.x = dot(fragment_unnamed_9.xyz, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f));
				fragment_unnamed_163 = float4(fragment_unnamed_28.wyx.x, fragment_unnamed_28.wyx.y, fragment_unnamed_163.z, fragment_unnamed_28.wyx.z);
				fragment_unnamed_163 = (-fragment_unnamed_28) + fragment_unnamed_163;
				fragment_unnamed_9 = (fragment_unnamed_544.xxxx * fragment_unnamed_163) + fragment_unnamed_28;
				fragment_unnamed_28.x = min(fragment_unnamed_9.y, fragment_unnamed_9.w);
				fragment_unnamed_28.x = fragment_unnamed_9.x + (-fragment_unnamed_28.x);
				fragment_unnamed_280.x = (fragment_unnamed_28.x * 6.0f) + 9.9999997473787516355514526367188e-05f;
				fragment_unnamed_628.x = (-fragment_unnamed_9.y) + fragment_unnamed_9.w;
				fragment_unnamed_628.x /= fragment_unnamed_280.x;
				fragment_unnamed_628.x += fragment_unnamed_9.z;
				fragment_unnamed_163.x = abs(fragment_unnamed_628.x);
				fragment_unnamed_653.x = fragment_unnamed_163.x + _HueSatCon.x;
				fragment_unnamed_585.y = 0.25f;
				fragment_unnamed_653.y = 0.25f;
				fragment_unnamed_628.x = _Curves.SampleLevel(sampler_Curves, fragment_unnamed_653, 0.0f).x;
				fragment_unnamed_628.y = _Curves.SampleLevel(sampler_Curves, fragment_unnamed_585.xy, 0.0f).w;
				fragment_unnamed_628 = float3(fragment_unnamed_628.xy.x, fragment_unnamed_628.xy.y, fragment_unnamed_628.z);
				float2 fragment_unnamed_693 = clamp(fragment_unnamed_628.xy, 0.0f.xx, 1.0f.xx);
				fragment_unnamed_628 = float3(fragment_unnamed_693.x, fragment_unnamed_693.y, fragment_unnamed_628.z);
				fragment_unnamed_628.x += (-0.5f);
				fragment_unnamed_628.x += fragment_unnamed_653.x;
				fragment_unnamed_538 = 1.0f < fragment_unnamed_628.x;
				float2 fragment_unnamed_713 = fragment_unnamed_628.xx + float2(1.0f, -1.0f);
				fragment_unnamed_280 = float3(fragment_unnamed_713.x, fragment_unnamed_713.y, fragment_unnamed_280.z);
				float fragment_unnamed_717;
				if (fragment_unnamed_538)
				{
					fragment_unnamed_717 = fragment_unnamed_280.y;
				}
				else
				{
					fragment_unnamed_717 = fragment_unnamed_628.x;
				}
				fragment_unnamed_544 = fragment_unnamed_717;
				fragment_unnamed_726 = fragment_unnamed_628.x < 0.0f;
				float fragment_unnamed_731;
				if (fragment_unnamed_726)
				{
					fragment_unnamed_731 = fragment_unnamed_280.x;
				}
				else
				{
					fragment_unnamed_731 = fragment_unnamed_544;
				}
				fragment_unnamed_628.x = fragment_unnamed_731;
				fragment_unnamed_280 = fragment_unnamed_628.xxx + float3(1.0f, 0.666666686534881591796875f, 0.3333333432674407958984375f);
				fragment_unnamed_280 = frac(fragment_unnamed_280);
				fragment_unnamed_280 = (fragment_unnamed_280 * 6.0f.xxx) + (-3.0f).xxx;
				fragment_unnamed_280 = abs(fragment_unnamed_280) + (-1.0f).xxx;
				fragment_unnamed_280 = clamp(fragment_unnamed_280, 0.0f.xxx, 1.0f.xxx);
				fragment_unnamed_280 += (-1.0f).xxx;
				fragment_unnamed_628.x = fragment_unnamed_9.x + 9.9999997473787516355514526367188e-05f;
				fragment_unnamed_766.x = fragment_unnamed_28.x / fragment_unnamed_628.x;
				float3 fragment_unnamed_778 = (fragment_unnamed_766.xxx * fragment_unnamed_280) + 1.0f.xxx;
				fragment_unnamed_28 = float4(fragment_unnamed_778.x, fragment_unnamed_778.y, fragment_unnamed_778.z, fragment_unnamed_28.w);
				fragment_unnamed_585 = fragment_unnamed_9.xxx * fragment_unnamed_28.xyz;
				fragment_unnamed_628.x = dot(fragment_unnamed_585, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f));
				float3 fragment_unnamed_797 = (fragment_unnamed_9.xxx * fragment_unnamed_28.xyz) + (-fragment_unnamed_628.xxx);
				fragment_unnamed_28 = float4(fragment_unnamed_797.x, fragment_unnamed_797.y, fragment_unnamed_797.z, fragment_unnamed_28.w);
				fragment_unnamed_163.y = 0.25f;
				fragment_unnamed_766.y = 0.25f;
				fragment_unnamed_9.x = _Curves.SampleLevel(sampler_Curves, fragment_unnamed_163.xy, 0.0f).y;
				fragment_unnamed_9.w = _Curves.SampleLevel(sampler_Curves, fragment_unnamed_766, 0.0f).z;
				fragment_unnamed_9 = float4(fragment_unnamed_9.xw.x, fragment_unnamed_9.y, fragment_unnamed_9.z, fragment_unnamed_9.xw.y);
				float2 fragment_unnamed_825 = clamp(fragment_unnamed_9.xw, 0.0f.xx, 1.0f.xx);
				fragment_unnamed_9 = float4(fragment_unnamed_825.x, fragment_unnamed_9.y, fragment_unnamed_9.z, fragment_unnamed_825.y);
				fragment_unnamed_9.x += fragment_unnamed_9.x;
				fragment_unnamed_9.x = dot(fragment_unnamed_9.ww, fragment_unnamed_9.xx);
				fragment_unnamed_9.x *= fragment_unnamed_628.y;
				fragment_unnamed_9.x = dot(_HueSatCon.yy, fragment_unnamed_9.xx);
				float3 fragment_unnamed_860 = (fragment_unnamed_9.xxx * fragment_unnamed_28.xyz) + fragment_unnamed_628.xxx;
				fragment_unnamed_9 = float4(fragment_unnamed_860.x, fragment_unnamed_860.y, fragment_unnamed_860.z, fragment_unnamed_9.w);
				fragment_unnamed_280.x = dot(float3(0.695452213287353515625f, 0.140678703784942626953125f, 0.16386906802654266357421875f), fragment_unnamed_9.xyz);
				fragment_unnamed_280.y = dot(float3(0.0447945632040500640869140625f, 0.859671115875244140625f, 0.095534317195415496826171875f), fragment_unnamed_9.xyz);
				fragment_unnamed_280.z = dot(float3(-0.0055258828215301036834716796875f, 0.0040252101607620716094970703125f, 1.00150072574615478515625f), fragment_unnamed_9.xyz);
				float3 fragment_unnamed_892 = (-fragment_unnamed_280.yxz) + fragment_unnamed_280.zyx;
				fragment_unnamed_9 = float4(fragment_unnamed_892.x, fragment_unnamed_892.y, fragment_unnamed_892.z, fragment_unnamed_9.w);
				float2 fragment_unnamed_899 = fragment_unnamed_9.xy * fragment_unnamed_280.zy;
				fragment_unnamed_9 = float4(fragment_unnamed_899.x, fragment_unnamed_899.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
				fragment_unnamed_9.x = fragment_unnamed_9.y + fragment_unnamed_9.x;
				fragment_unnamed_9.x = (fragment_unnamed_280.x * fragment_unnamed_9.z) + fragment_unnamed_9.x;
				fragment_unnamed_9.x = sqrt(fragment_unnamed_9.x);
				fragment_unnamed_628.x = fragment_unnamed_280.y + fragment_unnamed_280.z;
				fragment_unnamed_628.x = fragment_unnamed_280.x + fragment_unnamed_628.x;
				fragment_unnamed_9.x = (fragment_unnamed_9.x * 1.75f) + fragment_unnamed_628.x;
				fragment_unnamed_628.x = fragment_unnamed_9.x * 0.3333333432674407958984375f;
				fragment_unnamed_628.x = 0.07999999821186065673828125f / fragment_unnamed_628.x;
				fragment_unnamed_308 = min(fragment_unnamed_280.y, fragment_unnamed_280.x);
				fragment_unnamed_308 = min(fragment_unnamed_280.z, fragment_unnamed_308);
				fragment_unnamed_308 = max(fragment_unnamed_308, 9.9999997473787516355514526367188e-05f);
				fragment_unnamed_544 = max(fragment_unnamed_280.y, fragment_unnamed_280.x);
				fragment_unnamed_544 = max(fragment_unnamed_280.z, fragment_unnamed_544);
				float2 fragment_unnamed_974 = max(fragment_unnamed_544.xx, float2(9.9999997473787516355514526367188e-05f, 0.00999999977648258209228515625f));
				fragment_unnamed_163 = float4(fragment_unnamed_974.x, fragment_unnamed_974.y, fragment_unnamed_163.z, fragment_unnamed_163.w);
				fragment_unnamed_308 = (-fragment_unnamed_308) + fragment_unnamed_163.x;
				fragment_unnamed_628.y = fragment_unnamed_308 / fragment_unnamed_163.y;
				float2 fragment_unnamed_991 = fragment_unnamed_628.xy + float2(-0.5f, -0.4000000059604644775390625f);
				fragment_unnamed_628 = float3(fragment_unnamed_991.x, fragment_unnamed_628.y, fragment_unnamed_991.y);
				fragment_unnamed_28.x = fragment_unnamed_628.z * 2.5f;
				fragment_unnamed_544 = (fragment_unnamed_628.z * asfloat(2139095040)) + 0.5f;
				fragment_unnamed_544 = clamp(fragment_unnamed_544, 0.0f, 1.0f);
				fragment_unnamed_544 = (fragment_unnamed_544 * 2.0f) + (-1.0f);
				fragment_unnamed_28.x = (-abs(fragment_unnamed_28.x)) + 1.0f;
				fragment_unnamed_28.x = max(fragment_unnamed_28.x, 0.0f);
				fragment_unnamed_28.x = ((-fragment_unnamed_28.x) * fragment_unnamed_28.x) + 1.0f;
				fragment_unnamed_544 = (fragment_unnamed_544 * fragment_unnamed_28.x) + 1.0f;
				fragment_unnamed_544 *= 0.02500000037252902984619140625f;
				fragment_unnamed_628.x *= fragment_unnamed_544;
				fragment_unnamed_249.x = fragment_unnamed_9.x >= 0.4799999892711639404296875f;
				fragment_unnamed_172.x = 0.1599999964237213134765625f >= fragment_unnamed_9.x;
				float fragment_unnamed_1053;
				if (fragment_unnamed_249.x)
				{
					fragment_unnamed_1053 = 0.0f;
				}
				else
				{
					fragment_unnamed_1053 = fragment_unnamed_628.x;
				}
				fragment_unnamed_628.x = fragment_unnamed_1053;
				float fragment_unnamed_1063;
				if (fragment_unnamed_172.x)
				{
					fragment_unnamed_1063 = fragment_unnamed_544;
				}
				else
				{
					fragment_unnamed_1063 = fragment_unnamed_628.x;
				}
				fragment_unnamed_9.x = fragment_unnamed_1063;
				fragment_unnamed_9.x += 1.0f;
				float3 fragment_unnamed_1079 = fragment_unnamed_9.xxx * fragment_unnamed_280;
				fragment_unnamed_163 = float4(fragment_unnamed_163.x, fragment_unnamed_1079.x, fragment_unnamed_1079.y, fragment_unnamed_1079.z);
				fragment_unnamed_628.x = ((-fragment_unnamed_280.x) * fragment_unnamed_9.x) + 0.02999999932944774627685546875f;
				fragment_unnamed_544 = (fragment_unnamed_280.y * fragment_unnamed_9.x) + (-fragment_unnamed_163.w);
				fragment_unnamed_544 *= 1.73205077648162841796875f;
				fragment_unnamed_28.x = (fragment_unnamed_163.y * 2.0f) + (-fragment_unnamed_163.z);
				fragment_unnamed_9.x = ((-fragment_unnamed_280.z) * fragment_unnamed_9.x) + fragment_unnamed_28.x;
				fragment_unnamed_28.x = max(abs(fragment_unnamed_9.x), abs(fragment_unnamed_544));
				fragment_unnamed_28.x = 1.0f / fragment_unnamed_28.x;
				fragment_unnamed_280.x = min(abs(fragment_unnamed_9.x), abs(fragment_unnamed_544));
				fragment_unnamed_28.x *= fragment_unnamed_280.x;
				fragment_unnamed_280.x = fragment_unnamed_28.x * fragment_unnamed_28.x;
				fragment_unnamed_1151 = (fragment_unnamed_280.x * 0.02083509974181652069091796875f) + (-0.08513300120830535888671875f);
				fragment_unnamed_1151 = (fragment_unnamed_280.x * fragment_unnamed_1151) + 0.1801410019397735595703125f;
				fragment_unnamed_1151 = (fragment_unnamed_280.x * fragment_unnamed_1151) + (-0.33029949665069580078125f);
				fragment_unnamed_280.x = (fragment_unnamed_280.x * fragment_unnamed_1151) + 0.999866008758544921875f;
				fragment_unnamed_1151 = fragment_unnamed_280.x * fragment_unnamed_28.x;
				fragment_unnamed_1151 = (fragment_unnamed_1151 * (-2.0f)) + 1.57079637050628662109375f;
				fragment_unnamed_1187 = abs(fragment_unnamed_9.x) < abs(fragment_unnamed_544);
				fragment_unnamed_1151 = fragment_unnamed_1187 ? fragment_unnamed_1151 : 0.0f;
				fragment_unnamed_28.x = (fragment_unnamed_28.x * fragment_unnamed_280.x) + fragment_unnamed_1151;
				fragment_unnamed_1205 = fragment_unnamed_9.x < (-fragment_unnamed_9.x);
				fragment_unnamed_280.x = fragment_unnamed_1205 ? (-3.1415927410125732421875f) : 0.0f;
				fragment_unnamed_28.x = fragment_unnamed_280.x + fragment_unnamed_28.x;
				fragment_unnamed_280.x = min(fragment_unnamed_9.x, fragment_unnamed_544);
				fragment_unnamed_9.x = max(fragment_unnamed_9.x, fragment_unnamed_544);
				fragment_unnamed_172.x = fragment_unnamed_9.x >= (-fragment_unnamed_9.x);
				fragment_unnamed_538 = fragment_unnamed_280.x < (-fragment_unnamed_280.x);
				fragment_unnamed_172.x = fragment_unnamed_172.x && fragment_unnamed_538;
				float fragment_unnamed_1252;
				if (fragment_unnamed_172.x)
				{
					fragment_unnamed_1252 = -fragment_unnamed_28.x;
				}
				else
				{
					fragment_unnamed_1252 = fragment_unnamed_28.x;
				}
				fragment_unnamed_9.x = fragment_unnamed_1252;
				fragment_unnamed_9.x *= 57.295780181884765625f;
				bool2 fragment_unnamed_1273 = bool4(fragment_unnamed_163.zwzz.x == fragment_unnamed_163.yzyy.x, fragment_unnamed_163.zwzz.y == fragment_unnamed_163.yzyy.y, fragment_unnamed_163.zwzz.z == fragment_unnamed_163.yzyy.z, fragment_unnamed_163.zwzz.w == fragment_unnamed_163.yzyy.w).xy;
				fragment_unnamed_249 = bool4(fragment_unnamed_1273.x, fragment_unnamed_1273.y, fragment_unnamed_249.z, fragment_unnamed_249.w);
				fragment_unnamed_538 = fragment_unnamed_249.y && fragment_unnamed_249.x;
				float fragment_unnamed_1282;
				if (fragment_unnamed_538)
				{
					fragment_unnamed_1282 = 0.0f;
				}
				else
				{
					fragment_unnamed_1282 = fragment_unnamed_9.x;
				}
				fragment_unnamed_9.x = fragment_unnamed_1282;
				fragment_unnamed_538 = fragment_unnamed_9.x < 0.0f;
				fragment_unnamed_28.x = fragment_unnamed_9.x + 360.0f;
				float fragment_unnamed_1299;
				if (fragment_unnamed_538)
				{
					fragment_unnamed_1299 = fragment_unnamed_28.x;
				}
				else
				{
					fragment_unnamed_1299 = fragment_unnamed_9.x;
				}
				fragment_unnamed_9.x = fragment_unnamed_1299;
				fragment_unnamed_538 = 180.0f < fragment_unnamed_9.x;
				float2 fragment_unnamed_1317 = fragment_unnamed_9.xx + float2(360.0f, -360.0f);
				fragment_unnamed_28 = float4(fragment_unnamed_1317.x, fragment_unnamed_1317.y, fragment_unnamed_28.z, fragment_unnamed_28.w);
				float fragment_unnamed_1321;
				if (fragment_unnamed_538)
				{
					fragment_unnamed_1321 = fragment_unnamed_28.y;
				}
				else
				{
					fragment_unnamed_1321 = fragment_unnamed_9.x;
				}
				fragment_unnamed_544 = fragment_unnamed_1321;
				fragment_unnamed_172.x = fragment_unnamed_9.x < (-180.0f);
				float fragment_unnamed_1337;
				if (fragment_unnamed_172.x)
				{
					fragment_unnamed_1337 = fragment_unnamed_28.x;
				}
				else
				{
					fragment_unnamed_1337 = fragment_unnamed_544;
				}
				fragment_unnamed_9.x = fragment_unnamed_1337;
				fragment_unnamed_9.x *= 0.01481481455266475677490234375f;
				fragment_unnamed_9.x = (-abs(fragment_unnamed_9.x)) + 1.0f;
				fragment_unnamed_9.x = max(fragment_unnamed_9.x, 0.0f);
				fragment_unnamed_544 = (fragment_unnamed_9.x * (-2.0f)) + 3.0f;
				fragment_unnamed_9.x *= fragment_unnamed_9.x;
				fragment_unnamed_9.x *= fragment_unnamed_544;
				fragment_unnamed_9.x *= fragment_unnamed_9.x;
				fragment_unnamed_9.x = fragment_unnamed_628.y * fragment_unnamed_9.x;
				fragment_unnamed_9.x = fragment_unnamed_628.x * fragment_unnamed_9.x;
				fragment_unnamed_163.x = (fragment_unnamed_9.x * 0.180000007152557373046875f) + fragment_unnamed_163.y;
				fragment_unnamed_9.x = dot(float3(1.45143926143646240234375f, -0.236510753631591796875f, -0.214928567409515380859375f), fragment_unnamed_163.xzw);
				fragment_unnamed_9.y = dot(float3(-0.07655377686023712158203125f, 1.1762297153472900390625f, -0.0996759235858917236328125f), fragment_unnamed_163.xzw);
				fragment_unnamed_9.z = dot(float3(0.0083161480724811553955078125f, -0.0060324496589601039886474609375f, 0.99771630764007568359375f), fragment_unnamed_163.xzw);
				float3 fragment_unnamed_1417 = max(fragment_unnamed_9.xyz, 0.0f.xxx);
				fragment_unnamed_9 = float4(fragment_unnamed_1417.x, fragment_unnamed_1417.y, fragment_unnamed_1417.z, fragment_unnamed_9.w);
				fragment_unnamed_544 = dot(fragment_unnamed_9.xyz, float3(0.2722289860248565673828125f, 0.674081981182098388671875f, 0.0536894984543323516845703125f));
				float3 fragment_unnamed_1432 = (-fragment_unnamed_544.xxx) + fragment_unnamed_9.xyz;
				fragment_unnamed_9 = float4(fragment_unnamed_1432.x, fragment_unnamed_1432.y, fragment_unnamed_1432.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_1442 = (fragment_unnamed_9.xyz * 0.959999978542327880859375f.xxx) + fragment_unnamed_544.xxx;
				fragment_unnamed_9 = float4(fragment_unnamed_1442.x, fragment_unnamed_1442.y, fragment_unnamed_1442.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_1452 = (fragment_unnamed_9.xyz * 278.508514404296875f.xxx) + 10.77719974517822265625f.xxx;
				fragment_unnamed_28 = float4(fragment_unnamed_1452.x, fragment_unnamed_1452.y, fragment_unnamed_1452.z, fragment_unnamed_28.w);
				float3 fragment_unnamed_1459 = fragment_unnamed_9.xyz * fragment_unnamed_28.xyz;
				fragment_unnamed_28 = float4(fragment_unnamed_1459.x, fragment_unnamed_1459.y, fragment_unnamed_1459.z, fragment_unnamed_28.w);
				float3 fragment_unnamed_1469 = (fragment_unnamed_9.xyz * 293.6044921875f.xxx) + 88.71219635009765625f.xxx;
				fragment_unnamed_163 = float4(fragment_unnamed_1469.x, fragment_unnamed_1469.y, fragment_unnamed_1469.z, fragment_unnamed_163.w);
				float3 fragment_unnamed_1479 = (fragment_unnamed_9.xyz * fragment_unnamed_163.xyz) + 80.68890380859375f.xxx;
				fragment_unnamed_9 = float4(fragment_unnamed_1479.x, fragment_unnamed_1479.y, fragment_unnamed_1479.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_1486 = fragment_unnamed_28.xyz / fragment_unnamed_9.xyz;
				fragment_unnamed_9 = float4(fragment_unnamed_1486.x, fragment_unnamed_1486.y, fragment_unnamed_1486.z, fragment_unnamed_9.w);
				fragment_unnamed_28.z = dot(float3(-0.0055746496655046939849853515625f, 0.0040607335977256298065185546875f, 1.01033914089202880859375f), fragment_unnamed_9.xyz);
				fragment_unnamed_28.x = dot(float3(0.662454187870025634765625f, 0.1340042054653167724609375f, 0.1561876833438873291015625f), fragment_unnamed_9.xyz);
				fragment_unnamed_28.y = dot(float3(0.272228717803955078125f, 0.674081742763519287109375f, 0.053689517080783843994140625f), fragment_unnamed_9.xyz);
				fragment_unnamed_9.x = dot(fragment_unnamed_28.xyz, 1.0f.xxx);
				fragment_unnamed_9.x = max(fragment_unnamed_9.x, 9.9999997473787516355514526367188e-05f);
				float2 fragment_unnamed_1525 = fragment_unnamed_28.xy / fragment_unnamed_9.xx;
				fragment_unnamed_9 = float4(fragment_unnamed_1525.x, fragment_unnamed_1525.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
				fragment_unnamed_544 = max(fragment_unnamed_28.y, 0.0f);
				fragment_unnamed_544 = min(fragment_unnamed_544, 65504.0f);
				fragment_unnamed_544 = log2(fragment_unnamed_544);
				fragment_unnamed_544 *= 0.981100022792816162109375f;
				fragment_unnamed_28.y = exp2(fragment_unnamed_544);
				fragment_unnamed_544 = (-fragment_unnamed_9.x) + 1.0f;
				fragment_unnamed_9.z = (-fragment_unnamed_9.y) + fragment_unnamed_544;
				fragment_unnamed_628.x = max(fragment_unnamed_9.y, 9.9999997473787516355514526367188e-05f);
				fragment_unnamed_628.x = fragment_unnamed_28.y / fragment_unnamed_628.x;
				float2 fragment_unnamed_1565 = fragment_unnamed_628.xx * fragment_unnamed_9.xz;
				fragment_unnamed_28 = float4(fragment_unnamed_1565.x, fragment_unnamed_28.y, fragment_unnamed_1565.y, fragment_unnamed_28.w);
				fragment_unnamed_9.x = dot(float3(1.6410233974456787109375f, -0.324803292751312255859375f, -0.23642469942569732666015625f), fragment_unnamed_28.xyz);
				fragment_unnamed_9.y = dot(float3(-0.663662850856781005859375f, 1.6153316497802734375f, 0.016756348311901092529296875f), fragment_unnamed_28.xyz);
				fragment_unnamed_9.z = dot(float3(0.01172189414501190185546875f, -0.008284442126750946044921875f, 0.98839485645294189453125f), fragment_unnamed_28.xyz);
				fragment_unnamed_544 = dot(fragment_unnamed_9.xyz, float3(0.2722289860248565673828125f, 0.674081981182098388671875f, 0.0536894984543323516845703125f));
				float3 fragment_unnamed_1600 = (-fragment_unnamed_544.xxx) + fragment_unnamed_9.xyz;
				fragment_unnamed_9 = float4(fragment_unnamed_1600.x, fragment_unnamed_1600.y, fragment_unnamed_1600.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_1610 = (fragment_unnamed_9.xyz * 0.930000007152557373046875f.xxx) + fragment_unnamed_544.xxx;
				fragment_unnamed_9 = float4(fragment_unnamed_1610.x, fragment_unnamed_1610.y, fragment_unnamed_1610.z, fragment_unnamed_9.w);
				fragment_unnamed_28.x = dot(float3(0.662454187870025634765625f, 0.1340042054653167724609375f, 0.1561876833438873291015625f), fragment_unnamed_9.xyz);
				fragment_unnamed_28.y = dot(float3(0.272228717803955078125f, 0.674081742763519287109375f, 0.053689517080783843994140625f), fragment_unnamed_9.xyz);
				fragment_unnamed_28.z = dot(float3(-0.0055746496655046939849853515625f, 0.0040607335977256298065185546875f, 1.01033914089202880859375f), fragment_unnamed_9.xyz);
				fragment_unnamed_9.x = dot(float3(0.98722398281097412109375f, -0.0061132698319852352142333984375f, 0.01595330052077770233154296875f), fragment_unnamed_28.xyz);
				fragment_unnamed_9.y = dot(float3(-0.007598360069096088409423828125f, 1.00186002254486083984375f, 0.0053301998414099216461181640625f), fragment_unnamed_28.xyz);
				fragment_unnamed_9.z = dot(float3(0.003072570078074932098388671875f, -0.0050959498621523380279541015625f, 1.0816800594329833984375f), fragment_unnamed_28.xyz);
				fragment_unnamed_28.x = dot(float3(3.2409698963165283203125f, -1.53738319873809814453125f, -0.4986107647418975830078125f), fragment_unnamed_9.xyz);
				fragment_unnamed_28.y = dot(float3(-0.96924364566802978515625f, 1.875967502593994140625f, 0.0415550582110881805419921875f), fragment_unnamed_9.xyz);
				fragment_unnamed_28.z = dot(float3(0.055630080401897430419921875f, -0.2039769589900970458984375f, 1.05697154998779296875f), fragment_unnamed_9.xyz);
				float3 fragment_unnamed_1677 = max(fragment_unnamed_28.xyz, 0.0f.xxx);
				fragment_output_0 = float4(fragment_unnamed_1677.x, fragment_unnamed_1677.y, fragment_unnamed_1677.z, fragment_output_0.w);
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

			#endif // TONEMAPPING_ACES
			#endif // !TONEMAPPING_CUSTOM
			#endif // !TONEMAPPING_NEUTRAL


			#ifdef TONEMAPPING_NEUTRAL
			#ifndef TONEMAPPING_ACES
			#ifndef TONEMAPPING_CUSTOM
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

			float4 _Lut2D_Params;
			float3 _ColorBalance;
			float3 _ColorFilter;
			float3 _HueSatCon;
			float3 _ChannelMixerRed;
			float3 _ChannelMixerGreen;
			float3 _ChannelMixerBlue;
			float3 _Lift;
			float3 _InvGamma;
			float3 _Gain;

			Texture2D<float4> _Curves;
			SamplerState sampler_Curves;

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
			static float4 fragment_unnamed_28;
			static bool fragment_unnamed_269;
			static float fragment_unnamed_275;
			static float4 fragment_unnamed_282;
			static float3 fragment_unnamed_318;
			static float3 fragment_unnamed_354;
			static float2 fragment_unnamed_363;
			static float2 fragment_unnamed_387;
			static bool fragment_unnamed_436;
			static float2 fragment_unnamed_492;

			void frag_main()
			{
				float2 fragment_unnamed_25 = fragment_input_0 + (-_Lut2D_Params.yz);
				fragment_unnamed_9 = float4(fragment_unnamed_9.x, fragment_unnamed_25.x, fragment_unnamed_25.y, fragment_unnamed_9.w);
				fragment_unnamed_28.x = fragment_unnamed_9.y * _Lut2D_Params.x;
				fragment_unnamed_9.x = frac(fragment_unnamed_28.x);
				fragment_unnamed_28.x = fragment_unnamed_9.x / _Lut2D_Params.x;
				fragment_unnamed_9.w = fragment_unnamed_9.y + (-fragment_unnamed_28.x);
				float3 fragment_unnamed_66 = (fragment_unnamed_9.xzw * _Lut2D_Params.www) + (-0.41358840465545654296875f).xxx;
				fragment_unnamed_9 = float4(fragment_unnamed_66.x, fragment_unnamed_66.y, fragment_unnamed_66.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_79 = (fragment_unnamed_9.xyz * _HueSatCon.zzz) + 0.0275523960590362548828125f.xxx;
				fragment_unnamed_9 = float4(fragment_unnamed_79.x, fragment_unnamed_79.y, fragment_unnamed_79.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_86 = fragment_unnamed_9.xyz * 13.6054821014404296875f.xxx;
				fragment_unnamed_9 = float4(fragment_unnamed_86.x, fragment_unnamed_86.y, fragment_unnamed_86.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_91 = exp2(fragment_unnamed_9.xyz);
				fragment_unnamed_9 = float4(fragment_unnamed_91.x, fragment_unnamed_91.y, fragment_unnamed_91.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_98 = fragment_unnamed_9.xyz + (-0.04799599945545196533203125f).xxx;
				fragment_unnamed_9 = float4(fragment_unnamed_98.x, fragment_unnamed_98.y, fragment_unnamed_98.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_105 = fragment_unnamed_9.xyz * 0.17999999225139617919921875f.xxx;
				fragment_unnamed_9 = float4(fragment_unnamed_105.x, fragment_unnamed_105.y, fragment_unnamed_105.z, fragment_unnamed_9.w);
				fragment_unnamed_28.x = dot(float3(0.390404999256134033203125f, 0.549941003322601318359375f, 0.008926319889724254608154296875f), fragment_unnamed_9.xyz);
				fragment_unnamed_28.y = dot(float3(0.070841602981090545654296875f, 0.963172018527984619140625f, 0.001357750035822391510009765625f), fragment_unnamed_9.xyz);
				fragment_unnamed_28.z = dot(float3(0.02310819923877716064453125f, 0.1280210018157958984375f, 0.936245024204254150390625f), fragment_unnamed_9.xyz);
				float3 fragment_unnamed_138 = fragment_unnamed_28.xyz * _ColorBalance;
				fragment_unnamed_9 = float4(fragment_unnamed_138.x, fragment_unnamed_138.y, fragment_unnamed_138.z, fragment_unnamed_9.w);
				fragment_unnamed_28.x = dot(float3(2.85846996307373046875f, -1.62879002094268798828125f, -0.0248910002410411834716796875f), fragment_unnamed_9.xyz);
				fragment_unnamed_28.y = dot(float3(-0.21018199622631072998046875f, 1.1582000255584716796875f, 0.0003242809907533228397369384765625f), fragment_unnamed_9.xyz);
				fragment_unnamed_28.z = dot(float3(-0.0418119989335536956787109375f, -0.118169002234935760498046875f, 1.0686700344085693359375f), fragment_unnamed_9.xyz);
				float3 fragment_unnamed_170 = fragment_unnamed_28.xyz * _ColorFilter;
				fragment_unnamed_9 = float4(fragment_unnamed_170.x, fragment_unnamed_170.y, fragment_unnamed_170.z, fragment_unnamed_9.w);
				fragment_unnamed_28.x = dot(fragment_unnamed_9.xyz, _ChannelMixerRed);
				fragment_unnamed_28.y = dot(fragment_unnamed_9.xyz, _ChannelMixerGreen);
				fragment_unnamed_28.z = dot(fragment_unnamed_9.xyz, _ChannelMixerBlue);
				float3 fragment_unnamed_203 = (fragment_unnamed_28.xyz * _Gain) + _Lift;
				fragment_unnamed_9 = float4(fragment_unnamed_203.x, fragment_unnamed_203.y, fragment_unnamed_203.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_209 = log2(abs(fragment_unnamed_9.xyz));
				fragment_unnamed_28 = float4(fragment_unnamed_209.x, fragment_unnamed_209.y, fragment_unnamed_209.z, fragment_unnamed_28.w);
				float3 fragment_unnamed_219 = (fragment_unnamed_9.xyz * 3.4028234663852885981170418348452e+38f.xxx) + 0.5f.xxx;
				fragment_unnamed_9 = float4(fragment_unnamed_219.x, fragment_unnamed_219.y, fragment_unnamed_219.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_228 = clamp(fragment_unnamed_9.xyz, 0.0f.xxx, 1.0f.xxx);
				fragment_unnamed_9 = float4(fragment_unnamed_228.x, fragment_unnamed_228.y, fragment_unnamed_228.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_238 = (fragment_unnamed_9.xyz * 2.0f.xxx) + (-1.0f).xxx;
				fragment_unnamed_9 = float4(fragment_unnamed_238.x, fragment_unnamed_238.y, fragment_unnamed_238.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_246 = fragment_unnamed_28.xyz * _InvGamma;
				fragment_unnamed_28 = float4(fragment_unnamed_246.x, fragment_unnamed_246.y, fragment_unnamed_246.z, fragment_unnamed_28.w);
				float3 fragment_unnamed_251 = exp2(fragment_unnamed_28.xyz);
				fragment_unnamed_28 = float4(fragment_unnamed_251.x, fragment_unnamed_251.y, fragment_unnamed_251.z, fragment_unnamed_28.w);
				float3 fragment_unnamed_258 = fragment_unnamed_9.xyz * fragment_unnamed_28.xyz;
				fragment_unnamed_9 = float4(fragment_unnamed_258.x, fragment_unnamed_258.y, fragment_unnamed_258.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_264 = max(fragment_unnamed_9.xyz, 0.0f.xxx);
				fragment_unnamed_9 = float4(fragment_unnamed_264.x, fragment_unnamed_264.y, fragment_unnamed_264.z, fragment_unnamed_9.w);
				fragment_unnamed_269 = fragment_unnamed_9.y >= fragment_unnamed_9.z;
				fragment_unnamed_275 = float(fragment_unnamed_269);
				fragment_unnamed_28 = float4(fragment_unnamed_9.zy.x, fragment_unnamed_9.zy.y, fragment_unnamed_28.z, fragment_unnamed_28.w);
				float2 fragment_unnamed_288 = fragment_unnamed_9.yz + (-fragment_unnamed_28.xy);
				fragment_unnamed_282 = float4(fragment_unnamed_288.x, fragment_unnamed_288.y, fragment_unnamed_282.z, fragment_unnamed_282.w);
				fragment_unnamed_28.z = -1.0f;
				fragment_unnamed_28.w = 0.666666686534881591796875f;
				fragment_unnamed_282.z = 1.0f;
				fragment_unnamed_282.w = -1.0f;
				fragment_unnamed_28 = (fragment_unnamed_275.xxxx * fragment_unnamed_282.xywz) + fragment_unnamed_28.xywz;
				fragment_unnamed_269 = fragment_unnamed_9.x >= fragment_unnamed_28.x;
				fragment_unnamed_275 = float(fragment_unnamed_269);
				fragment_unnamed_282.z = fragment_unnamed_28.w;
				fragment_unnamed_28.w = fragment_unnamed_9.x;
				fragment_unnamed_318.x = dot(fragment_unnamed_9.xyz, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f));
				fragment_unnamed_282 = float4(fragment_unnamed_28.wyx.x, fragment_unnamed_28.wyx.y, fragment_unnamed_282.z, fragment_unnamed_28.wyx.z);
				fragment_unnamed_282 = (-fragment_unnamed_28) + fragment_unnamed_282;
				fragment_unnamed_9 = (fragment_unnamed_275.xxxx * fragment_unnamed_282) + fragment_unnamed_28;
				fragment_unnamed_28.x = min(fragment_unnamed_9.y, fragment_unnamed_9.w);
				fragment_unnamed_28.x = fragment_unnamed_9.x + (-fragment_unnamed_28.x);
				fragment_unnamed_354.x = (fragment_unnamed_28.x * 6.0f) + 9.9999997473787516355514526367188e-05f;
				fragment_unnamed_363.x = (-fragment_unnamed_9.y) + fragment_unnamed_9.w;
				fragment_unnamed_363.x /= fragment_unnamed_354.x;
				fragment_unnamed_363.x += fragment_unnamed_9.z;
				fragment_unnamed_282.x = abs(fragment_unnamed_363.x);
				fragment_unnamed_387.x = fragment_unnamed_282.x + _HueSatCon.x;
				fragment_unnamed_318.y = 0.25f;
				fragment_unnamed_387.y = 0.25f;
				fragment_unnamed_363.x = _Curves.SampleLevel(sampler_Curves, fragment_unnamed_387, 0.0f).x;
				fragment_unnamed_363.y = _Curves.SampleLevel(sampler_Curves, fragment_unnamed_318.xy, 0.0f).w;
				fragment_unnamed_363 = fragment_unnamed_363;
				fragment_unnamed_363 = clamp(fragment_unnamed_363, 0.0f.xx, 1.0f.xx);
				fragment_unnamed_363.x = fragment_unnamed_387.x + fragment_unnamed_363.x;
				fragment_unnamed_354 = fragment_unnamed_363.xxx + float3(-0.5f, 0.5f, -1.5f);
				fragment_unnamed_436 = 1.0f < fragment_unnamed_354.x;
				float fragment_unnamed_442;
				if (fragment_unnamed_436)
				{
					fragment_unnamed_442 = fragment_unnamed_354.z;
				}
				else
				{
					fragment_unnamed_442 = fragment_unnamed_354.x;
				}
				fragment_unnamed_363.x = fragment_unnamed_442;
				fragment_unnamed_269 = fragment_unnamed_354.x < 0.0f;
				float fragment_unnamed_456;
				if (fragment_unnamed_269)
				{
					fragment_unnamed_456 = fragment_unnamed_354.y;
				}
				else
				{
					fragment_unnamed_456 = fragment_unnamed_363.x;
				}
				fragment_unnamed_363.x = fragment_unnamed_456;
				fragment_unnamed_354 = fragment_unnamed_363.xxx + float3(1.0f, 0.666666686534881591796875f, 0.3333333432674407958984375f);
				fragment_unnamed_354 = frac(fragment_unnamed_354);
				fragment_unnamed_354 = (fragment_unnamed_354 * 6.0f.xxx) + (-3.0f).xxx;
				fragment_unnamed_354 = abs(fragment_unnamed_354) + (-1.0f).xxx;
				fragment_unnamed_354 = clamp(fragment_unnamed_354, 0.0f.xxx, 1.0f.xxx);
				fragment_unnamed_354 += (-1.0f).xxx;
				fragment_unnamed_363.x = fragment_unnamed_9.x + 9.9999997473787516355514526367188e-05f;
				fragment_unnamed_492.x = fragment_unnamed_28.x / fragment_unnamed_363.x;
				float3 fragment_unnamed_504 = (fragment_unnamed_492.xxx * fragment_unnamed_354) + 1.0f.xxx;
				fragment_unnamed_28 = float4(fragment_unnamed_504.x, fragment_unnamed_504.y, fragment_unnamed_504.z, fragment_unnamed_28.w);
				fragment_unnamed_318 = fragment_unnamed_9.xxx * fragment_unnamed_28.xyz;
				fragment_unnamed_363.x = dot(fragment_unnamed_318, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f));
				float3 fragment_unnamed_523 = (fragment_unnamed_9.xxx * fragment_unnamed_28.xyz) + (-fragment_unnamed_363.xxx);
				fragment_unnamed_28 = float4(fragment_unnamed_523.x, fragment_unnamed_523.y, fragment_unnamed_523.z, fragment_unnamed_28.w);
				fragment_unnamed_282.y = 0.25f;
				fragment_unnamed_492.y = 0.25f;
				fragment_unnamed_9.x = _Curves.SampleLevel(sampler_Curves, fragment_unnamed_282.xy, 0.0f).y;
				fragment_unnamed_9.w = _Curves.SampleLevel(sampler_Curves, fragment_unnamed_492, 0.0f).z;
				fragment_unnamed_9 = float4(fragment_unnamed_9.xw.x, fragment_unnamed_9.y, fragment_unnamed_9.z, fragment_unnamed_9.xw.y);
				float2 fragment_unnamed_551 = clamp(fragment_unnamed_9.xw, 0.0f.xx, 1.0f.xx);
				fragment_unnamed_9 = float4(fragment_unnamed_551.x, fragment_unnamed_9.y, fragment_unnamed_9.z, fragment_unnamed_551.y);
				fragment_unnamed_9.x += fragment_unnamed_9.x;
				fragment_unnamed_9.x = dot(fragment_unnamed_9.ww, fragment_unnamed_9.xx);
				fragment_unnamed_9.x *= fragment_unnamed_363.y;
				fragment_unnamed_9.x = dot(_HueSatCon.yy, fragment_unnamed_9.xx);
				float3 fragment_unnamed_586 = (fragment_unnamed_9.xxx * fragment_unnamed_28.xyz) + fragment_unnamed_363.xxx;
				fragment_unnamed_9 = float4(fragment_unnamed_586.x, fragment_unnamed_586.y, fragment_unnamed_586.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_591 = max(fragment_unnamed_9.xyz, 0.0f.xxx);
				fragment_unnamed_9 = float4(fragment_unnamed_591.x, fragment_unnamed_591.y, fragment_unnamed_591.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_601 = (fragment_unnamed_9.xyz * 0.2626772224903106689453125f.xxx) + 0.069599993526935577392578125f.xxx;
				fragment_unnamed_28 = float4(fragment_unnamed_601.x, fragment_unnamed_601.y, fragment_unnamed_601.z, fragment_unnamed_28.w);
				float3 fragment_unnamed_608 = fragment_unnamed_9.xyz * 1.31338608264923095703125f.xxx;
				fragment_unnamed_282 = float4(fragment_unnamed_608.x, fragment_unnamed_608.y, fragment_unnamed_608.z, fragment_unnamed_282.w);
				float3 fragment_unnamed_616 = (fragment_unnamed_9.xyz * 0.2626772224903106689453125f.xxx) + 0.2899999916553497314453125f.xxx;
				fragment_unnamed_9 = float4(fragment_unnamed_616.x, fragment_unnamed_616.y, fragment_unnamed_616.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_626 = (fragment_unnamed_282.xyz * fragment_unnamed_9.xyz) + 0.081600010395050048828125f.xxx;
				fragment_unnamed_9 = float4(fragment_unnamed_626.x, fragment_unnamed_626.y, fragment_unnamed_626.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_636 = (fragment_unnamed_282.xyz * fragment_unnamed_28.xyz) + 0.0054399999789893627166748046875f.xxx;
				fragment_unnamed_28 = float4(fragment_unnamed_636.x, fragment_unnamed_636.y, fragment_unnamed_636.z, fragment_unnamed_28.w);
				float3 fragment_unnamed_643 = fragment_unnamed_28.xyz / fragment_unnamed_9.xyz;
				fragment_unnamed_9 = float4(fragment_unnamed_643.x, fragment_unnamed_643.y, fragment_unnamed_643.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_650 = fragment_unnamed_9.xyz + (-0.066666662693023681640625f).xxx;
				fragment_unnamed_9 = float4(fragment_unnamed_650.x, fragment_unnamed_650.y, fragment_unnamed_650.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_655 = fragment_unnamed_9.xyz * 1.31338608264923095703125f.xxx;
				fragment_unnamed_9 = float4(fragment_unnamed_655.x, fragment_unnamed_655.y, fragment_unnamed_655.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_662 = max(fragment_unnamed_9.xyz, 0.0f.xxx);
				fragment_output_0 = float4(fragment_unnamed_662.x, fragment_unnamed_662.y, fragment_unnamed_662.z, fragment_output_0.w);
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

			#endif // TONEMAPPING_NEUTRAL
			#endif // !TONEMAPPING_ACES
			#endif // !TONEMAPPING_CUSTOM


			#ifdef TONEMAPPING_CUSTOM
			#ifndef TONEMAPPING_ACES
			#ifndef TONEMAPPING_NEUTRAL
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

			float4 _Lut2D_Params;
			float3 _ColorBalance;
			float3 _ColorFilter;
			float3 _HueSatCon;
			float3 _ChannelMixerRed;
			float3 _ChannelMixerGreen;
			float3 _ChannelMixerBlue;
			float3 _Lift;
			float3 _InvGamma;
			float3 _Gain;
			float4 _CustomToneCurve;
			float4 _ToeSegmentA;
			float4 _ToeSegmentB;
			float4 _MidSegmentA;
			float4 _MidSegmentB;
			float4 _ShoSegmentA;
			float4 _ShoSegmentB;

			Texture2D<float4> _Curves;
			SamplerState sampler_Curves;

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
			static float4 fragment_unnamed_28;
			static bool fragment_unnamed_269;
			static float fragment_unnamed_275;
			static float4 fragment_unnamed_282;
			static float4 fragment_unnamed_317;
			static float3 fragment_unnamed_354;
			static float2 fragment_unnamed_363;
			static float2 fragment_unnamed_387;
			static bool fragment_unnamed_436;
			static float2 fragment_unnamed_492;
			static bool2 fragment_unnamed_608;
			static bool4 fragment_unnamed_618;
			static float fragment_unnamed_650;
			static bool fragment_unnamed_666;
			static bool fragment_unnamed_768;
			static float4 fragment_unnamed_772;

			void frag_main()
			{
				float2 fragment_unnamed_25 = fragment_input_0 + (-_Lut2D_Params.yz);
				fragment_unnamed_9 = float4(fragment_unnamed_9.x, fragment_unnamed_25.x, fragment_unnamed_25.y, fragment_unnamed_9.w);
				fragment_unnamed_28.x = fragment_unnamed_9.y * _Lut2D_Params.x;
				fragment_unnamed_9.x = frac(fragment_unnamed_28.x);
				fragment_unnamed_28.x = fragment_unnamed_9.x / _Lut2D_Params.x;
				fragment_unnamed_9.w = fragment_unnamed_9.y + (-fragment_unnamed_28.x);
				float3 fragment_unnamed_66 = (fragment_unnamed_9.xzw * _Lut2D_Params.www) + (-0.41358840465545654296875f).xxx;
				fragment_unnamed_9 = float4(fragment_unnamed_66.x, fragment_unnamed_66.y, fragment_unnamed_66.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_79 = (fragment_unnamed_9.xyz * _HueSatCon.zzz) + 0.0275523960590362548828125f.xxx;
				fragment_unnamed_9 = float4(fragment_unnamed_79.x, fragment_unnamed_79.y, fragment_unnamed_79.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_86 = fragment_unnamed_9.xyz * 13.6054821014404296875f.xxx;
				fragment_unnamed_9 = float4(fragment_unnamed_86.x, fragment_unnamed_86.y, fragment_unnamed_86.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_91 = exp2(fragment_unnamed_9.xyz);
				fragment_unnamed_9 = float4(fragment_unnamed_91.x, fragment_unnamed_91.y, fragment_unnamed_91.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_98 = fragment_unnamed_9.xyz + (-0.04799599945545196533203125f).xxx;
				fragment_unnamed_9 = float4(fragment_unnamed_98.x, fragment_unnamed_98.y, fragment_unnamed_98.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_105 = fragment_unnamed_9.xyz * 0.17999999225139617919921875f.xxx;
				fragment_unnamed_9 = float4(fragment_unnamed_105.x, fragment_unnamed_105.y, fragment_unnamed_105.z, fragment_unnamed_9.w);
				fragment_unnamed_28.x = dot(float3(0.390404999256134033203125f, 0.549941003322601318359375f, 0.008926319889724254608154296875f), fragment_unnamed_9.xyz);
				fragment_unnamed_28.y = dot(float3(0.070841602981090545654296875f, 0.963172018527984619140625f, 0.001357750035822391510009765625f), fragment_unnamed_9.xyz);
				fragment_unnamed_28.z = dot(float3(0.02310819923877716064453125f, 0.1280210018157958984375f, 0.936245024204254150390625f), fragment_unnamed_9.xyz);
				float3 fragment_unnamed_138 = fragment_unnamed_28.xyz * _ColorBalance;
				fragment_unnamed_9 = float4(fragment_unnamed_138.x, fragment_unnamed_138.y, fragment_unnamed_138.z, fragment_unnamed_9.w);
				fragment_unnamed_28.x = dot(float3(2.85846996307373046875f, -1.62879002094268798828125f, -0.0248910002410411834716796875f), fragment_unnamed_9.xyz);
				fragment_unnamed_28.y = dot(float3(-0.21018199622631072998046875f, 1.1582000255584716796875f, 0.0003242809907533228397369384765625f), fragment_unnamed_9.xyz);
				fragment_unnamed_28.z = dot(float3(-0.0418119989335536956787109375f, -0.118169002234935760498046875f, 1.0686700344085693359375f), fragment_unnamed_9.xyz);
				float3 fragment_unnamed_170 = fragment_unnamed_28.xyz * _ColorFilter;
				fragment_unnamed_9 = float4(fragment_unnamed_170.x, fragment_unnamed_170.y, fragment_unnamed_170.z, fragment_unnamed_9.w);
				fragment_unnamed_28.x = dot(fragment_unnamed_9.xyz, _ChannelMixerRed);
				fragment_unnamed_28.y = dot(fragment_unnamed_9.xyz, _ChannelMixerGreen);
				fragment_unnamed_28.z = dot(fragment_unnamed_9.xyz, _ChannelMixerBlue);
				float3 fragment_unnamed_203 = (fragment_unnamed_28.xyz * _Gain) + _Lift;
				fragment_unnamed_9 = float4(fragment_unnamed_203.x, fragment_unnamed_203.y, fragment_unnamed_203.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_209 = log2(abs(fragment_unnamed_9.xyz));
				fragment_unnamed_28 = float4(fragment_unnamed_209.x, fragment_unnamed_209.y, fragment_unnamed_209.z, fragment_unnamed_28.w);
				float3 fragment_unnamed_219 = (fragment_unnamed_9.xyz * 3.4028234663852885981170418348452e+38f.xxx) + 0.5f.xxx;
				fragment_unnamed_9 = float4(fragment_unnamed_219.x, fragment_unnamed_219.y, fragment_unnamed_219.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_228 = clamp(fragment_unnamed_9.xyz, 0.0f.xxx, 1.0f.xxx);
				fragment_unnamed_9 = float4(fragment_unnamed_228.x, fragment_unnamed_228.y, fragment_unnamed_228.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_238 = (fragment_unnamed_9.xyz * 2.0f.xxx) + (-1.0f).xxx;
				fragment_unnamed_9 = float4(fragment_unnamed_238.x, fragment_unnamed_238.y, fragment_unnamed_238.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_246 = fragment_unnamed_28.xyz * _InvGamma;
				fragment_unnamed_28 = float4(fragment_unnamed_246.x, fragment_unnamed_246.y, fragment_unnamed_246.z, fragment_unnamed_28.w);
				float3 fragment_unnamed_251 = exp2(fragment_unnamed_28.xyz);
				fragment_unnamed_28 = float4(fragment_unnamed_251.x, fragment_unnamed_251.y, fragment_unnamed_251.z, fragment_unnamed_28.w);
				float3 fragment_unnamed_258 = fragment_unnamed_9.xyz * fragment_unnamed_28.xyz;
				fragment_unnamed_9 = float4(fragment_unnamed_258.x, fragment_unnamed_258.y, fragment_unnamed_258.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_264 = max(fragment_unnamed_9.xyz, 0.0f.xxx);
				fragment_unnamed_9 = float4(fragment_unnamed_264.x, fragment_unnamed_264.y, fragment_unnamed_264.z, fragment_unnamed_9.w);
				fragment_unnamed_269 = fragment_unnamed_9.y >= fragment_unnamed_9.z;
				fragment_unnamed_275 = float(fragment_unnamed_269);
				fragment_unnamed_28 = float4(fragment_unnamed_9.zy.x, fragment_unnamed_9.zy.y, fragment_unnamed_28.z, fragment_unnamed_28.w);
				float2 fragment_unnamed_288 = fragment_unnamed_9.yz + (-fragment_unnamed_28.xy);
				fragment_unnamed_282 = float4(fragment_unnamed_288.x, fragment_unnamed_288.y, fragment_unnamed_282.z, fragment_unnamed_282.w);
				fragment_unnamed_28.z = -1.0f;
				fragment_unnamed_28.w = 0.666666686534881591796875f;
				fragment_unnamed_282.z = 1.0f;
				fragment_unnamed_282.w = -1.0f;
				fragment_unnamed_28 = (fragment_unnamed_275.xxxx * fragment_unnamed_282.xywz) + fragment_unnamed_28.xywz;
				fragment_unnamed_269 = fragment_unnamed_9.x >= fragment_unnamed_28.x;
				fragment_unnamed_275 = float(fragment_unnamed_269);
				fragment_unnamed_282.z = fragment_unnamed_28.w;
				fragment_unnamed_28.w = fragment_unnamed_9.x;
				fragment_unnamed_317.x = dot(fragment_unnamed_9.xyz, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f));
				fragment_unnamed_282 = float4(fragment_unnamed_28.wyx.x, fragment_unnamed_28.wyx.y, fragment_unnamed_282.z, fragment_unnamed_28.wyx.z);
				fragment_unnamed_282 = (-fragment_unnamed_28) + fragment_unnamed_282;
				fragment_unnamed_9 = (fragment_unnamed_275.xxxx * fragment_unnamed_282) + fragment_unnamed_28;
				fragment_unnamed_28.x = min(fragment_unnamed_9.y, fragment_unnamed_9.w);
				fragment_unnamed_28.x = fragment_unnamed_9.x + (-fragment_unnamed_28.x);
				fragment_unnamed_354.x = (fragment_unnamed_28.x * 6.0f) + 9.9999997473787516355514526367188e-05f;
				fragment_unnamed_363.x = (-fragment_unnamed_9.y) + fragment_unnamed_9.w;
				fragment_unnamed_363.x /= fragment_unnamed_354.x;
				fragment_unnamed_363.x += fragment_unnamed_9.z;
				fragment_unnamed_282.x = abs(fragment_unnamed_363.x);
				fragment_unnamed_387.x = fragment_unnamed_282.x + _HueSatCon.x;
				fragment_unnamed_317.y = 0.25f;
				fragment_unnamed_387.y = 0.25f;
				fragment_unnamed_363.x = _Curves.SampleLevel(sampler_Curves, fragment_unnamed_387, 0.0f).x;
				fragment_unnamed_363.y = _Curves.SampleLevel(sampler_Curves, fragment_unnamed_317.xy, 0.0f).w;
				fragment_unnamed_363 = fragment_unnamed_363;
				fragment_unnamed_363 = clamp(fragment_unnamed_363, 0.0f.xx, 1.0f.xx);
				fragment_unnamed_363.x = fragment_unnamed_387.x + fragment_unnamed_363.x;
				fragment_unnamed_354 = fragment_unnamed_363.xxx + float3(-0.5f, 0.5f, -1.5f);
				fragment_unnamed_436 = 1.0f < fragment_unnamed_354.x;
				float fragment_unnamed_442;
				if (fragment_unnamed_436)
				{
					fragment_unnamed_442 = fragment_unnamed_354.z;
				}
				else
				{
					fragment_unnamed_442 = fragment_unnamed_354.x;
				}
				fragment_unnamed_363.x = fragment_unnamed_442;
				fragment_unnamed_269 = fragment_unnamed_354.x < 0.0f;
				float fragment_unnamed_456;
				if (fragment_unnamed_269)
				{
					fragment_unnamed_456 = fragment_unnamed_354.y;
				}
				else
				{
					fragment_unnamed_456 = fragment_unnamed_363.x;
				}
				fragment_unnamed_363.x = fragment_unnamed_456;
				fragment_unnamed_354 = fragment_unnamed_363.xxx + float3(1.0f, 0.666666686534881591796875f, 0.3333333432674407958984375f);
				fragment_unnamed_354 = frac(fragment_unnamed_354);
				fragment_unnamed_354 = (fragment_unnamed_354 * 6.0f.xxx) + (-3.0f).xxx;
				fragment_unnamed_354 = abs(fragment_unnamed_354) + (-1.0f).xxx;
				fragment_unnamed_354 = clamp(fragment_unnamed_354, 0.0f.xxx, 1.0f.xxx);
				fragment_unnamed_354 += (-1.0f).xxx;
				fragment_unnamed_363.x = fragment_unnamed_9.x + 9.9999997473787516355514526367188e-05f;
				fragment_unnamed_492.x = fragment_unnamed_28.x / fragment_unnamed_363.x;
				float3 fragment_unnamed_504 = (fragment_unnamed_492.xxx * fragment_unnamed_354) + 1.0f.xxx;
				fragment_unnamed_28 = float4(fragment_unnamed_504.x, fragment_unnamed_504.y, fragment_unnamed_504.z, fragment_unnamed_28.w);
				float3 fragment_unnamed_511 = fragment_unnamed_9.xxx * fragment_unnamed_28.xyz;
				fragment_unnamed_317 = float4(fragment_unnamed_511.x, fragment_unnamed_511.y, fragment_unnamed_511.z, fragment_unnamed_317.w);
				fragment_unnamed_363.x = dot(fragment_unnamed_317.xyz, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f));
				float3 fragment_unnamed_526 = (fragment_unnamed_9.xxx * fragment_unnamed_28.xyz) + (-fragment_unnamed_363.xxx);
				fragment_unnamed_28 = float4(fragment_unnamed_526.x, fragment_unnamed_526.y, fragment_unnamed_526.z, fragment_unnamed_28.w);
				fragment_unnamed_282.y = 0.25f;
				fragment_unnamed_492.y = 0.25f;
				fragment_unnamed_9.x = _Curves.SampleLevel(sampler_Curves, fragment_unnamed_282.xy, 0.0f).y;
				fragment_unnamed_9.w = _Curves.SampleLevel(sampler_Curves, fragment_unnamed_492, 0.0f).z;
				fragment_unnamed_9 = float4(fragment_unnamed_9.xw.x, fragment_unnamed_9.y, fragment_unnamed_9.z, fragment_unnamed_9.xw.y);
				float2 fragment_unnamed_554 = clamp(fragment_unnamed_9.xw, 0.0f.xx, 1.0f.xx);
				fragment_unnamed_9 = float4(fragment_unnamed_554.x, fragment_unnamed_9.y, fragment_unnamed_9.z, fragment_unnamed_554.y);
				fragment_unnamed_9.x += fragment_unnamed_9.x;
				fragment_unnamed_9.x = dot(fragment_unnamed_9.ww, fragment_unnamed_9.xx);
				fragment_unnamed_9.x *= fragment_unnamed_363.y;
				fragment_unnamed_9.x = dot(_HueSatCon.yy, fragment_unnamed_9.xx);
				float3 fragment_unnamed_589 = (fragment_unnamed_9.xxx * fragment_unnamed_28.xyz) + fragment_unnamed_363.xxx;
				fragment_unnamed_9 = float4(fragment_unnamed_589.x, fragment_unnamed_589.y, fragment_unnamed_589.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_594 = max(fragment_unnamed_9.xyz, 0.0f.xxx);
				fragment_unnamed_9 = float4(fragment_unnamed_594.x, fragment_unnamed_594.y, fragment_unnamed_594.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_603 = fragment_unnamed_9.xyz * _CustomToneCurve.xxx;
				fragment_unnamed_28 = float4(fragment_unnamed_603.x, fragment_unnamed_603.y, fragment_unnamed_603.z, fragment_unnamed_28.w);
				fragment_unnamed_608 = bool4(fragment_unnamed_28.zzzz.x < _CustomToneCurve.yzyz.x, fragment_unnamed_28.zzzz.y < _CustomToneCurve.yzyz.y, fragment_unnamed_28.zzzz.z < _CustomToneCurve.yzyz.z, fragment_unnamed_28.zzzz.w < _CustomToneCurve.yzyz.w).xy;
				fragment_unnamed_618 = bool4(fragment_unnamed_28.xxyy.x < _CustomToneCurve.yzyz.x, fragment_unnamed_28.xxyy.y < _CustomToneCurve.yzyz.y, fragment_unnamed_28.xxyy.z < _CustomToneCurve.yzyz.z, fragment_unnamed_28.xxyy.w < _CustomToneCurve.yzyz.w);
				float4 fragment_unnamed_628;
				if (fragment_unnamed_608.y)
				{
					fragment_unnamed_628 = _MidSegmentA;
				}
				else
				{
					fragment_unnamed_628 = _ShoSegmentA;
				}
				fragment_unnamed_317 = fragment_unnamed_628;
				float4 fragment_unnamed_641;
				if (fragment_unnamed_608.x)
				{
					fragment_unnamed_641 = _ToeSegmentA;
				}
				else
				{
					fragment_unnamed_641 = fragment_unnamed_317;
				}
				fragment_unnamed_317 = fragment_unnamed_641;
				fragment_unnamed_650 = (fragment_unnamed_9.z * _CustomToneCurve.x) + (-fragment_unnamed_317.x);
				fragment_unnamed_650 = fragment_unnamed_317.z * fragment_unnamed_650;
				fragment_unnamed_275 = log2(fragment_unnamed_650);
				fragment_unnamed_666 = 0.0f < fragment_unnamed_650;
				float2 fragment_unnamed_672;
				if (fragment_unnamed_608.y)
				{
					fragment_unnamed_672 = _MidSegmentB.xy;
				}
				else
				{
					fragment_unnamed_672 = _ShoSegmentB.xy;
				}
				fragment_unnamed_28 = float4(fragment_unnamed_672.x, fragment_unnamed_672.y, fragment_unnamed_28.z, fragment_unnamed_28.w);
				float2 fragment_unnamed_689;
				if (fragment_unnamed_608.x)
				{
					fragment_unnamed_689 = _ToeSegmentB.xy;
				}
				else
				{
					fragment_unnamed_689 = fragment_unnamed_28.xy;
				}
				fragment_unnamed_28 = float4(fragment_unnamed_689.x, fragment_unnamed_689.y, fragment_unnamed_28.z, fragment_unnamed_28.w);
				fragment_unnamed_275 *= fragment_unnamed_28.y;
				fragment_unnamed_275 = (fragment_unnamed_275 * 0.693147182464599609375f) + fragment_unnamed_28.x;
				fragment_unnamed_275 *= 1.44269502162933349609375f;
				fragment_unnamed_275 = exp2(fragment_unnamed_275);
				fragment_unnamed_650 = fragment_unnamed_666 ? fragment_unnamed_275 : 0.0f;
				fragment_unnamed_28.z = (fragment_unnamed_650 * fragment_unnamed_317.w) + fragment_unnamed_317.y;
				float4 fragment_unnamed_730;
				if (fragment_unnamed_618.y)
				{
					fragment_unnamed_730 = _MidSegmentA;
				}
				else
				{
					fragment_unnamed_730 = _ShoSegmentA;
				}
				fragment_unnamed_317 = fragment_unnamed_730;
				float4 fragment_unnamed_741;
				if (fragment_unnamed_618.x)
				{
					fragment_unnamed_741 = _ToeSegmentA;
				}
				else
				{
					fragment_unnamed_741 = fragment_unnamed_317;
				}
				fragment_unnamed_317 = fragment_unnamed_741;
				fragment_unnamed_9.x = (fragment_unnamed_9.x * _CustomToneCurve.x) + (-fragment_unnamed_317.x);
				fragment_unnamed_9.x = fragment_unnamed_317.z * fragment_unnamed_9.x;
				fragment_unnamed_650 = log2(fragment_unnamed_9.x);
				fragment_unnamed_768 = 0.0f < fragment_unnamed_9.x;
				float fragment_unnamed_775;
				if (fragment_unnamed_618.y)
				{
					fragment_unnamed_775 = _MidSegmentB.x;
				}
				else
				{
					fragment_unnamed_775 = _ShoSegmentB.x;
				}
				fragment_unnamed_772.x = fragment_unnamed_775;
				float fragment_unnamed_787;
				if (fragment_unnamed_618.y)
				{
					fragment_unnamed_787 = _MidSegmentB.y;
				}
				else
				{
					fragment_unnamed_787 = _ShoSegmentB.y;
				}
				fragment_unnamed_772.y = fragment_unnamed_787;
				float fragment_unnamed_799;
				if (fragment_unnamed_618.w)
				{
					fragment_unnamed_799 = _MidSegmentB.x;
				}
				else
				{
					fragment_unnamed_799 = _ShoSegmentB.x;
				}
				fragment_unnamed_772.z = fragment_unnamed_799;
				float fragment_unnamed_811;
				if (fragment_unnamed_618.w)
				{
					fragment_unnamed_811 = _MidSegmentB.y;
				}
				else
				{
					fragment_unnamed_811 = _ShoSegmentB.y;
				}
				fragment_unnamed_772.w = fragment_unnamed_811;
				float4 fragment_unnamed_821 = fragment_unnamed_772;
				float fragment_unnamed_825;
				if (fragment_unnamed_618.x)
				{
					fragment_unnamed_825 = _ToeSegmentB.x;
				}
				else
				{
					fragment_unnamed_825 = fragment_unnamed_772.x;
				}
				fragment_unnamed_821.x = fragment_unnamed_825;
				float fragment_unnamed_837;
				if (fragment_unnamed_618.x)
				{
					fragment_unnamed_837 = _ToeSegmentB.y;
				}
				else
				{
					fragment_unnamed_837 = fragment_unnamed_772.y;
				}
				fragment_unnamed_821.y = fragment_unnamed_837;
				float fragment_unnamed_849;
				if (fragment_unnamed_618.z)
				{
					fragment_unnamed_849 = _ToeSegmentB.x;
				}
				else
				{
					fragment_unnamed_849 = fragment_unnamed_772.z;
				}
				fragment_unnamed_821.z = fragment_unnamed_849;
				float fragment_unnamed_861;
				if (fragment_unnamed_618.z)
				{
					fragment_unnamed_861 = _ToeSegmentB.y;
				}
				else
				{
					fragment_unnamed_861 = fragment_unnamed_772.w;
				}
				fragment_unnamed_821.w = fragment_unnamed_861;
				fragment_unnamed_772 = fragment_unnamed_821;
				fragment_unnamed_650 *= fragment_unnamed_772.y;
				fragment_unnamed_650 = (fragment_unnamed_650 * 0.693147182464599609375f) + fragment_unnamed_772.x;
				fragment_unnamed_650 *= 1.44269502162933349609375f;
				fragment_unnamed_650 = exp2(fragment_unnamed_650);
				fragment_unnamed_9.x = fragment_unnamed_768 ? fragment_unnamed_650 : 0.0f;
				fragment_unnamed_28.x = (fragment_unnamed_9.x * fragment_unnamed_317.w) + fragment_unnamed_317.y;
				float4 fragment_unnamed_900;
				if (fragment_unnamed_618.w)
				{
					fragment_unnamed_900 = _MidSegmentA;
				}
				else
				{
					fragment_unnamed_900 = _ShoSegmentA;
				}
				fragment_unnamed_317 = fragment_unnamed_900;
				float4 fragment_unnamed_911;
				if (fragment_unnamed_618.z)
				{
					fragment_unnamed_911 = _ToeSegmentA;
				}
				else
				{
					fragment_unnamed_911 = fragment_unnamed_317;
				}
				fragment_unnamed_282 = fragment_unnamed_911;
				fragment_unnamed_9.x = (fragment_unnamed_9.y * _CustomToneCurve.x) + (-fragment_unnamed_282.x);
				fragment_unnamed_9.x = fragment_unnamed_282.z * fragment_unnamed_9.x;
				fragment_unnamed_363.x = log2(fragment_unnamed_9.x);
				fragment_unnamed_768 = 0.0f < fragment_unnamed_9.x;
				fragment_unnamed_363.x *= fragment_unnamed_772.w;
				fragment_unnamed_363.x = (fragment_unnamed_363.x * 0.693147182464599609375f) + fragment_unnamed_772.z;
				fragment_unnamed_363.x *= 1.44269502162933349609375f;
				fragment_unnamed_363.x = exp2(fragment_unnamed_363.x);
				float fragment_unnamed_964;
				if (fragment_unnamed_768)
				{
					fragment_unnamed_964 = fragment_unnamed_363.x;
				}
				else
				{
					fragment_unnamed_964 = 0.0f;
				}
				fragment_unnamed_9.x = fragment_unnamed_964;
				fragment_unnamed_28.y = (fragment_unnamed_9.x * fragment_unnamed_282.w) + fragment_unnamed_282.y;
				float3 fragment_unnamed_985 = max(fragment_unnamed_28.xyz, 0.0f.xxx);
				fragment_output_0 = float4(fragment_unnamed_985.x, fragment_unnamed_985.y, fragment_unnamed_985.z, fragment_output_0.w);
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

			#endif // TONEMAPPING_CUSTOM
			#endif // !TONEMAPPING_ACES
			#endif // !TONEMAPPING_NEUTRAL


			#ifndef TONEMAPPING_ACES
			#ifndef TONEMAPPING_CUSTOM
			#ifndef TONEMAPPING_NEUTRAL
			#define ANY_SHADER_VARIANT_ACTIVE

			float4 _Lut2D_Params;
			float3 _ColorBalance;
			float3 _ColorFilter;
			float3 _HueSatCon;
			float3 _ChannelMixerRed;
			float3 _ChannelMixerGreen;
			float3 _ChannelMixerBlue;
			float3 _Lift;
			float3 _InvGamma;
			float3 _Gain;

			static float4 fragment_uniform_buffer_0[39];
			Texture2D<float4> _Curves;
			SamplerState sampler_Curves;

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
				precise float fragment_unnamed_41 = (-0.0f) - fragment_uniform_buffer_0[28u].y;
				precise float fragment_unnamed_44 = (-0.0f) - fragment_uniform_buffer_0[28u].z;
				precise float fragment_unnamed_45 = fragment_input_1.x + fragment_unnamed_41;
				precise float fragment_unnamed_46 = fragment_input_1.y + fragment_unnamed_44;
				precise float fragment_unnamed_50 = fragment_unnamed_45 * fragment_uniform_buffer_0[28u].x;
				float fragment_unnamed_52 = frac(fragment_unnamed_50);
				precise float fragment_unnamed_56 = fragment_unnamed_52 / fragment_uniform_buffer_0[28u].x;
				precise float fragment_unnamed_57 = (-0.0f) - fragment_unnamed_56;
				precise float fragment_unnamed_58 = fragment_unnamed_45 + fragment_unnamed_57;
				precise float fragment_unnamed_74 = mad(mad(fragment_unnamed_52, fragment_uniform_buffer_0[28u].w, -0.41358840465545654296875f), fragment_uniform_buffer_0[32u].z, 0.0275523960590362548828125f) * 13.6054821014404296875f;
				precise float fragment_unnamed_76 = mad(mad(fragment_unnamed_46, fragment_uniform_buffer_0[28u].w, -0.41358840465545654296875f), fragment_uniform_buffer_0[32u].z, 0.0275523960590362548828125f) * 13.6054821014404296875f;
				precise float fragment_unnamed_77 = mad(mad(fragment_unnamed_58, fragment_uniform_buffer_0[28u].w, -0.41358840465545654296875f), fragment_uniform_buffer_0[32u].z, 0.0275523960590362548828125f) * 13.6054821014404296875f;
				precise float fragment_unnamed_81 = exp2(fragment_unnamed_74) + (-0.04799599945545196533203125f);
				precise float fragment_unnamed_83 = exp2(fragment_unnamed_76) + (-0.04799599945545196533203125f);
				precise float fragment_unnamed_84 = exp2(fragment_unnamed_77) + (-0.04799599945545196533203125f);
				precise float fragment_unnamed_85 = fragment_unnamed_81 * 0.17999999225139617919921875f;
				precise float fragment_unnamed_87 = fragment_unnamed_83 * 0.17999999225139617919921875f;
				precise float fragment_unnamed_88 = fragment_unnamed_84 * 0.17999999225139617919921875f;
				precise float fragment_unnamed_114 = dot(float3(0.390404999256134033203125f, 0.549941003322601318359375f, 0.008926319889724254608154296875f), float3(fragment_unnamed_85, fragment_unnamed_87, fragment_unnamed_88)) * fragment_uniform_buffer_0[30u].x;
				precise float fragment_unnamed_115 = dot(float3(0.070841602981090545654296875f, 0.963172018527984619140625f, 0.001357750035822391510009765625f), float3(fragment_unnamed_85, fragment_unnamed_87, fragment_unnamed_88)) * fragment_uniform_buffer_0[30u].y;
				precise float fragment_unnamed_116 = dot(float3(0.02310819923877716064453125f, 0.1280210018157958984375f, 0.936245024204254150390625f), float3(fragment_unnamed_85, fragment_unnamed_87, fragment_unnamed_88)) * fragment_uniform_buffer_0[30u].z;
				precise float fragment_unnamed_141 = dot(float3(2.85846996307373046875f, -1.62879002094268798828125f, -0.0248910002410411834716796875f), float3(fragment_unnamed_114, fragment_unnamed_115, fragment_unnamed_116)) * fragment_uniform_buffer_0[31u].x;
				precise float fragment_unnamed_142 = dot(float3(-0.21018199622631072998046875f, 1.1582000255584716796875f, 0.0003242809907533228397369384765625f), float3(fragment_unnamed_114, fragment_unnamed_115, fragment_unnamed_116)) * fragment_uniform_buffer_0[31u].y;
				precise float fragment_unnamed_143 = dot(float3(-0.0418119989335536956787109375f, -0.118169002234935760498046875f, 1.0686700344085693359375f), float3(fragment_unnamed_114, fragment_unnamed_115, fragment_unnamed_116)) * fragment_uniform_buffer_0[31u].z;
				float fragment_unnamed_183 = mad(dot(float3(fragment_unnamed_141, fragment_unnamed_142, fragment_unnamed_143), float3(fragment_uniform_buffer_0[33u].xyz)), fragment_uniform_buffer_0[38u].x, fragment_uniform_buffer_0[36u].x);
				float fragment_unnamed_184 = mad(dot(float3(fragment_unnamed_141, fragment_unnamed_142, fragment_unnamed_143), float3(fragment_uniform_buffer_0[34u].xyz)), fragment_uniform_buffer_0[38u].y, fragment_uniform_buffer_0[36u].y);
				float fragment_unnamed_185 = mad(dot(float3(fragment_unnamed_141, fragment_unnamed_142, fragment_unnamed_143), float3(fragment_uniform_buffer_0[35u].xyz)), fragment_uniform_buffer_0[38u].z, fragment_uniform_buffer_0[36u].z);
				precise float fragment_unnamed_213 = log2(abs(fragment_unnamed_183)) * fragment_uniform_buffer_0[37u].x;
				precise float fragment_unnamed_214 = log2(abs(fragment_unnamed_184)) * fragment_uniform_buffer_0[37u].y;
				precise float fragment_unnamed_215 = log2(abs(fragment_unnamed_185)) * fragment_uniform_buffer_0[37u].z;
				precise float fragment_unnamed_219 = mad(clamp(mad(fragment_unnamed_183, 3.4028234663852885981170418348452e+38f, 0.5f), 0.0f, 1.0f), 2.0f, -1.0f) * exp2(fragment_unnamed_213);
				precise float fragment_unnamed_220 = mad(clamp(mad(fragment_unnamed_184, 3.4028234663852885981170418348452e+38f, 0.5f), 0.0f, 1.0f), 2.0f, -1.0f) * exp2(fragment_unnamed_214);
				precise float fragment_unnamed_221 = mad(clamp(mad(fragment_unnamed_185, 3.4028234663852885981170418348452e+38f, 0.5f), 0.0f, 1.0f), 2.0f, -1.0f) * exp2(fragment_unnamed_215);
				float fragment_unnamed_222 = max(fragment_unnamed_219, 0.0f);
				float fragment_unnamed_223 = max(fragment_unnamed_220, 0.0f);
				float fragment_unnamed_224 = max(fragment_unnamed_221, 0.0f);
				float fragment_unnamed_231 = asfloat(((fragment_unnamed_223 >= fragment_unnamed_224) ? 4294967295u : 0u) & 1065353216u);
				precise float fragment_unnamed_232 = (-0.0f) - fragment_unnamed_224;
				precise float fragment_unnamed_233 = (-0.0f) - fragment_unnamed_223;
				precise float fragment_unnamed_234 = fragment_unnamed_223 + fragment_unnamed_232;
				precise float fragment_unnamed_235 = fragment_unnamed_224 + fragment_unnamed_233;
				float fragment_unnamed_242 = mad(fragment_unnamed_231, fragment_unnamed_234, fragment_unnamed_224);
				float fragment_unnamed_243 = mad(fragment_unnamed_231, fragment_unnamed_235, fragment_unnamed_223);
				float fragment_unnamed_244 = mad(fragment_unnamed_231, asfloat(3212836864u), asfloat(1059760811u));
				float fragment_unnamed_249 = asfloat(((fragment_unnamed_222 >= fragment_unnamed_242) ? 4294967295u : 0u) & 1065353216u);
				precise float fragment_unnamed_256 = (-0.0f) - fragment_unnamed_242;
				precise float fragment_unnamed_257 = (-0.0f) - fragment_unnamed_243;
				precise float fragment_unnamed_258 = (-0.0f) - fragment_unnamed_244;
				precise float fragment_unnamed_259 = (-0.0f) - fragment_unnamed_222;
				precise float fragment_unnamed_260 = fragment_unnamed_256 + fragment_unnamed_222;
				precise float fragment_unnamed_261 = fragment_unnamed_257 + fragment_unnamed_243;
				precise float fragment_unnamed_262 = fragment_unnamed_258 + mad(fragment_unnamed_231, asfloat(1065353216u), asfloat(3212836864u));
				precise float fragment_unnamed_263 = fragment_unnamed_259 + fragment_unnamed_242;
				float fragment_unnamed_264 = mad(fragment_unnamed_249, fragment_unnamed_260, fragment_unnamed_242);
				float fragment_unnamed_265 = mad(fragment_unnamed_249, fragment_unnamed_261, fragment_unnamed_243);
				float fragment_unnamed_267 = mad(fragment_unnamed_249, fragment_unnamed_263, fragment_unnamed_222);
				precise float fragment_unnamed_269 = (-0.0f) - min(fragment_unnamed_265, fragment_unnamed_267);
				precise float fragment_unnamed_270 = fragment_unnamed_264 + fragment_unnamed_269;
				precise float fragment_unnamed_274 = (-0.0f) - fragment_unnamed_265;
				precise float fragment_unnamed_275 = fragment_unnamed_274 + fragment_unnamed_267;
				precise float fragment_unnamed_276 = fragment_unnamed_275 / mad(fragment_unnamed_270, 6.0f, 9.9999997473787516355514526367188e-05f);
				precise float fragment_unnamed_277 = fragment_unnamed_276 + mad(fragment_unnamed_249, fragment_unnamed_262, fragment_unnamed_244);
				float fragment_unnamed_278 = abs(fragment_unnamed_277);
				precise float fragment_unnamed_282 = fragment_unnamed_278 + fragment_uniform_buffer_0[32u].x;
				precise float fragment_unnamed_296 = fragment_unnamed_282 + clamp(_Curves.SampleLevel(sampler_Curves, float2(fragment_unnamed_282, asfloat(1048576000u)), 0.0f).x, 0.0f, 1.0f);
				precise float fragment_unnamed_297 = fragment_unnamed_296 + (-0.5f);
				precise float fragment_unnamed_299 = fragment_unnamed_296 + 0.5f;
				precise float fragment_unnamed_300 = fragment_unnamed_296 + (-1.5f);
				float fragment_unnamed_309 = asfloat((fragment_unnamed_297 < 0.0f) ? asuint(fragment_unnamed_299) : ((1.0f < fragment_unnamed_297) ? asuint(fragment_unnamed_300) : asuint(fragment_unnamed_297)));
				precise float fragment_unnamed_310 = fragment_unnamed_309 + 1.0f;
				precise float fragment_unnamed_311 = fragment_unnamed_309 + 0.666666686534881591796875f;
				precise float fragment_unnamed_313 = fragment_unnamed_309 + 0.3333333432674407958984375f;
				precise float fragment_unnamed_325 = abs(mad(frac(fragment_unnamed_310), 6.0f, -3.0f)) + (-1.0f);
				precise float fragment_unnamed_326 = abs(mad(frac(fragment_unnamed_311), 6.0f, -3.0f)) + (-1.0f);
				precise float fragment_unnamed_327 = abs(mad(frac(fragment_unnamed_313), 6.0f, -3.0f)) + (-1.0f);
				precise float fragment_unnamed_331 = clamp(fragment_unnamed_325, 0.0f, 1.0f) + (-1.0f);
				precise float fragment_unnamed_332 = clamp(fragment_unnamed_326, 0.0f, 1.0f) + (-1.0f);
				precise float fragment_unnamed_333 = clamp(fragment_unnamed_327, 0.0f, 1.0f) + (-1.0f);
				precise float fragment_unnamed_334 = fragment_unnamed_264 + 9.9999997473787516355514526367188e-05f;
				precise float fragment_unnamed_335 = fragment_unnamed_270 / fragment_unnamed_334;
				float fragment_unnamed_336 = mad(fragment_unnamed_335, fragment_unnamed_331, 1.0f);
				float fragment_unnamed_337 = mad(fragment_unnamed_335, fragment_unnamed_332, 1.0f);
				float fragment_unnamed_338 = mad(fragment_unnamed_335, fragment_unnamed_333, 1.0f);
				precise float fragment_unnamed_339 = fragment_unnamed_336 * fragment_unnamed_264;
				precise float fragment_unnamed_340 = fragment_unnamed_337 * fragment_unnamed_264;
				precise float fragment_unnamed_341 = fragment_unnamed_338 * fragment_unnamed_264;
				float fragment_unnamed_342 = dot(float3(fragment_unnamed_339, fragment_unnamed_340, fragment_unnamed_341), float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f));
				precise float fragment_unnamed_345 = (-0.0f) - fragment_unnamed_342;
				float fragment_unnamed_358 = clamp(_Curves.SampleLevel(sampler_Curves, float2(fragment_unnamed_278, asfloat(1048576000u)), 0.0f).y, 0.0f, 1.0f);
				precise float fragment_unnamed_359 = fragment_unnamed_358 + fragment_unnamed_358;
				precise float fragment_unnamed_363 = dot(clamp(_Curves.SampleLevel(sampler_Curves, float2(fragment_unnamed_335, asfloat(1048576000u)), 0.0f).z, 0.0f, 1.0f).xx, fragment_unnamed_359.xx) * clamp(_Curves.SampleLevel(sampler_Curves, float2(dot(float3(fragment_unnamed_222, fragment_unnamed_223, fragment_unnamed_224), float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)), asfloat(1048576000u)), 0.0f).w, 0.0f, 1.0f);
				float fragment_unnamed_367 = dot(fragment_uniform_buffer_0[32u].y.xx, fragment_unnamed_363.xx);
				fragment_output_0.x = max(mad(fragment_unnamed_367, mad(fragment_unnamed_264, fragment_unnamed_336, fragment_unnamed_345), fragment_unnamed_342), 0.0f);
				fragment_output_0.y = max(mad(fragment_unnamed_367, mad(fragment_unnamed_264, fragment_unnamed_337, fragment_unnamed_345), fragment_unnamed_342), 0.0f);
				fragment_output_0.z = max(mad(fragment_unnamed_367, mad(fragment_unnamed_264, fragment_unnamed_338, fragment_unnamed_345), fragment_unnamed_342), 0.0f);
				fragment_output_0.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[28] = float4(_Lut2D_Params[0], _Lut2D_Params[1], _Lut2D_Params[2], _Lut2D_Params[3]);

				fragment_uniform_buffer_0[30] = float4(_ColorBalance[0], _ColorBalance[1], _ColorBalance[2], fragment_uniform_buffer_0[30][3]);

				fragment_uniform_buffer_0[31] = float4(_ColorFilter[0], _ColorFilter[1], _ColorFilter[2], fragment_uniform_buffer_0[31][3]);

				fragment_uniform_buffer_0[32] = float4(_HueSatCon[0], _HueSatCon[1], _HueSatCon[2], fragment_uniform_buffer_0[32][3]);

				fragment_uniform_buffer_0[33] = float4(_ChannelMixerRed[0], _ChannelMixerRed[1], _ChannelMixerRed[2], fragment_uniform_buffer_0[33][3]);

				fragment_uniform_buffer_0[34] = float4(_ChannelMixerGreen[0], _ChannelMixerGreen[1], _ChannelMixerGreen[2], fragment_uniform_buffer_0[34][3]);

				fragment_uniform_buffer_0[35] = float4(_ChannelMixerBlue[0], _ChannelMixerBlue[1], _ChannelMixerBlue[2], fragment_uniform_buffer_0[35][3]);

				fragment_uniform_buffer_0[36] = float4(_Lift[0], _Lift[1], _Lift[2], fragment_uniform_buffer_0[36][3]);

				fragment_uniform_buffer_0[37] = float4(_InvGamma[0], _InvGamma[1], _InvGamma[2], fragment_uniform_buffer_0[37][3]);

				fragment_uniform_buffer_0[38] = float4(_Gain[0], _Gain[1], _Gain[2], fragment_uniform_buffer_0[38][3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // !TONEMAPPING_ACES
			#endif // !TONEMAPPING_CUSTOM
			#endif // !TONEMAPPING_NEUTRAL


			#ifdef TONEMAPPING_ACES
			#ifndef TONEMAPPING_CUSTOM
			#ifndef TONEMAPPING_NEUTRAL
			#define ANY_SHADER_VARIANT_ACTIVE

			float4 _Lut2D_Params;
			float3 _ColorBalance;
			float3 _ColorFilter;
			float3 _HueSatCon;
			float3 _ChannelMixerRed;
			float3 _ChannelMixerGreen;
			float3 _ChannelMixerBlue;
			float3 _Lift;
			float3 _InvGamma;
			float3 _Gain;

			static float4 fragment_uniform_buffer_0[39];
			Texture2D<float4> _Curves;
			SamplerState sampler_Curves;

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
				precise float fragment_unnamed_41 = (-0.0f) - fragment_uniform_buffer_0[28u].y;
				precise float fragment_unnamed_44 = (-0.0f) - fragment_uniform_buffer_0[28u].z;
				precise float fragment_unnamed_45 = fragment_input_1.x + fragment_unnamed_41;
				precise float fragment_unnamed_46 = fragment_input_1.y + fragment_unnamed_44;
				precise float fragment_unnamed_50 = fragment_unnamed_45 * fragment_uniform_buffer_0[28u].x;
				float fragment_unnamed_52 = frac(fragment_unnamed_50);
				precise float fragment_unnamed_56 = fragment_unnamed_52 / fragment_uniform_buffer_0[28u].x;
				precise float fragment_unnamed_57 = (-0.0f) - fragment_unnamed_56;
				precise float fragment_unnamed_58 = fragment_unnamed_45 + fragment_unnamed_57;
				precise float fragment_unnamed_66 = mad(fragment_unnamed_52, fragment_uniform_buffer_0[28u].w, -0.3860360085964202880859375f) * 13.6054821014404296875f;
				precise float fragment_unnamed_68 = mad(fragment_unnamed_46, fragment_uniform_buffer_0[28u].w, -0.3860360085964202880859375f) * 13.6054821014404296875f;
				precise float fragment_unnamed_69 = mad(fragment_unnamed_58, fragment_uniform_buffer_0[28u].w, -0.3860360085964202880859375f) * 13.6054821014404296875f;
				precise float fragment_unnamed_73 = exp2(fragment_unnamed_66) + (-0.04799599945545196533203125f);
				precise float fragment_unnamed_75 = exp2(fragment_unnamed_68) + (-0.04799599945545196533203125f);
				precise float fragment_unnamed_76 = exp2(fragment_unnamed_69) + (-0.04799599945545196533203125f);
				precise float fragment_unnamed_77 = fragment_unnamed_73 * 0.17999999225139617919921875f;
				precise float fragment_unnamed_79 = fragment_unnamed_75 * 0.17999999225139617919921875f;
				precise float fragment_unnamed_80 = fragment_unnamed_76 * 0.17999999225139617919921875f;
				float fragment_unnamed_104 = min(max(dot(float3(0.4397009909152984619140625f, 0.3829779922962188720703125f, 0.1773349940776824951171875f), float3(fragment_unnamed_77, fragment_unnamed_79, fragment_unnamed_80)), 0.0f), 65504.0f);
				float fragment_unnamed_106 = min(max(dot(float3(0.08979229629039764404296875f, 0.813422977924346923828125f, 0.09676159918308258056640625f), float3(fragment_unnamed_77, fragment_unnamed_79, fragment_unnamed_80)), 0.0f), 65504.0f);
				float fragment_unnamed_107 = min(max(dot(float3(0.01754399947822093963623046875f, 0.11154399812221527099609375f, 0.870703995227813720703125f), float3(fragment_unnamed_77, fragment_unnamed_79, fragment_unnamed_80)), 0.0f), 65504.0f);
				precise float fragment_unnamed_116 = log2(mad(fragment_unnamed_104, 0.5f, 1.5258779967552982270717620849609e-05f)) + 9.72000026702880859375f;
				precise float fragment_unnamed_118 = log2(mad(fragment_unnamed_106, 0.5f, 1.5258779967552982270717620849609e-05f)) + 9.72000026702880859375f;
				precise float fragment_unnamed_119 = log2(mad(fragment_unnamed_107, 0.5f, 1.5258779967552982270717620849609e-05f)) + 9.72000026702880859375f;
				precise float fragment_unnamed_120 = fragment_unnamed_116 * 0.057077623903751373291015625f;
				precise float fragment_unnamed_122 = fragment_unnamed_118 * 0.057077623903751373291015625f;
				precise float fragment_unnamed_123 = fragment_unnamed_119 * 0.057077623903751373291015625f;
				precise float fragment_unnamed_132 = log2(fragment_unnamed_104) + 9.72000026702880859375f;
				precise float fragment_unnamed_133 = log2(fragment_unnamed_106) + 9.72000026702880859375f;
				precise float fragment_unnamed_134 = log2(fragment_unnamed_107) + 9.72000026702880859375f;
				precise float fragment_unnamed_135 = fragment_unnamed_132 * 0.057077623903751373291015625f;
				precise float fragment_unnamed_136 = fragment_unnamed_133 * 0.057077623903751373291015625f;
				precise float fragment_unnamed_137 = fragment_unnamed_134 * 0.057077623903751373291015625f;
				precise float fragment_unnamed_150 = asfloat((fragment_unnamed_104 < 3.0517570849042385816574096679688e-05f) ? asuint(fragment_unnamed_120) : asuint(fragment_unnamed_135)) + (-0.41358840465545654296875f);
				precise float fragment_unnamed_152 = asfloat((fragment_unnamed_106 < 3.0517570849042385816574096679688e-05f) ? asuint(fragment_unnamed_122) : asuint(fragment_unnamed_136)) + (-0.41358840465545654296875f);
				precise float fragment_unnamed_153 = asfloat((fragment_unnamed_107 < 3.0517570849042385816574096679688e-05f) ? asuint(fragment_unnamed_123) : asuint(fragment_unnamed_137)) + (-0.41358840465545654296875f);
				float fragment_unnamed_158 = mad(fragment_unnamed_150, fragment_uniform_buffer_0[32u].z, 0.41358840465545654296875f);
				float fragment_unnamed_160 = mad(fragment_unnamed_152, fragment_uniform_buffer_0[32u].z, 0.41358840465545654296875f);
				float fragment_unnamed_161 = mad(fragment_unnamed_153, fragment_uniform_buffer_0[32u].z, 0.41358840465545654296875f);
				float fragment_unnamed_175 = exp2(mad(fragment_unnamed_158, 17.520000457763671875f, -9.72000026702880859375f));
				float fragment_unnamed_176 = exp2(mad(fragment_unnamed_160, 17.520000457763671875f, -9.72000026702880859375f));
				float fragment_unnamed_177 = exp2(mad(fragment_unnamed_161, 17.520000457763671875f, -9.72000026702880859375f));
				precise float fragment_unnamed_183 = fragment_unnamed_175 + (-1.52587890625e-05f);
				precise float fragment_unnamed_185 = fragment_unnamed_176 + (-1.52587890625e-05f);
				precise float fragment_unnamed_186 = fragment_unnamed_177 + (-1.52587890625e-05f);
				precise float fragment_unnamed_189 = fragment_unnamed_183 + fragment_unnamed_183;
				precise float fragment_unnamed_190 = fragment_unnamed_185 + fragment_unnamed_185;
				precise float fragment_unnamed_191 = fragment_unnamed_186 + fragment_unnamed_186;
				float fragment_unnamed_195 = asfloat((fragment_unnamed_158 < (-0.3013698756694793701171875f)) ? asuint(fragment_unnamed_189) : ((fragment_unnamed_158 < 1.4679963588714599609375f) ? asuint(fragment_unnamed_175) : 1199562752u));
				float fragment_unnamed_197 = asfloat((fragment_unnamed_160 < (-0.3013698756694793701171875f)) ? asuint(fragment_unnamed_190) : ((fragment_unnamed_160 < 1.4679963588714599609375f) ? asuint(fragment_unnamed_176) : 1199562752u));
				float fragment_unnamed_200 = asfloat((fragment_unnamed_161 < (-0.3013698756694793701171875f)) ? asuint(fragment_unnamed_191) : ((fragment_unnamed_161 < 1.4679963588714599609375f) ? asuint(fragment_unnamed_177) : 1199562752u));
				float fragment_unnamed_201 = dot(float3(1.45143926143646240234375f, -0.236510753631591796875f, -0.214928567409515380859375f), float3(fragment_unnamed_195, fragment_unnamed_197, fragment_unnamed_200));
				float fragment_unnamed_207 = dot(float3(-0.07655377686023712158203125f, 1.1762297153472900390625f, -0.0996759235858917236328125f), float3(fragment_unnamed_195, fragment_unnamed_197, fragment_unnamed_200));
				float fragment_unnamed_213 = dot(float3(0.0083161480724811553955078125f, -0.0060324496589601039886474609375f, 0.99771630764007568359375f), float3(fragment_unnamed_195, fragment_unnamed_197, fragment_unnamed_200));
				precise float fragment_unnamed_243 = dot(float3(0.390404999256134033203125f, 0.549941003322601318359375f, 0.008926319889724254608154296875f), float3(fragment_unnamed_201, fragment_unnamed_207, fragment_unnamed_213)) * fragment_uniform_buffer_0[30u].x;
				precise float fragment_unnamed_244 = dot(float3(0.070841602981090545654296875f, 0.963172018527984619140625f, 0.001357750035822391510009765625f), float3(fragment_unnamed_201, fragment_unnamed_207, fragment_unnamed_213)) * fragment_uniform_buffer_0[30u].y;
				precise float fragment_unnamed_245 = dot(float3(0.02310819923877716064453125f, 0.1280210018157958984375f, 0.936245024204254150390625f), float3(fragment_unnamed_201, fragment_unnamed_207, fragment_unnamed_213)) * fragment_uniform_buffer_0[30u].z;
				precise float fragment_unnamed_270 = dot(float3(2.85846996307373046875f, -1.62879002094268798828125f, -0.0248910002410411834716796875f), float3(fragment_unnamed_243, fragment_unnamed_244, fragment_unnamed_245)) * fragment_uniform_buffer_0[31u].x;
				precise float fragment_unnamed_271 = dot(float3(-0.21018199622631072998046875f, 1.1582000255584716796875f, 0.0003242809907533228397369384765625f), float3(fragment_unnamed_243, fragment_unnamed_244, fragment_unnamed_245)) * fragment_uniform_buffer_0[31u].y;
				precise float fragment_unnamed_272 = dot(float3(-0.0418119989335536956787109375f, -0.118169002234935760498046875f, 1.0686700344085693359375f), float3(fragment_unnamed_243, fragment_unnamed_244, fragment_unnamed_245)) * fragment_uniform_buffer_0[31u].z;
				float fragment_unnamed_312 = mad(dot(float3(fragment_unnamed_270, fragment_unnamed_271, fragment_unnamed_272), float3(fragment_uniform_buffer_0[33u].xyz)), fragment_uniform_buffer_0[38u].x, fragment_uniform_buffer_0[36u].x);
				float fragment_unnamed_313 = mad(dot(float3(fragment_unnamed_270, fragment_unnamed_271, fragment_unnamed_272), float3(fragment_uniform_buffer_0[34u].xyz)), fragment_uniform_buffer_0[38u].y, fragment_uniform_buffer_0[36u].y);
				float fragment_unnamed_314 = mad(dot(float3(fragment_unnamed_270, fragment_unnamed_271, fragment_unnamed_272), float3(fragment_uniform_buffer_0[35u].xyz)), fragment_uniform_buffer_0[38u].z, fragment_uniform_buffer_0[36u].z);
				precise float fragment_unnamed_340 = log2(abs(fragment_unnamed_312)) * fragment_uniform_buffer_0[37u].x;
				precise float fragment_unnamed_341 = log2(abs(fragment_unnamed_313)) * fragment_uniform_buffer_0[37u].y;
				precise float fragment_unnamed_342 = log2(abs(fragment_unnamed_314)) * fragment_uniform_buffer_0[37u].z;
				precise float fragment_unnamed_346 = mad(clamp(mad(fragment_unnamed_312, 3.4028234663852885981170418348452e+38f, 0.5f), 0.0f, 1.0f), 2.0f, -1.0f) * exp2(fragment_unnamed_340);
				precise float fragment_unnamed_347 = mad(clamp(mad(fragment_unnamed_313, 3.4028234663852885981170418348452e+38f, 0.5f), 0.0f, 1.0f), 2.0f, -1.0f) * exp2(fragment_unnamed_341);
				precise float fragment_unnamed_348 = mad(clamp(mad(fragment_unnamed_314, 3.4028234663852885981170418348452e+38f, 0.5f), 0.0f, 1.0f), 2.0f, -1.0f) * exp2(fragment_unnamed_342);
				float fragment_unnamed_349 = max(fragment_unnamed_346, 0.0f);
				float fragment_unnamed_350 = max(fragment_unnamed_347, 0.0f);
				float fragment_unnamed_351 = max(fragment_unnamed_348, 0.0f);
				float fragment_unnamed_357 = asfloat(((fragment_unnamed_350 >= fragment_unnamed_351) ? 4294967295u : 0u) & 1065353216u);
				precise float fragment_unnamed_358 = (-0.0f) - fragment_unnamed_351;
				precise float fragment_unnamed_359 = (-0.0f) - fragment_unnamed_350;
				precise float fragment_unnamed_360 = fragment_unnamed_350 + fragment_unnamed_358;
				precise float fragment_unnamed_361 = fragment_unnamed_351 + fragment_unnamed_359;
				float fragment_unnamed_368 = mad(fragment_unnamed_357, fragment_unnamed_360, fragment_unnamed_351);
				float fragment_unnamed_369 = mad(fragment_unnamed_357, fragment_unnamed_361, fragment_unnamed_350);
				float fragment_unnamed_370 = mad(fragment_unnamed_357, asfloat(3212836864u), asfloat(1059760811u));
				float fragment_unnamed_375 = asfloat(((fragment_unnamed_349 >= fragment_unnamed_368) ? 4294967295u : 0u) & 1065353216u);
				precise float fragment_unnamed_382 = (-0.0f) - fragment_unnamed_368;
				precise float fragment_unnamed_383 = (-0.0f) - fragment_unnamed_369;
				precise float fragment_unnamed_384 = (-0.0f) - fragment_unnamed_370;
				precise float fragment_unnamed_385 = (-0.0f) - fragment_unnamed_349;
				precise float fragment_unnamed_386 = fragment_unnamed_382 + fragment_unnamed_349;
				precise float fragment_unnamed_387 = fragment_unnamed_383 + fragment_unnamed_369;
				precise float fragment_unnamed_388 = fragment_unnamed_384 + mad(fragment_unnamed_357, asfloat(1065353216u), asfloat(3212836864u));
				precise float fragment_unnamed_389 = fragment_unnamed_385 + fragment_unnamed_368;
				float fragment_unnamed_390 = mad(fragment_unnamed_375, fragment_unnamed_386, fragment_unnamed_368);
				float fragment_unnamed_391 = mad(fragment_unnamed_375, fragment_unnamed_387, fragment_unnamed_369);
				float fragment_unnamed_393 = mad(fragment_unnamed_375, fragment_unnamed_389, fragment_unnamed_349);
				precise float fragment_unnamed_395 = (-0.0f) - min(fragment_unnamed_391, fragment_unnamed_393);
				precise float fragment_unnamed_396 = fragment_unnamed_390 + fragment_unnamed_395;
				precise float fragment_unnamed_400 = (-0.0f) - fragment_unnamed_391;
				precise float fragment_unnamed_401 = fragment_unnamed_400 + fragment_unnamed_393;
				precise float fragment_unnamed_402 = fragment_unnamed_401 / mad(fragment_unnamed_396, 6.0f, 9.9999997473787516355514526367188e-05f);
				precise float fragment_unnamed_403 = fragment_unnamed_402 + mad(fragment_unnamed_375, fragment_unnamed_388, fragment_unnamed_370);
				float fragment_unnamed_404 = abs(fragment_unnamed_403);
				precise float fragment_unnamed_408 = fragment_unnamed_404 + fragment_uniform_buffer_0[32u].x;
				precise float fragment_unnamed_422 = clamp(_Curves.SampleLevel(sampler_Curves, float2(fragment_unnamed_408, asfloat(1048576000u)), 0.0f).x, 0.0f, 1.0f) + (-0.5f);
				precise float fragment_unnamed_424 = fragment_unnamed_422 + fragment_unnamed_408;
				precise float fragment_unnamed_426 = fragment_unnamed_424 + 1.0f;
				precise float fragment_unnamed_427 = fragment_unnamed_424 + (-1.0f);
				float fragment_unnamed_434 = asfloat((fragment_unnamed_424 < 0.0f) ? asuint(fragment_unnamed_426) : ((1.0f < fragment_unnamed_424) ? asuint(fragment_unnamed_427) : asuint(fragment_unnamed_424)));
				precise float fragment_unnamed_435 = fragment_unnamed_434 + 1.0f;
				precise float fragment_unnamed_436 = fragment_unnamed_434 + 0.666666686534881591796875f;
				precise float fragment_unnamed_438 = fragment_unnamed_434 + 0.3333333432674407958984375f;
				precise float fragment_unnamed_450 = abs(mad(frac(fragment_unnamed_435), 6.0f, -3.0f)) + (-1.0f);
				precise float fragment_unnamed_451 = abs(mad(frac(fragment_unnamed_436), 6.0f, -3.0f)) + (-1.0f);
				precise float fragment_unnamed_452 = abs(mad(frac(fragment_unnamed_438), 6.0f, -3.0f)) + (-1.0f);
				precise float fragment_unnamed_456 = clamp(fragment_unnamed_450, 0.0f, 1.0f) + (-1.0f);
				precise float fragment_unnamed_457 = clamp(fragment_unnamed_451, 0.0f, 1.0f) + (-1.0f);
				precise float fragment_unnamed_458 = clamp(fragment_unnamed_452, 0.0f, 1.0f) + (-1.0f);
				precise float fragment_unnamed_459 = fragment_unnamed_390 + 9.9999997473787516355514526367188e-05f;
				precise float fragment_unnamed_460 = fragment_unnamed_396 / fragment_unnamed_459;
				float fragment_unnamed_461 = mad(fragment_unnamed_460, fragment_unnamed_456, 1.0f);
				float fragment_unnamed_462 = mad(fragment_unnamed_460, fragment_unnamed_457, 1.0f);
				float fragment_unnamed_463 = mad(fragment_unnamed_460, fragment_unnamed_458, 1.0f);
				precise float fragment_unnamed_464 = fragment_unnamed_461 * fragment_unnamed_390;
				precise float fragment_unnamed_465 = fragment_unnamed_462 * fragment_unnamed_390;
				precise float fragment_unnamed_466 = fragment_unnamed_463 * fragment_unnamed_390;
				float fragment_unnamed_467 = dot(float3(fragment_unnamed_464, fragment_unnamed_465, fragment_unnamed_466), float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f));
				precise float fragment_unnamed_470 = (-0.0f) - fragment_unnamed_467;
				float fragment_unnamed_483 = clamp(_Curves.SampleLevel(sampler_Curves, float2(fragment_unnamed_404, asfloat(1048576000u)), 0.0f).y, 0.0f, 1.0f);
				precise float fragment_unnamed_484 = fragment_unnamed_483 + fragment_unnamed_483;
				precise float fragment_unnamed_488 = dot(clamp(_Curves.SampleLevel(sampler_Curves, float2(fragment_unnamed_460, asfloat(1048576000u)), 0.0f).z, 0.0f, 1.0f).xx, fragment_unnamed_484.xx) * clamp(_Curves.SampleLevel(sampler_Curves, float2(dot(float3(fragment_unnamed_349, fragment_unnamed_350, fragment_unnamed_351), float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)), asfloat(1048576000u)), 0.0f).w, 0.0f, 1.0f);
				float fragment_unnamed_492 = dot(fragment_uniform_buffer_0[32u].y.xx, fragment_unnamed_488.xx);
				float fragment_unnamed_495 = mad(fragment_unnamed_492, mad(fragment_unnamed_390, fragment_unnamed_461, fragment_unnamed_470), fragment_unnamed_467);
				float fragment_unnamed_496 = mad(fragment_unnamed_492, mad(fragment_unnamed_390, fragment_unnamed_462, fragment_unnamed_470), fragment_unnamed_467);
				float fragment_unnamed_497 = mad(fragment_unnamed_492, mad(fragment_unnamed_390, fragment_unnamed_463, fragment_unnamed_470), fragment_unnamed_467);
				float fragment_unnamed_498 = dot(float3(0.695452213287353515625f, 0.140678703784942626953125f, 0.16386906802654266357421875f), float3(fragment_unnamed_495, fragment_unnamed_496, fragment_unnamed_497));
				float fragment_unnamed_504 = dot(float3(0.0447945632040500640869140625f, 0.859671115875244140625f, 0.095534317195415496826171875f), float3(fragment_unnamed_495, fragment_unnamed_496, fragment_unnamed_497));
				float fragment_unnamed_510 = dot(float3(-0.0055258828215301036834716796875f, 0.0040252101607620716094970703125f, 1.00150072574615478515625f), float3(fragment_unnamed_495, fragment_unnamed_496, fragment_unnamed_497));
				precise float fragment_unnamed_516 = (-0.0f) - fragment_unnamed_504;
				precise float fragment_unnamed_517 = (-0.0f) - fragment_unnamed_498;
				precise float fragment_unnamed_518 = (-0.0f) - fragment_unnamed_510;
				precise float fragment_unnamed_519 = fragment_unnamed_516 + fragment_unnamed_510;
				precise float fragment_unnamed_520 = fragment_unnamed_517 + fragment_unnamed_504;
				precise float fragment_unnamed_521 = fragment_unnamed_518 + fragment_unnamed_498;
				precise float fragment_unnamed_522 = fragment_unnamed_519 * fragment_unnamed_510;
				precise float fragment_unnamed_523 = fragment_unnamed_520 * fragment_unnamed_504;
				precise float fragment_unnamed_524 = fragment_unnamed_523 + fragment_unnamed_522;
				precise float fragment_unnamed_527 = fragment_unnamed_504 + fragment_unnamed_510;
				precise float fragment_unnamed_528 = fragment_unnamed_498 + fragment_unnamed_527;
				float fragment_unnamed_529 = mad(sqrt(mad(fragment_unnamed_498, fragment_unnamed_521, fragment_unnamed_524)), 1.75f, fragment_unnamed_528);
				precise float fragment_unnamed_531 = fragment_unnamed_529 * 0.3333333432674407958984375f;
				precise float fragment_unnamed_532 = 0.07999999821186065673828125f / fragment_unnamed_531;
				float fragment_unnamed_538 = max(fragment_unnamed_510, max(fragment_unnamed_504, fragment_unnamed_498));
				precise float fragment_unnamed_542 = (-0.0f) - max(min(fragment_unnamed_510, min(fragment_unnamed_504, fragment_unnamed_498)), 9.9999997473787516355514526367188e-05f);
				precise float fragment_unnamed_543 = fragment_unnamed_542 + max(fragment_unnamed_538, 9.9999997473787516355514526367188e-05f);
				precise float fragment_unnamed_544 = fragment_unnamed_543 / max(fragment_unnamed_538, 0.00999999977648258209228515625f);
				precise float fragment_unnamed_545 = fragment_unnamed_532 + (-0.5f);
				precise float fragment_unnamed_546 = fragment_unnamed_544 + (-0.4000000059604644775390625f);
				precise float fragment_unnamed_548 = fragment_unnamed_546 * 2.5f;
				precise float fragment_unnamed_555 = (-0.0f) - abs(fragment_unnamed_548);
				precise float fragment_unnamed_556 = fragment_unnamed_555 + 1.0f;
				float fragment_unnamed_557 = max(fragment_unnamed_556, 0.0f);
				precise float fragment_unnamed_558 = (-0.0f) - fragment_unnamed_557;
				precise float fragment_unnamed_561 = mad(mad(clamp(mad(fragment_unnamed_546, asfloat(0x7f800000u /* inf */), 0.5f), 0.0f, 1.0f), 2.0f, -1.0f), mad(fragment_unnamed_558, fragment_unnamed_557, 1.0f), 1.0f) * 0.02500000037252902984619140625f;
				precise float fragment_unnamed_563 = fragment_unnamed_545 * fragment_unnamed_561;
				precise float fragment_unnamed_573 = asfloat((0.1599999964237213134765625f >= fragment_unnamed_529) ? asuint(fragment_unnamed_561) : ((fragment_unnamed_529 >= 0.4799999892711639404296875f) ? 0u : asuint(fragment_unnamed_563))) + 1.0f;
				precise float fragment_unnamed_574 = fragment_unnamed_573 * fragment_unnamed_498;
				precise float fragment_unnamed_575 = fragment_unnamed_573 * fragment_unnamed_504;
				precise float fragment_unnamed_576 = fragment_unnamed_573 * fragment_unnamed_510;
				precise float fragment_unnamed_577 = (-0.0f) - fragment_unnamed_498;
				precise float fragment_unnamed_580 = (-0.0f) - fragment_unnamed_576;
				precise float fragment_unnamed_582 = mad(fragment_unnamed_504, fragment_unnamed_573, fragment_unnamed_580) * 1.73205077648162841796875f;
				precise float fragment_unnamed_584 = (-0.0f) - fragment_unnamed_575;
				precise float fragment_unnamed_586 = (-0.0f) - fragment_unnamed_510;
				float fragment_unnamed_587 = mad(fragment_unnamed_586, fragment_unnamed_573, mad(fragment_unnamed_574, 2.0f, fragment_unnamed_584));
				precise float fragment_unnamed_591 = 1.0f / max(abs(fragment_unnamed_587), abs(fragment_unnamed_582));
				precise float fragment_unnamed_595 = fragment_unnamed_591 * min(abs(fragment_unnamed_587), abs(fragment_unnamed_582));
				precise float fragment_unnamed_596 = fragment_unnamed_595 * fragment_unnamed_595;
				float fragment_unnamed_604 = mad(fragment_unnamed_596, mad(fragment_unnamed_596, mad(fragment_unnamed_596, mad(fragment_unnamed_596, 0.02083509974181652069091796875f, -0.08513300120830535888671875f), 0.1801410019397735595703125f), -0.33029949665069580078125f), 0.999866008758544921875f);
				precise float fragment_unnamed_606 = fragment_unnamed_604 * fragment_unnamed_595;
				precise float fragment_unnamed_618 = (-0.0f) - fragment_unnamed_587;
				precise float fragment_unnamed_624 = asfloat(((fragment_unnamed_587 < fragment_unnamed_618) ? 4294967295u : 0u) & 3226013659u) + mad(fragment_unnamed_595, fragment_unnamed_604, asfloat(((abs(fragment_unnamed_587) < abs(fragment_unnamed_582)) ? 4294967295u : 0u) & asuint(mad(fragment_unnamed_606, -2.0f, 1.57079637050628662109375f))));
				float fragment_unnamed_625 = min(fragment_unnamed_587, fragment_unnamed_582);
				float fragment_unnamed_626 = max(fragment_unnamed_587, fragment_unnamed_582);
				precise float fragment_unnamed_627 = (-0.0f) - fragment_unnamed_626;
				precise float fragment_unnamed_630 = (-0.0f) - fragment_unnamed_625;
				precise float fragment_unnamed_635 = (-0.0f) - fragment_unnamed_624;
				precise float fragment_unnamed_637 = (((((fragment_unnamed_626 >= fragment_unnamed_627) ? 4294967295u : 0u) & ((fragment_unnamed_625 < fragment_unnamed_630) ? 4294967295u : 0u)) != 0u) ? fragment_unnamed_635 : fragment_unnamed_624) * 57.295780181884765625f;
				uint fragment_unnamed_646 = ((((fragment_unnamed_576 == fragment_unnamed_575) ? 4294967295u : 0u) & ((fragment_unnamed_575 == fragment_unnamed_574) ? 4294967295u : 0u)) != 0u) ? 0u : asuint(fragment_unnamed_637);
				float fragment_unnamed_647 = asfloat(fragment_unnamed_646);
				precise float fragment_unnamed_649 = fragment_unnamed_647 + 360.0f;
				uint fragment_unnamed_652 = (fragment_unnamed_647 < 0.0f) ? asuint(fragment_unnamed_649) : fragment_unnamed_646;
				float fragment_unnamed_653 = asfloat(fragment_unnamed_652);
				precise float fragment_unnamed_656 = fragment_unnamed_653 + 360.0f;
				precise float fragment_unnamed_657 = fragment_unnamed_653 + (-360.0f);
				precise float fragment_unnamed_666 = asfloat((fragment_unnamed_653 < (-180.0f)) ? asuint(fragment_unnamed_656) : ((180.0f < fragment_unnamed_653) ? asuint(fragment_unnamed_657) : fragment_unnamed_652)) * 0.01481481455266475677490234375f;
				precise float fragment_unnamed_669 = (-0.0f) - abs(fragment_unnamed_666);
				precise float fragment_unnamed_670 = fragment_unnamed_669 + 1.0f;
				float fragment_unnamed_671 = max(fragment_unnamed_670, 0.0f);
				precise float fragment_unnamed_674 = fragment_unnamed_671 * fragment_unnamed_671;
				precise float fragment_unnamed_675 = fragment_unnamed_674 * mad(fragment_unnamed_671, -2.0f, 3.0f);
				precise float fragment_unnamed_676 = fragment_unnamed_675 * fragment_unnamed_675;
				precise float fragment_unnamed_677 = fragment_unnamed_544 * fragment_unnamed_676;
				precise float fragment_unnamed_678 = mad(fragment_unnamed_577, fragment_unnamed_573, 0.02999999932944774627685546875f) * fragment_unnamed_677;
				float fragment_unnamed_679 = mad(fragment_unnamed_678, 0.180000007152557373046875f, fragment_unnamed_574);
				float fragment_unnamed_690 = max(dot(float3(1.45143926143646240234375f, -0.236510753631591796875f, -0.214928567409515380859375f), float3(fragment_unnamed_679, fragment_unnamed_575, fragment_unnamed_576)), 0.0f);
				float fragment_unnamed_691 = max(dot(float3(-0.07655377686023712158203125f, 1.1762297153472900390625f, -0.0996759235858917236328125f), float3(fragment_unnamed_679, fragment_unnamed_575, fragment_unnamed_576)), 0.0f);
				float fragment_unnamed_692 = max(dot(float3(0.0083161480724811553955078125f, -0.0060324496589601039886474609375f, 0.99771630764007568359375f), float3(fragment_unnamed_679, fragment_unnamed_575, fragment_unnamed_576)), 0.0f);
				float fragment_unnamed_693 = dot(float3(fragment_unnamed_690, fragment_unnamed_691, fragment_unnamed_692), float3(0.2722289860248565673828125f, 0.674081981182098388671875f, 0.0536894984543323516845703125f));
				precise float fragment_unnamed_699 = (-0.0f) - fragment_unnamed_693;
				precise float fragment_unnamed_700 = fragment_unnamed_699 + fragment_unnamed_690;
				precise float fragment_unnamed_701 = fragment_unnamed_699 + fragment_unnamed_691;
				precise float fragment_unnamed_702 = fragment_unnamed_699 + fragment_unnamed_692;
				float fragment_unnamed_703 = mad(fragment_unnamed_700, 0.959999978542327880859375f, fragment_unnamed_693);
				float fragment_unnamed_705 = mad(fragment_unnamed_701, 0.959999978542327880859375f, fragment_unnamed_693);
				float fragment_unnamed_706 = mad(fragment_unnamed_702, 0.959999978542327880859375f, fragment_unnamed_693);
				precise float fragment_unnamed_712 = fragment_unnamed_703 * mad(fragment_unnamed_703, 278.508514404296875f, 10.77719974517822265625f);
				precise float fragment_unnamed_713 = fragment_unnamed_705 * mad(fragment_unnamed_705, 278.508514404296875f, 10.77719974517822265625f);
				precise float fragment_unnamed_714 = fragment_unnamed_706 * mad(fragment_unnamed_706, 278.508514404296875f, 10.77719974517822265625f);
				precise float fragment_unnamed_724 = fragment_unnamed_712 / mad(fragment_unnamed_703, mad(fragment_unnamed_703, 293.6044921875f, 88.71219635009765625f), 80.68890380859375f);
				precise float fragment_unnamed_725 = fragment_unnamed_713 / mad(fragment_unnamed_705, mad(fragment_unnamed_705, 293.6044921875f, 88.71219635009765625f), 80.68890380859375f);
				precise float fragment_unnamed_726 = fragment_unnamed_714 / mad(fragment_unnamed_706, mad(fragment_unnamed_706, 293.6044921875f, 88.71219635009765625f), 80.68890380859375f);
				float fragment_unnamed_733 = dot(float3(0.662454187870025634765625f, 0.1340042054653167724609375f, 0.1561876833438873291015625f), float3(fragment_unnamed_724, fragment_unnamed_725, fragment_unnamed_726));
				float fragment_unnamed_739 = dot(float3(0.272228717803955078125f, 0.674081742763519287109375f, 0.053689517080783843994140625f), float3(fragment_unnamed_724, fragment_unnamed_725, fragment_unnamed_726));
				float fragment_unnamed_748 = max(dot(float3(fragment_unnamed_733, fragment_unnamed_739, dot(float3(-0.0055746496655046939849853515625f, 0.0040607335977256298065185546875f, 1.01033914089202880859375f), float3(fragment_unnamed_724, fragment_unnamed_725, fragment_unnamed_726))), 1.0f.xxx), 9.9999997473787516355514526367188e-05f);
				precise float fragment_unnamed_749 = fragment_unnamed_733 / fragment_unnamed_748;
				precise float fragment_unnamed_750 = fragment_unnamed_739 / fragment_unnamed_748;
				precise float fragment_unnamed_754 = log2(min(max(fragment_unnamed_739, 0.0f), 65504.0f)) * 0.981100022792816162109375f;
				float fragment_unnamed_756 = exp2(fragment_unnamed_754);
				precise float fragment_unnamed_757 = (-0.0f) - fragment_unnamed_749;
				precise float fragment_unnamed_758 = fragment_unnamed_757 + 1.0f;
				precise float fragment_unnamed_759 = (-0.0f) - fragment_unnamed_750;
				precise float fragment_unnamed_760 = fragment_unnamed_759 + fragment_unnamed_758;
				precise float fragment_unnamed_762 = fragment_unnamed_756 / max(fragment_unnamed_750, 9.9999997473787516355514526367188e-05f);
				precise float fragment_unnamed_763 = fragment_unnamed_762 * fragment_unnamed_749;
				precise float fragment_unnamed_764 = fragment_unnamed_762 * fragment_unnamed_760;
				float fragment_unnamed_765 = dot(float3(1.6410233974456787109375f, -0.324803292751312255859375f, -0.23642469942569732666015625f), float3(fragment_unnamed_763, fragment_unnamed_756, fragment_unnamed_764));
				float fragment_unnamed_771 = dot(float3(-0.663662850856781005859375f, 1.6153316497802734375f, 0.016756348311901092529296875f), float3(fragment_unnamed_763, fragment_unnamed_756, fragment_unnamed_764));
				float fragment_unnamed_777 = dot(float3(0.01172189414501190185546875f, -0.008284442126750946044921875f, 0.98839485645294189453125f), float3(fragment_unnamed_763, fragment_unnamed_756, fragment_unnamed_764));
				float fragment_unnamed_783 = dot(float3(fragment_unnamed_765, fragment_unnamed_771, fragment_unnamed_777), float3(0.2722289860248565673828125f, 0.674081981182098388671875f, 0.0536894984543323516845703125f));
				precise float fragment_unnamed_786 = (-0.0f) - fragment_unnamed_783;
				precise float fragment_unnamed_787 = fragment_unnamed_786 + fragment_unnamed_765;
				precise float fragment_unnamed_788 = fragment_unnamed_786 + fragment_unnamed_771;
				precise float fragment_unnamed_789 = fragment_unnamed_786 + fragment_unnamed_777;
				float fragment_unnamed_790 = mad(fragment_unnamed_787, 0.930000007152557373046875f, fragment_unnamed_783);
				float fragment_unnamed_792 = mad(fragment_unnamed_788, 0.930000007152557373046875f, fragment_unnamed_783);
				float fragment_unnamed_793 = mad(fragment_unnamed_789, 0.930000007152557373046875f, fragment_unnamed_783);
				float fragment_unnamed_794 = dot(float3(0.662454187870025634765625f, 0.1340042054653167724609375f, 0.1561876833438873291015625f), float3(fragment_unnamed_790, fragment_unnamed_792, fragment_unnamed_793));
				float fragment_unnamed_797 = dot(float3(0.272228717803955078125f, 0.674081742763519287109375f, 0.053689517080783843994140625f), float3(fragment_unnamed_790, fragment_unnamed_792, fragment_unnamed_793));
				float fragment_unnamed_800 = dot(float3(-0.0055746496655046939849853515625f, 0.0040607335977256298065185546875f, 1.01033914089202880859375f), float3(fragment_unnamed_790, fragment_unnamed_792, fragment_unnamed_793));
				float fragment_unnamed_803 = dot(float3(0.98722398281097412109375f, -0.0061132698319852352142333984375f, 0.01595330052077770233154296875f), float3(fragment_unnamed_794, fragment_unnamed_797, fragment_unnamed_800));
				float fragment_unnamed_809 = dot(float3(-0.007598360069096088409423828125f, 1.00186002254486083984375f, 0.0053301998414099216461181640625f), float3(fragment_unnamed_794, fragment_unnamed_797, fragment_unnamed_800));
				float fragment_unnamed_815 = dot(float3(0.003072570078074932098388671875f, -0.0050959498621523380279541015625f, 1.0816800594329833984375f), float3(fragment_unnamed_794, fragment_unnamed_797, fragment_unnamed_800));
				fragment_output_0.x = max(dot(float3(3.2409698963165283203125f, -1.53738319873809814453125f, -0.4986107647418975830078125f), float3(fragment_unnamed_803, fragment_unnamed_809, fragment_unnamed_815)), 0.0f);
				fragment_output_0.y = max(dot(float3(-0.96924364566802978515625f, 1.875967502593994140625f, 0.0415550582110881805419921875f), float3(fragment_unnamed_803, fragment_unnamed_809, fragment_unnamed_815)), 0.0f);
				fragment_output_0.z = max(dot(float3(0.055630080401897430419921875f, -0.2039769589900970458984375f, 1.05697154998779296875f), float3(fragment_unnamed_803, fragment_unnamed_809, fragment_unnamed_815)), 0.0f);
				fragment_output_0.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[28] = float4(_Lut2D_Params[0], _Lut2D_Params[1], _Lut2D_Params[2], _Lut2D_Params[3]);

				fragment_uniform_buffer_0[30] = float4(_ColorBalance[0], _ColorBalance[1], _ColorBalance[2], fragment_uniform_buffer_0[30][3]);

				fragment_uniform_buffer_0[31] = float4(_ColorFilter[0], _ColorFilter[1], _ColorFilter[2], fragment_uniform_buffer_0[31][3]);

				fragment_uniform_buffer_0[32] = float4(_HueSatCon[0], _HueSatCon[1], _HueSatCon[2], fragment_uniform_buffer_0[32][3]);

				fragment_uniform_buffer_0[33] = float4(_ChannelMixerRed[0], _ChannelMixerRed[1], _ChannelMixerRed[2], fragment_uniform_buffer_0[33][3]);

				fragment_uniform_buffer_0[34] = float4(_ChannelMixerGreen[0], _ChannelMixerGreen[1], _ChannelMixerGreen[2], fragment_uniform_buffer_0[34][3]);

				fragment_uniform_buffer_0[35] = float4(_ChannelMixerBlue[0], _ChannelMixerBlue[1], _ChannelMixerBlue[2], fragment_uniform_buffer_0[35][3]);

				fragment_uniform_buffer_0[36] = float4(_Lift[0], _Lift[1], _Lift[2], fragment_uniform_buffer_0[36][3]);

				fragment_uniform_buffer_0[37] = float4(_InvGamma[0], _InvGamma[1], _InvGamma[2], fragment_uniform_buffer_0[37][3]);

				fragment_uniform_buffer_0[38] = float4(_Gain[0], _Gain[1], _Gain[2], fragment_uniform_buffer_0[38][3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // TONEMAPPING_ACES
			#endif // !TONEMAPPING_CUSTOM
			#endif // !TONEMAPPING_NEUTRAL


			#ifdef TONEMAPPING_NEUTRAL
			#ifndef TONEMAPPING_ACES
			#ifndef TONEMAPPING_CUSTOM
			#define ANY_SHADER_VARIANT_ACTIVE

			float4 _Lut2D_Params;
			float3 _ColorBalance;
			float3 _ColorFilter;
			float3 _HueSatCon;
			float3 _ChannelMixerRed;
			float3 _ChannelMixerGreen;
			float3 _ChannelMixerBlue;
			float3 _Lift;
			float3 _InvGamma;
			float3 _Gain;

			static float4 fragment_uniform_buffer_0[39];
			Texture2D<float4> _Curves;
			SamplerState sampler_Curves;

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
				precise float fragment_unnamed_41 = (-0.0f) - fragment_uniform_buffer_0[28u].y;
				precise float fragment_unnamed_44 = (-0.0f) - fragment_uniform_buffer_0[28u].z;
				precise float fragment_unnamed_45 = fragment_input_1.x + fragment_unnamed_41;
				precise float fragment_unnamed_46 = fragment_input_1.y + fragment_unnamed_44;
				precise float fragment_unnamed_50 = fragment_unnamed_45 * fragment_uniform_buffer_0[28u].x;
				float fragment_unnamed_52 = frac(fragment_unnamed_50);
				precise float fragment_unnamed_56 = fragment_unnamed_52 / fragment_uniform_buffer_0[28u].x;
				precise float fragment_unnamed_57 = (-0.0f) - fragment_unnamed_56;
				precise float fragment_unnamed_58 = fragment_unnamed_45 + fragment_unnamed_57;
				precise float fragment_unnamed_74 = mad(mad(fragment_unnamed_52, fragment_uniform_buffer_0[28u].w, -0.41358840465545654296875f), fragment_uniform_buffer_0[32u].z, 0.0275523960590362548828125f) * 13.6054821014404296875f;
				precise float fragment_unnamed_76 = mad(mad(fragment_unnamed_46, fragment_uniform_buffer_0[28u].w, -0.41358840465545654296875f), fragment_uniform_buffer_0[32u].z, 0.0275523960590362548828125f) * 13.6054821014404296875f;
				precise float fragment_unnamed_77 = mad(mad(fragment_unnamed_58, fragment_uniform_buffer_0[28u].w, -0.41358840465545654296875f), fragment_uniform_buffer_0[32u].z, 0.0275523960590362548828125f) * 13.6054821014404296875f;
				precise float fragment_unnamed_81 = exp2(fragment_unnamed_74) + (-0.04799599945545196533203125f);
				precise float fragment_unnamed_83 = exp2(fragment_unnamed_76) + (-0.04799599945545196533203125f);
				precise float fragment_unnamed_84 = exp2(fragment_unnamed_77) + (-0.04799599945545196533203125f);
				precise float fragment_unnamed_85 = fragment_unnamed_81 * 0.17999999225139617919921875f;
				precise float fragment_unnamed_87 = fragment_unnamed_83 * 0.17999999225139617919921875f;
				precise float fragment_unnamed_88 = fragment_unnamed_84 * 0.17999999225139617919921875f;
				precise float fragment_unnamed_114 = dot(float3(0.390404999256134033203125f, 0.549941003322601318359375f, 0.008926319889724254608154296875f), float3(fragment_unnamed_85, fragment_unnamed_87, fragment_unnamed_88)) * fragment_uniform_buffer_0[30u].x;
				precise float fragment_unnamed_115 = dot(float3(0.070841602981090545654296875f, 0.963172018527984619140625f, 0.001357750035822391510009765625f), float3(fragment_unnamed_85, fragment_unnamed_87, fragment_unnamed_88)) * fragment_uniform_buffer_0[30u].y;
				precise float fragment_unnamed_116 = dot(float3(0.02310819923877716064453125f, 0.1280210018157958984375f, 0.936245024204254150390625f), float3(fragment_unnamed_85, fragment_unnamed_87, fragment_unnamed_88)) * fragment_uniform_buffer_0[30u].z;
				precise float fragment_unnamed_141 = dot(float3(2.85846996307373046875f, -1.62879002094268798828125f, -0.0248910002410411834716796875f), float3(fragment_unnamed_114, fragment_unnamed_115, fragment_unnamed_116)) * fragment_uniform_buffer_0[31u].x;
				precise float fragment_unnamed_142 = dot(float3(-0.21018199622631072998046875f, 1.1582000255584716796875f, 0.0003242809907533228397369384765625f), float3(fragment_unnamed_114, fragment_unnamed_115, fragment_unnamed_116)) * fragment_uniform_buffer_0[31u].y;
				precise float fragment_unnamed_143 = dot(float3(-0.0418119989335536956787109375f, -0.118169002234935760498046875f, 1.0686700344085693359375f), float3(fragment_unnamed_114, fragment_unnamed_115, fragment_unnamed_116)) * fragment_uniform_buffer_0[31u].z;
				float fragment_unnamed_183 = mad(dot(float3(fragment_unnamed_141, fragment_unnamed_142, fragment_unnamed_143), float3(fragment_uniform_buffer_0[33u].xyz)), fragment_uniform_buffer_0[38u].x, fragment_uniform_buffer_0[36u].x);
				float fragment_unnamed_184 = mad(dot(float3(fragment_unnamed_141, fragment_unnamed_142, fragment_unnamed_143), float3(fragment_uniform_buffer_0[34u].xyz)), fragment_uniform_buffer_0[38u].y, fragment_uniform_buffer_0[36u].y);
				float fragment_unnamed_185 = mad(dot(float3(fragment_unnamed_141, fragment_unnamed_142, fragment_unnamed_143), float3(fragment_uniform_buffer_0[35u].xyz)), fragment_uniform_buffer_0[38u].z, fragment_uniform_buffer_0[36u].z);
				precise float fragment_unnamed_213 = log2(abs(fragment_unnamed_183)) * fragment_uniform_buffer_0[37u].x;
				precise float fragment_unnamed_214 = log2(abs(fragment_unnamed_184)) * fragment_uniform_buffer_0[37u].y;
				precise float fragment_unnamed_215 = log2(abs(fragment_unnamed_185)) * fragment_uniform_buffer_0[37u].z;
				precise float fragment_unnamed_219 = mad(clamp(mad(fragment_unnamed_183, 3.4028234663852885981170418348452e+38f, 0.5f), 0.0f, 1.0f), 2.0f, -1.0f) * exp2(fragment_unnamed_213);
				precise float fragment_unnamed_220 = mad(clamp(mad(fragment_unnamed_184, 3.4028234663852885981170418348452e+38f, 0.5f), 0.0f, 1.0f), 2.0f, -1.0f) * exp2(fragment_unnamed_214);
				precise float fragment_unnamed_221 = mad(clamp(mad(fragment_unnamed_185, 3.4028234663852885981170418348452e+38f, 0.5f), 0.0f, 1.0f), 2.0f, -1.0f) * exp2(fragment_unnamed_215);
				float fragment_unnamed_222 = max(fragment_unnamed_219, 0.0f);
				float fragment_unnamed_223 = max(fragment_unnamed_220, 0.0f);
				float fragment_unnamed_224 = max(fragment_unnamed_221, 0.0f);
				float fragment_unnamed_231 = asfloat(((fragment_unnamed_223 >= fragment_unnamed_224) ? 4294967295u : 0u) & 1065353216u);
				precise float fragment_unnamed_232 = (-0.0f) - fragment_unnamed_224;
				precise float fragment_unnamed_233 = (-0.0f) - fragment_unnamed_223;
				precise float fragment_unnamed_234 = fragment_unnamed_223 + fragment_unnamed_232;
				precise float fragment_unnamed_235 = fragment_unnamed_224 + fragment_unnamed_233;
				float fragment_unnamed_242 = mad(fragment_unnamed_231, fragment_unnamed_234, fragment_unnamed_224);
				float fragment_unnamed_243 = mad(fragment_unnamed_231, fragment_unnamed_235, fragment_unnamed_223);
				float fragment_unnamed_244 = mad(fragment_unnamed_231, asfloat(3212836864u), asfloat(1059760811u));
				float fragment_unnamed_249 = asfloat(((fragment_unnamed_222 >= fragment_unnamed_242) ? 4294967295u : 0u) & 1065353216u);
				precise float fragment_unnamed_256 = (-0.0f) - fragment_unnamed_242;
				precise float fragment_unnamed_257 = (-0.0f) - fragment_unnamed_243;
				precise float fragment_unnamed_258 = (-0.0f) - fragment_unnamed_244;
				precise float fragment_unnamed_259 = (-0.0f) - fragment_unnamed_222;
				precise float fragment_unnamed_260 = fragment_unnamed_256 + fragment_unnamed_222;
				precise float fragment_unnamed_261 = fragment_unnamed_257 + fragment_unnamed_243;
				precise float fragment_unnamed_262 = fragment_unnamed_258 + mad(fragment_unnamed_231, asfloat(1065353216u), asfloat(3212836864u));
				precise float fragment_unnamed_263 = fragment_unnamed_259 + fragment_unnamed_242;
				float fragment_unnamed_264 = mad(fragment_unnamed_249, fragment_unnamed_260, fragment_unnamed_242);
				float fragment_unnamed_265 = mad(fragment_unnamed_249, fragment_unnamed_261, fragment_unnamed_243);
				float fragment_unnamed_267 = mad(fragment_unnamed_249, fragment_unnamed_263, fragment_unnamed_222);
				precise float fragment_unnamed_269 = (-0.0f) - min(fragment_unnamed_265, fragment_unnamed_267);
				precise float fragment_unnamed_270 = fragment_unnamed_264 + fragment_unnamed_269;
				precise float fragment_unnamed_274 = (-0.0f) - fragment_unnamed_265;
				precise float fragment_unnamed_275 = fragment_unnamed_274 + fragment_unnamed_267;
				precise float fragment_unnamed_276 = fragment_unnamed_275 / mad(fragment_unnamed_270, 6.0f, 9.9999997473787516355514526367188e-05f);
				precise float fragment_unnamed_277 = fragment_unnamed_276 + mad(fragment_unnamed_249, fragment_unnamed_262, fragment_unnamed_244);
				float fragment_unnamed_278 = abs(fragment_unnamed_277);
				precise float fragment_unnamed_282 = fragment_unnamed_278 + fragment_uniform_buffer_0[32u].x;
				precise float fragment_unnamed_296 = fragment_unnamed_282 + clamp(_Curves.SampleLevel(sampler_Curves, float2(fragment_unnamed_282, asfloat(1048576000u)), 0.0f).x, 0.0f, 1.0f);
				precise float fragment_unnamed_297 = fragment_unnamed_296 + (-0.5f);
				precise float fragment_unnamed_299 = fragment_unnamed_296 + 0.5f;
				precise float fragment_unnamed_300 = fragment_unnamed_296 + (-1.5f);
				float fragment_unnamed_309 = asfloat((fragment_unnamed_297 < 0.0f) ? asuint(fragment_unnamed_299) : ((1.0f < fragment_unnamed_297) ? asuint(fragment_unnamed_300) : asuint(fragment_unnamed_297)));
				precise float fragment_unnamed_310 = fragment_unnamed_309 + 1.0f;
				precise float fragment_unnamed_311 = fragment_unnamed_309 + 0.666666686534881591796875f;
				precise float fragment_unnamed_313 = fragment_unnamed_309 + 0.3333333432674407958984375f;
				precise float fragment_unnamed_325 = abs(mad(frac(fragment_unnamed_310), 6.0f, -3.0f)) + (-1.0f);
				precise float fragment_unnamed_326 = abs(mad(frac(fragment_unnamed_311), 6.0f, -3.0f)) + (-1.0f);
				precise float fragment_unnamed_327 = abs(mad(frac(fragment_unnamed_313), 6.0f, -3.0f)) + (-1.0f);
				precise float fragment_unnamed_331 = clamp(fragment_unnamed_325, 0.0f, 1.0f) + (-1.0f);
				precise float fragment_unnamed_332 = clamp(fragment_unnamed_326, 0.0f, 1.0f) + (-1.0f);
				precise float fragment_unnamed_333 = clamp(fragment_unnamed_327, 0.0f, 1.0f) + (-1.0f);
				precise float fragment_unnamed_334 = fragment_unnamed_264 + 9.9999997473787516355514526367188e-05f;
				precise float fragment_unnamed_335 = fragment_unnamed_270 / fragment_unnamed_334;
				float fragment_unnamed_336 = mad(fragment_unnamed_335, fragment_unnamed_331, 1.0f);
				float fragment_unnamed_337 = mad(fragment_unnamed_335, fragment_unnamed_332, 1.0f);
				float fragment_unnamed_338 = mad(fragment_unnamed_335, fragment_unnamed_333, 1.0f);
				precise float fragment_unnamed_339 = fragment_unnamed_336 * fragment_unnamed_264;
				precise float fragment_unnamed_340 = fragment_unnamed_337 * fragment_unnamed_264;
				precise float fragment_unnamed_341 = fragment_unnamed_338 * fragment_unnamed_264;
				float fragment_unnamed_342 = dot(float3(fragment_unnamed_339, fragment_unnamed_340, fragment_unnamed_341), float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f));
				precise float fragment_unnamed_345 = (-0.0f) - fragment_unnamed_342;
				float fragment_unnamed_358 = clamp(_Curves.SampleLevel(sampler_Curves, float2(fragment_unnamed_278, asfloat(1048576000u)), 0.0f).y, 0.0f, 1.0f);
				precise float fragment_unnamed_359 = fragment_unnamed_358 + fragment_unnamed_358;
				precise float fragment_unnamed_363 = dot(clamp(_Curves.SampleLevel(sampler_Curves, float2(fragment_unnamed_335, asfloat(1048576000u)), 0.0f).z, 0.0f, 1.0f).xx, fragment_unnamed_359.xx) * clamp(_Curves.SampleLevel(sampler_Curves, float2(dot(float3(fragment_unnamed_222, fragment_unnamed_223, fragment_unnamed_224), float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)), asfloat(1048576000u)), 0.0f).w, 0.0f, 1.0f);
				float fragment_unnamed_367 = dot(fragment_uniform_buffer_0[32u].y.xx, fragment_unnamed_363.xx);
				float fragment_unnamed_373 = max(mad(fragment_unnamed_367, mad(fragment_unnamed_264, fragment_unnamed_336, fragment_unnamed_345), fragment_unnamed_342), 0.0f);
				float fragment_unnamed_374 = max(mad(fragment_unnamed_367, mad(fragment_unnamed_264, fragment_unnamed_337, fragment_unnamed_345), fragment_unnamed_342), 0.0f);
				float fragment_unnamed_375 = max(mad(fragment_unnamed_367, mad(fragment_unnamed_264, fragment_unnamed_338, fragment_unnamed_345), fragment_unnamed_342), 0.0f);
				precise float fragment_unnamed_381 = fragment_unnamed_373 * 1.31338608264923095703125f;
				precise float fragment_unnamed_383 = fragment_unnamed_374 * 1.31338608264923095703125f;
				precise float fragment_unnamed_384 = fragment_unnamed_375 * 1.31338608264923095703125f;
				precise float fragment_unnamed_397 = mad(fragment_unnamed_381, mad(fragment_unnamed_373, 0.2626772224903106689453125f, 0.069599993526935577392578125f), 0.0054399999789893627166748046875f) / mad(fragment_unnamed_381, mad(fragment_unnamed_373, 0.2626772224903106689453125f, 0.2899999916553497314453125f), 0.081600010395050048828125f);
				precise float fragment_unnamed_398 = mad(fragment_unnamed_383, mad(fragment_unnamed_374, 0.2626772224903106689453125f, 0.069599993526935577392578125f), 0.0054399999789893627166748046875f) / mad(fragment_unnamed_383, mad(fragment_unnamed_374, 0.2626772224903106689453125f, 0.2899999916553497314453125f), 0.081600010395050048828125f);
				precise float fragment_unnamed_399 = mad(fragment_unnamed_384, mad(fragment_unnamed_375, 0.2626772224903106689453125f, 0.069599993526935577392578125f), 0.0054399999789893627166748046875f) / mad(fragment_unnamed_384, mad(fragment_unnamed_375, 0.2626772224903106689453125f, 0.2899999916553497314453125f), 0.081600010395050048828125f);
				precise float fragment_unnamed_400 = fragment_unnamed_397 + (-0.066666662693023681640625f);
				precise float fragment_unnamed_402 = fragment_unnamed_398 + (-0.066666662693023681640625f);
				precise float fragment_unnamed_403 = fragment_unnamed_399 + (-0.066666662693023681640625f);
				precise float fragment_unnamed_404 = fragment_unnamed_400 * 1.31338608264923095703125f;
				precise float fragment_unnamed_405 = fragment_unnamed_402 * 1.31338608264923095703125f;
				precise float fragment_unnamed_406 = fragment_unnamed_403 * 1.31338608264923095703125f;
				fragment_output_0.x = max(fragment_unnamed_404, 0.0f);
				fragment_output_0.y = max(fragment_unnamed_405, 0.0f);
				fragment_output_0.z = max(fragment_unnamed_406, 0.0f);
				fragment_output_0.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[28] = float4(_Lut2D_Params[0], _Lut2D_Params[1], _Lut2D_Params[2], _Lut2D_Params[3]);

				fragment_uniform_buffer_0[30] = float4(_ColorBalance[0], _ColorBalance[1], _ColorBalance[2], fragment_uniform_buffer_0[30][3]);

				fragment_uniform_buffer_0[31] = float4(_ColorFilter[0], _ColorFilter[1], _ColorFilter[2], fragment_uniform_buffer_0[31][3]);

				fragment_uniform_buffer_0[32] = float4(_HueSatCon[0], _HueSatCon[1], _HueSatCon[2], fragment_uniform_buffer_0[32][3]);

				fragment_uniform_buffer_0[33] = float4(_ChannelMixerRed[0], _ChannelMixerRed[1], _ChannelMixerRed[2], fragment_uniform_buffer_0[33][3]);

				fragment_uniform_buffer_0[34] = float4(_ChannelMixerGreen[0], _ChannelMixerGreen[1], _ChannelMixerGreen[2], fragment_uniform_buffer_0[34][3]);

				fragment_uniform_buffer_0[35] = float4(_ChannelMixerBlue[0], _ChannelMixerBlue[1], _ChannelMixerBlue[2], fragment_uniform_buffer_0[35][3]);

				fragment_uniform_buffer_0[36] = float4(_Lift[0], _Lift[1], _Lift[2], fragment_uniform_buffer_0[36][3]);

				fragment_uniform_buffer_0[37] = float4(_InvGamma[0], _InvGamma[1], _InvGamma[2], fragment_uniform_buffer_0[37][3]);

				fragment_uniform_buffer_0[38] = float4(_Gain[0], _Gain[1], _Gain[2], fragment_uniform_buffer_0[38][3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // TONEMAPPING_NEUTRAL
			#endif // !TONEMAPPING_ACES
			#endif // !TONEMAPPING_CUSTOM


			#ifdef TONEMAPPING_CUSTOM
			#ifndef TONEMAPPING_ACES
			#ifndef TONEMAPPING_NEUTRAL
			#define ANY_SHADER_VARIANT_ACTIVE

			float4 _Lut2D_Params;
			float3 _ColorBalance;
			float3 _ColorFilter;
			float3 _HueSatCon;
			float3 _ChannelMixerRed;
			float3 _ChannelMixerGreen;
			float3 _ChannelMixerBlue;
			float3 _Lift;
			float3 _InvGamma;
			float3 _Gain;
			float4 _CustomToneCurve;
			float4 _ToeSegmentA;
			float4 _ToeSegmentB;
			float4 _MidSegmentA;
			float4 _MidSegmentB;
			float4 _ShoSegmentA;
			float4 _ShoSegmentB;

			static float4 fragment_uniform_buffer_0[46];
			Texture2D<float4> _Curves;
			SamplerState sampler_Curves;

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
				precise float fragment_unnamed_41 = (-0.0f) - fragment_uniform_buffer_0[28u].y;
				precise float fragment_unnamed_44 = (-0.0f) - fragment_uniform_buffer_0[28u].z;
				precise float fragment_unnamed_45 = fragment_input_1.x + fragment_unnamed_41;
				precise float fragment_unnamed_46 = fragment_input_1.y + fragment_unnamed_44;
				precise float fragment_unnamed_50 = fragment_unnamed_45 * fragment_uniform_buffer_0[28u].x;
				float fragment_unnamed_52 = frac(fragment_unnamed_50);
				precise float fragment_unnamed_56 = fragment_unnamed_52 / fragment_uniform_buffer_0[28u].x;
				precise float fragment_unnamed_57 = (-0.0f) - fragment_unnamed_56;
				precise float fragment_unnamed_58 = fragment_unnamed_45 + fragment_unnamed_57;
				precise float fragment_unnamed_74 = mad(mad(fragment_unnamed_52, fragment_uniform_buffer_0[28u].w, -0.41358840465545654296875f), fragment_uniform_buffer_0[32u].z, 0.0275523960590362548828125f) * 13.6054821014404296875f;
				precise float fragment_unnamed_76 = mad(mad(fragment_unnamed_46, fragment_uniform_buffer_0[28u].w, -0.41358840465545654296875f), fragment_uniform_buffer_0[32u].z, 0.0275523960590362548828125f) * 13.6054821014404296875f;
				precise float fragment_unnamed_77 = mad(mad(fragment_unnamed_58, fragment_uniform_buffer_0[28u].w, -0.41358840465545654296875f), fragment_uniform_buffer_0[32u].z, 0.0275523960590362548828125f) * 13.6054821014404296875f;
				precise float fragment_unnamed_81 = exp2(fragment_unnamed_74) + (-0.04799599945545196533203125f);
				precise float fragment_unnamed_83 = exp2(fragment_unnamed_76) + (-0.04799599945545196533203125f);
				precise float fragment_unnamed_84 = exp2(fragment_unnamed_77) + (-0.04799599945545196533203125f);
				precise float fragment_unnamed_85 = fragment_unnamed_81 * 0.17999999225139617919921875f;
				precise float fragment_unnamed_87 = fragment_unnamed_83 * 0.17999999225139617919921875f;
				precise float fragment_unnamed_88 = fragment_unnamed_84 * 0.17999999225139617919921875f;
				precise float fragment_unnamed_114 = dot(float3(0.390404999256134033203125f, 0.549941003322601318359375f, 0.008926319889724254608154296875f), float3(fragment_unnamed_85, fragment_unnamed_87, fragment_unnamed_88)) * fragment_uniform_buffer_0[30u].x;
				precise float fragment_unnamed_115 = dot(float3(0.070841602981090545654296875f, 0.963172018527984619140625f, 0.001357750035822391510009765625f), float3(fragment_unnamed_85, fragment_unnamed_87, fragment_unnamed_88)) * fragment_uniform_buffer_0[30u].y;
				precise float fragment_unnamed_116 = dot(float3(0.02310819923877716064453125f, 0.1280210018157958984375f, 0.936245024204254150390625f), float3(fragment_unnamed_85, fragment_unnamed_87, fragment_unnamed_88)) * fragment_uniform_buffer_0[30u].z;
				precise float fragment_unnamed_141 = dot(float3(2.85846996307373046875f, -1.62879002094268798828125f, -0.0248910002410411834716796875f), float3(fragment_unnamed_114, fragment_unnamed_115, fragment_unnamed_116)) * fragment_uniform_buffer_0[31u].x;
				precise float fragment_unnamed_142 = dot(float3(-0.21018199622631072998046875f, 1.1582000255584716796875f, 0.0003242809907533228397369384765625f), float3(fragment_unnamed_114, fragment_unnamed_115, fragment_unnamed_116)) * fragment_uniform_buffer_0[31u].y;
				precise float fragment_unnamed_143 = dot(float3(-0.0418119989335536956787109375f, -0.118169002234935760498046875f, 1.0686700344085693359375f), float3(fragment_unnamed_114, fragment_unnamed_115, fragment_unnamed_116)) * fragment_uniform_buffer_0[31u].z;
				float fragment_unnamed_183 = mad(dot(float3(fragment_unnamed_141, fragment_unnamed_142, fragment_unnamed_143), float3(fragment_uniform_buffer_0[33u].xyz)), fragment_uniform_buffer_0[38u].x, fragment_uniform_buffer_0[36u].x);
				float fragment_unnamed_184 = mad(dot(float3(fragment_unnamed_141, fragment_unnamed_142, fragment_unnamed_143), float3(fragment_uniform_buffer_0[34u].xyz)), fragment_uniform_buffer_0[38u].y, fragment_uniform_buffer_0[36u].y);
				float fragment_unnamed_185 = mad(dot(float3(fragment_unnamed_141, fragment_unnamed_142, fragment_unnamed_143), float3(fragment_uniform_buffer_0[35u].xyz)), fragment_uniform_buffer_0[38u].z, fragment_uniform_buffer_0[36u].z);
				precise float fragment_unnamed_213 = log2(abs(fragment_unnamed_183)) * fragment_uniform_buffer_0[37u].x;
				precise float fragment_unnamed_214 = log2(abs(fragment_unnamed_184)) * fragment_uniform_buffer_0[37u].y;
				precise float fragment_unnamed_215 = log2(abs(fragment_unnamed_185)) * fragment_uniform_buffer_0[37u].z;
				precise float fragment_unnamed_219 = mad(clamp(mad(fragment_unnamed_183, 3.4028234663852885981170418348452e+38f, 0.5f), 0.0f, 1.0f), 2.0f, -1.0f) * exp2(fragment_unnamed_213);
				precise float fragment_unnamed_220 = mad(clamp(mad(fragment_unnamed_184, 3.4028234663852885981170418348452e+38f, 0.5f), 0.0f, 1.0f), 2.0f, -1.0f) * exp2(fragment_unnamed_214);
				precise float fragment_unnamed_221 = mad(clamp(mad(fragment_unnamed_185, 3.4028234663852885981170418348452e+38f, 0.5f), 0.0f, 1.0f), 2.0f, -1.0f) * exp2(fragment_unnamed_215);
				float fragment_unnamed_222 = max(fragment_unnamed_219, 0.0f);
				float fragment_unnamed_223 = max(fragment_unnamed_220, 0.0f);
				float fragment_unnamed_224 = max(fragment_unnamed_221, 0.0f);
				float fragment_unnamed_231 = asfloat(((fragment_unnamed_223 >= fragment_unnamed_224) ? 4294967295u : 0u) & 1065353216u);
				precise float fragment_unnamed_232 = (-0.0f) - fragment_unnamed_224;
				precise float fragment_unnamed_233 = (-0.0f) - fragment_unnamed_223;
				precise float fragment_unnamed_234 = fragment_unnamed_223 + fragment_unnamed_232;
				precise float fragment_unnamed_235 = fragment_unnamed_224 + fragment_unnamed_233;
				float fragment_unnamed_242 = mad(fragment_unnamed_231, fragment_unnamed_234, fragment_unnamed_224);
				float fragment_unnamed_243 = mad(fragment_unnamed_231, fragment_unnamed_235, fragment_unnamed_223);
				float fragment_unnamed_244 = mad(fragment_unnamed_231, asfloat(3212836864u), asfloat(1059760811u));
				float fragment_unnamed_249 = asfloat(((fragment_unnamed_222 >= fragment_unnamed_242) ? 4294967295u : 0u) & 1065353216u);
				precise float fragment_unnamed_256 = (-0.0f) - fragment_unnamed_242;
				precise float fragment_unnamed_257 = (-0.0f) - fragment_unnamed_243;
				precise float fragment_unnamed_258 = (-0.0f) - fragment_unnamed_244;
				precise float fragment_unnamed_259 = (-0.0f) - fragment_unnamed_222;
				precise float fragment_unnamed_260 = fragment_unnamed_256 + fragment_unnamed_222;
				precise float fragment_unnamed_261 = fragment_unnamed_257 + fragment_unnamed_243;
				precise float fragment_unnamed_262 = fragment_unnamed_258 + mad(fragment_unnamed_231, asfloat(1065353216u), asfloat(3212836864u));
				precise float fragment_unnamed_263 = fragment_unnamed_259 + fragment_unnamed_242;
				float fragment_unnamed_264 = mad(fragment_unnamed_249, fragment_unnamed_260, fragment_unnamed_242);
				float fragment_unnamed_265 = mad(fragment_unnamed_249, fragment_unnamed_261, fragment_unnamed_243);
				float fragment_unnamed_267 = mad(fragment_unnamed_249, fragment_unnamed_263, fragment_unnamed_222);
				precise float fragment_unnamed_269 = (-0.0f) - min(fragment_unnamed_265, fragment_unnamed_267);
				precise float fragment_unnamed_270 = fragment_unnamed_264 + fragment_unnamed_269;
				precise float fragment_unnamed_274 = (-0.0f) - fragment_unnamed_265;
				precise float fragment_unnamed_275 = fragment_unnamed_274 + fragment_unnamed_267;
				precise float fragment_unnamed_276 = fragment_unnamed_275 / mad(fragment_unnamed_270, 6.0f, 9.9999997473787516355514526367188e-05f);
				precise float fragment_unnamed_277 = fragment_unnamed_276 + mad(fragment_unnamed_249, fragment_unnamed_262, fragment_unnamed_244);
				float fragment_unnamed_278 = abs(fragment_unnamed_277);
				precise float fragment_unnamed_282 = fragment_unnamed_278 + fragment_uniform_buffer_0[32u].x;
				precise float fragment_unnamed_296 = fragment_unnamed_282 + clamp(_Curves.SampleLevel(sampler_Curves, float2(fragment_unnamed_282, asfloat(1048576000u)), 0.0f).x, 0.0f, 1.0f);
				precise float fragment_unnamed_297 = fragment_unnamed_296 + (-0.5f);
				precise float fragment_unnamed_299 = fragment_unnamed_296 + 0.5f;
				precise float fragment_unnamed_300 = fragment_unnamed_296 + (-1.5f);
				float fragment_unnamed_309 = asfloat((fragment_unnamed_297 < 0.0f) ? asuint(fragment_unnamed_299) : ((1.0f < fragment_unnamed_297) ? asuint(fragment_unnamed_300) : asuint(fragment_unnamed_297)));
				precise float fragment_unnamed_310 = fragment_unnamed_309 + 1.0f;
				precise float fragment_unnamed_311 = fragment_unnamed_309 + 0.666666686534881591796875f;
				precise float fragment_unnamed_313 = fragment_unnamed_309 + 0.3333333432674407958984375f;
				precise float fragment_unnamed_325 = abs(mad(frac(fragment_unnamed_310), 6.0f, -3.0f)) + (-1.0f);
				precise float fragment_unnamed_326 = abs(mad(frac(fragment_unnamed_311), 6.0f, -3.0f)) + (-1.0f);
				precise float fragment_unnamed_327 = abs(mad(frac(fragment_unnamed_313), 6.0f, -3.0f)) + (-1.0f);
				precise float fragment_unnamed_331 = clamp(fragment_unnamed_325, 0.0f, 1.0f) + (-1.0f);
				precise float fragment_unnamed_332 = clamp(fragment_unnamed_326, 0.0f, 1.0f) + (-1.0f);
				precise float fragment_unnamed_333 = clamp(fragment_unnamed_327, 0.0f, 1.0f) + (-1.0f);
				precise float fragment_unnamed_334 = fragment_unnamed_264 + 9.9999997473787516355514526367188e-05f;
				precise float fragment_unnamed_335 = fragment_unnamed_270 / fragment_unnamed_334;
				float fragment_unnamed_336 = mad(fragment_unnamed_335, fragment_unnamed_331, 1.0f);
				float fragment_unnamed_337 = mad(fragment_unnamed_335, fragment_unnamed_332, 1.0f);
				float fragment_unnamed_338 = mad(fragment_unnamed_335, fragment_unnamed_333, 1.0f);
				precise float fragment_unnamed_339 = fragment_unnamed_336 * fragment_unnamed_264;
				precise float fragment_unnamed_340 = fragment_unnamed_337 * fragment_unnamed_264;
				precise float fragment_unnamed_341 = fragment_unnamed_338 * fragment_unnamed_264;
				float fragment_unnamed_342 = dot(float3(fragment_unnamed_339, fragment_unnamed_340, fragment_unnamed_341), float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f));
				precise float fragment_unnamed_345 = (-0.0f) - fragment_unnamed_342;
				float fragment_unnamed_358 = clamp(_Curves.SampleLevel(sampler_Curves, float2(fragment_unnamed_278, asfloat(1048576000u)), 0.0f).y, 0.0f, 1.0f);
				precise float fragment_unnamed_359 = fragment_unnamed_358 + fragment_unnamed_358;
				precise float fragment_unnamed_363 = dot(clamp(_Curves.SampleLevel(sampler_Curves, float2(fragment_unnamed_335, asfloat(1048576000u)), 0.0f).z, 0.0f, 1.0f).xx, fragment_unnamed_359.xx) * clamp(_Curves.SampleLevel(sampler_Curves, float2(dot(float3(fragment_unnamed_222, fragment_unnamed_223, fragment_unnamed_224), float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)), asfloat(1048576000u)), 0.0f).w, 0.0f, 1.0f);
				float fragment_unnamed_367 = dot(fragment_uniform_buffer_0[32u].y.xx, fragment_unnamed_363.xx);
				float fragment_unnamed_373 = max(mad(fragment_unnamed_367, mad(fragment_unnamed_264, fragment_unnamed_336, fragment_unnamed_345), fragment_unnamed_342), 0.0f);
				float fragment_unnamed_374 = max(mad(fragment_unnamed_367, mad(fragment_unnamed_264, fragment_unnamed_337, fragment_unnamed_345), fragment_unnamed_342), 0.0f);
				float fragment_unnamed_375 = max(mad(fragment_unnamed_367, mad(fragment_unnamed_264, fragment_unnamed_338, fragment_unnamed_345), fragment_unnamed_342), 0.0f);
				precise float fragment_unnamed_380 = fragment_unnamed_373 * fragment_uniform_buffer_0[39u].x;
				precise float fragment_unnamed_381 = fragment_unnamed_374 * fragment_uniform_buffer_0[39u].x;
				precise float fragment_unnamed_382 = fragment_unnamed_375 * fragment_uniform_buffer_0[39u].x;
				bool fragment_unnamed_387 = fragment_unnamed_382 < fragment_uniform_buffer_0[39u].y;
				bool fragment_unnamed_388 = fragment_unnamed_382 < fragment_uniform_buffer_0[39u].z;
				bool fragment_unnamed_393 = fragment_unnamed_380 < fragment_uniform_buffer_0[39u].y;
				bool fragment_unnamed_394 = fragment_unnamed_380 < fragment_uniform_buffer_0[39u].z;
				bool fragment_unnamed_395 = fragment_unnamed_381 < fragment_uniform_buffer_0[39u].y;
				bool fragment_unnamed_396 = fragment_unnamed_381 < fragment_uniform_buffer_0[39u].z;
				uint4 fragment_unnamed_401 = asuint(fragment_uniform_buffer_0[42u]);
				uint4 fragment_unnamed_409 = asuint(fragment_uniform_buffer_0[44u]);
				uint4 fragment_unnamed_421 = asuint(fragment_uniform_buffer_0[40u]);
				precise float fragment_unnamed_434 = (-0.0f) - asfloat(fragment_unnamed_387 ? fragment_unnamed_421.x : (fragment_unnamed_388 ? fragment_unnamed_401.x : fragment_unnamed_409.x));
				precise float fragment_unnamed_437 = asfloat(fragment_unnamed_387 ? fragment_unnamed_421.z : (fragment_unnamed_388 ? fragment_unnamed_401.z : fragment_unnamed_409.z)) * mad(fragment_unnamed_375, fragment_uniform_buffer_0[39u].x, fragment_unnamed_434);
				uint4 fragment_unnamed_444 = asuint(fragment_uniform_buffer_0[43u]);
				uint4 fragment_unnamed_450 = asuint(fragment_uniform_buffer_0[45u]);
				uint4 fragment_unnamed_458 = asuint(fragment_uniform_buffer_0[41u]);
				precise float fragment_unnamed_465 = log2(fragment_unnamed_437) * asfloat(fragment_unnamed_387 ? fragment_unnamed_458.y : (fragment_unnamed_388 ? fragment_unnamed_444.y : fragment_unnamed_450.y));
				precise float fragment_unnamed_468 = mad(fragment_unnamed_465, 0.693147182464599609375f, asfloat(fragment_unnamed_387 ? fragment_unnamed_458.x : (fragment_unnamed_388 ? fragment_unnamed_444.x : fragment_unnamed_450.x))) * 1.44269502162933349609375f;
				uint4 fragment_unnamed_479 = asuint(fragment_uniform_buffer_0[42u]);
				uint4 fragment_unnamed_486 = asuint(fragment_uniform_buffer_0[44u]);
				uint4 fragment_unnamed_497 = asuint(fragment_uniform_buffer_0[40u]);
				precise float fragment_unnamed_510 = (-0.0f) - asfloat(fragment_unnamed_393 ? fragment_unnamed_497.x : (fragment_unnamed_394 ? fragment_unnamed_479.x : fragment_unnamed_486.x));
				precise float fragment_unnamed_513 = asfloat(fragment_unnamed_393 ? fragment_unnamed_497.z : (fragment_unnamed_394 ? fragment_unnamed_479.z : fragment_unnamed_486.z)) * mad(fragment_unnamed_373, fragment_uniform_buffer_0[39u].x, fragment_unnamed_510);
				uint4 fragment_unnamed_519 = asuint(fragment_uniform_buffer_0[43u]);
				uint fragment_unnamed_520 = fragment_unnamed_519.x;
				uint fragment_unnamed_521 = fragment_unnamed_519.y;
				uint4 fragment_unnamed_524 = asuint(fragment_uniform_buffer_0[45u]);
				uint fragment_unnamed_525 = fragment_unnamed_524.x;
				uint fragment_unnamed_526 = fragment_unnamed_524.y;
				uint4 fragment_unnamed_533 = asuint(fragment_uniform_buffer_0[41u]);
				uint fragment_unnamed_534 = fragment_unnamed_533.x;
				uint fragment_unnamed_535 = fragment_unnamed_533.y;
				precise float fragment_unnamed_542 = log2(fragment_unnamed_513) * asfloat(fragment_unnamed_393 ? fragment_unnamed_535 : (fragment_unnamed_394 ? fragment_unnamed_521 : fragment_unnamed_526));
				precise float fragment_unnamed_544 = mad(fragment_unnamed_542, 0.693147182464599609375f, asfloat(fragment_unnamed_393 ? fragment_unnamed_534 : (fragment_unnamed_394 ? fragment_unnamed_520 : fragment_unnamed_525))) * 1.44269502162933349609375f;
				uint4 fragment_unnamed_554 = asuint(fragment_uniform_buffer_0[42u]);
				uint4 fragment_unnamed_561 = asuint(fragment_uniform_buffer_0[44u]);
				uint4 fragment_unnamed_572 = asuint(fragment_uniform_buffer_0[40u]);
				precise float fragment_unnamed_588 = (-0.0f) - asfloat(fragment_unnamed_395 ? fragment_unnamed_572.x : (fragment_unnamed_396 ? fragment_unnamed_554.x : fragment_unnamed_561.x));
				precise float fragment_unnamed_590 = asfloat(fragment_unnamed_395 ? fragment_unnamed_572.z : (fragment_unnamed_396 ? fragment_unnamed_554.z : fragment_unnamed_561.z)) * mad(fragment_unnamed_374, fragment_uniform_buffer_0[39u].x, fragment_unnamed_588);
				precise float fragment_unnamed_595 = log2(fragment_unnamed_590) * asfloat(fragment_unnamed_395 ? fragment_unnamed_535 : (fragment_unnamed_396 ? fragment_unnamed_521 : fragment_unnamed_526));
				precise float fragment_unnamed_598 = mad(fragment_unnamed_595, 0.693147182464599609375f, asfloat(fragment_unnamed_395 ? fragment_unnamed_534 : (fragment_unnamed_396 ? fragment_unnamed_520 : fragment_unnamed_525))) * 1.44269502162933349609375f;
				fragment_output_0.x = max(mad(asfloat(asuint(exp2(fragment_unnamed_544)) & ((0.0f < fragment_unnamed_513) ? 4294967295u : 0u)), asfloat(fragment_unnamed_393 ? fragment_unnamed_497.w : (fragment_unnamed_394 ? fragment_unnamed_479.w : fragment_unnamed_486.w)), asfloat(fragment_unnamed_393 ? fragment_unnamed_497.y : (fragment_unnamed_394 ? fragment_unnamed_479.y : fragment_unnamed_486.y))), 0.0f);
				fragment_output_0.y = max(mad(asfloat(asuint(exp2(fragment_unnamed_598)) & ((0.0f < fragment_unnamed_590) ? 4294967295u : 0u)), asfloat(fragment_unnamed_395 ? fragment_unnamed_572.w : (fragment_unnamed_396 ? fragment_unnamed_554.w : fragment_unnamed_561.w)), asfloat(fragment_unnamed_395 ? fragment_unnamed_572.y : (fragment_unnamed_396 ? fragment_unnamed_554.y : fragment_unnamed_561.y))), 0.0f);
				fragment_output_0.z = max(mad(asfloat(asuint(exp2(fragment_unnamed_468)) & ((0.0f < fragment_unnamed_437) ? 4294967295u : 0u)), asfloat(fragment_unnamed_387 ? fragment_unnamed_421.w : (fragment_unnamed_388 ? fragment_unnamed_401.w : fragment_unnamed_409.w)), asfloat(fragment_unnamed_387 ? fragment_unnamed_421.y : (fragment_unnamed_388 ? fragment_unnamed_401.y : fragment_unnamed_409.y))), 0.0f);
				fragment_output_0.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[28] = float4(_Lut2D_Params[0], _Lut2D_Params[1], _Lut2D_Params[2], _Lut2D_Params[3]);

				fragment_uniform_buffer_0[30] = float4(_ColorBalance[0], _ColorBalance[1], _ColorBalance[2], fragment_uniform_buffer_0[30][3]);

				fragment_uniform_buffer_0[31] = float4(_ColorFilter[0], _ColorFilter[1], _ColorFilter[2], fragment_uniform_buffer_0[31][3]);

				fragment_uniform_buffer_0[32] = float4(_HueSatCon[0], _HueSatCon[1], _HueSatCon[2], fragment_uniform_buffer_0[32][3]);

				fragment_uniform_buffer_0[33] = float4(_ChannelMixerRed[0], _ChannelMixerRed[1], _ChannelMixerRed[2], fragment_uniform_buffer_0[33][3]);

				fragment_uniform_buffer_0[34] = float4(_ChannelMixerGreen[0], _ChannelMixerGreen[1], _ChannelMixerGreen[2], fragment_uniform_buffer_0[34][3]);

				fragment_uniform_buffer_0[35] = float4(_ChannelMixerBlue[0], _ChannelMixerBlue[1], _ChannelMixerBlue[2], fragment_uniform_buffer_0[35][3]);

				fragment_uniform_buffer_0[36] = float4(_Lift[0], _Lift[1], _Lift[2], fragment_uniform_buffer_0[36][3]);

				fragment_uniform_buffer_0[37] = float4(_InvGamma[0], _InvGamma[1], _InvGamma[2], fragment_uniform_buffer_0[37][3]);

				fragment_uniform_buffer_0[38] = float4(_Gain[0], _Gain[1], _Gain[2], fragment_uniform_buffer_0[38][3]);

				fragment_uniform_buffer_0[39] = float4(_CustomToneCurve[0], _CustomToneCurve[1], _CustomToneCurve[2], _CustomToneCurve[3]);

				fragment_uniform_buffer_0[40] = float4(_ToeSegmentA[0], _ToeSegmentA[1], _ToeSegmentA[2], _ToeSegmentA[3]);

				fragment_uniform_buffer_0[41] = float4(_ToeSegmentB[0], _ToeSegmentB[1], _ToeSegmentB[2], _ToeSegmentB[3]);

				fragment_uniform_buffer_0[42] = float4(_MidSegmentA[0], _MidSegmentA[1], _MidSegmentA[2], _MidSegmentA[3]);

				fragment_uniform_buffer_0[43] = float4(_MidSegmentB[0], _MidSegmentB[1], _MidSegmentB[2], _MidSegmentB[3]);

				fragment_uniform_buffer_0[44] = float4(_ShoSegmentA[0], _ShoSegmentA[1], _ShoSegmentA[2], _ShoSegmentA[3]);

				fragment_uniform_buffer_0[45] = float4(_ShoSegmentB[0], _ShoSegmentB[1], _ShoSegmentB[2], _ShoSegmentB[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // TONEMAPPING_CUSTOM
			#endif // !TONEMAPPING_ACES
			#endif // !TONEMAPPING_NEUTRAL


			// Fallback Shader Code
			#ifndef ANY_SHADER_VARIANT_ACTIVE

			// https://docs.unity3d.com/Manual/SL-UnityShaderVariables.html
			float4x4 unity_MatrixMVP;

			struct Vertex_Stage_Input
			{
				float3 pos : POSITION;
			};

			struct Vertex_Stage_Output
			{
				float4 pos : SV_POSITION;
			};

			Vertex_Stage_Output vert(Vertex_Stage_Input input)
			{
				Vertex_Stage_Output output;
				output.pos = mul(unity_MatrixMVP, float4(input.pos, 1.0));
				return output;
			}

			float4 frag(Vertex_Stage_Output input) : SV_TARGET
			{
				// Output solid grey color (e.g., 50% grey)
				return float4(0.5, 0.5, 0.5, 1.0); // RGBA
			}

			#endif // !ANY_SHADER_VARIANT_ACTIVE


			ENDHLSL
		}
	}
}
