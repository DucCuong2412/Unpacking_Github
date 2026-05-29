Shader "UI/Invalid"
{
	Properties
	{
		[PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
		_Color ("Tint", Color) = (1,1,1,1)
		_Dark ("Dark", Color) = (1,1,1,1)
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
			Name "Default"
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
			GpuProgramID 22808

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
				precise float vertex_unnamed_150 = vertex_input_1.x * vertex_uniform_buffer_0[2u].x;
				precise float vertex_unnamed_151 = vertex_input_1.y * vertex_uniform_buffer_0[2u].y;
				precise float vertex_unnamed_152 = vertex_input_1.z * vertex_uniform_buffer_0[2u].z;
				precise float vertex_unnamed_153 = vertex_input_1.w * vertex_uniform_buffer_0[2u].w;
				vertex_output_1.x = vertex_unnamed_150;
				vertex_output_1.y = vertex_unnamed_151;
				vertex_output_1.z = vertex_unnamed_152;
				vertex_output_1.w = vertex_unnamed_153;
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
				precise float vertex_unnamed_150 = vertex_input_1.x * vertex_uniform_buffer_0[2u].x;
				precise float vertex_unnamed_151 = vertex_input_1.y * vertex_uniform_buffer_0[2u].y;
				precise float vertex_unnamed_152 = vertex_input_1.z * vertex_uniform_buffer_0[2u].z;
				precise float vertex_unnamed_153 = vertex_input_1.w * vertex_uniform_buffer_0[2u].w;
				vertex_output_1.x = vertex_unnamed_150;
				vertex_output_1.y = vertex_unnamed_151;
				vertex_output_1.z = vertex_unnamed_152;
				vertex_output_1.w = vertex_unnamed_153;
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
				precise float vertex_unnamed_150 = vertex_input_1.x * vertex_uniform_buffer_0[2u].x;
				precise float vertex_unnamed_151 = vertex_input_1.y * vertex_uniform_buffer_0[2u].y;
				precise float vertex_unnamed_152 = vertex_input_1.z * vertex_uniform_buffer_0[2u].z;
				precise float vertex_unnamed_153 = vertex_input_1.w * vertex_uniform_buffer_0[2u].w;
				vertex_output_1.x = vertex_unnamed_150;
				vertex_output_1.y = vertex_unnamed_151;
				vertex_output_1.z = vertex_unnamed_152;
				vertex_output_1.w = vertex_unnamed_153;
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
				precise float vertex_unnamed_150 = vertex_input_1.x * vertex_uniform_buffer_0[2u].x;
				precise float vertex_unnamed_151 = vertex_input_1.y * vertex_uniform_buffer_0[2u].y;
				precise float vertex_unnamed_152 = vertex_input_1.z * vertex_uniform_buffer_0[2u].z;
				precise float vertex_unnamed_153 = vertex_input_1.w * vertex_uniform_buffer_0[2u].w;
				vertex_output_1.x = vertex_unnamed_150;
				vertex_output_1.y = vertex_unnamed_151;
				vertex_output_1.z = vertex_unnamed_152;
				vertex_output_1.w = vertex_unnamed_153;
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
			static float4 vertex_input_1;
			static float2 vertex_output_1;
			static float2 vertex_input_2;
			static float4 vertex_output_2;

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
				vertex_output_0 = vertex_input_1 * _Color;
				vertex_output_1 = vertex_input_2;
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
				vertex_input_2 = stage_input.vertex_input_2;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_0 = vertex_output_0;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				return stage_output;
			}

			float4 _Dark;
			float4 _TextureSampleAdd;
			float4 _OutlineColor;

			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

			static float4 fragment_input_0;
			static float2 fragment_input_1;
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

			static float3 fragment_unnamed_9;
			static float3 fragment_unnamed_47;
			static bool2 fragment_unnamed_73;
			static float3 fragment_unnamed_96;

			void frag_main()
			{
				fragment_unnamed_9.x = (-_OutlineColor.w) + 1.0f;
				fragment_unnamed_9 = fragment_unnamed_9.xxx * fragment_input_0.xyz;
				fragment_unnamed_9 += fragment_unnamed_9;
				fragment_unnamed_9 = (_OutlineColor.xyz * _OutlineColor.www) + fragment_unnamed_9;
				fragment_unnamed_47 = _MainTex.Sample(sampler_MainTex, fragment_input_1).xzw;
				fragment_unnamed_47 += _TextureSampleAdd.xzw;
				fragment_unnamed_73 = bool4(0.0f.xxxx.x >= fragment_unnamed_47.yxyy.x, 0.0f.xxxx.y >= fragment_unnamed_47.yxyy.y, 0.0f.xxxx.z >= fragment_unnamed_47.yxyy.z, 0.0f.xxxx.w >= fragment_unnamed_47.yxyy.w).xy;
				float3 fragment_unnamed_86;
				if (fragment_unnamed_73.y)
				{
					fragment_unnamed_86 = _Dark.xyz;
				}
				else
				{
					fragment_unnamed_86 = fragment_unnamed_9;
				}
				fragment_unnamed_9 = fragment_unnamed_86;
				fragment_unnamed_96 = fragment_input_0.xyz + fragment_input_0.xyz;
				float3 fragment_unnamed_104;
				if (fragment_unnamed_73.x)
				{
					fragment_unnamed_104 = fragment_unnamed_9;
				}
				else
				{
					fragment_unnamed_104 = fragment_unnamed_96;
				}
				fragment_unnamed_9 = fragment_unnamed_104;
				float3 fragment_unnamed_116 = fragment_unnamed_9 * fragment_unnamed_47.zzz;
				fragment_output_0 = float4(fragment_unnamed_116.x, fragment_unnamed_116.y, fragment_unnamed_116.z, fragment_output_0.w);
				fragment_output_0.w = fragment_unnamed_47.z;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_0 = stage_input.fragment_input_0;
				fragment_input_1 = stage_input.fragment_input_1;
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
			static float4 vertex_input_1;
			static float2 vertex_output_1;
			static float2 vertex_input_2;
			static float4 vertex_output_2;

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
				vertex_output_0 = vertex_input_1 * _Color;
				vertex_output_1 = vertex_input_2;
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
				vertex_input_2 = stage_input.vertex_input_2;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_0 = vertex_output_0;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				return stage_output;
			}

			float4 _Dark;
			float4 _TextureSampleAdd;
			float4 _OutlineColor;

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
			static float fragment_unnamed_44;
			static bool fragment_unnamed_53;
			static float3 fragment_unnamed_75;
			static bool2 fragment_unnamed_97;
			static float3 fragment_unnamed_117;

			void frag_main()
			{
				float3 fragment_unnamed_26 = _MainTex.Sample(sampler_MainTex, fragment_input_1).xzw;
				fragment_unnamed_9 = float4(fragment_unnamed_26.x, fragment_unnamed_26.y, fragment_unnamed_26.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_40 = fragment_unnamed_9.xyz + _TextureSampleAdd.xzw;
				fragment_unnamed_9 = float4(fragment_unnamed_40.x, fragment_unnamed_40.y, fragment_unnamed_40.z, fragment_unnamed_9.w);
				fragment_unnamed_44 = fragment_unnamed_9.z + (-0.001000000047497451305389404296875f);
				fragment_unnamed_53 = fragment_unnamed_44 < 0.0f;
				if ((int(fragment_unnamed_53) * (-1)) != 0)
				{
					discard;
				}
				fragment_unnamed_44 = (-_OutlineColor.w) + 1.0f;
				fragment_unnamed_75 = fragment_unnamed_44.xxx * fragment_input_0.xyz;
				fragment_unnamed_75 += fragment_unnamed_75;
				fragment_unnamed_75 = (_OutlineColor.xyz * _OutlineColor.www) + fragment_unnamed_75;
				fragment_unnamed_97 = bool4(0.0f.xxxx.x >= fragment_unnamed_9.yxyy.x, 0.0f.xxxx.y >= fragment_unnamed_9.yxyy.y, 0.0f.xxxx.z >= fragment_unnamed_9.yxyy.z, 0.0f.xxxx.w >= fragment_unnamed_9.yxyy.w).xy;
				float3 fragment_unnamed_108;
				if (fragment_unnamed_97.y)
				{
					fragment_unnamed_108 = _Dark.xyz;
				}
				else
				{
					fragment_unnamed_108 = fragment_unnamed_75;
				}
				fragment_unnamed_75 = fragment_unnamed_108;
				fragment_unnamed_117 = fragment_input_0.xyz + fragment_input_0.xyz;
				float3 fragment_unnamed_126;
				if (fragment_unnamed_97.x)
				{
					fragment_unnamed_126 = fragment_unnamed_75;
				}
				else
				{
					fragment_unnamed_126 = fragment_unnamed_117;
				}
				fragment_unnamed_9 = float4(fragment_unnamed_126.x, fragment_unnamed_126.y, fragment_unnamed_9.z, fragment_unnamed_126.z);
				float3 fragment_unnamed_141 = fragment_unnamed_9.xyw * fragment_unnamed_9.zzz;
				fragment_output_0 = float4(fragment_unnamed_141.x, fragment_unnamed_141.y, fragment_unnamed_141.z, fragment_output_0.w);
				fragment_output_0.w = fragment_unnamed_9.z;
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
			static float4 vertex_input_1;
			static float2 vertex_output_1;
			static float2 vertex_input_2;
			static float4 vertex_output_2;

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
				vertex_output_0 = vertex_input_1 * _Color;
				vertex_output_1 = vertex_input_2;
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
				vertex_input_2 = stage_input.vertex_input_2;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_0 = vertex_output_0;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				return stage_output;
			}

			float4 _Dark;
			float4 _TextureSampleAdd;
			float4 _ClipRect;
			float4 _OutlineColor;

			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

			static float4 fragment_input_0;
			static float2 fragment_input_1;
			static float4 fragment_output_0;
			static float4 fragment_input_2;

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

			static float4 fragment_unnamed_9;
			static float3 fragment_unnamed_57;
			static bool2 fragment_unnamed_83;
			static float3 fragment_unnamed_109;
			static bool4 fragment_unnamed_137;

			void frag_main()
			{
				fragment_unnamed_9.x = (-_OutlineColor.w) + 1.0f;
				float3 fragment_unnamed_33 = fragment_unnamed_9.xxx * fragment_input_0.xyz;
				fragment_unnamed_9 = float4(fragment_unnamed_33.x, fragment_unnamed_33.y, fragment_unnamed_33.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_40 = fragment_unnamed_9.xyz + fragment_unnamed_9.xyz;
				fragment_unnamed_9 = float4(fragment_unnamed_40.x, fragment_unnamed_40.y, fragment_unnamed_40.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_53 = (_OutlineColor.xyz * _OutlineColor.www) + fragment_unnamed_9.xyz;
				fragment_unnamed_9 = float4(fragment_unnamed_53.x, fragment_unnamed_53.y, fragment_unnamed_53.z, fragment_unnamed_9.w);
				fragment_unnamed_57 = _MainTex.Sample(sampler_MainTex, fragment_input_1).xzw;
				fragment_unnamed_57 += _TextureSampleAdd.xzw;
				fragment_unnamed_83 = bool4(0.0f.xxxx.x >= fragment_unnamed_57.yxyy.x, 0.0f.xxxx.y >= fragment_unnamed_57.yxyy.y, 0.0f.xxxx.z >= fragment_unnamed_57.yxyy.z, 0.0f.xxxx.w >= fragment_unnamed_57.yxyy.w).xy;
				float3 fragment_unnamed_96;
				if (fragment_unnamed_83.y)
				{
					fragment_unnamed_96 = _Dark.xyz;
				}
				else
				{
					fragment_unnamed_96 = fragment_unnamed_9.xyz;
				}
				fragment_unnamed_9 = float4(fragment_unnamed_96.x, fragment_unnamed_96.y, fragment_unnamed_96.z, fragment_unnamed_9.w);
				fragment_unnamed_109 = fragment_input_0.xyz + fragment_input_0.xyz;
				float3 fragment_unnamed_117;
				if (fragment_unnamed_83.x)
				{
					fragment_unnamed_117 = fragment_unnamed_9.xyz;
				}
				else
				{
					fragment_unnamed_117 = fragment_unnamed_109;
				}
				fragment_unnamed_9 = float4(fragment_unnamed_117.x, fragment_unnamed_117.y, fragment_unnamed_117.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_133 = fragment_unnamed_9.xyz * fragment_unnamed_57.zzz;
				fragment_output_0 = float4(fragment_unnamed_133.x, fragment_unnamed_133.y, fragment_unnamed_133.z, fragment_output_0.w);
				bool2 fragment_unnamed_146 = bool4(fragment_input_2.xyxx.x >= _ClipRect.xyxx.x, fragment_input_2.xyxx.y >= _ClipRect.xyxx.y, fragment_input_2.xyxx.z >= _ClipRect.xyxx.z, fragment_input_2.xyxx.w >= _ClipRect.xyxx.w).xy;
				fragment_unnamed_137 = bool4(fragment_unnamed_146.x, fragment_unnamed_146.y, fragment_unnamed_137.z, fragment_unnamed_137.w);
				bool2 fragment_unnamed_155 = bool4(_ClipRect.zzzw.x >= fragment_input_2.xxxy.x, _ClipRect.zzzw.y >= fragment_input_2.xxxy.y, _ClipRect.zzzw.z >= fragment_input_2.xxxy.z, _ClipRect.zzzw.w >= fragment_input_2.xxxy.w).zw;
				fragment_unnamed_137 = bool4(fragment_unnamed_137.x, fragment_unnamed_137.y, fragment_unnamed_155.x, fragment_unnamed_155.y);
				fragment_unnamed_9.x = float(fragment_unnamed_137.x);
				fragment_unnamed_9.y = float(fragment_unnamed_137.y);
				fragment_unnamed_9.z = float(fragment_unnamed_137.z);
				fragment_unnamed_9.w = float(fragment_unnamed_137.w);
				float2 fragment_unnamed_179 = fragment_unnamed_9.zw * fragment_unnamed_9.xy;
				fragment_unnamed_9 = float4(fragment_unnamed_179.x, fragment_unnamed_179.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
				fragment_unnamed_9.x = fragment_unnamed_9.y * fragment_unnamed_9.x;
				fragment_output_0.w = fragment_unnamed_9.x * fragment_unnamed_57.z;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_0 = stage_input.fragment_input_0;
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
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
			static float4 vertex_input_1;
			static float2 vertex_output_1;
			static float2 vertex_input_2;
			static float4 vertex_output_2;

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
				vertex_output_0 = vertex_input_1 * _Color;
				vertex_output_1 = vertex_input_2;
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
				vertex_input_2 = stage_input.vertex_input_2;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_0 = vertex_output_0;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				return stage_output;
			}

			float4 _Dark;
			float4 _TextureSampleAdd;
			float4 _ClipRect;
			float4 _OutlineColor;

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
			static float3 fragment_unnamed_82;
			static float3 fragment_unnamed_104;
			static float3 fragment_unnamed_183;

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
				fragment_unnamed_82 = _MainTex.Sample(sampler_MainTex, fragment_input_1).xzw;
				fragment_unnamed_82 += _TextureSampleAdd.xzw;
				fragment_unnamed_104.x = (fragment_unnamed_82.z * fragment_unnamed_40.x) + (-0.001000000047497451305389404296875f);
				fragment_unnamed_40.x *= fragment_unnamed_82.z;
				fragment_output_0.w = fragment_unnamed_40.x;
				fragment_unnamed_9.x = fragment_unnamed_104.x < 0.0f;
				if ((int(fragment_unnamed_9.x) * (-1)) != 0)
				{
					discard;
				}
				fragment_unnamed_40.x = (-_OutlineColor.w) + 1.0f;
				fragment_unnamed_104 = fragment_unnamed_40.xxx * fragment_input_0.xyz;
				fragment_unnamed_104 += fragment_unnamed_104;
				fragment_unnamed_104 = (_OutlineColor.xyz * _OutlineColor.www) + fragment_unnamed_104;
				bool2 fragment_unnamed_168 = bool4(0.0f.xxxx.x >= fragment_unnamed_82.yxyy.x, 0.0f.xxxx.y >= fragment_unnamed_82.yxyy.y, 0.0f.xxxx.z >= fragment_unnamed_82.yxyy.z, 0.0f.xxxx.w >= fragment_unnamed_82.yxyy.w).xy;
				fragment_unnamed_9 = bool4(fragment_unnamed_168.x, fragment_unnamed_168.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_174;
				if (fragment_unnamed_9.y)
				{
					fragment_unnamed_174 = _Dark.xyz;
				}
				else
				{
					fragment_unnamed_174 = fragment_unnamed_104;
				}
				fragment_unnamed_104 = fragment_unnamed_174;
				fragment_unnamed_183 = fragment_input_0.xyz + fragment_input_0.xyz;
				float3 fragment_unnamed_191;
				if (fragment_unnamed_9.x)
				{
					fragment_unnamed_191 = fragment_unnamed_104;
				}
				else
				{
					fragment_unnamed_191 = fragment_unnamed_183;
				}
				fragment_unnamed_40 = float4(fragment_unnamed_191.x, fragment_unnamed_191.y, fragment_unnamed_191.z, fragment_unnamed_40.w);
				float3 fragment_unnamed_204 = fragment_unnamed_40.xyz * fragment_unnamed_82.zzz;
				fragment_output_0 = float4(fragment_unnamed_204.x, fragment_unnamed_204.y, fragment_unnamed_204.z, fragment_output_0.w);
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

			float4 _Dark;
			float4 _TextureSampleAdd;
			float4 _OutlineColor;

			static float4 fragment_uniform_buffer_0[7];
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
				precise float fragment_unnamed_36 = (-0.0f) - fragment_uniform_buffer_0[6u].w;
				precise float fragment_unnamed_38 = fragment_unnamed_36 + 1.0f;
				precise float fragment_unnamed_49 = fragment_unnamed_38 * fragment_input_1.x;
				precise float fragment_unnamed_50 = fragment_unnamed_38 * fragment_input_1.y;
				precise float fragment_unnamed_51 = fragment_unnamed_38 * fragment_input_1.z;
				precise float fragment_unnamed_52 = fragment_unnamed_49 + fragment_unnamed_49;
				precise float fragment_unnamed_53 = fragment_unnamed_50 + fragment_unnamed_50;
				precise float fragment_unnamed_54 = fragment_unnamed_51 + fragment_unnamed_51;
				float4 fragment_unnamed_74 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_2.x, fragment_input_2.y));
				precise float fragment_unnamed_85 = fragment_unnamed_74.x + fragment_uniform_buffer_0[4u].x;
				precise float fragment_unnamed_86 = fragment_unnamed_74.z + fragment_uniform_buffer_0[4u].z;
				precise float fragment_unnamed_87 = fragment_unnamed_74.w + fragment_uniform_buffer_0[4u].w;
				bool fragment_unnamed_89 = 0.0f >= fragment_unnamed_86;
				bool fragment_unnamed_90 = 0.0f >= fragment_unnamed_85;
				uint4 fragment_unnamed_95 = asuint(fragment_uniform_buffer_0[3u]);
				precise float fragment_unnamed_117 = fragment_input_1.x + fragment_input_1.x;
				precise float fragment_unnamed_118 = fragment_input_1.y + fragment_input_1.y;
				precise float fragment_unnamed_119 = fragment_input_1.z + fragment_input_1.z;
				precise float fragment_unnamed_129 = asfloat(fragment_unnamed_89 ? (fragment_unnamed_90 ? fragment_unnamed_95.x : asuint(mad(fragment_uniform_buffer_0[6u].x, fragment_uniform_buffer_0[6u].w, fragment_unnamed_52))) : asuint(fragment_unnamed_117)) * fragment_unnamed_87;
				precise float fragment_unnamed_130 = asfloat(fragment_unnamed_89 ? (fragment_unnamed_90 ? fragment_unnamed_95.y : asuint(mad(fragment_uniform_buffer_0[6u].y, fragment_uniform_buffer_0[6u].w, fragment_unnamed_53))) : asuint(fragment_unnamed_118)) * fragment_unnamed_87;
				precise float fragment_unnamed_131 = asfloat(fragment_unnamed_89 ? (fragment_unnamed_90 ? fragment_unnamed_95.z : asuint(mad(fragment_uniform_buffer_0[6u].z, fragment_uniform_buffer_0[6u].w, fragment_unnamed_54))) : asuint(fragment_unnamed_119)) * fragment_unnamed_87;
				fragment_output_0.x = fragment_unnamed_129;
				fragment_output_0.y = fragment_unnamed_130;
				fragment_output_0.z = fragment_unnamed_131;
				fragment_output_0.w = fragment_unnamed_87;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[3] = float4(_Dark[0], _Dark[1], _Dark[2], _Dark[3]);

				fragment_uniform_buffer_0[4] = float4(_TextureSampleAdd[0], _TextureSampleAdd[1], _TextureSampleAdd[2], _TextureSampleAdd[3]);

				fragment_uniform_buffer_0[6] = float4(_OutlineColor[0], _OutlineColor[1], _OutlineColor[2], _OutlineColor[3]);

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

			float4 _Dark;
			float4 _TextureSampleAdd;
			float4 _OutlineColor;

			static float4 fragment_uniform_buffer_0[7];
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

			void discard_cond(bool fragment_unnamed_145)
			{
				if (fragment_unnamed_145)
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
				precise float fragment_unnamed_52 = fragment_unnamed_40.x + fragment_uniform_buffer_0[4u].x;
				precise float fragment_unnamed_53 = fragment_unnamed_40.z + fragment_uniform_buffer_0[4u].z;
				precise float fragment_unnamed_54 = fragment_unnamed_40.w + fragment_uniform_buffer_0[4u].w;
				precise float fragment_unnamed_55 = fragment_unnamed_54 + (-0.001000000047497451305389404296875f);
				discard_cond(fragment_unnamed_55 < 0.0f);
				precise float fragment_unnamed_66 = (-0.0f) - fragment_uniform_buffer_0[6u].w;
				precise float fragment_unnamed_68 = fragment_unnamed_66 + 1.0f;
				precise float fragment_unnamed_77 = fragment_unnamed_68 * fragment_input_1.x;
				precise float fragment_unnamed_78 = fragment_unnamed_68 * fragment_input_1.y;
				precise float fragment_unnamed_79 = fragment_unnamed_68 * fragment_input_1.z;
				precise float fragment_unnamed_80 = fragment_unnamed_77 + fragment_unnamed_77;
				precise float fragment_unnamed_81 = fragment_unnamed_78 + fragment_unnamed_78;
				precise float fragment_unnamed_82 = fragment_unnamed_79 + fragment_unnamed_79;
				bool fragment_unnamed_95 = 0.0f >= fragment_unnamed_53;
				bool fragment_unnamed_96 = 0.0f >= fragment_unnamed_52;
				uint4 fragment_unnamed_101 = asuint(fragment_uniform_buffer_0[3u]);
				precise float fragment_unnamed_123 = fragment_input_1.x + fragment_input_1.x;
				precise float fragment_unnamed_124 = fragment_input_1.y + fragment_input_1.y;
				precise float fragment_unnamed_125 = fragment_input_1.z + fragment_input_1.z;
				precise float fragment_unnamed_135 = asfloat(fragment_unnamed_95 ? (fragment_unnamed_96 ? fragment_unnamed_101.x : asuint(mad(fragment_uniform_buffer_0[6u].x, fragment_uniform_buffer_0[6u].w, fragment_unnamed_80))) : asuint(fragment_unnamed_123)) * fragment_unnamed_54;
				precise float fragment_unnamed_136 = asfloat(fragment_unnamed_95 ? (fragment_unnamed_96 ? fragment_unnamed_101.y : asuint(mad(fragment_uniform_buffer_0[6u].y, fragment_uniform_buffer_0[6u].w, fragment_unnamed_81))) : asuint(fragment_unnamed_124)) * fragment_unnamed_54;
				precise float fragment_unnamed_137 = asfloat(fragment_unnamed_95 ? (fragment_unnamed_96 ? fragment_unnamed_101.z : asuint(mad(fragment_uniform_buffer_0[6u].z, fragment_uniform_buffer_0[6u].w, fragment_unnamed_82))) : asuint(fragment_unnamed_125)) * fragment_unnamed_54;
				fragment_output_0.x = fragment_unnamed_135;
				fragment_output_0.y = fragment_unnamed_136;
				fragment_output_0.z = fragment_unnamed_137;
				fragment_output_0.w = fragment_unnamed_54;
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[3] = float4(_Dark[0], _Dark[1], _Dark[2], _Dark[3]);

				fragment_uniform_buffer_0[4] = float4(_TextureSampleAdd[0], _TextureSampleAdd[1], _TextureSampleAdd[2], _TextureSampleAdd[3]);

				fragment_uniform_buffer_0[6] = float4(_OutlineColor[0], _OutlineColor[1], _OutlineColor[2], _OutlineColor[3]);

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

			float4 _Dark;
			float4 _TextureSampleAdd;
			float4 _ClipRect;
			float4 _OutlineColor;

			static float4 fragment_uniform_buffer_0[7];
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
				precise float fragment_unnamed_36 = (-0.0f) - fragment_uniform_buffer_0[6u].w;
				precise float fragment_unnamed_38 = fragment_unnamed_36 + 1.0f;
				precise float fragment_unnamed_49 = fragment_unnamed_38 * fragment_input_1.x;
				precise float fragment_unnamed_50 = fragment_unnamed_38 * fragment_input_1.y;
				precise float fragment_unnamed_51 = fragment_unnamed_38 * fragment_input_1.z;
				precise float fragment_unnamed_52 = fragment_unnamed_49 + fragment_unnamed_49;
				precise float fragment_unnamed_53 = fragment_unnamed_50 + fragment_unnamed_50;
				precise float fragment_unnamed_54 = fragment_unnamed_51 + fragment_unnamed_51;
				float4 fragment_unnamed_74 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_2.x, fragment_input_2.y));
				precise float fragment_unnamed_85 = fragment_unnamed_74.x + fragment_uniform_buffer_0[4u].x;
				precise float fragment_unnamed_86 = fragment_unnamed_74.z + fragment_uniform_buffer_0[4u].z;
				precise float fragment_unnamed_87 = fragment_unnamed_74.w + fragment_uniform_buffer_0[4u].w;
				bool fragment_unnamed_89 = 0.0f >= fragment_unnamed_86;
				bool fragment_unnamed_90 = 0.0f >= fragment_unnamed_85;
				uint4 fragment_unnamed_95 = asuint(fragment_uniform_buffer_0[3u]);
				precise float fragment_unnamed_117 = fragment_input_1.x + fragment_input_1.x;
				precise float fragment_unnamed_118 = fragment_input_1.y + fragment_input_1.y;
				precise float fragment_unnamed_119 = fragment_input_1.z + fragment_input_1.z;
				precise float fragment_unnamed_129 = asfloat(fragment_unnamed_89 ? (fragment_unnamed_90 ? fragment_unnamed_95.x : asuint(mad(fragment_uniform_buffer_0[6u].x, fragment_uniform_buffer_0[6u].w, fragment_unnamed_52))) : asuint(fragment_unnamed_117)) * fragment_unnamed_87;
				precise float fragment_unnamed_130 = asfloat(fragment_unnamed_89 ? (fragment_unnamed_90 ? fragment_unnamed_95.y : asuint(mad(fragment_uniform_buffer_0[6u].y, fragment_uniform_buffer_0[6u].w, fragment_unnamed_53))) : asuint(fragment_unnamed_118)) * fragment_unnamed_87;
				precise float fragment_unnamed_131 = asfloat(fragment_unnamed_89 ? (fragment_unnamed_90 ? fragment_unnamed_95.z : asuint(mad(fragment_uniform_buffer_0[6u].z, fragment_uniform_buffer_0[6u].w, fragment_unnamed_54))) : asuint(fragment_unnamed_119)) * fragment_unnamed_87;
				fragment_output_0.x = fragment_unnamed_129;
				fragment_output_0.y = fragment_unnamed_130;
				fragment_output_0.z = fragment_unnamed_131;
				precise float fragment_unnamed_171 = asfloat(((fragment_uniform_buffer_0[5u].z >= fragment_input_3.x) ? 4294967295u : 0u) & 1065353216u) * asfloat(((fragment_input_3.x >= fragment_uniform_buffer_0[5u].x) ? 4294967295u : 0u) & 1065353216u);
				precise float fragment_unnamed_172 = asfloat(((fragment_uniform_buffer_0[5u].w >= fragment_input_3.y) ? 4294967295u : 0u) & 1065353216u) * asfloat(((fragment_input_3.y >= fragment_uniform_buffer_0[5u].y) ? 4294967295u : 0u) & 1065353216u);
				precise float fragment_unnamed_173 = fragment_unnamed_172 * fragment_unnamed_171;
				precise float fragment_unnamed_174 = fragment_unnamed_173 * fragment_unnamed_87;
				fragment_output_0.w = fragment_unnamed_174;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[3] = float4(_Dark[0], _Dark[1], _Dark[2], _Dark[3]);

				fragment_uniform_buffer_0[4] = float4(_TextureSampleAdd[0], _TextureSampleAdd[1], _TextureSampleAdd[2], _TextureSampleAdd[3]);

				fragment_uniform_buffer_0[5] = float4(_ClipRect[0], _ClipRect[1], _ClipRect[2], _ClipRect[3]);

				fragment_uniform_buffer_0[6] = float4(_OutlineColor[0], _OutlineColor[1], _OutlineColor[2], _OutlineColor[3]);

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

			float4 _Dark;
			float4 _TextureSampleAdd;
			float4 _ClipRect;
			float4 _OutlineColor;

			static float4 fragment_uniform_buffer_0[7];
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

			void discard_cond(bool fragment_unnamed_184)
			{
				if (fragment_unnamed_184)
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
				precise float fragment_unnamed_70 = asfloat(((fragment_uniform_buffer_0[5u].z >= fragment_input_3.x) ? 4294967295u : 0u) & 1065353216u) * asfloat(((fragment_input_3.x >= fragment_uniform_buffer_0[5u].x) ? 4294967295u : 0u) & 1065353216u);
				precise float fragment_unnamed_71 = asfloat(((fragment_uniform_buffer_0[5u].w >= fragment_input_3.y) ? 4294967295u : 0u) & 1065353216u) * asfloat(((fragment_input_3.y >= fragment_uniform_buffer_0[5u].y) ? 4294967295u : 0u) & 1065353216u);
				precise float fragment_unnamed_72 = fragment_unnamed_71 * fragment_unnamed_70;
				float4 fragment_unnamed_80 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_2.x, fragment_input_2.y));
				precise float fragment_unnamed_91 = fragment_unnamed_80.x + fragment_uniform_buffer_0[4u].x;
				precise float fragment_unnamed_92 = fragment_unnamed_80.z + fragment_uniform_buffer_0[4u].z;
				precise float fragment_unnamed_93 = fragment_unnamed_80.w + fragment_uniform_buffer_0[4u].w;
				precise float fragment_unnamed_97 = fragment_unnamed_72 * fragment_unnamed_93;
				fragment_output_0.w = fragment_unnamed_97;
				discard_cond(mad(fragment_unnamed_93, fragment_unnamed_72, -0.001000000047497451305389404296875f) < 0.0f);
				precise float fragment_unnamed_109 = (-0.0f) - fragment_uniform_buffer_0[6u].w;
				precise float fragment_unnamed_111 = fragment_unnamed_109 + 1.0f;
				precise float fragment_unnamed_120 = fragment_unnamed_111 * fragment_input_1.x;
				precise float fragment_unnamed_121 = fragment_unnamed_111 * fragment_input_1.y;
				precise float fragment_unnamed_122 = fragment_unnamed_111 * fragment_input_1.z;
				precise float fragment_unnamed_123 = fragment_unnamed_120 + fragment_unnamed_120;
				precise float fragment_unnamed_124 = fragment_unnamed_121 + fragment_unnamed_121;
				precise float fragment_unnamed_125 = fragment_unnamed_122 + fragment_unnamed_122;
				bool fragment_unnamed_137 = 0.0f >= fragment_unnamed_92;
				bool fragment_unnamed_138 = 0.0f >= fragment_unnamed_91;
				uint4 fragment_unnamed_142 = asuint(fragment_uniform_buffer_0[3u]);
				precise float fragment_unnamed_164 = fragment_input_1.x + fragment_input_1.x;
				precise float fragment_unnamed_165 = fragment_input_1.y + fragment_input_1.y;
				precise float fragment_unnamed_166 = fragment_input_1.z + fragment_input_1.z;
				precise float fragment_unnamed_176 = asfloat(fragment_unnamed_137 ? (fragment_unnamed_138 ? fragment_unnamed_142.x : asuint(mad(fragment_uniform_buffer_0[6u].x, fragment_uniform_buffer_0[6u].w, fragment_unnamed_123))) : asuint(fragment_unnamed_164)) * fragment_unnamed_93;
				precise float fragment_unnamed_177 = asfloat(fragment_unnamed_137 ? (fragment_unnamed_138 ? fragment_unnamed_142.y : asuint(mad(fragment_uniform_buffer_0[6u].y, fragment_uniform_buffer_0[6u].w, fragment_unnamed_124))) : asuint(fragment_unnamed_165)) * fragment_unnamed_93;
				precise float fragment_unnamed_178 = asfloat(fragment_unnamed_137 ? (fragment_unnamed_138 ? fragment_unnamed_142.z : asuint(mad(fragment_uniform_buffer_0[6u].z, fragment_uniform_buffer_0[6u].w, fragment_unnamed_125))) : asuint(fragment_unnamed_166)) * fragment_unnamed_93;
				fragment_output_0.x = fragment_unnamed_176;
				fragment_output_0.y = fragment_unnamed_177;
				fragment_output_0.z = fragment_unnamed_178;
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[3] = float4(_Dark[0], _Dark[1], _Dark[2], _Dark[3]);

				fragment_uniform_buffer_0[4] = float4(_TextureSampleAdd[0], _TextureSampleAdd[1], _TextureSampleAdd[2], _TextureSampleAdd[3]);

				fragment_uniform_buffer_0[5] = float4(_ClipRect[0], _ClipRect[1], _ClipRect[2], _ClipRect[3]);

				fragment_uniform_buffer_0[6] = float4(_OutlineColor[0], _OutlineColor[1], _OutlineColor[2], _OutlineColor[3]);

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
