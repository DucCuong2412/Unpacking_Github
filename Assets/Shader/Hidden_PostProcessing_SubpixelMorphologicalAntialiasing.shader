Shader "Hidden/PostProcessing/SubpixelMorphologicalAntialiasing"
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
			GpuProgramID 53444

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.0


			float4 _MainTex_TexelSize;

			static float4 vertex_uniform_buffer_0[29];
			static float4 gl_Position;
			static float3 vertex_input_0;
			static float2 vertex_output_1;
			static float4 vertex_output_2;
			static float4 vertex_output_3;
			static float4 vertex_output_4;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				float4 vertex_output_2 : TEXCOORD1; // TEXCOORD_1
				float4 vertex_output_3 : TEXCOORD2; // TEXCOORD_2
				float4 vertex_output_4 : TEXCOORD3; // TEXCOORD_3
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				gl_Position.x = vertex_input_0.x;
				gl_Position.y = vertex_input_0.y;
				gl_Position.z = 0.0f;
				gl_Position.w = 1.0f;
				precise float vertex_unnamed_44 = vertex_input_0.x + 1.0f;
				precise float vertex_unnamed_45 = vertex_input_0.y + 1.0f;
				float vertex_unnamed_47 = mad(vertex_unnamed_44, 0.5f, 0.0f);
				float vertex_unnamed_49 = mad(vertex_unnamed_45, -0.5f, 1.0f);
				vertex_output_1.x = vertex_unnamed_47;
				vertex_output_1.y = vertex_unnamed_49;
				vertex_output_2.x = mad(vertex_uniform_buffer_0[28u].x, -1.0f, vertex_unnamed_47);
				vertex_output_2.y = mad(vertex_uniform_buffer_0[28u].y, 0.0f, vertex_unnamed_49);
				vertex_output_2.z = mad(vertex_uniform_buffer_0[28u].x, 0.0f, vertex_unnamed_47);
				vertex_output_2.w = mad(vertex_uniform_buffer_0[28u].y, -1.0f, vertex_unnamed_49);
				vertex_output_3.x = mad(vertex_uniform_buffer_0[28u].x, 1.0f, vertex_unnamed_47);
				vertex_output_3.y = mad(vertex_uniform_buffer_0[28u].y, 0.0f, vertex_unnamed_49);
				vertex_output_3.z = mad(vertex_uniform_buffer_0[28u].x, 0.0f, vertex_unnamed_47);
				vertex_output_3.w = mad(vertex_uniform_buffer_0[28u].y, 1.0f, vertex_unnamed_49);
				vertex_output_4.x = mad(vertex_uniform_buffer_0[28u].x, -2.0f, vertex_unnamed_47);
				vertex_output_4.y = mad(vertex_uniform_buffer_0[28u].y, 0.0f, vertex_unnamed_49);
				vertex_output_4.z = mad(vertex_uniform_buffer_0[28u].x, 0.0f, vertex_unnamed_47);
				vertex_output_4.w = mad(vertex_uniform_buffer_0[28u].y, -2.0f, vertex_unnamed_49);
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[28] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				return stage_output;
			}


			float4 _MainTex_TexelSize;

			static float4 gl_Position;
			static float3 vertex_input_0;
			static float2 vertex_output_0;
			static float4 vertex_output_1;
			static float4 vertex_output_2;
			static float4 vertex_output_3;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION;
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_0 : TEXCOORD0; // vs_TEXCOORD0
				float4 vertex_output_1 : TEXCOORD1; // vs_TEXCOORD1
				float4 vertex_output_2 : TEXCOORD2; // vs_TEXCOORD2
				float4 vertex_output_3 : TEXCOORD3; // vs_TEXCOORD3
				float4 gl_Position : SV_Position;
			};

			static float2 vertex_unnamed_33;

			void vert_main()
			{
				gl_Position = float4(vertex_input_0.xy.x, vertex_input_0.xy.y, gl_Position.z, gl_Position.w);
				gl_Position = float4(gl_Position.x, gl_Position.y, float2(0.0f, 1.0f).x, float2(0.0f, 1.0f).y);
				vertex_unnamed_33 = vertex_input_0.xy + 1.0f.xx;
				vertex_unnamed_33 = (vertex_unnamed_33 * float2(0.5f, -0.5f)) + float2(0.0f, 1.0f);
				vertex_output_0 = vertex_unnamed_33;
				vertex_output_1 = (_MainTex_TexelSize.xyxy * float4(-1.0f, 0.0f, 0.0f, -1.0f)) + vertex_unnamed_33.xyxy;
				vertex_output_2 = (_MainTex_TexelSize.xyxy * float4(1.0f, 0.0f, 0.0f, 1.0f)) + vertex_unnamed_33.xyxy;
				vertex_output_3 = (_MainTex_TexelSize.xyxy * float4(-2.0f, 0.0f, 0.0f, -2.0f)) + vertex_unnamed_33.xyxy;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_0 = vertex_output_0;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				return stage_output;
			}

			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

			static float2 fragment_input_0;
			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_0 : TEXCOORD0; // vs_TEXCOORD0
				float4 fragment_input_1 : TEXCOORD1; // vs_TEXCOORD1
				float4 fragment_input_2 : TEXCOORD2; // vs_TEXCOORD2
				float4 fragment_input_3 : TEXCOORD3; // vs_TEXCOORD3
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static float3 fragment_unnamed_9;
			static float3 fragment_unnamed_27;
			static float3 fragment_unnamed_37;
			static float fragment_unnamed_43;
			static float3 fragment_unnamed_61;
			static float3 fragment_unnamed_69;
			static bool2 fragment_unnamed_90;
			static float2 fragment_unnamed_99;
			static bool fragment_unnamed_114;
			static float3 fragment_unnamed_153;
			static float fragment_unnamed_199;
			static float2 fragment_unnamed_250;
			static bool2 fragment_unnamed_256;

			void frag_main()
			{
				fragment_unnamed_9 = _MainTex.Sample(sampler_MainTex, fragment_input_0).xyz;
				fragment_unnamed_27 = _MainTex.Sample(sampler_MainTex, fragment_input_1.xy).xyz;
				fragment_unnamed_37 = fragment_unnamed_9 + (-fragment_unnamed_27);
				fragment_unnamed_43 = max(abs(fragment_unnamed_37.y), abs(fragment_unnamed_37.x));
				fragment_unnamed_37.x = max(abs(fragment_unnamed_37.z), fragment_unnamed_43);
				fragment_unnamed_61 = _MainTex.Sample(sampler_MainTex, fragment_input_1.zw).xyz;
				fragment_unnamed_69 = fragment_unnamed_9 + (-fragment_unnamed_61);
				fragment_unnamed_43 = max(abs(fragment_unnamed_69.y), abs(fragment_unnamed_69.x));
				fragment_unnamed_37.y = max(abs(fragment_unnamed_69.z), fragment_unnamed_43);
				fragment_unnamed_90 = bool4(fragment_unnamed_37.xyxy.x >= 0.1500000059604644775390625f.xxxx.x, fragment_unnamed_37.xyxy.y >= 0.1500000059604644775390625f.xxxx.y, fragment_unnamed_37.xyxy.z >= 0.1500000059604644775390625f.xxxx.z, fragment_unnamed_37.xyxy.w >= 0.1500000059604644775390625f.xxxx.w).xy;
				fragment_unnamed_99.x = float(fragment_unnamed_90.x);
				fragment_unnamed_99.y = float(fragment_unnamed_90.y);
				fragment_unnamed_43 = dot(fragment_unnamed_99, 1.0f.xx);
				fragment_unnamed_114 = fragment_unnamed_43 == 0.0f;
				if ((int(fragment_unnamed_114) * (-1)) != 0)
				{
					discard;
				}
				fragment_unnamed_69 = _MainTex.Sample(sampler_MainTex, fragment_input_2.xy).xyz;
				fragment_unnamed_69 = fragment_unnamed_9 + (-fragment_unnamed_69);
				fragment_unnamed_43 = max(abs(fragment_unnamed_69.y), abs(fragment_unnamed_69.x));
				fragment_unnamed_69.x = max(abs(fragment_unnamed_69.z), fragment_unnamed_43);
				fragment_unnamed_153 = _MainTex.Sample(sampler_MainTex, fragment_input_2.zw).xyz;
				fragment_unnamed_9 += (-fragment_unnamed_153);
				fragment_unnamed_9.x = max(abs(fragment_unnamed_9.y), abs(fragment_unnamed_9.x));
				fragment_unnamed_69.y = max(abs(fragment_unnamed_9.z), fragment_unnamed_9.x);
				float2 fragment_unnamed_184 = max(fragment_unnamed_37.xy, fragment_unnamed_69.xy);
				fragment_unnamed_9 = float3(fragment_unnamed_184.x, fragment_unnamed_184.y, fragment_unnamed_9.z);
				fragment_unnamed_69 = _MainTex.Sample(sampler_MainTex, fragment_input_3.xy).xyz;
				fragment_unnamed_27 += (-fragment_unnamed_69);
				fragment_unnamed_199 = max(abs(fragment_unnamed_27.y), abs(fragment_unnamed_27.x));
				fragment_unnamed_27.x = max(abs(fragment_unnamed_27.z), fragment_unnamed_199);
				fragment_unnamed_69 = _MainTex.Sample(sampler_MainTex, fragment_input_3.zw).xyz;
				fragment_unnamed_61 += (-fragment_unnamed_69);
				fragment_unnamed_199 = max(abs(fragment_unnamed_61.y), abs(fragment_unnamed_61.x));
				fragment_unnamed_27.y = max(abs(fragment_unnamed_61.z), fragment_unnamed_199);
				float2 fragment_unnamed_241 = max(fragment_unnamed_9.xy, fragment_unnamed_27.xy);
				fragment_unnamed_9 = float3(fragment_unnamed_241.x, fragment_unnamed_241.y, fragment_unnamed_9.z);
				fragment_unnamed_9.x = max(fragment_unnamed_9.y, fragment_unnamed_9.x);
				fragment_unnamed_250 = fragment_unnamed_37.xy + fragment_unnamed_37.xy;
				fragment_unnamed_256 = bool4(fragment_unnamed_250.xyxx.x >= fragment_unnamed_9.xxxx.x, fragment_unnamed_250.xyxx.y >= fragment_unnamed_9.xxxx.y, fragment_unnamed_250.xyxx.z >= fragment_unnamed_9.xxxx.z, fragment_unnamed_250.xyxx.w >= fragment_unnamed_9.xxxx.w).xy;
				fragment_unnamed_9.x = float(fragment_unnamed_256.x);
				fragment_unnamed_9.y = float(fragment_unnamed_256.y);
				float2 fragment_unnamed_274 = fragment_unnamed_9.xy * fragment_unnamed_99;
				fragment_unnamed_9 = float3(fragment_unnamed_274.x, fragment_unnamed_274.y, fragment_unnamed_9.z);
				fragment_output_0 = float4(fragment_unnamed_9.xy.x, fragment_unnamed_9.xy.y, fragment_output_0.z, fragment_output_0.w);
				fragment_output_0 = float4(fragment_output_0.x, fragment_output_0.y, 0.0f.xx.x, 0.0f.xx.y);
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_0 = stage_input.fragment_input_0;
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

			static float2 fragment_input_1;
			static float4 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD; // TEXCOORD
				float4 fragment_input_2 : TEXCOORD1; // TEXCOORD_1
				float4 fragment_input_3 : TEXCOORD2; // TEXCOORD_2
				float4 fragment_input_4 : TEXCOORD3; // TEXCOORD_3
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static bool discard_state;

			void discard_cond(bool fragment_unnamed_210)
			{
				if (fragment_unnamed_210)
				{
					discard_state = true;
				}
			}

			void discard_exit()
			{
				if (discard_state)
				{
					discard;
				}
			}

			void frag_main()
			{
				discard_state = false;
				float4 fragment_unnamed_36 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				float fragment_unnamed_38 = fragment_unnamed_36.x;
				float fragment_unnamed_39 = fragment_unnamed_36.y;
				float fragment_unnamed_40 = fragment_unnamed_36.z;
				float4 fragment_unnamed_45 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_2.x, fragment_input_2.y));
				float fragment_unnamed_47 = fragment_unnamed_45.x;
				float fragment_unnamed_48 = fragment_unnamed_45.y;
				float fragment_unnamed_49 = fragment_unnamed_45.z;
				precise float fragment_unnamed_50 = (-0.0f) - fragment_unnamed_47;
				precise float fragment_unnamed_52 = (-0.0f) - fragment_unnamed_48;
				precise float fragment_unnamed_53 = (-0.0f) - fragment_unnamed_49;
				precise float fragment_unnamed_54 = fragment_unnamed_38 + fragment_unnamed_50;
				precise float fragment_unnamed_55 = fragment_unnamed_39 + fragment_unnamed_52;
				precise float fragment_unnamed_56 = fragment_unnamed_40 + fragment_unnamed_53;
				float fragment_unnamed_62 = max(abs(fragment_unnamed_56), max(abs(fragment_unnamed_55), abs(fragment_unnamed_54)));
				float4 fragment_unnamed_69 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_2.z, fragment_input_2.w));
				float fragment_unnamed_71 = fragment_unnamed_69.x;
				float fragment_unnamed_72 = fragment_unnamed_69.y;
				float fragment_unnamed_73 = fragment_unnamed_69.z;
				precise float fragment_unnamed_74 = (-0.0f) - fragment_unnamed_71;
				precise float fragment_unnamed_75 = (-0.0f) - fragment_unnamed_72;
				precise float fragment_unnamed_76 = (-0.0f) - fragment_unnamed_73;
				precise float fragment_unnamed_77 = fragment_unnamed_38 + fragment_unnamed_74;
				precise float fragment_unnamed_78 = fragment_unnamed_39 + fragment_unnamed_75;
				precise float fragment_unnamed_79 = fragment_unnamed_40 + fragment_unnamed_76;
				float fragment_unnamed_84 = max(abs(fragment_unnamed_79), max(abs(fragment_unnamed_78), abs(fragment_unnamed_77)));
				float fragment_unnamed_94 = asfloat(((fragment_unnamed_62 >= 0.1500000059604644775390625f) ? 4294967295u : 0u) & 1065353216u);
				uint fragment_unnamed_95 = ((fragment_unnamed_84 >= 0.1500000059604644775390625f) ? 4294967295u : 0u) & 1065353216u;
				discard_cond(dot(float2(fragment_unnamed_94, asfloat(fragment_unnamed_95)), 1.0f.xx) == 0.0f);
				float4 fragment_unnamed_109 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_3.x, fragment_input_3.y));
				precise float fragment_unnamed_114 = (-0.0f) - fragment_unnamed_109.x;
				precise float fragment_unnamed_115 = (-0.0f) - fragment_unnamed_109.y;
				precise float fragment_unnamed_116 = (-0.0f) - fragment_unnamed_109.z;
				precise float fragment_unnamed_117 = fragment_unnamed_38 + fragment_unnamed_114;
				precise float fragment_unnamed_118 = fragment_unnamed_39 + fragment_unnamed_115;
				precise float fragment_unnamed_119 = fragment_unnamed_40 + fragment_unnamed_116;
				float4 fragment_unnamed_129 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_3.z, fragment_input_3.w));
				precise float fragment_unnamed_134 = (-0.0f) - fragment_unnamed_129.x;
				precise float fragment_unnamed_135 = (-0.0f) - fragment_unnamed_129.y;
				precise float fragment_unnamed_136 = (-0.0f) - fragment_unnamed_129.z;
				precise float fragment_unnamed_137 = fragment_unnamed_38 + fragment_unnamed_134;
				precise float fragment_unnamed_138 = fragment_unnamed_39 + fragment_unnamed_135;
				precise float fragment_unnamed_139 = fragment_unnamed_40 + fragment_unnamed_136;
				float4 fragment_unnamed_151 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_4.x, fragment_input_4.y));
				precise float fragment_unnamed_156 = (-0.0f) - fragment_unnamed_151.x;
				precise float fragment_unnamed_157 = (-0.0f) - fragment_unnamed_151.y;
				precise float fragment_unnamed_158 = (-0.0f) - fragment_unnamed_151.z;
				precise float fragment_unnamed_159 = fragment_unnamed_47 + fragment_unnamed_156;
				precise float fragment_unnamed_160 = fragment_unnamed_48 + fragment_unnamed_157;
				precise float fragment_unnamed_161 = fragment_unnamed_49 + fragment_unnamed_158;
				float4 fragment_unnamed_171 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_4.z, fragment_input_4.w));
				precise float fragment_unnamed_176 = (-0.0f) - fragment_unnamed_171.x;
				precise float fragment_unnamed_177 = (-0.0f) - fragment_unnamed_171.y;
				precise float fragment_unnamed_178 = (-0.0f) - fragment_unnamed_171.z;
				precise float fragment_unnamed_179 = fragment_unnamed_71 + fragment_unnamed_176;
				precise float fragment_unnamed_180 = fragment_unnamed_72 + fragment_unnamed_177;
				precise float fragment_unnamed_181 = fragment_unnamed_73 + fragment_unnamed_178;
				float fragment_unnamed_189 = max(max(max(fragment_unnamed_84, max(abs(fragment_unnamed_139), max(abs(fragment_unnamed_138), abs(fragment_unnamed_137)))), max(abs(fragment_unnamed_181), max(abs(fragment_unnamed_180), abs(fragment_unnamed_179)))), max(max(fragment_unnamed_62, max(abs(fragment_unnamed_119), max(abs(fragment_unnamed_118), abs(fragment_unnamed_117)))), max(abs(fragment_unnamed_161), max(abs(fragment_unnamed_160), abs(fragment_unnamed_159)))));
				precise float fragment_unnamed_190 = fragment_unnamed_62 + fragment_unnamed_62;
				precise float fragment_unnamed_191 = fragment_unnamed_84 + fragment_unnamed_84;
				precise float fragment_unnamed_201 = asfloat(((fragment_unnamed_190 >= fragment_unnamed_189) ? 4294967295u : 0u) & 1065353216u) * fragment_unnamed_94;
				precise float fragment_unnamed_202 = asfloat(((fragment_unnamed_191 >= fragment_unnamed_189) ? 4294967295u : 0u) & 1065353216u) * asfloat(fragment_unnamed_95);
				fragment_output_0.x = fragment_unnamed_201;
				fragment_output_0.y = fragment_unnamed_202;
				fragment_output_0.z = 0.0f;
				fragment_output_0.w = 0.0f;
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
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
			GpuProgramID 120903

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.0


			float4 _MainTex_TexelSize;

			static float4 vertex_uniform_buffer_0[29];
			static float4 gl_Position;
			static float3 vertex_input_0;
			static float2 vertex_output_1;
			static float4 vertex_output_2;
			static float4 vertex_output_3;
			static float4 vertex_output_4;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				float4 vertex_output_2 : TEXCOORD1; // TEXCOORD_1
				float4 vertex_output_3 : TEXCOORD2; // TEXCOORD_2
				float4 vertex_output_4 : TEXCOORD3; // TEXCOORD_3
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				gl_Position.x = vertex_input_0.x;
				gl_Position.y = vertex_input_0.y;
				gl_Position.z = 0.0f;
				gl_Position.w = 1.0f;
				precise float vertex_unnamed_44 = vertex_input_0.x + 1.0f;
				precise float vertex_unnamed_45 = vertex_input_0.y + 1.0f;
				float vertex_unnamed_47 = mad(vertex_unnamed_44, 0.5f, 0.0f);
				float vertex_unnamed_49 = mad(vertex_unnamed_45, -0.5f, 1.0f);
				vertex_output_1.x = vertex_unnamed_47;
				vertex_output_1.y = vertex_unnamed_49;
				vertex_output_2.x = mad(vertex_uniform_buffer_0[28u].x, -1.0f, vertex_unnamed_47);
				vertex_output_2.y = mad(vertex_uniform_buffer_0[28u].y, 0.0f, vertex_unnamed_49);
				vertex_output_2.z = mad(vertex_uniform_buffer_0[28u].x, 0.0f, vertex_unnamed_47);
				vertex_output_2.w = mad(vertex_uniform_buffer_0[28u].y, -1.0f, vertex_unnamed_49);
				vertex_output_3.x = mad(vertex_uniform_buffer_0[28u].x, 1.0f, vertex_unnamed_47);
				vertex_output_3.y = mad(vertex_uniform_buffer_0[28u].y, 0.0f, vertex_unnamed_49);
				vertex_output_3.z = mad(vertex_uniform_buffer_0[28u].x, 0.0f, vertex_unnamed_47);
				vertex_output_3.w = mad(vertex_uniform_buffer_0[28u].y, 1.0f, vertex_unnamed_49);
				vertex_output_4.x = mad(vertex_uniform_buffer_0[28u].x, -2.0f, vertex_unnamed_47);
				vertex_output_4.y = mad(vertex_uniform_buffer_0[28u].y, 0.0f, vertex_unnamed_49);
				vertex_output_4.z = mad(vertex_uniform_buffer_0[28u].x, 0.0f, vertex_unnamed_47);
				vertex_output_4.w = mad(vertex_uniform_buffer_0[28u].y, -2.0f, vertex_unnamed_49);
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[28] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				return stage_output;
			}


			float4 _MainTex_TexelSize;

			static float4 gl_Position;
			static float3 vertex_input_0;
			static float2 vertex_output_0;
			static float4 vertex_output_1;
			static float4 vertex_output_2;
			static float4 vertex_output_3;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION;
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_0 : TEXCOORD0; // vs_TEXCOORD0
				float4 vertex_output_1 : TEXCOORD1; // vs_TEXCOORD1
				float4 vertex_output_2 : TEXCOORD2; // vs_TEXCOORD2
				float4 vertex_output_3 : TEXCOORD3; // vs_TEXCOORD3
				float4 gl_Position : SV_Position;
			};

			static float2 vertex_unnamed_33;

			void vert_main()
			{
				gl_Position = float4(vertex_input_0.xy.x, vertex_input_0.xy.y, gl_Position.z, gl_Position.w);
				gl_Position = float4(gl_Position.x, gl_Position.y, float2(0.0f, 1.0f).x, float2(0.0f, 1.0f).y);
				vertex_unnamed_33 = vertex_input_0.xy + 1.0f.xx;
				vertex_unnamed_33 = (vertex_unnamed_33 * float2(0.5f, -0.5f)) + float2(0.0f, 1.0f);
				vertex_output_0 = vertex_unnamed_33;
				vertex_output_1 = (_MainTex_TexelSize.xyxy * float4(-1.0f, 0.0f, 0.0f, -1.0f)) + vertex_unnamed_33.xyxy;
				vertex_output_2 = (_MainTex_TexelSize.xyxy * float4(1.0f, 0.0f, 0.0f, 1.0f)) + vertex_unnamed_33.xyxy;
				vertex_output_3 = (_MainTex_TexelSize.xyxy * float4(-2.0f, 0.0f, 0.0f, -2.0f)) + vertex_unnamed_33.xyxy;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_0 = vertex_output_0;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				return stage_output;
			}

			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

			static float2 fragment_input_0;
			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_0 : TEXCOORD0; // vs_TEXCOORD0
				float4 fragment_input_1 : TEXCOORD1; // vs_TEXCOORD1
				float4 fragment_input_2 : TEXCOORD2; // vs_TEXCOORD2
				float4 fragment_input_3 : TEXCOORD3; // vs_TEXCOORD3
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static float3 fragment_unnamed_9;
			static float3 fragment_unnamed_27;
			static float3 fragment_unnamed_37;
			static float fragment_unnamed_43;
			static float3 fragment_unnamed_61;
			static float3 fragment_unnamed_69;
			static bool2 fragment_unnamed_90;
			static float2 fragment_unnamed_99;
			static bool fragment_unnamed_114;
			static float3 fragment_unnamed_153;
			static float fragment_unnamed_199;
			static float2 fragment_unnamed_250;
			static bool2 fragment_unnamed_256;

			void frag_main()
			{
				fragment_unnamed_9 = _MainTex.Sample(sampler_MainTex, fragment_input_0).xyz;
				fragment_unnamed_27 = _MainTex.Sample(sampler_MainTex, fragment_input_1.xy).xyz;
				fragment_unnamed_37 = fragment_unnamed_9 + (-fragment_unnamed_27);
				fragment_unnamed_43 = max(abs(fragment_unnamed_37.y), abs(fragment_unnamed_37.x));
				fragment_unnamed_37.x = max(abs(fragment_unnamed_37.z), fragment_unnamed_43);
				fragment_unnamed_61 = _MainTex.Sample(sampler_MainTex, fragment_input_1.zw).xyz;
				fragment_unnamed_69 = fragment_unnamed_9 + (-fragment_unnamed_61);
				fragment_unnamed_43 = max(abs(fragment_unnamed_69.y), abs(fragment_unnamed_69.x));
				fragment_unnamed_37.y = max(abs(fragment_unnamed_69.z), fragment_unnamed_43);
				fragment_unnamed_90 = bool4(fragment_unnamed_37.xyxy.x >= 0.100000001490116119384765625f.xxxx.x, fragment_unnamed_37.xyxy.y >= 0.100000001490116119384765625f.xxxx.y, fragment_unnamed_37.xyxy.z >= 0.100000001490116119384765625f.xxxx.z, fragment_unnamed_37.xyxy.w >= 0.100000001490116119384765625f.xxxx.w).xy;
				fragment_unnamed_99.x = float(fragment_unnamed_90.x);
				fragment_unnamed_99.y = float(fragment_unnamed_90.y);
				fragment_unnamed_43 = dot(fragment_unnamed_99, 1.0f.xx);
				fragment_unnamed_114 = fragment_unnamed_43 == 0.0f;
				if ((int(fragment_unnamed_114) * (-1)) != 0)
				{
					discard;
				}
				fragment_unnamed_69 = _MainTex.Sample(sampler_MainTex, fragment_input_2.xy).xyz;
				fragment_unnamed_69 = fragment_unnamed_9 + (-fragment_unnamed_69);
				fragment_unnamed_43 = max(abs(fragment_unnamed_69.y), abs(fragment_unnamed_69.x));
				fragment_unnamed_69.x = max(abs(fragment_unnamed_69.z), fragment_unnamed_43);
				fragment_unnamed_153 = _MainTex.Sample(sampler_MainTex, fragment_input_2.zw).xyz;
				fragment_unnamed_9 += (-fragment_unnamed_153);
				fragment_unnamed_9.x = max(abs(fragment_unnamed_9.y), abs(fragment_unnamed_9.x));
				fragment_unnamed_69.y = max(abs(fragment_unnamed_9.z), fragment_unnamed_9.x);
				float2 fragment_unnamed_184 = max(fragment_unnamed_37.xy, fragment_unnamed_69.xy);
				fragment_unnamed_9 = float3(fragment_unnamed_184.x, fragment_unnamed_184.y, fragment_unnamed_9.z);
				fragment_unnamed_69 = _MainTex.Sample(sampler_MainTex, fragment_input_3.xy).xyz;
				fragment_unnamed_27 += (-fragment_unnamed_69);
				fragment_unnamed_199 = max(abs(fragment_unnamed_27.y), abs(fragment_unnamed_27.x));
				fragment_unnamed_27.x = max(abs(fragment_unnamed_27.z), fragment_unnamed_199);
				fragment_unnamed_69 = _MainTex.Sample(sampler_MainTex, fragment_input_3.zw).xyz;
				fragment_unnamed_61 += (-fragment_unnamed_69);
				fragment_unnamed_199 = max(abs(fragment_unnamed_61.y), abs(fragment_unnamed_61.x));
				fragment_unnamed_27.y = max(abs(fragment_unnamed_61.z), fragment_unnamed_199);
				float2 fragment_unnamed_241 = max(fragment_unnamed_9.xy, fragment_unnamed_27.xy);
				fragment_unnamed_9 = float3(fragment_unnamed_241.x, fragment_unnamed_241.y, fragment_unnamed_9.z);
				fragment_unnamed_9.x = max(fragment_unnamed_9.y, fragment_unnamed_9.x);
				fragment_unnamed_250 = fragment_unnamed_37.xy + fragment_unnamed_37.xy;
				fragment_unnamed_256 = bool4(fragment_unnamed_250.xyxx.x >= fragment_unnamed_9.xxxx.x, fragment_unnamed_250.xyxx.y >= fragment_unnamed_9.xxxx.y, fragment_unnamed_250.xyxx.z >= fragment_unnamed_9.xxxx.z, fragment_unnamed_250.xyxx.w >= fragment_unnamed_9.xxxx.w).xy;
				fragment_unnamed_9.x = float(fragment_unnamed_256.x);
				fragment_unnamed_9.y = float(fragment_unnamed_256.y);
				float2 fragment_unnamed_274 = fragment_unnamed_9.xy * fragment_unnamed_99;
				fragment_unnamed_9 = float3(fragment_unnamed_274.x, fragment_unnamed_274.y, fragment_unnamed_9.z);
				fragment_output_0 = float4(fragment_unnamed_9.xy.x, fragment_unnamed_9.xy.y, fragment_output_0.z, fragment_output_0.w);
				fragment_output_0 = float4(fragment_output_0.x, fragment_output_0.y, 0.0f.xx.x, 0.0f.xx.y);
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_0 = stage_input.fragment_input_0;
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

			static float2 fragment_input_1;
			static float4 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD; // TEXCOORD
				float4 fragment_input_2 : TEXCOORD1; // TEXCOORD_1
				float4 fragment_input_3 : TEXCOORD2; // TEXCOORD_2
				float4 fragment_input_4 : TEXCOORD3; // TEXCOORD_3
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static bool discard_state;

			void discard_cond(bool fragment_unnamed_210)
			{
				if (fragment_unnamed_210)
				{
					discard_state = true;
				}
			}

			void discard_exit()
			{
				if (discard_state)
				{
					discard;
				}
			}

			void frag_main()
			{
				discard_state = false;
				float4 fragment_unnamed_36 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				float fragment_unnamed_38 = fragment_unnamed_36.x;
				float fragment_unnamed_39 = fragment_unnamed_36.y;
				float fragment_unnamed_40 = fragment_unnamed_36.z;
				float4 fragment_unnamed_45 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_2.x, fragment_input_2.y));
				float fragment_unnamed_47 = fragment_unnamed_45.x;
				float fragment_unnamed_48 = fragment_unnamed_45.y;
				float fragment_unnamed_49 = fragment_unnamed_45.z;
				precise float fragment_unnamed_50 = (-0.0f) - fragment_unnamed_47;
				precise float fragment_unnamed_52 = (-0.0f) - fragment_unnamed_48;
				precise float fragment_unnamed_53 = (-0.0f) - fragment_unnamed_49;
				precise float fragment_unnamed_54 = fragment_unnamed_38 + fragment_unnamed_50;
				precise float fragment_unnamed_55 = fragment_unnamed_39 + fragment_unnamed_52;
				precise float fragment_unnamed_56 = fragment_unnamed_40 + fragment_unnamed_53;
				float fragment_unnamed_62 = max(abs(fragment_unnamed_56), max(abs(fragment_unnamed_55), abs(fragment_unnamed_54)));
				float4 fragment_unnamed_69 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_2.z, fragment_input_2.w));
				float fragment_unnamed_71 = fragment_unnamed_69.x;
				float fragment_unnamed_72 = fragment_unnamed_69.y;
				float fragment_unnamed_73 = fragment_unnamed_69.z;
				precise float fragment_unnamed_74 = (-0.0f) - fragment_unnamed_71;
				precise float fragment_unnamed_75 = (-0.0f) - fragment_unnamed_72;
				precise float fragment_unnamed_76 = (-0.0f) - fragment_unnamed_73;
				precise float fragment_unnamed_77 = fragment_unnamed_38 + fragment_unnamed_74;
				precise float fragment_unnamed_78 = fragment_unnamed_39 + fragment_unnamed_75;
				precise float fragment_unnamed_79 = fragment_unnamed_40 + fragment_unnamed_76;
				float fragment_unnamed_84 = max(abs(fragment_unnamed_79), max(abs(fragment_unnamed_78), abs(fragment_unnamed_77)));
				float fragment_unnamed_94 = asfloat(((fragment_unnamed_62 >= 0.100000001490116119384765625f) ? 4294967295u : 0u) & 1065353216u);
				uint fragment_unnamed_95 = ((fragment_unnamed_84 >= 0.100000001490116119384765625f) ? 4294967295u : 0u) & 1065353216u;
				discard_cond(dot(float2(fragment_unnamed_94, asfloat(fragment_unnamed_95)), 1.0f.xx) == 0.0f);
				float4 fragment_unnamed_109 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_3.x, fragment_input_3.y));
				precise float fragment_unnamed_114 = (-0.0f) - fragment_unnamed_109.x;
				precise float fragment_unnamed_115 = (-0.0f) - fragment_unnamed_109.y;
				precise float fragment_unnamed_116 = (-0.0f) - fragment_unnamed_109.z;
				precise float fragment_unnamed_117 = fragment_unnamed_38 + fragment_unnamed_114;
				precise float fragment_unnamed_118 = fragment_unnamed_39 + fragment_unnamed_115;
				precise float fragment_unnamed_119 = fragment_unnamed_40 + fragment_unnamed_116;
				float4 fragment_unnamed_129 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_3.z, fragment_input_3.w));
				precise float fragment_unnamed_134 = (-0.0f) - fragment_unnamed_129.x;
				precise float fragment_unnamed_135 = (-0.0f) - fragment_unnamed_129.y;
				precise float fragment_unnamed_136 = (-0.0f) - fragment_unnamed_129.z;
				precise float fragment_unnamed_137 = fragment_unnamed_38 + fragment_unnamed_134;
				precise float fragment_unnamed_138 = fragment_unnamed_39 + fragment_unnamed_135;
				precise float fragment_unnamed_139 = fragment_unnamed_40 + fragment_unnamed_136;
				float4 fragment_unnamed_151 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_4.x, fragment_input_4.y));
				precise float fragment_unnamed_156 = (-0.0f) - fragment_unnamed_151.x;
				precise float fragment_unnamed_157 = (-0.0f) - fragment_unnamed_151.y;
				precise float fragment_unnamed_158 = (-0.0f) - fragment_unnamed_151.z;
				precise float fragment_unnamed_159 = fragment_unnamed_47 + fragment_unnamed_156;
				precise float fragment_unnamed_160 = fragment_unnamed_48 + fragment_unnamed_157;
				precise float fragment_unnamed_161 = fragment_unnamed_49 + fragment_unnamed_158;
				float4 fragment_unnamed_171 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_4.z, fragment_input_4.w));
				precise float fragment_unnamed_176 = (-0.0f) - fragment_unnamed_171.x;
				precise float fragment_unnamed_177 = (-0.0f) - fragment_unnamed_171.y;
				precise float fragment_unnamed_178 = (-0.0f) - fragment_unnamed_171.z;
				precise float fragment_unnamed_179 = fragment_unnamed_71 + fragment_unnamed_176;
				precise float fragment_unnamed_180 = fragment_unnamed_72 + fragment_unnamed_177;
				precise float fragment_unnamed_181 = fragment_unnamed_73 + fragment_unnamed_178;
				float fragment_unnamed_189 = max(max(max(fragment_unnamed_84, max(abs(fragment_unnamed_139), max(abs(fragment_unnamed_138), abs(fragment_unnamed_137)))), max(abs(fragment_unnamed_181), max(abs(fragment_unnamed_180), abs(fragment_unnamed_179)))), max(max(fragment_unnamed_62, max(abs(fragment_unnamed_119), max(abs(fragment_unnamed_118), abs(fragment_unnamed_117)))), max(abs(fragment_unnamed_161), max(abs(fragment_unnamed_160), abs(fragment_unnamed_159)))));
				precise float fragment_unnamed_190 = fragment_unnamed_62 + fragment_unnamed_62;
				precise float fragment_unnamed_191 = fragment_unnamed_84 + fragment_unnamed_84;
				precise float fragment_unnamed_201 = asfloat(((fragment_unnamed_190 >= fragment_unnamed_189) ? 4294967295u : 0u) & 1065353216u) * fragment_unnamed_94;
				precise float fragment_unnamed_202 = asfloat(((fragment_unnamed_191 >= fragment_unnamed_189) ? 4294967295u : 0u) & 1065353216u) * asfloat(fragment_unnamed_95);
				fragment_output_0.x = fragment_unnamed_201;
				fragment_output_0.y = fragment_unnamed_202;
				fragment_output_0.z = 0.0f;
				fragment_output_0.w = 0.0f;
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
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
			GpuProgramID 142247

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.0


			float4 _MainTex_TexelSize;

			static float4 vertex_uniform_buffer_0[29];
			static float4 gl_Position;
			static float3 vertex_input_0;
			static float2 vertex_output_1;
			static float4 vertex_output_2;
			static float4 vertex_output_3;
			static float4 vertex_output_4;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				float4 vertex_output_2 : TEXCOORD1; // TEXCOORD_1
				float4 vertex_output_3 : TEXCOORD2; // TEXCOORD_2
				float4 vertex_output_4 : TEXCOORD3; // TEXCOORD_3
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				gl_Position.x = vertex_input_0.x;
				gl_Position.y = vertex_input_0.y;
				gl_Position.z = 0.0f;
				gl_Position.w = 1.0f;
				precise float vertex_unnamed_44 = vertex_input_0.x + 1.0f;
				precise float vertex_unnamed_45 = vertex_input_0.y + 1.0f;
				float vertex_unnamed_47 = mad(vertex_unnamed_44, 0.5f, 0.0f);
				float vertex_unnamed_49 = mad(vertex_unnamed_45, -0.5f, 1.0f);
				vertex_output_1.x = vertex_unnamed_47;
				vertex_output_1.y = vertex_unnamed_49;
				vertex_output_2.x = mad(vertex_uniform_buffer_0[28u].x, -1.0f, vertex_unnamed_47);
				vertex_output_2.y = mad(vertex_uniform_buffer_0[28u].y, 0.0f, vertex_unnamed_49);
				vertex_output_2.z = mad(vertex_uniform_buffer_0[28u].x, 0.0f, vertex_unnamed_47);
				vertex_output_2.w = mad(vertex_uniform_buffer_0[28u].y, -1.0f, vertex_unnamed_49);
				vertex_output_3.x = mad(vertex_uniform_buffer_0[28u].x, 1.0f, vertex_unnamed_47);
				vertex_output_3.y = mad(vertex_uniform_buffer_0[28u].y, 0.0f, vertex_unnamed_49);
				vertex_output_3.z = mad(vertex_uniform_buffer_0[28u].x, 0.0f, vertex_unnamed_47);
				vertex_output_3.w = mad(vertex_uniform_buffer_0[28u].y, 1.0f, vertex_unnamed_49);
				vertex_output_4.x = mad(vertex_uniform_buffer_0[28u].x, -2.0f, vertex_unnamed_47);
				vertex_output_4.y = mad(vertex_uniform_buffer_0[28u].y, 0.0f, vertex_unnamed_49);
				vertex_output_4.z = mad(vertex_uniform_buffer_0[28u].x, 0.0f, vertex_unnamed_47);
				vertex_output_4.w = mad(vertex_uniform_buffer_0[28u].y, -2.0f, vertex_unnamed_49);
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[28] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				return stage_output;
			}


			float4 _MainTex_TexelSize;

			static float4 gl_Position;
			static float3 vertex_input_0;
			static float2 vertex_output_0;
			static float4 vertex_output_1;
			static float4 vertex_output_2;
			static float4 vertex_output_3;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION;
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_0 : TEXCOORD0; // vs_TEXCOORD0
				float4 vertex_output_1 : TEXCOORD1; // vs_TEXCOORD1
				float4 vertex_output_2 : TEXCOORD2; // vs_TEXCOORD2
				float4 vertex_output_3 : TEXCOORD3; // vs_TEXCOORD3
				float4 gl_Position : SV_Position;
			};

			static float2 vertex_unnamed_33;

			void vert_main()
			{
				gl_Position = float4(vertex_input_0.xy.x, vertex_input_0.xy.y, gl_Position.z, gl_Position.w);
				gl_Position = float4(gl_Position.x, gl_Position.y, float2(0.0f, 1.0f).x, float2(0.0f, 1.0f).y);
				vertex_unnamed_33 = vertex_input_0.xy + 1.0f.xx;
				vertex_unnamed_33 = (vertex_unnamed_33 * float2(0.5f, -0.5f)) + float2(0.0f, 1.0f);
				vertex_output_0 = vertex_unnamed_33;
				vertex_output_1 = (_MainTex_TexelSize.xyxy * float4(-1.0f, 0.0f, 0.0f, -1.0f)) + vertex_unnamed_33.xyxy;
				vertex_output_2 = (_MainTex_TexelSize.xyxy * float4(1.0f, 0.0f, 0.0f, 1.0f)) + vertex_unnamed_33.xyxy;
				vertex_output_3 = (_MainTex_TexelSize.xyxy * float4(-2.0f, 0.0f, 0.0f, -2.0f)) + vertex_unnamed_33.xyxy;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_0 = vertex_output_0;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				return stage_output;
			}

			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

			static float2 fragment_input_0;
			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_0 : TEXCOORD0; // vs_TEXCOORD0
				float4 fragment_input_1 : TEXCOORD1; // vs_TEXCOORD1
				float4 fragment_input_2 : TEXCOORD2; // vs_TEXCOORD2
				float4 fragment_input_3 : TEXCOORD3; // vs_TEXCOORD3
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static float3 fragment_unnamed_9;
			static float3 fragment_unnamed_27;
			static float3 fragment_unnamed_37;
			static float fragment_unnamed_43;
			static float3 fragment_unnamed_61;
			static float3 fragment_unnamed_69;
			static bool2 fragment_unnamed_90;
			static float2 fragment_unnamed_99;
			static bool fragment_unnamed_114;
			static float3 fragment_unnamed_153;
			static float fragment_unnamed_199;
			static float2 fragment_unnamed_250;
			static bool2 fragment_unnamed_256;

			void frag_main()
			{
				fragment_unnamed_9 = _MainTex.Sample(sampler_MainTex, fragment_input_0).xyz;
				fragment_unnamed_27 = _MainTex.Sample(sampler_MainTex, fragment_input_1.xy).xyz;
				fragment_unnamed_37 = fragment_unnamed_9 + (-fragment_unnamed_27);
				fragment_unnamed_43 = max(abs(fragment_unnamed_37.y), abs(fragment_unnamed_37.x));
				fragment_unnamed_37.x = max(abs(fragment_unnamed_37.z), fragment_unnamed_43);
				fragment_unnamed_61 = _MainTex.Sample(sampler_MainTex, fragment_input_1.zw).xyz;
				fragment_unnamed_69 = fragment_unnamed_9 + (-fragment_unnamed_61);
				fragment_unnamed_43 = max(abs(fragment_unnamed_69.y), abs(fragment_unnamed_69.x));
				fragment_unnamed_37.y = max(abs(fragment_unnamed_69.z), fragment_unnamed_43);
				fragment_unnamed_90 = bool4(fragment_unnamed_37.xyxy.x >= 0.100000001490116119384765625f.xxxx.x, fragment_unnamed_37.xyxy.y >= 0.100000001490116119384765625f.xxxx.y, fragment_unnamed_37.xyxy.z >= 0.100000001490116119384765625f.xxxx.z, fragment_unnamed_37.xyxy.w >= 0.100000001490116119384765625f.xxxx.w).xy;
				fragment_unnamed_99.x = float(fragment_unnamed_90.x);
				fragment_unnamed_99.y = float(fragment_unnamed_90.y);
				fragment_unnamed_43 = dot(fragment_unnamed_99, 1.0f.xx);
				fragment_unnamed_114 = fragment_unnamed_43 == 0.0f;
				if ((int(fragment_unnamed_114) * (-1)) != 0)
				{
					discard;
				}
				fragment_unnamed_69 = _MainTex.Sample(sampler_MainTex, fragment_input_2.xy).xyz;
				fragment_unnamed_69 = fragment_unnamed_9 + (-fragment_unnamed_69);
				fragment_unnamed_43 = max(abs(fragment_unnamed_69.y), abs(fragment_unnamed_69.x));
				fragment_unnamed_69.x = max(abs(fragment_unnamed_69.z), fragment_unnamed_43);
				fragment_unnamed_153 = _MainTex.Sample(sampler_MainTex, fragment_input_2.zw).xyz;
				fragment_unnamed_9 += (-fragment_unnamed_153);
				fragment_unnamed_9.x = max(abs(fragment_unnamed_9.y), abs(fragment_unnamed_9.x));
				fragment_unnamed_69.y = max(abs(fragment_unnamed_9.z), fragment_unnamed_9.x);
				float2 fragment_unnamed_184 = max(fragment_unnamed_37.xy, fragment_unnamed_69.xy);
				fragment_unnamed_9 = float3(fragment_unnamed_184.x, fragment_unnamed_184.y, fragment_unnamed_9.z);
				fragment_unnamed_69 = _MainTex.Sample(sampler_MainTex, fragment_input_3.xy).xyz;
				fragment_unnamed_27 += (-fragment_unnamed_69);
				fragment_unnamed_199 = max(abs(fragment_unnamed_27.y), abs(fragment_unnamed_27.x));
				fragment_unnamed_27.x = max(abs(fragment_unnamed_27.z), fragment_unnamed_199);
				fragment_unnamed_69 = _MainTex.Sample(sampler_MainTex, fragment_input_3.zw).xyz;
				fragment_unnamed_61 += (-fragment_unnamed_69);
				fragment_unnamed_199 = max(abs(fragment_unnamed_61.y), abs(fragment_unnamed_61.x));
				fragment_unnamed_27.y = max(abs(fragment_unnamed_61.z), fragment_unnamed_199);
				float2 fragment_unnamed_241 = max(fragment_unnamed_9.xy, fragment_unnamed_27.xy);
				fragment_unnamed_9 = float3(fragment_unnamed_241.x, fragment_unnamed_241.y, fragment_unnamed_9.z);
				fragment_unnamed_9.x = max(fragment_unnamed_9.y, fragment_unnamed_9.x);
				fragment_unnamed_250 = fragment_unnamed_37.xy + fragment_unnamed_37.xy;
				fragment_unnamed_256 = bool4(fragment_unnamed_250.xyxx.x >= fragment_unnamed_9.xxxx.x, fragment_unnamed_250.xyxx.y >= fragment_unnamed_9.xxxx.y, fragment_unnamed_250.xyxx.z >= fragment_unnamed_9.xxxx.z, fragment_unnamed_250.xyxx.w >= fragment_unnamed_9.xxxx.w).xy;
				fragment_unnamed_9.x = float(fragment_unnamed_256.x);
				fragment_unnamed_9.y = float(fragment_unnamed_256.y);
				float2 fragment_unnamed_274 = fragment_unnamed_9.xy * fragment_unnamed_99;
				fragment_unnamed_9 = float3(fragment_unnamed_274.x, fragment_unnamed_274.y, fragment_unnamed_9.z);
				fragment_output_0 = float4(fragment_unnamed_9.xy.x, fragment_unnamed_9.xy.y, fragment_output_0.z, fragment_output_0.w);
				fragment_output_0 = float4(fragment_output_0.x, fragment_output_0.y, 0.0f.xx.x, 0.0f.xx.y);
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_0 = stage_input.fragment_input_0;
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

			static float2 fragment_input_1;
			static float4 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD; // TEXCOORD
				float4 fragment_input_2 : TEXCOORD1; // TEXCOORD_1
				float4 fragment_input_3 : TEXCOORD2; // TEXCOORD_2
				float4 fragment_input_4 : TEXCOORD3; // TEXCOORD_3
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static bool discard_state;

			void discard_cond(bool fragment_unnamed_210)
			{
				if (fragment_unnamed_210)
				{
					discard_state = true;
				}
			}

			void discard_exit()
			{
				if (discard_state)
				{
					discard;
				}
			}

			void frag_main()
			{
				discard_state = false;
				float4 fragment_unnamed_36 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				float fragment_unnamed_38 = fragment_unnamed_36.x;
				float fragment_unnamed_39 = fragment_unnamed_36.y;
				float fragment_unnamed_40 = fragment_unnamed_36.z;
				float4 fragment_unnamed_45 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_2.x, fragment_input_2.y));
				float fragment_unnamed_47 = fragment_unnamed_45.x;
				float fragment_unnamed_48 = fragment_unnamed_45.y;
				float fragment_unnamed_49 = fragment_unnamed_45.z;
				precise float fragment_unnamed_50 = (-0.0f) - fragment_unnamed_47;
				precise float fragment_unnamed_52 = (-0.0f) - fragment_unnamed_48;
				precise float fragment_unnamed_53 = (-0.0f) - fragment_unnamed_49;
				precise float fragment_unnamed_54 = fragment_unnamed_38 + fragment_unnamed_50;
				precise float fragment_unnamed_55 = fragment_unnamed_39 + fragment_unnamed_52;
				precise float fragment_unnamed_56 = fragment_unnamed_40 + fragment_unnamed_53;
				float fragment_unnamed_62 = max(abs(fragment_unnamed_56), max(abs(fragment_unnamed_55), abs(fragment_unnamed_54)));
				float4 fragment_unnamed_69 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_2.z, fragment_input_2.w));
				float fragment_unnamed_71 = fragment_unnamed_69.x;
				float fragment_unnamed_72 = fragment_unnamed_69.y;
				float fragment_unnamed_73 = fragment_unnamed_69.z;
				precise float fragment_unnamed_74 = (-0.0f) - fragment_unnamed_71;
				precise float fragment_unnamed_75 = (-0.0f) - fragment_unnamed_72;
				precise float fragment_unnamed_76 = (-0.0f) - fragment_unnamed_73;
				precise float fragment_unnamed_77 = fragment_unnamed_38 + fragment_unnamed_74;
				precise float fragment_unnamed_78 = fragment_unnamed_39 + fragment_unnamed_75;
				precise float fragment_unnamed_79 = fragment_unnamed_40 + fragment_unnamed_76;
				float fragment_unnamed_84 = max(abs(fragment_unnamed_79), max(abs(fragment_unnamed_78), abs(fragment_unnamed_77)));
				float fragment_unnamed_94 = asfloat(((fragment_unnamed_62 >= 0.100000001490116119384765625f) ? 4294967295u : 0u) & 1065353216u);
				uint fragment_unnamed_95 = ((fragment_unnamed_84 >= 0.100000001490116119384765625f) ? 4294967295u : 0u) & 1065353216u;
				discard_cond(dot(float2(fragment_unnamed_94, asfloat(fragment_unnamed_95)), 1.0f.xx) == 0.0f);
				float4 fragment_unnamed_109 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_3.x, fragment_input_3.y));
				precise float fragment_unnamed_114 = (-0.0f) - fragment_unnamed_109.x;
				precise float fragment_unnamed_115 = (-0.0f) - fragment_unnamed_109.y;
				precise float fragment_unnamed_116 = (-0.0f) - fragment_unnamed_109.z;
				precise float fragment_unnamed_117 = fragment_unnamed_38 + fragment_unnamed_114;
				precise float fragment_unnamed_118 = fragment_unnamed_39 + fragment_unnamed_115;
				precise float fragment_unnamed_119 = fragment_unnamed_40 + fragment_unnamed_116;
				float4 fragment_unnamed_129 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_3.z, fragment_input_3.w));
				precise float fragment_unnamed_134 = (-0.0f) - fragment_unnamed_129.x;
				precise float fragment_unnamed_135 = (-0.0f) - fragment_unnamed_129.y;
				precise float fragment_unnamed_136 = (-0.0f) - fragment_unnamed_129.z;
				precise float fragment_unnamed_137 = fragment_unnamed_38 + fragment_unnamed_134;
				precise float fragment_unnamed_138 = fragment_unnamed_39 + fragment_unnamed_135;
				precise float fragment_unnamed_139 = fragment_unnamed_40 + fragment_unnamed_136;
				float4 fragment_unnamed_151 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_4.x, fragment_input_4.y));
				precise float fragment_unnamed_156 = (-0.0f) - fragment_unnamed_151.x;
				precise float fragment_unnamed_157 = (-0.0f) - fragment_unnamed_151.y;
				precise float fragment_unnamed_158 = (-0.0f) - fragment_unnamed_151.z;
				precise float fragment_unnamed_159 = fragment_unnamed_47 + fragment_unnamed_156;
				precise float fragment_unnamed_160 = fragment_unnamed_48 + fragment_unnamed_157;
				precise float fragment_unnamed_161 = fragment_unnamed_49 + fragment_unnamed_158;
				float4 fragment_unnamed_171 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_4.z, fragment_input_4.w));
				precise float fragment_unnamed_176 = (-0.0f) - fragment_unnamed_171.x;
				precise float fragment_unnamed_177 = (-0.0f) - fragment_unnamed_171.y;
				precise float fragment_unnamed_178 = (-0.0f) - fragment_unnamed_171.z;
				precise float fragment_unnamed_179 = fragment_unnamed_71 + fragment_unnamed_176;
				precise float fragment_unnamed_180 = fragment_unnamed_72 + fragment_unnamed_177;
				precise float fragment_unnamed_181 = fragment_unnamed_73 + fragment_unnamed_178;
				float fragment_unnamed_189 = max(max(max(fragment_unnamed_84, max(abs(fragment_unnamed_139), max(abs(fragment_unnamed_138), abs(fragment_unnamed_137)))), max(abs(fragment_unnamed_181), max(abs(fragment_unnamed_180), abs(fragment_unnamed_179)))), max(max(fragment_unnamed_62, max(abs(fragment_unnamed_119), max(abs(fragment_unnamed_118), abs(fragment_unnamed_117)))), max(abs(fragment_unnamed_161), max(abs(fragment_unnamed_160), abs(fragment_unnamed_159)))));
				precise float fragment_unnamed_190 = fragment_unnamed_62 + fragment_unnamed_62;
				precise float fragment_unnamed_191 = fragment_unnamed_84 + fragment_unnamed_84;
				precise float fragment_unnamed_201 = asfloat(((fragment_unnamed_190 >= fragment_unnamed_189) ? 4294967295u : 0u) & 1065353216u) * fragment_unnamed_94;
				precise float fragment_unnamed_202 = asfloat(((fragment_unnamed_191 >= fragment_unnamed_189) ? 4294967295u : 0u) & 1065353216u) * asfloat(fragment_unnamed_95);
				fragment_output_0.x = fragment_unnamed_201;
				fragment_output_0.y = fragment_unnamed_202;
				fragment_output_0.z = 0.0f;
				fragment_output_0.w = 0.0f;
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
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
			GpuProgramID 255539

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.0


			float4 _MainTex_TexelSize;

			static float4 vertex_uniform_buffer_0[29];
			static float4 gl_Position;
			static float3 vertex_input_0;
			static float2 vertex_output_1;
			static float2 vertex_output_1;
			static float4 vertex_output_2;
			static float4 vertex_output_3;
			static float4 vertex_output_4;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				float2 vertex_output_1 : TEXCOORD1; // TEXCOORD_1
				float4 vertex_output_2 : TEXCOORD2; // TEXCOORD_2
				float4 vertex_output_3 : TEXCOORD3; // TEXCOORD_3
				float4 vertex_output_4 : TEXCOORD4; // TEXCOORD_4
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				gl_Position.x = vertex_input_0.x;
				gl_Position.y = vertex_input_0.y;
				gl_Position.z = 0.0f;
				gl_Position.w = 1.0f;
				vertex_output_1.x = mad(vertex_input_0.x, 0.5f, 0.5f);
				vertex_output_1.y = mad(vertex_input_0.y, -0.5f, 0.5f);
				precise float vertex_unnamed_56 = vertex_input_0.x + 1.0f;
				precise float vertex_unnamed_57 = vertex_input_0.y + 1.0f;
				precise float vertex_unnamed_58 = vertex_input_0.x + 1.0f;
				precise float vertex_unnamed_59 = vertex_input_0.y + 1.0f;
				float vertex_unnamed_62 = mad(vertex_unnamed_58, 0.5f, 0.0f);
				float vertex_unnamed_63 = mad(vertex_unnamed_59, -0.5f, 1.0f);
				precise float vertex_unnamed_70 = vertex_unnamed_62 * vertex_uniform_buffer_0[28u].z;
				precise float vertex_unnamed_71 = vertex_unnamed_63 * vertex_uniform_buffer_0[28u].w;
				vertex_output_1.x = vertex_unnamed_70;
				vertex_output_1.y = vertex_unnamed_71;
				float vertex_unnamed_78 = mad(vertex_uniform_buffer_0[28u].x, -0.25f, vertex_unnamed_62);
				float vertex_unnamed_80 = mad(vertex_uniform_buffer_0[28u].x, 1.25f, vertex_unnamed_62);
				float vertex_unnamed_90 = mad(vertex_uniform_buffer_0[28u].y, -0.25f, mad(vertex_unnamed_57, -0.5f, 1.0f));
				float vertex_unnamed_92 = mad(vertex_uniform_buffer_0[28u].y, 1.25f, vertex_unnamed_63);
				vertex_output_2.x = vertex_unnamed_78;
				vertex_output_2.y = mad(vertex_uniform_buffer_0[28u].y, -0.125f, vertex_unnamed_63);
				vertex_output_2.z = vertex_unnamed_80;
				vertex_output_2.w = mad(vertex_uniform_buffer_0[28u].y, -0.125f, vertex_unnamed_63);
				vertex_output_3.x = mad(vertex_uniform_buffer_0[28u].x, -0.125f, mad(vertex_unnamed_56, 0.5f, 0.0f));
				vertex_output_3.y = vertex_unnamed_90;
				vertex_output_3.z = mad(vertex_uniform_buffer_0[28u].x, -0.125f, vertex_unnamed_62);
				vertex_output_3.w = vertex_unnamed_92;
				vertex_output_4.x = mad(vertex_uniform_buffer_0[28u].x, -8.0f, vertex_unnamed_78);
				vertex_output_4.y = mad(vertex_uniform_buffer_0[28u].x, 8.0f, vertex_unnamed_80);
				vertex_output_4.z = mad(vertex_uniform_buffer_0[28u].y, -8.0f, vertex_unnamed_90);
				vertex_output_4.w = mad(vertex_uniform_buffer_0[28u].y, 8.0f, vertex_unnamed_92);
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[28] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				return stage_output;
			}


			float4 _MainTex_TexelSize;

			static float4 gl_Position;
			static float3 vertex_input_0;
			static float2 vertex_output_0;
			static float2 vertex_output_1;
			static float4 vertex_output_2;
			static float4 vertex_output_3;
			static float4 vertex_output_4;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION;
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_0 : TEXCOORD0; // vs_TEXCOORD0
				float2 vertex_output_1 : TEXCOORD1; // vs_TEXCOORD1
				float4 vertex_output_2 : TEXCOORD2; // vs_TEXCOORD2
				float4 vertex_output_3 : TEXCOORD3; // vs_TEXCOORD3
				float4 vertex_output_4 : TEXCOORD4; // vs_TEXCOORD4
				float4 gl_Position : SV_Position;
			};

			static float4 vertex_unnamed_43;
			static float4 vertex_unnamed_64;

			void vert_main()
			{
				gl_Position = float4(vertex_input_0.xy.x, vertex_input_0.xy.y, gl_Position.z, gl_Position.w);
				gl_Position = float4(gl_Position.x, gl_Position.y, float2(0.0f, 1.0f).x, float2(0.0f, 1.0f).y);
				vertex_output_0 = (vertex_input_0.xy * float2(0.5f, -0.5f)) + 0.5f.xx;
				vertex_unnamed_43 = vertex_input_0.xyxy + 1.0f.xxxx;
				vertex_unnamed_43 = (vertex_unnamed_43 * float4(0.5f, -0.5f, 0.5f, -0.5f)) + float4(0.0f, 1.0f, 0.0f, 1.0f);
				vertex_output_1 = vertex_unnamed_43.zw * _MainTex_TexelSize.zw;
				vertex_unnamed_64 = (_MainTex_TexelSize.xxyy * float4(-0.25f, 1.25f, -0.125f, -0.125f)) + vertex_unnamed_43.zzww;
				vertex_unnamed_43 = (_MainTex_TexelSize.xyxy * float4(-0.125f, -0.25f, -0.125f, 1.25f)) + vertex_unnamed_43;
				vertex_output_2 = vertex_unnamed_64.xzyw;
				vertex_output_3 = vertex_unnamed_43;
				vertex_unnamed_64 = float4(vertex_unnamed_64.x, vertex_unnamed_64.y, vertex_unnamed_43.yw.x, vertex_unnamed_43.yw.y);
				vertex_output_4 = (_MainTex_TexelSize.xxyy * float4(-8.0f, 8.0f, -8.0f, 8.0f)) + vertex_unnamed_64;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_0 = vertex_output_0;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				return stage_output;
			}

			float4 _MainTex_TexelSize;

			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;
			Texture2D<float4> _SearchTex;
			Texture2D<float4> _AreaTex;

			static float2 fragment_input_0;
			static float4 fragment_input_2;
			static float4 fragment_input_4;
			static float4 fragment_input_3;
			static float2 fragment_input_1;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_0 : TEXCOORD0; // vs_TEXCOORD0
				float2 fragment_input_1 : TEXCOORD1; // vs_TEXCOORD1
				float4 fragment_input_2 : TEXCOORD2; // vs_TEXCOORD2
				float4 fragment_input_3 : TEXCOORD3; // vs_TEXCOORD3
				float4 fragment_input_4 : TEXCOORD4; // vs_TEXCOORD4
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static float4 fragment_unnamed_9;
			static bool2 fragment_unnamed_31;
			static float4 fragment_unnamed_46;
			static float3 fragment_unnamed_59;
			static bool fragment_unnamed_75;
			static float3 fragment_unnamed_189;
			static bool fragment_unnamed_196;
			static bool fragment_unnamed_202;
			static float fragment_unnamed_255;
			static bool fragment_unnamed_482;
			static float2 fragment_unnamed_527;
			static float2 fragment_unnamed_582;

			void frag_main()
			{
				float2 fragment_unnamed_25 = _MainTex.Sample(sampler_MainTex, fragment_input_0).xy;
				fragment_unnamed_9 = float4(fragment_unnamed_25.x, fragment_unnamed_25.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
				fragment_unnamed_31 = bool4(0.0f.xxxx.x < fragment_unnamed_9.yxyy.x, 0.0f.xxxx.y < fragment_unnamed_9.yxyy.y, 0.0f.xxxx.z < fragment_unnamed_9.yxyy.z, 0.0f.xxxx.w < fragment_unnamed_9.yxyy.w).xy;
				if (fragment_unnamed_31.x)
				{
					fragment_unnamed_46 = float4(fragment_input_2.xy.x, fragment_input_2.xy.y, fragment_unnamed_46.z, fragment_unnamed_46.w);
					fragment_unnamed_46.z = 1.0f;
					fragment_unnamed_59.x = 0.0f;
					while (true)
					{
						fragment_unnamed_31.x = fragment_input_4.x < fragment_unnamed_46.x;
						fragment_unnamed_75 = 0.828100025653839111328125f < fragment_unnamed_46.z;
						fragment_unnamed_31.x = fragment_unnamed_75 && fragment_unnamed_31.x;
						fragment_unnamed_75 = fragment_unnamed_59.x == 0.0f;
						fragment_unnamed_31.x = fragment_unnamed_75 && fragment_unnamed_31.x;
						if (!fragment_unnamed_31.x)
						{
							break;
						}
						float2 fragment_unnamed_105 = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_46.xy, 0.0f).xy;
						fragment_unnamed_59 = float3(fragment_unnamed_105.x, fragment_unnamed_105.y, fragment_unnamed_59.z);
						float2 fragment_unnamed_123 = (_MainTex_TexelSize.xy * float2(-2.0f, -0.0f)) + fragment_unnamed_46.xy;
						fragment_unnamed_46 = float4(fragment_unnamed_123.x, fragment_unnamed_123.y, fragment_unnamed_46.z, fragment_unnamed_46.w);
						fragment_unnamed_46.z = fragment_unnamed_59.y;
					}
					fragment_unnamed_59 = float3(fragment_unnamed_59.x, fragment_unnamed_46.xz.x, fragment_unnamed_46.xz.y);
					float2 fragment_unnamed_142 = (fragment_unnamed_59.xz * float2(0.5f, -2.0f)) + float2(0.0078125f, 2.03125f);
					fragment_unnamed_9 = float4(fragment_unnamed_142.x, fragment_unnamed_9.y, fragment_unnamed_142.y, fragment_unnamed_9.w);
					fragment_unnamed_9.x = _SearchTex.SampleLevel(sampler_MainTex, fragment_unnamed_9.xz, 0.0f).w;
					fragment_unnamed_9.x = (fragment_unnamed_9.x * (-2.007874011993408203125f)) + 3.25f;
					fragment_unnamed_46.x = (_MainTex_TexelSize.x * fragment_unnamed_9.x) + fragment_unnamed_59.y;
					fragment_unnamed_46.y = fragment_input_3.y;
					fragment_unnamed_9.x = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_46.xy, 0.0f).x;
					fragment_unnamed_59 = float3(fragment_input_2.zw.x, fragment_input_2.zw.y, fragment_unnamed_59.z);
					fragment_unnamed_59.z = 1.0f;
					fragment_unnamed_189.x = 0.0f;
					while (true)
					{
						fragment_unnamed_196 = fragment_unnamed_59.x < fragment_input_4.y;
						fragment_unnamed_202 = 0.828100025653839111328125f < fragment_unnamed_59.z;
						fragment_unnamed_196 = fragment_unnamed_196 && fragment_unnamed_202;
						fragment_unnamed_202 = fragment_unnamed_189.x == 0.0f;
						fragment_unnamed_196 = fragment_unnamed_196 && fragment_unnamed_202;
						if (!fragment_unnamed_196)
						{
							break;
						}
						float2 fragment_unnamed_226 = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_59.xy, 0.0f).xy;
						fragment_unnamed_189 = float3(fragment_unnamed_226.x, fragment_unnamed_226.y, fragment_unnamed_189.z);
						float2 fragment_unnamed_237 = (_MainTex_TexelSize.xy * float2(2.0f, 0.0f)) + fragment_unnamed_59.xy;
						fragment_unnamed_59 = float3(fragment_unnamed_237.x, fragment_unnamed_237.y, fragment_unnamed_59.z);
						fragment_unnamed_59.z = fragment_unnamed_189.y;
					}
					fragment_unnamed_189 = float3(fragment_unnamed_189.x, fragment_unnamed_59.xz.x, fragment_unnamed_59.xz.y);
					float2 fragment_unnamed_252 = (fragment_unnamed_189.xz * float2(0.5f, -2.0f)) + float2(0.5234375f, 2.03125f);
					fragment_unnamed_59 = float3(fragment_unnamed_252.x, fragment_unnamed_252.y, fragment_unnamed_59.z);
					fragment_unnamed_255 = _SearchTex.SampleLevel(sampler_MainTex, fragment_unnamed_59.xy, 0.0f).w;
					fragment_unnamed_255 = (fragment_unnamed_255 * (-2.007874011993408203125f)) + 3.25f;
					fragment_unnamed_46.z = ((-_MainTex_TexelSize.x) * fragment_unnamed_255) + fragment_unnamed_189.y;
					float2 fragment_unnamed_285 = (_MainTex_TexelSize.zz * fragment_unnamed_46.xz) + (-fragment_input_1.xx);
					fragment_unnamed_46 = float4(fragment_unnamed_285.x, fragment_unnamed_46.y, fragment_unnamed_46.z, fragment_unnamed_285.y);
					float2 fragment_unnamed_290 = round(fragment_unnamed_46.xw);
					fragment_unnamed_46 = float4(fragment_unnamed_290.x, fragment_unnamed_46.y, fragment_unnamed_46.z, fragment_unnamed_290.y);
					float2 fragment_unnamed_296 = sqrt(abs(fragment_unnamed_46.xw));
					fragment_unnamed_46 = float4(fragment_unnamed_296.x, fragment_unnamed_46.y, fragment_unnamed_46.z, fragment_unnamed_296.y);
					fragment_unnamed_9.z = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_46.zy, 0.0f, int2(1, 0)).x;
					float2 fragment_unnamed_314 = fragment_unnamed_9.xz * 4.0f.xx;
					fragment_unnamed_9 = float4(fragment_unnamed_314.x, fragment_unnamed_9.y, fragment_unnamed_314.y, fragment_unnamed_9.w);
					float2 fragment_unnamed_319 = round(fragment_unnamed_9.xz);
					fragment_unnamed_9 = float4(fragment_unnamed_319.x, fragment_unnamed_9.y, fragment_unnamed_319.y, fragment_unnamed_9.w);
					float2 fragment_unnamed_329 = (fragment_unnamed_9.xz * 16.0f.xx) + fragment_unnamed_46.xw;
					fragment_unnamed_9 = float4(fragment_unnamed_329.x, fragment_unnamed_9.y, fragment_unnamed_329.y, fragment_unnamed_9.w);
					float2 fragment_unnamed_341 = (fragment_unnamed_9.xz * float2(0.0062500000931322574615478515625f, 0.001785714295692741870880126953125f)) + float2(0.00312500004656612873077392578125f, 0.0008928571478463709354400634765625f);
					fragment_unnamed_9 = float4(fragment_unnamed_341.x, fragment_unnamed_9.y, fragment_unnamed_341.y, fragment_unnamed_9.w);
					float2 fragment_unnamed_351 = _AreaTex.SampleLevel(sampler_MainTex, fragment_unnamed_9.xz, 0.0f).xy;
					fragment_unnamed_9 = float4(fragment_unnamed_351.x, fragment_unnamed_9.y, fragment_unnamed_351.y, fragment_unnamed_9.w);
					fragment_output_0 = float4(fragment_unnamed_9.xz.x, fragment_unnamed_9.xz.y, fragment_output_0.z, fragment_output_0.w);
				}
				else
				{
					fragment_output_0 = float4(0.0f.xx.x, 0.0f.xx.y, fragment_output_0.z, fragment_output_0.w);
				}
				if (fragment_unnamed_31.y)
				{
					fragment_unnamed_9 = float4(fragment_input_3.xy.x, fragment_input_3.xy.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
					fragment_unnamed_9.z = 1.0f;
					fragment_unnamed_46.x = 0.0f;
					while (true)
					{
						fragment_unnamed_196 = fragment_input_4.z < fragment_unnamed_9.y;
						fragment_unnamed_202 = 0.828100025653839111328125f < fragment_unnamed_9.z;
						fragment_unnamed_196 = fragment_unnamed_196 && fragment_unnamed_202;
						fragment_unnamed_202 = fragment_unnamed_46.x == 0.0f;
						fragment_unnamed_196 = fragment_unnamed_196 && fragment_unnamed_202;
						if (!fragment_unnamed_196)
						{
							break;
						}
						float2 fragment_unnamed_407 = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_9.xy, 0.0f).yx;
						fragment_unnamed_46 = float4(fragment_unnamed_407.x, fragment_unnamed_407.y, fragment_unnamed_46.z, fragment_unnamed_46.w);
						float2 fragment_unnamed_417 = (_MainTex_TexelSize.xy * float2(-0.0f, -2.0f)) + fragment_unnamed_9.xy;
						fragment_unnamed_9 = float4(fragment_unnamed_417.x, fragment_unnamed_417.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
						fragment_unnamed_9.z = fragment_unnamed_46.y;
					}
					fragment_unnamed_46 = float4(fragment_unnamed_46.x, fragment_unnamed_9.yz.x, fragment_unnamed_9.yz.y, fragment_unnamed_46.w);
					float2 fragment_unnamed_430 = (fragment_unnamed_46.xz * float2(0.5f, -2.0f)) + float2(0.0078125f, 2.03125f);
					fragment_unnamed_9 = float4(fragment_unnamed_430.x, fragment_unnamed_430.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
					fragment_unnamed_9.x = _SearchTex.SampleLevel(sampler_MainTex, fragment_unnamed_9.xy, 0.0f).w;
					fragment_unnamed_9.x = (fragment_unnamed_9.x * (-2.007874011993408203125f)) + 3.25f;
					fragment_unnamed_9.x = (_MainTex_TexelSize.y * fragment_unnamed_9.x) + fragment_unnamed_46.y;
					fragment_unnamed_9.y = fragment_input_2.x;
					fragment_unnamed_46.x = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_9.yx, 0.0f).y;
					fragment_unnamed_59 = float3(fragment_input_3.zw.x, fragment_input_3.zw.y, fragment_unnamed_59.z);
					fragment_unnamed_59.z = 1.0f;
					fragment_unnamed_189.x = 0.0f;
					while (true)
					{
						fragment_unnamed_196 = fragment_unnamed_59.y < fragment_input_4.w;
						fragment_unnamed_482 = 0.828100025653839111328125f < fragment_unnamed_59.z;
						fragment_unnamed_196 = fragment_unnamed_196 && fragment_unnamed_482;
						fragment_unnamed_482 = fragment_unnamed_189.x == 0.0f;
						fragment_unnamed_196 = fragment_unnamed_196 && fragment_unnamed_482;
						if (!fragment_unnamed_196)
						{
							break;
						}
						float2 fragment_unnamed_506 = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_59.xy, 0.0f).yx;
						fragment_unnamed_189 = float3(fragment_unnamed_506.x, fragment_unnamed_506.y, fragment_unnamed_189.z);
						float2 fragment_unnamed_516 = (_MainTex_TexelSize.xy * float2(0.0f, 2.0f)) + fragment_unnamed_59.xy;
						fragment_unnamed_59 = float3(fragment_unnamed_516.x, fragment_unnamed_516.y, fragment_unnamed_59.z);
						fragment_unnamed_59.z = fragment_unnamed_189.y;
					}
					fragment_unnamed_189 = float3(fragment_unnamed_189.x, fragment_unnamed_59.yz.x, fragment_unnamed_59.yz.y);
					fragment_unnamed_527 = (fragment_unnamed_189.xz * float2(0.5f, -2.0f)) + float2(0.5234375f, 2.03125f);
					fragment_unnamed_255 = _SearchTex.SampleLevel(sampler_MainTex, fragment_unnamed_527, 0.0f).w;
					fragment_unnamed_255 = (fragment_unnamed_255 * (-2.007874011993408203125f)) + 3.25f;
					fragment_unnamed_9.z = ((-_MainTex_TexelSize.y) * fragment_unnamed_255) + fragment_unnamed_189.y;
					float2 fragment_unnamed_559 = (_MainTex_TexelSize.ww * fragment_unnamed_9.xz) + (-fragment_input_1.yy);
					fragment_unnamed_9 = float4(fragment_unnamed_559.x, fragment_unnamed_9.y, fragment_unnamed_9.z, fragment_unnamed_559.y);
					float2 fragment_unnamed_564 = round(fragment_unnamed_9.xw);
					fragment_unnamed_9 = float4(fragment_unnamed_564.x, fragment_unnamed_9.y, fragment_unnamed_9.z, fragment_unnamed_564.y);
					float2 fragment_unnamed_570 = sqrt(abs(fragment_unnamed_9.xw));
					fragment_unnamed_9 = float4(fragment_unnamed_570.x, fragment_unnamed_9.y, fragment_unnamed_9.z, fragment_unnamed_570.y);
					fragment_unnamed_46.y = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_9.yz, 0.0f, int2(0, 1)).y;
					fragment_unnamed_582 = fragment_unnamed_46.xy * 4.0f.xx;
					fragment_unnamed_582 = round(fragment_unnamed_582);
					float2 fragment_unnamed_592 = (fragment_unnamed_582 * 16.0f.xx) + fragment_unnamed_9.xw;
					fragment_unnamed_9 = float4(fragment_unnamed_592.x, fragment_unnamed_592.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
					float2 fragment_unnamed_598 = (fragment_unnamed_9.xy * float2(0.0062500000931322574615478515625f, 0.001785714295692741870880126953125f)) + float2(0.00312500004656612873077392578125f, 0.0008928571478463709354400634765625f);
					fragment_unnamed_9 = float4(fragment_unnamed_598.x, fragment_unnamed_598.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
					float2 fragment_unnamed_607 = _AreaTex.SampleLevel(sampler_MainTex, fragment_unnamed_9.xy, 0.0f).xy;
					fragment_unnamed_9 = float4(fragment_unnamed_607.x, fragment_unnamed_607.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
					fragment_output_0 = float4(fragment_output_0.x, fragment_output_0.y, fragment_unnamed_9.xy.x, fragment_unnamed_9.xy.y);
				}
				else
				{
					fragment_output_0 = float4(fragment_output_0.x, fragment_output_0.y, 0.0f.xx.x, 0.0f.xx.y);
				}
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_0 = stage_input.fragment_input_0;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			float4 _MainTex_TexelSize;

			static float4 fragment_uniform_buffer_0[29];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _AreaTex;
			Texture2D<float4> _SearchTex;
			SamplerState sampler_MainTex;

			static float2 fragment_input_1;
			static float2 fragment_input_1;
			static float4 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD; // TEXCOORD
				float2 fragment_input_1 : TEXCOORD1; // TEXCOORD_1
				float4 fragment_input_2 : TEXCOORD2; // TEXCOORD_2
				float4 fragment_input_3 : TEXCOORD3; // TEXCOORD_3
				float4 fragment_input_4 : TEXCOORD4; // TEXCOORD_4
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				float4 fragment_unnamed_46 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				if (0.0f < fragment_unnamed_46.y)
				{
					float fragment_unnamed_63;
					float fragment_unnamed_67;
					float fragment_unnamed_69;
					fragment_unnamed_63 = fragment_input_2.x;
					fragment_unnamed_67 = asfloat(1065353216u);
					fragment_unnamed_69 = asfloat(0u);
					float4 fragment_unnamed_119;
					float2 fragment_unnamed_120;
					for (float fragment_unnamed_65 = fragment_input_2.y; !((((fragment_unnamed_69 == 0.0f) ? 4294967295u : 0u) & (((0.828100025653839111328125f < fragment_unnamed_67) ? 4294967295u : 0u) & ((fragment_input_4.x < fragment_unnamed_63) ? 4294967295u : 0u))) == 0u); fragment_unnamed_120 = float2(fragment_unnamed_63, fragment_unnamed_65), fragment_unnamed_119 = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_120, 0.0f), fragment_unnamed_63 = mad(fragment_uniform_buffer_0[28u].x, -2.0f, fragment_unnamed_63), fragment_unnamed_65 = mad(fragment_uniform_buffer_0[28u].y, -0.0f, fragment_unnamed_65), fragment_unnamed_67 = fragment_unnamed_119.y, fragment_unnamed_69 = fragment_unnamed_119.x)
					{
					}
					float fragment_unnamed_103 = mad(fragment_uniform_buffer_0[28u].x, mad(_SearchTex.SampleLevel(sampler_MainTex, float2(mad(fragment_unnamed_69, 0.5f, 0.0078125f), mad(fragment_unnamed_67, -2.0f, 2.03125f)), 0.0f).w, -2.007874011993408203125f, 3.25f), fragment_unnamed_63);
					float fragment_unnamed_134;
					float fragment_unnamed_138;
					float fragment_unnamed_140;
					fragment_unnamed_134 = fragment_input_2.z;
					fragment_unnamed_138 = asfloat(1065353216u);
					fragment_unnamed_140 = asfloat(0u);
					float4 fragment_unnamed_230;
					float2 fragment_unnamed_231;
					for (float fragment_unnamed_136 = fragment_input_2.w; !((((fragment_unnamed_140 == 0.0f) ? 4294967295u : 0u) & (((0.828100025653839111328125f < fragment_unnamed_138) ? 4294967295u : 0u) & ((fragment_unnamed_134 < fragment_input_4.y) ? 4294967295u : 0u))) == 0u); fragment_unnamed_231 = float2(fragment_unnamed_134, fragment_unnamed_136), fragment_unnamed_230 = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_231, 0.0f), fragment_unnamed_134 = mad(fragment_uniform_buffer_0[28u].x, 2.0f, fragment_unnamed_134), fragment_unnamed_136 = mad(fragment_uniform_buffer_0[28u].y, 0.0f, fragment_unnamed_136), fragment_unnamed_138 = fragment_unnamed_230.y, fragment_unnamed_140 = fragment_unnamed_230.x)
					{
					}
					precise float fragment_unnamed_183 = (-0.0f) - fragment_uniform_buffer_0[28u].x;
					float fragment_unnamed_184 = mad(fragment_unnamed_183, mad(_SearchTex.SampleLevel(sampler_MainTex, float2(mad(fragment_unnamed_140, 0.5f, 0.5234375f), mad(fragment_unnamed_138, -2.0f, 2.03125f)), 0.0f).w, -2.007874011993408203125f, 3.25f), fragment_unnamed_134);
					precise float fragment_unnamed_190 = (-0.0f) - fragment_input_1.x;
					precise float fragment_unnamed_208 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_103, fragment_input_3.y), 0.0f).x * 4.0f;
					precise float fragment_unnamed_210 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_184, fragment_input_3.y), 0.0f, int2(1, 0)).x * 4.0f;
					float4 fragment_unnamed_223 = _AreaTex.SampleLevel(sampler_MainTex, float2(mad(mad(round(fragment_unnamed_208), 16.0f, sqrt(abs(round(mad(fragment_uniform_buffer_0[28u].z, fragment_unnamed_103, fragment_unnamed_190))))), 0.0062500000931322574615478515625f, 0.00312500004656612873077392578125f), mad(mad(round(fragment_unnamed_210), 16.0f, sqrt(abs(round(mad(fragment_uniform_buffer_0[28u].z, fragment_unnamed_184, fragment_unnamed_190))))), 0.001785714295692741870880126953125f, 0.0008928571478463709354400634765625f)), 0.0f);
					fragment_output_0.x = fragment_unnamed_223.x;
					fragment_output_0.y = fragment_unnamed_223.y;
				}
				else
				{
					fragment_output_0.x = 0.0f;
					fragment_output_0.y = 0.0f;
				}
				if (0.0f < fragment_unnamed_46.x)
				{
					float fragment_unnamed_153;
					float fragment_unnamed_155;
					float fragment_unnamed_157;
					fragment_unnamed_153 = fragment_input_3.y;
					fragment_unnamed_155 = asfloat(1065353216u);
					fragment_unnamed_157 = asfloat(0u);
					float4 fragment_unnamed_261;
					float2 fragment_unnamed_262;
					for (float fragment_unnamed_159 = fragment_input_3.x; !(((((fragment_input_4.z < fragment_unnamed_153) ? 4294967295u : 0u) & ((0.828100025653839111328125f < fragment_unnamed_155) ? 4294967295u : 0u)) & ((fragment_unnamed_157 == 0.0f) ? 4294967295u : 0u)) == 0u); fragment_unnamed_262 = float2(fragment_unnamed_159, fragment_unnamed_153), fragment_unnamed_261 = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_262, 0.0f), fragment_unnamed_153 = mad(fragment_uniform_buffer_0[28u].y, -2.0f, fragment_unnamed_153), fragment_unnamed_155 = fragment_unnamed_261.x, fragment_unnamed_157 = fragment_unnamed_261.y, fragment_unnamed_159 = mad(fragment_uniform_buffer_0[28u].x, -0.0f, fragment_unnamed_159))
					{
					}
					float fragment_unnamed_247 = mad(fragment_uniform_buffer_0[28u].y, mad(_SearchTex.SampleLevel(sampler_MainTex, float2(mad(fragment_unnamed_157, 0.5f, 0.0078125f), mad(fragment_unnamed_155, -2.0f, 2.03125f)), 0.0f).w, -2.007874011993408203125f, 3.25f), fragment_unnamed_153);
					float fragment_unnamed_269;
					float fragment_unnamed_271;
					float fragment_unnamed_273;
					fragment_unnamed_269 = fragment_input_3.w;
					fragment_unnamed_271 = asfloat(1065353216u);
					fragment_unnamed_273 = asfloat(0u);
					float4 fragment_unnamed_333;
					float2 fragment_unnamed_334;
					for (float fragment_unnamed_267 = fragment_input_3.z; !(((((fragment_unnamed_269 < fragment_input_4.w) ? 4294967295u : 0u) & ((0.828100025653839111328125f < fragment_unnamed_271) ? 4294967295u : 0u)) & ((fragment_unnamed_273 == 0.0f) ? 4294967295u : 0u)) == 0u); fragment_unnamed_334 = float2(fragment_unnamed_267, fragment_unnamed_269), fragment_unnamed_333 = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_334, 0.0f), fragment_unnamed_267 = mad(fragment_uniform_buffer_0[28u].x, 0.0f, fragment_unnamed_267), fragment_unnamed_269 = mad(fragment_uniform_buffer_0[28u].y, 2.0f, fragment_unnamed_269), fragment_unnamed_271 = fragment_unnamed_333.x, fragment_unnamed_273 = fragment_unnamed_333.y)
					{
					}
					precise float fragment_unnamed_296 = (-0.0f) - fragment_uniform_buffer_0[28u].y;
					float fragment_unnamed_297 = mad(fragment_unnamed_296, mad(_SearchTex.SampleLevel(sampler_MainTex, float2(mad(fragment_unnamed_273, 0.5f, 0.5234375f), mad(fragment_unnamed_271, -2.0f, 2.03125f)), 0.0f).w, -2.007874011993408203125f, 3.25f), fragment_unnamed_269);
					precise float fragment_unnamed_303 = (-0.0f) - fragment_input_1.y;
					precise float fragment_unnamed_317 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_input_2.x, fragment_unnamed_247), 0.0f).y * 4.0f;
					precise float fragment_unnamed_318 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_input_2.x, fragment_unnamed_297), 0.0f, int2(0, 1)).y * 4.0f;
					float4 fragment_unnamed_326 = _AreaTex.SampleLevel(sampler_MainTex, float2(mad(mad(round(fragment_unnamed_317), 16.0f, sqrt(abs(round(mad(fragment_uniform_buffer_0[28u].w, fragment_unnamed_247, fragment_unnamed_303))))), 0.0062500000931322574615478515625f, 0.00312500004656612873077392578125f), mad(mad(round(fragment_unnamed_318), 16.0f, sqrt(abs(round(mad(fragment_uniform_buffer_0[28u].w, fragment_unnamed_297, fragment_unnamed_303))))), 0.001785714295692741870880126953125f, 0.0008928571478463709354400634765625f)), 0.0f);
					fragment_output_0.z = fragment_unnamed_326.x;
					fragment_output_0.w = fragment_unnamed_326.y;
				}
				else
				{
					fragment_output_0.z = 0.0f;
					fragment_output_0.w = 0.0f;
				}
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[28] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
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
			GpuProgramID 325449

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.0


			float4 _MainTex_TexelSize;

			static float4 vertex_uniform_buffer_0[29];
			static float4 gl_Position;
			static float3 vertex_input_0;
			static float2 vertex_output_1;
			static float2 vertex_output_1;
			static float4 vertex_output_2;
			static float4 vertex_output_3;
			static float4 vertex_output_4;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				float2 vertex_output_1 : TEXCOORD1; // TEXCOORD_1
				float4 vertex_output_2 : TEXCOORD2; // TEXCOORD_2
				float4 vertex_output_3 : TEXCOORD3; // TEXCOORD_3
				float4 vertex_output_4 : TEXCOORD4; // TEXCOORD_4
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				gl_Position.x = vertex_input_0.x;
				gl_Position.y = vertex_input_0.y;
				gl_Position.z = 0.0f;
				gl_Position.w = 1.0f;
				vertex_output_1.x = mad(vertex_input_0.x, 0.5f, 0.5f);
				vertex_output_1.y = mad(vertex_input_0.y, -0.5f, 0.5f);
				precise float vertex_unnamed_56 = vertex_input_0.x + 1.0f;
				precise float vertex_unnamed_57 = vertex_input_0.y + 1.0f;
				precise float vertex_unnamed_58 = vertex_input_0.x + 1.0f;
				precise float vertex_unnamed_59 = vertex_input_0.y + 1.0f;
				float vertex_unnamed_62 = mad(vertex_unnamed_58, 0.5f, 0.0f);
				float vertex_unnamed_63 = mad(vertex_unnamed_59, -0.5f, 1.0f);
				precise float vertex_unnamed_70 = vertex_unnamed_62 * vertex_uniform_buffer_0[28u].z;
				precise float vertex_unnamed_71 = vertex_unnamed_63 * vertex_uniform_buffer_0[28u].w;
				vertex_output_1.x = vertex_unnamed_70;
				vertex_output_1.y = vertex_unnamed_71;
				float vertex_unnamed_78 = mad(vertex_uniform_buffer_0[28u].x, -0.25f, vertex_unnamed_62);
				float vertex_unnamed_80 = mad(vertex_uniform_buffer_0[28u].x, 1.25f, vertex_unnamed_62);
				float vertex_unnamed_90 = mad(vertex_uniform_buffer_0[28u].y, -0.25f, mad(vertex_unnamed_57, -0.5f, 1.0f));
				float vertex_unnamed_92 = mad(vertex_uniform_buffer_0[28u].y, 1.25f, vertex_unnamed_63);
				vertex_output_2.x = vertex_unnamed_78;
				vertex_output_2.y = mad(vertex_uniform_buffer_0[28u].y, -0.125f, vertex_unnamed_63);
				vertex_output_2.z = vertex_unnamed_80;
				vertex_output_2.w = mad(vertex_uniform_buffer_0[28u].y, -0.125f, vertex_unnamed_63);
				vertex_output_3.x = mad(vertex_uniform_buffer_0[28u].x, -0.125f, mad(vertex_unnamed_56, 0.5f, 0.0f));
				vertex_output_3.y = vertex_unnamed_90;
				vertex_output_3.z = mad(vertex_uniform_buffer_0[28u].x, -0.125f, vertex_unnamed_62);
				vertex_output_3.w = vertex_unnamed_92;
				vertex_output_4.x = mad(vertex_uniform_buffer_0[28u].x, -16.0f, vertex_unnamed_78);
				vertex_output_4.y = mad(vertex_uniform_buffer_0[28u].x, 16.0f, vertex_unnamed_80);
				vertex_output_4.z = mad(vertex_uniform_buffer_0[28u].y, -16.0f, vertex_unnamed_90);
				vertex_output_4.w = mad(vertex_uniform_buffer_0[28u].y, 16.0f, vertex_unnamed_92);
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[28] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				return stage_output;
			}


			float4 _MainTex_TexelSize;

			static float4 gl_Position;
			static float3 vertex_input_0;
			static float2 vertex_output_0;
			static float2 vertex_output_1;
			static float4 vertex_output_2;
			static float4 vertex_output_3;
			static float4 vertex_output_4;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION;
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_0 : TEXCOORD0; // vs_TEXCOORD0
				float2 vertex_output_1 : TEXCOORD1; // vs_TEXCOORD1
				float4 vertex_output_2 : TEXCOORD2; // vs_TEXCOORD2
				float4 vertex_output_3 : TEXCOORD3; // vs_TEXCOORD3
				float4 vertex_output_4 : TEXCOORD4; // vs_TEXCOORD4
				float4 gl_Position : SV_Position;
			};

			static float4 vertex_unnamed_43;
			static float4 vertex_unnamed_64;

			void vert_main()
			{
				gl_Position = float4(vertex_input_0.xy.x, vertex_input_0.xy.y, gl_Position.z, gl_Position.w);
				gl_Position = float4(gl_Position.x, gl_Position.y, float2(0.0f, 1.0f).x, float2(0.0f, 1.0f).y);
				vertex_output_0 = (vertex_input_0.xy * float2(0.5f, -0.5f)) + 0.5f.xx;
				vertex_unnamed_43 = vertex_input_0.xyxy + 1.0f.xxxx;
				vertex_unnamed_43 = (vertex_unnamed_43 * float4(0.5f, -0.5f, 0.5f, -0.5f)) + float4(0.0f, 1.0f, 0.0f, 1.0f);
				vertex_output_1 = vertex_unnamed_43.zw * _MainTex_TexelSize.zw;
				vertex_unnamed_64 = (_MainTex_TexelSize.xxyy * float4(-0.25f, 1.25f, -0.125f, -0.125f)) + vertex_unnamed_43.zzww;
				vertex_unnamed_43 = (_MainTex_TexelSize.xyxy * float4(-0.125f, -0.25f, -0.125f, 1.25f)) + vertex_unnamed_43;
				vertex_output_2 = vertex_unnamed_64.xzyw;
				vertex_output_3 = vertex_unnamed_43;
				vertex_unnamed_64 = float4(vertex_unnamed_64.x, vertex_unnamed_64.y, vertex_unnamed_43.yw.x, vertex_unnamed_43.yw.y);
				vertex_output_4 = (_MainTex_TexelSize.xxyy * float4(-16.0f, 16.0f, -16.0f, 16.0f)) + vertex_unnamed_64;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_0 = vertex_output_0;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				return stage_output;
			}

			float4 _MainTex_TexelSize;

			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;
			Texture2D<float4> _SearchTex;
			Texture2D<float4> _AreaTex;

			static float2 fragment_input_0;
			static float4 fragment_input_2;
			static float4 fragment_input_4;
			static float4 fragment_input_3;
			static float2 fragment_input_1;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_0 : TEXCOORD0; // vs_TEXCOORD0
				float2 fragment_input_1 : TEXCOORD1; // vs_TEXCOORD1
				float4 fragment_input_2 : TEXCOORD2; // vs_TEXCOORD2
				float4 fragment_input_3 : TEXCOORD3; // vs_TEXCOORD3
				float4 fragment_input_4 : TEXCOORD4; // vs_TEXCOORD4
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static float4 fragment_unnamed_9;
			static bool2 fragment_unnamed_31;
			static float4 fragment_unnamed_46;
			static float3 fragment_unnamed_59;
			static bool fragment_unnamed_75;
			static float3 fragment_unnamed_189;
			static bool fragment_unnamed_196;
			static bool fragment_unnamed_202;
			static float fragment_unnamed_255;
			static bool fragment_unnamed_482;
			static float2 fragment_unnamed_527;
			static float2 fragment_unnamed_582;

			void frag_main()
			{
				float2 fragment_unnamed_25 = _MainTex.Sample(sampler_MainTex, fragment_input_0).xy;
				fragment_unnamed_9 = float4(fragment_unnamed_25.x, fragment_unnamed_25.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
				fragment_unnamed_31 = bool4(0.0f.xxxx.x < fragment_unnamed_9.yxyy.x, 0.0f.xxxx.y < fragment_unnamed_9.yxyy.y, 0.0f.xxxx.z < fragment_unnamed_9.yxyy.z, 0.0f.xxxx.w < fragment_unnamed_9.yxyy.w).xy;
				if (fragment_unnamed_31.x)
				{
					fragment_unnamed_46 = float4(fragment_input_2.xy.x, fragment_input_2.xy.y, fragment_unnamed_46.z, fragment_unnamed_46.w);
					fragment_unnamed_46.z = 1.0f;
					fragment_unnamed_59.x = 0.0f;
					while (true)
					{
						fragment_unnamed_31.x = fragment_input_4.x < fragment_unnamed_46.x;
						fragment_unnamed_75 = 0.828100025653839111328125f < fragment_unnamed_46.z;
						fragment_unnamed_31.x = fragment_unnamed_75 && fragment_unnamed_31.x;
						fragment_unnamed_75 = fragment_unnamed_59.x == 0.0f;
						fragment_unnamed_31.x = fragment_unnamed_75 && fragment_unnamed_31.x;
						if (!fragment_unnamed_31.x)
						{
							break;
						}
						float2 fragment_unnamed_105 = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_46.xy, 0.0f).xy;
						fragment_unnamed_59 = float3(fragment_unnamed_105.x, fragment_unnamed_105.y, fragment_unnamed_59.z);
						float2 fragment_unnamed_123 = (_MainTex_TexelSize.xy * float2(-2.0f, -0.0f)) + fragment_unnamed_46.xy;
						fragment_unnamed_46 = float4(fragment_unnamed_123.x, fragment_unnamed_123.y, fragment_unnamed_46.z, fragment_unnamed_46.w);
						fragment_unnamed_46.z = fragment_unnamed_59.y;
					}
					fragment_unnamed_59 = float3(fragment_unnamed_59.x, fragment_unnamed_46.xz.x, fragment_unnamed_46.xz.y);
					float2 fragment_unnamed_142 = (fragment_unnamed_59.xz * float2(0.5f, -2.0f)) + float2(0.0078125f, 2.03125f);
					fragment_unnamed_9 = float4(fragment_unnamed_142.x, fragment_unnamed_9.y, fragment_unnamed_142.y, fragment_unnamed_9.w);
					fragment_unnamed_9.x = _SearchTex.SampleLevel(sampler_MainTex, fragment_unnamed_9.xz, 0.0f).w;
					fragment_unnamed_9.x = (fragment_unnamed_9.x * (-2.007874011993408203125f)) + 3.25f;
					fragment_unnamed_46.x = (_MainTex_TexelSize.x * fragment_unnamed_9.x) + fragment_unnamed_59.y;
					fragment_unnamed_46.y = fragment_input_3.y;
					fragment_unnamed_9.x = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_46.xy, 0.0f).x;
					fragment_unnamed_59 = float3(fragment_input_2.zw.x, fragment_input_2.zw.y, fragment_unnamed_59.z);
					fragment_unnamed_59.z = 1.0f;
					fragment_unnamed_189.x = 0.0f;
					while (true)
					{
						fragment_unnamed_196 = fragment_unnamed_59.x < fragment_input_4.y;
						fragment_unnamed_202 = 0.828100025653839111328125f < fragment_unnamed_59.z;
						fragment_unnamed_196 = fragment_unnamed_196 && fragment_unnamed_202;
						fragment_unnamed_202 = fragment_unnamed_189.x == 0.0f;
						fragment_unnamed_196 = fragment_unnamed_196 && fragment_unnamed_202;
						if (!fragment_unnamed_196)
						{
							break;
						}
						float2 fragment_unnamed_226 = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_59.xy, 0.0f).xy;
						fragment_unnamed_189 = float3(fragment_unnamed_226.x, fragment_unnamed_226.y, fragment_unnamed_189.z);
						float2 fragment_unnamed_237 = (_MainTex_TexelSize.xy * float2(2.0f, 0.0f)) + fragment_unnamed_59.xy;
						fragment_unnamed_59 = float3(fragment_unnamed_237.x, fragment_unnamed_237.y, fragment_unnamed_59.z);
						fragment_unnamed_59.z = fragment_unnamed_189.y;
					}
					fragment_unnamed_189 = float3(fragment_unnamed_189.x, fragment_unnamed_59.xz.x, fragment_unnamed_59.xz.y);
					float2 fragment_unnamed_252 = (fragment_unnamed_189.xz * float2(0.5f, -2.0f)) + float2(0.5234375f, 2.03125f);
					fragment_unnamed_59 = float3(fragment_unnamed_252.x, fragment_unnamed_252.y, fragment_unnamed_59.z);
					fragment_unnamed_255 = _SearchTex.SampleLevel(sampler_MainTex, fragment_unnamed_59.xy, 0.0f).w;
					fragment_unnamed_255 = (fragment_unnamed_255 * (-2.007874011993408203125f)) + 3.25f;
					fragment_unnamed_46.z = ((-_MainTex_TexelSize.x) * fragment_unnamed_255) + fragment_unnamed_189.y;
					float2 fragment_unnamed_285 = (_MainTex_TexelSize.zz * fragment_unnamed_46.xz) + (-fragment_input_1.xx);
					fragment_unnamed_46 = float4(fragment_unnamed_285.x, fragment_unnamed_46.y, fragment_unnamed_46.z, fragment_unnamed_285.y);
					float2 fragment_unnamed_290 = round(fragment_unnamed_46.xw);
					fragment_unnamed_46 = float4(fragment_unnamed_290.x, fragment_unnamed_46.y, fragment_unnamed_46.z, fragment_unnamed_290.y);
					float2 fragment_unnamed_296 = sqrt(abs(fragment_unnamed_46.xw));
					fragment_unnamed_46 = float4(fragment_unnamed_296.x, fragment_unnamed_46.y, fragment_unnamed_46.z, fragment_unnamed_296.y);
					fragment_unnamed_9.z = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_46.zy, 0.0f, int2(1, 0)).x;
					float2 fragment_unnamed_314 = fragment_unnamed_9.xz * 4.0f.xx;
					fragment_unnamed_9 = float4(fragment_unnamed_314.x, fragment_unnamed_9.y, fragment_unnamed_314.y, fragment_unnamed_9.w);
					float2 fragment_unnamed_319 = round(fragment_unnamed_9.xz);
					fragment_unnamed_9 = float4(fragment_unnamed_319.x, fragment_unnamed_9.y, fragment_unnamed_319.y, fragment_unnamed_9.w);
					float2 fragment_unnamed_329 = (fragment_unnamed_9.xz * 16.0f.xx) + fragment_unnamed_46.xw;
					fragment_unnamed_9 = float4(fragment_unnamed_329.x, fragment_unnamed_9.y, fragment_unnamed_329.y, fragment_unnamed_9.w);
					float2 fragment_unnamed_341 = (fragment_unnamed_9.xz * float2(0.0062500000931322574615478515625f, 0.001785714295692741870880126953125f)) + float2(0.00312500004656612873077392578125f, 0.0008928571478463709354400634765625f);
					fragment_unnamed_9 = float4(fragment_unnamed_341.x, fragment_unnamed_9.y, fragment_unnamed_341.y, fragment_unnamed_9.w);
					float2 fragment_unnamed_351 = _AreaTex.SampleLevel(sampler_MainTex, fragment_unnamed_9.xz, 0.0f).xy;
					fragment_unnamed_9 = float4(fragment_unnamed_351.x, fragment_unnamed_9.y, fragment_unnamed_351.y, fragment_unnamed_9.w);
					fragment_output_0 = float4(fragment_unnamed_9.xz.x, fragment_unnamed_9.xz.y, fragment_output_0.z, fragment_output_0.w);
				}
				else
				{
					fragment_output_0 = float4(0.0f.xx.x, 0.0f.xx.y, fragment_output_0.z, fragment_output_0.w);
				}
				if (fragment_unnamed_31.y)
				{
					fragment_unnamed_9 = float4(fragment_input_3.xy.x, fragment_input_3.xy.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
					fragment_unnamed_9.z = 1.0f;
					fragment_unnamed_46.x = 0.0f;
					while (true)
					{
						fragment_unnamed_196 = fragment_input_4.z < fragment_unnamed_9.y;
						fragment_unnamed_202 = 0.828100025653839111328125f < fragment_unnamed_9.z;
						fragment_unnamed_196 = fragment_unnamed_196 && fragment_unnamed_202;
						fragment_unnamed_202 = fragment_unnamed_46.x == 0.0f;
						fragment_unnamed_196 = fragment_unnamed_196 && fragment_unnamed_202;
						if (!fragment_unnamed_196)
						{
							break;
						}
						float2 fragment_unnamed_407 = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_9.xy, 0.0f).yx;
						fragment_unnamed_46 = float4(fragment_unnamed_407.x, fragment_unnamed_407.y, fragment_unnamed_46.z, fragment_unnamed_46.w);
						float2 fragment_unnamed_417 = (_MainTex_TexelSize.xy * float2(-0.0f, -2.0f)) + fragment_unnamed_9.xy;
						fragment_unnamed_9 = float4(fragment_unnamed_417.x, fragment_unnamed_417.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
						fragment_unnamed_9.z = fragment_unnamed_46.y;
					}
					fragment_unnamed_46 = float4(fragment_unnamed_46.x, fragment_unnamed_9.yz.x, fragment_unnamed_9.yz.y, fragment_unnamed_46.w);
					float2 fragment_unnamed_430 = (fragment_unnamed_46.xz * float2(0.5f, -2.0f)) + float2(0.0078125f, 2.03125f);
					fragment_unnamed_9 = float4(fragment_unnamed_430.x, fragment_unnamed_430.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
					fragment_unnamed_9.x = _SearchTex.SampleLevel(sampler_MainTex, fragment_unnamed_9.xy, 0.0f).w;
					fragment_unnamed_9.x = (fragment_unnamed_9.x * (-2.007874011993408203125f)) + 3.25f;
					fragment_unnamed_9.x = (_MainTex_TexelSize.y * fragment_unnamed_9.x) + fragment_unnamed_46.y;
					fragment_unnamed_9.y = fragment_input_2.x;
					fragment_unnamed_46.x = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_9.yx, 0.0f).y;
					fragment_unnamed_59 = float3(fragment_input_3.zw.x, fragment_input_3.zw.y, fragment_unnamed_59.z);
					fragment_unnamed_59.z = 1.0f;
					fragment_unnamed_189.x = 0.0f;
					while (true)
					{
						fragment_unnamed_196 = fragment_unnamed_59.y < fragment_input_4.w;
						fragment_unnamed_482 = 0.828100025653839111328125f < fragment_unnamed_59.z;
						fragment_unnamed_196 = fragment_unnamed_196 && fragment_unnamed_482;
						fragment_unnamed_482 = fragment_unnamed_189.x == 0.0f;
						fragment_unnamed_196 = fragment_unnamed_196 && fragment_unnamed_482;
						if (!fragment_unnamed_196)
						{
							break;
						}
						float2 fragment_unnamed_506 = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_59.xy, 0.0f).yx;
						fragment_unnamed_189 = float3(fragment_unnamed_506.x, fragment_unnamed_506.y, fragment_unnamed_189.z);
						float2 fragment_unnamed_516 = (_MainTex_TexelSize.xy * float2(0.0f, 2.0f)) + fragment_unnamed_59.xy;
						fragment_unnamed_59 = float3(fragment_unnamed_516.x, fragment_unnamed_516.y, fragment_unnamed_59.z);
						fragment_unnamed_59.z = fragment_unnamed_189.y;
					}
					fragment_unnamed_189 = float3(fragment_unnamed_189.x, fragment_unnamed_59.yz.x, fragment_unnamed_59.yz.y);
					fragment_unnamed_527 = (fragment_unnamed_189.xz * float2(0.5f, -2.0f)) + float2(0.5234375f, 2.03125f);
					fragment_unnamed_255 = _SearchTex.SampleLevel(sampler_MainTex, fragment_unnamed_527, 0.0f).w;
					fragment_unnamed_255 = (fragment_unnamed_255 * (-2.007874011993408203125f)) + 3.25f;
					fragment_unnamed_9.z = ((-_MainTex_TexelSize.y) * fragment_unnamed_255) + fragment_unnamed_189.y;
					float2 fragment_unnamed_559 = (_MainTex_TexelSize.ww * fragment_unnamed_9.xz) + (-fragment_input_1.yy);
					fragment_unnamed_9 = float4(fragment_unnamed_559.x, fragment_unnamed_9.y, fragment_unnamed_9.z, fragment_unnamed_559.y);
					float2 fragment_unnamed_564 = round(fragment_unnamed_9.xw);
					fragment_unnamed_9 = float4(fragment_unnamed_564.x, fragment_unnamed_9.y, fragment_unnamed_9.z, fragment_unnamed_564.y);
					float2 fragment_unnamed_570 = sqrt(abs(fragment_unnamed_9.xw));
					fragment_unnamed_9 = float4(fragment_unnamed_570.x, fragment_unnamed_9.y, fragment_unnamed_9.z, fragment_unnamed_570.y);
					fragment_unnamed_46.y = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_9.yz, 0.0f, int2(0, 1)).y;
					fragment_unnamed_582 = fragment_unnamed_46.xy * 4.0f.xx;
					fragment_unnamed_582 = round(fragment_unnamed_582);
					float2 fragment_unnamed_592 = (fragment_unnamed_582 * 16.0f.xx) + fragment_unnamed_9.xw;
					fragment_unnamed_9 = float4(fragment_unnamed_592.x, fragment_unnamed_592.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
					float2 fragment_unnamed_598 = (fragment_unnamed_9.xy * float2(0.0062500000931322574615478515625f, 0.001785714295692741870880126953125f)) + float2(0.00312500004656612873077392578125f, 0.0008928571478463709354400634765625f);
					fragment_unnamed_9 = float4(fragment_unnamed_598.x, fragment_unnamed_598.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
					float2 fragment_unnamed_607 = _AreaTex.SampleLevel(sampler_MainTex, fragment_unnamed_9.xy, 0.0f).xy;
					fragment_unnamed_9 = float4(fragment_unnamed_607.x, fragment_unnamed_607.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
					fragment_output_0 = float4(fragment_output_0.x, fragment_output_0.y, fragment_unnamed_9.xy.x, fragment_unnamed_9.xy.y);
				}
				else
				{
					fragment_output_0 = float4(fragment_output_0.x, fragment_output_0.y, 0.0f.xx.x, 0.0f.xx.y);
				}
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_0 = stage_input.fragment_input_0;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			float4 _MainTex_TexelSize;

			static float4 fragment_uniform_buffer_0[29];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _AreaTex;
			Texture2D<float4> _SearchTex;
			SamplerState sampler_MainTex;

			static float2 fragment_input_1;
			static float2 fragment_input_1;
			static float4 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD; // TEXCOORD
				float2 fragment_input_1 : TEXCOORD1; // TEXCOORD_1
				float4 fragment_input_2 : TEXCOORD2; // TEXCOORD_2
				float4 fragment_input_3 : TEXCOORD3; // TEXCOORD_3
				float4 fragment_input_4 : TEXCOORD4; // TEXCOORD_4
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				float4 fragment_unnamed_46 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				if (0.0f < fragment_unnamed_46.y)
				{
					float fragment_unnamed_63;
					float fragment_unnamed_67;
					float fragment_unnamed_69;
					fragment_unnamed_63 = fragment_input_2.x;
					fragment_unnamed_67 = asfloat(1065353216u);
					fragment_unnamed_69 = asfloat(0u);
					float4 fragment_unnamed_119;
					float2 fragment_unnamed_120;
					for (float fragment_unnamed_65 = fragment_input_2.y; !((((fragment_unnamed_69 == 0.0f) ? 4294967295u : 0u) & (((0.828100025653839111328125f < fragment_unnamed_67) ? 4294967295u : 0u) & ((fragment_input_4.x < fragment_unnamed_63) ? 4294967295u : 0u))) == 0u); fragment_unnamed_120 = float2(fragment_unnamed_63, fragment_unnamed_65), fragment_unnamed_119 = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_120, 0.0f), fragment_unnamed_63 = mad(fragment_uniform_buffer_0[28u].x, -2.0f, fragment_unnamed_63), fragment_unnamed_65 = mad(fragment_uniform_buffer_0[28u].y, -0.0f, fragment_unnamed_65), fragment_unnamed_67 = fragment_unnamed_119.y, fragment_unnamed_69 = fragment_unnamed_119.x)
					{
					}
					float fragment_unnamed_103 = mad(fragment_uniform_buffer_0[28u].x, mad(_SearchTex.SampleLevel(sampler_MainTex, float2(mad(fragment_unnamed_69, 0.5f, 0.0078125f), mad(fragment_unnamed_67, -2.0f, 2.03125f)), 0.0f).w, -2.007874011993408203125f, 3.25f), fragment_unnamed_63);
					float fragment_unnamed_134;
					float fragment_unnamed_138;
					float fragment_unnamed_140;
					fragment_unnamed_134 = fragment_input_2.z;
					fragment_unnamed_138 = asfloat(1065353216u);
					fragment_unnamed_140 = asfloat(0u);
					float4 fragment_unnamed_230;
					float2 fragment_unnamed_231;
					for (float fragment_unnamed_136 = fragment_input_2.w; !((((fragment_unnamed_140 == 0.0f) ? 4294967295u : 0u) & (((0.828100025653839111328125f < fragment_unnamed_138) ? 4294967295u : 0u) & ((fragment_unnamed_134 < fragment_input_4.y) ? 4294967295u : 0u))) == 0u); fragment_unnamed_231 = float2(fragment_unnamed_134, fragment_unnamed_136), fragment_unnamed_230 = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_231, 0.0f), fragment_unnamed_134 = mad(fragment_uniform_buffer_0[28u].x, 2.0f, fragment_unnamed_134), fragment_unnamed_136 = mad(fragment_uniform_buffer_0[28u].y, 0.0f, fragment_unnamed_136), fragment_unnamed_138 = fragment_unnamed_230.y, fragment_unnamed_140 = fragment_unnamed_230.x)
					{
					}
					precise float fragment_unnamed_183 = (-0.0f) - fragment_uniform_buffer_0[28u].x;
					float fragment_unnamed_184 = mad(fragment_unnamed_183, mad(_SearchTex.SampleLevel(sampler_MainTex, float2(mad(fragment_unnamed_140, 0.5f, 0.5234375f), mad(fragment_unnamed_138, -2.0f, 2.03125f)), 0.0f).w, -2.007874011993408203125f, 3.25f), fragment_unnamed_134);
					precise float fragment_unnamed_190 = (-0.0f) - fragment_input_1.x;
					precise float fragment_unnamed_208 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_103, fragment_input_3.y), 0.0f).x * 4.0f;
					precise float fragment_unnamed_210 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_184, fragment_input_3.y), 0.0f, int2(1, 0)).x * 4.0f;
					float4 fragment_unnamed_223 = _AreaTex.SampleLevel(sampler_MainTex, float2(mad(mad(round(fragment_unnamed_208), 16.0f, sqrt(abs(round(mad(fragment_uniform_buffer_0[28u].z, fragment_unnamed_103, fragment_unnamed_190))))), 0.0062500000931322574615478515625f, 0.00312500004656612873077392578125f), mad(mad(round(fragment_unnamed_210), 16.0f, sqrt(abs(round(mad(fragment_uniform_buffer_0[28u].z, fragment_unnamed_184, fragment_unnamed_190))))), 0.001785714295692741870880126953125f, 0.0008928571478463709354400634765625f)), 0.0f);
					fragment_output_0.x = fragment_unnamed_223.x;
					fragment_output_0.y = fragment_unnamed_223.y;
				}
				else
				{
					fragment_output_0.x = 0.0f;
					fragment_output_0.y = 0.0f;
				}
				if (0.0f < fragment_unnamed_46.x)
				{
					float fragment_unnamed_153;
					float fragment_unnamed_155;
					float fragment_unnamed_157;
					fragment_unnamed_153 = fragment_input_3.y;
					fragment_unnamed_155 = asfloat(1065353216u);
					fragment_unnamed_157 = asfloat(0u);
					float4 fragment_unnamed_261;
					float2 fragment_unnamed_262;
					for (float fragment_unnamed_159 = fragment_input_3.x; !(((((fragment_input_4.z < fragment_unnamed_153) ? 4294967295u : 0u) & ((0.828100025653839111328125f < fragment_unnamed_155) ? 4294967295u : 0u)) & ((fragment_unnamed_157 == 0.0f) ? 4294967295u : 0u)) == 0u); fragment_unnamed_262 = float2(fragment_unnamed_159, fragment_unnamed_153), fragment_unnamed_261 = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_262, 0.0f), fragment_unnamed_153 = mad(fragment_uniform_buffer_0[28u].y, -2.0f, fragment_unnamed_153), fragment_unnamed_155 = fragment_unnamed_261.x, fragment_unnamed_157 = fragment_unnamed_261.y, fragment_unnamed_159 = mad(fragment_uniform_buffer_0[28u].x, -0.0f, fragment_unnamed_159))
					{
					}
					float fragment_unnamed_247 = mad(fragment_uniform_buffer_0[28u].y, mad(_SearchTex.SampleLevel(sampler_MainTex, float2(mad(fragment_unnamed_157, 0.5f, 0.0078125f), mad(fragment_unnamed_155, -2.0f, 2.03125f)), 0.0f).w, -2.007874011993408203125f, 3.25f), fragment_unnamed_153);
					float fragment_unnamed_269;
					float fragment_unnamed_271;
					float fragment_unnamed_273;
					fragment_unnamed_269 = fragment_input_3.w;
					fragment_unnamed_271 = asfloat(1065353216u);
					fragment_unnamed_273 = asfloat(0u);
					float4 fragment_unnamed_333;
					float2 fragment_unnamed_334;
					for (float fragment_unnamed_267 = fragment_input_3.z; !(((((fragment_unnamed_269 < fragment_input_4.w) ? 4294967295u : 0u) & ((0.828100025653839111328125f < fragment_unnamed_271) ? 4294967295u : 0u)) & ((fragment_unnamed_273 == 0.0f) ? 4294967295u : 0u)) == 0u); fragment_unnamed_334 = float2(fragment_unnamed_267, fragment_unnamed_269), fragment_unnamed_333 = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_334, 0.0f), fragment_unnamed_267 = mad(fragment_uniform_buffer_0[28u].x, 0.0f, fragment_unnamed_267), fragment_unnamed_269 = mad(fragment_uniform_buffer_0[28u].y, 2.0f, fragment_unnamed_269), fragment_unnamed_271 = fragment_unnamed_333.x, fragment_unnamed_273 = fragment_unnamed_333.y)
					{
					}
					precise float fragment_unnamed_296 = (-0.0f) - fragment_uniform_buffer_0[28u].y;
					float fragment_unnamed_297 = mad(fragment_unnamed_296, mad(_SearchTex.SampleLevel(sampler_MainTex, float2(mad(fragment_unnamed_273, 0.5f, 0.5234375f), mad(fragment_unnamed_271, -2.0f, 2.03125f)), 0.0f).w, -2.007874011993408203125f, 3.25f), fragment_unnamed_269);
					precise float fragment_unnamed_303 = (-0.0f) - fragment_input_1.y;
					precise float fragment_unnamed_317 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_input_2.x, fragment_unnamed_247), 0.0f).y * 4.0f;
					precise float fragment_unnamed_318 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_input_2.x, fragment_unnamed_297), 0.0f, int2(0, 1)).y * 4.0f;
					float4 fragment_unnamed_326 = _AreaTex.SampleLevel(sampler_MainTex, float2(mad(mad(round(fragment_unnamed_317), 16.0f, sqrt(abs(round(mad(fragment_uniform_buffer_0[28u].w, fragment_unnamed_247, fragment_unnamed_303))))), 0.0062500000931322574615478515625f, 0.00312500004656612873077392578125f), mad(mad(round(fragment_unnamed_318), 16.0f, sqrt(abs(round(mad(fragment_uniform_buffer_0[28u].w, fragment_unnamed_297, fragment_unnamed_303))))), 0.001785714295692741870880126953125f, 0.0008928571478463709354400634765625f)), 0.0f);
					fragment_output_0.z = fragment_unnamed_326.x;
					fragment_output_0.w = fragment_unnamed_326.y;
				}
				else
				{
					fragment_output_0.z = 0.0f;
					fragment_output_0.w = 0.0f;
				}
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[28] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
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
			GpuProgramID 369268

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.0


			float4 _MainTex_TexelSize;

			static float4 vertex_uniform_buffer_0[29];
			static float4 gl_Position;
			static float3 vertex_input_0;
			static float2 vertex_output_1;
			static float2 vertex_output_1;
			static float4 vertex_output_2;
			static float4 vertex_output_3;
			static float4 vertex_output_4;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				float2 vertex_output_1 : TEXCOORD1; // TEXCOORD_1
				float4 vertex_output_2 : TEXCOORD2; // TEXCOORD_2
				float4 vertex_output_3 : TEXCOORD3; // TEXCOORD_3
				float4 vertex_output_4 : TEXCOORD4; // TEXCOORD_4
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				gl_Position.x = vertex_input_0.x;
				gl_Position.y = vertex_input_0.y;
				gl_Position.z = 0.0f;
				gl_Position.w = 1.0f;
				vertex_output_1.x = mad(vertex_input_0.x, 0.5f, 0.5f);
				vertex_output_1.y = mad(vertex_input_0.y, -0.5f, 0.5f);
				precise float vertex_unnamed_56 = vertex_input_0.x + 1.0f;
				precise float vertex_unnamed_57 = vertex_input_0.y + 1.0f;
				precise float vertex_unnamed_58 = vertex_input_0.x + 1.0f;
				precise float vertex_unnamed_59 = vertex_input_0.y + 1.0f;
				float vertex_unnamed_62 = mad(vertex_unnamed_58, 0.5f, 0.0f);
				float vertex_unnamed_63 = mad(vertex_unnamed_59, -0.5f, 1.0f);
				precise float vertex_unnamed_70 = vertex_unnamed_62 * vertex_uniform_buffer_0[28u].z;
				precise float vertex_unnamed_71 = vertex_unnamed_63 * vertex_uniform_buffer_0[28u].w;
				vertex_output_1.x = vertex_unnamed_70;
				vertex_output_1.y = vertex_unnamed_71;
				float vertex_unnamed_78 = mad(vertex_uniform_buffer_0[28u].x, -0.25f, vertex_unnamed_62);
				float vertex_unnamed_80 = mad(vertex_uniform_buffer_0[28u].x, 1.25f, vertex_unnamed_62);
				float vertex_unnamed_90 = mad(vertex_uniform_buffer_0[28u].y, -0.25f, mad(vertex_unnamed_57, -0.5f, 1.0f));
				float vertex_unnamed_92 = mad(vertex_uniform_buffer_0[28u].y, 1.25f, vertex_unnamed_63);
				vertex_output_2.x = vertex_unnamed_78;
				vertex_output_2.y = mad(vertex_uniform_buffer_0[28u].y, -0.125f, vertex_unnamed_63);
				vertex_output_2.z = vertex_unnamed_80;
				vertex_output_2.w = mad(vertex_uniform_buffer_0[28u].y, -0.125f, vertex_unnamed_63);
				vertex_output_3.x = mad(vertex_uniform_buffer_0[28u].x, -0.125f, mad(vertex_unnamed_56, 0.5f, 0.0f));
				vertex_output_3.y = vertex_unnamed_90;
				vertex_output_3.z = mad(vertex_uniform_buffer_0[28u].x, -0.125f, vertex_unnamed_62);
				vertex_output_3.w = vertex_unnamed_92;
				vertex_output_4.x = mad(vertex_uniform_buffer_0[28u].x, -32.0f, vertex_unnamed_78);
				vertex_output_4.y = mad(vertex_uniform_buffer_0[28u].x, 32.0f, vertex_unnamed_80);
				vertex_output_4.z = mad(vertex_uniform_buffer_0[28u].y, -32.0f, vertex_unnamed_90);
				vertex_output_4.w = mad(vertex_uniform_buffer_0[28u].y, 32.0f, vertex_unnamed_92);
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[28] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				return stage_output;
			}


			float4 _MainTex_TexelSize;

			static float4 gl_Position;
			static float3 vertex_input_0;
			static float2 vertex_output_0;
			static float2 vertex_output_1;
			static float4 vertex_output_2;
			static float4 vertex_output_3;
			static float4 vertex_output_4;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION;
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_0 : TEXCOORD0; // vs_TEXCOORD0
				float2 vertex_output_1 : TEXCOORD1; // vs_TEXCOORD1
				float4 vertex_output_2 : TEXCOORD2; // vs_TEXCOORD2
				float4 vertex_output_3 : TEXCOORD3; // vs_TEXCOORD3
				float4 vertex_output_4 : TEXCOORD4; // vs_TEXCOORD4
				float4 gl_Position : SV_Position;
			};

			static float4 vertex_unnamed_43;
			static float4 vertex_unnamed_64;

			void vert_main()
			{
				gl_Position = float4(vertex_input_0.xy.x, vertex_input_0.xy.y, gl_Position.z, gl_Position.w);
				gl_Position = float4(gl_Position.x, gl_Position.y, float2(0.0f, 1.0f).x, float2(0.0f, 1.0f).y);
				vertex_output_0 = (vertex_input_0.xy * float2(0.5f, -0.5f)) + 0.5f.xx;
				vertex_unnamed_43 = vertex_input_0.xyxy + 1.0f.xxxx;
				vertex_unnamed_43 = (vertex_unnamed_43 * float4(0.5f, -0.5f, 0.5f, -0.5f)) + float4(0.0f, 1.0f, 0.0f, 1.0f);
				vertex_output_1 = vertex_unnamed_43.zw * _MainTex_TexelSize.zw;
				vertex_unnamed_64 = (_MainTex_TexelSize.xxyy * float4(-0.25f, 1.25f, -0.125f, -0.125f)) + vertex_unnamed_43.zzww;
				vertex_unnamed_43 = (_MainTex_TexelSize.xyxy * float4(-0.125f, -0.25f, -0.125f, 1.25f)) + vertex_unnamed_43;
				vertex_output_2 = vertex_unnamed_64.xzyw;
				vertex_output_3 = vertex_unnamed_43;
				vertex_unnamed_64 = float4(vertex_unnamed_64.x, vertex_unnamed_64.y, vertex_unnamed_43.yw.x, vertex_unnamed_43.yw.y);
				vertex_output_4 = (_MainTex_TexelSize.xxyy * float4(-32.0f, 32.0f, -32.0f, 32.0f)) + vertex_unnamed_64;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_0 = vertex_output_0;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				return stage_output;
			}

			float4 _MainTex_TexelSize;

			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;
			Texture2D<float4> _AreaTex;
			Texture2D<float4> _SearchTex;

			static float2 fragment_input_0;
			static float4 fragment_input_2;
			static float4 fragment_input_4;
			static float4 fragment_input_3;
			static float2 fragment_input_1;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_0 : TEXCOORD0; // vs_TEXCOORD0
				float2 fragment_input_1 : TEXCOORD1; // vs_TEXCOORD1
				float4 fragment_input_2 : TEXCOORD2; // vs_TEXCOORD2
				float4 fragment_input_3 : TEXCOORD3; // vs_TEXCOORD3
				float4 fragment_input_4 : TEXCOORD4; // vs_TEXCOORD4
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static float4 fragment_unnamed_9;
			static bool fragment_unnamed_30;
			static float4 fragment_unnamed_48;
			static float4 fragment_unnamed_66;
			static float3 fragment_unnamed_72;
			static float4 fragment_unnamed_75;
			static bool fragment_unnamed_83;
			static bool fragment_unnamed_88;
			static float fragment_unnamed_150;
			static bool fragment_unnamed_156;
			static bool fragment_unnamed_160;
			static float2 fragment_unnamed_179;
			static float3 fragment_unnamed_239;
			static float3 fragment_unnamed_277;
			static bool3 fragment_unnamed_297;
			static float fragment_unnamed_367;
			static bool4 fragment_unnamed_399;
			static float fragment_unnamed_426;
			static float4 fragment_unnamed_436;
			static float2 fragment_unnamed_475;
			static float2 fragment_unnamed_503;
			static bool4 fragment_unnamed_601;
			static bool fragment_unnamed_796;
			static bool fragment_unnamed_1055;
			static bool fragment_unnamed_1171;
			static float2 fragment_unnamed_1220;

			void frag_main()
			{
				float2 fragment_unnamed_25 = _MainTex.Sample(sampler_MainTex, fragment_input_0).xy;
				fragment_unnamed_9 = float4(fragment_unnamed_25.x, fragment_unnamed_25.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
				fragment_unnamed_30 = 0.0f < fragment_unnamed_9.y;
				if (fragment_unnamed_30)
				{
					fragment_unnamed_30 = 0.0f < fragment_unnamed_9.x;
					if (fragment_unnamed_30)
					{
						float2 fragment_unnamed_61 = _MainTex_TexelSize.xy * float2(-1.0f, 1.0f);
						fragment_unnamed_48 = float4(fragment_unnamed_61.x, fragment_unnamed_61.y, fragment_unnamed_48.z, fragment_unnamed_48.w);
						fragment_unnamed_48.z = 1.0f;
						fragment_unnamed_66 = float4(fragment_input_0.x, fragment_input_0.y, fragment_unnamed_66.z, fragment_unnamed_66.w);
						fragment_unnamed_72.x = 0.0f;
						fragment_unnamed_66.z = -1.0f;
						fragment_unnamed_75.x = 1.0f;
						while (true)
						{
							fragment_unnamed_83 = fragment_unnamed_66.z < 7.0f;
							fragment_unnamed_88 = 0.89999997615814208984375f < fragment_unnamed_75.x;
							fragment_unnamed_83 = fragment_unnamed_83 && fragment_unnamed_88;
							if (!fragment_unnamed_83)
							{
								break;
							}
							float3 fragment_unnamed_105 = fragment_unnamed_48.xyz + fragment_unnamed_66.xyz;
							fragment_unnamed_66 = float4(fragment_unnamed_105.x, fragment_unnamed_105.y, fragment_unnamed_105.z, fragment_unnamed_66.w);
							float2 fragment_unnamed_114 = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_66.xy, 0.0f).yx;
							fragment_unnamed_72 = float3(fragment_unnamed_114.x, fragment_unnamed_114.y, fragment_unnamed_72.z);
							fragment_unnamed_75.x = dot(fragment_unnamed_72.yx, 0.5f.xx);
						}
						fragment_unnamed_30 = 0.89999997615814208984375f < fragment_unnamed_72.x;
						fragment_unnamed_72.x = float(fragment_unnamed_30);
						fragment_unnamed_48.x = fragment_unnamed_72.x + fragment_unnamed_66.z;
					}
					else
					{
						fragment_unnamed_48.x = 0.0f;
						fragment_unnamed_75.x = 0.0f;
					}
					float2 fragment_unnamed_142 = _MainTex_TexelSize.xy * float2(1.0f, -1.0f);
					fragment_unnamed_72 = float3(fragment_unnamed_142.x, fragment_unnamed_142.y, fragment_unnamed_72.z);
					fragment_unnamed_72.z = 1.0f;
					fragment_unnamed_66 = float4(fragment_unnamed_66.x, fragment_input_0.x, fragment_input_0.y, fragment_unnamed_66.w);
					fragment_unnamed_66.x = -1.0f;
					fragment_unnamed_150 = 1.0f;
					while (true)
					{
						fragment_unnamed_156 = fragment_unnamed_66.x < 7.0f;
						fragment_unnamed_160 = 0.89999997615814208984375f < fragment_unnamed_150;
						fragment_unnamed_156 = fragment_unnamed_160 && fragment_unnamed_156;
						if (!fragment_unnamed_156)
						{
							break;
						}
						float3 fragment_unnamed_175 = fragment_unnamed_72.zxy + fragment_unnamed_66.xyz;
						fragment_unnamed_66 = float4(fragment_unnamed_175.x, fragment_unnamed_175.y, fragment_unnamed_175.z, fragment_unnamed_66.w);
						fragment_unnamed_179 = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_66.yz, 0.0f).xy;
						fragment_unnamed_150 = dot(fragment_unnamed_179, 0.5f.xx);
					}
					fragment_unnamed_75.y = fragment_unnamed_150;
					fragment_unnamed_72.x = fragment_unnamed_48.x + fragment_unnamed_66.x;
					fragment_unnamed_30 = 2.0f < fragment_unnamed_72.x;
					if (fragment_unnamed_30)
					{
						fragment_unnamed_48.y = (-fragment_unnamed_48.x) + 0.25f;
						float2 fragment_unnamed_215 = (fragment_unnamed_66.xx * float2(1.0f, -1.0f)) + float2(0.0f, -0.25f);
						fragment_unnamed_48 = float4(fragment_unnamed_48.x, fragment_unnamed_48.y, fragment_unnamed_215.x, fragment_unnamed_215.y);
						fragment_unnamed_66 = (fragment_unnamed_48.yxzw * _MainTex_TexelSize.xyxy) + fragment_input_0.xyxy;
						float2 fragment_unnamed_236 = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_66.xy, 0.0f, int2(-1, 0)).xy;
						fragment_unnamed_72 = float3(fragment_unnamed_236.x, fragment_unnamed_236.y, fragment_unnamed_72.z);
						float2 fragment_unnamed_248 = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_66.zw, 0.0f, int2(1, 0)).xy;
						fragment_unnamed_239 = float3(fragment_unnamed_248.x, fragment_unnamed_239.y, fragment_unnamed_248.y);
						fragment_unnamed_72.z = fragment_unnamed_239.x;
						float2 fragment_unnamed_261 = (fragment_unnamed_72.xz * 5.0f.xx) + (-3.75f).xx;
						fragment_unnamed_66 = float4(fragment_unnamed_261.x, fragment_unnamed_261.y, fragment_unnamed_66.z, fragment_unnamed_66.w);
						float2 fragment_unnamed_269 = fragment_unnamed_72.xz * abs(fragment_unnamed_66.xy);
						fragment_unnamed_72 = float3(fragment_unnamed_269.x, fragment_unnamed_72.y, fragment_unnamed_269.y);
						float2 fragment_unnamed_274 = round(fragment_unnamed_72.xz);
						fragment_unnamed_72 = float3(fragment_unnamed_274.x, fragment_unnamed_72.y, fragment_unnamed_274.y);
						fragment_unnamed_277.x = round(fragment_unnamed_72.y);
						fragment_unnamed_277.z = round(fragment_unnamed_239.z);
						float2 fragment_unnamed_292 = (fragment_unnamed_277.xz * 2.0f.xx) + fragment_unnamed_72.xz;
						fragment_unnamed_72 = float3(fragment_unnamed_292.x, fragment_unnamed_292.y, fragment_unnamed_72.z);
						bool2 fragment_unnamed_304 = bool4(fragment_unnamed_75.xxyy.x >= float4(0.89999997615814208984375f, 0.0f, 0.89999997615814208984375f, 0.89999997615814208984375f).x, fragment_unnamed_75.xxyy.y >= float4(0.89999997615814208984375f, 0.0f, 0.89999997615814208984375f, 0.89999997615814208984375f).y, fragment_unnamed_75.xxyy.z >= float4(0.89999997615814208984375f, 0.0f, 0.89999997615814208984375f, 0.89999997615814208984375f).z, fragment_unnamed_75.xxyy.w >= float4(0.89999997615814208984375f, 0.0f, 0.89999997615814208984375f, 0.89999997615814208984375f).w).xz;
						fragment_unnamed_297 = bool3(fragment_unnamed_304.x, fragment_unnamed_297.y, fragment_unnamed_304.y);
						float3 fragment_unnamed_308 = fragment_unnamed_72;
						float fragment_unnamed_313;
						if (fragment_unnamed_297.x)
						{
							fragment_unnamed_313 = 0.0f;
						}
						else
						{
							fragment_unnamed_313 = fragment_unnamed_72.x;
						}
						fragment_unnamed_308.x = fragment_unnamed_313;
						float fragment_unnamed_323;
						if (fragment_unnamed_297.z)
						{
							fragment_unnamed_323 = 0.0f;
						}
						else
						{
							fragment_unnamed_323 = fragment_unnamed_72.y;
						}
						fragment_unnamed_308.y = fragment_unnamed_323;
						fragment_unnamed_72 = fragment_unnamed_308;
						float2 fragment_unnamed_339 = (fragment_unnamed_72.xy * 20.0f.xx) + fragment_unnamed_48.xz;
						fragment_unnamed_72 = float3(fragment_unnamed_339.x, fragment_unnamed_339.y, fragment_unnamed_72.z);
						float2 fragment_unnamed_351 = (fragment_unnamed_72.xy * float2(0.0062500000931322574615478515625f, 0.001785714295692741870880126953125f)) + float2(0.503125011920928955078125f, 0.0008928571478463709354400634765625f);
						fragment_unnamed_72 = float3(fragment_unnamed_351.x, fragment_unnamed_351.y, fragment_unnamed_72.z);
						float2 fragment_unnamed_361 = _AreaTex.SampleLevel(sampler_MainTex, fragment_unnamed_72.xy, 0.0f).xy;
						fragment_unnamed_72 = float3(fragment_unnamed_361.x, fragment_unnamed_361.y, fragment_unnamed_72.z);
					}
					else
					{
						fragment_unnamed_72.x = 0.0f;
						fragment_unnamed_72.y = 0.0f;
					}
					fragment_unnamed_367 = (_MainTex_TexelSize.x * 0.25f) + fragment_input_0.x;
					float2 fragment_unnamed_379 = -_MainTex_TexelSize.xy;
					fragment_unnamed_48 = float4(fragment_unnamed_379.x, fragment_unnamed_379.y, fragment_unnamed_48.z, fragment_unnamed_48.w);
					fragment_unnamed_48.z = 1.0f;
					fragment_unnamed_277.x = fragment_unnamed_367;
					fragment_unnamed_277.y = fragment_input_0.y;
					fragment_unnamed_66.x = 1.0f;
					fragment_unnamed_277.z = -1.0f;
					while (true)
					{
						fragment_unnamed_88 = fragment_unnamed_277.z < 7.0f;
						fragment_unnamed_399.x = 0.89999997615814208984375f < fragment_unnamed_66.x;
						fragment_unnamed_88 = fragment_unnamed_88 && fragment_unnamed_399.x;
						if (!fragment_unnamed_88)
						{
							break;
						}
						fragment_unnamed_277 = fragment_unnamed_48.xyz + fragment_unnamed_277;
						float2 fragment_unnamed_423 = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_277.xy, 0.0f).xy;
						fragment_unnamed_75 = float4(fragment_unnamed_423.x, fragment_unnamed_423.y, fragment_unnamed_75.z, fragment_unnamed_75.w);
						fragment_unnamed_426 = (fragment_unnamed_75.x * 5.0f) + (-3.75f);
						fragment_unnamed_426 = abs(fragment_unnamed_426) * fragment_unnamed_75.x;
						fragment_unnamed_436.x = round(fragment_unnamed_426);
						fragment_unnamed_436.y = round(fragment_unnamed_75.y);
						fragment_unnamed_66.x = dot(fragment_unnamed_436.xy, 0.5f.xx);
					}
					fragment_unnamed_48.x = fragment_unnamed_277.z;
					fragment_unnamed_426 = _MainTex.SampleLevel(sampler_MainTex, fragment_input_0, 0.0f, int2(1, 0)).x;
					fragment_unnamed_88 = 0.0f < fragment_unnamed_426;
					if (fragment_unnamed_88)
					{
						fragment_unnamed_75 = float4(_MainTex_TexelSize.xy.x, _MainTex_TexelSize.xy.y, fragment_unnamed_75.z, fragment_unnamed_75.w);
						fragment_unnamed_75.z = 1.0f;
						fragment_unnamed_436.x = fragment_unnamed_367;
						fragment_unnamed_436.y = fragment_input_0.y;
						fragment_unnamed_436.z = -1.0f;
						fragment_unnamed_66.y = 1.0f;
						fragment_unnamed_475.x = 0.0f;
						while (true)
						{
							fragment_unnamed_88 = fragment_unnamed_436.z < 7.0f;
							fragment_unnamed_160 = 0.89999997615814208984375f < fragment_unnamed_66.y;
							fragment_unnamed_88 = fragment_unnamed_88 && fragment_unnamed_160;
							if (!fragment_unnamed_88)
							{
								break;
							}
							float3 fragment_unnamed_500 = fragment_unnamed_75.xyz + fragment_unnamed_436.xyz;
							fragment_unnamed_436 = float4(fragment_unnamed_500.x, fragment_unnamed_500.y, fragment_unnamed_500.z, fragment_unnamed_436.w);
							fragment_unnamed_503 = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_436.xy, 0.0f).xy;
							fragment_unnamed_426 = (fragment_unnamed_503.x * 5.0f) + (-3.75f);
							fragment_unnamed_426 = abs(fragment_unnamed_426) * fragment_unnamed_503.x;
							fragment_unnamed_475.y = round(fragment_unnamed_426);
							fragment_unnamed_475.x = round(fragment_unnamed_503.y);
							fragment_unnamed_66.y = dot(fragment_unnamed_475.yx, 0.5f.xx);
						}
						fragment_unnamed_83 = 0.89999997615814208984375f < fragment_unnamed_475.x;
						fragment_unnamed_367 = float(fragment_unnamed_83);
						fragment_unnamed_48.z = fragment_unnamed_367 + fragment_unnamed_436.z;
					}
					else
					{
						fragment_unnamed_48.z = 0.0f;
						fragment_unnamed_66.y = 0.0f;
					}
					fragment_unnamed_367 = fragment_unnamed_48.z + fragment_unnamed_48.x;
					fragment_unnamed_83 = 2.0f < fragment_unnamed_367;
					if (fragment_unnamed_83)
					{
						fragment_unnamed_48.y = -fragment_unnamed_48.x;
						fragment_unnamed_75 = (fragment_unnamed_48.yyzz * _MainTex_TexelSize.xyxy) + fragment_input_0.xyxy;
						fragment_unnamed_436.x = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_75.xy, 0.0f, int2(-1, 0)).y;
						fragment_unnamed_436.z = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_75.xy, 0.0f, int2(0, -1)).x;
						float2 fragment_unnamed_590 = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_75.zw, 0.0f, int2(1, 0)).yx;
						fragment_unnamed_436 = float4(fragment_unnamed_436.x, fragment_unnamed_590.x, fragment_unnamed_436.z, fragment_unnamed_590.y);
						float2 fragment_unnamed_598 = (fragment_unnamed_436.xy * 2.0f.xx) + fragment_unnamed_436.zw;
						fragment_unnamed_239 = float3(fragment_unnamed_598.x, fragment_unnamed_239.y, fragment_unnamed_598.y);
						bool2 fragment_unnamed_606 = bool4(fragment_unnamed_66.xyxx.x >= float4(0.89999997615814208984375f, 0.89999997615814208984375f, 0.0f, 0.0f).x, fragment_unnamed_66.xyxx.y >= float4(0.89999997615814208984375f, 0.89999997615814208984375f, 0.0f, 0.0f).y, fragment_unnamed_66.xyxx.z >= float4(0.89999997615814208984375f, 0.89999997615814208984375f, 0.0f, 0.0f).z, fragment_unnamed_66.xyxx.w >= float4(0.89999997615814208984375f, 0.89999997615814208984375f, 0.0f, 0.0f).w).xy;
						fragment_unnamed_601 = bool4(fragment_unnamed_606.x, fragment_unnamed_606.y, fragment_unnamed_601.z, fragment_unnamed_601.w);
						float3 fragment_unnamed_609 = fragment_unnamed_239;
						float fragment_unnamed_613;
						if (fragment_unnamed_601.x)
						{
							fragment_unnamed_613 = 0.0f;
						}
						else
						{
							fragment_unnamed_613 = fragment_unnamed_239.x;
						}
						fragment_unnamed_609.x = fragment_unnamed_613;
						float fragment_unnamed_623;
						if (fragment_unnamed_601.y)
						{
							fragment_unnamed_623 = 0.0f;
						}
						else
						{
							fragment_unnamed_623 = fragment_unnamed_239.z;
						}
						fragment_unnamed_609.z = fragment_unnamed_623;
						fragment_unnamed_239 = fragment_unnamed_609;
						float2 fragment_unnamed_637 = (fragment_unnamed_239.xz * 20.0f.xx) + fragment_unnamed_48.xz;
						fragment_unnamed_48 = float4(fragment_unnamed_637.x, fragment_unnamed_637.y, fragment_unnamed_48.z, fragment_unnamed_48.w);
						float2 fragment_unnamed_643 = (fragment_unnamed_48.xy * float2(0.0062500000931322574615478515625f, 0.001785714295692741870880126953125f)) + float2(0.503125011920928955078125f, 0.0008928571478463709354400634765625f);
						fragment_unnamed_48 = float4(fragment_unnamed_643.x, fragment_unnamed_643.y, fragment_unnamed_48.z, fragment_unnamed_48.w);
						float2 fragment_unnamed_652 = _AreaTex.SampleLevel(sampler_MainTex, fragment_unnamed_48.xy, 0.0f).xy;
						fragment_unnamed_48 = float4(fragment_unnamed_652.x, fragment_unnamed_652.y, fragment_unnamed_48.z, fragment_unnamed_48.w);
						float2 fragment_unnamed_659 = fragment_unnamed_72.xy + fragment_unnamed_48.yx;
						fragment_unnamed_72 = float3(fragment_unnamed_659.x, fragment_unnamed_659.y, fragment_unnamed_72.z);
					}
					fragment_unnamed_83 = (-fragment_unnamed_72.y) == fragment_unnamed_72.x;
					if (fragment_unnamed_83)
					{
						fragment_unnamed_48 = float4(fragment_input_2.xy.x, fragment_input_2.xy.y, fragment_unnamed_48.z, fragment_unnamed_48.w);
						fragment_unnamed_48.z = 1.0f;
						fragment_unnamed_66.x = 0.0f;
						while (true)
						{
							fragment_unnamed_83 = fragment_input_4.x < fragment_unnamed_48.x;
							fragment_unnamed_88 = 0.828100025653839111328125f < fragment_unnamed_48.z;
							fragment_unnamed_83 = fragment_unnamed_83 && fragment_unnamed_88;
							fragment_unnamed_88 = fragment_unnamed_66.x == 0.0f;
							fragment_unnamed_83 = fragment_unnamed_83 && fragment_unnamed_88;
							if (!fragment_unnamed_83)
							{
								break;
							}
							float2 fragment_unnamed_714 = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_48.xy, 0.0f).xy;
							fragment_unnamed_66 = float4(fragment_unnamed_714.x, fragment_unnamed_714.y, fragment_unnamed_66.z, fragment_unnamed_66.w);
							float2 fragment_unnamed_726 = (_MainTex_TexelSize.xy * float2(-2.0f, -0.0f)) + fragment_unnamed_48.xy;
							fragment_unnamed_48 = float4(fragment_unnamed_726.x, fragment_unnamed_726.y, fragment_unnamed_48.z, fragment_unnamed_48.w);
							fragment_unnamed_48.z = fragment_unnamed_66.y;
						}
						fragment_unnamed_66 = float4(fragment_unnamed_66.x, fragment_unnamed_48.xz.x, fragment_unnamed_48.xz.y, fragment_unnamed_66.w);
						float2 fragment_unnamed_743 = (fragment_unnamed_66.xz * float2(0.5f, -2.0f)) + float2(0.0078125f, 2.03125f);
						fragment_unnamed_48 = float4(fragment_unnamed_743.x, fragment_unnamed_743.y, fragment_unnamed_48.z, fragment_unnamed_48.w);
						fragment_unnamed_367 = _SearchTex.SampleLevel(sampler_MainTex, fragment_unnamed_48.xy, 0.0f).w;
						fragment_unnamed_367 = (fragment_unnamed_367 * (-2.007874011993408203125f)) + 3.25f;
						fragment_unnamed_48.x = (_MainTex_TexelSize.x * fragment_unnamed_367) + fragment_unnamed_66.y;
						fragment_unnamed_48.y = fragment_input_3.y;
						fragment_unnamed_66.x = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_48.xy, 0.0f).x;
						fragment_unnamed_75 = float4(fragment_input_2.zw.x, fragment_input_2.zw.y, fragment_unnamed_75.z, fragment_unnamed_75.w);
						fragment_unnamed_75.z = 1.0f;
						fragment_unnamed_436.x = 0.0f;
						while (true)
						{
							fragment_unnamed_83 = fragment_unnamed_75.x < fragment_input_4.y;
							fragment_unnamed_796 = 0.828100025653839111328125f < fragment_unnamed_75.z;
							fragment_unnamed_83 = fragment_unnamed_83 && fragment_unnamed_796;
							fragment_unnamed_796 = fragment_unnamed_436.x == 0.0f;
							fragment_unnamed_83 = fragment_unnamed_83 && fragment_unnamed_796;
							if (!fragment_unnamed_83)
							{
								break;
							}
							float2 fragment_unnamed_820 = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_75.xy, 0.0f).xy;
							fragment_unnamed_436 = float4(fragment_unnamed_820.x, fragment_unnamed_820.y, fragment_unnamed_436.z, fragment_unnamed_436.w);
							float2 fragment_unnamed_830 = (_MainTex_TexelSize.xy * float2(2.0f, 0.0f)) + fragment_unnamed_75.xy;
							fragment_unnamed_75 = float4(fragment_unnamed_830.x, fragment_unnamed_830.y, fragment_unnamed_75.z, fragment_unnamed_75.w);
							fragment_unnamed_75.z = fragment_unnamed_436.y;
						}
						fragment_unnamed_436 = float4(fragment_unnamed_436.x, fragment_unnamed_75.xz.x, fragment_unnamed_75.xz.y, fragment_unnamed_436.w);
						fragment_unnamed_475 = (fragment_unnamed_436.xz * float2(0.5f, -2.0f)) + float2(0.5234375f, 2.03125f);
						fragment_unnamed_367 = _SearchTex.SampleLevel(sampler_MainTex, fragment_unnamed_475, 0.0f).w;
						fragment_unnamed_367 = (fragment_unnamed_367 * (-2.007874011993408203125f)) + 3.25f;
						fragment_unnamed_48.z = ((-_MainTex_TexelSize.x) * fragment_unnamed_367) + fragment_unnamed_436.y;
						fragment_unnamed_75 = (_MainTex_TexelSize.zzzz * fragment_unnamed_48.zxzx) + (-fragment_input_1.xxxx);
						fragment_unnamed_75 = round(fragment_unnamed_75);
						fragment_unnamed_475 = sqrt(abs(fragment_unnamed_75.wz));
						fragment_unnamed_66.y = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_48.zy, 0.0f, int2(1, 0)).x;
						float2 fragment_unnamed_893 = fragment_unnamed_66.xy * 4.0f.xx;
						fragment_unnamed_66 = float4(fragment_unnamed_893.x, fragment_unnamed_893.y, fragment_unnamed_66.z, fragment_unnamed_66.w);
						float2 fragment_unnamed_898 = round(fragment_unnamed_66.xy);
						fragment_unnamed_66 = float4(fragment_unnamed_898.x, fragment_unnamed_898.y, fragment_unnamed_66.z, fragment_unnamed_66.w);
						float2 fragment_unnamed_907 = (fragment_unnamed_66.xy * 16.0f.xx) + fragment_unnamed_475;
						fragment_unnamed_66 = float4(fragment_unnamed_907.x, fragment_unnamed_907.y, fragment_unnamed_66.z, fragment_unnamed_66.w);
						float2 fragment_unnamed_915 = (fragment_unnamed_66.xy * float2(0.0062500000931322574615478515625f, 0.001785714295692741870880126953125f)) + float2(0.00312500004656612873077392578125f, 0.0008928571478463709354400634765625f);
						fragment_unnamed_66 = float4(fragment_unnamed_915.x, fragment_unnamed_915.y, fragment_unnamed_66.z, fragment_unnamed_66.w);
						float2 fragment_unnamed_924 = _AreaTex.SampleLevel(sampler_MainTex, fragment_unnamed_66.xy, 0.0f).xy;
						fragment_unnamed_66 = float4(fragment_unnamed_924.x, fragment_unnamed_924.y, fragment_unnamed_66.z, fragment_unnamed_66.w);
						float4 fragment_unnamed_928 = abs(fragment_unnamed_75);
						float4 fragment_unnamed_931 = abs(fragment_unnamed_75.wzwz);
						fragment_unnamed_399 = bool4(fragment_unnamed_928.x >= fragment_unnamed_931.x, fragment_unnamed_928.y >= fragment_unnamed_931.y, fragment_unnamed_928.z >= fragment_unnamed_931.z, fragment_unnamed_928.w >= fragment_unnamed_931.w);
						fragment_unnamed_75.x = float(fragment_unnamed_399.x);
						fragment_unnamed_75.y = float(fragment_unnamed_399.y);
						fragment_unnamed_75.z = fragment_unnamed_399.z ? 0.75f : 0.0f;
						fragment_unnamed_75.w = fragment_unnamed_399.w ? 0.75f : 0.0f;
						fragment_unnamed_367 = fragment_unnamed_75.y + fragment_unnamed_75.x;
						fragment_unnamed_475 = fragment_unnamed_75.zw / fragment_unnamed_367.xx;
						fragment_unnamed_48.w = fragment_input_0.y;
						fragment_unnamed_367 = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_48.xw, 0.0f, int2(0, 1)).x;
						fragment_unnamed_367 = ((-fragment_unnamed_475.x) * fragment_unnamed_367) + 1.0f;
						fragment_unnamed_239.x = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_48.zw, 0.0f, int2(1, 1)).x;
						fragment_unnamed_75.x = ((-fragment_unnamed_475.y) * fragment_unnamed_239.x) + fragment_unnamed_367;
						fragment_unnamed_75.x = clamp(fragment_unnamed_75.x, 0.0f, 1.0f);
						fragment_unnamed_367 = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_48.xw, 0.0f, int2(0, -2)).x;
						fragment_unnamed_367 = ((-fragment_unnamed_475.x) * fragment_unnamed_367) + 1.0f;
						fragment_unnamed_48.x = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_48.zw, 0.0f, int2(1, -2)).x;
						fragment_unnamed_75.y = ((-fragment_unnamed_475.y) * fragment_unnamed_48.x) + fragment_unnamed_367;
						fragment_unnamed_75.y = clamp(fragment_unnamed_75.y, 0.0f, 1.0f);
						float2 fragment_unnamed_1042 = fragment_unnamed_66.xy * fragment_unnamed_75.xy;
						fragment_output_0 = float4(fragment_unnamed_1042.x, fragment_unnamed_1042.y, fragment_output_0.z, fragment_output_0.w);
					}
					else
					{
						fragment_output_0 = float4(fragment_unnamed_72.xy.x, fragment_unnamed_72.xy.y, fragment_output_0.z, fragment_output_0.w);
						fragment_unnamed_9.x = 0.0f;
					}
				}
				else
				{
					fragment_output_0 = float4(0.0f.xx.x, 0.0f.xx.y, fragment_output_0.z, fragment_output_0.w);
				}
				fragment_unnamed_1055 = 0.0f < fragment_unnamed_9.x;
				if (fragment_unnamed_1055)
				{
					fragment_unnamed_9 = float4(fragment_input_3.xy.x, fragment_input_3.xy.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
					fragment_unnamed_9.z = 1.0f;
					fragment_unnamed_48.x = 0.0f;
					while (true)
					{
						fragment_unnamed_83 = fragment_input_4.z < fragment_unnamed_9.y;
						fragment_unnamed_88 = 0.828100025653839111328125f < fragment_unnamed_9.z;
						fragment_unnamed_83 = fragment_unnamed_83 && fragment_unnamed_88;
						fragment_unnamed_88 = fragment_unnamed_48.x == 0.0f;
						fragment_unnamed_83 = fragment_unnamed_83 && fragment_unnamed_88;
						if (!fragment_unnamed_83)
						{
							break;
						}
						float2 fragment_unnamed_1101 = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_9.xy, 0.0f).yx;
						fragment_unnamed_48 = float4(fragment_unnamed_1101.x, fragment_unnamed_1101.y, fragment_unnamed_48.z, fragment_unnamed_48.w);
						float2 fragment_unnamed_1111 = (_MainTex_TexelSize.xy * float2(-0.0f, -2.0f)) + fragment_unnamed_9.xy;
						fragment_unnamed_9 = float4(fragment_unnamed_1111.x, fragment_unnamed_1111.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
						fragment_unnamed_9.z = fragment_unnamed_48.y;
					}
					fragment_unnamed_48 = float4(fragment_unnamed_48.x, fragment_unnamed_9.yz.x, fragment_unnamed_9.yz.y, fragment_unnamed_48.w);
					float2 fragment_unnamed_1124 = (fragment_unnamed_48.xz * float2(0.5f, -2.0f)) + float2(0.0078125f, 2.03125f);
					fragment_unnamed_9 = float4(fragment_unnamed_1124.x, fragment_unnamed_1124.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
					fragment_unnamed_9.x = _SearchTex.SampleLevel(sampler_MainTex, fragment_unnamed_9.xy, 0.0f).w;
					fragment_unnamed_9.x = (fragment_unnamed_9.x * (-2.007874011993408203125f)) + 3.25f;
					fragment_unnamed_9.x = (_MainTex_TexelSize.y * fragment_unnamed_9.x) + fragment_unnamed_48.y;
					fragment_unnamed_9.y = fragment_input_2.x;
					fragment_unnamed_48.x = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_9.yx, 0.0f).y;
					fragment_unnamed_66 = float4(fragment_input_3.zw.x, fragment_input_3.zw.y, fragment_unnamed_66.z, fragment_unnamed_66.w);
					fragment_unnamed_66.z = 1.0f;
					fragment_unnamed_75.x = 0.0f;
					while (true)
					{
						fragment_unnamed_1171 = fragment_unnamed_66.y < fragment_input_4.w;
						fragment_unnamed_88 = 0.828100025653839111328125f < fragment_unnamed_66.z;
						fragment_unnamed_1171 = fragment_unnamed_88 && fragment_unnamed_1171;
						fragment_unnamed_88 = fragment_unnamed_75.x == 0.0f;
						fragment_unnamed_1171 = fragment_unnamed_88 && fragment_unnamed_1171;
						if (!fragment_unnamed_1171)
						{
							break;
						}
						float2 fragment_unnamed_1200 = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_66.xy, 0.0f).yx;
						fragment_unnamed_75 = float4(fragment_unnamed_1200.x, fragment_unnamed_1200.y, fragment_unnamed_75.z, fragment_unnamed_75.w);
						float2 fragment_unnamed_1210 = (_MainTex_TexelSize.xy * float2(0.0f, 2.0f)) + fragment_unnamed_66.xy;
						fragment_unnamed_66 = float4(fragment_unnamed_1210.x, fragment_unnamed_1210.y, fragment_unnamed_66.z, fragment_unnamed_66.w);
						fragment_unnamed_66.z = fragment_unnamed_75.y;
					}
					fragment_unnamed_75 = float4(fragment_unnamed_75.x, fragment_unnamed_66.yz.x, fragment_unnamed_66.yz.y, fragment_unnamed_75.w);
					fragment_unnamed_1220 = (fragment_unnamed_75.xz * float2(0.5f, -2.0f)) + float2(0.5234375f, 2.03125f);
					fragment_unnamed_1220.x = _SearchTex.SampleLevel(sampler_MainTex, fragment_unnamed_1220, 0.0f).w;
					fragment_unnamed_1220.x = (fragment_unnamed_1220.x * (-2.007874011993408203125f)) + 3.25f;
					fragment_unnamed_9.z = ((-_MainTex_TexelSize.y) * fragment_unnamed_1220.x) + fragment_unnamed_75.y;
					fragment_unnamed_66 = (_MainTex_TexelSize.wwww * fragment_unnamed_9.zxzx) + (-fragment_input_1.yyyy);
					fragment_unnamed_66 = round(fragment_unnamed_66);
					fragment_unnamed_1220 = sqrt(abs(fragment_unnamed_66.wz));
					fragment_unnamed_48.y = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_9.yz, 0.0f, int2(0, 1)).y;
					float2 fragment_unnamed_1273 = fragment_unnamed_48.xy * 4.0f.xx;
					fragment_unnamed_48 = float4(fragment_unnamed_1273.x, fragment_unnamed_1273.y, fragment_unnamed_48.z, fragment_unnamed_48.w);
					float2 fragment_unnamed_1278 = round(fragment_unnamed_48.xy);
					fragment_unnamed_48 = float4(fragment_unnamed_1278.x, fragment_unnamed_1278.y, fragment_unnamed_48.z, fragment_unnamed_48.w);
					float2 fragment_unnamed_1285 = (fragment_unnamed_48.xy * 16.0f.xx) + fragment_unnamed_1220;
					fragment_unnamed_48 = float4(fragment_unnamed_1285.x, fragment_unnamed_1285.y, fragment_unnamed_48.z, fragment_unnamed_48.w);
					float2 fragment_unnamed_1291 = (fragment_unnamed_48.xy * float2(0.0062500000931322574615478515625f, 0.001785714295692741870880126953125f)) + float2(0.00312500004656612873077392578125f, 0.0008928571478463709354400634765625f);
					fragment_unnamed_48 = float4(fragment_unnamed_1291.x, fragment_unnamed_1291.y, fragment_unnamed_48.z, fragment_unnamed_48.w);
					float2 fragment_unnamed_1300 = _AreaTex.SampleLevel(sampler_MainTex, fragment_unnamed_48.xy, 0.0f).xy;
					fragment_unnamed_48 = float4(fragment_unnamed_1300.x, fragment_unnamed_1300.y, fragment_unnamed_48.z, fragment_unnamed_48.w);
					float4 fragment_unnamed_1304 = abs(fragment_unnamed_66);
					float4 fragment_unnamed_1307 = abs(fragment_unnamed_66.wzwz);
					fragment_unnamed_601 = bool4(fragment_unnamed_1304.x >= fragment_unnamed_1307.x, fragment_unnamed_1304.y >= fragment_unnamed_1307.y, fragment_unnamed_1304.z >= fragment_unnamed_1307.z, fragment_unnamed_1304.w >= fragment_unnamed_1307.w);
					fragment_unnamed_66.x = float(fragment_unnamed_601.x);
					fragment_unnamed_66.y = float(fragment_unnamed_601.y);
					fragment_unnamed_66.z = fragment_unnamed_601.z ? 0.75f : 0.0f;
					fragment_unnamed_66.w = fragment_unnamed_601.w ? 0.75f : 0.0f;
					fragment_unnamed_72.x = fragment_unnamed_66.y + fragment_unnamed_66.x;
					fragment_unnamed_1220 = fragment_unnamed_66.zw / fragment_unnamed_72.xx;
					fragment_unnamed_9.w = fragment_input_0.x;
					fragment_unnamed_72.x = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_9.wx, 0.0f, int2(1, 0)).y;
					fragment_unnamed_72.x = ((-fragment_unnamed_1220.x) * fragment_unnamed_72.x) + 1.0f;
					fragment_unnamed_66.x = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_9.wz, 0.0f, int2(1, 1)).y;
					fragment_unnamed_475.x = ((-fragment_unnamed_1220.y) * fragment_unnamed_66.x) + fragment_unnamed_72.x;
					fragment_unnamed_475.x = clamp(fragment_unnamed_475.x, 0.0f, 1.0f);
					fragment_unnamed_9.x = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_9.wx, 0.0f, int2(-2, 0)).y;
					fragment_unnamed_9.x = ((-fragment_unnamed_1220.x) * fragment_unnamed_9.x) + 1.0f;
					fragment_unnamed_72.x = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_9.wz, 0.0f, int2(-2, 1)).y;
					fragment_unnamed_475.y = ((-fragment_unnamed_1220.y) * fragment_unnamed_72.x) + fragment_unnamed_9.x;
					fragment_unnamed_475.y = clamp(fragment_unnamed_475.y, 0.0f, 1.0f);
					float2 fragment_unnamed_1420 = fragment_unnamed_48.xy * fragment_unnamed_475;
					fragment_output_0 = float4(fragment_output_0.x, fragment_output_0.y, fragment_unnamed_1420.x, fragment_unnamed_1420.y);
				}
				else
				{
					fragment_output_0 = float4(fragment_output_0.x, fragment_output_0.y, 0.0f.xx.x, 0.0f.xx.y);
				}
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_0 = stage_input.fragment_input_0;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			float4 _MainTex_TexelSize;

			static float4 fragment_uniform_buffer_0[29];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _AreaTex;
			Texture2D<float4> _SearchTex;
			SamplerState sampler_MainTex;

			static float2 fragment_input_1;
			static float2 fragment_input_1;
			static float4 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD; // TEXCOORD
				float2 fragment_input_1 : TEXCOORD1; // TEXCOORD_1
				float4 fragment_input_2 : TEXCOORD2; // TEXCOORD_2
				float4 fragment_input_3 : TEXCOORD3; // TEXCOORD_3
				float4 fragment_input_4 : TEXCOORD4; // TEXCOORD_4
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				float4 fragment_unnamed_46 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				float fragment_unnamed_48 = fragment_unnamed_46.x;
				float fragment_unnamed_78;
				if (0.0f < fragment_unnamed_46.y)
				{
					float fragment_unnamed_100;
					float fragment_unnamed_102;
					if (0.0f < fragment_unnamed_48)
					{
						precise float fragment_unnamed_62 = fragment_uniform_buffer_0[28u].x * (-1.0f);
						precise float fragment_unnamed_64 = fragment_uniform_buffer_0[28u].y * 1.0f;
						float fragment_unnamed_66 = asfloat(1065353216u);
						float fragment_unnamed_85;
						float fragment_unnamed_87;
						float fragment_unnamed_89;
						fragment_unnamed_85 = asfloat(0u);
						fragment_unnamed_87 = asfloat(3212836864u);
						fragment_unnamed_89 = asfloat(1065353216u);
						precise float fragment_unnamed_82;
						precise float fragment_unnamed_84;
						precise float fragment_unnamed_88;
						float4 fragment_unnamed_131;
						for (float fragment_unnamed_81 = fragment_input_1.x, fragment_unnamed_83 = fragment_input_1.y; !((((0.89999997615814208984375f < fragment_unnamed_89) ? 4294967295u : 0u) & ((fragment_unnamed_87 < 7.0f) ? 4294967295u : 0u)) == 0u); fragment_unnamed_82 = fragment_unnamed_62 + fragment_unnamed_81, fragment_unnamed_84 = fragment_unnamed_64 + fragment_unnamed_83, fragment_unnamed_88 = fragment_unnamed_66 + fragment_unnamed_87, fragment_unnamed_131 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_82, fragment_unnamed_84), 0.0f), fragment_unnamed_81 = fragment_unnamed_82, fragment_unnamed_83 = fragment_unnamed_84, fragment_unnamed_85 = fragment_unnamed_131.y, fragment_unnamed_87 = fragment_unnamed_88, fragment_unnamed_89 = dot(float2(fragment_unnamed_131.xy), 0.5f.xx))
						{
						}
						precise float fragment_unnamed_101 = asfloat(((0.89999997615814208984375f < fragment_unnamed_85) ? 4294967295u : 0u) & 1065353216u) + fragment_unnamed_87;
						fragment_unnamed_100 = fragment_unnamed_101;
						fragment_unnamed_102 = fragment_unnamed_89;
					}
					else
					{
						fragment_unnamed_100 = asfloat(0u);
						fragment_unnamed_102 = asfloat(0u);
					}
					precise float fragment_unnamed_107 = fragment_uniform_buffer_0[28u].x * 1.0f;
					precise float fragment_unnamed_108 = fragment_uniform_buffer_0[28u].y * (-1.0f);
					float fragment_unnamed_109 = asfloat(1065353216u);
					float fragment_unnamed_137;
					float fragment_unnamed_143;
					fragment_unnamed_137 = asfloat(3212836864u);
					fragment_unnamed_143 = asfloat(1065353216u);
					precise float fragment_unnamed_138;
					precise float fragment_unnamed_140;
					precise float fragment_unnamed_142;
					for (float fragment_unnamed_139 = fragment_input_1.x, fragment_unnamed_141 = fragment_input_1.y; !((((0.89999997615814208984375f < fragment_unnamed_143) ? 4294967295u : 0u) & ((fragment_unnamed_137 < 7.0f) ? 4294967295u : 0u)) == 0u); fragment_unnamed_138 = fragment_unnamed_109 + fragment_unnamed_137, fragment_unnamed_140 = fragment_unnamed_107 + fragment_unnamed_139, fragment_unnamed_142 = fragment_unnamed_108 + fragment_unnamed_141, fragment_unnamed_137 = fragment_unnamed_138, fragment_unnamed_139 = fragment_unnamed_140, fragment_unnamed_141 = fragment_unnamed_142, fragment_unnamed_143 = dot(float2(_MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_140, fragment_unnamed_142), 0.0f).xy), 0.5f.xx))
					{
					}
					precise float fragment_unnamed_171 = fragment_unnamed_100 + fragment_unnamed_137;
					float fragment_unnamed_309;
					float fragment_unnamed_310;
					if (2.0f < fragment_unnamed_171)
					{
						precise float fragment_unnamed_218 = (-0.0f) - fragment_unnamed_100;
						precise float fragment_unnamed_219 = fragment_unnamed_218 + 0.25f;
						float fragment_unnamed_221 = mad(fragment_unnamed_137, 1.0f, 0.0f);
						float4 fragment_unnamed_240 = _MainTex.SampleLevel(sampler_MainTex, float2(mad(fragment_unnamed_219, fragment_uniform_buffer_0[28u].x, fragment_input_1.x), mad(fragment_unnamed_100, fragment_uniform_buffer_0[28u].y, fragment_input_1.y)), 0.0f, int2(-1, 0));
						float fragment_unnamed_244 = fragment_unnamed_240.x;
						float4 fragment_unnamed_247 = _MainTex.SampleLevel(sampler_MainTex, float2(mad(fragment_unnamed_221, fragment_uniform_buffer_0[28u].x, fragment_input_1.x), mad(mad(fragment_unnamed_137, -1.0f, -0.25f), fragment_uniform_buffer_0[28u].y, fragment_input_1.y)), 0.0f, int2(1, 0));
						float fragment_unnamed_250 = fragment_unnamed_247.x;
						precise float fragment_unnamed_258 = abs(mad(fragment_unnamed_244, 5.0f, -3.75f)) * fragment_unnamed_244;
						precise float fragment_unnamed_259 = abs(mad(fragment_unnamed_250, 5.0f, -3.75f)) * fragment_unnamed_250;
						float4 fragment_unnamed_284 = _AreaTex.SampleLevel(sampler_MainTex, float2(mad(mad(asfloat((fragment_unnamed_102 >= 0.89999997615814208984375f) ? 0u : asuint(mad(round(fragment_unnamed_240.y), 2.0f, round(fragment_unnamed_258)))), 20.0f, fragment_unnamed_100), 0.0062500000931322574615478515625f, 0.503125011920928955078125f), mad(mad(asfloat((fragment_unnamed_143 >= 0.89999997615814208984375f) ? 0u : asuint(mad(round(fragment_unnamed_247.y), 2.0f, round(fragment_unnamed_259)))), 20.0f, fragment_unnamed_221), 0.001785714295692741870880126953125f, 0.0008928571478463709354400634765625f)), 0.0f);
						fragment_unnamed_309 = fragment_unnamed_284.x;
						fragment_unnamed_310 = fragment_unnamed_284.y;
					}
					else
					{
						fragment_unnamed_309 = asfloat(0u);
						fragment_unnamed_310 = asfloat(0u);
					}
					float fragment_unnamed_316 = mad(fragment_uniform_buffer_0[28u].x, 0.25f, fragment_input_1.x);
					precise float fragment_unnamed_320 = (-0.0f) - fragment_uniform_buffer_0[28u].x;
					precise float fragment_unnamed_322 = (-0.0f) - fragment_uniform_buffer_0[28u].y;
					float fragment_unnamed_323 = asfloat(1065353216u);
					float fragment_unnamed_445;
					float fragment_unnamed_451;
					fragment_unnamed_445 = asfloat(1065353216u);
					fragment_unnamed_451 = asfloat(3212836864u);
					precise float fragment_unnamed_448;
					precise float fragment_unnamed_450;
					precise float fragment_unnamed_452;
					float4 fragment_unnamed_469;
					float fragment_unnamed_471;
					precise float fragment_unnamed_475;
					for (float fragment_unnamed_447 = fragment_unnamed_316, fragment_unnamed_449 = fragment_input_1.y; !((((0.89999997615814208984375f < fragment_unnamed_445) ? 4294967295u : 0u) & ((fragment_unnamed_451 < 7.0f) ? 4294967295u : 0u)) == 0u); fragment_unnamed_448 = fragment_unnamed_320 + fragment_unnamed_447, fragment_unnamed_450 = fragment_unnamed_322 + fragment_unnamed_449, fragment_unnamed_452 = fragment_unnamed_323 + fragment_unnamed_451, fragment_unnamed_469 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_448, fragment_unnamed_450), 0.0f), fragment_unnamed_471 = fragment_unnamed_469.x, fragment_unnamed_475 = abs(mad(fragment_unnamed_471, 5.0f, -3.75f)) * fragment_unnamed_471, fragment_unnamed_445 = dot(float2(round(fragment_unnamed_475), round(fragment_unnamed_469.y)), 0.5f.xx), fragment_unnamed_447 = fragment_unnamed_448, fragment_unnamed_449 = fragment_unnamed_450, fragment_unnamed_451 = fragment_unnamed_452)
					{
					}
					float fragment_unnamed_512;
					float fragment_unnamed_514;
					if (0.0f < _MainTex.SampleLevel(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y), 0.0f, int2(1, 0)).x)
					{
						uint4 fragment_unnamed_483 = asuint(fragment_uniform_buffer_0[28u]);
						float fragment_unnamed_485 = asfloat(fragment_unnamed_483.x);
						float fragment_unnamed_487 = asfloat(fragment_unnamed_483.y);
						float fragment_unnamed_488 = asfloat(1065353216u);
						float fragment_unnamed_496;
						float fragment_unnamed_498;
						float fragment_unnamed_504;
						fragment_unnamed_496 = asfloat(0u);
						fragment_unnamed_498 = asfloat(1065353216u);
						fragment_unnamed_504 = asfloat(3212836864u);
						float fragment_unnamed_497;
						precise float fragment_unnamed_501;
						precise float fragment_unnamed_503;
						precise float fragment_unnamed_505;
						float4 fragment_unnamed_522;
						float fragment_unnamed_524;
						precise float fragment_unnamed_528;
						for (float fragment_unnamed_500 = fragment_unnamed_316, fragment_unnamed_502 = fragment_input_1.y; !((((0.89999997615814208984375f < fragment_unnamed_498) ? 4294967295u : 0u) & ((fragment_unnamed_504 < 7.0f) ? 4294967295u : 0u)) == 0u); fragment_unnamed_501 = fragment_unnamed_485 + fragment_unnamed_500, fragment_unnamed_503 = fragment_unnamed_487 + fragment_unnamed_502, fragment_unnamed_505 = fragment_unnamed_488 + fragment_unnamed_504, fragment_unnamed_522 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_501, fragment_unnamed_503), 0.0f), fragment_unnamed_524 = fragment_unnamed_522.x, fragment_unnamed_528 = abs(mad(fragment_unnamed_524, 5.0f, -3.75f)) * fragment_unnamed_524, fragment_unnamed_497 = round(fragment_unnamed_522.y), fragment_unnamed_496 = fragment_unnamed_497, fragment_unnamed_498 = dot(float2(round(fragment_unnamed_528), fragment_unnamed_497), 0.5f.xx), fragment_unnamed_500 = fragment_unnamed_501, fragment_unnamed_502 = fragment_unnamed_503, fragment_unnamed_504 = fragment_unnamed_505)
						{
						}
						precise float fragment_unnamed_513 = asfloat(((0.89999997615814208984375f < fragment_unnamed_496) ? 4294967295u : 0u) & 1065353216u) + fragment_unnamed_504;
						fragment_unnamed_512 = fragment_unnamed_513;
						fragment_unnamed_514 = fragment_unnamed_498;
					}
					else
					{
						fragment_unnamed_512 = asfloat(0u);
						fragment_unnamed_514 = asfloat(0u);
					}
					precise float fragment_unnamed_515 = fragment_unnamed_512 + fragment_unnamed_451;
					float fragment_unnamed_578;
					float fragment_unnamed_579;
					if (2.0f < fragment_unnamed_515)
					{
						precise float fragment_unnamed_532 = (-0.0f) - fragment_unnamed_451;
						float fragment_unnamed_541 = mad(fragment_unnamed_532, fragment_uniform_buffer_0[28u].x, fragment_input_1.x);
						float fragment_unnamed_542 = mad(fragment_unnamed_532, fragment_uniform_buffer_0[28u].y, fragment_input_1.y);
						float4 fragment_unnamed_553 = _MainTex.SampleLevel(sampler_MainTex, float2(mad(fragment_unnamed_512, fragment_uniform_buffer_0[28u].x, fragment_input_1.x), mad(fragment_unnamed_512, fragment_uniform_buffer_0[28u].y, fragment_input_1.y)), 0.0f, int2(1, 0));
						float4 fragment_unnamed_572 = _AreaTex.SampleLevel(sampler_MainTex, float2(mad(mad(asfloat((fragment_unnamed_445 >= 0.89999997615814208984375f) ? 0u : asuint(mad(_MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_541, fragment_unnamed_542), 0.0f, int2(-1, 0)).y, 2.0f, _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_541, fragment_unnamed_542), 0.0f, int2(0, -1)).x))), 20.0f, fragment_unnamed_451), 0.0062500000931322574615478515625f, 0.503125011920928955078125f), mad(mad(asfloat((fragment_unnamed_514 >= 0.89999997615814208984375f) ? 0u : asuint(mad(fragment_unnamed_553.y, 2.0f, fragment_unnamed_553.x))), 20.0f, fragment_unnamed_512), 0.001785714295692741870880126953125f, 0.0008928571478463709354400634765625f)), 0.0f);
						precise float fragment_unnamed_576 = fragment_unnamed_309 + fragment_unnamed_572.y;
						precise float fragment_unnamed_577 = fragment_unnamed_310 + fragment_unnamed_572.x;
						fragment_unnamed_578 = fragment_unnamed_576;
						fragment_unnamed_579 = fragment_unnamed_577;
					}
					else
					{
						fragment_unnamed_578 = fragment_unnamed_309;
						fragment_unnamed_579 = fragment_unnamed_310;
					}
					precise float fragment_unnamed_580 = (-0.0f) - fragment_unnamed_579;
					float fragment_unnamed_79;
					if (fragment_unnamed_580 == fragment_unnamed_578)
					{
						float fragment_unnamed_591;
						float fragment_unnamed_595;
						float fragment_unnamed_597;
						fragment_unnamed_591 = fragment_input_2.x;
						fragment_unnamed_595 = asfloat(0u);
						fragment_unnamed_597 = asfloat(1065353216u);
						float4 fragment_unnamed_634;
						float2 fragment_unnamed_635;
						for (float fragment_unnamed_593 = fragment_input_2.y; !((((fragment_unnamed_595 == 0.0f) ? 4294967295u : 0u) & (((0.828100025653839111328125f < fragment_unnamed_597) ? 4294967295u : 0u) & ((fragment_input_4.x < fragment_unnamed_591) ? 4294967295u : 0u))) == 0u); fragment_unnamed_635 = float2(fragment_unnamed_591, fragment_unnamed_593), fragment_unnamed_634 = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_635, 0.0f), fragment_unnamed_591 = mad(fragment_uniform_buffer_0[28u].x, -2.0f, fragment_unnamed_591), fragment_unnamed_593 = mad(fragment_uniform_buffer_0[28u].y, -0.0f, fragment_unnamed_593), fragment_unnamed_595 = fragment_unnamed_634.x, fragment_unnamed_597 = fragment_unnamed_634.y)
						{
						}
						float fragment_unnamed_620 = mad(fragment_uniform_buffer_0[28u].x, mad(_SearchTex.SampleLevel(sampler_MainTex, float2(mad(fragment_unnamed_595, 0.5f, 0.0078125f), mad(fragment_unnamed_597, -2.0f, 2.03125f)), 0.0f).w, -2.007874011993408203125f, 3.25f), fragment_unnamed_591);
						float fragment_unnamed_640;
						float fragment_unnamed_644;
						float fragment_unnamed_646;
						fragment_unnamed_640 = fragment_input_2.z;
						fragment_unnamed_644 = asfloat(1065353216u);
						fragment_unnamed_646 = asfloat(0u);
						float4 fragment_unnamed_762;
						float2 fragment_unnamed_763;
						for (float fragment_unnamed_642 = fragment_input_2.w; !((((fragment_unnamed_646 == 0.0f) ? 4294967295u : 0u) & (((0.828100025653839111328125f < fragment_unnamed_644) ? 4294967295u : 0u) & ((fragment_unnamed_640 < fragment_input_4.y) ? 4294967295u : 0u))) == 0u); fragment_unnamed_763 = float2(fragment_unnamed_640, fragment_unnamed_642), fragment_unnamed_762 = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_763, 0.0f), fragment_unnamed_640 = mad(fragment_uniform_buffer_0[28u].x, 2.0f, fragment_unnamed_640), fragment_unnamed_642 = mad(fragment_uniform_buffer_0[28u].y, 0.0f, fragment_unnamed_642), fragment_unnamed_644 = fragment_unnamed_762.y, fragment_unnamed_646 = fragment_unnamed_762.x)
						{
						}
						precise float fragment_unnamed_669 = (-0.0f) - fragment_uniform_buffer_0[28u].x;
						float fragment_unnamed_670 = mad(fragment_unnamed_669, mad(_SearchTex.SampleLevel(sampler_MainTex, float2(mad(fragment_unnamed_646, 0.5f, 0.5234375f), mad(fragment_unnamed_644, -2.0f, 2.03125f)), 0.0f).w, -2.007874011993408203125f, 3.25f), fragment_unnamed_640);
						precise float fragment_unnamed_676 = (-0.0f) - fragment_input_1.x;
						float fragment_unnamed_683 = round(mad(fragment_uniform_buffer_0[28u].z, fragment_unnamed_670, fragment_unnamed_676));
						float fragment_unnamed_684 = round(mad(fragment_uniform_buffer_0[28u].z, fragment_unnamed_620, fragment_unnamed_676));
						precise float fragment_unnamed_693 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_620, fragment_input_3.y), 0.0f).x * 4.0f;
						precise float fragment_unnamed_694 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_670, fragment_input_3.y), 0.0f, int2(1, 0)).x * 4.0f;
						float4 fragment_unnamed_702 = _AreaTex.SampleLevel(sampler_MainTex, float2(mad(mad(round(fragment_unnamed_693), 16.0f, sqrt(abs(fragment_unnamed_684))), 0.0062500000931322574615478515625f, 0.00312500004656612873077392578125f), mad(mad(round(fragment_unnamed_694), 16.0f, sqrt(abs(fragment_unnamed_683))), 0.001785714295692741870880126953125f, 0.0008928571478463709354400634765625f)), 0.0f);
						float fragment_unnamed_710 = abs(fragment_unnamed_684);
						float fragment_unnamed_711 = abs(fragment_unnamed_683);
						precise float fragment_unnamed_728 = asfloat(((abs(round(mad(fragment_uniform_buffer_0[28u].z, fragment_unnamed_620, fragment_unnamed_676))) >= fragment_unnamed_711) ? 4294967295u : 0u) & 1065353216u) + asfloat(((abs(round(mad(fragment_uniform_buffer_0[28u].z, fragment_unnamed_670, fragment_unnamed_676))) >= fragment_unnamed_710) ? 4294967295u : 0u) & 1065353216u);
						precise float fragment_unnamed_729 = asfloat(((abs(fragment_unnamed_683) >= fragment_unnamed_710) ? 4294967295u : 0u) & 1061158912u) / fragment_unnamed_728;
						precise float fragment_unnamed_730 = asfloat(((abs(fragment_unnamed_684) >= fragment_unnamed_711) ? 4294967295u : 0u) & 1061158912u) / fragment_unnamed_728;
						precise float fragment_unnamed_736 = (-0.0f) - fragment_unnamed_729;
						precise float fragment_unnamed_741 = (-0.0f) - fragment_unnamed_730;
						precise float fragment_unnamed_748 = (-0.0f) - fragment_unnamed_729;
						precise float fragment_unnamed_754 = (-0.0f) - fragment_unnamed_730;
						precise float fragment_unnamed_757 = fragment_unnamed_702.x * clamp(mad(fragment_unnamed_741, _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_670, fragment_input_1.y), 0.0f, int2(1, 1)).x, mad(fragment_unnamed_736, _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_620, fragment_input_1.y), 0.0f, int2(0, 1)).x, 1.0f)), 0.0f, 1.0f);
						precise float fragment_unnamed_758 = fragment_unnamed_702.y * clamp(mad(fragment_unnamed_754, _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_670, fragment_input_1.y), 0.0f, int2(1, -2)).x, mad(fragment_unnamed_748, _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_620, fragment_input_1.y), 0.0f, int2(0, -2)).x, 1.0f)), 0.0f, 1.0f);
						fragment_output_0.x = fragment_unnamed_757;
						fragment_output_0.y = fragment_unnamed_758;
						fragment_unnamed_79 = fragment_unnamed_48;
					}
					else
					{
						fragment_output_0.x = fragment_unnamed_578;
						fragment_output_0.y = fragment_unnamed_579;
						fragment_unnamed_79 = asfloat(0u);
					}
					fragment_unnamed_78 = fragment_unnamed_79;
				}
				else
				{
					fragment_output_0.x = 0.0f;
					fragment_output_0.y = 0.0f;
					fragment_unnamed_78 = fragment_unnamed_48;
				}
				if (0.0f < fragment_unnamed_78)
				{
					float fragment_unnamed_153;
					float fragment_unnamed_155;
					float fragment_unnamed_157;
					fragment_unnamed_153 = fragment_input_3.y;
					fragment_unnamed_155 = asfloat(1065353216u);
					fragment_unnamed_157 = asfloat(0u);
					float4 fragment_unnamed_211;
					float2 fragment_unnamed_212;
					for (float fragment_unnamed_151 = fragment_input_3.x; !(((((fragment_input_4.z < fragment_unnamed_153) ? 4294967295u : 0u) & ((0.828100025653839111328125f < fragment_unnamed_155) ? 4294967295u : 0u)) & ((fragment_unnamed_157 == 0.0f) ? 4294967295u : 0u)) == 0u); fragment_unnamed_212 = float2(fragment_unnamed_151, fragment_unnamed_153), fragment_unnamed_211 = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_212, 0.0f), fragment_unnamed_151 = mad(fragment_uniform_buffer_0[28u].x, -0.0f, fragment_unnamed_151), fragment_unnamed_153 = mad(fragment_uniform_buffer_0[28u].y, -2.0f, fragment_unnamed_153), fragment_unnamed_155 = fragment_unnamed_211.x, fragment_unnamed_157 = fragment_unnamed_211.y)
					{
					}
					float fragment_unnamed_197 = mad(fragment_uniform_buffer_0[28u].y, mad(_SearchTex.SampleLevel(sampler_MainTex, float2(mad(fragment_unnamed_157, 0.5f, 0.0078125f), mad(fragment_unnamed_155, -2.0f, 2.03125f)), 0.0f).w, -2.007874011993408203125f, 3.25f), fragment_unnamed_153);
					float fragment_unnamed_292;
					float fragment_unnamed_294;
					float fragment_unnamed_296;
					fragment_unnamed_292 = fragment_input_3.w;
					fragment_unnamed_294 = asfloat(0u);
					fragment_unnamed_296 = asfloat(1065353216u);
					float4 fragment_unnamed_439;
					float2 fragment_unnamed_440;
					for (float fragment_unnamed_290 = fragment_input_3.z; !((((fragment_unnamed_294 == 0.0f) ? 4294967295u : 0u) & (((0.828100025653839111328125f < fragment_unnamed_296) ? 4294967295u : 0u) & ((fragment_unnamed_292 < fragment_input_4.w) ? 4294967295u : 0u))) == 0u); fragment_unnamed_440 = float2(fragment_unnamed_290, fragment_unnamed_292), fragment_unnamed_439 = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_440, 0.0f), fragment_unnamed_290 = mad(fragment_uniform_buffer_0[28u].x, 0.0f, fragment_unnamed_290), fragment_unnamed_292 = mad(fragment_uniform_buffer_0[28u].y, 2.0f, fragment_unnamed_292), fragment_unnamed_294 = fragment_unnamed_439.y, fragment_unnamed_296 = fragment_unnamed_439.x)
					{
					}
					precise float fragment_unnamed_339 = (-0.0f) - fragment_uniform_buffer_0[28u].y;
					float fragment_unnamed_340 = mad(fragment_unnamed_339, mad(_SearchTex.SampleLevel(sampler_MainTex, float2(mad(fragment_unnamed_294, 0.5f, 0.5234375f), mad(fragment_unnamed_296, -2.0f, 2.03125f)), 0.0f).w, -2.007874011993408203125f, 3.25f), fragment_unnamed_292);
					precise float fragment_unnamed_346 = (-0.0f) - fragment_input_1.y;
					float fragment_unnamed_353 = round(mad(fragment_uniform_buffer_0[28u].w, fragment_unnamed_340, fragment_unnamed_346));
					float fragment_unnamed_354 = round(mad(fragment_uniform_buffer_0[28u].w, fragment_unnamed_197, fragment_unnamed_346));
					precise float fragment_unnamed_364 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_input_2.x, fragment_unnamed_197), 0.0f).y * 4.0f;
					precise float fragment_unnamed_366 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_input_2.x, fragment_unnamed_340), 0.0f, int2(0, 1)).y * 4.0f;
					float4 fragment_unnamed_376 = _AreaTex.SampleLevel(sampler_MainTex, float2(mad(mad(round(fragment_unnamed_364), 16.0f, sqrt(abs(fragment_unnamed_354))), 0.0062500000931322574615478515625f, 0.00312500004656612873077392578125f), mad(mad(round(fragment_unnamed_366), 16.0f, sqrt(abs(fragment_unnamed_353))), 0.001785714295692741870880126953125f, 0.0008928571478463709354400634765625f)), 0.0f);
					float fragment_unnamed_384 = abs(fragment_unnamed_354);
					float fragment_unnamed_385 = abs(fragment_unnamed_353);
					precise float fragment_unnamed_403 = asfloat(((abs(round(mad(fragment_uniform_buffer_0[28u].w, fragment_unnamed_197, fragment_unnamed_346))) >= fragment_unnamed_385) ? 4294967295u : 0u) & 1065353216u) + asfloat(((abs(round(mad(fragment_uniform_buffer_0[28u].w, fragment_unnamed_340, fragment_unnamed_346))) >= fragment_unnamed_384) ? 4294967295u : 0u) & 1065353216u);
					precise float fragment_unnamed_404 = asfloat(((abs(fragment_unnamed_353) >= fragment_unnamed_384) ? 4294967295u : 0u) & 1061158912u) / fragment_unnamed_403;
					precise float fragment_unnamed_405 = asfloat(((abs(fragment_unnamed_354) >= fragment_unnamed_385) ? 4294967295u : 0u) & 1061158912u) / fragment_unnamed_403;
					precise float fragment_unnamed_411 = (-0.0f) - fragment_unnamed_404;
					precise float fragment_unnamed_417 = (-0.0f) - fragment_unnamed_405;
					precise float fragment_unnamed_425 = (-0.0f) - fragment_unnamed_404;
					precise float fragment_unnamed_431 = (-0.0f) - fragment_unnamed_405;
					precise float fragment_unnamed_434 = fragment_unnamed_376.x * clamp(mad(fragment_unnamed_417, _MainTex.SampleLevel(sampler_MainTex, float2(fragment_input_1.x, fragment_unnamed_340), 0.0f, int2(1, 1)).y, mad(fragment_unnamed_411, _MainTex.SampleLevel(sampler_MainTex, float2(fragment_input_1.x, fragment_unnamed_197), 0.0f, int2(1, 0)).y, 1.0f)), 0.0f, 1.0f);
					precise float fragment_unnamed_435 = fragment_unnamed_376.y * clamp(mad(fragment_unnamed_431, _MainTex.SampleLevel(sampler_MainTex, float2(fragment_input_1.x, fragment_unnamed_340), 0.0f, int2(-2, 1)).y, mad(fragment_unnamed_425, _MainTex.SampleLevel(sampler_MainTex, float2(fragment_input_1.x, fragment_unnamed_197), 0.0f, int2(-2, 0)).y, 1.0f)), 0.0f, 1.0f);
					fragment_output_0.z = fragment_unnamed_434;
					fragment_output_0.w = fragment_unnamed_435;
				}
				else
				{
					fragment_output_0.z = 0.0f;
					fragment_output_0.w = 0.0f;
				}
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[28] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
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
			GpuProgramID 422248

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.0


			float4 _MainTex_TexelSize;

			static float4 vertex_uniform_buffer_0[29];
			static float4 gl_Position;
			static float3 vertex_input_0;
			static float2 vertex_output_1;
			static float4 vertex_output_2;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				float4 vertex_output_2 : TEXCOORD1; // TEXCOORD_1
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
				float vertex_unnamed_45 = mad(vertex_unnamed_42, 0.5f, 0.0f);
				float vertex_unnamed_47 = mad(vertex_unnamed_43, -0.5f, 1.0f);
				vertex_output_1.x = vertex_unnamed_45;
				vertex_output_1.y = vertex_unnamed_47;
				vertex_output_2.x = mad(vertex_uniform_buffer_0[28u].x, 1.0f, vertex_unnamed_45);
				vertex_output_2.y = mad(vertex_uniform_buffer_0[28u].y, 0.0f, vertex_unnamed_47);
				vertex_output_2.z = mad(vertex_uniform_buffer_0[28u].x, 0.0f, vertex_unnamed_45);
				vertex_output_2.w = mad(vertex_uniform_buffer_0[28u].y, 1.0f, vertex_unnamed_47);
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[28] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				return stage_output;
			}


			float4 _MainTex_TexelSize;

			static float4 gl_Position;
			static float3 vertex_input_0;
			static float2 vertex_output_0;
			static float4 vertex_output_1;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION;
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_0 : TEXCOORD0; // vs_TEXCOORD0
				float4 vertex_output_1 : TEXCOORD1; // vs_TEXCOORD1
				float4 gl_Position : SV_Position;
			};

			static float2 vertex_unnamed_33;

			void vert_main()
			{
				gl_Position = float4(vertex_input_0.xy.x, vertex_input_0.xy.y, gl_Position.z, gl_Position.w);
				gl_Position = float4(gl_Position.x, gl_Position.y, float2(0.0f, 1.0f).x, float2(0.0f, 1.0f).y);
				vertex_unnamed_33 = vertex_input_0.xy + 1.0f.xx;
				vertex_unnamed_33 = (vertex_unnamed_33 * float2(0.5f, -0.5f)) + float2(0.0f, 1.0f);
				vertex_output_0 = vertex_unnamed_33;
				vertex_output_1 = (_MainTex_TexelSize.xyxy * float4(1.0f, 0.0f, 0.0f, 1.0f)) + vertex_unnamed_33.xyxy;
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

			Texture2D<float4> _BlendTex;
			SamplerState sampler_MainTex;
			Texture2D<float4> _MainTex;

			static float4 fragment_input_1;
			static float2 fragment_input_0;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_0 : TEXCOORD0; // vs_TEXCOORD0
				float4 fragment_input_1 : TEXCOORD1; // vs_TEXCOORD1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static float4 fragment_unnamed_9;
			static float4 fragment_unnamed_51;
			static bool fragment_unnamed_59;
			static float4 fragment_unnamed_89;
			static float fragment_unnamed_136;

			void frag_main()
			{
				fragment_unnamed_9.x = _BlendTex.Sample(sampler_MainTex, fragment_input_1.xy).w;
				fragment_unnamed_9.y = _BlendTex.Sample(sampler_MainTex, fragment_input_1.zw).y;
				float2 fragment_unnamed_48 = _BlendTex.Sample(sampler_MainTex, fragment_input_0).zx;
				fragment_unnamed_9 = float4(fragment_unnamed_9.x, fragment_unnamed_9.y, fragment_unnamed_48.x, fragment_unnamed_48.y);
				fragment_unnamed_51.x = dot(fragment_unnamed_9, 1.0f.xxxx);
				fragment_unnamed_59 = fragment_unnamed_51.x < 9.9999997473787516355514526367188e-06f;
				if (fragment_unnamed_59)
				{
					fragment_output_0 = _MainTex.SampleLevel(sampler_MainTex, fragment_input_0, 0.0f);
				}
				else
				{
					float2 fragment_unnamed_81 = max(fragment_unnamed_9.zw, fragment_unnamed_9.xy);
					fragment_unnamed_51 = float4(fragment_unnamed_81.x, fragment_unnamed_81.y, fragment_unnamed_51.z, fragment_unnamed_51.w);
					fragment_unnamed_59 = fragment_unnamed_51.y < fragment_unnamed_51.x;
					float2 fragment_unnamed_92;
					if (fragment_unnamed_59)
					{
						fragment_unnamed_92 = fragment_unnamed_9.xz;
					}
					else
					{
						fragment_unnamed_92 = 0.0f.xx;
					}
					fragment_unnamed_89 = float4(fragment_unnamed_92.x, fragment_unnamed_89.y, fragment_unnamed_92.y, fragment_unnamed_89.w);
					float2 fragment_unnamed_103;
					if (fragment_unnamed_59)
					{
						fragment_unnamed_103 = 0.0f.xx;
					}
					else
					{
						fragment_unnamed_103 = fragment_unnamed_9.yw;
					}
					fragment_unnamed_89 = float4(fragment_unnamed_89.x, fragment_unnamed_103.x, fragment_unnamed_89.z, fragment_unnamed_103.y);
					float fragment_unnamed_114;
					if (fragment_unnamed_59)
					{
						fragment_unnamed_114 = fragment_unnamed_9.x;
					}
					else
					{
						fragment_unnamed_114 = fragment_unnamed_9.y;
					}
					fragment_unnamed_9.x = fragment_unnamed_114;
					float fragment_unnamed_125;
					if (fragment_unnamed_59)
					{
						fragment_unnamed_125 = fragment_unnamed_9.z;
					}
					else
					{
						fragment_unnamed_125 = fragment_unnamed_9.w;
					}
					fragment_unnamed_9.y = fragment_unnamed_125;
					fragment_unnamed_136 = dot(fragment_unnamed_9.xy, 1.0f.xx);
					float2 fragment_unnamed_145 = fragment_unnamed_9.xy / fragment_unnamed_136.xx;
					fragment_unnamed_9 = float4(fragment_unnamed_145.x, fragment_unnamed_145.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
					fragment_unnamed_51 = _MainTex_TexelSize.xyxy * float4(1.0f, 1.0f, -1.0f, -1.0f);
					fragment_unnamed_51 = (fragment_unnamed_89 * fragment_unnamed_51) + fragment_input_0.xyxy;
					fragment_unnamed_89 = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_51.xy, 0.0f);
					fragment_unnamed_51 = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_51.zw, 0.0f);
					fragment_unnamed_51 = fragment_unnamed_9.yyyy * fragment_unnamed_51;
					fragment_output_0 = (fragment_unnamed_9.xxxx * fragment_unnamed_89) + fragment_unnamed_51;
				}
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


			float4 _MainTex_TexelSize;

			static float4 fragment_uniform_buffer_0[29];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _BlendTex;
			SamplerState sampler_MainTex;

			static float2 fragment_input_1;
			static float4 fragment_input_2;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD; // TEXCOORD
				float4 fragment_input_2 : TEXCOORD1; // TEXCOORD_1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				float4 fragment_unnamed_41 = _BlendTex.Sample(sampler_MainTex, float2(fragment_input_2.x, fragment_input_2.y));
				float fragment_unnamed_43 = fragment_unnamed_41.w;
				uint fragment_unnamed_44 = asuint(fragment_unnamed_43);
				float4 fragment_unnamed_51 = _BlendTex.Sample(sampler_MainTex, float2(fragment_input_2.z, fragment_input_2.w));
				float fragment_unnamed_53 = fragment_unnamed_51.y;
				float4 fragment_unnamed_58 = _BlendTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				float fragment_unnamed_60 = fragment_unnamed_58.z;
				float fragment_unnamed_61 = fragment_unnamed_58.x;
				if (dot(float4(fragment_unnamed_43, fragment_unnamed_53, fragment_unnamed_60, fragment_unnamed_61), 1.0f.xxxx) < 9.9999997473787516355514526367188e-06f)
				{
					float4 fragment_unnamed_74 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y), 0.0f);
					fragment_output_0.x = fragment_unnamed_74.x;
					fragment_output_0.y = fragment_unnamed_74.y;
					fragment_output_0.z = fragment_unnamed_74.z;
					fragment_output_0.w = fragment_unnamed_74.w;
				}
				else
				{
					bool fragment_unnamed_88 = max(fragment_unnamed_61, fragment_unnamed_53) < max(fragment_unnamed_43, fragment_unnamed_60);
					uint fragment_unnamed_90 = fragment_unnamed_88 ? 4294967295u : 0u;
					float fragment_unnamed_104 = asfloat(fragment_unnamed_88 ? fragment_unnamed_44 : asuint(fragment_unnamed_53));
					float fragment_unnamed_108 = asfloat(fragment_unnamed_88 ? asuint(fragment_unnamed_60) : asuint(fragment_unnamed_61));
					float fragment_unnamed_109 = dot(float2(fragment_unnamed_104, fragment_unnamed_108), 1.0f.xx);
					precise float fragment_unnamed_112 = fragment_unnamed_104 / fragment_unnamed_109;
					precise float fragment_unnamed_113 = fragment_unnamed_108 / fragment_unnamed_109;
					precise float fragment_unnamed_120 = fragment_uniform_buffer_0[28u].x * 1.0f;
					precise float fragment_unnamed_121 = fragment_uniform_buffer_0[28u].y * 1.0f;
					precise float fragment_unnamed_122 = fragment_uniform_buffer_0[28u].x * (-1.0f);
					precise float fragment_unnamed_124 = fragment_uniform_buffer_0[28u].y * (-1.0f);
					float4 fragment_unnamed_134 = _MainTex.SampleLevel(sampler_MainTex, float2(mad(asfloat(fragment_unnamed_44 & fragment_unnamed_90), fragment_unnamed_120, fragment_input_1.x), mad(asfloat(fragment_unnamed_88 ? 0u : asuint(fragment_unnamed_53)), fragment_unnamed_121, fragment_input_1.y)), 0.0f);
					float4 fragment_unnamed_140 = _MainTex.SampleLevel(sampler_MainTex, float2(mad(asfloat(asuint(fragment_unnamed_60) & fragment_unnamed_90), fragment_unnamed_122, fragment_input_1.x), mad(asfloat(fragment_unnamed_88 ? 0u : asuint(fragment_unnamed_61)), fragment_unnamed_124, fragment_input_1.y)), 0.0f);
					precise float fragment_unnamed_146 = fragment_unnamed_113 * fragment_unnamed_140.x;
					precise float fragment_unnamed_147 = fragment_unnamed_113 * fragment_unnamed_140.y;
					precise float fragment_unnamed_148 = fragment_unnamed_113 * fragment_unnamed_140.z;
					precise float fragment_unnamed_149 = fragment_unnamed_113 * fragment_unnamed_140.w;
					fragment_output_0.x = mad(fragment_unnamed_112, fragment_unnamed_134.x, fragment_unnamed_146);
					fragment_output_0.y = mad(fragment_unnamed_112, fragment_unnamed_134.y, fragment_unnamed_147);
					fragment_output_0.z = mad(fragment_unnamed_112, fragment_unnamed_134.z, fragment_unnamed_148);
					fragment_output_0.w = mad(fragment_unnamed_112, fragment_unnamed_134.w, fragment_unnamed_149);
				}
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[28] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			ENDHLSL
		}
	}
}
