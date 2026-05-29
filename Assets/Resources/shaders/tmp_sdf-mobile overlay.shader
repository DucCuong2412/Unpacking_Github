Shader "TextMeshPro/Mobile/Distance Field Overlay"
{
	Properties
	{
		_FaceColor ("Face Color", Color) = (1,1,1,1)
		_FaceDilate ("Face Dilate", Range(-1, 1)) = 0
		_OutlineColor ("Outline Color", Color) = (0,0,0,1)
		_OutlineWidth ("Outline Thickness", Range(0, 1)) = 0
		_OutlineSoftness ("Outline Softness", Range(0, 1)) = 0
		_UnderlayColor ("Border Color", Color) = (0,0,0,0.5)
		_UnderlayOffsetX ("Border OffsetX", Range(-1, 1)) = 0
		_UnderlayOffsetY ("Border OffsetY", Range(-1, 1)) = 0
		_UnderlayDilate ("Border Dilate", Range(-1, 1)) = 0
		_UnderlaySoftness ("Border Softness", Range(0, 1)) = 0
		_WeightNormal ("Weight Normal", Float) = 0
		_WeightBold ("Weight Bold", Float) = 0.5
		_ShaderFlags ("Flags", Float) = 0
		_ScaleRatioA ("Scale RatioA", Float) = 1
		_ScaleRatioB ("Scale RatioB", Float) = 1
		_ScaleRatioC ("Scale RatioC", Float) = 1
		_MainTex ("Font Atlas", 2D) = "white" {}
		_TextureWidth ("Texture Width", Float) = 512
		_TextureHeight ("Texture Height", Float) = 512
		_GradientScale ("Gradient Scale", Float) = 5
		_ScaleX ("Scale X", Float) = 1
		_ScaleY ("Scale Y", Float) = 1
		_PerspectiveFilter ("Perspective Correction", Range(0, 1)) = 0.875
		_Sharpness ("Sharpness", Range(-1, 1)) = 0
		_VertexOffsetX ("Vertex OffsetX", Float) = 0
		_VertexOffsetY ("Vertex OffsetY", Float) = 0
		_ClipRect ("Clip Rect", Vector) = (-32767,-32767,32767,32767)
		_MaskSoftnessX ("Mask SoftnessX", Float) = 0
		_MaskSoftnessY ("Mask SoftnessY", Float) = 0
		_StencilComp ("Stencil Comparison", Float) = 8
		_Stencil ("Stencil ID", Float) = 0
		_StencilOp ("Stencil Operation", Float) = 0
		_StencilWriteMask ("Stencil Write Mask", Float) = 255
		_StencilReadMask ("Stencil Read Mask", Float) = 255
		_ColorMask ("Color Mask", Float) = 15
	}
	SubShader
	{
		Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Overlay" "RenderType" = "Transparent" }
		Pass
		{
			Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Overlay" "RenderType" = "Transparent" }
			Blend One OneMinusSrcAlpha, One OneMinusSrcAlpha
			ColorMask 0
			ZTest Always
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
			GpuProgramID 6614

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

			float4 _FaceColor;
			float _FaceDilate;
			float _OutlineSoftness;
			float4 _OutlineColor;
			float _OutlineWidth;
			float _WeightNormal;
			float _WeightBold;
			float _ScaleRatioA;
			float _VertexOffsetX;
			float _VertexOffsetY;
			float4 _ClipRect;
			float _MaskSoftnessX;
			float _MaskSoftnessY;
			float _GradientScale;
			float _ScaleX;
			float _ScaleY;
			float _PerspectiveFilter;
			float _Sharpness;
			float3 _WorldSpaceCameraPos;
			float4 _ScreenParams;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4x4 glstate_matrix_projection;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[30];
			static float4 vertex_uniform_buffer_1[7];
			static float4 vertex_uniform_buffer_2[8];
			static float4 vertex_uniform_buffer_3[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float3 vertex_input_1;
			static float4 vertex_input_2;
			static float2 vertex_input_3;
			static float2 vertex_input_4;
			static float4 vertex_output_1;
			static float4 vertex_output_2;
			static float4 vertex_output_3;
			static float4 vertex_output_4;
			static float4 vertex_output_5;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : COLOR; // COLOR
				float2 vertex_input_3 : TEXCOORD0; // TEXCOORD
				float2 vertex_input_4 : TEXCOORD1; // TEXCOORD_1
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : COLOR; // COLOR
				float4 vertex_output_2 : COLOR1; // COLOR_1
				float4 vertex_output_3 : TEXCOORD; // TEXCOORD
				float4 vertex_output_4 : TEXCOORD1; // TEXCOORD_1
				float4 vertex_output_5 : TEXCOORD2; // TEXCOORD_2
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_57 = vertex_input_0.x + vertex_uniform_buffer_0[23u].z;
				precise float vertex_unnamed_58 = vertex_input_0.y + vertex_uniform_buffer_0[23u].w;
				precise float vertex_unnamed_65 = vertex_unnamed_58 * vertex_uniform_buffer_2[1u].x;
				precise float vertex_unnamed_66 = vertex_unnamed_58 * vertex_uniform_buffer_2[1u].y;
				precise float vertex_unnamed_67 = vertex_unnamed_58 * vertex_uniform_buffer_2[1u].z;
				precise float vertex_unnamed_68 = vertex_unnamed_58 * vertex_uniform_buffer_2[1u].w;
				float vertex_unnamed_89 = mad(vertex_uniform_buffer_2[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].x, vertex_unnamed_57, vertex_unnamed_65));
				float vertex_unnamed_90 = mad(vertex_uniform_buffer_2[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].y, vertex_unnamed_57, vertex_unnamed_66));
				float vertex_unnamed_91 = mad(vertex_uniform_buffer_2[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].z, vertex_unnamed_57, vertex_unnamed_67));
				precise float vertex_unnamed_100 = vertex_unnamed_89 + vertex_uniform_buffer_2[3u].x;
				precise float vertex_unnamed_101 = vertex_unnamed_90 + vertex_uniform_buffer_2[3u].y;
				precise float vertex_unnamed_102 = vertex_unnamed_91 + vertex_uniform_buffer_2[3u].z;
				precise float vertex_unnamed_103 = mad(vertex_uniform_buffer_2[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].w, vertex_unnamed_57, vertex_unnamed_68)) + vertex_uniform_buffer_2[3u].w;
				precise float vertex_unnamed_114 = (-0.0f) - mad(vertex_uniform_buffer_2[3u].x, vertex_input_0.w, vertex_unnamed_89);
				precise float vertex_unnamed_116 = (-0.0f) - mad(vertex_uniform_buffer_2[3u].y, vertex_input_0.w, vertex_unnamed_90);
				precise float vertex_unnamed_117 = (-0.0f) - mad(vertex_uniform_buffer_2[3u].z, vertex_input_0.w, vertex_unnamed_91);
				precise float vertex_unnamed_124 = vertex_unnamed_114 + vertex_uniform_buffer_1[4u].x;
				precise float vertex_unnamed_125 = vertex_unnamed_116 + vertex_uniform_buffer_1[4u].y;
				precise float vertex_unnamed_126 = vertex_unnamed_117 + vertex_uniform_buffer_1[4u].z;
				precise float vertex_unnamed_134 = vertex_unnamed_101 * vertex_uniform_buffer_3[18u].x;
				precise float vertex_unnamed_135 = vertex_unnamed_101 * vertex_uniform_buffer_3[18u].y;
				precise float vertex_unnamed_136 = vertex_unnamed_101 * vertex_uniform_buffer_3[18u].z;
				precise float vertex_unnamed_137 = vertex_unnamed_101 * vertex_uniform_buffer_3[18u].w;
				float vertex_unnamed_170 = mad(vertex_uniform_buffer_3[20u].w, vertex_unnamed_103, mad(vertex_uniform_buffer_3[19u].w, vertex_unnamed_102, mad(vertex_uniform_buffer_3[17u].w, vertex_unnamed_100, vertex_unnamed_137)));
				gl_Position.x = mad(vertex_uniform_buffer_3[20u].x, vertex_unnamed_103, mad(vertex_uniform_buffer_3[19u].x, vertex_unnamed_102, mad(vertex_uniform_buffer_3[17u].x, vertex_unnamed_100, vertex_unnamed_134)));
				gl_Position.y = mad(vertex_uniform_buffer_3[20u].y, vertex_unnamed_103, mad(vertex_uniform_buffer_3[19u].y, vertex_unnamed_102, mad(vertex_uniform_buffer_3[17u].y, vertex_unnamed_100, vertex_unnamed_135)));
				gl_Position.z = mad(vertex_uniform_buffer_3[20u].z, vertex_unnamed_103, mad(vertex_uniform_buffer_3[19u].z, vertex_unnamed_102, mad(vertex_uniform_buffer_3[17u].z, vertex_unnamed_100, vertex_unnamed_136)));
				gl_Position.w = vertex_unnamed_170;
				precise float vertex_unnamed_190 = vertex_input_2.x * vertex_uniform_buffer_0[3u].x;
				precise float vertex_unnamed_191 = vertex_input_2.y * vertex_uniform_buffer_0[3u].y;
				precise float vertex_unnamed_192 = vertex_input_2.z * vertex_uniform_buffer_0[3u].z;
				precise float vertex_unnamed_193 = vertex_input_2.w * vertex_uniform_buffer_0[3u].w;
				precise float vertex_unnamed_194 = vertex_unnamed_193 * vertex_unnamed_190;
				precise float vertex_unnamed_195 = vertex_unnamed_193 * vertex_unnamed_191;
				precise float vertex_unnamed_196 = vertex_unnamed_193 * vertex_unnamed_192;
				vertex_output_1.x = vertex_unnamed_194;
				vertex_output_1.y = vertex_unnamed_195;
				vertex_output_1.z = vertex_unnamed_196;
				vertex_output_1.w = vertex_unnamed_193;
				precise float vertex_unnamed_207 = vertex_input_2.w * vertex_uniform_buffer_0[5u].w;
				precise float vertex_unnamed_213 = vertex_unnamed_207 * vertex_uniform_buffer_0[5u].x;
				precise float vertex_unnamed_214 = vertex_unnamed_207 * vertex_uniform_buffer_0[5u].y;
				precise float vertex_unnamed_215 = vertex_unnamed_207 * vertex_uniform_buffer_0[5u].z;
				precise float vertex_unnamed_216 = (-0.0f) - vertex_unnamed_194;
				precise float vertex_unnamed_217 = (-0.0f) - vertex_unnamed_195;
				precise float vertex_unnamed_218 = (-0.0f) - vertex_unnamed_196;
				precise float vertex_unnamed_219 = (-0.0f) - vertex_unnamed_193;
				precise float vertex_unnamed_220 = vertex_unnamed_216 + vertex_unnamed_213;
				precise float vertex_unnamed_221 = vertex_unnamed_217 + vertex_unnamed_214;
				precise float vertex_unnamed_222 = vertex_unnamed_218 + vertex_unnamed_215;
				precise float vertex_unnamed_223 = vertex_unnamed_219 + vertex_unnamed_207;
				float vertex_unnamed_227 = rsqrt(dot(float3(vertex_unnamed_124, vertex_unnamed_125, vertex_unnamed_126), float3(vertex_unnamed_124, vertex_unnamed_125, vertex_unnamed_126)));
				precise float vertex_unnamed_228 = vertex_unnamed_227 * vertex_unnamed_124;
				precise float vertex_unnamed_229 = vertex_unnamed_227 * vertex_unnamed_125;
				precise float vertex_unnamed_230 = vertex_unnamed_227 * vertex_unnamed_126;
				float vertex_unnamed_242 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_2[4u].xyz));
				float vertex_unnamed_256 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_2[5u].xyz));
				float vertex_unnamed_271 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_2[6u].xyz));
				float vertex_unnamed_277 = rsqrt(dot(float3(vertex_unnamed_242, vertex_unnamed_256, vertex_unnamed_271), float3(vertex_unnamed_242, vertex_unnamed_256, vertex_unnamed_271)));
				precise float vertex_unnamed_278 = vertex_unnamed_277 * vertex_unnamed_242;
				precise float vertex_unnamed_279 = vertex_unnamed_277 * vertex_unnamed_256;
				precise float vertex_unnamed_280 = vertex_unnamed_277 * vertex_unnamed_271;
				precise float vertex_unnamed_291 = vertex_uniform_buffer_1[6u].y * vertex_uniform_buffer_3[6u].x;
				precise float vertex_unnamed_292 = vertex_uniform_buffer_1[6u].y * vertex_uniform_buffer_3[6u].y;
				precise float vertex_unnamed_309 = abs(mad(vertex_uniform_buffer_3[5u].x, vertex_uniform_buffer_1[6u].x, vertex_unnamed_291)) * vertex_uniform_buffer_0[28u].y;
				precise float vertex_unnamed_310 = abs(mad(vertex_uniform_buffer_3[5u].y, vertex_uniform_buffer_1[6u].x, vertex_unnamed_292)) * vertex_uniform_buffer_0[28u].z;
				precise float vertex_unnamed_311 = vertex_unnamed_170 / vertex_unnamed_309;
				precise float vertex_unnamed_312 = vertex_unnamed_170 / vertex_unnamed_310;
				precise float vertex_unnamed_324 = 0.25f / mad(vertex_uniform_buffer_0[27u].x, 0.25f, vertex_unnamed_311);
				precise float vertex_unnamed_325 = 0.25f / mad(vertex_uniform_buffer_0[27u].y, 0.25f, vertex_unnamed_312);
				vertex_output_5.z = vertex_unnamed_324;
				vertex_output_5.w = vertex_unnamed_325;
				float vertex_unnamed_328 = rsqrt(dot(float2(vertex_unnamed_311, vertex_unnamed_312), float2(vertex_unnamed_311, vertex_unnamed_312)));
				precise float vertex_unnamed_335 = abs(vertex_input_4.y) * vertex_uniform_buffer_0[28u].x;
				precise float vertex_unnamed_340 = vertex_uniform_buffer_0[29u].x + 1.0f;
				precise float vertex_unnamed_342 = vertex_unnamed_340 * vertex_unnamed_335;
				precise float vertex_unnamed_343 = vertex_unnamed_328 * vertex_unnamed_342;
				precise float vertex_unnamed_347 = (-0.0f) - vertex_uniform_buffer_0[28u].w;
				precise float vertex_unnamed_348 = vertex_unnamed_347 + 1.0f;
				precise float vertex_unnamed_350 = vertex_unnamed_348 * abs(vertex_unnamed_343);
				precise float vertex_unnamed_351 = (-0.0f) - vertex_unnamed_350;
				float vertex_unnamed_365 = asfloat((vertex_uniform_buffer_3[8u].w == 0.0f) ? asuint(mad(abs(dot(float3(vertex_unnamed_278, vertex_unnamed_279, vertex_unnamed_280), float3(vertex_unnamed_228, vertex_unnamed_229, vertex_unnamed_230))), mad(vertex_unnamed_328, vertex_unnamed_342, vertex_unnamed_351), vertex_unnamed_350)) : asuint(vertex_unnamed_343));
				precise float vertex_unnamed_373 = vertex_uniform_buffer_0[4u].y * vertex_uniform_buffer_0[22u].w;
				precise float vertex_unnamed_375 = vertex_unnamed_365 / mad(vertex_unnamed_373, vertex_unnamed_365, 1.0f);
				precise float vertex_unnamed_382 = vertex_uniform_buffer_0[6u].x * vertex_uniform_buffer_0[22u].w;
				precise float vertex_unnamed_383 = vertex_unnamed_382 * 0.5f;
				precise float vertex_unnamed_385 = vertex_unnamed_375 * vertex_unnamed_383;
				precise float vertex_unnamed_386 = vertex_unnamed_385 + vertex_unnamed_385;
				float vertex_unnamed_388 = sqrt(min(vertex_unnamed_386, 1.0f));
				vertex_output_2.x = mad(vertex_unnamed_388, vertex_unnamed_220, vertex_unnamed_194);
				vertex_output_2.y = mad(vertex_unnamed_388, vertex_unnamed_221, vertex_unnamed_195);
				vertex_output_2.z = mad(vertex_unnamed_388, vertex_unnamed_222, vertex_unnamed_196);
				vertex_output_2.w = mad(vertex_unnamed_388, vertex_unnamed_223, vertex_unnamed_193);
				float vertex_unnamed_409 = min(max(vertex_uniform_buffer_0[26u].x, -20000000000.0f), 20000000000.0f);
				float vertex_unnamed_411 = min(max(vertex_uniform_buffer_0[26u].y, -20000000000.0f), 20000000000.0f);
				float vertex_unnamed_412 = min(max(vertex_uniform_buffer_0[26u].z, -20000000000.0f), 20000000000.0f);
				float vertex_unnamed_413 = min(max(vertex_uniform_buffer_0[26u].w, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_414 = (-0.0f) - vertex_unnamed_409;
				precise float vertex_unnamed_415 = (-0.0f) - vertex_unnamed_411;
				precise float vertex_unnamed_416 = vertex_unnamed_57 + vertex_unnamed_414;
				precise float vertex_unnamed_417 = vertex_unnamed_58 + vertex_unnamed_415;
				precise float vertex_unnamed_418 = (-0.0f) - vertex_unnamed_409;
				precise float vertex_unnamed_419 = (-0.0f) - vertex_unnamed_411;
				precise float vertex_unnamed_423 = (-0.0f) - vertex_unnamed_412;
				precise float vertex_unnamed_424 = (-0.0f) - vertex_unnamed_413;
				precise float vertex_unnamed_425 = vertex_unnamed_423 + mad(vertex_unnamed_57, 2.0f, vertex_unnamed_418);
				precise float vertex_unnamed_426 = vertex_unnamed_424 + mad(vertex_unnamed_58, 2.0f, vertex_unnamed_419);
				vertex_output_5.x = vertex_unnamed_425;
				vertex_output_5.y = vertex_unnamed_426;
				precise float vertex_unnamed_429 = (-0.0f) - vertex_unnamed_409;
				precise float vertex_unnamed_430 = (-0.0f) - vertex_unnamed_411;
				precise float vertex_unnamed_431 = vertex_unnamed_429 + vertex_unnamed_412;
				precise float vertex_unnamed_432 = vertex_unnamed_430 + vertex_unnamed_413;
				precise float vertex_unnamed_433 = vertex_unnamed_416 / vertex_unnamed_431;
				precise float vertex_unnamed_434 = vertex_unnamed_417 / vertex_unnamed_432;
				vertex_output_3.z = vertex_unnamed_433;
				vertex_output_3.w = vertex_unnamed_434;
				vertex_output_3.x = vertex_input_3.x;
				vertex_output_3.y = vertex_input_3.y;
				precise float vertex_unnamed_454 = (-0.0f) - vertex_uniform_buffer_0[22u].y;
				precise float vertex_unnamed_458 = vertex_unnamed_454 + vertex_uniform_buffer_0[22u].z;
				precise float vertex_unnamed_470 = mad(mad(asfloat(((0.0f >= vertex_input_4.y) ? 4294967295u : 0u) & 1065353216u), vertex_unnamed_458, vertex_uniform_buffer_0[22u].y), 0.25f, vertex_uniform_buffer_0[4u].x) * vertex_uniform_buffer_0[22u].w;
				precise float vertex_unnamed_471 = (-0.0f) - vertex_unnamed_470;
				float vertex_unnamed_473 = mad(mad(vertex_unnamed_471, 0.5f, 0.5f), vertex_unnamed_375, -0.5f);
				precise float vertex_unnamed_475 = (-0.0f) - vertex_unnamed_383;
				vertex_output_4.y = mad(vertex_unnamed_475, vertex_unnamed_375, vertex_unnamed_473);
				vertex_output_4.z = mad(vertex_unnamed_383, vertex_unnamed_375, vertex_unnamed_473);
				vertex_output_4.x = vertex_unnamed_375;
				vertex_output_4.w = vertex_unnamed_473;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[3] = float4(_FaceColor[0], _FaceColor[1], _FaceColor[2], _FaceColor[3]);

				vertex_uniform_buffer_0[4] = float4(_FaceDilate, vertex_uniform_buffer_0[4][1], vertex_uniform_buffer_0[4][2], vertex_uniform_buffer_0[4][3]);

				vertex_uniform_buffer_0[4] = float4(vertex_uniform_buffer_0[4][0], _OutlineSoftness, vertex_uniform_buffer_0[4][2], vertex_uniform_buffer_0[4][3]);

				vertex_uniform_buffer_0[5] = float4(_OutlineColor[0], _OutlineColor[1], _OutlineColor[2], _OutlineColor[3]);

				vertex_uniform_buffer_0[6] = float4(_OutlineWidth, vertex_uniform_buffer_0[6][1], vertex_uniform_buffer_0[6][2], vertex_uniform_buffer_0[6][3]);

				vertex_uniform_buffer_0[22] = float4(vertex_uniform_buffer_0[22][0], _WeightNormal, vertex_uniform_buffer_0[22][2], vertex_uniform_buffer_0[22][3]);

				vertex_uniform_buffer_0[22] = float4(vertex_uniform_buffer_0[22][0], vertex_uniform_buffer_0[22][1], _WeightBold, vertex_uniform_buffer_0[22][3]);

				vertex_uniform_buffer_0[22] = float4(vertex_uniform_buffer_0[22][0], vertex_uniform_buffer_0[22][1], vertex_uniform_buffer_0[22][2], _ScaleRatioA);

				vertex_uniform_buffer_0[23] = float4(vertex_uniform_buffer_0[23][0], vertex_uniform_buffer_0[23][1], _VertexOffsetX, vertex_uniform_buffer_0[23][3]);

				vertex_uniform_buffer_0[23] = float4(vertex_uniform_buffer_0[23][0], vertex_uniform_buffer_0[23][1], vertex_uniform_buffer_0[23][2], _VertexOffsetY);

				vertex_uniform_buffer_0[26] = float4(_ClipRect[0], _ClipRect[1], _ClipRect[2], _ClipRect[3]);

				vertex_uniform_buffer_0[27] = float4(_MaskSoftnessX, vertex_uniform_buffer_0[27][1], vertex_uniform_buffer_0[27][2], vertex_uniform_buffer_0[27][3]);

				vertex_uniform_buffer_0[27] = float4(vertex_uniform_buffer_0[27][0], _MaskSoftnessY, vertex_uniform_buffer_0[27][2], vertex_uniform_buffer_0[27][3]);

				vertex_uniform_buffer_0[28] = float4(_GradientScale, vertex_uniform_buffer_0[28][1], vertex_uniform_buffer_0[28][2], vertex_uniform_buffer_0[28][3]);

				vertex_uniform_buffer_0[28] = float4(vertex_uniform_buffer_0[28][0], _ScaleX, vertex_uniform_buffer_0[28][2], vertex_uniform_buffer_0[28][3]);

				vertex_uniform_buffer_0[28] = float4(vertex_uniform_buffer_0[28][0], vertex_uniform_buffer_0[28][1], _ScaleY, vertex_uniform_buffer_0[28][3]);

				vertex_uniform_buffer_0[28] = float4(vertex_uniform_buffer_0[28][0], vertex_uniform_buffer_0[28][1], vertex_uniform_buffer_0[28][2], _PerspectiveFilter);

				vertex_uniform_buffer_0[29] = float4(_Sharpness, vertex_uniform_buffer_0[29][1], vertex_uniform_buffer_0[29][2], vertex_uniform_buffer_0[29][3]);

				vertex_uniform_buffer_1[4] = float4(_WorldSpaceCameraPos[0], _WorldSpaceCameraPos[1], _WorldSpaceCameraPos[2], vertex_uniform_buffer_1[4][3]);

				vertex_uniform_buffer_1[6] = float4(_ScreenParams[0], _ScreenParams[1], _ScreenParams[2], _ScreenParams[3]);

				vertex_uniform_buffer_2[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_2[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_2[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_2[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_2[4] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				vertex_uniform_buffer_2[5] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				vertex_uniform_buffer_2[6] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				vertex_uniform_buffer_2[7] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

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
				vertex_input_4 = stage_input.vertex_input_4;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
				return stage_output;
			}

			#endif // !UNITY_UI_ALPHACLIP
			#endif // !UNITY_UI_CLIP_RECT


			#ifdef UNITY_UI_ALPHACLIP
			#ifndef UNITY_UI_CLIP_RECT
			#define ANY_SHADER_VARIANT_ACTIVE

			float4 _FaceColor;
			float _FaceDilate;
			float _OutlineSoftness;
			float4 _OutlineColor;
			float _OutlineWidth;
			float _WeightNormal;
			float _WeightBold;
			float _ScaleRatioA;
			float _VertexOffsetX;
			float _VertexOffsetY;
			float4 _ClipRect;
			float _MaskSoftnessX;
			float _MaskSoftnessY;
			float _GradientScale;
			float _ScaleX;
			float _ScaleY;
			float _PerspectiveFilter;
			float _Sharpness;
			float3 _WorldSpaceCameraPos;
			float4 _ScreenParams;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4x4 glstate_matrix_projection;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[30];
			static float4 vertex_uniform_buffer_1[7];
			static float4 vertex_uniform_buffer_2[8];
			static float4 vertex_uniform_buffer_3[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float3 vertex_input_1;
			static float4 vertex_input_2;
			static float2 vertex_input_3;
			static float2 vertex_input_4;
			static float4 vertex_output_1;
			static float4 vertex_output_2;
			static float4 vertex_output_3;
			static float4 vertex_output_4;
			static float4 vertex_output_5;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : COLOR; // COLOR
				float2 vertex_input_3 : TEXCOORD0; // TEXCOORD
				float2 vertex_input_4 : TEXCOORD1; // TEXCOORD_1
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : COLOR; // COLOR
				float4 vertex_output_2 : COLOR1; // COLOR_1
				float4 vertex_output_3 : TEXCOORD; // TEXCOORD
				float4 vertex_output_4 : TEXCOORD1; // TEXCOORD_1
				float4 vertex_output_5 : TEXCOORD2; // TEXCOORD_2
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_57 = vertex_input_0.x + vertex_uniform_buffer_0[23u].z;
				precise float vertex_unnamed_58 = vertex_input_0.y + vertex_uniform_buffer_0[23u].w;
				precise float vertex_unnamed_65 = vertex_unnamed_58 * vertex_uniform_buffer_2[1u].x;
				precise float vertex_unnamed_66 = vertex_unnamed_58 * vertex_uniform_buffer_2[1u].y;
				precise float vertex_unnamed_67 = vertex_unnamed_58 * vertex_uniform_buffer_2[1u].z;
				precise float vertex_unnamed_68 = vertex_unnamed_58 * vertex_uniform_buffer_2[1u].w;
				float vertex_unnamed_89 = mad(vertex_uniform_buffer_2[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].x, vertex_unnamed_57, vertex_unnamed_65));
				float vertex_unnamed_90 = mad(vertex_uniform_buffer_2[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].y, vertex_unnamed_57, vertex_unnamed_66));
				float vertex_unnamed_91 = mad(vertex_uniform_buffer_2[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].z, vertex_unnamed_57, vertex_unnamed_67));
				precise float vertex_unnamed_100 = vertex_unnamed_89 + vertex_uniform_buffer_2[3u].x;
				precise float vertex_unnamed_101 = vertex_unnamed_90 + vertex_uniform_buffer_2[3u].y;
				precise float vertex_unnamed_102 = vertex_unnamed_91 + vertex_uniform_buffer_2[3u].z;
				precise float vertex_unnamed_103 = mad(vertex_uniform_buffer_2[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].w, vertex_unnamed_57, vertex_unnamed_68)) + vertex_uniform_buffer_2[3u].w;
				precise float vertex_unnamed_114 = (-0.0f) - mad(vertex_uniform_buffer_2[3u].x, vertex_input_0.w, vertex_unnamed_89);
				precise float vertex_unnamed_116 = (-0.0f) - mad(vertex_uniform_buffer_2[3u].y, vertex_input_0.w, vertex_unnamed_90);
				precise float vertex_unnamed_117 = (-0.0f) - mad(vertex_uniform_buffer_2[3u].z, vertex_input_0.w, vertex_unnamed_91);
				precise float vertex_unnamed_124 = vertex_unnamed_114 + vertex_uniform_buffer_1[4u].x;
				precise float vertex_unnamed_125 = vertex_unnamed_116 + vertex_uniform_buffer_1[4u].y;
				precise float vertex_unnamed_126 = vertex_unnamed_117 + vertex_uniform_buffer_1[4u].z;
				precise float vertex_unnamed_134 = vertex_unnamed_101 * vertex_uniform_buffer_3[18u].x;
				precise float vertex_unnamed_135 = vertex_unnamed_101 * vertex_uniform_buffer_3[18u].y;
				precise float vertex_unnamed_136 = vertex_unnamed_101 * vertex_uniform_buffer_3[18u].z;
				precise float vertex_unnamed_137 = vertex_unnamed_101 * vertex_uniform_buffer_3[18u].w;
				float vertex_unnamed_170 = mad(vertex_uniform_buffer_3[20u].w, vertex_unnamed_103, mad(vertex_uniform_buffer_3[19u].w, vertex_unnamed_102, mad(vertex_uniform_buffer_3[17u].w, vertex_unnamed_100, vertex_unnamed_137)));
				gl_Position.x = mad(vertex_uniform_buffer_3[20u].x, vertex_unnamed_103, mad(vertex_uniform_buffer_3[19u].x, vertex_unnamed_102, mad(vertex_uniform_buffer_3[17u].x, vertex_unnamed_100, vertex_unnamed_134)));
				gl_Position.y = mad(vertex_uniform_buffer_3[20u].y, vertex_unnamed_103, mad(vertex_uniform_buffer_3[19u].y, vertex_unnamed_102, mad(vertex_uniform_buffer_3[17u].y, vertex_unnamed_100, vertex_unnamed_135)));
				gl_Position.z = mad(vertex_uniform_buffer_3[20u].z, vertex_unnamed_103, mad(vertex_uniform_buffer_3[19u].z, vertex_unnamed_102, mad(vertex_uniform_buffer_3[17u].z, vertex_unnamed_100, vertex_unnamed_136)));
				gl_Position.w = vertex_unnamed_170;
				precise float vertex_unnamed_190 = vertex_input_2.x * vertex_uniform_buffer_0[3u].x;
				precise float vertex_unnamed_191 = vertex_input_2.y * vertex_uniform_buffer_0[3u].y;
				precise float vertex_unnamed_192 = vertex_input_2.z * vertex_uniform_buffer_0[3u].z;
				precise float vertex_unnamed_193 = vertex_input_2.w * vertex_uniform_buffer_0[3u].w;
				precise float vertex_unnamed_194 = vertex_unnamed_193 * vertex_unnamed_190;
				precise float vertex_unnamed_195 = vertex_unnamed_193 * vertex_unnamed_191;
				precise float vertex_unnamed_196 = vertex_unnamed_193 * vertex_unnamed_192;
				vertex_output_1.x = vertex_unnamed_194;
				vertex_output_1.y = vertex_unnamed_195;
				vertex_output_1.z = vertex_unnamed_196;
				vertex_output_1.w = vertex_unnamed_193;
				precise float vertex_unnamed_207 = vertex_input_2.w * vertex_uniform_buffer_0[5u].w;
				precise float vertex_unnamed_213 = vertex_unnamed_207 * vertex_uniform_buffer_0[5u].x;
				precise float vertex_unnamed_214 = vertex_unnamed_207 * vertex_uniform_buffer_0[5u].y;
				precise float vertex_unnamed_215 = vertex_unnamed_207 * vertex_uniform_buffer_0[5u].z;
				precise float vertex_unnamed_216 = (-0.0f) - vertex_unnamed_194;
				precise float vertex_unnamed_217 = (-0.0f) - vertex_unnamed_195;
				precise float vertex_unnamed_218 = (-0.0f) - vertex_unnamed_196;
				precise float vertex_unnamed_219 = (-0.0f) - vertex_unnamed_193;
				precise float vertex_unnamed_220 = vertex_unnamed_216 + vertex_unnamed_213;
				precise float vertex_unnamed_221 = vertex_unnamed_217 + vertex_unnamed_214;
				precise float vertex_unnamed_222 = vertex_unnamed_218 + vertex_unnamed_215;
				precise float vertex_unnamed_223 = vertex_unnamed_219 + vertex_unnamed_207;
				float vertex_unnamed_227 = rsqrt(dot(float3(vertex_unnamed_124, vertex_unnamed_125, vertex_unnamed_126), float3(vertex_unnamed_124, vertex_unnamed_125, vertex_unnamed_126)));
				precise float vertex_unnamed_228 = vertex_unnamed_227 * vertex_unnamed_124;
				precise float vertex_unnamed_229 = vertex_unnamed_227 * vertex_unnamed_125;
				precise float vertex_unnamed_230 = vertex_unnamed_227 * vertex_unnamed_126;
				float vertex_unnamed_242 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_2[4u].xyz));
				float vertex_unnamed_256 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_2[5u].xyz));
				float vertex_unnamed_271 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_2[6u].xyz));
				float vertex_unnamed_277 = rsqrt(dot(float3(vertex_unnamed_242, vertex_unnamed_256, vertex_unnamed_271), float3(vertex_unnamed_242, vertex_unnamed_256, vertex_unnamed_271)));
				precise float vertex_unnamed_278 = vertex_unnamed_277 * vertex_unnamed_242;
				precise float vertex_unnamed_279 = vertex_unnamed_277 * vertex_unnamed_256;
				precise float vertex_unnamed_280 = vertex_unnamed_277 * vertex_unnamed_271;
				precise float vertex_unnamed_291 = vertex_uniform_buffer_1[6u].y * vertex_uniform_buffer_3[6u].x;
				precise float vertex_unnamed_292 = vertex_uniform_buffer_1[6u].y * vertex_uniform_buffer_3[6u].y;
				precise float vertex_unnamed_309 = abs(mad(vertex_uniform_buffer_3[5u].x, vertex_uniform_buffer_1[6u].x, vertex_unnamed_291)) * vertex_uniform_buffer_0[28u].y;
				precise float vertex_unnamed_310 = abs(mad(vertex_uniform_buffer_3[5u].y, vertex_uniform_buffer_1[6u].x, vertex_unnamed_292)) * vertex_uniform_buffer_0[28u].z;
				precise float vertex_unnamed_311 = vertex_unnamed_170 / vertex_unnamed_309;
				precise float vertex_unnamed_312 = vertex_unnamed_170 / vertex_unnamed_310;
				precise float vertex_unnamed_324 = 0.25f / mad(vertex_uniform_buffer_0[27u].x, 0.25f, vertex_unnamed_311);
				precise float vertex_unnamed_325 = 0.25f / mad(vertex_uniform_buffer_0[27u].y, 0.25f, vertex_unnamed_312);
				vertex_output_5.z = vertex_unnamed_324;
				vertex_output_5.w = vertex_unnamed_325;
				float vertex_unnamed_328 = rsqrt(dot(float2(vertex_unnamed_311, vertex_unnamed_312), float2(vertex_unnamed_311, vertex_unnamed_312)));
				precise float vertex_unnamed_335 = abs(vertex_input_4.y) * vertex_uniform_buffer_0[28u].x;
				precise float vertex_unnamed_340 = vertex_uniform_buffer_0[29u].x + 1.0f;
				precise float vertex_unnamed_342 = vertex_unnamed_340 * vertex_unnamed_335;
				precise float vertex_unnamed_343 = vertex_unnamed_328 * vertex_unnamed_342;
				precise float vertex_unnamed_347 = (-0.0f) - vertex_uniform_buffer_0[28u].w;
				precise float vertex_unnamed_348 = vertex_unnamed_347 + 1.0f;
				precise float vertex_unnamed_350 = vertex_unnamed_348 * abs(vertex_unnamed_343);
				precise float vertex_unnamed_351 = (-0.0f) - vertex_unnamed_350;
				float vertex_unnamed_365 = asfloat((vertex_uniform_buffer_3[8u].w == 0.0f) ? asuint(mad(abs(dot(float3(vertex_unnamed_278, vertex_unnamed_279, vertex_unnamed_280), float3(vertex_unnamed_228, vertex_unnamed_229, vertex_unnamed_230))), mad(vertex_unnamed_328, vertex_unnamed_342, vertex_unnamed_351), vertex_unnamed_350)) : asuint(vertex_unnamed_343));
				precise float vertex_unnamed_373 = vertex_uniform_buffer_0[4u].y * vertex_uniform_buffer_0[22u].w;
				precise float vertex_unnamed_375 = vertex_unnamed_365 / mad(vertex_unnamed_373, vertex_unnamed_365, 1.0f);
				precise float vertex_unnamed_382 = vertex_uniform_buffer_0[6u].x * vertex_uniform_buffer_0[22u].w;
				precise float vertex_unnamed_383 = vertex_unnamed_382 * 0.5f;
				precise float vertex_unnamed_385 = vertex_unnamed_375 * vertex_unnamed_383;
				precise float vertex_unnamed_386 = vertex_unnamed_385 + vertex_unnamed_385;
				float vertex_unnamed_388 = sqrt(min(vertex_unnamed_386, 1.0f));
				vertex_output_2.x = mad(vertex_unnamed_388, vertex_unnamed_220, vertex_unnamed_194);
				vertex_output_2.y = mad(vertex_unnamed_388, vertex_unnamed_221, vertex_unnamed_195);
				vertex_output_2.z = mad(vertex_unnamed_388, vertex_unnamed_222, vertex_unnamed_196);
				vertex_output_2.w = mad(vertex_unnamed_388, vertex_unnamed_223, vertex_unnamed_193);
				float vertex_unnamed_409 = min(max(vertex_uniform_buffer_0[26u].x, -20000000000.0f), 20000000000.0f);
				float vertex_unnamed_411 = min(max(vertex_uniform_buffer_0[26u].y, -20000000000.0f), 20000000000.0f);
				float vertex_unnamed_412 = min(max(vertex_uniform_buffer_0[26u].z, -20000000000.0f), 20000000000.0f);
				float vertex_unnamed_413 = min(max(vertex_uniform_buffer_0[26u].w, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_414 = (-0.0f) - vertex_unnamed_409;
				precise float vertex_unnamed_415 = (-0.0f) - vertex_unnamed_411;
				precise float vertex_unnamed_416 = vertex_unnamed_57 + vertex_unnamed_414;
				precise float vertex_unnamed_417 = vertex_unnamed_58 + vertex_unnamed_415;
				precise float vertex_unnamed_418 = (-0.0f) - vertex_unnamed_409;
				precise float vertex_unnamed_419 = (-0.0f) - vertex_unnamed_411;
				precise float vertex_unnamed_423 = (-0.0f) - vertex_unnamed_412;
				precise float vertex_unnamed_424 = (-0.0f) - vertex_unnamed_413;
				precise float vertex_unnamed_425 = vertex_unnamed_423 + mad(vertex_unnamed_57, 2.0f, vertex_unnamed_418);
				precise float vertex_unnamed_426 = vertex_unnamed_424 + mad(vertex_unnamed_58, 2.0f, vertex_unnamed_419);
				vertex_output_5.x = vertex_unnamed_425;
				vertex_output_5.y = vertex_unnamed_426;
				precise float vertex_unnamed_429 = (-0.0f) - vertex_unnamed_409;
				precise float vertex_unnamed_430 = (-0.0f) - vertex_unnamed_411;
				precise float vertex_unnamed_431 = vertex_unnamed_429 + vertex_unnamed_412;
				precise float vertex_unnamed_432 = vertex_unnamed_430 + vertex_unnamed_413;
				precise float vertex_unnamed_433 = vertex_unnamed_416 / vertex_unnamed_431;
				precise float vertex_unnamed_434 = vertex_unnamed_417 / vertex_unnamed_432;
				vertex_output_3.z = vertex_unnamed_433;
				vertex_output_3.w = vertex_unnamed_434;
				vertex_output_3.x = vertex_input_3.x;
				vertex_output_3.y = vertex_input_3.y;
				precise float vertex_unnamed_454 = (-0.0f) - vertex_uniform_buffer_0[22u].y;
				precise float vertex_unnamed_458 = vertex_unnamed_454 + vertex_uniform_buffer_0[22u].z;
				precise float vertex_unnamed_470 = mad(mad(asfloat(((0.0f >= vertex_input_4.y) ? 4294967295u : 0u) & 1065353216u), vertex_unnamed_458, vertex_uniform_buffer_0[22u].y), 0.25f, vertex_uniform_buffer_0[4u].x) * vertex_uniform_buffer_0[22u].w;
				precise float vertex_unnamed_471 = (-0.0f) - vertex_unnamed_470;
				float vertex_unnamed_473 = mad(mad(vertex_unnamed_471, 0.5f, 0.5f), vertex_unnamed_375, -0.5f);
				precise float vertex_unnamed_475 = (-0.0f) - vertex_unnamed_383;
				vertex_output_4.y = mad(vertex_unnamed_475, vertex_unnamed_375, vertex_unnamed_473);
				vertex_output_4.z = mad(vertex_unnamed_383, vertex_unnamed_375, vertex_unnamed_473);
				vertex_output_4.x = vertex_unnamed_375;
				vertex_output_4.w = vertex_unnamed_473;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[3] = float4(_FaceColor[0], _FaceColor[1], _FaceColor[2], _FaceColor[3]);

				vertex_uniform_buffer_0[4] = float4(_FaceDilate, vertex_uniform_buffer_0[4][1], vertex_uniform_buffer_0[4][2], vertex_uniform_buffer_0[4][3]);

				vertex_uniform_buffer_0[4] = float4(vertex_uniform_buffer_0[4][0], _OutlineSoftness, vertex_uniform_buffer_0[4][2], vertex_uniform_buffer_0[4][3]);

				vertex_uniform_buffer_0[5] = float4(_OutlineColor[0], _OutlineColor[1], _OutlineColor[2], _OutlineColor[3]);

				vertex_uniform_buffer_0[6] = float4(_OutlineWidth, vertex_uniform_buffer_0[6][1], vertex_uniform_buffer_0[6][2], vertex_uniform_buffer_0[6][3]);

				vertex_uniform_buffer_0[22] = float4(vertex_uniform_buffer_0[22][0], _WeightNormal, vertex_uniform_buffer_0[22][2], vertex_uniform_buffer_0[22][3]);

				vertex_uniform_buffer_0[22] = float4(vertex_uniform_buffer_0[22][0], vertex_uniform_buffer_0[22][1], _WeightBold, vertex_uniform_buffer_0[22][3]);

				vertex_uniform_buffer_0[22] = float4(vertex_uniform_buffer_0[22][0], vertex_uniform_buffer_0[22][1], vertex_uniform_buffer_0[22][2], _ScaleRatioA);

				vertex_uniform_buffer_0[23] = float4(vertex_uniform_buffer_0[23][0], vertex_uniform_buffer_0[23][1], _VertexOffsetX, vertex_uniform_buffer_0[23][3]);

				vertex_uniform_buffer_0[23] = float4(vertex_uniform_buffer_0[23][0], vertex_uniform_buffer_0[23][1], vertex_uniform_buffer_0[23][2], _VertexOffsetY);

				vertex_uniform_buffer_0[26] = float4(_ClipRect[0], _ClipRect[1], _ClipRect[2], _ClipRect[3]);

				vertex_uniform_buffer_0[27] = float4(_MaskSoftnessX, vertex_uniform_buffer_0[27][1], vertex_uniform_buffer_0[27][2], vertex_uniform_buffer_0[27][3]);

				vertex_uniform_buffer_0[27] = float4(vertex_uniform_buffer_0[27][0], _MaskSoftnessY, vertex_uniform_buffer_0[27][2], vertex_uniform_buffer_0[27][3]);

				vertex_uniform_buffer_0[28] = float4(_GradientScale, vertex_uniform_buffer_0[28][1], vertex_uniform_buffer_0[28][2], vertex_uniform_buffer_0[28][3]);

				vertex_uniform_buffer_0[28] = float4(vertex_uniform_buffer_0[28][0], _ScaleX, vertex_uniform_buffer_0[28][2], vertex_uniform_buffer_0[28][3]);

				vertex_uniform_buffer_0[28] = float4(vertex_uniform_buffer_0[28][0], vertex_uniform_buffer_0[28][1], _ScaleY, vertex_uniform_buffer_0[28][3]);

				vertex_uniform_buffer_0[28] = float4(vertex_uniform_buffer_0[28][0], vertex_uniform_buffer_0[28][1], vertex_uniform_buffer_0[28][2], _PerspectiveFilter);

				vertex_uniform_buffer_0[29] = float4(_Sharpness, vertex_uniform_buffer_0[29][1], vertex_uniform_buffer_0[29][2], vertex_uniform_buffer_0[29][3]);

				vertex_uniform_buffer_1[4] = float4(_WorldSpaceCameraPos[0], _WorldSpaceCameraPos[1], _WorldSpaceCameraPos[2], vertex_uniform_buffer_1[4][3]);

				vertex_uniform_buffer_1[6] = float4(_ScreenParams[0], _ScreenParams[1], _ScreenParams[2], _ScreenParams[3]);

				vertex_uniform_buffer_2[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_2[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_2[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_2[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_2[4] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				vertex_uniform_buffer_2[5] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				vertex_uniform_buffer_2[6] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				vertex_uniform_buffer_2[7] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

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
				vertex_input_4 = stage_input.vertex_input_4;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
				return stage_output;
			}

			#endif // UNITY_UI_ALPHACLIP
			#endif // !UNITY_UI_CLIP_RECT


			#ifdef UNITY_UI_CLIP_RECT
			#ifndef UNITY_UI_ALPHACLIP
			#define ANY_SHADER_VARIANT_ACTIVE

			float4 _FaceColor;
			float _FaceDilate;
			float _OutlineSoftness;
			float4 _OutlineColor;
			float _OutlineWidth;
			float _WeightNormal;
			float _WeightBold;
			float _ScaleRatioA;
			float _VertexOffsetX;
			float _VertexOffsetY;
			float4 _ClipRect;
			float _MaskSoftnessX;
			float _MaskSoftnessY;
			float _GradientScale;
			float _ScaleX;
			float _ScaleY;
			float _PerspectiveFilter;
			float _Sharpness;
			float3 _WorldSpaceCameraPos;
			float4 _ScreenParams;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4x4 glstate_matrix_projection;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[30];
			static float4 vertex_uniform_buffer_1[7];
			static float4 vertex_uniform_buffer_2[8];
			static float4 vertex_uniform_buffer_3[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float3 vertex_input_1;
			static float4 vertex_input_2;
			static float2 vertex_input_3;
			static float2 vertex_input_4;
			static float4 vertex_output_1;
			static float4 vertex_output_2;
			static float4 vertex_output_3;
			static float4 vertex_output_4;
			static float4 vertex_output_5;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : COLOR; // COLOR
				float2 vertex_input_3 : TEXCOORD0; // TEXCOORD
				float2 vertex_input_4 : TEXCOORD1; // TEXCOORD_1
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : COLOR; // COLOR
				float4 vertex_output_2 : COLOR1; // COLOR_1
				float4 vertex_output_3 : TEXCOORD; // TEXCOORD
				float4 vertex_output_4 : TEXCOORD1; // TEXCOORD_1
				float4 vertex_output_5 : TEXCOORD2; // TEXCOORD_2
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_57 = vertex_input_0.x + vertex_uniform_buffer_0[23u].z;
				precise float vertex_unnamed_58 = vertex_input_0.y + vertex_uniform_buffer_0[23u].w;
				precise float vertex_unnamed_65 = vertex_unnamed_58 * vertex_uniform_buffer_2[1u].x;
				precise float vertex_unnamed_66 = vertex_unnamed_58 * vertex_uniform_buffer_2[1u].y;
				precise float vertex_unnamed_67 = vertex_unnamed_58 * vertex_uniform_buffer_2[1u].z;
				precise float vertex_unnamed_68 = vertex_unnamed_58 * vertex_uniform_buffer_2[1u].w;
				float vertex_unnamed_89 = mad(vertex_uniform_buffer_2[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].x, vertex_unnamed_57, vertex_unnamed_65));
				float vertex_unnamed_90 = mad(vertex_uniform_buffer_2[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].y, vertex_unnamed_57, vertex_unnamed_66));
				float vertex_unnamed_91 = mad(vertex_uniform_buffer_2[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].z, vertex_unnamed_57, vertex_unnamed_67));
				precise float vertex_unnamed_100 = vertex_unnamed_89 + vertex_uniform_buffer_2[3u].x;
				precise float vertex_unnamed_101 = vertex_unnamed_90 + vertex_uniform_buffer_2[3u].y;
				precise float vertex_unnamed_102 = vertex_unnamed_91 + vertex_uniform_buffer_2[3u].z;
				precise float vertex_unnamed_103 = mad(vertex_uniform_buffer_2[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].w, vertex_unnamed_57, vertex_unnamed_68)) + vertex_uniform_buffer_2[3u].w;
				precise float vertex_unnamed_114 = (-0.0f) - mad(vertex_uniform_buffer_2[3u].x, vertex_input_0.w, vertex_unnamed_89);
				precise float vertex_unnamed_116 = (-0.0f) - mad(vertex_uniform_buffer_2[3u].y, vertex_input_0.w, vertex_unnamed_90);
				precise float vertex_unnamed_117 = (-0.0f) - mad(vertex_uniform_buffer_2[3u].z, vertex_input_0.w, vertex_unnamed_91);
				precise float vertex_unnamed_124 = vertex_unnamed_114 + vertex_uniform_buffer_1[4u].x;
				precise float vertex_unnamed_125 = vertex_unnamed_116 + vertex_uniform_buffer_1[4u].y;
				precise float vertex_unnamed_126 = vertex_unnamed_117 + vertex_uniform_buffer_1[4u].z;
				precise float vertex_unnamed_134 = vertex_unnamed_101 * vertex_uniform_buffer_3[18u].x;
				precise float vertex_unnamed_135 = vertex_unnamed_101 * vertex_uniform_buffer_3[18u].y;
				precise float vertex_unnamed_136 = vertex_unnamed_101 * vertex_uniform_buffer_3[18u].z;
				precise float vertex_unnamed_137 = vertex_unnamed_101 * vertex_uniform_buffer_3[18u].w;
				float vertex_unnamed_170 = mad(vertex_uniform_buffer_3[20u].w, vertex_unnamed_103, mad(vertex_uniform_buffer_3[19u].w, vertex_unnamed_102, mad(vertex_uniform_buffer_3[17u].w, vertex_unnamed_100, vertex_unnamed_137)));
				gl_Position.x = mad(vertex_uniform_buffer_3[20u].x, vertex_unnamed_103, mad(vertex_uniform_buffer_3[19u].x, vertex_unnamed_102, mad(vertex_uniform_buffer_3[17u].x, vertex_unnamed_100, vertex_unnamed_134)));
				gl_Position.y = mad(vertex_uniform_buffer_3[20u].y, vertex_unnamed_103, mad(vertex_uniform_buffer_3[19u].y, vertex_unnamed_102, mad(vertex_uniform_buffer_3[17u].y, vertex_unnamed_100, vertex_unnamed_135)));
				gl_Position.z = mad(vertex_uniform_buffer_3[20u].z, vertex_unnamed_103, mad(vertex_uniform_buffer_3[19u].z, vertex_unnamed_102, mad(vertex_uniform_buffer_3[17u].z, vertex_unnamed_100, vertex_unnamed_136)));
				gl_Position.w = vertex_unnamed_170;
				precise float vertex_unnamed_190 = vertex_input_2.x * vertex_uniform_buffer_0[3u].x;
				precise float vertex_unnamed_191 = vertex_input_2.y * vertex_uniform_buffer_0[3u].y;
				precise float vertex_unnamed_192 = vertex_input_2.z * vertex_uniform_buffer_0[3u].z;
				precise float vertex_unnamed_193 = vertex_input_2.w * vertex_uniform_buffer_0[3u].w;
				precise float vertex_unnamed_194 = vertex_unnamed_193 * vertex_unnamed_190;
				precise float vertex_unnamed_195 = vertex_unnamed_193 * vertex_unnamed_191;
				precise float vertex_unnamed_196 = vertex_unnamed_193 * vertex_unnamed_192;
				vertex_output_1.x = vertex_unnamed_194;
				vertex_output_1.y = vertex_unnamed_195;
				vertex_output_1.z = vertex_unnamed_196;
				vertex_output_1.w = vertex_unnamed_193;
				precise float vertex_unnamed_207 = vertex_input_2.w * vertex_uniform_buffer_0[5u].w;
				precise float vertex_unnamed_213 = vertex_unnamed_207 * vertex_uniform_buffer_0[5u].x;
				precise float vertex_unnamed_214 = vertex_unnamed_207 * vertex_uniform_buffer_0[5u].y;
				precise float vertex_unnamed_215 = vertex_unnamed_207 * vertex_uniform_buffer_0[5u].z;
				precise float vertex_unnamed_216 = (-0.0f) - vertex_unnamed_194;
				precise float vertex_unnamed_217 = (-0.0f) - vertex_unnamed_195;
				precise float vertex_unnamed_218 = (-0.0f) - vertex_unnamed_196;
				precise float vertex_unnamed_219 = (-0.0f) - vertex_unnamed_193;
				precise float vertex_unnamed_220 = vertex_unnamed_216 + vertex_unnamed_213;
				precise float vertex_unnamed_221 = vertex_unnamed_217 + vertex_unnamed_214;
				precise float vertex_unnamed_222 = vertex_unnamed_218 + vertex_unnamed_215;
				precise float vertex_unnamed_223 = vertex_unnamed_219 + vertex_unnamed_207;
				float vertex_unnamed_227 = rsqrt(dot(float3(vertex_unnamed_124, vertex_unnamed_125, vertex_unnamed_126), float3(vertex_unnamed_124, vertex_unnamed_125, vertex_unnamed_126)));
				precise float vertex_unnamed_228 = vertex_unnamed_227 * vertex_unnamed_124;
				precise float vertex_unnamed_229 = vertex_unnamed_227 * vertex_unnamed_125;
				precise float vertex_unnamed_230 = vertex_unnamed_227 * vertex_unnamed_126;
				float vertex_unnamed_242 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_2[4u].xyz));
				float vertex_unnamed_256 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_2[5u].xyz));
				float vertex_unnamed_271 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_2[6u].xyz));
				float vertex_unnamed_277 = rsqrt(dot(float3(vertex_unnamed_242, vertex_unnamed_256, vertex_unnamed_271), float3(vertex_unnamed_242, vertex_unnamed_256, vertex_unnamed_271)));
				precise float vertex_unnamed_278 = vertex_unnamed_277 * vertex_unnamed_242;
				precise float vertex_unnamed_279 = vertex_unnamed_277 * vertex_unnamed_256;
				precise float vertex_unnamed_280 = vertex_unnamed_277 * vertex_unnamed_271;
				precise float vertex_unnamed_291 = vertex_uniform_buffer_1[6u].y * vertex_uniform_buffer_3[6u].x;
				precise float vertex_unnamed_292 = vertex_uniform_buffer_1[6u].y * vertex_uniform_buffer_3[6u].y;
				precise float vertex_unnamed_309 = abs(mad(vertex_uniform_buffer_3[5u].x, vertex_uniform_buffer_1[6u].x, vertex_unnamed_291)) * vertex_uniform_buffer_0[28u].y;
				precise float vertex_unnamed_310 = abs(mad(vertex_uniform_buffer_3[5u].y, vertex_uniform_buffer_1[6u].x, vertex_unnamed_292)) * vertex_uniform_buffer_0[28u].z;
				precise float vertex_unnamed_311 = vertex_unnamed_170 / vertex_unnamed_309;
				precise float vertex_unnamed_312 = vertex_unnamed_170 / vertex_unnamed_310;
				precise float vertex_unnamed_324 = 0.25f / mad(vertex_uniform_buffer_0[27u].x, 0.25f, vertex_unnamed_311);
				precise float vertex_unnamed_325 = 0.25f / mad(vertex_uniform_buffer_0[27u].y, 0.25f, vertex_unnamed_312);
				vertex_output_5.z = vertex_unnamed_324;
				vertex_output_5.w = vertex_unnamed_325;
				float vertex_unnamed_328 = rsqrt(dot(float2(vertex_unnamed_311, vertex_unnamed_312), float2(vertex_unnamed_311, vertex_unnamed_312)));
				precise float vertex_unnamed_335 = abs(vertex_input_4.y) * vertex_uniform_buffer_0[28u].x;
				precise float vertex_unnamed_340 = vertex_uniform_buffer_0[29u].x + 1.0f;
				precise float vertex_unnamed_342 = vertex_unnamed_340 * vertex_unnamed_335;
				precise float vertex_unnamed_343 = vertex_unnamed_328 * vertex_unnamed_342;
				precise float vertex_unnamed_347 = (-0.0f) - vertex_uniform_buffer_0[28u].w;
				precise float vertex_unnamed_348 = vertex_unnamed_347 + 1.0f;
				precise float vertex_unnamed_350 = vertex_unnamed_348 * abs(vertex_unnamed_343);
				precise float vertex_unnamed_351 = (-0.0f) - vertex_unnamed_350;
				float vertex_unnamed_365 = asfloat((vertex_uniform_buffer_3[8u].w == 0.0f) ? asuint(mad(abs(dot(float3(vertex_unnamed_278, vertex_unnamed_279, vertex_unnamed_280), float3(vertex_unnamed_228, vertex_unnamed_229, vertex_unnamed_230))), mad(vertex_unnamed_328, vertex_unnamed_342, vertex_unnamed_351), vertex_unnamed_350)) : asuint(vertex_unnamed_343));
				precise float vertex_unnamed_373 = vertex_uniform_buffer_0[4u].y * vertex_uniform_buffer_0[22u].w;
				precise float vertex_unnamed_375 = vertex_unnamed_365 / mad(vertex_unnamed_373, vertex_unnamed_365, 1.0f);
				precise float vertex_unnamed_382 = vertex_uniform_buffer_0[6u].x * vertex_uniform_buffer_0[22u].w;
				precise float vertex_unnamed_383 = vertex_unnamed_382 * 0.5f;
				precise float vertex_unnamed_385 = vertex_unnamed_375 * vertex_unnamed_383;
				precise float vertex_unnamed_386 = vertex_unnamed_385 + vertex_unnamed_385;
				float vertex_unnamed_388 = sqrt(min(vertex_unnamed_386, 1.0f));
				vertex_output_2.x = mad(vertex_unnamed_388, vertex_unnamed_220, vertex_unnamed_194);
				vertex_output_2.y = mad(vertex_unnamed_388, vertex_unnamed_221, vertex_unnamed_195);
				vertex_output_2.z = mad(vertex_unnamed_388, vertex_unnamed_222, vertex_unnamed_196);
				vertex_output_2.w = mad(vertex_unnamed_388, vertex_unnamed_223, vertex_unnamed_193);
				float vertex_unnamed_409 = min(max(vertex_uniform_buffer_0[26u].x, -20000000000.0f), 20000000000.0f);
				float vertex_unnamed_411 = min(max(vertex_uniform_buffer_0[26u].y, -20000000000.0f), 20000000000.0f);
				float vertex_unnamed_412 = min(max(vertex_uniform_buffer_0[26u].z, -20000000000.0f), 20000000000.0f);
				float vertex_unnamed_413 = min(max(vertex_uniform_buffer_0[26u].w, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_414 = (-0.0f) - vertex_unnamed_409;
				precise float vertex_unnamed_415 = (-0.0f) - vertex_unnamed_411;
				precise float vertex_unnamed_416 = vertex_unnamed_57 + vertex_unnamed_414;
				precise float vertex_unnamed_417 = vertex_unnamed_58 + vertex_unnamed_415;
				precise float vertex_unnamed_418 = (-0.0f) - vertex_unnamed_409;
				precise float vertex_unnamed_419 = (-0.0f) - vertex_unnamed_411;
				precise float vertex_unnamed_423 = (-0.0f) - vertex_unnamed_412;
				precise float vertex_unnamed_424 = (-0.0f) - vertex_unnamed_413;
				precise float vertex_unnamed_425 = vertex_unnamed_423 + mad(vertex_unnamed_57, 2.0f, vertex_unnamed_418);
				precise float vertex_unnamed_426 = vertex_unnamed_424 + mad(vertex_unnamed_58, 2.0f, vertex_unnamed_419);
				vertex_output_5.x = vertex_unnamed_425;
				vertex_output_5.y = vertex_unnamed_426;
				precise float vertex_unnamed_429 = (-0.0f) - vertex_unnamed_409;
				precise float vertex_unnamed_430 = (-0.0f) - vertex_unnamed_411;
				precise float vertex_unnamed_431 = vertex_unnamed_429 + vertex_unnamed_412;
				precise float vertex_unnamed_432 = vertex_unnamed_430 + vertex_unnamed_413;
				precise float vertex_unnamed_433 = vertex_unnamed_416 / vertex_unnamed_431;
				precise float vertex_unnamed_434 = vertex_unnamed_417 / vertex_unnamed_432;
				vertex_output_3.z = vertex_unnamed_433;
				vertex_output_3.w = vertex_unnamed_434;
				vertex_output_3.x = vertex_input_3.x;
				vertex_output_3.y = vertex_input_3.y;
				precise float vertex_unnamed_454 = (-0.0f) - vertex_uniform_buffer_0[22u].y;
				precise float vertex_unnamed_458 = vertex_unnamed_454 + vertex_uniform_buffer_0[22u].z;
				precise float vertex_unnamed_470 = mad(mad(asfloat(((0.0f >= vertex_input_4.y) ? 4294967295u : 0u) & 1065353216u), vertex_unnamed_458, vertex_uniform_buffer_0[22u].y), 0.25f, vertex_uniform_buffer_0[4u].x) * vertex_uniform_buffer_0[22u].w;
				precise float vertex_unnamed_471 = (-0.0f) - vertex_unnamed_470;
				float vertex_unnamed_473 = mad(mad(vertex_unnamed_471, 0.5f, 0.5f), vertex_unnamed_375, -0.5f);
				precise float vertex_unnamed_475 = (-0.0f) - vertex_unnamed_383;
				vertex_output_4.y = mad(vertex_unnamed_475, vertex_unnamed_375, vertex_unnamed_473);
				vertex_output_4.z = mad(vertex_unnamed_383, vertex_unnamed_375, vertex_unnamed_473);
				vertex_output_4.x = vertex_unnamed_375;
				vertex_output_4.w = vertex_unnamed_473;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[3] = float4(_FaceColor[0], _FaceColor[1], _FaceColor[2], _FaceColor[3]);

				vertex_uniform_buffer_0[4] = float4(_FaceDilate, vertex_uniform_buffer_0[4][1], vertex_uniform_buffer_0[4][2], vertex_uniform_buffer_0[4][3]);

				vertex_uniform_buffer_0[4] = float4(vertex_uniform_buffer_0[4][0], _OutlineSoftness, vertex_uniform_buffer_0[4][2], vertex_uniform_buffer_0[4][3]);

				vertex_uniform_buffer_0[5] = float4(_OutlineColor[0], _OutlineColor[1], _OutlineColor[2], _OutlineColor[3]);

				vertex_uniform_buffer_0[6] = float4(_OutlineWidth, vertex_uniform_buffer_0[6][1], vertex_uniform_buffer_0[6][2], vertex_uniform_buffer_0[6][3]);

				vertex_uniform_buffer_0[22] = float4(vertex_uniform_buffer_0[22][0], _WeightNormal, vertex_uniform_buffer_0[22][2], vertex_uniform_buffer_0[22][3]);

				vertex_uniform_buffer_0[22] = float4(vertex_uniform_buffer_0[22][0], vertex_uniform_buffer_0[22][1], _WeightBold, vertex_uniform_buffer_0[22][3]);

				vertex_uniform_buffer_0[22] = float4(vertex_uniform_buffer_0[22][0], vertex_uniform_buffer_0[22][1], vertex_uniform_buffer_0[22][2], _ScaleRatioA);

				vertex_uniform_buffer_0[23] = float4(vertex_uniform_buffer_0[23][0], vertex_uniform_buffer_0[23][1], _VertexOffsetX, vertex_uniform_buffer_0[23][3]);

				vertex_uniform_buffer_0[23] = float4(vertex_uniform_buffer_0[23][0], vertex_uniform_buffer_0[23][1], vertex_uniform_buffer_0[23][2], _VertexOffsetY);

				vertex_uniform_buffer_0[26] = float4(_ClipRect[0], _ClipRect[1], _ClipRect[2], _ClipRect[3]);

				vertex_uniform_buffer_0[27] = float4(_MaskSoftnessX, vertex_uniform_buffer_0[27][1], vertex_uniform_buffer_0[27][2], vertex_uniform_buffer_0[27][3]);

				vertex_uniform_buffer_0[27] = float4(vertex_uniform_buffer_0[27][0], _MaskSoftnessY, vertex_uniform_buffer_0[27][2], vertex_uniform_buffer_0[27][3]);

				vertex_uniform_buffer_0[28] = float4(_GradientScale, vertex_uniform_buffer_0[28][1], vertex_uniform_buffer_0[28][2], vertex_uniform_buffer_0[28][3]);

				vertex_uniform_buffer_0[28] = float4(vertex_uniform_buffer_0[28][0], _ScaleX, vertex_uniform_buffer_0[28][2], vertex_uniform_buffer_0[28][3]);

				vertex_uniform_buffer_0[28] = float4(vertex_uniform_buffer_0[28][0], vertex_uniform_buffer_0[28][1], _ScaleY, vertex_uniform_buffer_0[28][3]);

				vertex_uniform_buffer_0[28] = float4(vertex_uniform_buffer_0[28][0], vertex_uniform_buffer_0[28][1], vertex_uniform_buffer_0[28][2], _PerspectiveFilter);

				vertex_uniform_buffer_0[29] = float4(_Sharpness, vertex_uniform_buffer_0[29][1], vertex_uniform_buffer_0[29][2], vertex_uniform_buffer_0[29][3]);

				vertex_uniform_buffer_1[4] = float4(_WorldSpaceCameraPos[0], _WorldSpaceCameraPos[1], _WorldSpaceCameraPos[2], vertex_uniform_buffer_1[4][3]);

				vertex_uniform_buffer_1[6] = float4(_ScreenParams[0], _ScreenParams[1], _ScreenParams[2], _ScreenParams[3]);

				vertex_uniform_buffer_2[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_2[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_2[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_2[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_2[4] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				vertex_uniform_buffer_2[5] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				vertex_uniform_buffer_2[6] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				vertex_uniform_buffer_2[7] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

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
				vertex_input_4 = stage_input.vertex_input_4;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
				return stage_output;
			}

			#endif // UNITY_UI_CLIP_RECT
			#endif // !UNITY_UI_ALPHACLIP


			#ifdef UNITY_UI_ALPHACLIP
			#ifdef UNITY_UI_CLIP_RECT
			#define ANY_SHADER_VARIANT_ACTIVE

			float4 _FaceColor;
			float _FaceDilate;
			float _OutlineSoftness;
			float4 _OutlineColor;
			float _OutlineWidth;
			float _WeightNormal;
			float _WeightBold;
			float _ScaleRatioA;
			float _VertexOffsetX;
			float _VertexOffsetY;
			float4 _ClipRect;
			float _MaskSoftnessX;
			float _MaskSoftnessY;
			float _GradientScale;
			float _ScaleX;
			float _ScaleY;
			float _PerspectiveFilter;
			float _Sharpness;
			float3 _WorldSpaceCameraPos;
			float4 _ScreenParams;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4x4 glstate_matrix_projection;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[30];
			static float4 vertex_uniform_buffer_1[7];
			static float4 vertex_uniform_buffer_2[8];
			static float4 vertex_uniform_buffer_3[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float3 vertex_input_1;
			static float4 vertex_input_2;
			static float2 vertex_input_3;
			static float2 vertex_input_4;
			static float4 vertex_output_1;
			static float4 vertex_output_2;
			static float4 vertex_output_3;
			static float4 vertex_output_4;
			static float4 vertex_output_5;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : COLOR; // COLOR
				float2 vertex_input_3 : TEXCOORD0; // TEXCOORD
				float2 vertex_input_4 : TEXCOORD1; // TEXCOORD_1
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : COLOR; // COLOR
				float4 vertex_output_2 : COLOR1; // COLOR_1
				float4 vertex_output_3 : TEXCOORD; // TEXCOORD
				float4 vertex_output_4 : TEXCOORD1; // TEXCOORD_1
				float4 vertex_output_5 : TEXCOORD2; // TEXCOORD_2
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_57 = vertex_input_0.x + vertex_uniform_buffer_0[23u].z;
				precise float vertex_unnamed_58 = vertex_input_0.y + vertex_uniform_buffer_0[23u].w;
				precise float vertex_unnamed_65 = vertex_unnamed_58 * vertex_uniform_buffer_2[1u].x;
				precise float vertex_unnamed_66 = vertex_unnamed_58 * vertex_uniform_buffer_2[1u].y;
				precise float vertex_unnamed_67 = vertex_unnamed_58 * vertex_uniform_buffer_2[1u].z;
				precise float vertex_unnamed_68 = vertex_unnamed_58 * vertex_uniform_buffer_2[1u].w;
				float vertex_unnamed_89 = mad(vertex_uniform_buffer_2[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].x, vertex_unnamed_57, vertex_unnamed_65));
				float vertex_unnamed_90 = mad(vertex_uniform_buffer_2[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].y, vertex_unnamed_57, vertex_unnamed_66));
				float vertex_unnamed_91 = mad(vertex_uniform_buffer_2[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].z, vertex_unnamed_57, vertex_unnamed_67));
				precise float vertex_unnamed_100 = vertex_unnamed_89 + vertex_uniform_buffer_2[3u].x;
				precise float vertex_unnamed_101 = vertex_unnamed_90 + vertex_uniform_buffer_2[3u].y;
				precise float vertex_unnamed_102 = vertex_unnamed_91 + vertex_uniform_buffer_2[3u].z;
				precise float vertex_unnamed_103 = mad(vertex_uniform_buffer_2[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].w, vertex_unnamed_57, vertex_unnamed_68)) + vertex_uniform_buffer_2[3u].w;
				precise float vertex_unnamed_114 = (-0.0f) - mad(vertex_uniform_buffer_2[3u].x, vertex_input_0.w, vertex_unnamed_89);
				precise float vertex_unnamed_116 = (-0.0f) - mad(vertex_uniform_buffer_2[3u].y, vertex_input_0.w, vertex_unnamed_90);
				precise float vertex_unnamed_117 = (-0.0f) - mad(vertex_uniform_buffer_2[3u].z, vertex_input_0.w, vertex_unnamed_91);
				precise float vertex_unnamed_124 = vertex_unnamed_114 + vertex_uniform_buffer_1[4u].x;
				precise float vertex_unnamed_125 = vertex_unnamed_116 + vertex_uniform_buffer_1[4u].y;
				precise float vertex_unnamed_126 = vertex_unnamed_117 + vertex_uniform_buffer_1[4u].z;
				precise float vertex_unnamed_134 = vertex_unnamed_101 * vertex_uniform_buffer_3[18u].x;
				precise float vertex_unnamed_135 = vertex_unnamed_101 * vertex_uniform_buffer_3[18u].y;
				precise float vertex_unnamed_136 = vertex_unnamed_101 * vertex_uniform_buffer_3[18u].z;
				precise float vertex_unnamed_137 = vertex_unnamed_101 * vertex_uniform_buffer_3[18u].w;
				float vertex_unnamed_170 = mad(vertex_uniform_buffer_3[20u].w, vertex_unnamed_103, mad(vertex_uniform_buffer_3[19u].w, vertex_unnamed_102, mad(vertex_uniform_buffer_3[17u].w, vertex_unnamed_100, vertex_unnamed_137)));
				gl_Position.x = mad(vertex_uniform_buffer_3[20u].x, vertex_unnamed_103, mad(vertex_uniform_buffer_3[19u].x, vertex_unnamed_102, mad(vertex_uniform_buffer_3[17u].x, vertex_unnamed_100, vertex_unnamed_134)));
				gl_Position.y = mad(vertex_uniform_buffer_3[20u].y, vertex_unnamed_103, mad(vertex_uniform_buffer_3[19u].y, vertex_unnamed_102, mad(vertex_uniform_buffer_3[17u].y, vertex_unnamed_100, vertex_unnamed_135)));
				gl_Position.z = mad(vertex_uniform_buffer_3[20u].z, vertex_unnamed_103, mad(vertex_uniform_buffer_3[19u].z, vertex_unnamed_102, mad(vertex_uniform_buffer_3[17u].z, vertex_unnamed_100, vertex_unnamed_136)));
				gl_Position.w = vertex_unnamed_170;
				precise float vertex_unnamed_190 = vertex_input_2.x * vertex_uniform_buffer_0[3u].x;
				precise float vertex_unnamed_191 = vertex_input_2.y * vertex_uniform_buffer_0[3u].y;
				precise float vertex_unnamed_192 = vertex_input_2.z * vertex_uniform_buffer_0[3u].z;
				precise float vertex_unnamed_193 = vertex_input_2.w * vertex_uniform_buffer_0[3u].w;
				precise float vertex_unnamed_194 = vertex_unnamed_193 * vertex_unnamed_190;
				precise float vertex_unnamed_195 = vertex_unnamed_193 * vertex_unnamed_191;
				precise float vertex_unnamed_196 = vertex_unnamed_193 * vertex_unnamed_192;
				vertex_output_1.x = vertex_unnamed_194;
				vertex_output_1.y = vertex_unnamed_195;
				vertex_output_1.z = vertex_unnamed_196;
				vertex_output_1.w = vertex_unnamed_193;
				precise float vertex_unnamed_207 = vertex_input_2.w * vertex_uniform_buffer_0[5u].w;
				precise float vertex_unnamed_213 = vertex_unnamed_207 * vertex_uniform_buffer_0[5u].x;
				precise float vertex_unnamed_214 = vertex_unnamed_207 * vertex_uniform_buffer_0[5u].y;
				precise float vertex_unnamed_215 = vertex_unnamed_207 * vertex_uniform_buffer_0[5u].z;
				precise float vertex_unnamed_216 = (-0.0f) - vertex_unnamed_194;
				precise float vertex_unnamed_217 = (-0.0f) - vertex_unnamed_195;
				precise float vertex_unnamed_218 = (-0.0f) - vertex_unnamed_196;
				precise float vertex_unnamed_219 = (-0.0f) - vertex_unnamed_193;
				precise float vertex_unnamed_220 = vertex_unnamed_216 + vertex_unnamed_213;
				precise float vertex_unnamed_221 = vertex_unnamed_217 + vertex_unnamed_214;
				precise float vertex_unnamed_222 = vertex_unnamed_218 + vertex_unnamed_215;
				precise float vertex_unnamed_223 = vertex_unnamed_219 + vertex_unnamed_207;
				float vertex_unnamed_227 = rsqrt(dot(float3(vertex_unnamed_124, vertex_unnamed_125, vertex_unnamed_126), float3(vertex_unnamed_124, vertex_unnamed_125, vertex_unnamed_126)));
				precise float vertex_unnamed_228 = vertex_unnamed_227 * vertex_unnamed_124;
				precise float vertex_unnamed_229 = vertex_unnamed_227 * vertex_unnamed_125;
				precise float vertex_unnamed_230 = vertex_unnamed_227 * vertex_unnamed_126;
				float vertex_unnamed_242 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_2[4u].xyz));
				float vertex_unnamed_256 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_2[5u].xyz));
				float vertex_unnamed_271 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_2[6u].xyz));
				float vertex_unnamed_277 = rsqrt(dot(float3(vertex_unnamed_242, vertex_unnamed_256, vertex_unnamed_271), float3(vertex_unnamed_242, vertex_unnamed_256, vertex_unnamed_271)));
				precise float vertex_unnamed_278 = vertex_unnamed_277 * vertex_unnamed_242;
				precise float vertex_unnamed_279 = vertex_unnamed_277 * vertex_unnamed_256;
				precise float vertex_unnamed_280 = vertex_unnamed_277 * vertex_unnamed_271;
				precise float vertex_unnamed_291 = vertex_uniform_buffer_1[6u].y * vertex_uniform_buffer_3[6u].x;
				precise float vertex_unnamed_292 = vertex_uniform_buffer_1[6u].y * vertex_uniform_buffer_3[6u].y;
				precise float vertex_unnamed_309 = abs(mad(vertex_uniform_buffer_3[5u].x, vertex_uniform_buffer_1[6u].x, vertex_unnamed_291)) * vertex_uniform_buffer_0[28u].y;
				precise float vertex_unnamed_310 = abs(mad(vertex_uniform_buffer_3[5u].y, vertex_uniform_buffer_1[6u].x, vertex_unnamed_292)) * vertex_uniform_buffer_0[28u].z;
				precise float vertex_unnamed_311 = vertex_unnamed_170 / vertex_unnamed_309;
				precise float vertex_unnamed_312 = vertex_unnamed_170 / vertex_unnamed_310;
				precise float vertex_unnamed_324 = 0.25f / mad(vertex_uniform_buffer_0[27u].x, 0.25f, vertex_unnamed_311);
				precise float vertex_unnamed_325 = 0.25f / mad(vertex_uniform_buffer_0[27u].y, 0.25f, vertex_unnamed_312);
				vertex_output_5.z = vertex_unnamed_324;
				vertex_output_5.w = vertex_unnamed_325;
				float vertex_unnamed_328 = rsqrt(dot(float2(vertex_unnamed_311, vertex_unnamed_312), float2(vertex_unnamed_311, vertex_unnamed_312)));
				precise float vertex_unnamed_335 = abs(vertex_input_4.y) * vertex_uniform_buffer_0[28u].x;
				precise float vertex_unnamed_340 = vertex_uniform_buffer_0[29u].x + 1.0f;
				precise float vertex_unnamed_342 = vertex_unnamed_340 * vertex_unnamed_335;
				precise float vertex_unnamed_343 = vertex_unnamed_328 * vertex_unnamed_342;
				precise float vertex_unnamed_347 = (-0.0f) - vertex_uniform_buffer_0[28u].w;
				precise float vertex_unnamed_348 = vertex_unnamed_347 + 1.0f;
				precise float vertex_unnamed_350 = vertex_unnamed_348 * abs(vertex_unnamed_343);
				precise float vertex_unnamed_351 = (-0.0f) - vertex_unnamed_350;
				float vertex_unnamed_365 = asfloat((vertex_uniform_buffer_3[8u].w == 0.0f) ? asuint(mad(abs(dot(float3(vertex_unnamed_278, vertex_unnamed_279, vertex_unnamed_280), float3(vertex_unnamed_228, vertex_unnamed_229, vertex_unnamed_230))), mad(vertex_unnamed_328, vertex_unnamed_342, vertex_unnamed_351), vertex_unnamed_350)) : asuint(vertex_unnamed_343));
				precise float vertex_unnamed_373 = vertex_uniform_buffer_0[4u].y * vertex_uniform_buffer_0[22u].w;
				precise float vertex_unnamed_375 = vertex_unnamed_365 / mad(vertex_unnamed_373, vertex_unnamed_365, 1.0f);
				precise float vertex_unnamed_382 = vertex_uniform_buffer_0[6u].x * vertex_uniform_buffer_0[22u].w;
				precise float vertex_unnamed_383 = vertex_unnamed_382 * 0.5f;
				precise float vertex_unnamed_385 = vertex_unnamed_375 * vertex_unnamed_383;
				precise float vertex_unnamed_386 = vertex_unnamed_385 + vertex_unnamed_385;
				float vertex_unnamed_388 = sqrt(min(vertex_unnamed_386, 1.0f));
				vertex_output_2.x = mad(vertex_unnamed_388, vertex_unnamed_220, vertex_unnamed_194);
				vertex_output_2.y = mad(vertex_unnamed_388, vertex_unnamed_221, vertex_unnamed_195);
				vertex_output_2.z = mad(vertex_unnamed_388, vertex_unnamed_222, vertex_unnamed_196);
				vertex_output_2.w = mad(vertex_unnamed_388, vertex_unnamed_223, vertex_unnamed_193);
				float vertex_unnamed_409 = min(max(vertex_uniform_buffer_0[26u].x, -20000000000.0f), 20000000000.0f);
				float vertex_unnamed_411 = min(max(vertex_uniform_buffer_0[26u].y, -20000000000.0f), 20000000000.0f);
				float vertex_unnamed_412 = min(max(vertex_uniform_buffer_0[26u].z, -20000000000.0f), 20000000000.0f);
				float vertex_unnamed_413 = min(max(vertex_uniform_buffer_0[26u].w, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_414 = (-0.0f) - vertex_unnamed_409;
				precise float vertex_unnamed_415 = (-0.0f) - vertex_unnamed_411;
				precise float vertex_unnamed_416 = vertex_unnamed_57 + vertex_unnamed_414;
				precise float vertex_unnamed_417 = vertex_unnamed_58 + vertex_unnamed_415;
				precise float vertex_unnamed_418 = (-0.0f) - vertex_unnamed_409;
				precise float vertex_unnamed_419 = (-0.0f) - vertex_unnamed_411;
				precise float vertex_unnamed_423 = (-0.0f) - vertex_unnamed_412;
				precise float vertex_unnamed_424 = (-0.0f) - vertex_unnamed_413;
				precise float vertex_unnamed_425 = vertex_unnamed_423 + mad(vertex_unnamed_57, 2.0f, vertex_unnamed_418);
				precise float vertex_unnamed_426 = vertex_unnamed_424 + mad(vertex_unnamed_58, 2.0f, vertex_unnamed_419);
				vertex_output_5.x = vertex_unnamed_425;
				vertex_output_5.y = vertex_unnamed_426;
				precise float vertex_unnamed_429 = (-0.0f) - vertex_unnamed_409;
				precise float vertex_unnamed_430 = (-0.0f) - vertex_unnamed_411;
				precise float vertex_unnamed_431 = vertex_unnamed_429 + vertex_unnamed_412;
				precise float vertex_unnamed_432 = vertex_unnamed_430 + vertex_unnamed_413;
				precise float vertex_unnamed_433 = vertex_unnamed_416 / vertex_unnamed_431;
				precise float vertex_unnamed_434 = vertex_unnamed_417 / vertex_unnamed_432;
				vertex_output_3.z = vertex_unnamed_433;
				vertex_output_3.w = vertex_unnamed_434;
				vertex_output_3.x = vertex_input_3.x;
				vertex_output_3.y = vertex_input_3.y;
				precise float vertex_unnamed_454 = (-0.0f) - vertex_uniform_buffer_0[22u].y;
				precise float vertex_unnamed_458 = vertex_unnamed_454 + vertex_uniform_buffer_0[22u].z;
				precise float vertex_unnamed_470 = mad(mad(asfloat(((0.0f >= vertex_input_4.y) ? 4294967295u : 0u) & 1065353216u), vertex_unnamed_458, vertex_uniform_buffer_0[22u].y), 0.25f, vertex_uniform_buffer_0[4u].x) * vertex_uniform_buffer_0[22u].w;
				precise float vertex_unnamed_471 = (-0.0f) - vertex_unnamed_470;
				float vertex_unnamed_473 = mad(mad(vertex_unnamed_471, 0.5f, 0.5f), vertex_unnamed_375, -0.5f);
				precise float vertex_unnamed_475 = (-0.0f) - vertex_unnamed_383;
				vertex_output_4.y = mad(vertex_unnamed_475, vertex_unnamed_375, vertex_unnamed_473);
				vertex_output_4.z = mad(vertex_unnamed_383, vertex_unnamed_375, vertex_unnamed_473);
				vertex_output_4.x = vertex_unnamed_375;
				vertex_output_4.w = vertex_unnamed_473;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[3] = float4(_FaceColor[0], _FaceColor[1], _FaceColor[2], _FaceColor[3]);

				vertex_uniform_buffer_0[4] = float4(_FaceDilate, vertex_uniform_buffer_0[4][1], vertex_uniform_buffer_0[4][2], vertex_uniform_buffer_0[4][3]);

				vertex_uniform_buffer_0[4] = float4(vertex_uniform_buffer_0[4][0], _OutlineSoftness, vertex_uniform_buffer_0[4][2], vertex_uniform_buffer_0[4][3]);

				vertex_uniform_buffer_0[5] = float4(_OutlineColor[0], _OutlineColor[1], _OutlineColor[2], _OutlineColor[3]);

				vertex_uniform_buffer_0[6] = float4(_OutlineWidth, vertex_uniform_buffer_0[6][1], vertex_uniform_buffer_0[6][2], vertex_uniform_buffer_0[6][3]);

				vertex_uniform_buffer_0[22] = float4(vertex_uniform_buffer_0[22][0], _WeightNormal, vertex_uniform_buffer_0[22][2], vertex_uniform_buffer_0[22][3]);

				vertex_uniform_buffer_0[22] = float4(vertex_uniform_buffer_0[22][0], vertex_uniform_buffer_0[22][1], _WeightBold, vertex_uniform_buffer_0[22][3]);

				vertex_uniform_buffer_0[22] = float4(vertex_uniform_buffer_0[22][0], vertex_uniform_buffer_0[22][1], vertex_uniform_buffer_0[22][2], _ScaleRatioA);

				vertex_uniform_buffer_0[23] = float4(vertex_uniform_buffer_0[23][0], vertex_uniform_buffer_0[23][1], _VertexOffsetX, vertex_uniform_buffer_0[23][3]);

				vertex_uniform_buffer_0[23] = float4(vertex_uniform_buffer_0[23][0], vertex_uniform_buffer_0[23][1], vertex_uniform_buffer_0[23][2], _VertexOffsetY);

				vertex_uniform_buffer_0[26] = float4(_ClipRect[0], _ClipRect[1], _ClipRect[2], _ClipRect[3]);

				vertex_uniform_buffer_0[27] = float4(_MaskSoftnessX, vertex_uniform_buffer_0[27][1], vertex_uniform_buffer_0[27][2], vertex_uniform_buffer_0[27][3]);

				vertex_uniform_buffer_0[27] = float4(vertex_uniform_buffer_0[27][0], _MaskSoftnessY, vertex_uniform_buffer_0[27][2], vertex_uniform_buffer_0[27][3]);

				vertex_uniform_buffer_0[28] = float4(_GradientScale, vertex_uniform_buffer_0[28][1], vertex_uniform_buffer_0[28][2], vertex_uniform_buffer_0[28][3]);

				vertex_uniform_buffer_0[28] = float4(vertex_uniform_buffer_0[28][0], _ScaleX, vertex_uniform_buffer_0[28][2], vertex_uniform_buffer_0[28][3]);

				vertex_uniform_buffer_0[28] = float4(vertex_uniform_buffer_0[28][0], vertex_uniform_buffer_0[28][1], _ScaleY, vertex_uniform_buffer_0[28][3]);

				vertex_uniform_buffer_0[28] = float4(vertex_uniform_buffer_0[28][0], vertex_uniform_buffer_0[28][1], vertex_uniform_buffer_0[28][2], _PerspectiveFilter);

				vertex_uniform_buffer_0[29] = float4(_Sharpness, vertex_uniform_buffer_0[29][1], vertex_uniform_buffer_0[29][2], vertex_uniform_buffer_0[29][3]);

				vertex_uniform_buffer_1[4] = float4(_WorldSpaceCameraPos[0], _WorldSpaceCameraPos[1], _WorldSpaceCameraPos[2], vertex_uniform_buffer_1[4][3]);

				vertex_uniform_buffer_1[6] = float4(_ScreenParams[0], _ScreenParams[1], _ScreenParams[2], _ScreenParams[3]);

				vertex_uniform_buffer_2[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_2[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_2[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_2[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_2[4] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				vertex_uniform_buffer_2[5] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				vertex_uniform_buffer_2[6] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				vertex_uniform_buffer_2[7] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

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
				vertex_input_4 = stage_input.vertex_input_4;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
				return stage_output;
			}

			#endif // UNITY_UI_ALPHACLIP
			#endif // UNITY_UI_CLIP_RECT


			#ifndef UNITY_UI_ALPHACLIP
			#ifndef UNITY_UI_CLIP_RECT
			#define ANY_SHADER_VARIANT_ACTIVE

			float3 _WorldSpaceCameraPos;
			float4 _ScreenParams;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4x4 glstate_matrix_projection;
			float4x4 unity_MatrixVP;
			float4 _FaceColor;
			float _FaceDilate;
			float _OutlineSoftness;
			float4 _OutlineColor;
			float _OutlineWidth;
			float _WeightNormal;
			float _WeightBold;
			float _ScaleRatioA;
			float _VertexOffsetX;
			float _VertexOffsetY;
			float4 _ClipRect;
			float _MaskSoftnessX;
			float _MaskSoftnessY;
			float _GradientScale;
			float _ScaleX;
			float _ScaleY;
			float _PerspectiveFilter;
			float _Sharpness;

			static float4 unity_ObjectToWorld__array[4];
			static float4 unity_WorldToObject__array[4];
			static float4 glstate_matrix_projection__array[4];
			static float4 unity_MatrixVP__array[4];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_2;
			static float4 vertex_output_0;
			static float3 vertex_input_1;
			static float4 vertex_output_4;
			static float2 vertex_input_4;
			static float4 vertex_output_3;
			static float4 vertex_output_1;
			static float2 vertex_input_3;
			static float4 vertex_output_2;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION;
				float3 vertex_input_1 : NORMAL;
				float4 vertex_input_2 : COLOR;
				float2 vertex_input_3 : TEXCOORD0;
				float2 vertex_input_4 : TEXCOORD1;
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_0 : UNKNOWN0;
				float4 vertex_output_1 : TEXCOORD0; // vs_TEXCOORD0
				float4 vertex_output_2 : TEXCOORD1; // vs_TEXCOORD1
				float4 vertex_output_3 : UNKNOWN3;
				float4 vertex_output_4 : TEXCOORD2; // vs_TEXCOORD2
				float4 gl_Position : SV_Position;
			};

			static float2 vertex_unnamed_9;
			static float4 vertex_unnamed_36;
			static float4 vertex_unnamed_60;
			static float4 vertex_unnamed_86;
			static float vertex_unnamed_138;
			static float vertex_unnamed_236;
			static float2 vertex_unnamed_276;
			static float vertex_unnamed_294;
			static bool vertex_unnamed_320;
			static bool vertex_unnamed_437;
			static float vertex_unnamed_444;

			void vert_main()
			{
				vertex_unnamed_9 = vertex_input_0.xy + float2(_VertexOffsetX, _VertexOffsetY);
				vertex_unnamed_36 = vertex_unnamed_9.yyyy * unity_ObjectToWorld__array[1];
				vertex_unnamed_36 = (unity_ObjectToWorld__array[0] * vertex_unnamed_9.xxxx) + vertex_unnamed_36;
				vertex_unnamed_36 = (unity_ObjectToWorld__array[2] * vertex_input_0.zzzz) + vertex_unnamed_36;
				vertex_unnamed_60 = vertex_unnamed_36 + unity_ObjectToWorld__array[3];
				float3 vertex_unnamed_74 = (unity_ObjectToWorld__array[3].xyz * vertex_input_0.www) + vertex_unnamed_36.xyz;
				vertex_unnamed_36 = float4(vertex_unnamed_74.x, vertex_unnamed_74.y, vertex_unnamed_74.z, vertex_unnamed_36.w);
				float3 vertex_unnamed_83 = (-vertex_unnamed_36.xyz) + _WorldSpaceCameraPos;
				vertex_unnamed_36 = float4(vertex_unnamed_83.x, vertex_unnamed_83.y, vertex_unnamed_83.z, vertex_unnamed_36.w);
				vertex_unnamed_86 = vertex_unnamed_60.yyyy * unity_MatrixVP__array[1];
				vertex_unnamed_86 = (unity_MatrixVP__array[0] * vertex_unnamed_60.xxxx) + vertex_unnamed_86;
				vertex_unnamed_86 = (unity_MatrixVP__array[2] * vertex_unnamed_60.zzzz) + vertex_unnamed_86;
				vertex_unnamed_60 = (unity_MatrixVP__array[3] * vertex_unnamed_60.wwww) + vertex_unnamed_86;
				gl_Position = vertex_unnamed_60;
				vertex_unnamed_86 = vertex_input_2 * _FaceColor;
				float3 vertex_unnamed_132 = vertex_unnamed_86.www * vertex_unnamed_86.xyz;
				vertex_unnamed_86 = float4(vertex_unnamed_132.x, vertex_unnamed_132.y, vertex_unnamed_132.z, vertex_unnamed_86.w);
				vertex_output_0 = vertex_unnamed_86;
				vertex_unnamed_138 = dot(vertex_unnamed_36.xyz, vertex_unnamed_36.xyz);
				vertex_unnamed_138 = rsqrt(vertex_unnamed_138);
				float3 vertex_unnamed_150 = vertex_unnamed_138.xxx * vertex_unnamed_36.xyz;
				vertex_unnamed_36 = float4(vertex_unnamed_150.x, vertex_unnamed_150.y, vertex_unnamed_150.z, vertex_unnamed_36.w);
				vertex_unnamed_60.x = dot(vertex_input_1, unity_WorldToObject__array[0].xyz);
				vertex_unnamed_60.y = dot(vertex_input_1, unity_WorldToObject__array[1].xyz);
				vertex_unnamed_60.z = dot(vertex_input_1, unity_WorldToObject__array[2].xyz);
				vertex_unnamed_138 = dot(vertex_unnamed_60.xyz, vertex_unnamed_60.xyz);
				vertex_unnamed_138 = rsqrt(vertex_unnamed_138);
				float3 vertex_unnamed_186 = vertex_unnamed_138.xxx * vertex_unnamed_60.xyz;
				vertex_unnamed_60 = float4(vertex_unnamed_186.x, vertex_unnamed_186.y, vertex_unnamed_186.z, vertex_unnamed_60.w);
				vertex_unnamed_138 = dot(vertex_unnamed_60.xyz, vertex_unnamed_36.xyz);
				float2 vertex_unnamed_201 = _ScreenParams.yy * glstate_matrix_projection__array[1].xy;
				vertex_unnamed_36 = float4(vertex_unnamed_201.x, vertex_unnamed_201.y, vertex_unnamed_36.z, vertex_unnamed_36.w);
				float2 vertex_unnamed_213 = (glstate_matrix_projection__array[0].xy * _ScreenParams.xx) + vertex_unnamed_36.xy;
				vertex_unnamed_36 = float4(vertex_unnamed_213.x, vertex_unnamed_213.y, vertex_unnamed_36.z, vertex_unnamed_36.w);
				float2 vertex_unnamed_226 = abs(vertex_unnamed_36.xy) * float2(_ScaleX, _ScaleY);
				vertex_unnamed_36 = float4(vertex_unnamed_226.x, vertex_unnamed_226.y, vertex_unnamed_36.z, vertex_unnamed_36.w);
				float2 vertex_unnamed_233 = vertex_unnamed_60.ww / vertex_unnamed_36.xy;
				vertex_unnamed_36 = float4(vertex_unnamed_233.x, vertex_unnamed_233.y, vertex_unnamed_36.z, vertex_unnamed_36.w);
				vertex_unnamed_236 = dot(vertex_unnamed_36.xy, vertex_unnamed_36.xy);
				float2 vertex_unnamed_254 = (float2(_MaskSoftnessX, _MaskSoftnessY) * 0.25f.xx) + vertex_unnamed_36.xy;
				vertex_unnamed_36 = float4(vertex_unnamed_254.x, vertex_unnamed_254.y, vertex_unnamed_36.z, vertex_unnamed_36.w);
				float2 vertex_unnamed_260 = 0.25f.xx / vertex_unnamed_36.xy;
				vertex_output_4 = float4(vertex_output_4.x, vertex_output_4.y, vertex_unnamed_260.x, vertex_unnamed_260.y);
				vertex_unnamed_236 = rsqrt(vertex_unnamed_236);
				vertex_unnamed_36.x = abs(vertex_input_4.y) * _GradientScale;
				vertex_unnamed_276.x = _Sharpness + 1.0f;
				vertex_unnamed_36.x = vertex_unnamed_276.x * vertex_unnamed_36.x;
				vertex_unnamed_276.x = vertex_unnamed_236 * vertex_unnamed_36.x;
				vertex_unnamed_294 = (-_PerspectiveFilter) + 1.0f;
				vertex_unnamed_294 *= abs(vertex_unnamed_276.x);
				vertex_unnamed_236 = (vertex_unnamed_236 * vertex_unnamed_36.x) + (-vertex_unnamed_294);
				vertex_unnamed_138 = (abs(vertex_unnamed_138) * vertex_unnamed_236) + vertex_unnamed_294;
				vertex_unnamed_320 = glstate_matrix_projection__array[3].w == 0.0f;
				float vertex_unnamed_328;
				if (vertex_unnamed_320)
				{
					vertex_unnamed_328 = vertex_unnamed_138;
				}
				else
				{
					vertex_unnamed_328 = vertex_unnamed_276.x;
				}
				vertex_unnamed_138 = vertex_unnamed_328;
				vertex_unnamed_236 = _OutlineSoftness * _ScaleRatioA;
				vertex_unnamed_236 = (vertex_unnamed_236 * vertex_unnamed_138) + 1.0f;
				vertex_unnamed_36.x = vertex_unnamed_138 / vertex_unnamed_236;
				vertex_unnamed_138 = _OutlineWidth * _ScaleRatioA;
				vertex_unnamed_138 = vertex_unnamed_36.x * vertex_unnamed_138;
				vertex_unnamed_236 = min(vertex_unnamed_138, 1.0f);
				vertex_unnamed_236 = sqrt(vertex_unnamed_236);
				vertex_unnamed_60.w = vertex_input_2.w * _OutlineColor.w;
				float3 vertex_unnamed_377 = vertex_unnamed_60.www * _OutlineColor.xyz;
				vertex_unnamed_60 = float4(vertex_unnamed_377.x, vertex_unnamed_377.y, vertex_unnamed_377.z, vertex_unnamed_60.w);
				vertex_unnamed_60 = (-vertex_unnamed_86) + vertex_unnamed_60;
				vertex_output_3 = (vertex_unnamed_236.xxxx * vertex_unnamed_60) + vertex_unnamed_86;
				vertex_unnamed_60 = max(_ClipRect, (-20000000000.0f).xxxx);
				vertex_unnamed_60 = min(vertex_unnamed_60, 20000000000.0f.xxxx);
				vertex_unnamed_276 = vertex_unnamed_9 + (-vertex_unnamed_60.xy);
				vertex_unnamed_9 = (vertex_unnamed_9 * 2.0f.xx) + (-vertex_unnamed_60.xy);
				float2 vertex_unnamed_418 = (-vertex_unnamed_60.zw) + vertex_unnamed_9;
				vertex_output_4 = float4(vertex_unnamed_418.x, vertex_unnamed_418.y, vertex_output_4.z, vertex_output_4.w);
				vertex_unnamed_9 = (-vertex_unnamed_60.xy) + vertex_unnamed_60.zw;
				float2 vertex_unnamed_430 = vertex_unnamed_276 / vertex_unnamed_9;
				vertex_output_1 = float4(vertex_output_1.x, vertex_output_1.y, vertex_unnamed_430.x, vertex_unnamed_430.y);
				vertex_output_1 = float4(vertex_input_3.x, vertex_input_3.y, vertex_output_1.z, vertex_output_1.w);
				vertex_unnamed_437 = 0.0f >= vertex_input_4.y;
				vertex_unnamed_9.x = float(vertex_unnamed_437);
				vertex_unnamed_444 = (-_WeightNormal) + _WeightBold;
				vertex_unnamed_9.x = (vertex_unnamed_9.x * vertex_unnamed_444) + _WeightNormal;
				vertex_unnamed_9.x = (vertex_unnamed_9.x * 0.25f) + _FaceDilate;
				vertex_unnamed_9.x *= _ScaleRatioA;
				vertex_unnamed_9.x = ((-vertex_unnamed_9.x) * 0.5f) + 0.5f;
				vertex_unnamed_36.w = (vertex_unnamed_9.x * vertex_unnamed_36.x) + (-0.5f);
				vertex_output_2 = float4(vertex_unnamed_36.xw.x, vertex_output_2.y, vertex_output_2.z, vertex_unnamed_36.xw.y);
				vertex_output_2.y = ((-vertex_unnamed_138) * 0.5f) + vertex_unnamed_36.w;
				vertex_output_2.z = (vertex_unnamed_138 * 0.5f) + vertex_unnamed_36.w;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				unity_ObjectToWorld__array[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				unity_ObjectToWorld__array[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				unity_ObjectToWorld__array[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				unity_ObjectToWorld__array[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				unity_WorldToObject__array[0] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				unity_WorldToObject__array[1] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				unity_WorldToObject__array[2] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				unity_WorldToObject__array[3] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

				glstate_matrix_projection__array[0] = float4(glstate_matrix_projection[0][0], glstate_matrix_projection[1][0], glstate_matrix_projection[2][0], glstate_matrix_projection[3][0]);
				glstate_matrix_projection__array[1] = float4(glstate_matrix_projection[0][1], glstate_matrix_projection[1][1], glstate_matrix_projection[2][1], glstate_matrix_projection[3][1]);
				glstate_matrix_projection__array[2] = float4(glstate_matrix_projection[0][2], glstate_matrix_projection[1][2], glstate_matrix_projection[2][2], glstate_matrix_projection[3][2]);
				glstate_matrix_projection__array[3] = float4(glstate_matrix_projection[0][3], glstate_matrix_projection[1][3], glstate_matrix_projection[2][3], glstate_matrix_projection[3][3]);

				unity_MatrixVP__array[0] = float4(unity_MatrixVP[0][0], unity_MatrixVP[1][0], unity_MatrixVP[2][0], unity_MatrixVP[3][0]);
				unity_MatrixVP__array[1] = float4(unity_MatrixVP[0][1], unity_MatrixVP[1][1], unity_MatrixVP[2][1], unity_MatrixVP[3][1]);
				unity_MatrixVP__array[2] = float4(unity_MatrixVP[0][2], unity_MatrixVP[1][2], unity_MatrixVP[2][2], unity_MatrixVP[3][2]);
				unity_MatrixVP__array[3] = float4(unity_MatrixVP[0][3], unity_MatrixVP[1][3], unity_MatrixVP[2][3], unity_MatrixVP[3][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_2 = stage_input.vertex_input_2;
				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_4 = stage_input.vertex_input_4;
				vertex_input_3 = stage_input.vertex_input_3;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_0 = vertex_output_0;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				return stage_output;
			}

			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float4 fragment_output_0;
			static float4 fragment_input_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_0 : UNKNOWN0;
				float4 fragment_input_1 : TEXCOORD0; // vs_TEXCOORD0
				float4 fragment_input_2 : TEXCOORD1; // vs_TEXCOORD1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static float fragment_unnamed_8;

			void frag_main()
			{
				fragment_unnamed_8 = _MainTex.Sample(sampler_MainTex, fragment_input_1.xy).w;
				fragment_unnamed_8 = (fragment_unnamed_8 * fragment_input_2.x) + (-fragment_input_2.w);
				fragment_unnamed_8 = clamp(fragment_unnamed_8, 0.0f, 1.0f);
				fragment_output_0 = fragment_unnamed_8.xxxx * fragment_input_0;
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

			float3 _WorldSpaceCameraPos;
			float4 _ScreenParams;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4x4 glstate_matrix_projection;
			float4x4 unity_MatrixVP;
			float4 _FaceColor;
			float _FaceDilate;
			float _OutlineSoftness;
			float4 _OutlineColor;
			float _OutlineWidth;
			float _WeightNormal;
			float _WeightBold;
			float _ScaleRatioA;
			float _VertexOffsetX;
			float _VertexOffsetY;
			float4 _ClipRect;
			float _MaskSoftnessX;
			float _MaskSoftnessY;
			float _GradientScale;
			float _ScaleX;
			float _ScaleY;
			float _PerspectiveFilter;
			float _Sharpness;

			static float4 unity_ObjectToWorld__array[4];
			static float4 unity_WorldToObject__array[4];
			static float4 glstate_matrix_projection__array[4];
			static float4 unity_MatrixVP__array[4];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_2;
			static float4 vertex_output_0;
			static float3 vertex_input_1;
			static float4 vertex_output_4;
			static float2 vertex_input_4;
			static float4 vertex_output_3;
			static float4 vertex_output_1;
			static float2 vertex_input_3;
			static float4 vertex_output_2;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION;
				float3 vertex_input_1 : NORMAL;
				float4 vertex_input_2 : COLOR;
				float2 vertex_input_3 : TEXCOORD0;
				float2 vertex_input_4 : TEXCOORD1;
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_0 : UNKNOWN0;
				float4 vertex_output_1 : TEXCOORD0; // vs_TEXCOORD0
				float4 vertex_output_2 : TEXCOORD1; // vs_TEXCOORD1
				float4 vertex_output_3 : UNKNOWN3;
				float4 vertex_output_4 : TEXCOORD2; // vs_TEXCOORD2
				float4 gl_Position : SV_Position;
			};

			static float2 vertex_unnamed_9;
			static float4 vertex_unnamed_36;
			static float4 vertex_unnamed_60;
			static float4 vertex_unnamed_86;
			static float vertex_unnamed_138;
			static float vertex_unnamed_236;
			static float2 vertex_unnamed_276;
			static float vertex_unnamed_294;
			static bool vertex_unnamed_320;
			static bool vertex_unnamed_437;
			static float vertex_unnamed_444;

			void vert_main()
			{
				vertex_unnamed_9 = vertex_input_0.xy + float2(_VertexOffsetX, _VertexOffsetY);
				vertex_unnamed_36 = vertex_unnamed_9.yyyy * unity_ObjectToWorld__array[1];
				vertex_unnamed_36 = (unity_ObjectToWorld__array[0] * vertex_unnamed_9.xxxx) + vertex_unnamed_36;
				vertex_unnamed_36 = (unity_ObjectToWorld__array[2] * vertex_input_0.zzzz) + vertex_unnamed_36;
				vertex_unnamed_60 = vertex_unnamed_36 + unity_ObjectToWorld__array[3];
				float3 vertex_unnamed_74 = (unity_ObjectToWorld__array[3].xyz * vertex_input_0.www) + vertex_unnamed_36.xyz;
				vertex_unnamed_36 = float4(vertex_unnamed_74.x, vertex_unnamed_74.y, vertex_unnamed_74.z, vertex_unnamed_36.w);
				float3 vertex_unnamed_83 = (-vertex_unnamed_36.xyz) + _WorldSpaceCameraPos;
				vertex_unnamed_36 = float4(vertex_unnamed_83.x, vertex_unnamed_83.y, vertex_unnamed_83.z, vertex_unnamed_36.w);
				vertex_unnamed_86 = vertex_unnamed_60.yyyy * unity_MatrixVP__array[1];
				vertex_unnamed_86 = (unity_MatrixVP__array[0] * vertex_unnamed_60.xxxx) + vertex_unnamed_86;
				vertex_unnamed_86 = (unity_MatrixVP__array[2] * vertex_unnamed_60.zzzz) + vertex_unnamed_86;
				vertex_unnamed_60 = (unity_MatrixVP__array[3] * vertex_unnamed_60.wwww) + vertex_unnamed_86;
				gl_Position = vertex_unnamed_60;
				vertex_unnamed_86 = vertex_input_2 * _FaceColor;
				float3 vertex_unnamed_132 = vertex_unnamed_86.www * vertex_unnamed_86.xyz;
				vertex_unnamed_86 = float4(vertex_unnamed_132.x, vertex_unnamed_132.y, vertex_unnamed_132.z, vertex_unnamed_86.w);
				vertex_output_0 = vertex_unnamed_86;
				vertex_unnamed_138 = dot(vertex_unnamed_36.xyz, vertex_unnamed_36.xyz);
				vertex_unnamed_138 = rsqrt(vertex_unnamed_138);
				float3 vertex_unnamed_150 = vertex_unnamed_138.xxx * vertex_unnamed_36.xyz;
				vertex_unnamed_36 = float4(vertex_unnamed_150.x, vertex_unnamed_150.y, vertex_unnamed_150.z, vertex_unnamed_36.w);
				vertex_unnamed_60.x = dot(vertex_input_1, unity_WorldToObject__array[0].xyz);
				vertex_unnamed_60.y = dot(vertex_input_1, unity_WorldToObject__array[1].xyz);
				vertex_unnamed_60.z = dot(vertex_input_1, unity_WorldToObject__array[2].xyz);
				vertex_unnamed_138 = dot(vertex_unnamed_60.xyz, vertex_unnamed_60.xyz);
				vertex_unnamed_138 = rsqrt(vertex_unnamed_138);
				float3 vertex_unnamed_186 = vertex_unnamed_138.xxx * vertex_unnamed_60.xyz;
				vertex_unnamed_60 = float4(vertex_unnamed_186.x, vertex_unnamed_186.y, vertex_unnamed_186.z, vertex_unnamed_60.w);
				vertex_unnamed_138 = dot(vertex_unnamed_60.xyz, vertex_unnamed_36.xyz);
				float2 vertex_unnamed_201 = _ScreenParams.yy * glstate_matrix_projection__array[1].xy;
				vertex_unnamed_36 = float4(vertex_unnamed_201.x, vertex_unnamed_201.y, vertex_unnamed_36.z, vertex_unnamed_36.w);
				float2 vertex_unnamed_213 = (glstate_matrix_projection__array[0].xy * _ScreenParams.xx) + vertex_unnamed_36.xy;
				vertex_unnamed_36 = float4(vertex_unnamed_213.x, vertex_unnamed_213.y, vertex_unnamed_36.z, vertex_unnamed_36.w);
				float2 vertex_unnamed_226 = abs(vertex_unnamed_36.xy) * float2(_ScaleX, _ScaleY);
				vertex_unnamed_36 = float4(vertex_unnamed_226.x, vertex_unnamed_226.y, vertex_unnamed_36.z, vertex_unnamed_36.w);
				float2 vertex_unnamed_233 = vertex_unnamed_60.ww / vertex_unnamed_36.xy;
				vertex_unnamed_36 = float4(vertex_unnamed_233.x, vertex_unnamed_233.y, vertex_unnamed_36.z, vertex_unnamed_36.w);
				vertex_unnamed_236 = dot(vertex_unnamed_36.xy, vertex_unnamed_36.xy);
				float2 vertex_unnamed_254 = (float2(_MaskSoftnessX, _MaskSoftnessY) * 0.25f.xx) + vertex_unnamed_36.xy;
				vertex_unnamed_36 = float4(vertex_unnamed_254.x, vertex_unnamed_254.y, vertex_unnamed_36.z, vertex_unnamed_36.w);
				float2 vertex_unnamed_260 = 0.25f.xx / vertex_unnamed_36.xy;
				vertex_output_4 = float4(vertex_output_4.x, vertex_output_4.y, vertex_unnamed_260.x, vertex_unnamed_260.y);
				vertex_unnamed_236 = rsqrt(vertex_unnamed_236);
				vertex_unnamed_36.x = abs(vertex_input_4.y) * _GradientScale;
				vertex_unnamed_276.x = _Sharpness + 1.0f;
				vertex_unnamed_36.x = vertex_unnamed_276.x * vertex_unnamed_36.x;
				vertex_unnamed_276.x = vertex_unnamed_236 * vertex_unnamed_36.x;
				vertex_unnamed_294 = (-_PerspectiveFilter) + 1.0f;
				vertex_unnamed_294 *= abs(vertex_unnamed_276.x);
				vertex_unnamed_236 = (vertex_unnamed_236 * vertex_unnamed_36.x) + (-vertex_unnamed_294);
				vertex_unnamed_138 = (abs(vertex_unnamed_138) * vertex_unnamed_236) + vertex_unnamed_294;
				vertex_unnamed_320 = glstate_matrix_projection__array[3].w == 0.0f;
				float vertex_unnamed_328;
				if (vertex_unnamed_320)
				{
					vertex_unnamed_328 = vertex_unnamed_138;
				}
				else
				{
					vertex_unnamed_328 = vertex_unnamed_276.x;
				}
				vertex_unnamed_138 = vertex_unnamed_328;
				vertex_unnamed_236 = _OutlineSoftness * _ScaleRatioA;
				vertex_unnamed_236 = (vertex_unnamed_236 * vertex_unnamed_138) + 1.0f;
				vertex_unnamed_36.x = vertex_unnamed_138 / vertex_unnamed_236;
				vertex_unnamed_138 = _OutlineWidth * _ScaleRatioA;
				vertex_unnamed_138 = vertex_unnamed_36.x * vertex_unnamed_138;
				vertex_unnamed_236 = min(vertex_unnamed_138, 1.0f);
				vertex_unnamed_236 = sqrt(vertex_unnamed_236);
				vertex_unnamed_60.w = vertex_input_2.w * _OutlineColor.w;
				float3 vertex_unnamed_377 = vertex_unnamed_60.www * _OutlineColor.xyz;
				vertex_unnamed_60 = float4(vertex_unnamed_377.x, vertex_unnamed_377.y, vertex_unnamed_377.z, vertex_unnamed_60.w);
				vertex_unnamed_60 = (-vertex_unnamed_86) + vertex_unnamed_60;
				vertex_output_3 = (vertex_unnamed_236.xxxx * vertex_unnamed_60) + vertex_unnamed_86;
				vertex_unnamed_60 = max(_ClipRect, (-20000000000.0f).xxxx);
				vertex_unnamed_60 = min(vertex_unnamed_60, 20000000000.0f.xxxx);
				vertex_unnamed_276 = vertex_unnamed_9 + (-vertex_unnamed_60.xy);
				vertex_unnamed_9 = (vertex_unnamed_9 * 2.0f.xx) + (-vertex_unnamed_60.xy);
				float2 vertex_unnamed_418 = (-vertex_unnamed_60.zw) + vertex_unnamed_9;
				vertex_output_4 = float4(vertex_unnamed_418.x, vertex_unnamed_418.y, vertex_output_4.z, vertex_output_4.w);
				vertex_unnamed_9 = (-vertex_unnamed_60.xy) + vertex_unnamed_60.zw;
				float2 vertex_unnamed_430 = vertex_unnamed_276 / vertex_unnamed_9;
				vertex_output_1 = float4(vertex_output_1.x, vertex_output_1.y, vertex_unnamed_430.x, vertex_unnamed_430.y);
				vertex_output_1 = float4(vertex_input_3.x, vertex_input_3.y, vertex_output_1.z, vertex_output_1.w);
				vertex_unnamed_437 = 0.0f >= vertex_input_4.y;
				vertex_unnamed_9.x = float(vertex_unnamed_437);
				vertex_unnamed_444 = (-_WeightNormal) + _WeightBold;
				vertex_unnamed_9.x = (vertex_unnamed_9.x * vertex_unnamed_444) + _WeightNormal;
				vertex_unnamed_9.x = (vertex_unnamed_9.x * 0.25f) + _FaceDilate;
				vertex_unnamed_9.x *= _ScaleRatioA;
				vertex_unnamed_9.x = ((-vertex_unnamed_9.x) * 0.5f) + 0.5f;
				vertex_unnamed_36.w = (vertex_unnamed_9.x * vertex_unnamed_36.x) + (-0.5f);
				vertex_output_2 = float4(vertex_unnamed_36.xw.x, vertex_output_2.y, vertex_output_2.z, vertex_unnamed_36.xw.y);
				vertex_output_2.y = ((-vertex_unnamed_138) * 0.5f) + vertex_unnamed_36.w;
				vertex_output_2.z = (vertex_unnamed_138 * 0.5f) + vertex_unnamed_36.w;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				unity_ObjectToWorld__array[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				unity_ObjectToWorld__array[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				unity_ObjectToWorld__array[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				unity_ObjectToWorld__array[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				unity_WorldToObject__array[0] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				unity_WorldToObject__array[1] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				unity_WorldToObject__array[2] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				unity_WorldToObject__array[3] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

				glstate_matrix_projection__array[0] = float4(glstate_matrix_projection[0][0], glstate_matrix_projection[1][0], glstate_matrix_projection[2][0], glstate_matrix_projection[3][0]);
				glstate_matrix_projection__array[1] = float4(glstate_matrix_projection[0][1], glstate_matrix_projection[1][1], glstate_matrix_projection[2][1], glstate_matrix_projection[3][1]);
				glstate_matrix_projection__array[2] = float4(glstate_matrix_projection[0][2], glstate_matrix_projection[1][2], glstate_matrix_projection[2][2], glstate_matrix_projection[3][2]);
				glstate_matrix_projection__array[3] = float4(glstate_matrix_projection[0][3], glstate_matrix_projection[1][3], glstate_matrix_projection[2][3], glstate_matrix_projection[3][3]);

				unity_MatrixVP__array[0] = float4(unity_MatrixVP[0][0], unity_MatrixVP[1][0], unity_MatrixVP[2][0], unity_MatrixVP[3][0]);
				unity_MatrixVP__array[1] = float4(unity_MatrixVP[0][1], unity_MatrixVP[1][1], unity_MatrixVP[2][1], unity_MatrixVP[3][1]);
				unity_MatrixVP__array[2] = float4(unity_MatrixVP[0][2], unity_MatrixVP[1][2], unity_MatrixVP[2][2], unity_MatrixVP[3][2]);
				unity_MatrixVP__array[3] = float4(unity_MatrixVP[0][3], unity_MatrixVP[1][3], unity_MatrixVP[2][3], unity_MatrixVP[3][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_2 = stage_input.vertex_input_2;
				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_4 = stage_input.vertex_input_4;
				vertex_input_3 = stage_input.vertex_input_3;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_0 = vertex_output_0;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				return stage_output;
			}

			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float4 fragment_input_0;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_0 : UNKNOWN0;
				float4 fragment_input_1 : TEXCOORD0; // vs_TEXCOORD0
				float4 fragment_input_2 : TEXCOORD1; // vs_TEXCOORD1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static float fragment_unnamed_8;
			static float fragment_unnamed_44;
			static float4 fragment_unnamed_53;
			static bool fragment_unnamed_63;

			void frag_main()
			{
				fragment_unnamed_8 = _MainTex.Sample(sampler_MainTex, fragment_input_1.xy).w;
				fragment_unnamed_8 = (fragment_unnamed_8 * fragment_input_2.x) + (-fragment_input_2.w);
				fragment_unnamed_8 = clamp(fragment_unnamed_8, 0.0f, 1.0f);
				fragment_unnamed_44 = (fragment_input_0.w * fragment_unnamed_8) + (-0.001000000047497451305389404296875f);
				fragment_unnamed_53 = fragment_unnamed_8.xxxx * fragment_input_0;
				fragment_output_0 = fragment_unnamed_53;
				fragment_unnamed_63 = fragment_unnamed_44 < 0.0f;
				if ((int(fragment_unnamed_63) * (-1)) != 0)
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

			float3 _WorldSpaceCameraPos;
			float4 _ScreenParams;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4x4 glstate_matrix_projection;
			float4x4 unity_MatrixVP;
			float4 _FaceColor;
			float _FaceDilate;
			float _OutlineSoftness;
			float4 _OutlineColor;
			float _OutlineWidth;
			float _WeightNormal;
			float _WeightBold;
			float _ScaleRatioA;
			float _VertexOffsetX;
			float _VertexOffsetY;
			float4 _ClipRect;
			float _MaskSoftnessX;
			float _MaskSoftnessY;
			float _GradientScale;
			float _ScaleX;
			float _ScaleY;
			float _PerspectiveFilter;
			float _Sharpness;

			static float4 unity_ObjectToWorld__array[4];
			static float4 unity_WorldToObject__array[4];
			static float4 glstate_matrix_projection__array[4];
			static float4 unity_MatrixVP__array[4];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_2;
			static float4 vertex_output_0;
			static float3 vertex_input_1;
			static float4 vertex_output_3;
			static float2 vertex_input_4;
			static float4 vertex_output_4;
			static float4 vertex_output_1;
			static float2 vertex_input_3;
			static float4 vertex_output_2;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION;
				float3 vertex_input_1 : NORMAL;
				float4 vertex_input_2 : COLOR;
				float2 vertex_input_3 : TEXCOORD0;
				float2 vertex_input_4 : TEXCOORD1;
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_0 : UNKNOWN0;
				float4 vertex_output_1 : TEXCOORD0; // vs_TEXCOORD0
				float4 vertex_output_2 : TEXCOORD1; // vs_TEXCOORD1
				float4 vertex_output_3 : TEXCOORD2; // vs_TEXCOORD2
				float4 vertex_output_4 : UNKNOWN4;
				float4 gl_Position : SV_Position;
			};

			static float2 vertex_unnamed_9;
			static float4 vertex_unnamed_36;
			static float4 vertex_unnamed_60;
			static float4 vertex_unnamed_86;
			static float vertex_unnamed_138;
			static float vertex_unnamed_236;
			static float2 vertex_unnamed_276;
			static float vertex_unnamed_294;
			static bool vertex_unnamed_320;
			static bool vertex_unnamed_437;
			static float vertex_unnamed_444;

			void vert_main()
			{
				vertex_unnamed_9 = vertex_input_0.xy + float2(_VertexOffsetX, _VertexOffsetY);
				vertex_unnamed_36 = vertex_unnamed_9.yyyy * unity_ObjectToWorld__array[1];
				vertex_unnamed_36 = (unity_ObjectToWorld__array[0] * vertex_unnamed_9.xxxx) + vertex_unnamed_36;
				vertex_unnamed_36 = (unity_ObjectToWorld__array[2] * vertex_input_0.zzzz) + vertex_unnamed_36;
				vertex_unnamed_60 = vertex_unnamed_36 + unity_ObjectToWorld__array[3];
				float3 vertex_unnamed_74 = (unity_ObjectToWorld__array[3].xyz * vertex_input_0.www) + vertex_unnamed_36.xyz;
				vertex_unnamed_36 = float4(vertex_unnamed_74.x, vertex_unnamed_74.y, vertex_unnamed_74.z, vertex_unnamed_36.w);
				float3 vertex_unnamed_83 = (-vertex_unnamed_36.xyz) + _WorldSpaceCameraPos;
				vertex_unnamed_36 = float4(vertex_unnamed_83.x, vertex_unnamed_83.y, vertex_unnamed_83.z, vertex_unnamed_36.w);
				vertex_unnamed_86 = vertex_unnamed_60.yyyy * unity_MatrixVP__array[1];
				vertex_unnamed_86 = (unity_MatrixVP__array[0] * vertex_unnamed_60.xxxx) + vertex_unnamed_86;
				vertex_unnamed_86 = (unity_MatrixVP__array[2] * vertex_unnamed_60.zzzz) + vertex_unnamed_86;
				vertex_unnamed_60 = (unity_MatrixVP__array[3] * vertex_unnamed_60.wwww) + vertex_unnamed_86;
				gl_Position = vertex_unnamed_60;
				vertex_unnamed_86 = vertex_input_2 * _FaceColor;
				float3 vertex_unnamed_132 = vertex_unnamed_86.www * vertex_unnamed_86.xyz;
				vertex_unnamed_86 = float4(vertex_unnamed_132.x, vertex_unnamed_132.y, vertex_unnamed_132.z, vertex_unnamed_86.w);
				vertex_output_0 = vertex_unnamed_86;
				vertex_unnamed_138 = dot(vertex_unnamed_36.xyz, vertex_unnamed_36.xyz);
				vertex_unnamed_138 = rsqrt(vertex_unnamed_138);
				float3 vertex_unnamed_150 = vertex_unnamed_138.xxx * vertex_unnamed_36.xyz;
				vertex_unnamed_36 = float4(vertex_unnamed_150.x, vertex_unnamed_150.y, vertex_unnamed_150.z, vertex_unnamed_36.w);
				vertex_unnamed_60.x = dot(vertex_input_1, unity_WorldToObject__array[0].xyz);
				vertex_unnamed_60.y = dot(vertex_input_1, unity_WorldToObject__array[1].xyz);
				vertex_unnamed_60.z = dot(vertex_input_1, unity_WorldToObject__array[2].xyz);
				vertex_unnamed_138 = dot(vertex_unnamed_60.xyz, vertex_unnamed_60.xyz);
				vertex_unnamed_138 = rsqrt(vertex_unnamed_138);
				float3 vertex_unnamed_186 = vertex_unnamed_138.xxx * vertex_unnamed_60.xyz;
				vertex_unnamed_60 = float4(vertex_unnamed_186.x, vertex_unnamed_186.y, vertex_unnamed_186.z, vertex_unnamed_60.w);
				vertex_unnamed_138 = dot(vertex_unnamed_60.xyz, vertex_unnamed_36.xyz);
				float2 vertex_unnamed_201 = _ScreenParams.yy * glstate_matrix_projection__array[1].xy;
				vertex_unnamed_36 = float4(vertex_unnamed_201.x, vertex_unnamed_201.y, vertex_unnamed_36.z, vertex_unnamed_36.w);
				float2 vertex_unnamed_213 = (glstate_matrix_projection__array[0].xy * _ScreenParams.xx) + vertex_unnamed_36.xy;
				vertex_unnamed_36 = float4(vertex_unnamed_213.x, vertex_unnamed_213.y, vertex_unnamed_36.z, vertex_unnamed_36.w);
				float2 vertex_unnamed_226 = abs(vertex_unnamed_36.xy) * float2(_ScaleX, _ScaleY);
				vertex_unnamed_36 = float4(vertex_unnamed_226.x, vertex_unnamed_226.y, vertex_unnamed_36.z, vertex_unnamed_36.w);
				float2 vertex_unnamed_233 = vertex_unnamed_60.ww / vertex_unnamed_36.xy;
				vertex_unnamed_36 = float4(vertex_unnamed_233.x, vertex_unnamed_233.y, vertex_unnamed_36.z, vertex_unnamed_36.w);
				vertex_unnamed_236 = dot(vertex_unnamed_36.xy, vertex_unnamed_36.xy);
				float2 vertex_unnamed_254 = (float2(_MaskSoftnessX, _MaskSoftnessY) * 0.25f.xx) + vertex_unnamed_36.xy;
				vertex_unnamed_36 = float4(vertex_unnamed_254.x, vertex_unnamed_254.y, vertex_unnamed_36.z, vertex_unnamed_36.w);
				float2 vertex_unnamed_260 = 0.25f.xx / vertex_unnamed_36.xy;
				vertex_output_3 = float4(vertex_output_3.x, vertex_output_3.y, vertex_unnamed_260.x, vertex_unnamed_260.y);
				vertex_unnamed_236 = rsqrt(vertex_unnamed_236);
				vertex_unnamed_36.x = abs(vertex_input_4.y) * _GradientScale;
				vertex_unnamed_276.x = _Sharpness + 1.0f;
				vertex_unnamed_36.x = vertex_unnamed_276.x * vertex_unnamed_36.x;
				vertex_unnamed_276.x = vertex_unnamed_236 * vertex_unnamed_36.x;
				vertex_unnamed_294 = (-_PerspectiveFilter) + 1.0f;
				vertex_unnamed_294 *= abs(vertex_unnamed_276.x);
				vertex_unnamed_236 = (vertex_unnamed_236 * vertex_unnamed_36.x) + (-vertex_unnamed_294);
				vertex_unnamed_138 = (abs(vertex_unnamed_138) * vertex_unnamed_236) + vertex_unnamed_294;
				vertex_unnamed_320 = glstate_matrix_projection__array[3].w == 0.0f;
				float vertex_unnamed_328;
				if (vertex_unnamed_320)
				{
					vertex_unnamed_328 = vertex_unnamed_138;
				}
				else
				{
					vertex_unnamed_328 = vertex_unnamed_276.x;
				}
				vertex_unnamed_138 = vertex_unnamed_328;
				vertex_unnamed_236 = _OutlineSoftness * _ScaleRatioA;
				vertex_unnamed_236 = (vertex_unnamed_236 * vertex_unnamed_138) + 1.0f;
				vertex_unnamed_36.x = vertex_unnamed_138 / vertex_unnamed_236;
				vertex_unnamed_138 = _OutlineWidth * _ScaleRatioA;
				vertex_unnamed_138 = vertex_unnamed_36.x * vertex_unnamed_138;
				vertex_unnamed_236 = min(vertex_unnamed_138, 1.0f);
				vertex_unnamed_236 = sqrt(vertex_unnamed_236);
				vertex_unnamed_60.w = vertex_input_2.w * _OutlineColor.w;
				float3 vertex_unnamed_377 = vertex_unnamed_60.www * _OutlineColor.xyz;
				vertex_unnamed_60 = float4(vertex_unnamed_377.x, vertex_unnamed_377.y, vertex_unnamed_377.z, vertex_unnamed_60.w);
				vertex_unnamed_60 = (-vertex_unnamed_86) + vertex_unnamed_60;
				vertex_output_4 = (vertex_unnamed_236.xxxx * vertex_unnamed_60) + vertex_unnamed_86;
				vertex_unnamed_60 = max(_ClipRect, (-20000000000.0f).xxxx);
				vertex_unnamed_60 = min(vertex_unnamed_60, 20000000000.0f.xxxx);
				vertex_unnamed_276 = vertex_unnamed_9 + (-vertex_unnamed_60.xy);
				vertex_unnamed_9 = (vertex_unnamed_9 * 2.0f.xx) + (-vertex_unnamed_60.xy);
				float2 vertex_unnamed_418 = (-vertex_unnamed_60.zw) + vertex_unnamed_9;
				vertex_output_3 = float4(vertex_unnamed_418.x, vertex_unnamed_418.y, vertex_output_3.z, vertex_output_3.w);
				vertex_unnamed_9 = (-vertex_unnamed_60.xy) + vertex_unnamed_60.zw;
				float2 vertex_unnamed_430 = vertex_unnamed_276 / vertex_unnamed_9;
				vertex_output_1 = float4(vertex_output_1.x, vertex_output_1.y, vertex_unnamed_430.x, vertex_unnamed_430.y);
				vertex_output_1 = float4(vertex_input_3.x, vertex_input_3.y, vertex_output_1.z, vertex_output_1.w);
				vertex_unnamed_437 = 0.0f >= vertex_input_4.y;
				vertex_unnamed_9.x = float(vertex_unnamed_437);
				vertex_unnamed_444 = (-_WeightNormal) + _WeightBold;
				vertex_unnamed_9.x = (vertex_unnamed_9.x * vertex_unnamed_444) + _WeightNormal;
				vertex_unnamed_9.x = (vertex_unnamed_9.x * 0.25f) + _FaceDilate;
				vertex_unnamed_9.x *= _ScaleRatioA;
				vertex_unnamed_9.x = ((-vertex_unnamed_9.x) * 0.5f) + 0.5f;
				vertex_unnamed_36.w = (vertex_unnamed_9.x * vertex_unnamed_36.x) + (-0.5f);
				vertex_output_2 = float4(vertex_unnamed_36.xw.x, vertex_output_2.y, vertex_output_2.z, vertex_unnamed_36.xw.y);
				vertex_output_2.y = ((-vertex_unnamed_138) * 0.5f) + vertex_unnamed_36.w;
				vertex_output_2.z = (vertex_unnamed_138 * 0.5f) + vertex_unnamed_36.w;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				unity_ObjectToWorld__array[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				unity_ObjectToWorld__array[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				unity_ObjectToWorld__array[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				unity_ObjectToWorld__array[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				unity_WorldToObject__array[0] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				unity_WorldToObject__array[1] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				unity_WorldToObject__array[2] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				unity_WorldToObject__array[3] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

				glstate_matrix_projection__array[0] = float4(glstate_matrix_projection[0][0], glstate_matrix_projection[1][0], glstate_matrix_projection[2][0], glstate_matrix_projection[3][0]);
				glstate_matrix_projection__array[1] = float4(glstate_matrix_projection[0][1], glstate_matrix_projection[1][1], glstate_matrix_projection[2][1], glstate_matrix_projection[3][1]);
				glstate_matrix_projection__array[2] = float4(glstate_matrix_projection[0][2], glstate_matrix_projection[1][2], glstate_matrix_projection[2][2], glstate_matrix_projection[3][2]);
				glstate_matrix_projection__array[3] = float4(glstate_matrix_projection[0][3], glstate_matrix_projection[1][3], glstate_matrix_projection[2][3], glstate_matrix_projection[3][3]);

				unity_MatrixVP__array[0] = float4(unity_MatrixVP[0][0], unity_MatrixVP[1][0], unity_MatrixVP[2][0], unity_MatrixVP[3][0]);
				unity_MatrixVP__array[1] = float4(unity_MatrixVP[0][1], unity_MatrixVP[1][1], unity_MatrixVP[2][1], unity_MatrixVP[3][1]);
				unity_MatrixVP__array[2] = float4(unity_MatrixVP[0][2], unity_MatrixVP[1][2], unity_MatrixVP[2][2], unity_MatrixVP[3][2]);
				unity_MatrixVP__array[3] = float4(unity_MatrixVP[0][3], unity_MatrixVP[1][3], unity_MatrixVP[2][3], unity_MatrixVP[3][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_2 = stage_input.vertex_input_2;
				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_4 = stage_input.vertex_input_4;
				vertex_input_3 = stage_input.vertex_input_3;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_0 = vertex_output_0;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				return stage_output;
			}

			float4 _ClipRect;

			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

			static float4 fragment_input_3;
			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float4 fragment_input_0;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_0 : UNKNOWN0;
				float4 fragment_input_1 : TEXCOORD0; // vs_TEXCOORD0
				float4 fragment_input_2 : TEXCOORD1; // vs_TEXCOORD1
				float4 fragment_input_3 : TEXCOORD2; // vs_TEXCOORD2
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static float2 fragment_unnamed_9;
			static float fragment_unnamed_53;
			static float4 fragment_unnamed_83;

			void frag_main()
			{
				fragment_unnamed_9 = (-_ClipRect.xy) + _ClipRect.zw;
				fragment_unnamed_9 += (-abs(fragment_input_3.xy));
				fragment_unnamed_9 *= fragment_input_3.zw;
				fragment_unnamed_9 = clamp(fragment_unnamed_9, 0.0f.xx, 1.0f.xx);
				fragment_unnamed_9.x = fragment_unnamed_9.y * fragment_unnamed_9.x;
				fragment_unnamed_53 = _MainTex.Sample(sampler_MainTex, fragment_input_1.xy).w;
				fragment_unnamed_53 = (fragment_unnamed_53 * fragment_input_2.x) + (-fragment_input_2.w);
				fragment_unnamed_53 = clamp(fragment_unnamed_53, 0.0f, 1.0f);
				fragment_unnamed_83 = fragment_unnamed_53.xxxx * fragment_input_0;
				fragment_output_0 = fragment_unnamed_9.xxxx * fragment_unnamed_83;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
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

			float3 _WorldSpaceCameraPos;
			float4 _ScreenParams;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4x4 glstate_matrix_projection;
			float4x4 unity_MatrixVP;
			float4 _FaceColor;
			float _FaceDilate;
			float _OutlineSoftness;
			float4 _OutlineColor;
			float _OutlineWidth;
			float _WeightNormal;
			float _WeightBold;
			float _ScaleRatioA;
			float _VertexOffsetX;
			float _VertexOffsetY;
			float4 _ClipRect;
			float _MaskSoftnessX;
			float _MaskSoftnessY;
			float _GradientScale;
			float _ScaleX;
			float _ScaleY;
			float _PerspectiveFilter;
			float _Sharpness;

			static float4 unity_ObjectToWorld__array[4];
			static float4 unity_WorldToObject__array[4];
			static float4 glstate_matrix_projection__array[4];
			static float4 unity_MatrixVP__array[4];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_2;
			static float4 vertex_output_0;
			static float3 vertex_input_1;
			static float4 vertex_output_3;
			static float2 vertex_input_4;
			static float4 vertex_output_4;
			static float4 vertex_output_1;
			static float2 vertex_input_3;
			static float4 vertex_output_2;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION;
				float3 vertex_input_1 : NORMAL;
				float4 vertex_input_2 : COLOR;
				float2 vertex_input_3 : TEXCOORD0;
				float2 vertex_input_4 : TEXCOORD1;
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_0 : UNKNOWN0;
				float4 vertex_output_1 : TEXCOORD0; // vs_TEXCOORD0
				float4 vertex_output_2 : TEXCOORD1; // vs_TEXCOORD1
				float4 vertex_output_3 : TEXCOORD2; // vs_TEXCOORD2
				float4 vertex_output_4 : UNKNOWN4;
				float4 gl_Position : SV_Position;
			};

			static float2 vertex_unnamed_9;
			static float4 vertex_unnamed_36;
			static float4 vertex_unnamed_60;
			static float4 vertex_unnamed_86;
			static float vertex_unnamed_138;
			static float vertex_unnamed_236;
			static float2 vertex_unnamed_276;
			static float vertex_unnamed_294;
			static bool vertex_unnamed_320;
			static bool vertex_unnamed_437;
			static float vertex_unnamed_444;

			void vert_main()
			{
				vertex_unnamed_9 = vertex_input_0.xy + float2(_VertexOffsetX, _VertexOffsetY);
				vertex_unnamed_36 = vertex_unnamed_9.yyyy * unity_ObjectToWorld__array[1];
				vertex_unnamed_36 = (unity_ObjectToWorld__array[0] * vertex_unnamed_9.xxxx) + vertex_unnamed_36;
				vertex_unnamed_36 = (unity_ObjectToWorld__array[2] * vertex_input_0.zzzz) + vertex_unnamed_36;
				vertex_unnamed_60 = vertex_unnamed_36 + unity_ObjectToWorld__array[3];
				float3 vertex_unnamed_74 = (unity_ObjectToWorld__array[3].xyz * vertex_input_0.www) + vertex_unnamed_36.xyz;
				vertex_unnamed_36 = float4(vertex_unnamed_74.x, vertex_unnamed_74.y, vertex_unnamed_74.z, vertex_unnamed_36.w);
				float3 vertex_unnamed_83 = (-vertex_unnamed_36.xyz) + _WorldSpaceCameraPos;
				vertex_unnamed_36 = float4(vertex_unnamed_83.x, vertex_unnamed_83.y, vertex_unnamed_83.z, vertex_unnamed_36.w);
				vertex_unnamed_86 = vertex_unnamed_60.yyyy * unity_MatrixVP__array[1];
				vertex_unnamed_86 = (unity_MatrixVP__array[0] * vertex_unnamed_60.xxxx) + vertex_unnamed_86;
				vertex_unnamed_86 = (unity_MatrixVP__array[2] * vertex_unnamed_60.zzzz) + vertex_unnamed_86;
				vertex_unnamed_60 = (unity_MatrixVP__array[3] * vertex_unnamed_60.wwww) + vertex_unnamed_86;
				gl_Position = vertex_unnamed_60;
				vertex_unnamed_86 = vertex_input_2 * _FaceColor;
				float3 vertex_unnamed_132 = vertex_unnamed_86.www * vertex_unnamed_86.xyz;
				vertex_unnamed_86 = float4(vertex_unnamed_132.x, vertex_unnamed_132.y, vertex_unnamed_132.z, vertex_unnamed_86.w);
				vertex_output_0 = vertex_unnamed_86;
				vertex_unnamed_138 = dot(vertex_unnamed_36.xyz, vertex_unnamed_36.xyz);
				vertex_unnamed_138 = rsqrt(vertex_unnamed_138);
				float3 vertex_unnamed_150 = vertex_unnamed_138.xxx * vertex_unnamed_36.xyz;
				vertex_unnamed_36 = float4(vertex_unnamed_150.x, vertex_unnamed_150.y, vertex_unnamed_150.z, vertex_unnamed_36.w);
				vertex_unnamed_60.x = dot(vertex_input_1, unity_WorldToObject__array[0].xyz);
				vertex_unnamed_60.y = dot(vertex_input_1, unity_WorldToObject__array[1].xyz);
				vertex_unnamed_60.z = dot(vertex_input_1, unity_WorldToObject__array[2].xyz);
				vertex_unnamed_138 = dot(vertex_unnamed_60.xyz, vertex_unnamed_60.xyz);
				vertex_unnamed_138 = rsqrt(vertex_unnamed_138);
				float3 vertex_unnamed_186 = vertex_unnamed_138.xxx * vertex_unnamed_60.xyz;
				vertex_unnamed_60 = float4(vertex_unnamed_186.x, vertex_unnamed_186.y, vertex_unnamed_186.z, vertex_unnamed_60.w);
				vertex_unnamed_138 = dot(vertex_unnamed_60.xyz, vertex_unnamed_36.xyz);
				float2 vertex_unnamed_201 = _ScreenParams.yy * glstate_matrix_projection__array[1].xy;
				vertex_unnamed_36 = float4(vertex_unnamed_201.x, vertex_unnamed_201.y, vertex_unnamed_36.z, vertex_unnamed_36.w);
				float2 vertex_unnamed_213 = (glstate_matrix_projection__array[0].xy * _ScreenParams.xx) + vertex_unnamed_36.xy;
				vertex_unnamed_36 = float4(vertex_unnamed_213.x, vertex_unnamed_213.y, vertex_unnamed_36.z, vertex_unnamed_36.w);
				float2 vertex_unnamed_226 = abs(vertex_unnamed_36.xy) * float2(_ScaleX, _ScaleY);
				vertex_unnamed_36 = float4(vertex_unnamed_226.x, vertex_unnamed_226.y, vertex_unnamed_36.z, vertex_unnamed_36.w);
				float2 vertex_unnamed_233 = vertex_unnamed_60.ww / vertex_unnamed_36.xy;
				vertex_unnamed_36 = float4(vertex_unnamed_233.x, vertex_unnamed_233.y, vertex_unnamed_36.z, vertex_unnamed_36.w);
				vertex_unnamed_236 = dot(vertex_unnamed_36.xy, vertex_unnamed_36.xy);
				float2 vertex_unnamed_254 = (float2(_MaskSoftnessX, _MaskSoftnessY) * 0.25f.xx) + vertex_unnamed_36.xy;
				vertex_unnamed_36 = float4(vertex_unnamed_254.x, vertex_unnamed_254.y, vertex_unnamed_36.z, vertex_unnamed_36.w);
				float2 vertex_unnamed_260 = 0.25f.xx / vertex_unnamed_36.xy;
				vertex_output_3 = float4(vertex_output_3.x, vertex_output_3.y, vertex_unnamed_260.x, vertex_unnamed_260.y);
				vertex_unnamed_236 = rsqrt(vertex_unnamed_236);
				vertex_unnamed_36.x = abs(vertex_input_4.y) * _GradientScale;
				vertex_unnamed_276.x = _Sharpness + 1.0f;
				vertex_unnamed_36.x = vertex_unnamed_276.x * vertex_unnamed_36.x;
				vertex_unnamed_276.x = vertex_unnamed_236 * vertex_unnamed_36.x;
				vertex_unnamed_294 = (-_PerspectiveFilter) + 1.0f;
				vertex_unnamed_294 *= abs(vertex_unnamed_276.x);
				vertex_unnamed_236 = (vertex_unnamed_236 * vertex_unnamed_36.x) + (-vertex_unnamed_294);
				vertex_unnamed_138 = (abs(vertex_unnamed_138) * vertex_unnamed_236) + vertex_unnamed_294;
				vertex_unnamed_320 = glstate_matrix_projection__array[3].w == 0.0f;
				float vertex_unnamed_328;
				if (vertex_unnamed_320)
				{
					vertex_unnamed_328 = vertex_unnamed_138;
				}
				else
				{
					vertex_unnamed_328 = vertex_unnamed_276.x;
				}
				vertex_unnamed_138 = vertex_unnamed_328;
				vertex_unnamed_236 = _OutlineSoftness * _ScaleRatioA;
				vertex_unnamed_236 = (vertex_unnamed_236 * vertex_unnamed_138) + 1.0f;
				vertex_unnamed_36.x = vertex_unnamed_138 / vertex_unnamed_236;
				vertex_unnamed_138 = _OutlineWidth * _ScaleRatioA;
				vertex_unnamed_138 = vertex_unnamed_36.x * vertex_unnamed_138;
				vertex_unnamed_236 = min(vertex_unnamed_138, 1.0f);
				vertex_unnamed_236 = sqrt(vertex_unnamed_236);
				vertex_unnamed_60.w = vertex_input_2.w * _OutlineColor.w;
				float3 vertex_unnamed_377 = vertex_unnamed_60.www * _OutlineColor.xyz;
				vertex_unnamed_60 = float4(vertex_unnamed_377.x, vertex_unnamed_377.y, vertex_unnamed_377.z, vertex_unnamed_60.w);
				vertex_unnamed_60 = (-vertex_unnamed_86) + vertex_unnamed_60;
				vertex_output_4 = (vertex_unnamed_236.xxxx * vertex_unnamed_60) + vertex_unnamed_86;
				vertex_unnamed_60 = max(_ClipRect, (-20000000000.0f).xxxx);
				vertex_unnamed_60 = min(vertex_unnamed_60, 20000000000.0f.xxxx);
				vertex_unnamed_276 = vertex_unnamed_9 + (-vertex_unnamed_60.xy);
				vertex_unnamed_9 = (vertex_unnamed_9 * 2.0f.xx) + (-vertex_unnamed_60.xy);
				float2 vertex_unnamed_418 = (-vertex_unnamed_60.zw) + vertex_unnamed_9;
				vertex_output_3 = float4(vertex_unnamed_418.x, vertex_unnamed_418.y, vertex_output_3.z, vertex_output_3.w);
				vertex_unnamed_9 = (-vertex_unnamed_60.xy) + vertex_unnamed_60.zw;
				float2 vertex_unnamed_430 = vertex_unnamed_276 / vertex_unnamed_9;
				vertex_output_1 = float4(vertex_output_1.x, vertex_output_1.y, vertex_unnamed_430.x, vertex_unnamed_430.y);
				vertex_output_1 = float4(vertex_input_3.x, vertex_input_3.y, vertex_output_1.z, vertex_output_1.w);
				vertex_unnamed_437 = 0.0f >= vertex_input_4.y;
				vertex_unnamed_9.x = float(vertex_unnamed_437);
				vertex_unnamed_444 = (-_WeightNormal) + _WeightBold;
				vertex_unnamed_9.x = (vertex_unnamed_9.x * vertex_unnamed_444) + _WeightNormal;
				vertex_unnamed_9.x = (vertex_unnamed_9.x * 0.25f) + _FaceDilate;
				vertex_unnamed_9.x *= _ScaleRatioA;
				vertex_unnamed_9.x = ((-vertex_unnamed_9.x) * 0.5f) + 0.5f;
				vertex_unnamed_36.w = (vertex_unnamed_9.x * vertex_unnamed_36.x) + (-0.5f);
				vertex_output_2 = float4(vertex_unnamed_36.xw.x, vertex_output_2.y, vertex_output_2.z, vertex_unnamed_36.xw.y);
				vertex_output_2.y = ((-vertex_unnamed_138) * 0.5f) + vertex_unnamed_36.w;
				vertex_output_2.z = (vertex_unnamed_138 * 0.5f) + vertex_unnamed_36.w;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				unity_ObjectToWorld__array[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				unity_ObjectToWorld__array[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				unity_ObjectToWorld__array[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				unity_ObjectToWorld__array[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				unity_WorldToObject__array[0] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				unity_WorldToObject__array[1] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				unity_WorldToObject__array[2] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				unity_WorldToObject__array[3] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

				glstate_matrix_projection__array[0] = float4(glstate_matrix_projection[0][0], glstate_matrix_projection[1][0], glstate_matrix_projection[2][0], glstate_matrix_projection[3][0]);
				glstate_matrix_projection__array[1] = float4(glstate_matrix_projection[0][1], glstate_matrix_projection[1][1], glstate_matrix_projection[2][1], glstate_matrix_projection[3][1]);
				glstate_matrix_projection__array[2] = float4(glstate_matrix_projection[0][2], glstate_matrix_projection[1][2], glstate_matrix_projection[2][2], glstate_matrix_projection[3][2]);
				glstate_matrix_projection__array[3] = float4(glstate_matrix_projection[0][3], glstate_matrix_projection[1][3], glstate_matrix_projection[2][3], glstate_matrix_projection[3][3]);

				unity_MatrixVP__array[0] = float4(unity_MatrixVP[0][0], unity_MatrixVP[1][0], unity_MatrixVP[2][0], unity_MatrixVP[3][0]);
				unity_MatrixVP__array[1] = float4(unity_MatrixVP[0][1], unity_MatrixVP[1][1], unity_MatrixVP[2][1], unity_MatrixVP[3][1]);
				unity_MatrixVP__array[2] = float4(unity_MatrixVP[0][2], unity_MatrixVP[1][2], unity_MatrixVP[2][2], unity_MatrixVP[3][2]);
				unity_MatrixVP__array[3] = float4(unity_MatrixVP[0][3], unity_MatrixVP[1][3], unity_MatrixVP[2][3], unity_MatrixVP[3][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_2 = stage_input.vertex_input_2;
				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_4 = stage_input.vertex_input_4;
				vertex_input_3 = stage_input.vertex_input_3;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_0 = vertex_output_0;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				return stage_output;
			}

			float4 _ClipRect;

			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

			static float4 fragment_input_3;
			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float4 fragment_input_0;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_0 : UNKNOWN0;
				float4 fragment_input_1 : TEXCOORD0; // vs_TEXCOORD0
				float4 fragment_input_2 : TEXCOORD1; // vs_TEXCOORD1
				float4 fragment_input_3 : TEXCOORD2; // vs_TEXCOORD2
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static float2 fragment_unnamed_9;
			static float fragment_unnamed_53;
			static float4 fragment_unnamed_83;
			static bool fragment_unnamed_105;

			void frag_main()
			{
				fragment_unnamed_9 = (-_ClipRect.xy) + _ClipRect.zw;
				fragment_unnamed_9 += (-abs(fragment_input_3.xy));
				fragment_unnamed_9 *= fragment_input_3.zw;
				fragment_unnamed_9 = clamp(fragment_unnamed_9, 0.0f.xx, 1.0f.xx);
				fragment_unnamed_9.x = fragment_unnamed_9.y * fragment_unnamed_9.x;
				fragment_unnamed_53 = _MainTex.Sample(sampler_MainTex, fragment_input_1.xy).w;
				fragment_unnamed_53 = (fragment_unnamed_53 * fragment_input_2.x) + (-fragment_input_2.w);
				fragment_unnamed_53 = clamp(fragment_unnamed_53, 0.0f, 1.0f);
				fragment_unnamed_83 = fragment_unnamed_53.xxxx * fragment_input_0;
				fragment_unnamed_53 = (fragment_unnamed_83.w * fragment_unnamed_9.x) + (-0.001000000047497451305389404296875f);
				fragment_unnamed_83 = fragment_unnamed_9.xxxx * fragment_unnamed_83;
				fragment_output_0 = fragment_unnamed_83;
				fragment_unnamed_105 = fragment_unnamed_53 < 0.0f;
				if ((int(fragment_unnamed_105) * (-1)) != 0)
				{
					discard;
				}
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
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
			static float4 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_input_5;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : COLOR; // COLOR
				float4 fragment_input_2 : COLOR1; // COLOR_1
				float4 fragment_input_3 : TEXCOORD; // TEXCOORD
				float4 fragment_input_4 : TEXCOORD1; // TEXCOORD_1
				float4 fragment_input_5 : TEXCOORD2; // TEXCOORD_2
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				precise float fragment_unnamed_44 = (-0.0f) - fragment_input_4.w;
				float fragment_unnamed_49 = clamp(mad(_MainTex.Sample(sampler_MainTex, float2(fragment_input_3.x, fragment_input_3.y)).w, fragment_input_4.x, fragment_unnamed_44), 0.0f, 1.0f);
				precise float fragment_unnamed_59 = fragment_unnamed_49 * fragment_input_1.x;
				precise float fragment_unnamed_60 = fragment_unnamed_49 * fragment_input_1.y;
				precise float fragment_unnamed_61 = fragment_unnamed_49 * fragment_input_1.z;
				precise float fragment_unnamed_62 = fragment_unnamed_49 * fragment_input_1.w;
				fragment_output_0.x = fragment_unnamed_59;
				fragment_output_0.y = fragment_unnamed_60;
				fragment_output_0.z = fragment_unnamed_61;
				fragment_output_0.w = fragment_unnamed_62;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
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
			static float4 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_input_5;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : COLOR; // COLOR
				float4 fragment_input_2 : COLOR1; // COLOR_1
				float4 fragment_input_3 : TEXCOORD; // TEXCOORD
				float4 fragment_input_4 : TEXCOORD1; // TEXCOORD_1
				float4 fragment_input_5 : TEXCOORD2; // TEXCOORD_2
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static bool discard_state;

			void discard_cond(bool fragment_unnamed_79)
			{
				if (fragment_unnamed_79)
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
				precise float fragment_unnamed_44 = (-0.0f) - fragment_input_4.w;
				float fragment_unnamed_49 = clamp(mad(_MainTex.Sample(sampler_MainTex, float2(fragment_input_3.x, fragment_input_3.y)).w, fragment_input_4.x, fragment_unnamed_44), 0.0f, 1.0f);
				precise float fragment_unnamed_63 = fragment_unnamed_49 * fragment_input_1.x;
				precise float fragment_unnamed_64 = fragment_unnamed_49 * fragment_input_1.y;
				precise float fragment_unnamed_65 = fragment_unnamed_49 * fragment_input_1.z;
				precise float fragment_unnamed_66 = fragment_unnamed_49 * fragment_input_1.w;
				fragment_output_0.x = fragment_unnamed_63;
				fragment_output_0.y = fragment_unnamed_64;
				fragment_output_0.z = fragment_unnamed_65;
				fragment_output_0.w = fragment_unnamed_66;
				discard_cond(mad(fragment_input_1.w, fragment_unnamed_49, -0.001000000047497451305389404296875f) < 0.0f);
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
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

			static float4 fragment_uniform_buffer_0[27];
			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_input_5;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : COLOR; // COLOR
				float4 fragment_input_2 : COLOR1; // COLOR_1
				float4 fragment_input_3 : TEXCOORD; // TEXCOORD
				float4 fragment_input_4 : TEXCOORD1; // TEXCOORD_1
				float4 fragment_input_5 : TEXCOORD2; // TEXCOORD_2
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				precise float fragment_unnamed_36 = (-0.0f) - fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_39 = (-0.0f) - fragment_uniform_buffer_0[26u].y;
				precise float fragment_unnamed_44 = fragment_unnamed_36 + fragment_uniform_buffer_0[26u].z;
				precise float fragment_unnamed_45 = fragment_unnamed_39 + fragment_uniform_buffer_0[26u].w;
				precise float fragment_unnamed_51 = (-0.0f) - abs(fragment_input_5.x);
				precise float fragment_unnamed_56 = (-0.0f) - abs(fragment_input_5.y);
				precise float fragment_unnamed_57 = fragment_unnamed_44 + fragment_unnamed_51;
				precise float fragment_unnamed_58 = fragment_unnamed_45 + fragment_unnamed_56;
				precise float fragment_unnamed_65 = fragment_unnamed_57 * fragment_input_5.z;
				precise float fragment_unnamed_66 = fragment_unnamed_58 * fragment_input_5.w;
				precise float fragment_unnamed_71 = clamp(fragment_unnamed_66, 0.0f, 1.0f) * clamp(fragment_unnamed_65, 0.0f, 1.0f);
				precise float fragment_unnamed_86 = (-0.0f) - fragment_input_4.w;
				float fragment_unnamed_88 = clamp(mad(_MainTex.Sample(sampler_MainTex, float2(fragment_input_3.x, fragment_input_3.y)).w, fragment_input_4.x, fragment_unnamed_86), 0.0f, 1.0f);
				precise float fragment_unnamed_97 = fragment_unnamed_88 * fragment_input_1.x;
				precise float fragment_unnamed_98 = fragment_unnamed_88 * fragment_input_1.y;
				precise float fragment_unnamed_99 = fragment_unnamed_88 * fragment_input_1.z;
				precise float fragment_unnamed_100 = fragment_unnamed_88 * fragment_input_1.w;
				precise float fragment_unnamed_101 = fragment_unnamed_71 * fragment_unnamed_97;
				precise float fragment_unnamed_102 = fragment_unnamed_71 * fragment_unnamed_98;
				precise float fragment_unnamed_103 = fragment_unnamed_71 * fragment_unnamed_99;
				precise float fragment_unnamed_104 = fragment_unnamed_71 * fragment_unnamed_100;
				fragment_output_0.x = fragment_unnamed_101;
				fragment_output_0.y = fragment_unnamed_102;
				fragment_output_0.z = fragment_unnamed_103;
				fragment_output_0.w = fragment_unnamed_104;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[26] = float4(_ClipRect[0], _ClipRect[1], _ClipRect[2], _ClipRect[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
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

			static float4 fragment_uniform_buffer_0[27];
			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_input_5;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : COLOR; // COLOR
				float4 fragment_input_2 : COLOR1; // COLOR_1
				float4 fragment_input_3 : TEXCOORD; // TEXCOORD
				float4 fragment_input_4 : TEXCOORD1; // TEXCOORD_1
				float4 fragment_input_5 : TEXCOORD2; // TEXCOORD_2
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static bool discard_state;

			void discard_cond(bool fragment_unnamed_119)
			{
				if (fragment_unnamed_119)
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
				precise float fragment_unnamed_36 = (-0.0f) - fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_39 = (-0.0f) - fragment_uniform_buffer_0[26u].y;
				precise float fragment_unnamed_44 = fragment_unnamed_36 + fragment_uniform_buffer_0[26u].z;
				precise float fragment_unnamed_45 = fragment_unnamed_39 + fragment_uniform_buffer_0[26u].w;
				precise float fragment_unnamed_51 = (-0.0f) - abs(fragment_input_5.x);
				precise float fragment_unnamed_56 = (-0.0f) - abs(fragment_input_5.y);
				precise float fragment_unnamed_57 = fragment_unnamed_44 + fragment_unnamed_51;
				precise float fragment_unnamed_58 = fragment_unnamed_45 + fragment_unnamed_56;
				precise float fragment_unnamed_65 = fragment_unnamed_57 * fragment_input_5.z;
				precise float fragment_unnamed_66 = fragment_unnamed_58 * fragment_input_5.w;
				precise float fragment_unnamed_71 = clamp(fragment_unnamed_66, 0.0f, 1.0f) * clamp(fragment_unnamed_65, 0.0f, 1.0f);
				precise float fragment_unnamed_86 = (-0.0f) - fragment_input_4.w;
				float fragment_unnamed_88 = clamp(mad(_MainTex.Sample(sampler_MainTex, float2(fragment_input_3.x, fragment_input_3.y)).w, fragment_input_4.x, fragment_unnamed_86), 0.0f, 1.0f);
				precise float fragment_unnamed_97 = fragment_unnamed_88 * fragment_input_1.x;
				precise float fragment_unnamed_98 = fragment_unnamed_88 * fragment_input_1.y;
				precise float fragment_unnamed_99 = fragment_unnamed_88 * fragment_input_1.z;
				precise float fragment_unnamed_100 = fragment_unnamed_88 * fragment_input_1.w;
				precise float fragment_unnamed_103 = fragment_unnamed_71 * fragment_unnamed_97;
				precise float fragment_unnamed_104 = fragment_unnamed_71 * fragment_unnamed_98;
				precise float fragment_unnamed_105 = fragment_unnamed_71 * fragment_unnamed_99;
				precise float fragment_unnamed_106 = fragment_unnamed_71 * fragment_unnamed_100;
				fragment_output_0.x = fragment_unnamed_103;
				fragment_output_0.y = fragment_unnamed_104;
				fragment_output_0.z = fragment_unnamed_105;
				fragment_output_0.w = fragment_unnamed_106;
				discard_cond(mad(fragment_unnamed_100, fragment_unnamed_71, -0.001000000047497451305389404296875f) < 0.0f);
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[26] = float4(_ClipRect[0], _ClipRect[1], _ClipRect[2], _ClipRect[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
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
	CustomEditor "TMPro.EditorUtilities.TMP_SDFShaderGUI"
}
