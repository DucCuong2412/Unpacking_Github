Shader "Hidden/OverlayComposite"
{
	Properties
	{
		_MainTex ("", 2D) = "" {}
		_Occlude ("", 2D) = "" {}
	}
	SubShader
	{
		Pass
		{
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 32614

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.0


			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[4];
			static float4 vertex_uniform_buffer_1[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float2 vertex_input_1;
			static float2 vertex_output_1;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION; // POSITION
				float2 vertex_input_1 : TEXCOORD0; // TEXCOORD
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_39 = vertex_input_0.y * vertex_uniform_buffer_0[1u].x;
				precise float vertex_unnamed_40 = vertex_input_0.y * vertex_uniform_buffer_0[1u].y;
				precise float vertex_unnamed_41 = vertex_input_0.y * vertex_uniform_buffer_0[1u].z;
				precise float vertex_unnamed_42 = vertex_input_0.y * vertex_uniform_buffer_0[1u].w;
				precise float vertex_unnamed_76 = mad(vertex_uniform_buffer_0[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].x, vertex_input_0.x, vertex_unnamed_39)) + vertex_uniform_buffer_0[3u].x;
				precise float vertex_unnamed_77 = mad(vertex_uniform_buffer_0[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].y, vertex_input_0.x, vertex_unnamed_40)) + vertex_uniform_buffer_0[3u].y;
				precise float vertex_unnamed_78 = mad(vertex_uniform_buffer_0[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].z, vertex_input_0.x, vertex_unnamed_41)) + vertex_uniform_buffer_0[3u].z;
				precise float vertex_unnamed_79 = mad(vertex_uniform_buffer_0[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].w, vertex_input_0.x, vertex_unnamed_42)) + vertex_uniform_buffer_0[3u].w;
				precise float vertex_unnamed_87 = vertex_unnamed_77 * vertex_uniform_buffer_1[18u].x;
				precise float vertex_unnamed_88 = vertex_unnamed_77 * vertex_uniform_buffer_1[18u].y;
				precise float vertex_unnamed_89 = vertex_unnamed_77 * vertex_uniform_buffer_1[18u].z;
				precise float vertex_unnamed_90 = vertex_unnamed_77 * vertex_uniform_buffer_1[18u].w;
				gl_Position.x = mad(vertex_uniform_buffer_1[20u].x, vertex_unnamed_79, mad(vertex_uniform_buffer_1[19u].x, vertex_unnamed_78, mad(vertex_uniform_buffer_1[17u].x, vertex_unnamed_76, vertex_unnamed_87)));
				gl_Position.y = mad(vertex_uniform_buffer_1[20u].y, vertex_unnamed_79, mad(vertex_uniform_buffer_1[19u].y, vertex_unnamed_78, mad(vertex_uniform_buffer_1[17u].y, vertex_unnamed_76, vertex_unnamed_88)));
				gl_Position.z = mad(vertex_uniform_buffer_1[20u].z, vertex_unnamed_79, mad(vertex_uniform_buffer_1[19u].z, vertex_unnamed_78, mad(vertex_uniform_buffer_1[17u].z, vertex_unnamed_76, vertex_unnamed_89)));
				gl_Position.w = mad(vertex_uniform_buffer_1[20u].w, vertex_unnamed_79, mad(vertex_uniform_buffer_1[19u].w, vertex_unnamed_78, mad(vertex_uniform_buffer_1[17u].w, vertex_unnamed_76, vertex_unnamed_90)));
				vertex_output_1.x = vertex_input_1.x;
				vertex_output_1.y = vertex_input_1.y;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_0[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_0[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_0[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_1[17] = float4(unity_MatrixVP[0][0], unity_MatrixVP[1][0], unity_MatrixVP[2][0], unity_MatrixVP[3][0]);
				vertex_uniform_buffer_1[18] = float4(unity_MatrixVP[0][1], unity_MatrixVP[1][1], unity_MatrixVP[2][1], unity_MatrixVP[3][1]);
				vertex_uniform_buffer_1[19] = float4(unity_MatrixVP[0][2], unity_MatrixVP[1][2], unity_MatrixVP[2][2], unity_MatrixVP[3][2]);
				vertex_uniform_buffer_1[20] = float4(unity_MatrixVP[0][3], unity_MatrixVP[1][3], unity_MatrixVP[2][3], unity_MatrixVP[3][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_1 = stage_input.vertex_input_1;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}


			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;

			static float4 unity_ObjectToWorld__array[4];
			static float4 unity_MatrixVP__array[4];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float2 vertex_output_0;
			static float2 vertex_input_1;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION;
				float2 vertex_input_1 : TEXCOORD0;
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_0 : TEXCOORD0; // vs_TEXCOORD0
				float4 gl_Position : SV_Position;
			};

			static float4 vertex_unnamed_9;
			static float4 vertex_unnamed_48;

			void vert_main()
			{
				vertex_unnamed_9 = vertex_input_0.yyyy * unity_ObjectToWorld__array[1];
				vertex_unnamed_9 = (unity_ObjectToWorld__array[0] * vertex_input_0.xxxx) + vertex_unnamed_9;
				vertex_unnamed_9 = (unity_ObjectToWorld__array[2] * vertex_input_0.zzzz) + vertex_unnamed_9;
				vertex_unnamed_9 += unity_ObjectToWorld__array[3];
				vertex_unnamed_48 = vertex_unnamed_9.yyyy * unity_MatrixVP__array[1];
				vertex_unnamed_48 = (unity_MatrixVP__array[0] * vertex_unnamed_9.xxxx) + vertex_unnamed_48;
				vertex_unnamed_48 = (unity_MatrixVP__array[2] * vertex_unnamed_9.zzzz) + vertex_unnamed_48;
				gl_Position = (unity_MatrixVP__array[3] * vertex_unnamed_9.wwww) + vertex_unnamed_48;
				vertex_output_0 = vertex_input_1;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				unity_ObjectToWorld__array[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				unity_ObjectToWorld__array[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				unity_ObjectToWorld__array[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				unity_ObjectToWorld__array[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				unity_MatrixVP__array[0] = float4(unity_MatrixVP[0][0], unity_MatrixVP[1][0], unity_MatrixVP[2][0], unity_MatrixVP[3][0]);
				unity_MatrixVP__array[1] = float4(unity_MatrixVP[0][1], unity_MatrixVP[1][1], unity_MatrixVP[2][1], unity_MatrixVP[3][1]);
				unity_MatrixVP__array[2] = float4(unity_MatrixVP[0][2], unity_MatrixVP[1][2], unity_MatrixVP[2][2], unity_MatrixVP[3][2]);
				unity_MatrixVP__array[3] = float4(unity_MatrixVP[0][3], unity_MatrixVP[1][3], unity_MatrixVP[2][3], unity_MatrixVP[3][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_1 = stage_input.vertex_input_1;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_0 = vertex_output_0;
				return stage_output;
			}

			float4 _OutlineColor;

			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;
			Texture2D<float4> _Occlude;
			SamplerState sampler_Occlude;

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
			static float fragment_unnamed_26;
			static float fragment_unnamed_37;

			void frag_main()
			{
				fragment_unnamed_9 = _MainTex.Sample(sampler_MainTex, fragment_input_0);
				fragment_unnamed_26 = _Occlude.Sample(sampler_Occlude, fragment_input_0).x;
				fragment_unnamed_37 = ((-fragment_unnamed_26) * _OutlineColor.w) + 1.0f;
				fragment_unnamed_26 *= _OutlineColor.w;
				fragment_unnamed_9 *= fragment_unnamed_37.xxxx;
				fragment_output_0 = (fragment_unnamed_26.xxxx * _OutlineColor) + fragment_unnamed_9;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_0 = stage_input.fragment_input_0;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			float4 _OutlineColor;

			static float4 fragment_uniform_buffer_0[3];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _Occlude;
			SamplerState sampler_MainTex;
			SamplerState sampler_Occlude;

			static float2 fragment_input_1;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD; // TEXCOORD
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				float4 fragment_unnamed_42 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				float4 fragment_unnamed_53 = _Occlude.Sample(sampler_Occlude, float2(fragment_input_1.x, fragment_input_1.y));
				float fragment_unnamed_55 = fragment_unnamed_53.x;
				precise float fragment_unnamed_56 = (-0.0f) - fragment_unnamed_55;
				float fragment_unnamed_64 = mad(fragment_unnamed_56, fragment_uniform_buffer_0[2u].w, 1.0f);
				precise float fragment_unnamed_69 = fragment_unnamed_55 * fragment_uniform_buffer_0[2u].w;
				precise float fragment_unnamed_70 = fragment_unnamed_42.x * fragment_unnamed_64;
				precise float fragment_unnamed_71 = fragment_unnamed_42.y * fragment_unnamed_64;
				precise float fragment_unnamed_72 = fragment_unnamed_42.z * fragment_unnamed_64;
				precise float fragment_unnamed_73 = fragment_unnamed_42.w * fragment_unnamed_64;
				fragment_output_0.x = mad(fragment_unnamed_69, fragment_uniform_buffer_0[2u].x, fragment_unnamed_70);
				fragment_output_0.y = mad(fragment_unnamed_69, fragment_uniform_buffer_0[2u].y, fragment_unnamed_71);
				fragment_output_0.z = mad(fragment_unnamed_69, fragment_uniform_buffer_0[2u].z, fragment_unnamed_72);
				fragment_output_0.w = mad(fragment_unnamed_69, fragment_uniform_buffer_0[2u].w, fragment_unnamed_73);
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[2] = float4(_OutlineColor[0], _OutlineColor[1], _OutlineColor[2], _OutlineColor[3]);

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
