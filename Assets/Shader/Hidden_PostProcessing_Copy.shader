Shader "Hidden/PostProcessing/Copy"
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
			GpuProgramID 17990

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

			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

			static float4 fragment_output_0;
			static float2 fragment_input_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_0 : TEXCOORD1; // vs_TEXCOORD1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				fragment_output_0 = _MainTex.Sample(sampler_MainTex, fragment_input_0);
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_0 = stage_input.fragment_input_0;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


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
				float4 fragment_unnamed_34 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				fragment_output_0.x = fragment_unnamed_34.x;
				fragment_output_0.y = fragment_unnamed_34.y;
				fragment_output_0.z = fragment_unnamed_34.z;
				fragment_output_0.w = fragment_unnamed_34.w;
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
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 87767

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
			static bool4 fragment_unnamed_28;
			static bool4 fragment_unnamed_33;
			static int4 fragment_unnamed_39;

			void frag_main()
			{
				fragment_unnamed_9 = _MainTex.Sample(sampler_MainTex, fragment_input_0);
				fragment_unnamed_28 = bool4(fragment_unnamed_9.x < 0.0f.xxxx.x, fragment_unnamed_9.y < 0.0f.xxxx.y, fragment_unnamed_9.z < 0.0f.xxxx.z, fragment_unnamed_9.w < 0.0f.xxxx.w);
				fragment_unnamed_33 = bool4(0.0f.xxxx.x < fragment_unnamed_9.x, 0.0f.xxxx.y < fragment_unnamed_9.y, 0.0f.xxxx.z < fragment_unnamed_9.z, 0.0f.xxxx.w < fragment_unnamed_9.w);
				fragment_unnamed_39 = int4((uint4(fragment_unnamed_28) * uint4(4294967295u, 4294967295u, 4294967295u, 4294967295u)) | (uint4(fragment_unnamed_33) * uint4(4294967295u, 4294967295u, 4294967295u, 4294967295u)));
				fragment_unnamed_33 = bool4(fragment_unnamed_9.x == 0.0f.xxxx.x, fragment_unnamed_9.y == 0.0f.xxxx.y, fragment_unnamed_9.z == 0.0f.xxxx.z, fragment_unnamed_9.w == 0.0f.xxxx.w);
				fragment_unnamed_39 = int4(uint4(fragment_unnamed_39) | (uint4(fragment_unnamed_33) * uint4(4294967295u, 4294967295u, 4294967295u, 4294967295u)));
				fragment_unnamed_28 = bool4(fragment_unnamed_39.x == int4(0, 0, 0, 0).x, fragment_unnamed_39.y == int4(0, 0, 0, 0).y, fragment_unnamed_39.z == int4(0, 0, 0, 0).z, fragment_unnamed_39.w == int4(0, 0, 0, 0).w);
				fragment_unnamed_28.x = fragment_unnamed_28.y || fragment_unnamed_28.x;
				fragment_unnamed_28.x = fragment_unnamed_28.z || fragment_unnamed_28.x;
				fragment_unnamed_28.x = fragment_unnamed_28.w || fragment_unnamed_28.x;
				bool4 fragment_unnamed_97 = fragment_unnamed_28.x.xxxx;
				fragment_output_0 = float4(fragment_unnamed_97.x ? 0.0f.xxxx.x : fragment_unnamed_9.x, fragment_unnamed_97.y ? 0.0f.xxxx.y : fragment_unnamed_9.y, fragment_unnamed_97.z ? 0.0f.xxxx.z : fragment_unnamed_9.z, fragment_unnamed_97.w ? 0.0f.xxxx.w : fragment_unnamed_9.w);
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_0 = stage_input.fragment_input_0;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


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
				float4 fragment_unnamed_34 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				float fragment_unnamed_36 = fragment_unnamed_34.x;
				float fragment_unnamed_37 = fragment_unnamed_34.y;
				float fragment_unnamed_38 = fragment_unnamed_34.z;
				float fragment_unnamed_39 = fragment_unnamed_34.w;
				bool fragment_unnamed_85 = (((((((fragment_unnamed_39 < 0.0f) ? 4294967295u : 0u) | ((0.0f < fragment_unnamed_39) ? 4294967295u : 0u)) | ((fragment_unnamed_39 == 0.0f) ? 4294967295u : 0u)) == 0u) ? 4294967295u : 0u) | (((((((fragment_unnamed_38 < 0.0f) ? 4294967295u : 0u) | ((0.0f < fragment_unnamed_38) ? 4294967295u : 0u)) | ((fragment_unnamed_38 == 0.0f) ? 4294967295u : 0u)) == 0u) ? 4294967295u : 0u) | (((((((fragment_unnamed_37 < 0.0f) ? 4294967295u : 0u) | ((0.0f < fragment_unnamed_37) ? 4294967295u : 0u)) | ((fragment_unnamed_37 == 0.0f) ? 4294967295u : 0u)) == 0u) ? 4294967295u : 0u) | ((((((fragment_unnamed_36 < 0.0f) ? 4294967295u : 0u) | ((0.0f < fragment_unnamed_36) ? 4294967295u : 0u)) | ((fragment_unnamed_36 == 0.0f) ? 4294967295u : 0u)) == 0u) ? 4294967295u : 0u)))) != 0u;
				fragment_output_0.x = fragment_unnamed_85 ? 0.0f : fragment_unnamed_36;
				fragment_output_0.y = fragment_unnamed_85 ? 0.0f : fragment_unnamed_37;
				fragment_output_0.z = fragment_unnamed_85 ? 0.0f : fragment_unnamed_38;
				fragment_output_0.w = fragment_unnamed_85 ? 0.0f : fragment_unnamed_39;
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
