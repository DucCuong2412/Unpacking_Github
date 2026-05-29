Shader "Hidden/PostProcessing/Texture2DLerp"
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
			GpuProgramID 64114

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

			float _Interp;

			Texture2D<float4> _To;
			SamplerState sampler_To;
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
			static float4 fragment_unnamed_25;

			void frag_main()
			{
				fragment_unnamed_9 = _To.Sample(sampler_To, fragment_input_0);
				fragment_unnamed_25 = _MainTex.Sample(sampler_MainTex, fragment_input_0);
				fragment_unnamed_9 += (-fragment_unnamed_25);
				fragment_output_0 = (_Interp.xxxx * fragment_unnamed_9) + fragment_unnamed_25;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_0 = stage_input.fragment_input_0;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			float _Interp;

			static float4 fragment_uniform_buffer_0[29];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _To;
			SamplerState sampler_MainTex;
			SamplerState sampler_To;

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
				float4 fragment_unnamed_43 = _To.Sample(sampler_To, float2(fragment_input_1.x, fragment_input_1.y));
				float4 fragment_unnamed_54 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				float fragment_unnamed_56 = fragment_unnamed_54.x;
				float fragment_unnamed_57 = fragment_unnamed_54.y;
				float fragment_unnamed_58 = fragment_unnamed_54.z;
				float fragment_unnamed_59 = fragment_unnamed_54.w;
				precise float fragment_unnamed_60 = (-0.0f) - fragment_unnamed_56;
				precise float fragment_unnamed_62 = (-0.0f) - fragment_unnamed_57;
				precise float fragment_unnamed_63 = (-0.0f) - fragment_unnamed_58;
				precise float fragment_unnamed_64 = (-0.0f) - fragment_unnamed_59;
				precise float fragment_unnamed_65 = fragment_unnamed_43.x + fragment_unnamed_60;
				precise float fragment_unnamed_66 = fragment_unnamed_43.y + fragment_unnamed_62;
				precise float fragment_unnamed_67 = fragment_unnamed_43.z + fragment_unnamed_63;
				precise float fragment_unnamed_68 = fragment_unnamed_43.w + fragment_unnamed_64;
				fragment_output_0.x = mad(fragment_uniform_buffer_0[28u].x, fragment_unnamed_65, fragment_unnamed_56);
				fragment_output_0.y = mad(fragment_uniform_buffer_0[28u].x, fragment_unnamed_66, fragment_unnamed_57);
				fragment_output_0.z = mad(fragment_uniform_buffer_0[28u].x, fragment_unnamed_67, fragment_unnamed_58);
				fragment_output_0.w = mad(fragment_uniform_buffer_0[28u].x, fragment_unnamed_68, fragment_unnamed_59);
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[28] = float4(_Interp, fragment_uniform_buffer_0[28][1], fragment_uniform_buffer_0[28][2], fragment_uniform_buffer_0[28][3]);

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
			GpuProgramID 130902

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

			float _Interp;
			float4 _TargetColor;

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
			static float4 fragment_unnamed_25;

			void frag_main()
			{
				fragment_unnamed_9 = _MainTex.Sample(sampler_MainTex, fragment_input_0);
				fragment_unnamed_25 = (-fragment_unnamed_9) + _TargetColor;
				fragment_output_0 = (_Interp.xxxx * fragment_unnamed_25) + fragment_unnamed_9;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_0 = stage_input.fragment_input_0;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			float _Interp;
			float4 _TargetColor;

			static float4 fragment_uniform_buffer_0[30];
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
				float4 fragment_unnamed_39 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				float fragment_unnamed_41 = fragment_unnamed_39.x;
				float fragment_unnamed_42 = fragment_unnamed_39.y;
				float fragment_unnamed_43 = fragment_unnamed_39.z;
				float fragment_unnamed_44 = fragment_unnamed_39.w;
				precise float fragment_unnamed_45 = (-0.0f) - fragment_unnamed_41;
				precise float fragment_unnamed_47 = (-0.0f) - fragment_unnamed_42;
				precise float fragment_unnamed_48 = (-0.0f) - fragment_unnamed_43;
				precise float fragment_unnamed_49 = (-0.0f) - fragment_unnamed_44;
				precise float fragment_unnamed_58 = fragment_unnamed_45 + fragment_uniform_buffer_0[29u].x;
				precise float fragment_unnamed_59 = fragment_unnamed_47 + fragment_uniform_buffer_0[29u].y;
				precise float fragment_unnamed_60 = fragment_unnamed_48 + fragment_uniform_buffer_0[29u].z;
				precise float fragment_unnamed_61 = fragment_unnamed_49 + fragment_uniform_buffer_0[29u].w;
				fragment_output_0.x = mad(fragment_uniform_buffer_0[28u].x, fragment_unnamed_58, fragment_unnamed_41);
				fragment_output_0.y = mad(fragment_uniform_buffer_0[28u].x, fragment_unnamed_59, fragment_unnamed_42);
				fragment_output_0.z = mad(fragment_uniform_buffer_0[28u].x, fragment_unnamed_60, fragment_unnamed_43);
				fragment_output_0.w = mad(fragment_uniform_buffer_0[28u].x, fragment_unnamed_61, fragment_unnamed_44);
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[28] = float4(_Interp, fragment_uniform_buffer_0[28][1], fragment_uniform_buffer_0[28][2], fragment_uniform_buffer_0[28][3]);

				fragment_uniform_buffer_0[29] = float4(_TargetColor[0], _TargetColor[1], _TargetColor[2], _TargetColor[3]);

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
