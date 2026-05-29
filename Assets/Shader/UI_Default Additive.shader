Shader "UI/Default Additive"
{
	Properties
	{
		[PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
		_Color ("Tint", Color) = (1,1,1,1)
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
			Blend One One, One One
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
			GpuProgramID 53620

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

			void frag_main()
			{
				fragment_unnamed_9 = _MainTex.Sample(sampler_MainTex, fragment_input_1);
				fragment_unnamed_9 += _TextureSampleAdd;
				fragment_unnamed_9 *= fragment_input_0;
				float3 fragment_unnamed_47 = fragment_unnamed_9.www * fragment_unnamed_9.xyz;
				fragment_output_0 = float4(fragment_unnamed_47.x, fragment_unnamed_47.y, fragment_unnamed_47.z, fragment_output_0.w);
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
			static bool fragment_unnamed_54;

			void frag_main()
			{
				fragment_unnamed_9 = _MainTex.Sample(sampler_MainTex, fragment_input_1);
				fragment_unnamed_9 += _TextureSampleAdd;
				fragment_unnamed_36 = (fragment_unnamed_9.w * fragment_input_0.w) + (-0.001000000047497451305389404296875f);
				fragment_unnamed_9 *= fragment_input_0;
				fragment_unnamed_54 = fragment_unnamed_36 < 0.0f;
				if ((int(fragment_unnamed_54) * (-1)) != 0)
				{
					discard;
				}
				float3 fragment_unnamed_74 = fragment_unnamed_9.www * fragment_unnamed_9.xyz;
				fragment_output_0 = float4(fragment_unnamed_74.x, fragment_unnamed_74.y, fragment_unnamed_74.z, fragment_output_0.w);
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
				fragment_unnamed_40.x *= fragment_unnamed_80.w;
				float3 fragment_unnamed_117 = fragment_unnamed_40.xxx * fragment_unnamed_80.xyz;
				fragment_output_0 = float4(fragment_unnamed_117.x, fragment_unnamed_117.y, fragment_unnamed_117.z, fragment_output_0.w);
				fragment_output_0.w = fragment_unnamed_40.x;
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
				float3 fragment_unnamed_125 = fragment_unnamed_40.xxx * fragment_unnamed_80.xyz;
				fragment_output_0 = float4(fragment_unnamed_125.x, fragment_unnamed_125.y, fragment_unnamed_125.z, fragment_output_0.w);
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
				precise float fragment_unnamed_71 = fragment_unnamed_70 * fragment_unnamed_67;
				precise float fragment_unnamed_72 = fragment_unnamed_70 * fragment_unnamed_68;
				precise float fragment_unnamed_73 = fragment_unnamed_70 * fragment_unnamed_69;
				fragment_output_0.x = fragment_unnamed_71;
				fragment_output_0.y = fragment_unnamed_72;
				fragment_output_0.z = fragment_unnamed_73;
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

			void discard_cond(bool fragment_unnamed_91)
			{
				if (fragment_unnamed_91)
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
				discard_cond(mad(fragment_unnamed_57, fragment_input_1.w, -0.001000000047497451305389404296875f) < 0.0f);
				precise float fragment_unnamed_81 = fragment_unnamed_75 * fragment_unnamed_72;
				precise float fragment_unnamed_82 = fragment_unnamed_75 * fragment_unnamed_73;
				precise float fragment_unnamed_83 = fragment_unnamed_75 * fragment_unnamed_74;
				fragment_output_0.x = fragment_unnamed_81;
				fragment_output_0.y = fragment_unnamed_82;
				fragment_output_0.z = fragment_unnamed_83;
				fragment_output_0.w = fragment_unnamed_75;
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
				precise float fragment_unnamed_111 = fragment_unnamed_110 * fragment_unnamed_106;
				precise float fragment_unnamed_112 = fragment_unnamed_110 * fragment_unnamed_107;
				precise float fragment_unnamed_113 = fragment_unnamed_110 * fragment_unnamed_108;
				fragment_output_0.x = fragment_unnamed_111;
				fragment_output_0.y = fragment_unnamed_112;
				fragment_output_0.z = fragment_unnamed_113;
				fragment_output_0.w = fragment_unnamed_110;
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

			void discard_cond(bool fragment_unnamed_128)
			{
				if (fragment_unnamed_128)
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
				precise float fragment_unnamed_114 = fragment_unnamed_113 * fragment_unnamed_106;
				precise float fragment_unnamed_115 = fragment_unnamed_113 * fragment_unnamed_107;
				precise float fragment_unnamed_116 = fragment_unnamed_113 * fragment_unnamed_108;
				fragment_output_0.x = fragment_unnamed_114;
				fragment_output_0.y = fragment_unnamed_115;
				fragment_output_0.z = fragment_unnamed_116;
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
