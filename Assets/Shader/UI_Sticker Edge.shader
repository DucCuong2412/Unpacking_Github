Shader "UI/Sticker Edge"
{
	Properties
	{
		[PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
		_Color ("Tint", Color) = (1,1,1,1)
		_Edge ("Edge", Color) = (1,1,1,1)
		_StencilComp ("Stencil Comparison", Float) = 8
		_Stencil ("Stencil ID", Float) = 0
		_StencilOp ("Stencil Operation", Float) = 0
		_StencilWriteMask ("Stencil Write Mask", Float) = 255
		_StencilReadMask ("Stencil Read Mask", Float) = 255
		_ColorMask ("Color Mask", Float) = 15
		[Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip ("Use Alpha Clip", Float) = 0
	}
	SubShader
	{
		Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass
		{
			Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
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
			GpuProgramID 54379

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

			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[4];
			static float4 vertex_uniform_buffer_1[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float2 vertex_input_2;
			static float4 vertex_output_1;
			static float2 vertex_output_2;
			static float4 vertex_output_3;

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
				float4 vertex_output_3 : TEXCOORD1; // TEXCOORD_1
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_44 = asfloat((vertex_input_1.z < 0.75f) ? 3221225472u : 3212836864u) + vertex_input_0.x;
				precise float vertex_unnamed_55 = vertex_input_0.y * vertex_uniform_buffer_0[1u].x;
				precise float vertex_unnamed_56 = vertex_input_0.y * vertex_uniform_buffer_0[1u].y;
				precise float vertex_unnamed_57 = vertex_input_0.y * vertex_uniform_buffer_0[1u].z;
				precise float vertex_unnamed_58 = vertex_input_0.y * vertex_uniform_buffer_0[1u].w;
				vertex_output_3.x = vertex_unnamed_44;
				precise float vertex_unnamed_91 = mad(vertex_uniform_buffer_0[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].x, vertex_unnamed_44, vertex_unnamed_55)) + vertex_uniform_buffer_0[3u].x;
				precise float vertex_unnamed_92 = mad(vertex_uniform_buffer_0[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].y, vertex_unnamed_44, vertex_unnamed_56)) + vertex_uniform_buffer_0[3u].y;
				precise float vertex_unnamed_93 = mad(vertex_uniform_buffer_0[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].z, vertex_unnamed_44, vertex_unnamed_57)) + vertex_uniform_buffer_0[3u].z;
				precise float vertex_unnamed_94 = mad(vertex_uniform_buffer_0[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].w, vertex_unnamed_44, vertex_unnamed_58)) + vertex_uniform_buffer_0[3u].w;
				precise float vertex_unnamed_102 = vertex_unnamed_92 * vertex_uniform_buffer_1[18u].x;
				precise float vertex_unnamed_103 = vertex_unnamed_92 * vertex_uniform_buffer_1[18u].y;
				precise float vertex_unnamed_104 = vertex_unnamed_92 * vertex_uniform_buffer_1[18u].z;
				precise float vertex_unnamed_105 = vertex_unnamed_92 * vertex_uniform_buffer_1[18u].w;
				gl_Position.x = mad(vertex_uniform_buffer_1[20u].x, vertex_unnamed_94, mad(vertex_uniform_buffer_1[19u].x, vertex_unnamed_93, mad(vertex_uniform_buffer_1[17u].x, vertex_unnamed_91, vertex_unnamed_102)));
				gl_Position.y = mad(vertex_uniform_buffer_1[20u].y, vertex_unnamed_94, mad(vertex_uniform_buffer_1[19u].y, vertex_unnamed_93, mad(vertex_uniform_buffer_1[17u].y, vertex_unnamed_91, vertex_unnamed_103)));
				gl_Position.z = mad(vertex_uniform_buffer_1[20u].z, vertex_unnamed_94, mad(vertex_uniform_buffer_1[19u].z, vertex_unnamed_93, mad(vertex_uniform_buffer_1[17u].z, vertex_unnamed_91, vertex_unnamed_104)));
				gl_Position.w = mad(vertex_uniform_buffer_1[20u].w, vertex_unnamed_94, mad(vertex_uniform_buffer_1[19u].w, vertex_unnamed_93, mad(vertex_uniform_buffer_1[17u].w, vertex_unnamed_91, vertex_unnamed_105)));
				vertex_output_1.x = vertex_input_1.x;
				vertex_output_1.y = vertex_input_1.y;
				vertex_output_1.z = vertex_input_1.z;
				vertex_output_1.w = vertex_input_1.w;
				vertex_output_2.x = vertex_input_2.x;
				vertex_output_2.y = vertex_input_2.y;
				vertex_output_3.y = vertex_input_0.y;
				vertex_output_3.z = vertex_input_0.z;
				vertex_output_3.w = vertex_input_0.w;
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
				vertex_input_2 = stage_input.vertex_input_2;
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

			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[4];
			static float4 vertex_uniform_buffer_1[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float2 vertex_input_2;
			static float4 vertex_output_1;
			static float2 vertex_output_2;
			static float4 vertex_output_3;

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
				float4 vertex_output_3 : TEXCOORD1; // TEXCOORD_1
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_44 = asfloat((vertex_input_1.z < 0.75f) ? 3221225472u : 3212836864u) + vertex_input_0.x;
				precise float vertex_unnamed_55 = vertex_input_0.y * vertex_uniform_buffer_0[1u].x;
				precise float vertex_unnamed_56 = vertex_input_0.y * vertex_uniform_buffer_0[1u].y;
				precise float vertex_unnamed_57 = vertex_input_0.y * vertex_uniform_buffer_0[1u].z;
				precise float vertex_unnamed_58 = vertex_input_0.y * vertex_uniform_buffer_0[1u].w;
				vertex_output_3.x = vertex_unnamed_44;
				precise float vertex_unnamed_91 = mad(vertex_uniform_buffer_0[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].x, vertex_unnamed_44, vertex_unnamed_55)) + vertex_uniform_buffer_0[3u].x;
				precise float vertex_unnamed_92 = mad(vertex_uniform_buffer_0[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].y, vertex_unnamed_44, vertex_unnamed_56)) + vertex_uniform_buffer_0[3u].y;
				precise float vertex_unnamed_93 = mad(vertex_uniform_buffer_0[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].z, vertex_unnamed_44, vertex_unnamed_57)) + vertex_uniform_buffer_0[3u].z;
				precise float vertex_unnamed_94 = mad(vertex_uniform_buffer_0[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].w, vertex_unnamed_44, vertex_unnamed_58)) + vertex_uniform_buffer_0[3u].w;
				precise float vertex_unnamed_102 = vertex_unnamed_92 * vertex_uniform_buffer_1[18u].x;
				precise float vertex_unnamed_103 = vertex_unnamed_92 * vertex_uniform_buffer_1[18u].y;
				precise float vertex_unnamed_104 = vertex_unnamed_92 * vertex_uniform_buffer_1[18u].z;
				precise float vertex_unnamed_105 = vertex_unnamed_92 * vertex_uniform_buffer_1[18u].w;
				gl_Position.x = mad(vertex_uniform_buffer_1[20u].x, vertex_unnamed_94, mad(vertex_uniform_buffer_1[19u].x, vertex_unnamed_93, mad(vertex_uniform_buffer_1[17u].x, vertex_unnamed_91, vertex_unnamed_102)));
				gl_Position.y = mad(vertex_uniform_buffer_1[20u].y, vertex_unnamed_94, mad(vertex_uniform_buffer_1[19u].y, vertex_unnamed_93, mad(vertex_uniform_buffer_1[17u].y, vertex_unnamed_91, vertex_unnamed_103)));
				gl_Position.z = mad(vertex_uniform_buffer_1[20u].z, vertex_unnamed_94, mad(vertex_uniform_buffer_1[19u].z, vertex_unnamed_93, mad(vertex_uniform_buffer_1[17u].z, vertex_unnamed_91, vertex_unnamed_104)));
				gl_Position.w = mad(vertex_uniform_buffer_1[20u].w, vertex_unnamed_94, mad(vertex_uniform_buffer_1[19u].w, vertex_unnamed_93, mad(vertex_uniform_buffer_1[17u].w, vertex_unnamed_91, vertex_unnamed_105)));
				vertex_output_1.x = vertex_input_1.x;
				vertex_output_1.y = vertex_input_1.y;
				vertex_output_1.z = vertex_input_1.z;
				vertex_output_1.w = vertex_input_1.w;
				vertex_output_2.x = vertex_input_2.x;
				vertex_output_2.y = vertex_input_2.y;
				vertex_output_3.y = vertex_input_0.y;
				vertex_output_3.z = vertex_input_0.z;
				vertex_output_3.w = vertex_input_0.w;
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
				vertex_input_2 = stage_input.vertex_input_2;
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

			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[4];
			static float4 vertex_uniform_buffer_1[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float2 vertex_input_2;
			static float4 vertex_output_1;
			static float2 vertex_output_2;
			static float4 vertex_output_3;

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
				float4 vertex_output_3 : TEXCOORD1; // TEXCOORD_1
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_44 = asfloat((vertex_input_1.z < 0.75f) ? 3221225472u : 3212836864u) + vertex_input_0.x;
				precise float vertex_unnamed_55 = vertex_input_0.y * vertex_uniform_buffer_0[1u].x;
				precise float vertex_unnamed_56 = vertex_input_0.y * vertex_uniform_buffer_0[1u].y;
				precise float vertex_unnamed_57 = vertex_input_0.y * vertex_uniform_buffer_0[1u].z;
				precise float vertex_unnamed_58 = vertex_input_0.y * vertex_uniform_buffer_0[1u].w;
				vertex_output_3.x = vertex_unnamed_44;
				precise float vertex_unnamed_91 = mad(vertex_uniform_buffer_0[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].x, vertex_unnamed_44, vertex_unnamed_55)) + vertex_uniform_buffer_0[3u].x;
				precise float vertex_unnamed_92 = mad(vertex_uniform_buffer_0[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].y, vertex_unnamed_44, vertex_unnamed_56)) + vertex_uniform_buffer_0[3u].y;
				precise float vertex_unnamed_93 = mad(vertex_uniform_buffer_0[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].z, vertex_unnamed_44, vertex_unnamed_57)) + vertex_uniform_buffer_0[3u].z;
				precise float vertex_unnamed_94 = mad(vertex_uniform_buffer_0[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].w, vertex_unnamed_44, vertex_unnamed_58)) + vertex_uniform_buffer_0[3u].w;
				precise float vertex_unnamed_102 = vertex_unnamed_92 * vertex_uniform_buffer_1[18u].x;
				precise float vertex_unnamed_103 = vertex_unnamed_92 * vertex_uniform_buffer_1[18u].y;
				precise float vertex_unnamed_104 = vertex_unnamed_92 * vertex_uniform_buffer_1[18u].z;
				precise float vertex_unnamed_105 = vertex_unnamed_92 * vertex_uniform_buffer_1[18u].w;
				gl_Position.x = mad(vertex_uniform_buffer_1[20u].x, vertex_unnamed_94, mad(vertex_uniform_buffer_1[19u].x, vertex_unnamed_93, mad(vertex_uniform_buffer_1[17u].x, vertex_unnamed_91, vertex_unnamed_102)));
				gl_Position.y = mad(vertex_uniform_buffer_1[20u].y, vertex_unnamed_94, mad(vertex_uniform_buffer_1[19u].y, vertex_unnamed_93, mad(vertex_uniform_buffer_1[17u].y, vertex_unnamed_91, vertex_unnamed_103)));
				gl_Position.z = mad(vertex_uniform_buffer_1[20u].z, vertex_unnamed_94, mad(vertex_uniform_buffer_1[19u].z, vertex_unnamed_93, mad(vertex_uniform_buffer_1[17u].z, vertex_unnamed_91, vertex_unnamed_104)));
				gl_Position.w = mad(vertex_uniform_buffer_1[20u].w, vertex_unnamed_94, mad(vertex_uniform_buffer_1[19u].w, vertex_unnamed_93, mad(vertex_uniform_buffer_1[17u].w, vertex_unnamed_91, vertex_unnamed_105)));
				vertex_output_1.x = vertex_input_1.x;
				vertex_output_1.y = vertex_input_1.y;
				vertex_output_1.z = vertex_input_1.z;
				vertex_output_1.w = vertex_input_1.w;
				vertex_output_2.x = vertex_input_2.x;
				vertex_output_2.y = vertex_input_2.y;
				vertex_output_3.y = vertex_input_0.y;
				vertex_output_3.z = vertex_input_0.z;
				vertex_output_3.w = vertex_input_0.w;
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
				vertex_input_2 = stage_input.vertex_input_2;
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

			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[4];
			static float4 vertex_uniform_buffer_1[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float2 vertex_input_2;
			static float4 vertex_output_1;
			static float2 vertex_output_2;
			static float4 vertex_output_3;

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
				float4 vertex_output_3 : TEXCOORD1; // TEXCOORD_1
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_44 = asfloat((vertex_input_1.z < 0.75f) ? 3221225472u : 3212836864u) + vertex_input_0.x;
				precise float vertex_unnamed_55 = vertex_input_0.y * vertex_uniform_buffer_0[1u].x;
				precise float vertex_unnamed_56 = vertex_input_0.y * vertex_uniform_buffer_0[1u].y;
				precise float vertex_unnamed_57 = vertex_input_0.y * vertex_uniform_buffer_0[1u].z;
				precise float vertex_unnamed_58 = vertex_input_0.y * vertex_uniform_buffer_0[1u].w;
				vertex_output_3.x = vertex_unnamed_44;
				precise float vertex_unnamed_91 = mad(vertex_uniform_buffer_0[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].x, vertex_unnamed_44, vertex_unnamed_55)) + vertex_uniform_buffer_0[3u].x;
				precise float vertex_unnamed_92 = mad(vertex_uniform_buffer_0[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].y, vertex_unnamed_44, vertex_unnamed_56)) + vertex_uniform_buffer_0[3u].y;
				precise float vertex_unnamed_93 = mad(vertex_uniform_buffer_0[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].z, vertex_unnamed_44, vertex_unnamed_57)) + vertex_uniform_buffer_0[3u].z;
				precise float vertex_unnamed_94 = mad(vertex_uniform_buffer_0[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].w, vertex_unnamed_44, vertex_unnamed_58)) + vertex_uniform_buffer_0[3u].w;
				precise float vertex_unnamed_102 = vertex_unnamed_92 * vertex_uniform_buffer_1[18u].x;
				precise float vertex_unnamed_103 = vertex_unnamed_92 * vertex_uniform_buffer_1[18u].y;
				precise float vertex_unnamed_104 = vertex_unnamed_92 * vertex_uniform_buffer_1[18u].z;
				precise float vertex_unnamed_105 = vertex_unnamed_92 * vertex_uniform_buffer_1[18u].w;
				gl_Position.x = mad(vertex_uniform_buffer_1[20u].x, vertex_unnamed_94, mad(vertex_uniform_buffer_1[19u].x, vertex_unnamed_93, mad(vertex_uniform_buffer_1[17u].x, vertex_unnamed_91, vertex_unnamed_102)));
				gl_Position.y = mad(vertex_uniform_buffer_1[20u].y, vertex_unnamed_94, mad(vertex_uniform_buffer_1[19u].y, vertex_unnamed_93, mad(vertex_uniform_buffer_1[17u].y, vertex_unnamed_91, vertex_unnamed_103)));
				gl_Position.z = mad(vertex_uniform_buffer_1[20u].z, vertex_unnamed_94, mad(vertex_uniform_buffer_1[19u].z, vertex_unnamed_93, mad(vertex_uniform_buffer_1[17u].z, vertex_unnamed_91, vertex_unnamed_104)));
				gl_Position.w = mad(vertex_uniform_buffer_1[20u].w, vertex_unnamed_94, mad(vertex_uniform_buffer_1[19u].w, vertex_unnamed_93, mad(vertex_uniform_buffer_1[17u].w, vertex_unnamed_91, vertex_unnamed_105)));
				vertex_output_1.x = vertex_input_1.x;
				vertex_output_1.y = vertex_input_1.y;
				vertex_output_1.z = vertex_input_1.z;
				vertex_output_1.w = vertex_input_1.w;
				vertex_output_2.x = vertex_input_2.x;
				vertex_output_2.y = vertex_input_2.y;
				vertex_output_3.y = vertex_input_0.y;
				vertex_output_3.z = vertex_input_0.z;
				vertex_output_3.w = vertex_input_0.w;
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
				vertex_input_2 = stage_input.vertex_input_2;
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

			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;

			static float4 unity_ObjectToWorld__array[4];
			static float4 unity_MatrixVP__array[4];
			static float4 gl_Position;
			static float4 vertex_input_1;
			static float4 vertex_input_0;
			static float4 vertex_output_2;
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
				float4 vertex_output_2 : TEXCOORD1; // vs_TEXCOORD1
				float4 gl_Position : SV_Position;
			};

			static bool vertex_unnamed_8;
			static float4 vertex_unnamed_21;
			static float4 vertex_unnamed_36;

			void vert_main()
			{
				vertex_unnamed_8 = vertex_input_1.z < 0.75f;
				vertex_unnamed_21.x = vertex_unnamed_8 ? (-2.0f) : (-1.0f);
				vertex_unnamed_21.x += vertex_input_0.x;
				vertex_unnamed_36 = vertex_input_0.yyyy * unity_ObjectToWorld__array[1];
				vertex_unnamed_36 = (unity_ObjectToWorld__array[0] * vertex_unnamed_21.xxxx) + vertex_unnamed_36;
				vertex_output_2.x = vertex_unnamed_21.x;
				vertex_unnamed_21 = (unity_ObjectToWorld__array[2] * vertex_input_0.zzzz) + vertex_unnamed_36;
				vertex_unnamed_21 += unity_ObjectToWorld__array[3];
				vertex_unnamed_36 = vertex_unnamed_21.yyyy * unity_MatrixVP__array[1];
				vertex_unnamed_36 = (unity_MatrixVP__array[0] * vertex_unnamed_21.xxxx) + vertex_unnamed_36;
				vertex_unnamed_36 = (unity_MatrixVP__array[2] * vertex_unnamed_21.zzzz) + vertex_unnamed_36;
				gl_Position = (unity_MatrixVP__array[3] * vertex_unnamed_21.wwww) + vertex_unnamed_36;
				vertex_output_0 = vertex_input_1;
				vertex_output_1 = vertex_input_2;
				vertex_output_2 = float4(vertex_output_2.x, vertex_input_0.yzw.x, vertex_input_0.yzw.y, vertex_input_0.yzw.z);
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
				vertex_input_0 = stage_input.vertex_input_0;
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
				fragment_output_0.w = fragment_unnamed_8;
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

			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;

			static float4 unity_ObjectToWorld__array[4];
			static float4 unity_MatrixVP__array[4];
			static float4 gl_Position;
			static float4 vertex_input_1;
			static float4 vertex_input_0;
			static float4 vertex_output_2;
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
				float4 vertex_output_2 : TEXCOORD1; // vs_TEXCOORD1
				float4 gl_Position : SV_Position;
			};

			static bool vertex_unnamed_8;
			static float4 vertex_unnamed_21;
			static float4 vertex_unnamed_36;

			void vert_main()
			{
				vertex_unnamed_8 = vertex_input_1.z < 0.75f;
				vertex_unnamed_21.x = vertex_unnamed_8 ? (-2.0f) : (-1.0f);
				vertex_unnamed_21.x += vertex_input_0.x;
				vertex_unnamed_36 = vertex_input_0.yyyy * unity_ObjectToWorld__array[1];
				vertex_unnamed_36 = (unity_ObjectToWorld__array[0] * vertex_unnamed_21.xxxx) + vertex_unnamed_36;
				vertex_output_2.x = vertex_unnamed_21.x;
				vertex_unnamed_21 = (unity_ObjectToWorld__array[2] * vertex_input_0.zzzz) + vertex_unnamed_36;
				vertex_unnamed_21 += unity_ObjectToWorld__array[3];
				vertex_unnamed_36 = vertex_unnamed_21.yyyy * unity_MatrixVP__array[1];
				vertex_unnamed_36 = (unity_MatrixVP__array[0] * vertex_unnamed_21.xxxx) + vertex_unnamed_36;
				vertex_unnamed_36 = (unity_MatrixVP__array[2] * vertex_unnamed_21.zzzz) + vertex_unnamed_36;
				gl_Position = (unity_MatrixVP__array[3] * vertex_unnamed_21.wwww) + vertex_unnamed_36;
				vertex_output_0 = vertex_input_1;
				vertex_output_1 = vertex_input_2;
				vertex_output_2 = float4(vertex_output_2.x, vertex_input_0.yzw.x, vertex_input_0.yzw.y, vertex_input_0.yzw.z);
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
				vertex_input_0 = stage_input.vertex_input_0;
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
			static float fragment_unnamed_28;
			static bool fragment_unnamed_39;

			void frag_main()
			{
				fragment_unnamed_8 = _MainTex.Sample(sampler_MainTex, fragment_input_1).w;
				fragment_unnamed_28 = fragment_unnamed_8 + (-0.001000000047497451305389404296875f);
				fragment_output_0.w = fragment_unnamed_8;
				fragment_unnamed_39 = fragment_unnamed_28 < 0.0f;
				if ((int(fragment_unnamed_39) * (-1)) != 0)
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

			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;

			static float4 unity_ObjectToWorld__array[4];
			static float4 unity_MatrixVP__array[4];
			static float4 gl_Position;
			static float4 vertex_input_1;
			static float4 vertex_input_0;
			static float4 vertex_output_2;
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
				float4 vertex_output_2 : TEXCOORD1; // vs_TEXCOORD1
				float4 gl_Position : SV_Position;
			};

			static bool vertex_unnamed_8;
			static float4 vertex_unnamed_21;
			static float4 vertex_unnamed_36;

			void vert_main()
			{
				vertex_unnamed_8 = vertex_input_1.z < 0.75f;
				vertex_unnamed_21.x = vertex_unnamed_8 ? (-2.0f) : (-1.0f);
				vertex_unnamed_21.x += vertex_input_0.x;
				vertex_unnamed_36 = vertex_input_0.yyyy * unity_ObjectToWorld__array[1];
				vertex_unnamed_36 = (unity_ObjectToWorld__array[0] * vertex_unnamed_21.xxxx) + vertex_unnamed_36;
				vertex_output_2.x = vertex_unnamed_21.x;
				vertex_unnamed_21 = (unity_ObjectToWorld__array[2] * vertex_input_0.zzzz) + vertex_unnamed_36;
				vertex_unnamed_21 += unity_ObjectToWorld__array[3];
				vertex_unnamed_36 = vertex_unnamed_21.yyyy * unity_MatrixVP__array[1];
				vertex_unnamed_36 = (unity_MatrixVP__array[0] * vertex_unnamed_21.xxxx) + vertex_unnamed_36;
				vertex_unnamed_36 = (unity_MatrixVP__array[2] * vertex_unnamed_21.zzzz) + vertex_unnamed_36;
				gl_Position = (unity_MatrixVP__array[3] * vertex_unnamed_21.wwww) + vertex_unnamed_36;
				vertex_output_0 = vertex_input_1;
				vertex_output_1 = vertex_input_2;
				vertex_output_2 = float4(vertex_output_2.x, vertex_input_0.yzw.x, vertex_input_0.yzw.y, vertex_input_0.yzw.z);
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
				vertex_input_0 = stage_input.vertex_input_0;
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
			static float4 fragment_output_0;
			static float4 fragment_input_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_0 : UNKNOWN0;
				float2 fragment_input_1 : TEXCOORD0; // vs_TEXCOORD0
				float4 fragment_input_2 : TEXCOORD1; // vs_TEXCOORD1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static bool4 fragment_unnamed_9;
			static float4 fragment_unnamed_40;
			static float fragment_unnamed_80;

			void frag_main()
			{
				bool2 fragment_unnamed_27 = bool4(fragment_input_2.xyxx.x >= _ClipRect.xyxx.x, fragment_input_2.xyxx.y >= _ClipRect.xyxx.y, fragment_input_2.xyxx.z >= _ClipRect.xyxx.z, fragment_input_2.xyxx.w >= _ClipRect.xyxx.w).xy;
				fragment_unnamed_9 = bool4(fragment_unnamed_27.x, fragment_unnamed_27.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
				bool2 fragment_unnamed_36 = bool4(_ClipRect.zzzw.x >= fragment_input_2.xxxy.x, _ClipRect.zzzw.y >= fragment_input_2.xxxy.y, _ClipRect.zzzw.z >= fragment_input_2.xxxy.z, _ClipRect.zzzw.w >= fragment_input_2.xxxy.w).zw;
				fragment_unnamed_9 = bool4(fragment_unnamed_9.x, fragment_unnamed_9.y, fragment_unnamed_36.x, fragment_unnamed_36.y);
				fragment_unnamed_40.x = float(fragment_unnamed_9.x);
				fragment_unnamed_40.y = float(fragment_unnamed_9.y);
				fragment_unnamed_40.z = float(fragment_unnamed_9.z);
				fragment_unnamed_40.w = float(fragment_unnamed_9.w);
				float2 fragment_unnamed_71 = fragment_unnamed_40.zw * fragment_unnamed_40.xy;
				fragment_unnamed_40 = float4(fragment_unnamed_71.x, fragment_unnamed_71.y, fragment_unnamed_40.z, fragment_unnamed_40.w);
				fragment_unnamed_40.x = fragment_unnamed_40.y * fragment_unnamed_40.x;
				fragment_unnamed_80 = _MainTex.Sample(sampler_MainTex, fragment_input_1).w;
				fragment_output_0.w = fragment_unnamed_40.x * fragment_unnamed_80;
				fragment_output_0 = float4(fragment_input_0.xyz.x, fragment_input_0.xyz.y, fragment_input_0.xyz.z, fragment_output_0.w);
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

			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;

			static float4 unity_ObjectToWorld__array[4];
			static float4 unity_MatrixVP__array[4];
			static float4 gl_Position;
			static float4 vertex_input_1;
			static float4 vertex_input_0;
			static float4 vertex_output_2;
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
				float4 vertex_output_2 : TEXCOORD1; // vs_TEXCOORD1
				float4 gl_Position : SV_Position;
			};

			static bool vertex_unnamed_8;
			static float4 vertex_unnamed_21;
			static float4 vertex_unnamed_36;

			void vert_main()
			{
				vertex_unnamed_8 = vertex_input_1.z < 0.75f;
				vertex_unnamed_21.x = vertex_unnamed_8 ? (-2.0f) : (-1.0f);
				vertex_unnamed_21.x += vertex_input_0.x;
				vertex_unnamed_36 = vertex_input_0.yyyy * unity_ObjectToWorld__array[1];
				vertex_unnamed_36 = (unity_ObjectToWorld__array[0] * vertex_unnamed_21.xxxx) + vertex_unnamed_36;
				vertex_output_2.x = vertex_unnamed_21.x;
				vertex_unnamed_21 = (unity_ObjectToWorld__array[2] * vertex_input_0.zzzz) + vertex_unnamed_36;
				vertex_unnamed_21 += unity_ObjectToWorld__array[3];
				vertex_unnamed_36 = vertex_unnamed_21.yyyy * unity_MatrixVP__array[1];
				vertex_unnamed_36 = (unity_MatrixVP__array[0] * vertex_unnamed_21.xxxx) + vertex_unnamed_36;
				vertex_unnamed_36 = (unity_MatrixVP__array[2] * vertex_unnamed_21.zzzz) + vertex_unnamed_36;
				gl_Position = (unity_MatrixVP__array[3] * vertex_unnamed_21.wwww) + vertex_unnamed_36;
				vertex_output_0 = vertex_input_1;
				vertex_output_1 = vertex_input_2;
				vertex_output_2 = float4(vertex_output_2.x, vertex_input_0.yzw.x, vertex_input_0.yzw.y, vertex_input_0.yzw.z);
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
				vertex_input_0 = stage_input.vertex_input_0;
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
			static float4 fragment_output_0;
			static float4 fragment_input_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_0 : UNKNOWN0;
				float2 fragment_input_1 : TEXCOORD0; // vs_TEXCOORD0
				float4 fragment_input_2 : TEXCOORD1; // vs_TEXCOORD1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static bool4 fragment_unnamed_9;
			static float4 fragment_unnamed_40;
			static float fragment_unnamed_80;
			static float fragment_unnamed_96;

			void frag_main()
			{
				bool2 fragment_unnamed_27 = bool4(fragment_input_2.xyxx.x >= _ClipRect.xyxx.x, fragment_input_2.xyxx.y >= _ClipRect.xyxx.y, fragment_input_2.xyxx.z >= _ClipRect.xyxx.z, fragment_input_2.xyxx.w >= _ClipRect.xyxx.w).xy;
				fragment_unnamed_9 = bool4(fragment_unnamed_27.x, fragment_unnamed_27.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
				bool2 fragment_unnamed_36 = bool4(_ClipRect.zzzw.x >= fragment_input_2.xxxy.x, _ClipRect.zzzw.y >= fragment_input_2.xxxy.y, _ClipRect.zzzw.z >= fragment_input_2.xxxy.z, _ClipRect.zzzw.w >= fragment_input_2.xxxy.w).zw;
				fragment_unnamed_9 = bool4(fragment_unnamed_9.x, fragment_unnamed_9.y, fragment_unnamed_36.x, fragment_unnamed_36.y);
				fragment_unnamed_40.x = float(fragment_unnamed_9.x);
				fragment_unnamed_40.y = float(fragment_unnamed_9.y);
				fragment_unnamed_40.z = float(fragment_unnamed_9.z);
				fragment_unnamed_40.w = float(fragment_unnamed_9.w);
				float2 fragment_unnamed_71 = fragment_unnamed_40.zw * fragment_unnamed_40.xy;
				fragment_unnamed_40 = float4(fragment_unnamed_71.x, fragment_unnamed_71.y, fragment_unnamed_40.z, fragment_unnamed_40.w);
				fragment_unnamed_40.x = fragment_unnamed_40.y * fragment_unnamed_40.x;
				fragment_unnamed_80 = _MainTex.Sample(sampler_MainTex, fragment_input_1).w;
				fragment_unnamed_96 = (fragment_unnamed_80 * fragment_unnamed_40.x) + (-0.001000000047497451305389404296875f);
				fragment_unnamed_40.x *= fragment_unnamed_80;
				fragment_output_0.w = fragment_unnamed_40.x;
				fragment_unnamed_9.x = fragment_unnamed_96 < 0.0f;
				if ((int(fragment_unnamed_9.x) * (-1)) != 0)
				{
					discard;
				}
				fragment_output_0 = float4(fragment_input_0.xyz.x, fragment_input_0.xyz.y, fragment_input_0.xyz.z, fragment_output_0.w);
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
				float4 fragment_input_3 : TEXCOORD1; // TEXCOORD_1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				fragment_output_0.w = _MainTex.Sample(sampler_MainTex, float2(fragment_input_2.x, fragment_input_2.y)).w;
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
				float4 fragment_input_3 : TEXCOORD1; // TEXCOORD_1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static bool discard_state;

			void discard_cond(bool fragment_unnamed_60)
			{
				if (fragment_unnamed_60)
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
				precise float fragment_unnamed_38 = fragment_unnamed_37 + (-0.001000000047497451305389404296875f);
				fragment_output_0.w = fragment_unnamed_37;
				discard_cond(fragment_unnamed_38 < 0.0f);
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

			static float4 fragment_uniform_buffer_0[3];
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
				float4 fragment_input_3 : TEXCOORD1; // TEXCOORD_1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				precise float fragment_unnamed_70 = asfloat(((fragment_uniform_buffer_0[2u].z >= fragment_input_3.x) ? 4294967295u : 0u) & 1065353216u) * asfloat(((fragment_input_3.x >= fragment_uniform_buffer_0[2u].x) ? 4294967295u : 0u) & 1065353216u);
				precise float fragment_unnamed_71 = asfloat(((fragment_uniform_buffer_0[2u].w >= fragment_input_3.y) ? 4294967295u : 0u) & 1065353216u) * asfloat(((fragment_input_3.y >= fragment_uniform_buffer_0[2u].y) ? 4294967295u : 0u) & 1065353216u);
				precise float fragment_unnamed_72 = fragment_unnamed_71 * fragment_unnamed_70;
				precise float fragment_unnamed_83 = fragment_unnamed_72 * _MainTex.Sample(sampler_MainTex, float2(fragment_input_2.x, fragment_input_2.y)).w;
				fragment_output_0.w = fragment_unnamed_83;
				fragment_output_0.x = fragment_input_1.x;
				fragment_output_0.y = fragment_input_1.y;
				fragment_output_0.z = fragment_input_1.z;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[2] = float4(_ClipRect[0], _ClipRect[1], _ClipRect[2], _ClipRect[3]);

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

			static float4 fragment_uniform_buffer_0[3];
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
				float4 fragment_input_3 : TEXCOORD1; // TEXCOORD_1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static bool discard_state;

			void discard_cond(bool fragment_unnamed_104)
			{
				if (fragment_unnamed_104)
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
				precise float fragment_unnamed_70 = asfloat(((fragment_uniform_buffer_0[2u].z >= fragment_input_3.x) ? 4294967295u : 0u) & 1065353216u) * asfloat(((fragment_input_3.x >= fragment_uniform_buffer_0[2u].x) ? 4294967295u : 0u) & 1065353216u);
				precise float fragment_unnamed_71 = asfloat(((fragment_uniform_buffer_0[2u].w >= fragment_input_3.y) ? 4294967295u : 0u) & 1065353216u) * asfloat(((fragment_input_3.y >= fragment_uniform_buffer_0[2u].y) ? 4294967295u : 0u) & 1065353216u);
				precise float fragment_unnamed_72 = fragment_unnamed_71 * fragment_unnamed_70;
				float4 fragment_unnamed_80 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_2.x, fragment_input_2.y));
				float fragment_unnamed_82 = fragment_unnamed_80.w;
				precise float fragment_unnamed_86 = fragment_unnamed_72 * fragment_unnamed_82;
				fragment_output_0.w = fragment_unnamed_86;
				discard_cond(mad(fragment_unnamed_82, fragment_unnamed_72, -0.001000000047497451305389404296875f) < 0.0f);
				fragment_output_0.x = fragment_input_1.x;
				fragment_output_0.y = fragment_input_1.y;
				fragment_output_0.z = fragment_input_1.z;
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[2] = float4(_ClipRect[0], _ClipRect[1], _ClipRect[2], _ClipRect[3]);

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
		Pass
		{
			Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
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
			GpuProgramID 127045

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

			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[4];
			static float4 vertex_uniform_buffer_1[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float2 vertex_input_2;
			static float4 vertex_output_1;
			static float2 vertex_output_2;
			static float4 vertex_output_3;

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
				float4 vertex_output_3 : TEXCOORD1; // TEXCOORD_1
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_44 = asfloat((vertex_input_1.z < 0.75f) ? 1073741824u : 1065353216u) + vertex_input_0.x;
				precise float vertex_unnamed_55 = vertex_input_0.y * vertex_uniform_buffer_0[1u].x;
				precise float vertex_unnamed_56 = vertex_input_0.y * vertex_uniform_buffer_0[1u].y;
				precise float vertex_unnamed_57 = vertex_input_0.y * vertex_uniform_buffer_0[1u].z;
				precise float vertex_unnamed_58 = vertex_input_0.y * vertex_uniform_buffer_0[1u].w;
				vertex_output_3.x = vertex_unnamed_44;
				precise float vertex_unnamed_91 = mad(vertex_uniform_buffer_0[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].x, vertex_unnamed_44, vertex_unnamed_55)) + vertex_uniform_buffer_0[3u].x;
				precise float vertex_unnamed_92 = mad(vertex_uniform_buffer_0[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].y, vertex_unnamed_44, vertex_unnamed_56)) + vertex_uniform_buffer_0[3u].y;
				precise float vertex_unnamed_93 = mad(vertex_uniform_buffer_0[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].z, vertex_unnamed_44, vertex_unnamed_57)) + vertex_uniform_buffer_0[3u].z;
				precise float vertex_unnamed_94 = mad(vertex_uniform_buffer_0[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].w, vertex_unnamed_44, vertex_unnamed_58)) + vertex_uniform_buffer_0[3u].w;
				precise float vertex_unnamed_102 = vertex_unnamed_92 * vertex_uniform_buffer_1[18u].x;
				precise float vertex_unnamed_103 = vertex_unnamed_92 * vertex_uniform_buffer_1[18u].y;
				precise float vertex_unnamed_104 = vertex_unnamed_92 * vertex_uniform_buffer_1[18u].z;
				precise float vertex_unnamed_105 = vertex_unnamed_92 * vertex_uniform_buffer_1[18u].w;
				gl_Position.x = mad(vertex_uniform_buffer_1[20u].x, vertex_unnamed_94, mad(vertex_uniform_buffer_1[19u].x, vertex_unnamed_93, mad(vertex_uniform_buffer_1[17u].x, vertex_unnamed_91, vertex_unnamed_102)));
				gl_Position.y = mad(vertex_uniform_buffer_1[20u].y, vertex_unnamed_94, mad(vertex_uniform_buffer_1[19u].y, vertex_unnamed_93, mad(vertex_uniform_buffer_1[17u].y, vertex_unnamed_91, vertex_unnamed_103)));
				gl_Position.z = mad(vertex_uniform_buffer_1[20u].z, vertex_unnamed_94, mad(vertex_uniform_buffer_1[19u].z, vertex_unnamed_93, mad(vertex_uniform_buffer_1[17u].z, vertex_unnamed_91, vertex_unnamed_104)));
				gl_Position.w = mad(vertex_uniform_buffer_1[20u].w, vertex_unnamed_94, mad(vertex_uniform_buffer_1[19u].w, vertex_unnamed_93, mad(vertex_uniform_buffer_1[17u].w, vertex_unnamed_91, vertex_unnamed_105)));
				vertex_output_1.x = vertex_input_1.x;
				vertex_output_1.y = vertex_input_1.y;
				vertex_output_1.z = vertex_input_1.z;
				vertex_output_1.w = vertex_input_1.w;
				vertex_output_2.x = vertex_input_2.x;
				vertex_output_2.y = vertex_input_2.y;
				vertex_output_3.y = vertex_input_0.y;
				vertex_output_3.z = vertex_input_0.z;
				vertex_output_3.w = vertex_input_0.w;
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
				vertex_input_2 = stage_input.vertex_input_2;
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

			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[4];
			static float4 vertex_uniform_buffer_1[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float2 vertex_input_2;
			static float4 vertex_output_1;
			static float2 vertex_output_2;
			static float4 vertex_output_3;

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
				float4 vertex_output_3 : TEXCOORD1; // TEXCOORD_1
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_44 = asfloat((vertex_input_1.z < 0.75f) ? 1073741824u : 1065353216u) + vertex_input_0.x;
				precise float vertex_unnamed_55 = vertex_input_0.y * vertex_uniform_buffer_0[1u].x;
				precise float vertex_unnamed_56 = vertex_input_0.y * vertex_uniform_buffer_0[1u].y;
				precise float vertex_unnamed_57 = vertex_input_0.y * vertex_uniform_buffer_0[1u].z;
				precise float vertex_unnamed_58 = vertex_input_0.y * vertex_uniform_buffer_0[1u].w;
				vertex_output_3.x = vertex_unnamed_44;
				precise float vertex_unnamed_91 = mad(vertex_uniform_buffer_0[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].x, vertex_unnamed_44, vertex_unnamed_55)) + vertex_uniform_buffer_0[3u].x;
				precise float vertex_unnamed_92 = mad(vertex_uniform_buffer_0[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].y, vertex_unnamed_44, vertex_unnamed_56)) + vertex_uniform_buffer_0[3u].y;
				precise float vertex_unnamed_93 = mad(vertex_uniform_buffer_0[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].z, vertex_unnamed_44, vertex_unnamed_57)) + vertex_uniform_buffer_0[3u].z;
				precise float vertex_unnamed_94 = mad(vertex_uniform_buffer_0[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].w, vertex_unnamed_44, vertex_unnamed_58)) + vertex_uniform_buffer_0[3u].w;
				precise float vertex_unnamed_102 = vertex_unnamed_92 * vertex_uniform_buffer_1[18u].x;
				precise float vertex_unnamed_103 = vertex_unnamed_92 * vertex_uniform_buffer_1[18u].y;
				precise float vertex_unnamed_104 = vertex_unnamed_92 * vertex_uniform_buffer_1[18u].z;
				precise float vertex_unnamed_105 = vertex_unnamed_92 * vertex_uniform_buffer_1[18u].w;
				gl_Position.x = mad(vertex_uniform_buffer_1[20u].x, vertex_unnamed_94, mad(vertex_uniform_buffer_1[19u].x, vertex_unnamed_93, mad(vertex_uniform_buffer_1[17u].x, vertex_unnamed_91, vertex_unnamed_102)));
				gl_Position.y = mad(vertex_uniform_buffer_1[20u].y, vertex_unnamed_94, mad(vertex_uniform_buffer_1[19u].y, vertex_unnamed_93, mad(vertex_uniform_buffer_1[17u].y, vertex_unnamed_91, vertex_unnamed_103)));
				gl_Position.z = mad(vertex_uniform_buffer_1[20u].z, vertex_unnamed_94, mad(vertex_uniform_buffer_1[19u].z, vertex_unnamed_93, mad(vertex_uniform_buffer_1[17u].z, vertex_unnamed_91, vertex_unnamed_104)));
				gl_Position.w = mad(vertex_uniform_buffer_1[20u].w, vertex_unnamed_94, mad(vertex_uniform_buffer_1[19u].w, vertex_unnamed_93, mad(vertex_uniform_buffer_1[17u].w, vertex_unnamed_91, vertex_unnamed_105)));
				vertex_output_1.x = vertex_input_1.x;
				vertex_output_1.y = vertex_input_1.y;
				vertex_output_1.z = vertex_input_1.z;
				vertex_output_1.w = vertex_input_1.w;
				vertex_output_2.x = vertex_input_2.x;
				vertex_output_2.y = vertex_input_2.y;
				vertex_output_3.y = vertex_input_0.y;
				vertex_output_3.z = vertex_input_0.z;
				vertex_output_3.w = vertex_input_0.w;
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
				vertex_input_2 = stage_input.vertex_input_2;
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

			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[4];
			static float4 vertex_uniform_buffer_1[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float2 vertex_input_2;
			static float4 vertex_output_1;
			static float2 vertex_output_2;
			static float4 vertex_output_3;

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
				float4 vertex_output_3 : TEXCOORD1; // TEXCOORD_1
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_44 = asfloat((vertex_input_1.z < 0.75f) ? 1073741824u : 1065353216u) + vertex_input_0.x;
				precise float vertex_unnamed_55 = vertex_input_0.y * vertex_uniform_buffer_0[1u].x;
				precise float vertex_unnamed_56 = vertex_input_0.y * vertex_uniform_buffer_0[1u].y;
				precise float vertex_unnamed_57 = vertex_input_0.y * vertex_uniform_buffer_0[1u].z;
				precise float vertex_unnamed_58 = vertex_input_0.y * vertex_uniform_buffer_0[1u].w;
				vertex_output_3.x = vertex_unnamed_44;
				precise float vertex_unnamed_91 = mad(vertex_uniform_buffer_0[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].x, vertex_unnamed_44, vertex_unnamed_55)) + vertex_uniform_buffer_0[3u].x;
				precise float vertex_unnamed_92 = mad(vertex_uniform_buffer_0[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].y, vertex_unnamed_44, vertex_unnamed_56)) + vertex_uniform_buffer_0[3u].y;
				precise float vertex_unnamed_93 = mad(vertex_uniform_buffer_0[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].z, vertex_unnamed_44, vertex_unnamed_57)) + vertex_uniform_buffer_0[3u].z;
				precise float vertex_unnamed_94 = mad(vertex_uniform_buffer_0[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].w, vertex_unnamed_44, vertex_unnamed_58)) + vertex_uniform_buffer_0[3u].w;
				precise float vertex_unnamed_102 = vertex_unnamed_92 * vertex_uniform_buffer_1[18u].x;
				precise float vertex_unnamed_103 = vertex_unnamed_92 * vertex_uniform_buffer_1[18u].y;
				precise float vertex_unnamed_104 = vertex_unnamed_92 * vertex_uniform_buffer_1[18u].z;
				precise float vertex_unnamed_105 = vertex_unnamed_92 * vertex_uniform_buffer_1[18u].w;
				gl_Position.x = mad(vertex_uniform_buffer_1[20u].x, vertex_unnamed_94, mad(vertex_uniform_buffer_1[19u].x, vertex_unnamed_93, mad(vertex_uniform_buffer_1[17u].x, vertex_unnamed_91, vertex_unnamed_102)));
				gl_Position.y = mad(vertex_uniform_buffer_1[20u].y, vertex_unnamed_94, mad(vertex_uniform_buffer_1[19u].y, vertex_unnamed_93, mad(vertex_uniform_buffer_1[17u].y, vertex_unnamed_91, vertex_unnamed_103)));
				gl_Position.z = mad(vertex_uniform_buffer_1[20u].z, vertex_unnamed_94, mad(vertex_uniform_buffer_1[19u].z, vertex_unnamed_93, mad(vertex_uniform_buffer_1[17u].z, vertex_unnamed_91, vertex_unnamed_104)));
				gl_Position.w = mad(vertex_uniform_buffer_1[20u].w, vertex_unnamed_94, mad(vertex_uniform_buffer_1[19u].w, vertex_unnamed_93, mad(vertex_uniform_buffer_1[17u].w, vertex_unnamed_91, vertex_unnamed_105)));
				vertex_output_1.x = vertex_input_1.x;
				vertex_output_1.y = vertex_input_1.y;
				vertex_output_1.z = vertex_input_1.z;
				vertex_output_1.w = vertex_input_1.w;
				vertex_output_2.x = vertex_input_2.x;
				vertex_output_2.y = vertex_input_2.y;
				vertex_output_3.y = vertex_input_0.y;
				vertex_output_3.z = vertex_input_0.z;
				vertex_output_3.w = vertex_input_0.w;
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
				vertex_input_2 = stage_input.vertex_input_2;
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

			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[4];
			static float4 vertex_uniform_buffer_1[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float2 vertex_input_2;
			static float4 vertex_output_1;
			static float2 vertex_output_2;
			static float4 vertex_output_3;

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
				float4 vertex_output_3 : TEXCOORD1; // TEXCOORD_1
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_44 = asfloat((vertex_input_1.z < 0.75f) ? 1073741824u : 1065353216u) + vertex_input_0.x;
				precise float vertex_unnamed_55 = vertex_input_0.y * vertex_uniform_buffer_0[1u].x;
				precise float vertex_unnamed_56 = vertex_input_0.y * vertex_uniform_buffer_0[1u].y;
				precise float vertex_unnamed_57 = vertex_input_0.y * vertex_uniform_buffer_0[1u].z;
				precise float vertex_unnamed_58 = vertex_input_0.y * vertex_uniform_buffer_0[1u].w;
				vertex_output_3.x = vertex_unnamed_44;
				precise float vertex_unnamed_91 = mad(vertex_uniform_buffer_0[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].x, vertex_unnamed_44, vertex_unnamed_55)) + vertex_uniform_buffer_0[3u].x;
				precise float vertex_unnamed_92 = mad(vertex_uniform_buffer_0[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].y, vertex_unnamed_44, vertex_unnamed_56)) + vertex_uniform_buffer_0[3u].y;
				precise float vertex_unnamed_93 = mad(vertex_uniform_buffer_0[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].z, vertex_unnamed_44, vertex_unnamed_57)) + vertex_uniform_buffer_0[3u].z;
				precise float vertex_unnamed_94 = mad(vertex_uniform_buffer_0[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].w, vertex_unnamed_44, vertex_unnamed_58)) + vertex_uniform_buffer_0[3u].w;
				precise float vertex_unnamed_102 = vertex_unnamed_92 * vertex_uniform_buffer_1[18u].x;
				precise float vertex_unnamed_103 = vertex_unnamed_92 * vertex_uniform_buffer_1[18u].y;
				precise float vertex_unnamed_104 = vertex_unnamed_92 * vertex_uniform_buffer_1[18u].z;
				precise float vertex_unnamed_105 = vertex_unnamed_92 * vertex_uniform_buffer_1[18u].w;
				gl_Position.x = mad(vertex_uniform_buffer_1[20u].x, vertex_unnamed_94, mad(vertex_uniform_buffer_1[19u].x, vertex_unnamed_93, mad(vertex_uniform_buffer_1[17u].x, vertex_unnamed_91, vertex_unnamed_102)));
				gl_Position.y = mad(vertex_uniform_buffer_1[20u].y, vertex_unnamed_94, mad(vertex_uniform_buffer_1[19u].y, vertex_unnamed_93, mad(vertex_uniform_buffer_1[17u].y, vertex_unnamed_91, vertex_unnamed_103)));
				gl_Position.z = mad(vertex_uniform_buffer_1[20u].z, vertex_unnamed_94, mad(vertex_uniform_buffer_1[19u].z, vertex_unnamed_93, mad(vertex_uniform_buffer_1[17u].z, vertex_unnamed_91, vertex_unnamed_104)));
				gl_Position.w = mad(vertex_uniform_buffer_1[20u].w, vertex_unnamed_94, mad(vertex_uniform_buffer_1[19u].w, vertex_unnamed_93, mad(vertex_uniform_buffer_1[17u].w, vertex_unnamed_91, vertex_unnamed_105)));
				vertex_output_1.x = vertex_input_1.x;
				vertex_output_1.y = vertex_input_1.y;
				vertex_output_1.z = vertex_input_1.z;
				vertex_output_1.w = vertex_input_1.w;
				vertex_output_2.x = vertex_input_2.x;
				vertex_output_2.y = vertex_input_2.y;
				vertex_output_3.y = vertex_input_0.y;
				vertex_output_3.z = vertex_input_0.z;
				vertex_output_3.w = vertex_input_0.w;
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
				vertex_input_2 = stage_input.vertex_input_2;
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

			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;

			static float4 unity_ObjectToWorld__array[4];
			static float4 unity_MatrixVP__array[4];
			static float4 gl_Position;
			static float4 vertex_input_1;
			static float4 vertex_input_0;
			static float4 vertex_output_2;
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
				float4 vertex_output_2 : TEXCOORD1; // vs_TEXCOORD1
				float4 gl_Position : SV_Position;
			};

			static bool vertex_unnamed_8;
			static float4 vertex_unnamed_21;
			static float4 vertex_unnamed_36;

			void vert_main()
			{
				vertex_unnamed_8 = vertex_input_1.z < 0.75f;
				vertex_unnamed_21.x = vertex_unnamed_8 ? 2.0f : 1.0f;
				vertex_unnamed_21.x += vertex_input_0.x;
				vertex_unnamed_36 = vertex_input_0.yyyy * unity_ObjectToWorld__array[1];
				vertex_unnamed_36 = (unity_ObjectToWorld__array[0] * vertex_unnamed_21.xxxx) + vertex_unnamed_36;
				vertex_output_2.x = vertex_unnamed_21.x;
				vertex_unnamed_21 = (unity_ObjectToWorld__array[2] * vertex_input_0.zzzz) + vertex_unnamed_36;
				vertex_unnamed_21 += unity_ObjectToWorld__array[3];
				vertex_unnamed_36 = vertex_unnamed_21.yyyy * unity_MatrixVP__array[1];
				vertex_unnamed_36 = (unity_MatrixVP__array[0] * vertex_unnamed_21.xxxx) + vertex_unnamed_36;
				vertex_unnamed_36 = (unity_MatrixVP__array[2] * vertex_unnamed_21.zzzz) + vertex_unnamed_36;
				gl_Position = (unity_MatrixVP__array[3] * vertex_unnamed_21.wwww) + vertex_unnamed_36;
				vertex_output_0 = vertex_input_1;
				vertex_output_1 = vertex_input_2;
				vertex_output_2 = float4(vertex_output_2.x, vertex_input_0.yzw.x, vertex_input_0.yzw.y, vertex_input_0.yzw.z);
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
				vertex_input_0 = stage_input.vertex_input_0;
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
				fragment_output_0.w = fragment_unnamed_8;
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

			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;

			static float4 unity_ObjectToWorld__array[4];
			static float4 unity_MatrixVP__array[4];
			static float4 gl_Position;
			static float4 vertex_input_1;
			static float4 vertex_input_0;
			static float4 vertex_output_2;
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
				float4 vertex_output_2 : TEXCOORD1; // vs_TEXCOORD1
				float4 gl_Position : SV_Position;
			};

			static bool vertex_unnamed_8;
			static float4 vertex_unnamed_21;
			static float4 vertex_unnamed_36;

			void vert_main()
			{
				vertex_unnamed_8 = vertex_input_1.z < 0.75f;
				vertex_unnamed_21.x = vertex_unnamed_8 ? 2.0f : 1.0f;
				vertex_unnamed_21.x += vertex_input_0.x;
				vertex_unnamed_36 = vertex_input_0.yyyy * unity_ObjectToWorld__array[1];
				vertex_unnamed_36 = (unity_ObjectToWorld__array[0] * vertex_unnamed_21.xxxx) + vertex_unnamed_36;
				vertex_output_2.x = vertex_unnamed_21.x;
				vertex_unnamed_21 = (unity_ObjectToWorld__array[2] * vertex_input_0.zzzz) + vertex_unnamed_36;
				vertex_unnamed_21 += unity_ObjectToWorld__array[3];
				vertex_unnamed_36 = vertex_unnamed_21.yyyy * unity_MatrixVP__array[1];
				vertex_unnamed_36 = (unity_MatrixVP__array[0] * vertex_unnamed_21.xxxx) + vertex_unnamed_36;
				vertex_unnamed_36 = (unity_MatrixVP__array[2] * vertex_unnamed_21.zzzz) + vertex_unnamed_36;
				gl_Position = (unity_MatrixVP__array[3] * vertex_unnamed_21.wwww) + vertex_unnamed_36;
				vertex_output_0 = vertex_input_1;
				vertex_output_1 = vertex_input_2;
				vertex_output_2 = float4(vertex_output_2.x, vertex_input_0.yzw.x, vertex_input_0.yzw.y, vertex_input_0.yzw.z);
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
				vertex_input_0 = stage_input.vertex_input_0;
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
			static float fragment_unnamed_28;
			static bool fragment_unnamed_39;

			void frag_main()
			{
				fragment_unnamed_8 = _MainTex.Sample(sampler_MainTex, fragment_input_1).w;
				fragment_unnamed_28 = fragment_unnamed_8 + (-0.001000000047497451305389404296875f);
				fragment_output_0.w = fragment_unnamed_8;
				fragment_unnamed_39 = fragment_unnamed_28 < 0.0f;
				if ((int(fragment_unnamed_39) * (-1)) != 0)
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

			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;

			static float4 unity_ObjectToWorld__array[4];
			static float4 unity_MatrixVP__array[4];
			static float4 gl_Position;
			static float4 vertex_input_1;
			static float4 vertex_input_0;
			static float4 vertex_output_2;
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
				float4 vertex_output_2 : TEXCOORD1; // vs_TEXCOORD1
				float4 gl_Position : SV_Position;
			};

			static bool vertex_unnamed_8;
			static float4 vertex_unnamed_21;
			static float4 vertex_unnamed_36;

			void vert_main()
			{
				vertex_unnamed_8 = vertex_input_1.z < 0.75f;
				vertex_unnamed_21.x = vertex_unnamed_8 ? 2.0f : 1.0f;
				vertex_unnamed_21.x += vertex_input_0.x;
				vertex_unnamed_36 = vertex_input_0.yyyy * unity_ObjectToWorld__array[1];
				vertex_unnamed_36 = (unity_ObjectToWorld__array[0] * vertex_unnamed_21.xxxx) + vertex_unnamed_36;
				vertex_output_2.x = vertex_unnamed_21.x;
				vertex_unnamed_21 = (unity_ObjectToWorld__array[2] * vertex_input_0.zzzz) + vertex_unnamed_36;
				vertex_unnamed_21 += unity_ObjectToWorld__array[3];
				vertex_unnamed_36 = vertex_unnamed_21.yyyy * unity_MatrixVP__array[1];
				vertex_unnamed_36 = (unity_MatrixVP__array[0] * vertex_unnamed_21.xxxx) + vertex_unnamed_36;
				vertex_unnamed_36 = (unity_MatrixVP__array[2] * vertex_unnamed_21.zzzz) + vertex_unnamed_36;
				gl_Position = (unity_MatrixVP__array[3] * vertex_unnamed_21.wwww) + vertex_unnamed_36;
				vertex_output_0 = vertex_input_1;
				vertex_output_1 = vertex_input_2;
				vertex_output_2 = float4(vertex_output_2.x, vertex_input_0.yzw.x, vertex_input_0.yzw.y, vertex_input_0.yzw.z);
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
				vertex_input_0 = stage_input.vertex_input_0;
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
			static float4 fragment_output_0;
			static float4 fragment_input_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_0 : UNKNOWN0;
				float2 fragment_input_1 : TEXCOORD0; // vs_TEXCOORD0
				float4 fragment_input_2 : TEXCOORD1; // vs_TEXCOORD1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static bool4 fragment_unnamed_9;
			static float4 fragment_unnamed_40;
			static float fragment_unnamed_80;

			void frag_main()
			{
				bool2 fragment_unnamed_27 = bool4(fragment_input_2.xyxx.x >= _ClipRect.xyxx.x, fragment_input_2.xyxx.y >= _ClipRect.xyxx.y, fragment_input_2.xyxx.z >= _ClipRect.xyxx.z, fragment_input_2.xyxx.w >= _ClipRect.xyxx.w).xy;
				fragment_unnamed_9 = bool4(fragment_unnamed_27.x, fragment_unnamed_27.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
				bool2 fragment_unnamed_36 = bool4(_ClipRect.zzzw.x >= fragment_input_2.xxxy.x, _ClipRect.zzzw.y >= fragment_input_2.xxxy.y, _ClipRect.zzzw.z >= fragment_input_2.xxxy.z, _ClipRect.zzzw.w >= fragment_input_2.xxxy.w).zw;
				fragment_unnamed_9 = bool4(fragment_unnamed_9.x, fragment_unnamed_9.y, fragment_unnamed_36.x, fragment_unnamed_36.y);
				fragment_unnamed_40.x = float(fragment_unnamed_9.x);
				fragment_unnamed_40.y = float(fragment_unnamed_9.y);
				fragment_unnamed_40.z = float(fragment_unnamed_9.z);
				fragment_unnamed_40.w = float(fragment_unnamed_9.w);
				float2 fragment_unnamed_71 = fragment_unnamed_40.zw * fragment_unnamed_40.xy;
				fragment_unnamed_40 = float4(fragment_unnamed_71.x, fragment_unnamed_71.y, fragment_unnamed_40.z, fragment_unnamed_40.w);
				fragment_unnamed_40.x = fragment_unnamed_40.y * fragment_unnamed_40.x;
				fragment_unnamed_80 = _MainTex.Sample(sampler_MainTex, fragment_input_1).w;
				fragment_output_0.w = fragment_unnamed_40.x * fragment_unnamed_80;
				fragment_output_0 = float4(fragment_input_0.xyz.x, fragment_input_0.xyz.y, fragment_input_0.xyz.z, fragment_output_0.w);
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

			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;

			static float4 unity_ObjectToWorld__array[4];
			static float4 unity_MatrixVP__array[4];
			static float4 gl_Position;
			static float4 vertex_input_1;
			static float4 vertex_input_0;
			static float4 vertex_output_2;
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
				float4 vertex_output_2 : TEXCOORD1; // vs_TEXCOORD1
				float4 gl_Position : SV_Position;
			};

			static bool vertex_unnamed_8;
			static float4 vertex_unnamed_21;
			static float4 vertex_unnamed_36;

			void vert_main()
			{
				vertex_unnamed_8 = vertex_input_1.z < 0.75f;
				vertex_unnamed_21.x = vertex_unnamed_8 ? 2.0f : 1.0f;
				vertex_unnamed_21.x += vertex_input_0.x;
				vertex_unnamed_36 = vertex_input_0.yyyy * unity_ObjectToWorld__array[1];
				vertex_unnamed_36 = (unity_ObjectToWorld__array[0] * vertex_unnamed_21.xxxx) + vertex_unnamed_36;
				vertex_output_2.x = vertex_unnamed_21.x;
				vertex_unnamed_21 = (unity_ObjectToWorld__array[2] * vertex_input_0.zzzz) + vertex_unnamed_36;
				vertex_unnamed_21 += unity_ObjectToWorld__array[3];
				vertex_unnamed_36 = vertex_unnamed_21.yyyy * unity_MatrixVP__array[1];
				vertex_unnamed_36 = (unity_MatrixVP__array[0] * vertex_unnamed_21.xxxx) + vertex_unnamed_36;
				vertex_unnamed_36 = (unity_MatrixVP__array[2] * vertex_unnamed_21.zzzz) + vertex_unnamed_36;
				gl_Position = (unity_MatrixVP__array[3] * vertex_unnamed_21.wwww) + vertex_unnamed_36;
				vertex_output_0 = vertex_input_1;
				vertex_output_1 = vertex_input_2;
				vertex_output_2 = float4(vertex_output_2.x, vertex_input_0.yzw.x, vertex_input_0.yzw.y, vertex_input_0.yzw.z);
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
				vertex_input_0 = stage_input.vertex_input_0;
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
			static float4 fragment_output_0;
			static float4 fragment_input_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_0 : UNKNOWN0;
				float2 fragment_input_1 : TEXCOORD0; // vs_TEXCOORD0
				float4 fragment_input_2 : TEXCOORD1; // vs_TEXCOORD1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static bool4 fragment_unnamed_9;
			static float4 fragment_unnamed_40;
			static float fragment_unnamed_80;
			static float fragment_unnamed_96;

			void frag_main()
			{
				bool2 fragment_unnamed_27 = bool4(fragment_input_2.xyxx.x >= _ClipRect.xyxx.x, fragment_input_2.xyxx.y >= _ClipRect.xyxx.y, fragment_input_2.xyxx.z >= _ClipRect.xyxx.z, fragment_input_2.xyxx.w >= _ClipRect.xyxx.w).xy;
				fragment_unnamed_9 = bool4(fragment_unnamed_27.x, fragment_unnamed_27.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
				bool2 fragment_unnamed_36 = bool4(_ClipRect.zzzw.x >= fragment_input_2.xxxy.x, _ClipRect.zzzw.y >= fragment_input_2.xxxy.y, _ClipRect.zzzw.z >= fragment_input_2.xxxy.z, _ClipRect.zzzw.w >= fragment_input_2.xxxy.w).zw;
				fragment_unnamed_9 = bool4(fragment_unnamed_9.x, fragment_unnamed_9.y, fragment_unnamed_36.x, fragment_unnamed_36.y);
				fragment_unnamed_40.x = float(fragment_unnamed_9.x);
				fragment_unnamed_40.y = float(fragment_unnamed_9.y);
				fragment_unnamed_40.z = float(fragment_unnamed_9.z);
				fragment_unnamed_40.w = float(fragment_unnamed_9.w);
				float2 fragment_unnamed_71 = fragment_unnamed_40.zw * fragment_unnamed_40.xy;
				fragment_unnamed_40 = float4(fragment_unnamed_71.x, fragment_unnamed_71.y, fragment_unnamed_40.z, fragment_unnamed_40.w);
				fragment_unnamed_40.x = fragment_unnamed_40.y * fragment_unnamed_40.x;
				fragment_unnamed_80 = _MainTex.Sample(sampler_MainTex, fragment_input_1).w;
				fragment_unnamed_96 = (fragment_unnamed_80 * fragment_unnamed_40.x) + (-0.001000000047497451305389404296875f);
				fragment_unnamed_40.x *= fragment_unnamed_80;
				fragment_output_0.w = fragment_unnamed_40.x;
				fragment_unnamed_9.x = fragment_unnamed_96 < 0.0f;
				if ((int(fragment_unnamed_9.x) * (-1)) != 0)
				{
					discard;
				}
				fragment_output_0 = float4(fragment_input_0.xyz.x, fragment_input_0.xyz.y, fragment_input_0.xyz.z, fragment_output_0.w);
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
				float4 fragment_input_3 : TEXCOORD1; // TEXCOORD_1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				fragment_output_0.w = _MainTex.Sample(sampler_MainTex, float2(fragment_input_2.x, fragment_input_2.y)).w;
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
				float4 fragment_input_3 : TEXCOORD1; // TEXCOORD_1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static bool discard_state;

			void discard_cond(bool fragment_unnamed_60)
			{
				if (fragment_unnamed_60)
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
				precise float fragment_unnamed_38 = fragment_unnamed_37 + (-0.001000000047497451305389404296875f);
				fragment_output_0.w = fragment_unnamed_37;
				discard_cond(fragment_unnamed_38 < 0.0f);
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

			static float4 fragment_uniform_buffer_0[3];
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
				float4 fragment_input_3 : TEXCOORD1; // TEXCOORD_1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				precise float fragment_unnamed_70 = asfloat(((fragment_uniform_buffer_0[2u].z >= fragment_input_3.x) ? 4294967295u : 0u) & 1065353216u) * asfloat(((fragment_input_3.x >= fragment_uniform_buffer_0[2u].x) ? 4294967295u : 0u) & 1065353216u);
				precise float fragment_unnamed_71 = asfloat(((fragment_uniform_buffer_0[2u].w >= fragment_input_3.y) ? 4294967295u : 0u) & 1065353216u) * asfloat(((fragment_input_3.y >= fragment_uniform_buffer_0[2u].y) ? 4294967295u : 0u) & 1065353216u);
				precise float fragment_unnamed_72 = fragment_unnamed_71 * fragment_unnamed_70;
				precise float fragment_unnamed_83 = fragment_unnamed_72 * _MainTex.Sample(sampler_MainTex, float2(fragment_input_2.x, fragment_input_2.y)).w;
				fragment_output_0.w = fragment_unnamed_83;
				fragment_output_0.x = fragment_input_1.x;
				fragment_output_0.y = fragment_input_1.y;
				fragment_output_0.z = fragment_input_1.z;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[2] = float4(_ClipRect[0], _ClipRect[1], _ClipRect[2], _ClipRect[3]);

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

			static float4 fragment_uniform_buffer_0[3];
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
				float4 fragment_input_3 : TEXCOORD1; // TEXCOORD_1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static bool discard_state;

			void discard_cond(bool fragment_unnamed_104)
			{
				if (fragment_unnamed_104)
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
				precise float fragment_unnamed_70 = asfloat(((fragment_uniform_buffer_0[2u].z >= fragment_input_3.x) ? 4294967295u : 0u) & 1065353216u) * asfloat(((fragment_input_3.x >= fragment_uniform_buffer_0[2u].x) ? 4294967295u : 0u) & 1065353216u);
				precise float fragment_unnamed_71 = asfloat(((fragment_uniform_buffer_0[2u].w >= fragment_input_3.y) ? 4294967295u : 0u) & 1065353216u) * asfloat(((fragment_input_3.y >= fragment_uniform_buffer_0[2u].y) ? 4294967295u : 0u) & 1065353216u);
				precise float fragment_unnamed_72 = fragment_unnamed_71 * fragment_unnamed_70;
				float4 fragment_unnamed_80 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_2.x, fragment_input_2.y));
				float fragment_unnamed_82 = fragment_unnamed_80.w;
				precise float fragment_unnamed_86 = fragment_unnamed_72 * fragment_unnamed_82;
				fragment_output_0.w = fragment_unnamed_86;
				discard_cond(mad(fragment_unnamed_82, fragment_unnamed_72, -0.001000000047497451305389404296875f) < 0.0f);
				fragment_output_0.x = fragment_input_1.x;
				fragment_output_0.y = fragment_input_1.y;
				fragment_output_0.z = fragment_input_1.z;
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[2] = float4(_ClipRect[0], _ClipRect[1], _ClipRect[2], _ClipRect[3]);

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
		Pass
		{
			Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
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
			GpuProgramID 156917

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

			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[4];
			static float4 vertex_uniform_buffer_1[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float2 vertex_input_2;
			static float4 vertex_output_1;
			static float2 vertex_output_2;
			static float4 vertex_output_3;

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
				float4 vertex_output_3 : TEXCOORD1; // TEXCOORD_1
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_44 = asfloat((vertex_input_1.z < 0.75f) ? 3221225472u : 3212836864u) + vertex_input_0.y;
				precise float vertex_unnamed_53 = vertex_unnamed_44 * vertex_uniform_buffer_0[1u].x;
				precise float vertex_unnamed_54 = vertex_unnamed_44 * vertex_uniform_buffer_0[1u].y;
				precise float vertex_unnamed_55 = vertex_unnamed_44 * vertex_uniform_buffer_0[1u].z;
				precise float vertex_unnamed_56 = vertex_unnamed_44 * vertex_uniform_buffer_0[1u].w;
				vertex_output_3.y = vertex_unnamed_44;
				precise float vertex_unnamed_91 = mad(vertex_uniform_buffer_0[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].x, vertex_input_0.x, vertex_unnamed_53)) + vertex_uniform_buffer_0[3u].x;
				precise float vertex_unnamed_92 = mad(vertex_uniform_buffer_0[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].y, vertex_input_0.x, vertex_unnamed_54)) + vertex_uniform_buffer_0[3u].y;
				precise float vertex_unnamed_93 = mad(vertex_uniform_buffer_0[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].z, vertex_input_0.x, vertex_unnamed_55)) + vertex_uniform_buffer_0[3u].z;
				precise float vertex_unnamed_94 = mad(vertex_uniform_buffer_0[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].w, vertex_input_0.x, vertex_unnamed_56)) + vertex_uniform_buffer_0[3u].w;
				precise float vertex_unnamed_102 = vertex_unnamed_92 * vertex_uniform_buffer_1[18u].x;
				precise float vertex_unnamed_103 = vertex_unnamed_92 * vertex_uniform_buffer_1[18u].y;
				precise float vertex_unnamed_104 = vertex_unnamed_92 * vertex_uniform_buffer_1[18u].z;
				precise float vertex_unnamed_105 = vertex_unnamed_92 * vertex_uniform_buffer_1[18u].w;
				gl_Position.x = mad(vertex_uniform_buffer_1[20u].x, vertex_unnamed_94, mad(vertex_uniform_buffer_1[19u].x, vertex_unnamed_93, mad(vertex_uniform_buffer_1[17u].x, vertex_unnamed_91, vertex_unnamed_102)));
				gl_Position.y = mad(vertex_uniform_buffer_1[20u].y, vertex_unnamed_94, mad(vertex_uniform_buffer_1[19u].y, vertex_unnamed_93, mad(vertex_uniform_buffer_1[17u].y, vertex_unnamed_91, vertex_unnamed_103)));
				gl_Position.z = mad(vertex_uniform_buffer_1[20u].z, vertex_unnamed_94, mad(vertex_uniform_buffer_1[19u].z, vertex_unnamed_93, mad(vertex_uniform_buffer_1[17u].z, vertex_unnamed_91, vertex_unnamed_104)));
				gl_Position.w = mad(vertex_uniform_buffer_1[20u].w, vertex_unnamed_94, mad(vertex_uniform_buffer_1[19u].w, vertex_unnamed_93, mad(vertex_uniform_buffer_1[17u].w, vertex_unnamed_91, vertex_unnamed_105)));
				vertex_output_1.x = vertex_input_1.x;
				vertex_output_1.y = vertex_input_1.y;
				vertex_output_1.z = vertex_input_1.z;
				vertex_output_1.w = vertex_input_1.w;
				vertex_output_2.x = vertex_input_2.x;
				vertex_output_2.y = vertex_input_2.y;
				vertex_output_3.x = vertex_input_0.x;
				vertex_output_3.z = vertex_input_0.z;
				vertex_output_3.w = vertex_input_0.w;
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
				vertex_input_2 = stage_input.vertex_input_2;
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

			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[4];
			static float4 vertex_uniform_buffer_1[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float2 vertex_input_2;
			static float4 vertex_output_1;
			static float2 vertex_output_2;
			static float4 vertex_output_3;

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
				float4 vertex_output_3 : TEXCOORD1; // TEXCOORD_1
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_44 = asfloat((vertex_input_1.z < 0.75f) ? 3221225472u : 3212836864u) + vertex_input_0.y;
				precise float vertex_unnamed_53 = vertex_unnamed_44 * vertex_uniform_buffer_0[1u].x;
				precise float vertex_unnamed_54 = vertex_unnamed_44 * vertex_uniform_buffer_0[1u].y;
				precise float vertex_unnamed_55 = vertex_unnamed_44 * vertex_uniform_buffer_0[1u].z;
				precise float vertex_unnamed_56 = vertex_unnamed_44 * vertex_uniform_buffer_0[1u].w;
				vertex_output_3.y = vertex_unnamed_44;
				precise float vertex_unnamed_91 = mad(vertex_uniform_buffer_0[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].x, vertex_input_0.x, vertex_unnamed_53)) + vertex_uniform_buffer_0[3u].x;
				precise float vertex_unnamed_92 = mad(vertex_uniform_buffer_0[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].y, vertex_input_0.x, vertex_unnamed_54)) + vertex_uniform_buffer_0[3u].y;
				precise float vertex_unnamed_93 = mad(vertex_uniform_buffer_0[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].z, vertex_input_0.x, vertex_unnamed_55)) + vertex_uniform_buffer_0[3u].z;
				precise float vertex_unnamed_94 = mad(vertex_uniform_buffer_0[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].w, vertex_input_0.x, vertex_unnamed_56)) + vertex_uniform_buffer_0[3u].w;
				precise float vertex_unnamed_102 = vertex_unnamed_92 * vertex_uniform_buffer_1[18u].x;
				precise float vertex_unnamed_103 = vertex_unnamed_92 * vertex_uniform_buffer_1[18u].y;
				precise float vertex_unnamed_104 = vertex_unnamed_92 * vertex_uniform_buffer_1[18u].z;
				precise float vertex_unnamed_105 = vertex_unnamed_92 * vertex_uniform_buffer_1[18u].w;
				gl_Position.x = mad(vertex_uniform_buffer_1[20u].x, vertex_unnamed_94, mad(vertex_uniform_buffer_1[19u].x, vertex_unnamed_93, mad(vertex_uniform_buffer_1[17u].x, vertex_unnamed_91, vertex_unnamed_102)));
				gl_Position.y = mad(vertex_uniform_buffer_1[20u].y, vertex_unnamed_94, mad(vertex_uniform_buffer_1[19u].y, vertex_unnamed_93, mad(vertex_uniform_buffer_1[17u].y, vertex_unnamed_91, vertex_unnamed_103)));
				gl_Position.z = mad(vertex_uniform_buffer_1[20u].z, vertex_unnamed_94, mad(vertex_uniform_buffer_1[19u].z, vertex_unnamed_93, mad(vertex_uniform_buffer_1[17u].z, vertex_unnamed_91, vertex_unnamed_104)));
				gl_Position.w = mad(vertex_uniform_buffer_1[20u].w, vertex_unnamed_94, mad(vertex_uniform_buffer_1[19u].w, vertex_unnamed_93, mad(vertex_uniform_buffer_1[17u].w, vertex_unnamed_91, vertex_unnamed_105)));
				vertex_output_1.x = vertex_input_1.x;
				vertex_output_1.y = vertex_input_1.y;
				vertex_output_1.z = vertex_input_1.z;
				vertex_output_1.w = vertex_input_1.w;
				vertex_output_2.x = vertex_input_2.x;
				vertex_output_2.y = vertex_input_2.y;
				vertex_output_3.x = vertex_input_0.x;
				vertex_output_3.z = vertex_input_0.z;
				vertex_output_3.w = vertex_input_0.w;
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
				vertex_input_2 = stage_input.vertex_input_2;
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

			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[4];
			static float4 vertex_uniform_buffer_1[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float2 vertex_input_2;
			static float4 vertex_output_1;
			static float2 vertex_output_2;
			static float4 vertex_output_3;

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
				float4 vertex_output_3 : TEXCOORD1; // TEXCOORD_1
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_44 = asfloat((vertex_input_1.z < 0.75f) ? 3221225472u : 3212836864u) + vertex_input_0.y;
				precise float vertex_unnamed_53 = vertex_unnamed_44 * vertex_uniform_buffer_0[1u].x;
				precise float vertex_unnamed_54 = vertex_unnamed_44 * vertex_uniform_buffer_0[1u].y;
				precise float vertex_unnamed_55 = vertex_unnamed_44 * vertex_uniform_buffer_0[1u].z;
				precise float vertex_unnamed_56 = vertex_unnamed_44 * vertex_uniform_buffer_0[1u].w;
				vertex_output_3.y = vertex_unnamed_44;
				precise float vertex_unnamed_91 = mad(vertex_uniform_buffer_0[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].x, vertex_input_0.x, vertex_unnamed_53)) + vertex_uniform_buffer_0[3u].x;
				precise float vertex_unnamed_92 = mad(vertex_uniform_buffer_0[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].y, vertex_input_0.x, vertex_unnamed_54)) + vertex_uniform_buffer_0[3u].y;
				precise float vertex_unnamed_93 = mad(vertex_uniform_buffer_0[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].z, vertex_input_0.x, vertex_unnamed_55)) + vertex_uniform_buffer_0[3u].z;
				precise float vertex_unnamed_94 = mad(vertex_uniform_buffer_0[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].w, vertex_input_0.x, vertex_unnamed_56)) + vertex_uniform_buffer_0[3u].w;
				precise float vertex_unnamed_102 = vertex_unnamed_92 * vertex_uniform_buffer_1[18u].x;
				precise float vertex_unnamed_103 = vertex_unnamed_92 * vertex_uniform_buffer_1[18u].y;
				precise float vertex_unnamed_104 = vertex_unnamed_92 * vertex_uniform_buffer_1[18u].z;
				precise float vertex_unnamed_105 = vertex_unnamed_92 * vertex_uniform_buffer_1[18u].w;
				gl_Position.x = mad(vertex_uniform_buffer_1[20u].x, vertex_unnamed_94, mad(vertex_uniform_buffer_1[19u].x, vertex_unnamed_93, mad(vertex_uniform_buffer_1[17u].x, vertex_unnamed_91, vertex_unnamed_102)));
				gl_Position.y = mad(vertex_uniform_buffer_1[20u].y, vertex_unnamed_94, mad(vertex_uniform_buffer_1[19u].y, vertex_unnamed_93, mad(vertex_uniform_buffer_1[17u].y, vertex_unnamed_91, vertex_unnamed_103)));
				gl_Position.z = mad(vertex_uniform_buffer_1[20u].z, vertex_unnamed_94, mad(vertex_uniform_buffer_1[19u].z, vertex_unnamed_93, mad(vertex_uniform_buffer_1[17u].z, vertex_unnamed_91, vertex_unnamed_104)));
				gl_Position.w = mad(vertex_uniform_buffer_1[20u].w, vertex_unnamed_94, mad(vertex_uniform_buffer_1[19u].w, vertex_unnamed_93, mad(vertex_uniform_buffer_1[17u].w, vertex_unnamed_91, vertex_unnamed_105)));
				vertex_output_1.x = vertex_input_1.x;
				vertex_output_1.y = vertex_input_1.y;
				vertex_output_1.z = vertex_input_1.z;
				vertex_output_1.w = vertex_input_1.w;
				vertex_output_2.x = vertex_input_2.x;
				vertex_output_2.y = vertex_input_2.y;
				vertex_output_3.x = vertex_input_0.x;
				vertex_output_3.z = vertex_input_0.z;
				vertex_output_3.w = vertex_input_0.w;
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
				vertex_input_2 = stage_input.vertex_input_2;
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

			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[4];
			static float4 vertex_uniform_buffer_1[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float2 vertex_input_2;
			static float4 vertex_output_1;
			static float2 vertex_output_2;
			static float4 vertex_output_3;

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
				float4 vertex_output_3 : TEXCOORD1; // TEXCOORD_1
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_44 = asfloat((vertex_input_1.z < 0.75f) ? 3221225472u : 3212836864u) + vertex_input_0.y;
				precise float vertex_unnamed_53 = vertex_unnamed_44 * vertex_uniform_buffer_0[1u].x;
				precise float vertex_unnamed_54 = vertex_unnamed_44 * vertex_uniform_buffer_0[1u].y;
				precise float vertex_unnamed_55 = vertex_unnamed_44 * vertex_uniform_buffer_0[1u].z;
				precise float vertex_unnamed_56 = vertex_unnamed_44 * vertex_uniform_buffer_0[1u].w;
				vertex_output_3.y = vertex_unnamed_44;
				precise float vertex_unnamed_91 = mad(vertex_uniform_buffer_0[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].x, vertex_input_0.x, vertex_unnamed_53)) + vertex_uniform_buffer_0[3u].x;
				precise float vertex_unnamed_92 = mad(vertex_uniform_buffer_0[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].y, vertex_input_0.x, vertex_unnamed_54)) + vertex_uniform_buffer_0[3u].y;
				precise float vertex_unnamed_93 = mad(vertex_uniform_buffer_0[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].z, vertex_input_0.x, vertex_unnamed_55)) + vertex_uniform_buffer_0[3u].z;
				precise float vertex_unnamed_94 = mad(vertex_uniform_buffer_0[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].w, vertex_input_0.x, vertex_unnamed_56)) + vertex_uniform_buffer_0[3u].w;
				precise float vertex_unnamed_102 = vertex_unnamed_92 * vertex_uniform_buffer_1[18u].x;
				precise float vertex_unnamed_103 = vertex_unnamed_92 * vertex_uniform_buffer_1[18u].y;
				precise float vertex_unnamed_104 = vertex_unnamed_92 * vertex_uniform_buffer_1[18u].z;
				precise float vertex_unnamed_105 = vertex_unnamed_92 * vertex_uniform_buffer_1[18u].w;
				gl_Position.x = mad(vertex_uniform_buffer_1[20u].x, vertex_unnamed_94, mad(vertex_uniform_buffer_1[19u].x, vertex_unnamed_93, mad(vertex_uniform_buffer_1[17u].x, vertex_unnamed_91, vertex_unnamed_102)));
				gl_Position.y = mad(vertex_uniform_buffer_1[20u].y, vertex_unnamed_94, mad(vertex_uniform_buffer_1[19u].y, vertex_unnamed_93, mad(vertex_uniform_buffer_1[17u].y, vertex_unnamed_91, vertex_unnamed_103)));
				gl_Position.z = mad(vertex_uniform_buffer_1[20u].z, vertex_unnamed_94, mad(vertex_uniform_buffer_1[19u].z, vertex_unnamed_93, mad(vertex_uniform_buffer_1[17u].z, vertex_unnamed_91, vertex_unnamed_104)));
				gl_Position.w = mad(vertex_uniform_buffer_1[20u].w, vertex_unnamed_94, mad(vertex_uniform_buffer_1[19u].w, vertex_unnamed_93, mad(vertex_uniform_buffer_1[17u].w, vertex_unnamed_91, vertex_unnamed_105)));
				vertex_output_1.x = vertex_input_1.x;
				vertex_output_1.y = vertex_input_1.y;
				vertex_output_1.z = vertex_input_1.z;
				vertex_output_1.w = vertex_input_1.w;
				vertex_output_2.x = vertex_input_2.x;
				vertex_output_2.y = vertex_input_2.y;
				vertex_output_3.x = vertex_input_0.x;
				vertex_output_3.z = vertex_input_0.z;
				vertex_output_3.w = vertex_input_0.w;
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
				vertex_input_2 = stage_input.vertex_input_2;
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

			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;

			static float4 unity_ObjectToWorld__array[4];
			static float4 unity_MatrixVP__array[4];
			static float4 gl_Position;
			static float4 vertex_input_1;
			static float4 vertex_input_0;
			static float4 vertex_output_2;
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
				float4 vertex_output_2 : TEXCOORD1; // vs_TEXCOORD1
				float4 gl_Position : SV_Position;
			};

			static bool vertex_unnamed_8;
			static float4 vertex_unnamed_21;
			static float4 vertex_unnamed_37;

			void vert_main()
			{
				vertex_unnamed_8 = vertex_input_1.z < 0.75f;
				vertex_unnamed_21.x = vertex_unnamed_8 ? (-2.0f) : (-1.0f);
				vertex_unnamed_21.x += vertex_input_0.y;
				vertex_unnamed_37 = vertex_unnamed_21.xxxx * unity_ObjectToWorld__array[1];
				vertex_output_2.y = vertex_unnamed_21.x;
				vertex_unnamed_21 = (unity_ObjectToWorld__array[0] * vertex_input_0.xxxx) + vertex_unnamed_37;
				vertex_unnamed_21 = (unity_ObjectToWorld__array[2] * vertex_input_0.zzzz) + vertex_unnamed_21;
				vertex_unnamed_21 += unity_ObjectToWorld__array[3];
				vertex_unnamed_37 = vertex_unnamed_21.yyyy * unity_MatrixVP__array[1];
				vertex_unnamed_37 = (unity_MatrixVP__array[0] * vertex_unnamed_21.xxxx) + vertex_unnamed_37;
				vertex_unnamed_37 = (unity_MatrixVP__array[2] * vertex_unnamed_21.zzzz) + vertex_unnamed_37;
				gl_Position = (unity_MatrixVP__array[3] * vertex_unnamed_21.wwww) + vertex_unnamed_37;
				vertex_output_0 = vertex_input_1;
				vertex_output_1 = vertex_input_2;
				vertex_output_2 = float4(vertex_input_0.xzw.x, vertex_output_2.y, vertex_input_0.xzw.y, vertex_input_0.xzw.z);
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
				vertex_input_0 = stage_input.vertex_input_0;
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
				fragment_output_0.w = fragment_unnamed_8;
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

			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;

			static float4 unity_ObjectToWorld__array[4];
			static float4 unity_MatrixVP__array[4];
			static float4 gl_Position;
			static float4 vertex_input_1;
			static float4 vertex_input_0;
			static float4 vertex_output_2;
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
				float4 vertex_output_2 : TEXCOORD1; // vs_TEXCOORD1
				float4 gl_Position : SV_Position;
			};

			static bool vertex_unnamed_8;
			static float4 vertex_unnamed_21;
			static float4 vertex_unnamed_37;

			void vert_main()
			{
				vertex_unnamed_8 = vertex_input_1.z < 0.75f;
				vertex_unnamed_21.x = vertex_unnamed_8 ? (-2.0f) : (-1.0f);
				vertex_unnamed_21.x += vertex_input_0.y;
				vertex_unnamed_37 = vertex_unnamed_21.xxxx * unity_ObjectToWorld__array[1];
				vertex_output_2.y = vertex_unnamed_21.x;
				vertex_unnamed_21 = (unity_ObjectToWorld__array[0] * vertex_input_0.xxxx) + vertex_unnamed_37;
				vertex_unnamed_21 = (unity_ObjectToWorld__array[2] * vertex_input_0.zzzz) + vertex_unnamed_21;
				vertex_unnamed_21 += unity_ObjectToWorld__array[3];
				vertex_unnamed_37 = vertex_unnamed_21.yyyy * unity_MatrixVP__array[1];
				vertex_unnamed_37 = (unity_MatrixVP__array[0] * vertex_unnamed_21.xxxx) + vertex_unnamed_37;
				vertex_unnamed_37 = (unity_MatrixVP__array[2] * vertex_unnamed_21.zzzz) + vertex_unnamed_37;
				gl_Position = (unity_MatrixVP__array[3] * vertex_unnamed_21.wwww) + vertex_unnamed_37;
				vertex_output_0 = vertex_input_1;
				vertex_output_1 = vertex_input_2;
				vertex_output_2 = float4(vertex_input_0.xzw.x, vertex_output_2.y, vertex_input_0.xzw.y, vertex_input_0.xzw.z);
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
				vertex_input_0 = stage_input.vertex_input_0;
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
			static float fragment_unnamed_28;
			static bool fragment_unnamed_39;

			void frag_main()
			{
				fragment_unnamed_8 = _MainTex.Sample(sampler_MainTex, fragment_input_1).w;
				fragment_unnamed_28 = fragment_unnamed_8 + (-0.001000000047497451305389404296875f);
				fragment_output_0.w = fragment_unnamed_8;
				fragment_unnamed_39 = fragment_unnamed_28 < 0.0f;
				if ((int(fragment_unnamed_39) * (-1)) != 0)
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

			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;

			static float4 unity_ObjectToWorld__array[4];
			static float4 unity_MatrixVP__array[4];
			static float4 gl_Position;
			static float4 vertex_input_1;
			static float4 vertex_input_0;
			static float4 vertex_output_2;
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
				float4 vertex_output_2 : TEXCOORD1; // vs_TEXCOORD1
				float4 gl_Position : SV_Position;
			};

			static bool vertex_unnamed_8;
			static float4 vertex_unnamed_21;
			static float4 vertex_unnamed_37;

			void vert_main()
			{
				vertex_unnamed_8 = vertex_input_1.z < 0.75f;
				vertex_unnamed_21.x = vertex_unnamed_8 ? (-2.0f) : (-1.0f);
				vertex_unnamed_21.x += vertex_input_0.y;
				vertex_unnamed_37 = vertex_unnamed_21.xxxx * unity_ObjectToWorld__array[1];
				vertex_output_2.y = vertex_unnamed_21.x;
				vertex_unnamed_21 = (unity_ObjectToWorld__array[0] * vertex_input_0.xxxx) + vertex_unnamed_37;
				vertex_unnamed_21 = (unity_ObjectToWorld__array[2] * vertex_input_0.zzzz) + vertex_unnamed_21;
				vertex_unnamed_21 += unity_ObjectToWorld__array[3];
				vertex_unnamed_37 = vertex_unnamed_21.yyyy * unity_MatrixVP__array[1];
				vertex_unnamed_37 = (unity_MatrixVP__array[0] * vertex_unnamed_21.xxxx) + vertex_unnamed_37;
				vertex_unnamed_37 = (unity_MatrixVP__array[2] * vertex_unnamed_21.zzzz) + vertex_unnamed_37;
				gl_Position = (unity_MatrixVP__array[3] * vertex_unnamed_21.wwww) + vertex_unnamed_37;
				vertex_output_0 = vertex_input_1;
				vertex_output_1 = vertex_input_2;
				vertex_output_2 = float4(vertex_input_0.xzw.x, vertex_output_2.y, vertex_input_0.xzw.y, vertex_input_0.xzw.z);
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
				vertex_input_0 = stage_input.vertex_input_0;
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
			static float4 fragment_output_0;
			static float4 fragment_input_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_0 : UNKNOWN0;
				float2 fragment_input_1 : TEXCOORD0; // vs_TEXCOORD0
				float4 fragment_input_2 : TEXCOORD1; // vs_TEXCOORD1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static bool4 fragment_unnamed_9;
			static float4 fragment_unnamed_40;
			static float fragment_unnamed_80;

			void frag_main()
			{
				bool2 fragment_unnamed_27 = bool4(fragment_input_2.xyxx.x >= _ClipRect.xyxx.x, fragment_input_2.xyxx.y >= _ClipRect.xyxx.y, fragment_input_2.xyxx.z >= _ClipRect.xyxx.z, fragment_input_2.xyxx.w >= _ClipRect.xyxx.w).xy;
				fragment_unnamed_9 = bool4(fragment_unnamed_27.x, fragment_unnamed_27.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
				bool2 fragment_unnamed_36 = bool4(_ClipRect.zzzw.x >= fragment_input_2.xxxy.x, _ClipRect.zzzw.y >= fragment_input_2.xxxy.y, _ClipRect.zzzw.z >= fragment_input_2.xxxy.z, _ClipRect.zzzw.w >= fragment_input_2.xxxy.w).zw;
				fragment_unnamed_9 = bool4(fragment_unnamed_9.x, fragment_unnamed_9.y, fragment_unnamed_36.x, fragment_unnamed_36.y);
				fragment_unnamed_40.x = float(fragment_unnamed_9.x);
				fragment_unnamed_40.y = float(fragment_unnamed_9.y);
				fragment_unnamed_40.z = float(fragment_unnamed_9.z);
				fragment_unnamed_40.w = float(fragment_unnamed_9.w);
				float2 fragment_unnamed_71 = fragment_unnamed_40.zw * fragment_unnamed_40.xy;
				fragment_unnamed_40 = float4(fragment_unnamed_71.x, fragment_unnamed_71.y, fragment_unnamed_40.z, fragment_unnamed_40.w);
				fragment_unnamed_40.x = fragment_unnamed_40.y * fragment_unnamed_40.x;
				fragment_unnamed_80 = _MainTex.Sample(sampler_MainTex, fragment_input_1).w;
				fragment_output_0.w = fragment_unnamed_40.x * fragment_unnamed_80;
				fragment_output_0 = float4(fragment_input_0.xyz.x, fragment_input_0.xyz.y, fragment_input_0.xyz.z, fragment_output_0.w);
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

			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;

			static float4 unity_ObjectToWorld__array[4];
			static float4 unity_MatrixVP__array[4];
			static float4 gl_Position;
			static float4 vertex_input_1;
			static float4 vertex_input_0;
			static float4 vertex_output_2;
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
				float4 vertex_output_2 : TEXCOORD1; // vs_TEXCOORD1
				float4 gl_Position : SV_Position;
			};

			static bool vertex_unnamed_8;
			static float4 vertex_unnamed_21;
			static float4 vertex_unnamed_37;

			void vert_main()
			{
				vertex_unnamed_8 = vertex_input_1.z < 0.75f;
				vertex_unnamed_21.x = vertex_unnamed_8 ? (-2.0f) : (-1.0f);
				vertex_unnamed_21.x += vertex_input_0.y;
				vertex_unnamed_37 = vertex_unnamed_21.xxxx * unity_ObjectToWorld__array[1];
				vertex_output_2.y = vertex_unnamed_21.x;
				vertex_unnamed_21 = (unity_ObjectToWorld__array[0] * vertex_input_0.xxxx) + vertex_unnamed_37;
				vertex_unnamed_21 = (unity_ObjectToWorld__array[2] * vertex_input_0.zzzz) + vertex_unnamed_21;
				vertex_unnamed_21 += unity_ObjectToWorld__array[3];
				vertex_unnamed_37 = vertex_unnamed_21.yyyy * unity_MatrixVP__array[1];
				vertex_unnamed_37 = (unity_MatrixVP__array[0] * vertex_unnamed_21.xxxx) + vertex_unnamed_37;
				vertex_unnamed_37 = (unity_MatrixVP__array[2] * vertex_unnamed_21.zzzz) + vertex_unnamed_37;
				gl_Position = (unity_MatrixVP__array[3] * vertex_unnamed_21.wwww) + vertex_unnamed_37;
				vertex_output_0 = vertex_input_1;
				vertex_output_1 = vertex_input_2;
				vertex_output_2 = float4(vertex_input_0.xzw.x, vertex_output_2.y, vertex_input_0.xzw.y, vertex_input_0.xzw.z);
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
				vertex_input_0 = stage_input.vertex_input_0;
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
			static float4 fragment_output_0;
			static float4 fragment_input_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_0 : UNKNOWN0;
				float2 fragment_input_1 : TEXCOORD0; // vs_TEXCOORD0
				float4 fragment_input_2 : TEXCOORD1; // vs_TEXCOORD1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static bool4 fragment_unnamed_9;
			static float4 fragment_unnamed_40;
			static float fragment_unnamed_80;
			static float fragment_unnamed_96;

			void frag_main()
			{
				bool2 fragment_unnamed_27 = bool4(fragment_input_2.xyxx.x >= _ClipRect.xyxx.x, fragment_input_2.xyxx.y >= _ClipRect.xyxx.y, fragment_input_2.xyxx.z >= _ClipRect.xyxx.z, fragment_input_2.xyxx.w >= _ClipRect.xyxx.w).xy;
				fragment_unnamed_9 = bool4(fragment_unnamed_27.x, fragment_unnamed_27.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
				bool2 fragment_unnamed_36 = bool4(_ClipRect.zzzw.x >= fragment_input_2.xxxy.x, _ClipRect.zzzw.y >= fragment_input_2.xxxy.y, _ClipRect.zzzw.z >= fragment_input_2.xxxy.z, _ClipRect.zzzw.w >= fragment_input_2.xxxy.w).zw;
				fragment_unnamed_9 = bool4(fragment_unnamed_9.x, fragment_unnamed_9.y, fragment_unnamed_36.x, fragment_unnamed_36.y);
				fragment_unnamed_40.x = float(fragment_unnamed_9.x);
				fragment_unnamed_40.y = float(fragment_unnamed_9.y);
				fragment_unnamed_40.z = float(fragment_unnamed_9.z);
				fragment_unnamed_40.w = float(fragment_unnamed_9.w);
				float2 fragment_unnamed_71 = fragment_unnamed_40.zw * fragment_unnamed_40.xy;
				fragment_unnamed_40 = float4(fragment_unnamed_71.x, fragment_unnamed_71.y, fragment_unnamed_40.z, fragment_unnamed_40.w);
				fragment_unnamed_40.x = fragment_unnamed_40.y * fragment_unnamed_40.x;
				fragment_unnamed_80 = _MainTex.Sample(sampler_MainTex, fragment_input_1).w;
				fragment_unnamed_96 = (fragment_unnamed_80 * fragment_unnamed_40.x) + (-0.001000000047497451305389404296875f);
				fragment_unnamed_40.x *= fragment_unnamed_80;
				fragment_output_0.w = fragment_unnamed_40.x;
				fragment_unnamed_9.x = fragment_unnamed_96 < 0.0f;
				if ((int(fragment_unnamed_9.x) * (-1)) != 0)
				{
					discard;
				}
				fragment_output_0 = float4(fragment_input_0.xyz.x, fragment_input_0.xyz.y, fragment_input_0.xyz.z, fragment_output_0.w);
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
				float4 fragment_input_3 : TEXCOORD1; // TEXCOORD_1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				fragment_output_0.w = _MainTex.Sample(sampler_MainTex, float2(fragment_input_2.x, fragment_input_2.y)).w;
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
				float4 fragment_input_3 : TEXCOORD1; // TEXCOORD_1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static bool discard_state;

			void discard_cond(bool fragment_unnamed_60)
			{
				if (fragment_unnamed_60)
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
				precise float fragment_unnamed_38 = fragment_unnamed_37 + (-0.001000000047497451305389404296875f);
				fragment_output_0.w = fragment_unnamed_37;
				discard_cond(fragment_unnamed_38 < 0.0f);
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

			static float4 fragment_uniform_buffer_0[4];
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
				float4 fragment_input_3 : TEXCOORD1; // TEXCOORD_1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				precise float fragment_unnamed_70 = asfloat(((fragment_uniform_buffer_0[3u].z >= fragment_input_3.x) ? 4294967295u : 0u) & 1065353216u) * asfloat(((fragment_input_3.x >= fragment_uniform_buffer_0[3u].x) ? 4294967295u : 0u) & 1065353216u);
				precise float fragment_unnamed_71 = asfloat(((fragment_uniform_buffer_0[3u].w >= fragment_input_3.y) ? 4294967295u : 0u) & 1065353216u) * asfloat(((fragment_input_3.y >= fragment_uniform_buffer_0[3u].y) ? 4294967295u : 0u) & 1065353216u);
				precise float fragment_unnamed_72 = fragment_unnamed_71 * fragment_unnamed_70;
				precise float fragment_unnamed_83 = fragment_unnamed_72 * _MainTex.Sample(sampler_MainTex, float2(fragment_input_2.x, fragment_input_2.y)).w;
				fragment_output_0.w = fragment_unnamed_83;
				fragment_output_0.x = fragment_input_1.x;
				fragment_output_0.y = fragment_input_1.y;
				fragment_output_0.z = fragment_input_1.z;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[3] = float4(_ClipRect[0], _ClipRect[1], _ClipRect[2], _ClipRect[3]);

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

			static float4 fragment_uniform_buffer_0[4];
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
				float4 fragment_input_3 : TEXCOORD1; // TEXCOORD_1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static bool discard_state;

			void discard_cond(bool fragment_unnamed_105)
			{
				if (fragment_unnamed_105)
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
				precise float fragment_unnamed_70 = asfloat(((fragment_uniform_buffer_0[3u].z >= fragment_input_3.x) ? 4294967295u : 0u) & 1065353216u) * asfloat(((fragment_input_3.x >= fragment_uniform_buffer_0[3u].x) ? 4294967295u : 0u) & 1065353216u);
				precise float fragment_unnamed_71 = asfloat(((fragment_uniform_buffer_0[3u].w >= fragment_input_3.y) ? 4294967295u : 0u) & 1065353216u) * asfloat(((fragment_input_3.y >= fragment_uniform_buffer_0[3u].y) ? 4294967295u : 0u) & 1065353216u);
				precise float fragment_unnamed_72 = fragment_unnamed_71 * fragment_unnamed_70;
				float4 fragment_unnamed_80 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_2.x, fragment_input_2.y));
				float fragment_unnamed_82 = fragment_unnamed_80.w;
				precise float fragment_unnamed_86 = fragment_unnamed_72 * fragment_unnamed_82;
				fragment_output_0.w = fragment_unnamed_86;
				discard_cond(mad(fragment_unnamed_82, fragment_unnamed_72, -0.001000000047497451305389404296875f) < 0.0f);
				fragment_output_0.x = fragment_input_1.x;
				fragment_output_0.y = fragment_input_1.y;
				fragment_output_0.z = fragment_input_1.z;
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[3] = float4(_ClipRect[0], _ClipRect[1], _ClipRect[2], _ClipRect[3]);

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
		Pass
		{
			Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
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
			GpuProgramID 226678

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

			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[4];
			static float4 vertex_uniform_buffer_1[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float2 vertex_input_2;
			static float4 vertex_output_1;
			static float2 vertex_output_2;
			static float4 vertex_output_3;

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
				float4 vertex_output_3 : TEXCOORD1; // TEXCOORD_1
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_44 = asfloat((vertex_input_1.z < 0.75f) ? 1073741824u : 1065353216u) + vertex_input_0.y;
				precise float vertex_unnamed_53 = vertex_unnamed_44 * vertex_uniform_buffer_0[1u].x;
				precise float vertex_unnamed_54 = vertex_unnamed_44 * vertex_uniform_buffer_0[1u].y;
				precise float vertex_unnamed_55 = vertex_unnamed_44 * vertex_uniform_buffer_0[1u].z;
				precise float vertex_unnamed_56 = vertex_unnamed_44 * vertex_uniform_buffer_0[1u].w;
				vertex_output_3.y = vertex_unnamed_44;
				precise float vertex_unnamed_91 = mad(vertex_uniform_buffer_0[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].x, vertex_input_0.x, vertex_unnamed_53)) + vertex_uniform_buffer_0[3u].x;
				precise float vertex_unnamed_92 = mad(vertex_uniform_buffer_0[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].y, vertex_input_0.x, vertex_unnamed_54)) + vertex_uniform_buffer_0[3u].y;
				precise float vertex_unnamed_93 = mad(vertex_uniform_buffer_0[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].z, vertex_input_0.x, vertex_unnamed_55)) + vertex_uniform_buffer_0[3u].z;
				precise float vertex_unnamed_94 = mad(vertex_uniform_buffer_0[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].w, vertex_input_0.x, vertex_unnamed_56)) + vertex_uniform_buffer_0[3u].w;
				precise float vertex_unnamed_102 = vertex_unnamed_92 * vertex_uniform_buffer_1[18u].x;
				precise float vertex_unnamed_103 = vertex_unnamed_92 * vertex_uniform_buffer_1[18u].y;
				precise float vertex_unnamed_104 = vertex_unnamed_92 * vertex_uniform_buffer_1[18u].z;
				precise float vertex_unnamed_105 = vertex_unnamed_92 * vertex_uniform_buffer_1[18u].w;
				gl_Position.x = mad(vertex_uniform_buffer_1[20u].x, vertex_unnamed_94, mad(vertex_uniform_buffer_1[19u].x, vertex_unnamed_93, mad(vertex_uniform_buffer_1[17u].x, vertex_unnamed_91, vertex_unnamed_102)));
				gl_Position.y = mad(vertex_uniform_buffer_1[20u].y, vertex_unnamed_94, mad(vertex_uniform_buffer_1[19u].y, vertex_unnamed_93, mad(vertex_uniform_buffer_1[17u].y, vertex_unnamed_91, vertex_unnamed_103)));
				gl_Position.z = mad(vertex_uniform_buffer_1[20u].z, vertex_unnamed_94, mad(vertex_uniform_buffer_1[19u].z, vertex_unnamed_93, mad(vertex_uniform_buffer_1[17u].z, vertex_unnamed_91, vertex_unnamed_104)));
				gl_Position.w = mad(vertex_uniform_buffer_1[20u].w, vertex_unnamed_94, mad(vertex_uniform_buffer_1[19u].w, vertex_unnamed_93, mad(vertex_uniform_buffer_1[17u].w, vertex_unnamed_91, vertex_unnamed_105)));
				vertex_output_1.x = vertex_input_1.x;
				vertex_output_1.y = vertex_input_1.y;
				vertex_output_1.z = vertex_input_1.z;
				vertex_output_1.w = vertex_input_1.w;
				vertex_output_2.x = vertex_input_2.x;
				vertex_output_2.y = vertex_input_2.y;
				vertex_output_3.x = vertex_input_0.x;
				vertex_output_3.z = vertex_input_0.z;
				vertex_output_3.w = vertex_input_0.w;
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
				vertex_input_2 = stage_input.vertex_input_2;
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

			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[4];
			static float4 vertex_uniform_buffer_1[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float2 vertex_input_2;
			static float4 vertex_output_1;
			static float2 vertex_output_2;
			static float4 vertex_output_3;

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
				float4 vertex_output_3 : TEXCOORD1; // TEXCOORD_1
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_44 = asfloat((vertex_input_1.z < 0.75f) ? 1073741824u : 1065353216u) + vertex_input_0.y;
				precise float vertex_unnamed_53 = vertex_unnamed_44 * vertex_uniform_buffer_0[1u].x;
				precise float vertex_unnamed_54 = vertex_unnamed_44 * vertex_uniform_buffer_0[1u].y;
				precise float vertex_unnamed_55 = vertex_unnamed_44 * vertex_uniform_buffer_0[1u].z;
				precise float vertex_unnamed_56 = vertex_unnamed_44 * vertex_uniform_buffer_0[1u].w;
				vertex_output_3.y = vertex_unnamed_44;
				precise float vertex_unnamed_91 = mad(vertex_uniform_buffer_0[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].x, vertex_input_0.x, vertex_unnamed_53)) + vertex_uniform_buffer_0[3u].x;
				precise float vertex_unnamed_92 = mad(vertex_uniform_buffer_0[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].y, vertex_input_0.x, vertex_unnamed_54)) + vertex_uniform_buffer_0[3u].y;
				precise float vertex_unnamed_93 = mad(vertex_uniform_buffer_0[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].z, vertex_input_0.x, vertex_unnamed_55)) + vertex_uniform_buffer_0[3u].z;
				precise float vertex_unnamed_94 = mad(vertex_uniform_buffer_0[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].w, vertex_input_0.x, vertex_unnamed_56)) + vertex_uniform_buffer_0[3u].w;
				precise float vertex_unnamed_102 = vertex_unnamed_92 * vertex_uniform_buffer_1[18u].x;
				precise float vertex_unnamed_103 = vertex_unnamed_92 * vertex_uniform_buffer_1[18u].y;
				precise float vertex_unnamed_104 = vertex_unnamed_92 * vertex_uniform_buffer_1[18u].z;
				precise float vertex_unnamed_105 = vertex_unnamed_92 * vertex_uniform_buffer_1[18u].w;
				gl_Position.x = mad(vertex_uniform_buffer_1[20u].x, vertex_unnamed_94, mad(vertex_uniform_buffer_1[19u].x, vertex_unnamed_93, mad(vertex_uniform_buffer_1[17u].x, vertex_unnamed_91, vertex_unnamed_102)));
				gl_Position.y = mad(vertex_uniform_buffer_1[20u].y, vertex_unnamed_94, mad(vertex_uniform_buffer_1[19u].y, vertex_unnamed_93, mad(vertex_uniform_buffer_1[17u].y, vertex_unnamed_91, vertex_unnamed_103)));
				gl_Position.z = mad(vertex_uniform_buffer_1[20u].z, vertex_unnamed_94, mad(vertex_uniform_buffer_1[19u].z, vertex_unnamed_93, mad(vertex_uniform_buffer_1[17u].z, vertex_unnamed_91, vertex_unnamed_104)));
				gl_Position.w = mad(vertex_uniform_buffer_1[20u].w, vertex_unnamed_94, mad(vertex_uniform_buffer_1[19u].w, vertex_unnamed_93, mad(vertex_uniform_buffer_1[17u].w, vertex_unnamed_91, vertex_unnamed_105)));
				vertex_output_1.x = vertex_input_1.x;
				vertex_output_1.y = vertex_input_1.y;
				vertex_output_1.z = vertex_input_1.z;
				vertex_output_1.w = vertex_input_1.w;
				vertex_output_2.x = vertex_input_2.x;
				vertex_output_2.y = vertex_input_2.y;
				vertex_output_3.x = vertex_input_0.x;
				vertex_output_3.z = vertex_input_0.z;
				vertex_output_3.w = vertex_input_0.w;
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
				vertex_input_2 = stage_input.vertex_input_2;
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

			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[4];
			static float4 vertex_uniform_buffer_1[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float2 vertex_input_2;
			static float4 vertex_output_1;
			static float2 vertex_output_2;
			static float4 vertex_output_3;

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
				float4 vertex_output_3 : TEXCOORD1; // TEXCOORD_1
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_44 = asfloat((vertex_input_1.z < 0.75f) ? 1073741824u : 1065353216u) + vertex_input_0.y;
				precise float vertex_unnamed_53 = vertex_unnamed_44 * vertex_uniform_buffer_0[1u].x;
				precise float vertex_unnamed_54 = vertex_unnamed_44 * vertex_uniform_buffer_0[1u].y;
				precise float vertex_unnamed_55 = vertex_unnamed_44 * vertex_uniform_buffer_0[1u].z;
				precise float vertex_unnamed_56 = vertex_unnamed_44 * vertex_uniform_buffer_0[1u].w;
				vertex_output_3.y = vertex_unnamed_44;
				precise float vertex_unnamed_91 = mad(vertex_uniform_buffer_0[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].x, vertex_input_0.x, vertex_unnamed_53)) + vertex_uniform_buffer_0[3u].x;
				precise float vertex_unnamed_92 = mad(vertex_uniform_buffer_0[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].y, vertex_input_0.x, vertex_unnamed_54)) + vertex_uniform_buffer_0[3u].y;
				precise float vertex_unnamed_93 = mad(vertex_uniform_buffer_0[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].z, vertex_input_0.x, vertex_unnamed_55)) + vertex_uniform_buffer_0[3u].z;
				precise float vertex_unnamed_94 = mad(vertex_uniform_buffer_0[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].w, vertex_input_0.x, vertex_unnamed_56)) + vertex_uniform_buffer_0[3u].w;
				precise float vertex_unnamed_102 = vertex_unnamed_92 * vertex_uniform_buffer_1[18u].x;
				precise float vertex_unnamed_103 = vertex_unnamed_92 * vertex_uniform_buffer_1[18u].y;
				precise float vertex_unnamed_104 = vertex_unnamed_92 * vertex_uniform_buffer_1[18u].z;
				precise float vertex_unnamed_105 = vertex_unnamed_92 * vertex_uniform_buffer_1[18u].w;
				gl_Position.x = mad(vertex_uniform_buffer_1[20u].x, vertex_unnamed_94, mad(vertex_uniform_buffer_1[19u].x, vertex_unnamed_93, mad(vertex_uniform_buffer_1[17u].x, vertex_unnamed_91, vertex_unnamed_102)));
				gl_Position.y = mad(vertex_uniform_buffer_1[20u].y, vertex_unnamed_94, mad(vertex_uniform_buffer_1[19u].y, vertex_unnamed_93, mad(vertex_uniform_buffer_1[17u].y, vertex_unnamed_91, vertex_unnamed_103)));
				gl_Position.z = mad(vertex_uniform_buffer_1[20u].z, vertex_unnamed_94, mad(vertex_uniform_buffer_1[19u].z, vertex_unnamed_93, mad(vertex_uniform_buffer_1[17u].z, vertex_unnamed_91, vertex_unnamed_104)));
				gl_Position.w = mad(vertex_uniform_buffer_1[20u].w, vertex_unnamed_94, mad(vertex_uniform_buffer_1[19u].w, vertex_unnamed_93, mad(vertex_uniform_buffer_1[17u].w, vertex_unnamed_91, vertex_unnamed_105)));
				vertex_output_1.x = vertex_input_1.x;
				vertex_output_1.y = vertex_input_1.y;
				vertex_output_1.z = vertex_input_1.z;
				vertex_output_1.w = vertex_input_1.w;
				vertex_output_2.x = vertex_input_2.x;
				vertex_output_2.y = vertex_input_2.y;
				vertex_output_3.x = vertex_input_0.x;
				vertex_output_3.z = vertex_input_0.z;
				vertex_output_3.w = vertex_input_0.w;
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
				vertex_input_2 = stage_input.vertex_input_2;
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

			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[4];
			static float4 vertex_uniform_buffer_1[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float2 vertex_input_2;
			static float4 vertex_output_1;
			static float2 vertex_output_2;
			static float4 vertex_output_3;

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
				float4 vertex_output_3 : TEXCOORD1; // TEXCOORD_1
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_44 = asfloat((vertex_input_1.z < 0.75f) ? 1073741824u : 1065353216u) + vertex_input_0.y;
				precise float vertex_unnamed_53 = vertex_unnamed_44 * vertex_uniform_buffer_0[1u].x;
				precise float vertex_unnamed_54 = vertex_unnamed_44 * vertex_uniform_buffer_0[1u].y;
				precise float vertex_unnamed_55 = vertex_unnamed_44 * vertex_uniform_buffer_0[1u].z;
				precise float vertex_unnamed_56 = vertex_unnamed_44 * vertex_uniform_buffer_0[1u].w;
				vertex_output_3.y = vertex_unnamed_44;
				precise float vertex_unnamed_91 = mad(vertex_uniform_buffer_0[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].x, vertex_input_0.x, vertex_unnamed_53)) + vertex_uniform_buffer_0[3u].x;
				precise float vertex_unnamed_92 = mad(vertex_uniform_buffer_0[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].y, vertex_input_0.x, vertex_unnamed_54)) + vertex_uniform_buffer_0[3u].y;
				precise float vertex_unnamed_93 = mad(vertex_uniform_buffer_0[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].z, vertex_input_0.x, vertex_unnamed_55)) + vertex_uniform_buffer_0[3u].z;
				precise float vertex_unnamed_94 = mad(vertex_uniform_buffer_0[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].w, vertex_input_0.x, vertex_unnamed_56)) + vertex_uniform_buffer_0[3u].w;
				precise float vertex_unnamed_102 = vertex_unnamed_92 * vertex_uniform_buffer_1[18u].x;
				precise float vertex_unnamed_103 = vertex_unnamed_92 * vertex_uniform_buffer_1[18u].y;
				precise float vertex_unnamed_104 = vertex_unnamed_92 * vertex_uniform_buffer_1[18u].z;
				precise float vertex_unnamed_105 = vertex_unnamed_92 * vertex_uniform_buffer_1[18u].w;
				gl_Position.x = mad(vertex_uniform_buffer_1[20u].x, vertex_unnamed_94, mad(vertex_uniform_buffer_1[19u].x, vertex_unnamed_93, mad(vertex_uniform_buffer_1[17u].x, vertex_unnamed_91, vertex_unnamed_102)));
				gl_Position.y = mad(vertex_uniform_buffer_1[20u].y, vertex_unnamed_94, mad(vertex_uniform_buffer_1[19u].y, vertex_unnamed_93, mad(vertex_uniform_buffer_1[17u].y, vertex_unnamed_91, vertex_unnamed_103)));
				gl_Position.z = mad(vertex_uniform_buffer_1[20u].z, vertex_unnamed_94, mad(vertex_uniform_buffer_1[19u].z, vertex_unnamed_93, mad(vertex_uniform_buffer_1[17u].z, vertex_unnamed_91, vertex_unnamed_104)));
				gl_Position.w = mad(vertex_uniform_buffer_1[20u].w, vertex_unnamed_94, mad(vertex_uniform_buffer_1[19u].w, vertex_unnamed_93, mad(vertex_uniform_buffer_1[17u].w, vertex_unnamed_91, vertex_unnamed_105)));
				vertex_output_1.x = vertex_input_1.x;
				vertex_output_1.y = vertex_input_1.y;
				vertex_output_1.z = vertex_input_1.z;
				vertex_output_1.w = vertex_input_1.w;
				vertex_output_2.x = vertex_input_2.x;
				vertex_output_2.y = vertex_input_2.y;
				vertex_output_3.x = vertex_input_0.x;
				vertex_output_3.z = vertex_input_0.z;
				vertex_output_3.w = vertex_input_0.w;
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
				vertex_input_2 = stage_input.vertex_input_2;
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

			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;

			static float4 unity_ObjectToWorld__array[4];
			static float4 unity_MatrixVP__array[4];
			static float4 gl_Position;
			static float4 vertex_input_1;
			static float4 vertex_input_0;
			static float4 vertex_output_2;
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
				float4 vertex_output_2 : TEXCOORD1; // vs_TEXCOORD1
				float4 gl_Position : SV_Position;
			};

			static bool vertex_unnamed_8;
			static float4 vertex_unnamed_21;
			static float4 vertex_unnamed_37;

			void vert_main()
			{
				vertex_unnamed_8 = vertex_input_1.z < 0.75f;
				vertex_unnamed_21.x = vertex_unnamed_8 ? 2.0f : 1.0f;
				vertex_unnamed_21.x += vertex_input_0.y;
				vertex_unnamed_37 = vertex_unnamed_21.xxxx * unity_ObjectToWorld__array[1];
				vertex_output_2.y = vertex_unnamed_21.x;
				vertex_unnamed_21 = (unity_ObjectToWorld__array[0] * vertex_input_0.xxxx) + vertex_unnamed_37;
				vertex_unnamed_21 = (unity_ObjectToWorld__array[2] * vertex_input_0.zzzz) + vertex_unnamed_21;
				vertex_unnamed_21 += unity_ObjectToWorld__array[3];
				vertex_unnamed_37 = vertex_unnamed_21.yyyy * unity_MatrixVP__array[1];
				vertex_unnamed_37 = (unity_MatrixVP__array[0] * vertex_unnamed_21.xxxx) + vertex_unnamed_37;
				vertex_unnamed_37 = (unity_MatrixVP__array[2] * vertex_unnamed_21.zzzz) + vertex_unnamed_37;
				gl_Position = (unity_MatrixVP__array[3] * vertex_unnamed_21.wwww) + vertex_unnamed_37;
				vertex_output_0 = vertex_input_1;
				vertex_output_1 = vertex_input_2;
				vertex_output_2 = float4(vertex_input_0.xzw.x, vertex_output_2.y, vertex_input_0.xzw.y, vertex_input_0.xzw.z);
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
				vertex_input_0 = stage_input.vertex_input_0;
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
				fragment_output_0.w = fragment_unnamed_8;
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

			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;

			static float4 unity_ObjectToWorld__array[4];
			static float4 unity_MatrixVP__array[4];
			static float4 gl_Position;
			static float4 vertex_input_1;
			static float4 vertex_input_0;
			static float4 vertex_output_2;
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
				float4 vertex_output_2 : TEXCOORD1; // vs_TEXCOORD1
				float4 gl_Position : SV_Position;
			};

			static bool vertex_unnamed_8;
			static float4 vertex_unnamed_21;
			static float4 vertex_unnamed_37;

			void vert_main()
			{
				vertex_unnamed_8 = vertex_input_1.z < 0.75f;
				vertex_unnamed_21.x = vertex_unnamed_8 ? 2.0f : 1.0f;
				vertex_unnamed_21.x += vertex_input_0.y;
				vertex_unnamed_37 = vertex_unnamed_21.xxxx * unity_ObjectToWorld__array[1];
				vertex_output_2.y = vertex_unnamed_21.x;
				vertex_unnamed_21 = (unity_ObjectToWorld__array[0] * vertex_input_0.xxxx) + vertex_unnamed_37;
				vertex_unnamed_21 = (unity_ObjectToWorld__array[2] * vertex_input_0.zzzz) + vertex_unnamed_21;
				vertex_unnamed_21 += unity_ObjectToWorld__array[3];
				vertex_unnamed_37 = vertex_unnamed_21.yyyy * unity_MatrixVP__array[1];
				vertex_unnamed_37 = (unity_MatrixVP__array[0] * vertex_unnamed_21.xxxx) + vertex_unnamed_37;
				vertex_unnamed_37 = (unity_MatrixVP__array[2] * vertex_unnamed_21.zzzz) + vertex_unnamed_37;
				gl_Position = (unity_MatrixVP__array[3] * vertex_unnamed_21.wwww) + vertex_unnamed_37;
				vertex_output_0 = vertex_input_1;
				vertex_output_1 = vertex_input_2;
				vertex_output_2 = float4(vertex_input_0.xzw.x, vertex_output_2.y, vertex_input_0.xzw.y, vertex_input_0.xzw.z);
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
				vertex_input_0 = stage_input.vertex_input_0;
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
			static float fragment_unnamed_28;
			static bool fragment_unnamed_39;

			void frag_main()
			{
				fragment_unnamed_8 = _MainTex.Sample(sampler_MainTex, fragment_input_1).w;
				fragment_unnamed_28 = fragment_unnamed_8 + (-0.001000000047497451305389404296875f);
				fragment_output_0.w = fragment_unnamed_8;
				fragment_unnamed_39 = fragment_unnamed_28 < 0.0f;
				if ((int(fragment_unnamed_39) * (-1)) != 0)
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

			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;

			static float4 unity_ObjectToWorld__array[4];
			static float4 unity_MatrixVP__array[4];
			static float4 gl_Position;
			static float4 vertex_input_1;
			static float4 vertex_input_0;
			static float4 vertex_output_2;
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
				float4 vertex_output_2 : TEXCOORD1; // vs_TEXCOORD1
				float4 gl_Position : SV_Position;
			};

			static bool vertex_unnamed_8;
			static float4 vertex_unnamed_21;
			static float4 vertex_unnamed_37;

			void vert_main()
			{
				vertex_unnamed_8 = vertex_input_1.z < 0.75f;
				vertex_unnamed_21.x = vertex_unnamed_8 ? 2.0f : 1.0f;
				vertex_unnamed_21.x += vertex_input_0.y;
				vertex_unnamed_37 = vertex_unnamed_21.xxxx * unity_ObjectToWorld__array[1];
				vertex_output_2.y = vertex_unnamed_21.x;
				vertex_unnamed_21 = (unity_ObjectToWorld__array[0] * vertex_input_0.xxxx) + vertex_unnamed_37;
				vertex_unnamed_21 = (unity_ObjectToWorld__array[2] * vertex_input_0.zzzz) + vertex_unnamed_21;
				vertex_unnamed_21 += unity_ObjectToWorld__array[3];
				vertex_unnamed_37 = vertex_unnamed_21.yyyy * unity_MatrixVP__array[1];
				vertex_unnamed_37 = (unity_MatrixVP__array[0] * vertex_unnamed_21.xxxx) + vertex_unnamed_37;
				vertex_unnamed_37 = (unity_MatrixVP__array[2] * vertex_unnamed_21.zzzz) + vertex_unnamed_37;
				gl_Position = (unity_MatrixVP__array[3] * vertex_unnamed_21.wwww) + vertex_unnamed_37;
				vertex_output_0 = vertex_input_1;
				vertex_output_1 = vertex_input_2;
				vertex_output_2 = float4(vertex_input_0.xzw.x, vertex_output_2.y, vertex_input_0.xzw.y, vertex_input_0.xzw.z);
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
				vertex_input_0 = stage_input.vertex_input_0;
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
			static float4 fragment_output_0;
			static float4 fragment_input_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_0 : UNKNOWN0;
				float2 fragment_input_1 : TEXCOORD0; // vs_TEXCOORD0
				float4 fragment_input_2 : TEXCOORD1; // vs_TEXCOORD1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static bool4 fragment_unnamed_9;
			static float4 fragment_unnamed_40;
			static float fragment_unnamed_80;

			void frag_main()
			{
				bool2 fragment_unnamed_27 = bool4(fragment_input_2.xyxx.x >= _ClipRect.xyxx.x, fragment_input_2.xyxx.y >= _ClipRect.xyxx.y, fragment_input_2.xyxx.z >= _ClipRect.xyxx.z, fragment_input_2.xyxx.w >= _ClipRect.xyxx.w).xy;
				fragment_unnamed_9 = bool4(fragment_unnamed_27.x, fragment_unnamed_27.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
				bool2 fragment_unnamed_36 = bool4(_ClipRect.zzzw.x >= fragment_input_2.xxxy.x, _ClipRect.zzzw.y >= fragment_input_2.xxxy.y, _ClipRect.zzzw.z >= fragment_input_2.xxxy.z, _ClipRect.zzzw.w >= fragment_input_2.xxxy.w).zw;
				fragment_unnamed_9 = bool4(fragment_unnamed_9.x, fragment_unnamed_9.y, fragment_unnamed_36.x, fragment_unnamed_36.y);
				fragment_unnamed_40.x = float(fragment_unnamed_9.x);
				fragment_unnamed_40.y = float(fragment_unnamed_9.y);
				fragment_unnamed_40.z = float(fragment_unnamed_9.z);
				fragment_unnamed_40.w = float(fragment_unnamed_9.w);
				float2 fragment_unnamed_71 = fragment_unnamed_40.zw * fragment_unnamed_40.xy;
				fragment_unnamed_40 = float4(fragment_unnamed_71.x, fragment_unnamed_71.y, fragment_unnamed_40.z, fragment_unnamed_40.w);
				fragment_unnamed_40.x = fragment_unnamed_40.y * fragment_unnamed_40.x;
				fragment_unnamed_80 = _MainTex.Sample(sampler_MainTex, fragment_input_1).w;
				fragment_output_0.w = fragment_unnamed_40.x * fragment_unnamed_80;
				fragment_output_0 = float4(fragment_input_0.xyz.x, fragment_input_0.xyz.y, fragment_input_0.xyz.z, fragment_output_0.w);
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

			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;

			static float4 unity_ObjectToWorld__array[4];
			static float4 unity_MatrixVP__array[4];
			static float4 gl_Position;
			static float4 vertex_input_1;
			static float4 vertex_input_0;
			static float4 vertex_output_2;
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
				float4 vertex_output_2 : TEXCOORD1; // vs_TEXCOORD1
				float4 gl_Position : SV_Position;
			};

			static bool vertex_unnamed_8;
			static float4 vertex_unnamed_21;
			static float4 vertex_unnamed_37;

			void vert_main()
			{
				vertex_unnamed_8 = vertex_input_1.z < 0.75f;
				vertex_unnamed_21.x = vertex_unnamed_8 ? 2.0f : 1.0f;
				vertex_unnamed_21.x += vertex_input_0.y;
				vertex_unnamed_37 = vertex_unnamed_21.xxxx * unity_ObjectToWorld__array[1];
				vertex_output_2.y = vertex_unnamed_21.x;
				vertex_unnamed_21 = (unity_ObjectToWorld__array[0] * vertex_input_0.xxxx) + vertex_unnamed_37;
				vertex_unnamed_21 = (unity_ObjectToWorld__array[2] * vertex_input_0.zzzz) + vertex_unnamed_21;
				vertex_unnamed_21 += unity_ObjectToWorld__array[3];
				vertex_unnamed_37 = vertex_unnamed_21.yyyy * unity_MatrixVP__array[1];
				vertex_unnamed_37 = (unity_MatrixVP__array[0] * vertex_unnamed_21.xxxx) + vertex_unnamed_37;
				vertex_unnamed_37 = (unity_MatrixVP__array[2] * vertex_unnamed_21.zzzz) + vertex_unnamed_37;
				gl_Position = (unity_MatrixVP__array[3] * vertex_unnamed_21.wwww) + vertex_unnamed_37;
				vertex_output_0 = vertex_input_1;
				vertex_output_1 = vertex_input_2;
				vertex_output_2 = float4(vertex_input_0.xzw.x, vertex_output_2.y, vertex_input_0.xzw.y, vertex_input_0.xzw.z);
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
				vertex_input_0 = stage_input.vertex_input_0;
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
			static float4 fragment_output_0;
			static float4 fragment_input_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_0 : UNKNOWN0;
				float2 fragment_input_1 : TEXCOORD0; // vs_TEXCOORD0
				float4 fragment_input_2 : TEXCOORD1; // vs_TEXCOORD1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static bool4 fragment_unnamed_9;
			static float4 fragment_unnamed_40;
			static float fragment_unnamed_80;
			static float fragment_unnamed_96;

			void frag_main()
			{
				bool2 fragment_unnamed_27 = bool4(fragment_input_2.xyxx.x >= _ClipRect.xyxx.x, fragment_input_2.xyxx.y >= _ClipRect.xyxx.y, fragment_input_2.xyxx.z >= _ClipRect.xyxx.z, fragment_input_2.xyxx.w >= _ClipRect.xyxx.w).xy;
				fragment_unnamed_9 = bool4(fragment_unnamed_27.x, fragment_unnamed_27.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
				bool2 fragment_unnamed_36 = bool4(_ClipRect.zzzw.x >= fragment_input_2.xxxy.x, _ClipRect.zzzw.y >= fragment_input_2.xxxy.y, _ClipRect.zzzw.z >= fragment_input_2.xxxy.z, _ClipRect.zzzw.w >= fragment_input_2.xxxy.w).zw;
				fragment_unnamed_9 = bool4(fragment_unnamed_9.x, fragment_unnamed_9.y, fragment_unnamed_36.x, fragment_unnamed_36.y);
				fragment_unnamed_40.x = float(fragment_unnamed_9.x);
				fragment_unnamed_40.y = float(fragment_unnamed_9.y);
				fragment_unnamed_40.z = float(fragment_unnamed_9.z);
				fragment_unnamed_40.w = float(fragment_unnamed_9.w);
				float2 fragment_unnamed_71 = fragment_unnamed_40.zw * fragment_unnamed_40.xy;
				fragment_unnamed_40 = float4(fragment_unnamed_71.x, fragment_unnamed_71.y, fragment_unnamed_40.z, fragment_unnamed_40.w);
				fragment_unnamed_40.x = fragment_unnamed_40.y * fragment_unnamed_40.x;
				fragment_unnamed_80 = _MainTex.Sample(sampler_MainTex, fragment_input_1).w;
				fragment_unnamed_96 = (fragment_unnamed_80 * fragment_unnamed_40.x) + (-0.001000000047497451305389404296875f);
				fragment_unnamed_40.x *= fragment_unnamed_80;
				fragment_output_0.w = fragment_unnamed_40.x;
				fragment_unnamed_9.x = fragment_unnamed_96 < 0.0f;
				if ((int(fragment_unnamed_9.x) * (-1)) != 0)
				{
					discard;
				}
				fragment_output_0 = float4(fragment_input_0.xyz.x, fragment_input_0.xyz.y, fragment_input_0.xyz.z, fragment_output_0.w);
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
				float4 fragment_input_3 : TEXCOORD1; // TEXCOORD_1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				fragment_output_0.w = _MainTex.Sample(sampler_MainTex, float2(fragment_input_2.x, fragment_input_2.y)).w;
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
				float4 fragment_input_3 : TEXCOORD1; // TEXCOORD_1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static bool discard_state;

			void discard_cond(bool fragment_unnamed_60)
			{
				if (fragment_unnamed_60)
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
				precise float fragment_unnamed_38 = fragment_unnamed_37 + (-0.001000000047497451305389404296875f);
				fragment_output_0.w = fragment_unnamed_37;
				discard_cond(fragment_unnamed_38 < 0.0f);
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

			static float4 fragment_uniform_buffer_0[3];
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
				float4 fragment_input_3 : TEXCOORD1; // TEXCOORD_1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				precise float fragment_unnamed_70 = asfloat(((fragment_uniform_buffer_0[2u].z >= fragment_input_3.x) ? 4294967295u : 0u) & 1065353216u) * asfloat(((fragment_input_3.x >= fragment_uniform_buffer_0[2u].x) ? 4294967295u : 0u) & 1065353216u);
				precise float fragment_unnamed_71 = asfloat(((fragment_uniform_buffer_0[2u].w >= fragment_input_3.y) ? 4294967295u : 0u) & 1065353216u) * asfloat(((fragment_input_3.y >= fragment_uniform_buffer_0[2u].y) ? 4294967295u : 0u) & 1065353216u);
				precise float fragment_unnamed_72 = fragment_unnamed_71 * fragment_unnamed_70;
				precise float fragment_unnamed_83 = fragment_unnamed_72 * _MainTex.Sample(sampler_MainTex, float2(fragment_input_2.x, fragment_input_2.y)).w;
				fragment_output_0.w = fragment_unnamed_83;
				fragment_output_0.x = fragment_input_1.x;
				fragment_output_0.y = fragment_input_1.y;
				fragment_output_0.z = fragment_input_1.z;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[2] = float4(_ClipRect[0], _ClipRect[1], _ClipRect[2], _ClipRect[3]);

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

			static float4 fragment_uniform_buffer_0[3];
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
				float4 fragment_input_3 : TEXCOORD1; // TEXCOORD_1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static bool discard_state;

			void discard_cond(bool fragment_unnamed_104)
			{
				if (fragment_unnamed_104)
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
				precise float fragment_unnamed_70 = asfloat(((fragment_uniform_buffer_0[2u].z >= fragment_input_3.x) ? 4294967295u : 0u) & 1065353216u) * asfloat(((fragment_input_3.x >= fragment_uniform_buffer_0[2u].x) ? 4294967295u : 0u) & 1065353216u);
				precise float fragment_unnamed_71 = asfloat(((fragment_uniform_buffer_0[2u].w >= fragment_input_3.y) ? 4294967295u : 0u) & 1065353216u) * asfloat(((fragment_input_3.y >= fragment_uniform_buffer_0[2u].y) ? 4294967295u : 0u) & 1065353216u);
				precise float fragment_unnamed_72 = fragment_unnamed_71 * fragment_unnamed_70;
				float4 fragment_unnamed_80 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_2.x, fragment_input_2.y));
				float fragment_unnamed_82 = fragment_unnamed_80.w;
				precise float fragment_unnamed_86 = fragment_unnamed_72 * fragment_unnamed_82;
				fragment_output_0.w = fragment_unnamed_86;
				discard_cond(mad(fragment_unnamed_82, fragment_unnamed_72, -0.001000000047497451305389404296875f) < 0.0f);
				fragment_output_0.x = fragment_input_1.x;
				fragment_output_0.y = fragment_input_1.y;
				fragment_output_0.z = fragment_input_1.z;
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[2] = float4(_ClipRect[0], _ClipRect[1], _ClipRect[2], _ClipRect[3]);

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
		Pass
		{
			Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
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
			GpuProgramID 320925

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

			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[4];
			static float4 vertex_uniform_buffer_1[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float2 vertex_input_2;
			static float4 vertex_output_1;
			static float2 vertex_output_2;
			static float4 vertex_output_3;

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
				float4 vertex_output_3 : TEXCOORD1; // TEXCOORD_1
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				bool vertex_unnamed_35 = vertex_input_1.z < 0.75f;
				precise float vertex_unnamed_52 = asfloat(vertex_unnamed_35 ? 3221225472u : 2147483648u) + vertex_input_0.x;
				precise float vertex_unnamed_53 = asfloat((vertex_unnamed_35 ? 4294967295u : 0u) & 1073741824u) + vertex_input_0.y;
				precise float vertex_unnamed_61 = vertex_unnamed_53 * vertex_uniform_buffer_0[1u].x;
				precise float vertex_unnamed_62 = vertex_unnamed_53 * vertex_uniform_buffer_0[1u].y;
				precise float vertex_unnamed_63 = vertex_unnamed_53 * vertex_uniform_buffer_0[1u].z;
				precise float vertex_unnamed_64 = vertex_unnamed_53 * vertex_uniform_buffer_0[1u].w;
				vertex_output_3.x = vertex_unnamed_52;
				vertex_output_3.y = vertex_unnamed_53;
				precise float vertex_unnamed_98 = mad(vertex_uniform_buffer_0[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].x, vertex_unnamed_52, vertex_unnamed_61)) + vertex_uniform_buffer_0[3u].x;
				precise float vertex_unnamed_99 = mad(vertex_uniform_buffer_0[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].y, vertex_unnamed_52, vertex_unnamed_62)) + vertex_uniform_buffer_0[3u].y;
				precise float vertex_unnamed_100 = mad(vertex_uniform_buffer_0[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].z, vertex_unnamed_52, vertex_unnamed_63)) + vertex_uniform_buffer_0[3u].z;
				precise float vertex_unnamed_101 = mad(vertex_uniform_buffer_0[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].w, vertex_unnamed_52, vertex_unnamed_64)) + vertex_uniform_buffer_0[3u].w;
				precise float vertex_unnamed_109 = vertex_unnamed_99 * vertex_uniform_buffer_1[18u].x;
				precise float vertex_unnamed_110 = vertex_unnamed_99 * vertex_uniform_buffer_1[18u].y;
				precise float vertex_unnamed_111 = vertex_unnamed_99 * vertex_uniform_buffer_1[18u].z;
				precise float vertex_unnamed_112 = vertex_unnamed_99 * vertex_uniform_buffer_1[18u].w;
				gl_Position.x = mad(vertex_uniform_buffer_1[20u].x, vertex_unnamed_101, mad(vertex_uniform_buffer_1[19u].x, vertex_unnamed_100, mad(vertex_uniform_buffer_1[17u].x, vertex_unnamed_98, vertex_unnamed_109)));
				gl_Position.y = mad(vertex_uniform_buffer_1[20u].y, vertex_unnamed_101, mad(vertex_uniform_buffer_1[19u].y, vertex_unnamed_100, mad(vertex_uniform_buffer_1[17u].y, vertex_unnamed_98, vertex_unnamed_110)));
				gl_Position.z = mad(vertex_uniform_buffer_1[20u].z, vertex_unnamed_101, mad(vertex_uniform_buffer_1[19u].z, vertex_unnamed_100, mad(vertex_uniform_buffer_1[17u].z, vertex_unnamed_98, vertex_unnamed_111)));
				gl_Position.w = mad(vertex_uniform_buffer_1[20u].w, vertex_unnamed_101, mad(vertex_uniform_buffer_1[19u].w, vertex_unnamed_100, mad(vertex_uniform_buffer_1[17u].w, vertex_unnamed_98, vertex_unnamed_112)));
				vertex_output_1.x = vertex_input_1.x;
				vertex_output_1.y = vertex_input_1.y;
				vertex_output_1.z = vertex_input_1.z;
				vertex_output_1.w = vertex_input_1.w;
				vertex_output_2.x = vertex_input_2.x;
				vertex_output_2.y = vertex_input_2.y;
				vertex_output_3.z = vertex_input_0.z;
				vertex_output_3.w = vertex_input_0.w;
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
				vertex_input_2 = stage_input.vertex_input_2;
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

			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[4];
			static float4 vertex_uniform_buffer_1[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float2 vertex_input_2;
			static float4 vertex_output_1;
			static float2 vertex_output_2;
			static float4 vertex_output_3;

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
				float4 vertex_output_3 : TEXCOORD1; // TEXCOORD_1
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				bool vertex_unnamed_35 = vertex_input_1.z < 0.75f;
				precise float vertex_unnamed_52 = asfloat(vertex_unnamed_35 ? 3221225472u : 2147483648u) + vertex_input_0.x;
				precise float vertex_unnamed_53 = asfloat((vertex_unnamed_35 ? 4294967295u : 0u) & 1073741824u) + vertex_input_0.y;
				precise float vertex_unnamed_61 = vertex_unnamed_53 * vertex_uniform_buffer_0[1u].x;
				precise float vertex_unnamed_62 = vertex_unnamed_53 * vertex_uniform_buffer_0[1u].y;
				precise float vertex_unnamed_63 = vertex_unnamed_53 * vertex_uniform_buffer_0[1u].z;
				precise float vertex_unnamed_64 = vertex_unnamed_53 * vertex_uniform_buffer_0[1u].w;
				vertex_output_3.x = vertex_unnamed_52;
				vertex_output_3.y = vertex_unnamed_53;
				precise float vertex_unnamed_98 = mad(vertex_uniform_buffer_0[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].x, vertex_unnamed_52, vertex_unnamed_61)) + vertex_uniform_buffer_0[3u].x;
				precise float vertex_unnamed_99 = mad(vertex_uniform_buffer_0[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].y, vertex_unnamed_52, vertex_unnamed_62)) + vertex_uniform_buffer_0[3u].y;
				precise float vertex_unnamed_100 = mad(vertex_uniform_buffer_0[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].z, vertex_unnamed_52, vertex_unnamed_63)) + vertex_uniform_buffer_0[3u].z;
				precise float vertex_unnamed_101 = mad(vertex_uniform_buffer_0[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].w, vertex_unnamed_52, vertex_unnamed_64)) + vertex_uniform_buffer_0[3u].w;
				precise float vertex_unnamed_109 = vertex_unnamed_99 * vertex_uniform_buffer_1[18u].x;
				precise float vertex_unnamed_110 = vertex_unnamed_99 * vertex_uniform_buffer_1[18u].y;
				precise float vertex_unnamed_111 = vertex_unnamed_99 * vertex_uniform_buffer_1[18u].z;
				precise float vertex_unnamed_112 = vertex_unnamed_99 * vertex_uniform_buffer_1[18u].w;
				gl_Position.x = mad(vertex_uniform_buffer_1[20u].x, vertex_unnamed_101, mad(vertex_uniform_buffer_1[19u].x, vertex_unnamed_100, mad(vertex_uniform_buffer_1[17u].x, vertex_unnamed_98, vertex_unnamed_109)));
				gl_Position.y = mad(vertex_uniform_buffer_1[20u].y, vertex_unnamed_101, mad(vertex_uniform_buffer_1[19u].y, vertex_unnamed_100, mad(vertex_uniform_buffer_1[17u].y, vertex_unnamed_98, vertex_unnamed_110)));
				gl_Position.z = mad(vertex_uniform_buffer_1[20u].z, vertex_unnamed_101, mad(vertex_uniform_buffer_1[19u].z, vertex_unnamed_100, mad(vertex_uniform_buffer_1[17u].z, vertex_unnamed_98, vertex_unnamed_111)));
				gl_Position.w = mad(vertex_uniform_buffer_1[20u].w, vertex_unnamed_101, mad(vertex_uniform_buffer_1[19u].w, vertex_unnamed_100, mad(vertex_uniform_buffer_1[17u].w, vertex_unnamed_98, vertex_unnamed_112)));
				vertex_output_1.x = vertex_input_1.x;
				vertex_output_1.y = vertex_input_1.y;
				vertex_output_1.z = vertex_input_1.z;
				vertex_output_1.w = vertex_input_1.w;
				vertex_output_2.x = vertex_input_2.x;
				vertex_output_2.y = vertex_input_2.y;
				vertex_output_3.z = vertex_input_0.z;
				vertex_output_3.w = vertex_input_0.w;
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
				vertex_input_2 = stage_input.vertex_input_2;
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

			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[4];
			static float4 vertex_uniform_buffer_1[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float2 vertex_input_2;
			static float4 vertex_output_1;
			static float2 vertex_output_2;
			static float4 vertex_output_3;

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
				float4 vertex_output_3 : TEXCOORD1; // TEXCOORD_1
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				bool vertex_unnamed_35 = vertex_input_1.z < 0.75f;
				precise float vertex_unnamed_52 = asfloat(vertex_unnamed_35 ? 3221225472u : 2147483648u) + vertex_input_0.x;
				precise float vertex_unnamed_53 = asfloat((vertex_unnamed_35 ? 4294967295u : 0u) & 1073741824u) + vertex_input_0.y;
				precise float vertex_unnamed_61 = vertex_unnamed_53 * vertex_uniform_buffer_0[1u].x;
				precise float vertex_unnamed_62 = vertex_unnamed_53 * vertex_uniform_buffer_0[1u].y;
				precise float vertex_unnamed_63 = vertex_unnamed_53 * vertex_uniform_buffer_0[1u].z;
				precise float vertex_unnamed_64 = vertex_unnamed_53 * vertex_uniform_buffer_0[1u].w;
				vertex_output_3.x = vertex_unnamed_52;
				vertex_output_3.y = vertex_unnamed_53;
				precise float vertex_unnamed_98 = mad(vertex_uniform_buffer_0[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].x, vertex_unnamed_52, vertex_unnamed_61)) + vertex_uniform_buffer_0[3u].x;
				precise float vertex_unnamed_99 = mad(vertex_uniform_buffer_0[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].y, vertex_unnamed_52, vertex_unnamed_62)) + vertex_uniform_buffer_0[3u].y;
				precise float vertex_unnamed_100 = mad(vertex_uniform_buffer_0[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].z, vertex_unnamed_52, vertex_unnamed_63)) + vertex_uniform_buffer_0[3u].z;
				precise float vertex_unnamed_101 = mad(vertex_uniform_buffer_0[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].w, vertex_unnamed_52, vertex_unnamed_64)) + vertex_uniform_buffer_0[3u].w;
				precise float vertex_unnamed_109 = vertex_unnamed_99 * vertex_uniform_buffer_1[18u].x;
				precise float vertex_unnamed_110 = vertex_unnamed_99 * vertex_uniform_buffer_1[18u].y;
				precise float vertex_unnamed_111 = vertex_unnamed_99 * vertex_uniform_buffer_1[18u].z;
				precise float vertex_unnamed_112 = vertex_unnamed_99 * vertex_uniform_buffer_1[18u].w;
				gl_Position.x = mad(vertex_uniform_buffer_1[20u].x, vertex_unnamed_101, mad(vertex_uniform_buffer_1[19u].x, vertex_unnamed_100, mad(vertex_uniform_buffer_1[17u].x, vertex_unnamed_98, vertex_unnamed_109)));
				gl_Position.y = mad(vertex_uniform_buffer_1[20u].y, vertex_unnamed_101, mad(vertex_uniform_buffer_1[19u].y, vertex_unnamed_100, mad(vertex_uniform_buffer_1[17u].y, vertex_unnamed_98, vertex_unnamed_110)));
				gl_Position.z = mad(vertex_uniform_buffer_1[20u].z, vertex_unnamed_101, mad(vertex_uniform_buffer_1[19u].z, vertex_unnamed_100, mad(vertex_uniform_buffer_1[17u].z, vertex_unnamed_98, vertex_unnamed_111)));
				gl_Position.w = mad(vertex_uniform_buffer_1[20u].w, vertex_unnamed_101, mad(vertex_uniform_buffer_1[19u].w, vertex_unnamed_100, mad(vertex_uniform_buffer_1[17u].w, vertex_unnamed_98, vertex_unnamed_112)));
				vertex_output_1.x = vertex_input_1.x;
				vertex_output_1.y = vertex_input_1.y;
				vertex_output_1.z = vertex_input_1.z;
				vertex_output_1.w = vertex_input_1.w;
				vertex_output_2.x = vertex_input_2.x;
				vertex_output_2.y = vertex_input_2.y;
				vertex_output_3.z = vertex_input_0.z;
				vertex_output_3.w = vertex_input_0.w;
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
				vertex_input_2 = stage_input.vertex_input_2;
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

			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[4];
			static float4 vertex_uniform_buffer_1[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float2 vertex_input_2;
			static float4 vertex_output_1;
			static float2 vertex_output_2;
			static float4 vertex_output_3;

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
				float4 vertex_output_3 : TEXCOORD1; // TEXCOORD_1
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				bool vertex_unnamed_35 = vertex_input_1.z < 0.75f;
				precise float vertex_unnamed_52 = asfloat(vertex_unnamed_35 ? 3221225472u : 2147483648u) + vertex_input_0.x;
				precise float vertex_unnamed_53 = asfloat((vertex_unnamed_35 ? 4294967295u : 0u) & 1073741824u) + vertex_input_0.y;
				precise float vertex_unnamed_61 = vertex_unnamed_53 * vertex_uniform_buffer_0[1u].x;
				precise float vertex_unnamed_62 = vertex_unnamed_53 * vertex_uniform_buffer_0[1u].y;
				precise float vertex_unnamed_63 = vertex_unnamed_53 * vertex_uniform_buffer_0[1u].z;
				precise float vertex_unnamed_64 = vertex_unnamed_53 * vertex_uniform_buffer_0[1u].w;
				vertex_output_3.x = vertex_unnamed_52;
				vertex_output_3.y = vertex_unnamed_53;
				precise float vertex_unnamed_98 = mad(vertex_uniform_buffer_0[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].x, vertex_unnamed_52, vertex_unnamed_61)) + vertex_uniform_buffer_0[3u].x;
				precise float vertex_unnamed_99 = mad(vertex_uniform_buffer_0[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].y, vertex_unnamed_52, vertex_unnamed_62)) + vertex_uniform_buffer_0[3u].y;
				precise float vertex_unnamed_100 = mad(vertex_uniform_buffer_0[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].z, vertex_unnamed_52, vertex_unnamed_63)) + vertex_uniform_buffer_0[3u].z;
				precise float vertex_unnamed_101 = mad(vertex_uniform_buffer_0[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].w, vertex_unnamed_52, vertex_unnamed_64)) + vertex_uniform_buffer_0[3u].w;
				precise float vertex_unnamed_109 = vertex_unnamed_99 * vertex_uniform_buffer_1[18u].x;
				precise float vertex_unnamed_110 = vertex_unnamed_99 * vertex_uniform_buffer_1[18u].y;
				precise float vertex_unnamed_111 = vertex_unnamed_99 * vertex_uniform_buffer_1[18u].z;
				precise float vertex_unnamed_112 = vertex_unnamed_99 * vertex_uniform_buffer_1[18u].w;
				gl_Position.x = mad(vertex_uniform_buffer_1[20u].x, vertex_unnamed_101, mad(vertex_uniform_buffer_1[19u].x, vertex_unnamed_100, mad(vertex_uniform_buffer_1[17u].x, vertex_unnamed_98, vertex_unnamed_109)));
				gl_Position.y = mad(vertex_uniform_buffer_1[20u].y, vertex_unnamed_101, mad(vertex_uniform_buffer_1[19u].y, vertex_unnamed_100, mad(vertex_uniform_buffer_1[17u].y, vertex_unnamed_98, vertex_unnamed_110)));
				gl_Position.z = mad(vertex_uniform_buffer_1[20u].z, vertex_unnamed_101, mad(vertex_uniform_buffer_1[19u].z, vertex_unnamed_100, mad(vertex_uniform_buffer_1[17u].z, vertex_unnamed_98, vertex_unnamed_111)));
				gl_Position.w = mad(vertex_uniform_buffer_1[20u].w, vertex_unnamed_101, mad(vertex_uniform_buffer_1[19u].w, vertex_unnamed_100, mad(vertex_uniform_buffer_1[17u].w, vertex_unnamed_98, vertex_unnamed_112)));
				vertex_output_1.x = vertex_input_1.x;
				vertex_output_1.y = vertex_input_1.y;
				vertex_output_1.z = vertex_input_1.z;
				vertex_output_1.w = vertex_input_1.w;
				vertex_output_2.x = vertex_input_2.x;
				vertex_output_2.y = vertex_input_2.y;
				vertex_output_3.z = vertex_input_0.z;
				vertex_output_3.w = vertex_input_0.w;
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
				vertex_input_2 = stage_input.vertex_input_2;
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

			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;

			static float4 unity_ObjectToWorld__array[4];
			static float4 unity_MatrixVP__array[4];
			static float4 gl_Position;
			static float4 vertex_input_1;
			static float4 vertex_input_0;
			static float4 vertex_output_2;
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
				float4 vertex_output_2 : TEXCOORD1; // vs_TEXCOORD1
				float4 gl_Position : SV_Position;
			};

			static bool vertex_unnamed_8;
			static float4 vertex_unnamed_21;
			static float4 vertex_unnamed_35;

			void vert_main()
			{
				vertex_unnamed_8 = vertex_input_1.z < 0.75f;
				vertex_unnamed_21.y = vertex_unnamed_8 ? 2.0f : 0.0f;
				vertex_unnamed_21.x = vertex_unnamed_8 ? (-2.0f) : (-0.0f);
				float2 vertex_unnamed_42 = vertex_unnamed_21.xy + vertex_input_0.xy;
				vertex_unnamed_35 = float4(vertex_unnamed_42.x, vertex_unnamed_42.y, vertex_unnamed_35.z, vertex_unnamed_35.w);
				vertex_unnamed_21 = vertex_unnamed_35.yyyy * unity_ObjectToWorld__array[1];
				vertex_output_2 = float4(vertex_unnamed_35.xy.x, vertex_unnamed_35.xy.y, vertex_output_2.z, vertex_output_2.w);
				vertex_unnamed_21 = (unity_ObjectToWorld__array[0] * vertex_unnamed_35.xxxx) + vertex_unnamed_21;
				vertex_unnamed_21 = (unity_ObjectToWorld__array[2] * vertex_input_0.zzzz) + vertex_unnamed_21;
				vertex_unnamed_21 += unity_ObjectToWorld__array[3];
				vertex_unnamed_35 = vertex_unnamed_21.yyyy * unity_MatrixVP__array[1];
				vertex_unnamed_35 = (unity_MatrixVP__array[0] * vertex_unnamed_21.xxxx) + vertex_unnamed_35;
				vertex_unnamed_35 = (unity_MatrixVP__array[2] * vertex_unnamed_21.zzzz) + vertex_unnamed_35;
				gl_Position = (unity_MatrixVP__array[3] * vertex_unnamed_21.wwww) + vertex_unnamed_35;
				vertex_output_0 = vertex_input_1;
				vertex_output_1 = vertex_input_2;
				vertex_output_2 = float4(vertex_output_2.x, vertex_output_2.y, vertex_input_0.zw.x, vertex_input_0.zw.y);
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
				vertex_input_0 = stage_input.vertex_input_0;
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
				fragment_output_0.w = fragment_unnamed_8;
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

			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;

			static float4 unity_ObjectToWorld__array[4];
			static float4 unity_MatrixVP__array[4];
			static float4 gl_Position;
			static float4 vertex_input_1;
			static float4 vertex_input_0;
			static float4 vertex_output_2;
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
				float4 vertex_output_2 : TEXCOORD1; // vs_TEXCOORD1
				float4 gl_Position : SV_Position;
			};

			static bool vertex_unnamed_8;
			static float4 vertex_unnamed_21;
			static float4 vertex_unnamed_35;

			void vert_main()
			{
				vertex_unnamed_8 = vertex_input_1.z < 0.75f;
				vertex_unnamed_21.y = vertex_unnamed_8 ? 2.0f : 0.0f;
				vertex_unnamed_21.x = vertex_unnamed_8 ? (-2.0f) : (-0.0f);
				float2 vertex_unnamed_42 = vertex_unnamed_21.xy + vertex_input_0.xy;
				vertex_unnamed_35 = float4(vertex_unnamed_42.x, vertex_unnamed_42.y, vertex_unnamed_35.z, vertex_unnamed_35.w);
				vertex_unnamed_21 = vertex_unnamed_35.yyyy * unity_ObjectToWorld__array[1];
				vertex_output_2 = float4(vertex_unnamed_35.xy.x, vertex_unnamed_35.xy.y, vertex_output_2.z, vertex_output_2.w);
				vertex_unnamed_21 = (unity_ObjectToWorld__array[0] * vertex_unnamed_35.xxxx) + vertex_unnamed_21;
				vertex_unnamed_21 = (unity_ObjectToWorld__array[2] * vertex_input_0.zzzz) + vertex_unnamed_21;
				vertex_unnamed_21 += unity_ObjectToWorld__array[3];
				vertex_unnamed_35 = vertex_unnamed_21.yyyy * unity_MatrixVP__array[1];
				vertex_unnamed_35 = (unity_MatrixVP__array[0] * vertex_unnamed_21.xxxx) + vertex_unnamed_35;
				vertex_unnamed_35 = (unity_MatrixVP__array[2] * vertex_unnamed_21.zzzz) + vertex_unnamed_35;
				gl_Position = (unity_MatrixVP__array[3] * vertex_unnamed_21.wwww) + vertex_unnamed_35;
				vertex_output_0 = vertex_input_1;
				vertex_output_1 = vertex_input_2;
				vertex_output_2 = float4(vertex_output_2.x, vertex_output_2.y, vertex_input_0.zw.x, vertex_input_0.zw.y);
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
				vertex_input_0 = stage_input.vertex_input_0;
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
			static float fragment_unnamed_28;
			static bool fragment_unnamed_39;

			void frag_main()
			{
				fragment_unnamed_8 = _MainTex.Sample(sampler_MainTex, fragment_input_1).w;
				fragment_unnamed_28 = fragment_unnamed_8 + (-0.001000000047497451305389404296875f);
				fragment_output_0.w = fragment_unnamed_8;
				fragment_unnamed_39 = fragment_unnamed_28 < 0.0f;
				if ((int(fragment_unnamed_39) * (-1)) != 0)
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

			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;

			static float4 unity_ObjectToWorld__array[4];
			static float4 unity_MatrixVP__array[4];
			static float4 gl_Position;
			static float4 vertex_input_1;
			static float4 vertex_input_0;
			static float4 vertex_output_2;
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
				float4 vertex_output_2 : TEXCOORD1; // vs_TEXCOORD1
				float4 gl_Position : SV_Position;
			};

			static bool vertex_unnamed_8;
			static float4 vertex_unnamed_21;
			static float4 vertex_unnamed_35;

			void vert_main()
			{
				vertex_unnamed_8 = vertex_input_1.z < 0.75f;
				vertex_unnamed_21.y = vertex_unnamed_8 ? 2.0f : 0.0f;
				vertex_unnamed_21.x = vertex_unnamed_8 ? (-2.0f) : (-0.0f);
				float2 vertex_unnamed_42 = vertex_unnamed_21.xy + vertex_input_0.xy;
				vertex_unnamed_35 = float4(vertex_unnamed_42.x, vertex_unnamed_42.y, vertex_unnamed_35.z, vertex_unnamed_35.w);
				vertex_unnamed_21 = vertex_unnamed_35.yyyy * unity_ObjectToWorld__array[1];
				vertex_output_2 = float4(vertex_unnamed_35.xy.x, vertex_unnamed_35.xy.y, vertex_output_2.z, vertex_output_2.w);
				vertex_unnamed_21 = (unity_ObjectToWorld__array[0] * vertex_unnamed_35.xxxx) + vertex_unnamed_21;
				vertex_unnamed_21 = (unity_ObjectToWorld__array[2] * vertex_input_0.zzzz) + vertex_unnamed_21;
				vertex_unnamed_21 += unity_ObjectToWorld__array[3];
				vertex_unnamed_35 = vertex_unnamed_21.yyyy * unity_MatrixVP__array[1];
				vertex_unnamed_35 = (unity_MatrixVP__array[0] * vertex_unnamed_21.xxxx) + vertex_unnamed_35;
				vertex_unnamed_35 = (unity_MatrixVP__array[2] * vertex_unnamed_21.zzzz) + vertex_unnamed_35;
				gl_Position = (unity_MatrixVP__array[3] * vertex_unnamed_21.wwww) + vertex_unnamed_35;
				vertex_output_0 = vertex_input_1;
				vertex_output_1 = vertex_input_2;
				vertex_output_2 = float4(vertex_output_2.x, vertex_output_2.y, vertex_input_0.zw.x, vertex_input_0.zw.y);
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
				vertex_input_0 = stage_input.vertex_input_0;
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
			static float4 fragment_output_0;
			static float4 fragment_input_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_0 : UNKNOWN0;
				float2 fragment_input_1 : TEXCOORD0; // vs_TEXCOORD0
				float4 fragment_input_2 : TEXCOORD1; // vs_TEXCOORD1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static bool4 fragment_unnamed_9;
			static float4 fragment_unnamed_40;
			static float fragment_unnamed_80;

			void frag_main()
			{
				bool2 fragment_unnamed_27 = bool4(fragment_input_2.xyxx.x >= _ClipRect.xyxx.x, fragment_input_2.xyxx.y >= _ClipRect.xyxx.y, fragment_input_2.xyxx.z >= _ClipRect.xyxx.z, fragment_input_2.xyxx.w >= _ClipRect.xyxx.w).xy;
				fragment_unnamed_9 = bool4(fragment_unnamed_27.x, fragment_unnamed_27.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
				bool2 fragment_unnamed_36 = bool4(_ClipRect.zzzw.x >= fragment_input_2.xxxy.x, _ClipRect.zzzw.y >= fragment_input_2.xxxy.y, _ClipRect.zzzw.z >= fragment_input_2.xxxy.z, _ClipRect.zzzw.w >= fragment_input_2.xxxy.w).zw;
				fragment_unnamed_9 = bool4(fragment_unnamed_9.x, fragment_unnamed_9.y, fragment_unnamed_36.x, fragment_unnamed_36.y);
				fragment_unnamed_40.x = float(fragment_unnamed_9.x);
				fragment_unnamed_40.y = float(fragment_unnamed_9.y);
				fragment_unnamed_40.z = float(fragment_unnamed_9.z);
				fragment_unnamed_40.w = float(fragment_unnamed_9.w);
				float2 fragment_unnamed_71 = fragment_unnamed_40.zw * fragment_unnamed_40.xy;
				fragment_unnamed_40 = float4(fragment_unnamed_71.x, fragment_unnamed_71.y, fragment_unnamed_40.z, fragment_unnamed_40.w);
				fragment_unnamed_40.x = fragment_unnamed_40.y * fragment_unnamed_40.x;
				fragment_unnamed_80 = _MainTex.Sample(sampler_MainTex, fragment_input_1).w;
				fragment_output_0.w = fragment_unnamed_40.x * fragment_unnamed_80;
				fragment_output_0 = float4(fragment_input_0.xyz.x, fragment_input_0.xyz.y, fragment_input_0.xyz.z, fragment_output_0.w);
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

			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;

			static float4 unity_ObjectToWorld__array[4];
			static float4 unity_MatrixVP__array[4];
			static float4 gl_Position;
			static float4 vertex_input_1;
			static float4 vertex_input_0;
			static float4 vertex_output_2;
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
				float4 vertex_output_2 : TEXCOORD1; // vs_TEXCOORD1
				float4 gl_Position : SV_Position;
			};

			static bool vertex_unnamed_8;
			static float4 vertex_unnamed_21;
			static float4 vertex_unnamed_35;

			void vert_main()
			{
				vertex_unnamed_8 = vertex_input_1.z < 0.75f;
				vertex_unnamed_21.y = vertex_unnamed_8 ? 2.0f : 0.0f;
				vertex_unnamed_21.x = vertex_unnamed_8 ? (-2.0f) : (-0.0f);
				float2 vertex_unnamed_42 = vertex_unnamed_21.xy + vertex_input_0.xy;
				vertex_unnamed_35 = float4(vertex_unnamed_42.x, vertex_unnamed_42.y, vertex_unnamed_35.z, vertex_unnamed_35.w);
				vertex_unnamed_21 = vertex_unnamed_35.yyyy * unity_ObjectToWorld__array[1];
				vertex_output_2 = float4(vertex_unnamed_35.xy.x, vertex_unnamed_35.xy.y, vertex_output_2.z, vertex_output_2.w);
				vertex_unnamed_21 = (unity_ObjectToWorld__array[0] * vertex_unnamed_35.xxxx) + vertex_unnamed_21;
				vertex_unnamed_21 = (unity_ObjectToWorld__array[2] * vertex_input_0.zzzz) + vertex_unnamed_21;
				vertex_unnamed_21 += unity_ObjectToWorld__array[3];
				vertex_unnamed_35 = vertex_unnamed_21.yyyy * unity_MatrixVP__array[1];
				vertex_unnamed_35 = (unity_MatrixVP__array[0] * vertex_unnamed_21.xxxx) + vertex_unnamed_35;
				vertex_unnamed_35 = (unity_MatrixVP__array[2] * vertex_unnamed_21.zzzz) + vertex_unnamed_35;
				gl_Position = (unity_MatrixVP__array[3] * vertex_unnamed_21.wwww) + vertex_unnamed_35;
				vertex_output_0 = vertex_input_1;
				vertex_output_1 = vertex_input_2;
				vertex_output_2 = float4(vertex_output_2.x, vertex_output_2.y, vertex_input_0.zw.x, vertex_input_0.zw.y);
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
				vertex_input_0 = stage_input.vertex_input_0;
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
			static float4 fragment_output_0;
			static float4 fragment_input_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_0 : UNKNOWN0;
				float2 fragment_input_1 : TEXCOORD0; // vs_TEXCOORD0
				float4 fragment_input_2 : TEXCOORD1; // vs_TEXCOORD1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static bool4 fragment_unnamed_9;
			static float4 fragment_unnamed_40;
			static float fragment_unnamed_80;
			static float fragment_unnamed_96;

			void frag_main()
			{
				bool2 fragment_unnamed_27 = bool4(fragment_input_2.xyxx.x >= _ClipRect.xyxx.x, fragment_input_2.xyxx.y >= _ClipRect.xyxx.y, fragment_input_2.xyxx.z >= _ClipRect.xyxx.z, fragment_input_2.xyxx.w >= _ClipRect.xyxx.w).xy;
				fragment_unnamed_9 = bool4(fragment_unnamed_27.x, fragment_unnamed_27.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
				bool2 fragment_unnamed_36 = bool4(_ClipRect.zzzw.x >= fragment_input_2.xxxy.x, _ClipRect.zzzw.y >= fragment_input_2.xxxy.y, _ClipRect.zzzw.z >= fragment_input_2.xxxy.z, _ClipRect.zzzw.w >= fragment_input_2.xxxy.w).zw;
				fragment_unnamed_9 = bool4(fragment_unnamed_9.x, fragment_unnamed_9.y, fragment_unnamed_36.x, fragment_unnamed_36.y);
				fragment_unnamed_40.x = float(fragment_unnamed_9.x);
				fragment_unnamed_40.y = float(fragment_unnamed_9.y);
				fragment_unnamed_40.z = float(fragment_unnamed_9.z);
				fragment_unnamed_40.w = float(fragment_unnamed_9.w);
				float2 fragment_unnamed_71 = fragment_unnamed_40.zw * fragment_unnamed_40.xy;
				fragment_unnamed_40 = float4(fragment_unnamed_71.x, fragment_unnamed_71.y, fragment_unnamed_40.z, fragment_unnamed_40.w);
				fragment_unnamed_40.x = fragment_unnamed_40.y * fragment_unnamed_40.x;
				fragment_unnamed_80 = _MainTex.Sample(sampler_MainTex, fragment_input_1).w;
				fragment_unnamed_96 = (fragment_unnamed_80 * fragment_unnamed_40.x) + (-0.001000000047497451305389404296875f);
				fragment_unnamed_40.x *= fragment_unnamed_80;
				fragment_output_0.w = fragment_unnamed_40.x;
				fragment_unnamed_9.x = fragment_unnamed_96 < 0.0f;
				if ((int(fragment_unnamed_9.x) * (-1)) != 0)
				{
					discard;
				}
				fragment_output_0 = float4(fragment_input_0.xyz.x, fragment_input_0.xyz.y, fragment_input_0.xyz.z, fragment_output_0.w);
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
				float4 fragment_input_3 : TEXCOORD1; // TEXCOORD_1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				fragment_output_0.w = _MainTex.Sample(sampler_MainTex, float2(fragment_input_2.x, fragment_input_2.y)).w;
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
				float4 fragment_input_3 : TEXCOORD1; // TEXCOORD_1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static bool discard_state;

			void discard_cond(bool fragment_unnamed_60)
			{
				if (fragment_unnamed_60)
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
				precise float fragment_unnamed_38 = fragment_unnamed_37 + (-0.001000000047497451305389404296875f);
				fragment_output_0.w = fragment_unnamed_37;
				discard_cond(fragment_unnamed_38 < 0.0f);
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

			static float4 fragment_uniform_buffer_0[3];
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
				float4 fragment_input_3 : TEXCOORD1; // TEXCOORD_1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				precise float fragment_unnamed_70 = asfloat(((fragment_uniform_buffer_0[2u].z >= fragment_input_3.x) ? 4294967295u : 0u) & 1065353216u) * asfloat(((fragment_input_3.x >= fragment_uniform_buffer_0[2u].x) ? 4294967295u : 0u) & 1065353216u);
				precise float fragment_unnamed_71 = asfloat(((fragment_uniform_buffer_0[2u].w >= fragment_input_3.y) ? 4294967295u : 0u) & 1065353216u) * asfloat(((fragment_input_3.y >= fragment_uniform_buffer_0[2u].y) ? 4294967295u : 0u) & 1065353216u);
				precise float fragment_unnamed_72 = fragment_unnamed_71 * fragment_unnamed_70;
				precise float fragment_unnamed_83 = fragment_unnamed_72 * _MainTex.Sample(sampler_MainTex, float2(fragment_input_2.x, fragment_input_2.y)).w;
				fragment_output_0.w = fragment_unnamed_83;
				fragment_output_0.x = fragment_input_1.x;
				fragment_output_0.y = fragment_input_1.y;
				fragment_output_0.z = fragment_input_1.z;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[2] = float4(_ClipRect[0], _ClipRect[1], _ClipRect[2], _ClipRect[3]);

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

			static float4 fragment_uniform_buffer_0[3];
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
				float4 fragment_input_3 : TEXCOORD1; // TEXCOORD_1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static bool discard_state;

			void discard_cond(bool fragment_unnamed_104)
			{
				if (fragment_unnamed_104)
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
				precise float fragment_unnamed_70 = asfloat(((fragment_uniform_buffer_0[2u].z >= fragment_input_3.x) ? 4294967295u : 0u) & 1065353216u) * asfloat(((fragment_input_3.x >= fragment_uniform_buffer_0[2u].x) ? 4294967295u : 0u) & 1065353216u);
				precise float fragment_unnamed_71 = asfloat(((fragment_uniform_buffer_0[2u].w >= fragment_input_3.y) ? 4294967295u : 0u) & 1065353216u) * asfloat(((fragment_input_3.y >= fragment_uniform_buffer_0[2u].y) ? 4294967295u : 0u) & 1065353216u);
				precise float fragment_unnamed_72 = fragment_unnamed_71 * fragment_unnamed_70;
				float4 fragment_unnamed_80 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_2.x, fragment_input_2.y));
				float fragment_unnamed_82 = fragment_unnamed_80.w;
				precise float fragment_unnamed_86 = fragment_unnamed_72 * fragment_unnamed_82;
				fragment_output_0.w = fragment_unnamed_86;
				discard_cond(mad(fragment_unnamed_82, fragment_unnamed_72, -0.001000000047497451305389404296875f) < 0.0f);
				fragment_output_0.x = fragment_input_1.x;
				fragment_output_0.y = fragment_input_1.y;
				fragment_output_0.z = fragment_input_1.z;
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[2] = float4(_ClipRect[0], _ClipRect[1], _ClipRect[2], _ClipRect[3]);

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
		Pass
		{
			Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
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
			GpuProgramID 342945

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
			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[3];
			static float4 vertex_uniform_buffer_1[4];
			static float4 vertex_uniform_buffer_2[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float2 vertex_input_2;
			static float4 vertex_output_1;
			static float2 vertex_output_2;
			static float4 vertex_output_3;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION; // POSITION
				float4 vertex_input_1 : COLOR; // COLOR
				float2 vertex_input_2 : TEXCOORD; // TEXCOORD
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : COLOR; // COLOR
				float2 vertex_output_2 : TEXCOORD; // TEXCOORD
				float4 vertex_output_3 : TEXCOORD1; // TEXCOORD_1
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_47 = vertex_input_0.y * vertex_uniform_buffer_1[1u].x;
				precise float vertex_unnamed_48 = vertex_input_0.y * vertex_uniform_buffer_1[1u].y;
				precise float vertex_unnamed_49 = vertex_input_0.y * vertex_uniform_buffer_1[1u].z;
				precise float vertex_unnamed_50 = vertex_input_0.y * vertex_uniform_buffer_1[1u].w;
				precise float vertex_unnamed_83 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_0.x, vertex_unnamed_47)) + vertex_uniform_buffer_1[3u].x;
				precise float vertex_unnamed_84 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_0.x, vertex_unnamed_48)) + vertex_uniform_buffer_1[3u].y;
				precise float vertex_unnamed_85 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_0.x, vertex_unnamed_49)) + vertex_uniform_buffer_1[3u].z;
				precise float vertex_unnamed_86 = mad(vertex_uniform_buffer_1[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].w, vertex_input_0.x, vertex_unnamed_50)) + vertex_uniform_buffer_1[3u].w;
				precise float vertex_unnamed_94 = vertex_unnamed_84 * vertex_uniform_buffer_2[18u].x;
				precise float vertex_unnamed_95 = vertex_unnamed_84 * vertex_uniform_buffer_2[18u].y;
				precise float vertex_unnamed_96 = vertex_unnamed_84 * vertex_uniform_buffer_2[18u].z;
				precise float vertex_unnamed_97 = vertex_unnamed_84 * vertex_uniform_buffer_2[18u].w;
				gl_Position.x = mad(vertex_uniform_buffer_2[20u].x, vertex_unnamed_86, mad(vertex_uniform_buffer_2[19u].x, vertex_unnamed_85, mad(vertex_uniform_buffer_2[17u].x, vertex_unnamed_83, vertex_unnamed_94)));
				gl_Position.y = mad(vertex_uniform_buffer_2[20u].y, vertex_unnamed_86, mad(vertex_uniform_buffer_2[19u].y, vertex_unnamed_85, mad(vertex_uniform_buffer_2[17u].y, vertex_unnamed_83, vertex_unnamed_95)));
				gl_Position.z = mad(vertex_uniform_buffer_2[20u].z, vertex_unnamed_86, mad(vertex_uniform_buffer_2[19u].z, vertex_unnamed_85, mad(vertex_uniform_buffer_2[17u].z, vertex_unnamed_83, vertex_unnamed_96)));
				gl_Position.w = mad(vertex_uniform_buffer_2[20u].w, vertex_unnamed_86, mad(vertex_uniform_buffer_2[19u].w, vertex_unnamed_85, mad(vertex_uniform_buffer_2[17u].w, vertex_unnamed_83, vertex_unnamed_97)));
				vertex_output_1.x = vertex_uniform_buffer_0[2u].x;
				vertex_output_1.y = vertex_uniform_buffer_0[2u].y;
				vertex_output_1.z = vertex_uniform_buffer_0[2u].z;
				vertex_output_1.w = vertex_uniform_buffer_0[2u].w;
				vertex_output_2.x = vertex_input_2.x;
				vertex_output_2.y = vertex_input_2.y;
				vertex_output_3.x = vertex_input_0.x;
				vertex_output_3.y = vertex_input_0.y;
				vertex_output_3.z = vertex_input_0.z;
				vertex_output_3.w = vertex_input_0.w;
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
				vertex_input_2 = stage_input.vertex_input_2;
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
			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[3];
			static float4 vertex_uniform_buffer_1[4];
			static float4 vertex_uniform_buffer_2[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float2 vertex_input_2;
			static float4 vertex_output_1;
			static float2 vertex_output_2;
			static float4 vertex_output_3;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION; // POSITION
				float4 vertex_input_1 : COLOR; // COLOR
				float2 vertex_input_2 : TEXCOORD; // TEXCOORD
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : COLOR; // COLOR
				float2 vertex_output_2 : TEXCOORD; // TEXCOORD
				float4 vertex_output_3 : TEXCOORD1; // TEXCOORD_1
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_47 = vertex_input_0.y * vertex_uniform_buffer_1[1u].x;
				precise float vertex_unnamed_48 = vertex_input_0.y * vertex_uniform_buffer_1[1u].y;
				precise float vertex_unnamed_49 = vertex_input_0.y * vertex_uniform_buffer_1[1u].z;
				precise float vertex_unnamed_50 = vertex_input_0.y * vertex_uniform_buffer_1[1u].w;
				precise float vertex_unnamed_83 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_0.x, vertex_unnamed_47)) + vertex_uniform_buffer_1[3u].x;
				precise float vertex_unnamed_84 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_0.x, vertex_unnamed_48)) + vertex_uniform_buffer_1[3u].y;
				precise float vertex_unnamed_85 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_0.x, vertex_unnamed_49)) + vertex_uniform_buffer_1[3u].z;
				precise float vertex_unnamed_86 = mad(vertex_uniform_buffer_1[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].w, vertex_input_0.x, vertex_unnamed_50)) + vertex_uniform_buffer_1[3u].w;
				precise float vertex_unnamed_94 = vertex_unnamed_84 * vertex_uniform_buffer_2[18u].x;
				precise float vertex_unnamed_95 = vertex_unnamed_84 * vertex_uniform_buffer_2[18u].y;
				precise float vertex_unnamed_96 = vertex_unnamed_84 * vertex_uniform_buffer_2[18u].z;
				precise float vertex_unnamed_97 = vertex_unnamed_84 * vertex_uniform_buffer_2[18u].w;
				gl_Position.x = mad(vertex_uniform_buffer_2[20u].x, vertex_unnamed_86, mad(vertex_uniform_buffer_2[19u].x, vertex_unnamed_85, mad(vertex_uniform_buffer_2[17u].x, vertex_unnamed_83, vertex_unnamed_94)));
				gl_Position.y = mad(vertex_uniform_buffer_2[20u].y, vertex_unnamed_86, mad(vertex_uniform_buffer_2[19u].y, vertex_unnamed_85, mad(vertex_uniform_buffer_2[17u].y, vertex_unnamed_83, vertex_unnamed_95)));
				gl_Position.z = mad(vertex_uniform_buffer_2[20u].z, vertex_unnamed_86, mad(vertex_uniform_buffer_2[19u].z, vertex_unnamed_85, mad(vertex_uniform_buffer_2[17u].z, vertex_unnamed_83, vertex_unnamed_96)));
				gl_Position.w = mad(vertex_uniform_buffer_2[20u].w, vertex_unnamed_86, mad(vertex_uniform_buffer_2[19u].w, vertex_unnamed_85, mad(vertex_uniform_buffer_2[17u].w, vertex_unnamed_83, vertex_unnamed_97)));
				vertex_output_1.x = vertex_uniform_buffer_0[2u].x;
				vertex_output_1.y = vertex_uniform_buffer_0[2u].y;
				vertex_output_1.z = vertex_uniform_buffer_0[2u].z;
				vertex_output_1.w = vertex_uniform_buffer_0[2u].w;
				vertex_output_2.x = vertex_input_2.x;
				vertex_output_2.y = vertex_input_2.y;
				vertex_output_3.x = vertex_input_0.x;
				vertex_output_3.y = vertex_input_0.y;
				vertex_output_3.z = vertex_input_0.z;
				vertex_output_3.w = vertex_input_0.w;
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
				vertex_input_2 = stage_input.vertex_input_2;
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
			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[3];
			static float4 vertex_uniform_buffer_1[4];
			static float4 vertex_uniform_buffer_2[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float2 vertex_input_2;
			static float4 vertex_output_1;
			static float2 vertex_output_2;
			static float4 vertex_output_3;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION; // POSITION
				float4 vertex_input_1 : COLOR; // COLOR
				float2 vertex_input_2 : TEXCOORD; // TEXCOORD
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : COLOR; // COLOR
				float2 vertex_output_2 : TEXCOORD; // TEXCOORD
				float4 vertex_output_3 : TEXCOORD1; // TEXCOORD_1
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_47 = vertex_input_0.y * vertex_uniform_buffer_1[1u].x;
				precise float vertex_unnamed_48 = vertex_input_0.y * vertex_uniform_buffer_1[1u].y;
				precise float vertex_unnamed_49 = vertex_input_0.y * vertex_uniform_buffer_1[1u].z;
				precise float vertex_unnamed_50 = vertex_input_0.y * vertex_uniform_buffer_1[1u].w;
				precise float vertex_unnamed_83 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_0.x, vertex_unnamed_47)) + vertex_uniform_buffer_1[3u].x;
				precise float vertex_unnamed_84 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_0.x, vertex_unnamed_48)) + vertex_uniform_buffer_1[3u].y;
				precise float vertex_unnamed_85 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_0.x, vertex_unnamed_49)) + vertex_uniform_buffer_1[3u].z;
				precise float vertex_unnamed_86 = mad(vertex_uniform_buffer_1[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].w, vertex_input_0.x, vertex_unnamed_50)) + vertex_uniform_buffer_1[3u].w;
				precise float vertex_unnamed_94 = vertex_unnamed_84 * vertex_uniform_buffer_2[18u].x;
				precise float vertex_unnamed_95 = vertex_unnamed_84 * vertex_uniform_buffer_2[18u].y;
				precise float vertex_unnamed_96 = vertex_unnamed_84 * vertex_uniform_buffer_2[18u].z;
				precise float vertex_unnamed_97 = vertex_unnamed_84 * vertex_uniform_buffer_2[18u].w;
				gl_Position.x = mad(vertex_uniform_buffer_2[20u].x, vertex_unnamed_86, mad(vertex_uniform_buffer_2[19u].x, vertex_unnamed_85, mad(vertex_uniform_buffer_2[17u].x, vertex_unnamed_83, vertex_unnamed_94)));
				gl_Position.y = mad(vertex_uniform_buffer_2[20u].y, vertex_unnamed_86, mad(vertex_uniform_buffer_2[19u].y, vertex_unnamed_85, mad(vertex_uniform_buffer_2[17u].y, vertex_unnamed_83, vertex_unnamed_95)));
				gl_Position.z = mad(vertex_uniform_buffer_2[20u].z, vertex_unnamed_86, mad(vertex_uniform_buffer_2[19u].z, vertex_unnamed_85, mad(vertex_uniform_buffer_2[17u].z, vertex_unnamed_83, vertex_unnamed_96)));
				gl_Position.w = mad(vertex_uniform_buffer_2[20u].w, vertex_unnamed_86, mad(vertex_uniform_buffer_2[19u].w, vertex_unnamed_85, mad(vertex_uniform_buffer_2[17u].w, vertex_unnamed_83, vertex_unnamed_97)));
				vertex_output_1.x = vertex_uniform_buffer_0[2u].x;
				vertex_output_1.y = vertex_uniform_buffer_0[2u].y;
				vertex_output_1.z = vertex_uniform_buffer_0[2u].z;
				vertex_output_1.w = vertex_uniform_buffer_0[2u].w;
				vertex_output_2.x = vertex_input_2.x;
				vertex_output_2.y = vertex_input_2.y;
				vertex_output_3.x = vertex_input_0.x;
				vertex_output_3.y = vertex_input_0.y;
				vertex_output_3.z = vertex_input_0.z;
				vertex_output_3.w = vertex_input_0.w;
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
				vertex_input_2 = stage_input.vertex_input_2;
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
			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[3];
			static float4 vertex_uniform_buffer_1[4];
			static float4 vertex_uniform_buffer_2[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float2 vertex_input_2;
			static float4 vertex_output_1;
			static float2 vertex_output_2;
			static float4 vertex_output_3;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION; // POSITION
				float4 vertex_input_1 : COLOR; // COLOR
				float2 vertex_input_2 : TEXCOORD; // TEXCOORD
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : COLOR; // COLOR
				float2 vertex_output_2 : TEXCOORD; // TEXCOORD
				float4 vertex_output_3 : TEXCOORD1; // TEXCOORD_1
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_47 = vertex_input_0.y * vertex_uniform_buffer_1[1u].x;
				precise float vertex_unnamed_48 = vertex_input_0.y * vertex_uniform_buffer_1[1u].y;
				precise float vertex_unnamed_49 = vertex_input_0.y * vertex_uniform_buffer_1[1u].z;
				precise float vertex_unnamed_50 = vertex_input_0.y * vertex_uniform_buffer_1[1u].w;
				precise float vertex_unnamed_83 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_0.x, vertex_unnamed_47)) + vertex_uniform_buffer_1[3u].x;
				precise float vertex_unnamed_84 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_0.x, vertex_unnamed_48)) + vertex_uniform_buffer_1[3u].y;
				precise float vertex_unnamed_85 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_0.x, vertex_unnamed_49)) + vertex_uniform_buffer_1[3u].z;
				precise float vertex_unnamed_86 = mad(vertex_uniform_buffer_1[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].w, vertex_input_0.x, vertex_unnamed_50)) + vertex_uniform_buffer_1[3u].w;
				precise float vertex_unnamed_94 = vertex_unnamed_84 * vertex_uniform_buffer_2[18u].x;
				precise float vertex_unnamed_95 = vertex_unnamed_84 * vertex_uniform_buffer_2[18u].y;
				precise float vertex_unnamed_96 = vertex_unnamed_84 * vertex_uniform_buffer_2[18u].z;
				precise float vertex_unnamed_97 = vertex_unnamed_84 * vertex_uniform_buffer_2[18u].w;
				gl_Position.x = mad(vertex_uniform_buffer_2[20u].x, vertex_unnamed_86, mad(vertex_uniform_buffer_2[19u].x, vertex_unnamed_85, mad(vertex_uniform_buffer_2[17u].x, vertex_unnamed_83, vertex_unnamed_94)));
				gl_Position.y = mad(vertex_uniform_buffer_2[20u].y, vertex_unnamed_86, mad(vertex_uniform_buffer_2[19u].y, vertex_unnamed_85, mad(vertex_uniform_buffer_2[17u].y, vertex_unnamed_83, vertex_unnamed_95)));
				gl_Position.z = mad(vertex_uniform_buffer_2[20u].z, vertex_unnamed_86, mad(vertex_uniform_buffer_2[19u].z, vertex_unnamed_85, mad(vertex_uniform_buffer_2[17u].z, vertex_unnamed_83, vertex_unnamed_96)));
				gl_Position.w = mad(vertex_uniform_buffer_2[20u].w, vertex_unnamed_86, mad(vertex_uniform_buffer_2[19u].w, vertex_unnamed_85, mad(vertex_uniform_buffer_2[17u].w, vertex_unnamed_83, vertex_unnamed_97)));
				vertex_output_1.x = vertex_uniform_buffer_0[2u].x;
				vertex_output_1.y = vertex_uniform_buffer_0[2u].y;
				vertex_output_1.z = vertex_uniform_buffer_0[2u].z;
				vertex_output_1.w = vertex_uniform_buffer_0[2u].w;
				vertex_output_2.x = vertex_input_2.x;
				vertex_output_2.y = vertex_input_2.y;
				vertex_output_3.x = vertex_input_0.x;
				vertex_output_3.y = vertex_input_0.y;
				vertex_output_3.z = vertex_input_0.z;
				vertex_output_3.w = vertex_input_0.w;
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
				vertex_input_2 = stage_input.vertex_input_2;
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

			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;
			float4 _Color;

			static float4 unity_ObjectToWorld__array[4];
			static float4 unity_MatrixVP__array[4];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_output_0;
			static float2 vertex_output_1;
			static float2 vertex_input_1;
			static float4 vertex_output_2;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION;
				float2 vertex_input_1 : TEXCOORD0;
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_0 : UNKNOWN0;
				float2 vertex_output_1 : TEXCOORD0; // vs_TEXCOORD0
				float4 vertex_output_2 : TEXCOORD1; // vs_TEXCOORD1
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
				vertex_output_0 = _Color;
				vertex_output_1 = vertex_input_1;
				vertex_output_2 = vertex_input_0;
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
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				return stage_output;
			}

			float4 _TextureSampleAdd;

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

			static float4 fragment_unnamed_9;

			void frag_main()
			{
				fragment_unnamed_9 = _MainTex.Sample(sampler_MainTex, fragment_input_1);
				fragment_unnamed_9 += _TextureSampleAdd;
				fragment_output_0 = fragment_unnamed_9 * fragment_input_0;
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

			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;
			float4 _Color;

			static float4 unity_ObjectToWorld__array[4];
			static float4 unity_MatrixVP__array[4];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_output_0;
			static float2 vertex_output_1;
			static float2 vertex_input_1;
			static float4 vertex_output_2;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION;
				float2 vertex_input_1 : TEXCOORD0;
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_0 : UNKNOWN0;
				float2 vertex_output_1 : TEXCOORD0; // vs_TEXCOORD0
				float4 vertex_output_2 : TEXCOORD1; // vs_TEXCOORD1
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
				vertex_output_0 = _Color;
				vertex_output_1 = vertex_input_1;
				vertex_output_2 = vertex_input_0;
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
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				return stage_output;
			}

			float4 _TextureSampleAdd;

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
			static float fragment_unnamed_36;
			static bool fragment_unnamed_57;

			void frag_main()
			{
				fragment_unnamed_9 = _MainTex.Sample(sampler_MainTex, fragment_input_1);
				fragment_unnamed_9 += _TextureSampleAdd;
				fragment_unnamed_36 = (fragment_unnamed_9.w * fragment_input_0.w) + (-0.001000000047497451305389404296875f);
				fragment_unnamed_9 *= fragment_input_0;
				fragment_output_0 = fragment_unnamed_9;
				fragment_unnamed_57 = fragment_unnamed_36 < 0.0f;
				if ((int(fragment_unnamed_57) * (-1)) != 0)
				{
					discard;
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

			#endif // UNITY_UI_ALPHACLIP
			#endif // !UNITY_UI_CLIP_RECT


			#ifdef UNITY_UI_CLIP_RECT
			#ifndef UNITY_UI_ALPHACLIP
			#define ANY_SHADER_VARIANT_ACTIVE

			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;
			float4 _Color;

			static float4 unity_ObjectToWorld__array[4];
			static float4 unity_MatrixVP__array[4];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_output_0;
			static float2 vertex_output_1;
			static float2 vertex_input_1;
			static float4 vertex_output_2;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION;
				float2 vertex_input_1 : TEXCOORD0;
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_0 : UNKNOWN0;
				float2 vertex_output_1 : TEXCOORD0; // vs_TEXCOORD0
				float4 vertex_output_2 : TEXCOORD1; // vs_TEXCOORD1
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
				vertex_output_0 = _Color;
				vertex_output_1 = vertex_input_1;
				vertex_output_2 = vertex_input_0;
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
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				return stage_output;
			}

			float4 _TextureSampleAdd;
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
				float4 fragment_input_2 : TEXCOORD1; // vs_TEXCOORD1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static bool4 fragment_unnamed_9;
			static float4 fragment_unnamed_40;
			static float4 fragment_unnamed_80;

			void frag_main()
			{
				bool2 fragment_unnamed_27 = bool4(fragment_input_2.xyxx.x >= _ClipRect.xyxx.x, fragment_input_2.xyxx.y >= _ClipRect.xyxx.y, fragment_input_2.xyxx.z >= _ClipRect.xyxx.z, fragment_input_2.xyxx.w >= _ClipRect.xyxx.w).xy;
				fragment_unnamed_9 = bool4(fragment_unnamed_27.x, fragment_unnamed_27.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
				bool2 fragment_unnamed_36 = bool4(_ClipRect.zzzw.x >= fragment_input_2.xxxy.x, _ClipRect.zzzw.y >= fragment_input_2.xxxy.y, _ClipRect.zzzw.z >= fragment_input_2.xxxy.z, _ClipRect.zzzw.w >= fragment_input_2.xxxy.w).zw;
				fragment_unnamed_9 = bool4(fragment_unnamed_9.x, fragment_unnamed_9.y, fragment_unnamed_36.x, fragment_unnamed_36.y);
				fragment_unnamed_40.x = float(fragment_unnamed_9.x);
				fragment_unnamed_40.y = float(fragment_unnamed_9.y);
				fragment_unnamed_40.z = float(fragment_unnamed_9.z);
				fragment_unnamed_40.w = float(fragment_unnamed_9.w);
				float2 fragment_unnamed_71 = fragment_unnamed_40.zw * fragment_unnamed_40.xy;
				fragment_unnamed_40 = float4(fragment_unnamed_71.x, fragment_unnamed_71.y, fragment_unnamed_40.z, fragment_unnamed_40.w);
				fragment_unnamed_40.x = fragment_unnamed_40.y * fragment_unnamed_40.x;
				fragment_unnamed_80 = _MainTex.Sample(sampler_MainTex, fragment_input_1);
				fragment_unnamed_80 += _TextureSampleAdd;
				fragment_unnamed_80 *= fragment_input_0;
				fragment_output_0.w = fragment_unnamed_40.x * fragment_unnamed_80.w;
				fragment_output_0 = float4(fragment_unnamed_80.xyz.x, fragment_unnamed_80.xyz.y, fragment_unnamed_80.xyz.z, fragment_output_0.w);
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

			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;
			float4 _Color;

			static float4 unity_ObjectToWorld__array[4];
			static float4 unity_MatrixVP__array[4];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_output_0;
			static float2 vertex_output_1;
			static float2 vertex_input_1;
			static float4 vertex_output_2;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION;
				float2 vertex_input_1 : TEXCOORD0;
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_0 : UNKNOWN0;
				float2 vertex_output_1 : TEXCOORD0; // vs_TEXCOORD0
				float4 vertex_output_2 : TEXCOORD1; // vs_TEXCOORD1
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
				vertex_output_0 = _Color;
				vertex_output_1 = vertex_input_1;
				vertex_output_2 = vertex_input_0;
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
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				return stage_output;
			}

			float4 _TextureSampleAdd;
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
				float4 fragment_input_2 : TEXCOORD1; // vs_TEXCOORD1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static bool4 fragment_unnamed_9;
			static float4 fragment_unnamed_40;
			static float4 fragment_unnamed_80;
			static float fragment_unnamed_104;

			void frag_main()
			{
				bool2 fragment_unnamed_27 = bool4(fragment_input_2.xyxx.x >= _ClipRect.xyxx.x, fragment_input_2.xyxx.y >= _ClipRect.xyxx.y, fragment_input_2.xyxx.z >= _ClipRect.xyxx.z, fragment_input_2.xyxx.w >= _ClipRect.xyxx.w).xy;
				fragment_unnamed_9 = bool4(fragment_unnamed_27.x, fragment_unnamed_27.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
				bool2 fragment_unnamed_36 = bool4(_ClipRect.zzzw.x >= fragment_input_2.xxxy.x, _ClipRect.zzzw.y >= fragment_input_2.xxxy.y, _ClipRect.zzzw.z >= fragment_input_2.xxxy.z, _ClipRect.zzzw.w >= fragment_input_2.xxxy.w).zw;
				fragment_unnamed_9 = bool4(fragment_unnamed_9.x, fragment_unnamed_9.y, fragment_unnamed_36.x, fragment_unnamed_36.y);
				fragment_unnamed_40.x = float(fragment_unnamed_9.x);
				fragment_unnamed_40.y = float(fragment_unnamed_9.y);
				fragment_unnamed_40.z = float(fragment_unnamed_9.z);
				fragment_unnamed_40.w = float(fragment_unnamed_9.w);
				float2 fragment_unnamed_71 = fragment_unnamed_40.zw * fragment_unnamed_40.xy;
				fragment_unnamed_40 = float4(fragment_unnamed_71.x, fragment_unnamed_71.y, fragment_unnamed_40.z, fragment_unnamed_40.w);
				fragment_unnamed_40.x = fragment_unnamed_40.y * fragment_unnamed_40.x;
				fragment_unnamed_80 = _MainTex.Sample(sampler_MainTex, fragment_input_1);
				fragment_unnamed_80 += _TextureSampleAdd;
				fragment_unnamed_80 *= fragment_input_0;
				fragment_unnamed_104 = (fragment_unnamed_80.w * fragment_unnamed_40.x) + (-0.001000000047497451305389404296875f);
				fragment_unnamed_40.x *= fragment_unnamed_80.w;
				fragment_output_0 = float4(fragment_unnamed_80.xyz.x, fragment_unnamed_80.xyz.y, fragment_unnamed_80.xyz.z, fragment_output_0.w);
				fragment_output_0.w = fragment_unnamed_40.x;
				fragment_unnamed_9.x = fragment_unnamed_104 < 0.0f;
				if ((int(fragment_unnamed_9.x) * (-1)) != 0)
				{
					discard;
				}
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

			float4 _TextureSampleAdd;

			static float4 fragment_uniform_buffer_0[4];
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
				float4 fragment_input_3 : TEXCOORD1; // TEXCOORD_1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				float4 fragment_unnamed_40 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_2.x, fragment_input_2.y));
				precise float fragment_unnamed_54 = fragment_unnamed_40.x + fragment_uniform_buffer_0[3u].x;
				precise float fragment_unnamed_55 = fragment_unnamed_40.y + fragment_uniform_buffer_0[3u].y;
				precise float fragment_unnamed_56 = fragment_unnamed_40.z + fragment_uniform_buffer_0[3u].z;
				precise float fragment_unnamed_57 = fragment_unnamed_40.w + fragment_uniform_buffer_0[3u].w;
				precise float fragment_unnamed_67 = fragment_unnamed_54 * fragment_input_1.x;
				precise float fragment_unnamed_68 = fragment_unnamed_55 * fragment_input_1.y;
				precise float fragment_unnamed_69 = fragment_unnamed_56 * fragment_input_1.z;
				precise float fragment_unnamed_70 = fragment_unnamed_57 * fragment_input_1.w;
				fragment_output_0.x = fragment_unnamed_67;
				fragment_output_0.y = fragment_unnamed_68;
				fragment_output_0.z = fragment_unnamed_69;
				fragment_output_0.w = fragment_unnamed_70;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[3] = float4(_TextureSampleAdd[0], _TextureSampleAdd[1], _TextureSampleAdd[2], _TextureSampleAdd[3]);

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

			float4 _TextureSampleAdd;

			static float4 fragment_uniform_buffer_0[4];
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
				float4 fragment_input_3 : TEXCOORD1; // TEXCOORD_1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static bool discard_state;

			void discard_cond(bool fragment_unnamed_88)
			{
				if (fragment_unnamed_88)
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
				precise float fragment_unnamed_54 = fragment_unnamed_40.x + fragment_uniform_buffer_0[3u].x;
				precise float fragment_unnamed_55 = fragment_unnamed_40.y + fragment_uniform_buffer_0[3u].y;
				precise float fragment_unnamed_56 = fragment_unnamed_40.z + fragment_uniform_buffer_0[3u].z;
				precise float fragment_unnamed_57 = fragment_unnamed_40.w + fragment_uniform_buffer_0[3u].w;
				precise float fragment_unnamed_72 = fragment_unnamed_54 * fragment_input_1.x;
				precise float fragment_unnamed_73 = fragment_unnamed_55 * fragment_input_1.y;
				precise float fragment_unnamed_74 = fragment_unnamed_56 * fragment_input_1.z;
				precise float fragment_unnamed_75 = fragment_unnamed_57 * fragment_input_1.w;
				fragment_output_0.x = fragment_unnamed_72;
				fragment_output_0.y = fragment_unnamed_73;
				fragment_output_0.z = fragment_unnamed_74;
				fragment_output_0.w = fragment_unnamed_75;
				discard_cond(mad(fragment_unnamed_57, fragment_input_1.w, -0.001000000047497451305389404296875f) < 0.0f);
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[3] = float4(_TextureSampleAdd[0], _TextureSampleAdd[1], _TextureSampleAdd[2], _TextureSampleAdd[3]);

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

			float4 _TextureSampleAdd;
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
				float4 fragment_input_3 : TEXCOORD1; // TEXCOORD_1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				precise float fragment_unnamed_70 = asfloat(((fragment_uniform_buffer_0[4u].z >= fragment_input_3.x) ? 4294967295u : 0u) & 1065353216u) * asfloat(((fragment_input_3.x >= fragment_uniform_buffer_0[4u].x) ? 4294967295u : 0u) & 1065353216u);
				precise float fragment_unnamed_71 = asfloat(((fragment_uniform_buffer_0[4u].w >= fragment_input_3.y) ? 4294967295u : 0u) & 1065353216u) * asfloat(((fragment_input_3.y >= fragment_uniform_buffer_0[4u].y) ? 4294967295u : 0u) & 1065353216u);
				precise float fragment_unnamed_72 = fragment_unnamed_71 * fragment_unnamed_70;
				float4 fragment_unnamed_80 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_2.x, fragment_input_2.y));
				precise float fragment_unnamed_93 = fragment_unnamed_80.x + fragment_uniform_buffer_0[3u].x;
				precise float fragment_unnamed_94 = fragment_unnamed_80.y + fragment_uniform_buffer_0[3u].y;
				precise float fragment_unnamed_95 = fragment_unnamed_80.z + fragment_uniform_buffer_0[3u].z;
				precise float fragment_unnamed_96 = fragment_unnamed_80.w + fragment_uniform_buffer_0[3u].w;
				precise float fragment_unnamed_106 = fragment_unnamed_93 * fragment_input_1.x;
				precise float fragment_unnamed_107 = fragment_unnamed_94 * fragment_input_1.y;
				precise float fragment_unnamed_108 = fragment_unnamed_95 * fragment_input_1.z;
				precise float fragment_unnamed_109 = fragment_unnamed_96 * fragment_input_1.w;
				precise float fragment_unnamed_110 = fragment_unnamed_72 * fragment_unnamed_109;
				fragment_output_0.w = fragment_unnamed_110;
				fragment_output_0.x = fragment_unnamed_106;
				fragment_output_0.y = fragment_unnamed_107;
				fragment_output_0.z = fragment_unnamed_108;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[3] = float4(_TextureSampleAdd[0], _TextureSampleAdd[1], _TextureSampleAdd[2], _TextureSampleAdd[3]);

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

			float4 _TextureSampleAdd;
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
				float4 fragment_input_3 : TEXCOORD1; // TEXCOORD_1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static bool discard_state;

			void discard_cond(bool fragment_unnamed_125)
			{
				if (fragment_unnamed_125)
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
				precise float fragment_unnamed_70 = asfloat(((fragment_uniform_buffer_0[4u].z >= fragment_input_3.x) ? 4294967295u : 0u) & 1065353216u) * asfloat(((fragment_input_3.x >= fragment_uniform_buffer_0[4u].x) ? 4294967295u : 0u) & 1065353216u);
				precise float fragment_unnamed_71 = asfloat(((fragment_uniform_buffer_0[4u].w >= fragment_input_3.y) ? 4294967295u : 0u) & 1065353216u) * asfloat(((fragment_input_3.y >= fragment_uniform_buffer_0[4u].y) ? 4294967295u : 0u) & 1065353216u);
				precise float fragment_unnamed_72 = fragment_unnamed_71 * fragment_unnamed_70;
				float4 fragment_unnamed_80 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_2.x, fragment_input_2.y));
				precise float fragment_unnamed_93 = fragment_unnamed_80.x + fragment_uniform_buffer_0[3u].x;
				precise float fragment_unnamed_94 = fragment_unnamed_80.y + fragment_uniform_buffer_0[3u].y;
				precise float fragment_unnamed_95 = fragment_unnamed_80.z + fragment_uniform_buffer_0[3u].z;
				precise float fragment_unnamed_96 = fragment_unnamed_80.w + fragment_uniform_buffer_0[3u].w;
				precise float fragment_unnamed_106 = fragment_unnamed_93 * fragment_input_1.x;
				precise float fragment_unnamed_107 = fragment_unnamed_94 * fragment_input_1.y;
				precise float fragment_unnamed_108 = fragment_unnamed_95 * fragment_input_1.z;
				precise float fragment_unnamed_109 = fragment_unnamed_96 * fragment_input_1.w;
				precise float fragment_unnamed_113 = fragment_unnamed_72 * fragment_unnamed_109;
				fragment_output_0.x = fragment_unnamed_106;
				fragment_output_0.y = fragment_unnamed_107;
				fragment_output_0.z = fragment_unnamed_108;
				fragment_output_0.w = fragment_unnamed_113;
				discard_cond(mad(fragment_unnamed_109, fragment_unnamed_72, -0.001000000047497451305389404296875f) < 0.0f);
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[3] = float4(_TextureSampleAdd[0], _TextureSampleAdd[1], _TextureSampleAdd[2], _TextureSampleAdd[3]);

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
}
