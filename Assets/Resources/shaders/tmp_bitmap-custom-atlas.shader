Shader "TextMeshPro/Bitmap Custom Atlas"
{
	Properties
	{
		_MainTex ("Font Atlas", 2D) = "white" {}
		_FaceTex ("Font Texture", 2D) = "white" {}
		_FaceColor ("Text Color", Color) = (1,1,1,1)
		_VertexOffsetX ("Vertex OffsetX", Float) = 0
		_VertexOffsetY ("Vertex OffsetY", Float) = 0
		_MaskSoftnessX ("Mask SoftnessX", Float) = 0
		_MaskSoftnessY ("Mask SoftnessY", Float) = 0
		_ClipRect ("Clip Rect", Vector) = (-32767,-32767,32767,32767)
		_Padding ("Padding", Float) = 0
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
			GpuProgramID 32766

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

			float4 _FaceTex_ST;
			float4 _FaceColor;
			float _VertexOffsetX;
			float _VertexOffsetY;
			float4 _ClipRect;
			float _MaskSoftnessX;
			float _MaskSoftnessY;
			float4 _ScreenParams;
			float4x4 unity_ObjectToWorld;
			float4x4 glstate_matrix_projection;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[7];
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
			static float2 vertex_output_2;
			static float4 vertex_output_3;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION; // POSITION
				float4 vertex_input_1 : COLOR; // COLOR
				float2 vertex_input_2 : TEXCOORD0; // TEXCOORD
				float2 vertex_input_3 : TEXCOORD1; // TEXCOORD_1
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : COLOR; // COLOR
				float2 vertex_output_2 : TEXCOORD; // TEXCOORD
				float2 vertex_output_2 : TEXCOORD1; // TEXCOORD_1
				float4 vertex_output_3 : TEXCOORD2; // TEXCOORD_2
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_45 = vertex_input_0.w * 0.5f;
				precise float vertex_unnamed_54 = vertex_unnamed_45 / vertex_uniform_buffer_1[6u].x;
				precise float vertex_unnamed_55 = vertex_unnamed_45 / vertex_uniform_buffer_1[6u].y;
				precise float vertex_unnamed_65 = vertex_input_0.x + vertex_uniform_buffer_0[4u].x;
				precise float vertex_unnamed_66 = vertex_input_0.y + vertex_uniform_buffer_0[4u].y;
				precise float vertex_unnamed_67 = vertex_unnamed_54 + vertex_unnamed_65;
				precise float vertex_unnamed_68 = vertex_unnamed_55 + vertex_unnamed_66;
				precise float vertex_unnamed_75 = vertex_unnamed_68 * vertex_uniform_buffer_2[1u].x;
				precise float vertex_unnamed_76 = vertex_unnamed_68 * vertex_uniform_buffer_2[1u].y;
				precise float vertex_unnamed_77 = vertex_unnamed_68 * vertex_uniform_buffer_2[1u].z;
				precise float vertex_unnamed_78 = vertex_unnamed_68 * vertex_uniform_buffer_2[1u].w;
				precise float vertex_unnamed_109 = mad(vertex_uniform_buffer_2[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].x, vertex_unnamed_67, vertex_unnamed_75)) + vertex_uniform_buffer_2[3u].x;
				precise float vertex_unnamed_110 = mad(vertex_uniform_buffer_2[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].y, vertex_unnamed_67, vertex_unnamed_76)) + vertex_uniform_buffer_2[3u].y;
				precise float vertex_unnamed_111 = mad(vertex_uniform_buffer_2[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].z, vertex_unnamed_67, vertex_unnamed_77)) + vertex_uniform_buffer_2[3u].z;
				precise float vertex_unnamed_112 = mad(vertex_uniform_buffer_2[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].w, vertex_unnamed_67, vertex_unnamed_78)) + vertex_uniform_buffer_2[3u].w;
				precise float vertex_unnamed_120 = vertex_unnamed_110 * vertex_uniform_buffer_3[18u].x;
				precise float vertex_unnamed_121 = vertex_unnamed_110 * vertex_uniform_buffer_3[18u].y;
				precise float vertex_unnamed_122 = vertex_unnamed_110 * vertex_uniform_buffer_3[18u].z;
				precise float vertex_unnamed_123 = vertex_unnamed_110 * vertex_uniform_buffer_3[18u].w;
				float vertex_unnamed_156 = mad(vertex_uniform_buffer_3[20u].w, vertex_unnamed_112, mad(vertex_uniform_buffer_3[19u].w, vertex_unnamed_111, mad(vertex_uniform_buffer_3[17u].w, vertex_unnamed_109, vertex_unnamed_123)));
				precise float vertex_unnamed_157 = mad(vertex_uniform_buffer_3[20u].x, vertex_unnamed_112, mad(vertex_uniform_buffer_3[19u].x, vertex_unnamed_111, mad(vertex_uniform_buffer_3[17u].x, vertex_unnamed_109, vertex_unnamed_120))) / vertex_unnamed_156;
				precise float vertex_unnamed_158 = mad(vertex_uniform_buffer_3[20u].y, vertex_unnamed_112, mad(vertex_uniform_buffer_3[19u].y, vertex_unnamed_111, mad(vertex_uniform_buffer_3[17u].y, vertex_unnamed_109, vertex_unnamed_121))) / vertex_unnamed_156;
				precise float vertex_unnamed_163 = vertex_uniform_buffer_1[6u].x * 0.5f;
				precise float vertex_unnamed_164 = vertex_uniform_buffer_1[6u].y * 0.5f;
				precise float vertex_unnamed_165 = vertex_unnamed_157 * vertex_unnamed_163;
				precise float vertex_unnamed_166 = vertex_unnamed_158 * vertex_unnamed_164;
				precise float vertex_unnamed_169 = round(vertex_unnamed_165) / vertex_unnamed_163;
				precise float vertex_unnamed_170 = round(vertex_unnamed_166) / vertex_unnamed_164;
				precise float vertex_unnamed_171 = vertex_unnamed_156 * vertex_unnamed_169;
				precise float vertex_unnamed_172 = vertex_unnamed_156 * vertex_unnamed_170;
				gl_Position.x = vertex_unnamed_171;
				gl_Position.y = vertex_unnamed_172;
				gl_Position.z = mad(vertex_uniform_buffer_3[20u].z, vertex_unnamed_112, mad(vertex_uniform_buffer_3[19u].z, vertex_unnamed_111, mad(vertex_uniform_buffer_3[17u].z, vertex_unnamed_109, vertex_unnamed_122)));
				gl_Position.w = vertex_unnamed_156;
				precise float vertex_unnamed_192 = vertex_input_1.x * vertex_uniform_buffer_0[3u].x;
				precise float vertex_unnamed_193 = vertex_input_1.y * vertex_uniform_buffer_0[3u].y;
				precise float vertex_unnamed_194 = vertex_input_1.z * vertex_uniform_buffer_0[3u].z;
				precise float vertex_unnamed_195 = vertex_input_1.w * vertex_uniform_buffer_0[3u].w;
				vertex_output_1.x = vertex_unnamed_192;
				vertex_output_1.y = vertex_unnamed_193;
				vertex_output_1.z = vertex_unnamed_194;
				vertex_output_1.w = vertex_unnamed_195;
				precise float vertex_unnamed_202 = vertex_input_3.x * 0.000244140625f;
				float vertex_unnamed_204 = floor(vertex_unnamed_202);
				precise float vertex_unnamed_205 = (-0.0f) - vertex_unnamed_204;
				precise float vertex_unnamed_215 = vertex_unnamed_204 * vertex_uniform_buffer_0[2u].x;
				precise float vertex_unnamed_216 = mad(vertex_unnamed_205, 4096.0f, vertex_input_3.x) * vertex_uniform_buffer_0[2u].y;
				vertex_output_2.x = mad(vertex_unnamed_215, 0.001953125f, vertex_uniform_buffer_0[2u].z);
				vertex_output_2.y = mad(vertex_unnamed_216, 0.001953125f, vertex_uniform_buffer_0[2u].w);
				vertex_output_2.x = vertex_input_2.x;
				vertex_output_2.y = vertex_input_2.y;
				precise float vertex_unnamed_249 = (-0.0f) - min(max(vertex_uniform_buffer_0[5u].x, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_250 = (-0.0f) - min(max(vertex_uniform_buffer_0[5u].y, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_254 = (-0.0f) - min(max(vertex_uniform_buffer_0[5u].z, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_255 = (-0.0f) - min(max(vertex_uniform_buffer_0[5u].w, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_256 = vertex_unnamed_254 + mad(vertex_unnamed_67, 2.0f, vertex_unnamed_249);
				precise float vertex_unnamed_257 = vertex_unnamed_255 + mad(vertex_unnamed_68, 2.0f, vertex_unnamed_250);
				vertex_output_3.x = vertex_unnamed_256;
				vertex_output_3.y = vertex_unnamed_257;
				precise float vertex_unnamed_266 = vertex_uniform_buffer_1[6u].x * vertex_uniform_buffer_3[5u].x;
				precise float vertex_unnamed_273 = vertex_uniform_buffer_1[6u].y * vertex_uniform_buffer_3[6u].y;
				precise float vertex_unnamed_276 = vertex_unnamed_156 / abs(vertex_unnamed_266);
				precise float vertex_unnamed_277 = vertex_unnamed_156 / abs(vertex_unnamed_273);
				precise float vertex_unnamed_285 = 0.25f / mad(vertex_uniform_buffer_0[6u].x, 0.25f, vertex_unnamed_276);
				precise float vertex_unnamed_286 = 0.25f / mad(vertex_uniform_buffer_0[6u].y, 0.25f, vertex_unnamed_277);
				vertex_output_3.z = vertex_unnamed_285;
				vertex_output_3.w = vertex_unnamed_286;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[2] = float4(_FaceTex_ST[0], _FaceTex_ST[1], _FaceTex_ST[2], _FaceTex_ST[3]);

				vertex_uniform_buffer_0[3] = float4(_FaceColor[0], _FaceColor[1], _FaceColor[2], _FaceColor[3]);

				vertex_uniform_buffer_0[4] = float4(_VertexOffsetX, vertex_uniform_buffer_0[4][1], vertex_uniform_buffer_0[4][2], vertex_uniform_buffer_0[4][3]);

				vertex_uniform_buffer_0[4] = float4(vertex_uniform_buffer_0[4][0], _VertexOffsetY, vertex_uniform_buffer_0[4][2], vertex_uniform_buffer_0[4][3]);

				vertex_uniform_buffer_0[5] = float4(_ClipRect[0], _ClipRect[1], _ClipRect[2], _ClipRect[3]);

				vertex_uniform_buffer_0[6] = float4(_MaskSoftnessX, vertex_uniform_buffer_0[6][1], vertex_uniform_buffer_0[6][2], vertex_uniform_buffer_0[6][3]);

				vertex_uniform_buffer_0[6] = float4(vertex_uniform_buffer_0[6][0], _MaskSoftnessY, vertex_uniform_buffer_0[6][2], vertex_uniform_buffer_0[6][3]);

				vertex_uniform_buffer_1[6] = float4(_ScreenParams[0], _ScreenParams[1], _ScreenParams[2], _ScreenParams[3]);

				vertex_uniform_buffer_2[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_2[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_2[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_2[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_3[5] = float4(glstate_matrix_projection[0][0], glstate_matrix_projection[1][0], glstate_matrix_projection[2][0], glstate_matrix_projection[3][0]);
				vertex_uniform_buffer_3[6] = float4(glstate_matrix_projection[0][1], glstate_matrix_projection[1][1], glstate_matrix_projection[2][1], glstate_matrix_projection[3][1]);
				vertex_uniform_buffer_3[7] = float4(glstate_matrix_projection[0][2], glstate_matrix_projection[1][2], glstate_matrix_projection[2][2], glstate_matrix_projection[3][2]);
				vertex_uniform_buffer_3[8] = float4(glstate_matrix_projection[0][3], glstate_matrix_projection[1][3], glstate_matrix_projection[2][3], glstate_matrix_projection[3][3]);

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
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				return stage_output;
			}

			#endif // !UNITY_UI_ALPHACLIP
			#endif // !UNITY_UI_CLIP_RECT


			#ifdef UNITY_UI_ALPHACLIP
			#ifndef UNITY_UI_CLIP_RECT
			#define ANY_SHADER_VARIANT_ACTIVE

			float4 _FaceTex_ST;
			float4 _FaceColor;
			float _VertexOffsetX;
			float _VertexOffsetY;
			float4 _ClipRect;
			float _MaskSoftnessX;
			float _MaskSoftnessY;
			float4 _ScreenParams;
			float4x4 unity_ObjectToWorld;
			float4x4 glstate_matrix_projection;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[7];
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
			static float2 vertex_output_2;
			static float4 vertex_output_3;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION; // POSITION
				float4 vertex_input_1 : COLOR; // COLOR
				float2 vertex_input_2 : TEXCOORD0; // TEXCOORD
				float2 vertex_input_3 : TEXCOORD1; // TEXCOORD_1
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : COLOR; // COLOR
				float2 vertex_output_2 : TEXCOORD; // TEXCOORD
				float2 vertex_output_2 : TEXCOORD1; // TEXCOORD_1
				float4 vertex_output_3 : TEXCOORD2; // TEXCOORD_2
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_45 = vertex_input_0.w * 0.5f;
				precise float vertex_unnamed_54 = vertex_unnamed_45 / vertex_uniform_buffer_1[6u].x;
				precise float vertex_unnamed_55 = vertex_unnamed_45 / vertex_uniform_buffer_1[6u].y;
				precise float vertex_unnamed_65 = vertex_input_0.x + vertex_uniform_buffer_0[4u].x;
				precise float vertex_unnamed_66 = vertex_input_0.y + vertex_uniform_buffer_0[4u].y;
				precise float vertex_unnamed_67 = vertex_unnamed_54 + vertex_unnamed_65;
				precise float vertex_unnamed_68 = vertex_unnamed_55 + vertex_unnamed_66;
				precise float vertex_unnamed_75 = vertex_unnamed_68 * vertex_uniform_buffer_2[1u].x;
				precise float vertex_unnamed_76 = vertex_unnamed_68 * vertex_uniform_buffer_2[1u].y;
				precise float vertex_unnamed_77 = vertex_unnamed_68 * vertex_uniform_buffer_2[1u].z;
				precise float vertex_unnamed_78 = vertex_unnamed_68 * vertex_uniform_buffer_2[1u].w;
				precise float vertex_unnamed_109 = mad(vertex_uniform_buffer_2[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].x, vertex_unnamed_67, vertex_unnamed_75)) + vertex_uniform_buffer_2[3u].x;
				precise float vertex_unnamed_110 = mad(vertex_uniform_buffer_2[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].y, vertex_unnamed_67, vertex_unnamed_76)) + vertex_uniform_buffer_2[3u].y;
				precise float vertex_unnamed_111 = mad(vertex_uniform_buffer_2[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].z, vertex_unnamed_67, vertex_unnamed_77)) + vertex_uniform_buffer_2[3u].z;
				precise float vertex_unnamed_112 = mad(vertex_uniform_buffer_2[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].w, vertex_unnamed_67, vertex_unnamed_78)) + vertex_uniform_buffer_2[3u].w;
				precise float vertex_unnamed_120 = vertex_unnamed_110 * vertex_uniform_buffer_3[18u].x;
				precise float vertex_unnamed_121 = vertex_unnamed_110 * vertex_uniform_buffer_3[18u].y;
				precise float vertex_unnamed_122 = vertex_unnamed_110 * vertex_uniform_buffer_3[18u].z;
				precise float vertex_unnamed_123 = vertex_unnamed_110 * vertex_uniform_buffer_3[18u].w;
				float vertex_unnamed_156 = mad(vertex_uniform_buffer_3[20u].w, vertex_unnamed_112, mad(vertex_uniform_buffer_3[19u].w, vertex_unnamed_111, mad(vertex_uniform_buffer_3[17u].w, vertex_unnamed_109, vertex_unnamed_123)));
				precise float vertex_unnamed_157 = mad(vertex_uniform_buffer_3[20u].x, vertex_unnamed_112, mad(vertex_uniform_buffer_3[19u].x, vertex_unnamed_111, mad(vertex_uniform_buffer_3[17u].x, vertex_unnamed_109, vertex_unnamed_120))) / vertex_unnamed_156;
				precise float vertex_unnamed_158 = mad(vertex_uniform_buffer_3[20u].y, vertex_unnamed_112, mad(vertex_uniform_buffer_3[19u].y, vertex_unnamed_111, mad(vertex_uniform_buffer_3[17u].y, vertex_unnamed_109, vertex_unnamed_121))) / vertex_unnamed_156;
				precise float vertex_unnamed_163 = vertex_uniform_buffer_1[6u].x * 0.5f;
				precise float vertex_unnamed_164 = vertex_uniform_buffer_1[6u].y * 0.5f;
				precise float vertex_unnamed_165 = vertex_unnamed_157 * vertex_unnamed_163;
				precise float vertex_unnamed_166 = vertex_unnamed_158 * vertex_unnamed_164;
				precise float vertex_unnamed_169 = round(vertex_unnamed_165) / vertex_unnamed_163;
				precise float vertex_unnamed_170 = round(vertex_unnamed_166) / vertex_unnamed_164;
				precise float vertex_unnamed_171 = vertex_unnamed_156 * vertex_unnamed_169;
				precise float vertex_unnamed_172 = vertex_unnamed_156 * vertex_unnamed_170;
				gl_Position.x = vertex_unnamed_171;
				gl_Position.y = vertex_unnamed_172;
				gl_Position.z = mad(vertex_uniform_buffer_3[20u].z, vertex_unnamed_112, mad(vertex_uniform_buffer_3[19u].z, vertex_unnamed_111, mad(vertex_uniform_buffer_3[17u].z, vertex_unnamed_109, vertex_unnamed_122)));
				gl_Position.w = vertex_unnamed_156;
				precise float vertex_unnamed_192 = vertex_input_1.x * vertex_uniform_buffer_0[3u].x;
				precise float vertex_unnamed_193 = vertex_input_1.y * vertex_uniform_buffer_0[3u].y;
				precise float vertex_unnamed_194 = vertex_input_1.z * vertex_uniform_buffer_0[3u].z;
				precise float vertex_unnamed_195 = vertex_input_1.w * vertex_uniform_buffer_0[3u].w;
				vertex_output_1.x = vertex_unnamed_192;
				vertex_output_1.y = vertex_unnamed_193;
				vertex_output_1.z = vertex_unnamed_194;
				vertex_output_1.w = vertex_unnamed_195;
				precise float vertex_unnamed_202 = vertex_input_3.x * 0.000244140625f;
				float vertex_unnamed_204 = floor(vertex_unnamed_202);
				precise float vertex_unnamed_205 = (-0.0f) - vertex_unnamed_204;
				precise float vertex_unnamed_215 = vertex_unnamed_204 * vertex_uniform_buffer_0[2u].x;
				precise float vertex_unnamed_216 = mad(vertex_unnamed_205, 4096.0f, vertex_input_3.x) * vertex_uniform_buffer_0[2u].y;
				vertex_output_2.x = mad(vertex_unnamed_215, 0.001953125f, vertex_uniform_buffer_0[2u].z);
				vertex_output_2.y = mad(vertex_unnamed_216, 0.001953125f, vertex_uniform_buffer_0[2u].w);
				vertex_output_2.x = vertex_input_2.x;
				vertex_output_2.y = vertex_input_2.y;
				precise float vertex_unnamed_249 = (-0.0f) - min(max(vertex_uniform_buffer_0[5u].x, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_250 = (-0.0f) - min(max(vertex_uniform_buffer_0[5u].y, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_254 = (-0.0f) - min(max(vertex_uniform_buffer_0[5u].z, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_255 = (-0.0f) - min(max(vertex_uniform_buffer_0[5u].w, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_256 = vertex_unnamed_254 + mad(vertex_unnamed_67, 2.0f, vertex_unnamed_249);
				precise float vertex_unnamed_257 = vertex_unnamed_255 + mad(vertex_unnamed_68, 2.0f, vertex_unnamed_250);
				vertex_output_3.x = vertex_unnamed_256;
				vertex_output_3.y = vertex_unnamed_257;
				precise float vertex_unnamed_266 = vertex_uniform_buffer_1[6u].x * vertex_uniform_buffer_3[5u].x;
				precise float vertex_unnamed_273 = vertex_uniform_buffer_1[6u].y * vertex_uniform_buffer_3[6u].y;
				precise float vertex_unnamed_276 = vertex_unnamed_156 / abs(vertex_unnamed_266);
				precise float vertex_unnamed_277 = vertex_unnamed_156 / abs(vertex_unnamed_273);
				precise float vertex_unnamed_285 = 0.25f / mad(vertex_uniform_buffer_0[6u].x, 0.25f, vertex_unnamed_276);
				precise float vertex_unnamed_286 = 0.25f / mad(vertex_uniform_buffer_0[6u].y, 0.25f, vertex_unnamed_277);
				vertex_output_3.z = vertex_unnamed_285;
				vertex_output_3.w = vertex_unnamed_286;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[2] = float4(_FaceTex_ST[0], _FaceTex_ST[1], _FaceTex_ST[2], _FaceTex_ST[3]);

				vertex_uniform_buffer_0[3] = float4(_FaceColor[0], _FaceColor[1], _FaceColor[2], _FaceColor[3]);

				vertex_uniform_buffer_0[4] = float4(_VertexOffsetX, vertex_uniform_buffer_0[4][1], vertex_uniform_buffer_0[4][2], vertex_uniform_buffer_0[4][3]);

				vertex_uniform_buffer_0[4] = float4(vertex_uniform_buffer_0[4][0], _VertexOffsetY, vertex_uniform_buffer_0[4][2], vertex_uniform_buffer_0[4][3]);

				vertex_uniform_buffer_0[5] = float4(_ClipRect[0], _ClipRect[1], _ClipRect[2], _ClipRect[3]);

				vertex_uniform_buffer_0[6] = float4(_MaskSoftnessX, vertex_uniform_buffer_0[6][1], vertex_uniform_buffer_0[6][2], vertex_uniform_buffer_0[6][3]);

				vertex_uniform_buffer_0[6] = float4(vertex_uniform_buffer_0[6][0], _MaskSoftnessY, vertex_uniform_buffer_0[6][2], vertex_uniform_buffer_0[6][3]);

				vertex_uniform_buffer_1[6] = float4(_ScreenParams[0], _ScreenParams[1], _ScreenParams[2], _ScreenParams[3]);

				vertex_uniform_buffer_2[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_2[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_2[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_2[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_3[5] = float4(glstate_matrix_projection[0][0], glstate_matrix_projection[1][0], glstate_matrix_projection[2][0], glstate_matrix_projection[3][0]);
				vertex_uniform_buffer_3[6] = float4(glstate_matrix_projection[0][1], glstate_matrix_projection[1][1], glstate_matrix_projection[2][1], glstate_matrix_projection[3][1]);
				vertex_uniform_buffer_3[7] = float4(glstate_matrix_projection[0][2], glstate_matrix_projection[1][2], glstate_matrix_projection[2][2], glstate_matrix_projection[3][2]);
				vertex_uniform_buffer_3[8] = float4(glstate_matrix_projection[0][3], glstate_matrix_projection[1][3], glstate_matrix_projection[2][3], glstate_matrix_projection[3][3]);

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
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				return stage_output;
			}

			#endif // UNITY_UI_ALPHACLIP
			#endif // !UNITY_UI_CLIP_RECT


			#ifdef UNITY_UI_CLIP_RECT
			#ifndef UNITY_UI_ALPHACLIP
			#define ANY_SHADER_VARIANT_ACTIVE

			float4 _FaceTex_ST;
			float4 _FaceColor;
			float _VertexOffsetX;
			float _VertexOffsetY;
			float4 _ClipRect;
			float _MaskSoftnessX;
			float _MaskSoftnessY;
			float4 _ScreenParams;
			float4x4 unity_ObjectToWorld;
			float4x4 glstate_matrix_projection;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[7];
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
			static float2 vertex_output_2;
			static float4 vertex_output_3;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION; // POSITION
				float4 vertex_input_1 : COLOR; // COLOR
				float2 vertex_input_2 : TEXCOORD0; // TEXCOORD
				float2 vertex_input_3 : TEXCOORD1; // TEXCOORD_1
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : COLOR; // COLOR
				float2 vertex_output_2 : TEXCOORD; // TEXCOORD
				float2 vertex_output_2 : TEXCOORD1; // TEXCOORD_1
				float4 vertex_output_3 : TEXCOORD2; // TEXCOORD_2
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_45 = vertex_input_0.w * 0.5f;
				precise float vertex_unnamed_54 = vertex_unnamed_45 / vertex_uniform_buffer_1[6u].x;
				precise float vertex_unnamed_55 = vertex_unnamed_45 / vertex_uniform_buffer_1[6u].y;
				precise float vertex_unnamed_65 = vertex_input_0.x + vertex_uniform_buffer_0[4u].x;
				precise float vertex_unnamed_66 = vertex_input_0.y + vertex_uniform_buffer_0[4u].y;
				precise float vertex_unnamed_67 = vertex_unnamed_54 + vertex_unnamed_65;
				precise float vertex_unnamed_68 = vertex_unnamed_55 + vertex_unnamed_66;
				precise float vertex_unnamed_75 = vertex_unnamed_68 * vertex_uniform_buffer_2[1u].x;
				precise float vertex_unnamed_76 = vertex_unnamed_68 * vertex_uniform_buffer_2[1u].y;
				precise float vertex_unnamed_77 = vertex_unnamed_68 * vertex_uniform_buffer_2[1u].z;
				precise float vertex_unnamed_78 = vertex_unnamed_68 * vertex_uniform_buffer_2[1u].w;
				precise float vertex_unnamed_109 = mad(vertex_uniform_buffer_2[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].x, vertex_unnamed_67, vertex_unnamed_75)) + vertex_uniform_buffer_2[3u].x;
				precise float vertex_unnamed_110 = mad(vertex_uniform_buffer_2[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].y, vertex_unnamed_67, vertex_unnamed_76)) + vertex_uniform_buffer_2[3u].y;
				precise float vertex_unnamed_111 = mad(vertex_uniform_buffer_2[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].z, vertex_unnamed_67, vertex_unnamed_77)) + vertex_uniform_buffer_2[3u].z;
				precise float vertex_unnamed_112 = mad(vertex_uniform_buffer_2[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].w, vertex_unnamed_67, vertex_unnamed_78)) + vertex_uniform_buffer_2[3u].w;
				precise float vertex_unnamed_120 = vertex_unnamed_110 * vertex_uniform_buffer_3[18u].x;
				precise float vertex_unnamed_121 = vertex_unnamed_110 * vertex_uniform_buffer_3[18u].y;
				precise float vertex_unnamed_122 = vertex_unnamed_110 * vertex_uniform_buffer_3[18u].z;
				precise float vertex_unnamed_123 = vertex_unnamed_110 * vertex_uniform_buffer_3[18u].w;
				float vertex_unnamed_156 = mad(vertex_uniform_buffer_3[20u].w, vertex_unnamed_112, mad(vertex_uniform_buffer_3[19u].w, vertex_unnamed_111, mad(vertex_uniform_buffer_3[17u].w, vertex_unnamed_109, vertex_unnamed_123)));
				precise float vertex_unnamed_157 = mad(vertex_uniform_buffer_3[20u].x, vertex_unnamed_112, mad(vertex_uniform_buffer_3[19u].x, vertex_unnamed_111, mad(vertex_uniform_buffer_3[17u].x, vertex_unnamed_109, vertex_unnamed_120))) / vertex_unnamed_156;
				precise float vertex_unnamed_158 = mad(vertex_uniform_buffer_3[20u].y, vertex_unnamed_112, mad(vertex_uniform_buffer_3[19u].y, vertex_unnamed_111, mad(vertex_uniform_buffer_3[17u].y, vertex_unnamed_109, vertex_unnamed_121))) / vertex_unnamed_156;
				precise float vertex_unnamed_163 = vertex_uniform_buffer_1[6u].x * 0.5f;
				precise float vertex_unnamed_164 = vertex_uniform_buffer_1[6u].y * 0.5f;
				precise float vertex_unnamed_165 = vertex_unnamed_157 * vertex_unnamed_163;
				precise float vertex_unnamed_166 = vertex_unnamed_158 * vertex_unnamed_164;
				precise float vertex_unnamed_169 = round(vertex_unnamed_165) / vertex_unnamed_163;
				precise float vertex_unnamed_170 = round(vertex_unnamed_166) / vertex_unnamed_164;
				precise float vertex_unnamed_171 = vertex_unnamed_156 * vertex_unnamed_169;
				precise float vertex_unnamed_172 = vertex_unnamed_156 * vertex_unnamed_170;
				gl_Position.x = vertex_unnamed_171;
				gl_Position.y = vertex_unnamed_172;
				gl_Position.z = mad(vertex_uniform_buffer_3[20u].z, vertex_unnamed_112, mad(vertex_uniform_buffer_3[19u].z, vertex_unnamed_111, mad(vertex_uniform_buffer_3[17u].z, vertex_unnamed_109, vertex_unnamed_122)));
				gl_Position.w = vertex_unnamed_156;
				precise float vertex_unnamed_192 = vertex_input_1.x * vertex_uniform_buffer_0[3u].x;
				precise float vertex_unnamed_193 = vertex_input_1.y * vertex_uniform_buffer_0[3u].y;
				precise float vertex_unnamed_194 = vertex_input_1.z * vertex_uniform_buffer_0[3u].z;
				precise float vertex_unnamed_195 = vertex_input_1.w * vertex_uniform_buffer_0[3u].w;
				vertex_output_1.x = vertex_unnamed_192;
				vertex_output_1.y = vertex_unnamed_193;
				vertex_output_1.z = vertex_unnamed_194;
				vertex_output_1.w = vertex_unnamed_195;
				precise float vertex_unnamed_202 = vertex_input_3.x * 0.000244140625f;
				float vertex_unnamed_204 = floor(vertex_unnamed_202);
				precise float vertex_unnamed_205 = (-0.0f) - vertex_unnamed_204;
				precise float vertex_unnamed_215 = vertex_unnamed_204 * vertex_uniform_buffer_0[2u].x;
				precise float vertex_unnamed_216 = mad(vertex_unnamed_205, 4096.0f, vertex_input_3.x) * vertex_uniform_buffer_0[2u].y;
				vertex_output_2.x = mad(vertex_unnamed_215, 0.001953125f, vertex_uniform_buffer_0[2u].z);
				vertex_output_2.y = mad(vertex_unnamed_216, 0.001953125f, vertex_uniform_buffer_0[2u].w);
				vertex_output_2.x = vertex_input_2.x;
				vertex_output_2.y = vertex_input_2.y;
				precise float vertex_unnamed_249 = (-0.0f) - min(max(vertex_uniform_buffer_0[5u].x, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_250 = (-0.0f) - min(max(vertex_uniform_buffer_0[5u].y, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_254 = (-0.0f) - min(max(vertex_uniform_buffer_0[5u].z, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_255 = (-0.0f) - min(max(vertex_uniform_buffer_0[5u].w, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_256 = vertex_unnamed_254 + mad(vertex_unnamed_67, 2.0f, vertex_unnamed_249);
				precise float vertex_unnamed_257 = vertex_unnamed_255 + mad(vertex_unnamed_68, 2.0f, vertex_unnamed_250);
				vertex_output_3.x = vertex_unnamed_256;
				vertex_output_3.y = vertex_unnamed_257;
				precise float vertex_unnamed_266 = vertex_uniform_buffer_1[6u].x * vertex_uniform_buffer_3[5u].x;
				precise float vertex_unnamed_273 = vertex_uniform_buffer_1[6u].y * vertex_uniform_buffer_3[6u].y;
				precise float vertex_unnamed_276 = vertex_unnamed_156 / abs(vertex_unnamed_266);
				precise float vertex_unnamed_277 = vertex_unnamed_156 / abs(vertex_unnamed_273);
				precise float vertex_unnamed_285 = 0.25f / mad(vertex_uniform_buffer_0[6u].x, 0.25f, vertex_unnamed_276);
				precise float vertex_unnamed_286 = 0.25f / mad(vertex_uniform_buffer_0[6u].y, 0.25f, vertex_unnamed_277);
				vertex_output_3.z = vertex_unnamed_285;
				vertex_output_3.w = vertex_unnamed_286;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[2] = float4(_FaceTex_ST[0], _FaceTex_ST[1], _FaceTex_ST[2], _FaceTex_ST[3]);

				vertex_uniform_buffer_0[3] = float4(_FaceColor[0], _FaceColor[1], _FaceColor[2], _FaceColor[3]);

				vertex_uniform_buffer_0[4] = float4(_VertexOffsetX, vertex_uniform_buffer_0[4][1], vertex_uniform_buffer_0[4][2], vertex_uniform_buffer_0[4][3]);

				vertex_uniform_buffer_0[4] = float4(vertex_uniform_buffer_0[4][0], _VertexOffsetY, vertex_uniform_buffer_0[4][2], vertex_uniform_buffer_0[4][3]);

				vertex_uniform_buffer_0[5] = float4(_ClipRect[0], _ClipRect[1], _ClipRect[2], _ClipRect[3]);

				vertex_uniform_buffer_0[6] = float4(_MaskSoftnessX, vertex_uniform_buffer_0[6][1], vertex_uniform_buffer_0[6][2], vertex_uniform_buffer_0[6][3]);

				vertex_uniform_buffer_0[6] = float4(vertex_uniform_buffer_0[6][0], _MaskSoftnessY, vertex_uniform_buffer_0[6][2], vertex_uniform_buffer_0[6][3]);

				vertex_uniform_buffer_1[6] = float4(_ScreenParams[0], _ScreenParams[1], _ScreenParams[2], _ScreenParams[3]);

				vertex_uniform_buffer_2[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_2[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_2[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_2[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_3[5] = float4(glstate_matrix_projection[0][0], glstate_matrix_projection[1][0], glstate_matrix_projection[2][0], glstate_matrix_projection[3][0]);
				vertex_uniform_buffer_3[6] = float4(glstate_matrix_projection[0][1], glstate_matrix_projection[1][1], glstate_matrix_projection[2][1], glstate_matrix_projection[3][1]);
				vertex_uniform_buffer_3[7] = float4(glstate_matrix_projection[0][2], glstate_matrix_projection[1][2], glstate_matrix_projection[2][2], glstate_matrix_projection[3][2]);
				vertex_uniform_buffer_3[8] = float4(glstate_matrix_projection[0][3], glstate_matrix_projection[1][3], glstate_matrix_projection[2][3], glstate_matrix_projection[3][3]);

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
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				return stage_output;
			}

			#endif // UNITY_UI_CLIP_RECT
			#endif // !UNITY_UI_ALPHACLIP


			#ifdef UNITY_UI_ALPHACLIP
			#ifdef UNITY_UI_CLIP_RECT
			#define ANY_SHADER_VARIANT_ACTIVE

			float4 _FaceTex_ST;
			float4 _FaceColor;
			float _VertexOffsetX;
			float _VertexOffsetY;
			float4 _ClipRect;
			float _MaskSoftnessX;
			float _MaskSoftnessY;
			float4 _ScreenParams;
			float4x4 unity_ObjectToWorld;
			float4x4 glstate_matrix_projection;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[7];
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
			static float2 vertex_output_2;
			static float4 vertex_output_3;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION; // POSITION
				float4 vertex_input_1 : COLOR; // COLOR
				float2 vertex_input_2 : TEXCOORD0; // TEXCOORD
				float2 vertex_input_3 : TEXCOORD1; // TEXCOORD_1
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : COLOR; // COLOR
				float2 vertex_output_2 : TEXCOORD; // TEXCOORD
				float2 vertex_output_2 : TEXCOORD1; // TEXCOORD_1
				float4 vertex_output_3 : TEXCOORD2; // TEXCOORD_2
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_45 = vertex_input_0.w * 0.5f;
				precise float vertex_unnamed_54 = vertex_unnamed_45 / vertex_uniform_buffer_1[6u].x;
				precise float vertex_unnamed_55 = vertex_unnamed_45 / vertex_uniform_buffer_1[6u].y;
				precise float vertex_unnamed_65 = vertex_input_0.x + vertex_uniform_buffer_0[4u].x;
				precise float vertex_unnamed_66 = vertex_input_0.y + vertex_uniform_buffer_0[4u].y;
				precise float vertex_unnamed_67 = vertex_unnamed_54 + vertex_unnamed_65;
				precise float vertex_unnamed_68 = vertex_unnamed_55 + vertex_unnamed_66;
				precise float vertex_unnamed_75 = vertex_unnamed_68 * vertex_uniform_buffer_2[1u].x;
				precise float vertex_unnamed_76 = vertex_unnamed_68 * vertex_uniform_buffer_2[1u].y;
				precise float vertex_unnamed_77 = vertex_unnamed_68 * vertex_uniform_buffer_2[1u].z;
				precise float vertex_unnamed_78 = vertex_unnamed_68 * vertex_uniform_buffer_2[1u].w;
				precise float vertex_unnamed_109 = mad(vertex_uniform_buffer_2[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].x, vertex_unnamed_67, vertex_unnamed_75)) + vertex_uniform_buffer_2[3u].x;
				precise float vertex_unnamed_110 = mad(vertex_uniform_buffer_2[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].y, vertex_unnamed_67, vertex_unnamed_76)) + vertex_uniform_buffer_2[3u].y;
				precise float vertex_unnamed_111 = mad(vertex_uniform_buffer_2[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].z, vertex_unnamed_67, vertex_unnamed_77)) + vertex_uniform_buffer_2[3u].z;
				precise float vertex_unnamed_112 = mad(vertex_uniform_buffer_2[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].w, vertex_unnamed_67, vertex_unnamed_78)) + vertex_uniform_buffer_2[3u].w;
				precise float vertex_unnamed_120 = vertex_unnamed_110 * vertex_uniform_buffer_3[18u].x;
				precise float vertex_unnamed_121 = vertex_unnamed_110 * vertex_uniform_buffer_3[18u].y;
				precise float vertex_unnamed_122 = vertex_unnamed_110 * vertex_uniform_buffer_3[18u].z;
				precise float vertex_unnamed_123 = vertex_unnamed_110 * vertex_uniform_buffer_3[18u].w;
				float vertex_unnamed_156 = mad(vertex_uniform_buffer_3[20u].w, vertex_unnamed_112, mad(vertex_uniform_buffer_3[19u].w, vertex_unnamed_111, mad(vertex_uniform_buffer_3[17u].w, vertex_unnamed_109, vertex_unnamed_123)));
				precise float vertex_unnamed_157 = mad(vertex_uniform_buffer_3[20u].x, vertex_unnamed_112, mad(vertex_uniform_buffer_3[19u].x, vertex_unnamed_111, mad(vertex_uniform_buffer_3[17u].x, vertex_unnamed_109, vertex_unnamed_120))) / vertex_unnamed_156;
				precise float vertex_unnamed_158 = mad(vertex_uniform_buffer_3[20u].y, vertex_unnamed_112, mad(vertex_uniform_buffer_3[19u].y, vertex_unnamed_111, mad(vertex_uniform_buffer_3[17u].y, vertex_unnamed_109, vertex_unnamed_121))) / vertex_unnamed_156;
				precise float vertex_unnamed_163 = vertex_uniform_buffer_1[6u].x * 0.5f;
				precise float vertex_unnamed_164 = vertex_uniform_buffer_1[6u].y * 0.5f;
				precise float vertex_unnamed_165 = vertex_unnamed_157 * vertex_unnamed_163;
				precise float vertex_unnamed_166 = vertex_unnamed_158 * vertex_unnamed_164;
				precise float vertex_unnamed_169 = round(vertex_unnamed_165) / vertex_unnamed_163;
				precise float vertex_unnamed_170 = round(vertex_unnamed_166) / vertex_unnamed_164;
				precise float vertex_unnamed_171 = vertex_unnamed_156 * vertex_unnamed_169;
				precise float vertex_unnamed_172 = vertex_unnamed_156 * vertex_unnamed_170;
				gl_Position.x = vertex_unnamed_171;
				gl_Position.y = vertex_unnamed_172;
				gl_Position.z = mad(vertex_uniform_buffer_3[20u].z, vertex_unnamed_112, mad(vertex_uniform_buffer_3[19u].z, vertex_unnamed_111, mad(vertex_uniform_buffer_3[17u].z, vertex_unnamed_109, vertex_unnamed_122)));
				gl_Position.w = vertex_unnamed_156;
				precise float vertex_unnamed_192 = vertex_input_1.x * vertex_uniform_buffer_0[3u].x;
				precise float vertex_unnamed_193 = vertex_input_1.y * vertex_uniform_buffer_0[3u].y;
				precise float vertex_unnamed_194 = vertex_input_1.z * vertex_uniform_buffer_0[3u].z;
				precise float vertex_unnamed_195 = vertex_input_1.w * vertex_uniform_buffer_0[3u].w;
				vertex_output_1.x = vertex_unnamed_192;
				vertex_output_1.y = vertex_unnamed_193;
				vertex_output_1.z = vertex_unnamed_194;
				vertex_output_1.w = vertex_unnamed_195;
				precise float vertex_unnamed_202 = vertex_input_3.x * 0.000244140625f;
				float vertex_unnamed_204 = floor(vertex_unnamed_202);
				precise float vertex_unnamed_205 = (-0.0f) - vertex_unnamed_204;
				precise float vertex_unnamed_215 = vertex_unnamed_204 * vertex_uniform_buffer_0[2u].x;
				precise float vertex_unnamed_216 = mad(vertex_unnamed_205, 4096.0f, vertex_input_3.x) * vertex_uniform_buffer_0[2u].y;
				vertex_output_2.x = mad(vertex_unnamed_215, 0.001953125f, vertex_uniform_buffer_0[2u].z);
				vertex_output_2.y = mad(vertex_unnamed_216, 0.001953125f, vertex_uniform_buffer_0[2u].w);
				vertex_output_2.x = vertex_input_2.x;
				vertex_output_2.y = vertex_input_2.y;
				precise float vertex_unnamed_249 = (-0.0f) - min(max(vertex_uniform_buffer_0[5u].x, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_250 = (-0.0f) - min(max(vertex_uniform_buffer_0[5u].y, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_254 = (-0.0f) - min(max(vertex_uniform_buffer_0[5u].z, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_255 = (-0.0f) - min(max(vertex_uniform_buffer_0[5u].w, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_256 = vertex_unnamed_254 + mad(vertex_unnamed_67, 2.0f, vertex_unnamed_249);
				precise float vertex_unnamed_257 = vertex_unnamed_255 + mad(vertex_unnamed_68, 2.0f, vertex_unnamed_250);
				vertex_output_3.x = vertex_unnamed_256;
				vertex_output_3.y = vertex_unnamed_257;
				precise float vertex_unnamed_266 = vertex_uniform_buffer_1[6u].x * vertex_uniform_buffer_3[5u].x;
				precise float vertex_unnamed_273 = vertex_uniform_buffer_1[6u].y * vertex_uniform_buffer_3[6u].y;
				precise float vertex_unnamed_276 = vertex_unnamed_156 / abs(vertex_unnamed_266);
				precise float vertex_unnamed_277 = vertex_unnamed_156 / abs(vertex_unnamed_273);
				precise float vertex_unnamed_285 = 0.25f / mad(vertex_uniform_buffer_0[6u].x, 0.25f, vertex_unnamed_276);
				precise float vertex_unnamed_286 = 0.25f / mad(vertex_uniform_buffer_0[6u].y, 0.25f, vertex_unnamed_277);
				vertex_output_3.z = vertex_unnamed_285;
				vertex_output_3.w = vertex_unnamed_286;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[2] = float4(_FaceTex_ST[0], _FaceTex_ST[1], _FaceTex_ST[2], _FaceTex_ST[3]);

				vertex_uniform_buffer_0[3] = float4(_FaceColor[0], _FaceColor[1], _FaceColor[2], _FaceColor[3]);

				vertex_uniform_buffer_0[4] = float4(_VertexOffsetX, vertex_uniform_buffer_0[4][1], vertex_uniform_buffer_0[4][2], vertex_uniform_buffer_0[4][3]);

				vertex_uniform_buffer_0[4] = float4(vertex_uniform_buffer_0[4][0], _VertexOffsetY, vertex_uniform_buffer_0[4][2], vertex_uniform_buffer_0[4][3]);

				vertex_uniform_buffer_0[5] = float4(_ClipRect[0], _ClipRect[1], _ClipRect[2], _ClipRect[3]);

				vertex_uniform_buffer_0[6] = float4(_MaskSoftnessX, vertex_uniform_buffer_0[6][1], vertex_uniform_buffer_0[6][2], vertex_uniform_buffer_0[6][3]);

				vertex_uniform_buffer_0[6] = float4(vertex_uniform_buffer_0[6][0], _MaskSoftnessY, vertex_uniform_buffer_0[6][2], vertex_uniform_buffer_0[6][3]);

				vertex_uniform_buffer_1[6] = float4(_ScreenParams[0], _ScreenParams[1], _ScreenParams[2], _ScreenParams[3]);

				vertex_uniform_buffer_2[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_2[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_2[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_2[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_3[5] = float4(glstate_matrix_projection[0][0], glstate_matrix_projection[1][0], glstate_matrix_projection[2][0], glstate_matrix_projection[3][0]);
				vertex_uniform_buffer_3[6] = float4(glstate_matrix_projection[0][1], glstate_matrix_projection[1][1], glstate_matrix_projection[2][1], glstate_matrix_projection[3][1]);
				vertex_uniform_buffer_3[7] = float4(glstate_matrix_projection[0][2], glstate_matrix_projection[1][2], glstate_matrix_projection[2][2], glstate_matrix_projection[3][2]);
				vertex_uniform_buffer_3[8] = float4(glstate_matrix_projection[0][3], glstate_matrix_projection[1][3], glstate_matrix_projection[2][3], glstate_matrix_projection[3][3]);

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
			float4x4 glstate_matrix_projection;
			float4x4 unity_MatrixVP;
			float4 _FaceTex_ST;
			float4 _FaceColor;
			float _VertexOffsetX;
			float _VertexOffsetY;
			float4 _ClipRect;
			float _MaskSoftnessX;
			float _MaskSoftnessY;

			static float4 unity_ObjectToWorld__array[4];
			static float4 glstate_matrix_projection__array[4];
			static float4 unity_MatrixVP__array[4];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_output_0;
			static float4 vertex_input_1;
			static float2 vertex_input_3;
			static float2 vertex_output_2;
			static float2 vertex_output_1;
			static float2 vertex_input_2;
			static float4 vertex_output_3;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION;
				float4 vertex_input_1 : COLOR;
				float2 vertex_input_2 : TEXCOORD0;
				float2 vertex_input_3 : TEXCOORD1;
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_0 : UNKNOWN0;
				float2 vertex_output_1 : TEXCOORD0; // vs_TEXCOORD0
				float2 vertex_output_2 : TEXCOORD1; // vs_TEXCOORD1
				float4 vertex_output_3 : TEXCOORD2; // vs_TEXCOORD2
				float4 gl_Position : SV_Position;
			};

			static float2 vertex_unnamed_9;
			static float2 vertex_unnamed_39;
			static float4 vertex_unnamed_55;
			static float4 vertex_unnamed_82;

			void vert_main()
			{
				vertex_unnamed_9.x = vertex_input_0.w * 0.5f;
				vertex_unnamed_9 = vertex_unnamed_9.xx / _ScreenParams.xy;
				vertex_unnamed_39 = vertex_input_0.xy + float2(_VertexOffsetX, _VertexOffsetY);
				vertex_unnamed_9 += vertex_unnamed_39;
				vertex_unnamed_55 = vertex_unnamed_9.yyyy * unity_ObjectToWorld__array[1];
				vertex_unnamed_55 = (unity_ObjectToWorld__array[0] * vertex_unnamed_9.xxxx) + vertex_unnamed_55;
				vertex_unnamed_55 = (unity_ObjectToWorld__array[2] * vertex_input_0.zzzz) + vertex_unnamed_55;
				vertex_unnamed_55 += unity_ObjectToWorld__array[3];
				vertex_unnamed_82 = vertex_unnamed_55.yyyy * unity_MatrixVP__array[1];
				vertex_unnamed_82 = (unity_MatrixVP__array[0] * vertex_unnamed_55.xxxx) + vertex_unnamed_82;
				vertex_unnamed_82 = (unity_MatrixVP__array[2] * vertex_unnamed_55.zzzz) + vertex_unnamed_82;
				vertex_unnamed_55 = (unity_MatrixVP__array[3] * vertex_unnamed_55.wwww) + vertex_unnamed_82;
				vertex_unnamed_39 = vertex_unnamed_55.xy / vertex_unnamed_55.ww;
				float2 vertex_unnamed_118 = _ScreenParams.xy * 0.5f.xx;
				vertex_unnamed_55 = float4(vertex_unnamed_118.x, vertex_unnamed_118.y, vertex_unnamed_55.z, vertex_unnamed_55.w);
				vertex_unnamed_39 *= vertex_unnamed_55.xy;
				vertex_unnamed_39 = round(vertex_unnamed_39);
				vertex_unnamed_39 /= vertex_unnamed_55.xy;
				float2 vertex_unnamed_139 = vertex_unnamed_55.ww * vertex_unnamed_39;
				gl_Position = float4(vertex_unnamed_139.x, vertex_unnamed_139.y, gl_Position.z, gl_Position.w);
				gl_Position = float4(gl_Position.x, gl_Position.y, vertex_unnamed_55.zw.x, vertex_unnamed_55.zw.y);
				vertex_output_0 = vertex_input_1 * _FaceColor;
				vertex_unnamed_39.x = vertex_input_3.x * 0.000244140625f;
				vertex_unnamed_39.x = floor(vertex_unnamed_39.x);
				vertex_unnamed_39.y = ((-vertex_unnamed_39.x) * 4096.0f) + vertex_input_3.x;
				vertex_unnamed_39 *= _FaceTex_ST.xy;
				vertex_output_2 = (vertex_unnamed_39 * 0.001953125f.xx) + _FaceTex_ST.zw;
				vertex_output_1 = vertex_input_2;
				vertex_unnamed_82 = max(_ClipRect, (-20000000000.0f).xxxx);
				vertex_unnamed_82 = min(vertex_unnamed_82, 20000000000.0f.xxxx);
				vertex_unnamed_9 = (vertex_unnamed_9 * 2.0f.xx) + (-vertex_unnamed_82.xy);
				float2 vertex_unnamed_218 = (-vertex_unnamed_82.zw) + vertex_unnamed_9;
				vertex_output_3 = float4(vertex_unnamed_218.x, vertex_unnamed_218.y, vertex_output_3.z, vertex_output_3.w);
				vertex_unnamed_39.x = _ScreenParams.x * glstate_matrix_projection__array[0].x;
				vertex_unnamed_39.y = _ScreenParams.y * glstate_matrix_projection__array[1].y;
				vertex_unnamed_9 = vertex_unnamed_55.ww / abs(vertex_unnamed_39);
				vertex_unnamed_9 = (float2(_MaskSoftnessX, _MaskSoftnessY) * 0.25f.xx) + vertex_unnamed_9;
				float2 vertex_unnamed_251 = 0.25f.xx / vertex_unnamed_9;
				vertex_output_3 = float4(vertex_output_3.x, vertex_output_3.y, vertex_unnamed_251.x, vertex_unnamed_251.y);
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				unity_ObjectToWorld__array[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				unity_ObjectToWorld__array[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				unity_ObjectToWorld__array[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				unity_ObjectToWorld__array[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				glstate_matrix_projection__array[0] = float4(glstate_matrix_projection[0][0], glstate_matrix_projection[1][0], glstate_matrix_projection[2][0], glstate_matrix_projection[3][0]);
				glstate_matrix_projection__array[1] = float4(glstate_matrix_projection[0][1], glstate_matrix_projection[1][1], glstate_matrix_projection[2][1], glstate_matrix_projection[3][1]);
				glstate_matrix_projection__array[2] = float4(glstate_matrix_projection[0][2], glstate_matrix_projection[1][2], glstate_matrix_projection[2][2], glstate_matrix_projection[3][2]);
				glstate_matrix_projection__array[3] = float4(glstate_matrix_projection[0][3], glstate_matrix_projection[1][3], glstate_matrix_projection[2][3], glstate_matrix_projection[3][3]);

				unity_MatrixVP__array[0] = float4(unity_MatrixVP[0][0], unity_MatrixVP[1][0], unity_MatrixVP[2][0], unity_MatrixVP[3][0]);
				unity_MatrixVP__array[1] = float4(unity_MatrixVP[0][1], unity_MatrixVP[1][1], unity_MatrixVP[2][1], unity_MatrixVP[3][1]);
				unity_MatrixVP__array[2] = float4(unity_MatrixVP[0][2], unity_MatrixVP[1][2], unity_MatrixVP[2][2], unity_MatrixVP[3][2]);
				unity_MatrixVP__array[3] = float4(unity_MatrixVP[0][3], unity_MatrixVP[1][3], unity_MatrixVP[2][3], unity_MatrixVP[3][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_3 = stage_input.vertex_input_3;
				vertex_input_2 = stage_input.vertex_input_2;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_0 = vertex_output_0;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_3 = vertex_output_3;
				return stage_output;
			}

			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;
			Texture2D<float4> _FaceTex;
			SamplerState sampler_FaceTex;

			static float2 fragment_input_1;
			static float2 fragment_input_2;
			static float4 fragment_output_0;
			static float4 fragment_input_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_0 : UNKNOWN0;
				float2 fragment_input_1 : TEXCOORD0; // vs_TEXCOORD0
				float2 fragment_input_2 : TEXCOORD1; // vs_TEXCOORD1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static float4 fragment_unnamed_9;
			static float4 fragment_unnamed_25;

			void frag_main()
			{
				fragment_unnamed_9 = _MainTex.Sample(sampler_MainTex, fragment_input_1);
				fragment_unnamed_25 = _FaceTex.Sample(sampler_FaceTex, fragment_input_2);
				fragment_unnamed_9 *= fragment_unnamed_25;
				fragment_output_0 = fragment_unnamed_9 * fragment_input_0;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
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
			float4x4 glstate_matrix_projection;
			float4x4 unity_MatrixVP;
			float4 _FaceTex_ST;
			float4 _FaceColor;
			float _VertexOffsetX;
			float _VertexOffsetY;
			float4 _ClipRect;
			float _MaskSoftnessX;
			float _MaskSoftnessY;

			static float4 unity_ObjectToWorld__array[4];
			static float4 glstate_matrix_projection__array[4];
			static float4 unity_MatrixVP__array[4];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_output_0;
			static float4 vertex_input_1;
			static float2 vertex_input_3;
			static float2 vertex_output_2;
			static float2 vertex_output_1;
			static float2 vertex_input_2;
			static float4 vertex_output_3;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION;
				float4 vertex_input_1 : COLOR;
				float2 vertex_input_2 : TEXCOORD0;
				float2 vertex_input_3 : TEXCOORD1;
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_0 : UNKNOWN0;
				float2 vertex_output_1 : TEXCOORD0; // vs_TEXCOORD0
				float2 vertex_output_2 : TEXCOORD1; // vs_TEXCOORD1
				float4 vertex_output_3 : TEXCOORD2; // vs_TEXCOORD2
				float4 gl_Position : SV_Position;
			};

			static float2 vertex_unnamed_9;
			static float2 vertex_unnamed_39;
			static float4 vertex_unnamed_55;
			static float4 vertex_unnamed_82;

			void vert_main()
			{
				vertex_unnamed_9.x = vertex_input_0.w * 0.5f;
				vertex_unnamed_9 = vertex_unnamed_9.xx / _ScreenParams.xy;
				vertex_unnamed_39 = vertex_input_0.xy + float2(_VertexOffsetX, _VertexOffsetY);
				vertex_unnamed_9 += vertex_unnamed_39;
				vertex_unnamed_55 = vertex_unnamed_9.yyyy * unity_ObjectToWorld__array[1];
				vertex_unnamed_55 = (unity_ObjectToWorld__array[0] * vertex_unnamed_9.xxxx) + vertex_unnamed_55;
				vertex_unnamed_55 = (unity_ObjectToWorld__array[2] * vertex_input_0.zzzz) + vertex_unnamed_55;
				vertex_unnamed_55 += unity_ObjectToWorld__array[3];
				vertex_unnamed_82 = vertex_unnamed_55.yyyy * unity_MatrixVP__array[1];
				vertex_unnamed_82 = (unity_MatrixVP__array[0] * vertex_unnamed_55.xxxx) + vertex_unnamed_82;
				vertex_unnamed_82 = (unity_MatrixVP__array[2] * vertex_unnamed_55.zzzz) + vertex_unnamed_82;
				vertex_unnamed_55 = (unity_MatrixVP__array[3] * vertex_unnamed_55.wwww) + vertex_unnamed_82;
				vertex_unnamed_39 = vertex_unnamed_55.xy / vertex_unnamed_55.ww;
				float2 vertex_unnamed_118 = _ScreenParams.xy * 0.5f.xx;
				vertex_unnamed_55 = float4(vertex_unnamed_118.x, vertex_unnamed_118.y, vertex_unnamed_55.z, vertex_unnamed_55.w);
				vertex_unnamed_39 *= vertex_unnamed_55.xy;
				vertex_unnamed_39 = round(vertex_unnamed_39);
				vertex_unnamed_39 /= vertex_unnamed_55.xy;
				float2 vertex_unnamed_139 = vertex_unnamed_55.ww * vertex_unnamed_39;
				gl_Position = float4(vertex_unnamed_139.x, vertex_unnamed_139.y, gl_Position.z, gl_Position.w);
				gl_Position = float4(gl_Position.x, gl_Position.y, vertex_unnamed_55.zw.x, vertex_unnamed_55.zw.y);
				vertex_output_0 = vertex_input_1 * _FaceColor;
				vertex_unnamed_39.x = vertex_input_3.x * 0.000244140625f;
				vertex_unnamed_39.x = floor(vertex_unnamed_39.x);
				vertex_unnamed_39.y = ((-vertex_unnamed_39.x) * 4096.0f) + vertex_input_3.x;
				vertex_unnamed_39 *= _FaceTex_ST.xy;
				vertex_output_2 = (vertex_unnamed_39 * 0.001953125f.xx) + _FaceTex_ST.zw;
				vertex_output_1 = vertex_input_2;
				vertex_unnamed_82 = max(_ClipRect, (-20000000000.0f).xxxx);
				vertex_unnamed_82 = min(vertex_unnamed_82, 20000000000.0f.xxxx);
				vertex_unnamed_9 = (vertex_unnamed_9 * 2.0f.xx) + (-vertex_unnamed_82.xy);
				float2 vertex_unnamed_218 = (-vertex_unnamed_82.zw) + vertex_unnamed_9;
				vertex_output_3 = float4(vertex_unnamed_218.x, vertex_unnamed_218.y, vertex_output_3.z, vertex_output_3.w);
				vertex_unnamed_39.x = _ScreenParams.x * glstate_matrix_projection__array[0].x;
				vertex_unnamed_39.y = _ScreenParams.y * glstate_matrix_projection__array[1].y;
				vertex_unnamed_9 = vertex_unnamed_55.ww / abs(vertex_unnamed_39);
				vertex_unnamed_9 = (float2(_MaskSoftnessX, _MaskSoftnessY) * 0.25f.xx) + vertex_unnamed_9;
				float2 vertex_unnamed_251 = 0.25f.xx / vertex_unnamed_9;
				vertex_output_3 = float4(vertex_output_3.x, vertex_output_3.y, vertex_unnamed_251.x, vertex_unnamed_251.y);
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				unity_ObjectToWorld__array[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				unity_ObjectToWorld__array[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				unity_ObjectToWorld__array[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				unity_ObjectToWorld__array[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				glstate_matrix_projection__array[0] = float4(glstate_matrix_projection[0][0], glstate_matrix_projection[1][0], glstate_matrix_projection[2][0], glstate_matrix_projection[3][0]);
				glstate_matrix_projection__array[1] = float4(glstate_matrix_projection[0][1], glstate_matrix_projection[1][1], glstate_matrix_projection[2][1], glstate_matrix_projection[3][1]);
				glstate_matrix_projection__array[2] = float4(glstate_matrix_projection[0][2], glstate_matrix_projection[1][2], glstate_matrix_projection[2][2], glstate_matrix_projection[3][2]);
				glstate_matrix_projection__array[3] = float4(glstate_matrix_projection[0][3], glstate_matrix_projection[1][3], glstate_matrix_projection[2][3], glstate_matrix_projection[3][3]);

				unity_MatrixVP__array[0] = float4(unity_MatrixVP[0][0], unity_MatrixVP[1][0], unity_MatrixVP[2][0], unity_MatrixVP[3][0]);
				unity_MatrixVP__array[1] = float4(unity_MatrixVP[0][1], unity_MatrixVP[1][1], unity_MatrixVP[2][1], unity_MatrixVP[3][1]);
				unity_MatrixVP__array[2] = float4(unity_MatrixVP[0][2], unity_MatrixVP[1][2], unity_MatrixVP[2][2], unity_MatrixVP[3][2]);
				unity_MatrixVP__array[3] = float4(unity_MatrixVP[0][3], unity_MatrixVP[1][3], unity_MatrixVP[2][3], unity_MatrixVP[3][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_3 = stage_input.vertex_input_3;
				vertex_input_2 = stage_input.vertex_input_2;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_0 = vertex_output_0;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_3 = vertex_output_3;
				return stage_output;
			}

			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;
			Texture2D<float4> _FaceTex;
			SamplerState sampler_FaceTex;

			static float2 fragment_input_1;
			static float2 fragment_input_2;
			static float4 fragment_input_0;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_0 : UNKNOWN0;
				float2 fragment_input_1 : TEXCOORD0; // vs_TEXCOORD0
				float2 fragment_input_2 : TEXCOORD1; // vs_TEXCOORD1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static float4 fragment_unnamed_9;
			static float4 fragment_unnamed_25;
			static bool fragment_unnamed_60;

			void frag_main()
			{
				fragment_unnamed_9 = _MainTex.Sample(sampler_MainTex, fragment_input_1);
				fragment_unnamed_25 = _FaceTex.Sample(sampler_FaceTex, fragment_input_2);
				fragment_unnamed_9 *= fragment_unnamed_25;
				fragment_unnamed_25.x = (fragment_unnamed_9.w * fragment_input_0.w) + (-0.001000000047497451305389404296875f);
				fragment_unnamed_9 *= fragment_input_0;
				fragment_output_0 = fragment_unnamed_9;
				fragment_unnamed_60 = fragment_unnamed_25.x < 0.0f;
				if ((int(fragment_unnamed_60) * (-1)) != 0)
				{
					discard;
				}
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
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
			float4x4 glstate_matrix_projection;
			float4x4 unity_MatrixVP;
			float4 _FaceTex_ST;
			float4 _FaceColor;
			float _VertexOffsetX;
			float _VertexOffsetY;
			float4 _ClipRect;
			float _MaskSoftnessX;
			float _MaskSoftnessY;

			static float4 unity_ObjectToWorld__array[4];
			static float4 glstate_matrix_projection__array[4];
			static float4 unity_MatrixVP__array[4];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_output_0;
			static float4 vertex_input_1;
			static float2 vertex_input_3;
			static float2 vertex_output_2;
			static float2 vertex_output_1;
			static float2 vertex_input_2;
			static float4 vertex_output_3;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION;
				float4 vertex_input_1 : COLOR;
				float2 vertex_input_2 : TEXCOORD0;
				float2 vertex_input_3 : TEXCOORD1;
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_0 : UNKNOWN0;
				float2 vertex_output_1 : TEXCOORD0; // vs_TEXCOORD0
				float2 vertex_output_2 : TEXCOORD1; // vs_TEXCOORD1
				float4 vertex_output_3 : TEXCOORD2; // vs_TEXCOORD2
				float4 gl_Position : SV_Position;
			};

			static float2 vertex_unnamed_9;
			static float2 vertex_unnamed_39;
			static float4 vertex_unnamed_55;
			static float4 vertex_unnamed_82;

			void vert_main()
			{
				vertex_unnamed_9.x = vertex_input_0.w * 0.5f;
				vertex_unnamed_9 = vertex_unnamed_9.xx / _ScreenParams.xy;
				vertex_unnamed_39 = vertex_input_0.xy + float2(_VertexOffsetX, _VertexOffsetY);
				vertex_unnamed_9 += vertex_unnamed_39;
				vertex_unnamed_55 = vertex_unnamed_9.yyyy * unity_ObjectToWorld__array[1];
				vertex_unnamed_55 = (unity_ObjectToWorld__array[0] * vertex_unnamed_9.xxxx) + vertex_unnamed_55;
				vertex_unnamed_55 = (unity_ObjectToWorld__array[2] * vertex_input_0.zzzz) + vertex_unnamed_55;
				vertex_unnamed_55 += unity_ObjectToWorld__array[3];
				vertex_unnamed_82 = vertex_unnamed_55.yyyy * unity_MatrixVP__array[1];
				vertex_unnamed_82 = (unity_MatrixVP__array[0] * vertex_unnamed_55.xxxx) + vertex_unnamed_82;
				vertex_unnamed_82 = (unity_MatrixVP__array[2] * vertex_unnamed_55.zzzz) + vertex_unnamed_82;
				vertex_unnamed_55 = (unity_MatrixVP__array[3] * vertex_unnamed_55.wwww) + vertex_unnamed_82;
				vertex_unnamed_39 = vertex_unnamed_55.xy / vertex_unnamed_55.ww;
				float2 vertex_unnamed_118 = _ScreenParams.xy * 0.5f.xx;
				vertex_unnamed_55 = float4(vertex_unnamed_118.x, vertex_unnamed_118.y, vertex_unnamed_55.z, vertex_unnamed_55.w);
				vertex_unnamed_39 *= vertex_unnamed_55.xy;
				vertex_unnamed_39 = round(vertex_unnamed_39);
				vertex_unnamed_39 /= vertex_unnamed_55.xy;
				float2 vertex_unnamed_139 = vertex_unnamed_55.ww * vertex_unnamed_39;
				gl_Position = float4(vertex_unnamed_139.x, vertex_unnamed_139.y, gl_Position.z, gl_Position.w);
				gl_Position = float4(gl_Position.x, gl_Position.y, vertex_unnamed_55.zw.x, vertex_unnamed_55.zw.y);
				vertex_output_0 = vertex_input_1 * _FaceColor;
				vertex_unnamed_39.x = vertex_input_3.x * 0.000244140625f;
				vertex_unnamed_39.x = floor(vertex_unnamed_39.x);
				vertex_unnamed_39.y = ((-vertex_unnamed_39.x) * 4096.0f) + vertex_input_3.x;
				vertex_unnamed_39 *= _FaceTex_ST.xy;
				vertex_output_2 = (vertex_unnamed_39 * 0.001953125f.xx) + _FaceTex_ST.zw;
				vertex_output_1 = vertex_input_2;
				vertex_unnamed_82 = max(_ClipRect, (-20000000000.0f).xxxx);
				vertex_unnamed_82 = min(vertex_unnamed_82, 20000000000.0f.xxxx);
				vertex_unnamed_9 = (vertex_unnamed_9 * 2.0f.xx) + (-vertex_unnamed_82.xy);
				float2 vertex_unnamed_218 = (-vertex_unnamed_82.zw) + vertex_unnamed_9;
				vertex_output_3 = float4(vertex_unnamed_218.x, vertex_unnamed_218.y, vertex_output_3.z, vertex_output_3.w);
				vertex_unnamed_39.x = _ScreenParams.x * glstate_matrix_projection__array[0].x;
				vertex_unnamed_39.y = _ScreenParams.y * glstate_matrix_projection__array[1].y;
				vertex_unnamed_9 = vertex_unnamed_55.ww / abs(vertex_unnamed_39);
				vertex_unnamed_9 = (float2(_MaskSoftnessX, _MaskSoftnessY) * 0.25f.xx) + vertex_unnamed_9;
				float2 vertex_unnamed_251 = 0.25f.xx / vertex_unnamed_9;
				vertex_output_3 = float4(vertex_output_3.x, vertex_output_3.y, vertex_unnamed_251.x, vertex_unnamed_251.y);
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				unity_ObjectToWorld__array[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				unity_ObjectToWorld__array[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				unity_ObjectToWorld__array[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				unity_ObjectToWorld__array[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				glstate_matrix_projection__array[0] = float4(glstate_matrix_projection[0][0], glstate_matrix_projection[1][0], glstate_matrix_projection[2][0], glstate_matrix_projection[3][0]);
				glstate_matrix_projection__array[1] = float4(glstate_matrix_projection[0][1], glstate_matrix_projection[1][1], glstate_matrix_projection[2][1], glstate_matrix_projection[3][1]);
				glstate_matrix_projection__array[2] = float4(glstate_matrix_projection[0][2], glstate_matrix_projection[1][2], glstate_matrix_projection[2][2], glstate_matrix_projection[3][2]);
				glstate_matrix_projection__array[3] = float4(glstate_matrix_projection[0][3], glstate_matrix_projection[1][3], glstate_matrix_projection[2][3], glstate_matrix_projection[3][3]);

				unity_MatrixVP__array[0] = float4(unity_MatrixVP[0][0], unity_MatrixVP[1][0], unity_MatrixVP[2][0], unity_MatrixVP[3][0]);
				unity_MatrixVP__array[1] = float4(unity_MatrixVP[0][1], unity_MatrixVP[1][1], unity_MatrixVP[2][1], unity_MatrixVP[3][1]);
				unity_MatrixVP__array[2] = float4(unity_MatrixVP[0][2], unity_MatrixVP[1][2], unity_MatrixVP[2][2], unity_MatrixVP[3][2]);
				unity_MatrixVP__array[3] = float4(unity_MatrixVP[0][3], unity_MatrixVP[1][3], unity_MatrixVP[2][3], unity_MatrixVP[3][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_3 = stage_input.vertex_input_3;
				vertex_input_2 = stage_input.vertex_input_2;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_0 = vertex_output_0;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_3 = vertex_output_3;
				return stage_output;
			}

			float4 _ClipRect;

			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;
			Texture2D<float4> _FaceTex;
			SamplerState sampler_FaceTex;

			static float2 fragment_input_1;
			static float2 fragment_input_2;
			static float4 fragment_input_0;
			static float4 fragment_input_3;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_0 : UNKNOWN0;
				float2 fragment_input_1 : TEXCOORD0; // vs_TEXCOORD0
				float2 fragment_input_2 : TEXCOORD1; // vs_TEXCOORD1
				float4 fragment_input_3 : TEXCOORD2; // vs_TEXCOORD2
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static float4 fragment_unnamed_9;
			static float4 fragment_unnamed_25;

			void frag_main()
			{
				fragment_unnamed_9 = _MainTex.Sample(sampler_MainTex, fragment_input_1);
				fragment_unnamed_25 = _FaceTex.Sample(sampler_FaceTex, fragment_input_2);
				fragment_unnamed_9 *= fragment_unnamed_25;
				fragment_unnamed_9 *= fragment_input_0;
				float2 fragment_unnamed_55 = (-_ClipRect.xy) + _ClipRect.zw;
				fragment_unnamed_25 = float4(fragment_unnamed_55.x, fragment_unnamed_55.y, fragment_unnamed_25.z, fragment_unnamed_25.w);
				float2 fragment_unnamed_65 = fragment_unnamed_25.xy + (-abs(fragment_input_3.xy));
				fragment_unnamed_25 = float4(fragment_unnamed_65.x, fragment_unnamed_65.y, fragment_unnamed_25.z, fragment_unnamed_25.w);
				float2 fragment_unnamed_72 = fragment_unnamed_25.xy * fragment_input_3.zw;
				fragment_unnamed_25 = float4(fragment_unnamed_72.x, fragment_unnamed_72.y, fragment_unnamed_25.z, fragment_unnamed_25.w);
				float2 fragment_unnamed_81 = clamp(fragment_unnamed_25.xy, 0.0f.xx, 1.0f.xx);
				fragment_unnamed_25 = float4(fragment_unnamed_81.x, fragment_unnamed_81.y, fragment_unnamed_25.z, fragment_unnamed_25.w);
				fragment_unnamed_25.x = fragment_unnamed_25.y * fragment_unnamed_25.x;
				fragment_output_0 = fragment_unnamed_9 * fragment_unnamed_25.xxxx;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_0 = stage_input.fragment_input_0;
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

			float4 _ScreenParams;
			float4x4 unity_ObjectToWorld;
			float4x4 glstate_matrix_projection;
			float4x4 unity_MatrixVP;
			float4 _FaceTex_ST;
			float4 _FaceColor;
			float _VertexOffsetX;
			float _VertexOffsetY;
			float4 _ClipRect;
			float _MaskSoftnessX;
			float _MaskSoftnessY;

			static float4 unity_ObjectToWorld__array[4];
			static float4 glstate_matrix_projection__array[4];
			static float4 unity_MatrixVP__array[4];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_output_0;
			static float4 vertex_input_1;
			static float2 vertex_input_3;
			static float2 vertex_output_2;
			static float2 vertex_output_1;
			static float2 vertex_input_2;
			static float4 vertex_output_3;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION;
				float4 vertex_input_1 : COLOR;
				float2 vertex_input_2 : TEXCOORD0;
				float2 vertex_input_3 : TEXCOORD1;
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_0 : UNKNOWN0;
				float2 vertex_output_1 : TEXCOORD0; // vs_TEXCOORD0
				float2 vertex_output_2 : TEXCOORD1; // vs_TEXCOORD1
				float4 vertex_output_3 : TEXCOORD2; // vs_TEXCOORD2
				float4 gl_Position : SV_Position;
			};

			static float2 vertex_unnamed_9;
			static float2 vertex_unnamed_39;
			static float4 vertex_unnamed_55;
			static float4 vertex_unnamed_82;

			void vert_main()
			{
				vertex_unnamed_9.x = vertex_input_0.w * 0.5f;
				vertex_unnamed_9 = vertex_unnamed_9.xx / _ScreenParams.xy;
				vertex_unnamed_39 = vertex_input_0.xy + float2(_VertexOffsetX, _VertexOffsetY);
				vertex_unnamed_9 += vertex_unnamed_39;
				vertex_unnamed_55 = vertex_unnamed_9.yyyy * unity_ObjectToWorld__array[1];
				vertex_unnamed_55 = (unity_ObjectToWorld__array[0] * vertex_unnamed_9.xxxx) + vertex_unnamed_55;
				vertex_unnamed_55 = (unity_ObjectToWorld__array[2] * vertex_input_0.zzzz) + vertex_unnamed_55;
				vertex_unnamed_55 += unity_ObjectToWorld__array[3];
				vertex_unnamed_82 = vertex_unnamed_55.yyyy * unity_MatrixVP__array[1];
				vertex_unnamed_82 = (unity_MatrixVP__array[0] * vertex_unnamed_55.xxxx) + vertex_unnamed_82;
				vertex_unnamed_82 = (unity_MatrixVP__array[2] * vertex_unnamed_55.zzzz) + vertex_unnamed_82;
				vertex_unnamed_55 = (unity_MatrixVP__array[3] * vertex_unnamed_55.wwww) + vertex_unnamed_82;
				vertex_unnamed_39 = vertex_unnamed_55.xy / vertex_unnamed_55.ww;
				float2 vertex_unnamed_118 = _ScreenParams.xy * 0.5f.xx;
				vertex_unnamed_55 = float4(vertex_unnamed_118.x, vertex_unnamed_118.y, vertex_unnamed_55.z, vertex_unnamed_55.w);
				vertex_unnamed_39 *= vertex_unnamed_55.xy;
				vertex_unnamed_39 = round(vertex_unnamed_39);
				vertex_unnamed_39 /= vertex_unnamed_55.xy;
				float2 vertex_unnamed_139 = vertex_unnamed_55.ww * vertex_unnamed_39;
				gl_Position = float4(vertex_unnamed_139.x, vertex_unnamed_139.y, gl_Position.z, gl_Position.w);
				gl_Position = float4(gl_Position.x, gl_Position.y, vertex_unnamed_55.zw.x, vertex_unnamed_55.zw.y);
				vertex_output_0 = vertex_input_1 * _FaceColor;
				vertex_unnamed_39.x = vertex_input_3.x * 0.000244140625f;
				vertex_unnamed_39.x = floor(vertex_unnamed_39.x);
				vertex_unnamed_39.y = ((-vertex_unnamed_39.x) * 4096.0f) + vertex_input_3.x;
				vertex_unnamed_39 *= _FaceTex_ST.xy;
				vertex_output_2 = (vertex_unnamed_39 * 0.001953125f.xx) + _FaceTex_ST.zw;
				vertex_output_1 = vertex_input_2;
				vertex_unnamed_82 = max(_ClipRect, (-20000000000.0f).xxxx);
				vertex_unnamed_82 = min(vertex_unnamed_82, 20000000000.0f.xxxx);
				vertex_unnamed_9 = (vertex_unnamed_9 * 2.0f.xx) + (-vertex_unnamed_82.xy);
				float2 vertex_unnamed_218 = (-vertex_unnamed_82.zw) + vertex_unnamed_9;
				vertex_output_3 = float4(vertex_unnamed_218.x, vertex_unnamed_218.y, vertex_output_3.z, vertex_output_3.w);
				vertex_unnamed_39.x = _ScreenParams.x * glstate_matrix_projection__array[0].x;
				vertex_unnamed_39.y = _ScreenParams.y * glstate_matrix_projection__array[1].y;
				vertex_unnamed_9 = vertex_unnamed_55.ww / abs(vertex_unnamed_39);
				vertex_unnamed_9 = (float2(_MaskSoftnessX, _MaskSoftnessY) * 0.25f.xx) + vertex_unnamed_9;
				float2 vertex_unnamed_251 = 0.25f.xx / vertex_unnamed_9;
				vertex_output_3 = float4(vertex_output_3.x, vertex_output_3.y, vertex_unnamed_251.x, vertex_unnamed_251.y);
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				unity_ObjectToWorld__array[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				unity_ObjectToWorld__array[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				unity_ObjectToWorld__array[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				unity_ObjectToWorld__array[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				glstate_matrix_projection__array[0] = float4(glstate_matrix_projection[0][0], glstate_matrix_projection[1][0], glstate_matrix_projection[2][0], glstate_matrix_projection[3][0]);
				glstate_matrix_projection__array[1] = float4(glstate_matrix_projection[0][1], glstate_matrix_projection[1][1], glstate_matrix_projection[2][1], glstate_matrix_projection[3][1]);
				glstate_matrix_projection__array[2] = float4(glstate_matrix_projection[0][2], glstate_matrix_projection[1][2], glstate_matrix_projection[2][2], glstate_matrix_projection[3][2]);
				glstate_matrix_projection__array[3] = float4(glstate_matrix_projection[0][3], glstate_matrix_projection[1][3], glstate_matrix_projection[2][3], glstate_matrix_projection[3][3]);

				unity_MatrixVP__array[0] = float4(unity_MatrixVP[0][0], unity_MatrixVP[1][0], unity_MatrixVP[2][0], unity_MatrixVP[3][0]);
				unity_MatrixVP__array[1] = float4(unity_MatrixVP[0][1], unity_MatrixVP[1][1], unity_MatrixVP[2][1], unity_MatrixVP[3][1]);
				unity_MatrixVP__array[2] = float4(unity_MatrixVP[0][2], unity_MatrixVP[1][2], unity_MatrixVP[2][2], unity_MatrixVP[3][2]);
				unity_MatrixVP__array[3] = float4(unity_MatrixVP[0][3], unity_MatrixVP[1][3], unity_MatrixVP[2][3], unity_MatrixVP[3][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_3 = stage_input.vertex_input_3;
				vertex_input_2 = stage_input.vertex_input_2;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_0 = vertex_output_0;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_3 = vertex_output_3;
				return stage_output;
			}

			float4 _ClipRect;

			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;
			Texture2D<float4> _FaceTex;
			SamplerState sampler_FaceTex;

			static float2 fragment_input_1;
			static float2 fragment_input_2;
			static float4 fragment_input_0;
			static float4 fragment_input_3;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_0 : UNKNOWN0;
				float2 fragment_input_1 : TEXCOORD0; // vs_TEXCOORD0
				float2 fragment_input_2 : TEXCOORD1; // vs_TEXCOORD1
				float4 fragment_input_3 : TEXCOORD2; // vs_TEXCOORD2
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static float4 fragment_unnamed_9;
			static float4 fragment_unnamed_25;
			static float fragment_unnamed_94;
			static bool fragment_unnamed_112;

			void frag_main()
			{
				fragment_unnamed_9 = _MainTex.Sample(sampler_MainTex, fragment_input_1);
				fragment_unnamed_25 = _FaceTex.Sample(sampler_FaceTex, fragment_input_2);
				fragment_unnamed_9 *= fragment_unnamed_25;
				fragment_unnamed_9 *= fragment_input_0;
				float2 fragment_unnamed_55 = (-_ClipRect.xy) + _ClipRect.zw;
				fragment_unnamed_25 = float4(fragment_unnamed_55.x, fragment_unnamed_55.y, fragment_unnamed_25.z, fragment_unnamed_25.w);
				float2 fragment_unnamed_65 = fragment_unnamed_25.xy + (-abs(fragment_input_3.xy));
				fragment_unnamed_25 = float4(fragment_unnamed_65.x, fragment_unnamed_65.y, fragment_unnamed_25.z, fragment_unnamed_25.w);
				float2 fragment_unnamed_72 = fragment_unnamed_25.xy * fragment_input_3.zw;
				fragment_unnamed_25 = float4(fragment_unnamed_72.x, fragment_unnamed_72.y, fragment_unnamed_25.z, fragment_unnamed_25.w);
				float2 fragment_unnamed_81 = clamp(fragment_unnamed_25.xy, 0.0f.xx, 1.0f.xx);
				fragment_unnamed_25 = float4(fragment_unnamed_81.x, fragment_unnamed_81.y, fragment_unnamed_25.z, fragment_unnamed_25.w);
				fragment_unnamed_25.x = fragment_unnamed_25.y * fragment_unnamed_25.x;
				fragment_unnamed_94 = (fragment_unnamed_9.w * fragment_unnamed_25.x) + (-0.001000000047497451305389404296875f);
				fragment_unnamed_9 *= fragment_unnamed_25.xxxx;
				fragment_output_0 = fragment_unnamed_9;
				fragment_unnamed_112 = fragment_unnamed_94 < 0.0f;
				if ((int(fragment_unnamed_112) * (-1)) != 0)
				{
					discard;
				}
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_0 = stage_input.fragment_input_0;
				fragment_input_3 = stage_input.fragment_input_3;
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
			Texture2D<float4> _FaceTex;
			SamplerState sampler_MainTex;
			SamplerState sampler_FaceTex;

			static float4 fragment_input_1;
			static float2 fragment_input_2;
			static float2 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : COLOR; // COLOR
				float2 fragment_input_2 : TEXCOORD; // TEXCOORD
				float2 fragment_input_2 : TEXCOORD1; // TEXCOORD_1
				float4 fragment_input_3 : TEXCOORD2; // TEXCOORD_2
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				float4 fragment_unnamed_40 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_2.x, fragment_input_2.y));
				float4 fragment_unnamed_51 = _FaceTex.Sample(sampler_FaceTex, float2(fragment_input_2.x, fragment_input_2.y));
				precise float fragment_unnamed_57 = fragment_unnamed_40.x * fragment_unnamed_51.x;
				precise float fragment_unnamed_58 = fragment_unnamed_40.y * fragment_unnamed_51.y;
				precise float fragment_unnamed_59 = fragment_unnamed_40.z * fragment_unnamed_51.z;
				precise float fragment_unnamed_60 = fragment_unnamed_40.w * fragment_unnamed_51.w;
				precise float fragment_unnamed_71 = fragment_unnamed_57 * fragment_input_1.x;
				precise float fragment_unnamed_72 = fragment_unnamed_58 * fragment_input_1.y;
				precise float fragment_unnamed_73 = fragment_unnamed_59 * fragment_input_1.z;
				precise float fragment_unnamed_74 = fragment_unnamed_60 * fragment_input_1.w;
				fragment_output_0.x = fragment_unnamed_71;
				fragment_output_0.y = fragment_unnamed_72;
				fragment_output_0.z = fragment_unnamed_73;
				fragment_output_0.w = fragment_unnamed_74;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
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
			Texture2D<float4> _FaceTex;
			SamplerState sampler_MainTex;
			SamplerState sampler_FaceTex;

			static float4 fragment_input_1;
			static float2 fragment_input_2;
			static float2 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : COLOR; // COLOR
				float2 fragment_input_2 : TEXCOORD; // TEXCOORD
				float2 fragment_input_2 : TEXCOORD1; // TEXCOORD_1
				float4 fragment_input_3 : TEXCOORD2; // TEXCOORD_2
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static bool discard_state;

			void discard_cond(bool fragment_unnamed_92)
			{
				if (fragment_unnamed_92)
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
				float4 fragment_unnamed_51 = _FaceTex.Sample(sampler_FaceTex, float2(fragment_input_2.x, fragment_input_2.y));
				precise float fragment_unnamed_57 = fragment_unnamed_40.x * fragment_unnamed_51.x;
				precise float fragment_unnamed_58 = fragment_unnamed_40.y * fragment_unnamed_51.y;
				precise float fragment_unnamed_59 = fragment_unnamed_40.z * fragment_unnamed_51.z;
				precise float fragment_unnamed_60 = fragment_unnamed_40.w * fragment_unnamed_51.w;
				precise float fragment_unnamed_76 = fragment_unnamed_57 * fragment_input_1.x;
				precise float fragment_unnamed_77 = fragment_unnamed_58 * fragment_input_1.y;
				precise float fragment_unnamed_78 = fragment_unnamed_59 * fragment_input_1.z;
				precise float fragment_unnamed_79 = fragment_unnamed_60 * fragment_input_1.w;
				fragment_output_0.x = fragment_unnamed_76;
				fragment_output_0.y = fragment_unnamed_77;
				fragment_output_0.z = fragment_unnamed_78;
				fragment_output_0.w = fragment_unnamed_79;
				discard_cond(mad(fragment_unnamed_60, fragment_input_1.w, -0.001000000047497451305389404296875f) < 0.0f);
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
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

			static float4 fragment_uniform_buffer_0[6];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _FaceTex;
			SamplerState sampler_MainTex;
			SamplerState sampler_FaceTex;

			static float4 fragment_input_1;
			static float2 fragment_input_2;
			static float2 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : COLOR; // COLOR
				float2 fragment_input_2 : TEXCOORD; // TEXCOORD
				float2 fragment_input_2 : TEXCOORD1; // TEXCOORD_1
				float4 fragment_input_3 : TEXCOORD2; // TEXCOORD_2
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				float4 fragment_unnamed_45 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_2.x, fragment_input_2.y));
				float4 fragment_unnamed_56 = _FaceTex.Sample(sampler_FaceTex, float2(fragment_input_2.x, fragment_input_2.y));
				precise float fragment_unnamed_62 = fragment_unnamed_45.x * fragment_unnamed_56.x;
				precise float fragment_unnamed_63 = fragment_unnamed_45.y * fragment_unnamed_56.y;
				precise float fragment_unnamed_64 = fragment_unnamed_45.z * fragment_unnamed_56.z;
				precise float fragment_unnamed_65 = fragment_unnamed_45.w * fragment_unnamed_56.w;
				precise float fragment_unnamed_76 = fragment_unnamed_62 * fragment_input_1.x;
				precise float fragment_unnamed_77 = fragment_unnamed_63 * fragment_input_1.y;
				precise float fragment_unnamed_78 = fragment_unnamed_64 * fragment_input_1.z;
				precise float fragment_unnamed_79 = fragment_unnamed_65 * fragment_input_1.w;
				precise float fragment_unnamed_85 = (-0.0f) - fragment_uniform_buffer_0[5u].x;
				precise float fragment_unnamed_88 = (-0.0f) - fragment_uniform_buffer_0[5u].y;
				precise float fragment_unnamed_93 = fragment_unnamed_85 + fragment_uniform_buffer_0[5u].z;
				precise float fragment_unnamed_94 = fragment_unnamed_88 + fragment_uniform_buffer_0[5u].w;
				precise float fragment_unnamed_99 = (-0.0f) - abs(fragment_input_3.x);
				precise float fragment_unnamed_103 = (-0.0f) - abs(fragment_input_3.y);
				precise float fragment_unnamed_104 = fragment_unnamed_93 + fragment_unnamed_99;
				precise float fragment_unnamed_105 = fragment_unnamed_94 + fragment_unnamed_103;
				precise float fragment_unnamed_110 = fragment_unnamed_104 * fragment_input_3.z;
				precise float fragment_unnamed_111 = fragment_unnamed_105 * fragment_input_3.w;
				precise float fragment_unnamed_115 = clamp(fragment_unnamed_111, 0.0f, 1.0f) * clamp(fragment_unnamed_110, 0.0f, 1.0f);
				precise float fragment_unnamed_116 = fragment_unnamed_76 * fragment_unnamed_115;
				precise float fragment_unnamed_117 = fragment_unnamed_77 * fragment_unnamed_115;
				precise float fragment_unnamed_118 = fragment_unnamed_78 * fragment_unnamed_115;
				precise float fragment_unnamed_119 = fragment_unnamed_79 * fragment_unnamed_115;
				fragment_output_0.x = fragment_unnamed_116;
				fragment_output_0.y = fragment_unnamed_117;
				fragment_output_0.z = fragment_unnamed_118;
				fragment_output_0.w = fragment_unnamed_119;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[5] = float4(_ClipRect[0], _ClipRect[1], _ClipRect[2], _ClipRect[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
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

			static float4 fragment_uniform_buffer_0[6];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _FaceTex;
			SamplerState sampler_MainTex;
			SamplerState sampler_FaceTex;

			static float4 fragment_input_1;
			static float2 fragment_input_2;
			static float2 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : COLOR; // COLOR
				float2 fragment_input_2 : TEXCOORD; // TEXCOORD
				float2 fragment_input_2 : TEXCOORD1; // TEXCOORD_1
				float4 fragment_input_3 : TEXCOORD2; // TEXCOORD_2
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static bool discard_state;

			void discard_cond(bool fragment_unnamed_134)
			{
				if (fragment_unnamed_134)
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
				float4 fragment_unnamed_45 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_2.x, fragment_input_2.y));
				float4 fragment_unnamed_56 = _FaceTex.Sample(sampler_FaceTex, float2(fragment_input_2.x, fragment_input_2.y));
				precise float fragment_unnamed_62 = fragment_unnamed_45.x * fragment_unnamed_56.x;
				precise float fragment_unnamed_63 = fragment_unnamed_45.y * fragment_unnamed_56.y;
				precise float fragment_unnamed_64 = fragment_unnamed_45.z * fragment_unnamed_56.z;
				precise float fragment_unnamed_65 = fragment_unnamed_45.w * fragment_unnamed_56.w;
				precise float fragment_unnamed_76 = fragment_unnamed_62 * fragment_input_1.x;
				precise float fragment_unnamed_77 = fragment_unnamed_63 * fragment_input_1.y;
				precise float fragment_unnamed_78 = fragment_unnamed_64 * fragment_input_1.z;
				precise float fragment_unnamed_79 = fragment_unnamed_65 * fragment_input_1.w;
				precise float fragment_unnamed_85 = (-0.0f) - fragment_uniform_buffer_0[5u].x;
				precise float fragment_unnamed_88 = (-0.0f) - fragment_uniform_buffer_0[5u].y;
				precise float fragment_unnamed_93 = fragment_unnamed_85 + fragment_uniform_buffer_0[5u].z;
				precise float fragment_unnamed_94 = fragment_unnamed_88 + fragment_uniform_buffer_0[5u].w;
				precise float fragment_unnamed_99 = (-0.0f) - abs(fragment_input_3.x);
				precise float fragment_unnamed_103 = (-0.0f) - abs(fragment_input_3.y);
				precise float fragment_unnamed_104 = fragment_unnamed_93 + fragment_unnamed_99;
				precise float fragment_unnamed_105 = fragment_unnamed_94 + fragment_unnamed_103;
				precise float fragment_unnamed_110 = fragment_unnamed_104 * fragment_input_3.z;
				precise float fragment_unnamed_111 = fragment_unnamed_105 * fragment_input_3.w;
				precise float fragment_unnamed_115 = clamp(fragment_unnamed_111, 0.0f, 1.0f) * clamp(fragment_unnamed_110, 0.0f, 1.0f);
				precise float fragment_unnamed_118 = fragment_unnamed_76 * fragment_unnamed_115;
				precise float fragment_unnamed_119 = fragment_unnamed_77 * fragment_unnamed_115;
				precise float fragment_unnamed_120 = fragment_unnamed_78 * fragment_unnamed_115;
				precise float fragment_unnamed_121 = fragment_unnamed_79 * fragment_unnamed_115;
				fragment_output_0.x = fragment_unnamed_118;
				fragment_output_0.y = fragment_unnamed_119;
				fragment_output_0.z = fragment_unnamed_120;
				fragment_output_0.w = fragment_unnamed_121;
				discard_cond(mad(fragment_unnamed_79, fragment_unnamed_115, -0.001000000047497451305389404296875f) < 0.0f);
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[5] = float4(_ClipRect[0], _ClipRect[1], _ClipRect[2], _ClipRect[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
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
	CustomEditor "TMPro.EditorUtilities.TMP_BitmapShaderGUI"
}
