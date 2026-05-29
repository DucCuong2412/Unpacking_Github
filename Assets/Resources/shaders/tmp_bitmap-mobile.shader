Shader "TextMeshPro/Mobile/Bitmap"
{
	Properties
	{
		_MainTex ("Font Atlas", 2D) = "white" {}
		_Color ("Text Color", Color) = (1,1,1,1)
		_DiffusePower ("Diffuse Power", Range(1, 4)) = 1
		_VertexOffsetX ("Vertex OffsetX", Float) = 0
		_VertexOffsetY ("Vertex OffsetY", Float) = 0
		_MaskSoftnessX ("Mask SoftnessX", Float) = 0
		_MaskSoftnessY ("Mask SoftnessY", Float) = 0
		_ClipRect ("Clip Rect", Vector) = (-32767,-32767,32767,32767)
		_StencilComp ("Stencil Comparison", Float) = 8
		_Stencil ("Stencil ID", Float) = 0
		_StencilOp ("Stencil Operation", Float) = 0
		_StencilWriteMask ("Stencil Write Mask", Float) = 255
		_StencilReadMask ("Stencil Read Mask", Float) = 255
		_ColorMask ("Color Mask", Float) = 15
	}
	SubShader
	{
		Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass
		{
			Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ColorMask 0
			ZWrite Off
			Cull Off
			Stencil
			{
				ReadMask 0
				WriteMask 0
				Comp [Disabled]
				Pass Keep
				Fail Keep
				ZFail Keep
			}
			Fog
			{
				Mode Off
			}
			GpuProgramID 62068

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.0
			#pragma multi_compile _ UNITY_UI_ALPHACLIP
			#pragma multi_compile _ UNITY_UI_CLIP_RECT


			#ifndef UNITY_UI_ALPHACLIP
			#ifndef UNITY_UI_CLIP_RECT
			#define ANY_SHADER_VARIANT_ACTIVE

			float4 _Color;
			float _DiffusePower;
			float _VertexOffsetX;
			float _VertexOffsetY;
			float4 _ClipRect;
			float _MaskSoftnessX;
			float _MaskSoftnessY;
			float4 _ScreenParams;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[6];
			static float4 vertex_uniform_buffer_1[7];
			static float4 vertex_uniform_buffer_2[4];
			static float4 vertex_uniform_buffer_3[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float2 vertex_input_2;
			static float2 vertex_input_3;
			static float4 vertex_output_1;
			static float2 vertex_output_2;
			static float4 vertex_output_3;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION; // POSITION
				float4 vertex_input_1 : COLOR; // COLOR
				float2 vertex_input_2 : TEXCOORD; // TEXCOORD
				float2 vertex_input_3 : TEXCOORD1; // TEXCOORD_1
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : COLOR; // COLOR
				float2 vertex_output_2 : TEXCOORD; // TEXCOORD
				float4 vertex_output_3 : TEXCOORD2; // TEXCOORD_2
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_45 = vertex_input_0.w * 0.5f;
				precise float vertex_unnamed_53 = vertex_unnamed_45 / vertex_uniform_buffer_1[6u].x;
				precise float vertex_unnamed_54 = vertex_unnamed_45 / vertex_uniform_buffer_1[6u].y;
				precise float vertex_unnamed_64 = vertex_input_0.x + vertex_uniform_buffer_0[3u].y;
				precise float vertex_unnamed_65 = vertex_input_0.y + vertex_uniform_buffer_0[3u].z;
				precise float vertex_unnamed_66 = vertex_unnamed_53 + vertex_unnamed_64;
				precise float vertex_unnamed_67 = vertex_unnamed_54 + vertex_unnamed_65;
				precise float vertex_unnamed_74 = vertex_unnamed_67 * vertex_uniform_buffer_2[1u].x;
				precise float vertex_unnamed_75 = vertex_unnamed_67 * vertex_uniform_buffer_2[1u].y;
				precise float vertex_unnamed_76 = vertex_unnamed_67 * vertex_uniform_buffer_2[1u].z;
				precise float vertex_unnamed_77 = vertex_unnamed_67 * vertex_uniform_buffer_2[1u].w;
				precise float vertex_unnamed_108 = mad(vertex_uniform_buffer_2[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].x, vertex_unnamed_66, vertex_unnamed_74)) + vertex_uniform_buffer_2[3u].x;
				precise float vertex_unnamed_109 = mad(vertex_uniform_buffer_2[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].y, vertex_unnamed_66, vertex_unnamed_75)) + vertex_uniform_buffer_2[3u].y;
				precise float vertex_unnamed_110 = mad(vertex_uniform_buffer_2[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].z, vertex_unnamed_66, vertex_unnamed_76)) + vertex_uniform_buffer_2[3u].z;
				precise float vertex_unnamed_111 = mad(vertex_uniform_buffer_2[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].w, vertex_unnamed_66, vertex_unnamed_77)) + vertex_uniform_buffer_2[3u].w;
				precise float vertex_unnamed_119 = vertex_unnamed_109 * vertex_uniform_buffer_3[18u].x;
				precise float vertex_unnamed_120 = vertex_unnamed_109 * vertex_uniform_buffer_3[18u].y;
				precise float vertex_unnamed_121 = vertex_unnamed_109 * vertex_uniform_buffer_3[18u].z;
				precise float vertex_unnamed_122 = vertex_unnamed_109 * vertex_uniform_buffer_3[18u].w;
				float vertex_unnamed_155 = mad(vertex_uniform_buffer_3[20u].w, vertex_unnamed_111, mad(vertex_uniform_buffer_3[19u].w, vertex_unnamed_110, mad(vertex_uniform_buffer_3[17u].w, vertex_unnamed_108, vertex_unnamed_122)));
				precise float vertex_unnamed_156 = mad(vertex_uniform_buffer_3[20u].x, vertex_unnamed_111, mad(vertex_uniform_buffer_3[19u].x, vertex_unnamed_110, mad(vertex_uniform_buffer_3[17u].x, vertex_unnamed_108, vertex_unnamed_119))) / vertex_unnamed_155;
				precise float vertex_unnamed_157 = mad(vertex_uniform_buffer_3[20u].y, vertex_unnamed_111, mad(vertex_uniform_buffer_3[19u].y, vertex_unnamed_110, mad(vertex_uniform_buffer_3[17u].y, vertex_unnamed_108, vertex_unnamed_120))) / vertex_unnamed_155;
				precise float vertex_unnamed_162 = vertex_uniform_buffer_1[6u].x * 0.5f;
				precise float vertex_unnamed_163 = vertex_uniform_buffer_1[6u].y * 0.5f;
				precise float vertex_unnamed_164 = vertex_unnamed_156 * vertex_unnamed_162;
				precise float vertex_unnamed_165 = vertex_unnamed_157 * vertex_unnamed_163;
				precise float vertex_unnamed_168 = round(vertex_unnamed_164) / vertex_unnamed_162;
				precise float vertex_unnamed_169 = round(vertex_unnamed_165) / vertex_unnamed_163;
				precise float vertex_unnamed_170 = vertex_unnamed_155 * vertex_unnamed_168;
				precise float vertex_unnamed_171 = vertex_unnamed_155 * vertex_unnamed_169;
				gl_Position.x = vertex_unnamed_170;
				gl_Position.y = vertex_unnamed_171;
				gl_Position.z = mad(vertex_uniform_buffer_3[20u].z, vertex_unnamed_111, mad(vertex_uniform_buffer_3[19u].z, vertex_unnamed_110, mad(vertex_uniform_buffer_3[17u].z, vertex_unnamed_108, vertex_unnamed_121)));
				gl_Position.w = vertex_unnamed_155;
				precise float vertex_unnamed_185 = 0.25f / mad(vertex_uniform_buffer_0[5u].x, 0.25f, vertex_unnamed_155);
				precise float vertex_unnamed_186 = 0.25f / mad(vertex_uniform_buffer_0[5u].y, 0.25f, vertex_unnamed_155);
				vertex_output_3.z = vertex_unnamed_185;
				vertex_output_3.w = vertex_unnamed_186;
				precise float vertex_unnamed_203 = vertex_input_1.x * vertex_uniform_buffer_0[2u].x;
				precise float vertex_unnamed_204 = vertex_input_1.y * vertex_uniform_buffer_0[2u].y;
				precise float vertex_unnamed_205 = vertex_input_1.z * vertex_uniform_buffer_0[2u].z;
				precise float vertex_unnamed_206 = vertex_input_1.w * vertex_uniform_buffer_0[2u].w;
				precise float vertex_unnamed_210 = vertex_unnamed_203 * vertex_uniform_buffer_0[3u].x;
				precise float vertex_unnamed_211 = vertex_unnamed_204 * vertex_uniform_buffer_0[3u].x;
				precise float vertex_unnamed_212 = vertex_unnamed_205 * vertex_uniform_buffer_0[3u].x;
				vertex_output_1.x = vertex_unnamed_210;
				vertex_output_1.y = vertex_unnamed_211;
				vertex_output_1.z = vertex_unnamed_212;
				vertex_output_1.w = vertex_unnamed_206;
				vertex_output_2.x = vertex_input_2.x;
				vertex_output_2.y = vertex_input_2.y;
				precise float vertex_unnamed_239 = (-0.0f) - min(max(vertex_uniform_buffer_0[4u].x, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_241 = (-0.0f) - min(max(vertex_uniform_buffer_0[4u].y, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_245 = (-0.0f) - min(max(vertex_uniform_buffer_0[4u].z, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_246 = (-0.0f) - min(max(vertex_uniform_buffer_0[4u].w, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_247 = vertex_unnamed_245 + mad(vertex_unnamed_66, 2.0f, vertex_unnamed_239);
				precise float vertex_unnamed_248 = vertex_unnamed_246 + mad(vertex_unnamed_67, 2.0f, vertex_unnamed_241);
				vertex_output_3.x = vertex_unnamed_247;
				vertex_output_3.y = vertex_unnamed_248;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[2] = float4(_Color[0], _Color[1], _Color[2], _Color[3]);

				vertex_uniform_buffer_0[3] = float4(_DiffusePower, vertex_uniform_buffer_0[3][1], vertex_uniform_buffer_0[3][2], vertex_uniform_buffer_0[3][3]);

				vertex_uniform_buffer_0[3] = float4(vertex_uniform_buffer_0[3][0], _VertexOffsetX, vertex_uniform_buffer_0[3][2], vertex_uniform_buffer_0[3][3]);

				vertex_uniform_buffer_0[3] = float4(vertex_uniform_buffer_0[3][0], vertex_uniform_buffer_0[3][1], _VertexOffsetY, vertex_uniform_buffer_0[3][3]);

				vertex_uniform_buffer_0[4] = float4(_ClipRect[0], _ClipRect[1], _ClipRect[2], _ClipRect[3]);

				vertex_uniform_buffer_0[5] = float4(_MaskSoftnessX, vertex_uniform_buffer_0[5][1], vertex_uniform_buffer_0[5][2], vertex_uniform_buffer_0[5][3]);

				vertex_uniform_buffer_0[5] = float4(vertex_uniform_buffer_0[5][0], _MaskSoftnessY, vertex_uniform_buffer_0[5][2], vertex_uniform_buffer_0[5][3]);

				vertex_uniform_buffer_1[6] = float4(_ScreenParams[0], _ScreenParams[1], _ScreenParams[2], _ScreenParams[3]);

				vertex_uniform_buffer_2[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_2[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_2[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_2[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_3[17] = float4(unity_MatrixVP[0][0], unity_MatrixVP[1][0], unity_MatrixVP[2][0], unity_MatrixVP[3][0]);
				vertex_uniform_buffer_3[18] = float4(unity_MatrixVP[0][1], unity_MatrixVP[1][1], unity_MatrixVP[2][1], unity_MatrixVP[3][1]);
				vertex_uniform_buffer_3[19] = float4(unity_MatrixVP[0][2], unity_MatrixVP[1][2], unity_MatrixVP[2][2], unity_MatrixVP[3][2]);
				vertex_uniform_buffer_3[20] = float4(unity_MatrixVP[0][3], unity_MatrixVP[1][3], unity_MatrixVP[2][3], unity_MatrixVP[3][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_2 = stage_input.vertex_input_2;
				vertex_input_3 = stage_input.vertex_input_3;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				return stage_output;
			}

			#endif // !UNITY_UI_ALPHACLIP
			#endif // !UNITY_UI_CLIP_RECT


			#ifdef UNITY_UI_ALPHACLIP
			#ifndef UNITY_UI_CLIP_RECT
			#define ANY_SHADER_VARIANT_ACTIVE

			float4 _Color;
			float _DiffusePower;
			float _VertexOffsetX;
			float _VertexOffsetY;
			float4 _ClipRect;
			float _MaskSoftnessX;
			float _MaskSoftnessY;
			float4 _ScreenParams;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[6];
			static float4 vertex_uniform_buffer_1[7];
			static float4 vertex_uniform_buffer_2[4];
			static float4 vertex_uniform_buffer_3[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float2 vertex_input_2;
			static float2 vertex_input_3;
			static float4 vertex_output_1;
			static float2 vertex_output_2;
			static float4 vertex_output_3;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION; // POSITION
				float4 vertex_input_1 : COLOR; // COLOR
				float2 vertex_input_2 : TEXCOORD; // TEXCOORD
				float2 vertex_input_3 : TEXCOORD1; // TEXCOORD_1
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : COLOR; // COLOR
				float2 vertex_output_2 : TEXCOORD; // TEXCOORD
				float4 vertex_output_3 : TEXCOORD2; // TEXCOORD_2
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_45 = vertex_input_0.w * 0.5f;
				precise float vertex_unnamed_53 = vertex_unnamed_45 / vertex_uniform_buffer_1[6u].x;
				precise float vertex_unnamed_54 = vertex_unnamed_45 / vertex_uniform_buffer_1[6u].y;
				precise float vertex_unnamed_64 = vertex_input_0.x + vertex_uniform_buffer_0[3u].y;
				precise float vertex_unnamed_65 = vertex_input_0.y + vertex_uniform_buffer_0[3u].z;
				precise float vertex_unnamed_66 = vertex_unnamed_53 + vertex_unnamed_64;
				precise float vertex_unnamed_67 = vertex_unnamed_54 + vertex_unnamed_65;
				precise float vertex_unnamed_74 = vertex_unnamed_67 * vertex_uniform_buffer_2[1u].x;
				precise float vertex_unnamed_75 = vertex_unnamed_67 * vertex_uniform_buffer_2[1u].y;
				precise float vertex_unnamed_76 = vertex_unnamed_67 * vertex_uniform_buffer_2[1u].z;
				precise float vertex_unnamed_77 = vertex_unnamed_67 * vertex_uniform_buffer_2[1u].w;
				precise float vertex_unnamed_108 = mad(vertex_uniform_buffer_2[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].x, vertex_unnamed_66, vertex_unnamed_74)) + vertex_uniform_buffer_2[3u].x;
				precise float vertex_unnamed_109 = mad(vertex_uniform_buffer_2[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].y, vertex_unnamed_66, vertex_unnamed_75)) + vertex_uniform_buffer_2[3u].y;
				precise float vertex_unnamed_110 = mad(vertex_uniform_buffer_2[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].z, vertex_unnamed_66, vertex_unnamed_76)) + vertex_uniform_buffer_2[3u].z;
				precise float vertex_unnamed_111 = mad(vertex_uniform_buffer_2[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].w, vertex_unnamed_66, vertex_unnamed_77)) + vertex_uniform_buffer_2[3u].w;
				precise float vertex_unnamed_119 = vertex_unnamed_109 * vertex_uniform_buffer_3[18u].x;
				precise float vertex_unnamed_120 = vertex_unnamed_109 * vertex_uniform_buffer_3[18u].y;
				precise float vertex_unnamed_121 = vertex_unnamed_109 * vertex_uniform_buffer_3[18u].z;
				precise float vertex_unnamed_122 = vertex_unnamed_109 * vertex_uniform_buffer_3[18u].w;
				float vertex_unnamed_155 = mad(vertex_uniform_buffer_3[20u].w, vertex_unnamed_111, mad(vertex_uniform_buffer_3[19u].w, vertex_unnamed_110, mad(vertex_uniform_buffer_3[17u].w, vertex_unnamed_108, vertex_unnamed_122)));
				precise float vertex_unnamed_156 = mad(vertex_uniform_buffer_3[20u].x, vertex_unnamed_111, mad(vertex_uniform_buffer_3[19u].x, vertex_unnamed_110, mad(vertex_uniform_buffer_3[17u].x, vertex_unnamed_108, vertex_unnamed_119))) / vertex_unnamed_155;
				precise float vertex_unnamed_157 = mad(vertex_uniform_buffer_3[20u].y, vertex_unnamed_111, mad(vertex_uniform_buffer_3[19u].y, vertex_unnamed_110, mad(vertex_uniform_buffer_3[17u].y, vertex_unnamed_108, vertex_unnamed_120))) / vertex_unnamed_155;
				precise float vertex_unnamed_162 = vertex_uniform_buffer_1[6u].x * 0.5f;
				precise float vertex_unnamed_163 = vertex_uniform_buffer_1[6u].y * 0.5f;
				precise float vertex_unnamed_164 = vertex_unnamed_156 * vertex_unnamed_162;
				precise float vertex_unnamed_165 = vertex_unnamed_157 * vertex_unnamed_163;
				precise float vertex_unnamed_168 = round(vertex_unnamed_164) / vertex_unnamed_162;
				precise float vertex_unnamed_169 = round(vertex_unnamed_165) / vertex_unnamed_163;
				precise float vertex_unnamed_170 = vertex_unnamed_155 * vertex_unnamed_168;
				precise float vertex_unnamed_171 = vertex_unnamed_155 * vertex_unnamed_169;
				gl_Position.x = vertex_unnamed_170;
				gl_Position.y = vertex_unnamed_171;
				gl_Position.z = mad(vertex_uniform_buffer_3[20u].z, vertex_unnamed_111, mad(vertex_uniform_buffer_3[19u].z, vertex_unnamed_110, mad(vertex_uniform_buffer_3[17u].z, vertex_unnamed_108, vertex_unnamed_121)));
				gl_Position.w = vertex_unnamed_155;
				precise float vertex_unnamed_185 = 0.25f / mad(vertex_uniform_buffer_0[5u].x, 0.25f, vertex_unnamed_155);
				precise float vertex_unnamed_186 = 0.25f / mad(vertex_uniform_buffer_0[5u].y, 0.25f, vertex_unnamed_155);
				vertex_output_3.z = vertex_unnamed_185;
				vertex_output_3.w = vertex_unnamed_186;
				precise float vertex_unnamed_203 = vertex_input_1.x * vertex_uniform_buffer_0[2u].x;
				precise float vertex_unnamed_204 = vertex_input_1.y * vertex_uniform_buffer_0[2u].y;
				precise float vertex_unnamed_205 = vertex_input_1.z * vertex_uniform_buffer_0[2u].z;
				precise float vertex_unnamed_206 = vertex_input_1.w * vertex_uniform_buffer_0[2u].w;
				precise float vertex_unnamed_210 = vertex_unnamed_203 * vertex_uniform_buffer_0[3u].x;
				precise float vertex_unnamed_211 = vertex_unnamed_204 * vertex_uniform_buffer_0[3u].x;
				precise float vertex_unnamed_212 = vertex_unnamed_205 * vertex_uniform_buffer_0[3u].x;
				vertex_output_1.x = vertex_unnamed_210;
				vertex_output_1.y = vertex_unnamed_211;
				vertex_output_1.z = vertex_unnamed_212;
				vertex_output_1.w = vertex_unnamed_206;
				vertex_output_2.x = vertex_input_2.x;
				vertex_output_2.y = vertex_input_2.y;
				precise float vertex_unnamed_239 = (-0.0f) - min(max(vertex_uniform_buffer_0[4u].x, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_241 = (-0.0f) - min(max(vertex_uniform_buffer_0[4u].y, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_245 = (-0.0f) - min(max(vertex_uniform_buffer_0[4u].z, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_246 = (-0.0f) - min(max(vertex_uniform_buffer_0[4u].w, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_247 = vertex_unnamed_245 + mad(vertex_unnamed_66, 2.0f, vertex_unnamed_239);
				precise float vertex_unnamed_248 = vertex_unnamed_246 + mad(vertex_unnamed_67, 2.0f, vertex_unnamed_241);
				vertex_output_3.x = vertex_unnamed_247;
				vertex_output_3.y = vertex_unnamed_248;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[2] = float4(_Color[0], _Color[1], _Color[2], _Color[3]);

				vertex_uniform_buffer_0[3] = float4(_DiffusePower, vertex_uniform_buffer_0[3][1], vertex_uniform_buffer_0[3][2], vertex_uniform_buffer_0[3][3]);

				vertex_uniform_buffer_0[3] = float4(vertex_uniform_buffer_0[3][0], _VertexOffsetX, vertex_uniform_buffer_0[3][2], vertex_uniform_buffer_0[3][3]);

				vertex_uniform_buffer_0[3] = float4(vertex_uniform_buffer_0[3][0], vertex_uniform_buffer_0[3][1], _VertexOffsetY, vertex_uniform_buffer_0[3][3]);

				vertex_uniform_buffer_0[4] = float4(_ClipRect[0], _ClipRect[1], _ClipRect[2], _ClipRect[3]);

				vertex_uniform_buffer_0[5] = float4(_MaskSoftnessX, vertex_uniform_buffer_0[5][1], vertex_uniform_buffer_0[5][2], vertex_uniform_buffer_0[5][3]);

				vertex_uniform_buffer_0[5] = float4(vertex_uniform_buffer_0[5][0], _MaskSoftnessY, vertex_uniform_buffer_0[5][2], vertex_uniform_buffer_0[5][3]);

				vertex_uniform_buffer_1[6] = float4(_ScreenParams[0], _ScreenParams[1], _ScreenParams[2], _ScreenParams[3]);

				vertex_uniform_buffer_2[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_2[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_2[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_2[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_3[17] = float4(unity_MatrixVP[0][0], unity_MatrixVP[1][0], unity_MatrixVP[2][0], unity_MatrixVP[3][0]);
				vertex_uniform_buffer_3[18] = float4(unity_MatrixVP[0][1], unity_MatrixVP[1][1], unity_MatrixVP[2][1], unity_MatrixVP[3][1]);
				vertex_uniform_buffer_3[19] = float4(unity_MatrixVP[0][2], unity_MatrixVP[1][2], unity_MatrixVP[2][2], unity_MatrixVP[3][2]);
				vertex_uniform_buffer_3[20] = float4(unity_MatrixVP[0][3], unity_MatrixVP[1][3], unity_MatrixVP[2][3], unity_MatrixVP[3][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_2 = stage_input.vertex_input_2;
				vertex_input_3 = stage_input.vertex_input_3;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				return stage_output;
			}

			#endif // UNITY_UI_ALPHACLIP
			#endif // !UNITY_UI_CLIP_RECT


			#ifdef UNITY_UI_CLIP_RECT
			#ifndef UNITY_UI_ALPHACLIP
			#define ANY_SHADER_VARIANT_ACTIVE

			float4 _Color;
			float _DiffusePower;
			float _VertexOffsetX;
			float _VertexOffsetY;
			float4 _ClipRect;
			float _MaskSoftnessX;
			float _MaskSoftnessY;
			float4 _ScreenParams;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[6];
			static float4 vertex_uniform_buffer_1[7];
			static float4 vertex_uniform_buffer_2[4];
			static float4 vertex_uniform_buffer_3[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float2 vertex_input_2;
			static float2 vertex_input_3;
			static float4 vertex_output_1;
			static float2 vertex_output_2;
			static float4 vertex_output_3;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION; // POSITION
				float4 vertex_input_1 : COLOR; // COLOR
				float2 vertex_input_2 : TEXCOORD; // TEXCOORD
				float2 vertex_input_3 : TEXCOORD1; // TEXCOORD_1
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : COLOR; // COLOR
				float2 vertex_output_2 : TEXCOORD; // TEXCOORD
				float4 vertex_output_3 : TEXCOORD2; // TEXCOORD_2
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_45 = vertex_input_0.w * 0.5f;
				precise float vertex_unnamed_53 = vertex_unnamed_45 / vertex_uniform_buffer_1[6u].x;
				precise float vertex_unnamed_54 = vertex_unnamed_45 / vertex_uniform_buffer_1[6u].y;
				precise float vertex_unnamed_64 = vertex_input_0.x + vertex_uniform_buffer_0[3u].y;
				precise float vertex_unnamed_65 = vertex_input_0.y + vertex_uniform_buffer_0[3u].z;
				precise float vertex_unnamed_66 = vertex_unnamed_53 + vertex_unnamed_64;
				precise float vertex_unnamed_67 = vertex_unnamed_54 + vertex_unnamed_65;
				precise float vertex_unnamed_74 = vertex_unnamed_67 * vertex_uniform_buffer_2[1u].x;
				precise float vertex_unnamed_75 = vertex_unnamed_67 * vertex_uniform_buffer_2[1u].y;
				precise float vertex_unnamed_76 = vertex_unnamed_67 * vertex_uniform_buffer_2[1u].z;
				precise float vertex_unnamed_77 = vertex_unnamed_67 * vertex_uniform_buffer_2[1u].w;
				precise float vertex_unnamed_108 = mad(vertex_uniform_buffer_2[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].x, vertex_unnamed_66, vertex_unnamed_74)) + vertex_uniform_buffer_2[3u].x;
				precise float vertex_unnamed_109 = mad(vertex_uniform_buffer_2[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].y, vertex_unnamed_66, vertex_unnamed_75)) + vertex_uniform_buffer_2[3u].y;
				precise float vertex_unnamed_110 = mad(vertex_uniform_buffer_2[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].z, vertex_unnamed_66, vertex_unnamed_76)) + vertex_uniform_buffer_2[3u].z;
				precise float vertex_unnamed_111 = mad(vertex_uniform_buffer_2[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].w, vertex_unnamed_66, vertex_unnamed_77)) + vertex_uniform_buffer_2[3u].w;
				precise float vertex_unnamed_119 = vertex_unnamed_109 * vertex_uniform_buffer_3[18u].x;
				precise float vertex_unnamed_120 = vertex_unnamed_109 * vertex_uniform_buffer_3[18u].y;
				precise float vertex_unnamed_121 = vertex_unnamed_109 * vertex_uniform_buffer_3[18u].z;
				precise float vertex_unnamed_122 = vertex_unnamed_109 * vertex_uniform_buffer_3[18u].w;
				float vertex_unnamed_155 = mad(vertex_uniform_buffer_3[20u].w, vertex_unnamed_111, mad(vertex_uniform_buffer_3[19u].w, vertex_unnamed_110, mad(vertex_uniform_buffer_3[17u].w, vertex_unnamed_108, vertex_unnamed_122)));
				precise float vertex_unnamed_156 = mad(vertex_uniform_buffer_3[20u].x, vertex_unnamed_111, mad(vertex_uniform_buffer_3[19u].x, vertex_unnamed_110, mad(vertex_uniform_buffer_3[17u].x, vertex_unnamed_108, vertex_unnamed_119))) / vertex_unnamed_155;
				precise float vertex_unnamed_157 = mad(vertex_uniform_buffer_3[20u].y, vertex_unnamed_111, mad(vertex_uniform_buffer_3[19u].y, vertex_unnamed_110, mad(vertex_uniform_buffer_3[17u].y, vertex_unnamed_108, vertex_unnamed_120))) / vertex_unnamed_155;
				precise float vertex_unnamed_162 = vertex_uniform_buffer_1[6u].x * 0.5f;
				precise float vertex_unnamed_163 = vertex_uniform_buffer_1[6u].y * 0.5f;
				precise float vertex_unnamed_164 = vertex_unnamed_156 * vertex_unnamed_162;
				precise float vertex_unnamed_165 = vertex_unnamed_157 * vertex_unnamed_163;
				precise float vertex_unnamed_168 = round(vertex_unnamed_164) / vertex_unnamed_162;
				precise float vertex_unnamed_169 = round(vertex_unnamed_165) / vertex_unnamed_163;
				precise float vertex_unnamed_170 = vertex_unnamed_155 * vertex_unnamed_168;
				precise float vertex_unnamed_171 = vertex_unnamed_155 * vertex_unnamed_169;
				gl_Position.x = vertex_unnamed_170;
				gl_Position.y = vertex_unnamed_171;
				gl_Position.z = mad(vertex_uniform_buffer_3[20u].z, vertex_unnamed_111, mad(vertex_uniform_buffer_3[19u].z, vertex_unnamed_110, mad(vertex_uniform_buffer_3[17u].z, vertex_unnamed_108, vertex_unnamed_121)));
				gl_Position.w = vertex_unnamed_155;
				precise float vertex_unnamed_185 = 0.25f / mad(vertex_uniform_buffer_0[5u].x, 0.25f, vertex_unnamed_155);
				precise float vertex_unnamed_186 = 0.25f / mad(vertex_uniform_buffer_0[5u].y, 0.25f, vertex_unnamed_155);
				vertex_output_3.z = vertex_unnamed_185;
				vertex_output_3.w = vertex_unnamed_186;
				precise float vertex_unnamed_203 = vertex_input_1.x * vertex_uniform_buffer_0[2u].x;
				precise float vertex_unnamed_204 = vertex_input_1.y * vertex_uniform_buffer_0[2u].y;
				precise float vertex_unnamed_205 = vertex_input_1.z * vertex_uniform_buffer_0[2u].z;
				precise float vertex_unnamed_206 = vertex_input_1.w * vertex_uniform_buffer_0[2u].w;
				precise float vertex_unnamed_210 = vertex_unnamed_203 * vertex_uniform_buffer_0[3u].x;
				precise float vertex_unnamed_211 = vertex_unnamed_204 * vertex_uniform_buffer_0[3u].x;
				precise float vertex_unnamed_212 = vertex_unnamed_205 * vertex_uniform_buffer_0[3u].x;
				vertex_output_1.x = vertex_unnamed_210;
				vertex_output_1.y = vertex_unnamed_211;
				vertex_output_1.z = vertex_unnamed_212;
				vertex_output_1.w = vertex_unnamed_206;
				vertex_output_2.x = vertex_input_2.x;
				vertex_output_2.y = vertex_input_2.y;
				precise float vertex_unnamed_239 = (-0.0f) - min(max(vertex_uniform_buffer_0[4u].x, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_241 = (-0.0f) - min(max(vertex_uniform_buffer_0[4u].y, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_245 = (-0.0f) - min(max(vertex_uniform_buffer_0[4u].z, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_246 = (-0.0f) - min(max(vertex_uniform_buffer_0[4u].w, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_247 = vertex_unnamed_245 + mad(vertex_unnamed_66, 2.0f, vertex_unnamed_239);
				precise float vertex_unnamed_248 = vertex_unnamed_246 + mad(vertex_unnamed_67, 2.0f, vertex_unnamed_241);
				vertex_output_3.x = vertex_unnamed_247;
				vertex_output_3.y = vertex_unnamed_248;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[2] = float4(_Color[0], _Color[1], _Color[2], _Color[3]);

				vertex_uniform_buffer_0[3] = float4(_DiffusePower, vertex_uniform_buffer_0[3][1], vertex_uniform_buffer_0[3][2], vertex_uniform_buffer_0[3][3]);

				vertex_uniform_buffer_0[3] = float4(vertex_uniform_buffer_0[3][0], _VertexOffsetX, vertex_uniform_buffer_0[3][2], vertex_uniform_buffer_0[3][3]);

				vertex_uniform_buffer_0[3] = float4(vertex_uniform_buffer_0[3][0], vertex_uniform_buffer_0[3][1], _VertexOffsetY, vertex_uniform_buffer_0[3][3]);

				vertex_uniform_buffer_0[4] = float4(_ClipRect[0], _ClipRect[1], _ClipRect[2], _ClipRect[3]);

				vertex_uniform_buffer_0[5] = float4(_MaskSoftnessX, vertex_uniform_buffer_0[5][1], vertex_uniform_buffer_0[5][2], vertex_uniform_buffer_0[5][3]);

				vertex_uniform_buffer_0[5] = float4(vertex_uniform_buffer_0[5][0], _MaskSoftnessY, vertex_uniform_buffer_0[5][2], vertex_uniform_buffer_0[5][3]);

				vertex_uniform_buffer_1[6] = float4(_ScreenParams[0], _ScreenParams[1], _ScreenParams[2], _ScreenParams[3]);

				vertex_uniform_buffer_2[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_2[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_2[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_2[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_3[17] = float4(unity_MatrixVP[0][0], unity_MatrixVP[1][0], unity_MatrixVP[2][0], unity_MatrixVP[3][0]);
				vertex_uniform_buffer_3[18] = float4(unity_MatrixVP[0][1], unity_MatrixVP[1][1], unity_MatrixVP[2][1], unity_MatrixVP[3][1]);
				vertex_uniform_buffer_3[19] = float4(unity_MatrixVP[0][2], unity_MatrixVP[1][2], unity_MatrixVP[2][2], unity_MatrixVP[3][2]);
				vertex_uniform_buffer_3[20] = float4(unity_MatrixVP[0][3], unity_MatrixVP[1][3], unity_MatrixVP[2][3], unity_MatrixVP[3][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_2 = stage_input.vertex_input_2;
				vertex_input_3 = stage_input.vertex_input_3;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				return stage_output;
			}

			#endif // UNITY_UI_CLIP_RECT
			#endif // !UNITY_UI_ALPHACLIP


			#ifdef UNITY_UI_ALPHACLIP
			#ifdef UNITY_UI_CLIP_RECT
			#define ANY_SHADER_VARIANT_ACTIVE

			float4 _Color;
			float _DiffusePower;
			float _VertexOffsetX;
			float _VertexOffsetY;
			float4 _ClipRect;
			float _MaskSoftnessX;
			float _MaskSoftnessY;
			float4 _ScreenParams;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[6];
			static float4 vertex_uniform_buffer_1[7];
			static float4 vertex_uniform_buffer_2[4];
			static float4 vertex_uniform_buffer_3[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float2 vertex_input_2;
			static float2 vertex_input_3;
			static float4 vertex_output_1;
			static float2 vertex_output_2;
			static float4 vertex_output_3;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION; // POSITION
				float4 vertex_input_1 : COLOR; // COLOR
				float2 vertex_input_2 : TEXCOORD; // TEXCOORD
				float2 vertex_input_3 : TEXCOORD1; // TEXCOORD_1
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : COLOR; // COLOR
				float2 vertex_output_2 : TEXCOORD; // TEXCOORD
				float4 vertex_output_3 : TEXCOORD2; // TEXCOORD_2
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_45 = vertex_input_0.w * 0.5f;
				precise float vertex_unnamed_53 = vertex_unnamed_45 / vertex_uniform_buffer_1[6u].x;
				precise float vertex_unnamed_54 = vertex_unnamed_45 / vertex_uniform_buffer_1[6u].y;
				precise float vertex_unnamed_64 = vertex_input_0.x + vertex_uniform_buffer_0[3u].y;
				precise float vertex_unnamed_65 = vertex_input_0.y + vertex_uniform_buffer_0[3u].z;
				precise float vertex_unnamed_66 = vertex_unnamed_53 + vertex_unnamed_64;
				precise float vertex_unnamed_67 = vertex_unnamed_54 + vertex_unnamed_65;
				precise float vertex_unnamed_74 = vertex_unnamed_67 * vertex_uniform_buffer_2[1u].x;
				precise float vertex_unnamed_75 = vertex_unnamed_67 * vertex_uniform_buffer_2[1u].y;
				precise float vertex_unnamed_76 = vertex_unnamed_67 * vertex_uniform_buffer_2[1u].z;
				precise float vertex_unnamed_77 = vertex_unnamed_67 * vertex_uniform_buffer_2[1u].w;
				precise float vertex_unnamed_108 = mad(vertex_uniform_buffer_2[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].x, vertex_unnamed_66, vertex_unnamed_74)) + vertex_uniform_buffer_2[3u].x;
				precise float vertex_unnamed_109 = mad(vertex_uniform_buffer_2[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].y, vertex_unnamed_66, vertex_unnamed_75)) + vertex_uniform_buffer_2[3u].y;
				precise float vertex_unnamed_110 = mad(vertex_uniform_buffer_2[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].z, vertex_unnamed_66, vertex_unnamed_76)) + vertex_uniform_buffer_2[3u].z;
				precise float vertex_unnamed_111 = mad(vertex_uniform_buffer_2[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].w, vertex_unnamed_66, vertex_unnamed_77)) + vertex_uniform_buffer_2[3u].w;
				precise float vertex_unnamed_119 = vertex_unnamed_109 * vertex_uniform_buffer_3[18u].x;
				precise float vertex_unnamed_120 = vertex_unnamed_109 * vertex_uniform_buffer_3[18u].y;
				precise float vertex_unnamed_121 = vertex_unnamed_109 * vertex_uniform_buffer_3[18u].z;
				precise float vertex_unnamed_122 = vertex_unnamed_109 * vertex_uniform_buffer_3[18u].w;
				float vertex_unnamed_155 = mad(vertex_uniform_buffer_3[20u].w, vertex_unnamed_111, mad(vertex_uniform_buffer_3[19u].w, vertex_unnamed_110, mad(vertex_uniform_buffer_3[17u].w, vertex_unnamed_108, vertex_unnamed_122)));
				precise float vertex_unnamed_156 = mad(vertex_uniform_buffer_3[20u].x, vertex_unnamed_111, mad(vertex_uniform_buffer_3[19u].x, vertex_unnamed_110, mad(vertex_uniform_buffer_3[17u].x, vertex_unnamed_108, vertex_unnamed_119))) / vertex_unnamed_155;
				precise float vertex_unnamed_157 = mad(vertex_uniform_buffer_3[20u].y, vertex_unnamed_111, mad(vertex_uniform_buffer_3[19u].y, vertex_unnamed_110, mad(vertex_uniform_buffer_3[17u].y, vertex_unnamed_108, vertex_unnamed_120))) / vertex_unnamed_155;
				precise float vertex_unnamed_162 = vertex_uniform_buffer_1[6u].x * 0.5f;
				precise float vertex_unnamed_163 = vertex_uniform_buffer_1[6u].y * 0.5f;
				precise float vertex_unnamed_164 = vertex_unnamed_156 * vertex_unnamed_162;
				precise float vertex_unnamed_165 = vertex_unnamed_157 * vertex_unnamed_163;
				precise float vertex_unnamed_168 = round(vertex_unnamed_164) / vertex_unnamed_162;
				precise float vertex_unnamed_169 = round(vertex_unnamed_165) / vertex_unnamed_163;
				precise float vertex_unnamed_170 = vertex_unnamed_155 * vertex_unnamed_168;
				precise float vertex_unnamed_171 = vertex_unnamed_155 * vertex_unnamed_169;
				gl_Position.x = vertex_unnamed_170;
				gl_Position.y = vertex_unnamed_171;
				gl_Position.z = mad(vertex_uniform_buffer_3[20u].z, vertex_unnamed_111, mad(vertex_uniform_buffer_3[19u].z, vertex_unnamed_110, mad(vertex_uniform_buffer_3[17u].z, vertex_unnamed_108, vertex_unnamed_121)));
				gl_Position.w = vertex_unnamed_155;
				precise float vertex_unnamed_185 = 0.25f / mad(vertex_uniform_buffer_0[5u].x, 0.25f, vertex_unnamed_155);
				precise float vertex_unnamed_186 = 0.25f / mad(vertex_uniform_buffer_0[5u].y, 0.25f, vertex_unnamed_155);
				vertex_output_3.z = vertex_unnamed_185;
				vertex_output_3.w = vertex_unnamed_186;
				precise float vertex_unnamed_203 = vertex_input_1.x * vertex_uniform_buffer_0[2u].x;
				precise float vertex_unnamed_204 = vertex_input_1.y * vertex_uniform_buffer_0[2u].y;
				precise float vertex_unnamed_205 = vertex_input_1.z * vertex_uniform_buffer_0[2u].z;
				precise float vertex_unnamed_206 = vertex_input_1.w * vertex_uniform_buffer_0[2u].w;
				precise float vertex_unnamed_210 = vertex_unnamed_203 * vertex_uniform_buffer_0[3u].x;
				precise float vertex_unnamed_211 = vertex_unnamed_204 * vertex_uniform_buffer_0[3u].x;
				precise float vertex_unnamed_212 = vertex_unnamed_205 * vertex_uniform_buffer_0[3u].x;
				vertex_output_1.x = vertex_unnamed_210;
				vertex_output_1.y = vertex_unnamed_211;
				vertex_output_1.z = vertex_unnamed_212;
				vertex_output_1.w = vertex_unnamed_206;
				vertex_output_2.x = vertex_input_2.x;
				vertex_output_2.y = vertex_input_2.y;
				precise float vertex_unnamed_239 = (-0.0f) - min(max(vertex_uniform_buffer_0[4u].x, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_241 = (-0.0f) - min(max(vertex_uniform_buffer_0[4u].y, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_245 = (-0.0f) - min(max(vertex_uniform_buffer_0[4u].z, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_246 = (-0.0f) - min(max(vertex_uniform_buffer_0[4u].w, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_247 = vertex_unnamed_245 + mad(vertex_unnamed_66, 2.0f, vertex_unnamed_239);
				precise float vertex_unnamed_248 = vertex_unnamed_246 + mad(vertex_unnamed_67, 2.0f, vertex_unnamed_241);
				vertex_output_3.x = vertex_unnamed_247;
				vertex_output_3.y = vertex_unnamed_248;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[2] = float4(_Color[0], _Color[1], _Color[2], _Color[3]);

				vertex_uniform_buffer_0[3] = float4(_DiffusePower, vertex_uniform_buffer_0[3][1], vertex_uniform_buffer_0[3][2], vertex_uniform_buffer_0[3][3]);

				vertex_uniform_buffer_0[3] = float4(vertex_uniform_buffer_0[3][0], _VertexOffsetX, vertex_uniform_buffer_0[3][2], vertex_uniform_buffer_0[3][3]);

				vertex_uniform_buffer_0[3] = float4(vertex_uniform_buffer_0[3][0], vertex_uniform_buffer_0[3][1], _VertexOffsetY, vertex_uniform_buffer_0[3][3]);

				vertex_uniform_buffer_0[4] = float4(_ClipRect[0], _ClipRect[1], _ClipRect[2], _ClipRect[3]);

				vertex_uniform_buffer_0[5] = float4(_MaskSoftnessX, vertex_uniform_buffer_0[5][1], vertex_uniform_buffer_0[5][2], vertex_uniform_buffer_0[5][3]);

				vertex_uniform_buffer_0[5] = float4(vertex_uniform_buffer_0[5][0], _MaskSoftnessY, vertex_uniform_buffer_0[5][2], vertex_uniform_buffer_0[5][3]);

				vertex_uniform_buffer_1[6] = float4(_ScreenParams[0], _ScreenParams[1], _ScreenParams[2], _ScreenParams[3]);

				vertex_uniform_buffer_2[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_2[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_2[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_2[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_3[17] = float4(unity_MatrixVP[0][0], unity_MatrixVP[1][0], unity_MatrixVP[2][0], unity_MatrixVP[3][0]);
				vertex_uniform_buffer_3[18] = float4(unity_MatrixVP[0][1], unity_MatrixVP[1][1], unity_MatrixVP[2][1], unity_MatrixVP[3][1]);
				vertex_uniform_buffer_3[19] = float4(unity_MatrixVP[0][2], unity_MatrixVP[1][2], unity_MatrixVP[2][2], unity_MatrixVP[3][2]);
				vertex_uniform_buffer_3[20] = float4(unity_MatrixVP[0][3], unity_MatrixVP[1][3], unity_MatrixVP[2][3], unity_MatrixVP[3][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_2 = stage_input.vertex_input_2;
				vertex_input_3 = stage_input.vertex_input_3;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				return stage_output;
			}

			#endif // UNITY_UI_ALPHACLIP
			#endif // UNITY_UI_CLIP_RECT


			#ifndef UNITY_UI_ALPHACLIP
			#ifndef UNITY_UI_CLIP_RECT
			#define ANY_SHADER_VARIANT_ACTIVE

			float4 _ScreenParams;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;
			float4 _Color;
			float _DiffusePower;
			float _VertexOffsetX;
			float _VertexOffsetY;
			float4 _ClipRect;
			float _MaskSoftnessX;
			float _MaskSoftnessY;

			static float4 unity_ObjectToWorld__array[4];
			static float4 unity_MatrixVP__array[4];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_output_2;
			static float4 vertex_input_1;
			static float4 vertex_output_0;
			static float2 vertex_output_1;
			static float2 vertex_input_2;

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
				float4 vertex_output_2 : TEXCOORD2; // vs_TEXCOORD2
				float4 gl_Position : SV_Position;
			};

			static float2 vertex_unnamed_9;
			static float2 vertex_unnamed_38;
			static float4 vertex_unnamed_54;
			static float4 vertex_unnamed_81;

			void vert_main()
			{
				vertex_unnamed_9.x = vertex_input_0.w * 0.5f;
				vertex_unnamed_9 = vertex_unnamed_9.xx / _ScreenParams.xy;
				vertex_unnamed_38 = vertex_input_0.xy + float2(_VertexOffsetX, _VertexOffsetY);
				vertex_unnamed_9 += vertex_unnamed_38;
				vertex_unnamed_54 = vertex_unnamed_9.yyyy * unity_ObjectToWorld__array[1];
				vertex_unnamed_54 = (unity_ObjectToWorld__array[0] * vertex_unnamed_9.xxxx) + vertex_unnamed_54;
				vertex_unnamed_54 = (unity_ObjectToWorld__array[2] * vertex_input_0.zzzz) + vertex_unnamed_54;
				vertex_unnamed_54 += unity_ObjectToWorld__array[3];
				vertex_unnamed_81 = vertex_unnamed_54.yyyy * unity_MatrixVP__array[1];
				vertex_unnamed_81 = (unity_MatrixVP__array[0] * vertex_unnamed_54.xxxx) + vertex_unnamed_81;
				vertex_unnamed_81 = (unity_MatrixVP__array[2] * vertex_unnamed_54.zzzz) + vertex_unnamed_81;
				vertex_unnamed_54 = (unity_MatrixVP__array[3] * vertex_unnamed_54.wwww) + vertex_unnamed_81;
				vertex_unnamed_38 = vertex_unnamed_54.xy / vertex_unnamed_54.ww;
				float2 vertex_unnamed_117 = _ScreenParams.xy * 0.5f.xx;
				vertex_unnamed_54 = float4(vertex_unnamed_117.x, vertex_unnamed_117.y, vertex_unnamed_54.z, vertex_unnamed_54.w);
				vertex_unnamed_38 *= vertex_unnamed_54.xy;
				vertex_unnamed_38 = round(vertex_unnamed_38);
				vertex_unnamed_38 /= vertex_unnamed_54.xy;
				float2 vertex_unnamed_138 = vertex_unnamed_54.ww * vertex_unnamed_38;
				gl_Position = float4(vertex_unnamed_138.x, vertex_unnamed_138.y, gl_Position.z, gl_Position.w);
				gl_Position = float4(gl_Position.x, gl_Position.y, vertex_unnamed_54.zw.x, vertex_unnamed_54.zw.y);
				vertex_unnamed_38 = (float2(_MaskSoftnessX, _MaskSoftnessY) * 0.25f.xx) + vertex_unnamed_54.ww;
				float2 vertex_unnamed_163 = 0.25f.xx / vertex_unnamed_38;
				vertex_output_2 = float4(vertex_output_2.x, vertex_output_2.y, vertex_unnamed_163.x, vertex_unnamed_163.y);
				vertex_unnamed_54 = vertex_input_1 * _Color;
				float3 vertex_unnamed_179 = vertex_unnamed_54.xyz * _DiffusePower.xxx;
				vertex_output_0 = float4(vertex_unnamed_179.x, vertex_unnamed_179.y, vertex_unnamed_179.z, vertex_output_0.w);
				vertex_output_0.w = vertex_unnamed_54.w;
				vertex_output_1 = vertex_input_2;
				vertex_unnamed_54 = max(_ClipRect, (-20000000000.0f).xxxx);
				vertex_unnamed_54 = min(vertex_unnamed_54, 20000000000.0f.xxxx);
				vertex_unnamed_9 = (vertex_unnamed_9 * 2.0f.xx) + (-vertex_unnamed_54.xy);
				float2 vertex_unnamed_213 = (-vertex_unnamed_54.zw) + vertex_unnamed_9;
				vertex_output_2 = float4(vertex_unnamed_213.x, vertex_unnamed_213.y, vertex_output_2.z, vertex_output_2.w);
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
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_0 = vertex_output_0;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}

			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

			static float2 fragment_input_1;
			static float4 fragment_output_0;
			static float4 fragment_input_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_0 : UNKNOWN0;
				float2 fragment_input_1 : TEXCOORD0; // vs_TEXCOORD0
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static float fragment_unnamed_8;

			void frag_main()
			{
				fragment_unnamed_8 = _MainTex.Sample(sampler_MainTex, fragment_input_1).w;
				fragment_output_0.w = fragment_unnamed_8 * fragment_input_0.w;
				fragment_output_0 = float4(fragment_input_0.xyz.x, fragment_input_0.xyz.y, fragment_input_0.xyz.z, fragment_output_0.w);
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

			#endif // !UNITY_UI_ALPHACLIP
			#endif // !UNITY_UI_CLIP_RECT


			#ifdef UNITY_UI_ALPHACLIP
			#ifndef UNITY_UI_CLIP_RECT
			#define ANY_SHADER_VARIANT_ACTIVE

			float4 _ScreenParams;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;
			float4 _Color;
			float _DiffusePower;
			float _VertexOffsetX;
			float _VertexOffsetY;
			float4 _ClipRect;
			float _MaskSoftnessX;
			float _MaskSoftnessY;

			static float4 unity_ObjectToWorld__array[4];
			static float4 unity_MatrixVP__array[4];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_output_2;
			static float4 vertex_input_1;
			static float4 vertex_output_0;
			static float2 vertex_output_1;
			static float2 vertex_input_2;

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
				float4 vertex_output_2 : TEXCOORD2; // vs_TEXCOORD2
				float4 gl_Position : SV_Position;
			};

			static float2 vertex_unnamed_9;
			static float2 vertex_unnamed_38;
			static float4 vertex_unnamed_54;
			static float4 vertex_unnamed_81;

			void vert_main()
			{
				vertex_unnamed_9.x = vertex_input_0.w * 0.5f;
				vertex_unnamed_9 = vertex_unnamed_9.xx / _ScreenParams.xy;
				vertex_unnamed_38 = vertex_input_0.xy + float2(_VertexOffsetX, _VertexOffsetY);
				vertex_unnamed_9 += vertex_unnamed_38;
				vertex_unnamed_54 = vertex_unnamed_9.yyyy * unity_ObjectToWorld__array[1];
				vertex_unnamed_54 = (unity_ObjectToWorld__array[0] * vertex_unnamed_9.xxxx) + vertex_unnamed_54;
				vertex_unnamed_54 = (unity_ObjectToWorld__array[2] * vertex_input_0.zzzz) + vertex_unnamed_54;
				vertex_unnamed_54 += unity_ObjectToWorld__array[3];
				vertex_unnamed_81 = vertex_unnamed_54.yyyy * unity_MatrixVP__array[1];
				vertex_unnamed_81 = (unity_MatrixVP__array[0] * vertex_unnamed_54.xxxx) + vertex_unnamed_81;
				vertex_unnamed_81 = (unity_MatrixVP__array[2] * vertex_unnamed_54.zzzz) + vertex_unnamed_81;
				vertex_unnamed_54 = (unity_MatrixVP__array[3] * vertex_unnamed_54.wwww) + vertex_unnamed_81;
				vertex_unnamed_38 = vertex_unnamed_54.xy / vertex_unnamed_54.ww;
				float2 vertex_unnamed_117 = _ScreenParams.xy * 0.5f.xx;
				vertex_unnamed_54 = float4(vertex_unnamed_117.x, vertex_unnamed_117.y, vertex_unnamed_54.z, vertex_unnamed_54.w);
				vertex_unnamed_38 *= vertex_unnamed_54.xy;
				vertex_unnamed_38 = round(vertex_unnamed_38);
				vertex_unnamed_38 /= vertex_unnamed_54.xy;
				float2 vertex_unnamed_138 = vertex_unnamed_54.ww * vertex_unnamed_38;
				gl_Position = float4(vertex_unnamed_138.x, vertex_unnamed_138.y, gl_Position.z, gl_Position.w);
				gl_Position = float4(gl_Position.x, gl_Position.y, vertex_unnamed_54.zw.x, vertex_unnamed_54.zw.y);
				vertex_unnamed_38 = (float2(_MaskSoftnessX, _MaskSoftnessY) * 0.25f.xx) + vertex_unnamed_54.ww;
				float2 vertex_unnamed_163 = 0.25f.xx / vertex_unnamed_38;
				vertex_output_2 = float4(vertex_output_2.x, vertex_output_2.y, vertex_unnamed_163.x, vertex_unnamed_163.y);
				vertex_unnamed_54 = vertex_input_1 * _Color;
				float3 vertex_unnamed_179 = vertex_unnamed_54.xyz * _DiffusePower.xxx;
				vertex_output_0 = float4(vertex_unnamed_179.x, vertex_unnamed_179.y, vertex_unnamed_179.z, vertex_output_0.w);
				vertex_output_0.w = vertex_unnamed_54.w;
				vertex_output_1 = vertex_input_2;
				vertex_unnamed_54 = max(_ClipRect, (-20000000000.0f).xxxx);
				vertex_unnamed_54 = min(vertex_unnamed_54, 20000000000.0f.xxxx);
				vertex_unnamed_9 = (vertex_unnamed_9 * 2.0f.xx) + (-vertex_unnamed_54.xy);
				float2 vertex_unnamed_213 = (-vertex_unnamed_54.zw) + vertex_unnamed_9;
				vertex_output_2 = float4(vertex_unnamed_213.x, vertex_unnamed_213.y, vertex_output_2.z, vertex_output_2.w);
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
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_0 = vertex_output_0;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}

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

			static float fragment_unnamed_8;
			static float fragment_unnamed_28;
			static bool fragment_unnamed_49;

			void frag_main()
			{
				fragment_unnamed_8 = _MainTex.Sample(sampler_MainTex, fragment_input_1).w;
				fragment_unnamed_28 = (fragment_input_0.w * fragment_unnamed_8) + (-0.001000000047497451305389404296875f);
				fragment_unnamed_8 *= fragment_input_0.w;
				fragment_output_0.w = fragment_unnamed_8;
				fragment_unnamed_49 = fragment_unnamed_28 < 0.0f;
				if ((int(fragment_unnamed_49) * (-1)) != 0)
				{
					discard;
				}
				fragment_output_0 = float4(fragment_input_0.xyz.x, fragment_input_0.xyz.y, fragment_input_0.xyz.z, fragment_output_0.w);
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

			#endif // UNITY_UI_ALPHACLIP
			#endif // !UNITY_UI_CLIP_RECT


			#ifdef UNITY_UI_CLIP_RECT
			#ifndef UNITY_UI_ALPHACLIP
			#define ANY_SHADER_VARIANT_ACTIVE

			float4 _ScreenParams;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;
			float4 _Color;
			float _DiffusePower;
			float _VertexOffsetX;
			float _VertexOffsetY;
			float4 _ClipRect;
			float _MaskSoftnessX;
			float _MaskSoftnessY;

			static float4 unity_ObjectToWorld__array[4];
			static float4 unity_MatrixVP__array[4];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_output_2;
			static float4 vertex_input_1;
			static float4 vertex_output_0;
			static float2 vertex_output_1;
			static float2 vertex_input_2;

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
				float4 vertex_output_2 : TEXCOORD2; // vs_TEXCOORD2
				float4 gl_Position : SV_Position;
			};

			static float2 vertex_unnamed_9;
			static float2 vertex_unnamed_38;
			static float4 vertex_unnamed_54;
			static float4 vertex_unnamed_81;

			void vert_main()
			{
				vertex_unnamed_9.x = vertex_input_0.w * 0.5f;
				vertex_unnamed_9 = vertex_unnamed_9.xx / _ScreenParams.xy;
				vertex_unnamed_38 = vertex_input_0.xy + float2(_VertexOffsetX, _VertexOffsetY);
				vertex_unnamed_9 += vertex_unnamed_38;
				vertex_unnamed_54 = vertex_unnamed_9.yyyy * unity_ObjectToWorld__array[1];
				vertex_unnamed_54 = (unity_ObjectToWorld__array[0] * vertex_unnamed_9.xxxx) + vertex_unnamed_54;
				vertex_unnamed_54 = (unity_ObjectToWorld__array[2] * vertex_input_0.zzzz) + vertex_unnamed_54;
				vertex_unnamed_54 += unity_ObjectToWorld__array[3];
				vertex_unnamed_81 = vertex_unnamed_54.yyyy * unity_MatrixVP__array[1];
				vertex_unnamed_81 = (unity_MatrixVP__array[0] * vertex_unnamed_54.xxxx) + vertex_unnamed_81;
				vertex_unnamed_81 = (unity_MatrixVP__array[2] * vertex_unnamed_54.zzzz) + vertex_unnamed_81;
				vertex_unnamed_54 = (unity_MatrixVP__array[3] * vertex_unnamed_54.wwww) + vertex_unnamed_81;
				vertex_unnamed_38 = vertex_unnamed_54.xy / vertex_unnamed_54.ww;
				float2 vertex_unnamed_117 = _ScreenParams.xy * 0.5f.xx;
				vertex_unnamed_54 = float4(vertex_unnamed_117.x, vertex_unnamed_117.y, vertex_unnamed_54.z, vertex_unnamed_54.w);
				vertex_unnamed_38 *= vertex_unnamed_54.xy;
				vertex_unnamed_38 = round(vertex_unnamed_38);
				vertex_unnamed_38 /= vertex_unnamed_54.xy;
				float2 vertex_unnamed_138 = vertex_unnamed_54.ww * vertex_unnamed_38;
				gl_Position = float4(vertex_unnamed_138.x, vertex_unnamed_138.y, gl_Position.z, gl_Position.w);
				gl_Position = float4(gl_Position.x, gl_Position.y, vertex_unnamed_54.zw.x, vertex_unnamed_54.zw.y);
				vertex_unnamed_38 = (float2(_MaskSoftnessX, _MaskSoftnessY) * 0.25f.xx) + vertex_unnamed_54.ww;
				float2 vertex_unnamed_163 = 0.25f.xx / vertex_unnamed_38;
				vertex_output_2 = float4(vertex_output_2.x, vertex_output_2.y, vertex_unnamed_163.x, vertex_unnamed_163.y);
				vertex_unnamed_54 = vertex_input_1 * _Color;
				float3 vertex_unnamed_179 = vertex_unnamed_54.xyz * _DiffusePower.xxx;
				vertex_output_0 = float4(vertex_unnamed_179.x, vertex_unnamed_179.y, vertex_unnamed_179.z, vertex_output_0.w);
				vertex_output_0.w = vertex_unnamed_54.w;
				vertex_output_1 = vertex_input_2;
				vertex_unnamed_54 = max(_ClipRect, (-20000000000.0f).xxxx);
				vertex_unnamed_54 = min(vertex_unnamed_54, 20000000000.0f.xxxx);
				vertex_unnamed_9 = (vertex_unnamed_9 * 2.0f.xx) + (-vertex_unnamed_54.xy);
				float2 vertex_unnamed_213 = (-vertex_unnamed_54.zw) + vertex_unnamed_9;
				vertex_output_2 = float4(vertex_unnamed_213.x, vertex_unnamed_213.y, vertex_output_2.z, vertex_output_2.w);
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
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_0 = vertex_output_0;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}

			float4 _ClipRect;

			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

			static float4 fragment_input_2;
			static float2 fragment_input_1;
			static float4 fragment_input_0;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_0 : UNKNOWN0;
				float2 fragment_input_1 : TEXCOORD0; // vs_TEXCOORD0
				float4 fragment_input_2 : TEXCOORD2; // vs_TEXCOORD2
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static float2 fragment_unnamed_9;
			static float fragment_unnamed_53;
			static float4 fragment_unnamed_71;

			void frag_main()
			{
				fragment_unnamed_9 = (-_ClipRect.xy) + _ClipRect.zw;
				fragment_unnamed_9 += (-abs(fragment_input_2.xy));
				fragment_unnamed_9 *= fragment_input_2.zw;
				fragment_unnamed_9 = clamp(fragment_unnamed_9, 0.0f.xx, 1.0f.xx);
				fragment_unnamed_9.x = fragment_unnamed_9.y * fragment_unnamed_9.x;
				fragment_unnamed_53 = _MainTex.Sample(sampler_MainTex, fragment_input_1).w;
				fragment_unnamed_71.w = fragment_unnamed_53 * fragment_input_0.w;
				fragment_unnamed_71 = float4(fragment_input_0.xyz.x, fragment_input_0.xyz.y, fragment_input_0.xyz.z, fragment_unnamed_71.w);
				fragment_output_0 = fragment_unnamed_9.xxxx * fragment_unnamed_71;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_0 = stage_input.fragment_input_0;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // UNITY_UI_CLIP_RECT
			#endif // !UNITY_UI_ALPHACLIP


			#ifdef UNITY_UI_ALPHACLIP
			#ifdef UNITY_UI_CLIP_RECT
			#define ANY_SHADER_VARIANT_ACTIVE

			float4 _ScreenParams;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;
			float4 _Color;
			float _DiffusePower;
			float _VertexOffsetX;
			float _VertexOffsetY;
			float4 _ClipRect;
			float _MaskSoftnessX;
			float _MaskSoftnessY;

			static float4 unity_ObjectToWorld__array[4];
			static float4 unity_MatrixVP__array[4];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_output_2;
			static float4 vertex_input_1;
			static float4 vertex_output_0;
			static float2 vertex_output_1;
			static float2 vertex_input_2;

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
				float4 vertex_output_2 : TEXCOORD2; // vs_TEXCOORD2
				float4 gl_Position : SV_Position;
			};

			static float2 vertex_unnamed_9;
			static float2 vertex_unnamed_38;
			static float4 vertex_unnamed_54;
			static float4 vertex_unnamed_81;

			void vert_main()
			{
				vertex_unnamed_9.x = vertex_input_0.w * 0.5f;
				vertex_unnamed_9 = vertex_unnamed_9.xx / _ScreenParams.xy;
				vertex_unnamed_38 = vertex_input_0.xy + float2(_VertexOffsetX, _VertexOffsetY);
				vertex_unnamed_9 += vertex_unnamed_38;
				vertex_unnamed_54 = vertex_unnamed_9.yyyy * unity_ObjectToWorld__array[1];
				vertex_unnamed_54 = (unity_ObjectToWorld__array[0] * vertex_unnamed_9.xxxx) + vertex_unnamed_54;
				vertex_unnamed_54 = (unity_ObjectToWorld__array[2] * vertex_input_0.zzzz) + vertex_unnamed_54;
				vertex_unnamed_54 += unity_ObjectToWorld__array[3];
				vertex_unnamed_81 = vertex_unnamed_54.yyyy * unity_MatrixVP__array[1];
				vertex_unnamed_81 = (unity_MatrixVP__array[0] * vertex_unnamed_54.xxxx) + vertex_unnamed_81;
				vertex_unnamed_81 = (unity_MatrixVP__array[2] * vertex_unnamed_54.zzzz) + vertex_unnamed_81;
				vertex_unnamed_54 = (unity_MatrixVP__array[3] * vertex_unnamed_54.wwww) + vertex_unnamed_81;
				vertex_unnamed_38 = vertex_unnamed_54.xy / vertex_unnamed_54.ww;
				float2 vertex_unnamed_117 = _ScreenParams.xy * 0.5f.xx;
				vertex_unnamed_54 = float4(vertex_unnamed_117.x, vertex_unnamed_117.y, vertex_unnamed_54.z, vertex_unnamed_54.w);
				vertex_unnamed_38 *= vertex_unnamed_54.xy;
				vertex_unnamed_38 = round(vertex_unnamed_38);
				vertex_unnamed_38 /= vertex_unnamed_54.xy;
				float2 vertex_unnamed_138 = vertex_unnamed_54.ww * vertex_unnamed_38;
				gl_Position = float4(vertex_unnamed_138.x, vertex_unnamed_138.y, gl_Position.z, gl_Position.w);
				gl_Position = float4(gl_Position.x, gl_Position.y, vertex_unnamed_54.zw.x, vertex_unnamed_54.zw.y);
				vertex_unnamed_38 = (float2(_MaskSoftnessX, _MaskSoftnessY) * 0.25f.xx) + vertex_unnamed_54.ww;
				float2 vertex_unnamed_163 = 0.25f.xx / vertex_unnamed_38;
				vertex_output_2 = float4(vertex_output_2.x, vertex_output_2.y, vertex_unnamed_163.x, vertex_unnamed_163.y);
				vertex_unnamed_54 = vertex_input_1 * _Color;
				float3 vertex_unnamed_179 = vertex_unnamed_54.xyz * _DiffusePower.xxx;
				vertex_output_0 = float4(vertex_unnamed_179.x, vertex_unnamed_179.y, vertex_unnamed_179.z, vertex_output_0.w);
				vertex_output_0.w = vertex_unnamed_54.w;
				vertex_output_1 = vertex_input_2;
				vertex_unnamed_54 = max(_ClipRect, (-20000000000.0f).xxxx);
				vertex_unnamed_54 = min(vertex_unnamed_54, 20000000000.0f.xxxx);
				vertex_unnamed_9 = (vertex_unnamed_9 * 2.0f.xx) + (-vertex_unnamed_54.xy);
				float2 vertex_unnamed_213 = (-vertex_unnamed_54.zw) + vertex_unnamed_9;
				vertex_output_2 = float4(vertex_unnamed_213.x, vertex_unnamed_213.y, vertex_output_2.z, vertex_output_2.w);
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
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_0 = vertex_output_0;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}

			float4 _ClipRect;

			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

			static float4 fragment_input_2;
			static float2 fragment_input_1;
			static float4 fragment_input_0;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_0 : UNKNOWN0;
				float2 fragment_input_1 : TEXCOORD0; // vs_TEXCOORD0
				float4 fragment_input_2 : TEXCOORD2; // vs_TEXCOORD2
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static float4 fragment_unnamed_9;
			static float fragment_unnamed_64;
			static float4 fragment_unnamed_81;
			static bool fragment_unnamed_98;

			void frag_main()
			{
				float2 fragment_unnamed_24 = (-_ClipRect.xy) + _ClipRect.zw;
				fragment_unnamed_9 = float4(fragment_unnamed_24.x, fragment_unnamed_24.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
				float2 fragment_unnamed_35 = fragment_unnamed_9.xy + (-abs(fragment_input_2.xy));
				fragment_unnamed_9 = float4(fragment_unnamed_35.x, fragment_unnamed_35.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
				float2 fragment_unnamed_42 = fragment_unnamed_9.xy * fragment_input_2.zw;
				fragment_unnamed_9 = float4(fragment_unnamed_42.x, fragment_unnamed_42.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
				float2 fragment_unnamed_51 = clamp(fragment_unnamed_9.xy, 0.0f.xx, 1.0f.xx);
				fragment_unnamed_9 = float4(fragment_unnamed_51.x, fragment_unnamed_51.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
				fragment_unnamed_9.x = fragment_unnamed_9.y * fragment_unnamed_9.x;
				fragment_unnamed_64 = _MainTex.Sample(sampler_MainTex, fragment_input_1).w;
				fragment_unnamed_81.w = fragment_unnamed_64 * fragment_input_0.w;
				fragment_unnamed_64 = (fragment_unnamed_81.w * fragment_unnamed_9.x) + (-0.001000000047497451305389404296875f);
				fragment_unnamed_98 = fragment_unnamed_64 < 0.0f;
				if ((int(fragment_unnamed_98) * (-1)) != 0)
				{
					discard;
				}
				fragment_unnamed_81 = float4(fragment_input_0.xyz.x, fragment_input_0.xyz.y, fragment_input_0.xyz.z, fragment_unnamed_81.w);
				fragment_unnamed_9 = fragment_unnamed_9.xxxx * fragment_unnamed_81;
				fragment_output_0 = fragment_unnamed_9;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_0 = stage_input.fragment_input_0;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // UNITY_UI_ALPHACLIP
			#endif // UNITY_UI_CLIP_RECT


			#ifndef UNITY_UI_ALPHACLIP
			#ifndef UNITY_UI_CLIP_RECT
			#define ANY_SHADER_VARIANT_ACTIVE

			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

			static float4 fragment_input_1;
			static float2 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : COLOR; // COLOR
				float2 fragment_input_2 : TEXCOORD; // TEXCOORD
				float4 fragment_input_3 : TEXCOORD2; // TEXCOORD_2
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				precise float fragment_unnamed_41 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_2.x, fragment_input_2.y)).w * fragment_input_1.w;
				fragment_output_0.w = fragment_unnamed_41;
				fragment_output_0.x = fragment_input_1.x;
				fragment_output_0.y = fragment_input_1.y;
				fragment_output_0.z = fragment_input_1.z;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // !UNITY_UI_ALPHACLIP
			#endif // !UNITY_UI_CLIP_RECT


			#ifdef UNITY_UI_ALPHACLIP
			#ifndef UNITY_UI_CLIP_RECT
			#define ANY_SHADER_VARIANT_ACTIVE

			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

			static float4 fragment_input_1;
			static float2 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : COLOR; // COLOR
				float2 fragment_input_2 : TEXCOORD; // TEXCOORD
				float4 fragment_input_3 : TEXCOORD2; // TEXCOORD_2
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static bool discard_state;

			void discard_cond(bool fragment_unnamed_66)
			{
				if (fragment_unnamed_66)
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
				float4 fragment_unnamed_35 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_2.x, fragment_input_2.y));
				float fragment_unnamed_37 = fragment_unnamed_35.w;
				precise float fragment_unnamed_46 = fragment_unnamed_37 * fragment_input_1.w;
				fragment_output_0.w = fragment_unnamed_46;
				discard_cond(mad(fragment_input_1.w, fragment_unnamed_37, -0.001000000047497451305389404296875f) < 0.0f);
				fragment_output_0.x = fragment_input_1.x;
				fragment_output_0.y = fragment_input_1.y;
				fragment_output_0.z = fragment_input_1.z;
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // UNITY_UI_ALPHACLIP
			#endif // !UNITY_UI_CLIP_RECT


			#ifdef UNITY_UI_CLIP_RECT
			#ifndef UNITY_UI_ALPHACLIP
			#define ANY_SHADER_VARIANT_ACTIVE

			float4 _ClipRect;

			static float4 fragment_uniform_buffer_0[5];
			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

			static float4 fragment_input_1;
			static float2 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : COLOR; // COLOR
				float2 fragment_input_2 : TEXCOORD; // TEXCOORD
				float4 fragment_input_3 : TEXCOORD2; // TEXCOORD_2
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				precise float fragment_unnamed_36 = (-0.0f) - fragment_uniform_buffer_0[4u].x;
				precise float fragment_unnamed_39 = (-0.0f) - fragment_uniform_buffer_0[4u].y;
				precise float fragment_unnamed_44 = fragment_unnamed_36 + fragment_uniform_buffer_0[4u].z;
				precise float fragment_unnamed_45 = fragment_unnamed_39 + fragment_uniform_buffer_0[4u].w;
				precise float fragment_unnamed_51 = (-0.0f) - abs(fragment_input_3.x);
				precise float fragment_unnamed_56 = (-0.0f) - abs(fragment_input_3.y);
				precise float fragment_unnamed_57 = fragment_unnamed_44 + fragment_unnamed_51;
				precise float fragment_unnamed_58 = fragment_unnamed_45 + fragment_unnamed_56;
				precise float fragment_unnamed_65 = fragment_unnamed_57 * fragment_input_3.z;
				precise float fragment_unnamed_66 = fragment_unnamed_58 * fragment_input_3.w;
				precise float fragment_unnamed_71 = clamp(fragment_unnamed_66, 0.0f, 1.0f) * clamp(fragment_unnamed_65, 0.0f, 1.0f);
				precise float fragment_unnamed_83 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_2.x, fragment_input_2.y)).w * fragment_input_1.w;
				precise float fragment_unnamed_90 = fragment_unnamed_71 * fragment_input_1.x;
				precise float fragment_unnamed_91 = fragment_unnamed_71 * fragment_input_1.y;
				precise float fragment_unnamed_92 = fragment_unnamed_71 * fragment_input_1.z;
				precise float fragment_unnamed_93 = fragment_unnamed_71 * fragment_unnamed_83;
				fragment_output_0.x = fragment_unnamed_90;
				fragment_output_0.y = fragment_unnamed_91;
				fragment_output_0.z = fragment_unnamed_92;
				fragment_output_0.w = fragment_unnamed_93;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[4] = float4(_ClipRect[0], _ClipRect[1], _ClipRect[2], _ClipRect[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // UNITY_UI_CLIP_RECT
			#endif // !UNITY_UI_ALPHACLIP


			#ifdef UNITY_UI_ALPHACLIP
			#ifdef UNITY_UI_CLIP_RECT
			#define ANY_SHADER_VARIANT_ACTIVE

			float4 _ClipRect;

			static float4 fragment_uniform_buffer_0[5];
			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

			static float4 fragment_input_1;
			static float2 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : COLOR; // COLOR
				float2 fragment_input_2 : TEXCOORD; // TEXCOORD
				float4 fragment_input_3 : TEXCOORD2; // TEXCOORD_2
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static bool discard_state;

			void discard_cond(bool fragment_unnamed_108)
			{
				if (fragment_unnamed_108)
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
				precise float fragment_unnamed_36 = (-0.0f) - fragment_uniform_buffer_0[4u].x;
				precise float fragment_unnamed_39 = (-0.0f) - fragment_uniform_buffer_0[4u].y;
				precise float fragment_unnamed_44 = fragment_unnamed_36 + fragment_uniform_buffer_0[4u].z;
				precise float fragment_unnamed_45 = fragment_unnamed_39 + fragment_uniform_buffer_0[4u].w;
				precise float fragment_unnamed_51 = (-0.0f) - abs(fragment_input_3.x);
				precise float fragment_unnamed_56 = (-0.0f) - abs(fragment_input_3.y);
				precise float fragment_unnamed_57 = fragment_unnamed_44 + fragment_unnamed_51;
				precise float fragment_unnamed_58 = fragment_unnamed_45 + fragment_unnamed_56;
				precise float fragment_unnamed_65 = fragment_unnamed_57 * fragment_input_3.z;
				precise float fragment_unnamed_66 = fragment_unnamed_58 * fragment_input_3.w;
				precise float fragment_unnamed_71 = clamp(fragment_unnamed_66, 0.0f, 1.0f) * clamp(fragment_unnamed_65, 0.0f, 1.0f);
				precise float fragment_unnamed_83 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_2.x, fragment_input_2.y)).w * fragment_input_1.w;
				discard_cond(mad(fragment_unnamed_83, fragment_unnamed_71, -0.001000000047497451305389404296875f) < 0.0f);
				precise float fragment_unnamed_97 = fragment_unnamed_71 * fragment_input_1.x;
				precise float fragment_unnamed_98 = fragment_unnamed_71 * fragment_input_1.y;
				precise float fragment_unnamed_99 = fragment_unnamed_71 * fragment_input_1.z;
				precise float fragment_unnamed_100 = fragment_unnamed_71 * fragment_unnamed_83;
				fragment_output_0.x = fragment_unnamed_97;
				fragment_output_0.y = fragment_unnamed_98;
				fragment_output_0.z = fragment_unnamed_99;
				fragment_output_0.w = fragment_unnamed_100;
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[4] = float4(_ClipRect[0], _ClipRect[1], _ClipRect[2], _ClipRect[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // UNITY_UI_ALPHACLIP
			#endif // UNITY_UI_CLIP_RECT


			ENDHLSL
		}
	}
	SubShader
	{
		Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass
		{
			Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ZTest Always
			ZWrite Off
			Cull Off
			Fog
			{
				Mode Off
			}
			GpuProgramID 117148

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.0


			float4 _MainTex_ST;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[3];
			static float4 vertex_uniform_buffer_1[4];
			static float4 vertex_uniform_buffer_2[21];
			static float4 gl_Position;
			static float3 vertex_input_0;
			static float4 vertex_input_1;
			static float3 vertex_input_2;
			static float4 vertex_output_0;
			static float2 vertex_output_1;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
				float4 vertex_input_1 : COLOR; // COLOR
				float3 vertex_input_2 : TEXCOORD0; // TEXCOORD
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_0 : COLOR; // COLOR
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				vertex_output_0.x = clamp(vertex_input_1.x, 0.0f, 1.0f);
				vertex_output_0.y = clamp(vertex_input_1.y, 0.0f, 1.0f);
				vertex_output_0.z = clamp(vertex_input_1.z, 0.0f, 1.0f);
				vertex_output_0.w = clamp(vertex_input_1.w, 0.0f, 1.0f);
				vertex_output_1.x = mad(vertex_input_2.x, vertex_uniform_buffer_0[2u].x, vertex_uniform_buffer_0[2u].z);
				vertex_output_1.y = mad(vertex_input_2.y, vertex_uniform_buffer_0[2u].y, vertex_uniform_buffer_0[2u].w);
				precise float vertex_unnamed_84 = vertex_input_0.y * vertex_uniform_buffer_1[1u].x;
				precise float vertex_unnamed_85 = vertex_input_0.y * vertex_uniform_buffer_1[1u].y;
				precise float vertex_unnamed_86 = vertex_input_0.y * vertex_uniform_buffer_1[1u].z;
				precise float vertex_unnamed_87 = vertex_input_0.y * vertex_uniform_buffer_1[1u].w;
				precise float vertex_unnamed_118 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_0.x, vertex_unnamed_84)) + vertex_uniform_buffer_1[3u].x;
				precise float vertex_unnamed_119 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_0.x, vertex_unnamed_85)) + vertex_uniform_buffer_1[3u].y;
				precise float vertex_unnamed_120 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_0.x, vertex_unnamed_86)) + vertex_uniform_buffer_1[3u].z;
				precise float vertex_unnamed_121 = mad(vertex_uniform_buffer_1[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].w, vertex_input_0.x, vertex_unnamed_87)) + vertex_uniform_buffer_1[3u].w;
				precise float vertex_unnamed_129 = vertex_unnamed_119 * vertex_uniform_buffer_2[18u].x;
				precise float vertex_unnamed_130 = vertex_unnamed_119 * vertex_uniform_buffer_2[18u].y;
				precise float vertex_unnamed_131 = vertex_unnamed_119 * vertex_uniform_buffer_2[18u].z;
				precise float vertex_unnamed_132 = vertex_unnamed_119 * vertex_uniform_buffer_2[18u].w;
				gl_Position.x = mad(vertex_uniform_buffer_2[20u].x, vertex_unnamed_121, mad(vertex_uniform_buffer_2[19u].x, vertex_unnamed_120, mad(vertex_uniform_buffer_2[17u].x, vertex_unnamed_118, vertex_unnamed_129)));
				gl_Position.y = mad(vertex_uniform_buffer_2[20u].y, vertex_unnamed_121, mad(vertex_uniform_buffer_2[19u].y, vertex_unnamed_120, mad(vertex_uniform_buffer_2[17u].y, vertex_unnamed_118, vertex_unnamed_130)));
				gl_Position.z = mad(vertex_uniform_buffer_2[20u].z, vertex_unnamed_121, mad(vertex_uniform_buffer_2[19u].z, vertex_unnamed_120, mad(vertex_uniform_buffer_2[17u].z, vertex_unnamed_118, vertex_unnamed_131)));
				gl_Position.w = mad(vertex_uniform_buffer_2[20u].w, vertex_unnamed_121, mad(vertex_uniform_buffer_2[19u].w, vertex_unnamed_120, mad(vertex_uniform_buffer_2[17u].w, vertex_unnamed_118, vertex_unnamed_132)));
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[2] = float4(_MainTex_ST[0], _MainTex_ST[1], _MainTex_ST[2], _MainTex_ST[3]);

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
				vertex_input_2 = stage_input.vertex_input_2;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_0 = vertex_output_0;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}


			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;
			float4 _MainTex_ST;

			static float4 unity_ObjectToWorld__array[4];
			static float4 unity_MatrixVP__array[4];
			static float4 gl_Position;
			static float4 vertex_output_0;
			static float4 vertex_input_1;
			static float2 vertex_output_1;
			static float3 vertex_input_2;
			static float3 vertex_input_0;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION;
				float4 vertex_input_1 : COLOR;
				float3 vertex_input_2 : TEXCOORD0;
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_0 : UNKNOWN0;
				float2 vertex_output_1 : TEXCOORD0; // vs_TEXCOORD0
				float4 gl_Position : SV_Position;
			};

			static float4 vertex_unnamed_46;
			static float4 vertex_unnamed_74;

			void vert_main()
			{
				vertex_output_0 = vertex_input_1;
				vertex_output_0 = clamp(vertex_output_0, 0.0f.xxxx, 1.0f.xxxx);
				vertex_output_1 = (vertex_input_2.xy * _MainTex_ST.xy) + _MainTex_ST.zw;
				vertex_unnamed_46 = vertex_input_0.yyyy * unity_ObjectToWorld__array[1];
				vertex_unnamed_46 = (unity_ObjectToWorld__array[0] * vertex_input_0.xxxx) + vertex_unnamed_46;
				vertex_unnamed_46 = (unity_ObjectToWorld__array[2] * vertex_input_0.zzzz) + vertex_unnamed_46;
				vertex_unnamed_46 += unity_ObjectToWorld__array[3];
				vertex_unnamed_74 = vertex_unnamed_46.yyyy * unity_MatrixVP__array[1];
				vertex_unnamed_74 = (unity_MatrixVP__array[0] * vertex_unnamed_46.xxxx) + vertex_unnamed_74;
				vertex_unnamed_74 = (unity_MatrixVP__array[2] * vertex_unnamed_46.zzzz) + vertex_unnamed_74;
				gl_Position = (unity_MatrixVP__array[3] * vertex_unnamed_46.wwww) + vertex_unnamed_74;
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

				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_2 = stage_input.vertex_input_2;
				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_0 = vertex_output_0;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}

			float4 _Color;

			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

			static float2 fragment_input_1;
			static float4 fragment_output_0;
			static float4 fragment_input_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_0 : UNKNOWN0;
				float2 fragment_input_1 : TEXCOORD0; // vs_TEXCOORD0
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static float fragment_unnamed_8;

			void frag_main()
			{
				fragment_unnamed_8 = _MainTex.Sample(sampler_MainTex, fragment_input_1).w;
				fragment_output_0.w = fragment_unnamed_8 * _Color.w;
				float3 fragment_unnamed_51 = fragment_input_0.xyz * _Color.xyz;
				fragment_output_0 = float4(fragment_unnamed_51.x, fragment_unnamed_51.y, fragment_unnamed_51.z, fragment_output_0.w);
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


			float4 _Color;

			static float4 fragment_uniform_buffer_0[4];
			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

			static float4 fragment_input_0;
			static float2 fragment_input_1;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_0 : COLOR; // COLOR
				float2 fragment_input_1 : TEXCOORD; // TEXCOORD
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				precise float fragment_unnamed_47 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y)).w * fragment_uniform_buffer_0[3u].w;
				fragment_output_0.w = fragment_unnamed_47;
				precise float fragment_unnamed_62 = fragment_input_0.x * fragment_uniform_buffer_0[3u].x;
				precise float fragment_unnamed_63 = fragment_input_0.y * fragment_uniform_buffer_0[3u].y;
				precise float fragment_unnamed_64 = fragment_input_0.z * fragment_uniform_buffer_0[3u].z;
				fragment_output_0.x = fragment_unnamed_62;
				fragment_output_0.y = fragment_unnamed_63;
				fragment_output_0.z = fragment_unnamed_64;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[3] = float4(_Color[0], _Color[1], _Color[2], _Color[3]);

				fragment_input_0 = stage_input.fragment_input_0;
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			ENDHLSL
		}
	}
	CustomEditor "TMPro.EditorUtilities.TMP_BitmapShaderGUI"
}
