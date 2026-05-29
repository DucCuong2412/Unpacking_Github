Shader "Sprites/Default Color Replace"
{
	Properties
	{
		[PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
		_Color ("Tint", Color) = (1,1,1,1)
		_Replace ("Replace", Color) = (1,1,1,1)
		[MaterialToggle] PixelSnap ("Pixel snap", Float) = 0
		[HideInInspector] _RendererColor ("RendererColor", Color) = (1,1,1,1)
		[HideInInspector] _Flip ("Flip", Vector) = (1,1,1,1)
		[PerRendererData] _AlphaTex ("External Alpha", 2D) = "white" {}
		[PerRendererData] _EnableExternalAlpha ("Enable External Alpha", Float) = 0
	}
	SubShader
	{
		Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass
		{
			Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend One OneMinusSrcAlpha, One OneMinusSrcAlpha
			ZWrite Off
			Cull Off
			GpuProgramID 47539

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.0
			#pragma multi_compile _ ETC1_EXTERNAL_ALPHA
			#pragma multi_compile _ PIXELSNAP_ON


			#ifndef ETC1_EXTERNAL_ALPHA
			#ifndef PIXELSNAP_ON
			#define ANY_SHADER_VARIANT_ACTIVE

			float4 _Color;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;
			float4 _RendererColor;

			static float4 vertex_uniform_buffer_0[3];
			static float4 vertex_uniform_buffer_1[4];
			static float4 vertex_uniform_buffer_2[21];
			static float4 vertex_uniform_buffer_3[1];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float2 vertex_input_2;
			static float4 vertex_output_1;
			static float2 vertex_output_2;
			static float2 vertex_output_2;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION; // POSITION
				float4 vertex_input_1 : COLOR; // COLOR
				float2 vertex_input_2 : TEXCOORD0; // TEXCOORD
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : COLOR; // COLOR
				float2 vertex_output_2 : TEXCOORD; // TEXCOORD
				float2 vertex_output_2 : TEXCOORD1; // TEXCOORD_1
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_51 = vertex_input_0.y * vertex_uniform_buffer_1[1u].x;
				precise float vertex_unnamed_52 = vertex_input_0.y * vertex_uniform_buffer_1[1u].y;
				precise float vertex_unnamed_53 = vertex_input_0.y * vertex_uniform_buffer_1[1u].z;
				precise float vertex_unnamed_54 = vertex_input_0.y * vertex_uniform_buffer_1[1u].w;
				precise float vertex_unnamed_87 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_0.x, vertex_unnamed_51)) + vertex_uniform_buffer_1[3u].x;
				precise float vertex_unnamed_88 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_0.x, vertex_unnamed_52)) + vertex_uniform_buffer_1[3u].y;
				precise float vertex_unnamed_89 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_0.x, vertex_unnamed_53)) + vertex_uniform_buffer_1[3u].z;
				precise float vertex_unnamed_90 = mad(vertex_uniform_buffer_1[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].w, vertex_input_0.x, vertex_unnamed_54)) + vertex_uniform_buffer_1[3u].w;
				precise float vertex_unnamed_98 = vertex_unnamed_88 * vertex_uniform_buffer_2[18u].x;
				precise float vertex_unnamed_99 = vertex_unnamed_88 * vertex_uniform_buffer_2[18u].y;
				precise float vertex_unnamed_100 = vertex_unnamed_88 * vertex_uniform_buffer_2[18u].z;
				precise float vertex_unnamed_101 = vertex_unnamed_88 * vertex_uniform_buffer_2[18u].w;
				gl_Position.x = mad(vertex_uniform_buffer_2[20u].x, vertex_unnamed_90, mad(vertex_uniform_buffer_2[19u].x, vertex_unnamed_89, mad(vertex_uniform_buffer_2[17u].x, vertex_unnamed_87, vertex_unnamed_98)));
				gl_Position.y = mad(vertex_uniform_buffer_2[20u].y, vertex_unnamed_90, mad(vertex_uniform_buffer_2[19u].y, vertex_unnamed_89, mad(vertex_uniform_buffer_2[17u].y, vertex_unnamed_87, vertex_unnamed_99)));
				gl_Position.z = mad(vertex_uniform_buffer_2[20u].z, vertex_unnamed_90, mad(vertex_uniform_buffer_2[19u].z, vertex_unnamed_89, mad(vertex_uniform_buffer_2[17u].z, vertex_unnamed_87, vertex_unnamed_100)));
				gl_Position.w = mad(vertex_uniform_buffer_2[20u].w, vertex_unnamed_90, mad(vertex_uniform_buffer_2[19u].w, vertex_unnamed_89, mad(vertex_uniform_buffer_2[17u].w, vertex_unnamed_87, vertex_unnamed_101)));
				precise float vertex_unnamed_154 = vertex_input_1.x * vertex_uniform_buffer_0[2u].x;
				precise float vertex_unnamed_155 = vertex_input_1.y * vertex_uniform_buffer_0[2u].y;
				precise float vertex_unnamed_156 = vertex_input_1.z * vertex_uniform_buffer_0[2u].z;
				precise float vertex_unnamed_157 = vertex_input_1.w * vertex_uniform_buffer_0[2u].w;
				precise float vertex_unnamed_164 = vertex_unnamed_154 * vertex_uniform_buffer_3[0u].x;
				precise float vertex_unnamed_165 = vertex_unnamed_155 * vertex_uniform_buffer_3[0u].y;
				precise float vertex_unnamed_166 = vertex_unnamed_156 * vertex_uniform_buffer_3[0u].z;
				precise float vertex_unnamed_167 = vertex_unnamed_157 * vertex_uniform_buffer_3[0u].w;
				vertex_output_1.x = vertex_unnamed_164;
				vertex_output_1.y = vertex_unnamed_165;
				vertex_output_1.z = vertex_unnamed_166;
				vertex_output_1.w = vertex_unnamed_167;
				vertex_output_2.x = vertex_input_2.x;
				vertex_output_2.y = vertex_input_2.y;
				vertex_output_2.x = vertex_input_0.x;
				vertex_output_2.y = vertex_input_0.y;
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

				vertex_uniform_buffer_3[0] = float4(_RendererColor[0], _RendererColor[1], _RendererColor[2], _RendererColor[3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_2 = stage_input.vertex_input_2;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_2 = vertex_output_2;
				return stage_output;
			}

			#endif // !ETC1_EXTERNAL_ALPHA
			#endif // !PIXELSNAP_ON


			#ifdef ETC1_EXTERNAL_ALPHA
			#ifndef PIXELSNAP_ON
			#define ANY_SHADER_VARIANT_ACTIVE

			float4 _Color;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;
			float4 _RendererColor;

			static float4 vertex_uniform_buffer_0[3];
			static float4 vertex_uniform_buffer_1[4];
			static float4 vertex_uniform_buffer_2[21];
			static float4 vertex_uniform_buffer_3[1];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float2 vertex_input_2;
			static float4 vertex_output_1;
			static float2 vertex_output_2;
			static float2 vertex_output_2;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION; // POSITION
				float4 vertex_input_1 : COLOR; // COLOR
				float2 vertex_input_2 : TEXCOORD0; // TEXCOORD
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : COLOR; // COLOR
				float2 vertex_output_2 : TEXCOORD; // TEXCOORD
				float2 vertex_output_2 : TEXCOORD1; // TEXCOORD_1
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_51 = vertex_input_0.y * vertex_uniform_buffer_1[1u].x;
				precise float vertex_unnamed_52 = vertex_input_0.y * vertex_uniform_buffer_1[1u].y;
				precise float vertex_unnamed_53 = vertex_input_0.y * vertex_uniform_buffer_1[1u].z;
				precise float vertex_unnamed_54 = vertex_input_0.y * vertex_uniform_buffer_1[1u].w;
				precise float vertex_unnamed_87 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_0.x, vertex_unnamed_51)) + vertex_uniform_buffer_1[3u].x;
				precise float vertex_unnamed_88 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_0.x, vertex_unnamed_52)) + vertex_uniform_buffer_1[3u].y;
				precise float vertex_unnamed_89 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_0.x, vertex_unnamed_53)) + vertex_uniform_buffer_1[3u].z;
				precise float vertex_unnamed_90 = mad(vertex_uniform_buffer_1[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].w, vertex_input_0.x, vertex_unnamed_54)) + vertex_uniform_buffer_1[3u].w;
				precise float vertex_unnamed_98 = vertex_unnamed_88 * vertex_uniform_buffer_2[18u].x;
				precise float vertex_unnamed_99 = vertex_unnamed_88 * vertex_uniform_buffer_2[18u].y;
				precise float vertex_unnamed_100 = vertex_unnamed_88 * vertex_uniform_buffer_2[18u].z;
				precise float vertex_unnamed_101 = vertex_unnamed_88 * vertex_uniform_buffer_2[18u].w;
				gl_Position.x = mad(vertex_uniform_buffer_2[20u].x, vertex_unnamed_90, mad(vertex_uniform_buffer_2[19u].x, vertex_unnamed_89, mad(vertex_uniform_buffer_2[17u].x, vertex_unnamed_87, vertex_unnamed_98)));
				gl_Position.y = mad(vertex_uniform_buffer_2[20u].y, vertex_unnamed_90, mad(vertex_uniform_buffer_2[19u].y, vertex_unnamed_89, mad(vertex_uniform_buffer_2[17u].y, vertex_unnamed_87, vertex_unnamed_99)));
				gl_Position.z = mad(vertex_uniform_buffer_2[20u].z, vertex_unnamed_90, mad(vertex_uniform_buffer_2[19u].z, vertex_unnamed_89, mad(vertex_uniform_buffer_2[17u].z, vertex_unnamed_87, vertex_unnamed_100)));
				gl_Position.w = mad(vertex_uniform_buffer_2[20u].w, vertex_unnamed_90, mad(vertex_uniform_buffer_2[19u].w, vertex_unnamed_89, mad(vertex_uniform_buffer_2[17u].w, vertex_unnamed_87, vertex_unnamed_101)));
				precise float vertex_unnamed_154 = vertex_input_1.x * vertex_uniform_buffer_0[2u].x;
				precise float vertex_unnamed_155 = vertex_input_1.y * vertex_uniform_buffer_0[2u].y;
				precise float vertex_unnamed_156 = vertex_input_1.z * vertex_uniform_buffer_0[2u].z;
				precise float vertex_unnamed_157 = vertex_input_1.w * vertex_uniform_buffer_0[2u].w;
				precise float vertex_unnamed_164 = vertex_unnamed_154 * vertex_uniform_buffer_3[0u].x;
				precise float vertex_unnamed_165 = vertex_unnamed_155 * vertex_uniform_buffer_3[0u].y;
				precise float vertex_unnamed_166 = vertex_unnamed_156 * vertex_uniform_buffer_3[0u].z;
				precise float vertex_unnamed_167 = vertex_unnamed_157 * vertex_uniform_buffer_3[0u].w;
				vertex_output_1.x = vertex_unnamed_164;
				vertex_output_1.y = vertex_unnamed_165;
				vertex_output_1.z = vertex_unnamed_166;
				vertex_output_1.w = vertex_unnamed_167;
				vertex_output_2.x = vertex_input_2.x;
				vertex_output_2.y = vertex_input_2.y;
				vertex_output_2.x = vertex_input_0.x;
				vertex_output_2.y = vertex_input_0.y;
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

				vertex_uniform_buffer_3[0] = float4(_RendererColor[0], _RendererColor[1], _RendererColor[2], _RendererColor[3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_2 = stage_input.vertex_input_2;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_2 = vertex_output_2;
				return stage_output;
			}

			#endif // ETC1_EXTERNAL_ALPHA
			#endif // !PIXELSNAP_ON


			#ifdef PIXELSNAP_ON
			#ifndef ETC1_EXTERNAL_ALPHA
			#define ANY_SHADER_VARIANT_ACTIVE

			float4 _Color;
			float4 _ScreenParams;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;
			float4 _RendererColor;

			static float4 vertex_uniform_buffer_0[3];
			static float4 vertex_uniform_buffer_1[7];
			static float4 vertex_uniform_buffer_2[4];
			static float4 vertex_uniform_buffer_3[21];
			static float4 vertex_uniform_buffer_4[1];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float2 vertex_input_2;
			static float4 vertex_output_1;
			static float2 vertex_output_2;
			static float2 vertex_output_2;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION; // POSITION
				float4 vertex_input_1 : COLOR; // COLOR
				float2 vertex_input_2 : TEXCOORD0; // TEXCOORD
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : COLOR; // COLOR
				float2 vertex_output_2 : TEXCOORD; // TEXCOORD
				float2 vertex_output_2 : TEXCOORD1; // TEXCOORD_1
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_56 = vertex_input_0.y * vertex_uniform_buffer_2[1u].x;
				precise float vertex_unnamed_57 = vertex_input_0.y * vertex_uniform_buffer_2[1u].y;
				precise float vertex_unnamed_58 = vertex_input_0.y * vertex_uniform_buffer_2[1u].z;
				precise float vertex_unnamed_59 = vertex_input_0.y * vertex_uniform_buffer_2[1u].w;
				precise float vertex_unnamed_92 = mad(vertex_uniform_buffer_2[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].x, vertex_input_0.x, vertex_unnamed_56)) + vertex_uniform_buffer_2[3u].x;
				precise float vertex_unnamed_93 = mad(vertex_uniform_buffer_2[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].y, vertex_input_0.x, vertex_unnamed_57)) + vertex_uniform_buffer_2[3u].y;
				precise float vertex_unnamed_94 = mad(vertex_uniform_buffer_2[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].z, vertex_input_0.x, vertex_unnamed_58)) + vertex_uniform_buffer_2[3u].z;
				precise float vertex_unnamed_95 = mad(vertex_uniform_buffer_2[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].w, vertex_input_0.x, vertex_unnamed_59)) + vertex_uniform_buffer_2[3u].w;
				precise float vertex_unnamed_103 = vertex_unnamed_93 * vertex_uniform_buffer_3[18u].x;
				precise float vertex_unnamed_104 = vertex_unnamed_93 * vertex_uniform_buffer_3[18u].y;
				precise float vertex_unnamed_105 = vertex_unnamed_93 * vertex_uniform_buffer_3[18u].z;
				precise float vertex_unnamed_106 = vertex_unnamed_93 * vertex_uniform_buffer_3[18u].w;
				float vertex_unnamed_139 = mad(vertex_uniform_buffer_3[20u].w, vertex_unnamed_95, mad(vertex_uniform_buffer_3[19u].w, vertex_unnamed_94, mad(vertex_uniform_buffer_3[17u].w, vertex_unnamed_92, vertex_unnamed_106)));
				precise float vertex_unnamed_140 = mad(vertex_uniform_buffer_3[20u].x, vertex_unnamed_95, mad(vertex_uniform_buffer_3[19u].x, vertex_unnamed_94, mad(vertex_uniform_buffer_3[17u].x, vertex_unnamed_92, vertex_unnamed_103))) / vertex_unnamed_139;
				precise float vertex_unnamed_141 = mad(vertex_uniform_buffer_3[20u].y, vertex_unnamed_95, mad(vertex_uniform_buffer_3[19u].y, vertex_unnamed_94, mad(vertex_uniform_buffer_3[17u].y, vertex_unnamed_92, vertex_unnamed_104))) / vertex_unnamed_139;
				precise float vertex_unnamed_147 = vertex_uniform_buffer_1[6u].x * 0.5f;
				precise float vertex_unnamed_149 = vertex_uniform_buffer_1[6u].y * 0.5f;
				precise float vertex_unnamed_150 = vertex_unnamed_140 * vertex_unnamed_147;
				precise float vertex_unnamed_151 = vertex_unnamed_141 * vertex_unnamed_149;
				precise float vertex_unnamed_154 = round(vertex_unnamed_150) / vertex_unnamed_147;
				precise float vertex_unnamed_155 = round(vertex_unnamed_151) / vertex_unnamed_149;
				precise float vertex_unnamed_156 = vertex_unnamed_139 * vertex_unnamed_154;
				precise float vertex_unnamed_157 = vertex_unnamed_139 * vertex_unnamed_155;
				gl_Position.x = vertex_unnamed_156;
				gl_Position.y = vertex_unnamed_157;
				gl_Position.z = mad(vertex_uniform_buffer_3[20u].z, vertex_unnamed_95, mad(vertex_uniform_buffer_3[19u].z, vertex_unnamed_94, mad(vertex_uniform_buffer_3[17u].z, vertex_unnamed_92, vertex_unnamed_105)));
				gl_Position.w = vertex_unnamed_139;
				precise float vertex_unnamed_177 = vertex_input_1.x * vertex_uniform_buffer_0[2u].x;
				precise float vertex_unnamed_178 = vertex_input_1.y * vertex_uniform_buffer_0[2u].y;
				precise float vertex_unnamed_179 = vertex_input_1.z * vertex_uniform_buffer_0[2u].z;
				precise float vertex_unnamed_180 = vertex_input_1.w * vertex_uniform_buffer_0[2u].w;
				precise float vertex_unnamed_187 = vertex_unnamed_177 * vertex_uniform_buffer_4[0u].x;
				precise float vertex_unnamed_188 = vertex_unnamed_178 * vertex_uniform_buffer_4[0u].y;
				precise float vertex_unnamed_189 = vertex_unnamed_179 * vertex_uniform_buffer_4[0u].z;
				precise float vertex_unnamed_190 = vertex_unnamed_180 * vertex_uniform_buffer_4[0u].w;
				vertex_output_1.x = vertex_unnamed_187;
				vertex_output_1.y = vertex_unnamed_188;
				vertex_output_1.z = vertex_unnamed_189;
				vertex_output_1.w = vertex_unnamed_190;
				vertex_output_2.x = vertex_input_2.x;
				vertex_output_2.y = vertex_input_2.y;
				vertex_output_2.x = vertex_input_0.x;
				vertex_output_2.y = vertex_input_0.y;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[2] = float4(_Color[0], _Color[1], _Color[2], _Color[3]);

				vertex_uniform_buffer_1[6] = float4(_ScreenParams[0], _ScreenParams[1], _ScreenParams[2], _ScreenParams[3]);

				vertex_uniform_buffer_2[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_2[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_2[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_2[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_3[17] = float4(unity_MatrixVP[0][0], unity_MatrixVP[1][0], unity_MatrixVP[2][0], unity_MatrixVP[3][0]);
				vertex_uniform_buffer_3[18] = float4(unity_MatrixVP[0][1], unity_MatrixVP[1][1], unity_MatrixVP[2][1], unity_MatrixVP[3][1]);
				vertex_uniform_buffer_3[19] = float4(unity_MatrixVP[0][2], unity_MatrixVP[1][2], unity_MatrixVP[2][2], unity_MatrixVP[3][2]);
				vertex_uniform_buffer_3[20] = float4(unity_MatrixVP[0][3], unity_MatrixVP[1][3], unity_MatrixVP[2][3], unity_MatrixVP[3][3]);

				vertex_uniform_buffer_4[0] = float4(_RendererColor[0], _RendererColor[1], _RendererColor[2], _RendererColor[3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_2 = stage_input.vertex_input_2;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_2 = vertex_output_2;
				return stage_output;
			}

			#endif // PIXELSNAP_ON
			#endif // !ETC1_EXTERNAL_ALPHA


			#ifdef ETC1_EXTERNAL_ALPHA
			#ifdef PIXELSNAP_ON
			#define ANY_SHADER_VARIANT_ACTIVE

			float4 _Color;
			float4 _ScreenParams;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;
			float4 _RendererColor;

			static float4 vertex_uniform_buffer_0[3];
			static float4 vertex_uniform_buffer_1[7];
			static float4 vertex_uniform_buffer_2[4];
			static float4 vertex_uniform_buffer_3[21];
			static float4 vertex_uniform_buffer_4[1];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float2 vertex_input_2;
			static float4 vertex_output_1;
			static float2 vertex_output_2;
			static float2 vertex_output_2;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION; // POSITION
				float4 vertex_input_1 : COLOR; // COLOR
				float2 vertex_input_2 : TEXCOORD0; // TEXCOORD
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : COLOR; // COLOR
				float2 vertex_output_2 : TEXCOORD; // TEXCOORD
				float2 vertex_output_2 : TEXCOORD1; // TEXCOORD_1
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_56 = vertex_input_0.y * vertex_uniform_buffer_2[1u].x;
				precise float vertex_unnamed_57 = vertex_input_0.y * vertex_uniform_buffer_2[1u].y;
				precise float vertex_unnamed_58 = vertex_input_0.y * vertex_uniform_buffer_2[1u].z;
				precise float vertex_unnamed_59 = vertex_input_0.y * vertex_uniform_buffer_2[1u].w;
				precise float vertex_unnamed_92 = mad(vertex_uniform_buffer_2[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].x, vertex_input_0.x, vertex_unnamed_56)) + vertex_uniform_buffer_2[3u].x;
				precise float vertex_unnamed_93 = mad(vertex_uniform_buffer_2[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].y, vertex_input_0.x, vertex_unnamed_57)) + vertex_uniform_buffer_2[3u].y;
				precise float vertex_unnamed_94 = mad(vertex_uniform_buffer_2[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].z, vertex_input_0.x, vertex_unnamed_58)) + vertex_uniform_buffer_2[3u].z;
				precise float vertex_unnamed_95 = mad(vertex_uniform_buffer_2[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].w, vertex_input_0.x, vertex_unnamed_59)) + vertex_uniform_buffer_2[3u].w;
				precise float vertex_unnamed_103 = vertex_unnamed_93 * vertex_uniform_buffer_3[18u].x;
				precise float vertex_unnamed_104 = vertex_unnamed_93 * vertex_uniform_buffer_3[18u].y;
				precise float vertex_unnamed_105 = vertex_unnamed_93 * vertex_uniform_buffer_3[18u].z;
				precise float vertex_unnamed_106 = vertex_unnamed_93 * vertex_uniform_buffer_3[18u].w;
				float vertex_unnamed_139 = mad(vertex_uniform_buffer_3[20u].w, vertex_unnamed_95, mad(vertex_uniform_buffer_3[19u].w, vertex_unnamed_94, mad(vertex_uniform_buffer_3[17u].w, vertex_unnamed_92, vertex_unnamed_106)));
				precise float vertex_unnamed_140 = mad(vertex_uniform_buffer_3[20u].x, vertex_unnamed_95, mad(vertex_uniform_buffer_3[19u].x, vertex_unnamed_94, mad(vertex_uniform_buffer_3[17u].x, vertex_unnamed_92, vertex_unnamed_103))) / vertex_unnamed_139;
				precise float vertex_unnamed_141 = mad(vertex_uniform_buffer_3[20u].y, vertex_unnamed_95, mad(vertex_uniform_buffer_3[19u].y, vertex_unnamed_94, mad(vertex_uniform_buffer_3[17u].y, vertex_unnamed_92, vertex_unnamed_104))) / vertex_unnamed_139;
				precise float vertex_unnamed_147 = vertex_uniform_buffer_1[6u].x * 0.5f;
				precise float vertex_unnamed_149 = vertex_uniform_buffer_1[6u].y * 0.5f;
				precise float vertex_unnamed_150 = vertex_unnamed_140 * vertex_unnamed_147;
				precise float vertex_unnamed_151 = vertex_unnamed_141 * vertex_unnamed_149;
				precise float vertex_unnamed_154 = round(vertex_unnamed_150) / vertex_unnamed_147;
				precise float vertex_unnamed_155 = round(vertex_unnamed_151) / vertex_unnamed_149;
				precise float vertex_unnamed_156 = vertex_unnamed_139 * vertex_unnamed_154;
				precise float vertex_unnamed_157 = vertex_unnamed_139 * vertex_unnamed_155;
				gl_Position.x = vertex_unnamed_156;
				gl_Position.y = vertex_unnamed_157;
				gl_Position.z = mad(vertex_uniform_buffer_3[20u].z, vertex_unnamed_95, mad(vertex_uniform_buffer_3[19u].z, vertex_unnamed_94, mad(vertex_uniform_buffer_3[17u].z, vertex_unnamed_92, vertex_unnamed_105)));
				gl_Position.w = vertex_unnamed_139;
				precise float vertex_unnamed_177 = vertex_input_1.x * vertex_uniform_buffer_0[2u].x;
				precise float vertex_unnamed_178 = vertex_input_1.y * vertex_uniform_buffer_0[2u].y;
				precise float vertex_unnamed_179 = vertex_input_1.z * vertex_uniform_buffer_0[2u].z;
				precise float vertex_unnamed_180 = vertex_input_1.w * vertex_uniform_buffer_0[2u].w;
				precise float vertex_unnamed_187 = vertex_unnamed_177 * vertex_uniform_buffer_4[0u].x;
				precise float vertex_unnamed_188 = vertex_unnamed_178 * vertex_uniform_buffer_4[0u].y;
				precise float vertex_unnamed_189 = vertex_unnamed_179 * vertex_uniform_buffer_4[0u].z;
				precise float vertex_unnamed_190 = vertex_unnamed_180 * vertex_uniform_buffer_4[0u].w;
				vertex_output_1.x = vertex_unnamed_187;
				vertex_output_1.y = vertex_unnamed_188;
				vertex_output_1.z = vertex_unnamed_189;
				vertex_output_1.w = vertex_unnamed_190;
				vertex_output_2.x = vertex_input_2.x;
				vertex_output_2.y = vertex_input_2.y;
				vertex_output_2.x = vertex_input_0.x;
				vertex_output_2.y = vertex_input_0.y;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[2] = float4(_Color[0], _Color[1], _Color[2], _Color[3]);

				vertex_uniform_buffer_1[6] = float4(_ScreenParams[0], _ScreenParams[1], _ScreenParams[2], _ScreenParams[3]);

				vertex_uniform_buffer_2[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_2[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_2[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_2[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_3[17] = float4(unity_MatrixVP[0][0], unity_MatrixVP[1][0], unity_MatrixVP[2][0], unity_MatrixVP[3][0]);
				vertex_uniform_buffer_3[18] = float4(unity_MatrixVP[0][1], unity_MatrixVP[1][1], unity_MatrixVP[2][1], unity_MatrixVP[3][1]);
				vertex_uniform_buffer_3[19] = float4(unity_MatrixVP[0][2], unity_MatrixVP[1][2], unity_MatrixVP[2][2], unity_MatrixVP[3][2]);
				vertex_uniform_buffer_3[20] = float4(unity_MatrixVP[0][3], unity_MatrixVP[1][3], unity_MatrixVP[2][3], unity_MatrixVP[3][3]);

				vertex_uniform_buffer_4[0] = float4(_RendererColor[0], _RendererColor[1], _RendererColor[2], _RendererColor[3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_2 = stage_input.vertex_input_2;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_2 = vertex_output_2;
				return stage_output;
			}

			#endif // ETC1_EXTERNAL_ALPHA
			#endif // PIXELSNAP_ON


			#ifndef ETC1_EXTERNAL_ALPHA
			#ifndef PIXELSNAP_ON
			#define ANY_SHADER_VARIANT_ACTIVE

			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;
			float4 _RendererColor;
			float4 _Color;

			static float4 unity_ObjectToWorld__array[4];
			static float4 unity_MatrixVP__array[4];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float4 vertex_output_0;
			static float2 vertex_output_1;
			static float2 vertex_input_2;
			static float2 vertex_output_2;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION;
				float4 vertex_input_1 : COLOR;
				float2 vertex_input_2 : TEXCOORD0;
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_0 : UNKNOWN0;
				float2 vertex_output_1 : TEXCOORD0; // vs_TEXCOORD0
				float2 vertex_output_2 : TEXCOORD1; // vs_TEXCOORD1
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
				vertex_unnamed_9 = vertex_input_1 * _Color;
				vertex_output_0 = vertex_unnamed_9 * _RendererColor;
				vertex_output_1 = vertex_input_2;
				vertex_output_2 = vertex_input_0.xy;
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
				vertex_input_2 = stage_input.vertex_input_2;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_0 = vertex_output_0;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				return stage_output;
			}

			float4 _Replace;

			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

			static float2 fragment_input_1;
			static float4 fragment_input_0;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_0 : UNKNOWN0;
				float2 fragment_input_1 : TEXCOORD0; // vs_TEXCOORD0
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static float4 fragment_unnamed_9;
			static bool4 fragment_unnamed_28;
			static float fragment_unnamed_80;

			void frag_main()
			{
				fragment_unnamed_9 = _MainTex.Sample(sampler_MainTex, fragment_input_1);
				fragment_unnamed_28 = bool4(fragment_unnamed_9.x == 1.0f.xxxx.x, fragment_unnamed_9.y == 1.0f.xxxx.y, fragment_unnamed_9.z == 1.0f.xxxx.z, fragment_unnamed_9.w == 1.0f.xxxx.w);
				fragment_unnamed_9 *= fragment_input_0;
				fragment_unnamed_28.x = fragment_unnamed_28.y && fragment_unnamed_28.x;
				fragment_unnamed_28.x = fragment_unnamed_28.z && fragment_unnamed_28.x;
				fragment_unnamed_28.x = fragment_unnamed_28.w && fragment_unnamed_28.x;
				float4 fragment_unnamed_65;
				if (fragment_unnamed_28.x)
				{
					fragment_unnamed_65 = _Replace;
				}
				else
				{
					fragment_unnamed_65 = fragment_unnamed_9;
				}
				fragment_unnamed_9 = fragment_unnamed_65;
				fragment_unnamed_80 = fragment_unnamed_9.w + (-0.100000001490116119384765625f);
				fragment_unnamed_28.x = fragment_unnamed_80 < 0.0f;
				if ((int(fragment_unnamed_28.x) * (-1)) != 0)
				{
					discard;
				}
				float3 fragment_unnamed_106 = fragment_unnamed_9.www * fragment_unnamed_9.xyz;
				fragment_output_0 = float4(fragment_unnamed_106.x, fragment_unnamed_106.y, fragment_unnamed_106.z, fragment_output_0.w);
				fragment_output_0.w = fragment_unnamed_9.w;
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

			#endif // !ETC1_EXTERNAL_ALPHA
			#endif // !PIXELSNAP_ON


			#ifdef ETC1_EXTERNAL_ALPHA
			#ifndef PIXELSNAP_ON
			#define ANY_SHADER_VARIANT_ACTIVE

			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;
			float4 _RendererColor;
			float4 _Color;

			static float4 unity_ObjectToWorld__array[4];
			static float4 unity_MatrixVP__array[4];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float4 vertex_output_0;
			static float2 vertex_output_1;
			static float2 vertex_input_2;
			static float2 vertex_output_2;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION;
				float4 vertex_input_1 : COLOR;
				float2 vertex_input_2 : TEXCOORD0;
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_0 : UNKNOWN0;
				float2 vertex_output_1 : TEXCOORD0; // vs_TEXCOORD0
				float2 vertex_output_2 : TEXCOORD1; // vs_TEXCOORD1
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
				vertex_unnamed_9 = vertex_input_1 * _Color;
				vertex_output_0 = vertex_unnamed_9 * _RendererColor;
				vertex_output_1 = vertex_input_2;
				vertex_output_2 = vertex_input_0.xy;
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
				vertex_input_2 = stage_input.vertex_input_2;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_0 = vertex_output_0;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				return stage_output;
			}

			float _EnableExternalAlpha;
			float4 _Replace;

			Texture2D<float4> _AlphaTex;
			SamplerState sampler_AlphaTex;
			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

			static float2 fragment_input_1;
			static float4 fragment_input_0;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_0 : UNKNOWN0;
				float2 fragment_input_1 : TEXCOORD0; // vs_TEXCOORD0
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static float4 fragment_unnamed_9;
			static float4 fragment_unnamed_30;
			static bool4 fragment_unnamed_64;
			static bool fragment_unnamed_76;
			static bool fragment_unnamed_111;

			void frag_main()
			{
				fragment_unnamed_9.x = _AlphaTex.Sample(sampler_AlphaTex, fragment_input_1).x;
				fragment_unnamed_30 = _MainTex.Sample(sampler_MainTex, fragment_input_1);
				fragment_unnamed_9.x += (-fragment_unnamed_30.w);
				fragment_unnamed_30.w = (_EnableExternalAlpha * fragment_unnamed_9.x) + fragment_unnamed_30.w;
				fragment_unnamed_64 = bool4(fragment_unnamed_30.wxyz.x == 1.0f.xxxx.x, fragment_unnamed_30.wxyz.y == 1.0f.xxxx.y, fragment_unnamed_30.wxyz.z == 1.0f.xxxx.z, fragment_unnamed_30.wxyz.w == 1.0f.xxxx.w);
				fragment_unnamed_30 *= fragment_input_0;
				fragment_unnamed_76 = fragment_unnamed_64.z && fragment_unnamed_64.y;
				fragment_unnamed_76 = fragment_unnamed_64.w && fragment_unnamed_76;
				fragment_unnamed_64.x = fragment_unnamed_64.x && fragment_unnamed_76;
				float4 fragment_unnamed_96;
				if (fragment_unnamed_64.x)
				{
					fragment_unnamed_96 = _Replace;
				}
				else
				{
					fragment_unnamed_96 = fragment_unnamed_30;
				}
				fragment_unnamed_9 = fragment_unnamed_96;
				fragment_unnamed_30.x = fragment_unnamed_9.w + (-0.100000001490116119384765625f);
				fragment_unnamed_111 = fragment_unnamed_30.x < 0.0f;
				if ((int(fragment_unnamed_111) * (-1)) != 0)
				{
					discard;
				}
				float3 fragment_unnamed_131 = fragment_unnamed_9.www * fragment_unnamed_9.xyz;
				fragment_output_0 = float4(fragment_unnamed_131.x, fragment_unnamed_131.y, fragment_unnamed_131.z, fragment_output_0.w);
				fragment_output_0.w = fragment_unnamed_9.w;
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

			#endif // ETC1_EXTERNAL_ALPHA
			#endif // !PIXELSNAP_ON


			#ifdef PIXELSNAP_ON
			#ifndef ETC1_EXTERNAL_ALPHA
			#define ANY_SHADER_VARIANT_ACTIVE

			float4 _ScreenParams;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;
			float4 _RendererColor;
			float4 _Color;

			static float4 unity_ObjectToWorld__array[4];
			static float4 unity_MatrixVP__array[4];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float4 vertex_output_0;
			static float2 vertex_output_1;
			static float2 vertex_input_2;
			static float2 vertex_output_2;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION;
				float4 vertex_input_1 : COLOR;
				float2 vertex_input_2 : TEXCOORD0;
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_0 : UNKNOWN0;
				float2 vertex_output_1 : TEXCOORD0; // vs_TEXCOORD0
				float2 vertex_output_2 : TEXCOORD1; // vs_TEXCOORD1
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
				vertex_unnamed_9 = (unity_MatrixVP__array[3] * vertex_unnamed_9.wwww) + vertex_unnamed_48;
				float2 vertex_unnamed_80 = vertex_unnamed_9.xy / vertex_unnamed_9.ww;
				vertex_unnamed_9 = float4(vertex_unnamed_80.x, vertex_unnamed_80.y, vertex_unnamed_9.z, vertex_unnamed_9.w);
				float2 vertex_unnamed_88 = _ScreenParams.xy * 0.5f.xx;
				vertex_unnamed_48 = float4(vertex_unnamed_88.x, vertex_unnamed_88.y, vertex_unnamed_48.z, vertex_unnamed_48.w);
				float2 vertex_unnamed_95 = vertex_unnamed_9.xy * vertex_unnamed_48.xy;
				vertex_unnamed_9 = float4(vertex_unnamed_95.x, vertex_unnamed_95.y, vertex_unnamed_9.z, vertex_unnamed_9.w);
				float2 vertex_unnamed_100 = round(vertex_unnamed_9.xy);
				vertex_unnamed_9 = float4(vertex_unnamed_100.x, vertex_unnamed_100.y, vertex_unnamed_9.z, vertex_unnamed_9.w);
				float2 vertex_unnamed_107 = vertex_unnamed_9.xy / vertex_unnamed_48.xy;
				vertex_unnamed_9 = float4(vertex_unnamed_107.x, vertex_unnamed_107.y, vertex_unnamed_9.z, vertex_unnamed_9.w);
				float2 vertex_unnamed_119 = vertex_unnamed_9.ww * vertex_unnamed_9.xy;
				gl_Position = float4(vertex_unnamed_119.x, vertex_unnamed_119.y, gl_Position.z, gl_Position.w);
				gl_Position = float4(gl_Position.x, gl_Position.y, vertex_unnamed_9.zw.x, vertex_unnamed_9.zw.y);
				vertex_unnamed_9 = vertex_input_1 * _Color;
				vertex_output_0 = vertex_unnamed_9 * _RendererColor;
				vertex_output_1 = vertex_input_2;
				vertex_output_2 = vertex_input_0.xy;
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
				vertex_input_2 = stage_input.vertex_input_2;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_0 = vertex_output_0;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				return stage_output;
			}

			float4 _Replace;

			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

			static float2 fragment_input_1;
			static float4 fragment_input_0;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_0 : UNKNOWN0;
				float2 fragment_input_1 : TEXCOORD0; // vs_TEXCOORD0
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static float4 fragment_unnamed_9;
			static bool4 fragment_unnamed_28;
			static float fragment_unnamed_80;

			void frag_main()
			{
				fragment_unnamed_9 = _MainTex.Sample(sampler_MainTex, fragment_input_1);
				fragment_unnamed_28 = bool4(fragment_unnamed_9.x == 1.0f.xxxx.x, fragment_unnamed_9.y == 1.0f.xxxx.y, fragment_unnamed_9.z == 1.0f.xxxx.z, fragment_unnamed_9.w == 1.0f.xxxx.w);
				fragment_unnamed_9 *= fragment_input_0;
				fragment_unnamed_28.x = fragment_unnamed_28.y && fragment_unnamed_28.x;
				fragment_unnamed_28.x = fragment_unnamed_28.z && fragment_unnamed_28.x;
				fragment_unnamed_28.x = fragment_unnamed_28.w && fragment_unnamed_28.x;
				float4 fragment_unnamed_65;
				if (fragment_unnamed_28.x)
				{
					fragment_unnamed_65 = _Replace;
				}
				else
				{
					fragment_unnamed_65 = fragment_unnamed_9;
				}
				fragment_unnamed_9 = fragment_unnamed_65;
				fragment_unnamed_80 = fragment_unnamed_9.w + (-0.100000001490116119384765625f);
				fragment_unnamed_28.x = fragment_unnamed_80 < 0.0f;
				if ((int(fragment_unnamed_28.x) * (-1)) != 0)
				{
					discard;
				}
				float3 fragment_unnamed_106 = fragment_unnamed_9.www * fragment_unnamed_9.xyz;
				fragment_output_0 = float4(fragment_unnamed_106.x, fragment_unnamed_106.y, fragment_unnamed_106.z, fragment_output_0.w);
				fragment_output_0.w = fragment_unnamed_9.w;
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

			#endif // PIXELSNAP_ON
			#endif // !ETC1_EXTERNAL_ALPHA


			#ifdef ETC1_EXTERNAL_ALPHA
			#ifdef PIXELSNAP_ON
			#define ANY_SHADER_VARIANT_ACTIVE

			float4 _ScreenParams;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;
			float4 _RendererColor;
			float4 _Color;

			static float4 unity_ObjectToWorld__array[4];
			static float4 unity_MatrixVP__array[4];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float4 vertex_output_0;
			static float2 vertex_output_1;
			static float2 vertex_input_2;
			static float2 vertex_output_2;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION;
				float4 vertex_input_1 : COLOR;
				float2 vertex_input_2 : TEXCOORD0;
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_0 : UNKNOWN0;
				float2 vertex_output_1 : TEXCOORD0; // vs_TEXCOORD0
				float2 vertex_output_2 : TEXCOORD1; // vs_TEXCOORD1
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
				vertex_unnamed_9 = (unity_MatrixVP__array[3] * vertex_unnamed_9.wwww) + vertex_unnamed_48;
				float2 vertex_unnamed_80 = vertex_unnamed_9.xy / vertex_unnamed_9.ww;
				vertex_unnamed_9 = float4(vertex_unnamed_80.x, vertex_unnamed_80.y, vertex_unnamed_9.z, vertex_unnamed_9.w);
				float2 vertex_unnamed_88 = _ScreenParams.xy * 0.5f.xx;
				vertex_unnamed_48 = float4(vertex_unnamed_88.x, vertex_unnamed_88.y, vertex_unnamed_48.z, vertex_unnamed_48.w);
				float2 vertex_unnamed_95 = vertex_unnamed_9.xy * vertex_unnamed_48.xy;
				vertex_unnamed_9 = float4(vertex_unnamed_95.x, vertex_unnamed_95.y, vertex_unnamed_9.z, vertex_unnamed_9.w);
				float2 vertex_unnamed_100 = round(vertex_unnamed_9.xy);
				vertex_unnamed_9 = float4(vertex_unnamed_100.x, vertex_unnamed_100.y, vertex_unnamed_9.z, vertex_unnamed_9.w);
				float2 vertex_unnamed_107 = vertex_unnamed_9.xy / vertex_unnamed_48.xy;
				vertex_unnamed_9 = float4(vertex_unnamed_107.x, vertex_unnamed_107.y, vertex_unnamed_9.z, vertex_unnamed_9.w);
				float2 vertex_unnamed_119 = vertex_unnamed_9.ww * vertex_unnamed_9.xy;
				gl_Position = float4(vertex_unnamed_119.x, vertex_unnamed_119.y, gl_Position.z, gl_Position.w);
				gl_Position = float4(gl_Position.x, gl_Position.y, vertex_unnamed_9.zw.x, vertex_unnamed_9.zw.y);
				vertex_unnamed_9 = vertex_input_1 * _Color;
				vertex_output_0 = vertex_unnamed_9 * _RendererColor;
				vertex_output_1 = vertex_input_2;
				vertex_output_2 = vertex_input_0.xy;
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
				vertex_input_2 = stage_input.vertex_input_2;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_0 = vertex_output_0;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				return stage_output;
			}

			float _EnableExternalAlpha;
			float4 _Replace;

			Texture2D<float4> _AlphaTex;
			SamplerState sampler_AlphaTex;
			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

			static float2 fragment_input_1;
			static float4 fragment_input_0;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_0 : UNKNOWN0;
				float2 fragment_input_1 : TEXCOORD0; // vs_TEXCOORD0
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static float4 fragment_unnamed_9;
			static float4 fragment_unnamed_30;
			static bool4 fragment_unnamed_64;
			static bool fragment_unnamed_76;
			static bool fragment_unnamed_111;

			void frag_main()
			{
				fragment_unnamed_9.x = _AlphaTex.Sample(sampler_AlphaTex, fragment_input_1).x;
				fragment_unnamed_30 = _MainTex.Sample(sampler_MainTex, fragment_input_1);
				fragment_unnamed_9.x += (-fragment_unnamed_30.w);
				fragment_unnamed_30.w = (_EnableExternalAlpha * fragment_unnamed_9.x) + fragment_unnamed_30.w;
				fragment_unnamed_64 = bool4(fragment_unnamed_30.wxyz.x == 1.0f.xxxx.x, fragment_unnamed_30.wxyz.y == 1.0f.xxxx.y, fragment_unnamed_30.wxyz.z == 1.0f.xxxx.z, fragment_unnamed_30.wxyz.w == 1.0f.xxxx.w);
				fragment_unnamed_30 *= fragment_input_0;
				fragment_unnamed_76 = fragment_unnamed_64.z && fragment_unnamed_64.y;
				fragment_unnamed_76 = fragment_unnamed_64.w && fragment_unnamed_76;
				fragment_unnamed_64.x = fragment_unnamed_64.x && fragment_unnamed_76;
				float4 fragment_unnamed_96;
				if (fragment_unnamed_64.x)
				{
					fragment_unnamed_96 = _Replace;
				}
				else
				{
					fragment_unnamed_96 = fragment_unnamed_30;
				}
				fragment_unnamed_9 = fragment_unnamed_96;
				fragment_unnamed_30.x = fragment_unnamed_9.w + (-0.100000001490116119384765625f);
				fragment_unnamed_111 = fragment_unnamed_30.x < 0.0f;
				if ((int(fragment_unnamed_111) * (-1)) != 0)
				{
					discard;
				}
				float3 fragment_unnamed_131 = fragment_unnamed_9.www * fragment_unnamed_9.xyz;
				fragment_output_0 = float4(fragment_unnamed_131.x, fragment_unnamed_131.y, fragment_unnamed_131.z, fragment_output_0.w);
				fragment_output_0.w = fragment_unnamed_9.w;
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

			#endif // ETC1_EXTERNAL_ALPHA
			#endif // PIXELSNAP_ON


			#ifndef ETC1_EXTERNAL_ALPHA
			#ifndef PIXELSNAP_ON
			#define ANY_SHADER_VARIANT_ACTIVE

			float4 _Replace;

			static float4 fragment_uniform_buffer_0[7];
			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

			static float4 fragment_input_1;
			static float2 fragment_input_2;
			static float2 fragment_input_2;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : COLOR; // COLOR
				float2 fragment_input_2 : TEXCOORD; // TEXCOORD
				float2 fragment_input_2 : TEXCOORD1; // TEXCOORD_1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static bool discard_state;

			void discard_cond(bool fragment_unnamed_113)
			{
				if (fragment_unnamed_113)
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
				float4 fragment_unnamed_40 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_2.x, fragment_input_2.y));
				float fragment_unnamed_42 = fragment_unnamed_40.x;
				float fragment_unnamed_43 = fragment_unnamed_40.y;
				float fragment_unnamed_44 = fragment_unnamed_40.z;
				float fragment_unnamed_45 = fragment_unnamed_40.w;
				precise float fragment_unnamed_67 = fragment_unnamed_42 * fragment_input_1.x;
				precise float fragment_unnamed_68 = fragment_unnamed_43 * fragment_input_1.y;
				precise float fragment_unnamed_69 = fragment_unnamed_44 * fragment_input_1.z;
				precise float fragment_unnamed_70 = fragment_unnamed_45 * fragment_input_1.w;
				bool fragment_unnamed_74 = (((fragment_unnamed_45 == 1.0f) ? 4294967295u : 0u) & (((fragment_unnamed_44 == 1.0f) ? 4294967295u : 0u) & (((fragment_unnamed_43 == 1.0f) ? 4294967295u : 0u) & ((fragment_unnamed_42 == 1.0f) ? 4294967295u : 0u)))) != 0u;
				uint4 fragment_unnamed_80 = asuint(fragment_uniform_buffer_0[6u]);
				float fragment_unnamed_96 = asfloat(fragment_unnamed_74 ? fragment_unnamed_80.w : asuint(fragment_unnamed_70));
				precise float fragment_unnamed_97 = fragment_unnamed_96 + (-0.100000001490116119384765625f);
				discard_cond(fragment_unnamed_97 < 0.0f);
				precise float fragment_unnamed_103 = fragment_unnamed_96 * asfloat(fragment_unnamed_74 ? fragment_unnamed_80.x : asuint(fragment_unnamed_67));
				precise float fragment_unnamed_104 = fragment_unnamed_96 * asfloat(fragment_unnamed_74 ? fragment_unnamed_80.y : asuint(fragment_unnamed_68));
				precise float fragment_unnamed_105 = fragment_unnamed_96 * asfloat(fragment_unnamed_74 ? fragment_unnamed_80.z : asuint(fragment_unnamed_69));
				fragment_output_0.x = fragment_unnamed_103;
				fragment_output_0.y = fragment_unnamed_104;
				fragment_output_0.z = fragment_unnamed_105;
				fragment_output_0.w = fragment_unnamed_96;
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[6] = float4(_Replace[0], _Replace[1], _Replace[2], _Replace[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_2 = stage_input.fragment_input_2;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // !ETC1_EXTERNAL_ALPHA
			#endif // !PIXELSNAP_ON


			#ifdef ETC1_EXTERNAL_ALPHA
			#ifndef PIXELSNAP_ON
			#define ANY_SHADER_VARIANT_ACTIVE

			float4 _Replace;
			float _EnableExternalAlpha;

			static float4 fragment_uniform_buffer_0[7];
			static float4 fragment_uniform_buffer_1[3];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _AlphaTex;
			SamplerState sampler_MainTex;
			SamplerState sampler_AlphaTex;

			static float4 fragment_input_1;
			static float2 fragment_input_2;
			static float2 fragment_input_2;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : COLOR; // COLOR
				float2 fragment_input_2 : TEXCOORD; // TEXCOORD
				float2 fragment_input_2 : TEXCOORD1; // TEXCOORD_1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static bool discard_state;

			void discard_cond(bool fragment_unnamed_137)
			{
				if (fragment_unnamed_137)
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
				float4 fragment_unnamed_57 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_2.x, fragment_input_2.y));
				float fragment_unnamed_59 = fragment_unnamed_57.x;
				float fragment_unnamed_60 = fragment_unnamed_57.y;
				float fragment_unnamed_61 = fragment_unnamed_57.z;
				float fragment_unnamed_62 = fragment_unnamed_57.w;
				precise float fragment_unnamed_63 = (-0.0f) - fragment_unnamed_62;
				precise float fragment_unnamed_65 = _AlphaTex.Sample(sampler_AlphaTex, float2(fragment_input_2.x, fragment_input_2.y)).x + fragment_unnamed_63;
				float fragment_unnamed_72 = mad(fragment_uniform_buffer_1[2u].x, fragment_unnamed_65, fragment_unnamed_62);
				precise float fragment_unnamed_92 = fragment_unnamed_59 * fragment_input_1.x;
				precise float fragment_unnamed_93 = fragment_unnamed_60 * fragment_input_1.y;
				precise float fragment_unnamed_94 = fragment_unnamed_61 * fragment_input_1.z;
				precise float fragment_unnamed_95 = fragment_unnamed_72 * fragment_input_1.w;
				bool fragment_unnamed_99 = (((fragment_unnamed_72 == 1.0f) ? 4294967295u : 0u) & (((fragment_unnamed_61 == 1.0f) ? 4294967295u : 0u) & (((fragment_unnamed_60 == 1.0f) ? 4294967295u : 0u) & ((fragment_unnamed_59 == 1.0f) ? 4294967295u : 0u)))) != 0u;
				uint4 fragment_unnamed_104 = asuint(fragment_uniform_buffer_0[6u]);
				float fragment_unnamed_118 = asfloat(fragment_unnamed_99 ? fragment_unnamed_104.w : asuint(fragment_unnamed_95));
				precise float fragment_unnamed_119 = fragment_unnamed_118 + (-0.100000001490116119384765625f);
				discard_cond(fragment_unnamed_119 < 0.0f);
				precise float fragment_unnamed_127 = fragment_unnamed_118 * asfloat(fragment_unnamed_99 ? fragment_unnamed_104.x : asuint(fragment_unnamed_92));
				precise float fragment_unnamed_128 = fragment_unnamed_118 * asfloat(fragment_unnamed_99 ? fragment_unnamed_104.y : asuint(fragment_unnamed_93));
				precise float fragment_unnamed_129 = fragment_unnamed_118 * asfloat(fragment_unnamed_99 ? fragment_unnamed_104.z : asuint(fragment_unnamed_94));
				fragment_output_0.x = fragment_unnamed_127;
				fragment_output_0.y = fragment_unnamed_128;
				fragment_output_0.z = fragment_unnamed_129;
				fragment_output_0.w = fragment_unnamed_118;
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[6] = float4(_Replace[0], _Replace[1], _Replace[2], _Replace[3]);

				fragment_uniform_buffer_1[2] = float4(_EnableExternalAlpha, fragment_uniform_buffer_1[2][1], fragment_uniform_buffer_1[2][2], fragment_uniform_buffer_1[2][3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_2 = stage_input.fragment_input_2;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // ETC1_EXTERNAL_ALPHA
			#endif // !PIXELSNAP_ON


			#ifdef PIXELSNAP_ON
			#ifndef ETC1_EXTERNAL_ALPHA
			#define ANY_SHADER_VARIANT_ACTIVE

			float4 _Replace;

			static float4 fragment_uniform_buffer_0[7];
			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

			static float4 fragment_input_1;
			static float2 fragment_input_2;
			static float2 fragment_input_2;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : COLOR; // COLOR
				float2 fragment_input_2 : TEXCOORD; // TEXCOORD
				float2 fragment_input_2 : TEXCOORD1; // TEXCOORD_1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static bool discard_state;

			void discard_cond(bool fragment_unnamed_113)
			{
				if (fragment_unnamed_113)
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
				float4 fragment_unnamed_40 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_2.x, fragment_input_2.y));
				float fragment_unnamed_42 = fragment_unnamed_40.x;
				float fragment_unnamed_43 = fragment_unnamed_40.y;
				float fragment_unnamed_44 = fragment_unnamed_40.z;
				float fragment_unnamed_45 = fragment_unnamed_40.w;
				precise float fragment_unnamed_67 = fragment_unnamed_42 * fragment_input_1.x;
				precise float fragment_unnamed_68 = fragment_unnamed_43 * fragment_input_1.y;
				precise float fragment_unnamed_69 = fragment_unnamed_44 * fragment_input_1.z;
				precise float fragment_unnamed_70 = fragment_unnamed_45 * fragment_input_1.w;
				bool fragment_unnamed_74 = (((fragment_unnamed_45 == 1.0f) ? 4294967295u : 0u) & (((fragment_unnamed_44 == 1.0f) ? 4294967295u : 0u) & (((fragment_unnamed_43 == 1.0f) ? 4294967295u : 0u) & ((fragment_unnamed_42 == 1.0f) ? 4294967295u : 0u)))) != 0u;
				uint4 fragment_unnamed_80 = asuint(fragment_uniform_buffer_0[6u]);
				float fragment_unnamed_96 = asfloat(fragment_unnamed_74 ? fragment_unnamed_80.w : asuint(fragment_unnamed_70));
				precise float fragment_unnamed_97 = fragment_unnamed_96 + (-0.100000001490116119384765625f);
				discard_cond(fragment_unnamed_97 < 0.0f);
				precise float fragment_unnamed_103 = fragment_unnamed_96 * asfloat(fragment_unnamed_74 ? fragment_unnamed_80.x : asuint(fragment_unnamed_67));
				precise float fragment_unnamed_104 = fragment_unnamed_96 * asfloat(fragment_unnamed_74 ? fragment_unnamed_80.y : asuint(fragment_unnamed_68));
				precise float fragment_unnamed_105 = fragment_unnamed_96 * asfloat(fragment_unnamed_74 ? fragment_unnamed_80.z : asuint(fragment_unnamed_69));
				fragment_output_0.x = fragment_unnamed_103;
				fragment_output_0.y = fragment_unnamed_104;
				fragment_output_0.z = fragment_unnamed_105;
				fragment_output_0.w = fragment_unnamed_96;
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[6] = float4(_Replace[0], _Replace[1], _Replace[2], _Replace[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_2 = stage_input.fragment_input_2;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // PIXELSNAP_ON
			#endif // !ETC1_EXTERNAL_ALPHA


			#ifdef ETC1_EXTERNAL_ALPHA
			#ifdef PIXELSNAP_ON
			#define ANY_SHADER_VARIANT_ACTIVE

			float4 _Replace;
			float _EnableExternalAlpha;

			static float4 fragment_uniform_buffer_0[7];
			static float4 fragment_uniform_buffer_1[3];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _AlphaTex;
			SamplerState sampler_MainTex;
			SamplerState sampler_AlphaTex;

			static float4 fragment_input_1;
			static float2 fragment_input_2;
			static float2 fragment_input_2;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : COLOR; // COLOR
				float2 fragment_input_2 : TEXCOORD; // TEXCOORD
				float2 fragment_input_2 : TEXCOORD1; // TEXCOORD_1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static bool discard_state;

			void discard_cond(bool fragment_unnamed_137)
			{
				if (fragment_unnamed_137)
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
				float4 fragment_unnamed_57 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_2.x, fragment_input_2.y));
				float fragment_unnamed_59 = fragment_unnamed_57.x;
				float fragment_unnamed_60 = fragment_unnamed_57.y;
				float fragment_unnamed_61 = fragment_unnamed_57.z;
				float fragment_unnamed_62 = fragment_unnamed_57.w;
				precise float fragment_unnamed_63 = (-0.0f) - fragment_unnamed_62;
				precise float fragment_unnamed_65 = _AlphaTex.Sample(sampler_AlphaTex, float2(fragment_input_2.x, fragment_input_2.y)).x + fragment_unnamed_63;
				float fragment_unnamed_72 = mad(fragment_uniform_buffer_1[2u].x, fragment_unnamed_65, fragment_unnamed_62);
				precise float fragment_unnamed_92 = fragment_unnamed_59 * fragment_input_1.x;
				precise float fragment_unnamed_93 = fragment_unnamed_60 * fragment_input_1.y;
				precise float fragment_unnamed_94 = fragment_unnamed_61 * fragment_input_1.z;
				precise float fragment_unnamed_95 = fragment_unnamed_72 * fragment_input_1.w;
				bool fragment_unnamed_99 = (((fragment_unnamed_72 == 1.0f) ? 4294967295u : 0u) & (((fragment_unnamed_61 == 1.0f) ? 4294967295u : 0u) & (((fragment_unnamed_60 == 1.0f) ? 4294967295u : 0u) & ((fragment_unnamed_59 == 1.0f) ? 4294967295u : 0u)))) != 0u;
				uint4 fragment_unnamed_104 = asuint(fragment_uniform_buffer_0[6u]);
				float fragment_unnamed_118 = asfloat(fragment_unnamed_99 ? fragment_unnamed_104.w : asuint(fragment_unnamed_95));
				precise float fragment_unnamed_119 = fragment_unnamed_118 + (-0.100000001490116119384765625f);
				discard_cond(fragment_unnamed_119 < 0.0f);
				precise float fragment_unnamed_127 = fragment_unnamed_118 * asfloat(fragment_unnamed_99 ? fragment_unnamed_104.x : asuint(fragment_unnamed_92));
				precise float fragment_unnamed_128 = fragment_unnamed_118 * asfloat(fragment_unnamed_99 ? fragment_unnamed_104.y : asuint(fragment_unnamed_93));
				precise float fragment_unnamed_129 = fragment_unnamed_118 * asfloat(fragment_unnamed_99 ? fragment_unnamed_104.z : asuint(fragment_unnamed_94));
				fragment_output_0.x = fragment_unnamed_127;
				fragment_output_0.y = fragment_unnamed_128;
				fragment_output_0.z = fragment_unnamed_129;
				fragment_output_0.w = fragment_unnamed_118;
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[6] = float4(_Replace[0], _Replace[1], _Replace[2], _Replace[3]);

				fragment_uniform_buffer_1[2] = float4(_EnableExternalAlpha, fragment_uniform_buffer_1[2][1], fragment_uniform_buffer_1[2][2], fragment_uniform_buffer_1[2][3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_2 = stage_input.fragment_input_2;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // ETC1_EXTERNAL_ALPHA
			#endif // PIXELSNAP_ON


			ENDHLSL
		}
	}
}
