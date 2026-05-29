Shader "Hidden/Custom/PaletteMatch"
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
			GpuProgramID 61744

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

			float _Blend;

			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;
			Texture2D<float4> _Palette;
			SamplerState sampler_Palette;

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
			static bool fragment_unnamed_27;
			static float4 fragment_unnamed_37;
			static float3 fragment_unnamed_53;
			static bool fragment_unnamed_74;
			static float2 fragment_unnamed_80;
			static float3 fragment_unnamed_87;
			static float fragment_unnamed_94;
			static float fragment_unnamed_112;
			static float2 fragment_unnamed_119;
			static bool3 fragment_unnamed_128;
			static float fragment_unnamed_196;

			void frag_main()
			{
				fragment_unnamed_9 = _MainTex.Sample(sampler_MainTex, fragment_input_0);
				fragment_unnamed_27 = fragment_unnamed_9.y < fragment_unnamed_9.x;
				float2 fragment_unnamed_40;
				if (fragment_unnamed_27)
				{
					fragment_unnamed_40 = fragment_unnamed_9.yx;
				}
				else
				{
					fragment_unnamed_40 = fragment_unnamed_9.xy;
				}
				fragment_unnamed_37 = float4(fragment_unnamed_40.x, fragment_unnamed_40.y, fragment_unnamed_37.z, fragment_unnamed_37.w);
				fragment_unnamed_53.z = max(fragment_unnamed_9.z, fragment_unnamed_37.y);
				fragment_unnamed_37.x = min(fragment_unnamed_9.z, fragment_unnamed_37.x);
				fragment_unnamed_37.x = (-fragment_unnamed_37.x) + fragment_unnamed_53.z;
				fragment_unnamed_74 = fragment_unnamed_37.x != 0.0f;
				fragment_unnamed_80.y = fragment_unnamed_37.x / fragment_unnamed_53.z;
				fragment_unnamed_87 = (-fragment_unnamed_9.yzx) + fragment_unnamed_53.zzz;
				fragment_unnamed_94 = fragment_unnamed_37.x * 6.0f;
				fragment_unnamed_87 = (fragment_unnamed_37.xxx * 3.0f.xxx) + fragment_unnamed_87;
				float3 fragment_unnamed_109 = fragment_unnamed_87 / fragment_unnamed_94.xxx;
				fragment_unnamed_37 = float4(fragment_unnamed_109.x, fragment_unnamed_37.y, fragment_unnamed_109.y, fragment_unnamed_109.z);
				fragment_unnamed_112 = (-fragment_unnamed_37.x) + fragment_unnamed_37.z;
				fragment_unnamed_119 = fragment_unnamed_37.wx + float2(0.3333333432674407958984375f, 0.666666686534881591796875f);
				fragment_unnamed_128 = bool4(fragment_unnamed_9.xyzx.x == fragment_unnamed_53.zzzz.x, fragment_unnamed_9.xyzx.y == fragment_unnamed_53.zzzz.y, fragment_unnamed_9.xyzx.z == fragment_unnamed_53.zzzz.z, fragment_unnamed_9.xyzx.w == fragment_unnamed_53.zzzz.w).xyz;
				float2 fragment_unnamed_140 = (-fragment_unnamed_37.zw) + fragment_unnamed_119;
				fragment_unnamed_37 = float4(fragment_unnamed_140.x, fragment_unnamed_37.y, fragment_unnamed_140.y, fragment_unnamed_37.w);
				float fragment_unnamed_146;
				if (fragment_unnamed_128.z)
				{
					fragment_unnamed_146 = fragment_unnamed_37.z;
				}
				else
				{
					fragment_unnamed_146 = 0.0f;
				}
				fragment_unnamed_94 = fragment_unnamed_146;
				float fragment_unnamed_155;
				if (fragment_unnamed_128.y)
				{
					fragment_unnamed_155 = fragment_unnamed_37.x;
				}
				else
				{
					fragment_unnamed_155 = fragment_unnamed_94;
				}
				fragment_unnamed_37.x = fragment_unnamed_155;
				float fragment_unnamed_166;
				if (fragment_unnamed_128.x)
				{
					fragment_unnamed_166 = fragment_unnamed_112;
				}
				else
				{
					fragment_unnamed_166 = fragment_unnamed_37.x;
				}
				fragment_unnamed_80.x = fragment_unnamed_166;
				float2 fragment_unnamed_176;
				if (fragment_unnamed_74)
				{
					fragment_unnamed_176 = fragment_unnamed_80;
				}
				else
				{
					fragment_unnamed_176 = 0.0f.xx;
				}
				fragment_unnamed_53 = float3(fragment_unnamed_176.x, fragment_unnamed_176.y, fragment_unnamed_53.z);
				fragment_unnamed_53 = fragment_unnamed_53;
				fragment_unnamed_53 = clamp(fragment_unnamed_53, 0.0f.xxx, 1.0f.xxx);
				fragment_unnamed_37.x = fragment_unnamed_53.z * 0.85000002384185791015625f;
				fragment_unnamed_196 = (fragment_unnamed_53.z * 0.25f) + fragment_unnamed_53.y;
				fragment_unnamed_74 = fragment_unnamed_196 < 0.5f;
				if (fragment_unnamed_74)
				{
					fragment_unnamed_37.z = 0.02999999932944774627685546875f;
					float3 fragment_unnamed_220 = _Palette.Sample(sampler_Palette, fragment_unnamed_37.zx).xyz;
					fragment_unnamed_37 = float4(fragment_unnamed_220.x, fragment_unnamed_220.y, fragment_unnamed_220.z, fragment_unnamed_37.w);
				}
				else
				{
					float2 fragment_unnamed_231 = (fragment_unnamed_53.xz * float2(0.875f, 0.85000002384185791015625f)) + float2(0.1875f, 0.0f);
					fragment_unnamed_53 = float3(fragment_unnamed_231.x, fragment_unnamed_231.y, fragment_unnamed_53.z);
					float3 fragment_unnamed_240 = _Palette.Sample(sampler_Palette, fragment_unnamed_53.xy).xyz;
					fragment_unnamed_37 = float4(fragment_unnamed_240.x, fragment_unnamed_240.y, fragment_unnamed_240.z, fragment_unnamed_37.w);
				}
				float3 fragment_unnamed_248 = (-fragment_unnamed_9.xyz) + fragment_unnamed_37.xyz;
				fragment_unnamed_37 = float4(fragment_unnamed_248.x, fragment_unnamed_248.y, fragment_unnamed_248.z, fragment_unnamed_37.w);
				float3 fragment_unnamed_267 = (_Blend.xxx * fragment_unnamed_37.xyz) + fragment_unnamed_9.xyz;
				fragment_output_0 = float4(fragment_unnamed_267.x, fragment_unnamed_267.y, fragment_unnamed_267.z, fragment_output_0.w);
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


			float _Blend;

			static float4 fragment_uniform_buffer_0[29];
			Texture2D<float4> _Palette;
			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;
			SamplerState sampler_Palette;

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
				float4 fragment_unnamed_43 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				float fragment_unnamed_45 = fragment_unnamed_43.x;
				float fragment_unnamed_46 = fragment_unnamed_43.y;
				float fragment_unnamed_47 = fragment_unnamed_43.z;
				bool fragment_unnamed_50 = fragment_unnamed_46 < fragment_unnamed_45;
				float fragment_unnamed_60 = max(fragment_unnamed_47, asfloat(fragment_unnamed_50 ? asuint(fragment_unnamed_45) : asuint(fragment_unnamed_46)));
				precise float fragment_unnamed_62 = (-0.0f) - min(fragment_unnamed_47, asfloat(fragment_unnamed_50 ? asuint(fragment_unnamed_46) : asuint(fragment_unnamed_45)));
				precise float fragment_unnamed_64 = fragment_unnamed_62 + fragment_unnamed_60;
				uint fragment_unnamed_67 = (fragment_unnamed_64 != 0.0f) ? 4294967295u : 0u;
				precise float fragment_unnamed_68 = fragment_unnamed_64 / fragment_unnamed_60;
				precise float fragment_unnamed_69 = (-0.0f) - fragment_unnamed_46;
				precise float fragment_unnamed_70 = (-0.0f) - fragment_unnamed_47;
				precise float fragment_unnamed_71 = (-0.0f) - fragment_unnamed_45;
				precise float fragment_unnamed_72 = fragment_unnamed_69 + fragment_unnamed_60;
				precise float fragment_unnamed_73 = fragment_unnamed_70 + fragment_unnamed_60;
				precise float fragment_unnamed_74 = fragment_unnamed_71 + fragment_unnamed_60;
				precise float fragment_unnamed_75 = fragment_unnamed_64 * 6.0f;
				precise float fragment_unnamed_81 = mad(fragment_unnamed_64, 3.0f, fragment_unnamed_72) / fragment_unnamed_75;
				precise float fragment_unnamed_82 = mad(fragment_unnamed_64, 3.0f, fragment_unnamed_73) / fragment_unnamed_75;
				precise float fragment_unnamed_83 = mad(fragment_unnamed_64, 3.0f, fragment_unnamed_74) / fragment_unnamed_75;
				precise float fragment_unnamed_84 = (-0.0f) - fragment_unnamed_81;
				precise float fragment_unnamed_85 = fragment_unnamed_84 + fragment_unnamed_82;
				precise float fragment_unnamed_86 = fragment_unnamed_83 + 0.3333333432674407958984375f;
				precise float fragment_unnamed_88 = fragment_unnamed_81 + 0.666666686534881591796875f;
				precise float fragment_unnamed_94 = (-0.0f) - fragment_unnamed_82;
				precise float fragment_unnamed_95 = (-0.0f) - fragment_unnamed_83;
				precise float fragment_unnamed_96 = fragment_unnamed_94 + fragment_unnamed_86;
				precise float fragment_unnamed_97 = fragment_unnamed_95 + fragment_unnamed_88;
				float fragment_unnamed_112 = clamp(fragment_unnamed_60, 0.0f, 1.0f);
				precise float fragment_unnamed_113 = fragment_unnamed_112 * 0.85000002384185791015625f;
				float fragment_unnamed_137;
				float fragment_unnamed_138;
				float fragment_unnamed_139;
				if (mad(fragment_unnamed_112, 0.25f, clamp(asfloat(fragment_unnamed_67 & asuint(fragment_unnamed_68)), 0.0f, 1.0f)) < 0.5f)
				{
					float4 fragment_unnamed_122 = _Palette.Sample(sampler_Palette, float2(asfloat(1022739087u), fragment_unnamed_113));
					fragment_unnamed_137 = fragment_unnamed_122.z;
					fragment_unnamed_138 = fragment_unnamed_122.y;
					fragment_unnamed_139 = fragment_unnamed_122.x;
				}
				else
				{
					float4 fragment_unnamed_132 = _Palette.Sample(sampler_Palette, float2(mad(clamp(asfloat(fragment_unnamed_67 & ((fragment_unnamed_45 == fragment_unnamed_60) ? asuint(fragment_unnamed_85) : ((fragment_unnamed_46 == fragment_unnamed_60) ? asuint(fragment_unnamed_96) : (asuint(fragment_unnamed_97) & ((fragment_unnamed_47 == fragment_unnamed_60) ? 4294967295u : 0u))))), 0.0f, 1.0f), 0.875f, 0.1875f), mad(fragment_unnamed_112, 0.85000002384185791015625f, 0.0f)));
					fragment_unnamed_137 = fragment_unnamed_132.z;
					fragment_unnamed_138 = fragment_unnamed_132.y;
					fragment_unnamed_139 = fragment_unnamed_132.x;
				}
				precise float fragment_unnamed_140 = (-0.0f) - fragment_unnamed_45;
				precise float fragment_unnamed_141 = (-0.0f) - fragment_unnamed_46;
				precise float fragment_unnamed_142 = (-0.0f) - fragment_unnamed_47;
				precise float fragment_unnamed_143 = fragment_unnamed_140 + fragment_unnamed_139;
				precise float fragment_unnamed_144 = fragment_unnamed_141 + fragment_unnamed_138;
				precise float fragment_unnamed_145 = fragment_unnamed_142 + fragment_unnamed_137;
				fragment_output_0.x = mad(fragment_uniform_buffer_0[28u].x, fragment_unnamed_143, fragment_unnamed_45);
				fragment_output_0.y = mad(fragment_uniform_buffer_0[28u].x, fragment_unnamed_144, fragment_unnamed_46);
				fragment_output_0.z = mad(fragment_uniform_buffer_0[28u].x, fragment_unnamed_145, fragment_unnamed_47);
				fragment_output_0.w = fragment_unnamed_43.w;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[28] = float4(_Blend, fragment_uniform_buffer_0[28][1], fragment_uniform_buffer_0[28][2], fragment_uniform_buffer_0[28][3]);

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
