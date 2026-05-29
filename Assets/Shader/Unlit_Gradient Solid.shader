Shader "Unlit/Gradient Solid"
{
	Properties
	{
		_Color ("Main Color", Color) = (1,1,1,1)
	}
	SubShader
	{
		LOD 100
		Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass
		{
			LOD 100
			Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ZWrite Off
			Cull Off
			GpuProgramID 59903

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.0


			float4 _Color;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[3];
			static float4 vertex_uniform_buffer_1[4];
			static float4 vertex_uniform_buffer_2[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float2 vertex_input_1;
			static float4 vertex_output_1;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION; // POSITION
				float2 vertex_input_1 : TEXCOORD0; // TEXCOORD
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : COLOR; // COLOR
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_43 = vertex_input_0.y * vertex_uniform_buffer_1[1u].x;
				precise float vertex_unnamed_44 = vertex_input_0.y * vertex_uniform_buffer_1[1u].y;
				precise float vertex_unnamed_45 = vertex_input_0.y * vertex_uniform_buffer_1[1u].z;
				precise float vertex_unnamed_46 = vertex_input_0.y * vertex_uniform_buffer_1[1u].w;
				precise float vertex_unnamed_79 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_0.x, vertex_unnamed_43)) + vertex_uniform_buffer_1[3u].x;
				precise float vertex_unnamed_80 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_0.x, vertex_unnamed_44)) + vertex_uniform_buffer_1[3u].y;
				precise float vertex_unnamed_81 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_0.x, vertex_unnamed_45)) + vertex_uniform_buffer_1[3u].z;
				precise float vertex_unnamed_82 = mad(vertex_uniform_buffer_1[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].w, vertex_input_0.x, vertex_unnamed_46)) + vertex_uniform_buffer_1[3u].w;
				precise float vertex_unnamed_90 = vertex_unnamed_80 * vertex_uniform_buffer_2[18u].x;
				precise float vertex_unnamed_91 = vertex_unnamed_80 * vertex_uniform_buffer_2[18u].y;
				precise float vertex_unnamed_92 = vertex_unnamed_80 * vertex_uniform_buffer_2[18u].z;
				precise float vertex_unnamed_93 = vertex_unnamed_80 * vertex_uniform_buffer_2[18u].w;
				gl_Position.x = mad(vertex_uniform_buffer_2[20u].x, vertex_unnamed_82, mad(vertex_uniform_buffer_2[19u].x, vertex_unnamed_81, mad(vertex_uniform_buffer_2[17u].x, vertex_unnamed_79, vertex_unnamed_90)));
				gl_Position.y = mad(vertex_uniform_buffer_2[20u].y, vertex_unnamed_82, mad(vertex_uniform_buffer_2[19u].y, vertex_unnamed_81, mad(vertex_uniform_buffer_2[17u].y, vertex_unnamed_79, vertex_unnamed_91)));
				gl_Position.z = mad(vertex_uniform_buffer_2[20u].z, vertex_unnamed_82, mad(vertex_uniform_buffer_2[19u].z, vertex_unnamed_81, mad(vertex_uniform_buffer_2[17u].z, vertex_unnamed_79, vertex_unnamed_92)));
				gl_Position.w = mad(vertex_uniform_buffer_2[20u].w, vertex_unnamed_82, mad(vertex_uniform_buffer_2[19u].w, vertex_unnamed_81, mad(vertex_uniform_buffer_2[17u].w, vertex_unnamed_79, vertex_unnamed_93)));
				precise float vertex_unnamed_137 = vertex_input_1.y * vertex_uniform_buffer_0[2u].w;
				vertex_output_1.w = vertex_unnamed_137;
				vertex_output_1.x = vertex_uniform_buffer_0[2u].x;
				vertex_output_1.y = vertex_uniform_buffer_0[2u].y;
				vertex_output_1.z = vertex_uniform_buffer_0[2u].z;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[2] = float4(_Color[0], _Color[1], _Color[2], _Color[3]);

				vertex_uniform_buffer_1[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_1[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_1[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_1[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_2[17] = float4(unity_MatrixVP[0][0], unity_MatrixVP[1][0], unity_MatrixVP[2][0], unity_MatrixVP[3][0]);
				vertex_uniform_buffer_2[18] = float4(unity_MatrixVP[0][1], unity_MatrixVP[1][1], unity_MatrixVP[2][1], unity_MatrixVP[3][1]);
				vertex_uniform_buffer_2[19] = float4(unity_MatrixVP[0][2], unity_MatrixVP[1][2], unity_MatrixVP[2][2], unity_MatrixVP[3][2]);
				vertex_uniform_buffer_2[20] = float4(unity_MatrixVP[0][3], unity_MatrixVP[1][3], unity_MatrixVP[2][3], unity_MatrixVP[3][3]);

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
			float4 _Color;

			static float4 unity_ObjectToWorld__array[4];
			static float4 unity_MatrixVP__array[4];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_output_0;
			static float2 vertex_input_1;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION;
				float2 vertex_input_1 : TEXCOORD0;
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_0 : UNKNOWN0;
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
				vertex_output_0.w = vertex_input_1.y * _Color.w;
				vertex_output_0 = float4(_Color.xyz.x, _Color.xyz.y, _Color.xyz.z, vertex_output_0.w);
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

			static float4 fragment_output_0;
			static float4 fragment_input_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_0 : UNKNOWN0;
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				fragment_output_0 = fragment_input_0;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_0 = stage_input.fragment_input_0;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			static float4 fragment_input_1;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : COLOR; // COLOR
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				fragment_output_0.x = fragment_input_1.x;
				fragment_output_0.y = fragment_input_1.y;
				fragment_output_0.z = fragment_input_1.z;
				fragment_output_0.w = fragment_input_1.w;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
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
