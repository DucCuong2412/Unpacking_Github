Shader "TextMeshPro/Distance Field (Surface)"
{
	Properties
	{
		_FaceTex ("Fill Texture", 2D) = "white" {}
		_FaceUVSpeedX ("Face UV Speed X", Range(-5, 5)) = 0
		_FaceUVSpeedY ("Face UV Speed Y", Range(-5, 5)) = 0
		_FaceColor ("Fill Color", Color) = (1,1,1,1)
		_FaceDilate ("Face Dilate", Range(-1, 1)) = 0
		_OutlineColor ("Outline Color", Color) = (0,0,0,1)
		_OutlineTex ("Outline Texture", 2D) = "white" {}
		_OutlineUVSpeedX ("Outline UV Speed X", Range(-5, 5)) = 0
		_OutlineUVSpeedY ("Outline UV Speed Y", Range(-5, 5)) = 0
		_OutlineWidth ("Outline Thickness", Range(0, 1)) = 0
		_OutlineSoftness ("Outline Softness", Range(0, 1)) = 0
		_Bevel ("Bevel", Range(0, 1)) = 0.5
		_BevelOffset ("Bevel Offset", Range(-0.5, 0.5)) = 0
		_BevelWidth ("Bevel Width", Range(-0.5, 0.5)) = 0
		_BevelClamp ("Bevel Clamp", Range(0, 1)) = 0
		_BevelRoundness ("Bevel Roundness", Range(0, 1)) = 0
		_BumpMap ("Normalmap", 2D) = "bump" {}
		_BumpOutline ("Bump Outline", Range(0, 1)) = 0.5
		_BumpFace ("Bump Face", Range(0, 1)) = 0.5
		_ReflectFaceColor ("Face Color", Color) = (0,0,0,1)
		_ReflectOutlineColor ("Outline Color", Color) = (0,0,0,1)
		_Cube ("Reflection Cubemap", Cube) = "black" {}
		_EnvMatrixRotation ("Texture Rotation", Vector) = (0,0,0,0)
		_SpecColor ("Specular Color", Color) = (0,0,0,1)
		_FaceShininess ("Face Shininess", Range(0, 1)) = 0
		_OutlineShininess ("Outline Shininess", Range(0, 1)) = 0
		_GlowColor ("Color", Color) = (0,1,0,0.5)
		_GlowOffset ("Offset", Range(-1, 1)) = 0
		_GlowInner ("Inner", Range(0, 1)) = 0.05
		_GlowOuter ("Outer", Range(0, 1)) = 0.05
		_GlowPower ("Falloff", Range(1, 0)) = 0.75
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
	}
	SubShader
	{
		LOD 300
		Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass
		{
			Name "FORWARD"
			LOD 300
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ColorMask RGB
			ZWrite Off
			Cull Off
			GpuProgramID 8719

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.0
			#pragma shader_feature DIRECTIONAL
			#pragma shader_feature LIGHTPROBE_SH
			#pragma shader_feature VERTEXLIGHT_ON


			#ifdef DIRECTIONAL
			#ifndef LIGHTPROBE_SH
			#ifndef VERTEXLIGHT_ON
			#define ANY_SHADER_VARIANT_ACTIVE

			float _FaceDilate;
			float4x4 _EnvMatrix;
			float _WeightNormal;
			float _WeightBold;
			float _ScaleRatioA;
			float _VertexOffsetX;
			float _VertexOffsetY;
			float _GradientScale;
			float _ScaleX;
			float _ScaleY;
			float _PerspectiveFilter;
			float _Sharpness;
			float4 _MainTex_ST;
			float4 _FaceTex_ST;
			float4 _OutlineTex_ST;
			float3 _WorldSpaceCameraPos;
			float4 _ScreenParams;
			float4 unity_SHBr;
			float4 unity_SHBg;
			float4 unity_SHBb;
			float4 unity_SHC;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4 unity_WorldTransformParams;
			float4x4 glstate_matrix_projection;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[35];
			static float4 vertex_uniform_buffer_1[7];
			static float4 vertex_uniform_buffer_2[46];
			static float4 vertex_uniform_buffer_3[10];
			static float4 vertex_uniform_buffer_4[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float3 vertex_input_2;
			static float4 vertex_input_3;
			static float4 vertex_input_4;
			static float4 vertex_input_5;
			static float4 vertex_input_6;
			static float4 vertex_input_7;
			static float4 vertex_output_1;
			static float2 vertex_output_2;
			static float2 vertex_output_2;
			static float4 vertex_output_3;
			static float4 vertex_output_4;
			static float4 vertex_output_5;
			static float4 vertex_output_6;
			static float3 vertex_output_7;
			static float3 vertex_output_8;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION; // POSITION
				float4 vertex_input_1 : TANGENT; // TANGENT
				float3 vertex_input_2 : NORMAL; // NORMAL
				float4 vertex_input_3 : TEXCOORD; // TEXCOORD
				float4 vertex_input_4 : TEXCOORD1; // TEXCOORD_1
				float4 vertex_input_5 : TEXCOORD2; // TEXCOORD_2
				float4 vertex_input_6 : TEXCOORD3; // TEXCOORD_3
				float4 vertex_input_7 : COLOR; // COLOR
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : TEXCOORD; // TEXCOORD
				float2 vertex_output_2 : TEXCOORD1; // TEXCOORD_1
				float2 vertex_output_2 : TEXCOORD5; // TEXCOORD_5
				float4 vertex_output_3 : TEXCOORD2; // TEXCOORD_2
				float4 vertex_output_4 : TEXCOORD3; // TEXCOORD_3
				float4 vertex_output_5 : TEXCOORD4; // TEXCOORD_4
				float4 vertex_output_6 : COLOR; // COLOR
				float3 vertex_output_7 : TEXCOORD6; // TEXCOORD_6
				float3 vertex_output_8 : TEXCOORD7; // TEXCOORD_7
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_71 = vertex_input_0.x + vertex_uniform_buffer_0[25u].z;
				precise float vertex_unnamed_72 = vertex_input_0.y + vertex_uniform_buffer_0[25u].w;
				precise float vertex_unnamed_79 = vertex_unnamed_72 * vertex_uniform_buffer_3[1u].x;
				precise float vertex_unnamed_80 = vertex_unnamed_72 * vertex_uniform_buffer_3[1u].y;
				precise float vertex_unnamed_81 = vertex_unnamed_72 * vertex_uniform_buffer_3[1u].z;
				precise float vertex_unnamed_82 = vertex_unnamed_72 * vertex_uniform_buffer_3[1u].w;
				float vertex_unnamed_103 = mad(vertex_uniform_buffer_3[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_3[0u].x, vertex_unnamed_71, vertex_unnamed_79));
				float vertex_unnamed_104 = mad(vertex_uniform_buffer_3[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_3[0u].y, vertex_unnamed_71, vertex_unnamed_80));
				float vertex_unnamed_105 = mad(vertex_uniform_buffer_3[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_3[0u].z, vertex_unnamed_71, vertex_unnamed_81));
				precise float vertex_unnamed_114 = vertex_unnamed_103 + vertex_uniform_buffer_3[3u].x;
				precise float vertex_unnamed_115 = vertex_unnamed_104 + vertex_uniform_buffer_3[3u].y;
				precise float vertex_unnamed_116 = vertex_unnamed_105 + vertex_uniform_buffer_3[3u].z;
				precise float vertex_unnamed_117 = mad(vertex_uniform_buffer_3[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_3[0u].w, vertex_unnamed_71, vertex_unnamed_82)) + vertex_uniform_buffer_3[3u].w;
				float vertex_unnamed_125 = mad(vertex_uniform_buffer_3[3u].x, vertex_input_0.w, vertex_unnamed_103);
				float vertex_unnamed_126 = mad(vertex_uniform_buffer_3[3u].y, vertex_input_0.w, vertex_unnamed_104);
				float vertex_unnamed_127 = mad(vertex_uniform_buffer_3[3u].z, vertex_input_0.w, vertex_unnamed_105);
				precise float vertex_unnamed_135 = vertex_unnamed_115 * vertex_uniform_buffer_4[18u].x;
				precise float vertex_unnamed_136 = vertex_unnamed_115 * vertex_uniform_buffer_4[18u].y;
				precise float vertex_unnamed_137 = vertex_unnamed_115 * vertex_uniform_buffer_4[18u].z;
				precise float vertex_unnamed_138 = vertex_unnamed_115 * vertex_uniform_buffer_4[18u].w;
				gl_Position.x = mad(vertex_uniform_buffer_4[20u].x, vertex_unnamed_117, mad(vertex_uniform_buffer_4[19u].x, vertex_unnamed_116, mad(vertex_uniform_buffer_4[17u].x, vertex_unnamed_114, vertex_unnamed_135)));
				gl_Position.y = mad(vertex_uniform_buffer_4[20u].y, vertex_unnamed_117, mad(vertex_uniform_buffer_4[19u].y, vertex_unnamed_116, mad(vertex_uniform_buffer_4[17u].y, vertex_unnamed_114, vertex_unnamed_136)));
				gl_Position.z = mad(vertex_uniform_buffer_4[20u].z, vertex_unnamed_117, mad(vertex_uniform_buffer_4[19u].z, vertex_unnamed_116, mad(vertex_uniform_buffer_4[17u].z, vertex_unnamed_114, vertex_unnamed_137)));
				gl_Position.w = mad(vertex_uniform_buffer_4[20u].w, vertex_unnamed_117, mad(vertex_uniform_buffer_4[19u].w, vertex_unnamed_116, mad(vertex_uniform_buffer_4[17u].w, vertex_unnamed_114, vertex_unnamed_138)));
				precise float vertex_unnamed_179 = vertex_input_4.x * 0.000244140625f;
				float vertex_unnamed_181 = floor(vertex_unnamed_179);
				precise float vertex_unnamed_182 = (-0.0f) - vertex_unnamed_181;
				precise float vertex_unnamed_188 = vertex_unnamed_181 * 0.001953125f;
				precise float vertex_unnamed_190 = mad(vertex_unnamed_182, 4096.0f, vertex_input_4.x) * 0.001953125f;
				vertex_output_1.z = mad(vertex_unnamed_188, vertex_uniform_buffer_0[33u].x, vertex_uniform_buffer_0[33u].z);
				vertex_output_1.w = mad(vertex_unnamed_190, vertex_uniform_buffer_0[33u].y, vertex_uniform_buffer_0[33u].w);
				vertex_output_2.x = mad(vertex_unnamed_188, vertex_uniform_buffer_0[34u].x, vertex_uniform_buffer_0[34u].z);
				vertex_output_2.y = mad(vertex_unnamed_190, vertex_uniform_buffer_0[34u].y, vertex_uniform_buffer_0[34u].w);
				vertex_output_1.x = mad(vertex_input_3.x, vertex_uniform_buffer_0[32u].x, vertex_uniform_buffer_0[32u].z);
				vertex_output_1.y = mad(vertex_input_3.y, vertex_uniform_buffer_0[32u].y, vertex_uniform_buffer_0[32u].w);
				precise float vertex_unnamed_248 = (-0.0f) - vertex_uniform_buffer_0[24u].y;
				precise float vertex_unnamed_252 = vertex_unnamed_248 + vertex_uniform_buffer_0[24u].z;
				precise float vertex_unnamed_266 = mad(mad(asfloat(((0.0f >= vertex_input_4.y) ? 4294967295u : 0u) & 1065353216u), vertex_unnamed_252, vertex_uniform_buffer_0[24u].y), 0.25f, vertex_uniform_buffer_0[6u].x) * vertex_uniform_buffer_0[24u].w;
				precise float vertex_unnamed_267 = vertex_unnamed_266 * 0.5f;
				vertex_output_2.x = vertex_unnamed_267;
				precise float vertex_unnamed_273 = vertex_unnamed_115 * vertex_uniform_buffer_4[18u].w;
				float vertex_unnamed_285 = mad(vertex_uniform_buffer_4[20u].w, vertex_unnamed_117, mad(vertex_uniform_buffer_4[19u].w, vertex_unnamed_116, mad(vertex_uniform_buffer_4[17u].w, vertex_unnamed_114, vertex_unnamed_273)));
				precise float vertex_unnamed_293 = vertex_uniform_buffer_1[6u].y * vertex_uniform_buffer_4[6u].x;
				precise float vertex_unnamed_294 = vertex_uniform_buffer_1[6u].y * vertex_uniform_buffer_4[6u].y;
				precise float vertex_unnamed_310 = mad(vertex_uniform_buffer_4[5u].x, vertex_uniform_buffer_1[6u].x, vertex_unnamed_293) * vertex_uniform_buffer_0[30u].y;
				precise float vertex_unnamed_311 = mad(vertex_uniform_buffer_4[5u].y, vertex_uniform_buffer_1[6u].x, vertex_unnamed_294) * vertex_uniform_buffer_0[30u].z;
				precise float vertex_unnamed_312 = vertex_unnamed_285 / vertex_unnamed_310;
				precise float vertex_unnamed_313 = vertex_unnamed_285 / vertex_unnamed_311;
				float vertex_unnamed_317 = rsqrt(dot(float2(vertex_unnamed_312, vertex_unnamed_313), float2(vertex_unnamed_312, vertex_unnamed_313)));
				precise float vertex_unnamed_324 = abs(vertex_input_4.y) * vertex_uniform_buffer_0[30u].x;
				precise float vertex_unnamed_329 = vertex_uniform_buffer_0[31u].x + 1.0f;
				precise float vertex_unnamed_331 = vertex_unnamed_324 * vertex_unnamed_329;
				precise float vertex_unnamed_332 = vertex_unnamed_317 * vertex_unnamed_331;
				precise float vertex_unnamed_336 = (-0.0f) - vertex_uniform_buffer_0[30u].w;
				precise float vertex_unnamed_337 = vertex_unnamed_336 + 1.0f;
				precise float vertex_unnamed_338 = vertex_unnamed_337 * vertex_unnamed_332;
				precise float vertex_unnamed_339 = (-0.0f) - vertex_unnamed_338;
				precise float vertex_unnamed_350 = vertex_uniform_buffer_1[4u].y * vertex_uniform_buffer_3[5u].x;
				precise float vertex_unnamed_351 = vertex_uniform_buffer_1[4u].y * vertex_uniform_buffer_3[5u].y;
				precise float vertex_unnamed_352 = vertex_uniform_buffer_1[4u].y * vertex_uniform_buffer_3[5u].z;
				precise float vertex_unnamed_380 = mad(vertex_uniform_buffer_3[6u].x, vertex_uniform_buffer_1[4u].z, mad(vertex_uniform_buffer_3[4u].x, vertex_uniform_buffer_1[4u].x, vertex_unnamed_350)) + vertex_uniform_buffer_3[7u].x;
				precise float vertex_unnamed_381 = mad(vertex_uniform_buffer_3[6u].y, vertex_uniform_buffer_1[4u].z, mad(vertex_uniform_buffer_3[4u].y, vertex_uniform_buffer_1[4u].x, vertex_unnamed_351)) + vertex_uniform_buffer_3[7u].y;
				precise float vertex_unnamed_382 = mad(vertex_uniform_buffer_3[6u].z, vertex_uniform_buffer_1[4u].z, mad(vertex_uniform_buffer_3[4u].z, vertex_uniform_buffer_1[4u].x, vertex_unnamed_352)) + vertex_uniform_buffer_3[7u].z;
				precise float vertex_unnamed_385 = (-0.0f) - vertex_unnamed_71;
				precise float vertex_unnamed_386 = (-0.0f) - vertex_unnamed_72;
				precise float vertex_unnamed_387 = (-0.0f) - vertex_input_0.z;
				precise float vertex_unnamed_388 = vertex_unnamed_385 + vertex_unnamed_380;
				precise float vertex_unnamed_389 = vertex_unnamed_386 + vertex_unnamed_381;
				precise float vertex_unnamed_390 = vertex_unnamed_387 + vertex_unnamed_382;
				float vertex_unnamed_397 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_unnamed_388, vertex_unnamed_389, vertex_unnamed_390));
				float vertex_unnamed_406 = float(int((-((0.0f < vertex_unnamed_397) ? 4294967295u : 0u)) + ((vertex_unnamed_397 < 0.0f) ? 4294967295u : 0u)));
				precise float vertex_unnamed_413 = vertex_unnamed_406 * vertex_input_2.x;
				precise float vertex_unnamed_414 = vertex_unnamed_406 * vertex_input_2.y;
				precise float vertex_unnamed_415 = vertex_unnamed_406 * vertex_input_2.z;
				float vertex_unnamed_421 = dot(float3(vertex_unnamed_413, vertex_unnamed_414, vertex_unnamed_415), float3(vertex_uniform_buffer_3[4u].xyz));
				float vertex_unnamed_429 = dot(float3(vertex_unnamed_413, vertex_unnamed_414, vertex_unnamed_415), float3(vertex_uniform_buffer_3[5u].xyz));
				float vertex_unnamed_437 = dot(float3(vertex_unnamed_413, vertex_unnamed_414, vertex_unnamed_415), float3(vertex_uniform_buffer_3[6u].xyz));
				float vertex_unnamed_443 = rsqrt(dot(float3(vertex_unnamed_421, vertex_unnamed_429, vertex_unnamed_437), float3(vertex_unnamed_421, vertex_unnamed_429, vertex_unnamed_437)));
				precise float vertex_unnamed_444 = vertex_unnamed_443 * vertex_unnamed_421;
				precise float vertex_unnamed_445 = vertex_unnamed_443 * vertex_unnamed_429;
				precise float vertex_unnamed_446 = vertex_unnamed_443 * vertex_unnamed_437;
				precise float vertex_unnamed_447 = vertex_unnamed_443 * vertex_unnamed_437;
				precise float vertex_unnamed_448 = (-0.0f) - vertex_unnamed_125;
				precise float vertex_unnamed_449 = (-0.0f) - vertex_unnamed_126;
				precise float vertex_unnamed_450 = (-0.0f) - vertex_unnamed_127;
				precise float vertex_unnamed_456 = vertex_unnamed_448 + vertex_uniform_buffer_1[4u].x;
				precise float vertex_unnamed_457 = vertex_unnamed_449 + vertex_uniform_buffer_1[4u].y;
				precise float vertex_unnamed_458 = vertex_unnamed_450 + vertex_uniform_buffer_1[4u].z;
				float vertex_unnamed_462 = rsqrt(dot(float3(vertex_unnamed_456, vertex_unnamed_457, vertex_unnamed_458), float3(vertex_unnamed_456, vertex_unnamed_457, vertex_unnamed_458)));
				precise float vertex_unnamed_463 = vertex_unnamed_456 * vertex_unnamed_462;
				precise float vertex_unnamed_464 = vertex_unnamed_457 * vertex_unnamed_462;
				precise float vertex_unnamed_465 = vertex_unnamed_458 * vertex_unnamed_462;
				vertex_output_2.y = mad(abs(dot(float3(vertex_unnamed_444, vertex_unnamed_445, vertex_unnamed_447), float3(vertex_unnamed_463, vertex_unnamed_464, vertex_unnamed_465))), mad(vertex_unnamed_317, vertex_unnamed_331, vertex_unnamed_339), vertex_unnamed_338);
				vertex_output_3.w = vertex_unnamed_125;
				precise float vertex_unnamed_480 = vertex_input_1.y * vertex_uniform_buffer_3[1u].y;
				precise float vertex_unnamed_481 = vertex_input_1.y * vertex_uniform_buffer_3[1u].z;
				precise float vertex_unnamed_482 = vertex_input_1.y * vertex_uniform_buffer_3[1u].x;
				float vertex_unnamed_500 = mad(vertex_uniform_buffer_3[2u].y, vertex_input_1.z, mad(vertex_uniform_buffer_3[0u].y, vertex_input_1.x, vertex_unnamed_480));
				float vertex_unnamed_501 = mad(vertex_uniform_buffer_3[2u].z, vertex_input_1.z, mad(vertex_uniform_buffer_3[0u].z, vertex_input_1.x, vertex_unnamed_481));
				float vertex_unnamed_502 = mad(vertex_uniform_buffer_3[2u].x, vertex_input_1.z, mad(vertex_uniform_buffer_3[0u].x, vertex_input_1.x, vertex_unnamed_482));
				float vertex_unnamed_506 = rsqrt(dot(float3(vertex_unnamed_500, vertex_unnamed_501, vertex_unnamed_502), float3(vertex_unnamed_500, vertex_unnamed_501, vertex_unnamed_502)));
				precise float vertex_unnamed_507 = vertex_unnamed_506 * vertex_unnamed_500;
				precise float vertex_unnamed_508 = vertex_unnamed_506 * vertex_unnamed_501;
				precise float vertex_unnamed_509 = vertex_unnamed_506 * vertex_unnamed_502;
				precise float vertex_unnamed_510 = vertex_unnamed_507 * vertex_unnamed_447;
				precise float vertex_unnamed_511 = vertex_unnamed_508 * vertex_unnamed_444;
				precise float vertex_unnamed_512 = vertex_unnamed_509 * vertex_unnamed_445;
				precise float vertex_unnamed_513 = (-0.0f) - vertex_unnamed_510;
				precise float vertex_unnamed_514 = (-0.0f) - vertex_unnamed_511;
				precise float vertex_unnamed_515 = (-0.0f) - vertex_unnamed_512;
				precise float vertex_unnamed_525 = vertex_input_1.w * vertex_uniform_buffer_3[9u].w;
				precise float vertex_unnamed_526 = vertex_unnamed_525 * mad(vertex_unnamed_445, vertex_unnamed_508, vertex_unnamed_513);
				precise float vertex_unnamed_527 = vertex_unnamed_525 * mad(vertex_unnamed_447, vertex_unnamed_509, vertex_unnamed_514);
				precise float vertex_unnamed_528 = vertex_unnamed_525 * mad(vertex_unnamed_444, vertex_unnamed_507, vertex_unnamed_515);
				vertex_output_3.y = vertex_unnamed_526;
				vertex_output_3.z = vertex_unnamed_444;
				vertex_output_3.x = vertex_unnamed_509;
				vertex_output_4.x = vertex_unnamed_507;
				vertex_output_5.x = vertex_unnamed_508;
				vertex_output_4.w = vertex_unnamed_126;
				vertex_output_5.w = vertex_unnamed_127;
				vertex_output_4.z = vertex_unnamed_445;
				vertex_output_4.y = vertex_unnamed_527;
				vertex_output_5.y = vertex_unnamed_528;
				vertex_output_5.z = vertex_unnamed_447;
				vertex_output_6.x = vertex_input_7.x;
				vertex_output_6.y = vertex_input_7.y;
				vertex_output_6.z = vertex_input_7.z;
				vertex_output_6.w = vertex_input_7.w;
				precise float vertex_unnamed_558 = vertex_unnamed_457 * vertex_uniform_buffer_0[14u].x;
				precise float vertex_unnamed_559 = vertex_unnamed_457 * vertex_uniform_buffer_0[14u].y;
				precise float vertex_unnamed_560 = vertex_unnamed_457 * vertex_uniform_buffer_0[14u].z;
				vertex_output_7.x = mad(vertex_uniform_buffer_0[15u].x, vertex_unnamed_458, mad(vertex_uniform_buffer_0[13u].x, vertex_unnamed_456, vertex_unnamed_558));
				vertex_output_7.y = mad(vertex_uniform_buffer_0[15u].y, vertex_unnamed_458, mad(vertex_uniform_buffer_0[13u].y, vertex_unnamed_456, vertex_unnamed_559));
				vertex_output_7.z = mad(vertex_uniform_buffer_0[15u].z, vertex_unnamed_458, mad(vertex_uniform_buffer_0[13u].z, vertex_unnamed_456, vertex_unnamed_560));
				precise float vertex_unnamed_582 = vertex_unnamed_445 * vertex_unnamed_445;
				precise float vertex_unnamed_583 = (-0.0f) - vertex_unnamed_582;
				float vertex_unnamed_584 = mad(vertex_unnamed_444, vertex_unnamed_444, vertex_unnamed_583);
				precise float vertex_unnamed_585 = vertex_unnamed_445 * vertex_unnamed_444;
				precise float vertex_unnamed_586 = vertex_unnamed_447 * vertex_unnamed_445;
				precise float vertex_unnamed_587 = vertex_unnamed_446 * vertex_unnamed_446;
				precise float vertex_unnamed_588 = vertex_unnamed_444 * vertex_unnamed_447;
				vertex_output_8.x = mad(vertex_uniform_buffer_2[45u].x, vertex_unnamed_584, dot(float4(vertex_uniform_buffer_2[42u]), float4(vertex_unnamed_585, vertex_unnamed_586, vertex_unnamed_587, vertex_unnamed_588)));
				vertex_output_8.y = mad(vertex_uniform_buffer_2[45u].y, vertex_unnamed_584, dot(float4(vertex_uniform_buffer_2[43u]), float4(vertex_unnamed_585, vertex_unnamed_586, vertex_unnamed_587, vertex_unnamed_588)));
				vertex_output_8.z = mad(vertex_uniform_buffer_2[45u].z, vertex_unnamed_584, dot(float4(vertex_uniform_buffer_2[44u]), float4(vertex_unnamed_585, vertex_unnamed_586, vertex_unnamed_587, vertex_unnamed_588)));
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[6] = float4(_FaceDilate, vertex_uniform_buffer_0[6][1], vertex_uniform_buffer_0[6][2], vertex_uniform_buffer_0[6][3]);

				vertex_uniform_buffer_0[13] = float4(_EnvMatrix[0][0], _EnvMatrix[1][0], _EnvMatrix[2][0], _EnvMatrix[3][0]);
				vertex_uniform_buffer_0[14] = float4(_EnvMatrix[0][1], _EnvMatrix[1][1], _EnvMatrix[2][1], _EnvMatrix[3][1]);
				vertex_uniform_buffer_0[15] = float4(_EnvMatrix[0][2], _EnvMatrix[1][2], _EnvMatrix[2][2], _EnvMatrix[3][2]);
				vertex_uniform_buffer_0[16] = float4(_EnvMatrix[0][3], _EnvMatrix[1][3], _EnvMatrix[2][3], _EnvMatrix[3][3]);

				vertex_uniform_buffer_0[24] = float4(vertex_uniform_buffer_0[24][0], _WeightNormal, vertex_uniform_buffer_0[24][2], vertex_uniform_buffer_0[24][3]);

				vertex_uniform_buffer_0[24] = float4(vertex_uniform_buffer_0[24][0], vertex_uniform_buffer_0[24][1], _WeightBold, vertex_uniform_buffer_0[24][3]);

				vertex_uniform_buffer_0[24] = float4(vertex_uniform_buffer_0[24][0], vertex_uniform_buffer_0[24][1], vertex_uniform_buffer_0[24][2], _ScaleRatioA);

				vertex_uniform_buffer_0[25] = float4(vertex_uniform_buffer_0[25][0], vertex_uniform_buffer_0[25][1], _VertexOffsetX, vertex_uniform_buffer_0[25][3]);

				vertex_uniform_buffer_0[25] = float4(vertex_uniform_buffer_0[25][0], vertex_uniform_buffer_0[25][1], vertex_uniform_buffer_0[25][2], _VertexOffsetY);

				vertex_uniform_buffer_0[30] = float4(_GradientScale, vertex_uniform_buffer_0[30][1], vertex_uniform_buffer_0[30][2], vertex_uniform_buffer_0[30][3]);

				vertex_uniform_buffer_0[30] = float4(vertex_uniform_buffer_0[30][0], _ScaleX, vertex_uniform_buffer_0[30][2], vertex_uniform_buffer_0[30][3]);

				vertex_uniform_buffer_0[30] = float4(vertex_uniform_buffer_0[30][0], vertex_uniform_buffer_0[30][1], _ScaleY, vertex_uniform_buffer_0[30][3]);

				vertex_uniform_buffer_0[30] = float4(vertex_uniform_buffer_0[30][0], vertex_uniform_buffer_0[30][1], vertex_uniform_buffer_0[30][2], _PerspectiveFilter);

				vertex_uniform_buffer_0[31] = float4(_Sharpness, vertex_uniform_buffer_0[31][1], vertex_uniform_buffer_0[31][2], vertex_uniform_buffer_0[31][3]);

				vertex_uniform_buffer_0[32] = float4(_MainTex_ST[0], _MainTex_ST[1], _MainTex_ST[2], _MainTex_ST[3]);

				vertex_uniform_buffer_0[33] = float4(_FaceTex_ST[0], _FaceTex_ST[1], _FaceTex_ST[2], _FaceTex_ST[3]);

				vertex_uniform_buffer_0[34] = float4(_OutlineTex_ST[0], _OutlineTex_ST[1], _OutlineTex_ST[2], _OutlineTex_ST[3]);

				vertex_uniform_buffer_1[4] = float4(_WorldSpaceCameraPos[0], _WorldSpaceCameraPos[1], _WorldSpaceCameraPos[2], vertex_uniform_buffer_1[4][3]);

				vertex_uniform_buffer_1[6] = float4(_ScreenParams[0], _ScreenParams[1], _ScreenParams[2], _ScreenParams[3]);

				vertex_uniform_buffer_2[42] = float4(unity_SHBr[0], unity_SHBr[1], unity_SHBr[2], unity_SHBr[3]);

				vertex_uniform_buffer_2[43] = float4(unity_SHBg[0], unity_SHBg[1], unity_SHBg[2], unity_SHBg[3]);

				vertex_uniform_buffer_2[44] = float4(unity_SHBb[0], unity_SHBb[1], unity_SHBb[2], unity_SHBb[3]);

				vertex_uniform_buffer_2[45] = float4(unity_SHC[0], unity_SHC[1], unity_SHC[2], unity_SHC[3]);

				vertex_uniform_buffer_3[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_3[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_3[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_3[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_3[4] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				vertex_uniform_buffer_3[5] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				vertex_uniform_buffer_3[6] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				vertex_uniform_buffer_3[7] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

				vertex_uniform_buffer_3[9] = float4(unity_WorldTransformParams[0], unity_WorldTransformParams[1], unity_WorldTransformParams[2], unity_WorldTransformParams[3]);

				vertex_uniform_buffer_4[5] = float4(glstate_matrix_projection[0][0], glstate_matrix_projection[1][0], glstate_matrix_projection[2][0], glstate_matrix_projection[3][0]);
				vertex_uniform_buffer_4[6] = float4(glstate_matrix_projection[0][1], glstate_matrix_projection[1][1], glstate_matrix_projection[2][1], glstate_matrix_projection[3][1]);
				vertex_uniform_buffer_4[7] = float4(glstate_matrix_projection[0][2], glstate_matrix_projection[1][2], glstate_matrix_projection[2][2], glstate_matrix_projection[3][2]);
				vertex_uniform_buffer_4[8] = float4(glstate_matrix_projection[0][3], glstate_matrix_projection[1][3], glstate_matrix_projection[2][3], glstate_matrix_projection[3][3]);

				vertex_uniform_buffer_4[17] = float4(unity_MatrixVP[0][0], unity_MatrixVP[1][0], unity_MatrixVP[2][0], unity_MatrixVP[3][0]);
				vertex_uniform_buffer_4[18] = float4(unity_MatrixVP[0][1], unity_MatrixVP[1][1], unity_MatrixVP[2][1], unity_MatrixVP[3][1]);
				vertex_uniform_buffer_4[19] = float4(unity_MatrixVP[0][2], unity_MatrixVP[1][2], unity_MatrixVP[2][2], unity_MatrixVP[3][2]);
				vertex_uniform_buffer_4[20] = float4(unity_MatrixVP[0][3], unity_MatrixVP[1][3], unity_MatrixVP[2][3], unity_MatrixVP[3][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_2 = stage_input.vertex_input_2;
				vertex_input_3 = stage_input.vertex_input_3;
				vertex_input_4 = stage_input.vertex_input_4;
				vertex_input_5 = stage_input.vertex_input_5;
				vertex_input_6 = stage_input.vertex_input_6;
				vertex_input_7 = stage_input.vertex_input_7;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
				stage_output.vertex_output_6 = vertex_output_6;
				stage_output.vertex_output_7 = vertex_output_7;
				stage_output.vertex_output_8 = vertex_output_8;
				return stage_output;
			}

			#endif // DIRECTIONAL
			#endif // !LIGHTPROBE_SH
			#endif // !VERTEXLIGHT_ON


			#ifdef DIRECTIONAL
			#ifdef LIGHTPROBE_SH
			#ifndef VERTEXLIGHT_ON
			#define ANY_SHADER_VARIANT_ACTIVE

			float _FaceDilate;
			float4x4 _EnvMatrix;
			float _WeightNormal;
			float _WeightBold;
			float _ScaleRatioA;
			float _VertexOffsetX;
			float _VertexOffsetY;
			float _GradientScale;
			float _ScaleX;
			float _ScaleY;
			float _PerspectiveFilter;
			float _Sharpness;
			float4 _MainTex_ST;
			float4 _FaceTex_ST;
			float4 _OutlineTex_ST;
			float3 _WorldSpaceCameraPos;
			float4 _ScreenParams;
			float4 unity_SHBr;
			float4 unity_SHBg;
			float4 unity_SHBb;
			float4 unity_SHC;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4 unity_WorldTransformParams;
			float4x4 glstate_matrix_projection;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[35];
			static float4 vertex_uniform_buffer_1[7];
			static float4 vertex_uniform_buffer_2[46];
			static float4 vertex_uniform_buffer_3[10];
			static float4 vertex_uniform_buffer_4[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float3 vertex_input_2;
			static float4 vertex_input_3;
			static float4 vertex_input_4;
			static float4 vertex_input_5;
			static float4 vertex_input_6;
			static float4 vertex_input_7;
			static float4 vertex_output_1;
			static float2 vertex_output_2;
			static float2 vertex_output_2;
			static float4 vertex_output_3;
			static float4 vertex_output_4;
			static float4 vertex_output_5;
			static float4 vertex_output_6;
			static float3 vertex_output_7;
			static float3 vertex_output_8;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION; // POSITION
				float4 vertex_input_1 : TANGENT; // TANGENT
				float3 vertex_input_2 : NORMAL; // NORMAL
				float4 vertex_input_3 : TEXCOORD; // TEXCOORD
				float4 vertex_input_4 : TEXCOORD1; // TEXCOORD_1
				float4 vertex_input_5 : TEXCOORD2; // TEXCOORD_2
				float4 vertex_input_6 : TEXCOORD3; // TEXCOORD_3
				float4 vertex_input_7 : COLOR; // COLOR
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : TEXCOORD; // TEXCOORD
				float2 vertex_output_2 : TEXCOORD1; // TEXCOORD_1
				float2 vertex_output_2 : TEXCOORD5; // TEXCOORD_5
				float4 vertex_output_3 : TEXCOORD2; // TEXCOORD_2
				float4 vertex_output_4 : TEXCOORD3; // TEXCOORD_3
				float4 vertex_output_5 : TEXCOORD4; // TEXCOORD_4
				float4 vertex_output_6 : COLOR; // COLOR
				float3 vertex_output_7 : TEXCOORD6; // TEXCOORD_6
				float3 vertex_output_8 : TEXCOORD7; // TEXCOORD_7
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_71 = vertex_input_0.x + vertex_uniform_buffer_0[25u].z;
				precise float vertex_unnamed_72 = vertex_input_0.y + vertex_uniform_buffer_0[25u].w;
				precise float vertex_unnamed_79 = vertex_unnamed_72 * vertex_uniform_buffer_3[1u].x;
				precise float vertex_unnamed_80 = vertex_unnamed_72 * vertex_uniform_buffer_3[1u].y;
				precise float vertex_unnamed_81 = vertex_unnamed_72 * vertex_uniform_buffer_3[1u].z;
				precise float vertex_unnamed_82 = vertex_unnamed_72 * vertex_uniform_buffer_3[1u].w;
				float vertex_unnamed_103 = mad(vertex_uniform_buffer_3[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_3[0u].x, vertex_unnamed_71, vertex_unnamed_79));
				float vertex_unnamed_104 = mad(vertex_uniform_buffer_3[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_3[0u].y, vertex_unnamed_71, vertex_unnamed_80));
				float vertex_unnamed_105 = mad(vertex_uniform_buffer_3[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_3[0u].z, vertex_unnamed_71, vertex_unnamed_81));
				precise float vertex_unnamed_114 = vertex_unnamed_103 + vertex_uniform_buffer_3[3u].x;
				precise float vertex_unnamed_115 = vertex_unnamed_104 + vertex_uniform_buffer_3[3u].y;
				precise float vertex_unnamed_116 = vertex_unnamed_105 + vertex_uniform_buffer_3[3u].z;
				precise float vertex_unnamed_117 = mad(vertex_uniform_buffer_3[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_3[0u].w, vertex_unnamed_71, vertex_unnamed_82)) + vertex_uniform_buffer_3[3u].w;
				float vertex_unnamed_125 = mad(vertex_uniform_buffer_3[3u].x, vertex_input_0.w, vertex_unnamed_103);
				float vertex_unnamed_126 = mad(vertex_uniform_buffer_3[3u].y, vertex_input_0.w, vertex_unnamed_104);
				float vertex_unnamed_127 = mad(vertex_uniform_buffer_3[3u].z, vertex_input_0.w, vertex_unnamed_105);
				precise float vertex_unnamed_135 = vertex_unnamed_115 * vertex_uniform_buffer_4[18u].x;
				precise float vertex_unnamed_136 = vertex_unnamed_115 * vertex_uniform_buffer_4[18u].y;
				precise float vertex_unnamed_137 = vertex_unnamed_115 * vertex_uniform_buffer_4[18u].z;
				precise float vertex_unnamed_138 = vertex_unnamed_115 * vertex_uniform_buffer_4[18u].w;
				gl_Position.x = mad(vertex_uniform_buffer_4[20u].x, vertex_unnamed_117, mad(vertex_uniform_buffer_4[19u].x, vertex_unnamed_116, mad(vertex_uniform_buffer_4[17u].x, vertex_unnamed_114, vertex_unnamed_135)));
				gl_Position.y = mad(vertex_uniform_buffer_4[20u].y, vertex_unnamed_117, mad(vertex_uniform_buffer_4[19u].y, vertex_unnamed_116, mad(vertex_uniform_buffer_4[17u].y, vertex_unnamed_114, vertex_unnamed_136)));
				gl_Position.z = mad(vertex_uniform_buffer_4[20u].z, vertex_unnamed_117, mad(vertex_uniform_buffer_4[19u].z, vertex_unnamed_116, mad(vertex_uniform_buffer_4[17u].z, vertex_unnamed_114, vertex_unnamed_137)));
				gl_Position.w = mad(vertex_uniform_buffer_4[20u].w, vertex_unnamed_117, mad(vertex_uniform_buffer_4[19u].w, vertex_unnamed_116, mad(vertex_uniform_buffer_4[17u].w, vertex_unnamed_114, vertex_unnamed_138)));
				precise float vertex_unnamed_179 = vertex_input_4.x * 0.000244140625f;
				float vertex_unnamed_181 = floor(vertex_unnamed_179);
				precise float vertex_unnamed_182 = (-0.0f) - vertex_unnamed_181;
				precise float vertex_unnamed_188 = vertex_unnamed_181 * 0.001953125f;
				precise float vertex_unnamed_190 = mad(vertex_unnamed_182, 4096.0f, vertex_input_4.x) * 0.001953125f;
				vertex_output_1.z = mad(vertex_unnamed_188, vertex_uniform_buffer_0[33u].x, vertex_uniform_buffer_0[33u].z);
				vertex_output_1.w = mad(vertex_unnamed_190, vertex_uniform_buffer_0[33u].y, vertex_uniform_buffer_0[33u].w);
				vertex_output_2.x = mad(vertex_unnamed_188, vertex_uniform_buffer_0[34u].x, vertex_uniform_buffer_0[34u].z);
				vertex_output_2.y = mad(vertex_unnamed_190, vertex_uniform_buffer_0[34u].y, vertex_uniform_buffer_0[34u].w);
				vertex_output_1.x = mad(vertex_input_3.x, vertex_uniform_buffer_0[32u].x, vertex_uniform_buffer_0[32u].z);
				vertex_output_1.y = mad(vertex_input_3.y, vertex_uniform_buffer_0[32u].y, vertex_uniform_buffer_0[32u].w);
				precise float vertex_unnamed_248 = (-0.0f) - vertex_uniform_buffer_0[24u].y;
				precise float vertex_unnamed_252 = vertex_unnamed_248 + vertex_uniform_buffer_0[24u].z;
				precise float vertex_unnamed_266 = mad(mad(asfloat(((0.0f >= vertex_input_4.y) ? 4294967295u : 0u) & 1065353216u), vertex_unnamed_252, vertex_uniform_buffer_0[24u].y), 0.25f, vertex_uniform_buffer_0[6u].x) * vertex_uniform_buffer_0[24u].w;
				precise float vertex_unnamed_267 = vertex_unnamed_266 * 0.5f;
				vertex_output_2.x = vertex_unnamed_267;
				precise float vertex_unnamed_273 = vertex_unnamed_115 * vertex_uniform_buffer_4[18u].w;
				float vertex_unnamed_285 = mad(vertex_uniform_buffer_4[20u].w, vertex_unnamed_117, mad(vertex_uniform_buffer_4[19u].w, vertex_unnamed_116, mad(vertex_uniform_buffer_4[17u].w, vertex_unnamed_114, vertex_unnamed_273)));
				precise float vertex_unnamed_293 = vertex_uniform_buffer_1[6u].y * vertex_uniform_buffer_4[6u].x;
				precise float vertex_unnamed_294 = vertex_uniform_buffer_1[6u].y * vertex_uniform_buffer_4[6u].y;
				precise float vertex_unnamed_310 = mad(vertex_uniform_buffer_4[5u].x, vertex_uniform_buffer_1[6u].x, vertex_unnamed_293) * vertex_uniform_buffer_0[30u].y;
				precise float vertex_unnamed_311 = mad(vertex_uniform_buffer_4[5u].y, vertex_uniform_buffer_1[6u].x, vertex_unnamed_294) * vertex_uniform_buffer_0[30u].z;
				precise float vertex_unnamed_312 = vertex_unnamed_285 / vertex_unnamed_310;
				precise float vertex_unnamed_313 = vertex_unnamed_285 / vertex_unnamed_311;
				float vertex_unnamed_317 = rsqrt(dot(float2(vertex_unnamed_312, vertex_unnamed_313), float2(vertex_unnamed_312, vertex_unnamed_313)));
				precise float vertex_unnamed_324 = abs(vertex_input_4.y) * vertex_uniform_buffer_0[30u].x;
				precise float vertex_unnamed_329 = vertex_uniform_buffer_0[31u].x + 1.0f;
				precise float vertex_unnamed_331 = vertex_unnamed_324 * vertex_unnamed_329;
				precise float vertex_unnamed_332 = vertex_unnamed_317 * vertex_unnamed_331;
				precise float vertex_unnamed_336 = (-0.0f) - vertex_uniform_buffer_0[30u].w;
				precise float vertex_unnamed_337 = vertex_unnamed_336 + 1.0f;
				precise float vertex_unnamed_338 = vertex_unnamed_337 * vertex_unnamed_332;
				precise float vertex_unnamed_339 = (-0.0f) - vertex_unnamed_338;
				precise float vertex_unnamed_350 = vertex_uniform_buffer_1[4u].y * vertex_uniform_buffer_3[5u].x;
				precise float vertex_unnamed_351 = vertex_uniform_buffer_1[4u].y * vertex_uniform_buffer_3[5u].y;
				precise float vertex_unnamed_352 = vertex_uniform_buffer_1[4u].y * vertex_uniform_buffer_3[5u].z;
				precise float vertex_unnamed_380 = mad(vertex_uniform_buffer_3[6u].x, vertex_uniform_buffer_1[4u].z, mad(vertex_uniform_buffer_3[4u].x, vertex_uniform_buffer_1[4u].x, vertex_unnamed_350)) + vertex_uniform_buffer_3[7u].x;
				precise float vertex_unnamed_381 = mad(vertex_uniform_buffer_3[6u].y, vertex_uniform_buffer_1[4u].z, mad(vertex_uniform_buffer_3[4u].y, vertex_uniform_buffer_1[4u].x, vertex_unnamed_351)) + vertex_uniform_buffer_3[7u].y;
				precise float vertex_unnamed_382 = mad(vertex_uniform_buffer_3[6u].z, vertex_uniform_buffer_1[4u].z, mad(vertex_uniform_buffer_3[4u].z, vertex_uniform_buffer_1[4u].x, vertex_unnamed_352)) + vertex_uniform_buffer_3[7u].z;
				precise float vertex_unnamed_385 = (-0.0f) - vertex_unnamed_71;
				precise float vertex_unnamed_386 = (-0.0f) - vertex_unnamed_72;
				precise float vertex_unnamed_387 = (-0.0f) - vertex_input_0.z;
				precise float vertex_unnamed_388 = vertex_unnamed_385 + vertex_unnamed_380;
				precise float vertex_unnamed_389 = vertex_unnamed_386 + vertex_unnamed_381;
				precise float vertex_unnamed_390 = vertex_unnamed_387 + vertex_unnamed_382;
				float vertex_unnamed_397 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_unnamed_388, vertex_unnamed_389, vertex_unnamed_390));
				float vertex_unnamed_406 = float(int((-((0.0f < vertex_unnamed_397) ? 4294967295u : 0u)) + ((vertex_unnamed_397 < 0.0f) ? 4294967295u : 0u)));
				precise float vertex_unnamed_413 = vertex_unnamed_406 * vertex_input_2.x;
				precise float vertex_unnamed_414 = vertex_unnamed_406 * vertex_input_2.y;
				precise float vertex_unnamed_415 = vertex_unnamed_406 * vertex_input_2.z;
				float vertex_unnamed_421 = dot(float3(vertex_unnamed_413, vertex_unnamed_414, vertex_unnamed_415), float3(vertex_uniform_buffer_3[4u].xyz));
				float vertex_unnamed_429 = dot(float3(vertex_unnamed_413, vertex_unnamed_414, vertex_unnamed_415), float3(vertex_uniform_buffer_3[5u].xyz));
				float vertex_unnamed_437 = dot(float3(vertex_unnamed_413, vertex_unnamed_414, vertex_unnamed_415), float3(vertex_uniform_buffer_3[6u].xyz));
				float vertex_unnamed_443 = rsqrt(dot(float3(vertex_unnamed_421, vertex_unnamed_429, vertex_unnamed_437), float3(vertex_unnamed_421, vertex_unnamed_429, vertex_unnamed_437)));
				precise float vertex_unnamed_444 = vertex_unnamed_443 * vertex_unnamed_421;
				precise float vertex_unnamed_445 = vertex_unnamed_443 * vertex_unnamed_429;
				precise float vertex_unnamed_446 = vertex_unnamed_443 * vertex_unnamed_437;
				precise float vertex_unnamed_447 = vertex_unnamed_443 * vertex_unnamed_437;
				precise float vertex_unnamed_448 = (-0.0f) - vertex_unnamed_125;
				precise float vertex_unnamed_449 = (-0.0f) - vertex_unnamed_126;
				precise float vertex_unnamed_450 = (-0.0f) - vertex_unnamed_127;
				precise float vertex_unnamed_456 = vertex_unnamed_448 + vertex_uniform_buffer_1[4u].x;
				precise float vertex_unnamed_457 = vertex_unnamed_449 + vertex_uniform_buffer_1[4u].y;
				precise float vertex_unnamed_458 = vertex_unnamed_450 + vertex_uniform_buffer_1[4u].z;
				float vertex_unnamed_462 = rsqrt(dot(float3(vertex_unnamed_456, vertex_unnamed_457, vertex_unnamed_458), float3(vertex_unnamed_456, vertex_unnamed_457, vertex_unnamed_458)));
				precise float vertex_unnamed_463 = vertex_unnamed_456 * vertex_unnamed_462;
				precise float vertex_unnamed_464 = vertex_unnamed_457 * vertex_unnamed_462;
				precise float vertex_unnamed_465 = vertex_unnamed_458 * vertex_unnamed_462;
				vertex_output_2.y = mad(abs(dot(float3(vertex_unnamed_444, vertex_unnamed_445, vertex_unnamed_447), float3(vertex_unnamed_463, vertex_unnamed_464, vertex_unnamed_465))), mad(vertex_unnamed_317, vertex_unnamed_331, vertex_unnamed_339), vertex_unnamed_338);
				vertex_output_3.w = vertex_unnamed_125;
				precise float vertex_unnamed_480 = vertex_input_1.y * vertex_uniform_buffer_3[1u].y;
				precise float vertex_unnamed_481 = vertex_input_1.y * vertex_uniform_buffer_3[1u].z;
				precise float vertex_unnamed_482 = vertex_input_1.y * vertex_uniform_buffer_3[1u].x;
				float vertex_unnamed_500 = mad(vertex_uniform_buffer_3[2u].y, vertex_input_1.z, mad(vertex_uniform_buffer_3[0u].y, vertex_input_1.x, vertex_unnamed_480));
				float vertex_unnamed_501 = mad(vertex_uniform_buffer_3[2u].z, vertex_input_1.z, mad(vertex_uniform_buffer_3[0u].z, vertex_input_1.x, vertex_unnamed_481));
				float vertex_unnamed_502 = mad(vertex_uniform_buffer_3[2u].x, vertex_input_1.z, mad(vertex_uniform_buffer_3[0u].x, vertex_input_1.x, vertex_unnamed_482));
				float vertex_unnamed_506 = rsqrt(dot(float3(vertex_unnamed_500, vertex_unnamed_501, vertex_unnamed_502), float3(vertex_unnamed_500, vertex_unnamed_501, vertex_unnamed_502)));
				precise float vertex_unnamed_507 = vertex_unnamed_506 * vertex_unnamed_500;
				precise float vertex_unnamed_508 = vertex_unnamed_506 * vertex_unnamed_501;
				precise float vertex_unnamed_509 = vertex_unnamed_506 * vertex_unnamed_502;
				precise float vertex_unnamed_510 = vertex_unnamed_507 * vertex_unnamed_447;
				precise float vertex_unnamed_511 = vertex_unnamed_508 * vertex_unnamed_444;
				precise float vertex_unnamed_512 = vertex_unnamed_509 * vertex_unnamed_445;
				precise float vertex_unnamed_513 = (-0.0f) - vertex_unnamed_510;
				precise float vertex_unnamed_514 = (-0.0f) - vertex_unnamed_511;
				precise float vertex_unnamed_515 = (-0.0f) - vertex_unnamed_512;
				precise float vertex_unnamed_525 = vertex_input_1.w * vertex_uniform_buffer_3[9u].w;
				precise float vertex_unnamed_526 = vertex_unnamed_525 * mad(vertex_unnamed_445, vertex_unnamed_508, vertex_unnamed_513);
				precise float vertex_unnamed_527 = vertex_unnamed_525 * mad(vertex_unnamed_447, vertex_unnamed_509, vertex_unnamed_514);
				precise float vertex_unnamed_528 = vertex_unnamed_525 * mad(vertex_unnamed_444, vertex_unnamed_507, vertex_unnamed_515);
				vertex_output_3.y = vertex_unnamed_526;
				vertex_output_3.z = vertex_unnamed_444;
				vertex_output_3.x = vertex_unnamed_509;
				vertex_output_4.x = vertex_unnamed_507;
				vertex_output_5.x = vertex_unnamed_508;
				vertex_output_4.w = vertex_unnamed_126;
				vertex_output_5.w = vertex_unnamed_127;
				vertex_output_4.z = vertex_unnamed_445;
				vertex_output_4.y = vertex_unnamed_527;
				vertex_output_5.y = vertex_unnamed_528;
				vertex_output_5.z = vertex_unnamed_447;
				vertex_output_6.x = vertex_input_7.x;
				vertex_output_6.y = vertex_input_7.y;
				vertex_output_6.z = vertex_input_7.z;
				vertex_output_6.w = vertex_input_7.w;
				precise float vertex_unnamed_558 = vertex_unnamed_457 * vertex_uniform_buffer_0[14u].x;
				precise float vertex_unnamed_559 = vertex_unnamed_457 * vertex_uniform_buffer_0[14u].y;
				precise float vertex_unnamed_560 = vertex_unnamed_457 * vertex_uniform_buffer_0[14u].z;
				vertex_output_7.x = mad(vertex_uniform_buffer_0[15u].x, vertex_unnamed_458, mad(vertex_uniform_buffer_0[13u].x, vertex_unnamed_456, vertex_unnamed_558));
				vertex_output_7.y = mad(vertex_uniform_buffer_0[15u].y, vertex_unnamed_458, mad(vertex_uniform_buffer_0[13u].y, vertex_unnamed_456, vertex_unnamed_559));
				vertex_output_7.z = mad(vertex_uniform_buffer_0[15u].z, vertex_unnamed_458, mad(vertex_uniform_buffer_0[13u].z, vertex_unnamed_456, vertex_unnamed_560));
				precise float vertex_unnamed_582 = vertex_unnamed_445 * vertex_unnamed_445;
				precise float vertex_unnamed_583 = (-0.0f) - vertex_unnamed_582;
				float vertex_unnamed_584 = mad(vertex_unnamed_444, vertex_unnamed_444, vertex_unnamed_583);
				precise float vertex_unnamed_585 = vertex_unnamed_445 * vertex_unnamed_444;
				precise float vertex_unnamed_586 = vertex_unnamed_447 * vertex_unnamed_445;
				precise float vertex_unnamed_587 = vertex_unnamed_446 * vertex_unnamed_446;
				precise float vertex_unnamed_588 = vertex_unnamed_444 * vertex_unnamed_447;
				vertex_output_8.x = mad(vertex_uniform_buffer_2[45u].x, vertex_unnamed_584, dot(float4(vertex_uniform_buffer_2[42u]), float4(vertex_unnamed_585, vertex_unnamed_586, vertex_unnamed_587, vertex_unnamed_588)));
				vertex_output_8.y = mad(vertex_uniform_buffer_2[45u].y, vertex_unnamed_584, dot(float4(vertex_uniform_buffer_2[43u]), float4(vertex_unnamed_585, vertex_unnamed_586, vertex_unnamed_587, vertex_unnamed_588)));
				vertex_output_8.z = mad(vertex_uniform_buffer_2[45u].z, vertex_unnamed_584, dot(float4(vertex_uniform_buffer_2[44u]), float4(vertex_unnamed_585, vertex_unnamed_586, vertex_unnamed_587, vertex_unnamed_588)));
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[6] = float4(_FaceDilate, vertex_uniform_buffer_0[6][1], vertex_uniform_buffer_0[6][2], vertex_uniform_buffer_0[6][3]);

				vertex_uniform_buffer_0[13] = float4(_EnvMatrix[0][0], _EnvMatrix[1][0], _EnvMatrix[2][0], _EnvMatrix[3][0]);
				vertex_uniform_buffer_0[14] = float4(_EnvMatrix[0][1], _EnvMatrix[1][1], _EnvMatrix[2][1], _EnvMatrix[3][1]);
				vertex_uniform_buffer_0[15] = float4(_EnvMatrix[0][2], _EnvMatrix[1][2], _EnvMatrix[2][2], _EnvMatrix[3][2]);
				vertex_uniform_buffer_0[16] = float4(_EnvMatrix[0][3], _EnvMatrix[1][3], _EnvMatrix[2][3], _EnvMatrix[3][3]);

				vertex_uniform_buffer_0[24] = float4(vertex_uniform_buffer_0[24][0], _WeightNormal, vertex_uniform_buffer_0[24][2], vertex_uniform_buffer_0[24][3]);

				vertex_uniform_buffer_0[24] = float4(vertex_uniform_buffer_0[24][0], vertex_uniform_buffer_0[24][1], _WeightBold, vertex_uniform_buffer_0[24][3]);

				vertex_uniform_buffer_0[24] = float4(vertex_uniform_buffer_0[24][0], vertex_uniform_buffer_0[24][1], vertex_uniform_buffer_0[24][2], _ScaleRatioA);

				vertex_uniform_buffer_0[25] = float4(vertex_uniform_buffer_0[25][0], vertex_uniform_buffer_0[25][1], _VertexOffsetX, vertex_uniform_buffer_0[25][3]);

				vertex_uniform_buffer_0[25] = float4(vertex_uniform_buffer_0[25][0], vertex_uniform_buffer_0[25][1], vertex_uniform_buffer_0[25][2], _VertexOffsetY);

				vertex_uniform_buffer_0[30] = float4(_GradientScale, vertex_uniform_buffer_0[30][1], vertex_uniform_buffer_0[30][2], vertex_uniform_buffer_0[30][3]);

				vertex_uniform_buffer_0[30] = float4(vertex_uniform_buffer_0[30][0], _ScaleX, vertex_uniform_buffer_0[30][2], vertex_uniform_buffer_0[30][3]);

				vertex_uniform_buffer_0[30] = float4(vertex_uniform_buffer_0[30][0], vertex_uniform_buffer_0[30][1], _ScaleY, vertex_uniform_buffer_0[30][3]);

				vertex_uniform_buffer_0[30] = float4(vertex_uniform_buffer_0[30][0], vertex_uniform_buffer_0[30][1], vertex_uniform_buffer_0[30][2], _PerspectiveFilter);

				vertex_uniform_buffer_0[31] = float4(_Sharpness, vertex_uniform_buffer_0[31][1], vertex_uniform_buffer_0[31][2], vertex_uniform_buffer_0[31][3]);

				vertex_uniform_buffer_0[32] = float4(_MainTex_ST[0], _MainTex_ST[1], _MainTex_ST[2], _MainTex_ST[3]);

				vertex_uniform_buffer_0[33] = float4(_FaceTex_ST[0], _FaceTex_ST[1], _FaceTex_ST[2], _FaceTex_ST[3]);

				vertex_uniform_buffer_0[34] = float4(_OutlineTex_ST[0], _OutlineTex_ST[1], _OutlineTex_ST[2], _OutlineTex_ST[3]);

				vertex_uniform_buffer_1[4] = float4(_WorldSpaceCameraPos[0], _WorldSpaceCameraPos[1], _WorldSpaceCameraPos[2], vertex_uniform_buffer_1[4][3]);

				vertex_uniform_buffer_1[6] = float4(_ScreenParams[0], _ScreenParams[1], _ScreenParams[2], _ScreenParams[3]);

				vertex_uniform_buffer_2[42] = float4(unity_SHBr[0], unity_SHBr[1], unity_SHBr[2], unity_SHBr[3]);

				vertex_uniform_buffer_2[43] = float4(unity_SHBg[0], unity_SHBg[1], unity_SHBg[2], unity_SHBg[3]);

				vertex_uniform_buffer_2[44] = float4(unity_SHBb[0], unity_SHBb[1], unity_SHBb[2], unity_SHBb[3]);

				vertex_uniform_buffer_2[45] = float4(unity_SHC[0], unity_SHC[1], unity_SHC[2], unity_SHC[3]);

				vertex_uniform_buffer_3[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_3[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_3[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_3[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_3[4] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				vertex_uniform_buffer_3[5] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				vertex_uniform_buffer_3[6] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				vertex_uniform_buffer_3[7] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

				vertex_uniform_buffer_3[9] = float4(unity_WorldTransformParams[0], unity_WorldTransformParams[1], unity_WorldTransformParams[2], unity_WorldTransformParams[3]);

				vertex_uniform_buffer_4[5] = float4(glstate_matrix_projection[0][0], glstate_matrix_projection[1][0], glstate_matrix_projection[2][0], glstate_matrix_projection[3][0]);
				vertex_uniform_buffer_4[6] = float4(glstate_matrix_projection[0][1], glstate_matrix_projection[1][1], glstate_matrix_projection[2][1], glstate_matrix_projection[3][1]);
				vertex_uniform_buffer_4[7] = float4(glstate_matrix_projection[0][2], glstate_matrix_projection[1][2], glstate_matrix_projection[2][2], glstate_matrix_projection[3][2]);
				vertex_uniform_buffer_4[8] = float4(glstate_matrix_projection[0][3], glstate_matrix_projection[1][3], glstate_matrix_projection[2][3], glstate_matrix_projection[3][3]);

				vertex_uniform_buffer_4[17] = float4(unity_MatrixVP[0][0], unity_MatrixVP[1][0], unity_MatrixVP[2][0], unity_MatrixVP[3][0]);
				vertex_uniform_buffer_4[18] = float4(unity_MatrixVP[0][1], unity_MatrixVP[1][1], unity_MatrixVP[2][1], unity_MatrixVP[3][1]);
				vertex_uniform_buffer_4[19] = float4(unity_MatrixVP[0][2], unity_MatrixVP[1][2], unity_MatrixVP[2][2], unity_MatrixVP[3][2]);
				vertex_uniform_buffer_4[20] = float4(unity_MatrixVP[0][3], unity_MatrixVP[1][3], unity_MatrixVP[2][3], unity_MatrixVP[3][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_2 = stage_input.vertex_input_2;
				vertex_input_3 = stage_input.vertex_input_3;
				vertex_input_4 = stage_input.vertex_input_4;
				vertex_input_5 = stage_input.vertex_input_5;
				vertex_input_6 = stage_input.vertex_input_6;
				vertex_input_7 = stage_input.vertex_input_7;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
				stage_output.vertex_output_6 = vertex_output_6;
				stage_output.vertex_output_7 = vertex_output_7;
				stage_output.vertex_output_8 = vertex_output_8;
				return stage_output;
			}

			#endif // DIRECTIONAL
			#endif // LIGHTPROBE_SH
			#endif // !VERTEXLIGHT_ON


			#ifdef DIRECTIONAL
			#ifdef LIGHTPROBE_SH
			#ifdef VERTEXLIGHT_ON
			#define ANY_SHADER_VARIANT_ACTIVE

			float _FaceDilate;
			float4x4 _EnvMatrix;
			float _WeightNormal;
			float _WeightBold;
			float _ScaleRatioA;
			float _VertexOffsetX;
			float _VertexOffsetY;
			float _GradientScale;
			float _ScaleX;
			float _ScaleY;
			float _PerspectiveFilter;
			float _Sharpness;
			float4 _MainTex_ST;
			float4 _FaceTex_ST;
			float4 _OutlineTex_ST;
			float3 _WorldSpaceCameraPos;
			float4 _ScreenParams;
			float4 unity_4LightPosX0;
			float4 unity_4LightPosY0;
			float4 unity_4LightPosZ0;
			float4 unity_4LightAtten0;
			float4 unity_LightColor[8];
			float4 unity_SHBr;
			float4 unity_SHBg;
			float4 unity_SHBb;
			float4 unity_SHC;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4 unity_WorldTransformParams;
			float4x4 glstate_matrix_projection;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[35];
			static float4 vertex_uniform_buffer_1[7];
			static float4 vertex_uniform_buffer_2[46];
			static float4 vertex_uniform_buffer_3[10];
			static float4 vertex_uniform_buffer_4[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float3 vertex_input_2;
			static float4 vertex_input_3;
			static float4 vertex_input_4;
			static float4 vertex_input_5;
			static float4 vertex_input_6;
			static float4 vertex_input_7;
			static float4 vertex_output_1;
			static float2 vertex_output_2;
			static float2 vertex_output_2;
			static float4 vertex_output_3;
			static float4 vertex_output_4;
			static float4 vertex_output_5;
			static float4 vertex_output_6;
			static float3 vertex_output_7;
			static float3 vertex_output_8;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION; // POSITION
				float4 vertex_input_1 : TANGENT; // TANGENT
				float3 vertex_input_2 : NORMAL; // NORMAL
				float4 vertex_input_3 : TEXCOORD; // TEXCOORD
				float4 vertex_input_4 : TEXCOORD1; // TEXCOORD_1
				float4 vertex_input_5 : TEXCOORD2; // TEXCOORD_2
				float4 vertex_input_6 : TEXCOORD3; // TEXCOORD_3
				float4 vertex_input_7 : COLOR; // COLOR
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : TEXCOORD; // TEXCOORD
				float2 vertex_output_2 : TEXCOORD1; // TEXCOORD_1
				float2 vertex_output_2 : TEXCOORD5; // TEXCOORD_5
				float4 vertex_output_3 : TEXCOORD2; // TEXCOORD_2
				float4 vertex_output_4 : TEXCOORD3; // TEXCOORD_3
				float4 vertex_output_5 : TEXCOORD4; // TEXCOORD_4
				float4 vertex_output_6 : COLOR; // COLOR
				float3 vertex_output_7 : TEXCOORD6; // TEXCOORD_6
				float3 vertex_output_8 : TEXCOORD7; // TEXCOORD_7
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_71 = vertex_input_0.x + vertex_uniform_buffer_0[25u].z;
				precise float vertex_unnamed_72 = vertex_input_0.y + vertex_uniform_buffer_0[25u].w;
				precise float vertex_unnamed_79 = vertex_unnamed_72 * vertex_uniform_buffer_3[1u].x;
				precise float vertex_unnamed_80 = vertex_unnamed_72 * vertex_uniform_buffer_3[1u].y;
				precise float vertex_unnamed_81 = vertex_unnamed_72 * vertex_uniform_buffer_3[1u].z;
				precise float vertex_unnamed_82 = vertex_unnamed_72 * vertex_uniform_buffer_3[1u].w;
				float vertex_unnamed_103 = mad(vertex_uniform_buffer_3[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_3[0u].x, vertex_unnamed_71, vertex_unnamed_79));
				float vertex_unnamed_104 = mad(vertex_uniform_buffer_3[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_3[0u].y, vertex_unnamed_71, vertex_unnamed_80));
				float vertex_unnamed_105 = mad(vertex_uniform_buffer_3[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_3[0u].z, vertex_unnamed_71, vertex_unnamed_81));
				precise float vertex_unnamed_114 = vertex_unnamed_103 + vertex_uniform_buffer_3[3u].x;
				precise float vertex_unnamed_115 = vertex_unnamed_104 + vertex_uniform_buffer_3[3u].y;
				precise float vertex_unnamed_116 = vertex_unnamed_105 + vertex_uniform_buffer_3[3u].z;
				precise float vertex_unnamed_117 = mad(vertex_uniform_buffer_3[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_3[0u].w, vertex_unnamed_71, vertex_unnamed_82)) + vertex_uniform_buffer_3[3u].w;
				float vertex_unnamed_125 = mad(vertex_uniform_buffer_3[3u].x, vertex_input_0.w, vertex_unnamed_103);
				float vertex_unnamed_126 = mad(vertex_uniform_buffer_3[3u].y, vertex_input_0.w, vertex_unnamed_104);
				float vertex_unnamed_127 = mad(vertex_uniform_buffer_3[3u].z, vertex_input_0.w, vertex_unnamed_105);
				precise float vertex_unnamed_135 = vertex_unnamed_115 * vertex_uniform_buffer_4[18u].x;
				precise float vertex_unnamed_136 = vertex_unnamed_115 * vertex_uniform_buffer_4[18u].y;
				precise float vertex_unnamed_137 = vertex_unnamed_115 * vertex_uniform_buffer_4[18u].z;
				precise float vertex_unnamed_138 = vertex_unnamed_115 * vertex_uniform_buffer_4[18u].w;
				gl_Position.x = mad(vertex_uniform_buffer_4[20u].x, vertex_unnamed_117, mad(vertex_uniform_buffer_4[19u].x, vertex_unnamed_116, mad(vertex_uniform_buffer_4[17u].x, vertex_unnamed_114, vertex_unnamed_135)));
				gl_Position.y = mad(vertex_uniform_buffer_4[20u].y, vertex_unnamed_117, mad(vertex_uniform_buffer_4[19u].y, vertex_unnamed_116, mad(vertex_uniform_buffer_4[17u].y, vertex_unnamed_114, vertex_unnamed_136)));
				gl_Position.z = mad(vertex_uniform_buffer_4[20u].z, vertex_unnamed_117, mad(vertex_uniform_buffer_4[19u].z, vertex_unnamed_116, mad(vertex_uniform_buffer_4[17u].z, vertex_unnamed_114, vertex_unnamed_137)));
				gl_Position.w = mad(vertex_uniform_buffer_4[20u].w, vertex_unnamed_117, mad(vertex_uniform_buffer_4[19u].w, vertex_unnamed_116, mad(vertex_uniform_buffer_4[17u].w, vertex_unnamed_114, vertex_unnamed_138)));
				precise float vertex_unnamed_179 = vertex_input_4.x * 0.000244140625f;
				float vertex_unnamed_181 = floor(vertex_unnamed_179);
				precise float vertex_unnamed_182 = (-0.0f) - vertex_unnamed_181;
				precise float vertex_unnamed_188 = vertex_unnamed_181 * 0.001953125f;
				precise float vertex_unnamed_190 = mad(vertex_unnamed_182, 4096.0f, vertex_input_4.x) * 0.001953125f;
				vertex_output_1.z = mad(vertex_unnamed_188, vertex_uniform_buffer_0[33u].x, vertex_uniform_buffer_0[33u].z);
				vertex_output_1.w = mad(vertex_unnamed_190, vertex_uniform_buffer_0[33u].y, vertex_uniform_buffer_0[33u].w);
				vertex_output_2.x = mad(vertex_unnamed_188, vertex_uniform_buffer_0[34u].x, vertex_uniform_buffer_0[34u].z);
				vertex_output_2.y = mad(vertex_unnamed_190, vertex_uniform_buffer_0[34u].y, vertex_uniform_buffer_0[34u].w);
				vertex_output_1.x = mad(vertex_input_3.x, vertex_uniform_buffer_0[32u].x, vertex_uniform_buffer_0[32u].z);
				vertex_output_1.y = mad(vertex_input_3.y, vertex_uniform_buffer_0[32u].y, vertex_uniform_buffer_0[32u].w);
				precise float vertex_unnamed_248 = (-0.0f) - vertex_uniform_buffer_0[24u].y;
				precise float vertex_unnamed_252 = vertex_unnamed_248 + vertex_uniform_buffer_0[24u].z;
				precise float vertex_unnamed_266 = mad(mad(asfloat(((0.0f >= vertex_input_4.y) ? 4294967295u : 0u) & 1065353216u), vertex_unnamed_252, vertex_uniform_buffer_0[24u].y), 0.25f, vertex_uniform_buffer_0[6u].x) * vertex_uniform_buffer_0[24u].w;
				precise float vertex_unnamed_267 = vertex_unnamed_266 * 0.5f;
				vertex_output_2.x = vertex_unnamed_267;
				precise float vertex_unnamed_273 = vertex_unnamed_115 * vertex_uniform_buffer_4[18u].w;
				float vertex_unnamed_285 = mad(vertex_uniform_buffer_4[20u].w, vertex_unnamed_117, mad(vertex_uniform_buffer_4[19u].w, vertex_unnamed_116, mad(vertex_uniform_buffer_4[17u].w, vertex_unnamed_114, vertex_unnamed_273)));
				precise float vertex_unnamed_293 = vertex_uniform_buffer_1[6u].y * vertex_uniform_buffer_4[6u].x;
				precise float vertex_unnamed_294 = vertex_uniform_buffer_1[6u].y * vertex_uniform_buffer_4[6u].y;
				precise float vertex_unnamed_310 = mad(vertex_uniform_buffer_4[5u].x, vertex_uniform_buffer_1[6u].x, vertex_unnamed_293) * vertex_uniform_buffer_0[30u].y;
				precise float vertex_unnamed_311 = mad(vertex_uniform_buffer_4[5u].y, vertex_uniform_buffer_1[6u].x, vertex_unnamed_294) * vertex_uniform_buffer_0[30u].z;
				precise float vertex_unnamed_312 = vertex_unnamed_285 / vertex_unnamed_310;
				precise float vertex_unnamed_313 = vertex_unnamed_285 / vertex_unnamed_311;
				float vertex_unnamed_317 = rsqrt(dot(float2(vertex_unnamed_312, vertex_unnamed_313), float2(vertex_unnamed_312, vertex_unnamed_313)));
				precise float vertex_unnamed_324 = abs(vertex_input_4.y) * vertex_uniform_buffer_0[30u].x;
				precise float vertex_unnamed_329 = vertex_uniform_buffer_0[31u].x + 1.0f;
				precise float vertex_unnamed_331 = vertex_unnamed_324 * vertex_unnamed_329;
				precise float vertex_unnamed_332 = vertex_unnamed_317 * vertex_unnamed_331;
				precise float vertex_unnamed_336 = (-0.0f) - vertex_uniform_buffer_0[30u].w;
				precise float vertex_unnamed_337 = vertex_unnamed_336 + 1.0f;
				precise float vertex_unnamed_338 = vertex_unnamed_337 * vertex_unnamed_332;
				precise float vertex_unnamed_339 = (-0.0f) - vertex_unnamed_338;
				precise float vertex_unnamed_350 = vertex_uniform_buffer_1[4u].y * vertex_uniform_buffer_3[5u].x;
				precise float vertex_unnamed_351 = vertex_uniform_buffer_1[4u].y * vertex_uniform_buffer_3[5u].y;
				precise float vertex_unnamed_352 = vertex_uniform_buffer_1[4u].y * vertex_uniform_buffer_3[5u].z;
				precise float vertex_unnamed_380 = mad(vertex_uniform_buffer_3[6u].x, vertex_uniform_buffer_1[4u].z, mad(vertex_uniform_buffer_3[4u].x, vertex_uniform_buffer_1[4u].x, vertex_unnamed_350)) + vertex_uniform_buffer_3[7u].x;
				precise float vertex_unnamed_381 = mad(vertex_uniform_buffer_3[6u].y, vertex_uniform_buffer_1[4u].z, mad(vertex_uniform_buffer_3[4u].y, vertex_uniform_buffer_1[4u].x, vertex_unnamed_351)) + vertex_uniform_buffer_3[7u].y;
				precise float vertex_unnamed_382 = mad(vertex_uniform_buffer_3[6u].z, vertex_uniform_buffer_1[4u].z, mad(vertex_uniform_buffer_3[4u].z, vertex_uniform_buffer_1[4u].x, vertex_unnamed_352)) + vertex_uniform_buffer_3[7u].z;
				precise float vertex_unnamed_385 = (-0.0f) - vertex_unnamed_71;
				precise float vertex_unnamed_386 = (-0.0f) - vertex_unnamed_72;
				precise float vertex_unnamed_387 = (-0.0f) - vertex_input_0.z;
				precise float vertex_unnamed_388 = vertex_unnamed_385 + vertex_unnamed_380;
				precise float vertex_unnamed_389 = vertex_unnamed_386 + vertex_unnamed_381;
				precise float vertex_unnamed_390 = vertex_unnamed_387 + vertex_unnamed_382;
				float vertex_unnamed_397 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_unnamed_388, vertex_unnamed_389, vertex_unnamed_390));
				float vertex_unnamed_406 = float(int((-((0.0f < vertex_unnamed_397) ? 4294967295u : 0u)) + ((vertex_unnamed_397 < 0.0f) ? 4294967295u : 0u)));
				precise float vertex_unnamed_413 = vertex_unnamed_406 * vertex_input_2.x;
				precise float vertex_unnamed_414 = vertex_unnamed_406 * vertex_input_2.y;
				precise float vertex_unnamed_415 = vertex_unnamed_406 * vertex_input_2.z;
				float vertex_unnamed_421 = dot(float3(vertex_unnamed_413, vertex_unnamed_414, vertex_unnamed_415), float3(vertex_uniform_buffer_3[4u].xyz));
				float vertex_unnamed_429 = dot(float3(vertex_unnamed_413, vertex_unnamed_414, vertex_unnamed_415), float3(vertex_uniform_buffer_3[5u].xyz));
				float vertex_unnamed_437 = dot(float3(vertex_unnamed_413, vertex_unnamed_414, vertex_unnamed_415), float3(vertex_uniform_buffer_3[6u].xyz));
				float vertex_unnamed_443 = rsqrt(dot(float3(vertex_unnamed_421, vertex_unnamed_429, vertex_unnamed_437), float3(vertex_unnamed_421, vertex_unnamed_429, vertex_unnamed_437)));
				precise float vertex_unnamed_444 = vertex_unnamed_443 * vertex_unnamed_421;
				precise float vertex_unnamed_445 = vertex_unnamed_443 * vertex_unnamed_429;
				precise float vertex_unnamed_446 = vertex_unnamed_443 * vertex_unnamed_437;
				precise float vertex_unnamed_447 = vertex_unnamed_443 * vertex_unnamed_437;
				precise float vertex_unnamed_448 = (-0.0f) - vertex_unnamed_125;
				precise float vertex_unnamed_449 = (-0.0f) - vertex_unnamed_126;
				precise float vertex_unnamed_450 = (-0.0f) - vertex_unnamed_127;
				precise float vertex_unnamed_456 = vertex_unnamed_448 + vertex_uniform_buffer_1[4u].x;
				precise float vertex_unnamed_457 = vertex_unnamed_449 + vertex_uniform_buffer_1[4u].y;
				precise float vertex_unnamed_458 = vertex_unnamed_450 + vertex_uniform_buffer_1[4u].z;
				float vertex_unnamed_462 = rsqrt(dot(float3(vertex_unnamed_456, vertex_unnamed_457, vertex_unnamed_458), float3(vertex_unnamed_456, vertex_unnamed_457, vertex_unnamed_458)));
				precise float vertex_unnamed_463 = vertex_unnamed_456 * vertex_unnamed_462;
				precise float vertex_unnamed_464 = vertex_unnamed_457 * vertex_unnamed_462;
				precise float vertex_unnamed_465 = vertex_unnamed_458 * vertex_unnamed_462;
				vertex_output_2.y = mad(abs(dot(float3(vertex_unnamed_444, vertex_unnamed_445, vertex_unnamed_447), float3(vertex_unnamed_463, vertex_unnamed_464, vertex_unnamed_465))), mad(vertex_unnamed_317, vertex_unnamed_331, vertex_unnamed_339), vertex_unnamed_338);
				precise float vertex_unnamed_479 = vertex_input_1.y * vertex_uniform_buffer_3[1u].y;
				precise float vertex_unnamed_480 = vertex_input_1.y * vertex_uniform_buffer_3[1u].z;
				precise float vertex_unnamed_481 = vertex_input_1.y * vertex_uniform_buffer_3[1u].x;
				float vertex_unnamed_499 = mad(vertex_uniform_buffer_3[2u].y, vertex_input_1.z, mad(vertex_uniform_buffer_3[0u].y, vertex_input_1.x, vertex_unnamed_479));
				float vertex_unnamed_500 = mad(vertex_uniform_buffer_3[2u].z, vertex_input_1.z, mad(vertex_uniform_buffer_3[0u].z, vertex_input_1.x, vertex_unnamed_480));
				float vertex_unnamed_501 = mad(vertex_uniform_buffer_3[2u].x, vertex_input_1.z, mad(vertex_uniform_buffer_3[0u].x, vertex_input_1.x, vertex_unnamed_481));
				float vertex_unnamed_505 = rsqrt(dot(float3(vertex_unnamed_499, vertex_unnamed_500, vertex_unnamed_501), float3(vertex_unnamed_499, vertex_unnamed_500, vertex_unnamed_501)));
				precise float vertex_unnamed_506 = vertex_unnamed_505 * vertex_unnamed_499;
				precise float vertex_unnamed_507 = vertex_unnamed_505 * vertex_unnamed_500;
				precise float vertex_unnamed_508 = vertex_unnamed_505 * vertex_unnamed_501;
				precise float vertex_unnamed_509 = vertex_unnamed_506 * vertex_unnamed_447;
				precise float vertex_unnamed_510 = vertex_unnamed_507 * vertex_unnamed_444;
				precise float vertex_unnamed_511 = vertex_unnamed_508 * vertex_unnamed_445;
				precise float vertex_unnamed_512 = (-0.0f) - vertex_unnamed_509;
				precise float vertex_unnamed_513 = (-0.0f) - vertex_unnamed_510;
				precise float vertex_unnamed_514 = (-0.0f) - vertex_unnamed_511;
				precise float vertex_unnamed_524 = vertex_input_1.w * vertex_uniform_buffer_3[9u].w;
				precise float vertex_unnamed_525 = vertex_unnamed_524 * mad(vertex_unnamed_445, vertex_unnamed_507, vertex_unnamed_512);
				precise float vertex_unnamed_526 = vertex_unnamed_524 * mad(vertex_unnamed_447, vertex_unnamed_508, vertex_unnamed_513);
				precise float vertex_unnamed_527 = vertex_unnamed_524 * mad(vertex_unnamed_444, vertex_unnamed_506, vertex_unnamed_514);
				vertex_output_3.y = vertex_unnamed_525;
				vertex_output_3.z = vertex_unnamed_444;
				vertex_output_3.x = vertex_unnamed_508;
				vertex_output_3.w = vertex_unnamed_125;
				vertex_output_4.x = vertex_unnamed_506;
				vertex_output_5.x = vertex_unnamed_507;
				vertex_output_4.z = vertex_unnamed_445;
				vertex_output_4.y = vertex_unnamed_526;
				vertex_output_5.y = vertex_unnamed_527;
				vertex_output_4.w = vertex_unnamed_126;
				vertex_output_5.z = vertex_unnamed_447;
				vertex_output_5.w = vertex_unnamed_127;
				vertex_output_6.x = vertex_input_7.x;
				vertex_output_6.y = vertex_input_7.y;
				vertex_output_6.z = vertex_input_7.z;
				vertex_output_6.w = vertex_input_7.w;
				precise float vertex_unnamed_558 = vertex_unnamed_457 * vertex_uniform_buffer_0[14u].x;
				precise float vertex_unnamed_559 = vertex_unnamed_457 * vertex_uniform_buffer_0[14u].y;
				precise float vertex_unnamed_560 = vertex_unnamed_457 * vertex_uniform_buffer_0[14u].z;
				vertex_output_7.x = mad(vertex_uniform_buffer_0[15u].x, vertex_unnamed_458, mad(vertex_uniform_buffer_0[13u].x, vertex_unnamed_456, vertex_unnamed_558));
				vertex_output_7.y = mad(vertex_uniform_buffer_0[15u].y, vertex_unnamed_458, mad(vertex_uniform_buffer_0[13u].y, vertex_unnamed_456, vertex_unnamed_559));
				vertex_output_7.z = mad(vertex_uniform_buffer_0[15u].z, vertex_unnamed_458, mad(vertex_uniform_buffer_0[13u].z, vertex_unnamed_456, vertex_unnamed_560));
				precise float vertex_unnamed_582 = (-0.0f) - vertex_unnamed_126;
				precise float vertex_unnamed_589 = vertex_unnamed_582 + vertex_uniform_buffer_2[4u].x;
				precise float vertex_unnamed_590 = vertex_unnamed_582 + vertex_uniform_buffer_2[4u].y;
				precise float vertex_unnamed_591 = vertex_unnamed_582 + vertex_uniform_buffer_2[4u].z;
				precise float vertex_unnamed_592 = vertex_unnamed_582 + vertex_uniform_buffer_2[4u].w;
				precise float vertex_unnamed_593 = vertex_unnamed_445 * vertex_unnamed_589;
				precise float vertex_unnamed_594 = vertex_unnamed_445 * vertex_unnamed_590;
				precise float vertex_unnamed_595 = vertex_unnamed_445 * vertex_unnamed_591;
				precise float vertex_unnamed_596 = vertex_unnamed_445 * vertex_unnamed_592;
				precise float vertex_unnamed_597 = vertex_unnamed_589 * vertex_unnamed_589;
				precise float vertex_unnamed_598 = vertex_unnamed_590 * vertex_unnamed_590;
				precise float vertex_unnamed_599 = vertex_unnamed_591 * vertex_unnamed_591;
				precise float vertex_unnamed_600 = vertex_unnamed_592 * vertex_unnamed_592;
				precise float vertex_unnamed_601 = (-0.0f) - vertex_unnamed_125;
				precise float vertex_unnamed_608 = vertex_unnamed_601 + vertex_uniform_buffer_2[3u].x;
				precise float vertex_unnamed_609 = vertex_unnamed_601 + vertex_uniform_buffer_2[3u].y;
				precise float vertex_unnamed_610 = vertex_unnamed_601 + vertex_uniform_buffer_2[3u].z;
				precise float vertex_unnamed_611 = vertex_unnamed_601 + vertex_uniform_buffer_2[3u].w;
				precise float vertex_unnamed_612 = (-0.0f) - vertex_unnamed_127;
				precise float vertex_unnamed_619 = vertex_unnamed_612 + vertex_uniform_buffer_2[5u].x;
				precise float vertex_unnamed_620 = vertex_unnamed_612 + vertex_uniform_buffer_2[5u].y;
				precise float vertex_unnamed_621 = vertex_unnamed_612 + vertex_uniform_buffer_2[5u].z;
				precise float vertex_unnamed_622 = vertex_unnamed_612 + vertex_uniform_buffer_2[5u].w;
				float vertex_unnamed_639 = max(mad(vertex_unnamed_619, vertex_unnamed_619, mad(vertex_unnamed_608, vertex_unnamed_608, vertex_unnamed_597)), 9.9999999747524270787835121154785e-07f);
				float vertex_unnamed_641 = max(mad(vertex_unnamed_620, vertex_unnamed_620, mad(vertex_unnamed_609, vertex_unnamed_609, vertex_unnamed_598)), 9.9999999747524270787835121154785e-07f);
				float vertex_unnamed_642 = max(mad(vertex_unnamed_621, vertex_unnamed_621, mad(vertex_unnamed_610, vertex_unnamed_610, vertex_unnamed_599)), 9.9999999747524270787835121154785e-07f);
				float vertex_unnamed_643 = max(mad(vertex_unnamed_622, vertex_unnamed_622, mad(vertex_unnamed_611, vertex_unnamed_611, vertex_unnamed_600)), 9.9999999747524270787835121154785e-07f);
				precise float vertex_unnamed_658 = 1.0f / mad(vertex_unnamed_639, vertex_uniform_buffer_2[6u].x, 1.0f);
				precise float vertex_unnamed_659 = 1.0f / mad(vertex_unnamed_641, vertex_uniform_buffer_2[6u].y, 1.0f);
				precise float vertex_unnamed_660 = 1.0f / mad(vertex_unnamed_642, vertex_uniform_buffer_2[6u].z, 1.0f);
				precise float vertex_unnamed_661 = 1.0f / mad(vertex_unnamed_643, vertex_uniform_buffer_2[6u].w, 1.0f);
				precise float vertex_unnamed_662 = mad(vertex_unnamed_619, vertex_unnamed_447, mad(vertex_unnamed_608, vertex_unnamed_444, vertex_unnamed_593)) * rsqrt(vertex_unnamed_639);
				precise float vertex_unnamed_663 = mad(vertex_unnamed_620, vertex_unnamed_447, mad(vertex_unnamed_609, vertex_unnamed_444, vertex_unnamed_594)) * rsqrt(vertex_unnamed_641);
				precise float vertex_unnamed_664 = mad(vertex_unnamed_621, vertex_unnamed_446, mad(vertex_unnamed_610, vertex_unnamed_444, vertex_unnamed_595)) * rsqrt(vertex_unnamed_642);
				precise float vertex_unnamed_665 = mad(vertex_unnamed_622, vertex_unnamed_447, mad(vertex_unnamed_611, vertex_unnamed_444, vertex_unnamed_596)) * rsqrt(vertex_unnamed_643);
				precise float vertex_unnamed_670 = vertex_unnamed_658 * max(vertex_unnamed_662, 0.0f);
				precise float vertex_unnamed_671 = vertex_unnamed_659 * max(vertex_unnamed_663, 0.0f);
				precise float vertex_unnamed_672 = vertex_unnamed_660 * max(vertex_unnamed_664, 0.0f);
				precise float vertex_unnamed_673 = vertex_unnamed_661 * max(vertex_unnamed_665, 0.0f);
				precise float vertex_unnamed_680 = vertex_unnamed_671 * vertex_uniform_buffer_2[8u].x;
				precise float vertex_unnamed_681 = vertex_unnamed_671 * vertex_uniform_buffer_2[8u].y;
				precise float vertex_unnamed_682 = vertex_unnamed_671 * vertex_uniform_buffer_2[8u].z;
				float vertex_unnamed_704 = mad(vertex_uniform_buffer_2[10u].x, vertex_unnamed_673, mad(vertex_uniform_buffer_2[9u].x, vertex_unnamed_672, mad(vertex_uniform_buffer_2[7u].x, vertex_unnamed_670, vertex_unnamed_680)));
				float vertex_unnamed_705 = mad(vertex_uniform_buffer_2[10u].y, vertex_unnamed_673, mad(vertex_uniform_buffer_2[9u].y, vertex_unnamed_672, mad(vertex_uniform_buffer_2[7u].y, vertex_unnamed_670, vertex_unnamed_681)));
				float vertex_unnamed_706 = mad(vertex_uniform_buffer_2[10u].z, vertex_unnamed_673, mad(vertex_uniform_buffer_2[9u].z, vertex_unnamed_672, mad(vertex_uniform_buffer_2[7u].z, vertex_unnamed_670, vertex_unnamed_682)));
				precise float vertex_unnamed_716 = vertex_unnamed_445 * vertex_unnamed_445;
				precise float vertex_unnamed_717 = (-0.0f) - vertex_unnamed_716;
				float vertex_unnamed_718 = mad(vertex_unnamed_444, vertex_unnamed_444, vertex_unnamed_717);
				precise float vertex_unnamed_719 = vertex_unnamed_445 * vertex_unnamed_444;
				precise float vertex_unnamed_720 = vertex_unnamed_447 * vertex_unnamed_445;
				precise float vertex_unnamed_721 = vertex_unnamed_446 * vertex_unnamed_446;
				precise float vertex_unnamed_722 = vertex_unnamed_444 * vertex_unnamed_447;
				vertex_output_8.x = mad(vertex_unnamed_704, mad(vertex_unnamed_704, mad(vertex_unnamed_704, 0.305306017398834228515625f, 0.6821711063385009765625f), 0.01252287812530994415283203125f), mad(vertex_uniform_buffer_2[45u].x, vertex_unnamed_718, dot(float4(vertex_uniform_buffer_2[42u]), float4(vertex_unnamed_719, vertex_unnamed_720, vertex_unnamed_721, vertex_unnamed_722))));
				vertex_output_8.y = mad(vertex_unnamed_705, mad(vertex_unnamed_705, mad(vertex_unnamed_705, 0.305306017398834228515625f, 0.6821711063385009765625f), 0.01252287812530994415283203125f), mad(vertex_uniform_buffer_2[45u].y, vertex_unnamed_718, dot(float4(vertex_uniform_buffer_2[43u]), float4(vertex_unnamed_719, vertex_unnamed_720, vertex_unnamed_721, vertex_unnamed_722))));
				vertex_output_8.z = mad(vertex_unnamed_706, mad(vertex_unnamed_706, mad(vertex_unnamed_706, 0.305306017398834228515625f, 0.6821711063385009765625f), 0.01252287812530994415283203125f), mad(vertex_uniform_buffer_2[45u].z, vertex_unnamed_718, dot(float4(vertex_uniform_buffer_2[44u]), float4(vertex_unnamed_719, vertex_unnamed_720, vertex_unnamed_721, vertex_unnamed_722))));
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[6] = float4(_FaceDilate, vertex_uniform_buffer_0[6][1], vertex_uniform_buffer_0[6][2], vertex_uniform_buffer_0[6][3]);

				vertex_uniform_buffer_0[13] = float4(_EnvMatrix[0][0], _EnvMatrix[1][0], _EnvMatrix[2][0], _EnvMatrix[3][0]);
				vertex_uniform_buffer_0[14] = float4(_EnvMatrix[0][1], _EnvMatrix[1][1], _EnvMatrix[2][1], _EnvMatrix[3][1]);
				vertex_uniform_buffer_0[15] = float4(_EnvMatrix[0][2], _EnvMatrix[1][2], _EnvMatrix[2][2], _EnvMatrix[3][2]);
				vertex_uniform_buffer_0[16] = float4(_EnvMatrix[0][3], _EnvMatrix[1][3], _EnvMatrix[2][3], _EnvMatrix[3][3]);

				vertex_uniform_buffer_0[24] = float4(vertex_uniform_buffer_0[24][0], _WeightNormal, vertex_uniform_buffer_0[24][2], vertex_uniform_buffer_0[24][3]);

				vertex_uniform_buffer_0[24] = float4(vertex_uniform_buffer_0[24][0], vertex_uniform_buffer_0[24][1], _WeightBold, vertex_uniform_buffer_0[24][3]);

				vertex_uniform_buffer_0[24] = float4(vertex_uniform_buffer_0[24][0], vertex_uniform_buffer_0[24][1], vertex_uniform_buffer_0[24][2], _ScaleRatioA);

				vertex_uniform_buffer_0[25] = float4(vertex_uniform_buffer_0[25][0], vertex_uniform_buffer_0[25][1], _VertexOffsetX, vertex_uniform_buffer_0[25][3]);

				vertex_uniform_buffer_0[25] = float4(vertex_uniform_buffer_0[25][0], vertex_uniform_buffer_0[25][1], vertex_uniform_buffer_0[25][2], _VertexOffsetY);

				vertex_uniform_buffer_0[30] = float4(_GradientScale, vertex_uniform_buffer_0[30][1], vertex_uniform_buffer_0[30][2], vertex_uniform_buffer_0[30][3]);

				vertex_uniform_buffer_0[30] = float4(vertex_uniform_buffer_0[30][0], _ScaleX, vertex_uniform_buffer_0[30][2], vertex_uniform_buffer_0[30][3]);

				vertex_uniform_buffer_0[30] = float4(vertex_uniform_buffer_0[30][0], vertex_uniform_buffer_0[30][1], _ScaleY, vertex_uniform_buffer_0[30][3]);

				vertex_uniform_buffer_0[30] = float4(vertex_uniform_buffer_0[30][0], vertex_uniform_buffer_0[30][1], vertex_uniform_buffer_0[30][2], _PerspectiveFilter);

				vertex_uniform_buffer_0[31] = float4(_Sharpness, vertex_uniform_buffer_0[31][1], vertex_uniform_buffer_0[31][2], vertex_uniform_buffer_0[31][3]);

				vertex_uniform_buffer_0[32] = float4(_MainTex_ST[0], _MainTex_ST[1], _MainTex_ST[2], _MainTex_ST[3]);

				vertex_uniform_buffer_0[33] = float4(_FaceTex_ST[0], _FaceTex_ST[1], _FaceTex_ST[2], _FaceTex_ST[3]);

				vertex_uniform_buffer_0[34] = float4(_OutlineTex_ST[0], _OutlineTex_ST[1], _OutlineTex_ST[2], _OutlineTex_ST[3]);

				vertex_uniform_buffer_1[4] = float4(_WorldSpaceCameraPos[0], _WorldSpaceCameraPos[1], _WorldSpaceCameraPos[2], vertex_uniform_buffer_1[4][3]);

				vertex_uniform_buffer_1[6] = float4(_ScreenParams[0], _ScreenParams[1], _ScreenParams[2], _ScreenParams[3]);

				vertex_uniform_buffer_2[3] = float4(unity_4LightPosX0[0], unity_4LightPosX0[1], unity_4LightPosX0[2], unity_4LightPosX0[3]);

				vertex_uniform_buffer_2[4] = float4(unity_4LightPosY0[0], unity_4LightPosY0[1], unity_4LightPosY0[2], unity_4LightPosY0[3]);

				vertex_uniform_buffer_2[5] = float4(unity_4LightPosZ0[0], unity_4LightPosZ0[1], unity_4LightPosZ0[2], unity_4LightPosZ0[3]);

				vertex_uniform_buffer_2[6] = float4(unity_4LightAtten0[0], unity_4LightAtten0[1], unity_4LightAtten0[2], unity_4LightAtten0[3]);

				vertex_uniform_buffer_2[7] = float4(unity_LightColor[0][0], unity_LightColor[0][1], unity_LightColor[0][2], unity_LightColor[0][3]);
				vertex_uniform_buffer_2[8] = float4(unity_LightColor[1][0], unity_LightColor[1][1], unity_LightColor[1][2], unity_LightColor[1][3]);
				vertex_uniform_buffer_2[9] = float4(unity_LightColor[2][0], unity_LightColor[2][1], unity_LightColor[2][2], unity_LightColor[2][3]);
				vertex_uniform_buffer_2[10] = float4(unity_LightColor[3][0], unity_LightColor[3][1], unity_LightColor[3][2], unity_LightColor[3][3]);
				vertex_uniform_buffer_2[11] = float4(unity_LightColor[4][0], unity_LightColor[4][1], unity_LightColor[4][2], unity_LightColor[4][3]);
				vertex_uniform_buffer_2[12] = float4(unity_LightColor[5][0], unity_LightColor[5][1], unity_LightColor[5][2], unity_LightColor[5][3]);
				vertex_uniform_buffer_2[13] = float4(unity_LightColor[6][0], unity_LightColor[6][1], unity_LightColor[6][2], unity_LightColor[6][3]);
				vertex_uniform_buffer_2[14] = float4(unity_LightColor[7][0], unity_LightColor[7][1], unity_LightColor[7][2], unity_LightColor[7][3]);

				vertex_uniform_buffer_2[42] = float4(unity_SHBr[0], unity_SHBr[1], unity_SHBr[2], unity_SHBr[3]);

				vertex_uniform_buffer_2[43] = float4(unity_SHBg[0], unity_SHBg[1], unity_SHBg[2], unity_SHBg[3]);

				vertex_uniform_buffer_2[44] = float4(unity_SHBb[0], unity_SHBb[1], unity_SHBb[2], unity_SHBb[3]);

				vertex_uniform_buffer_2[45] = float4(unity_SHC[0], unity_SHC[1], unity_SHC[2], unity_SHC[3]);

				vertex_uniform_buffer_3[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_3[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_3[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_3[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_3[4] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				vertex_uniform_buffer_3[5] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				vertex_uniform_buffer_3[6] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				vertex_uniform_buffer_3[7] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

				vertex_uniform_buffer_3[9] = float4(unity_WorldTransformParams[0], unity_WorldTransformParams[1], unity_WorldTransformParams[2], unity_WorldTransformParams[3]);

				vertex_uniform_buffer_4[5] = float4(glstate_matrix_projection[0][0], glstate_matrix_projection[1][0], glstate_matrix_projection[2][0], glstate_matrix_projection[3][0]);
				vertex_uniform_buffer_4[6] = float4(glstate_matrix_projection[0][1], glstate_matrix_projection[1][1], glstate_matrix_projection[2][1], glstate_matrix_projection[3][1]);
				vertex_uniform_buffer_4[7] = float4(glstate_matrix_projection[0][2], glstate_matrix_projection[1][2], glstate_matrix_projection[2][2], glstate_matrix_projection[3][2]);
				vertex_uniform_buffer_4[8] = float4(glstate_matrix_projection[0][3], glstate_matrix_projection[1][3], glstate_matrix_projection[2][3], glstate_matrix_projection[3][3]);

				vertex_uniform_buffer_4[17] = float4(unity_MatrixVP[0][0], unity_MatrixVP[1][0], unity_MatrixVP[2][0], unity_MatrixVP[3][0]);
				vertex_uniform_buffer_4[18] = float4(unity_MatrixVP[0][1], unity_MatrixVP[1][1], unity_MatrixVP[2][1], unity_MatrixVP[3][1]);
				vertex_uniform_buffer_4[19] = float4(unity_MatrixVP[0][2], unity_MatrixVP[1][2], unity_MatrixVP[2][2], unity_MatrixVP[3][2]);
				vertex_uniform_buffer_4[20] = float4(unity_MatrixVP[0][3], unity_MatrixVP[1][3], unity_MatrixVP[2][3], unity_MatrixVP[3][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_2 = stage_input.vertex_input_2;
				vertex_input_3 = stage_input.vertex_input_3;
				vertex_input_4 = stage_input.vertex_input_4;
				vertex_input_5 = stage_input.vertex_input_5;
				vertex_input_6 = stage_input.vertex_input_6;
				vertex_input_7 = stage_input.vertex_input_7;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
				stage_output.vertex_output_6 = vertex_output_6;
				stage_output.vertex_output_7 = vertex_output_7;
				stage_output.vertex_output_8 = vertex_output_8;
				return stage_output;
			}

			#endif // DIRECTIONAL
			#endif // LIGHTPROBE_SH
			#endif // VERTEXLIGHT_ON


			#ifdef DIRECTIONAL
			#ifndef LIGHTPROBE_SH
			#ifndef VERTEXLIGHT_ON
			#define ANY_SHADER_VARIANT_ACTIVE

			float3 _WorldSpaceCameraPos;
			float4 _ScreenParams;
			float4 unity_SHBr;
			float4 unity_SHBg;
			float4 unity_SHBb;
			float4 unity_SHC;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4 unity_WorldTransformParams;
			float4x4 glstate_matrix_projection;
			float4x4 unity_MatrixVP;
			float _FaceDilate;
			float4x4 _EnvMatrix;
			float _WeightNormal;
			float _WeightBold;
			float _ScaleRatioA;
			float _VertexOffsetX;
			float _VertexOffsetY;
			float _GradientScale;
			float _ScaleX;
			float _ScaleY;
			float _PerspectiveFilter;
			float _Sharpness;
			float4 _MainTex_ST;
			float4 _FaceTex_ST;
			float4 _OutlineTex_ST;

			static float4 unity_ObjectToWorld__array[4];
			static float4 unity_WorldToObject__array[4];
			static float4 glstate_matrix_projection__array[4];
			static float4 unity_MatrixVP__array[4];
			static float4 _EnvMatrix__array[4];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_4;
			static float4 vertex_output_0;
			static float2 vertex_output_1;
			static float4 vertex_input_3;
			static float2 vertex_output_2;
			static float3 vertex_input_2;
			static float4 vertex_output_3;
			static float4 vertex_input_1;
			static float4 vertex_output_4;
			static float4 vertex_output_5;
			static float4 vertex_output_6;
			static float4 vertex_input_5;
			static float3 vertex_output_7;
			static float3 vertex_output_8;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION;
				float4 vertex_input_1 : TANGENT;
				float3 vertex_input_2 : NORMAL;
				float4 vertex_input_3 : TEXCOORD0;
				float4 vertex_input_4 : TEXCOORD1;
				float4 vertex_input_5 : COLOR;
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_0 : TEXCOORD0; // vs_TEXCOORD0
				float2 vertex_output_1 : TEXCOORD1; // vs_TEXCOORD1
				float2 vertex_output_2 : TEXCOORD5; // vs_TEXCOORD5
				float4 vertex_output_3 : TEXCOORD2; // vs_TEXCOORD2
				float4 vertex_output_4 : TEXCOORD3; // vs_TEXCOORD3
				float4 vertex_output_5 : TEXCOORD4; // vs_TEXCOORD4
				float4 vertex_output_6 : UNKNOWN6;
				float3 vertex_output_7 : TEXCOORD6; // vs_TEXCOORD6
				float3 vertex_output_8 : TEXCOORD7; // vs_TEXCOORD7
				float4 gl_Position : SV_Position;
			};

			static float4 vertex_unnamed_9;
			static float4 vertex_unnamed_38;
			static float4 vertex_unnamed_63;
			static float4 vertex_unnamed_80;
			static float vertex_unnamed_116;
			static bool vertex_unnamed_186;
			static float vertex_unnamed_194;
			static float3 vertex_unnamed_324;
			static int vertex_unnamed_394;
			static int vertex_unnamed_401;
			static float3 vertex_unnamed_537;

			void vert_main()
			{
				float2 vertex_unnamed_35 = vertex_input_0.xy + float2(_VertexOffsetX, _VertexOffsetY);
				vertex_unnamed_9 = float4(vertex_unnamed_35.x, vertex_unnamed_35.y, vertex_unnamed_9.z, vertex_unnamed_9.w);
				vertex_unnamed_38 = vertex_unnamed_9.yyyy * unity_ObjectToWorld__array[1];
				vertex_unnamed_38 = (unity_ObjectToWorld__array[0] * vertex_unnamed_9.xxxx) + vertex_unnamed_38;
				vertex_unnamed_38 = (unity_ObjectToWorld__array[2] * vertex_input_0.zzzz) + vertex_unnamed_38;
				vertex_unnamed_63 = vertex_unnamed_38 + unity_ObjectToWorld__array[3];
				float3 vertex_unnamed_77 = (unity_ObjectToWorld__array[3].xyz * vertex_input_0.www) + vertex_unnamed_38.xyz;
				vertex_unnamed_38 = float4(vertex_unnamed_77.x, vertex_unnamed_77.y, vertex_unnamed_77.z, vertex_unnamed_38.w);
				vertex_unnamed_80 = vertex_unnamed_63.yyyy * unity_MatrixVP__array[1];
				vertex_unnamed_80 = (unity_MatrixVP__array[0] * vertex_unnamed_63.xxxx) + vertex_unnamed_80;
				vertex_unnamed_80 = (unity_MatrixVP__array[2] * vertex_unnamed_63.zzzz) + vertex_unnamed_80;
				gl_Position = (unity_MatrixVP__array[3] * vertex_unnamed_63.wwww) + vertex_unnamed_80;
				vertex_unnamed_116 = vertex_input_4.x * 0.000244140625f;
				vertex_unnamed_80.x = floor(vertex_unnamed_116);
				vertex_unnamed_80.y = ((-vertex_unnamed_80.x) * 4096.0f) + vertex_input_4.x;
				float2 vertex_unnamed_140 = vertex_unnamed_80.xy * 0.001953125f.xx;
				vertex_unnamed_80 = float4(vertex_unnamed_140.x, vertex_unnamed_140.y, vertex_unnamed_80.z, vertex_unnamed_80.w);
				float2 vertex_unnamed_154 = (vertex_unnamed_80.xy * _FaceTex_ST.xy) + _FaceTex_ST.zw;
				vertex_output_0 = float4(vertex_output_0.x, vertex_output_0.y, vertex_unnamed_154.x, vertex_unnamed_154.y);
				vertex_output_1 = (vertex_unnamed_80.xy * _OutlineTex_ST.xy) + _OutlineTex_ST.zw;
				float2 vertex_unnamed_181 = (vertex_input_3.xy * _MainTex_ST.xy) + _MainTex_ST.zw;
				vertex_output_0 = float4(vertex_unnamed_181.x, vertex_unnamed_181.y, vertex_output_0.z, vertex_output_0.w);
				vertex_unnamed_186 = 0.0f >= vertex_input_4.y;
				vertex_unnamed_116 = float(vertex_unnamed_186);
				vertex_unnamed_194 = (-_WeightNormal) + _WeightBold;
				vertex_unnamed_116 = (vertex_unnamed_116 * vertex_unnamed_194) + _WeightNormal;
				vertex_unnamed_116 = (vertex_unnamed_116 * 0.25f) + _FaceDilate;
				vertex_unnamed_116 *= _ScaleRatioA;
				vertex_output_2.x = vertex_unnamed_116 * 0.5f;
				vertex_unnamed_116 = vertex_unnamed_63.y * unity_MatrixVP__array[1].w;
				vertex_unnamed_116 = (unity_MatrixVP__array[0].w * vertex_unnamed_63.x) + vertex_unnamed_116;
				vertex_unnamed_116 = (unity_MatrixVP__array[2].w * vertex_unnamed_63.z) + vertex_unnamed_116;
				vertex_unnamed_116 = (unity_MatrixVP__array[3].w * vertex_unnamed_63.w) + vertex_unnamed_116;
				float2 vertex_unnamed_262 = _ScreenParams.yy * glstate_matrix_projection__array[1].xy;
				vertex_unnamed_63 = float4(vertex_unnamed_262.x, vertex_unnamed_262.y, vertex_unnamed_63.z, vertex_unnamed_63.w);
				float2 vertex_unnamed_274 = (glstate_matrix_projection__array[0].xy * _ScreenParams.xx) + vertex_unnamed_63.xy;
				vertex_unnamed_63 = float4(vertex_unnamed_274.x, vertex_unnamed_274.y, vertex_unnamed_63.z, vertex_unnamed_63.w);
				float2 vertex_unnamed_286 = vertex_unnamed_63.xy * float2(_ScaleX, _ScaleY);
				vertex_unnamed_63 = float4(vertex_unnamed_286.x, vertex_unnamed_286.y, vertex_unnamed_63.z, vertex_unnamed_63.w);
				float2 vertex_unnamed_293 = vertex_unnamed_116.xx / vertex_unnamed_63.xy;
				vertex_unnamed_63 = float4(vertex_unnamed_293.x, vertex_unnamed_293.y, vertex_unnamed_63.z, vertex_unnamed_63.w);
				vertex_unnamed_116 = dot(vertex_unnamed_63.xy, vertex_unnamed_63.xy);
				vertex_unnamed_116 = rsqrt(vertex_unnamed_116);
				vertex_unnamed_194 = abs(vertex_input_4.y) * _GradientScale;
				vertex_unnamed_63.x = _Sharpness + 1.0f;
				vertex_unnamed_194 *= vertex_unnamed_63.x;
				vertex_unnamed_63.x = vertex_unnamed_116 * vertex_unnamed_194;
				vertex_unnamed_324.x = (-_PerspectiveFilter) + 1.0f;
				vertex_unnamed_63.x = vertex_unnamed_324.x * vertex_unnamed_63.x;
				vertex_unnamed_116 = (vertex_unnamed_116 * vertex_unnamed_194) + (-vertex_unnamed_63.x);
				vertex_unnamed_324 = _WorldSpaceCameraPos.yyy * unity_WorldToObject__array[1].xyz;
				vertex_unnamed_324 = (unity_WorldToObject__array[0].xyz * _WorldSpaceCameraPos.xxx) + vertex_unnamed_324;
				vertex_unnamed_324 = (unity_WorldToObject__array[2].xyz * _WorldSpaceCameraPos.zzz) + vertex_unnamed_324;
				vertex_unnamed_324 += unity_WorldToObject__array[3].xyz;
				vertex_unnamed_9.z = vertex_input_0.z;
				float3 vertex_unnamed_383 = (-vertex_unnamed_9.xyz) + vertex_unnamed_324;
				vertex_unnamed_9 = float4(vertex_unnamed_383.x, vertex_unnamed_383.y, vertex_unnamed_383.z, vertex_unnamed_9.w);
				vertex_unnamed_9.x = dot(vertex_input_2, vertex_unnamed_9.xyz);
				vertex_unnamed_394 = int((0.0f < vertex_unnamed_9.x) ? 4294967295u : 0u);
				vertex_unnamed_401 = int((vertex_unnamed_9.x < 0.0f) ? 4294967295u : 0u);
				vertex_unnamed_401 = (-vertex_unnamed_394) + vertex_unnamed_401;
				vertex_unnamed_9.x = float(vertex_unnamed_401);
				float3 vertex_unnamed_417 = vertex_unnamed_9.xxx * vertex_input_2;
				vertex_unnamed_9 = float4(vertex_unnamed_417.x, vertex_unnamed_417.y, vertex_unnamed_417.z, vertex_unnamed_9.w);
				vertex_unnamed_80.x = dot(vertex_unnamed_9.xyz, unity_WorldToObject__array[0].xyz);
				vertex_unnamed_80.y = dot(vertex_unnamed_9.xyz, unity_WorldToObject__array[1].xyz);
				vertex_unnamed_80.z = dot(vertex_unnamed_9.xyz, unity_WorldToObject__array[2].xyz);
				vertex_unnamed_9.x = dot(vertex_unnamed_80.xyz, vertex_unnamed_80.xyz);
				vertex_unnamed_9.x = rsqrt(vertex_unnamed_9.x);
				vertex_unnamed_80 = vertex_unnamed_9.xxxx * vertex_unnamed_80.xyzz;
				float3 vertex_unnamed_461 = (-vertex_unnamed_38.xyz) + _WorldSpaceCameraPos;
				vertex_unnamed_9 = float4(vertex_unnamed_461.x, vertex_unnamed_461.y, vertex_unnamed_461.z, vertex_unnamed_9.w);
				vertex_unnamed_194 = dot(vertex_unnamed_9.xyz, vertex_unnamed_9.xyz);
				vertex_unnamed_194 = rsqrt(vertex_unnamed_194);
				vertex_unnamed_324 = vertex_unnamed_9.xyz * vertex_unnamed_194.xxx;
				vertex_unnamed_194 = dot(vertex_unnamed_80.xyw, vertex_unnamed_324);
				vertex_output_2.y = (abs(vertex_unnamed_194) * vertex_unnamed_116) + vertex_unnamed_63.x;
				vertex_output_3.w = vertex_unnamed_38.x;
				float3 vertex_unnamed_498 = vertex_input_1.yyy * unity_ObjectToWorld__array[1].yzx;
				vertex_unnamed_63 = float4(vertex_unnamed_498.x, vertex_unnamed_498.y, vertex_unnamed_498.z, vertex_unnamed_63.w);
				float3 vertex_unnamed_509 = (unity_ObjectToWorld__array[0].yzx * vertex_input_1.xxx) + vertex_unnamed_63.xyz;
				vertex_unnamed_63 = float4(vertex_unnamed_509.x, vertex_unnamed_509.y, vertex_unnamed_509.z, vertex_unnamed_63.w);
				float3 vertex_unnamed_520 = (unity_ObjectToWorld__array[2].yzx * vertex_input_1.zzz) + vertex_unnamed_63.xyz;
				vertex_unnamed_63 = float4(vertex_unnamed_520.x, vertex_unnamed_520.y, vertex_unnamed_520.z, vertex_unnamed_63.w);
				vertex_unnamed_116 = dot(vertex_unnamed_63.xyz, vertex_unnamed_63.xyz);
				vertex_unnamed_116 = rsqrt(vertex_unnamed_116);
				float3 vertex_unnamed_534 = vertex_unnamed_116.xxx * vertex_unnamed_63.xyz;
				vertex_unnamed_63 = float4(vertex_unnamed_534.x, vertex_unnamed_534.y, vertex_unnamed_534.z, vertex_unnamed_63.w);
				vertex_unnamed_537 = vertex_unnamed_63.xyz * vertex_unnamed_80.wxy;
				vertex_unnamed_537 = (vertex_unnamed_80.ywx * vertex_unnamed_63.yzx) + (-vertex_unnamed_537);
				vertex_unnamed_116 = vertex_input_1.w * unity_WorldTransformParams.w;
				vertex_unnamed_537 = vertex_unnamed_116.xxx * vertex_unnamed_537;
				vertex_output_3.y = vertex_unnamed_537.x;
				vertex_output_3.z = vertex_unnamed_80.x;
				vertex_output_3.x = vertex_unnamed_63.z;
				vertex_output_4.x = vertex_unnamed_63.x;
				vertex_output_5.x = vertex_unnamed_63.y;
				vertex_output_4.w = vertex_unnamed_38.y;
				vertex_output_5.w = vertex_unnamed_38.z;
				vertex_output_4.z = vertex_unnamed_80.y;
				vertex_output_4.y = vertex_unnamed_537.y;
				vertex_output_5.y = vertex_unnamed_537.z;
				vertex_output_5.z = vertex_unnamed_80.w;
				vertex_output_6 = vertex_input_5;
				float3 vertex_unnamed_605 = vertex_unnamed_9.yyy * _EnvMatrix__array[1].xyz;
				vertex_unnamed_38 = float4(vertex_unnamed_605.x, vertex_unnamed_605.y, vertex_unnamed_605.z, vertex_unnamed_38.w);
				float3 vertex_unnamed_616 = (_EnvMatrix__array[0].xyz * vertex_unnamed_9.xxx) + vertex_unnamed_38.xyz;
				vertex_unnamed_9 = float4(vertex_unnamed_616.x, vertex_unnamed_616.y, vertex_unnamed_9.z, vertex_unnamed_616.z);
				vertex_output_7 = (_EnvMatrix__array[2].xyz * vertex_unnamed_9.zzz) + vertex_unnamed_9.xyw;
				vertex_unnamed_9.x = vertex_unnamed_80.y * vertex_unnamed_80.y;
				vertex_unnamed_9.x = (vertex_unnamed_80.x * vertex_unnamed_80.x) + (-vertex_unnamed_9.x);
				vertex_unnamed_38 = vertex_unnamed_80.ywzx * vertex_unnamed_80;
				vertex_unnamed_63.x = dot(unity_SHBr, vertex_unnamed_38);
				vertex_unnamed_63.y = dot(unity_SHBg, vertex_unnamed_38);
				vertex_unnamed_63.z = dot(unity_SHBb, vertex_unnamed_38);
				vertex_output_8 = (unity_SHC.xyz * vertex_unnamed_9.xxx) + vertex_unnamed_63.xyz;
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

				_EnvMatrix__array[0] = float4(_EnvMatrix[0][0], _EnvMatrix[1][0], _EnvMatrix[2][0], _EnvMatrix[3][0]);
				_EnvMatrix__array[1] = float4(_EnvMatrix[0][1], _EnvMatrix[1][1], _EnvMatrix[2][1], _EnvMatrix[3][1]);
				_EnvMatrix__array[2] = float4(_EnvMatrix[0][2], _EnvMatrix[1][2], _EnvMatrix[2][2], _EnvMatrix[3][2]);
				_EnvMatrix__array[3] = float4(_EnvMatrix[0][3], _EnvMatrix[1][3], _EnvMatrix[2][3], _EnvMatrix[3][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_4 = stage_input.vertex_input_4;
				vertex_input_3 = stage_input.vertex_input_3;
				vertex_input_2 = stage_input.vertex_input_2;
				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_5 = stage_input.vertex_input_5;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_0 = vertex_output_0;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
				stage_output.vertex_output_6 = vertex_output_6;
				stage_output.vertex_output_7 = vertex_output_7;
				stage_output.vertex_output_8 = vertex_output_8;
				return stage_output;
			}

			float4 _Time;
			float3 _WorldSpaceCameraPos;
			float4 _WorldSpaceLightPos0;
			float4 unity_SHAr;
			float4 unity_SHAg;
			float4 unity_SHAb;
			float4x4 unity_ObjectToWorld;
			float4 _LightColor0;
			float4 _SpecColor;
			float _FaceUVSpeedX;
			float _FaceUVSpeedY;
			float4 _FaceColor;
			float _OutlineSoftness;
			float _OutlineUVSpeedX;
			float _OutlineUVSpeedY;
			float4 _OutlineColor;
			float _OutlineWidth;
			float _Bevel;
			float _BevelOffset;
			float _BevelWidth;
			float _BevelClamp;
			float _BevelRoundness;
			float _BumpOutline;
			float _BumpFace;
			float4 _ReflectFaceColor;
			float4 _ReflectOutlineColor;
			float _ShaderFlags;
			float _ScaleRatioA;
			float _TextureWidth;
			float _TextureHeight;
			float _GradientScale;
			float _FaceShininess;
			float _OutlineShininess;

			static float4 unity_ObjectToWorld__array[4];
			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;
			Texture2D<float4> _OutlineTex;
			SamplerState sampler_OutlineTex;
			Texture2D<float4> _FaceTex;
			SamplerState sampler_FaceTex;
			Texture2D<float4> _BumpMap;
			SamplerState sampler_BumpMap;
			TextureCube<float4> _Cube;
			SamplerState sampler_Cube;

			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_input_5;
			static float2 fragment_input_2;
			static float4 fragment_input_0;
			static float2 fragment_input_1;
			static float4 fragment_input_6;
			static float3 fragment_input_8;
			static float3 fragment_input_7;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_0 : TEXCOORD0; // vs_TEXCOORD0
				float2 fragment_input_1 : TEXCOORD1; // vs_TEXCOORD1
				float2 fragment_input_2 : TEXCOORD5; // vs_TEXCOORD5
				float4 fragment_input_3 : TEXCOORD2; // vs_TEXCOORD2
				float4 fragment_input_4 : TEXCOORD3; // vs_TEXCOORD3
				float4 fragment_input_5 : TEXCOORD4; // vs_TEXCOORD4
				float4 fragment_input_6 : UNKNOWN6;
				float3 fragment_input_7 : TEXCOORD6; // vs_TEXCOORD6
				float3 fragment_input_8 : TEXCOORD7; // vs_TEXCOORD7
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static float3 fragment_unnamed_9;
			static float fragment_unnamed_44;
			static float4 fragment_unnamed_80;
			static float4 fragment_unnamed_95;
			static float4 fragment_unnamed_108;
			static bool fragment_unnamed_210;
			static bool fragment_unnamed_235;
			static float fragment_unnamed_311;
			static float4 fragment_unnamed_432;
			static float fragment_unnamed_493;
			static float3 fragment_unnamed_690;
			static float3 fragment_unnamed_771;

			void frag_main()
			{
				fragment_unnamed_9.x = fragment_input_3.w;
				fragment_unnamed_9.y = fragment_input_4.w;
				fragment_unnamed_9.z = fragment_input_5.w;
				fragment_unnamed_9 = (-fragment_unnamed_9) + _WorldSpaceCameraPos;
				fragment_unnamed_44 = dot(fragment_unnamed_9, fragment_unnamed_9);
				fragment_unnamed_44 = rsqrt(fragment_unnamed_44);
				fragment_unnamed_9 = (fragment_unnamed_9 * fragment_unnamed_44.xxx) + _WorldSpaceLightPos0.xyz;
				fragment_unnamed_44 = dot(fragment_unnamed_9, fragment_unnamed_9);
				fragment_unnamed_44 = rsqrt(fragment_unnamed_44);
				fragment_unnamed_9 = fragment_unnamed_44.xxx * fragment_unnamed_9;
				fragment_unnamed_44 = fragment_input_2.x + _BevelOffset;
				float2 fragment_unnamed_90 = 1.0f.xx / float2(_TextureWidth, _TextureHeight);
				fragment_unnamed_80 = float4(fragment_unnamed_90.x, fragment_unnamed_90.y, fragment_unnamed_80.z, fragment_unnamed_80.w);
				fragment_unnamed_80.z = 0.0f;
				fragment_unnamed_95 = (-fragment_unnamed_80.xzzy) + fragment_input_0.xyxy;
				fragment_unnamed_80 = fragment_unnamed_80.xzzy + fragment_input_0.xyxy;
				fragment_unnamed_108.x = _MainTex.Sample(sampler_MainTex, fragment_unnamed_95.xy).w;
				fragment_unnamed_108.z = _MainTex.Sample(sampler_MainTex, fragment_unnamed_95.zw).w;
				fragment_unnamed_108.y = _MainTex.Sample(sampler_MainTex, fragment_unnamed_80.xy).w;
				fragment_unnamed_108.w = _MainTex.Sample(sampler_MainTex, fragment_unnamed_80.zw).w;
				fragment_unnamed_80 = fragment_unnamed_44.xxxx + fragment_unnamed_108;
				fragment_unnamed_80 += (-0.5f).xxxx;
				fragment_unnamed_44 = _BevelWidth + _OutlineWidth;
				fragment_unnamed_44 = max(fragment_unnamed_44, 0.00999999977648258209228515625f);
				fragment_unnamed_80 /= fragment_unnamed_44.xxxx;
				fragment_unnamed_44 *= _Bevel;
				fragment_unnamed_44 *= _GradientScale;
				fragment_unnamed_44 *= (-2.0f);
				fragment_unnamed_80 += 0.5f.xxxx;
				fragment_unnamed_80 = clamp(fragment_unnamed_80, 0.0f.xxxx, 1.0f.xxxx);
				fragment_unnamed_95 = (fragment_unnamed_80 * 2.0f.xxxx) + (-1.0f).xxxx;
				fragment_unnamed_95 = (-abs(fragment_unnamed_95)) + 1.0f.xxxx;
				fragment_unnamed_108.x = _ShaderFlags * 0.5f;
				fragment_unnamed_210 = fragment_unnamed_108.x >= (-fragment_unnamed_108.x);
				fragment_unnamed_108.x = frac(abs(fragment_unnamed_108.x));
				float fragment_unnamed_224;
				if (fragment_unnamed_210)
				{
					fragment_unnamed_224 = fragment_unnamed_108.x;
				}
				else
				{
					fragment_unnamed_224 = -fragment_unnamed_108.x;
				}
				fragment_unnamed_108.x = fragment_unnamed_224;
				fragment_unnamed_235 = fragment_unnamed_108.x >= 0.5f;
				bool4 fragment_unnamed_243 = fragment_unnamed_235.xxxx;
				fragment_unnamed_80 = float4(fragment_unnamed_243.x ? fragment_unnamed_95.x : fragment_unnamed_80.x, fragment_unnamed_243.y ? fragment_unnamed_95.y : fragment_unnamed_80.y, fragment_unnamed_243.z ? fragment_unnamed_95.z : fragment_unnamed_80.z, fragment_unnamed_243.w ? fragment_unnamed_95.w : fragment_unnamed_80.w);
				fragment_unnamed_95 = fragment_unnamed_80 * 1.57079601287841796875f.xxxx;
				fragment_unnamed_95 = sin(fragment_unnamed_95);
				fragment_unnamed_95 = (-fragment_unnamed_80) + fragment_unnamed_95;
				fragment_unnamed_80 = (float4(float4(_BevelRoundness, _BevelRoundness, _BevelRoundness, _BevelRoundness)) * fragment_unnamed_95) + fragment_unnamed_80;
				fragment_unnamed_95.x = (-_BevelClamp) + 1.0f;
				fragment_unnamed_80 = min(fragment_unnamed_80, fragment_unnamed_95.xxxx);
				float2 fragment_unnamed_288 = fragment_unnamed_44.xx * fragment_unnamed_80.xz;
				fragment_unnamed_80 = float4(fragment_unnamed_288.x, fragment_unnamed_80.y, fragment_unnamed_288.y, fragment_unnamed_80.w);
				float2 fragment_unnamed_299 = (fragment_unnamed_80.wy * fragment_unnamed_44.xx) + (-fragment_unnamed_80.zx);
				fragment_unnamed_80 = float4(fragment_unnamed_80.x, fragment_unnamed_299.x, fragment_unnamed_299.y, fragment_unnamed_80.w);
				fragment_unnamed_80.x = -1.0f;
				fragment_unnamed_80.w = 1.0f;
				fragment_unnamed_44 = dot(fragment_unnamed_80.xy, fragment_unnamed_80.xy);
				fragment_unnamed_44 = rsqrt(fragment_unnamed_44);
				fragment_unnamed_311 = dot(fragment_unnamed_80.zw, fragment_unnamed_80.zw);
				fragment_unnamed_311 = rsqrt(fragment_unnamed_311);
				fragment_unnamed_95.x = fragment_unnamed_311 * fragment_unnamed_80.z;
				float2 fragment_unnamed_327 = fragment_unnamed_311.xx * float2(1.0f, 0.0f);
				fragment_unnamed_95 = float4(fragment_unnamed_95.x, fragment_unnamed_327.x, fragment_unnamed_327.y, fragment_unnamed_95.w);
				fragment_unnamed_80.z = 0.0f;
				float3 fragment_unnamed_335 = fragment_unnamed_44.xxx * fragment_unnamed_80.xyz;
				fragment_unnamed_80 = float4(fragment_unnamed_335.x, fragment_unnamed_335.y, fragment_unnamed_335.z, fragment_unnamed_80.w);
				float3 fragment_unnamed_342 = fragment_unnamed_80.xyz * fragment_unnamed_95.xyz;
				fragment_unnamed_108 = float4(fragment_unnamed_342.x, fragment_unnamed_342.y, fragment_unnamed_342.z, fragment_unnamed_108.w);
				float3 fragment_unnamed_353 = (fragment_unnamed_95.zxy * fragment_unnamed_80.yzx) + (-fragment_unnamed_108.xyz);
				fragment_unnamed_80 = float4(fragment_unnamed_353.x, fragment_unnamed_353.y, fragment_unnamed_353.z, fragment_unnamed_80.w);
				float2 fragment_unnamed_370 = (float2(_OutlineUVSpeedX, _OutlineUVSpeedY) * _Time.yy) + fragment_input_1;
				fragment_unnamed_95 = float4(fragment_unnamed_370.x, fragment_unnamed_370.y, fragment_unnamed_95.z, fragment_unnamed_95.w);
				fragment_unnamed_95 = _OutlineTex.Sample(sampler_OutlineTex, fragment_unnamed_95.xy);
				float3 fragment_unnamed_387 = fragment_unnamed_95.xyz * _OutlineColor.xyz;
				fragment_unnamed_95 = float4(fragment_unnamed_387.x, fragment_unnamed_387.y, fragment_unnamed_387.z, fragment_unnamed_95.w);
				fragment_unnamed_44 = fragment_input_6.w * _OutlineColor.w;
				fragment_unnamed_108.w = fragment_unnamed_95.w * fragment_unnamed_44;
				float3 fragment_unnamed_405 = fragment_unnamed_95.xyz * fragment_unnamed_108.www;
				fragment_unnamed_108 = float4(fragment_unnamed_405.x, fragment_unnamed_405.y, fragment_unnamed_405.z, fragment_unnamed_108.w);
				float2 fragment_unnamed_421 = (float2(_FaceUVSpeedX, _FaceUVSpeedY) * _Time.yy) + fragment_input_0.zw;
				fragment_unnamed_95 = float4(fragment_unnamed_421.x, fragment_unnamed_421.y, fragment_unnamed_95.z, fragment_unnamed_95.w);
				fragment_unnamed_95 = _FaceTex.Sample(sampler_FaceTex, fragment_unnamed_95.xy);
				fragment_unnamed_432 = fragment_input_6 * _FaceColor;
				fragment_unnamed_95 *= fragment_unnamed_432;
				float3 fragment_unnamed_445 = fragment_unnamed_95.www * fragment_unnamed_95.xyz;
				fragment_unnamed_95 = float4(fragment_unnamed_445.x, fragment_unnamed_445.y, fragment_unnamed_445.z, fragment_unnamed_95.w);
				fragment_unnamed_108 = (-fragment_unnamed_95) + fragment_unnamed_108;
				fragment_unnamed_44 = _OutlineWidth * _ScaleRatioA;
				fragment_unnamed_44 *= fragment_input_2.y;
				fragment_unnamed_311 = min(fragment_unnamed_44, 1.0f);
				fragment_unnamed_311 = sqrt(fragment_unnamed_311);
				fragment_unnamed_432.x = _MainTex.Sample(sampler_MainTex, fragment_input_0.xy).w;
				fragment_unnamed_432.x = (-fragment_unnamed_432.x) + 0.5f;
				fragment_unnamed_432.x += (-fragment_input_2.x);
				fragment_unnamed_432.x = (fragment_unnamed_432.x * fragment_input_2.y) + 0.5f;
				fragment_unnamed_493 = (fragment_unnamed_44 * 0.5f) + fragment_unnamed_432.x;
				fragment_unnamed_493 = clamp(fragment_unnamed_493, 0.0f, 1.0f);
				fragment_unnamed_44 = ((-fragment_unnamed_44) * 0.5f) + fragment_unnamed_432.x;
				fragment_unnamed_311 *= fragment_unnamed_493;
				fragment_unnamed_95 = (fragment_unnamed_311.xxxx * fragment_unnamed_108) + fragment_unnamed_95;
				fragment_unnamed_311 = _OutlineSoftness * _ScaleRatioA;
				fragment_unnamed_108.x = fragment_unnamed_311 * fragment_input_2.y;
				fragment_unnamed_311 = (fragment_unnamed_311 * fragment_input_2.y) + 1.0f;
				fragment_unnamed_44 = (fragment_unnamed_108.x * 0.5f) + fragment_unnamed_44;
				fragment_unnamed_44 /= fragment_unnamed_311;
				fragment_unnamed_44 = clamp(fragment_unnamed_44, 0.0f, 1.0f);
				fragment_unnamed_44 = (-fragment_unnamed_44) + 1.0f;
				fragment_unnamed_95 = fragment_unnamed_44.xxxx * fragment_unnamed_95;
				fragment_unnamed_44 = (-_BumpFace) + _BumpOutline;
				fragment_unnamed_44 = (fragment_unnamed_493 * fragment_unnamed_44) + _BumpFace;
				float3 fragment_unnamed_571 = _BumpMap.Sample(sampler_BumpMap, fragment_input_0.zw).xyw;
				fragment_unnamed_108 = float4(fragment_unnamed_571.x, fragment_unnamed_571.y, fragment_unnamed_571.z, fragment_unnamed_108.w);
				fragment_unnamed_108.x = fragment_unnamed_108.z * fragment_unnamed_108.x;
				float2 fragment_unnamed_585 = (fragment_unnamed_108.xy * 2.0f.xx) + (-1.0f).xx;
				fragment_unnamed_108 = float4(fragment_unnamed_585.x, fragment_unnamed_585.y, fragment_unnamed_108.z, fragment_unnamed_108.w);
				fragment_unnamed_311 = dot(fragment_unnamed_108.xy, fragment_unnamed_108.xy);
				fragment_unnamed_311 = min(fragment_unnamed_311, 1.0f);
				fragment_unnamed_311 = (-fragment_unnamed_311) + 1.0f;
				fragment_unnamed_108.z = sqrt(fragment_unnamed_311);
				float3 fragment_unnamed_608 = (fragment_unnamed_108.xyz * fragment_unnamed_44.xxx) + float3(-0.0f, -0.0f, -1.0f);
				fragment_unnamed_108 = float4(fragment_unnamed_608.x, fragment_unnamed_608.y, fragment_unnamed_608.z, fragment_unnamed_108.w);
				float3 fragment_unnamed_617 = (fragment_unnamed_95.www * fragment_unnamed_108.xyz) + float3(0.0f, 0.0f, 1.0f);
				fragment_unnamed_108 = float4(fragment_unnamed_617.x, fragment_unnamed_617.y, fragment_unnamed_617.z, fragment_unnamed_108.w);
				float3 fragment_unnamed_625 = fragment_unnamed_80.xyz + (-fragment_unnamed_108.xyz);
				fragment_unnamed_80 = float4(fragment_unnamed_625.x, fragment_unnamed_625.y, fragment_unnamed_625.z, fragment_unnamed_80.w);
				fragment_unnamed_44 = dot(fragment_unnamed_80.xyz, fragment_unnamed_80.xyz);
				fragment_unnamed_44 = rsqrt(fragment_unnamed_44);
				float3 fragment_unnamed_639 = fragment_unnamed_44.xxx * fragment_unnamed_80.xyz;
				fragment_unnamed_80 = float4(fragment_unnamed_639.x, fragment_unnamed_639.y, fragment_unnamed_639.z, fragment_unnamed_80.w);
				fragment_unnamed_108.x = dot(fragment_input_3.xyz, -fragment_unnamed_80.xyz);
				fragment_unnamed_108.y = dot(fragment_input_4.xyz, -fragment_unnamed_80.xyz);
				fragment_unnamed_108.z = dot(fragment_input_5.xyz, -fragment_unnamed_80.xyz);
				fragment_unnamed_44 = dot(fragment_unnamed_108.xyz, fragment_unnamed_108.xyz);
				fragment_unnamed_44 = rsqrt(fragment_unnamed_44);
				float3 fragment_unnamed_674 = fragment_unnamed_44.xxx * fragment_unnamed_108.xyz;
				fragment_unnamed_108 = float4(fragment_unnamed_674.x, fragment_unnamed_674.y, fragment_unnamed_674.z, fragment_unnamed_108.w);
				fragment_unnamed_9.x = dot(fragment_unnamed_108.xyz, fragment_unnamed_9);
				fragment_unnamed_9.x = max(fragment_unnamed_9.x, 0.0f);
				fragment_unnamed_9.x = log2(fragment_unnamed_9.x);
				fragment_unnamed_690.x = (-_FaceShininess) + _OutlineShininess;
				fragment_unnamed_690.x = (fragment_unnamed_493 * fragment_unnamed_690.x) + _FaceShininess;
				fragment_unnamed_690.x *= 128.0f;
				fragment_unnamed_9.x *= fragment_unnamed_690.x;
				fragment_unnamed_9.x = exp2(fragment_unnamed_9.x);
				fragment_unnamed_690 = _LightColor0.xyz * _SpecColor.xyz;
				fragment_unnamed_9 = fragment_unnamed_9.xxx * fragment_unnamed_690;
				fragment_unnamed_44 = dot(fragment_unnamed_108.xyz, _WorldSpaceLightPos0.xyz);
				fragment_unnamed_44 = max(fragment_unnamed_44, 0.0f);
				fragment_unnamed_311 = max(fragment_unnamed_95.w, 9.9999997473787516355514526367188e-05f);
				float3 fragment_unnamed_752 = fragment_unnamed_95.xyz / fragment_unnamed_311.xxx;
				fragment_unnamed_95 = float4(fragment_unnamed_752.x, fragment_unnamed_752.y, fragment_unnamed_752.z, fragment_unnamed_95.w);
				float3 fragment_unnamed_760 = fragment_unnamed_95.xyz * _LightColor0.xyz;
				fragment_unnamed_432 = float4(fragment_unnamed_760.x, fragment_unnamed_432.y, fragment_unnamed_760.y, fragment_unnamed_760.z);
				fragment_unnamed_9 = (fragment_unnamed_432.xzw * fragment_unnamed_44.xxx) + fragment_unnamed_9;
				fragment_unnamed_108.w = 1.0f;
				fragment_unnamed_771.x = dot(unity_SHAr, fragment_unnamed_108);
				fragment_unnamed_771.y = dot(unity_SHAg, fragment_unnamed_108);
				fragment_unnamed_771.z = dot(unity_SHAb, fragment_unnamed_108);
				float3 fragment_unnamed_794 = fragment_unnamed_771 + fragment_input_8;
				fragment_unnamed_108 = float4(fragment_unnamed_794.x, fragment_unnamed_794.y, fragment_unnamed_794.z, fragment_unnamed_108.w);
				float3 fragment_unnamed_800 = max(fragment_unnamed_108.xyz, 0.0f.xxx);
				fragment_unnamed_108 = float4(fragment_unnamed_800.x, fragment_unnamed_800.y, fragment_unnamed_800.z, fragment_unnamed_108.w);
				float3 fragment_unnamed_805 = log2(fragment_unnamed_108.xyz);
				fragment_unnamed_108 = float4(fragment_unnamed_805.x, fragment_unnamed_805.y, fragment_unnamed_805.z, fragment_unnamed_108.w);
				float3 fragment_unnamed_812 = fragment_unnamed_108.xyz * 0.4166666567325592041015625f.xxx;
				fragment_unnamed_108 = float4(fragment_unnamed_812.x, fragment_unnamed_812.y, fragment_unnamed_812.z, fragment_unnamed_108.w);
				float3 fragment_unnamed_817 = exp2(fragment_unnamed_108.xyz);
				fragment_unnamed_108 = float4(fragment_unnamed_817.x, fragment_unnamed_817.y, fragment_unnamed_817.z, fragment_unnamed_108.w);
				float3 fragment_unnamed_827 = (fragment_unnamed_108.xyz * 1.05499994754791259765625f.xxx) + (-0.054999999701976776123046875f).xxx;
				fragment_unnamed_108 = float4(fragment_unnamed_827.x, fragment_unnamed_827.y, fragment_unnamed_827.z, fragment_unnamed_108.w);
				float3 fragment_unnamed_832 = max(fragment_unnamed_108.xyz, 0.0f.xxx);
				fragment_unnamed_108 = float4(fragment_unnamed_832.x, fragment_unnamed_832.y, fragment_unnamed_832.z, fragment_unnamed_108.w);
				fragment_unnamed_9 = (fragment_unnamed_95.xyz * fragment_unnamed_108.xyz) + fragment_unnamed_9;
				float3 fragment_unnamed_851 = (-_ReflectFaceColor.xyz) + _ReflectOutlineColor.xyz;
				fragment_unnamed_95 = float4(fragment_unnamed_851.x, fragment_unnamed_851.y, fragment_unnamed_851.z, fragment_unnamed_95.w);
				float3 fragment_unnamed_862 = (fragment_unnamed_493.xxx * fragment_unnamed_95.xyz) + _ReflectFaceColor.xyz;
				fragment_unnamed_95 = float4(fragment_unnamed_862.x, fragment_unnamed_862.y, fragment_unnamed_862.z, fragment_unnamed_95.w);
				float3 fragment_unnamed_871 = fragment_unnamed_80.yyy * unity_ObjectToWorld__array[1].xyz;
				fragment_unnamed_108 = float4(fragment_unnamed_871.x, fragment_unnamed_871.y, fragment_unnamed_871.z, fragment_unnamed_108.w);
				float3 fragment_unnamed_882 = (unity_ObjectToWorld__array[0].xyz * fragment_unnamed_80.xxx) + fragment_unnamed_108.xyz;
				fragment_unnamed_80 = float4(fragment_unnamed_882.x, fragment_unnamed_882.y, fragment_unnamed_80.z, fragment_unnamed_882.z);
				float3 fragment_unnamed_893 = (unity_ObjectToWorld__array[2].xyz * fragment_unnamed_80.zzz) + fragment_unnamed_80.xyw;
				fragment_unnamed_80 = float4(fragment_unnamed_893.x, fragment_unnamed_893.y, fragment_unnamed_893.z, fragment_unnamed_80.w);
				fragment_unnamed_44 = dot(fragment_input_7, fragment_unnamed_80.xyz);
				fragment_unnamed_44 += fragment_unnamed_44;
				float3 fragment_unnamed_911 = (fragment_unnamed_80.xyz * (-fragment_unnamed_44.xxx)) + fragment_input_7;
				fragment_unnamed_80 = float4(fragment_unnamed_911.x, fragment_unnamed_911.y, fragment_unnamed_911.z, fragment_unnamed_80.w);
				float3 fragment_unnamed_925 = _Cube.Sample(sampler_Cube, fragment_unnamed_80.xyz).xyz;
				fragment_unnamed_80 = float4(fragment_unnamed_925.x, fragment_unnamed_925.y, fragment_unnamed_925.z, fragment_unnamed_80.w);
				float3 fragment_unnamed_932 = fragment_unnamed_95.xyz * fragment_unnamed_80.xyz;
				fragment_unnamed_80 = float4(fragment_unnamed_932.x, fragment_unnamed_932.y, fragment_unnamed_932.z, fragment_unnamed_80.w);
				float3 fragment_unnamed_943 = (fragment_unnamed_80.xyz * fragment_unnamed_95.www) + fragment_unnamed_9;
				fragment_output_0 = float4(fragment_unnamed_943.x, fragment_unnamed_943.y, fragment_unnamed_943.z, fragment_output_0.w);
				fragment_output_0.w = fragment_unnamed_95.w;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				unity_ObjectToWorld__array[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				unity_ObjectToWorld__array[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				unity_ObjectToWorld__array[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				unity_ObjectToWorld__array[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_0 = stage_input.fragment_input_0;
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_6 = stage_input.fragment_input_6;
				fragment_input_8 = stage_input.fragment_input_8;
				fragment_input_7 = stage_input.fragment_input_7;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // DIRECTIONAL
			#endif // !LIGHTPROBE_SH
			#endif // !VERTEXLIGHT_ON


			#ifdef DIRECTIONAL
			#ifdef LIGHTPROBE_SH
			#ifndef VERTEXLIGHT_ON
			#define ANY_SHADER_VARIANT_ACTIVE

			float3 _WorldSpaceCameraPos;
			float4 _ScreenParams;
			float4 unity_SHBr;
			float4 unity_SHBg;
			float4 unity_SHBb;
			float4 unity_SHC;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4 unity_WorldTransformParams;
			float4x4 glstate_matrix_projection;
			float4x4 unity_MatrixVP;
			float _FaceDilate;
			float4x4 _EnvMatrix;
			float _WeightNormal;
			float _WeightBold;
			float _ScaleRatioA;
			float _VertexOffsetX;
			float _VertexOffsetY;
			float _GradientScale;
			float _ScaleX;
			float _ScaleY;
			float _PerspectiveFilter;
			float _Sharpness;
			float4 _MainTex_ST;
			float4 _FaceTex_ST;
			float4 _OutlineTex_ST;

			static float4 unity_ObjectToWorld__array[4];
			static float4 unity_WorldToObject__array[4];
			static float4 glstate_matrix_projection__array[4];
			static float4 unity_MatrixVP__array[4];
			static float4 _EnvMatrix__array[4];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_4;
			static float4 vertex_output_0;
			static float2 vertex_output_1;
			static float4 vertex_input_3;
			static float2 vertex_output_2;
			static float3 vertex_input_2;
			static float4 vertex_output_3;
			static float4 vertex_input_1;
			static float4 vertex_output_4;
			static float4 vertex_output_5;
			static float4 vertex_output_6;
			static float4 vertex_input_5;
			static float3 vertex_output_7;
			static float3 vertex_output_8;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION;
				float4 vertex_input_1 : TANGENT;
				float3 vertex_input_2 : NORMAL;
				float4 vertex_input_3 : TEXCOORD0;
				float4 vertex_input_4 : TEXCOORD1;
				float4 vertex_input_5 : COLOR;
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_0 : TEXCOORD0; // vs_TEXCOORD0
				float2 vertex_output_1 : TEXCOORD1; // vs_TEXCOORD1
				float2 vertex_output_2 : TEXCOORD5; // vs_TEXCOORD5
				float4 vertex_output_3 : TEXCOORD2; // vs_TEXCOORD2
				float4 vertex_output_4 : TEXCOORD3; // vs_TEXCOORD3
				float4 vertex_output_5 : TEXCOORD4; // vs_TEXCOORD4
				float4 vertex_output_6 : UNKNOWN6;
				float3 vertex_output_7 : TEXCOORD6; // vs_TEXCOORD6
				float3 vertex_output_8 : TEXCOORD7; // vs_TEXCOORD7
				float4 gl_Position : SV_Position;
			};

			static float4 vertex_unnamed_9;
			static float4 vertex_unnamed_38;
			static float4 vertex_unnamed_63;
			static float4 vertex_unnamed_80;
			static float vertex_unnamed_116;
			static bool vertex_unnamed_186;
			static float vertex_unnamed_194;
			static float3 vertex_unnamed_324;
			static int vertex_unnamed_394;
			static int vertex_unnamed_401;
			static float3 vertex_unnamed_537;

			void vert_main()
			{
				float2 vertex_unnamed_35 = vertex_input_0.xy + float2(_VertexOffsetX, _VertexOffsetY);
				vertex_unnamed_9 = float4(vertex_unnamed_35.x, vertex_unnamed_35.y, vertex_unnamed_9.z, vertex_unnamed_9.w);
				vertex_unnamed_38 = vertex_unnamed_9.yyyy * unity_ObjectToWorld__array[1];
				vertex_unnamed_38 = (unity_ObjectToWorld__array[0] * vertex_unnamed_9.xxxx) + vertex_unnamed_38;
				vertex_unnamed_38 = (unity_ObjectToWorld__array[2] * vertex_input_0.zzzz) + vertex_unnamed_38;
				vertex_unnamed_63 = vertex_unnamed_38 + unity_ObjectToWorld__array[3];
				float3 vertex_unnamed_77 = (unity_ObjectToWorld__array[3].xyz * vertex_input_0.www) + vertex_unnamed_38.xyz;
				vertex_unnamed_38 = float4(vertex_unnamed_77.x, vertex_unnamed_77.y, vertex_unnamed_77.z, vertex_unnamed_38.w);
				vertex_unnamed_80 = vertex_unnamed_63.yyyy * unity_MatrixVP__array[1];
				vertex_unnamed_80 = (unity_MatrixVP__array[0] * vertex_unnamed_63.xxxx) + vertex_unnamed_80;
				vertex_unnamed_80 = (unity_MatrixVP__array[2] * vertex_unnamed_63.zzzz) + vertex_unnamed_80;
				gl_Position = (unity_MatrixVP__array[3] * vertex_unnamed_63.wwww) + vertex_unnamed_80;
				vertex_unnamed_116 = vertex_input_4.x * 0.000244140625f;
				vertex_unnamed_80.x = floor(vertex_unnamed_116);
				vertex_unnamed_80.y = ((-vertex_unnamed_80.x) * 4096.0f) + vertex_input_4.x;
				float2 vertex_unnamed_140 = vertex_unnamed_80.xy * 0.001953125f.xx;
				vertex_unnamed_80 = float4(vertex_unnamed_140.x, vertex_unnamed_140.y, vertex_unnamed_80.z, vertex_unnamed_80.w);
				float2 vertex_unnamed_154 = (vertex_unnamed_80.xy * _FaceTex_ST.xy) + _FaceTex_ST.zw;
				vertex_output_0 = float4(vertex_output_0.x, vertex_output_0.y, vertex_unnamed_154.x, vertex_unnamed_154.y);
				vertex_output_1 = (vertex_unnamed_80.xy * _OutlineTex_ST.xy) + _OutlineTex_ST.zw;
				float2 vertex_unnamed_181 = (vertex_input_3.xy * _MainTex_ST.xy) + _MainTex_ST.zw;
				vertex_output_0 = float4(vertex_unnamed_181.x, vertex_unnamed_181.y, vertex_output_0.z, vertex_output_0.w);
				vertex_unnamed_186 = 0.0f >= vertex_input_4.y;
				vertex_unnamed_116 = float(vertex_unnamed_186);
				vertex_unnamed_194 = (-_WeightNormal) + _WeightBold;
				vertex_unnamed_116 = (vertex_unnamed_116 * vertex_unnamed_194) + _WeightNormal;
				vertex_unnamed_116 = (vertex_unnamed_116 * 0.25f) + _FaceDilate;
				vertex_unnamed_116 *= _ScaleRatioA;
				vertex_output_2.x = vertex_unnamed_116 * 0.5f;
				vertex_unnamed_116 = vertex_unnamed_63.y * unity_MatrixVP__array[1].w;
				vertex_unnamed_116 = (unity_MatrixVP__array[0].w * vertex_unnamed_63.x) + vertex_unnamed_116;
				vertex_unnamed_116 = (unity_MatrixVP__array[2].w * vertex_unnamed_63.z) + vertex_unnamed_116;
				vertex_unnamed_116 = (unity_MatrixVP__array[3].w * vertex_unnamed_63.w) + vertex_unnamed_116;
				float2 vertex_unnamed_262 = _ScreenParams.yy * glstate_matrix_projection__array[1].xy;
				vertex_unnamed_63 = float4(vertex_unnamed_262.x, vertex_unnamed_262.y, vertex_unnamed_63.z, vertex_unnamed_63.w);
				float2 vertex_unnamed_274 = (glstate_matrix_projection__array[0].xy * _ScreenParams.xx) + vertex_unnamed_63.xy;
				vertex_unnamed_63 = float4(vertex_unnamed_274.x, vertex_unnamed_274.y, vertex_unnamed_63.z, vertex_unnamed_63.w);
				float2 vertex_unnamed_286 = vertex_unnamed_63.xy * float2(_ScaleX, _ScaleY);
				vertex_unnamed_63 = float4(vertex_unnamed_286.x, vertex_unnamed_286.y, vertex_unnamed_63.z, vertex_unnamed_63.w);
				float2 vertex_unnamed_293 = vertex_unnamed_116.xx / vertex_unnamed_63.xy;
				vertex_unnamed_63 = float4(vertex_unnamed_293.x, vertex_unnamed_293.y, vertex_unnamed_63.z, vertex_unnamed_63.w);
				vertex_unnamed_116 = dot(vertex_unnamed_63.xy, vertex_unnamed_63.xy);
				vertex_unnamed_116 = rsqrt(vertex_unnamed_116);
				vertex_unnamed_194 = abs(vertex_input_4.y) * _GradientScale;
				vertex_unnamed_63.x = _Sharpness + 1.0f;
				vertex_unnamed_194 *= vertex_unnamed_63.x;
				vertex_unnamed_63.x = vertex_unnamed_116 * vertex_unnamed_194;
				vertex_unnamed_324.x = (-_PerspectiveFilter) + 1.0f;
				vertex_unnamed_63.x = vertex_unnamed_324.x * vertex_unnamed_63.x;
				vertex_unnamed_116 = (vertex_unnamed_116 * vertex_unnamed_194) + (-vertex_unnamed_63.x);
				vertex_unnamed_324 = _WorldSpaceCameraPos.yyy * unity_WorldToObject__array[1].xyz;
				vertex_unnamed_324 = (unity_WorldToObject__array[0].xyz * _WorldSpaceCameraPos.xxx) + vertex_unnamed_324;
				vertex_unnamed_324 = (unity_WorldToObject__array[2].xyz * _WorldSpaceCameraPos.zzz) + vertex_unnamed_324;
				vertex_unnamed_324 += unity_WorldToObject__array[3].xyz;
				vertex_unnamed_9.z = vertex_input_0.z;
				float3 vertex_unnamed_383 = (-vertex_unnamed_9.xyz) + vertex_unnamed_324;
				vertex_unnamed_9 = float4(vertex_unnamed_383.x, vertex_unnamed_383.y, vertex_unnamed_383.z, vertex_unnamed_9.w);
				vertex_unnamed_9.x = dot(vertex_input_2, vertex_unnamed_9.xyz);
				vertex_unnamed_394 = int((0.0f < vertex_unnamed_9.x) ? 4294967295u : 0u);
				vertex_unnamed_401 = int((vertex_unnamed_9.x < 0.0f) ? 4294967295u : 0u);
				vertex_unnamed_401 = (-vertex_unnamed_394) + vertex_unnamed_401;
				vertex_unnamed_9.x = float(vertex_unnamed_401);
				float3 vertex_unnamed_417 = vertex_unnamed_9.xxx * vertex_input_2;
				vertex_unnamed_9 = float4(vertex_unnamed_417.x, vertex_unnamed_417.y, vertex_unnamed_417.z, vertex_unnamed_9.w);
				vertex_unnamed_80.x = dot(vertex_unnamed_9.xyz, unity_WorldToObject__array[0].xyz);
				vertex_unnamed_80.y = dot(vertex_unnamed_9.xyz, unity_WorldToObject__array[1].xyz);
				vertex_unnamed_80.z = dot(vertex_unnamed_9.xyz, unity_WorldToObject__array[2].xyz);
				vertex_unnamed_9.x = dot(vertex_unnamed_80.xyz, vertex_unnamed_80.xyz);
				vertex_unnamed_9.x = rsqrt(vertex_unnamed_9.x);
				vertex_unnamed_80 = vertex_unnamed_9.xxxx * vertex_unnamed_80.xyzz;
				float3 vertex_unnamed_461 = (-vertex_unnamed_38.xyz) + _WorldSpaceCameraPos;
				vertex_unnamed_9 = float4(vertex_unnamed_461.x, vertex_unnamed_461.y, vertex_unnamed_461.z, vertex_unnamed_9.w);
				vertex_unnamed_194 = dot(vertex_unnamed_9.xyz, vertex_unnamed_9.xyz);
				vertex_unnamed_194 = rsqrt(vertex_unnamed_194);
				vertex_unnamed_324 = vertex_unnamed_9.xyz * vertex_unnamed_194.xxx;
				vertex_unnamed_194 = dot(vertex_unnamed_80.xyw, vertex_unnamed_324);
				vertex_output_2.y = (abs(vertex_unnamed_194) * vertex_unnamed_116) + vertex_unnamed_63.x;
				vertex_output_3.w = vertex_unnamed_38.x;
				float3 vertex_unnamed_498 = vertex_input_1.yyy * unity_ObjectToWorld__array[1].yzx;
				vertex_unnamed_63 = float4(vertex_unnamed_498.x, vertex_unnamed_498.y, vertex_unnamed_498.z, vertex_unnamed_63.w);
				float3 vertex_unnamed_509 = (unity_ObjectToWorld__array[0].yzx * vertex_input_1.xxx) + vertex_unnamed_63.xyz;
				vertex_unnamed_63 = float4(vertex_unnamed_509.x, vertex_unnamed_509.y, vertex_unnamed_509.z, vertex_unnamed_63.w);
				float3 vertex_unnamed_520 = (unity_ObjectToWorld__array[2].yzx * vertex_input_1.zzz) + vertex_unnamed_63.xyz;
				vertex_unnamed_63 = float4(vertex_unnamed_520.x, vertex_unnamed_520.y, vertex_unnamed_520.z, vertex_unnamed_63.w);
				vertex_unnamed_116 = dot(vertex_unnamed_63.xyz, vertex_unnamed_63.xyz);
				vertex_unnamed_116 = rsqrt(vertex_unnamed_116);
				float3 vertex_unnamed_534 = vertex_unnamed_116.xxx * vertex_unnamed_63.xyz;
				vertex_unnamed_63 = float4(vertex_unnamed_534.x, vertex_unnamed_534.y, vertex_unnamed_534.z, vertex_unnamed_63.w);
				vertex_unnamed_537 = vertex_unnamed_63.xyz * vertex_unnamed_80.wxy;
				vertex_unnamed_537 = (vertex_unnamed_80.ywx * vertex_unnamed_63.yzx) + (-vertex_unnamed_537);
				vertex_unnamed_116 = vertex_input_1.w * unity_WorldTransformParams.w;
				vertex_unnamed_537 = vertex_unnamed_116.xxx * vertex_unnamed_537;
				vertex_output_3.y = vertex_unnamed_537.x;
				vertex_output_3.z = vertex_unnamed_80.x;
				vertex_output_3.x = vertex_unnamed_63.z;
				vertex_output_4.x = vertex_unnamed_63.x;
				vertex_output_5.x = vertex_unnamed_63.y;
				vertex_output_4.w = vertex_unnamed_38.y;
				vertex_output_5.w = vertex_unnamed_38.z;
				vertex_output_4.z = vertex_unnamed_80.y;
				vertex_output_4.y = vertex_unnamed_537.y;
				vertex_output_5.y = vertex_unnamed_537.z;
				vertex_output_5.z = vertex_unnamed_80.w;
				vertex_output_6 = vertex_input_5;
				float3 vertex_unnamed_605 = vertex_unnamed_9.yyy * _EnvMatrix__array[1].xyz;
				vertex_unnamed_38 = float4(vertex_unnamed_605.x, vertex_unnamed_605.y, vertex_unnamed_605.z, vertex_unnamed_38.w);
				float3 vertex_unnamed_616 = (_EnvMatrix__array[0].xyz * vertex_unnamed_9.xxx) + vertex_unnamed_38.xyz;
				vertex_unnamed_9 = float4(vertex_unnamed_616.x, vertex_unnamed_616.y, vertex_unnamed_9.z, vertex_unnamed_616.z);
				vertex_output_7 = (_EnvMatrix__array[2].xyz * vertex_unnamed_9.zzz) + vertex_unnamed_9.xyw;
				vertex_unnamed_9.x = vertex_unnamed_80.y * vertex_unnamed_80.y;
				vertex_unnamed_9.x = (vertex_unnamed_80.x * vertex_unnamed_80.x) + (-vertex_unnamed_9.x);
				vertex_unnamed_38 = vertex_unnamed_80.ywzx * vertex_unnamed_80;
				vertex_unnamed_63.x = dot(unity_SHBr, vertex_unnamed_38);
				vertex_unnamed_63.y = dot(unity_SHBg, vertex_unnamed_38);
				vertex_unnamed_63.z = dot(unity_SHBb, vertex_unnamed_38);
				vertex_output_8 = (unity_SHC.xyz * vertex_unnamed_9.xxx) + vertex_unnamed_63.xyz;
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

				_EnvMatrix__array[0] = float4(_EnvMatrix[0][0], _EnvMatrix[1][0], _EnvMatrix[2][0], _EnvMatrix[3][0]);
				_EnvMatrix__array[1] = float4(_EnvMatrix[0][1], _EnvMatrix[1][1], _EnvMatrix[2][1], _EnvMatrix[3][1]);
				_EnvMatrix__array[2] = float4(_EnvMatrix[0][2], _EnvMatrix[1][2], _EnvMatrix[2][2], _EnvMatrix[3][2]);
				_EnvMatrix__array[3] = float4(_EnvMatrix[0][3], _EnvMatrix[1][3], _EnvMatrix[2][3], _EnvMatrix[3][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_4 = stage_input.vertex_input_4;
				vertex_input_3 = stage_input.vertex_input_3;
				vertex_input_2 = stage_input.vertex_input_2;
				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_5 = stage_input.vertex_input_5;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_0 = vertex_output_0;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
				stage_output.vertex_output_6 = vertex_output_6;
				stage_output.vertex_output_7 = vertex_output_7;
				stage_output.vertex_output_8 = vertex_output_8;
				return stage_output;
			}

			float4 _Time;
			float3 _WorldSpaceCameraPos;
			float4 _WorldSpaceLightPos0;
			float4 unity_SHAr;
			float4 unity_SHAg;
			float4 unity_SHAb;
			float4x4 unity_ObjectToWorld;
			float4 _LightColor0;
			float4 _SpecColor;
			float _FaceUVSpeedX;
			float _FaceUVSpeedY;
			float4 _FaceColor;
			float _OutlineSoftness;
			float _OutlineUVSpeedX;
			float _OutlineUVSpeedY;
			float4 _OutlineColor;
			float _OutlineWidth;
			float _Bevel;
			float _BevelOffset;
			float _BevelWidth;
			float _BevelClamp;
			float _BevelRoundness;
			float _BumpOutline;
			float _BumpFace;
			float4 _ReflectFaceColor;
			float4 _ReflectOutlineColor;
			float _ShaderFlags;
			float _ScaleRatioA;
			float _TextureWidth;
			float _TextureHeight;
			float _GradientScale;
			float _FaceShininess;
			float _OutlineShininess;

			static float4 unity_ObjectToWorld__array[4];
			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;
			Texture2D<float4> _OutlineTex;
			SamplerState sampler_OutlineTex;
			Texture2D<float4> _FaceTex;
			SamplerState sampler_FaceTex;
			Texture2D<float4> _BumpMap;
			SamplerState sampler_BumpMap;
			TextureCube<float4> _Cube;
			SamplerState sampler_Cube;

			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_input_5;
			static float2 fragment_input_2;
			static float4 fragment_input_0;
			static float2 fragment_input_1;
			static float4 fragment_input_6;
			static float3 fragment_input_8;
			static float3 fragment_input_7;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_0 : TEXCOORD0; // vs_TEXCOORD0
				float2 fragment_input_1 : TEXCOORD1; // vs_TEXCOORD1
				float2 fragment_input_2 : TEXCOORD5; // vs_TEXCOORD5
				float4 fragment_input_3 : TEXCOORD2; // vs_TEXCOORD2
				float4 fragment_input_4 : TEXCOORD3; // vs_TEXCOORD3
				float4 fragment_input_5 : TEXCOORD4; // vs_TEXCOORD4
				float4 fragment_input_6 : UNKNOWN6;
				float3 fragment_input_7 : TEXCOORD6; // vs_TEXCOORD6
				float3 fragment_input_8 : TEXCOORD7; // vs_TEXCOORD7
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static float3 fragment_unnamed_9;
			static float fragment_unnamed_44;
			static float4 fragment_unnamed_80;
			static float4 fragment_unnamed_95;
			static float4 fragment_unnamed_108;
			static bool fragment_unnamed_210;
			static bool fragment_unnamed_235;
			static float fragment_unnamed_311;
			static float4 fragment_unnamed_432;
			static float fragment_unnamed_493;
			static float3 fragment_unnamed_690;
			static float3 fragment_unnamed_771;

			void frag_main()
			{
				fragment_unnamed_9.x = fragment_input_3.w;
				fragment_unnamed_9.y = fragment_input_4.w;
				fragment_unnamed_9.z = fragment_input_5.w;
				fragment_unnamed_9 = (-fragment_unnamed_9) + _WorldSpaceCameraPos;
				fragment_unnamed_44 = dot(fragment_unnamed_9, fragment_unnamed_9);
				fragment_unnamed_44 = rsqrt(fragment_unnamed_44);
				fragment_unnamed_9 = (fragment_unnamed_9 * fragment_unnamed_44.xxx) + _WorldSpaceLightPos0.xyz;
				fragment_unnamed_44 = dot(fragment_unnamed_9, fragment_unnamed_9);
				fragment_unnamed_44 = rsqrt(fragment_unnamed_44);
				fragment_unnamed_9 = fragment_unnamed_44.xxx * fragment_unnamed_9;
				fragment_unnamed_44 = fragment_input_2.x + _BevelOffset;
				float2 fragment_unnamed_90 = 1.0f.xx / float2(_TextureWidth, _TextureHeight);
				fragment_unnamed_80 = float4(fragment_unnamed_90.x, fragment_unnamed_90.y, fragment_unnamed_80.z, fragment_unnamed_80.w);
				fragment_unnamed_80.z = 0.0f;
				fragment_unnamed_95 = (-fragment_unnamed_80.xzzy) + fragment_input_0.xyxy;
				fragment_unnamed_80 = fragment_unnamed_80.xzzy + fragment_input_0.xyxy;
				fragment_unnamed_108.x = _MainTex.Sample(sampler_MainTex, fragment_unnamed_95.xy).w;
				fragment_unnamed_108.z = _MainTex.Sample(sampler_MainTex, fragment_unnamed_95.zw).w;
				fragment_unnamed_108.y = _MainTex.Sample(sampler_MainTex, fragment_unnamed_80.xy).w;
				fragment_unnamed_108.w = _MainTex.Sample(sampler_MainTex, fragment_unnamed_80.zw).w;
				fragment_unnamed_80 = fragment_unnamed_44.xxxx + fragment_unnamed_108;
				fragment_unnamed_80 += (-0.5f).xxxx;
				fragment_unnamed_44 = _BevelWidth + _OutlineWidth;
				fragment_unnamed_44 = max(fragment_unnamed_44, 0.00999999977648258209228515625f);
				fragment_unnamed_80 /= fragment_unnamed_44.xxxx;
				fragment_unnamed_44 *= _Bevel;
				fragment_unnamed_44 *= _GradientScale;
				fragment_unnamed_44 *= (-2.0f);
				fragment_unnamed_80 += 0.5f.xxxx;
				fragment_unnamed_80 = clamp(fragment_unnamed_80, 0.0f.xxxx, 1.0f.xxxx);
				fragment_unnamed_95 = (fragment_unnamed_80 * 2.0f.xxxx) + (-1.0f).xxxx;
				fragment_unnamed_95 = (-abs(fragment_unnamed_95)) + 1.0f.xxxx;
				fragment_unnamed_108.x = _ShaderFlags * 0.5f;
				fragment_unnamed_210 = fragment_unnamed_108.x >= (-fragment_unnamed_108.x);
				fragment_unnamed_108.x = frac(abs(fragment_unnamed_108.x));
				float fragment_unnamed_224;
				if (fragment_unnamed_210)
				{
					fragment_unnamed_224 = fragment_unnamed_108.x;
				}
				else
				{
					fragment_unnamed_224 = -fragment_unnamed_108.x;
				}
				fragment_unnamed_108.x = fragment_unnamed_224;
				fragment_unnamed_235 = fragment_unnamed_108.x >= 0.5f;
				bool4 fragment_unnamed_243 = fragment_unnamed_235.xxxx;
				fragment_unnamed_80 = float4(fragment_unnamed_243.x ? fragment_unnamed_95.x : fragment_unnamed_80.x, fragment_unnamed_243.y ? fragment_unnamed_95.y : fragment_unnamed_80.y, fragment_unnamed_243.z ? fragment_unnamed_95.z : fragment_unnamed_80.z, fragment_unnamed_243.w ? fragment_unnamed_95.w : fragment_unnamed_80.w);
				fragment_unnamed_95 = fragment_unnamed_80 * 1.57079601287841796875f.xxxx;
				fragment_unnamed_95 = sin(fragment_unnamed_95);
				fragment_unnamed_95 = (-fragment_unnamed_80) + fragment_unnamed_95;
				fragment_unnamed_80 = (float4(float4(_BevelRoundness, _BevelRoundness, _BevelRoundness, _BevelRoundness)) * fragment_unnamed_95) + fragment_unnamed_80;
				fragment_unnamed_95.x = (-_BevelClamp) + 1.0f;
				fragment_unnamed_80 = min(fragment_unnamed_80, fragment_unnamed_95.xxxx);
				float2 fragment_unnamed_288 = fragment_unnamed_44.xx * fragment_unnamed_80.xz;
				fragment_unnamed_80 = float4(fragment_unnamed_288.x, fragment_unnamed_80.y, fragment_unnamed_288.y, fragment_unnamed_80.w);
				float2 fragment_unnamed_299 = (fragment_unnamed_80.wy * fragment_unnamed_44.xx) + (-fragment_unnamed_80.zx);
				fragment_unnamed_80 = float4(fragment_unnamed_80.x, fragment_unnamed_299.x, fragment_unnamed_299.y, fragment_unnamed_80.w);
				fragment_unnamed_80.x = -1.0f;
				fragment_unnamed_80.w = 1.0f;
				fragment_unnamed_44 = dot(fragment_unnamed_80.xy, fragment_unnamed_80.xy);
				fragment_unnamed_44 = rsqrt(fragment_unnamed_44);
				fragment_unnamed_311 = dot(fragment_unnamed_80.zw, fragment_unnamed_80.zw);
				fragment_unnamed_311 = rsqrt(fragment_unnamed_311);
				fragment_unnamed_95.x = fragment_unnamed_311 * fragment_unnamed_80.z;
				float2 fragment_unnamed_327 = fragment_unnamed_311.xx * float2(1.0f, 0.0f);
				fragment_unnamed_95 = float4(fragment_unnamed_95.x, fragment_unnamed_327.x, fragment_unnamed_327.y, fragment_unnamed_95.w);
				fragment_unnamed_80.z = 0.0f;
				float3 fragment_unnamed_335 = fragment_unnamed_44.xxx * fragment_unnamed_80.xyz;
				fragment_unnamed_80 = float4(fragment_unnamed_335.x, fragment_unnamed_335.y, fragment_unnamed_335.z, fragment_unnamed_80.w);
				float3 fragment_unnamed_342 = fragment_unnamed_80.xyz * fragment_unnamed_95.xyz;
				fragment_unnamed_108 = float4(fragment_unnamed_342.x, fragment_unnamed_342.y, fragment_unnamed_342.z, fragment_unnamed_108.w);
				float3 fragment_unnamed_353 = (fragment_unnamed_95.zxy * fragment_unnamed_80.yzx) + (-fragment_unnamed_108.xyz);
				fragment_unnamed_80 = float4(fragment_unnamed_353.x, fragment_unnamed_353.y, fragment_unnamed_353.z, fragment_unnamed_80.w);
				float2 fragment_unnamed_370 = (float2(_OutlineUVSpeedX, _OutlineUVSpeedY) * _Time.yy) + fragment_input_1;
				fragment_unnamed_95 = float4(fragment_unnamed_370.x, fragment_unnamed_370.y, fragment_unnamed_95.z, fragment_unnamed_95.w);
				fragment_unnamed_95 = _OutlineTex.Sample(sampler_OutlineTex, fragment_unnamed_95.xy);
				float3 fragment_unnamed_387 = fragment_unnamed_95.xyz * _OutlineColor.xyz;
				fragment_unnamed_95 = float4(fragment_unnamed_387.x, fragment_unnamed_387.y, fragment_unnamed_387.z, fragment_unnamed_95.w);
				fragment_unnamed_44 = fragment_input_6.w * _OutlineColor.w;
				fragment_unnamed_108.w = fragment_unnamed_95.w * fragment_unnamed_44;
				float3 fragment_unnamed_405 = fragment_unnamed_95.xyz * fragment_unnamed_108.www;
				fragment_unnamed_108 = float4(fragment_unnamed_405.x, fragment_unnamed_405.y, fragment_unnamed_405.z, fragment_unnamed_108.w);
				float2 fragment_unnamed_421 = (float2(_FaceUVSpeedX, _FaceUVSpeedY) * _Time.yy) + fragment_input_0.zw;
				fragment_unnamed_95 = float4(fragment_unnamed_421.x, fragment_unnamed_421.y, fragment_unnamed_95.z, fragment_unnamed_95.w);
				fragment_unnamed_95 = _FaceTex.Sample(sampler_FaceTex, fragment_unnamed_95.xy);
				fragment_unnamed_432 = fragment_input_6 * _FaceColor;
				fragment_unnamed_95 *= fragment_unnamed_432;
				float3 fragment_unnamed_445 = fragment_unnamed_95.www * fragment_unnamed_95.xyz;
				fragment_unnamed_95 = float4(fragment_unnamed_445.x, fragment_unnamed_445.y, fragment_unnamed_445.z, fragment_unnamed_95.w);
				fragment_unnamed_108 = (-fragment_unnamed_95) + fragment_unnamed_108;
				fragment_unnamed_44 = _OutlineWidth * _ScaleRatioA;
				fragment_unnamed_44 *= fragment_input_2.y;
				fragment_unnamed_311 = min(fragment_unnamed_44, 1.0f);
				fragment_unnamed_311 = sqrt(fragment_unnamed_311);
				fragment_unnamed_432.x = _MainTex.Sample(sampler_MainTex, fragment_input_0.xy).w;
				fragment_unnamed_432.x = (-fragment_unnamed_432.x) + 0.5f;
				fragment_unnamed_432.x += (-fragment_input_2.x);
				fragment_unnamed_432.x = (fragment_unnamed_432.x * fragment_input_2.y) + 0.5f;
				fragment_unnamed_493 = (fragment_unnamed_44 * 0.5f) + fragment_unnamed_432.x;
				fragment_unnamed_493 = clamp(fragment_unnamed_493, 0.0f, 1.0f);
				fragment_unnamed_44 = ((-fragment_unnamed_44) * 0.5f) + fragment_unnamed_432.x;
				fragment_unnamed_311 *= fragment_unnamed_493;
				fragment_unnamed_95 = (fragment_unnamed_311.xxxx * fragment_unnamed_108) + fragment_unnamed_95;
				fragment_unnamed_311 = _OutlineSoftness * _ScaleRatioA;
				fragment_unnamed_108.x = fragment_unnamed_311 * fragment_input_2.y;
				fragment_unnamed_311 = (fragment_unnamed_311 * fragment_input_2.y) + 1.0f;
				fragment_unnamed_44 = (fragment_unnamed_108.x * 0.5f) + fragment_unnamed_44;
				fragment_unnamed_44 /= fragment_unnamed_311;
				fragment_unnamed_44 = clamp(fragment_unnamed_44, 0.0f, 1.0f);
				fragment_unnamed_44 = (-fragment_unnamed_44) + 1.0f;
				fragment_unnamed_95 = fragment_unnamed_44.xxxx * fragment_unnamed_95;
				fragment_unnamed_44 = (-_BumpFace) + _BumpOutline;
				fragment_unnamed_44 = (fragment_unnamed_493 * fragment_unnamed_44) + _BumpFace;
				float3 fragment_unnamed_571 = _BumpMap.Sample(sampler_BumpMap, fragment_input_0.zw).xyw;
				fragment_unnamed_108 = float4(fragment_unnamed_571.x, fragment_unnamed_571.y, fragment_unnamed_571.z, fragment_unnamed_108.w);
				fragment_unnamed_108.x = fragment_unnamed_108.z * fragment_unnamed_108.x;
				float2 fragment_unnamed_585 = (fragment_unnamed_108.xy * 2.0f.xx) + (-1.0f).xx;
				fragment_unnamed_108 = float4(fragment_unnamed_585.x, fragment_unnamed_585.y, fragment_unnamed_108.z, fragment_unnamed_108.w);
				fragment_unnamed_311 = dot(fragment_unnamed_108.xy, fragment_unnamed_108.xy);
				fragment_unnamed_311 = min(fragment_unnamed_311, 1.0f);
				fragment_unnamed_311 = (-fragment_unnamed_311) + 1.0f;
				fragment_unnamed_108.z = sqrt(fragment_unnamed_311);
				float3 fragment_unnamed_608 = (fragment_unnamed_108.xyz * fragment_unnamed_44.xxx) + float3(-0.0f, -0.0f, -1.0f);
				fragment_unnamed_108 = float4(fragment_unnamed_608.x, fragment_unnamed_608.y, fragment_unnamed_608.z, fragment_unnamed_108.w);
				float3 fragment_unnamed_617 = (fragment_unnamed_95.www * fragment_unnamed_108.xyz) + float3(0.0f, 0.0f, 1.0f);
				fragment_unnamed_108 = float4(fragment_unnamed_617.x, fragment_unnamed_617.y, fragment_unnamed_617.z, fragment_unnamed_108.w);
				float3 fragment_unnamed_625 = fragment_unnamed_80.xyz + (-fragment_unnamed_108.xyz);
				fragment_unnamed_80 = float4(fragment_unnamed_625.x, fragment_unnamed_625.y, fragment_unnamed_625.z, fragment_unnamed_80.w);
				fragment_unnamed_44 = dot(fragment_unnamed_80.xyz, fragment_unnamed_80.xyz);
				fragment_unnamed_44 = rsqrt(fragment_unnamed_44);
				float3 fragment_unnamed_639 = fragment_unnamed_44.xxx * fragment_unnamed_80.xyz;
				fragment_unnamed_80 = float4(fragment_unnamed_639.x, fragment_unnamed_639.y, fragment_unnamed_639.z, fragment_unnamed_80.w);
				fragment_unnamed_108.x = dot(fragment_input_3.xyz, -fragment_unnamed_80.xyz);
				fragment_unnamed_108.y = dot(fragment_input_4.xyz, -fragment_unnamed_80.xyz);
				fragment_unnamed_108.z = dot(fragment_input_5.xyz, -fragment_unnamed_80.xyz);
				fragment_unnamed_44 = dot(fragment_unnamed_108.xyz, fragment_unnamed_108.xyz);
				fragment_unnamed_44 = rsqrt(fragment_unnamed_44);
				float3 fragment_unnamed_674 = fragment_unnamed_44.xxx * fragment_unnamed_108.xyz;
				fragment_unnamed_108 = float4(fragment_unnamed_674.x, fragment_unnamed_674.y, fragment_unnamed_674.z, fragment_unnamed_108.w);
				fragment_unnamed_9.x = dot(fragment_unnamed_108.xyz, fragment_unnamed_9);
				fragment_unnamed_9.x = max(fragment_unnamed_9.x, 0.0f);
				fragment_unnamed_9.x = log2(fragment_unnamed_9.x);
				fragment_unnamed_690.x = (-_FaceShininess) + _OutlineShininess;
				fragment_unnamed_690.x = (fragment_unnamed_493 * fragment_unnamed_690.x) + _FaceShininess;
				fragment_unnamed_690.x *= 128.0f;
				fragment_unnamed_9.x *= fragment_unnamed_690.x;
				fragment_unnamed_9.x = exp2(fragment_unnamed_9.x);
				fragment_unnamed_690 = _LightColor0.xyz * _SpecColor.xyz;
				fragment_unnamed_9 = fragment_unnamed_9.xxx * fragment_unnamed_690;
				fragment_unnamed_44 = dot(fragment_unnamed_108.xyz, _WorldSpaceLightPos0.xyz);
				fragment_unnamed_44 = max(fragment_unnamed_44, 0.0f);
				fragment_unnamed_311 = max(fragment_unnamed_95.w, 9.9999997473787516355514526367188e-05f);
				float3 fragment_unnamed_752 = fragment_unnamed_95.xyz / fragment_unnamed_311.xxx;
				fragment_unnamed_95 = float4(fragment_unnamed_752.x, fragment_unnamed_752.y, fragment_unnamed_752.z, fragment_unnamed_95.w);
				float3 fragment_unnamed_760 = fragment_unnamed_95.xyz * _LightColor0.xyz;
				fragment_unnamed_432 = float4(fragment_unnamed_760.x, fragment_unnamed_432.y, fragment_unnamed_760.y, fragment_unnamed_760.z);
				fragment_unnamed_9 = (fragment_unnamed_432.xzw * fragment_unnamed_44.xxx) + fragment_unnamed_9;
				fragment_unnamed_108.w = 1.0f;
				fragment_unnamed_771.x = dot(unity_SHAr, fragment_unnamed_108);
				fragment_unnamed_771.y = dot(unity_SHAg, fragment_unnamed_108);
				fragment_unnamed_771.z = dot(unity_SHAb, fragment_unnamed_108);
				float3 fragment_unnamed_794 = fragment_unnamed_771 + fragment_input_8;
				fragment_unnamed_108 = float4(fragment_unnamed_794.x, fragment_unnamed_794.y, fragment_unnamed_794.z, fragment_unnamed_108.w);
				float3 fragment_unnamed_800 = max(fragment_unnamed_108.xyz, 0.0f.xxx);
				fragment_unnamed_108 = float4(fragment_unnamed_800.x, fragment_unnamed_800.y, fragment_unnamed_800.z, fragment_unnamed_108.w);
				float3 fragment_unnamed_805 = log2(fragment_unnamed_108.xyz);
				fragment_unnamed_108 = float4(fragment_unnamed_805.x, fragment_unnamed_805.y, fragment_unnamed_805.z, fragment_unnamed_108.w);
				float3 fragment_unnamed_812 = fragment_unnamed_108.xyz * 0.4166666567325592041015625f.xxx;
				fragment_unnamed_108 = float4(fragment_unnamed_812.x, fragment_unnamed_812.y, fragment_unnamed_812.z, fragment_unnamed_108.w);
				float3 fragment_unnamed_817 = exp2(fragment_unnamed_108.xyz);
				fragment_unnamed_108 = float4(fragment_unnamed_817.x, fragment_unnamed_817.y, fragment_unnamed_817.z, fragment_unnamed_108.w);
				float3 fragment_unnamed_827 = (fragment_unnamed_108.xyz * 1.05499994754791259765625f.xxx) + (-0.054999999701976776123046875f).xxx;
				fragment_unnamed_108 = float4(fragment_unnamed_827.x, fragment_unnamed_827.y, fragment_unnamed_827.z, fragment_unnamed_108.w);
				float3 fragment_unnamed_832 = max(fragment_unnamed_108.xyz, 0.0f.xxx);
				fragment_unnamed_108 = float4(fragment_unnamed_832.x, fragment_unnamed_832.y, fragment_unnamed_832.z, fragment_unnamed_108.w);
				fragment_unnamed_9 = (fragment_unnamed_95.xyz * fragment_unnamed_108.xyz) + fragment_unnamed_9;
				float3 fragment_unnamed_851 = (-_ReflectFaceColor.xyz) + _ReflectOutlineColor.xyz;
				fragment_unnamed_95 = float4(fragment_unnamed_851.x, fragment_unnamed_851.y, fragment_unnamed_851.z, fragment_unnamed_95.w);
				float3 fragment_unnamed_862 = (fragment_unnamed_493.xxx * fragment_unnamed_95.xyz) + _ReflectFaceColor.xyz;
				fragment_unnamed_95 = float4(fragment_unnamed_862.x, fragment_unnamed_862.y, fragment_unnamed_862.z, fragment_unnamed_95.w);
				float3 fragment_unnamed_871 = fragment_unnamed_80.yyy * unity_ObjectToWorld__array[1].xyz;
				fragment_unnamed_108 = float4(fragment_unnamed_871.x, fragment_unnamed_871.y, fragment_unnamed_871.z, fragment_unnamed_108.w);
				float3 fragment_unnamed_882 = (unity_ObjectToWorld__array[0].xyz * fragment_unnamed_80.xxx) + fragment_unnamed_108.xyz;
				fragment_unnamed_80 = float4(fragment_unnamed_882.x, fragment_unnamed_882.y, fragment_unnamed_80.z, fragment_unnamed_882.z);
				float3 fragment_unnamed_893 = (unity_ObjectToWorld__array[2].xyz * fragment_unnamed_80.zzz) + fragment_unnamed_80.xyw;
				fragment_unnamed_80 = float4(fragment_unnamed_893.x, fragment_unnamed_893.y, fragment_unnamed_893.z, fragment_unnamed_80.w);
				fragment_unnamed_44 = dot(fragment_input_7, fragment_unnamed_80.xyz);
				fragment_unnamed_44 += fragment_unnamed_44;
				float3 fragment_unnamed_911 = (fragment_unnamed_80.xyz * (-fragment_unnamed_44.xxx)) + fragment_input_7;
				fragment_unnamed_80 = float4(fragment_unnamed_911.x, fragment_unnamed_911.y, fragment_unnamed_911.z, fragment_unnamed_80.w);
				float3 fragment_unnamed_925 = _Cube.Sample(sampler_Cube, fragment_unnamed_80.xyz).xyz;
				fragment_unnamed_80 = float4(fragment_unnamed_925.x, fragment_unnamed_925.y, fragment_unnamed_925.z, fragment_unnamed_80.w);
				float3 fragment_unnamed_932 = fragment_unnamed_95.xyz * fragment_unnamed_80.xyz;
				fragment_unnamed_80 = float4(fragment_unnamed_932.x, fragment_unnamed_932.y, fragment_unnamed_932.z, fragment_unnamed_80.w);
				float3 fragment_unnamed_943 = (fragment_unnamed_80.xyz * fragment_unnamed_95.www) + fragment_unnamed_9;
				fragment_output_0 = float4(fragment_unnamed_943.x, fragment_unnamed_943.y, fragment_unnamed_943.z, fragment_output_0.w);
				fragment_output_0.w = fragment_unnamed_95.w;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				unity_ObjectToWorld__array[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				unity_ObjectToWorld__array[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				unity_ObjectToWorld__array[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				unity_ObjectToWorld__array[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_0 = stage_input.fragment_input_0;
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_6 = stage_input.fragment_input_6;
				fragment_input_8 = stage_input.fragment_input_8;
				fragment_input_7 = stage_input.fragment_input_7;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // DIRECTIONAL
			#endif // LIGHTPROBE_SH
			#endif // !VERTEXLIGHT_ON


			#ifdef DIRECTIONAL
			#ifdef LIGHTPROBE_SH
			#ifdef VERTEXLIGHT_ON
			#define ANY_SHADER_VARIANT_ACTIVE

			float3 _WorldSpaceCameraPos;
			float4 _ScreenParams;
			float4 unity_4LightPosX0;
			float4 unity_4LightPosY0;
			float4 unity_4LightPosZ0;
			float4 unity_4LightAtten0;
			float4 unity_LightColor[4];
			float4 unity_SHBr;
			float4 unity_SHBg;
			float4 unity_SHBb;
			float4 unity_SHC;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4 unity_WorldTransformParams;
			float4x4 glstate_matrix_projection;
			float4x4 unity_MatrixVP;
			float _FaceDilate;
			float4x4 _EnvMatrix;
			float _WeightNormal;
			float _WeightBold;
			float _ScaleRatioA;
			float _VertexOffsetX;
			float _VertexOffsetY;
			float _GradientScale;
			float _ScaleX;
			float _ScaleY;
			float _PerspectiveFilter;
			float _Sharpness;
			float4 _MainTex_ST;
			float4 _FaceTex_ST;
			float4 _OutlineTex_ST;

			static float4 unity_ObjectToWorld__array[4];
			static float4 unity_WorldToObject__array[4];
			static float4 glstate_matrix_projection__array[4];
			static float4 unity_MatrixVP__array[4];
			static float4 _EnvMatrix__array[4];
			cbuffer t213fc0ea90d849309700aa9915d67e58
			{
				float4 unity_LightColor[8];
			};

			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_4;
			static float4 vertex_output_0;
			static float2 vertex_output_1;
			static float4 vertex_input_3;
			static float2 vertex_output_2;
			static float3 vertex_input_2;
			static float4 vertex_input_1;
			static float4 vertex_output_3;
			static float4 vertex_output_4;
			static float4 vertex_output_5;
			static float4 vertex_output_6;
			static float4 vertex_input_5;
			static float3 vertex_output_7;
			static float3 vertex_output_8;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION;
				float4 vertex_input_1 : TANGENT;
				float3 vertex_input_2 : NORMAL;
				float4 vertex_input_3 : TEXCOORD0;
				float4 vertex_input_4 : TEXCOORD1;
				float4 vertex_input_5 : COLOR;
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_0 : TEXCOORD0; // vs_TEXCOORD0
				float2 vertex_output_1 : TEXCOORD1; // vs_TEXCOORD1
				float2 vertex_output_2 : TEXCOORD5; // vs_TEXCOORD5
				float4 vertex_output_3 : TEXCOORD2; // vs_TEXCOORD2
				float4 vertex_output_4 : TEXCOORD3; // vs_TEXCOORD3
				float4 vertex_output_5 : TEXCOORD4; // vs_TEXCOORD4
				float4 vertex_output_6 : UNKNOWN6;
				float3 vertex_output_7 : TEXCOORD6; // vs_TEXCOORD6
				float3 vertex_output_8 : TEXCOORD7; // vs_TEXCOORD7
				float4 gl_Position : SV_Position;
			};

			static float4 vertex_unnamed_9;
			static float4 vertex_unnamed_40;
			static float4 vertex_unnamed_65;
			static float4 vertex_unnamed_82;
			static float vertex_unnamed_118;
			static bool vertex_unnamed_188;
			static float vertex_unnamed_196;
			static float3 vertex_unnamed_326;
			static int vertex_unnamed_396;
			static int vertex_unnamed_403;
			static float4 vertex_unnamed_535;

			void vert_main()
			{
				float2 vertex_unnamed_37 = vertex_input_0.xy + float2(_VertexOffsetX, _VertexOffsetY);
				vertex_unnamed_9 = float4(vertex_unnamed_37.x, vertex_unnamed_37.y, vertex_unnamed_9.z, vertex_unnamed_9.w);
				vertex_unnamed_40 = vertex_unnamed_9.yyyy * unity_ObjectToWorld__array[1];
				vertex_unnamed_40 = (unity_ObjectToWorld__array[0] * vertex_unnamed_9.xxxx) + vertex_unnamed_40;
				vertex_unnamed_40 = (unity_ObjectToWorld__array[2] * vertex_input_0.zzzz) + vertex_unnamed_40;
				vertex_unnamed_65 = vertex_unnamed_40 + unity_ObjectToWorld__array[3];
				float3 vertex_unnamed_79 = (unity_ObjectToWorld__array[3].xyz * vertex_input_0.www) + vertex_unnamed_40.xyz;
				vertex_unnamed_40 = float4(vertex_unnamed_79.x, vertex_unnamed_79.y, vertex_unnamed_79.z, vertex_unnamed_40.w);
				vertex_unnamed_82 = vertex_unnamed_65.yyyy * unity_MatrixVP__array[1];
				vertex_unnamed_82 = (unity_MatrixVP__array[0] * vertex_unnamed_65.xxxx) + vertex_unnamed_82;
				vertex_unnamed_82 = (unity_MatrixVP__array[2] * vertex_unnamed_65.zzzz) + vertex_unnamed_82;
				gl_Position = (unity_MatrixVP__array[3] * vertex_unnamed_65.wwww) + vertex_unnamed_82;
				vertex_unnamed_118 = vertex_input_4.x * 0.000244140625f;
				vertex_unnamed_82.x = floor(vertex_unnamed_118);
				vertex_unnamed_82.y = ((-vertex_unnamed_82.x) * 4096.0f) + vertex_input_4.x;
				float2 vertex_unnamed_142 = vertex_unnamed_82.xy * 0.001953125f.xx;
				vertex_unnamed_82 = float4(vertex_unnamed_142.x, vertex_unnamed_142.y, vertex_unnamed_82.z, vertex_unnamed_82.w);
				float2 vertex_unnamed_156 = (vertex_unnamed_82.xy * _FaceTex_ST.xy) + _FaceTex_ST.zw;
				vertex_output_0 = float4(vertex_output_0.x, vertex_output_0.y, vertex_unnamed_156.x, vertex_unnamed_156.y);
				vertex_output_1 = (vertex_unnamed_82.xy * _OutlineTex_ST.xy) + _OutlineTex_ST.zw;
				float2 vertex_unnamed_183 = (vertex_input_3.xy * _MainTex_ST.xy) + _MainTex_ST.zw;
				vertex_output_0 = float4(vertex_unnamed_183.x, vertex_unnamed_183.y, vertex_output_0.z, vertex_output_0.w);
				vertex_unnamed_188 = 0.0f >= vertex_input_4.y;
				vertex_unnamed_118 = float(vertex_unnamed_188);
				vertex_unnamed_196 = (-_WeightNormal) + _WeightBold;
				vertex_unnamed_118 = (vertex_unnamed_118 * vertex_unnamed_196) + _WeightNormal;
				vertex_unnamed_118 = (vertex_unnamed_118 * 0.25f) + _FaceDilate;
				vertex_unnamed_118 *= _ScaleRatioA;
				vertex_output_2.x = vertex_unnamed_118 * 0.5f;
				vertex_unnamed_118 = vertex_unnamed_65.y * unity_MatrixVP__array[1].w;
				vertex_unnamed_118 = (unity_MatrixVP__array[0].w * vertex_unnamed_65.x) + vertex_unnamed_118;
				vertex_unnamed_118 = (unity_MatrixVP__array[2].w * vertex_unnamed_65.z) + vertex_unnamed_118;
				vertex_unnamed_118 = (unity_MatrixVP__array[3].w * vertex_unnamed_65.w) + vertex_unnamed_118;
				float2 vertex_unnamed_264 = _ScreenParams.yy * glstate_matrix_projection__array[1].xy;
				vertex_unnamed_65 = float4(vertex_unnamed_264.x, vertex_unnamed_264.y, vertex_unnamed_65.z, vertex_unnamed_65.w);
				float2 vertex_unnamed_276 = (glstate_matrix_projection__array[0].xy * _ScreenParams.xx) + vertex_unnamed_65.xy;
				vertex_unnamed_65 = float4(vertex_unnamed_276.x, vertex_unnamed_276.y, vertex_unnamed_65.z, vertex_unnamed_65.w);
				float2 vertex_unnamed_288 = vertex_unnamed_65.xy * float2(_ScaleX, _ScaleY);
				vertex_unnamed_65 = float4(vertex_unnamed_288.x, vertex_unnamed_288.y, vertex_unnamed_65.z, vertex_unnamed_65.w);
				float2 vertex_unnamed_295 = vertex_unnamed_118.xx / vertex_unnamed_65.xy;
				vertex_unnamed_65 = float4(vertex_unnamed_295.x, vertex_unnamed_295.y, vertex_unnamed_65.z, vertex_unnamed_65.w);
				vertex_unnamed_118 = dot(vertex_unnamed_65.xy, vertex_unnamed_65.xy);
				vertex_unnamed_118 = rsqrt(vertex_unnamed_118);
				vertex_unnamed_196 = abs(vertex_input_4.y) * _GradientScale;
				vertex_unnamed_65.x = _Sharpness + 1.0f;
				vertex_unnamed_196 *= vertex_unnamed_65.x;
				vertex_unnamed_65.x = vertex_unnamed_118 * vertex_unnamed_196;
				vertex_unnamed_326.x = (-_PerspectiveFilter) + 1.0f;
				vertex_unnamed_65.x = vertex_unnamed_326.x * vertex_unnamed_65.x;
				vertex_unnamed_118 = (vertex_unnamed_118 * vertex_unnamed_196) + (-vertex_unnamed_65.x);
				vertex_unnamed_326 = _WorldSpaceCameraPos.yyy * unity_WorldToObject__array[1].xyz;
				vertex_unnamed_326 = (unity_WorldToObject__array[0].xyz * _WorldSpaceCameraPos.xxx) + vertex_unnamed_326;
				vertex_unnamed_326 = (unity_WorldToObject__array[2].xyz * _WorldSpaceCameraPos.zzz) + vertex_unnamed_326;
				vertex_unnamed_326 += unity_WorldToObject__array[3].xyz;
				vertex_unnamed_9.z = vertex_input_0.z;
				float3 vertex_unnamed_385 = (-vertex_unnamed_9.xyz) + vertex_unnamed_326;
				vertex_unnamed_9 = float4(vertex_unnamed_385.x, vertex_unnamed_385.y, vertex_unnamed_385.z, vertex_unnamed_9.w);
				vertex_unnamed_9.x = dot(vertex_input_2, vertex_unnamed_9.xyz);
				vertex_unnamed_396 = int((0.0f < vertex_unnamed_9.x) ? 4294967295u : 0u);
				vertex_unnamed_403 = int((vertex_unnamed_9.x < 0.0f) ? 4294967295u : 0u);
				vertex_unnamed_403 = (-vertex_unnamed_396) + vertex_unnamed_403;
				vertex_unnamed_9.x = float(vertex_unnamed_403);
				float3 vertex_unnamed_419 = vertex_unnamed_9.xxx * vertex_input_2;
				vertex_unnamed_9 = float4(vertex_unnamed_419.x, vertex_unnamed_419.y, vertex_unnamed_419.z, vertex_unnamed_9.w);
				vertex_unnamed_82.x = dot(vertex_unnamed_9.xyz, unity_WorldToObject__array[0].xyz);
				vertex_unnamed_82.y = dot(vertex_unnamed_9.xyz, unity_WorldToObject__array[1].xyz);
				vertex_unnamed_82.z = dot(vertex_unnamed_9.xyz, unity_WorldToObject__array[2].xyz);
				vertex_unnamed_9.x = dot(vertex_unnamed_82.xyz, vertex_unnamed_82.xyz);
				vertex_unnamed_9.x = rsqrt(vertex_unnamed_9.x);
				vertex_unnamed_82 = vertex_unnamed_9.xxxx * vertex_unnamed_82.xyzz;
				float3 vertex_unnamed_463 = (-vertex_unnamed_40.xyz) + _WorldSpaceCameraPos;
				vertex_unnamed_9 = float4(vertex_unnamed_463.x, vertex_unnamed_463.y, vertex_unnamed_463.z, vertex_unnamed_9.w);
				vertex_unnamed_196 = dot(vertex_unnamed_9.xyz, vertex_unnamed_9.xyz);
				vertex_unnamed_196 = rsqrt(vertex_unnamed_196);
				vertex_unnamed_326 = vertex_unnamed_9.xyz * vertex_unnamed_196.xxx;
				vertex_unnamed_196 = dot(vertex_unnamed_82.xyw, vertex_unnamed_326);
				vertex_output_2.y = (abs(vertex_unnamed_196) * vertex_unnamed_118) + vertex_unnamed_65.x;
				float3 vertex_unnamed_496 = vertex_input_1.yyy * unity_ObjectToWorld__array[1].yzx;
				vertex_unnamed_65 = float4(vertex_unnamed_496.x, vertex_unnamed_496.y, vertex_unnamed_496.z, vertex_unnamed_65.w);
				float3 vertex_unnamed_507 = (unity_ObjectToWorld__array[0].yzx * vertex_input_1.xxx) + vertex_unnamed_65.xyz;
				vertex_unnamed_65 = float4(vertex_unnamed_507.x, vertex_unnamed_507.y, vertex_unnamed_507.z, vertex_unnamed_65.w);
				float3 vertex_unnamed_518 = (unity_ObjectToWorld__array[2].yzx * vertex_input_1.zzz) + vertex_unnamed_65.xyz;
				vertex_unnamed_65 = float4(vertex_unnamed_518.x, vertex_unnamed_518.y, vertex_unnamed_518.z, vertex_unnamed_65.w);
				vertex_unnamed_118 = dot(vertex_unnamed_65.xyz, vertex_unnamed_65.xyz);
				vertex_unnamed_118 = rsqrt(vertex_unnamed_118);
				float3 vertex_unnamed_532 = vertex_unnamed_118.xxx * vertex_unnamed_65.xyz;
				vertex_unnamed_65 = float4(vertex_unnamed_532.x, vertex_unnamed_532.y, vertex_unnamed_532.z, vertex_unnamed_65.w);
				float3 vertex_unnamed_540 = vertex_unnamed_65.xyz * vertex_unnamed_82.wxy;
				vertex_unnamed_535 = float4(vertex_unnamed_540.x, vertex_unnamed_540.y, vertex_unnamed_540.z, vertex_unnamed_535.w);
				float3 vertex_unnamed_551 = (vertex_unnamed_82.ywx * vertex_unnamed_65.yzx) + (-vertex_unnamed_535.xyz);
				vertex_unnamed_535 = float4(vertex_unnamed_551.x, vertex_unnamed_551.y, vertex_unnamed_551.z, vertex_unnamed_535.w);
				vertex_unnamed_118 = vertex_input_1.w * unity_WorldTransformParams.w;
				float3 vertex_unnamed_564 = vertex_unnamed_118.xxx * vertex_unnamed_535.xyz;
				vertex_unnamed_535 = float4(vertex_unnamed_564.x, vertex_unnamed_564.y, vertex_unnamed_564.z, vertex_unnamed_535.w);
				vertex_output_3.y = vertex_unnamed_535.x;
				vertex_output_3.z = vertex_unnamed_82.x;
				vertex_output_3.x = vertex_unnamed_65.z;
				vertex_output_3.w = vertex_unnamed_40.x;
				vertex_output_4.x = vertex_unnamed_65.x;
				vertex_output_5.x = vertex_unnamed_65.y;
				vertex_output_4.z = vertex_unnamed_82.y;
				vertex_output_4.y = vertex_unnamed_535.y;
				vertex_output_5.y = vertex_unnamed_535.z;
				vertex_output_4.w = vertex_unnamed_40.y;
				vertex_output_5.z = vertex_unnamed_82.w;
				vertex_output_5.w = vertex_unnamed_40.z;
				vertex_output_6 = vertex_input_5;
				float3 vertex_unnamed_615 = vertex_unnamed_9.yyy * _EnvMatrix__array[1].xyz;
				vertex_unnamed_65 = float4(vertex_unnamed_615.x, vertex_unnamed_615.y, vertex_unnamed_615.z, vertex_unnamed_65.w);
				float3 vertex_unnamed_626 = (_EnvMatrix__array[0].xyz * vertex_unnamed_9.xxx) + vertex_unnamed_65.xyz;
				vertex_unnamed_9 = float4(vertex_unnamed_626.x, vertex_unnamed_626.y, vertex_unnamed_9.z, vertex_unnamed_626.z);
				vertex_output_7 = (_EnvMatrix__array[2].xyz * vertex_unnamed_9.zzz) + vertex_unnamed_9.xyw;
				vertex_unnamed_9 = (-vertex_unnamed_40.yyyy) + unity_4LightPosY0;
				vertex_unnamed_65 = vertex_unnamed_82.yyyy * vertex_unnamed_9;
				vertex_unnamed_9 *= vertex_unnamed_9;
				vertex_unnamed_535 = (-vertex_unnamed_40.xxxx) + unity_4LightPosX0;
				vertex_unnamed_40 = (-vertex_unnamed_40.zzzz) + unity_4LightPosZ0;
				vertex_unnamed_65 = (vertex_unnamed_535 * vertex_unnamed_82.xxxx) + vertex_unnamed_65;
				vertex_unnamed_9 = (vertex_unnamed_535 * vertex_unnamed_535) + vertex_unnamed_9;
				vertex_unnamed_9 = (vertex_unnamed_40 * vertex_unnamed_40) + vertex_unnamed_9;
				vertex_unnamed_40 = (vertex_unnamed_40 * vertex_unnamed_82.wwzw) + vertex_unnamed_65;
				vertex_unnamed_9 = max(vertex_unnamed_9, 9.9999999747524270787835121154785e-07f.xxxx);
				vertex_unnamed_65 = rsqrt(vertex_unnamed_9);
				vertex_unnamed_9 = (vertex_unnamed_9 * unity_4LightAtten0) + 1.0f.xxxx;
				vertex_unnamed_9 = 1.0f.xxxx / vertex_unnamed_9;
				vertex_unnamed_40 *= vertex_unnamed_65;
				vertex_unnamed_40 = max(vertex_unnamed_40, 0.0f.xxxx);
				vertex_unnamed_9 *= vertex_unnamed_40;
				float3 vertex_unnamed_718 = vertex_unnamed_9.yyy * unity_LightColor[1].xyz;
				vertex_unnamed_40 = float4(vertex_unnamed_718.x, vertex_unnamed_718.y, vertex_unnamed_718.z, vertex_unnamed_40.w);
				float3 vertex_unnamed_729 = (unity_LightColor[0].xyz * vertex_unnamed_9.xxx) + vertex_unnamed_40.xyz;
				vertex_unnamed_40 = float4(vertex_unnamed_729.x, vertex_unnamed_729.y, vertex_unnamed_729.z, vertex_unnamed_40.w);
				float3 vertex_unnamed_740 = (unity_LightColor[2].xyz * vertex_unnamed_9.zzz) + vertex_unnamed_40.xyz;
				vertex_unnamed_9 = float4(vertex_unnamed_740.x, vertex_unnamed_740.y, vertex_unnamed_740.z, vertex_unnamed_9.w);
				float3 vertex_unnamed_751 = (unity_LightColor[3].xyz * vertex_unnamed_9.www) + vertex_unnamed_9.xyz;
				vertex_unnamed_9 = float4(vertex_unnamed_751.x, vertex_unnamed_751.y, vertex_unnamed_751.z, vertex_unnamed_9.w);
				float3 vertex_unnamed_761 = (vertex_unnamed_9.xyz * 0.305306017398834228515625f.xxx) + 0.6821711063385009765625f.xxx;
				vertex_unnamed_40 = float4(vertex_unnamed_761.x, vertex_unnamed_761.y, vertex_unnamed_761.z, vertex_unnamed_40.w);
				float3 vertex_unnamed_771 = (vertex_unnamed_9.xyz * vertex_unnamed_40.xyz) + 0.01252287812530994415283203125f.xxx;
				vertex_unnamed_40 = float4(vertex_unnamed_771.x, vertex_unnamed_771.y, vertex_unnamed_771.z, vertex_unnamed_40.w);
				vertex_unnamed_118 = vertex_unnamed_82.y * vertex_unnamed_82.y;
				vertex_unnamed_118 = (vertex_unnamed_82.x * vertex_unnamed_82.x) + (-vertex_unnamed_118);
				vertex_unnamed_65 = vertex_unnamed_82.ywzx * vertex_unnamed_82;
				vertex_unnamed_82.x = dot(unity_SHBr, vertex_unnamed_65);
				vertex_unnamed_82.y = dot(unity_SHBg, vertex_unnamed_65);
				vertex_unnamed_82.z = dot(unity_SHBb, vertex_unnamed_65);
				float3 vertex_unnamed_818 = (unity_SHC.xyz * vertex_unnamed_118.xxx) + vertex_unnamed_82.xyz;
				vertex_unnamed_65 = float4(vertex_unnamed_818.x, vertex_unnamed_818.y, vertex_unnamed_818.z, vertex_unnamed_65.w);
				vertex_output_8 = (vertex_unnamed_9.xyz * vertex_unnamed_40.xyz) + vertex_unnamed_65.xyz;
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

				_EnvMatrix__array[0] = float4(_EnvMatrix[0][0], _EnvMatrix[1][0], _EnvMatrix[2][0], _EnvMatrix[3][0]);
				_EnvMatrix__array[1] = float4(_EnvMatrix[0][1], _EnvMatrix[1][1], _EnvMatrix[2][1], _EnvMatrix[3][1]);
				_EnvMatrix__array[2] = float4(_EnvMatrix[0][2], _EnvMatrix[1][2], _EnvMatrix[2][2], _EnvMatrix[3][2]);
				_EnvMatrix__array[3] = float4(_EnvMatrix[0][3], _EnvMatrix[1][3], _EnvMatrix[2][3], _EnvMatrix[3][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_4 = stage_input.vertex_input_4;
				vertex_input_3 = stage_input.vertex_input_3;
				vertex_input_2 = stage_input.vertex_input_2;
				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_5 = stage_input.vertex_input_5;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_0 = vertex_output_0;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
				stage_output.vertex_output_6 = vertex_output_6;
				stage_output.vertex_output_7 = vertex_output_7;
				stage_output.vertex_output_8 = vertex_output_8;
				return stage_output;
			}

			float4 _Time;
			float3 _WorldSpaceCameraPos;
			float4 _WorldSpaceLightPos0;
			float4 unity_SHAr;
			float4 unity_SHAg;
			float4 unity_SHAb;
			float4x4 unity_ObjectToWorld;
			float4 _LightColor0;
			float4 _SpecColor;
			float _FaceUVSpeedX;
			float _FaceUVSpeedY;
			float4 _FaceColor;
			float _OutlineSoftness;
			float _OutlineUVSpeedX;
			float _OutlineUVSpeedY;
			float4 _OutlineColor;
			float _OutlineWidth;
			float _Bevel;
			float _BevelOffset;
			float _BevelWidth;
			float _BevelClamp;
			float _BevelRoundness;
			float _BumpOutline;
			float _BumpFace;
			float4 _ReflectFaceColor;
			float4 _ReflectOutlineColor;
			float _ShaderFlags;
			float _ScaleRatioA;
			float _TextureWidth;
			float _TextureHeight;
			float _GradientScale;
			float _FaceShininess;
			float _OutlineShininess;

			static float4 unity_ObjectToWorld__array[4];
			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;
			Texture2D<float4> _OutlineTex;
			SamplerState sampler_OutlineTex;
			Texture2D<float4> _FaceTex;
			SamplerState sampler_FaceTex;
			Texture2D<float4> _BumpMap;
			SamplerState sampler_BumpMap;
			TextureCube<float4> _Cube;
			SamplerState sampler_Cube;

			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_input_5;
			static float2 fragment_input_2;
			static float4 fragment_input_0;
			static float2 fragment_input_1;
			static float4 fragment_input_6;
			static float3 fragment_input_8;
			static float3 fragment_input_7;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_0 : TEXCOORD0; // vs_TEXCOORD0
				float2 fragment_input_1 : TEXCOORD1; // vs_TEXCOORD1
				float2 fragment_input_2 : TEXCOORD5; // vs_TEXCOORD5
				float4 fragment_input_3 : TEXCOORD2; // vs_TEXCOORD2
				float4 fragment_input_4 : TEXCOORD3; // vs_TEXCOORD3
				float4 fragment_input_5 : TEXCOORD4; // vs_TEXCOORD4
				float4 fragment_input_6 : UNKNOWN6;
				float3 fragment_input_7 : TEXCOORD6; // vs_TEXCOORD6
				float3 fragment_input_8 : TEXCOORD7; // vs_TEXCOORD7
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static float3 fragment_unnamed_9;
			static float fragment_unnamed_44;
			static float4 fragment_unnamed_80;
			static float4 fragment_unnamed_95;
			static float4 fragment_unnamed_108;
			static bool fragment_unnamed_210;
			static bool fragment_unnamed_235;
			static float fragment_unnamed_311;
			static float4 fragment_unnamed_432;
			static float fragment_unnamed_493;
			static float3 fragment_unnamed_690;
			static float3 fragment_unnamed_771;

			void frag_main()
			{
				fragment_unnamed_9.x = fragment_input_3.w;
				fragment_unnamed_9.y = fragment_input_4.w;
				fragment_unnamed_9.z = fragment_input_5.w;
				fragment_unnamed_9 = (-fragment_unnamed_9) + _WorldSpaceCameraPos;
				fragment_unnamed_44 = dot(fragment_unnamed_9, fragment_unnamed_9);
				fragment_unnamed_44 = rsqrt(fragment_unnamed_44);
				fragment_unnamed_9 = (fragment_unnamed_9 * fragment_unnamed_44.xxx) + _WorldSpaceLightPos0.xyz;
				fragment_unnamed_44 = dot(fragment_unnamed_9, fragment_unnamed_9);
				fragment_unnamed_44 = rsqrt(fragment_unnamed_44);
				fragment_unnamed_9 = fragment_unnamed_44.xxx * fragment_unnamed_9;
				fragment_unnamed_44 = fragment_input_2.x + _BevelOffset;
				float2 fragment_unnamed_90 = 1.0f.xx / float2(_TextureWidth, _TextureHeight);
				fragment_unnamed_80 = float4(fragment_unnamed_90.x, fragment_unnamed_90.y, fragment_unnamed_80.z, fragment_unnamed_80.w);
				fragment_unnamed_80.z = 0.0f;
				fragment_unnamed_95 = (-fragment_unnamed_80.xzzy) + fragment_input_0.xyxy;
				fragment_unnamed_80 = fragment_unnamed_80.xzzy + fragment_input_0.xyxy;
				fragment_unnamed_108.x = _MainTex.Sample(sampler_MainTex, fragment_unnamed_95.xy).w;
				fragment_unnamed_108.z = _MainTex.Sample(sampler_MainTex, fragment_unnamed_95.zw).w;
				fragment_unnamed_108.y = _MainTex.Sample(sampler_MainTex, fragment_unnamed_80.xy).w;
				fragment_unnamed_108.w = _MainTex.Sample(sampler_MainTex, fragment_unnamed_80.zw).w;
				fragment_unnamed_80 = fragment_unnamed_44.xxxx + fragment_unnamed_108;
				fragment_unnamed_80 += (-0.5f).xxxx;
				fragment_unnamed_44 = _BevelWidth + _OutlineWidth;
				fragment_unnamed_44 = max(fragment_unnamed_44, 0.00999999977648258209228515625f);
				fragment_unnamed_80 /= fragment_unnamed_44.xxxx;
				fragment_unnamed_44 *= _Bevel;
				fragment_unnamed_44 *= _GradientScale;
				fragment_unnamed_44 *= (-2.0f);
				fragment_unnamed_80 += 0.5f.xxxx;
				fragment_unnamed_80 = clamp(fragment_unnamed_80, 0.0f.xxxx, 1.0f.xxxx);
				fragment_unnamed_95 = (fragment_unnamed_80 * 2.0f.xxxx) + (-1.0f).xxxx;
				fragment_unnamed_95 = (-abs(fragment_unnamed_95)) + 1.0f.xxxx;
				fragment_unnamed_108.x = _ShaderFlags * 0.5f;
				fragment_unnamed_210 = fragment_unnamed_108.x >= (-fragment_unnamed_108.x);
				fragment_unnamed_108.x = frac(abs(fragment_unnamed_108.x));
				float fragment_unnamed_224;
				if (fragment_unnamed_210)
				{
					fragment_unnamed_224 = fragment_unnamed_108.x;
				}
				else
				{
					fragment_unnamed_224 = -fragment_unnamed_108.x;
				}
				fragment_unnamed_108.x = fragment_unnamed_224;
				fragment_unnamed_235 = fragment_unnamed_108.x >= 0.5f;
				bool4 fragment_unnamed_243 = fragment_unnamed_235.xxxx;
				fragment_unnamed_80 = float4(fragment_unnamed_243.x ? fragment_unnamed_95.x : fragment_unnamed_80.x, fragment_unnamed_243.y ? fragment_unnamed_95.y : fragment_unnamed_80.y, fragment_unnamed_243.z ? fragment_unnamed_95.z : fragment_unnamed_80.z, fragment_unnamed_243.w ? fragment_unnamed_95.w : fragment_unnamed_80.w);
				fragment_unnamed_95 = fragment_unnamed_80 * 1.57079601287841796875f.xxxx;
				fragment_unnamed_95 = sin(fragment_unnamed_95);
				fragment_unnamed_95 = (-fragment_unnamed_80) + fragment_unnamed_95;
				fragment_unnamed_80 = (float4(float4(_BevelRoundness, _BevelRoundness, _BevelRoundness, _BevelRoundness)) * fragment_unnamed_95) + fragment_unnamed_80;
				fragment_unnamed_95.x = (-_BevelClamp) + 1.0f;
				fragment_unnamed_80 = min(fragment_unnamed_80, fragment_unnamed_95.xxxx);
				float2 fragment_unnamed_288 = fragment_unnamed_44.xx * fragment_unnamed_80.xz;
				fragment_unnamed_80 = float4(fragment_unnamed_288.x, fragment_unnamed_80.y, fragment_unnamed_288.y, fragment_unnamed_80.w);
				float2 fragment_unnamed_299 = (fragment_unnamed_80.wy * fragment_unnamed_44.xx) + (-fragment_unnamed_80.zx);
				fragment_unnamed_80 = float4(fragment_unnamed_80.x, fragment_unnamed_299.x, fragment_unnamed_299.y, fragment_unnamed_80.w);
				fragment_unnamed_80.x = -1.0f;
				fragment_unnamed_80.w = 1.0f;
				fragment_unnamed_44 = dot(fragment_unnamed_80.xy, fragment_unnamed_80.xy);
				fragment_unnamed_44 = rsqrt(fragment_unnamed_44);
				fragment_unnamed_311 = dot(fragment_unnamed_80.zw, fragment_unnamed_80.zw);
				fragment_unnamed_311 = rsqrt(fragment_unnamed_311);
				fragment_unnamed_95.x = fragment_unnamed_311 * fragment_unnamed_80.z;
				float2 fragment_unnamed_327 = fragment_unnamed_311.xx * float2(1.0f, 0.0f);
				fragment_unnamed_95 = float4(fragment_unnamed_95.x, fragment_unnamed_327.x, fragment_unnamed_327.y, fragment_unnamed_95.w);
				fragment_unnamed_80.z = 0.0f;
				float3 fragment_unnamed_335 = fragment_unnamed_44.xxx * fragment_unnamed_80.xyz;
				fragment_unnamed_80 = float4(fragment_unnamed_335.x, fragment_unnamed_335.y, fragment_unnamed_335.z, fragment_unnamed_80.w);
				float3 fragment_unnamed_342 = fragment_unnamed_80.xyz * fragment_unnamed_95.xyz;
				fragment_unnamed_108 = float4(fragment_unnamed_342.x, fragment_unnamed_342.y, fragment_unnamed_342.z, fragment_unnamed_108.w);
				float3 fragment_unnamed_353 = (fragment_unnamed_95.zxy * fragment_unnamed_80.yzx) + (-fragment_unnamed_108.xyz);
				fragment_unnamed_80 = float4(fragment_unnamed_353.x, fragment_unnamed_353.y, fragment_unnamed_353.z, fragment_unnamed_80.w);
				float2 fragment_unnamed_370 = (float2(_OutlineUVSpeedX, _OutlineUVSpeedY) * _Time.yy) + fragment_input_1;
				fragment_unnamed_95 = float4(fragment_unnamed_370.x, fragment_unnamed_370.y, fragment_unnamed_95.z, fragment_unnamed_95.w);
				fragment_unnamed_95 = _OutlineTex.Sample(sampler_OutlineTex, fragment_unnamed_95.xy);
				float3 fragment_unnamed_387 = fragment_unnamed_95.xyz * _OutlineColor.xyz;
				fragment_unnamed_95 = float4(fragment_unnamed_387.x, fragment_unnamed_387.y, fragment_unnamed_387.z, fragment_unnamed_95.w);
				fragment_unnamed_44 = fragment_input_6.w * _OutlineColor.w;
				fragment_unnamed_108.w = fragment_unnamed_95.w * fragment_unnamed_44;
				float3 fragment_unnamed_405 = fragment_unnamed_95.xyz * fragment_unnamed_108.www;
				fragment_unnamed_108 = float4(fragment_unnamed_405.x, fragment_unnamed_405.y, fragment_unnamed_405.z, fragment_unnamed_108.w);
				float2 fragment_unnamed_421 = (float2(_FaceUVSpeedX, _FaceUVSpeedY) * _Time.yy) + fragment_input_0.zw;
				fragment_unnamed_95 = float4(fragment_unnamed_421.x, fragment_unnamed_421.y, fragment_unnamed_95.z, fragment_unnamed_95.w);
				fragment_unnamed_95 = _FaceTex.Sample(sampler_FaceTex, fragment_unnamed_95.xy);
				fragment_unnamed_432 = fragment_input_6 * _FaceColor;
				fragment_unnamed_95 *= fragment_unnamed_432;
				float3 fragment_unnamed_445 = fragment_unnamed_95.www * fragment_unnamed_95.xyz;
				fragment_unnamed_95 = float4(fragment_unnamed_445.x, fragment_unnamed_445.y, fragment_unnamed_445.z, fragment_unnamed_95.w);
				fragment_unnamed_108 = (-fragment_unnamed_95) + fragment_unnamed_108;
				fragment_unnamed_44 = _OutlineWidth * _ScaleRatioA;
				fragment_unnamed_44 *= fragment_input_2.y;
				fragment_unnamed_311 = min(fragment_unnamed_44, 1.0f);
				fragment_unnamed_311 = sqrt(fragment_unnamed_311);
				fragment_unnamed_432.x = _MainTex.Sample(sampler_MainTex, fragment_input_0.xy).w;
				fragment_unnamed_432.x = (-fragment_unnamed_432.x) + 0.5f;
				fragment_unnamed_432.x += (-fragment_input_2.x);
				fragment_unnamed_432.x = (fragment_unnamed_432.x * fragment_input_2.y) + 0.5f;
				fragment_unnamed_493 = (fragment_unnamed_44 * 0.5f) + fragment_unnamed_432.x;
				fragment_unnamed_493 = clamp(fragment_unnamed_493, 0.0f, 1.0f);
				fragment_unnamed_44 = ((-fragment_unnamed_44) * 0.5f) + fragment_unnamed_432.x;
				fragment_unnamed_311 *= fragment_unnamed_493;
				fragment_unnamed_95 = (fragment_unnamed_311.xxxx * fragment_unnamed_108) + fragment_unnamed_95;
				fragment_unnamed_311 = _OutlineSoftness * _ScaleRatioA;
				fragment_unnamed_108.x = fragment_unnamed_311 * fragment_input_2.y;
				fragment_unnamed_311 = (fragment_unnamed_311 * fragment_input_2.y) + 1.0f;
				fragment_unnamed_44 = (fragment_unnamed_108.x * 0.5f) + fragment_unnamed_44;
				fragment_unnamed_44 /= fragment_unnamed_311;
				fragment_unnamed_44 = clamp(fragment_unnamed_44, 0.0f, 1.0f);
				fragment_unnamed_44 = (-fragment_unnamed_44) + 1.0f;
				fragment_unnamed_95 = fragment_unnamed_44.xxxx * fragment_unnamed_95;
				fragment_unnamed_44 = (-_BumpFace) + _BumpOutline;
				fragment_unnamed_44 = (fragment_unnamed_493 * fragment_unnamed_44) + _BumpFace;
				float3 fragment_unnamed_571 = _BumpMap.Sample(sampler_BumpMap, fragment_input_0.zw).xyw;
				fragment_unnamed_108 = float4(fragment_unnamed_571.x, fragment_unnamed_571.y, fragment_unnamed_571.z, fragment_unnamed_108.w);
				fragment_unnamed_108.x = fragment_unnamed_108.z * fragment_unnamed_108.x;
				float2 fragment_unnamed_585 = (fragment_unnamed_108.xy * 2.0f.xx) + (-1.0f).xx;
				fragment_unnamed_108 = float4(fragment_unnamed_585.x, fragment_unnamed_585.y, fragment_unnamed_108.z, fragment_unnamed_108.w);
				fragment_unnamed_311 = dot(fragment_unnamed_108.xy, fragment_unnamed_108.xy);
				fragment_unnamed_311 = min(fragment_unnamed_311, 1.0f);
				fragment_unnamed_311 = (-fragment_unnamed_311) + 1.0f;
				fragment_unnamed_108.z = sqrt(fragment_unnamed_311);
				float3 fragment_unnamed_608 = (fragment_unnamed_108.xyz * fragment_unnamed_44.xxx) + float3(-0.0f, -0.0f, -1.0f);
				fragment_unnamed_108 = float4(fragment_unnamed_608.x, fragment_unnamed_608.y, fragment_unnamed_608.z, fragment_unnamed_108.w);
				float3 fragment_unnamed_617 = (fragment_unnamed_95.www * fragment_unnamed_108.xyz) + float3(0.0f, 0.0f, 1.0f);
				fragment_unnamed_108 = float4(fragment_unnamed_617.x, fragment_unnamed_617.y, fragment_unnamed_617.z, fragment_unnamed_108.w);
				float3 fragment_unnamed_625 = fragment_unnamed_80.xyz + (-fragment_unnamed_108.xyz);
				fragment_unnamed_80 = float4(fragment_unnamed_625.x, fragment_unnamed_625.y, fragment_unnamed_625.z, fragment_unnamed_80.w);
				fragment_unnamed_44 = dot(fragment_unnamed_80.xyz, fragment_unnamed_80.xyz);
				fragment_unnamed_44 = rsqrt(fragment_unnamed_44);
				float3 fragment_unnamed_639 = fragment_unnamed_44.xxx * fragment_unnamed_80.xyz;
				fragment_unnamed_80 = float4(fragment_unnamed_639.x, fragment_unnamed_639.y, fragment_unnamed_639.z, fragment_unnamed_80.w);
				fragment_unnamed_108.x = dot(fragment_input_3.xyz, -fragment_unnamed_80.xyz);
				fragment_unnamed_108.y = dot(fragment_input_4.xyz, -fragment_unnamed_80.xyz);
				fragment_unnamed_108.z = dot(fragment_input_5.xyz, -fragment_unnamed_80.xyz);
				fragment_unnamed_44 = dot(fragment_unnamed_108.xyz, fragment_unnamed_108.xyz);
				fragment_unnamed_44 = rsqrt(fragment_unnamed_44);
				float3 fragment_unnamed_674 = fragment_unnamed_44.xxx * fragment_unnamed_108.xyz;
				fragment_unnamed_108 = float4(fragment_unnamed_674.x, fragment_unnamed_674.y, fragment_unnamed_674.z, fragment_unnamed_108.w);
				fragment_unnamed_9.x = dot(fragment_unnamed_108.xyz, fragment_unnamed_9);
				fragment_unnamed_9.x = max(fragment_unnamed_9.x, 0.0f);
				fragment_unnamed_9.x = log2(fragment_unnamed_9.x);
				fragment_unnamed_690.x = (-_FaceShininess) + _OutlineShininess;
				fragment_unnamed_690.x = (fragment_unnamed_493 * fragment_unnamed_690.x) + _FaceShininess;
				fragment_unnamed_690.x *= 128.0f;
				fragment_unnamed_9.x *= fragment_unnamed_690.x;
				fragment_unnamed_9.x = exp2(fragment_unnamed_9.x);
				fragment_unnamed_690 = _LightColor0.xyz * _SpecColor.xyz;
				fragment_unnamed_9 = fragment_unnamed_9.xxx * fragment_unnamed_690;
				fragment_unnamed_44 = dot(fragment_unnamed_108.xyz, _WorldSpaceLightPos0.xyz);
				fragment_unnamed_44 = max(fragment_unnamed_44, 0.0f);
				fragment_unnamed_311 = max(fragment_unnamed_95.w, 9.9999997473787516355514526367188e-05f);
				float3 fragment_unnamed_752 = fragment_unnamed_95.xyz / fragment_unnamed_311.xxx;
				fragment_unnamed_95 = float4(fragment_unnamed_752.x, fragment_unnamed_752.y, fragment_unnamed_752.z, fragment_unnamed_95.w);
				float3 fragment_unnamed_760 = fragment_unnamed_95.xyz * _LightColor0.xyz;
				fragment_unnamed_432 = float4(fragment_unnamed_760.x, fragment_unnamed_432.y, fragment_unnamed_760.y, fragment_unnamed_760.z);
				fragment_unnamed_9 = (fragment_unnamed_432.xzw * fragment_unnamed_44.xxx) + fragment_unnamed_9;
				fragment_unnamed_108.w = 1.0f;
				fragment_unnamed_771.x = dot(unity_SHAr, fragment_unnamed_108);
				fragment_unnamed_771.y = dot(unity_SHAg, fragment_unnamed_108);
				fragment_unnamed_771.z = dot(unity_SHAb, fragment_unnamed_108);
				float3 fragment_unnamed_794 = fragment_unnamed_771 + fragment_input_8;
				fragment_unnamed_108 = float4(fragment_unnamed_794.x, fragment_unnamed_794.y, fragment_unnamed_794.z, fragment_unnamed_108.w);
				float3 fragment_unnamed_800 = max(fragment_unnamed_108.xyz, 0.0f.xxx);
				fragment_unnamed_108 = float4(fragment_unnamed_800.x, fragment_unnamed_800.y, fragment_unnamed_800.z, fragment_unnamed_108.w);
				float3 fragment_unnamed_805 = log2(fragment_unnamed_108.xyz);
				fragment_unnamed_108 = float4(fragment_unnamed_805.x, fragment_unnamed_805.y, fragment_unnamed_805.z, fragment_unnamed_108.w);
				float3 fragment_unnamed_812 = fragment_unnamed_108.xyz * 0.4166666567325592041015625f.xxx;
				fragment_unnamed_108 = float4(fragment_unnamed_812.x, fragment_unnamed_812.y, fragment_unnamed_812.z, fragment_unnamed_108.w);
				float3 fragment_unnamed_817 = exp2(fragment_unnamed_108.xyz);
				fragment_unnamed_108 = float4(fragment_unnamed_817.x, fragment_unnamed_817.y, fragment_unnamed_817.z, fragment_unnamed_108.w);
				float3 fragment_unnamed_827 = (fragment_unnamed_108.xyz * 1.05499994754791259765625f.xxx) + (-0.054999999701976776123046875f).xxx;
				fragment_unnamed_108 = float4(fragment_unnamed_827.x, fragment_unnamed_827.y, fragment_unnamed_827.z, fragment_unnamed_108.w);
				float3 fragment_unnamed_832 = max(fragment_unnamed_108.xyz, 0.0f.xxx);
				fragment_unnamed_108 = float4(fragment_unnamed_832.x, fragment_unnamed_832.y, fragment_unnamed_832.z, fragment_unnamed_108.w);
				fragment_unnamed_9 = (fragment_unnamed_95.xyz * fragment_unnamed_108.xyz) + fragment_unnamed_9;
				float3 fragment_unnamed_851 = (-_ReflectFaceColor.xyz) + _ReflectOutlineColor.xyz;
				fragment_unnamed_95 = float4(fragment_unnamed_851.x, fragment_unnamed_851.y, fragment_unnamed_851.z, fragment_unnamed_95.w);
				float3 fragment_unnamed_862 = (fragment_unnamed_493.xxx * fragment_unnamed_95.xyz) + _ReflectFaceColor.xyz;
				fragment_unnamed_95 = float4(fragment_unnamed_862.x, fragment_unnamed_862.y, fragment_unnamed_862.z, fragment_unnamed_95.w);
				float3 fragment_unnamed_871 = fragment_unnamed_80.yyy * unity_ObjectToWorld__array[1].xyz;
				fragment_unnamed_108 = float4(fragment_unnamed_871.x, fragment_unnamed_871.y, fragment_unnamed_871.z, fragment_unnamed_108.w);
				float3 fragment_unnamed_882 = (unity_ObjectToWorld__array[0].xyz * fragment_unnamed_80.xxx) + fragment_unnamed_108.xyz;
				fragment_unnamed_80 = float4(fragment_unnamed_882.x, fragment_unnamed_882.y, fragment_unnamed_80.z, fragment_unnamed_882.z);
				float3 fragment_unnamed_893 = (unity_ObjectToWorld__array[2].xyz * fragment_unnamed_80.zzz) + fragment_unnamed_80.xyw;
				fragment_unnamed_80 = float4(fragment_unnamed_893.x, fragment_unnamed_893.y, fragment_unnamed_893.z, fragment_unnamed_80.w);
				fragment_unnamed_44 = dot(fragment_input_7, fragment_unnamed_80.xyz);
				fragment_unnamed_44 += fragment_unnamed_44;
				float3 fragment_unnamed_911 = (fragment_unnamed_80.xyz * (-fragment_unnamed_44.xxx)) + fragment_input_7;
				fragment_unnamed_80 = float4(fragment_unnamed_911.x, fragment_unnamed_911.y, fragment_unnamed_911.z, fragment_unnamed_80.w);
				float3 fragment_unnamed_925 = _Cube.Sample(sampler_Cube, fragment_unnamed_80.xyz).xyz;
				fragment_unnamed_80 = float4(fragment_unnamed_925.x, fragment_unnamed_925.y, fragment_unnamed_925.z, fragment_unnamed_80.w);
				float3 fragment_unnamed_932 = fragment_unnamed_95.xyz * fragment_unnamed_80.xyz;
				fragment_unnamed_80 = float4(fragment_unnamed_932.x, fragment_unnamed_932.y, fragment_unnamed_932.z, fragment_unnamed_80.w);
				float3 fragment_unnamed_943 = (fragment_unnamed_80.xyz * fragment_unnamed_95.www) + fragment_unnamed_9;
				fragment_output_0 = float4(fragment_unnamed_943.x, fragment_unnamed_943.y, fragment_unnamed_943.z, fragment_output_0.w);
				fragment_output_0.w = fragment_unnamed_95.w;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				unity_ObjectToWorld__array[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				unity_ObjectToWorld__array[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				unity_ObjectToWorld__array[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				unity_ObjectToWorld__array[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_0 = stage_input.fragment_input_0;
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_6 = stage_input.fragment_input_6;
				fragment_input_8 = stage_input.fragment_input_8;
				fragment_input_7 = stage_input.fragment_input_7;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // DIRECTIONAL
			#endif // LIGHTPROBE_SH
			#endif // VERTEXLIGHT_ON


			#ifdef DIRECTIONAL
			#ifndef LIGHTPROBE_SH
			#ifndef VERTEXLIGHT_ON
			#define ANY_SHADER_VARIANT_ACTIVE

			float4 _LightColor0;
			float4 _SpecColor;
			float _FaceUVSpeedX;
			float _FaceUVSpeedY;
			float4 _FaceColor;
			float _OutlineSoftness;
			float _OutlineUVSpeedX;
			float _OutlineUVSpeedY;
			float4 _OutlineColor;
			float _OutlineWidth;
			float _Bevel;
			float _BevelOffset;
			float _BevelWidth;
			float _BevelClamp;
			float _BevelRoundness;
			float _BumpOutline;
			float _BumpFace;
			float4 _ReflectFaceColor;
			float4 _ReflectOutlineColor;
			float _ShaderFlags;
			float _ScaleRatioA;
			float _TextureWidth;
			float _TextureHeight;
			float _GradientScale;
			float _FaceShininess;
			float _OutlineShininess;
			float4 _Time;
			float3 _WorldSpaceCameraPos;
			float4 _WorldSpaceLightPos0;
			float4 unity_SHAr;
			float4 unity_SHAg;
			float4 unity_SHAb;
			float4x4 unity_ObjectToWorld;

			static float4 fragment_uniform_buffer_0[32];
			static float4 fragment_uniform_buffer_1[5];
			static float4 fragment_uniform_buffer_2[42];
			static float4 fragment_uniform_buffer_3[4];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _FaceTex;
			Texture2D<float4> _OutlineTex;
			Texture2D<float4> _BumpMap;
			TextureCube<float4> _Cube;
			SamplerState sampler_FaceTex;
			SamplerState sampler_OutlineTex;
			SamplerState sampler_BumpMap;
			SamplerState sampler_Cube;
			SamplerState sampler_MainTex;

			static float4 fragment_input_1;
			static float2 fragment_input_2;
			static float2 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_input_5;
			static float4 fragment_input_6;
			static float3 fragment_input_7;
			static float3 fragment_input_8;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : TEXCOORD; // TEXCOORD
				float2 fragment_input_2 : TEXCOORD1; // TEXCOORD_1
				float2 fragment_input_2 : TEXCOORD5; // TEXCOORD_5
				float4 fragment_input_3 : TEXCOORD2; // TEXCOORD_2
				float4 fragment_input_4 : TEXCOORD3; // TEXCOORD_3
				float4 fragment_input_5 : TEXCOORD4; // TEXCOORD_4
				float4 fragment_input_6 : COLOR; // COLOR
				float3 fragment_input_7 : TEXCOORD6; // TEXCOORD_6
				float3 fragment_input_8 : TEXCOORD7; // TEXCOORD_7
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				precise float fragment_unnamed_78 = (-0.0f) - fragment_input_3.w;
				precise float fragment_unnamed_80 = (-0.0f) - fragment_input_4.w;
				precise float fragment_unnamed_81 = (-0.0f) - fragment_input_5.w;
				precise float fragment_unnamed_90 = fragment_unnamed_78 + fragment_uniform_buffer_1[4u].x;
				precise float fragment_unnamed_91 = fragment_unnamed_80 + fragment_uniform_buffer_1[4u].y;
				precise float fragment_unnamed_92 = fragment_unnamed_81 + fragment_uniform_buffer_1[4u].z;
				float fragment_unnamed_97 = rsqrt(dot(float3(fragment_unnamed_90, fragment_unnamed_91, fragment_unnamed_92), float3(fragment_unnamed_90, fragment_unnamed_91, fragment_unnamed_92)));
				float fragment_unnamed_103 = mad(fragment_unnamed_90, fragment_unnamed_97, fragment_uniform_buffer_2[0u].x);
				float fragment_unnamed_104 = mad(fragment_unnamed_91, fragment_unnamed_97, fragment_uniform_buffer_2[0u].y);
				float fragment_unnamed_105 = mad(fragment_unnamed_92, fragment_unnamed_97, fragment_uniform_buffer_2[0u].z);
				float fragment_unnamed_109 = rsqrt(dot(float3(fragment_unnamed_103, fragment_unnamed_104, fragment_unnamed_105), float3(fragment_unnamed_103, fragment_unnamed_104, fragment_unnamed_105)));
				precise float fragment_unnamed_110 = fragment_unnamed_109 * fragment_unnamed_103;
				precise float fragment_unnamed_111 = fragment_unnamed_109 * fragment_unnamed_104;
				precise float fragment_unnamed_112 = fragment_unnamed_109 * fragment_unnamed_105;
				precise float fragment_unnamed_119 = fragment_input_2.x + fragment_uniform_buffer_0[8u].z;
				precise float fragment_unnamed_125 = 1.0f / fragment_uniform_buffer_0[29u].z;
				precise float fragment_unnamed_127 = 1.0f / fragment_uniform_buffer_0[29u].w;
				float fragment_unnamed_128 = asfloat(0u);
				precise float fragment_unnamed_129 = (-0.0f) - fragment_unnamed_125;
				precise float fragment_unnamed_130 = (-0.0f) - fragment_unnamed_128;
				precise float fragment_unnamed_131 = (-0.0f) - fragment_unnamed_127;
				precise float fragment_unnamed_137 = fragment_unnamed_129 + fragment_input_1.x;
				precise float fragment_unnamed_138 = fragment_unnamed_130 + fragment_input_1.y;
				precise float fragment_unnamed_139 = fragment_unnamed_130 + fragment_input_1.x;
				precise float fragment_unnamed_140 = fragment_unnamed_131 + fragment_input_1.y;
				precise float fragment_unnamed_145 = fragment_unnamed_125 + fragment_input_1.x;
				precise float fragment_unnamed_146 = fragment_unnamed_128 + fragment_input_1.y;
				precise float fragment_unnamed_147 = fragment_unnamed_128 + fragment_input_1.x;
				precise float fragment_unnamed_148 = fragment_unnamed_127 + fragment_input_1.y;
				precise float fragment_unnamed_164 = fragment_unnamed_119 + _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_137, fragment_unnamed_138)).w;
				precise float fragment_unnamed_165 = fragment_unnamed_119 + _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_145, fragment_unnamed_146)).w;
				precise float fragment_unnamed_166 = fragment_unnamed_119 + _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_139, fragment_unnamed_140)).w;
				precise float fragment_unnamed_167 = fragment_unnamed_119 + _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_147, fragment_unnamed_148)).w;
				precise float fragment_unnamed_168 = fragment_unnamed_164 + (-0.5f);
				precise float fragment_unnamed_170 = fragment_unnamed_165 + (-0.5f);
				precise float fragment_unnamed_171 = fragment_unnamed_166 + (-0.5f);
				precise float fragment_unnamed_172 = fragment_unnamed_167 + (-0.5f);
				precise float fragment_unnamed_179 = fragment_uniform_buffer_0[8u].w + fragment_uniform_buffer_0[8u].x;
				float fragment_unnamed_180 = max(fragment_unnamed_179, 0.00999999977648258209228515625f);
				precise float fragment_unnamed_182 = fragment_unnamed_168 / fragment_unnamed_180;
				precise float fragment_unnamed_183 = fragment_unnamed_170 / fragment_unnamed_180;
				precise float fragment_unnamed_184 = fragment_unnamed_171 / fragment_unnamed_180;
				precise float fragment_unnamed_185 = fragment_unnamed_172 / fragment_unnamed_180;
				precise float fragment_unnamed_189 = fragment_unnamed_180 * fragment_uniform_buffer_0[8u].y;
				precise float fragment_unnamed_194 = fragment_unnamed_189 * fragment_uniform_buffer_0[30u].x;
				precise float fragment_unnamed_195 = fragment_unnamed_194 * (-2.0f);
				precise float fragment_unnamed_197 = fragment_unnamed_182 + 0.5f;
				precise float fragment_unnamed_199 = fragment_unnamed_183 + 0.5f;
				precise float fragment_unnamed_200 = fragment_unnamed_184 + 0.5f;
				precise float fragment_unnamed_201 = fragment_unnamed_185 + 0.5f;
				float fragment_unnamed_202 = clamp(fragment_unnamed_197, 0.0f, 1.0f);
				float fragment_unnamed_203 = clamp(fragment_unnamed_199, 0.0f, 1.0f);
				float fragment_unnamed_204 = clamp(fragment_unnamed_200, 0.0f, 1.0f);
				float fragment_unnamed_205 = clamp(fragment_unnamed_201, 0.0f, 1.0f);
				precise float fragment_unnamed_213 = (-0.0f) - abs(mad(fragment_unnamed_202, 2.0f, -1.0f));
				precise float fragment_unnamed_215 = (-0.0f) - abs(mad(fragment_unnamed_203, 2.0f, -1.0f));
				precise float fragment_unnamed_217 = (-0.0f) - abs(mad(fragment_unnamed_204, 2.0f, -1.0f));
				precise float fragment_unnamed_219 = (-0.0f) - abs(mad(fragment_unnamed_205, 2.0f, -1.0f));
				precise float fragment_unnamed_220 = fragment_unnamed_213 + 1.0f;
				precise float fragment_unnamed_221 = fragment_unnamed_215 + 1.0f;
				precise float fragment_unnamed_222 = fragment_unnamed_217 + 1.0f;
				precise float fragment_unnamed_223 = fragment_unnamed_219 + 1.0f;
				precise float fragment_unnamed_228 = fragment_uniform_buffer_0[24u].x * 0.5f;
				precise float fragment_unnamed_229 = (-0.0f) - fragment_unnamed_228;
				float fragment_unnamed_233 = frac(abs(fragment_unnamed_228));
				precise float fragment_unnamed_234 = (-0.0f) - fragment_unnamed_233;
				bool fragment_unnamed_236 = ((fragment_unnamed_228 >= fragment_unnamed_229) ? fragment_unnamed_233 : fragment_unnamed_234) >= 0.5f;
				float fragment_unnamed_246 = asfloat(fragment_unnamed_236 ? asuint(fragment_unnamed_220) : asuint(fragment_unnamed_202));
				float fragment_unnamed_248 = asfloat(fragment_unnamed_236 ? asuint(fragment_unnamed_221) : asuint(fragment_unnamed_203));
				float fragment_unnamed_250 = asfloat(fragment_unnamed_236 ? asuint(fragment_unnamed_222) : asuint(fragment_unnamed_204));
				float fragment_unnamed_252 = asfloat(fragment_unnamed_236 ? asuint(fragment_unnamed_223) : asuint(fragment_unnamed_205));
				precise float fragment_unnamed_253 = fragment_unnamed_246 * 1.57079601287841796875f;
				precise float fragment_unnamed_255 = fragment_unnamed_248 * 1.57079601287841796875f;
				precise float fragment_unnamed_256 = fragment_unnamed_250 * 1.57079601287841796875f;
				precise float fragment_unnamed_257 = fragment_unnamed_252 * 1.57079601287841796875f;
				precise float fragment_unnamed_262 = (-0.0f) - fragment_unnamed_246;
				precise float fragment_unnamed_263 = (-0.0f) - fragment_unnamed_248;
				precise float fragment_unnamed_264 = (-0.0f) - fragment_unnamed_250;
				precise float fragment_unnamed_265 = (-0.0f) - fragment_unnamed_252;
				precise float fragment_unnamed_266 = fragment_unnamed_262 + sin(fragment_unnamed_253);
				precise float fragment_unnamed_267 = fragment_unnamed_263 + sin(fragment_unnamed_255);
				precise float fragment_unnamed_268 = fragment_unnamed_264 + sin(fragment_unnamed_256);
				precise float fragment_unnamed_269 = fragment_unnamed_265 + sin(fragment_unnamed_257);
				precise float fragment_unnamed_281 = (-0.0f) - fragment_uniform_buffer_0[9u].x;
				precise float fragment_unnamed_282 = fragment_unnamed_281 + 1.0f;
				precise float fragment_unnamed_287 = fragment_unnamed_195 * min(mad(fragment_uniform_buffer_0[9u].y, fragment_unnamed_266, fragment_unnamed_246), fragment_unnamed_282);
				precise float fragment_unnamed_288 = fragment_unnamed_195 * min(mad(fragment_uniform_buffer_0[9u].y, fragment_unnamed_268, fragment_unnamed_250), fragment_unnamed_282);
				precise float fragment_unnamed_289 = (-0.0f) - fragment_unnamed_288;
				precise float fragment_unnamed_290 = (-0.0f) - fragment_unnamed_287;
				float fragment_unnamed_291 = mad(min(mad(fragment_uniform_buffer_0[9u].y, fragment_unnamed_269, fragment_unnamed_252), fragment_unnamed_282), fragment_unnamed_195, fragment_unnamed_289);
				float fragment_unnamed_292 = mad(min(mad(fragment_uniform_buffer_0[9u].y, fragment_unnamed_267, fragment_unnamed_248), fragment_unnamed_282), fragment_unnamed_195, fragment_unnamed_290);
				float fragment_unnamed_293 = asfloat(3212836864u);
				float fragment_unnamed_295 = asfloat(1065353216u);
				float fragment_unnamed_300 = rsqrt(dot(float2(fragment_unnamed_293, fragment_unnamed_291), float2(fragment_unnamed_293, fragment_unnamed_291)));
				float fragment_unnamed_304 = rsqrt(dot(float2(fragment_unnamed_292, fragment_unnamed_295), float2(fragment_unnamed_292, fragment_unnamed_295)));
				precise float fragment_unnamed_305 = fragment_unnamed_304 * fragment_unnamed_292;
				precise float fragment_unnamed_306 = fragment_unnamed_304 * 1.0f;
				precise float fragment_unnamed_307 = fragment_unnamed_304 * 0.0f;
				precise float fragment_unnamed_309 = fragment_unnamed_300 * fragment_unnamed_293;
				precise float fragment_unnamed_310 = fragment_unnamed_300 * fragment_unnamed_291;
				precise float fragment_unnamed_311 = fragment_unnamed_300 * asfloat(0u);
				precise float fragment_unnamed_312 = fragment_unnamed_309 * fragment_unnamed_305;
				precise float fragment_unnamed_313 = fragment_unnamed_310 * fragment_unnamed_306;
				precise float fragment_unnamed_314 = fragment_unnamed_311 * fragment_unnamed_307;
				precise float fragment_unnamed_315 = (-0.0f) - fragment_unnamed_312;
				precise float fragment_unnamed_316 = (-0.0f) - fragment_unnamed_313;
				precise float fragment_unnamed_317 = (-0.0f) - fragment_unnamed_314;
				float4 fragment_unnamed_336 = _OutlineTex.Sample(sampler_OutlineTex, float2(mad(fragment_uniform_buffer_0[6u].z, fragment_uniform_buffer_1[0u].y, fragment_input_2.x), mad(fragment_uniform_buffer_0[6u].w, fragment_uniform_buffer_1[0u].y, fragment_input_2.y)));
				precise float fragment_unnamed_348 = fragment_unnamed_336.x * fragment_uniform_buffer_0[7u].x;
				precise float fragment_unnamed_349 = fragment_unnamed_336.y * fragment_uniform_buffer_0[7u].y;
				precise float fragment_unnamed_350 = fragment_unnamed_336.z * fragment_uniform_buffer_0[7u].z;
				precise float fragment_unnamed_356 = fragment_input_6.w * fragment_uniform_buffer_0[7u].w;
				precise float fragment_unnamed_357 = fragment_unnamed_336.w * fragment_unnamed_356;
				precise float fragment_unnamed_358 = fragment_unnamed_348 * fragment_unnamed_357;
				precise float fragment_unnamed_359 = fragment_unnamed_349 * fragment_unnamed_357;
				precise float fragment_unnamed_360 = fragment_unnamed_350 * fragment_unnamed_357;
				float4 fragment_unnamed_376 = _FaceTex.Sample(sampler_FaceTex, float2(mad(fragment_uniform_buffer_0[4u].x, fragment_uniform_buffer_1[0u].y, fragment_input_1.z), mad(fragment_uniform_buffer_0[4u].y, fragment_uniform_buffer_1[0u].y, fragment_input_1.w)));
				precise float fragment_unnamed_396 = fragment_input_6.x * fragment_uniform_buffer_0[5u].x;
				precise float fragment_unnamed_397 = fragment_input_6.y * fragment_uniform_buffer_0[5u].y;
				precise float fragment_unnamed_398 = fragment_input_6.z * fragment_uniform_buffer_0[5u].z;
				precise float fragment_unnamed_399 = fragment_input_6.w * fragment_uniform_buffer_0[5u].w;
				precise float fragment_unnamed_400 = fragment_unnamed_376.x * fragment_unnamed_396;
				precise float fragment_unnamed_401 = fragment_unnamed_376.y * fragment_unnamed_397;
				precise float fragment_unnamed_402 = fragment_unnamed_376.z * fragment_unnamed_398;
				precise float fragment_unnamed_403 = fragment_unnamed_376.w * fragment_unnamed_399;
				precise float fragment_unnamed_404 = fragment_unnamed_403 * fragment_unnamed_400;
				precise float fragment_unnamed_405 = fragment_unnamed_403 * fragment_unnamed_401;
				precise float fragment_unnamed_406 = fragment_unnamed_403 * fragment_unnamed_402;
				precise float fragment_unnamed_407 = (-0.0f) - fragment_unnamed_404;
				precise float fragment_unnamed_408 = (-0.0f) - fragment_unnamed_405;
				precise float fragment_unnamed_409 = (-0.0f) - fragment_unnamed_406;
				precise float fragment_unnamed_410 = (-0.0f) - fragment_unnamed_403;
				precise float fragment_unnamed_411 = fragment_unnamed_407 + fragment_unnamed_358;
				precise float fragment_unnamed_412 = fragment_unnamed_408 + fragment_unnamed_359;
				precise float fragment_unnamed_413 = fragment_unnamed_409 + fragment_unnamed_360;
				precise float fragment_unnamed_414 = fragment_unnamed_410 + fragment_unnamed_357;
				precise float fragment_unnamed_421 = fragment_uniform_buffer_0[8u].x * fragment_uniform_buffer_0[24u].w;
				precise float fragment_unnamed_424 = fragment_unnamed_421 * fragment_input_2.y;
				precise float fragment_unnamed_434 = (-0.0f) - _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y)).w;
				precise float fragment_unnamed_435 = fragment_unnamed_434 + 0.5f;
				precise float fragment_unnamed_438 = (-0.0f) - fragment_input_2.x;
				precise float fragment_unnamed_439 = fragment_unnamed_435 + fragment_unnamed_438;
				float fragment_unnamed_442 = mad(fragment_unnamed_439, fragment_input_2.y, 0.5f);
				float fragment_unnamed_444 = clamp(mad(fragment_unnamed_424, 0.5f, fragment_unnamed_442), 0.0f, 1.0f);
				precise float fragment_unnamed_445 = (-0.0f) - fragment_unnamed_424;
				precise float fragment_unnamed_447 = sqrt(min(fragment_unnamed_424, 1.0f)) * fragment_unnamed_444;
				precise float fragment_unnamed_458 = fragment_uniform_buffer_0[6u].y * fragment_uniform_buffer_0[24u].w;
				precise float fragment_unnamed_461 = fragment_unnamed_458 * fragment_input_2.y;
				precise float fragment_unnamed_466 = mad(fragment_unnamed_461, 0.5f, mad(fragment_unnamed_445, 0.5f, fragment_unnamed_442)) / mad(fragment_unnamed_458, fragment_input_2.y, 1.0f);
				precise float fragment_unnamed_468 = (-0.0f) - clamp(fragment_unnamed_466, 0.0f, 1.0f);
				precise float fragment_unnamed_469 = fragment_unnamed_468 + 1.0f;
				precise float fragment_unnamed_470 = fragment_unnamed_469 * mad(fragment_unnamed_447, fragment_unnamed_411, fragment_unnamed_404);
				precise float fragment_unnamed_471 = fragment_unnamed_469 * mad(fragment_unnamed_447, fragment_unnamed_412, fragment_unnamed_405);
				precise float fragment_unnamed_472 = fragment_unnamed_469 * mad(fragment_unnamed_447, fragment_unnamed_413, fragment_unnamed_406);
				precise float fragment_unnamed_473 = fragment_unnamed_469 * mad(fragment_unnamed_447, fragment_unnamed_414, fragment_unnamed_403);
				precise float fragment_unnamed_477 = (-0.0f) - fragment_uniform_buffer_0[9u].w;
				precise float fragment_unnamed_481 = fragment_unnamed_477 + fragment_uniform_buffer_0[9u].z;
				float fragment_unnamed_485 = mad(fragment_unnamed_444, fragment_unnamed_481, fragment_uniform_buffer_0[9u].w);
				float4 fragment_unnamed_491 = _BumpMap.Sample(sampler_BumpMap, float2(fragment_input_1.z, fragment_input_1.w));
				precise float fragment_unnamed_496 = fragment_unnamed_491.w * fragment_unnamed_491.x;
				float fragment_unnamed_497 = mad(fragment_unnamed_496, 2.0f, -1.0f);
				float fragment_unnamed_498 = mad(fragment_unnamed_491.y, 2.0f, -1.0f);
				precise float fragment_unnamed_503 = (-0.0f) - min(dot(float2(fragment_unnamed_497, fragment_unnamed_498), float2(fragment_unnamed_497, fragment_unnamed_498)), 1.0f);
				precise float fragment_unnamed_504 = fragment_unnamed_503 + 1.0f;
				precise float fragment_unnamed_512 = (-0.0f) - mad(fragment_unnamed_473, mad(fragment_unnamed_497, fragment_unnamed_485, -0.0f), 0.0f);
				precise float fragment_unnamed_513 = (-0.0f) - mad(fragment_unnamed_473, mad(fragment_unnamed_498, fragment_unnamed_485, -0.0f), 0.0f);
				precise float fragment_unnamed_514 = (-0.0f) - mad(fragment_unnamed_473, mad(sqrt(fragment_unnamed_504), fragment_unnamed_485, -1.0f), 1.0f);
				precise float fragment_unnamed_515 = mad(fragment_unnamed_307, fragment_unnamed_310, fragment_unnamed_315) + fragment_unnamed_512;
				precise float fragment_unnamed_516 = mad(fragment_unnamed_305, fragment_unnamed_311, fragment_unnamed_316) + fragment_unnamed_513;
				precise float fragment_unnamed_517 = mad(fragment_unnamed_306, fragment_unnamed_309, fragment_unnamed_317) + fragment_unnamed_514;
				float fragment_unnamed_521 = rsqrt(dot(float3(fragment_unnamed_515, fragment_unnamed_516, fragment_unnamed_517), float3(fragment_unnamed_515, fragment_unnamed_516, fragment_unnamed_517)));
				precise float fragment_unnamed_522 = fragment_unnamed_521 * fragment_unnamed_515;
				precise float fragment_unnamed_523 = fragment_unnamed_521 * fragment_unnamed_516;
				precise float fragment_unnamed_524 = fragment_unnamed_521 * fragment_unnamed_517;
				precise float fragment_unnamed_531 = (-0.0f) - fragment_unnamed_522;
				precise float fragment_unnamed_532 = (-0.0f) - fragment_unnamed_523;
				precise float fragment_unnamed_533 = (-0.0f) - fragment_unnamed_524;
				float fragment_unnamed_534 = dot(float3(fragment_input_3.x, fragment_input_3.y, fragment_input_3.z), float3(fragment_unnamed_531, fragment_unnamed_532, fragment_unnamed_533));
				precise float fragment_unnamed_543 = (-0.0f) - fragment_unnamed_522;
				precise float fragment_unnamed_544 = (-0.0f) - fragment_unnamed_523;
				precise float fragment_unnamed_545 = (-0.0f) - fragment_unnamed_524;
				float fragment_unnamed_546 = dot(float3(fragment_input_4.x, fragment_input_4.y, fragment_input_4.z), float3(fragment_unnamed_543, fragment_unnamed_544, fragment_unnamed_545));
				precise float fragment_unnamed_555 = (-0.0f) - fragment_unnamed_522;
				precise float fragment_unnamed_556 = (-0.0f) - fragment_unnamed_523;
				precise float fragment_unnamed_557 = (-0.0f) - fragment_unnamed_524;
				float fragment_unnamed_558 = dot(float3(fragment_input_5.x, fragment_input_5.y, fragment_input_5.z), float3(fragment_unnamed_555, fragment_unnamed_556, fragment_unnamed_557));
				float fragment_unnamed_564 = rsqrt(dot(float3(fragment_unnamed_534, fragment_unnamed_546, fragment_unnamed_558), float3(fragment_unnamed_534, fragment_unnamed_546, fragment_unnamed_558)));
				precise float fragment_unnamed_565 = fragment_unnamed_564 * fragment_unnamed_534;
				precise float fragment_unnamed_566 = fragment_unnamed_564 * fragment_unnamed_546;
				precise float fragment_unnamed_567 = fragment_unnamed_564 * fragment_unnamed_558;
				precise float fragment_unnamed_577 = (-0.0f) - fragment_uniform_buffer_0[31u].y;
				precise float fragment_unnamed_581 = fragment_unnamed_577 + fragment_uniform_buffer_0[31u].z;
				precise float fragment_unnamed_586 = mad(fragment_unnamed_444, fragment_unnamed_581, fragment_uniform_buffer_0[31u].y) * 128.0f;
				precise float fragment_unnamed_588 = log2(max(dot(float3(fragment_unnamed_565, fragment_unnamed_566, fragment_unnamed_567), float3(fragment_unnamed_110, fragment_unnamed_111, fragment_unnamed_112)), 0.0f)) * fragment_unnamed_586;
				float fragment_unnamed_589 = exp2(fragment_unnamed_588);
				precise float fragment_unnamed_600 = fragment_uniform_buffer_0[2u].x * fragment_uniform_buffer_0[3u].x;
				precise float fragment_unnamed_601 = fragment_uniform_buffer_0[2u].y * fragment_uniform_buffer_0[3u].y;
				precise float fragment_unnamed_602 = fragment_uniform_buffer_0[2u].z * fragment_uniform_buffer_0[3u].z;
				precise float fragment_unnamed_603 = fragment_unnamed_589 * fragment_unnamed_600;
				precise float fragment_unnamed_604 = fragment_unnamed_589 * fragment_unnamed_601;
				precise float fragment_unnamed_605 = fragment_unnamed_589 * fragment_unnamed_602;
				float fragment_unnamed_614 = max(dot(float3(fragment_unnamed_565, fragment_unnamed_566, fragment_unnamed_567), float3(fragment_uniform_buffer_2[0u].xyz)), 0.0f);
				float fragment_unnamed_615 = max(fragment_unnamed_473, 9.9999997473787516355514526367188e-05f);
				precise float fragment_unnamed_617 = fragment_unnamed_470 / fragment_unnamed_615;
				precise float fragment_unnamed_618 = fragment_unnamed_471 / fragment_unnamed_615;
				precise float fragment_unnamed_619 = fragment_unnamed_472 / fragment_unnamed_615;
				precise float fragment_unnamed_625 = fragment_unnamed_617 * fragment_uniform_buffer_0[2u].x;
				precise float fragment_unnamed_626 = fragment_unnamed_618 * fragment_uniform_buffer_0[2u].y;
				precise float fragment_unnamed_627 = fragment_unnamed_619 * fragment_uniform_buffer_0[2u].z;
				float fragment_unnamed_631 = asfloat(1065353216u);
				precise float fragment_unnamed_668 = dot(float4(fragment_uniform_buffer_2[39u]), float4(fragment_unnamed_565, fragment_unnamed_566, fragment_unnamed_567, fragment_unnamed_631)) + fragment_input_8.x;
				precise float fragment_unnamed_669 = dot(float4(fragment_uniform_buffer_2[40u]), float4(fragment_unnamed_565, fragment_unnamed_566, fragment_unnamed_567, fragment_unnamed_631)) + fragment_input_8.y;
				precise float fragment_unnamed_670 = dot(float4(fragment_uniform_buffer_2[41u]), float4(fragment_unnamed_565, fragment_unnamed_566, fragment_unnamed_567, fragment_unnamed_631)) + fragment_input_8.z;
				precise float fragment_unnamed_677 = log2(max(fragment_unnamed_668, 0.0f)) * 0.4166666567325592041015625f;
				precise float fragment_unnamed_679 = log2(max(fragment_unnamed_669, 0.0f)) * 0.4166666567325592041015625f;
				precise float fragment_unnamed_680 = log2(max(fragment_unnamed_670, 0.0f)) * 0.4166666567325592041015625f;
				precise float fragment_unnamed_699 = (-0.0f) - fragment_uniform_buffer_0[10u].x;
				precise float fragment_unnamed_701 = (-0.0f) - fragment_uniform_buffer_0[10u].y;
				precise float fragment_unnamed_703 = (-0.0f) - fragment_uniform_buffer_0[10u].z;
				precise float fragment_unnamed_710 = fragment_unnamed_699 + fragment_uniform_buffer_0[11u].x;
				precise float fragment_unnamed_711 = fragment_unnamed_701 + fragment_uniform_buffer_0[11u].y;
				precise float fragment_unnamed_712 = fragment_unnamed_703 + fragment_uniform_buffer_0[11u].z;
				precise float fragment_unnamed_726 = fragment_unnamed_523 * fragment_uniform_buffer_3[1u].x;
				precise float fragment_unnamed_727 = fragment_unnamed_523 * fragment_uniform_buffer_3[1u].y;
				precise float fragment_unnamed_728 = fragment_unnamed_523 * fragment_uniform_buffer_3[1u].z;
				float fragment_unnamed_742 = mad(fragment_uniform_buffer_3[2u].x, fragment_unnamed_524, mad(fragment_uniform_buffer_3[0u].x, fragment_unnamed_522, fragment_unnamed_726));
				float fragment_unnamed_743 = mad(fragment_uniform_buffer_3[2u].y, fragment_unnamed_524, mad(fragment_uniform_buffer_3[0u].y, fragment_unnamed_522, fragment_unnamed_727));
				float fragment_unnamed_744 = mad(fragment_uniform_buffer_3[2u].z, fragment_unnamed_524, mad(fragment_uniform_buffer_3[0u].z, fragment_unnamed_522, fragment_unnamed_728));
				float fragment_unnamed_751 = dot(float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z), float3(fragment_unnamed_742, fragment_unnamed_743, fragment_unnamed_744));
				precise float fragment_unnamed_754 = fragment_unnamed_751 + fragment_unnamed_751;
				precise float fragment_unnamed_755 = (-0.0f) - fragment_unnamed_754;
				float4 fragment_unnamed_767 = _Cube.Sample(sampler_Cube, float3(mad(fragment_unnamed_742, fragment_unnamed_755, fragment_input_7.x), mad(fragment_unnamed_743, fragment_unnamed_755, fragment_input_7.y), mad(fragment_unnamed_744, fragment_unnamed_755, fragment_input_7.z)));
				precise float fragment_unnamed_772 = mad(fragment_unnamed_444, fragment_unnamed_710, fragment_uniform_buffer_0[10u].x) * fragment_unnamed_767.x;
				precise float fragment_unnamed_773 = mad(fragment_unnamed_444, fragment_unnamed_711, fragment_uniform_buffer_0[10u].y) * fragment_unnamed_767.y;
				precise float fragment_unnamed_774 = mad(fragment_unnamed_444, fragment_unnamed_712, fragment_uniform_buffer_0[10u].z) * fragment_unnamed_767.z;
				fragment_output_0.x = mad(fragment_unnamed_772, fragment_unnamed_473, mad(fragment_unnamed_617, max(mad(exp2(fragment_unnamed_677), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f), mad(fragment_unnamed_625, fragment_unnamed_614, fragment_unnamed_603)));
				fragment_output_0.y = mad(fragment_unnamed_773, fragment_unnamed_473, mad(fragment_unnamed_618, max(mad(exp2(fragment_unnamed_679), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f), mad(fragment_unnamed_626, fragment_unnamed_614, fragment_unnamed_604)));
				fragment_output_0.z = mad(fragment_unnamed_774, fragment_unnamed_473, mad(fragment_unnamed_619, max(mad(exp2(fragment_unnamed_680), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f), mad(fragment_unnamed_627, fragment_unnamed_614, fragment_unnamed_605)));
				fragment_output_0.w = fragment_unnamed_473;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[2] = float4(_LightColor0[0], _LightColor0[1], _LightColor0[2], _LightColor0[3]);

				fragment_uniform_buffer_0[3] = float4(_SpecColor[0], _SpecColor[1], _SpecColor[2], _SpecColor[3]);

				fragment_uniform_buffer_0[4] = float4(_FaceUVSpeedX, fragment_uniform_buffer_0[4][1], fragment_uniform_buffer_0[4][2], fragment_uniform_buffer_0[4][3]);

				fragment_uniform_buffer_0[4] = float4(fragment_uniform_buffer_0[4][0], _FaceUVSpeedY, fragment_uniform_buffer_0[4][2], fragment_uniform_buffer_0[4][3]);

				fragment_uniform_buffer_0[5] = float4(_FaceColor[0], _FaceColor[1], _FaceColor[2], _FaceColor[3]);

				fragment_uniform_buffer_0[6] = float4(fragment_uniform_buffer_0[6][0], _OutlineSoftness, fragment_uniform_buffer_0[6][2], fragment_uniform_buffer_0[6][3]);

				fragment_uniform_buffer_0[6] = float4(fragment_uniform_buffer_0[6][0], fragment_uniform_buffer_0[6][1], _OutlineUVSpeedX, fragment_uniform_buffer_0[6][3]);

				fragment_uniform_buffer_0[6] = float4(fragment_uniform_buffer_0[6][0], fragment_uniform_buffer_0[6][1], fragment_uniform_buffer_0[6][2], _OutlineUVSpeedY);

				fragment_uniform_buffer_0[7] = float4(_OutlineColor[0], _OutlineColor[1], _OutlineColor[2], _OutlineColor[3]);

				fragment_uniform_buffer_0[8] = float4(_OutlineWidth, fragment_uniform_buffer_0[8][1], fragment_uniform_buffer_0[8][2], fragment_uniform_buffer_0[8][3]);

				fragment_uniform_buffer_0[8] = float4(fragment_uniform_buffer_0[8][0], _Bevel, fragment_uniform_buffer_0[8][2], fragment_uniform_buffer_0[8][3]);

				fragment_uniform_buffer_0[8] = float4(fragment_uniform_buffer_0[8][0], fragment_uniform_buffer_0[8][1], _BevelOffset, fragment_uniform_buffer_0[8][3]);

				fragment_uniform_buffer_0[8] = float4(fragment_uniform_buffer_0[8][0], fragment_uniform_buffer_0[8][1], fragment_uniform_buffer_0[8][2], _BevelWidth);

				fragment_uniform_buffer_0[9] = float4(_BevelClamp, fragment_uniform_buffer_0[9][1], fragment_uniform_buffer_0[9][2], fragment_uniform_buffer_0[9][3]);

				fragment_uniform_buffer_0[9] = float4(fragment_uniform_buffer_0[9][0], _BevelRoundness, fragment_uniform_buffer_0[9][2], fragment_uniform_buffer_0[9][3]);

				fragment_uniform_buffer_0[9] = float4(fragment_uniform_buffer_0[9][0], fragment_uniform_buffer_0[9][1], _BumpOutline, fragment_uniform_buffer_0[9][3]);

				fragment_uniform_buffer_0[9] = float4(fragment_uniform_buffer_0[9][0], fragment_uniform_buffer_0[9][1], fragment_uniform_buffer_0[9][2], _BumpFace);

				fragment_uniform_buffer_0[10] = float4(_ReflectFaceColor[0], _ReflectFaceColor[1], _ReflectFaceColor[2], _ReflectFaceColor[3]);

				fragment_uniform_buffer_0[11] = float4(_ReflectOutlineColor[0], _ReflectOutlineColor[1], _ReflectOutlineColor[2], _ReflectOutlineColor[3]);

				fragment_uniform_buffer_0[24] = float4(_ShaderFlags, fragment_uniform_buffer_0[24][1], fragment_uniform_buffer_0[24][2], fragment_uniform_buffer_0[24][3]);

				fragment_uniform_buffer_0[24] = float4(fragment_uniform_buffer_0[24][0], fragment_uniform_buffer_0[24][1], fragment_uniform_buffer_0[24][2], _ScaleRatioA);

				fragment_uniform_buffer_0[29] = float4(fragment_uniform_buffer_0[29][0], fragment_uniform_buffer_0[29][1], _TextureWidth, fragment_uniform_buffer_0[29][3]);

				fragment_uniform_buffer_0[29] = float4(fragment_uniform_buffer_0[29][0], fragment_uniform_buffer_0[29][1], fragment_uniform_buffer_0[29][2], _TextureHeight);

				fragment_uniform_buffer_0[30] = float4(_GradientScale, fragment_uniform_buffer_0[30][1], fragment_uniform_buffer_0[30][2], fragment_uniform_buffer_0[30][3]);

				fragment_uniform_buffer_0[31] = float4(fragment_uniform_buffer_0[31][0], _FaceShininess, fragment_uniform_buffer_0[31][2], fragment_uniform_buffer_0[31][3]);

				fragment_uniform_buffer_0[31] = float4(fragment_uniform_buffer_0[31][0], fragment_uniform_buffer_0[31][1], _OutlineShininess, fragment_uniform_buffer_0[31][3]);

				fragment_uniform_buffer_1[0] = float4(_Time[0], _Time[1], _Time[2], _Time[3]);

				fragment_uniform_buffer_1[4] = float4(_WorldSpaceCameraPos[0], _WorldSpaceCameraPos[1], _WorldSpaceCameraPos[2], fragment_uniform_buffer_1[4][3]);

				fragment_uniform_buffer_2[0] = float4(_WorldSpaceLightPos0[0], _WorldSpaceLightPos0[1], _WorldSpaceLightPos0[2], _WorldSpaceLightPos0[3]);

				fragment_uniform_buffer_2[39] = float4(unity_SHAr[0], unity_SHAr[1], unity_SHAr[2], unity_SHAr[3]);

				fragment_uniform_buffer_2[40] = float4(unity_SHAg[0], unity_SHAg[1], unity_SHAg[2], unity_SHAg[3]);

				fragment_uniform_buffer_2[41] = float4(unity_SHAb[0], unity_SHAb[1], unity_SHAb[2], unity_SHAb[3]);

				fragment_uniform_buffer_3[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				fragment_uniform_buffer_3[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				fragment_uniform_buffer_3[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				fragment_uniform_buffer_3[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				fragment_input_6 = stage_input.fragment_input_6;
				fragment_input_7 = stage_input.fragment_input_7;
				fragment_input_8 = stage_input.fragment_input_8;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // DIRECTIONAL
			#endif // !LIGHTPROBE_SH
			#endif // !VERTEXLIGHT_ON


			#ifdef DIRECTIONAL
			#ifdef LIGHTPROBE_SH
			#ifndef VERTEXLIGHT_ON
			#define ANY_SHADER_VARIANT_ACTIVE

			float4 _LightColor0;
			float4 _SpecColor;
			float _FaceUVSpeedX;
			float _FaceUVSpeedY;
			float4 _FaceColor;
			float _OutlineSoftness;
			float _OutlineUVSpeedX;
			float _OutlineUVSpeedY;
			float4 _OutlineColor;
			float _OutlineWidth;
			float _Bevel;
			float _BevelOffset;
			float _BevelWidth;
			float _BevelClamp;
			float _BevelRoundness;
			float _BumpOutline;
			float _BumpFace;
			float4 _ReflectFaceColor;
			float4 _ReflectOutlineColor;
			float _ShaderFlags;
			float _ScaleRatioA;
			float _TextureWidth;
			float _TextureHeight;
			float _GradientScale;
			float _FaceShininess;
			float _OutlineShininess;
			float4 _Time;
			float3 _WorldSpaceCameraPos;
			float4 _WorldSpaceLightPos0;
			float4 unity_SHAr;
			float4 unity_SHAg;
			float4 unity_SHAb;
			float4x4 unity_ObjectToWorld;

			static float4 fragment_uniform_buffer_0[32];
			static float4 fragment_uniform_buffer_1[5];
			static float4 fragment_uniform_buffer_2[42];
			static float4 fragment_uniform_buffer_3[4];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _FaceTex;
			Texture2D<float4> _OutlineTex;
			Texture2D<float4> _BumpMap;
			TextureCube<float4> _Cube;
			SamplerState sampler_FaceTex;
			SamplerState sampler_OutlineTex;
			SamplerState sampler_BumpMap;
			SamplerState sampler_Cube;
			SamplerState sampler_MainTex;

			static float4 fragment_input_1;
			static float2 fragment_input_2;
			static float2 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_input_5;
			static float4 fragment_input_6;
			static float3 fragment_input_7;
			static float3 fragment_input_8;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : TEXCOORD; // TEXCOORD
				float2 fragment_input_2 : TEXCOORD1; // TEXCOORD_1
				float2 fragment_input_2 : TEXCOORD5; // TEXCOORD_5
				float4 fragment_input_3 : TEXCOORD2; // TEXCOORD_2
				float4 fragment_input_4 : TEXCOORD3; // TEXCOORD_3
				float4 fragment_input_5 : TEXCOORD4; // TEXCOORD_4
				float4 fragment_input_6 : COLOR; // COLOR
				float3 fragment_input_7 : TEXCOORD6; // TEXCOORD_6
				float3 fragment_input_8 : TEXCOORD7; // TEXCOORD_7
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				precise float fragment_unnamed_78 = (-0.0f) - fragment_input_3.w;
				precise float fragment_unnamed_80 = (-0.0f) - fragment_input_4.w;
				precise float fragment_unnamed_81 = (-0.0f) - fragment_input_5.w;
				precise float fragment_unnamed_90 = fragment_unnamed_78 + fragment_uniform_buffer_1[4u].x;
				precise float fragment_unnamed_91 = fragment_unnamed_80 + fragment_uniform_buffer_1[4u].y;
				precise float fragment_unnamed_92 = fragment_unnamed_81 + fragment_uniform_buffer_1[4u].z;
				float fragment_unnamed_97 = rsqrt(dot(float3(fragment_unnamed_90, fragment_unnamed_91, fragment_unnamed_92), float3(fragment_unnamed_90, fragment_unnamed_91, fragment_unnamed_92)));
				float fragment_unnamed_103 = mad(fragment_unnamed_90, fragment_unnamed_97, fragment_uniform_buffer_2[0u].x);
				float fragment_unnamed_104 = mad(fragment_unnamed_91, fragment_unnamed_97, fragment_uniform_buffer_2[0u].y);
				float fragment_unnamed_105 = mad(fragment_unnamed_92, fragment_unnamed_97, fragment_uniform_buffer_2[0u].z);
				float fragment_unnamed_109 = rsqrt(dot(float3(fragment_unnamed_103, fragment_unnamed_104, fragment_unnamed_105), float3(fragment_unnamed_103, fragment_unnamed_104, fragment_unnamed_105)));
				precise float fragment_unnamed_110 = fragment_unnamed_109 * fragment_unnamed_103;
				precise float fragment_unnamed_111 = fragment_unnamed_109 * fragment_unnamed_104;
				precise float fragment_unnamed_112 = fragment_unnamed_109 * fragment_unnamed_105;
				precise float fragment_unnamed_119 = fragment_input_2.x + fragment_uniform_buffer_0[8u].z;
				precise float fragment_unnamed_125 = 1.0f / fragment_uniform_buffer_0[29u].z;
				precise float fragment_unnamed_127 = 1.0f / fragment_uniform_buffer_0[29u].w;
				float fragment_unnamed_128 = asfloat(0u);
				precise float fragment_unnamed_129 = (-0.0f) - fragment_unnamed_125;
				precise float fragment_unnamed_130 = (-0.0f) - fragment_unnamed_128;
				precise float fragment_unnamed_131 = (-0.0f) - fragment_unnamed_127;
				precise float fragment_unnamed_137 = fragment_unnamed_129 + fragment_input_1.x;
				precise float fragment_unnamed_138 = fragment_unnamed_130 + fragment_input_1.y;
				precise float fragment_unnamed_139 = fragment_unnamed_130 + fragment_input_1.x;
				precise float fragment_unnamed_140 = fragment_unnamed_131 + fragment_input_1.y;
				precise float fragment_unnamed_145 = fragment_unnamed_125 + fragment_input_1.x;
				precise float fragment_unnamed_146 = fragment_unnamed_128 + fragment_input_1.y;
				precise float fragment_unnamed_147 = fragment_unnamed_128 + fragment_input_1.x;
				precise float fragment_unnamed_148 = fragment_unnamed_127 + fragment_input_1.y;
				precise float fragment_unnamed_164 = fragment_unnamed_119 + _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_137, fragment_unnamed_138)).w;
				precise float fragment_unnamed_165 = fragment_unnamed_119 + _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_145, fragment_unnamed_146)).w;
				precise float fragment_unnamed_166 = fragment_unnamed_119 + _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_139, fragment_unnamed_140)).w;
				precise float fragment_unnamed_167 = fragment_unnamed_119 + _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_147, fragment_unnamed_148)).w;
				precise float fragment_unnamed_168 = fragment_unnamed_164 + (-0.5f);
				precise float fragment_unnamed_170 = fragment_unnamed_165 + (-0.5f);
				precise float fragment_unnamed_171 = fragment_unnamed_166 + (-0.5f);
				precise float fragment_unnamed_172 = fragment_unnamed_167 + (-0.5f);
				precise float fragment_unnamed_179 = fragment_uniform_buffer_0[8u].w + fragment_uniform_buffer_0[8u].x;
				float fragment_unnamed_180 = max(fragment_unnamed_179, 0.00999999977648258209228515625f);
				precise float fragment_unnamed_182 = fragment_unnamed_168 / fragment_unnamed_180;
				precise float fragment_unnamed_183 = fragment_unnamed_170 / fragment_unnamed_180;
				precise float fragment_unnamed_184 = fragment_unnamed_171 / fragment_unnamed_180;
				precise float fragment_unnamed_185 = fragment_unnamed_172 / fragment_unnamed_180;
				precise float fragment_unnamed_189 = fragment_unnamed_180 * fragment_uniform_buffer_0[8u].y;
				precise float fragment_unnamed_194 = fragment_unnamed_189 * fragment_uniform_buffer_0[30u].x;
				precise float fragment_unnamed_195 = fragment_unnamed_194 * (-2.0f);
				precise float fragment_unnamed_197 = fragment_unnamed_182 + 0.5f;
				precise float fragment_unnamed_199 = fragment_unnamed_183 + 0.5f;
				precise float fragment_unnamed_200 = fragment_unnamed_184 + 0.5f;
				precise float fragment_unnamed_201 = fragment_unnamed_185 + 0.5f;
				float fragment_unnamed_202 = clamp(fragment_unnamed_197, 0.0f, 1.0f);
				float fragment_unnamed_203 = clamp(fragment_unnamed_199, 0.0f, 1.0f);
				float fragment_unnamed_204 = clamp(fragment_unnamed_200, 0.0f, 1.0f);
				float fragment_unnamed_205 = clamp(fragment_unnamed_201, 0.0f, 1.0f);
				precise float fragment_unnamed_213 = (-0.0f) - abs(mad(fragment_unnamed_202, 2.0f, -1.0f));
				precise float fragment_unnamed_215 = (-0.0f) - abs(mad(fragment_unnamed_203, 2.0f, -1.0f));
				precise float fragment_unnamed_217 = (-0.0f) - abs(mad(fragment_unnamed_204, 2.0f, -1.0f));
				precise float fragment_unnamed_219 = (-0.0f) - abs(mad(fragment_unnamed_205, 2.0f, -1.0f));
				precise float fragment_unnamed_220 = fragment_unnamed_213 + 1.0f;
				precise float fragment_unnamed_221 = fragment_unnamed_215 + 1.0f;
				precise float fragment_unnamed_222 = fragment_unnamed_217 + 1.0f;
				precise float fragment_unnamed_223 = fragment_unnamed_219 + 1.0f;
				precise float fragment_unnamed_228 = fragment_uniform_buffer_0[24u].x * 0.5f;
				precise float fragment_unnamed_229 = (-0.0f) - fragment_unnamed_228;
				float fragment_unnamed_233 = frac(abs(fragment_unnamed_228));
				precise float fragment_unnamed_234 = (-0.0f) - fragment_unnamed_233;
				bool fragment_unnamed_236 = ((fragment_unnamed_228 >= fragment_unnamed_229) ? fragment_unnamed_233 : fragment_unnamed_234) >= 0.5f;
				float fragment_unnamed_246 = asfloat(fragment_unnamed_236 ? asuint(fragment_unnamed_220) : asuint(fragment_unnamed_202));
				float fragment_unnamed_248 = asfloat(fragment_unnamed_236 ? asuint(fragment_unnamed_221) : asuint(fragment_unnamed_203));
				float fragment_unnamed_250 = asfloat(fragment_unnamed_236 ? asuint(fragment_unnamed_222) : asuint(fragment_unnamed_204));
				float fragment_unnamed_252 = asfloat(fragment_unnamed_236 ? asuint(fragment_unnamed_223) : asuint(fragment_unnamed_205));
				precise float fragment_unnamed_253 = fragment_unnamed_246 * 1.57079601287841796875f;
				precise float fragment_unnamed_255 = fragment_unnamed_248 * 1.57079601287841796875f;
				precise float fragment_unnamed_256 = fragment_unnamed_250 * 1.57079601287841796875f;
				precise float fragment_unnamed_257 = fragment_unnamed_252 * 1.57079601287841796875f;
				precise float fragment_unnamed_262 = (-0.0f) - fragment_unnamed_246;
				precise float fragment_unnamed_263 = (-0.0f) - fragment_unnamed_248;
				precise float fragment_unnamed_264 = (-0.0f) - fragment_unnamed_250;
				precise float fragment_unnamed_265 = (-0.0f) - fragment_unnamed_252;
				precise float fragment_unnamed_266 = fragment_unnamed_262 + sin(fragment_unnamed_253);
				precise float fragment_unnamed_267 = fragment_unnamed_263 + sin(fragment_unnamed_255);
				precise float fragment_unnamed_268 = fragment_unnamed_264 + sin(fragment_unnamed_256);
				precise float fragment_unnamed_269 = fragment_unnamed_265 + sin(fragment_unnamed_257);
				precise float fragment_unnamed_281 = (-0.0f) - fragment_uniform_buffer_0[9u].x;
				precise float fragment_unnamed_282 = fragment_unnamed_281 + 1.0f;
				precise float fragment_unnamed_287 = fragment_unnamed_195 * min(mad(fragment_uniform_buffer_0[9u].y, fragment_unnamed_266, fragment_unnamed_246), fragment_unnamed_282);
				precise float fragment_unnamed_288 = fragment_unnamed_195 * min(mad(fragment_uniform_buffer_0[9u].y, fragment_unnamed_268, fragment_unnamed_250), fragment_unnamed_282);
				precise float fragment_unnamed_289 = (-0.0f) - fragment_unnamed_288;
				precise float fragment_unnamed_290 = (-0.0f) - fragment_unnamed_287;
				float fragment_unnamed_291 = mad(min(mad(fragment_uniform_buffer_0[9u].y, fragment_unnamed_269, fragment_unnamed_252), fragment_unnamed_282), fragment_unnamed_195, fragment_unnamed_289);
				float fragment_unnamed_292 = mad(min(mad(fragment_uniform_buffer_0[9u].y, fragment_unnamed_267, fragment_unnamed_248), fragment_unnamed_282), fragment_unnamed_195, fragment_unnamed_290);
				float fragment_unnamed_293 = asfloat(3212836864u);
				float fragment_unnamed_295 = asfloat(1065353216u);
				float fragment_unnamed_300 = rsqrt(dot(float2(fragment_unnamed_293, fragment_unnamed_291), float2(fragment_unnamed_293, fragment_unnamed_291)));
				float fragment_unnamed_304 = rsqrt(dot(float2(fragment_unnamed_292, fragment_unnamed_295), float2(fragment_unnamed_292, fragment_unnamed_295)));
				precise float fragment_unnamed_305 = fragment_unnamed_304 * fragment_unnamed_292;
				precise float fragment_unnamed_306 = fragment_unnamed_304 * 1.0f;
				precise float fragment_unnamed_307 = fragment_unnamed_304 * 0.0f;
				precise float fragment_unnamed_309 = fragment_unnamed_300 * fragment_unnamed_293;
				precise float fragment_unnamed_310 = fragment_unnamed_300 * fragment_unnamed_291;
				precise float fragment_unnamed_311 = fragment_unnamed_300 * asfloat(0u);
				precise float fragment_unnamed_312 = fragment_unnamed_309 * fragment_unnamed_305;
				precise float fragment_unnamed_313 = fragment_unnamed_310 * fragment_unnamed_306;
				precise float fragment_unnamed_314 = fragment_unnamed_311 * fragment_unnamed_307;
				precise float fragment_unnamed_315 = (-0.0f) - fragment_unnamed_312;
				precise float fragment_unnamed_316 = (-0.0f) - fragment_unnamed_313;
				precise float fragment_unnamed_317 = (-0.0f) - fragment_unnamed_314;
				float4 fragment_unnamed_336 = _OutlineTex.Sample(sampler_OutlineTex, float2(mad(fragment_uniform_buffer_0[6u].z, fragment_uniform_buffer_1[0u].y, fragment_input_2.x), mad(fragment_uniform_buffer_0[6u].w, fragment_uniform_buffer_1[0u].y, fragment_input_2.y)));
				precise float fragment_unnamed_348 = fragment_unnamed_336.x * fragment_uniform_buffer_0[7u].x;
				precise float fragment_unnamed_349 = fragment_unnamed_336.y * fragment_uniform_buffer_0[7u].y;
				precise float fragment_unnamed_350 = fragment_unnamed_336.z * fragment_uniform_buffer_0[7u].z;
				precise float fragment_unnamed_356 = fragment_input_6.w * fragment_uniform_buffer_0[7u].w;
				precise float fragment_unnamed_357 = fragment_unnamed_336.w * fragment_unnamed_356;
				precise float fragment_unnamed_358 = fragment_unnamed_348 * fragment_unnamed_357;
				precise float fragment_unnamed_359 = fragment_unnamed_349 * fragment_unnamed_357;
				precise float fragment_unnamed_360 = fragment_unnamed_350 * fragment_unnamed_357;
				float4 fragment_unnamed_376 = _FaceTex.Sample(sampler_FaceTex, float2(mad(fragment_uniform_buffer_0[4u].x, fragment_uniform_buffer_1[0u].y, fragment_input_1.z), mad(fragment_uniform_buffer_0[4u].y, fragment_uniform_buffer_1[0u].y, fragment_input_1.w)));
				precise float fragment_unnamed_396 = fragment_input_6.x * fragment_uniform_buffer_0[5u].x;
				precise float fragment_unnamed_397 = fragment_input_6.y * fragment_uniform_buffer_0[5u].y;
				precise float fragment_unnamed_398 = fragment_input_6.z * fragment_uniform_buffer_0[5u].z;
				precise float fragment_unnamed_399 = fragment_input_6.w * fragment_uniform_buffer_0[5u].w;
				precise float fragment_unnamed_400 = fragment_unnamed_376.x * fragment_unnamed_396;
				precise float fragment_unnamed_401 = fragment_unnamed_376.y * fragment_unnamed_397;
				precise float fragment_unnamed_402 = fragment_unnamed_376.z * fragment_unnamed_398;
				precise float fragment_unnamed_403 = fragment_unnamed_376.w * fragment_unnamed_399;
				precise float fragment_unnamed_404 = fragment_unnamed_403 * fragment_unnamed_400;
				precise float fragment_unnamed_405 = fragment_unnamed_403 * fragment_unnamed_401;
				precise float fragment_unnamed_406 = fragment_unnamed_403 * fragment_unnamed_402;
				precise float fragment_unnamed_407 = (-0.0f) - fragment_unnamed_404;
				precise float fragment_unnamed_408 = (-0.0f) - fragment_unnamed_405;
				precise float fragment_unnamed_409 = (-0.0f) - fragment_unnamed_406;
				precise float fragment_unnamed_410 = (-0.0f) - fragment_unnamed_403;
				precise float fragment_unnamed_411 = fragment_unnamed_407 + fragment_unnamed_358;
				precise float fragment_unnamed_412 = fragment_unnamed_408 + fragment_unnamed_359;
				precise float fragment_unnamed_413 = fragment_unnamed_409 + fragment_unnamed_360;
				precise float fragment_unnamed_414 = fragment_unnamed_410 + fragment_unnamed_357;
				precise float fragment_unnamed_421 = fragment_uniform_buffer_0[8u].x * fragment_uniform_buffer_0[24u].w;
				precise float fragment_unnamed_424 = fragment_unnamed_421 * fragment_input_2.y;
				precise float fragment_unnamed_434 = (-0.0f) - _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y)).w;
				precise float fragment_unnamed_435 = fragment_unnamed_434 + 0.5f;
				precise float fragment_unnamed_438 = (-0.0f) - fragment_input_2.x;
				precise float fragment_unnamed_439 = fragment_unnamed_435 + fragment_unnamed_438;
				float fragment_unnamed_442 = mad(fragment_unnamed_439, fragment_input_2.y, 0.5f);
				float fragment_unnamed_444 = clamp(mad(fragment_unnamed_424, 0.5f, fragment_unnamed_442), 0.0f, 1.0f);
				precise float fragment_unnamed_445 = (-0.0f) - fragment_unnamed_424;
				precise float fragment_unnamed_447 = sqrt(min(fragment_unnamed_424, 1.0f)) * fragment_unnamed_444;
				precise float fragment_unnamed_458 = fragment_uniform_buffer_0[6u].y * fragment_uniform_buffer_0[24u].w;
				precise float fragment_unnamed_461 = fragment_unnamed_458 * fragment_input_2.y;
				precise float fragment_unnamed_466 = mad(fragment_unnamed_461, 0.5f, mad(fragment_unnamed_445, 0.5f, fragment_unnamed_442)) / mad(fragment_unnamed_458, fragment_input_2.y, 1.0f);
				precise float fragment_unnamed_468 = (-0.0f) - clamp(fragment_unnamed_466, 0.0f, 1.0f);
				precise float fragment_unnamed_469 = fragment_unnamed_468 + 1.0f;
				precise float fragment_unnamed_470 = fragment_unnamed_469 * mad(fragment_unnamed_447, fragment_unnamed_411, fragment_unnamed_404);
				precise float fragment_unnamed_471 = fragment_unnamed_469 * mad(fragment_unnamed_447, fragment_unnamed_412, fragment_unnamed_405);
				precise float fragment_unnamed_472 = fragment_unnamed_469 * mad(fragment_unnamed_447, fragment_unnamed_413, fragment_unnamed_406);
				precise float fragment_unnamed_473 = fragment_unnamed_469 * mad(fragment_unnamed_447, fragment_unnamed_414, fragment_unnamed_403);
				precise float fragment_unnamed_477 = (-0.0f) - fragment_uniform_buffer_0[9u].w;
				precise float fragment_unnamed_481 = fragment_unnamed_477 + fragment_uniform_buffer_0[9u].z;
				float fragment_unnamed_485 = mad(fragment_unnamed_444, fragment_unnamed_481, fragment_uniform_buffer_0[9u].w);
				float4 fragment_unnamed_491 = _BumpMap.Sample(sampler_BumpMap, float2(fragment_input_1.z, fragment_input_1.w));
				precise float fragment_unnamed_496 = fragment_unnamed_491.w * fragment_unnamed_491.x;
				float fragment_unnamed_497 = mad(fragment_unnamed_496, 2.0f, -1.0f);
				float fragment_unnamed_498 = mad(fragment_unnamed_491.y, 2.0f, -1.0f);
				precise float fragment_unnamed_503 = (-0.0f) - min(dot(float2(fragment_unnamed_497, fragment_unnamed_498), float2(fragment_unnamed_497, fragment_unnamed_498)), 1.0f);
				precise float fragment_unnamed_504 = fragment_unnamed_503 + 1.0f;
				precise float fragment_unnamed_512 = (-0.0f) - mad(fragment_unnamed_473, mad(fragment_unnamed_497, fragment_unnamed_485, -0.0f), 0.0f);
				precise float fragment_unnamed_513 = (-0.0f) - mad(fragment_unnamed_473, mad(fragment_unnamed_498, fragment_unnamed_485, -0.0f), 0.0f);
				precise float fragment_unnamed_514 = (-0.0f) - mad(fragment_unnamed_473, mad(sqrt(fragment_unnamed_504), fragment_unnamed_485, -1.0f), 1.0f);
				precise float fragment_unnamed_515 = mad(fragment_unnamed_307, fragment_unnamed_310, fragment_unnamed_315) + fragment_unnamed_512;
				precise float fragment_unnamed_516 = mad(fragment_unnamed_305, fragment_unnamed_311, fragment_unnamed_316) + fragment_unnamed_513;
				precise float fragment_unnamed_517 = mad(fragment_unnamed_306, fragment_unnamed_309, fragment_unnamed_317) + fragment_unnamed_514;
				float fragment_unnamed_521 = rsqrt(dot(float3(fragment_unnamed_515, fragment_unnamed_516, fragment_unnamed_517), float3(fragment_unnamed_515, fragment_unnamed_516, fragment_unnamed_517)));
				precise float fragment_unnamed_522 = fragment_unnamed_521 * fragment_unnamed_515;
				precise float fragment_unnamed_523 = fragment_unnamed_521 * fragment_unnamed_516;
				precise float fragment_unnamed_524 = fragment_unnamed_521 * fragment_unnamed_517;
				precise float fragment_unnamed_531 = (-0.0f) - fragment_unnamed_522;
				precise float fragment_unnamed_532 = (-0.0f) - fragment_unnamed_523;
				precise float fragment_unnamed_533 = (-0.0f) - fragment_unnamed_524;
				float fragment_unnamed_534 = dot(float3(fragment_input_3.x, fragment_input_3.y, fragment_input_3.z), float3(fragment_unnamed_531, fragment_unnamed_532, fragment_unnamed_533));
				precise float fragment_unnamed_543 = (-0.0f) - fragment_unnamed_522;
				precise float fragment_unnamed_544 = (-0.0f) - fragment_unnamed_523;
				precise float fragment_unnamed_545 = (-0.0f) - fragment_unnamed_524;
				float fragment_unnamed_546 = dot(float3(fragment_input_4.x, fragment_input_4.y, fragment_input_4.z), float3(fragment_unnamed_543, fragment_unnamed_544, fragment_unnamed_545));
				precise float fragment_unnamed_555 = (-0.0f) - fragment_unnamed_522;
				precise float fragment_unnamed_556 = (-0.0f) - fragment_unnamed_523;
				precise float fragment_unnamed_557 = (-0.0f) - fragment_unnamed_524;
				float fragment_unnamed_558 = dot(float3(fragment_input_5.x, fragment_input_5.y, fragment_input_5.z), float3(fragment_unnamed_555, fragment_unnamed_556, fragment_unnamed_557));
				float fragment_unnamed_564 = rsqrt(dot(float3(fragment_unnamed_534, fragment_unnamed_546, fragment_unnamed_558), float3(fragment_unnamed_534, fragment_unnamed_546, fragment_unnamed_558)));
				precise float fragment_unnamed_565 = fragment_unnamed_564 * fragment_unnamed_534;
				precise float fragment_unnamed_566 = fragment_unnamed_564 * fragment_unnamed_546;
				precise float fragment_unnamed_567 = fragment_unnamed_564 * fragment_unnamed_558;
				precise float fragment_unnamed_577 = (-0.0f) - fragment_uniform_buffer_0[31u].y;
				precise float fragment_unnamed_581 = fragment_unnamed_577 + fragment_uniform_buffer_0[31u].z;
				precise float fragment_unnamed_586 = mad(fragment_unnamed_444, fragment_unnamed_581, fragment_uniform_buffer_0[31u].y) * 128.0f;
				precise float fragment_unnamed_588 = log2(max(dot(float3(fragment_unnamed_565, fragment_unnamed_566, fragment_unnamed_567), float3(fragment_unnamed_110, fragment_unnamed_111, fragment_unnamed_112)), 0.0f)) * fragment_unnamed_586;
				float fragment_unnamed_589 = exp2(fragment_unnamed_588);
				precise float fragment_unnamed_600 = fragment_uniform_buffer_0[2u].x * fragment_uniform_buffer_0[3u].x;
				precise float fragment_unnamed_601 = fragment_uniform_buffer_0[2u].y * fragment_uniform_buffer_0[3u].y;
				precise float fragment_unnamed_602 = fragment_uniform_buffer_0[2u].z * fragment_uniform_buffer_0[3u].z;
				precise float fragment_unnamed_603 = fragment_unnamed_589 * fragment_unnamed_600;
				precise float fragment_unnamed_604 = fragment_unnamed_589 * fragment_unnamed_601;
				precise float fragment_unnamed_605 = fragment_unnamed_589 * fragment_unnamed_602;
				float fragment_unnamed_614 = max(dot(float3(fragment_unnamed_565, fragment_unnamed_566, fragment_unnamed_567), float3(fragment_uniform_buffer_2[0u].xyz)), 0.0f);
				float fragment_unnamed_615 = max(fragment_unnamed_473, 9.9999997473787516355514526367188e-05f);
				precise float fragment_unnamed_617 = fragment_unnamed_470 / fragment_unnamed_615;
				precise float fragment_unnamed_618 = fragment_unnamed_471 / fragment_unnamed_615;
				precise float fragment_unnamed_619 = fragment_unnamed_472 / fragment_unnamed_615;
				precise float fragment_unnamed_625 = fragment_unnamed_617 * fragment_uniform_buffer_0[2u].x;
				precise float fragment_unnamed_626 = fragment_unnamed_618 * fragment_uniform_buffer_0[2u].y;
				precise float fragment_unnamed_627 = fragment_unnamed_619 * fragment_uniform_buffer_0[2u].z;
				float fragment_unnamed_631 = asfloat(1065353216u);
				precise float fragment_unnamed_668 = dot(float4(fragment_uniform_buffer_2[39u]), float4(fragment_unnamed_565, fragment_unnamed_566, fragment_unnamed_567, fragment_unnamed_631)) + fragment_input_8.x;
				precise float fragment_unnamed_669 = dot(float4(fragment_uniform_buffer_2[40u]), float4(fragment_unnamed_565, fragment_unnamed_566, fragment_unnamed_567, fragment_unnamed_631)) + fragment_input_8.y;
				precise float fragment_unnamed_670 = dot(float4(fragment_uniform_buffer_2[41u]), float4(fragment_unnamed_565, fragment_unnamed_566, fragment_unnamed_567, fragment_unnamed_631)) + fragment_input_8.z;
				precise float fragment_unnamed_677 = log2(max(fragment_unnamed_668, 0.0f)) * 0.4166666567325592041015625f;
				precise float fragment_unnamed_679 = log2(max(fragment_unnamed_669, 0.0f)) * 0.4166666567325592041015625f;
				precise float fragment_unnamed_680 = log2(max(fragment_unnamed_670, 0.0f)) * 0.4166666567325592041015625f;
				precise float fragment_unnamed_699 = (-0.0f) - fragment_uniform_buffer_0[10u].x;
				precise float fragment_unnamed_701 = (-0.0f) - fragment_uniform_buffer_0[10u].y;
				precise float fragment_unnamed_703 = (-0.0f) - fragment_uniform_buffer_0[10u].z;
				precise float fragment_unnamed_710 = fragment_unnamed_699 + fragment_uniform_buffer_0[11u].x;
				precise float fragment_unnamed_711 = fragment_unnamed_701 + fragment_uniform_buffer_0[11u].y;
				precise float fragment_unnamed_712 = fragment_unnamed_703 + fragment_uniform_buffer_0[11u].z;
				precise float fragment_unnamed_726 = fragment_unnamed_523 * fragment_uniform_buffer_3[1u].x;
				precise float fragment_unnamed_727 = fragment_unnamed_523 * fragment_uniform_buffer_3[1u].y;
				precise float fragment_unnamed_728 = fragment_unnamed_523 * fragment_uniform_buffer_3[1u].z;
				float fragment_unnamed_742 = mad(fragment_uniform_buffer_3[2u].x, fragment_unnamed_524, mad(fragment_uniform_buffer_3[0u].x, fragment_unnamed_522, fragment_unnamed_726));
				float fragment_unnamed_743 = mad(fragment_uniform_buffer_3[2u].y, fragment_unnamed_524, mad(fragment_uniform_buffer_3[0u].y, fragment_unnamed_522, fragment_unnamed_727));
				float fragment_unnamed_744 = mad(fragment_uniform_buffer_3[2u].z, fragment_unnamed_524, mad(fragment_uniform_buffer_3[0u].z, fragment_unnamed_522, fragment_unnamed_728));
				float fragment_unnamed_751 = dot(float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z), float3(fragment_unnamed_742, fragment_unnamed_743, fragment_unnamed_744));
				precise float fragment_unnamed_754 = fragment_unnamed_751 + fragment_unnamed_751;
				precise float fragment_unnamed_755 = (-0.0f) - fragment_unnamed_754;
				float4 fragment_unnamed_767 = _Cube.Sample(sampler_Cube, float3(mad(fragment_unnamed_742, fragment_unnamed_755, fragment_input_7.x), mad(fragment_unnamed_743, fragment_unnamed_755, fragment_input_7.y), mad(fragment_unnamed_744, fragment_unnamed_755, fragment_input_7.z)));
				precise float fragment_unnamed_772 = mad(fragment_unnamed_444, fragment_unnamed_710, fragment_uniform_buffer_0[10u].x) * fragment_unnamed_767.x;
				precise float fragment_unnamed_773 = mad(fragment_unnamed_444, fragment_unnamed_711, fragment_uniform_buffer_0[10u].y) * fragment_unnamed_767.y;
				precise float fragment_unnamed_774 = mad(fragment_unnamed_444, fragment_unnamed_712, fragment_uniform_buffer_0[10u].z) * fragment_unnamed_767.z;
				fragment_output_0.x = mad(fragment_unnamed_772, fragment_unnamed_473, mad(fragment_unnamed_617, max(mad(exp2(fragment_unnamed_677), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f), mad(fragment_unnamed_625, fragment_unnamed_614, fragment_unnamed_603)));
				fragment_output_0.y = mad(fragment_unnamed_773, fragment_unnamed_473, mad(fragment_unnamed_618, max(mad(exp2(fragment_unnamed_679), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f), mad(fragment_unnamed_626, fragment_unnamed_614, fragment_unnamed_604)));
				fragment_output_0.z = mad(fragment_unnamed_774, fragment_unnamed_473, mad(fragment_unnamed_619, max(mad(exp2(fragment_unnamed_680), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f), mad(fragment_unnamed_627, fragment_unnamed_614, fragment_unnamed_605)));
				fragment_output_0.w = fragment_unnamed_473;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[2] = float4(_LightColor0[0], _LightColor0[1], _LightColor0[2], _LightColor0[3]);

				fragment_uniform_buffer_0[3] = float4(_SpecColor[0], _SpecColor[1], _SpecColor[2], _SpecColor[3]);

				fragment_uniform_buffer_0[4] = float4(_FaceUVSpeedX, fragment_uniform_buffer_0[4][1], fragment_uniform_buffer_0[4][2], fragment_uniform_buffer_0[4][3]);

				fragment_uniform_buffer_0[4] = float4(fragment_uniform_buffer_0[4][0], _FaceUVSpeedY, fragment_uniform_buffer_0[4][2], fragment_uniform_buffer_0[4][3]);

				fragment_uniform_buffer_0[5] = float4(_FaceColor[0], _FaceColor[1], _FaceColor[2], _FaceColor[3]);

				fragment_uniform_buffer_0[6] = float4(fragment_uniform_buffer_0[6][0], _OutlineSoftness, fragment_uniform_buffer_0[6][2], fragment_uniform_buffer_0[6][3]);

				fragment_uniform_buffer_0[6] = float4(fragment_uniform_buffer_0[6][0], fragment_uniform_buffer_0[6][1], _OutlineUVSpeedX, fragment_uniform_buffer_0[6][3]);

				fragment_uniform_buffer_0[6] = float4(fragment_uniform_buffer_0[6][0], fragment_uniform_buffer_0[6][1], fragment_uniform_buffer_0[6][2], _OutlineUVSpeedY);

				fragment_uniform_buffer_0[7] = float4(_OutlineColor[0], _OutlineColor[1], _OutlineColor[2], _OutlineColor[3]);

				fragment_uniform_buffer_0[8] = float4(_OutlineWidth, fragment_uniform_buffer_0[8][1], fragment_uniform_buffer_0[8][2], fragment_uniform_buffer_0[8][3]);

				fragment_uniform_buffer_0[8] = float4(fragment_uniform_buffer_0[8][0], _Bevel, fragment_uniform_buffer_0[8][2], fragment_uniform_buffer_0[8][3]);

				fragment_uniform_buffer_0[8] = float4(fragment_uniform_buffer_0[8][0], fragment_uniform_buffer_0[8][1], _BevelOffset, fragment_uniform_buffer_0[8][3]);

				fragment_uniform_buffer_0[8] = float4(fragment_uniform_buffer_0[8][0], fragment_uniform_buffer_0[8][1], fragment_uniform_buffer_0[8][2], _BevelWidth);

				fragment_uniform_buffer_0[9] = float4(_BevelClamp, fragment_uniform_buffer_0[9][1], fragment_uniform_buffer_0[9][2], fragment_uniform_buffer_0[9][3]);

				fragment_uniform_buffer_0[9] = float4(fragment_uniform_buffer_0[9][0], _BevelRoundness, fragment_uniform_buffer_0[9][2], fragment_uniform_buffer_0[9][3]);

				fragment_uniform_buffer_0[9] = float4(fragment_uniform_buffer_0[9][0], fragment_uniform_buffer_0[9][1], _BumpOutline, fragment_uniform_buffer_0[9][3]);

				fragment_uniform_buffer_0[9] = float4(fragment_uniform_buffer_0[9][0], fragment_uniform_buffer_0[9][1], fragment_uniform_buffer_0[9][2], _BumpFace);

				fragment_uniform_buffer_0[10] = float4(_ReflectFaceColor[0], _ReflectFaceColor[1], _ReflectFaceColor[2], _ReflectFaceColor[3]);

				fragment_uniform_buffer_0[11] = float4(_ReflectOutlineColor[0], _ReflectOutlineColor[1], _ReflectOutlineColor[2], _ReflectOutlineColor[3]);

				fragment_uniform_buffer_0[24] = float4(_ShaderFlags, fragment_uniform_buffer_0[24][1], fragment_uniform_buffer_0[24][2], fragment_uniform_buffer_0[24][3]);

				fragment_uniform_buffer_0[24] = float4(fragment_uniform_buffer_0[24][0], fragment_uniform_buffer_0[24][1], fragment_uniform_buffer_0[24][2], _ScaleRatioA);

				fragment_uniform_buffer_0[29] = float4(fragment_uniform_buffer_0[29][0], fragment_uniform_buffer_0[29][1], _TextureWidth, fragment_uniform_buffer_0[29][3]);

				fragment_uniform_buffer_0[29] = float4(fragment_uniform_buffer_0[29][0], fragment_uniform_buffer_0[29][1], fragment_uniform_buffer_0[29][2], _TextureHeight);

				fragment_uniform_buffer_0[30] = float4(_GradientScale, fragment_uniform_buffer_0[30][1], fragment_uniform_buffer_0[30][2], fragment_uniform_buffer_0[30][3]);

				fragment_uniform_buffer_0[31] = float4(fragment_uniform_buffer_0[31][0], _FaceShininess, fragment_uniform_buffer_0[31][2], fragment_uniform_buffer_0[31][3]);

				fragment_uniform_buffer_0[31] = float4(fragment_uniform_buffer_0[31][0], fragment_uniform_buffer_0[31][1], _OutlineShininess, fragment_uniform_buffer_0[31][3]);

				fragment_uniform_buffer_1[0] = float4(_Time[0], _Time[1], _Time[2], _Time[3]);

				fragment_uniform_buffer_1[4] = float4(_WorldSpaceCameraPos[0], _WorldSpaceCameraPos[1], _WorldSpaceCameraPos[2], fragment_uniform_buffer_1[4][3]);

				fragment_uniform_buffer_2[0] = float4(_WorldSpaceLightPos0[0], _WorldSpaceLightPos0[1], _WorldSpaceLightPos0[2], _WorldSpaceLightPos0[3]);

				fragment_uniform_buffer_2[39] = float4(unity_SHAr[0], unity_SHAr[1], unity_SHAr[2], unity_SHAr[3]);

				fragment_uniform_buffer_2[40] = float4(unity_SHAg[0], unity_SHAg[1], unity_SHAg[2], unity_SHAg[3]);

				fragment_uniform_buffer_2[41] = float4(unity_SHAb[0], unity_SHAb[1], unity_SHAb[2], unity_SHAb[3]);

				fragment_uniform_buffer_3[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				fragment_uniform_buffer_3[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				fragment_uniform_buffer_3[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				fragment_uniform_buffer_3[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				fragment_input_6 = stage_input.fragment_input_6;
				fragment_input_7 = stage_input.fragment_input_7;
				fragment_input_8 = stage_input.fragment_input_8;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // DIRECTIONAL
			#endif // LIGHTPROBE_SH
			#endif // !VERTEXLIGHT_ON


			// Fallback Shader Code
			#ifndef ANY_SHADER_VARIANT_ACTIVE

			// https://docs.unity3d.com/Manual/SL-UnityShaderVariables.html
			float4x4 unity_MatrixMVP;

			struct Vertex_Stage_Input
			{
				float3 pos : POSITION;
			};

			struct Vertex_Stage_Output
			{
				float4 pos : SV_POSITION;
			};

			Vertex_Stage_Output vert(Vertex_Stage_Input input)
			{
				Vertex_Stage_Output output;
				output.pos = mul(unity_MatrixMVP, float4(input.pos, 1.0));
				return output;
			}

			float4 frag(Vertex_Stage_Output input) : SV_TARGET
			{
				// Output solid grey color (e.g., 50% grey)
				return float4(0.5, 0.5, 0.5, 1.0); // RGBA
			}

			#endif // !ANY_SHADER_VARIANT_ACTIVE


			ENDHLSL
		}
		Pass
		{
			Name "FORWARD"
			LOD 300
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDADD" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend SrcAlpha One, SrcAlpha One
			ColorMask RGB
			ZWrite Off
			Cull Off
			GpuProgramID 76001

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.0
			#pragma shader_feature DIRECTIONAL
			#pragma shader_feature DIRECTIONAL_COOKIE
			#pragma shader_feature POINT
			#pragma shader_feature POINT_COOKIE
			#pragma shader_feature SPOT


			#ifdef POINT
			#ifndef DIRECTIONAL
			#ifndef DIRECTIONAL_COOKIE
			#ifndef POINT_COOKIE
			#ifndef SPOT
			#define ANY_SHADER_VARIANT_ACTIVE

			float4x4 unity_WorldToLight;
			float _FaceDilate;
			float4x4 _EnvMatrix;
			float _WeightNormal;
			float _WeightBold;
			float _ScaleRatioA;
			float _VertexOffsetX;
			float _VertexOffsetY;
			float _GradientScale;
			float _ScaleX;
			float _ScaleY;
			float _PerspectiveFilter;
			float _Sharpness;
			float4 _MainTex_ST;
			float4 _FaceTex_ST;
			float4 _OutlineTex_ST;
			float3 _WorldSpaceCameraPos;
			float4 _ScreenParams;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4 unity_WorldTransformParams;
			float4x4 glstate_matrix_projection;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[39];
			static float4 vertex_uniform_buffer_1[7];
			static float4 vertex_uniform_buffer_2[10];
			static float4 vertex_uniform_buffer_3[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float3 vertex_input_2;
			static float4 vertex_input_3;
			static float4 vertex_input_4;
			static float4 vertex_input_5;
			static float4 vertex_input_6;
			static float4 vertex_input_7;
			static float4 vertex_output_1;
			static float2 vertex_output_2;
			static float2 vertex_output_2;
			static float3 vertex_output_3;
			static float3 vertex_output_4;
			static float3 vertex_output_5;
			static float3 vertex_output_6;
			static float4 vertex_output_7;
			static float3 vertex_output_8;
			static float3 vertex_output_9;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION; // POSITION
				float4 vertex_input_1 : TANGENT; // TANGENT
				float3 vertex_input_2 : NORMAL; // NORMAL
				float4 vertex_input_3 : TEXCOORD; // TEXCOORD
				float4 vertex_input_4 : TEXCOORD1; // TEXCOORD_1
				float4 vertex_input_5 : TEXCOORD2; // TEXCOORD_2
				float4 vertex_input_6 : TEXCOORD3; // TEXCOORD_3
				float4 vertex_input_7 : COLOR; // COLOR
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : TEXCOORD; // TEXCOORD
				float2 vertex_output_2 : TEXCOORD1; // TEXCOORD_1
				float2 vertex_output_2 : TEXCOORD6; // TEXCOORD_6
				float3 vertex_output_3 : TEXCOORD2; // TEXCOORD_2
				float3 vertex_output_4 : TEXCOORD3; // TEXCOORD_3
				float3 vertex_output_5 : TEXCOORD4; // TEXCOORD_4
				float3 vertex_output_6 : TEXCOORD5; // TEXCOORD_5
				float4 vertex_output_7 : COLOR; // COLOR
				float3 vertex_output_8 : TEXCOORD7; // TEXCOORD_7
				float3 vertex_output_9 : TEXCOORD8; // TEXCOORD_8
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_67 = vertex_input_0.x + vertex_uniform_buffer_0[29u].z;
				precise float vertex_unnamed_68 = vertex_input_0.y + vertex_uniform_buffer_0[29u].w;
				precise float vertex_unnamed_75 = vertex_unnamed_68 * vertex_uniform_buffer_2[1u].x;
				precise float vertex_unnamed_76 = vertex_unnamed_68 * vertex_uniform_buffer_2[1u].y;
				precise float vertex_unnamed_77 = vertex_unnamed_68 * vertex_uniform_buffer_2[1u].z;
				precise float vertex_unnamed_78 = vertex_unnamed_68 * vertex_uniform_buffer_2[1u].w;
				float vertex_unnamed_99 = mad(vertex_uniform_buffer_2[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].x, vertex_unnamed_67, vertex_unnamed_75));
				float vertex_unnamed_100 = mad(vertex_uniform_buffer_2[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].y, vertex_unnamed_67, vertex_unnamed_76));
				float vertex_unnamed_101 = mad(vertex_uniform_buffer_2[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].z, vertex_unnamed_67, vertex_unnamed_77));
				float vertex_unnamed_102 = mad(vertex_uniform_buffer_2[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].w, vertex_unnamed_67, vertex_unnamed_78));
				precise float vertex_unnamed_110 = vertex_unnamed_99 + vertex_uniform_buffer_2[3u].x;
				precise float vertex_unnamed_111 = vertex_unnamed_100 + vertex_uniform_buffer_2[3u].y;
				precise float vertex_unnamed_112 = vertex_unnamed_101 + vertex_uniform_buffer_2[3u].z;
				precise float vertex_unnamed_113 = vertex_unnamed_102 + vertex_uniform_buffer_2[3u].w;
				precise float vertex_unnamed_121 = vertex_unnamed_111 * vertex_uniform_buffer_3[18u].x;
				precise float vertex_unnamed_122 = vertex_unnamed_111 * vertex_uniform_buffer_3[18u].y;
				precise float vertex_unnamed_123 = vertex_unnamed_111 * vertex_uniform_buffer_3[18u].z;
				precise float vertex_unnamed_124 = vertex_unnamed_111 * vertex_uniform_buffer_3[18u].w;
				gl_Position.x = mad(vertex_uniform_buffer_3[20u].x, vertex_unnamed_113, mad(vertex_uniform_buffer_3[19u].x, vertex_unnamed_112, mad(vertex_uniform_buffer_3[17u].x, vertex_unnamed_110, vertex_unnamed_121)));
				gl_Position.y = mad(vertex_uniform_buffer_3[20u].y, vertex_unnamed_113, mad(vertex_uniform_buffer_3[19u].y, vertex_unnamed_112, mad(vertex_uniform_buffer_3[17u].y, vertex_unnamed_110, vertex_unnamed_122)));
				gl_Position.z = mad(vertex_uniform_buffer_3[20u].z, vertex_unnamed_113, mad(vertex_uniform_buffer_3[19u].z, vertex_unnamed_112, mad(vertex_uniform_buffer_3[17u].z, vertex_unnamed_110, vertex_unnamed_123)));
				gl_Position.w = mad(vertex_uniform_buffer_3[20u].w, vertex_unnamed_113, mad(vertex_uniform_buffer_3[19u].w, vertex_unnamed_112, mad(vertex_uniform_buffer_3[17u].w, vertex_unnamed_110, vertex_unnamed_124)));
				precise float vertex_unnamed_165 = vertex_input_4.x * 0.000244140625f;
				float vertex_unnamed_167 = floor(vertex_unnamed_165);
				precise float vertex_unnamed_168 = (-0.0f) - vertex_unnamed_167;
				precise float vertex_unnamed_174 = vertex_unnamed_167 * 0.001953125f;
				precise float vertex_unnamed_176 = mad(vertex_unnamed_168, 4096.0f, vertex_input_4.x) * 0.001953125f;
				vertex_output_1.z = mad(vertex_unnamed_174, vertex_uniform_buffer_0[37u].x, vertex_uniform_buffer_0[37u].z);
				vertex_output_1.w = mad(vertex_unnamed_176, vertex_uniform_buffer_0[37u].y, vertex_uniform_buffer_0[37u].w);
				vertex_output_2.x = mad(vertex_unnamed_174, vertex_uniform_buffer_0[38u].x, vertex_uniform_buffer_0[38u].z);
				vertex_output_2.y = mad(vertex_unnamed_176, vertex_uniform_buffer_0[38u].y, vertex_uniform_buffer_0[38u].w);
				vertex_output_1.x = mad(vertex_input_3.x, vertex_uniform_buffer_0[36u].x, vertex_uniform_buffer_0[36u].z);
				vertex_output_1.y = mad(vertex_input_3.y, vertex_uniform_buffer_0[36u].y, vertex_uniform_buffer_0[36u].w);
				precise float vertex_unnamed_223 = vertex_unnamed_111 * vertex_uniform_buffer_3[18u].w;
				float vertex_unnamed_235 = mad(vertex_uniform_buffer_3[20u].w, vertex_unnamed_113, mad(vertex_uniform_buffer_3[19u].w, vertex_unnamed_112, mad(vertex_uniform_buffer_3[17u].w, vertex_unnamed_110, vertex_unnamed_223)));
				precise float vertex_unnamed_244 = vertex_uniform_buffer_1[6u].y * vertex_uniform_buffer_3[6u].x;
				precise float vertex_unnamed_245 = vertex_uniform_buffer_1[6u].y * vertex_uniform_buffer_3[6u].y;
				precise float vertex_unnamed_261 = mad(vertex_uniform_buffer_3[5u].x, vertex_uniform_buffer_1[6u].x, vertex_unnamed_244) * vertex_uniform_buffer_0[34u].y;
				precise float vertex_unnamed_262 = mad(vertex_uniform_buffer_3[5u].y, vertex_uniform_buffer_1[6u].x, vertex_unnamed_245) * vertex_uniform_buffer_0[34u].z;
				precise float vertex_unnamed_263 = vertex_unnamed_235 / vertex_unnamed_261;
				precise float vertex_unnamed_264 = vertex_unnamed_235 / vertex_unnamed_262;
				float vertex_unnamed_268 = rsqrt(dot(float2(vertex_unnamed_263, vertex_unnamed_264), float2(vertex_unnamed_263, vertex_unnamed_264)));
				precise float vertex_unnamed_275 = abs(vertex_input_4.y) * vertex_uniform_buffer_0[34u].x;
				precise float vertex_unnamed_280 = vertex_uniform_buffer_0[35u].x + 1.0f;
				precise float vertex_unnamed_282 = vertex_unnamed_280 * vertex_unnamed_275;
				precise float vertex_unnamed_283 = vertex_unnamed_268 * vertex_unnamed_282;
				precise float vertex_unnamed_287 = (-0.0f) - vertex_uniform_buffer_0[34u].w;
				precise float vertex_unnamed_288 = vertex_unnamed_287 + 1.0f;
				precise float vertex_unnamed_289 = vertex_unnamed_288 * vertex_unnamed_283;
				precise float vertex_unnamed_290 = (-0.0f) - vertex_unnamed_289;
				precise float vertex_unnamed_301 = vertex_uniform_buffer_1[4u].y * vertex_uniform_buffer_2[5u].x;
				precise float vertex_unnamed_302 = vertex_uniform_buffer_1[4u].y * vertex_uniform_buffer_2[5u].y;
				precise float vertex_unnamed_303 = vertex_uniform_buffer_1[4u].y * vertex_uniform_buffer_2[5u].z;
				precise float vertex_unnamed_331 = mad(vertex_uniform_buffer_2[6u].x, vertex_uniform_buffer_1[4u].z, mad(vertex_uniform_buffer_2[4u].x, vertex_uniform_buffer_1[4u].x, vertex_unnamed_301)) + vertex_uniform_buffer_2[7u].x;
				precise float vertex_unnamed_332 = mad(vertex_uniform_buffer_2[6u].y, vertex_uniform_buffer_1[4u].z, mad(vertex_uniform_buffer_2[4u].y, vertex_uniform_buffer_1[4u].x, vertex_unnamed_302)) + vertex_uniform_buffer_2[7u].y;
				precise float vertex_unnamed_333 = mad(vertex_uniform_buffer_2[6u].z, vertex_uniform_buffer_1[4u].z, mad(vertex_uniform_buffer_2[4u].z, vertex_uniform_buffer_1[4u].x, vertex_unnamed_303)) + vertex_uniform_buffer_2[7u].z;
				precise float vertex_unnamed_336 = (-0.0f) - vertex_unnamed_67;
				precise float vertex_unnamed_337 = (-0.0f) - vertex_unnamed_68;
				precise float vertex_unnamed_338 = (-0.0f) - vertex_input_0.z;
				precise float vertex_unnamed_339 = vertex_unnamed_336 + vertex_unnamed_331;
				precise float vertex_unnamed_340 = vertex_unnamed_337 + vertex_unnamed_332;
				precise float vertex_unnamed_341 = vertex_unnamed_338 + vertex_unnamed_333;
				float vertex_unnamed_348 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_unnamed_339, vertex_unnamed_340, vertex_unnamed_341));
				float vertex_unnamed_360 = float(int((-((0.0f < vertex_unnamed_348) ? 4294967295u : 0u)) + ((vertex_unnamed_348 < 0.0f) ? 4294967295u : 0u)));
				precise float vertex_unnamed_367 = vertex_unnamed_360 * vertex_input_2.x;
				precise float vertex_unnamed_368 = vertex_unnamed_360 * vertex_input_2.y;
				precise float vertex_unnamed_369 = vertex_unnamed_360 * vertex_input_2.z;
				float vertex_unnamed_375 = dot(float3(vertex_unnamed_367, vertex_unnamed_368, vertex_unnamed_369), float3(vertex_uniform_buffer_2[4u].xyz));
				float vertex_unnamed_383 = dot(float3(vertex_unnamed_367, vertex_unnamed_368, vertex_unnamed_369), float3(vertex_uniform_buffer_2[5u].xyz));
				float vertex_unnamed_391 = dot(float3(vertex_unnamed_367, vertex_unnamed_368, vertex_unnamed_369), float3(vertex_uniform_buffer_2[6u].xyz));
				float vertex_unnamed_397 = rsqrt(dot(float3(vertex_unnamed_391, vertex_unnamed_375, vertex_unnamed_383), float3(vertex_unnamed_391, vertex_unnamed_375, vertex_unnamed_383)));
				precise float vertex_unnamed_398 = vertex_unnamed_397 * vertex_unnamed_391;
				precise float vertex_unnamed_399 = vertex_unnamed_397 * vertex_unnamed_375;
				precise float vertex_unnamed_400 = vertex_unnamed_397 * vertex_unnamed_383;
				float vertex_unnamed_408 = mad(vertex_uniform_buffer_2[3u].x, vertex_input_0.w, vertex_unnamed_99);
				float vertex_unnamed_409 = mad(vertex_uniform_buffer_2[3u].y, vertex_input_0.w, vertex_unnamed_100);
				float vertex_unnamed_410 = mad(vertex_uniform_buffer_2[3u].z, vertex_input_0.w, vertex_unnamed_101);
				float vertex_unnamed_419 = mad(vertex_uniform_buffer_2[3u].x, vertex_input_0.w, vertex_unnamed_99);
				float vertex_unnamed_420 = mad(vertex_uniform_buffer_2[3u].y, vertex_input_0.w, vertex_unnamed_100);
				float vertex_unnamed_421 = mad(vertex_uniform_buffer_2[3u].z, vertex_input_0.w, vertex_unnamed_101);
				float vertex_unnamed_422 = mad(vertex_uniform_buffer_2[3u].w, vertex_input_0.w, vertex_unnamed_102);
				precise float vertex_unnamed_423 = (-0.0f) - vertex_unnamed_408;
				precise float vertex_unnamed_424 = (-0.0f) - vertex_unnamed_409;
				precise float vertex_unnamed_425 = (-0.0f) - vertex_unnamed_410;
				precise float vertex_unnamed_431 = vertex_unnamed_423 + vertex_uniform_buffer_1[4u].x;
				precise float vertex_unnamed_432 = vertex_unnamed_424 + vertex_uniform_buffer_1[4u].y;
				precise float vertex_unnamed_433 = vertex_unnamed_425 + vertex_uniform_buffer_1[4u].z;
				vertex_output_6.x = vertex_unnamed_408;
				vertex_output_6.y = vertex_unnamed_409;
				vertex_output_6.z = vertex_unnamed_410;
				float vertex_unnamed_440 = rsqrt(dot(float3(vertex_unnamed_431, vertex_unnamed_432, vertex_unnamed_433), float3(vertex_unnamed_431, vertex_unnamed_432, vertex_unnamed_433)));
				precise float vertex_unnamed_441 = vertex_unnamed_440 * vertex_unnamed_431;
				precise float vertex_unnamed_442 = vertex_unnamed_440 * vertex_unnamed_432;
				precise float vertex_unnamed_443 = vertex_unnamed_440 * vertex_unnamed_433;
				vertex_output_2.y = mad(abs(dot(float3(vertex_unnamed_399, vertex_unnamed_400, vertex_unnamed_398), float3(vertex_unnamed_441, vertex_unnamed_442, vertex_unnamed_443))), mad(vertex_unnamed_268, vertex_unnamed_282, vertex_unnamed_290), vertex_unnamed_289);
				precise float vertex_unnamed_461 = (-0.0f) - vertex_uniform_buffer_0[28u].y;
				precise float vertex_unnamed_465 = vertex_unnamed_461 + vertex_uniform_buffer_0[28u].z;
				precise float vertex_unnamed_478 = mad(mad(asfloat(((0.0f >= vertex_input_4.y) ? 4294967295u : 0u) & 1065353216u), vertex_unnamed_465, vertex_uniform_buffer_0[28u].y), 0.25f, vertex_uniform_buffer_0[10u].x) * vertex_uniform_buffer_0[28u].w;
				precise float vertex_unnamed_479 = vertex_unnamed_478 * 0.5f;
				vertex_output_2.x = vertex_unnamed_479;
				vertex_output_3.z = vertex_unnamed_399;
				precise float vertex_unnamed_490 = vertex_input_1.y * vertex_uniform_buffer_2[1u].y;
				precise float vertex_unnamed_491 = vertex_input_1.y * vertex_uniform_buffer_2[1u].z;
				precise float vertex_unnamed_492 = vertex_input_1.y * vertex_uniform_buffer_2[1u].x;
				float vertex_unnamed_510 = mad(vertex_uniform_buffer_2[2u].y, vertex_input_1.z, mad(vertex_uniform_buffer_2[0u].y, vertex_input_1.x, vertex_unnamed_490));
				float vertex_unnamed_511 = mad(vertex_uniform_buffer_2[2u].z, vertex_input_1.z, mad(vertex_uniform_buffer_2[0u].z, vertex_input_1.x, vertex_unnamed_491));
				float vertex_unnamed_512 = mad(vertex_uniform_buffer_2[2u].x, vertex_input_1.z, mad(vertex_uniform_buffer_2[0u].x, vertex_input_1.x, vertex_unnamed_492));
				float vertex_unnamed_516 = rsqrt(dot(float3(vertex_unnamed_510, vertex_unnamed_511, vertex_unnamed_512), float3(vertex_unnamed_510, vertex_unnamed_511, vertex_unnamed_512)));
				precise float vertex_unnamed_517 = vertex_unnamed_516 * vertex_unnamed_510;
				precise float vertex_unnamed_518 = vertex_unnamed_516 * vertex_unnamed_511;
				precise float vertex_unnamed_519 = vertex_unnamed_516 * vertex_unnamed_512;
				precise float vertex_unnamed_520 = vertex_unnamed_398 * vertex_unnamed_517;
				precise float vertex_unnamed_521 = vertex_unnamed_399 * vertex_unnamed_518;
				precise float vertex_unnamed_522 = vertex_unnamed_400 * vertex_unnamed_519;
				precise float vertex_unnamed_523 = (-0.0f) - vertex_unnamed_520;
				precise float vertex_unnamed_524 = (-0.0f) - vertex_unnamed_521;
				precise float vertex_unnamed_525 = (-0.0f) - vertex_unnamed_522;
				precise float vertex_unnamed_535 = vertex_input_1.w * vertex_uniform_buffer_2[9u].w;
				precise float vertex_unnamed_536 = vertex_unnamed_535 * mad(vertex_unnamed_400, vertex_unnamed_518, vertex_unnamed_523);
				precise float vertex_unnamed_537 = vertex_unnamed_535 * mad(vertex_unnamed_398, vertex_unnamed_519, vertex_unnamed_524);
				precise float vertex_unnamed_538 = vertex_unnamed_535 * mad(vertex_unnamed_399, vertex_unnamed_517, vertex_unnamed_525);
				vertex_output_3.y = vertex_unnamed_536;
				vertex_output_3.x = vertex_unnamed_519;
				vertex_output_4.z = vertex_unnamed_400;
				vertex_output_5.z = vertex_unnamed_398;
				vertex_output_4.x = vertex_unnamed_517;
				vertex_output_5.x = vertex_unnamed_518;
				vertex_output_4.y = vertex_unnamed_537;
				vertex_output_5.y = vertex_unnamed_538;
				vertex_output_7.x = vertex_input_7.x;
				vertex_output_7.y = vertex_input_7.y;
				vertex_output_7.z = vertex_input_7.z;
				vertex_output_7.w = vertex_input_7.w;
				precise float vertex_unnamed_564 = vertex_unnamed_432 * vertex_uniform_buffer_0[18u].x;
				precise float vertex_unnamed_565 = vertex_unnamed_432 * vertex_uniform_buffer_0[18u].y;
				precise float vertex_unnamed_566 = vertex_unnamed_432 * vertex_uniform_buffer_0[18u].z;
				vertex_output_8.x = mad(vertex_uniform_buffer_0[19u].x, vertex_unnamed_433, mad(vertex_uniform_buffer_0[17u].x, vertex_unnamed_431, vertex_unnamed_564));
				vertex_output_8.y = mad(vertex_uniform_buffer_0[19u].y, vertex_unnamed_433, mad(vertex_uniform_buffer_0[17u].y, vertex_unnamed_431, vertex_unnamed_565));
				vertex_output_8.z = mad(vertex_uniform_buffer_0[19u].z, vertex_unnamed_433, mad(vertex_uniform_buffer_0[17u].z, vertex_unnamed_431, vertex_unnamed_566));
				precise float vertex_unnamed_591 = vertex_unnamed_420 * vertex_uniform_buffer_0[5u].x;
				precise float vertex_unnamed_592 = vertex_unnamed_420 * vertex_uniform_buffer_0[5u].y;
				precise float vertex_unnamed_593 = vertex_unnamed_420 * vertex_uniform_buffer_0[5u].z;
				vertex_output_9.x = mad(vertex_uniform_buffer_0[7u].x, vertex_unnamed_422, mad(vertex_uniform_buffer_0[6u].x, vertex_unnamed_421, mad(vertex_uniform_buffer_0[4u].x, vertex_unnamed_419, vertex_unnamed_591)));
				vertex_output_9.y = mad(vertex_uniform_buffer_0[7u].y, vertex_unnamed_422, mad(vertex_uniform_buffer_0[6u].y, vertex_unnamed_421, mad(vertex_uniform_buffer_0[4u].y, vertex_unnamed_419, vertex_unnamed_592)));
				vertex_output_9.z = mad(vertex_uniform_buffer_0[7u].z, vertex_unnamed_422, mad(vertex_uniform_buffer_0[6u].z, vertex_unnamed_421, mad(vertex_uniform_buffer_0[4u].z, vertex_unnamed_419, vertex_unnamed_593)));
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[4] = float4(unity_WorldToLight[0][0], unity_WorldToLight[1][0], unity_WorldToLight[2][0], unity_WorldToLight[3][0]);
				vertex_uniform_buffer_0[5] = float4(unity_WorldToLight[0][1], unity_WorldToLight[1][1], unity_WorldToLight[2][1], unity_WorldToLight[3][1]);
				vertex_uniform_buffer_0[6] = float4(unity_WorldToLight[0][2], unity_WorldToLight[1][2], unity_WorldToLight[2][2], unity_WorldToLight[3][2]);
				vertex_uniform_buffer_0[7] = float4(unity_WorldToLight[0][3], unity_WorldToLight[1][3], unity_WorldToLight[2][3], unity_WorldToLight[3][3]);

				vertex_uniform_buffer_0[10] = float4(_FaceDilate, vertex_uniform_buffer_0[10][1], vertex_uniform_buffer_0[10][2], vertex_uniform_buffer_0[10][3]);

				vertex_uniform_buffer_0[17] = float4(_EnvMatrix[0][0], _EnvMatrix[1][0], _EnvMatrix[2][0], _EnvMatrix[3][0]);
				vertex_uniform_buffer_0[18] = float4(_EnvMatrix[0][1], _EnvMatrix[1][1], _EnvMatrix[2][1], _EnvMatrix[3][1]);
				vertex_uniform_buffer_0[19] = float4(_EnvMatrix[0][2], _EnvMatrix[1][2], _EnvMatrix[2][2], _EnvMatrix[3][2]);
				vertex_uniform_buffer_0[20] = float4(_EnvMatrix[0][3], _EnvMatrix[1][3], _EnvMatrix[2][3], _EnvMatrix[3][3]);

				vertex_uniform_buffer_0[28] = float4(vertex_uniform_buffer_0[28][0], _WeightNormal, vertex_uniform_buffer_0[28][2], vertex_uniform_buffer_0[28][3]);

				vertex_uniform_buffer_0[28] = float4(vertex_uniform_buffer_0[28][0], vertex_uniform_buffer_0[28][1], _WeightBold, vertex_uniform_buffer_0[28][3]);

				vertex_uniform_buffer_0[28] = float4(vertex_uniform_buffer_0[28][0], vertex_uniform_buffer_0[28][1], vertex_uniform_buffer_0[28][2], _ScaleRatioA);

				vertex_uniform_buffer_0[29] = float4(vertex_uniform_buffer_0[29][0], vertex_uniform_buffer_0[29][1], _VertexOffsetX, vertex_uniform_buffer_0[29][3]);

				vertex_uniform_buffer_0[29] = float4(vertex_uniform_buffer_0[29][0], vertex_uniform_buffer_0[29][1], vertex_uniform_buffer_0[29][2], _VertexOffsetY);

				vertex_uniform_buffer_0[34] = float4(_GradientScale, vertex_uniform_buffer_0[34][1], vertex_uniform_buffer_0[34][2], vertex_uniform_buffer_0[34][3]);

				vertex_uniform_buffer_0[34] = float4(vertex_uniform_buffer_0[34][0], _ScaleX, vertex_uniform_buffer_0[34][2], vertex_uniform_buffer_0[34][3]);

				vertex_uniform_buffer_0[34] = float4(vertex_uniform_buffer_0[34][0], vertex_uniform_buffer_0[34][1], _ScaleY, vertex_uniform_buffer_0[34][3]);

				vertex_uniform_buffer_0[34] = float4(vertex_uniform_buffer_0[34][0], vertex_uniform_buffer_0[34][1], vertex_uniform_buffer_0[34][2], _PerspectiveFilter);

				vertex_uniform_buffer_0[35] = float4(_Sharpness, vertex_uniform_buffer_0[35][1], vertex_uniform_buffer_0[35][2], vertex_uniform_buffer_0[35][3]);

				vertex_uniform_buffer_0[36] = float4(_MainTex_ST[0], _MainTex_ST[1], _MainTex_ST[2], _MainTex_ST[3]);

				vertex_uniform_buffer_0[37] = float4(_FaceTex_ST[0], _FaceTex_ST[1], _FaceTex_ST[2], _FaceTex_ST[3]);

				vertex_uniform_buffer_0[38] = float4(_OutlineTex_ST[0], _OutlineTex_ST[1], _OutlineTex_ST[2], _OutlineTex_ST[3]);

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

				vertex_uniform_buffer_2[9] = float4(unity_WorldTransformParams[0], unity_WorldTransformParams[1], unity_WorldTransformParams[2], unity_WorldTransformParams[3]);

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
				vertex_input_5 = stage_input.vertex_input_5;
				vertex_input_6 = stage_input.vertex_input_6;
				vertex_input_7 = stage_input.vertex_input_7;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
				stage_output.vertex_output_6 = vertex_output_6;
				stage_output.vertex_output_7 = vertex_output_7;
				stage_output.vertex_output_8 = vertex_output_8;
				stage_output.vertex_output_9 = vertex_output_9;
				return stage_output;
			}

			#endif // POINT
			#endif // !DIRECTIONAL
			#endif // !DIRECTIONAL_COOKIE
			#endif // !POINT_COOKIE
			#endif // !SPOT


			#ifdef DIRECTIONAL
			#ifndef DIRECTIONAL_COOKIE
			#ifndef POINT
			#ifndef POINT_COOKIE
			#ifndef SPOT
			#define ANY_SHADER_VARIANT_ACTIVE

			float _FaceDilate;
			float4x4 _EnvMatrix;
			float _WeightNormal;
			float _WeightBold;
			float _ScaleRatioA;
			float _VertexOffsetX;
			float _VertexOffsetY;
			float _GradientScale;
			float _ScaleX;
			float _ScaleY;
			float _PerspectiveFilter;
			float _Sharpness;
			float4 _MainTex_ST;
			float4 _FaceTex_ST;
			float4 _OutlineTex_ST;
			float3 _WorldSpaceCameraPos;
			float4 _ScreenParams;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4 unity_WorldTransformParams;
			float4x4 glstate_matrix_projection;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[35];
			static float4 vertex_uniform_buffer_1[7];
			static float4 vertex_uniform_buffer_2[10];
			static float4 vertex_uniform_buffer_3[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float3 vertex_input_2;
			static float4 vertex_input_3;
			static float4 vertex_input_4;
			static float4 vertex_input_5;
			static float4 vertex_input_6;
			static float4 vertex_input_7;
			static float4 vertex_output_1;
			static float2 vertex_output_2;
			static float2 vertex_output_2;
			static float3 vertex_output_3;
			static float3 vertex_output_4;
			static float3 vertex_output_5;
			static float3 vertex_output_6;
			static float4 vertex_output_7;
			static float3 vertex_output_8;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION; // POSITION
				float4 vertex_input_1 : TANGENT; // TANGENT
				float3 vertex_input_2 : NORMAL; // NORMAL
				float4 vertex_input_3 : TEXCOORD; // TEXCOORD
				float4 vertex_input_4 : TEXCOORD1; // TEXCOORD_1
				float4 vertex_input_5 : TEXCOORD2; // TEXCOORD_2
				float4 vertex_input_6 : TEXCOORD3; // TEXCOORD_3
				float4 vertex_input_7 : COLOR; // COLOR
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : TEXCOORD; // TEXCOORD
				float2 vertex_output_2 : TEXCOORD1; // TEXCOORD_1
				float2 vertex_output_2 : TEXCOORD6; // TEXCOORD_6
				float3 vertex_output_3 : TEXCOORD2; // TEXCOORD_2
				float3 vertex_output_4 : TEXCOORD3; // TEXCOORD_3
				float3 vertex_output_5 : TEXCOORD4; // TEXCOORD_4
				float3 vertex_output_6 : TEXCOORD5; // TEXCOORD_5
				float4 vertex_output_7 : COLOR; // COLOR
				float3 vertex_output_8 : TEXCOORD7; // TEXCOORD_7
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_66 = vertex_input_0.x + vertex_uniform_buffer_0[25u].z;
				precise float vertex_unnamed_67 = vertex_input_0.y + vertex_uniform_buffer_0[25u].w;
				precise float vertex_unnamed_74 = vertex_unnamed_67 * vertex_uniform_buffer_2[1u].x;
				precise float vertex_unnamed_75 = vertex_unnamed_67 * vertex_uniform_buffer_2[1u].y;
				precise float vertex_unnamed_76 = vertex_unnamed_67 * vertex_uniform_buffer_2[1u].z;
				precise float vertex_unnamed_77 = vertex_unnamed_67 * vertex_uniform_buffer_2[1u].w;
				float vertex_unnamed_98 = mad(vertex_uniform_buffer_2[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].x, vertex_unnamed_66, vertex_unnamed_74));
				float vertex_unnamed_99 = mad(vertex_uniform_buffer_2[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].y, vertex_unnamed_66, vertex_unnamed_75));
				float vertex_unnamed_100 = mad(vertex_uniform_buffer_2[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].z, vertex_unnamed_66, vertex_unnamed_76));
				precise float vertex_unnamed_109 = vertex_unnamed_98 + vertex_uniform_buffer_2[3u].x;
				precise float vertex_unnamed_110 = vertex_unnamed_99 + vertex_uniform_buffer_2[3u].y;
				precise float vertex_unnamed_111 = vertex_unnamed_100 + vertex_uniform_buffer_2[3u].z;
				precise float vertex_unnamed_112 = mad(vertex_uniform_buffer_2[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].w, vertex_unnamed_66, vertex_unnamed_77)) + vertex_uniform_buffer_2[3u].w;
				float vertex_unnamed_120 = mad(vertex_uniform_buffer_2[3u].x, vertex_input_0.w, vertex_unnamed_98);
				float vertex_unnamed_121 = mad(vertex_uniform_buffer_2[3u].y, vertex_input_0.w, vertex_unnamed_99);
				float vertex_unnamed_122 = mad(vertex_uniform_buffer_2[3u].z, vertex_input_0.w, vertex_unnamed_100);
				precise float vertex_unnamed_130 = vertex_unnamed_110 * vertex_uniform_buffer_3[18u].x;
				precise float vertex_unnamed_131 = vertex_unnamed_110 * vertex_uniform_buffer_3[18u].y;
				precise float vertex_unnamed_132 = vertex_unnamed_110 * vertex_uniform_buffer_3[18u].z;
				precise float vertex_unnamed_133 = vertex_unnamed_110 * vertex_uniform_buffer_3[18u].w;
				gl_Position.x = mad(vertex_uniform_buffer_3[20u].x, vertex_unnamed_112, mad(vertex_uniform_buffer_3[19u].x, vertex_unnamed_111, mad(vertex_uniform_buffer_3[17u].x, vertex_unnamed_109, vertex_unnamed_130)));
				gl_Position.y = mad(vertex_uniform_buffer_3[20u].y, vertex_unnamed_112, mad(vertex_uniform_buffer_3[19u].y, vertex_unnamed_111, mad(vertex_uniform_buffer_3[17u].y, vertex_unnamed_109, vertex_unnamed_131)));
				gl_Position.z = mad(vertex_uniform_buffer_3[20u].z, vertex_unnamed_112, mad(vertex_uniform_buffer_3[19u].z, vertex_unnamed_111, mad(vertex_uniform_buffer_3[17u].z, vertex_unnamed_109, vertex_unnamed_132)));
				gl_Position.w = mad(vertex_uniform_buffer_3[20u].w, vertex_unnamed_112, mad(vertex_uniform_buffer_3[19u].w, vertex_unnamed_111, mad(vertex_uniform_buffer_3[17u].w, vertex_unnamed_109, vertex_unnamed_133)));
				precise float vertex_unnamed_174 = vertex_input_4.x * 0.000244140625f;
				float vertex_unnamed_176 = floor(vertex_unnamed_174);
				precise float vertex_unnamed_177 = (-0.0f) - vertex_unnamed_176;
				precise float vertex_unnamed_183 = vertex_unnamed_176 * 0.001953125f;
				precise float vertex_unnamed_185 = mad(vertex_unnamed_177, 4096.0f, vertex_input_4.x) * 0.001953125f;
				vertex_output_1.z = mad(vertex_unnamed_183, vertex_uniform_buffer_0[33u].x, vertex_uniform_buffer_0[33u].z);
				vertex_output_1.w = mad(vertex_unnamed_185, vertex_uniform_buffer_0[33u].y, vertex_uniform_buffer_0[33u].w);
				vertex_output_2.x = mad(vertex_unnamed_183, vertex_uniform_buffer_0[34u].x, vertex_uniform_buffer_0[34u].z);
				vertex_output_2.y = mad(vertex_unnamed_185, vertex_uniform_buffer_0[34u].y, vertex_uniform_buffer_0[34u].w);
				vertex_output_1.x = mad(vertex_input_3.x, vertex_uniform_buffer_0[32u].x, vertex_uniform_buffer_0[32u].z);
				vertex_output_1.y = mad(vertex_input_3.y, vertex_uniform_buffer_0[32u].y, vertex_uniform_buffer_0[32u].w);
				precise float vertex_unnamed_232 = vertex_unnamed_110 * vertex_uniform_buffer_3[18u].w;
				float vertex_unnamed_244 = mad(vertex_uniform_buffer_3[20u].w, vertex_unnamed_112, mad(vertex_uniform_buffer_3[19u].w, vertex_unnamed_111, mad(vertex_uniform_buffer_3[17u].w, vertex_unnamed_109, vertex_unnamed_232)));
				precise float vertex_unnamed_253 = vertex_uniform_buffer_1[6u].y * vertex_uniform_buffer_3[6u].x;
				precise float vertex_unnamed_254 = vertex_uniform_buffer_1[6u].y * vertex_uniform_buffer_3[6u].y;
				precise float vertex_unnamed_270 = mad(vertex_uniform_buffer_3[5u].x, vertex_uniform_buffer_1[6u].x, vertex_unnamed_253) * vertex_uniform_buffer_0[30u].y;
				precise float vertex_unnamed_271 = mad(vertex_uniform_buffer_3[5u].y, vertex_uniform_buffer_1[6u].x, vertex_unnamed_254) * vertex_uniform_buffer_0[30u].z;
				precise float vertex_unnamed_272 = vertex_unnamed_244 / vertex_unnamed_270;
				precise float vertex_unnamed_273 = vertex_unnamed_244 / vertex_unnamed_271;
				float vertex_unnamed_277 = rsqrt(dot(float2(vertex_unnamed_272, vertex_unnamed_273), float2(vertex_unnamed_272, vertex_unnamed_273)));
				precise float vertex_unnamed_284 = abs(vertex_input_4.y) * vertex_uniform_buffer_0[30u].x;
				precise float vertex_unnamed_289 = vertex_uniform_buffer_0[31u].x + 1.0f;
				precise float vertex_unnamed_291 = vertex_unnamed_284 * vertex_unnamed_289;
				precise float vertex_unnamed_292 = vertex_unnamed_277 * vertex_unnamed_291;
				precise float vertex_unnamed_296 = (-0.0f) - vertex_uniform_buffer_0[30u].w;
				precise float vertex_unnamed_297 = vertex_unnamed_296 + 1.0f;
				precise float vertex_unnamed_298 = vertex_unnamed_297 * vertex_unnamed_292;
				precise float vertex_unnamed_299 = (-0.0f) - vertex_unnamed_298;
				precise float vertex_unnamed_310 = vertex_uniform_buffer_1[4u].y * vertex_uniform_buffer_2[5u].x;
				precise float vertex_unnamed_311 = vertex_uniform_buffer_1[4u].y * vertex_uniform_buffer_2[5u].y;
				precise float vertex_unnamed_312 = vertex_uniform_buffer_1[4u].y * vertex_uniform_buffer_2[5u].z;
				precise float vertex_unnamed_340 = mad(vertex_uniform_buffer_2[6u].x, vertex_uniform_buffer_1[4u].z, mad(vertex_uniform_buffer_2[4u].x, vertex_uniform_buffer_1[4u].x, vertex_unnamed_310)) + vertex_uniform_buffer_2[7u].x;
				precise float vertex_unnamed_341 = mad(vertex_uniform_buffer_2[6u].y, vertex_uniform_buffer_1[4u].z, mad(vertex_uniform_buffer_2[4u].y, vertex_uniform_buffer_1[4u].x, vertex_unnamed_311)) + vertex_uniform_buffer_2[7u].y;
				precise float vertex_unnamed_342 = mad(vertex_uniform_buffer_2[6u].z, vertex_uniform_buffer_1[4u].z, mad(vertex_uniform_buffer_2[4u].z, vertex_uniform_buffer_1[4u].x, vertex_unnamed_312)) + vertex_uniform_buffer_2[7u].z;
				precise float vertex_unnamed_345 = (-0.0f) - vertex_unnamed_66;
				precise float vertex_unnamed_346 = (-0.0f) - vertex_unnamed_67;
				precise float vertex_unnamed_347 = (-0.0f) - vertex_input_0.z;
				precise float vertex_unnamed_348 = vertex_unnamed_345 + vertex_unnamed_340;
				precise float vertex_unnamed_349 = vertex_unnamed_346 + vertex_unnamed_341;
				precise float vertex_unnamed_350 = vertex_unnamed_347 + vertex_unnamed_342;
				float vertex_unnamed_357 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_unnamed_348, vertex_unnamed_349, vertex_unnamed_350));
				float vertex_unnamed_369 = float(int((-((0.0f < vertex_unnamed_357) ? 4294967295u : 0u)) + ((vertex_unnamed_357 < 0.0f) ? 4294967295u : 0u)));
				precise float vertex_unnamed_376 = vertex_unnamed_369 * vertex_input_2.x;
				precise float vertex_unnamed_377 = vertex_unnamed_369 * vertex_input_2.y;
				precise float vertex_unnamed_378 = vertex_unnamed_369 * vertex_input_2.z;
				float vertex_unnamed_384 = dot(float3(vertex_unnamed_376, vertex_unnamed_377, vertex_unnamed_378), float3(vertex_uniform_buffer_2[4u].xyz));
				float vertex_unnamed_392 = dot(float3(vertex_unnamed_376, vertex_unnamed_377, vertex_unnamed_378), float3(vertex_uniform_buffer_2[5u].xyz));
				float vertex_unnamed_400 = dot(float3(vertex_unnamed_376, vertex_unnamed_377, vertex_unnamed_378), float3(vertex_uniform_buffer_2[6u].xyz));
				float vertex_unnamed_406 = rsqrt(dot(float3(vertex_unnamed_400, vertex_unnamed_384, vertex_unnamed_392), float3(vertex_unnamed_400, vertex_unnamed_384, vertex_unnamed_392)));
				precise float vertex_unnamed_407 = vertex_unnamed_406 * vertex_unnamed_400;
				precise float vertex_unnamed_408 = vertex_unnamed_406 * vertex_unnamed_384;
				precise float vertex_unnamed_409 = vertex_unnamed_406 * vertex_unnamed_392;
				precise float vertex_unnamed_410 = (-0.0f) - vertex_unnamed_120;
				precise float vertex_unnamed_411 = (-0.0f) - vertex_unnamed_121;
				precise float vertex_unnamed_412 = (-0.0f) - vertex_unnamed_122;
				precise float vertex_unnamed_418 = vertex_unnamed_410 + vertex_uniform_buffer_1[4u].x;
				precise float vertex_unnamed_419 = vertex_unnamed_411 + vertex_uniform_buffer_1[4u].y;
				precise float vertex_unnamed_420 = vertex_unnamed_412 + vertex_uniform_buffer_1[4u].z;
				vertex_output_6.x = vertex_unnamed_120;
				vertex_output_6.y = vertex_unnamed_121;
				vertex_output_6.z = vertex_unnamed_122;
				float vertex_unnamed_427 = rsqrt(dot(float3(vertex_unnamed_418, vertex_unnamed_419, vertex_unnamed_420), float3(vertex_unnamed_418, vertex_unnamed_419, vertex_unnamed_420)));
				precise float vertex_unnamed_428 = vertex_unnamed_427 * vertex_unnamed_418;
				precise float vertex_unnamed_429 = vertex_unnamed_427 * vertex_unnamed_419;
				precise float vertex_unnamed_430 = vertex_unnamed_427 * vertex_unnamed_420;
				vertex_output_2.y = mad(abs(dot(float3(vertex_unnamed_408, vertex_unnamed_409, vertex_unnamed_407), float3(vertex_unnamed_428, vertex_unnamed_429, vertex_unnamed_430))), mad(vertex_unnamed_277, vertex_unnamed_291, vertex_unnamed_299), vertex_unnamed_298);
				precise float vertex_unnamed_448 = (-0.0f) - vertex_uniform_buffer_0[24u].y;
				precise float vertex_unnamed_452 = vertex_unnamed_448 + vertex_uniform_buffer_0[24u].z;
				precise float vertex_unnamed_465 = mad(mad(asfloat(((0.0f >= vertex_input_4.y) ? 4294967295u : 0u) & 1065353216u), vertex_unnamed_452, vertex_uniform_buffer_0[24u].y), 0.25f, vertex_uniform_buffer_0[6u].x) * vertex_uniform_buffer_0[24u].w;
				precise float vertex_unnamed_466 = vertex_unnamed_465 * 0.5f;
				vertex_output_2.x = vertex_unnamed_466;
				vertex_output_3.z = vertex_unnamed_408;
				precise float vertex_unnamed_477 = vertex_input_1.y * vertex_uniform_buffer_2[1u].y;
				precise float vertex_unnamed_478 = vertex_input_1.y * vertex_uniform_buffer_2[1u].z;
				precise float vertex_unnamed_479 = vertex_input_1.y * vertex_uniform_buffer_2[1u].x;
				float vertex_unnamed_497 = mad(vertex_uniform_buffer_2[2u].y, vertex_input_1.z, mad(vertex_uniform_buffer_2[0u].y, vertex_input_1.x, vertex_unnamed_477));
				float vertex_unnamed_498 = mad(vertex_uniform_buffer_2[2u].z, vertex_input_1.z, mad(vertex_uniform_buffer_2[0u].z, vertex_input_1.x, vertex_unnamed_478));
				float vertex_unnamed_499 = mad(vertex_uniform_buffer_2[2u].x, vertex_input_1.z, mad(vertex_uniform_buffer_2[0u].x, vertex_input_1.x, vertex_unnamed_479));
				float vertex_unnamed_503 = rsqrt(dot(float3(vertex_unnamed_497, vertex_unnamed_498, vertex_unnamed_499), float3(vertex_unnamed_497, vertex_unnamed_498, vertex_unnamed_499)));
				precise float vertex_unnamed_504 = vertex_unnamed_503 * vertex_unnamed_497;
				precise float vertex_unnamed_505 = vertex_unnamed_503 * vertex_unnamed_498;
				precise float vertex_unnamed_506 = vertex_unnamed_503 * vertex_unnamed_499;
				precise float vertex_unnamed_507 = vertex_unnamed_407 * vertex_unnamed_504;
				precise float vertex_unnamed_508 = vertex_unnamed_408 * vertex_unnamed_505;
				precise float vertex_unnamed_509 = vertex_unnamed_409 * vertex_unnamed_506;
				precise float vertex_unnamed_510 = (-0.0f) - vertex_unnamed_507;
				precise float vertex_unnamed_511 = (-0.0f) - vertex_unnamed_508;
				precise float vertex_unnamed_512 = (-0.0f) - vertex_unnamed_509;
				precise float vertex_unnamed_522 = vertex_input_1.w * vertex_uniform_buffer_2[9u].w;
				precise float vertex_unnamed_523 = vertex_unnamed_522 * mad(vertex_unnamed_409, vertex_unnamed_505, vertex_unnamed_510);
				precise float vertex_unnamed_524 = vertex_unnamed_522 * mad(vertex_unnamed_407, vertex_unnamed_506, vertex_unnamed_511);
				precise float vertex_unnamed_525 = vertex_unnamed_522 * mad(vertex_unnamed_408, vertex_unnamed_504, vertex_unnamed_512);
				vertex_output_3.y = vertex_unnamed_523;
				vertex_output_3.x = vertex_unnamed_506;
				vertex_output_4.z = vertex_unnamed_409;
				vertex_output_5.z = vertex_unnamed_407;
				vertex_output_4.x = vertex_unnamed_504;
				vertex_output_5.x = vertex_unnamed_505;
				vertex_output_4.y = vertex_unnamed_524;
				vertex_output_5.y = vertex_unnamed_525;
				vertex_output_7.x = vertex_input_7.x;
				vertex_output_7.y = vertex_input_7.y;
				vertex_output_7.z = vertex_input_7.z;
				vertex_output_7.w = vertex_input_7.w;
				precise float vertex_unnamed_552 = vertex_unnamed_419 * vertex_uniform_buffer_0[14u].x;
				precise float vertex_unnamed_553 = vertex_unnamed_419 * vertex_uniform_buffer_0[14u].y;
				precise float vertex_unnamed_554 = vertex_unnamed_419 * vertex_uniform_buffer_0[14u].z;
				vertex_output_8.x = mad(vertex_uniform_buffer_0[15u].x, vertex_unnamed_420, mad(vertex_uniform_buffer_0[13u].x, vertex_unnamed_418, vertex_unnamed_552));
				vertex_output_8.y = mad(vertex_uniform_buffer_0[15u].y, vertex_unnamed_420, mad(vertex_uniform_buffer_0[13u].y, vertex_unnamed_418, vertex_unnamed_553));
				vertex_output_8.z = mad(vertex_uniform_buffer_0[15u].z, vertex_unnamed_420, mad(vertex_uniform_buffer_0[13u].z, vertex_unnamed_418, vertex_unnamed_554));
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[6] = float4(_FaceDilate, vertex_uniform_buffer_0[6][1], vertex_uniform_buffer_0[6][2], vertex_uniform_buffer_0[6][3]);

				vertex_uniform_buffer_0[13] = float4(_EnvMatrix[0][0], _EnvMatrix[1][0], _EnvMatrix[2][0], _EnvMatrix[3][0]);
				vertex_uniform_buffer_0[14] = float4(_EnvMatrix[0][1], _EnvMatrix[1][1], _EnvMatrix[2][1], _EnvMatrix[3][1]);
				vertex_uniform_buffer_0[15] = float4(_EnvMatrix[0][2], _EnvMatrix[1][2], _EnvMatrix[2][2], _EnvMatrix[3][2]);
				vertex_uniform_buffer_0[16] = float4(_EnvMatrix[0][3], _EnvMatrix[1][3], _EnvMatrix[2][3], _EnvMatrix[3][3]);

				vertex_uniform_buffer_0[24] = float4(vertex_uniform_buffer_0[24][0], _WeightNormal, vertex_uniform_buffer_0[24][2], vertex_uniform_buffer_0[24][3]);

				vertex_uniform_buffer_0[24] = float4(vertex_uniform_buffer_0[24][0], vertex_uniform_buffer_0[24][1], _WeightBold, vertex_uniform_buffer_0[24][3]);

				vertex_uniform_buffer_0[24] = float4(vertex_uniform_buffer_0[24][0], vertex_uniform_buffer_0[24][1], vertex_uniform_buffer_0[24][2], _ScaleRatioA);

				vertex_uniform_buffer_0[25] = float4(vertex_uniform_buffer_0[25][0], vertex_uniform_buffer_0[25][1], _VertexOffsetX, vertex_uniform_buffer_0[25][3]);

				vertex_uniform_buffer_0[25] = float4(vertex_uniform_buffer_0[25][0], vertex_uniform_buffer_0[25][1], vertex_uniform_buffer_0[25][2], _VertexOffsetY);

				vertex_uniform_buffer_0[30] = float4(_GradientScale, vertex_uniform_buffer_0[30][1], vertex_uniform_buffer_0[30][2], vertex_uniform_buffer_0[30][3]);

				vertex_uniform_buffer_0[30] = float4(vertex_uniform_buffer_0[30][0], _ScaleX, vertex_uniform_buffer_0[30][2], vertex_uniform_buffer_0[30][3]);

				vertex_uniform_buffer_0[30] = float4(vertex_uniform_buffer_0[30][0], vertex_uniform_buffer_0[30][1], _ScaleY, vertex_uniform_buffer_0[30][3]);

				vertex_uniform_buffer_0[30] = float4(vertex_uniform_buffer_0[30][0], vertex_uniform_buffer_0[30][1], vertex_uniform_buffer_0[30][2], _PerspectiveFilter);

				vertex_uniform_buffer_0[31] = float4(_Sharpness, vertex_uniform_buffer_0[31][1], vertex_uniform_buffer_0[31][2], vertex_uniform_buffer_0[31][3]);

				vertex_uniform_buffer_0[32] = float4(_MainTex_ST[0], _MainTex_ST[1], _MainTex_ST[2], _MainTex_ST[3]);

				vertex_uniform_buffer_0[33] = float4(_FaceTex_ST[0], _FaceTex_ST[1], _FaceTex_ST[2], _FaceTex_ST[3]);

				vertex_uniform_buffer_0[34] = float4(_OutlineTex_ST[0], _OutlineTex_ST[1], _OutlineTex_ST[2], _OutlineTex_ST[3]);

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

				vertex_uniform_buffer_2[9] = float4(unity_WorldTransformParams[0], unity_WorldTransformParams[1], unity_WorldTransformParams[2], unity_WorldTransformParams[3]);

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
				vertex_input_5 = stage_input.vertex_input_5;
				vertex_input_6 = stage_input.vertex_input_6;
				vertex_input_7 = stage_input.vertex_input_7;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
				stage_output.vertex_output_6 = vertex_output_6;
				stage_output.vertex_output_7 = vertex_output_7;
				stage_output.vertex_output_8 = vertex_output_8;
				return stage_output;
			}

			#endif // DIRECTIONAL
			#endif // !DIRECTIONAL_COOKIE
			#endif // !POINT
			#endif // !POINT_COOKIE
			#endif // !SPOT


			#ifdef SPOT
			#ifndef DIRECTIONAL
			#ifndef DIRECTIONAL_COOKIE
			#ifndef POINT
			#ifndef POINT_COOKIE
			#define ANY_SHADER_VARIANT_ACTIVE

			float4x4 unity_WorldToLight;
			float _FaceDilate;
			float4x4 _EnvMatrix;
			float _WeightNormal;
			float _WeightBold;
			float _ScaleRatioA;
			float _VertexOffsetX;
			float _VertexOffsetY;
			float _GradientScale;
			float _ScaleX;
			float _ScaleY;
			float _PerspectiveFilter;
			float _Sharpness;
			float4 _MainTex_ST;
			float4 _FaceTex_ST;
			float4 _OutlineTex_ST;
			float3 _WorldSpaceCameraPos;
			float4 _ScreenParams;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4 unity_WorldTransformParams;
			float4x4 glstate_matrix_projection;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[39];
			static float4 vertex_uniform_buffer_1[7];
			static float4 vertex_uniform_buffer_2[10];
			static float4 vertex_uniform_buffer_3[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float3 vertex_input_2;
			static float4 vertex_input_3;
			static float4 vertex_input_4;
			static float4 vertex_input_5;
			static float4 vertex_input_6;
			static float4 vertex_input_7;
			static float4 vertex_output_1;
			static float2 vertex_output_2;
			static float2 vertex_output_2;
			static float3 vertex_output_3;
			static float3 vertex_output_4;
			static float3 vertex_output_5;
			static float3 vertex_output_6;
			static float4 vertex_output_7;
			static float3 vertex_output_8;
			static float4 vertex_output_9;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION; // POSITION
				float4 vertex_input_1 : TANGENT; // TANGENT
				float3 vertex_input_2 : NORMAL; // NORMAL
				float4 vertex_input_3 : TEXCOORD; // TEXCOORD
				float4 vertex_input_4 : TEXCOORD1; // TEXCOORD_1
				float4 vertex_input_5 : TEXCOORD2; // TEXCOORD_2
				float4 vertex_input_6 : TEXCOORD3; // TEXCOORD_3
				float4 vertex_input_7 : COLOR; // COLOR
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : TEXCOORD; // TEXCOORD
				float2 vertex_output_2 : TEXCOORD1; // TEXCOORD_1
				float2 vertex_output_2 : TEXCOORD6; // TEXCOORD_6
				float3 vertex_output_3 : TEXCOORD2; // TEXCOORD_2
				float3 vertex_output_4 : TEXCOORD3; // TEXCOORD_3
				float3 vertex_output_5 : TEXCOORD4; // TEXCOORD_4
				float3 vertex_output_6 : TEXCOORD5; // TEXCOORD_5
				float4 vertex_output_7 : COLOR; // COLOR
				float3 vertex_output_8 : TEXCOORD7; // TEXCOORD_7
				float4 vertex_output_9 : TEXCOORD8; // TEXCOORD_8
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_67 = vertex_input_0.x + vertex_uniform_buffer_0[29u].z;
				precise float vertex_unnamed_68 = vertex_input_0.y + vertex_uniform_buffer_0[29u].w;
				precise float vertex_unnamed_75 = vertex_unnamed_68 * vertex_uniform_buffer_2[1u].x;
				precise float vertex_unnamed_76 = vertex_unnamed_68 * vertex_uniform_buffer_2[1u].y;
				precise float vertex_unnamed_77 = vertex_unnamed_68 * vertex_uniform_buffer_2[1u].z;
				precise float vertex_unnamed_78 = vertex_unnamed_68 * vertex_uniform_buffer_2[1u].w;
				float vertex_unnamed_99 = mad(vertex_uniform_buffer_2[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].x, vertex_unnamed_67, vertex_unnamed_75));
				float vertex_unnamed_100 = mad(vertex_uniform_buffer_2[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].y, vertex_unnamed_67, vertex_unnamed_76));
				float vertex_unnamed_101 = mad(vertex_uniform_buffer_2[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].z, vertex_unnamed_67, vertex_unnamed_77));
				float vertex_unnamed_102 = mad(vertex_uniform_buffer_2[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].w, vertex_unnamed_67, vertex_unnamed_78));
				precise float vertex_unnamed_110 = vertex_unnamed_99 + vertex_uniform_buffer_2[3u].x;
				precise float vertex_unnamed_111 = vertex_unnamed_100 + vertex_uniform_buffer_2[3u].y;
				precise float vertex_unnamed_112 = vertex_unnamed_101 + vertex_uniform_buffer_2[3u].z;
				precise float vertex_unnamed_113 = vertex_unnamed_102 + vertex_uniform_buffer_2[3u].w;
				precise float vertex_unnamed_121 = vertex_unnamed_111 * vertex_uniform_buffer_3[18u].x;
				precise float vertex_unnamed_122 = vertex_unnamed_111 * vertex_uniform_buffer_3[18u].y;
				precise float vertex_unnamed_123 = vertex_unnamed_111 * vertex_uniform_buffer_3[18u].z;
				precise float vertex_unnamed_124 = vertex_unnamed_111 * vertex_uniform_buffer_3[18u].w;
				gl_Position.x = mad(vertex_uniform_buffer_3[20u].x, vertex_unnamed_113, mad(vertex_uniform_buffer_3[19u].x, vertex_unnamed_112, mad(vertex_uniform_buffer_3[17u].x, vertex_unnamed_110, vertex_unnamed_121)));
				gl_Position.y = mad(vertex_uniform_buffer_3[20u].y, vertex_unnamed_113, mad(vertex_uniform_buffer_3[19u].y, vertex_unnamed_112, mad(vertex_uniform_buffer_3[17u].y, vertex_unnamed_110, vertex_unnamed_122)));
				gl_Position.z = mad(vertex_uniform_buffer_3[20u].z, vertex_unnamed_113, mad(vertex_uniform_buffer_3[19u].z, vertex_unnamed_112, mad(vertex_uniform_buffer_3[17u].z, vertex_unnamed_110, vertex_unnamed_123)));
				gl_Position.w = mad(vertex_uniform_buffer_3[20u].w, vertex_unnamed_113, mad(vertex_uniform_buffer_3[19u].w, vertex_unnamed_112, mad(vertex_uniform_buffer_3[17u].w, vertex_unnamed_110, vertex_unnamed_124)));
				precise float vertex_unnamed_165 = vertex_input_4.x * 0.000244140625f;
				float vertex_unnamed_167 = floor(vertex_unnamed_165);
				precise float vertex_unnamed_168 = (-0.0f) - vertex_unnamed_167;
				precise float vertex_unnamed_174 = vertex_unnamed_167 * 0.001953125f;
				precise float vertex_unnamed_176 = mad(vertex_unnamed_168, 4096.0f, vertex_input_4.x) * 0.001953125f;
				vertex_output_1.z = mad(vertex_unnamed_174, vertex_uniform_buffer_0[37u].x, vertex_uniform_buffer_0[37u].z);
				vertex_output_1.w = mad(vertex_unnamed_176, vertex_uniform_buffer_0[37u].y, vertex_uniform_buffer_0[37u].w);
				vertex_output_2.x = mad(vertex_unnamed_174, vertex_uniform_buffer_0[38u].x, vertex_uniform_buffer_0[38u].z);
				vertex_output_2.y = mad(vertex_unnamed_176, vertex_uniform_buffer_0[38u].y, vertex_uniform_buffer_0[38u].w);
				vertex_output_1.x = mad(vertex_input_3.x, vertex_uniform_buffer_0[36u].x, vertex_uniform_buffer_0[36u].z);
				vertex_output_1.y = mad(vertex_input_3.y, vertex_uniform_buffer_0[36u].y, vertex_uniform_buffer_0[36u].w);
				precise float vertex_unnamed_223 = vertex_unnamed_111 * vertex_uniform_buffer_3[18u].w;
				float vertex_unnamed_235 = mad(vertex_uniform_buffer_3[20u].w, vertex_unnamed_113, mad(vertex_uniform_buffer_3[19u].w, vertex_unnamed_112, mad(vertex_uniform_buffer_3[17u].w, vertex_unnamed_110, vertex_unnamed_223)));
				precise float vertex_unnamed_244 = vertex_uniform_buffer_1[6u].y * vertex_uniform_buffer_3[6u].x;
				precise float vertex_unnamed_245 = vertex_uniform_buffer_1[6u].y * vertex_uniform_buffer_3[6u].y;
				precise float vertex_unnamed_261 = mad(vertex_uniform_buffer_3[5u].x, vertex_uniform_buffer_1[6u].x, vertex_unnamed_244) * vertex_uniform_buffer_0[34u].y;
				precise float vertex_unnamed_262 = mad(vertex_uniform_buffer_3[5u].y, vertex_uniform_buffer_1[6u].x, vertex_unnamed_245) * vertex_uniform_buffer_0[34u].z;
				precise float vertex_unnamed_263 = vertex_unnamed_235 / vertex_unnamed_261;
				precise float vertex_unnamed_264 = vertex_unnamed_235 / vertex_unnamed_262;
				float vertex_unnamed_268 = rsqrt(dot(float2(vertex_unnamed_263, vertex_unnamed_264), float2(vertex_unnamed_263, vertex_unnamed_264)));
				precise float vertex_unnamed_275 = abs(vertex_input_4.y) * vertex_uniform_buffer_0[34u].x;
				precise float vertex_unnamed_280 = vertex_uniform_buffer_0[35u].x + 1.0f;
				precise float vertex_unnamed_282 = vertex_unnamed_280 * vertex_unnamed_275;
				precise float vertex_unnamed_283 = vertex_unnamed_268 * vertex_unnamed_282;
				precise float vertex_unnamed_287 = (-0.0f) - vertex_uniform_buffer_0[34u].w;
				precise float vertex_unnamed_288 = vertex_unnamed_287 + 1.0f;
				precise float vertex_unnamed_289 = vertex_unnamed_288 * vertex_unnamed_283;
				precise float vertex_unnamed_290 = (-0.0f) - vertex_unnamed_289;
				precise float vertex_unnamed_301 = vertex_uniform_buffer_1[4u].y * vertex_uniform_buffer_2[5u].x;
				precise float vertex_unnamed_302 = vertex_uniform_buffer_1[4u].y * vertex_uniform_buffer_2[5u].y;
				precise float vertex_unnamed_303 = vertex_uniform_buffer_1[4u].y * vertex_uniform_buffer_2[5u].z;
				precise float vertex_unnamed_331 = mad(vertex_uniform_buffer_2[6u].x, vertex_uniform_buffer_1[4u].z, mad(vertex_uniform_buffer_2[4u].x, vertex_uniform_buffer_1[4u].x, vertex_unnamed_301)) + vertex_uniform_buffer_2[7u].x;
				precise float vertex_unnamed_332 = mad(vertex_uniform_buffer_2[6u].y, vertex_uniform_buffer_1[4u].z, mad(vertex_uniform_buffer_2[4u].y, vertex_uniform_buffer_1[4u].x, vertex_unnamed_302)) + vertex_uniform_buffer_2[7u].y;
				precise float vertex_unnamed_333 = mad(vertex_uniform_buffer_2[6u].z, vertex_uniform_buffer_1[4u].z, mad(vertex_uniform_buffer_2[4u].z, vertex_uniform_buffer_1[4u].x, vertex_unnamed_303)) + vertex_uniform_buffer_2[7u].z;
				precise float vertex_unnamed_336 = (-0.0f) - vertex_unnamed_67;
				precise float vertex_unnamed_337 = (-0.0f) - vertex_unnamed_68;
				precise float vertex_unnamed_338 = (-0.0f) - vertex_input_0.z;
				precise float vertex_unnamed_339 = vertex_unnamed_336 + vertex_unnamed_331;
				precise float vertex_unnamed_340 = vertex_unnamed_337 + vertex_unnamed_332;
				precise float vertex_unnamed_341 = vertex_unnamed_338 + vertex_unnamed_333;
				float vertex_unnamed_348 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_unnamed_339, vertex_unnamed_340, vertex_unnamed_341));
				float vertex_unnamed_360 = float(int((-((0.0f < vertex_unnamed_348) ? 4294967295u : 0u)) + ((vertex_unnamed_348 < 0.0f) ? 4294967295u : 0u)));
				precise float vertex_unnamed_367 = vertex_unnamed_360 * vertex_input_2.x;
				precise float vertex_unnamed_368 = vertex_unnamed_360 * vertex_input_2.y;
				precise float vertex_unnamed_369 = vertex_unnamed_360 * vertex_input_2.z;
				float vertex_unnamed_375 = dot(float3(vertex_unnamed_367, vertex_unnamed_368, vertex_unnamed_369), float3(vertex_uniform_buffer_2[4u].xyz));
				float vertex_unnamed_383 = dot(float3(vertex_unnamed_367, vertex_unnamed_368, vertex_unnamed_369), float3(vertex_uniform_buffer_2[5u].xyz));
				float vertex_unnamed_391 = dot(float3(vertex_unnamed_367, vertex_unnamed_368, vertex_unnamed_369), float3(vertex_uniform_buffer_2[6u].xyz));
				float vertex_unnamed_397 = rsqrt(dot(float3(vertex_unnamed_391, vertex_unnamed_375, vertex_unnamed_383), float3(vertex_unnamed_391, vertex_unnamed_375, vertex_unnamed_383)));
				precise float vertex_unnamed_398 = vertex_unnamed_397 * vertex_unnamed_391;
				precise float vertex_unnamed_399 = vertex_unnamed_397 * vertex_unnamed_375;
				precise float vertex_unnamed_400 = vertex_unnamed_397 * vertex_unnamed_383;
				float vertex_unnamed_408 = mad(vertex_uniform_buffer_2[3u].x, vertex_input_0.w, vertex_unnamed_99);
				float vertex_unnamed_409 = mad(vertex_uniform_buffer_2[3u].y, vertex_input_0.w, vertex_unnamed_100);
				float vertex_unnamed_410 = mad(vertex_uniform_buffer_2[3u].z, vertex_input_0.w, vertex_unnamed_101);
				float vertex_unnamed_419 = mad(vertex_uniform_buffer_2[3u].x, vertex_input_0.w, vertex_unnamed_99);
				float vertex_unnamed_420 = mad(vertex_uniform_buffer_2[3u].y, vertex_input_0.w, vertex_unnamed_100);
				float vertex_unnamed_421 = mad(vertex_uniform_buffer_2[3u].z, vertex_input_0.w, vertex_unnamed_101);
				float vertex_unnamed_422 = mad(vertex_uniform_buffer_2[3u].w, vertex_input_0.w, vertex_unnamed_102);
				precise float vertex_unnamed_423 = (-0.0f) - vertex_unnamed_408;
				precise float vertex_unnamed_424 = (-0.0f) - vertex_unnamed_409;
				precise float vertex_unnamed_425 = (-0.0f) - vertex_unnamed_410;
				precise float vertex_unnamed_431 = vertex_unnamed_423 + vertex_uniform_buffer_1[4u].x;
				precise float vertex_unnamed_432 = vertex_unnamed_424 + vertex_uniform_buffer_1[4u].y;
				precise float vertex_unnamed_433 = vertex_unnamed_425 + vertex_uniform_buffer_1[4u].z;
				vertex_output_6.x = vertex_unnamed_408;
				vertex_output_6.y = vertex_unnamed_409;
				vertex_output_6.z = vertex_unnamed_410;
				float vertex_unnamed_440 = rsqrt(dot(float3(vertex_unnamed_431, vertex_unnamed_432, vertex_unnamed_433), float3(vertex_unnamed_431, vertex_unnamed_432, vertex_unnamed_433)));
				precise float vertex_unnamed_441 = vertex_unnamed_440 * vertex_unnamed_431;
				precise float vertex_unnamed_442 = vertex_unnamed_440 * vertex_unnamed_432;
				precise float vertex_unnamed_443 = vertex_unnamed_440 * vertex_unnamed_433;
				vertex_output_2.y = mad(abs(dot(float3(vertex_unnamed_399, vertex_unnamed_400, vertex_unnamed_398), float3(vertex_unnamed_441, vertex_unnamed_442, vertex_unnamed_443))), mad(vertex_unnamed_268, vertex_unnamed_282, vertex_unnamed_290), vertex_unnamed_289);
				precise float vertex_unnamed_461 = (-0.0f) - vertex_uniform_buffer_0[28u].y;
				precise float vertex_unnamed_465 = vertex_unnamed_461 + vertex_uniform_buffer_0[28u].z;
				precise float vertex_unnamed_478 = mad(mad(asfloat(((0.0f >= vertex_input_4.y) ? 4294967295u : 0u) & 1065353216u), vertex_unnamed_465, vertex_uniform_buffer_0[28u].y), 0.25f, vertex_uniform_buffer_0[10u].x) * vertex_uniform_buffer_0[28u].w;
				precise float vertex_unnamed_479 = vertex_unnamed_478 * 0.5f;
				vertex_output_2.x = vertex_unnamed_479;
				vertex_output_3.z = vertex_unnamed_399;
				precise float vertex_unnamed_490 = vertex_input_1.y * vertex_uniform_buffer_2[1u].y;
				precise float vertex_unnamed_491 = vertex_input_1.y * vertex_uniform_buffer_2[1u].z;
				precise float vertex_unnamed_492 = vertex_input_1.y * vertex_uniform_buffer_2[1u].x;
				float vertex_unnamed_510 = mad(vertex_uniform_buffer_2[2u].y, vertex_input_1.z, mad(vertex_uniform_buffer_2[0u].y, vertex_input_1.x, vertex_unnamed_490));
				float vertex_unnamed_511 = mad(vertex_uniform_buffer_2[2u].z, vertex_input_1.z, mad(vertex_uniform_buffer_2[0u].z, vertex_input_1.x, vertex_unnamed_491));
				float vertex_unnamed_512 = mad(vertex_uniform_buffer_2[2u].x, vertex_input_1.z, mad(vertex_uniform_buffer_2[0u].x, vertex_input_1.x, vertex_unnamed_492));
				float vertex_unnamed_516 = rsqrt(dot(float3(vertex_unnamed_510, vertex_unnamed_511, vertex_unnamed_512), float3(vertex_unnamed_510, vertex_unnamed_511, vertex_unnamed_512)));
				precise float vertex_unnamed_517 = vertex_unnamed_516 * vertex_unnamed_510;
				precise float vertex_unnamed_518 = vertex_unnamed_516 * vertex_unnamed_511;
				precise float vertex_unnamed_519 = vertex_unnamed_516 * vertex_unnamed_512;
				precise float vertex_unnamed_520 = vertex_unnamed_398 * vertex_unnamed_517;
				precise float vertex_unnamed_521 = vertex_unnamed_399 * vertex_unnamed_518;
				precise float vertex_unnamed_522 = vertex_unnamed_400 * vertex_unnamed_519;
				precise float vertex_unnamed_523 = (-0.0f) - vertex_unnamed_520;
				precise float vertex_unnamed_524 = (-0.0f) - vertex_unnamed_521;
				precise float vertex_unnamed_525 = (-0.0f) - vertex_unnamed_522;
				precise float vertex_unnamed_535 = vertex_input_1.w * vertex_uniform_buffer_2[9u].w;
				precise float vertex_unnamed_536 = vertex_unnamed_535 * mad(vertex_unnamed_400, vertex_unnamed_518, vertex_unnamed_523);
				precise float vertex_unnamed_537 = vertex_unnamed_535 * mad(vertex_unnamed_398, vertex_unnamed_519, vertex_unnamed_524);
				precise float vertex_unnamed_538 = vertex_unnamed_535 * mad(vertex_unnamed_399, vertex_unnamed_517, vertex_unnamed_525);
				vertex_output_3.y = vertex_unnamed_536;
				vertex_output_3.x = vertex_unnamed_519;
				vertex_output_4.z = vertex_unnamed_400;
				vertex_output_5.z = vertex_unnamed_398;
				vertex_output_4.x = vertex_unnamed_517;
				vertex_output_5.x = vertex_unnamed_518;
				vertex_output_4.y = vertex_unnamed_537;
				vertex_output_5.y = vertex_unnamed_538;
				vertex_output_7.x = vertex_input_7.x;
				vertex_output_7.y = vertex_input_7.y;
				vertex_output_7.z = vertex_input_7.z;
				vertex_output_7.w = vertex_input_7.w;
				precise float vertex_unnamed_564 = vertex_unnamed_432 * vertex_uniform_buffer_0[18u].x;
				precise float vertex_unnamed_565 = vertex_unnamed_432 * vertex_uniform_buffer_0[18u].y;
				precise float vertex_unnamed_566 = vertex_unnamed_432 * vertex_uniform_buffer_0[18u].z;
				vertex_output_8.x = mad(vertex_uniform_buffer_0[19u].x, vertex_unnamed_433, mad(vertex_uniform_buffer_0[17u].x, vertex_unnamed_431, vertex_unnamed_564));
				vertex_output_8.y = mad(vertex_uniform_buffer_0[19u].y, vertex_unnamed_433, mad(vertex_uniform_buffer_0[17u].y, vertex_unnamed_431, vertex_unnamed_565));
				vertex_output_8.z = mad(vertex_uniform_buffer_0[19u].z, vertex_unnamed_433, mad(vertex_uniform_buffer_0[17u].z, vertex_unnamed_431, vertex_unnamed_566));
				precise float vertex_unnamed_592 = vertex_unnamed_420 * vertex_uniform_buffer_0[5u].x;
				precise float vertex_unnamed_593 = vertex_unnamed_420 * vertex_uniform_buffer_0[5u].y;
				precise float vertex_unnamed_594 = vertex_unnamed_420 * vertex_uniform_buffer_0[5u].z;
				precise float vertex_unnamed_595 = vertex_unnamed_420 * vertex_uniform_buffer_0[5u].w;
				vertex_output_9.x = mad(vertex_uniform_buffer_0[7u].x, vertex_unnamed_422, mad(vertex_uniform_buffer_0[6u].x, vertex_unnamed_421, mad(vertex_uniform_buffer_0[4u].x, vertex_unnamed_419, vertex_unnamed_592)));
				vertex_output_9.y = mad(vertex_uniform_buffer_0[7u].y, vertex_unnamed_422, mad(vertex_uniform_buffer_0[6u].y, vertex_unnamed_421, mad(vertex_uniform_buffer_0[4u].y, vertex_unnamed_419, vertex_unnamed_593)));
				vertex_output_9.z = mad(vertex_uniform_buffer_0[7u].z, vertex_unnamed_422, mad(vertex_uniform_buffer_0[6u].z, vertex_unnamed_421, mad(vertex_uniform_buffer_0[4u].z, vertex_unnamed_419, vertex_unnamed_594)));
				vertex_output_9.w = mad(vertex_uniform_buffer_0[7u].w, vertex_unnamed_422, mad(vertex_uniform_buffer_0[6u].w, vertex_unnamed_421, mad(vertex_uniform_buffer_0[4u].w, vertex_unnamed_419, vertex_unnamed_595)));
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[4] = float4(unity_WorldToLight[0][0], unity_WorldToLight[1][0], unity_WorldToLight[2][0], unity_WorldToLight[3][0]);
				vertex_uniform_buffer_0[5] = float4(unity_WorldToLight[0][1], unity_WorldToLight[1][1], unity_WorldToLight[2][1], unity_WorldToLight[3][1]);
				vertex_uniform_buffer_0[6] = float4(unity_WorldToLight[0][2], unity_WorldToLight[1][2], unity_WorldToLight[2][2], unity_WorldToLight[3][2]);
				vertex_uniform_buffer_0[7] = float4(unity_WorldToLight[0][3], unity_WorldToLight[1][3], unity_WorldToLight[2][3], unity_WorldToLight[3][3]);

				vertex_uniform_buffer_0[10] = float4(_FaceDilate, vertex_uniform_buffer_0[10][1], vertex_uniform_buffer_0[10][2], vertex_uniform_buffer_0[10][3]);

				vertex_uniform_buffer_0[17] = float4(_EnvMatrix[0][0], _EnvMatrix[1][0], _EnvMatrix[2][0], _EnvMatrix[3][0]);
				vertex_uniform_buffer_0[18] = float4(_EnvMatrix[0][1], _EnvMatrix[1][1], _EnvMatrix[2][1], _EnvMatrix[3][1]);
				vertex_uniform_buffer_0[19] = float4(_EnvMatrix[0][2], _EnvMatrix[1][2], _EnvMatrix[2][2], _EnvMatrix[3][2]);
				vertex_uniform_buffer_0[20] = float4(_EnvMatrix[0][3], _EnvMatrix[1][3], _EnvMatrix[2][3], _EnvMatrix[3][3]);

				vertex_uniform_buffer_0[28] = float4(vertex_uniform_buffer_0[28][0], _WeightNormal, vertex_uniform_buffer_0[28][2], vertex_uniform_buffer_0[28][3]);

				vertex_uniform_buffer_0[28] = float4(vertex_uniform_buffer_0[28][0], vertex_uniform_buffer_0[28][1], _WeightBold, vertex_uniform_buffer_0[28][3]);

				vertex_uniform_buffer_0[28] = float4(vertex_uniform_buffer_0[28][0], vertex_uniform_buffer_0[28][1], vertex_uniform_buffer_0[28][2], _ScaleRatioA);

				vertex_uniform_buffer_0[29] = float4(vertex_uniform_buffer_0[29][0], vertex_uniform_buffer_0[29][1], _VertexOffsetX, vertex_uniform_buffer_0[29][3]);

				vertex_uniform_buffer_0[29] = float4(vertex_uniform_buffer_0[29][0], vertex_uniform_buffer_0[29][1], vertex_uniform_buffer_0[29][2], _VertexOffsetY);

				vertex_uniform_buffer_0[34] = float4(_GradientScale, vertex_uniform_buffer_0[34][1], vertex_uniform_buffer_0[34][2], vertex_uniform_buffer_0[34][3]);

				vertex_uniform_buffer_0[34] = float4(vertex_uniform_buffer_0[34][0], _ScaleX, vertex_uniform_buffer_0[34][2], vertex_uniform_buffer_0[34][3]);

				vertex_uniform_buffer_0[34] = float4(vertex_uniform_buffer_0[34][0], vertex_uniform_buffer_0[34][1], _ScaleY, vertex_uniform_buffer_0[34][3]);

				vertex_uniform_buffer_0[34] = float4(vertex_uniform_buffer_0[34][0], vertex_uniform_buffer_0[34][1], vertex_uniform_buffer_0[34][2], _PerspectiveFilter);

				vertex_uniform_buffer_0[35] = float4(_Sharpness, vertex_uniform_buffer_0[35][1], vertex_uniform_buffer_0[35][2], vertex_uniform_buffer_0[35][3]);

				vertex_uniform_buffer_0[36] = float4(_MainTex_ST[0], _MainTex_ST[1], _MainTex_ST[2], _MainTex_ST[3]);

				vertex_uniform_buffer_0[37] = float4(_FaceTex_ST[0], _FaceTex_ST[1], _FaceTex_ST[2], _FaceTex_ST[3]);

				vertex_uniform_buffer_0[38] = float4(_OutlineTex_ST[0], _OutlineTex_ST[1], _OutlineTex_ST[2], _OutlineTex_ST[3]);

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

				vertex_uniform_buffer_2[9] = float4(unity_WorldTransformParams[0], unity_WorldTransformParams[1], unity_WorldTransformParams[2], unity_WorldTransformParams[3]);

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
				vertex_input_5 = stage_input.vertex_input_5;
				vertex_input_6 = stage_input.vertex_input_6;
				vertex_input_7 = stage_input.vertex_input_7;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
				stage_output.vertex_output_6 = vertex_output_6;
				stage_output.vertex_output_7 = vertex_output_7;
				stage_output.vertex_output_8 = vertex_output_8;
				stage_output.vertex_output_9 = vertex_output_9;
				return stage_output;
			}

			#endif // SPOT
			#endif // !DIRECTIONAL
			#endif // !DIRECTIONAL_COOKIE
			#endif // !POINT
			#endif // !POINT_COOKIE


			#ifdef POINT_COOKIE
			#ifndef DIRECTIONAL
			#ifndef DIRECTIONAL_COOKIE
			#ifndef POINT
			#ifndef SPOT
			#define ANY_SHADER_VARIANT_ACTIVE

			float4x4 unity_WorldToLight;
			float _FaceDilate;
			float4x4 _EnvMatrix;
			float _WeightNormal;
			float _WeightBold;
			float _ScaleRatioA;
			float _VertexOffsetX;
			float _VertexOffsetY;
			float _GradientScale;
			float _ScaleX;
			float _ScaleY;
			float _PerspectiveFilter;
			float _Sharpness;
			float4 _MainTex_ST;
			float4 _FaceTex_ST;
			float4 _OutlineTex_ST;
			float3 _WorldSpaceCameraPos;
			float4 _ScreenParams;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4 unity_WorldTransformParams;
			float4x4 glstate_matrix_projection;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[39];
			static float4 vertex_uniform_buffer_1[7];
			static float4 vertex_uniform_buffer_2[10];
			static float4 vertex_uniform_buffer_3[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float3 vertex_input_2;
			static float4 vertex_input_3;
			static float4 vertex_input_4;
			static float4 vertex_input_5;
			static float4 vertex_input_6;
			static float4 vertex_input_7;
			static float4 vertex_output_1;
			static float2 vertex_output_2;
			static float2 vertex_output_2;
			static float3 vertex_output_3;
			static float3 vertex_output_4;
			static float3 vertex_output_5;
			static float3 vertex_output_6;
			static float4 vertex_output_7;
			static float3 vertex_output_8;
			static float3 vertex_output_9;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION; // POSITION
				float4 vertex_input_1 : TANGENT; // TANGENT
				float3 vertex_input_2 : NORMAL; // NORMAL
				float4 vertex_input_3 : TEXCOORD; // TEXCOORD
				float4 vertex_input_4 : TEXCOORD1; // TEXCOORD_1
				float4 vertex_input_5 : TEXCOORD2; // TEXCOORD_2
				float4 vertex_input_6 : TEXCOORD3; // TEXCOORD_3
				float4 vertex_input_7 : COLOR; // COLOR
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : TEXCOORD; // TEXCOORD
				float2 vertex_output_2 : TEXCOORD1; // TEXCOORD_1
				float2 vertex_output_2 : TEXCOORD6; // TEXCOORD_6
				float3 vertex_output_3 : TEXCOORD2; // TEXCOORD_2
				float3 vertex_output_4 : TEXCOORD3; // TEXCOORD_3
				float3 vertex_output_5 : TEXCOORD4; // TEXCOORD_4
				float3 vertex_output_6 : TEXCOORD5; // TEXCOORD_5
				float4 vertex_output_7 : COLOR; // COLOR
				float3 vertex_output_8 : TEXCOORD7; // TEXCOORD_7
				float3 vertex_output_9 : TEXCOORD8; // TEXCOORD_8
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_67 = vertex_input_0.x + vertex_uniform_buffer_0[29u].z;
				precise float vertex_unnamed_68 = vertex_input_0.y + vertex_uniform_buffer_0[29u].w;
				precise float vertex_unnamed_75 = vertex_unnamed_68 * vertex_uniform_buffer_2[1u].x;
				precise float vertex_unnamed_76 = vertex_unnamed_68 * vertex_uniform_buffer_2[1u].y;
				precise float vertex_unnamed_77 = vertex_unnamed_68 * vertex_uniform_buffer_2[1u].z;
				precise float vertex_unnamed_78 = vertex_unnamed_68 * vertex_uniform_buffer_2[1u].w;
				float vertex_unnamed_99 = mad(vertex_uniform_buffer_2[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].x, vertex_unnamed_67, vertex_unnamed_75));
				float vertex_unnamed_100 = mad(vertex_uniform_buffer_2[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].y, vertex_unnamed_67, vertex_unnamed_76));
				float vertex_unnamed_101 = mad(vertex_uniform_buffer_2[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].z, vertex_unnamed_67, vertex_unnamed_77));
				float vertex_unnamed_102 = mad(vertex_uniform_buffer_2[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].w, vertex_unnamed_67, vertex_unnamed_78));
				precise float vertex_unnamed_110 = vertex_unnamed_99 + vertex_uniform_buffer_2[3u].x;
				precise float vertex_unnamed_111 = vertex_unnamed_100 + vertex_uniform_buffer_2[3u].y;
				precise float vertex_unnamed_112 = vertex_unnamed_101 + vertex_uniform_buffer_2[3u].z;
				precise float vertex_unnamed_113 = vertex_unnamed_102 + vertex_uniform_buffer_2[3u].w;
				precise float vertex_unnamed_121 = vertex_unnamed_111 * vertex_uniform_buffer_3[18u].x;
				precise float vertex_unnamed_122 = vertex_unnamed_111 * vertex_uniform_buffer_3[18u].y;
				precise float vertex_unnamed_123 = vertex_unnamed_111 * vertex_uniform_buffer_3[18u].z;
				precise float vertex_unnamed_124 = vertex_unnamed_111 * vertex_uniform_buffer_3[18u].w;
				gl_Position.x = mad(vertex_uniform_buffer_3[20u].x, vertex_unnamed_113, mad(vertex_uniform_buffer_3[19u].x, vertex_unnamed_112, mad(vertex_uniform_buffer_3[17u].x, vertex_unnamed_110, vertex_unnamed_121)));
				gl_Position.y = mad(vertex_uniform_buffer_3[20u].y, vertex_unnamed_113, mad(vertex_uniform_buffer_3[19u].y, vertex_unnamed_112, mad(vertex_uniform_buffer_3[17u].y, vertex_unnamed_110, vertex_unnamed_122)));
				gl_Position.z = mad(vertex_uniform_buffer_3[20u].z, vertex_unnamed_113, mad(vertex_uniform_buffer_3[19u].z, vertex_unnamed_112, mad(vertex_uniform_buffer_3[17u].z, vertex_unnamed_110, vertex_unnamed_123)));
				gl_Position.w = mad(vertex_uniform_buffer_3[20u].w, vertex_unnamed_113, mad(vertex_uniform_buffer_3[19u].w, vertex_unnamed_112, mad(vertex_uniform_buffer_3[17u].w, vertex_unnamed_110, vertex_unnamed_124)));
				precise float vertex_unnamed_165 = vertex_input_4.x * 0.000244140625f;
				float vertex_unnamed_167 = floor(vertex_unnamed_165);
				precise float vertex_unnamed_168 = (-0.0f) - vertex_unnamed_167;
				precise float vertex_unnamed_174 = vertex_unnamed_167 * 0.001953125f;
				precise float vertex_unnamed_176 = mad(vertex_unnamed_168, 4096.0f, vertex_input_4.x) * 0.001953125f;
				vertex_output_1.z = mad(vertex_unnamed_174, vertex_uniform_buffer_0[37u].x, vertex_uniform_buffer_0[37u].z);
				vertex_output_1.w = mad(vertex_unnamed_176, vertex_uniform_buffer_0[37u].y, vertex_uniform_buffer_0[37u].w);
				vertex_output_2.x = mad(vertex_unnamed_174, vertex_uniform_buffer_0[38u].x, vertex_uniform_buffer_0[38u].z);
				vertex_output_2.y = mad(vertex_unnamed_176, vertex_uniform_buffer_0[38u].y, vertex_uniform_buffer_0[38u].w);
				vertex_output_1.x = mad(vertex_input_3.x, vertex_uniform_buffer_0[36u].x, vertex_uniform_buffer_0[36u].z);
				vertex_output_1.y = mad(vertex_input_3.y, vertex_uniform_buffer_0[36u].y, vertex_uniform_buffer_0[36u].w);
				precise float vertex_unnamed_223 = vertex_unnamed_111 * vertex_uniform_buffer_3[18u].w;
				float vertex_unnamed_235 = mad(vertex_uniform_buffer_3[20u].w, vertex_unnamed_113, mad(vertex_uniform_buffer_3[19u].w, vertex_unnamed_112, mad(vertex_uniform_buffer_3[17u].w, vertex_unnamed_110, vertex_unnamed_223)));
				precise float vertex_unnamed_244 = vertex_uniform_buffer_1[6u].y * vertex_uniform_buffer_3[6u].x;
				precise float vertex_unnamed_245 = vertex_uniform_buffer_1[6u].y * vertex_uniform_buffer_3[6u].y;
				precise float vertex_unnamed_261 = mad(vertex_uniform_buffer_3[5u].x, vertex_uniform_buffer_1[6u].x, vertex_unnamed_244) * vertex_uniform_buffer_0[34u].y;
				precise float vertex_unnamed_262 = mad(vertex_uniform_buffer_3[5u].y, vertex_uniform_buffer_1[6u].x, vertex_unnamed_245) * vertex_uniform_buffer_0[34u].z;
				precise float vertex_unnamed_263 = vertex_unnamed_235 / vertex_unnamed_261;
				precise float vertex_unnamed_264 = vertex_unnamed_235 / vertex_unnamed_262;
				float vertex_unnamed_268 = rsqrt(dot(float2(vertex_unnamed_263, vertex_unnamed_264), float2(vertex_unnamed_263, vertex_unnamed_264)));
				precise float vertex_unnamed_275 = abs(vertex_input_4.y) * vertex_uniform_buffer_0[34u].x;
				precise float vertex_unnamed_280 = vertex_uniform_buffer_0[35u].x + 1.0f;
				precise float vertex_unnamed_282 = vertex_unnamed_280 * vertex_unnamed_275;
				precise float vertex_unnamed_283 = vertex_unnamed_268 * vertex_unnamed_282;
				precise float vertex_unnamed_287 = (-0.0f) - vertex_uniform_buffer_0[34u].w;
				precise float vertex_unnamed_288 = vertex_unnamed_287 + 1.0f;
				precise float vertex_unnamed_289 = vertex_unnamed_288 * vertex_unnamed_283;
				precise float vertex_unnamed_290 = (-0.0f) - vertex_unnamed_289;
				precise float vertex_unnamed_301 = vertex_uniform_buffer_1[4u].y * vertex_uniform_buffer_2[5u].x;
				precise float vertex_unnamed_302 = vertex_uniform_buffer_1[4u].y * vertex_uniform_buffer_2[5u].y;
				precise float vertex_unnamed_303 = vertex_uniform_buffer_1[4u].y * vertex_uniform_buffer_2[5u].z;
				precise float vertex_unnamed_331 = mad(vertex_uniform_buffer_2[6u].x, vertex_uniform_buffer_1[4u].z, mad(vertex_uniform_buffer_2[4u].x, vertex_uniform_buffer_1[4u].x, vertex_unnamed_301)) + vertex_uniform_buffer_2[7u].x;
				precise float vertex_unnamed_332 = mad(vertex_uniform_buffer_2[6u].y, vertex_uniform_buffer_1[4u].z, mad(vertex_uniform_buffer_2[4u].y, vertex_uniform_buffer_1[4u].x, vertex_unnamed_302)) + vertex_uniform_buffer_2[7u].y;
				precise float vertex_unnamed_333 = mad(vertex_uniform_buffer_2[6u].z, vertex_uniform_buffer_1[4u].z, mad(vertex_uniform_buffer_2[4u].z, vertex_uniform_buffer_1[4u].x, vertex_unnamed_303)) + vertex_uniform_buffer_2[7u].z;
				precise float vertex_unnamed_336 = (-0.0f) - vertex_unnamed_67;
				precise float vertex_unnamed_337 = (-0.0f) - vertex_unnamed_68;
				precise float vertex_unnamed_338 = (-0.0f) - vertex_input_0.z;
				precise float vertex_unnamed_339 = vertex_unnamed_336 + vertex_unnamed_331;
				precise float vertex_unnamed_340 = vertex_unnamed_337 + vertex_unnamed_332;
				precise float vertex_unnamed_341 = vertex_unnamed_338 + vertex_unnamed_333;
				float vertex_unnamed_348 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_unnamed_339, vertex_unnamed_340, vertex_unnamed_341));
				float vertex_unnamed_360 = float(int((-((0.0f < vertex_unnamed_348) ? 4294967295u : 0u)) + ((vertex_unnamed_348 < 0.0f) ? 4294967295u : 0u)));
				precise float vertex_unnamed_367 = vertex_unnamed_360 * vertex_input_2.x;
				precise float vertex_unnamed_368 = vertex_unnamed_360 * vertex_input_2.y;
				precise float vertex_unnamed_369 = vertex_unnamed_360 * vertex_input_2.z;
				float vertex_unnamed_375 = dot(float3(vertex_unnamed_367, vertex_unnamed_368, vertex_unnamed_369), float3(vertex_uniform_buffer_2[4u].xyz));
				float vertex_unnamed_383 = dot(float3(vertex_unnamed_367, vertex_unnamed_368, vertex_unnamed_369), float3(vertex_uniform_buffer_2[5u].xyz));
				float vertex_unnamed_391 = dot(float3(vertex_unnamed_367, vertex_unnamed_368, vertex_unnamed_369), float3(vertex_uniform_buffer_2[6u].xyz));
				float vertex_unnamed_397 = rsqrt(dot(float3(vertex_unnamed_391, vertex_unnamed_375, vertex_unnamed_383), float3(vertex_unnamed_391, vertex_unnamed_375, vertex_unnamed_383)));
				precise float vertex_unnamed_398 = vertex_unnamed_397 * vertex_unnamed_391;
				precise float vertex_unnamed_399 = vertex_unnamed_397 * vertex_unnamed_375;
				precise float vertex_unnamed_400 = vertex_unnamed_397 * vertex_unnamed_383;
				float vertex_unnamed_408 = mad(vertex_uniform_buffer_2[3u].x, vertex_input_0.w, vertex_unnamed_99);
				float vertex_unnamed_409 = mad(vertex_uniform_buffer_2[3u].y, vertex_input_0.w, vertex_unnamed_100);
				float vertex_unnamed_410 = mad(vertex_uniform_buffer_2[3u].z, vertex_input_0.w, vertex_unnamed_101);
				float vertex_unnamed_419 = mad(vertex_uniform_buffer_2[3u].x, vertex_input_0.w, vertex_unnamed_99);
				float vertex_unnamed_420 = mad(vertex_uniform_buffer_2[3u].y, vertex_input_0.w, vertex_unnamed_100);
				float vertex_unnamed_421 = mad(vertex_uniform_buffer_2[3u].z, vertex_input_0.w, vertex_unnamed_101);
				float vertex_unnamed_422 = mad(vertex_uniform_buffer_2[3u].w, vertex_input_0.w, vertex_unnamed_102);
				precise float vertex_unnamed_423 = (-0.0f) - vertex_unnamed_408;
				precise float vertex_unnamed_424 = (-0.0f) - vertex_unnamed_409;
				precise float vertex_unnamed_425 = (-0.0f) - vertex_unnamed_410;
				precise float vertex_unnamed_431 = vertex_unnamed_423 + vertex_uniform_buffer_1[4u].x;
				precise float vertex_unnamed_432 = vertex_unnamed_424 + vertex_uniform_buffer_1[4u].y;
				precise float vertex_unnamed_433 = vertex_unnamed_425 + vertex_uniform_buffer_1[4u].z;
				vertex_output_6.x = vertex_unnamed_408;
				vertex_output_6.y = vertex_unnamed_409;
				vertex_output_6.z = vertex_unnamed_410;
				float vertex_unnamed_440 = rsqrt(dot(float3(vertex_unnamed_431, vertex_unnamed_432, vertex_unnamed_433), float3(vertex_unnamed_431, vertex_unnamed_432, vertex_unnamed_433)));
				precise float vertex_unnamed_441 = vertex_unnamed_440 * vertex_unnamed_431;
				precise float vertex_unnamed_442 = vertex_unnamed_440 * vertex_unnamed_432;
				precise float vertex_unnamed_443 = vertex_unnamed_440 * vertex_unnamed_433;
				vertex_output_2.y = mad(abs(dot(float3(vertex_unnamed_399, vertex_unnamed_400, vertex_unnamed_398), float3(vertex_unnamed_441, vertex_unnamed_442, vertex_unnamed_443))), mad(vertex_unnamed_268, vertex_unnamed_282, vertex_unnamed_290), vertex_unnamed_289);
				precise float vertex_unnamed_461 = (-0.0f) - vertex_uniform_buffer_0[28u].y;
				precise float vertex_unnamed_465 = vertex_unnamed_461 + vertex_uniform_buffer_0[28u].z;
				precise float vertex_unnamed_478 = mad(mad(asfloat(((0.0f >= vertex_input_4.y) ? 4294967295u : 0u) & 1065353216u), vertex_unnamed_465, vertex_uniform_buffer_0[28u].y), 0.25f, vertex_uniform_buffer_0[10u].x) * vertex_uniform_buffer_0[28u].w;
				precise float vertex_unnamed_479 = vertex_unnamed_478 * 0.5f;
				vertex_output_2.x = vertex_unnamed_479;
				vertex_output_3.z = vertex_unnamed_399;
				precise float vertex_unnamed_490 = vertex_input_1.y * vertex_uniform_buffer_2[1u].y;
				precise float vertex_unnamed_491 = vertex_input_1.y * vertex_uniform_buffer_2[1u].z;
				precise float vertex_unnamed_492 = vertex_input_1.y * vertex_uniform_buffer_2[1u].x;
				float vertex_unnamed_510 = mad(vertex_uniform_buffer_2[2u].y, vertex_input_1.z, mad(vertex_uniform_buffer_2[0u].y, vertex_input_1.x, vertex_unnamed_490));
				float vertex_unnamed_511 = mad(vertex_uniform_buffer_2[2u].z, vertex_input_1.z, mad(vertex_uniform_buffer_2[0u].z, vertex_input_1.x, vertex_unnamed_491));
				float vertex_unnamed_512 = mad(vertex_uniform_buffer_2[2u].x, vertex_input_1.z, mad(vertex_uniform_buffer_2[0u].x, vertex_input_1.x, vertex_unnamed_492));
				float vertex_unnamed_516 = rsqrt(dot(float3(vertex_unnamed_510, vertex_unnamed_511, vertex_unnamed_512), float3(vertex_unnamed_510, vertex_unnamed_511, vertex_unnamed_512)));
				precise float vertex_unnamed_517 = vertex_unnamed_516 * vertex_unnamed_510;
				precise float vertex_unnamed_518 = vertex_unnamed_516 * vertex_unnamed_511;
				precise float vertex_unnamed_519 = vertex_unnamed_516 * vertex_unnamed_512;
				precise float vertex_unnamed_520 = vertex_unnamed_398 * vertex_unnamed_517;
				precise float vertex_unnamed_521 = vertex_unnamed_399 * vertex_unnamed_518;
				precise float vertex_unnamed_522 = vertex_unnamed_400 * vertex_unnamed_519;
				precise float vertex_unnamed_523 = (-0.0f) - vertex_unnamed_520;
				precise float vertex_unnamed_524 = (-0.0f) - vertex_unnamed_521;
				precise float vertex_unnamed_525 = (-0.0f) - vertex_unnamed_522;
				precise float vertex_unnamed_535 = vertex_input_1.w * vertex_uniform_buffer_2[9u].w;
				precise float vertex_unnamed_536 = vertex_unnamed_535 * mad(vertex_unnamed_400, vertex_unnamed_518, vertex_unnamed_523);
				precise float vertex_unnamed_537 = vertex_unnamed_535 * mad(vertex_unnamed_398, vertex_unnamed_519, vertex_unnamed_524);
				precise float vertex_unnamed_538 = vertex_unnamed_535 * mad(vertex_unnamed_399, vertex_unnamed_517, vertex_unnamed_525);
				vertex_output_3.y = vertex_unnamed_536;
				vertex_output_3.x = vertex_unnamed_519;
				vertex_output_4.z = vertex_unnamed_400;
				vertex_output_5.z = vertex_unnamed_398;
				vertex_output_4.x = vertex_unnamed_517;
				vertex_output_5.x = vertex_unnamed_518;
				vertex_output_4.y = vertex_unnamed_537;
				vertex_output_5.y = vertex_unnamed_538;
				vertex_output_7.x = vertex_input_7.x;
				vertex_output_7.y = vertex_input_7.y;
				vertex_output_7.z = vertex_input_7.z;
				vertex_output_7.w = vertex_input_7.w;
				precise float vertex_unnamed_564 = vertex_unnamed_432 * vertex_uniform_buffer_0[18u].x;
				precise float vertex_unnamed_565 = vertex_unnamed_432 * vertex_uniform_buffer_0[18u].y;
				precise float vertex_unnamed_566 = vertex_unnamed_432 * vertex_uniform_buffer_0[18u].z;
				vertex_output_8.x = mad(vertex_uniform_buffer_0[19u].x, vertex_unnamed_433, mad(vertex_uniform_buffer_0[17u].x, vertex_unnamed_431, vertex_unnamed_564));
				vertex_output_8.y = mad(vertex_uniform_buffer_0[19u].y, vertex_unnamed_433, mad(vertex_uniform_buffer_0[17u].y, vertex_unnamed_431, vertex_unnamed_565));
				vertex_output_8.z = mad(vertex_uniform_buffer_0[19u].z, vertex_unnamed_433, mad(vertex_uniform_buffer_0[17u].z, vertex_unnamed_431, vertex_unnamed_566));
				precise float vertex_unnamed_591 = vertex_unnamed_420 * vertex_uniform_buffer_0[5u].x;
				precise float vertex_unnamed_592 = vertex_unnamed_420 * vertex_uniform_buffer_0[5u].y;
				precise float vertex_unnamed_593 = vertex_unnamed_420 * vertex_uniform_buffer_0[5u].z;
				vertex_output_9.x = mad(vertex_uniform_buffer_0[7u].x, vertex_unnamed_422, mad(vertex_uniform_buffer_0[6u].x, vertex_unnamed_421, mad(vertex_uniform_buffer_0[4u].x, vertex_unnamed_419, vertex_unnamed_591)));
				vertex_output_9.y = mad(vertex_uniform_buffer_0[7u].y, vertex_unnamed_422, mad(vertex_uniform_buffer_0[6u].y, vertex_unnamed_421, mad(vertex_uniform_buffer_0[4u].y, vertex_unnamed_419, vertex_unnamed_592)));
				vertex_output_9.z = mad(vertex_uniform_buffer_0[7u].z, vertex_unnamed_422, mad(vertex_uniform_buffer_0[6u].z, vertex_unnamed_421, mad(vertex_uniform_buffer_0[4u].z, vertex_unnamed_419, vertex_unnamed_593)));
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[4] = float4(unity_WorldToLight[0][0], unity_WorldToLight[1][0], unity_WorldToLight[2][0], unity_WorldToLight[3][0]);
				vertex_uniform_buffer_0[5] = float4(unity_WorldToLight[0][1], unity_WorldToLight[1][1], unity_WorldToLight[2][1], unity_WorldToLight[3][1]);
				vertex_uniform_buffer_0[6] = float4(unity_WorldToLight[0][2], unity_WorldToLight[1][2], unity_WorldToLight[2][2], unity_WorldToLight[3][2]);
				vertex_uniform_buffer_0[7] = float4(unity_WorldToLight[0][3], unity_WorldToLight[1][3], unity_WorldToLight[2][3], unity_WorldToLight[3][3]);

				vertex_uniform_buffer_0[10] = float4(_FaceDilate, vertex_uniform_buffer_0[10][1], vertex_uniform_buffer_0[10][2], vertex_uniform_buffer_0[10][3]);

				vertex_uniform_buffer_0[17] = float4(_EnvMatrix[0][0], _EnvMatrix[1][0], _EnvMatrix[2][0], _EnvMatrix[3][0]);
				vertex_uniform_buffer_0[18] = float4(_EnvMatrix[0][1], _EnvMatrix[1][1], _EnvMatrix[2][1], _EnvMatrix[3][1]);
				vertex_uniform_buffer_0[19] = float4(_EnvMatrix[0][2], _EnvMatrix[1][2], _EnvMatrix[2][2], _EnvMatrix[3][2]);
				vertex_uniform_buffer_0[20] = float4(_EnvMatrix[0][3], _EnvMatrix[1][3], _EnvMatrix[2][3], _EnvMatrix[3][3]);

				vertex_uniform_buffer_0[28] = float4(vertex_uniform_buffer_0[28][0], _WeightNormal, vertex_uniform_buffer_0[28][2], vertex_uniform_buffer_0[28][3]);

				vertex_uniform_buffer_0[28] = float4(vertex_uniform_buffer_0[28][0], vertex_uniform_buffer_0[28][1], _WeightBold, vertex_uniform_buffer_0[28][3]);

				vertex_uniform_buffer_0[28] = float4(vertex_uniform_buffer_0[28][0], vertex_uniform_buffer_0[28][1], vertex_uniform_buffer_0[28][2], _ScaleRatioA);

				vertex_uniform_buffer_0[29] = float4(vertex_uniform_buffer_0[29][0], vertex_uniform_buffer_0[29][1], _VertexOffsetX, vertex_uniform_buffer_0[29][3]);

				vertex_uniform_buffer_0[29] = float4(vertex_uniform_buffer_0[29][0], vertex_uniform_buffer_0[29][1], vertex_uniform_buffer_0[29][2], _VertexOffsetY);

				vertex_uniform_buffer_0[34] = float4(_GradientScale, vertex_uniform_buffer_0[34][1], vertex_uniform_buffer_0[34][2], vertex_uniform_buffer_0[34][3]);

				vertex_uniform_buffer_0[34] = float4(vertex_uniform_buffer_0[34][0], _ScaleX, vertex_uniform_buffer_0[34][2], vertex_uniform_buffer_0[34][3]);

				vertex_uniform_buffer_0[34] = float4(vertex_uniform_buffer_0[34][0], vertex_uniform_buffer_0[34][1], _ScaleY, vertex_uniform_buffer_0[34][3]);

				vertex_uniform_buffer_0[34] = float4(vertex_uniform_buffer_0[34][0], vertex_uniform_buffer_0[34][1], vertex_uniform_buffer_0[34][2], _PerspectiveFilter);

				vertex_uniform_buffer_0[35] = float4(_Sharpness, vertex_uniform_buffer_0[35][1], vertex_uniform_buffer_0[35][2], vertex_uniform_buffer_0[35][3]);

				vertex_uniform_buffer_0[36] = float4(_MainTex_ST[0], _MainTex_ST[1], _MainTex_ST[2], _MainTex_ST[3]);

				vertex_uniform_buffer_0[37] = float4(_FaceTex_ST[0], _FaceTex_ST[1], _FaceTex_ST[2], _FaceTex_ST[3]);

				vertex_uniform_buffer_0[38] = float4(_OutlineTex_ST[0], _OutlineTex_ST[1], _OutlineTex_ST[2], _OutlineTex_ST[3]);

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

				vertex_uniform_buffer_2[9] = float4(unity_WorldTransformParams[0], unity_WorldTransformParams[1], unity_WorldTransformParams[2], unity_WorldTransformParams[3]);

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
				vertex_input_5 = stage_input.vertex_input_5;
				vertex_input_6 = stage_input.vertex_input_6;
				vertex_input_7 = stage_input.vertex_input_7;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
				stage_output.vertex_output_6 = vertex_output_6;
				stage_output.vertex_output_7 = vertex_output_7;
				stage_output.vertex_output_8 = vertex_output_8;
				stage_output.vertex_output_9 = vertex_output_9;
				return stage_output;
			}

			#endif // POINT_COOKIE
			#endif // !DIRECTIONAL
			#endif // !DIRECTIONAL_COOKIE
			#endif // !POINT
			#endif // !SPOT


			#ifdef DIRECTIONAL_COOKIE
			#ifndef DIRECTIONAL
			#ifndef POINT
			#ifndef POINT_COOKIE
			#ifndef SPOT
			#define ANY_SHADER_VARIANT_ACTIVE

			float4x4 unity_WorldToLight;
			float _FaceDilate;
			float4x4 _EnvMatrix;
			float _WeightNormal;
			float _WeightBold;
			float _ScaleRatioA;
			float _VertexOffsetX;
			float _VertexOffsetY;
			float _GradientScale;
			float _ScaleX;
			float _ScaleY;
			float _PerspectiveFilter;
			float _Sharpness;
			float4 _MainTex_ST;
			float4 _FaceTex_ST;
			float4 _OutlineTex_ST;
			float3 _WorldSpaceCameraPos;
			float4 _ScreenParams;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4 unity_WorldTransformParams;
			float4x4 glstate_matrix_projection;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[39];
			static float4 vertex_uniform_buffer_1[7];
			static float4 vertex_uniform_buffer_2[10];
			static float4 vertex_uniform_buffer_3[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float3 vertex_input_2;
			static float4 vertex_input_3;
			static float4 vertex_input_4;
			static float4 vertex_input_5;
			static float4 vertex_input_6;
			static float4 vertex_input_7;
			static float4 vertex_output_1;
			static float2 vertex_output_2;
			static float2 vertex_output_2;
			static float3 vertex_output_3;
			static float3 vertex_output_4;
			static float3 vertex_output_5;
			static float3 vertex_output_6;
			static float4 vertex_output_7;
			static float3 vertex_output_8;
			static float2 vertex_output_9;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION; // POSITION
				float4 vertex_input_1 : TANGENT; // TANGENT
				float3 vertex_input_2 : NORMAL; // NORMAL
				float4 vertex_input_3 : TEXCOORD; // TEXCOORD
				float4 vertex_input_4 : TEXCOORD1; // TEXCOORD_1
				float4 vertex_input_5 : TEXCOORD2; // TEXCOORD_2
				float4 vertex_input_6 : TEXCOORD3; // TEXCOORD_3
				float4 vertex_input_7 : COLOR; // COLOR
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : TEXCOORD; // TEXCOORD
				float2 vertex_output_2 : TEXCOORD1; // TEXCOORD_1
				float2 vertex_output_2 : TEXCOORD6; // TEXCOORD_6
				float3 vertex_output_3 : TEXCOORD2; // TEXCOORD_2
				float3 vertex_output_4 : TEXCOORD3; // TEXCOORD_3
				float3 vertex_output_5 : TEXCOORD4; // TEXCOORD_4
				float3 vertex_output_6 : TEXCOORD5; // TEXCOORD_5
				float4 vertex_output_7 : COLOR; // COLOR
				float3 vertex_output_8 : TEXCOORD7; // TEXCOORD_7
				float2 vertex_output_9 : TEXCOORD8; // TEXCOORD_8
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_67 = vertex_input_0.x + vertex_uniform_buffer_0[29u].z;
				precise float vertex_unnamed_68 = vertex_input_0.y + vertex_uniform_buffer_0[29u].w;
				precise float vertex_unnamed_75 = vertex_unnamed_68 * vertex_uniform_buffer_2[1u].x;
				precise float vertex_unnamed_76 = vertex_unnamed_68 * vertex_uniform_buffer_2[1u].y;
				precise float vertex_unnamed_77 = vertex_unnamed_68 * vertex_uniform_buffer_2[1u].z;
				precise float vertex_unnamed_78 = vertex_unnamed_68 * vertex_uniform_buffer_2[1u].w;
				float vertex_unnamed_99 = mad(vertex_uniform_buffer_2[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].x, vertex_unnamed_67, vertex_unnamed_75));
				float vertex_unnamed_100 = mad(vertex_uniform_buffer_2[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].y, vertex_unnamed_67, vertex_unnamed_76));
				float vertex_unnamed_101 = mad(vertex_uniform_buffer_2[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].z, vertex_unnamed_67, vertex_unnamed_77));
				float vertex_unnamed_102 = mad(vertex_uniform_buffer_2[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].w, vertex_unnamed_67, vertex_unnamed_78));
				precise float vertex_unnamed_110 = vertex_unnamed_99 + vertex_uniform_buffer_2[3u].x;
				precise float vertex_unnamed_111 = vertex_unnamed_100 + vertex_uniform_buffer_2[3u].y;
				precise float vertex_unnamed_112 = vertex_unnamed_101 + vertex_uniform_buffer_2[3u].z;
				precise float vertex_unnamed_113 = vertex_unnamed_102 + vertex_uniform_buffer_2[3u].w;
				precise float vertex_unnamed_121 = vertex_unnamed_111 * vertex_uniform_buffer_3[18u].x;
				precise float vertex_unnamed_122 = vertex_unnamed_111 * vertex_uniform_buffer_3[18u].y;
				precise float vertex_unnamed_123 = vertex_unnamed_111 * vertex_uniform_buffer_3[18u].z;
				precise float vertex_unnamed_124 = vertex_unnamed_111 * vertex_uniform_buffer_3[18u].w;
				gl_Position.x = mad(vertex_uniform_buffer_3[20u].x, vertex_unnamed_113, mad(vertex_uniform_buffer_3[19u].x, vertex_unnamed_112, mad(vertex_uniform_buffer_3[17u].x, vertex_unnamed_110, vertex_unnamed_121)));
				gl_Position.y = mad(vertex_uniform_buffer_3[20u].y, vertex_unnamed_113, mad(vertex_uniform_buffer_3[19u].y, vertex_unnamed_112, mad(vertex_uniform_buffer_3[17u].y, vertex_unnamed_110, vertex_unnamed_122)));
				gl_Position.z = mad(vertex_uniform_buffer_3[20u].z, vertex_unnamed_113, mad(vertex_uniform_buffer_3[19u].z, vertex_unnamed_112, mad(vertex_uniform_buffer_3[17u].z, vertex_unnamed_110, vertex_unnamed_123)));
				gl_Position.w = mad(vertex_uniform_buffer_3[20u].w, vertex_unnamed_113, mad(vertex_uniform_buffer_3[19u].w, vertex_unnamed_112, mad(vertex_uniform_buffer_3[17u].w, vertex_unnamed_110, vertex_unnamed_124)));
				precise float vertex_unnamed_165 = vertex_input_4.x * 0.000244140625f;
				float vertex_unnamed_167 = floor(vertex_unnamed_165);
				precise float vertex_unnamed_168 = (-0.0f) - vertex_unnamed_167;
				precise float vertex_unnamed_174 = vertex_unnamed_167 * 0.001953125f;
				precise float vertex_unnamed_176 = mad(vertex_unnamed_168, 4096.0f, vertex_input_4.x) * 0.001953125f;
				vertex_output_1.z = mad(vertex_unnamed_174, vertex_uniform_buffer_0[37u].x, vertex_uniform_buffer_0[37u].z);
				vertex_output_1.w = mad(vertex_unnamed_176, vertex_uniform_buffer_0[37u].y, vertex_uniform_buffer_0[37u].w);
				vertex_output_2.x = mad(vertex_unnamed_174, vertex_uniform_buffer_0[38u].x, vertex_uniform_buffer_0[38u].z);
				vertex_output_2.y = mad(vertex_unnamed_176, vertex_uniform_buffer_0[38u].y, vertex_uniform_buffer_0[38u].w);
				vertex_output_1.x = mad(vertex_input_3.x, vertex_uniform_buffer_0[36u].x, vertex_uniform_buffer_0[36u].z);
				vertex_output_1.y = mad(vertex_input_3.y, vertex_uniform_buffer_0[36u].y, vertex_uniform_buffer_0[36u].w);
				precise float vertex_unnamed_223 = vertex_unnamed_111 * vertex_uniform_buffer_3[18u].w;
				float vertex_unnamed_235 = mad(vertex_uniform_buffer_3[20u].w, vertex_unnamed_113, mad(vertex_uniform_buffer_3[19u].w, vertex_unnamed_112, mad(vertex_uniform_buffer_3[17u].w, vertex_unnamed_110, vertex_unnamed_223)));
				precise float vertex_unnamed_244 = vertex_uniform_buffer_1[6u].y * vertex_uniform_buffer_3[6u].x;
				precise float vertex_unnamed_245 = vertex_uniform_buffer_1[6u].y * vertex_uniform_buffer_3[6u].y;
				precise float vertex_unnamed_261 = mad(vertex_uniform_buffer_3[5u].x, vertex_uniform_buffer_1[6u].x, vertex_unnamed_244) * vertex_uniform_buffer_0[34u].y;
				precise float vertex_unnamed_262 = mad(vertex_uniform_buffer_3[5u].y, vertex_uniform_buffer_1[6u].x, vertex_unnamed_245) * vertex_uniform_buffer_0[34u].z;
				precise float vertex_unnamed_263 = vertex_unnamed_235 / vertex_unnamed_261;
				precise float vertex_unnamed_264 = vertex_unnamed_235 / vertex_unnamed_262;
				float vertex_unnamed_268 = rsqrt(dot(float2(vertex_unnamed_263, vertex_unnamed_264), float2(vertex_unnamed_263, vertex_unnamed_264)));
				precise float vertex_unnamed_275 = abs(vertex_input_4.y) * vertex_uniform_buffer_0[34u].x;
				precise float vertex_unnamed_280 = vertex_uniform_buffer_0[35u].x + 1.0f;
				precise float vertex_unnamed_282 = vertex_unnamed_280 * vertex_unnamed_275;
				precise float vertex_unnamed_283 = vertex_unnamed_268 * vertex_unnamed_282;
				precise float vertex_unnamed_287 = (-0.0f) - vertex_uniform_buffer_0[34u].w;
				precise float vertex_unnamed_288 = vertex_unnamed_287 + 1.0f;
				precise float vertex_unnamed_289 = vertex_unnamed_288 * vertex_unnamed_283;
				precise float vertex_unnamed_290 = (-0.0f) - vertex_unnamed_289;
				precise float vertex_unnamed_301 = vertex_uniform_buffer_1[4u].y * vertex_uniform_buffer_2[5u].x;
				precise float vertex_unnamed_302 = vertex_uniform_buffer_1[4u].y * vertex_uniform_buffer_2[5u].y;
				precise float vertex_unnamed_303 = vertex_uniform_buffer_1[4u].y * vertex_uniform_buffer_2[5u].z;
				precise float vertex_unnamed_331 = mad(vertex_uniform_buffer_2[6u].x, vertex_uniform_buffer_1[4u].z, mad(vertex_uniform_buffer_2[4u].x, vertex_uniform_buffer_1[4u].x, vertex_unnamed_301)) + vertex_uniform_buffer_2[7u].x;
				precise float vertex_unnamed_332 = mad(vertex_uniform_buffer_2[6u].y, vertex_uniform_buffer_1[4u].z, mad(vertex_uniform_buffer_2[4u].y, vertex_uniform_buffer_1[4u].x, vertex_unnamed_302)) + vertex_uniform_buffer_2[7u].y;
				precise float vertex_unnamed_333 = mad(vertex_uniform_buffer_2[6u].z, vertex_uniform_buffer_1[4u].z, mad(vertex_uniform_buffer_2[4u].z, vertex_uniform_buffer_1[4u].x, vertex_unnamed_303)) + vertex_uniform_buffer_2[7u].z;
				precise float vertex_unnamed_336 = (-0.0f) - vertex_unnamed_67;
				precise float vertex_unnamed_337 = (-0.0f) - vertex_unnamed_68;
				precise float vertex_unnamed_338 = (-0.0f) - vertex_input_0.z;
				precise float vertex_unnamed_339 = vertex_unnamed_336 + vertex_unnamed_331;
				precise float vertex_unnamed_340 = vertex_unnamed_337 + vertex_unnamed_332;
				precise float vertex_unnamed_341 = vertex_unnamed_338 + vertex_unnamed_333;
				float vertex_unnamed_348 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_unnamed_339, vertex_unnamed_340, vertex_unnamed_341));
				float vertex_unnamed_360 = float(int((-((0.0f < vertex_unnamed_348) ? 4294967295u : 0u)) + ((vertex_unnamed_348 < 0.0f) ? 4294967295u : 0u)));
				precise float vertex_unnamed_367 = vertex_unnamed_360 * vertex_input_2.x;
				precise float vertex_unnamed_368 = vertex_unnamed_360 * vertex_input_2.y;
				precise float vertex_unnamed_369 = vertex_unnamed_360 * vertex_input_2.z;
				float vertex_unnamed_375 = dot(float3(vertex_unnamed_367, vertex_unnamed_368, vertex_unnamed_369), float3(vertex_uniform_buffer_2[4u].xyz));
				float vertex_unnamed_383 = dot(float3(vertex_unnamed_367, vertex_unnamed_368, vertex_unnamed_369), float3(vertex_uniform_buffer_2[5u].xyz));
				float vertex_unnamed_391 = dot(float3(vertex_unnamed_367, vertex_unnamed_368, vertex_unnamed_369), float3(vertex_uniform_buffer_2[6u].xyz));
				float vertex_unnamed_397 = rsqrt(dot(float3(vertex_unnamed_391, vertex_unnamed_375, vertex_unnamed_383), float3(vertex_unnamed_391, vertex_unnamed_375, vertex_unnamed_383)));
				precise float vertex_unnamed_398 = vertex_unnamed_397 * vertex_unnamed_391;
				precise float vertex_unnamed_399 = vertex_unnamed_397 * vertex_unnamed_375;
				precise float vertex_unnamed_400 = vertex_unnamed_397 * vertex_unnamed_383;
				float vertex_unnamed_408 = mad(vertex_uniform_buffer_2[3u].x, vertex_input_0.w, vertex_unnamed_99);
				float vertex_unnamed_409 = mad(vertex_uniform_buffer_2[3u].y, vertex_input_0.w, vertex_unnamed_100);
				float vertex_unnamed_410 = mad(vertex_uniform_buffer_2[3u].z, vertex_input_0.w, vertex_unnamed_101);
				float vertex_unnamed_419 = mad(vertex_uniform_buffer_2[3u].x, vertex_input_0.w, vertex_unnamed_99);
				float vertex_unnamed_420 = mad(vertex_uniform_buffer_2[3u].y, vertex_input_0.w, vertex_unnamed_100);
				float vertex_unnamed_421 = mad(vertex_uniform_buffer_2[3u].z, vertex_input_0.w, vertex_unnamed_101);
				float vertex_unnamed_422 = mad(vertex_uniform_buffer_2[3u].w, vertex_input_0.w, vertex_unnamed_102);
				precise float vertex_unnamed_423 = (-0.0f) - vertex_unnamed_408;
				precise float vertex_unnamed_424 = (-0.0f) - vertex_unnamed_409;
				precise float vertex_unnamed_425 = (-0.0f) - vertex_unnamed_410;
				precise float vertex_unnamed_431 = vertex_unnamed_423 + vertex_uniform_buffer_1[4u].x;
				precise float vertex_unnamed_432 = vertex_unnamed_424 + vertex_uniform_buffer_1[4u].y;
				precise float vertex_unnamed_433 = vertex_unnamed_425 + vertex_uniform_buffer_1[4u].z;
				vertex_output_6.x = vertex_unnamed_408;
				vertex_output_6.y = vertex_unnamed_409;
				vertex_output_6.z = vertex_unnamed_410;
				float vertex_unnamed_440 = rsqrt(dot(float3(vertex_unnamed_431, vertex_unnamed_432, vertex_unnamed_433), float3(vertex_unnamed_431, vertex_unnamed_432, vertex_unnamed_433)));
				precise float vertex_unnamed_441 = vertex_unnamed_440 * vertex_unnamed_431;
				precise float vertex_unnamed_442 = vertex_unnamed_440 * vertex_unnamed_432;
				precise float vertex_unnamed_443 = vertex_unnamed_440 * vertex_unnamed_433;
				vertex_output_2.y = mad(abs(dot(float3(vertex_unnamed_399, vertex_unnamed_400, vertex_unnamed_398), float3(vertex_unnamed_441, vertex_unnamed_442, vertex_unnamed_443))), mad(vertex_unnamed_268, vertex_unnamed_282, vertex_unnamed_290), vertex_unnamed_289);
				precise float vertex_unnamed_461 = (-0.0f) - vertex_uniform_buffer_0[28u].y;
				precise float vertex_unnamed_465 = vertex_unnamed_461 + vertex_uniform_buffer_0[28u].z;
				precise float vertex_unnamed_478 = mad(mad(asfloat(((0.0f >= vertex_input_4.y) ? 4294967295u : 0u) & 1065353216u), vertex_unnamed_465, vertex_uniform_buffer_0[28u].y), 0.25f, vertex_uniform_buffer_0[10u].x) * vertex_uniform_buffer_0[28u].w;
				precise float vertex_unnamed_479 = vertex_unnamed_478 * 0.5f;
				vertex_output_2.x = vertex_unnamed_479;
				vertex_output_3.z = vertex_unnamed_399;
				precise float vertex_unnamed_490 = vertex_input_1.y * vertex_uniform_buffer_2[1u].y;
				precise float vertex_unnamed_491 = vertex_input_1.y * vertex_uniform_buffer_2[1u].z;
				precise float vertex_unnamed_492 = vertex_input_1.y * vertex_uniform_buffer_2[1u].x;
				float vertex_unnamed_510 = mad(vertex_uniform_buffer_2[2u].y, vertex_input_1.z, mad(vertex_uniform_buffer_2[0u].y, vertex_input_1.x, vertex_unnamed_490));
				float vertex_unnamed_511 = mad(vertex_uniform_buffer_2[2u].z, vertex_input_1.z, mad(vertex_uniform_buffer_2[0u].z, vertex_input_1.x, vertex_unnamed_491));
				float vertex_unnamed_512 = mad(vertex_uniform_buffer_2[2u].x, vertex_input_1.z, mad(vertex_uniform_buffer_2[0u].x, vertex_input_1.x, vertex_unnamed_492));
				float vertex_unnamed_516 = rsqrt(dot(float3(vertex_unnamed_510, vertex_unnamed_511, vertex_unnamed_512), float3(vertex_unnamed_510, vertex_unnamed_511, vertex_unnamed_512)));
				precise float vertex_unnamed_517 = vertex_unnamed_516 * vertex_unnamed_510;
				precise float vertex_unnamed_518 = vertex_unnamed_516 * vertex_unnamed_511;
				precise float vertex_unnamed_519 = vertex_unnamed_516 * vertex_unnamed_512;
				precise float vertex_unnamed_520 = vertex_unnamed_398 * vertex_unnamed_517;
				precise float vertex_unnamed_521 = vertex_unnamed_399 * vertex_unnamed_518;
				precise float vertex_unnamed_522 = vertex_unnamed_400 * vertex_unnamed_519;
				precise float vertex_unnamed_523 = (-0.0f) - vertex_unnamed_520;
				precise float vertex_unnamed_524 = (-0.0f) - vertex_unnamed_521;
				precise float vertex_unnamed_525 = (-0.0f) - vertex_unnamed_522;
				precise float vertex_unnamed_535 = vertex_input_1.w * vertex_uniform_buffer_2[9u].w;
				precise float vertex_unnamed_536 = vertex_unnamed_535 * mad(vertex_unnamed_400, vertex_unnamed_518, vertex_unnamed_523);
				precise float vertex_unnamed_537 = vertex_unnamed_535 * mad(vertex_unnamed_398, vertex_unnamed_519, vertex_unnamed_524);
				precise float vertex_unnamed_538 = vertex_unnamed_535 * mad(vertex_unnamed_399, vertex_unnamed_517, vertex_unnamed_525);
				vertex_output_3.y = vertex_unnamed_536;
				vertex_output_3.x = vertex_unnamed_519;
				vertex_output_4.z = vertex_unnamed_400;
				vertex_output_5.z = vertex_unnamed_398;
				vertex_output_4.x = vertex_unnamed_517;
				vertex_output_5.x = vertex_unnamed_518;
				vertex_output_4.y = vertex_unnamed_537;
				vertex_output_5.y = vertex_unnamed_538;
				vertex_output_7.x = vertex_input_7.x;
				vertex_output_7.y = vertex_input_7.y;
				vertex_output_7.z = vertex_input_7.z;
				vertex_output_7.w = vertex_input_7.w;
				precise float vertex_unnamed_564 = vertex_unnamed_432 * vertex_uniform_buffer_0[18u].x;
				precise float vertex_unnamed_565 = vertex_unnamed_432 * vertex_uniform_buffer_0[18u].y;
				precise float vertex_unnamed_566 = vertex_unnamed_432 * vertex_uniform_buffer_0[18u].z;
				vertex_output_8.x = mad(vertex_uniform_buffer_0[19u].x, vertex_unnamed_433, mad(vertex_uniform_buffer_0[17u].x, vertex_unnamed_431, vertex_unnamed_564));
				vertex_output_8.y = mad(vertex_uniform_buffer_0[19u].y, vertex_unnamed_433, mad(vertex_uniform_buffer_0[17u].y, vertex_unnamed_431, vertex_unnamed_565));
				vertex_output_8.z = mad(vertex_uniform_buffer_0[19u].z, vertex_unnamed_433, mad(vertex_uniform_buffer_0[17u].z, vertex_unnamed_431, vertex_unnamed_566));
				precise float vertex_unnamed_590 = vertex_unnamed_420 * vertex_uniform_buffer_0[5u].x;
				precise float vertex_unnamed_591 = vertex_unnamed_420 * vertex_uniform_buffer_0[5u].y;
				vertex_output_9.x = mad(vertex_uniform_buffer_0[7u].x, vertex_unnamed_422, mad(vertex_uniform_buffer_0[6u].x, vertex_unnamed_421, mad(vertex_uniform_buffer_0[4u].x, vertex_unnamed_419, vertex_unnamed_590)));
				vertex_output_9.y = mad(vertex_uniform_buffer_0[7u].y, vertex_unnamed_422, mad(vertex_uniform_buffer_0[6u].y, vertex_unnamed_421, mad(vertex_uniform_buffer_0[4u].y, vertex_unnamed_419, vertex_unnamed_591)));
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[4] = float4(unity_WorldToLight[0][0], unity_WorldToLight[1][0], unity_WorldToLight[2][0], unity_WorldToLight[3][0]);
				vertex_uniform_buffer_0[5] = float4(unity_WorldToLight[0][1], unity_WorldToLight[1][1], unity_WorldToLight[2][1], unity_WorldToLight[3][1]);
				vertex_uniform_buffer_0[6] = float4(unity_WorldToLight[0][2], unity_WorldToLight[1][2], unity_WorldToLight[2][2], unity_WorldToLight[3][2]);
				vertex_uniform_buffer_0[7] = float4(unity_WorldToLight[0][3], unity_WorldToLight[1][3], unity_WorldToLight[2][3], unity_WorldToLight[3][3]);

				vertex_uniform_buffer_0[10] = float4(_FaceDilate, vertex_uniform_buffer_0[10][1], vertex_uniform_buffer_0[10][2], vertex_uniform_buffer_0[10][3]);

				vertex_uniform_buffer_0[17] = float4(_EnvMatrix[0][0], _EnvMatrix[1][0], _EnvMatrix[2][0], _EnvMatrix[3][0]);
				vertex_uniform_buffer_0[18] = float4(_EnvMatrix[0][1], _EnvMatrix[1][1], _EnvMatrix[2][1], _EnvMatrix[3][1]);
				vertex_uniform_buffer_0[19] = float4(_EnvMatrix[0][2], _EnvMatrix[1][2], _EnvMatrix[2][2], _EnvMatrix[3][2]);
				vertex_uniform_buffer_0[20] = float4(_EnvMatrix[0][3], _EnvMatrix[1][3], _EnvMatrix[2][3], _EnvMatrix[3][3]);

				vertex_uniform_buffer_0[28] = float4(vertex_uniform_buffer_0[28][0], _WeightNormal, vertex_uniform_buffer_0[28][2], vertex_uniform_buffer_0[28][3]);

				vertex_uniform_buffer_0[28] = float4(vertex_uniform_buffer_0[28][0], vertex_uniform_buffer_0[28][1], _WeightBold, vertex_uniform_buffer_0[28][3]);

				vertex_uniform_buffer_0[28] = float4(vertex_uniform_buffer_0[28][0], vertex_uniform_buffer_0[28][1], vertex_uniform_buffer_0[28][2], _ScaleRatioA);

				vertex_uniform_buffer_0[29] = float4(vertex_uniform_buffer_0[29][0], vertex_uniform_buffer_0[29][1], _VertexOffsetX, vertex_uniform_buffer_0[29][3]);

				vertex_uniform_buffer_0[29] = float4(vertex_uniform_buffer_0[29][0], vertex_uniform_buffer_0[29][1], vertex_uniform_buffer_0[29][2], _VertexOffsetY);

				vertex_uniform_buffer_0[34] = float4(_GradientScale, vertex_uniform_buffer_0[34][1], vertex_uniform_buffer_0[34][2], vertex_uniform_buffer_0[34][3]);

				vertex_uniform_buffer_0[34] = float4(vertex_uniform_buffer_0[34][0], _ScaleX, vertex_uniform_buffer_0[34][2], vertex_uniform_buffer_0[34][3]);

				vertex_uniform_buffer_0[34] = float4(vertex_uniform_buffer_0[34][0], vertex_uniform_buffer_0[34][1], _ScaleY, vertex_uniform_buffer_0[34][3]);

				vertex_uniform_buffer_0[34] = float4(vertex_uniform_buffer_0[34][0], vertex_uniform_buffer_0[34][1], vertex_uniform_buffer_0[34][2], _PerspectiveFilter);

				vertex_uniform_buffer_0[35] = float4(_Sharpness, vertex_uniform_buffer_0[35][1], vertex_uniform_buffer_0[35][2], vertex_uniform_buffer_0[35][3]);

				vertex_uniform_buffer_0[36] = float4(_MainTex_ST[0], _MainTex_ST[1], _MainTex_ST[2], _MainTex_ST[3]);

				vertex_uniform_buffer_0[37] = float4(_FaceTex_ST[0], _FaceTex_ST[1], _FaceTex_ST[2], _FaceTex_ST[3]);

				vertex_uniform_buffer_0[38] = float4(_OutlineTex_ST[0], _OutlineTex_ST[1], _OutlineTex_ST[2], _OutlineTex_ST[3]);

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

				vertex_uniform_buffer_2[9] = float4(unity_WorldTransformParams[0], unity_WorldTransformParams[1], unity_WorldTransformParams[2], unity_WorldTransformParams[3]);

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
				vertex_input_5 = stage_input.vertex_input_5;
				vertex_input_6 = stage_input.vertex_input_6;
				vertex_input_7 = stage_input.vertex_input_7;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
				stage_output.vertex_output_6 = vertex_output_6;
				stage_output.vertex_output_7 = vertex_output_7;
				stage_output.vertex_output_8 = vertex_output_8;
				stage_output.vertex_output_9 = vertex_output_9;
				return stage_output;
			}

			#endif // DIRECTIONAL_COOKIE
			#endif // !DIRECTIONAL
			#endif // !POINT
			#endif // !POINT_COOKIE
			#endif // !SPOT


			#ifdef POINT
			#ifndef DIRECTIONAL
			#ifndef DIRECTIONAL_COOKIE
			#ifndef POINT_COOKIE
			#ifndef SPOT
			#define ANY_SHADER_VARIANT_ACTIVE

			float3 _WorldSpaceCameraPos;
			float4 _ScreenParams;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4 unity_WorldTransformParams;
			float4x4 glstate_matrix_projection;
			float4x4 unity_MatrixVP;
			float4x4 unity_WorldToLight;
			float _FaceDilate;
			float4x4 _EnvMatrix;
			float _WeightNormal;
			float _WeightBold;
			float _ScaleRatioA;
			float _VertexOffsetX;
			float _VertexOffsetY;
			float _GradientScale;
			float _ScaleX;
			float _ScaleY;
			float _PerspectiveFilter;
			float _Sharpness;
			float4 _MainTex_ST;
			float4 _FaceTex_ST;
			float4 _OutlineTex_ST;

			static float4 unity_ObjectToWorld__array[4];
			static float4 unity_WorldToObject__array[4];
			static float4 glstate_matrix_projection__array[4];
			static float4 unity_MatrixVP__array[4];
			static float4 unity_WorldToLight__array[4];
			static float4 _EnvMatrix__array[4];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_4;
			static float4 vertex_output_0;
			static float2 vertex_output_1;
			static float4 vertex_input_3;
			static float3 vertex_input_2;
			static float3 vertex_output_6;
			static float2 vertex_output_2;
			static float3 vertex_output_3;
			static float4 vertex_input_1;
			static float3 vertex_output_4;
			static float3 vertex_output_5;
			static float4 vertex_output_7;
			static float4 vertex_input_5;
			static float3 vertex_output_8;
			static float3 vertex_output_9;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION;
				float4 vertex_input_1 : TANGENT;
				float3 vertex_input_2 : NORMAL;
				float4 vertex_input_3 : TEXCOORD0;
				float4 vertex_input_4 : TEXCOORD1;
				float4 vertex_input_5 : COLOR;
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_0 : TEXCOORD0; // vs_TEXCOORD0
				float2 vertex_output_1 : TEXCOORD1; // vs_TEXCOORD1
				float2 vertex_output_2 : TEXCOORD6; // vs_TEXCOORD6
				float3 vertex_output_3 : TEXCOORD2; // vs_TEXCOORD2
				float3 vertex_output_4 : TEXCOORD3; // vs_TEXCOORD3
				float3 vertex_output_5 : TEXCOORD4; // vs_TEXCOORD4
				float3 vertex_output_6 : TEXCOORD5; // vs_TEXCOORD5
				float4 vertex_output_7 : UNKNOWN7;
				float3 vertex_output_8 : TEXCOORD7; // vs_TEXCOORD7
				float3 vertex_output_9 : TEXCOORD8; // vs_TEXCOORD8
				float4 gl_Position : SV_Position;
			};

			static float3 vertex_unnamed_9;
			static float4 vertex_unnamed_40;
			static float4 vertex_unnamed_64;
			static float4 vertex_unnamed_70;
			static float vertex_unnamed_106;
			static float vertex_unnamed_258;
			static float vertex_unnamed_273;
			static int vertex_unnamed_346;
			static int vertex_unnamed_355;
			static bool vertex_unnamed_469;
			static float3 vertex_unnamed_556;
			static float vertex_unnamed_569;

			void vert_main()
			{
				float2 vertex_unnamed_36 = vertex_input_0.xy + float2(_VertexOffsetX, _VertexOffsetY);
				vertex_unnamed_9 = float3(vertex_unnamed_36.x, vertex_unnamed_36.y, vertex_unnamed_9.z);
				vertex_unnamed_40 = vertex_unnamed_9.yyyy * unity_ObjectToWorld__array[1];
				vertex_unnamed_40 = (unity_ObjectToWorld__array[0] * vertex_unnamed_9.xxxx) + vertex_unnamed_40;
				vertex_unnamed_40 = (unity_ObjectToWorld__array[2] * vertex_input_0.zzzz) + vertex_unnamed_40;
				vertex_unnamed_64 = vertex_unnamed_40 + unity_ObjectToWorld__array[3];
				vertex_unnamed_70 = vertex_unnamed_64.yyyy * unity_MatrixVP__array[1];
				vertex_unnamed_70 = (unity_MatrixVP__array[0] * vertex_unnamed_64.xxxx) + vertex_unnamed_70;
				vertex_unnamed_70 = (unity_MatrixVP__array[2] * vertex_unnamed_64.zzzz) + vertex_unnamed_70;
				gl_Position = (unity_MatrixVP__array[3] * vertex_unnamed_64.wwww) + vertex_unnamed_70;
				vertex_unnamed_106 = vertex_input_4.x * 0.000244140625f;
				vertex_unnamed_70.x = floor(vertex_unnamed_106);
				vertex_unnamed_70.y = ((-vertex_unnamed_70.x) * 4096.0f) + vertex_input_4.x;
				float2 vertex_unnamed_130 = vertex_unnamed_70.xy * 0.001953125f.xx;
				vertex_unnamed_70 = float4(vertex_unnamed_130.x, vertex_unnamed_130.y, vertex_unnamed_70.z, vertex_unnamed_70.w);
				float2 vertex_unnamed_144 = (vertex_unnamed_70.xy * _FaceTex_ST.xy) + _FaceTex_ST.zw;
				vertex_output_0 = float4(vertex_output_0.x, vertex_output_0.y, vertex_unnamed_144.x, vertex_unnamed_144.y);
				vertex_output_1 = (vertex_unnamed_70.xy * _OutlineTex_ST.xy) + _OutlineTex_ST.zw;
				float2 vertex_unnamed_171 = (vertex_input_3.xy * _MainTex_ST.xy) + _MainTex_ST.zw;
				vertex_output_0 = float4(vertex_unnamed_171.x, vertex_unnamed_171.y, vertex_output_0.z, vertex_output_0.w);
				vertex_unnamed_106 = vertex_unnamed_64.y * unity_MatrixVP__array[1].w;
				vertex_unnamed_106 = (unity_MatrixVP__array[0].w * vertex_unnamed_64.x) + vertex_unnamed_106;
				vertex_unnamed_106 = (unity_MatrixVP__array[2].w * vertex_unnamed_64.z) + vertex_unnamed_106;
				vertex_unnamed_106 = (unity_MatrixVP__array[3].w * vertex_unnamed_64.w) + vertex_unnamed_106;
				float2 vertex_unnamed_209 = _ScreenParams.yy * glstate_matrix_projection__array[1].xy;
				vertex_unnamed_64 = float4(vertex_unnamed_209.x, vertex_unnamed_209.y, vertex_unnamed_64.z, vertex_unnamed_64.w);
				float2 vertex_unnamed_221 = (glstate_matrix_projection__array[0].xy * _ScreenParams.xx) + vertex_unnamed_64.xy;
				vertex_unnamed_64 = float4(vertex_unnamed_221.x, vertex_unnamed_221.y, vertex_unnamed_64.z, vertex_unnamed_64.w);
				float2 vertex_unnamed_233 = vertex_unnamed_64.xy * float2(_ScaleX, _ScaleY);
				vertex_unnamed_64 = float4(vertex_unnamed_233.x, vertex_unnamed_233.y, vertex_unnamed_64.z, vertex_unnamed_64.w);
				float2 vertex_unnamed_240 = vertex_unnamed_106.xx / vertex_unnamed_64.xy;
				vertex_unnamed_64 = float4(vertex_unnamed_240.x, vertex_unnamed_240.y, vertex_unnamed_64.z, vertex_unnamed_64.w);
				vertex_unnamed_106 = dot(vertex_unnamed_64.xy, vertex_unnamed_64.xy);
				vertex_unnamed_106 = rsqrt(vertex_unnamed_106);
				vertex_unnamed_64.x = abs(vertex_input_4.y) * _GradientScale;
				vertex_unnamed_258 = _Sharpness + 1.0f;
				vertex_unnamed_64.x = vertex_unnamed_258 * vertex_unnamed_64.x;
				vertex_unnamed_258 = vertex_unnamed_106 * vertex_unnamed_64.x;
				vertex_unnamed_273 = (-_PerspectiveFilter) + 1.0f;
				vertex_unnamed_258 = vertex_unnamed_273 * vertex_unnamed_258;
				vertex_unnamed_106 = (vertex_unnamed_106 * vertex_unnamed_64.x) + (-vertex_unnamed_258);
				float3 vertex_unnamed_296 = _WorldSpaceCameraPos.yyy * unity_WorldToObject__array[1].xyz;
				vertex_unnamed_64 = float4(vertex_unnamed_296.x, vertex_unnamed_64.y, vertex_unnamed_296.y, vertex_unnamed_296.z);
				float3 vertex_unnamed_308 = (unity_WorldToObject__array[0].xyz * _WorldSpaceCameraPos.xxx) + vertex_unnamed_64.xzw;
				vertex_unnamed_64 = float4(vertex_unnamed_308.x, vertex_unnamed_64.y, vertex_unnamed_308.y, vertex_unnamed_308.z);
				float3 vertex_unnamed_320 = (unity_WorldToObject__array[2].xyz * _WorldSpaceCameraPos.zzz) + vertex_unnamed_64.xzw;
				vertex_unnamed_64 = float4(vertex_unnamed_320.x, vertex_unnamed_64.y, vertex_unnamed_320.y, vertex_unnamed_320.z);
				float3 vertex_unnamed_328 = vertex_unnamed_64.xzw + unity_WorldToObject__array[3].xyz;
				vertex_unnamed_64 = float4(vertex_unnamed_328.x, vertex_unnamed_64.y, vertex_unnamed_328.y, vertex_unnamed_328.z);
				vertex_unnamed_9.z = vertex_input_0.z;
				vertex_unnamed_9 = (-vertex_unnamed_9) + vertex_unnamed_64.xzw;
				vertex_unnamed_9.x = dot(vertex_input_2, vertex_unnamed_9);
				vertex_unnamed_346 = int((0.0f < vertex_unnamed_9.x) ? 4294967295u : 0u);
				vertex_unnamed_355 = int((vertex_unnamed_9.x < 0.0f) ? 4294967295u : 0u);
				vertex_unnamed_355 = (-vertex_unnamed_346) + vertex_unnamed_355;
				vertex_unnamed_9.x = float(vertex_unnamed_355);
				vertex_unnamed_9 = vertex_unnamed_9.xxx * vertex_input_2;
				vertex_unnamed_70.y = dot(vertex_unnamed_9, unity_WorldToObject__array[0].xyz);
				vertex_unnamed_70.z = dot(vertex_unnamed_9, unity_WorldToObject__array[1].xyz);
				vertex_unnamed_70.x = dot(vertex_unnamed_9, unity_WorldToObject__array[2].xyz);
				vertex_unnamed_9.x = dot(vertex_unnamed_70.xyz, vertex_unnamed_70.xyz);
				vertex_unnamed_9.x = rsqrt(vertex_unnamed_9.x);
				vertex_unnamed_9 = vertex_unnamed_9.xxx * vertex_unnamed_70.xyz;
				float3 vertex_unnamed_413 = (unity_ObjectToWorld__array[3].xyz * vertex_input_0.www) + vertex_unnamed_40.xyz;
				vertex_unnamed_64 = float4(vertex_unnamed_413.x, vertex_unnamed_64.y, vertex_unnamed_413.y, vertex_unnamed_413.z);
				vertex_unnamed_40 = (unity_ObjectToWorld__array[3] * vertex_input_0.wwww) + vertex_unnamed_40;
				float3 vertex_unnamed_428 = (-vertex_unnamed_64.xzw) + _WorldSpaceCameraPos;
				vertex_unnamed_70 = float4(vertex_unnamed_428.x, vertex_unnamed_428.y, vertex_unnamed_428.z, vertex_unnamed_70.w);
				vertex_output_6 = vertex_unnamed_64.xzw;
				vertex_unnamed_64.x = dot(vertex_unnamed_70.xyz, vertex_unnamed_70.xyz);
				vertex_unnamed_64.x = rsqrt(vertex_unnamed_64.x);
				float3 vertex_unnamed_449 = vertex_unnamed_64.xxx * vertex_unnamed_70.xyz;
				vertex_unnamed_64 = float4(vertex_unnamed_449.x, vertex_unnamed_64.y, vertex_unnamed_449.y, vertex_unnamed_449.z);
				vertex_unnamed_64.x = dot(vertex_unnamed_9.yzx, vertex_unnamed_64.xzw);
				vertex_output_2.y = (abs(vertex_unnamed_64.x) * vertex_unnamed_106) + vertex_unnamed_258;
				vertex_unnamed_469 = 0.0f >= vertex_input_4.y;
				vertex_unnamed_106 = float(vertex_unnamed_469);
				vertex_unnamed_64.x = (-_WeightNormal) + _WeightBold;
				vertex_unnamed_106 = (vertex_unnamed_106 * vertex_unnamed_64.x) + _WeightNormal;
				vertex_unnamed_106 = (vertex_unnamed_106 * 0.25f) + _FaceDilate;
				vertex_unnamed_106 *= _ScaleRatioA;
				vertex_output_2.x = vertex_unnamed_106 * 0.5f;
				vertex_output_3.z = vertex_unnamed_9.y;
				float3 vertex_unnamed_517 = vertex_input_1.yyy * unity_ObjectToWorld__array[1].yzx;
				vertex_unnamed_64 = float4(vertex_unnamed_517.x, vertex_unnamed_517.y, vertex_unnamed_517.z, vertex_unnamed_64.w);
				float3 vertex_unnamed_528 = (unity_ObjectToWorld__array[0].yzx * vertex_input_1.xxx) + vertex_unnamed_64.xyz;
				vertex_unnamed_64 = float4(vertex_unnamed_528.x, vertex_unnamed_528.y, vertex_unnamed_528.z, vertex_unnamed_64.w);
				float3 vertex_unnamed_539 = (unity_ObjectToWorld__array[2].yzx * vertex_input_1.zzz) + vertex_unnamed_64.xyz;
				vertex_unnamed_64 = float4(vertex_unnamed_539.x, vertex_unnamed_539.y, vertex_unnamed_539.z, vertex_unnamed_64.w);
				vertex_unnamed_106 = dot(vertex_unnamed_64.xyz, vertex_unnamed_64.xyz);
				vertex_unnamed_106 = rsqrt(vertex_unnamed_106);
				float3 vertex_unnamed_553 = vertex_unnamed_106.xxx * vertex_unnamed_64.xyz;
				vertex_unnamed_64 = float4(vertex_unnamed_553.x, vertex_unnamed_553.y, vertex_unnamed_553.z, vertex_unnamed_64.w);
				vertex_unnamed_556 = vertex_unnamed_9 * vertex_unnamed_64.xyz;
				vertex_unnamed_556 = (vertex_unnamed_9.zxy * vertex_unnamed_64.yzx) + (-vertex_unnamed_556);
				vertex_unnamed_569 = vertex_input_1.w * unity_WorldTransformParams.w;
				vertex_unnamed_556 = vertex_unnamed_569.xxx * vertex_unnamed_556;
				vertex_output_3.y = vertex_unnamed_556.x;
				vertex_output_3.x = vertex_unnamed_64.z;
				vertex_output_4.z = vertex_unnamed_9.z;
				vertex_output_5.z = vertex_unnamed_9.x;
				vertex_output_4.x = vertex_unnamed_64.x;
				vertex_output_5.x = vertex_unnamed_64.y;
				vertex_output_4.y = vertex_unnamed_556.y;
				vertex_output_5.y = vertex_unnamed_556.z;
				vertex_output_7 = vertex_input_5;
				vertex_unnamed_9 = vertex_unnamed_70.yyy * _EnvMatrix__array[1].xyz;
				vertex_unnamed_9 = (_EnvMatrix__array[0].xyz * vertex_unnamed_70.xxx) + vertex_unnamed_9;
				vertex_output_8 = (_EnvMatrix__array[2].xyz * vertex_unnamed_70.zzz) + vertex_unnamed_9;
				vertex_unnamed_9 = vertex_unnamed_40.yyy * unity_WorldToLight__array[1].xyz;
				vertex_unnamed_9 = (unity_WorldToLight__array[0].xyz * vertex_unnamed_40.xxx) + vertex_unnamed_9;
				vertex_unnamed_9 = (unity_WorldToLight__array[2].xyz * vertex_unnamed_40.zzz) + vertex_unnamed_9;
				vertex_output_9 = (unity_WorldToLight__array[3].xyz * vertex_unnamed_40.www) + vertex_unnamed_9;
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

				unity_WorldToLight__array[0] = float4(unity_WorldToLight[0][0], unity_WorldToLight[1][0], unity_WorldToLight[2][0], unity_WorldToLight[3][0]);
				unity_WorldToLight__array[1] = float4(unity_WorldToLight[0][1], unity_WorldToLight[1][1], unity_WorldToLight[2][1], unity_WorldToLight[3][1]);
				unity_WorldToLight__array[2] = float4(unity_WorldToLight[0][2], unity_WorldToLight[1][2], unity_WorldToLight[2][2], unity_WorldToLight[3][2]);
				unity_WorldToLight__array[3] = float4(unity_WorldToLight[0][3], unity_WorldToLight[1][3], unity_WorldToLight[2][3], unity_WorldToLight[3][3]);

				_EnvMatrix__array[0] = float4(_EnvMatrix[0][0], _EnvMatrix[1][0], _EnvMatrix[2][0], _EnvMatrix[3][0]);
				_EnvMatrix__array[1] = float4(_EnvMatrix[0][1], _EnvMatrix[1][1], _EnvMatrix[2][1], _EnvMatrix[3][1]);
				_EnvMatrix__array[2] = float4(_EnvMatrix[0][2], _EnvMatrix[1][2], _EnvMatrix[2][2], _EnvMatrix[3][2]);
				_EnvMatrix__array[3] = float4(_EnvMatrix[0][3], _EnvMatrix[1][3], _EnvMatrix[2][3], _EnvMatrix[3][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_4 = stage_input.vertex_input_4;
				vertex_input_3 = stage_input.vertex_input_3;
				vertex_input_2 = stage_input.vertex_input_2;
				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_5 = stage_input.vertex_input_5;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_0 = vertex_output_0;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_6 = vertex_output_6;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
				stage_output.vertex_output_7 = vertex_output_7;
				stage_output.vertex_output_8 = vertex_output_8;
				stage_output.vertex_output_9 = vertex_output_9;
				return stage_output;
			}

			float4 _Time;
			float3 _WorldSpaceCameraPos;
			float4 _WorldSpaceLightPos0;
			float4 _LightColor0;
			float4 _SpecColor;
			float4x4 unity_WorldToLight;
			float _FaceUVSpeedX;
			float _FaceUVSpeedY;
			float4 _FaceColor;
			float _OutlineSoftness;
			float _OutlineUVSpeedX;
			float _OutlineUVSpeedY;
			float4 _OutlineColor;
			float _OutlineWidth;
			float _Bevel;
			float _BevelOffset;
			float _BevelWidth;
			float _BevelClamp;
			float _BevelRoundness;
			float _BumpOutline;
			float _BumpFace;
			float _ShaderFlags;
			float _ScaleRatioA;
			float _TextureWidth;
			float _TextureHeight;
			float _GradientScale;
			float _FaceShininess;
			float _OutlineShininess;

			static float4 unity_WorldToLight__array[4];
			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;
			Texture2D<float4> _OutlineTex;
			SamplerState sampler_OutlineTex;
			Texture2D<float4> _FaceTex;
			SamplerState sampler_FaceTex;
			Texture2D<float4> _BumpMap;
			SamplerState sampler_BumpMap;
			Texture2D<float4> _LightTexture0;
			SamplerState sampler_LightTexture0;

			static float2 fragment_input_2;
			static float4 fragment_input_0;
			static float2 fragment_input_1;
			static float4 fragment_input_7;
			static float3 fragment_input_3;
			static float3 fragment_input_4;
			static float3 fragment_input_5;
			static float3 fragment_input_6;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_0 : TEXCOORD0; // vs_TEXCOORD0
				float2 fragment_input_1 : TEXCOORD1; // vs_TEXCOORD1
				float2 fragment_input_2 : TEXCOORD6; // vs_TEXCOORD6
				float3 fragment_input_3 : TEXCOORD2; // vs_TEXCOORD2
				float3 fragment_input_4 : TEXCOORD3; // vs_TEXCOORD3
				float3 fragment_input_5 : TEXCOORD4; // vs_TEXCOORD4
				float3 fragment_input_6 : TEXCOORD5; // vs_TEXCOORD5
				float4 fragment_input_7 : UNKNOWN7;
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static float4 fragment_unnamed_9;
			static float4 fragment_unnamed_32;
			static float4 fragment_unnamed_48;
			static float4 fragment_unnamed_62;
			static float fragment_unnamed_168;
			static bool fragment_unnamed_175;
			static bool fragment_unnamed_193;
			static float fragment_unnamed_270;
			static float fragment_unnamed_428;
			static float fragment_unnamed_449;
			static float fragment_unnamed_479;
			static float fragment_unnamed_548;
			static float fragment_unnamed_731;

			void frag_main()
			{
				fragment_unnamed_9.x = fragment_input_2.x + _BevelOffset;
				float2 fragment_unnamed_42 = 1.0f.xx / float2(_TextureWidth, _TextureHeight);
				fragment_unnamed_32 = float4(fragment_unnamed_42.x, fragment_unnamed_42.y, fragment_unnamed_32.z, fragment_unnamed_32.w);
				fragment_unnamed_32.z = 0.0f;
				fragment_unnamed_48 = (-fragment_unnamed_32.xzzy) + fragment_input_0.xyxy;
				fragment_unnamed_32 = fragment_unnamed_32.xzzy + fragment_input_0.xyxy;
				fragment_unnamed_62.x = _MainTex.Sample(sampler_MainTex, fragment_unnamed_48.xy).w;
				fragment_unnamed_62.z = _MainTex.Sample(sampler_MainTex, fragment_unnamed_48.zw).w;
				fragment_unnamed_62.y = _MainTex.Sample(sampler_MainTex, fragment_unnamed_32.xy).w;
				fragment_unnamed_62.w = _MainTex.Sample(sampler_MainTex, fragment_unnamed_32.zw).w;
				fragment_unnamed_9 = fragment_unnamed_9.xxxx + fragment_unnamed_62;
				fragment_unnamed_9 += (-0.5f).xxxx;
				fragment_unnamed_32.x = _BevelWidth + _OutlineWidth;
				fragment_unnamed_32.x = max(fragment_unnamed_32.x, 0.00999999977648258209228515625f);
				fragment_unnamed_9 /= fragment_unnamed_32.xxxx;
				fragment_unnamed_32.x *= _Bevel;
				fragment_unnamed_32.x *= _GradientScale;
				fragment_unnamed_32.x *= (-2.0f);
				fragment_unnamed_9 += 0.5f.xxxx;
				fragment_unnamed_9 = clamp(fragment_unnamed_9, 0.0f.xxxx, 1.0f.xxxx);
				fragment_unnamed_48 = (fragment_unnamed_9 * 2.0f.xxxx) + (-1.0f).xxxx;
				fragment_unnamed_48 = (-abs(fragment_unnamed_48)) + 1.0f.xxxx;
				fragment_unnamed_168 = _ShaderFlags * 0.5f;
				fragment_unnamed_175 = fragment_unnamed_168 >= (-fragment_unnamed_168);
				fragment_unnamed_168 = frac(abs(fragment_unnamed_168));
				float fragment_unnamed_185;
				if (fragment_unnamed_175)
				{
					fragment_unnamed_185 = fragment_unnamed_168;
				}
				else
				{
					fragment_unnamed_185 = -fragment_unnamed_168;
				}
				fragment_unnamed_168 = fragment_unnamed_185;
				fragment_unnamed_193 = fragment_unnamed_168 >= 0.5f;
				bool4 fragment_unnamed_200 = fragment_unnamed_193.xxxx;
				fragment_unnamed_9 = float4(fragment_unnamed_200.x ? fragment_unnamed_48.x : fragment_unnamed_9.x, fragment_unnamed_200.y ? fragment_unnamed_48.y : fragment_unnamed_9.y, fragment_unnamed_200.z ? fragment_unnamed_48.z : fragment_unnamed_9.z, fragment_unnamed_200.w ? fragment_unnamed_48.w : fragment_unnamed_9.w);
				fragment_unnamed_48 = fragment_unnamed_9 * 1.57079601287841796875f.xxxx;
				fragment_unnamed_48 = sin(fragment_unnamed_48);
				fragment_unnamed_48 = (-fragment_unnamed_9) + fragment_unnamed_48;
				fragment_unnamed_9 = (float4(float4(_BevelRoundness, _BevelRoundness, _BevelRoundness, _BevelRoundness)) * fragment_unnamed_48) + fragment_unnamed_9;
				fragment_unnamed_168 = (-_BevelClamp) + 1.0f;
				fragment_unnamed_9 = min(fragment_unnamed_9, fragment_unnamed_168.xxxx);
				float2 fragment_unnamed_244 = fragment_unnamed_32.xx * fragment_unnamed_9.xz;
				fragment_unnamed_9 = float4(fragment_unnamed_244.x, fragment_unnamed_9.y, fragment_unnamed_244.y, fragment_unnamed_9.w);
				float2 fragment_unnamed_255 = (fragment_unnamed_9.wy * fragment_unnamed_32.xx) + (-fragment_unnamed_9.zx);
				fragment_unnamed_9 = float4(fragment_unnamed_9.x, fragment_unnamed_255.x, fragment_unnamed_255.y, fragment_unnamed_9.w);
				fragment_unnamed_9.x = -1.0f;
				fragment_unnamed_9.w = 1.0f;
				fragment_unnamed_32.x = dot(fragment_unnamed_9.xy, fragment_unnamed_9.xy);
				fragment_unnamed_32.x = rsqrt(fragment_unnamed_32.x);
				fragment_unnamed_270 = dot(fragment_unnamed_9.zw, fragment_unnamed_9.zw);
				fragment_unnamed_270 = rsqrt(fragment_unnamed_270);
				fragment_unnamed_48.x = fragment_unnamed_270 * fragment_unnamed_9.z;
				float2 fragment_unnamed_286 = fragment_unnamed_270.xx * float2(1.0f, 0.0f);
				fragment_unnamed_48 = float4(fragment_unnamed_48.x, fragment_unnamed_286.x, fragment_unnamed_286.y, fragment_unnamed_48.w);
				fragment_unnamed_9.z = 0.0f;
				float3 fragment_unnamed_294 = fragment_unnamed_32.xxx * fragment_unnamed_9.xyz;
				fragment_unnamed_9 = float4(fragment_unnamed_294.x, fragment_unnamed_294.y, fragment_unnamed_294.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_301 = fragment_unnamed_9.xyz * fragment_unnamed_48.xyz;
				fragment_unnamed_32 = float4(fragment_unnamed_301.x, fragment_unnamed_301.y, fragment_unnamed_301.z, fragment_unnamed_32.w);
				float3 fragment_unnamed_312 = (fragment_unnamed_48.zxy * fragment_unnamed_9.yzx) + (-fragment_unnamed_32.xyz);
				fragment_unnamed_9 = float4(fragment_unnamed_312.x, fragment_unnamed_312.y, fragment_unnamed_312.z, fragment_unnamed_9.w);
				float2 fragment_unnamed_330 = (float2(_OutlineUVSpeedX, _OutlineUVSpeedY) * _Time.yy) + fragment_input_1;
				fragment_unnamed_32 = float4(fragment_unnamed_330.x, fragment_unnamed_330.y, fragment_unnamed_32.z, fragment_unnamed_32.w);
				fragment_unnamed_32 = _OutlineTex.Sample(sampler_OutlineTex, fragment_unnamed_32.xy);
				float3 fragment_unnamed_347 = fragment_unnamed_32.xyz * _OutlineColor.xyz;
				fragment_unnamed_32 = float4(fragment_unnamed_347.x, fragment_unnamed_347.y, fragment_unnamed_347.z, fragment_unnamed_32.w);
				fragment_unnamed_270 = fragment_input_7.w * _OutlineColor.w;
				fragment_unnamed_48.w = fragment_unnamed_32.w * fragment_unnamed_270;
				float3 fragment_unnamed_365 = fragment_unnamed_32.xyz * fragment_unnamed_48.www;
				fragment_unnamed_48 = float4(fragment_unnamed_365.x, fragment_unnamed_365.y, fragment_unnamed_365.z, fragment_unnamed_48.w);
				float2 fragment_unnamed_381 = (float2(_FaceUVSpeedX, _FaceUVSpeedY) * _Time.yy) + fragment_input_0.zw;
				fragment_unnamed_32 = float4(fragment_unnamed_381.x, fragment_unnamed_381.y, fragment_unnamed_32.z, fragment_unnamed_32.w);
				fragment_unnamed_32 = _FaceTex.Sample(sampler_FaceTex, fragment_unnamed_32.xy);
				fragment_unnamed_62 = fragment_input_7 * _FaceColor;
				fragment_unnamed_32 *= fragment_unnamed_62;
				float3 fragment_unnamed_404 = fragment_unnamed_32.www * fragment_unnamed_32.xyz;
				fragment_unnamed_32 = float4(fragment_unnamed_404.x, fragment_unnamed_404.y, fragment_unnamed_404.z, fragment_unnamed_32.w);
				fragment_unnamed_48 = (-fragment_unnamed_32) + fragment_unnamed_48;
				fragment_unnamed_270 = _OutlineWidth * _ScaleRatioA;
				fragment_unnamed_270 *= fragment_input_2.y;
				fragment_unnamed_62.x = min(fragment_unnamed_270, 1.0f);
				fragment_unnamed_62.x = sqrt(fragment_unnamed_62.x);
				fragment_unnamed_428 = _MainTex.Sample(sampler_MainTex, fragment_input_0.xy).w;
				fragment_unnamed_428 = (-fragment_unnamed_428) + 0.5f;
				fragment_unnamed_428 += (-fragment_input_2.x);
				fragment_unnamed_428 = (fragment_unnamed_428 * fragment_input_2.y) + 0.5f;
				fragment_unnamed_449 = (fragment_unnamed_270 * 0.5f) + fragment_unnamed_428;
				fragment_unnamed_449 = clamp(fragment_unnamed_449, 0.0f, 1.0f);
				fragment_unnamed_270 = ((-fragment_unnamed_270) * 0.5f) + fragment_unnamed_428;
				fragment_unnamed_62.x *= fragment_unnamed_449;
				fragment_unnamed_32 = (fragment_unnamed_62.xxxx * fragment_unnamed_48) + fragment_unnamed_32;
				fragment_unnamed_48.x = _OutlineSoftness * _ScaleRatioA;
				fragment_unnamed_479 = fragment_unnamed_48.x * fragment_input_2.y;
				fragment_unnamed_48.x = (fragment_unnamed_48.x * fragment_input_2.y) + 1.0f;
				fragment_unnamed_270 = (fragment_unnamed_479 * 0.5f) + fragment_unnamed_270;
				fragment_unnamed_270 /= fragment_unnamed_48.x;
				fragment_unnamed_270 = clamp(fragment_unnamed_270, 0.0f, 1.0f);
				fragment_unnamed_270 = (-fragment_unnamed_270) + 1.0f;
				fragment_unnamed_32 = fragment_unnamed_270.xxxx * fragment_unnamed_32;
				fragment_unnamed_270 = (-_BumpFace) + _BumpOutline;
				fragment_unnamed_270 = (fragment_unnamed_449 * fragment_unnamed_270) + _BumpFace;
				float3 fragment_unnamed_531 = _BumpMap.Sample(sampler_BumpMap, fragment_input_0.zw).xyw;
				fragment_unnamed_48 = float4(fragment_unnamed_531.x, fragment_unnamed_531.y, fragment_unnamed_531.z, fragment_unnamed_48.w);
				fragment_unnamed_48.x = fragment_unnamed_48.z * fragment_unnamed_48.x;
				float2 fragment_unnamed_545 = (fragment_unnamed_48.xy * 2.0f.xx) + (-1.0f).xx;
				fragment_unnamed_48 = float4(fragment_unnamed_545.x, fragment_unnamed_545.y, fragment_unnamed_48.z, fragment_unnamed_48.w);
				fragment_unnamed_548 = dot(fragment_unnamed_48.xy, fragment_unnamed_48.xy);
				fragment_unnamed_548 = min(fragment_unnamed_548, 1.0f);
				fragment_unnamed_548 = (-fragment_unnamed_548) + 1.0f;
				fragment_unnamed_48.z = sqrt(fragment_unnamed_548);
				float3 fragment_unnamed_569 = (fragment_unnamed_48.xyz * fragment_unnamed_270.xxx) + float3(-0.0f, -0.0f, -1.0f);
				fragment_unnamed_48 = float4(fragment_unnamed_569.x, fragment_unnamed_569.y, fragment_unnamed_569.z, fragment_unnamed_48.w);
				float3 fragment_unnamed_578 = (fragment_unnamed_32.www * fragment_unnamed_48.xyz) + float3(0.0f, 0.0f, 1.0f);
				fragment_unnamed_48 = float4(fragment_unnamed_578.x, fragment_unnamed_578.y, fragment_unnamed_578.z, fragment_unnamed_48.w);
				float3 fragment_unnamed_586 = fragment_unnamed_9.xyz + (-fragment_unnamed_48.xyz);
				fragment_unnamed_9 = float4(fragment_unnamed_586.x, fragment_unnamed_586.y, fragment_unnamed_586.z, fragment_unnamed_9.w);
				fragment_unnamed_270 = dot(fragment_unnamed_9.xyz, fragment_unnamed_9.xyz);
				fragment_unnamed_270 = rsqrt(fragment_unnamed_270);
				float3 fragment_unnamed_600 = fragment_unnamed_270.xxx * fragment_unnamed_9.xyz;
				fragment_unnamed_9 = float4(fragment_unnamed_600.x, fragment_unnamed_600.y, fragment_unnamed_600.z, fragment_unnamed_9.w);
				fragment_unnamed_48.x = dot(fragment_input_3, -fragment_unnamed_9.xyz);
				fragment_unnamed_48.y = dot(fragment_input_4, -fragment_unnamed_9.xyz);
				fragment_unnamed_48.z = dot(fragment_input_5, -fragment_unnamed_9.xyz);
				fragment_unnamed_9.x = dot(fragment_unnamed_48.xyz, fragment_unnamed_48.xyz);
				fragment_unnamed_9.x = rsqrt(fragment_unnamed_9.x);
				float3 fragment_unnamed_639 = fragment_unnamed_9.xxx * fragment_unnamed_48.xyz;
				fragment_unnamed_9 = float4(fragment_unnamed_639.x, fragment_unnamed_639.y, fragment_unnamed_639.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_649 = (-fragment_input_6) + _WorldSpaceLightPos0.xyz;
				fragment_unnamed_48 = float4(fragment_unnamed_649.x, fragment_unnamed_649.y, fragment_unnamed_649.z, fragment_unnamed_48.w);
				fragment_unnamed_270 = dot(fragment_unnamed_48.xyz, fragment_unnamed_48.xyz);
				fragment_unnamed_270 = rsqrt(fragment_unnamed_270);
				float3 fragment_unnamed_663 = fragment_unnamed_270.xxx * fragment_unnamed_48.xyz;
				fragment_unnamed_48 = float4(fragment_unnamed_663.x, fragment_unnamed_663.y, fragment_unnamed_663.z, fragment_unnamed_48.w);
				float3 fragment_unnamed_672 = (-fragment_input_6) + _WorldSpaceCameraPos;
				fragment_unnamed_62 = float4(fragment_unnamed_672.x, fragment_unnamed_672.y, fragment_unnamed_62.z, fragment_unnamed_672.z);
				fragment_unnamed_270 = dot(fragment_unnamed_62.xyw, fragment_unnamed_62.xyw);
				fragment_unnamed_270 = rsqrt(fragment_unnamed_270);
				float3 fragment_unnamed_689 = (fragment_unnamed_62.xyw * fragment_unnamed_270.xxx) + fragment_unnamed_48.xyz;
				fragment_unnamed_62 = float4(fragment_unnamed_689.x, fragment_unnamed_689.y, fragment_unnamed_62.z, fragment_unnamed_689.z);
				fragment_unnamed_9.w = dot(fragment_unnamed_9.xyz, fragment_unnamed_48.xyz);
				fragment_unnamed_48.x = dot(fragment_unnamed_62.xyw, fragment_unnamed_62.xyw);
				fragment_unnamed_48.x = rsqrt(fragment_unnamed_48.x);
				float3 fragment_unnamed_712 = fragment_unnamed_48.xxx * fragment_unnamed_62.xyw;
				fragment_unnamed_48 = float4(fragment_unnamed_712.x, fragment_unnamed_712.y, fragment_unnamed_712.z, fragment_unnamed_48.w);
				fragment_unnamed_9.x = dot(fragment_unnamed_9.xyz, fragment_unnamed_48.xyz);
				float2 fragment_unnamed_724 = max(fragment_unnamed_9.xw, 0.0f.xx);
				fragment_unnamed_9 = float4(fragment_unnamed_724.x, fragment_unnamed_9.y, fragment_unnamed_9.z, fragment_unnamed_724.y);
				fragment_unnamed_9.x = log2(fragment_unnamed_9.x);
				fragment_unnamed_731 = (-_FaceShininess) + _OutlineShininess;
				fragment_unnamed_731 = (fragment_unnamed_449 * fragment_unnamed_731) + _FaceShininess;
				fragment_unnamed_731 *= 128.0f;
				fragment_unnamed_9.x *= fragment_unnamed_731;
				fragment_unnamed_9.x = exp2(fragment_unnamed_9.x);
				float3 fragment_unnamed_764 = fragment_input_6.yyy * unity_WorldToLight__array[1].xyz;
				fragment_unnamed_48 = float4(fragment_unnamed_764.x, fragment_unnamed_764.y, fragment_unnamed_764.z, fragment_unnamed_48.w);
				float3 fragment_unnamed_775 = (unity_WorldToLight__array[0].xyz * fragment_input_6.xxx) + fragment_unnamed_48.xyz;
				fragment_unnamed_48 = float4(fragment_unnamed_775.x, fragment_unnamed_775.y, fragment_unnamed_775.z, fragment_unnamed_48.w);
				float3 fragment_unnamed_786 = (unity_WorldToLight__array[2].xyz * fragment_input_6.zzz) + fragment_unnamed_48.xyz;
				fragment_unnamed_48 = float4(fragment_unnamed_786.x, fragment_unnamed_786.y, fragment_unnamed_786.z, fragment_unnamed_48.w);
				float3 fragment_unnamed_795 = fragment_unnamed_48.xyz + unity_WorldToLight__array[3].xyz;
				fragment_unnamed_48 = float4(fragment_unnamed_795.x, fragment_unnamed_795.y, fragment_unnamed_795.z, fragment_unnamed_48.w);
				fragment_unnamed_731 = dot(fragment_unnamed_48.xyz, fragment_unnamed_48.xyz);
				fragment_unnamed_731 = _LightTexture0.Sample(sampler_LightTexture0, fragment_unnamed_731.xx).x;
				float3 fragment_unnamed_817 = fragment_unnamed_731.xxx * _LightColor0.xyz;
				fragment_unnamed_48 = float4(fragment_unnamed_817.x, fragment_unnamed_817.y, fragment_unnamed_817.z, fragment_unnamed_48.w);
				float3 fragment_unnamed_826 = fragment_unnamed_48.xyz * _SpecColor.xyz;
				fragment_unnamed_62 = float4(fragment_unnamed_826.x, fragment_unnamed_826.y, fragment_unnamed_826.z, fragment_unnamed_62.w);
				float3 fragment_unnamed_833 = fragment_unnamed_9.xxx * fragment_unnamed_62.xyz;
				fragment_unnamed_9 = float4(fragment_unnamed_833.x, fragment_unnamed_833.y, fragment_unnamed_833.z, fragment_unnamed_9.w);
				fragment_unnamed_548 = max(fragment_unnamed_32.w, 9.9999997473787516355514526367188e-05f);
				float3 fragment_unnamed_844 = fragment_unnamed_32.xyz / fragment_unnamed_548.xxx;
				fragment_unnamed_32 = float4(fragment_unnamed_844.x, fragment_unnamed_844.y, fragment_unnamed_844.z, fragment_unnamed_32.w);
				fragment_output_0.w = fragment_unnamed_32.w;
				float3 fragment_unnamed_857 = fragment_unnamed_48.xyz * fragment_unnamed_32.xyz;
				fragment_unnamed_32 = float4(fragment_unnamed_857.x, fragment_unnamed_857.y, fragment_unnamed_857.z, fragment_unnamed_32.w);
				float3 fragment_unnamed_867 = (fragment_unnamed_32.xyz * fragment_unnamed_9.www) + fragment_unnamed_9.xyz;
				fragment_output_0 = float4(fragment_unnamed_867.x, fragment_unnamed_867.y, fragment_unnamed_867.z, fragment_output_0.w);
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				unity_WorldToLight__array[0] = float4(unity_WorldToLight[0][0], unity_WorldToLight[1][0], unity_WorldToLight[2][0], unity_WorldToLight[3][0]);
				unity_WorldToLight__array[1] = float4(unity_WorldToLight[0][1], unity_WorldToLight[1][1], unity_WorldToLight[2][1], unity_WorldToLight[3][1]);
				unity_WorldToLight__array[2] = float4(unity_WorldToLight[0][2], unity_WorldToLight[1][2], unity_WorldToLight[2][2], unity_WorldToLight[3][2]);
				unity_WorldToLight__array[3] = float4(unity_WorldToLight[0][3], unity_WorldToLight[1][3], unity_WorldToLight[2][3], unity_WorldToLight[3][3]);

				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_0 = stage_input.fragment_input_0;
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_7 = stage_input.fragment_input_7;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				fragment_input_6 = stage_input.fragment_input_6;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // POINT
			#endif // !DIRECTIONAL
			#endif // !DIRECTIONAL_COOKIE
			#endif // !POINT_COOKIE
			#endif // !SPOT


			#ifdef DIRECTIONAL
			#ifndef DIRECTIONAL_COOKIE
			#ifndef POINT
			#ifndef POINT_COOKIE
			#ifndef SPOT
			#define ANY_SHADER_VARIANT_ACTIVE

			float3 _WorldSpaceCameraPos;
			float4 _ScreenParams;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4 unity_WorldTransformParams;
			float4x4 glstate_matrix_projection;
			float4x4 unity_MatrixVP;
			float _FaceDilate;
			float4x4 _EnvMatrix;
			float _WeightNormal;
			float _WeightBold;
			float _ScaleRatioA;
			float _VertexOffsetX;
			float _VertexOffsetY;
			float _GradientScale;
			float _ScaleX;
			float _ScaleY;
			float _PerspectiveFilter;
			float _Sharpness;
			float4 _MainTex_ST;
			float4 _FaceTex_ST;
			float4 _OutlineTex_ST;

			static float4 unity_ObjectToWorld__array[4];
			static float4 unity_WorldToObject__array[4];
			static float4 glstate_matrix_projection__array[4];
			static float4 unity_MatrixVP__array[4];
			static float4 _EnvMatrix__array[4];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_4;
			static float4 vertex_output_0;
			static float2 vertex_output_1;
			static float4 vertex_input_3;
			static float3 vertex_input_2;
			static float3 vertex_output_6;
			static float2 vertex_output_2;
			static float3 vertex_output_3;
			static float4 vertex_input_1;
			static float3 vertex_output_4;
			static float3 vertex_output_5;
			static float4 vertex_output_7;
			static float4 vertex_input_5;
			static float3 vertex_output_8;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION;
				float4 vertex_input_1 : TANGENT;
				float3 vertex_input_2 : NORMAL;
				float4 vertex_input_3 : TEXCOORD0;
				float4 vertex_input_4 : TEXCOORD1;
				float4 vertex_input_5 : COLOR;
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_0 : TEXCOORD0; // vs_TEXCOORD0
				float2 vertex_output_1 : TEXCOORD1; // vs_TEXCOORD1
				float2 vertex_output_2 : TEXCOORD6; // vs_TEXCOORD6
				float3 vertex_output_3 : TEXCOORD2; // vs_TEXCOORD2
				float3 vertex_output_4 : TEXCOORD3; // vs_TEXCOORD3
				float3 vertex_output_5 : TEXCOORD4; // vs_TEXCOORD4
				float3 vertex_output_6 : TEXCOORD5; // vs_TEXCOORD5
				float4 vertex_output_7 : UNKNOWN7;
				float3 vertex_output_8 : TEXCOORD7; // vs_TEXCOORD7
				float4 gl_Position : SV_Position;
			};

			static float3 vertex_unnamed_9;
			static float4 vertex_unnamed_39;
			static float4 vertex_unnamed_63;
			static float4 vertex_unnamed_80;
			static float vertex_unnamed_116;
			static float vertex_unnamed_260;
			static float3 vertex_unnamed_282;
			static int vertex_unnamed_347;
			static int vertex_unnamed_356;
			static bool vertex_unnamed_448;
			static float vertex_unnamed_552;

			void vert_main()
			{
				float2 vertex_unnamed_35 = vertex_input_0.xy + float2(_VertexOffsetX, _VertexOffsetY);
				vertex_unnamed_9 = float3(vertex_unnamed_35.x, vertex_unnamed_35.y, vertex_unnamed_9.z);
				vertex_unnamed_39 = vertex_unnamed_9.yyyy * unity_ObjectToWorld__array[1];
				vertex_unnamed_39 = (unity_ObjectToWorld__array[0] * vertex_unnamed_9.xxxx) + vertex_unnamed_39;
				vertex_unnamed_39 = (unity_ObjectToWorld__array[2] * vertex_input_0.zzzz) + vertex_unnamed_39;
				vertex_unnamed_63 = vertex_unnamed_39 + unity_ObjectToWorld__array[3];
				float3 vertex_unnamed_77 = (unity_ObjectToWorld__array[3].xyz * vertex_input_0.www) + vertex_unnamed_39.xyz;
				vertex_unnamed_39 = float4(vertex_unnamed_77.x, vertex_unnamed_77.y, vertex_unnamed_77.z, vertex_unnamed_39.w);
				vertex_unnamed_80 = vertex_unnamed_63.yyyy * unity_MatrixVP__array[1];
				vertex_unnamed_80 = (unity_MatrixVP__array[0] * vertex_unnamed_63.xxxx) + vertex_unnamed_80;
				vertex_unnamed_80 = (unity_MatrixVP__array[2] * vertex_unnamed_63.zzzz) + vertex_unnamed_80;
				gl_Position = (unity_MatrixVP__array[3] * vertex_unnamed_63.wwww) + vertex_unnamed_80;
				vertex_unnamed_116 = vertex_input_4.x * 0.000244140625f;
				vertex_unnamed_80.x = floor(vertex_unnamed_116);
				vertex_unnamed_80.y = ((-vertex_unnamed_80.x) * 4096.0f) + vertex_input_4.x;
				float2 vertex_unnamed_140 = vertex_unnamed_80.xy * 0.001953125f.xx;
				vertex_unnamed_80 = float4(vertex_unnamed_140.x, vertex_unnamed_140.y, vertex_unnamed_80.z, vertex_unnamed_80.w);
				float2 vertex_unnamed_154 = (vertex_unnamed_80.xy * _FaceTex_ST.xy) + _FaceTex_ST.zw;
				vertex_output_0 = float4(vertex_output_0.x, vertex_output_0.y, vertex_unnamed_154.x, vertex_unnamed_154.y);
				vertex_output_1 = (vertex_unnamed_80.xy * _OutlineTex_ST.xy) + _OutlineTex_ST.zw;
				float2 vertex_unnamed_181 = (vertex_input_3.xy * _MainTex_ST.xy) + _MainTex_ST.zw;
				vertex_output_0 = float4(vertex_unnamed_181.x, vertex_unnamed_181.y, vertex_output_0.z, vertex_output_0.w);
				vertex_unnamed_116 = vertex_unnamed_63.y * unity_MatrixVP__array[1].w;
				vertex_unnamed_116 = (unity_MatrixVP__array[0].w * vertex_unnamed_63.x) + vertex_unnamed_116;
				vertex_unnamed_116 = (unity_MatrixVP__array[2].w * vertex_unnamed_63.z) + vertex_unnamed_116;
				vertex_unnamed_116 = (unity_MatrixVP__array[3].w * vertex_unnamed_63.w) + vertex_unnamed_116;
				float2 vertex_unnamed_219 = _ScreenParams.yy * glstate_matrix_projection__array[1].xy;
				vertex_unnamed_63 = float4(vertex_unnamed_219.x, vertex_unnamed_219.y, vertex_unnamed_63.z, vertex_unnamed_63.w);
				float2 vertex_unnamed_231 = (glstate_matrix_projection__array[0].xy * _ScreenParams.xx) + vertex_unnamed_63.xy;
				vertex_unnamed_63 = float4(vertex_unnamed_231.x, vertex_unnamed_231.y, vertex_unnamed_63.z, vertex_unnamed_63.w);
				float2 vertex_unnamed_243 = vertex_unnamed_63.xy * float2(_ScaleX, _ScaleY);
				vertex_unnamed_63 = float4(vertex_unnamed_243.x, vertex_unnamed_243.y, vertex_unnamed_63.z, vertex_unnamed_63.w);
				float2 vertex_unnamed_250 = vertex_unnamed_116.xx / vertex_unnamed_63.xy;
				vertex_unnamed_63 = float4(vertex_unnamed_250.x, vertex_unnamed_250.y, vertex_unnamed_63.z, vertex_unnamed_63.w);
				vertex_unnamed_116 = dot(vertex_unnamed_63.xy, vertex_unnamed_63.xy);
				vertex_unnamed_116 = rsqrt(vertex_unnamed_116);
				vertex_unnamed_260 = abs(vertex_input_4.y) * _GradientScale;
				vertex_unnamed_63.x = _Sharpness + 1.0f;
				vertex_unnamed_260 *= vertex_unnamed_63.x;
				vertex_unnamed_63.x = vertex_unnamed_116 * vertex_unnamed_260;
				vertex_unnamed_282.x = (-_PerspectiveFilter) + 1.0f;
				vertex_unnamed_63.x = vertex_unnamed_282.x * vertex_unnamed_63.x;
				vertex_unnamed_116 = (vertex_unnamed_116 * vertex_unnamed_260) + (-vertex_unnamed_63.x);
				vertex_unnamed_282 = _WorldSpaceCameraPos.yyy * unity_WorldToObject__array[1].xyz;
				vertex_unnamed_282 = (unity_WorldToObject__array[0].xyz * _WorldSpaceCameraPos.xxx) + vertex_unnamed_282;
				vertex_unnamed_282 = (unity_WorldToObject__array[2].xyz * _WorldSpaceCameraPos.zzz) + vertex_unnamed_282;
				vertex_unnamed_282 += unity_WorldToObject__array[3].xyz;
				vertex_unnamed_9.z = vertex_input_0.z;
				vertex_unnamed_9 = (-vertex_unnamed_9) + vertex_unnamed_282;
				vertex_unnamed_9.x = dot(vertex_input_2, vertex_unnamed_9);
				vertex_unnamed_347 = int((0.0f < vertex_unnamed_9.x) ? 4294967295u : 0u);
				vertex_unnamed_356 = int((vertex_unnamed_9.x < 0.0f) ? 4294967295u : 0u);
				vertex_unnamed_356 = (-vertex_unnamed_347) + vertex_unnamed_356;
				vertex_unnamed_9.x = float(vertex_unnamed_356);
				vertex_unnamed_9 = vertex_unnamed_9.xxx * vertex_input_2;
				vertex_unnamed_80.y = dot(vertex_unnamed_9, unity_WorldToObject__array[0].xyz);
				vertex_unnamed_80.z = dot(vertex_unnamed_9, unity_WorldToObject__array[1].xyz);
				vertex_unnamed_80.x = dot(vertex_unnamed_9, unity_WorldToObject__array[2].xyz);
				vertex_unnamed_9.x = dot(vertex_unnamed_80.xyz, vertex_unnamed_80.xyz);
				vertex_unnamed_9.x = rsqrt(vertex_unnamed_9.x);
				vertex_unnamed_9 = vertex_unnamed_9.xxx * vertex_unnamed_80.xyz;
				vertex_unnamed_282 = (-vertex_unnamed_39.xyz) + _WorldSpaceCameraPos;
				vertex_output_6 = vertex_unnamed_39.xyz;
				vertex_unnamed_39.x = dot(vertex_unnamed_282, vertex_unnamed_282);
				vertex_unnamed_39.x = rsqrt(vertex_unnamed_39.x);
				float3 vertex_unnamed_427 = vertex_unnamed_39.xxx * vertex_unnamed_282;
				vertex_unnamed_39 = float4(vertex_unnamed_427.x, vertex_unnamed_427.y, vertex_unnamed_427.z, vertex_unnamed_39.w);
				vertex_unnamed_39.x = dot(vertex_unnamed_9.yzx, vertex_unnamed_39.xyz);
				vertex_output_2.y = (abs(vertex_unnamed_39.x) * vertex_unnamed_116) + vertex_unnamed_63.x;
				vertex_unnamed_448 = 0.0f >= vertex_input_4.y;
				vertex_unnamed_116 = float(vertex_unnamed_448);
				vertex_unnamed_39.x = (-_WeightNormal) + _WeightBold;
				vertex_unnamed_116 = (vertex_unnamed_116 * vertex_unnamed_39.x) + _WeightNormal;
				vertex_unnamed_116 = (vertex_unnamed_116 * 0.25f) + _FaceDilate;
				vertex_unnamed_116 *= _ScaleRatioA;
				vertex_output_2.x = vertex_unnamed_116 * 0.5f;
				vertex_output_3.z = vertex_unnamed_9.y;
				float3 vertex_unnamed_496 = vertex_input_1.yyy * unity_ObjectToWorld__array[1].yzx;
				vertex_unnamed_39 = float4(vertex_unnamed_496.x, vertex_unnamed_496.y, vertex_unnamed_496.z, vertex_unnamed_39.w);
				float3 vertex_unnamed_507 = (unity_ObjectToWorld__array[0].yzx * vertex_input_1.xxx) + vertex_unnamed_39.xyz;
				vertex_unnamed_39 = float4(vertex_unnamed_507.x, vertex_unnamed_507.y, vertex_unnamed_507.z, vertex_unnamed_39.w);
				float3 vertex_unnamed_518 = (unity_ObjectToWorld__array[2].yzx * vertex_input_1.zzz) + vertex_unnamed_39.xyz;
				vertex_unnamed_39 = float4(vertex_unnamed_518.x, vertex_unnamed_518.y, vertex_unnamed_518.z, vertex_unnamed_39.w);
				vertex_unnamed_116 = dot(vertex_unnamed_39.xyz, vertex_unnamed_39.xyz);
				vertex_unnamed_116 = rsqrt(vertex_unnamed_116);
				float3 vertex_unnamed_532 = vertex_unnamed_116.xxx * vertex_unnamed_39.xyz;
				vertex_unnamed_39 = float4(vertex_unnamed_532.x, vertex_unnamed_532.y, vertex_unnamed_532.z, vertex_unnamed_39.w);
				float3 vertex_unnamed_538 = vertex_unnamed_9 * vertex_unnamed_39.xyz;
				vertex_unnamed_80 = float4(vertex_unnamed_538.x, vertex_unnamed_538.y, vertex_unnamed_538.z, vertex_unnamed_80.w);
				float3 vertex_unnamed_549 = (vertex_unnamed_9.zxy * vertex_unnamed_39.yzx) + (-vertex_unnamed_80.xyz);
				vertex_unnamed_80 = float4(vertex_unnamed_549.x, vertex_unnamed_549.y, vertex_unnamed_549.z, vertex_unnamed_80.w);
				vertex_unnamed_552 = vertex_input_1.w * unity_WorldTransformParams.w;
				float3 vertex_unnamed_563 = vertex_unnamed_552.xxx * vertex_unnamed_80.xyz;
				vertex_unnamed_80 = float4(vertex_unnamed_563.x, vertex_unnamed_563.y, vertex_unnamed_563.z, vertex_unnamed_80.w);
				vertex_output_3.y = vertex_unnamed_80.x;
				vertex_output_3.x = vertex_unnamed_39.z;
				vertex_output_4.z = vertex_unnamed_9.z;
				vertex_output_5.z = vertex_unnamed_9.x;
				vertex_output_4.x = vertex_unnamed_39.x;
				vertex_output_5.x = vertex_unnamed_39.y;
				vertex_output_4.y = vertex_unnamed_80.y;
				vertex_output_5.y = vertex_unnamed_80.z;
				vertex_output_7 = vertex_input_5;
				vertex_unnamed_9 = vertex_unnamed_282.yyy * _EnvMatrix__array[1].xyz;
				vertex_unnamed_9 = (_EnvMatrix__array[0].xyz * vertex_unnamed_282.xxx) + vertex_unnamed_9;
				vertex_output_8 = (_EnvMatrix__array[2].xyz * vertex_unnamed_282.zzz) + vertex_unnamed_9;
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

				_EnvMatrix__array[0] = float4(_EnvMatrix[0][0], _EnvMatrix[1][0], _EnvMatrix[2][0], _EnvMatrix[3][0]);
				_EnvMatrix__array[1] = float4(_EnvMatrix[0][1], _EnvMatrix[1][1], _EnvMatrix[2][1], _EnvMatrix[3][1]);
				_EnvMatrix__array[2] = float4(_EnvMatrix[0][2], _EnvMatrix[1][2], _EnvMatrix[2][2], _EnvMatrix[3][2]);
				_EnvMatrix__array[3] = float4(_EnvMatrix[0][3], _EnvMatrix[1][3], _EnvMatrix[2][3], _EnvMatrix[3][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_4 = stage_input.vertex_input_4;
				vertex_input_3 = stage_input.vertex_input_3;
				vertex_input_2 = stage_input.vertex_input_2;
				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_5 = stage_input.vertex_input_5;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_0 = vertex_output_0;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_6 = vertex_output_6;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
				stage_output.vertex_output_7 = vertex_output_7;
				stage_output.vertex_output_8 = vertex_output_8;
				return stage_output;
			}

			float4 _Time;
			float3 _WorldSpaceCameraPos;
			float4 _WorldSpaceLightPos0;
			float4 _LightColor0;
			float4 _SpecColor;
			float _FaceUVSpeedX;
			float _FaceUVSpeedY;
			float4 _FaceColor;
			float _OutlineSoftness;
			float _OutlineUVSpeedX;
			float _OutlineUVSpeedY;
			float4 _OutlineColor;
			float _OutlineWidth;
			float _Bevel;
			float _BevelOffset;
			float _BevelWidth;
			float _BevelClamp;
			float _BevelRoundness;
			float _BumpOutline;
			float _BumpFace;
			float _ShaderFlags;
			float _ScaleRatioA;
			float _TextureWidth;
			float _TextureHeight;
			float _GradientScale;
			float _FaceShininess;
			float _OutlineShininess;

			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;
			Texture2D<float4> _OutlineTex;
			SamplerState sampler_OutlineTex;
			Texture2D<float4> _FaceTex;
			SamplerState sampler_FaceTex;
			Texture2D<float4> _BumpMap;
			SamplerState sampler_BumpMap;

			static float2 fragment_input_2;
			static float4 fragment_input_0;
			static float2 fragment_input_1;
			static float4 fragment_input_7;
			static float3 fragment_input_3;
			static float3 fragment_input_4;
			static float3 fragment_input_5;
			static float3 fragment_input_6;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_0 : TEXCOORD0; // vs_TEXCOORD0
				float2 fragment_input_1 : TEXCOORD1; // vs_TEXCOORD1
				float2 fragment_input_2 : TEXCOORD6; // vs_TEXCOORD6
				float3 fragment_input_3 : TEXCOORD2; // vs_TEXCOORD2
				float3 fragment_input_4 : TEXCOORD3; // vs_TEXCOORD3
				float3 fragment_input_5 : TEXCOORD4; // vs_TEXCOORD4
				float3 fragment_input_6 : TEXCOORD5; // vs_TEXCOORD5
				float4 fragment_input_7 : UNKNOWN7;
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static float4 fragment_unnamed_9;
			static float4 fragment_unnamed_30;
			static float4 fragment_unnamed_46;
			static float4 fragment_unnamed_60;
			static float fragment_unnamed_166;
			static bool fragment_unnamed_173;
			static bool fragment_unnamed_191;
			static float fragment_unnamed_268;
			static float fragment_unnamed_426;
			static float fragment_unnamed_447;
			static float fragment_unnamed_477;
			static float fragment_unnamed_546;
			static float3 fragment_unnamed_703;
			static float fragment_unnamed_708;

			void frag_main()
			{
				fragment_unnamed_9.x = fragment_input_2.x + _BevelOffset;
				float2 fragment_unnamed_40 = 1.0f.xx / float2(_TextureWidth, _TextureHeight);
				fragment_unnamed_30 = float4(fragment_unnamed_40.x, fragment_unnamed_40.y, fragment_unnamed_30.z, fragment_unnamed_30.w);
				fragment_unnamed_30.z = 0.0f;
				fragment_unnamed_46 = (-fragment_unnamed_30.xzzy) + fragment_input_0.xyxy;
				fragment_unnamed_30 = fragment_unnamed_30.xzzy + fragment_input_0.xyxy;
				fragment_unnamed_60.x = _MainTex.Sample(sampler_MainTex, fragment_unnamed_46.xy).w;
				fragment_unnamed_60.z = _MainTex.Sample(sampler_MainTex, fragment_unnamed_46.zw).w;
				fragment_unnamed_60.y = _MainTex.Sample(sampler_MainTex, fragment_unnamed_30.xy).w;
				fragment_unnamed_60.w = _MainTex.Sample(sampler_MainTex, fragment_unnamed_30.zw).w;
				fragment_unnamed_9 = fragment_unnamed_9.xxxx + fragment_unnamed_60;
				fragment_unnamed_9 += (-0.5f).xxxx;
				fragment_unnamed_30.x = _BevelWidth + _OutlineWidth;
				fragment_unnamed_30.x = max(fragment_unnamed_30.x, 0.00999999977648258209228515625f);
				fragment_unnamed_9 /= fragment_unnamed_30.xxxx;
				fragment_unnamed_30.x *= _Bevel;
				fragment_unnamed_30.x *= _GradientScale;
				fragment_unnamed_30.x *= (-2.0f);
				fragment_unnamed_9 += 0.5f.xxxx;
				fragment_unnamed_9 = clamp(fragment_unnamed_9, 0.0f.xxxx, 1.0f.xxxx);
				fragment_unnamed_46 = (fragment_unnamed_9 * 2.0f.xxxx) + (-1.0f).xxxx;
				fragment_unnamed_46 = (-abs(fragment_unnamed_46)) + 1.0f.xxxx;
				fragment_unnamed_166 = _ShaderFlags * 0.5f;
				fragment_unnamed_173 = fragment_unnamed_166 >= (-fragment_unnamed_166);
				fragment_unnamed_166 = frac(abs(fragment_unnamed_166));
				float fragment_unnamed_183;
				if (fragment_unnamed_173)
				{
					fragment_unnamed_183 = fragment_unnamed_166;
				}
				else
				{
					fragment_unnamed_183 = -fragment_unnamed_166;
				}
				fragment_unnamed_166 = fragment_unnamed_183;
				fragment_unnamed_191 = fragment_unnamed_166 >= 0.5f;
				bool4 fragment_unnamed_198 = fragment_unnamed_191.xxxx;
				fragment_unnamed_9 = float4(fragment_unnamed_198.x ? fragment_unnamed_46.x : fragment_unnamed_9.x, fragment_unnamed_198.y ? fragment_unnamed_46.y : fragment_unnamed_9.y, fragment_unnamed_198.z ? fragment_unnamed_46.z : fragment_unnamed_9.z, fragment_unnamed_198.w ? fragment_unnamed_46.w : fragment_unnamed_9.w);
				fragment_unnamed_46 = fragment_unnamed_9 * 1.57079601287841796875f.xxxx;
				fragment_unnamed_46 = sin(fragment_unnamed_46);
				fragment_unnamed_46 = (-fragment_unnamed_9) + fragment_unnamed_46;
				fragment_unnamed_9 = (float4(float4(_BevelRoundness, _BevelRoundness, _BevelRoundness, _BevelRoundness)) * fragment_unnamed_46) + fragment_unnamed_9;
				fragment_unnamed_166 = (-_BevelClamp) + 1.0f;
				fragment_unnamed_9 = min(fragment_unnamed_9, fragment_unnamed_166.xxxx);
				float2 fragment_unnamed_242 = fragment_unnamed_30.xx * fragment_unnamed_9.xz;
				fragment_unnamed_9 = float4(fragment_unnamed_242.x, fragment_unnamed_9.y, fragment_unnamed_242.y, fragment_unnamed_9.w);
				float2 fragment_unnamed_253 = (fragment_unnamed_9.wy * fragment_unnamed_30.xx) + (-fragment_unnamed_9.zx);
				fragment_unnamed_9 = float4(fragment_unnamed_9.x, fragment_unnamed_253.x, fragment_unnamed_253.y, fragment_unnamed_9.w);
				fragment_unnamed_9.x = -1.0f;
				fragment_unnamed_9.w = 1.0f;
				fragment_unnamed_30.x = dot(fragment_unnamed_9.xy, fragment_unnamed_9.xy);
				fragment_unnamed_30.x = rsqrt(fragment_unnamed_30.x);
				fragment_unnamed_268 = dot(fragment_unnamed_9.zw, fragment_unnamed_9.zw);
				fragment_unnamed_268 = rsqrt(fragment_unnamed_268);
				fragment_unnamed_46.x = fragment_unnamed_268 * fragment_unnamed_9.z;
				float2 fragment_unnamed_284 = fragment_unnamed_268.xx * float2(1.0f, 0.0f);
				fragment_unnamed_46 = float4(fragment_unnamed_46.x, fragment_unnamed_284.x, fragment_unnamed_284.y, fragment_unnamed_46.w);
				fragment_unnamed_9.z = 0.0f;
				float3 fragment_unnamed_292 = fragment_unnamed_30.xxx * fragment_unnamed_9.xyz;
				fragment_unnamed_9 = float4(fragment_unnamed_292.x, fragment_unnamed_292.y, fragment_unnamed_292.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_299 = fragment_unnamed_9.xyz * fragment_unnamed_46.xyz;
				fragment_unnamed_30 = float4(fragment_unnamed_299.x, fragment_unnamed_299.y, fragment_unnamed_299.z, fragment_unnamed_30.w);
				float3 fragment_unnamed_310 = (fragment_unnamed_46.zxy * fragment_unnamed_9.yzx) + (-fragment_unnamed_30.xyz);
				fragment_unnamed_9 = float4(fragment_unnamed_310.x, fragment_unnamed_310.y, fragment_unnamed_310.z, fragment_unnamed_9.w);
				float2 fragment_unnamed_328 = (float2(_OutlineUVSpeedX, _OutlineUVSpeedY) * _Time.yy) + fragment_input_1;
				fragment_unnamed_30 = float4(fragment_unnamed_328.x, fragment_unnamed_328.y, fragment_unnamed_30.z, fragment_unnamed_30.w);
				fragment_unnamed_30 = _OutlineTex.Sample(sampler_OutlineTex, fragment_unnamed_30.xy);
				float3 fragment_unnamed_345 = fragment_unnamed_30.xyz * _OutlineColor.xyz;
				fragment_unnamed_30 = float4(fragment_unnamed_345.x, fragment_unnamed_345.y, fragment_unnamed_345.z, fragment_unnamed_30.w);
				fragment_unnamed_268 = fragment_input_7.w * _OutlineColor.w;
				fragment_unnamed_46.w = fragment_unnamed_30.w * fragment_unnamed_268;
				float3 fragment_unnamed_363 = fragment_unnamed_30.xyz * fragment_unnamed_46.www;
				fragment_unnamed_46 = float4(fragment_unnamed_363.x, fragment_unnamed_363.y, fragment_unnamed_363.z, fragment_unnamed_46.w);
				float2 fragment_unnamed_379 = (float2(_FaceUVSpeedX, _FaceUVSpeedY) * _Time.yy) + fragment_input_0.zw;
				fragment_unnamed_30 = float4(fragment_unnamed_379.x, fragment_unnamed_379.y, fragment_unnamed_30.z, fragment_unnamed_30.w);
				fragment_unnamed_30 = _FaceTex.Sample(sampler_FaceTex, fragment_unnamed_30.xy);
				fragment_unnamed_60 = fragment_input_7 * _FaceColor;
				fragment_unnamed_30 *= fragment_unnamed_60;
				float3 fragment_unnamed_402 = fragment_unnamed_30.www * fragment_unnamed_30.xyz;
				fragment_unnamed_30 = float4(fragment_unnamed_402.x, fragment_unnamed_402.y, fragment_unnamed_402.z, fragment_unnamed_30.w);
				fragment_unnamed_46 = (-fragment_unnamed_30) + fragment_unnamed_46;
				fragment_unnamed_268 = _OutlineWidth * _ScaleRatioA;
				fragment_unnamed_268 *= fragment_input_2.y;
				fragment_unnamed_60.x = min(fragment_unnamed_268, 1.0f);
				fragment_unnamed_60.x = sqrt(fragment_unnamed_60.x);
				fragment_unnamed_426 = _MainTex.Sample(sampler_MainTex, fragment_input_0.xy).w;
				fragment_unnamed_426 = (-fragment_unnamed_426) + 0.5f;
				fragment_unnamed_426 += (-fragment_input_2.x);
				fragment_unnamed_426 = (fragment_unnamed_426 * fragment_input_2.y) + 0.5f;
				fragment_unnamed_447 = (fragment_unnamed_268 * 0.5f) + fragment_unnamed_426;
				fragment_unnamed_447 = clamp(fragment_unnamed_447, 0.0f, 1.0f);
				fragment_unnamed_268 = ((-fragment_unnamed_268) * 0.5f) + fragment_unnamed_426;
				fragment_unnamed_60.x *= fragment_unnamed_447;
				fragment_unnamed_30 = (fragment_unnamed_60.xxxx * fragment_unnamed_46) + fragment_unnamed_30;
				fragment_unnamed_46.x = _OutlineSoftness * _ScaleRatioA;
				fragment_unnamed_477 = fragment_unnamed_46.x * fragment_input_2.y;
				fragment_unnamed_46.x = (fragment_unnamed_46.x * fragment_input_2.y) + 1.0f;
				fragment_unnamed_268 = (fragment_unnamed_477 * 0.5f) + fragment_unnamed_268;
				fragment_unnamed_268 /= fragment_unnamed_46.x;
				fragment_unnamed_268 = clamp(fragment_unnamed_268, 0.0f, 1.0f);
				fragment_unnamed_268 = (-fragment_unnamed_268) + 1.0f;
				fragment_unnamed_30 = fragment_unnamed_268.xxxx * fragment_unnamed_30;
				fragment_unnamed_268 = (-_BumpFace) + _BumpOutline;
				fragment_unnamed_268 = (fragment_unnamed_447 * fragment_unnamed_268) + _BumpFace;
				float3 fragment_unnamed_529 = _BumpMap.Sample(sampler_BumpMap, fragment_input_0.zw).xyw;
				fragment_unnamed_46 = float4(fragment_unnamed_529.x, fragment_unnamed_529.y, fragment_unnamed_529.z, fragment_unnamed_46.w);
				fragment_unnamed_46.x = fragment_unnamed_46.z * fragment_unnamed_46.x;
				float2 fragment_unnamed_543 = (fragment_unnamed_46.xy * 2.0f.xx) + (-1.0f).xx;
				fragment_unnamed_46 = float4(fragment_unnamed_543.x, fragment_unnamed_543.y, fragment_unnamed_46.z, fragment_unnamed_46.w);
				fragment_unnamed_546 = dot(fragment_unnamed_46.xy, fragment_unnamed_46.xy);
				fragment_unnamed_546 = min(fragment_unnamed_546, 1.0f);
				fragment_unnamed_546 = (-fragment_unnamed_546) + 1.0f;
				fragment_unnamed_46.z = sqrt(fragment_unnamed_546);
				float3 fragment_unnamed_567 = (fragment_unnamed_46.xyz * fragment_unnamed_268.xxx) + float3(-0.0f, -0.0f, -1.0f);
				fragment_unnamed_46 = float4(fragment_unnamed_567.x, fragment_unnamed_567.y, fragment_unnamed_567.z, fragment_unnamed_46.w);
				float3 fragment_unnamed_576 = (fragment_unnamed_30.www * fragment_unnamed_46.xyz) + float3(0.0f, 0.0f, 1.0f);
				fragment_unnamed_46 = float4(fragment_unnamed_576.x, fragment_unnamed_576.y, fragment_unnamed_576.z, fragment_unnamed_46.w);
				float3 fragment_unnamed_584 = fragment_unnamed_9.xyz + (-fragment_unnamed_46.xyz);
				fragment_unnamed_9 = float4(fragment_unnamed_584.x, fragment_unnamed_584.y, fragment_unnamed_584.z, fragment_unnamed_9.w);
				fragment_unnamed_268 = dot(fragment_unnamed_9.xyz, fragment_unnamed_9.xyz);
				fragment_unnamed_268 = rsqrt(fragment_unnamed_268);
				float3 fragment_unnamed_598 = fragment_unnamed_268.xxx * fragment_unnamed_9.xyz;
				fragment_unnamed_9 = float4(fragment_unnamed_598.x, fragment_unnamed_598.y, fragment_unnamed_598.z, fragment_unnamed_9.w);
				fragment_unnamed_46.x = dot(fragment_input_3, -fragment_unnamed_9.xyz);
				fragment_unnamed_46.y = dot(fragment_input_4, -fragment_unnamed_9.xyz);
				fragment_unnamed_46.z = dot(fragment_input_5, -fragment_unnamed_9.xyz);
				fragment_unnamed_9.x = dot(fragment_unnamed_46.xyz, fragment_unnamed_46.xyz);
				fragment_unnamed_9.x = rsqrt(fragment_unnamed_9.x);
				float3 fragment_unnamed_637 = fragment_unnamed_9.xxx * fragment_unnamed_46.xyz;
				fragment_unnamed_9 = float4(fragment_unnamed_637.x, fragment_unnamed_637.y, fragment_unnamed_637.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_647 = (-fragment_input_6) + _WorldSpaceCameraPos;
				fragment_unnamed_46 = float4(fragment_unnamed_647.x, fragment_unnamed_647.y, fragment_unnamed_647.z, fragment_unnamed_46.w);
				fragment_unnamed_268 = dot(fragment_unnamed_46.xyz, fragment_unnamed_46.xyz);
				fragment_unnamed_268 = rsqrt(fragment_unnamed_268);
				float3 fragment_unnamed_666 = (fragment_unnamed_46.xyz * fragment_unnamed_268.xxx) + _WorldSpaceLightPos0.xyz;
				fragment_unnamed_46 = float4(fragment_unnamed_666.x, fragment_unnamed_666.y, fragment_unnamed_666.z, fragment_unnamed_46.w);
				fragment_unnamed_268 = dot(fragment_unnamed_46.xyz, fragment_unnamed_46.xyz);
				fragment_unnamed_268 = rsqrt(fragment_unnamed_268);
				float3 fragment_unnamed_680 = fragment_unnamed_268.xxx * fragment_unnamed_46.xyz;
				fragment_unnamed_46 = float4(fragment_unnamed_680.x, fragment_unnamed_680.y, fragment_unnamed_680.z, fragment_unnamed_46.w);
				fragment_unnamed_9.w = dot(fragment_unnamed_9.xyz, fragment_unnamed_46.xyz);
				fragment_unnamed_9.x = dot(fragment_unnamed_9.xyz, _WorldSpaceLightPos0.xyz);
				float2 fragment_unnamed_699 = max(fragment_unnamed_9.xw, 0.0f.xx);
				fragment_unnamed_9 = float4(fragment_unnamed_699.x, fragment_unnamed_699.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
				fragment_unnamed_703.x = log2(fragment_unnamed_9.y);
				fragment_unnamed_708 = (-_FaceShininess) + _OutlineShininess;
				fragment_unnamed_708 = (fragment_unnamed_447 * fragment_unnamed_708) + _FaceShininess;
				fragment_unnamed_708 *= 128.0f;
				fragment_unnamed_703.x *= fragment_unnamed_708;
				fragment_unnamed_703.x = exp2(fragment_unnamed_703.x);
				float3 fragment_unnamed_743 = _LightColor0.xyz * _SpecColor.xyz;
				fragment_unnamed_46 = float4(fragment_unnamed_743.x, fragment_unnamed_743.y, fragment_unnamed_743.z, fragment_unnamed_46.w);
				fragment_unnamed_703 = fragment_unnamed_703.xxx * fragment_unnamed_46.xyz;
				fragment_unnamed_46.x = max(fragment_unnamed_30.w, 9.9999997473787516355514526367188e-05f);
				float3 fragment_unnamed_760 = fragment_unnamed_30.xyz / fragment_unnamed_46.xxx;
				fragment_unnamed_30 = float4(fragment_unnamed_760.x, fragment_unnamed_760.y, fragment_unnamed_760.z, fragment_unnamed_30.w);
				fragment_output_0.w = fragment_unnamed_30.w;
				float3 fragment_unnamed_774 = fragment_unnamed_30.xyz * _LightColor0.xyz;
				fragment_unnamed_30 = float4(fragment_unnamed_774.x, fragment_unnamed_774.y, fragment_unnamed_774.z, fragment_unnamed_30.w);
				float3 fragment_unnamed_783 = (fragment_unnamed_30.xyz * fragment_unnamed_9.xxx) + fragment_unnamed_703;
				fragment_output_0 = float4(fragment_unnamed_783.x, fragment_unnamed_783.y, fragment_unnamed_783.z, fragment_output_0.w);
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_0 = stage_input.fragment_input_0;
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_7 = stage_input.fragment_input_7;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				fragment_input_6 = stage_input.fragment_input_6;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // DIRECTIONAL
			#endif // !DIRECTIONAL_COOKIE
			#endif // !POINT
			#endif // !POINT_COOKIE
			#endif // !SPOT


			#ifdef SPOT
			#ifndef DIRECTIONAL
			#ifndef DIRECTIONAL_COOKIE
			#ifndef POINT
			#ifndef POINT_COOKIE
			#define ANY_SHADER_VARIANT_ACTIVE

			float3 _WorldSpaceCameraPos;
			float4 _ScreenParams;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4 unity_WorldTransformParams;
			float4x4 glstate_matrix_projection;
			float4x4 unity_MatrixVP;
			float4x4 unity_WorldToLight;
			float _FaceDilate;
			float4x4 _EnvMatrix;
			float _WeightNormal;
			float _WeightBold;
			float _ScaleRatioA;
			float _VertexOffsetX;
			float _VertexOffsetY;
			float _GradientScale;
			float _ScaleX;
			float _ScaleY;
			float _PerspectiveFilter;
			float _Sharpness;
			float4 _MainTex_ST;
			float4 _FaceTex_ST;
			float4 _OutlineTex_ST;

			static float4 unity_ObjectToWorld__array[4];
			static float4 unity_WorldToObject__array[4];
			static float4 glstate_matrix_projection__array[4];
			static float4 unity_MatrixVP__array[4];
			static float4 unity_WorldToLight__array[4];
			static float4 _EnvMatrix__array[4];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_4;
			static float4 vertex_output_0;
			static float2 vertex_output_1;
			static float4 vertex_input_3;
			static float3 vertex_input_2;
			static float3 vertex_output_6;
			static float2 vertex_output_2;
			static float3 vertex_output_3;
			static float4 vertex_input_1;
			static float3 vertex_output_4;
			static float3 vertex_output_5;
			static float4 vertex_output_7;
			static float4 vertex_input_5;
			static float3 vertex_output_8;
			static float4 vertex_output_9;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION;
				float4 vertex_input_1 : TANGENT;
				float3 vertex_input_2 : NORMAL;
				float4 vertex_input_3 : TEXCOORD0;
				float4 vertex_input_4 : TEXCOORD1;
				float4 vertex_input_5 : COLOR;
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_0 : TEXCOORD0; // vs_TEXCOORD0
				float2 vertex_output_1 : TEXCOORD1; // vs_TEXCOORD1
				float2 vertex_output_2 : TEXCOORD6; // vs_TEXCOORD6
				float3 vertex_output_3 : TEXCOORD2; // vs_TEXCOORD2
				float3 vertex_output_4 : TEXCOORD3; // vs_TEXCOORD3
				float3 vertex_output_5 : TEXCOORD4; // vs_TEXCOORD4
				float3 vertex_output_6 : TEXCOORD5; // vs_TEXCOORD5
				float4 vertex_output_7 : UNKNOWN7;
				float3 vertex_output_8 : TEXCOORD7; // vs_TEXCOORD7
				float4 vertex_output_9 : TEXCOORD8; // vs_TEXCOORD8
				float4 gl_Position : SV_Position;
			};

			static float4 vertex_unnamed_9;
			static float4 vertex_unnamed_39;
			static float4 vertex_unnamed_63;
			static float4 vertex_unnamed_69;
			static float vertex_unnamed_105;
			static float vertex_unnamed_257;
			static float vertex_unnamed_272;
			static int vertex_unnamed_349;
			static int vertex_unnamed_358;
			static bool vertex_unnamed_479;
			static float3 vertex_unnamed_567;
			static float vertex_unnamed_581;

			void vert_main()
			{
				float2 vertex_unnamed_36 = vertex_input_0.xy + float2(_VertexOffsetX, _VertexOffsetY);
				vertex_unnamed_9 = float4(vertex_unnamed_36.x, vertex_unnamed_36.y, vertex_unnamed_9.z, vertex_unnamed_9.w);
				vertex_unnamed_39 = vertex_unnamed_9.yyyy * unity_ObjectToWorld__array[1];
				vertex_unnamed_39 = (unity_ObjectToWorld__array[0] * vertex_unnamed_9.xxxx) + vertex_unnamed_39;
				vertex_unnamed_39 = (unity_ObjectToWorld__array[2] * vertex_input_0.zzzz) + vertex_unnamed_39;
				vertex_unnamed_63 = vertex_unnamed_39 + unity_ObjectToWorld__array[3];
				vertex_unnamed_69 = vertex_unnamed_63.yyyy * unity_MatrixVP__array[1];
				vertex_unnamed_69 = (unity_MatrixVP__array[0] * vertex_unnamed_63.xxxx) + vertex_unnamed_69;
				vertex_unnamed_69 = (unity_MatrixVP__array[2] * vertex_unnamed_63.zzzz) + vertex_unnamed_69;
				gl_Position = (unity_MatrixVP__array[3] * vertex_unnamed_63.wwww) + vertex_unnamed_69;
				vertex_unnamed_105 = vertex_input_4.x * 0.000244140625f;
				vertex_unnamed_69.x = floor(vertex_unnamed_105);
				vertex_unnamed_69.y = ((-vertex_unnamed_69.x) * 4096.0f) + vertex_input_4.x;
				float2 vertex_unnamed_129 = vertex_unnamed_69.xy * 0.001953125f.xx;
				vertex_unnamed_69 = float4(vertex_unnamed_129.x, vertex_unnamed_129.y, vertex_unnamed_69.z, vertex_unnamed_69.w);
				float2 vertex_unnamed_143 = (vertex_unnamed_69.xy * _FaceTex_ST.xy) + _FaceTex_ST.zw;
				vertex_output_0 = float4(vertex_output_0.x, vertex_output_0.y, vertex_unnamed_143.x, vertex_unnamed_143.y);
				vertex_output_1 = (vertex_unnamed_69.xy * _OutlineTex_ST.xy) + _OutlineTex_ST.zw;
				float2 vertex_unnamed_170 = (vertex_input_3.xy * _MainTex_ST.xy) + _MainTex_ST.zw;
				vertex_output_0 = float4(vertex_unnamed_170.x, vertex_unnamed_170.y, vertex_output_0.z, vertex_output_0.w);
				vertex_unnamed_105 = vertex_unnamed_63.y * unity_MatrixVP__array[1].w;
				vertex_unnamed_105 = (unity_MatrixVP__array[0].w * vertex_unnamed_63.x) + vertex_unnamed_105;
				vertex_unnamed_105 = (unity_MatrixVP__array[2].w * vertex_unnamed_63.z) + vertex_unnamed_105;
				vertex_unnamed_105 = (unity_MatrixVP__array[3].w * vertex_unnamed_63.w) + vertex_unnamed_105;
				float2 vertex_unnamed_208 = _ScreenParams.yy * glstate_matrix_projection__array[1].xy;
				vertex_unnamed_63 = float4(vertex_unnamed_208.x, vertex_unnamed_208.y, vertex_unnamed_63.z, vertex_unnamed_63.w);
				float2 vertex_unnamed_220 = (glstate_matrix_projection__array[0].xy * _ScreenParams.xx) + vertex_unnamed_63.xy;
				vertex_unnamed_63 = float4(vertex_unnamed_220.x, vertex_unnamed_220.y, vertex_unnamed_63.z, vertex_unnamed_63.w);
				float2 vertex_unnamed_232 = vertex_unnamed_63.xy * float2(_ScaleX, _ScaleY);
				vertex_unnamed_63 = float4(vertex_unnamed_232.x, vertex_unnamed_232.y, vertex_unnamed_63.z, vertex_unnamed_63.w);
				float2 vertex_unnamed_239 = vertex_unnamed_105.xx / vertex_unnamed_63.xy;
				vertex_unnamed_63 = float4(vertex_unnamed_239.x, vertex_unnamed_239.y, vertex_unnamed_63.z, vertex_unnamed_63.w);
				vertex_unnamed_105 = dot(vertex_unnamed_63.xy, vertex_unnamed_63.xy);
				vertex_unnamed_105 = rsqrt(vertex_unnamed_105);
				vertex_unnamed_63.x = abs(vertex_input_4.y) * _GradientScale;
				vertex_unnamed_257 = _Sharpness + 1.0f;
				vertex_unnamed_63.x = vertex_unnamed_257 * vertex_unnamed_63.x;
				vertex_unnamed_257 = vertex_unnamed_105 * vertex_unnamed_63.x;
				vertex_unnamed_272 = (-_PerspectiveFilter) + 1.0f;
				vertex_unnamed_257 = vertex_unnamed_272 * vertex_unnamed_257;
				vertex_unnamed_105 = (vertex_unnamed_105 * vertex_unnamed_63.x) + (-vertex_unnamed_257);
				float3 vertex_unnamed_295 = _WorldSpaceCameraPos.yyy * unity_WorldToObject__array[1].xyz;
				vertex_unnamed_63 = float4(vertex_unnamed_295.x, vertex_unnamed_63.y, vertex_unnamed_295.y, vertex_unnamed_295.z);
				float3 vertex_unnamed_307 = (unity_WorldToObject__array[0].xyz * _WorldSpaceCameraPos.xxx) + vertex_unnamed_63.xzw;
				vertex_unnamed_63 = float4(vertex_unnamed_307.x, vertex_unnamed_63.y, vertex_unnamed_307.y, vertex_unnamed_307.z);
				float3 vertex_unnamed_319 = (unity_WorldToObject__array[2].xyz * _WorldSpaceCameraPos.zzz) + vertex_unnamed_63.xzw;
				vertex_unnamed_63 = float4(vertex_unnamed_319.x, vertex_unnamed_63.y, vertex_unnamed_319.y, vertex_unnamed_319.z);
				float3 vertex_unnamed_327 = vertex_unnamed_63.xzw + unity_WorldToObject__array[3].xyz;
				vertex_unnamed_63 = float4(vertex_unnamed_327.x, vertex_unnamed_63.y, vertex_unnamed_327.y, vertex_unnamed_327.z);
				vertex_unnamed_9.z = vertex_input_0.z;
				float3 vertex_unnamed_338 = (-vertex_unnamed_9.xyz) + vertex_unnamed_63.xzw;
				vertex_unnamed_9 = float4(vertex_unnamed_338.x, vertex_unnamed_338.y, vertex_unnamed_338.z, vertex_unnamed_9.w);
				vertex_unnamed_9.x = dot(vertex_input_2, vertex_unnamed_9.xyz);
				vertex_unnamed_349 = int((0.0f < vertex_unnamed_9.x) ? 4294967295u : 0u);
				vertex_unnamed_358 = int((vertex_unnamed_9.x < 0.0f) ? 4294967295u : 0u);
				vertex_unnamed_358 = (-vertex_unnamed_349) + vertex_unnamed_358;
				vertex_unnamed_9.x = float(vertex_unnamed_358);
				float3 vertex_unnamed_374 = vertex_unnamed_9.xxx * vertex_input_2;
				vertex_unnamed_9 = float4(vertex_unnamed_374.x, vertex_unnamed_374.y, vertex_unnamed_374.z, vertex_unnamed_9.w);
				vertex_unnamed_69.y = dot(vertex_unnamed_9.xyz, unity_WorldToObject__array[0].xyz);
				vertex_unnamed_69.z = dot(vertex_unnamed_9.xyz, unity_WorldToObject__array[1].xyz);
				vertex_unnamed_69.x = dot(vertex_unnamed_9.xyz, unity_WorldToObject__array[2].xyz);
				vertex_unnamed_9.x = dot(vertex_unnamed_69.xyz, vertex_unnamed_69.xyz);
				vertex_unnamed_9.x = rsqrt(vertex_unnamed_9.x);
				float3 vertex_unnamed_412 = vertex_unnamed_9.xxx * vertex_unnamed_69.xyz;
				vertex_unnamed_9 = float4(vertex_unnamed_412.x, vertex_unnamed_412.y, vertex_unnamed_412.z, vertex_unnamed_9.w);
				float3 vertex_unnamed_423 = (unity_ObjectToWorld__array[3].xyz * vertex_input_0.www) + vertex_unnamed_39.xyz;
				vertex_unnamed_63 = float4(vertex_unnamed_423.x, vertex_unnamed_63.y, vertex_unnamed_423.y, vertex_unnamed_423.z);
				vertex_unnamed_39 = (unity_ObjectToWorld__array[3] * vertex_input_0.wwww) + vertex_unnamed_39;
				float3 vertex_unnamed_438 = (-vertex_unnamed_63.xzw) + _WorldSpaceCameraPos;
				vertex_unnamed_69 = float4(vertex_unnamed_438.x, vertex_unnamed_438.y, vertex_unnamed_438.z, vertex_unnamed_69.w);
				vertex_output_6 = vertex_unnamed_63.xzw;
				vertex_unnamed_63.x = dot(vertex_unnamed_69.xyz, vertex_unnamed_69.xyz);
				vertex_unnamed_63.x = rsqrt(vertex_unnamed_63.x);
				float3 vertex_unnamed_459 = vertex_unnamed_63.xxx * vertex_unnamed_69.xyz;
				vertex_unnamed_63 = float4(vertex_unnamed_459.x, vertex_unnamed_63.y, vertex_unnamed_459.y, vertex_unnamed_459.z);
				vertex_unnamed_63.x = dot(vertex_unnamed_9.yzx, vertex_unnamed_63.xzw);
				vertex_output_2.y = (abs(vertex_unnamed_63.x) * vertex_unnamed_105) + vertex_unnamed_257;
				vertex_unnamed_479 = 0.0f >= vertex_input_4.y;
				vertex_unnamed_105 = float(vertex_unnamed_479);
				vertex_unnamed_63.x = (-_WeightNormal) + _WeightBold;
				vertex_unnamed_105 = (vertex_unnamed_105 * vertex_unnamed_63.x) + _WeightNormal;
				vertex_unnamed_105 = (vertex_unnamed_105 * 0.25f) + _FaceDilate;
				vertex_unnamed_105 *= _ScaleRatioA;
				vertex_output_2.x = vertex_unnamed_105 * 0.5f;
				vertex_output_3.z = vertex_unnamed_9.y;
				float3 vertex_unnamed_527 = vertex_input_1.yyy * unity_ObjectToWorld__array[1].yzx;
				vertex_unnamed_63 = float4(vertex_unnamed_527.x, vertex_unnamed_527.y, vertex_unnamed_527.z, vertex_unnamed_63.w);
				float3 vertex_unnamed_538 = (unity_ObjectToWorld__array[0].yzx * vertex_input_1.xxx) + vertex_unnamed_63.xyz;
				vertex_unnamed_63 = float4(vertex_unnamed_538.x, vertex_unnamed_538.y, vertex_unnamed_538.z, vertex_unnamed_63.w);
				float3 vertex_unnamed_549 = (unity_ObjectToWorld__array[2].yzx * vertex_input_1.zzz) + vertex_unnamed_63.xyz;
				vertex_unnamed_63 = float4(vertex_unnamed_549.x, vertex_unnamed_549.y, vertex_unnamed_549.z, vertex_unnamed_63.w);
				vertex_unnamed_105 = dot(vertex_unnamed_63.xyz, vertex_unnamed_63.xyz);
				vertex_unnamed_105 = rsqrt(vertex_unnamed_105);
				float3 vertex_unnamed_563 = vertex_unnamed_105.xxx * vertex_unnamed_63.xyz;
				vertex_unnamed_63 = float4(vertex_unnamed_563.x, vertex_unnamed_563.y, vertex_unnamed_563.z, vertex_unnamed_63.w);
				vertex_unnamed_567 = vertex_unnamed_9.xyz * vertex_unnamed_63.xyz;
				vertex_unnamed_567 = (vertex_unnamed_9.zxy * vertex_unnamed_63.yzx) + (-vertex_unnamed_567);
				vertex_unnamed_581 = vertex_input_1.w * unity_WorldTransformParams.w;
				vertex_unnamed_567 = vertex_unnamed_581.xxx * vertex_unnamed_567;
				vertex_output_3.y = vertex_unnamed_567.x;
				vertex_output_3.x = vertex_unnamed_63.z;
				vertex_output_4.z = vertex_unnamed_9.z;
				vertex_output_5.z = vertex_unnamed_9.x;
				vertex_output_4.x = vertex_unnamed_63.x;
				vertex_output_5.x = vertex_unnamed_63.y;
				vertex_output_4.y = vertex_unnamed_567.y;
				vertex_output_5.y = vertex_unnamed_567.z;
				vertex_output_7 = vertex_input_5;
				float3 vertex_unnamed_627 = vertex_unnamed_69.yyy * _EnvMatrix__array[1].xyz;
				vertex_unnamed_9 = float4(vertex_unnamed_627.x, vertex_unnamed_627.y, vertex_unnamed_627.z, vertex_unnamed_9.w);
				float3 vertex_unnamed_638 = (_EnvMatrix__array[0].xyz * vertex_unnamed_69.xxx) + vertex_unnamed_9.xyz;
				vertex_unnamed_9 = float4(vertex_unnamed_638.x, vertex_unnamed_638.y, vertex_unnamed_638.z, vertex_unnamed_9.w);
				vertex_output_8 = (_EnvMatrix__array[2].xyz * vertex_unnamed_69.zzz) + vertex_unnamed_9.xyz;
				vertex_unnamed_9 = vertex_unnamed_39.yyyy * unity_WorldToLight__array[1];
				vertex_unnamed_9 = (unity_WorldToLight__array[0] * vertex_unnamed_39.xxxx) + vertex_unnamed_9;
				vertex_unnamed_9 = (unity_WorldToLight__array[2] * vertex_unnamed_39.zzzz) + vertex_unnamed_9;
				vertex_output_9 = (unity_WorldToLight__array[3] * vertex_unnamed_39.wwww) + vertex_unnamed_9;
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

				unity_WorldToLight__array[0] = float4(unity_WorldToLight[0][0], unity_WorldToLight[1][0], unity_WorldToLight[2][0], unity_WorldToLight[3][0]);
				unity_WorldToLight__array[1] = float4(unity_WorldToLight[0][1], unity_WorldToLight[1][1], unity_WorldToLight[2][1], unity_WorldToLight[3][1]);
				unity_WorldToLight__array[2] = float4(unity_WorldToLight[0][2], unity_WorldToLight[1][2], unity_WorldToLight[2][2], unity_WorldToLight[3][2]);
				unity_WorldToLight__array[3] = float4(unity_WorldToLight[0][3], unity_WorldToLight[1][3], unity_WorldToLight[2][3], unity_WorldToLight[3][3]);

				_EnvMatrix__array[0] = float4(_EnvMatrix[0][0], _EnvMatrix[1][0], _EnvMatrix[2][0], _EnvMatrix[3][0]);
				_EnvMatrix__array[1] = float4(_EnvMatrix[0][1], _EnvMatrix[1][1], _EnvMatrix[2][1], _EnvMatrix[3][1]);
				_EnvMatrix__array[2] = float4(_EnvMatrix[0][2], _EnvMatrix[1][2], _EnvMatrix[2][2], _EnvMatrix[3][2]);
				_EnvMatrix__array[3] = float4(_EnvMatrix[0][3], _EnvMatrix[1][3], _EnvMatrix[2][3], _EnvMatrix[3][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_4 = stage_input.vertex_input_4;
				vertex_input_3 = stage_input.vertex_input_3;
				vertex_input_2 = stage_input.vertex_input_2;
				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_5 = stage_input.vertex_input_5;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_0 = vertex_output_0;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_6 = vertex_output_6;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
				stage_output.vertex_output_7 = vertex_output_7;
				stage_output.vertex_output_8 = vertex_output_8;
				stage_output.vertex_output_9 = vertex_output_9;
				return stage_output;
			}

			float4 _Time;
			float3 _WorldSpaceCameraPos;
			float4 _WorldSpaceLightPos0;
			float4 _LightColor0;
			float4 _SpecColor;
			float4x4 unity_WorldToLight;
			float _FaceUVSpeedX;
			float _FaceUVSpeedY;
			float4 _FaceColor;
			float _OutlineSoftness;
			float _OutlineUVSpeedX;
			float _OutlineUVSpeedY;
			float4 _OutlineColor;
			float _OutlineWidth;
			float _Bevel;
			float _BevelOffset;
			float _BevelWidth;
			float _BevelClamp;
			float _BevelRoundness;
			float _BumpOutline;
			float _BumpFace;
			float _ShaderFlags;
			float _ScaleRatioA;
			float _TextureWidth;
			float _TextureHeight;
			float _GradientScale;
			float _FaceShininess;
			float _OutlineShininess;

			static float4 unity_WorldToLight__array[4];
			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;
			Texture2D<float4> _OutlineTex;
			SamplerState sampler_OutlineTex;
			Texture2D<float4> _FaceTex;
			SamplerState sampler_FaceTex;
			Texture2D<float4> _BumpMap;
			SamplerState sampler_BumpMap;
			Texture2D<float4> _LightTexture0;
			SamplerState sampler_LightTexture0;
			Texture2D<float4> _LightTextureB0;
			SamplerState sampler_LightTextureB0;

			static float2 fragment_input_2;
			static float4 fragment_input_0;
			static float2 fragment_input_1;
			static float4 fragment_input_7;
			static float3 fragment_input_3;
			static float3 fragment_input_4;
			static float3 fragment_input_5;
			static float3 fragment_input_6;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_0 : TEXCOORD0; // vs_TEXCOORD0
				float2 fragment_input_1 : TEXCOORD1; // vs_TEXCOORD1
				float2 fragment_input_2 : TEXCOORD6; // vs_TEXCOORD6
				float3 fragment_input_3 : TEXCOORD2; // vs_TEXCOORD2
				float3 fragment_input_4 : TEXCOORD3; // vs_TEXCOORD3
				float3 fragment_input_5 : TEXCOORD4; // vs_TEXCOORD4
				float3 fragment_input_6 : TEXCOORD5; // vs_TEXCOORD5
				float4 fragment_input_7 : UNKNOWN7;
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static float4 fragment_unnamed_9;
			static float4 fragment_unnamed_32;
			static float4 fragment_unnamed_48;
			static float4 fragment_unnamed_62;
			static float fragment_unnamed_168;
			static bool fragment_unnamed_175;
			static bool fragment_unnamed_193;
			static float fragment_unnamed_270;
			static float fragment_unnamed_428;
			static float fragment_unnamed_449;
			static float fragment_unnamed_479;
			static float fragment_unnamed_548;
			static float2 fragment_unnamed_732;
			static bool fragment_unnamed_807;
			static float fragment_unnamed_827;

			void frag_main()
			{
				fragment_unnamed_9.x = fragment_input_2.x + _BevelOffset;
				float2 fragment_unnamed_42 = 1.0f.xx / float2(_TextureWidth, _TextureHeight);
				fragment_unnamed_32 = float4(fragment_unnamed_42.x, fragment_unnamed_42.y, fragment_unnamed_32.z, fragment_unnamed_32.w);
				fragment_unnamed_32.z = 0.0f;
				fragment_unnamed_48 = (-fragment_unnamed_32.xzzy) + fragment_input_0.xyxy;
				fragment_unnamed_32 = fragment_unnamed_32.xzzy + fragment_input_0.xyxy;
				fragment_unnamed_62.x = _MainTex.Sample(sampler_MainTex, fragment_unnamed_48.xy).w;
				fragment_unnamed_62.z = _MainTex.Sample(sampler_MainTex, fragment_unnamed_48.zw).w;
				fragment_unnamed_62.y = _MainTex.Sample(sampler_MainTex, fragment_unnamed_32.xy).w;
				fragment_unnamed_62.w = _MainTex.Sample(sampler_MainTex, fragment_unnamed_32.zw).w;
				fragment_unnamed_9 = fragment_unnamed_9.xxxx + fragment_unnamed_62;
				fragment_unnamed_9 += (-0.5f).xxxx;
				fragment_unnamed_32.x = _BevelWidth + _OutlineWidth;
				fragment_unnamed_32.x = max(fragment_unnamed_32.x, 0.00999999977648258209228515625f);
				fragment_unnamed_9 /= fragment_unnamed_32.xxxx;
				fragment_unnamed_32.x *= _Bevel;
				fragment_unnamed_32.x *= _GradientScale;
				fragment_unnamed_32.x *= (-2.0f);
				fragment_unnamed_9 += 0.5f.xxxx;
				fragment_unnamed_9 = clamp(fragment_unnamed_9, 0.0f.xxxx, 1.0f.xxxx);
				fragment_unnamed_48 = (fragment_unnamed_9 * 2.0f.xxxx) + (-1.0f).xxxx;
				fragment_unnamed_48 = (-abs(fragment_unnamed_48)) + 1.0f.xxxx;
				fragment_unnamed_168 = _ShaderFlags * 0.5f;
				fragment_unnamed_175 = fragment_unnamed_168 >= (-fragment_unnamed_168);
				fragment_unnamed_168 = frac(abs(fragment_unnamed_168));
				float fragment_unnamed_185;
				if (fragment_unnamed_175)
				{
					fragment_unnamed_185 = fragment_unnamed_168;
				}
				else
				{
					fragment_unnamed_185 = -fragment_unnamed_168;
				}
				fragment_unnamed_168 = fragment_unnamed_185;
				fragment_unnamed_193 = fragment_unnamed_168 >= 0.5f;
				bool4 fragment_unnamed_200 = fragment_unnamed_193.xxxx;
				fragment_unnamed_9 = float4(fragment_unnamed_200.x ? fragment_unnamed_48.x : fragment_unnamed_9.x, fragment_unnamed_200.y ? fragment_unnamed_48.y : fragment_unnamed_9.y, fragment_unnamed_200.z ? fragment_unnamed_48.z : fragment_unnamed_9.z, fragment_unnamed_200.w ? fragment_unnamed_48.w : fragment_unnamed_9.w);
				fragment_unnamed_48 = fragment_unnamed_9 * 1.57079601287841796875f.xxxx;
				fragment_unnamed_48 = sin(fragment_unnamed_48);
				fragment_unnamed_48 = (-fragment_unnamed_9) + fragment_unnamed_48;
				fragment_unnamed_9 = (float4(float4(_BevelRoundness, _BevelRoundness, _BevelRoundness, _BevelRoundness)) * fragment_unnamed_48) + fragment_unnamed_9;
				fragment_unnamed_168 = (-_BevelClamp) + 1.0f;
				fragment_unnamed_9 = min(fragment_unnamed_9, fragment_unnamed_168.xxxx);
				float2 fragment_unnamed_244 = fragment_unnamed_32.xx * fragment_unnamed_9.xz;
				fragment_unnamed_9 = float4(fragment_unnamed_244.x, fragment_unnamed_9.y, fragment_unnamed_244.y, fragment_unnamed_9.w);
				float2 fragment_unnamed_255 = (fragment_unnamed_9.wy * fragment_unnamed_32.xx) + (-fragment_unnamed_9.zx);
				fragment_unnamed_9 = float4(fragment_unnamed_9.x, fragment_unnamed_255.x, fragment_unnamed_255.y, fragment_unnamed_9.w);
				fragment_unnamed_9.x = -1.0f;
				fragment_unnamed_9.w = 1.0f;
				fragment_unnamed_32.x = dot(fragment_unnamed_9.xy, fragment_unnamed_9.xy);
				fragment_unnamed_32.x = rsqrt(fragment_unnamed_32.x);
				fragment_unnamed_270 = dot(fragment_unnamed_9.zw, fragment_unnamed_9.zw);
				fragment_unnamed_270 = rsqrt(fragment_unnamed_270);
				fragment_unnamed_48.x = fragment_unnamed_270 * fragment_unnamed_9.z;
				float2 fragment_unnamed_286 = fragment_unnamed_270.xx * float2(1.0f, 0.0f);
				fragment_unnamed_48 = float4(fragment_unnamed_48.x, fragment_unnamed_286.x, fragment_unnamed_286.y, fragment_unnamed_48.w);
				fragment_unnamed_9.z = 0.0f;
				float3 fragment_unnamed_294 = fragment_unnamed_32.xxx * fragment_unnamed_9.xyz;
				fragment_unnamed_9 = float4(fragment_unnamed_294.x, fragment_unnamed_294.y, fragment_unnamed_294.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_301 = fragment_unnamed_9.xyz * fragment_unnamed_48.xyz;
				fragment_unnamed_32 = float4(fragment_unnamed_301.x, fragment_unnamed_301.y, fragment_unnamed_301.z, fragment_unnamed_32.w);
				float3 fragment_unnamed_312 = (fragment_unnamed_48.zxy * fragment_unnamed_9.yzx) + (-fragment_unnamed_32.xyz);
				fragment_unnamed_9 = float4(fragment_unnamed_312.x, fragment_unnamed_312.y, fragment_unnamed_312.z, fragment_unnamed_9.w);
				float2 fragment_unnamed_330 = (float2(_OutlineUVSpeedX, _OutlineUVSpeedY) * _Time.yy) + fragment_input_1;
				fragment_unnamed_32 = float4(fragment_unnamed_330.x, fragment_unnamed_330.y, fragment_unnamed_32.z, fragment_unnamed_32.w);
				fragment_unnamed_32 = _OutlineTex.Sample(sampler_OutlineTex, fragment_unnamed_32.xy);
				float3 fragment_unnamed_347 = fragment_unnamed_32.xyz * _OutlineColor.xyz;
				fragment_unnamed_32 = float4(fragment_unnamed_347.x, fragment_unnamed_347.y, fragment_unnamed_347.z, fragment_unnamed_32.w);
				fragment_unnamed_270 = fragment_input_7.w * _OutlineColor.w;
				fragment_unnamed_48.w = fragment_unnamed_32.w * fragment_unnamed_270;
				float3 fragment_unnamed_365 = fragment_unnamed_32.xyz * fragment_unnamed_48.www;
				fragment_unnamed_48 = float4(fragment_unnamed_365.x, fragment_unnamed_365.y, fragment_unnamed_365.z, fragment_unnamed_48.w);
				float2 fragment_unnamed_381 = (float2(_FaceUVSpeedX, _FaceUVSpeedY) * _Time.yy) + fragment_input_0.zw;
				fragment_unnamed_32 = float4(fragment_unnamed_381.x, fragment_unnamed_381.y, fragment_unnamed_32.z, fragment_unnamed_32.w);
				fragment_unnamed_32 = _FaceTex.Sample(sampler_FaceTex, fragment_unnamed_32.xy);
				fragment_unnamed_62 = fragment_input_7 * _FaceColor;
				fragment_unnamed_32 *= fragment_unnamed_62;
				float3 fragment_unnamed_404 = fragment_unnamed_32.www * fragment_unnamed_32.xyz;
				fragment_unnamed_32 = float4(fragment_unnamed_404.x, fragment_unnamed_404.y, fragment_unnamed_404.z, fragment_unnamed_32.w);
				fragment_unnamed_48 = (-fragment_unnamed_32) + fragment_unnamed_48;
				fragment_unnamed_270 = _OutlineWidth * _ScaleRatioA;
				fragment_unnamed_270 *= fragment_input_2.y;
				fragment_unnamed_62.x = min(fragment_unnamed_270, 1.0f);
				fragment_unnamed_62.x = sqrt(fragment_unnamed_62.x);
				fragment_unnamed_428 = _MainTex.Sample(sampler_MainTex, fragment_input_0.xy).w;
				fragment_unnamed_428 = (-fragment_unnamed_428) + 0.5f;
				fragment_unnamed_428 += (-fragment_input_2.x);
				fragment_unnamed_428 = (fragment_unnamed_428 * fragment_input_2.y) + 0.5f;
				fragment_unnamed_449 = (fragment_unnamed_270 * 0.5f) + fragment_unnamed_428;
				fragment_unnamed_449 = clamp(fragment_unnamed_449, 0.0f, 1.0f);
				fragment_unnamed_270 = ((-fragment_unnamed_270) * 0.5f) + fragment_unnamed_428;
				fragment_unnamed_62.x *= fragment_unnamed_449;
				fragment_unnamed_32 = (fragment_unnamed_62.xxxx * fragment_unnamed_48) + fragment_unnamed_32;
				fragment_unnamed_48.x = _OutlineSoftness * _ScaleRatioA;
				fragment_unnamed_479 = fragment_unnamed_48.x * fragment_input_2.y;
				fragment_unnamed_48.x = (fragment_unnamed_48.x * fragment_input_2.y) + 1.0f;
				fragment_unnamed_270 = (fragment_unnamed_479 * 0.5f) + fragment_unnamed_270;
				fragment_unnamed_270 /= fragment_unnamed_48.x;
				fragment_unnamed_270 = clamp(fragment_unnamed_270, 0.0f, 1.0f);
				fragment_unnamed_270 = (-fragment_unnamed_270) + 1.0f;
				fragment_unnamed_32 = fragment_unnamed_270.xxxx * fragment_unnamed_32;
				fragment_unnamed_270 = (-_BumpFace) + _BumpOutline;
				fragment_unnamed_270 = (fragment_unnamed_449 * fragment_unnamed_270) + _BumpFace;
				float3 fragment_unnamed_531 = _BumpMap.Sample(sampler_BumpMap, fragment_input_0.zw).xyw;
				fragment_unnamed_48 = float4(fragment_unnamed_531.x, fragment_unnamed_531.y, fragment_unnamed_531.z, fragment_unnamed_48.w);
				fragment_unnamed_48.x = fragment_unnamed_48.z * fragment_unnamed_48.x;
				float2 fragment_unnamed_545 = (fragment_unnamed_48.xy * 2.0f.xx) + (-1.0f).xx;
				fragment_unnamed_48 = float4(fragment_unnamed_545.x, fragment_unnamed_545.y, fragment_unnamed_48.z, fragment_unnamed_48.w);
				fragment_unnamed_548 = dot(fragment_unnamed_48.xy, fragment_unnamed_48.xy);
				fragment_unnamed_548 = min(fragment_unnamed_548, 1.0f);
				fragment_unnamed_548 = (-fragment_unnamed_548) + 1.0f;
				fragment_unnamed_48.z = sqrt(fragment_unnamed_548);
				float3 fragment_unnamed_569 = (fragment_unnamed_48.xyz * fragment_unnamed_270.xxx) + float3(-0.0f, -0.0f, -1.0f);
				fragment_unnamed_48 = float4(fragment_unnamed_569.x, fragment_unnamed_569.y, fragment_unnamed_569.z, fragment_unnamed_48.w);
				float3 fragment_unnamed_578 = (fragment_unnamed_32.www * fragment_unnamed_48.xyz) + float3(0.0f, 0.0f, 1.0f);
				fragment_unnamed_48 = float4(fragment_unnamed_578.x, fragment_unnamed_578.y, fragment_unnamed_578.z, fragment_unnamed_48.w);
				float3 fragment_unnamed_586 = fragment_unnamed_9.xyz + (-fragment_unnamed_48.xyz);
				fragment_unnamed_9 = float4(fragment_unnamed_586.x, fragment_unnamed_586.y, fragment_unnamed_586.z, fragment_unnamed_9.w);
				fragment_unnamed_270 = dot(fragment_unnamed_9.xyz, fragment_unnamed_9.xyz);
				fragment_unnamed_270 = rsqrt(fragment_unnamed_270);
				float3 fragment_unnamed_600 = fragment_unnamed_270.xxx * fragment_unnamed_9.xyz;
				fragment_unnamed_9 = float4(fragment_unnamed_600.x, fragment_unnamed_600.y, fragment_unnamed_600.z, fragment_unnamed_9.w);
				fragment_unnamed_48.x = dot(fragment_input_3, -fragment_unnamed_9.xyz);
				fragment_unnamed_48.y = dot(fragment_input_4, -fragment_unnamed_9.xyz);
				fragment_unnamed_48.z = dot(fragment_input_5, -fragment_unnamed_9.xyz);
				fragment_unnamed_9.x = dot(fragment_unnamed_48.xyz, fragment_unnamed_48.xyz);
				fragment_unnamed_9.x = rsqrt(fragment_unnamed_9.x);
				float3 fragment_unnamed_639 = fragment_unnamed_9.xxx * fragment_unnamed_48.xyz;
				fragment_unnamed_9 = float4(fragment_unnamed_639.x, fragment_unnamed_639.y, fragment_unnamed_639.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_649 = (-fragment_input_6) + _WorldSpaceLightPos0.xyz;
				fragment_unnamed_48 = float4(fragment_unnamed_649.x, fragment_unnamed_649.y, fragment_unnamed_649.z, fragment_unnamed_48.w);
				fragment_unnamed_270 = dot(fragment_unnamed_48.xyz, fragment_unnamed_48.xyz);
				fragment_unnamed_270 = rsqrt(fragment_unnamed_270);
				float3 fragment_unnamed_663 = fragment_unnamed_270.xxx * fragment_unnamed_48.xyz;
				fragment_unnamed_48 = float4(fragment_unnamed_663.x, fragment_unnamed_663.y, fragment_unnamed_663.z, fragment_unnamed_48.w);
				float3 fragment_unnamed_672 = (-fragment_input_6) + _WorldSpaceCameraPos;
				fragment_unnamed_62 = float4(fragment_unnamed_672.x, fragment_unnamed_672.y, fragment_unnamed_62.z, fragment_unnamed_672.z);
				fragment_unnamed_270 = dot(fragment_unnamed_62.xyw, fragment_unnamed_62.xyw);
				fragment_unnamed_270 = rsqrt(fragment_unnamed_270);
				float3 fragment_unnamed_689 = (fragment_unnamed_62.xyw * fragment_unnamed_270.xxx) + fragment_unnamed_48.xyz;
				fragment_unnamed_62 = float4(fragment_unnamed_689.x, fragment_unnamed_689.y, fragment_unnamed_62.z, fragment_unnamed_689.z);
				fragment_unnamed_9.w = dot(fragment_unnamed_9.xyz, fragment_unnamed_48.xyz);
				fragment_unnamed_48.x = dot(fragment_unnamed_62.xyw, fragment_unnamed_62.xyw);
				fragment_unnamed_48.x = rsqrt(fragment_unnamed_48.x);
				float3 fragment_unnamed_712 = fragment_unnamed_48.xxx * fragment_unnamed_62.xyw;
				fragment_unnamed_48 = float4(fragment_unnamed_712.x, fragment_unnamed_712.y, fragment_unnamed_712.z, fragment_unnamed_48.w);
				fragment_unnamed_9.x = dot(fragment_unnamed_9.xyz, fragment_unnamed_48.xyz);
				float2 fragment_unnamed_724 = max(fragment_unnamed_9.xw, 0.0f.xx);
				fragment_unnamed_9 = float4(fragment_unnamed_724.x, fragment_unnamed_9.y, fragment_unnamed_9.z, fragment_unnamed_724.y);
				fragment_unnamed_9.x = log2(fragment_unnamed_9.x);
				fragment_unnamed_732.x = (-_FaceShininess) + _OutlineShininess;
				fragment_unnamed_732.x = (fragment_unnamed_449 * fragment_unnamed_732.x) + _FaceShininess;
				fragment_unnamed_732.x *= 128.0f;
				fragment_unnamed_9.x *= fragment_unnamed_732.x;
				fragment_unnamed_9.x = exp2(fragment_unnamed_9.x);
				fragment_unnamed_48 = fragment_input_6.yyyy * unity_WorldToLight__array[1];
				fragment_unnamed_48 = (unity_WorldToLight__array[0] * fragment_input_6.xxxx) + fragment_unnamed_48;
				fragment_unnamed_48 = (unity_WorldToLight__array[2] * fragment_input_6.zzzz) + fragment_unnamed_48;
				fragment_unnamed_48 += unity_WorldToLight__array[3];
				fragment_unnamed_732 = fragment_unnamed_48.xy / fragment_unnamed_48.ww;
				fragment_unnamed_732 += 0.5f.xx;
				fragment_unnamed_732.x = _LightTexture0.Sample(sampler_LightTexture0, fragment_unnamed_732).w;
				fragment_unnamed_807 = 0.0f < fragment_unnamed_48.z;
				fragment_unnamed_48.x = dot(fragment_unnamed_48.xyz, fragment_unnamed_48.xyz);
				fragment_unnamed_48.x = _LightTextureB0.Sample(sampler_LightTextureB0, fragment_unnamed_48.xx).x;
				fragment_unnamed_827 = float(fragment_unnamed_807);
				fragment_unnamed_732.x *= fragment_unnamed_827;
				fragment_unnamed_732.x = fragment_unnamed_48.x * fragment_unnamed_732.x;
				float3 fragment_unnamed_846 = fragment_unnamed_732.xxx * _LightColor0.xyz;
				fragment_unnamed_48 = float4(fragment_unnamed_846.x, fragment_unnamed_846.y, fragment_unnamed_846.z, fragment_unnamed_48.w);
				float3 fragment_unnamed_855 = fragment_unnamed_48.xyz * _SpecColor.xyz;
				fragment_unnamed_62 = float4(fragment_unnamed_855.x, fragment_unnamed_855.y, fragment_unnamed_855.z, fragment_unnamed_62.w);
				float3 fragment_unnamed_862 = fragment_unnamed_9.xxx * fragment_unnamed_62.xyz;
				fragment_unnamed_9 = float4(fragment_unnamed_862.x, fragment_unnamed_862.y, fragment_unnamed_862.z, fragment_unnamed_9.w);
				fragment_unnamed_548 = max(fragment_unnamed_32.w, 9.9999997473787516355514526367188e-05f);
				float3 fragment_unnamed_873 = fragment_unnamed_32.xyz / fragment_unnamed_548.xxx;
				fragment_unnamed_32 = float4(fragment_unnamed_873.x, fragment_unnamed_873.y, fragment_unnamed_873.z, fragment_unnamed_32.w);
				fragment_output_0.w = fragment_unnamed_32.w;
				float3 fragment_unnamed_886 = fragment_unnamed_48.xyz * fragment_unnamed_32.xyz;
				fragment_unnamed_32 = float4(fragment_unnamed_886.x, fragment_unnamed_886.y, fragment_unnamed_886.z, fragment_unnamed_32.w);
				float3 fragment_unnamed_896 = (fragment_unnamed_32.xyz * fragment_unnamed_9.www) + fragment_unnamed_9.xyz;
				fragment_output_0 = float4(fragment_unnamed_896.x, fragment_unnamed_896.y, fragment_unnamed_896.z, fragment_output_0.w);
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				unity_WorldToLight__array[0] = float4(unity_WorldToLight[0][0], unity_WorldToLight[1][0], unity_WorldToLight[2][0], unity_WorldToLight[3][0]);
				unity_WorldToLight__array[1] = float4(unity_WorldToLight[0][1], unity_WorldToLight[1][1], unity_WorldToLight[2][1], unity_WorldToLight[3][1]);
				unity_WorldToLight__array[2] = float4(unity_WorldToLight[0][2], unity_WorldToLight[1][2], unity_WorldToLight[2][2], unity_WorldToLight[3][2]);
				unity_WorldToLight__array[3] = float4(unity_WorldToLight[0][3], unity_WorldToLight[1][3], unity_WorldToLight[2][3], unity_WorldToLight[3][3]);

				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_0 = stage_input.fragment_input_0;
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_7 = stage_input.fragment_input_7;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				fragment_input_6 = stage_input.fragment_input_6;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // SPOT
			#endif // !DIRECTIONAL
			#endif // !DIRECTIONAL_COOKIE
			#endif // !POINT
			#endif // !POINT_COOKIE


			#ifdef POINT_COOKIE
			#ifndef DIRECTIONAL
			#ifndef DIRECTIONAL_COOKIE
			#ifndef POINT
			#ifndef SPOT
			#define ANY_SHADER_VARIANT_ACTIVE

			float3 _WorldSpaceCameraPos;
			float4 _ScreenParams;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4 unity_WorldTransformParams;
			float4x4 glstate_matrix_projection;
			float4x4 unity_MatrixVP;
			float4x4 unity_WorldToLight;
			float _FaceDilate;
			float4x4 _EnvMatrix;
			float _WeightNormal;
			float _WeightBold;
			float _ScaleRatioA;
			float _VertexOffsetX;
			float _VertexOffsetY;
			float _GradientScale;
			float _ScaleX;
			float _ScaleY;
			float _PerspectiveFilter;
			float _Sharpness;
			float4 _MainTex_ST;
			float4 _FaceTex_ST;
			float4 _OutlineTex_ST;

			static float4 unity_ObjectToWorld__array[4];
			static float4 unity_WorldToObject__array[4];
			static float4 glstate_matrix_projection__array[4];
			static float4 unity_MatrixVP__array[4];
			static float4 unity_WorldToLight__array[4];
			static float4 _EnvMatrix__array[4];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_4;
			static float4 vertex_output_0;
			static float2 vertex_output_1;
			static float4 vertex_input_3;
			static float3 vertex_input_2;
			static float3 vertex_output_6;
			static float2 vertex_output_2;
			static float3 vertex_output_3;
			static float4 vertex_input_1;
			static float3 vertex_output_4;
			static float3 vertex_output_5;
			static float4 vertex_output_7;
			static float4 vertex_input_5;
			static float3 vertex_output_8;
			static float3 vertex_output_9;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION;
				float4 vertex_input_1 : TANGENT;
				float3 vertex_input_2 : NORMAL;
				float4 vertex_input_3 : TEXCOORD0;
				float4 vertex_input_4 : TEXCOORD1;
				float4 vertex_input_5 : COLOR;
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_0 : TEXCOORD0; // vs_TEXCOORD0
				float2 vertex_output_1 : TEXCOORD1; // vs_TEXCOORD1
				float2 vertex_output_2 : TEXCOORD6; // vs_TEXCOORD6
				float3 vertex_output_3 : TEXCOORD2; // vs_TEXCOORD2
				float3 vertex_output_4 : TEXCOORD3; // vs_TEXCOORD3
				float3 vertex_output_5 : TEXCOORD4; // vs_TEXCOORD4
				float3 vertex_output_6 : TEXCOORD5; // vs_TEXCOORD5
				float4 vertex_output_7 : UNKNOWN7;
				float3 vertex_output_8 : TEXCOORD7; // vs_TEXCOORD7
				float3 vertex_output_9 : TEXCOORD8; // vs_TEXCOORD8
				float4 gl_Position : SV_Position;
			};

			static float3 vertex_unnamed_9;
			static float4 vertex_unnamed_40;
			static float4 vertex_unnamed_64;
			static float4 vertex_unnamed_70;
			static float vertex_unnamed_106;
			static float vertex_unnamed_258;
			static float vertex_unnamed_273;
			static int vertex_unnamed_346;
			static int vertex_unnamed_355;
			static bool vertex_unnamed_469;
			static float3 vertex_unnamed_556;
			static float vertex_unnamed_569;

			void vert_main()
			{
				float2 vertex_unnamed_36 = vertex_input_0.xy + float2(_VertexOffsetX, _VertexOffsetY);
				vertex_unnamed_9 = float3(vertex_unnamed_36.x, vertex_unnamed_36.y, vertex_unnamed_9.z);
				vertex_unnamed_40 = vertex_unnamed_9.yyyy * unity_ObjectToWorld__array[1];
				vertex_unnamed_40 = (unity_ObjectToWorld__array[0] * vertex_unnamed_9.xxxx) + vertex_unnamed_40;
				vertex_unnamed_40 = (unity_ObjectToWorld__array[2] * vertex_input_0.zzzz) + vertex_unnamed_40;
				vertex_unnamed_64 = vertex_unnamed_40 + unity_ObjectToWorld__array[3];
				vertex_unnamed_70 = vertex_unnamed_64.yyyy * unity_MatrixVP__array[1];
				vertex_unnamed_70 = (unity_MatrixVP__array[0] * vertex_unnamed_64.xxxx) + vertex_unnamed_70;
				vertex_unnamed_70 = (unity_MatrixVP__array[2] * vertex_unnamed_64.zzzz) + vertex_unnamed_70;
				gl_Position = (unity_MatrixVP__array[3] * vertex_unnamed_64.wwww) + vertex_unnamed_70;
				vertex_unnamed_106 = vertex_input_4.x * 0.000244140625f;
				vertex_unnamed_70.x = floor(vertex_unnamed_106);
				vertex_unnamed_70.y = ((-vertex_unnamed_70.x) * 4096.0f) + vertex_input_4.x;
				float2 vertex_unnamed_130 = vertex_unnamed_70.xy * 0.001953125f.xx;
				vertex_unnamed_70 = float4(vertex_unnamed_130.x, vertex_unnamed_130.y, vertex_unnamed_70.z, vertex_unnamed_70.w);
				float2 vertex_unnamed_144 = (vertex_unnamed_70.xy * _FaceTex_ST.xy) + _FaceTex_ST.zw;
				vertex_output_0 = float4(vertex_output_0.x, vertex_output_0.y, vertex_unnamed_144.x, vertex_unnamed_144.y);
				vertex_output_1 = (vertex_unnamed_70.xy * _OutlineTex_ST.xy) + _OutlineTex_ST.zw;
				float2 vertex_unnamed_171 = (vertex_input_3.xy * _MainTex_ST.xy) + _MainTex_ST.zw;
				vertex_output_0 = float4(vertex_unnamed_171.x, vertex_unnamed_171.y, vertex_output_0.z, vertex_output_0.w);
				vertex_unnamed_106 = vertex_unnamed_64.y * unity_MatrixVP__array[1].w;
				vertex_unnamed_106 = (unity_MatrixVP__array[0].w * vertex_unnamed_64.x) + vertex_unnamed_106;
				vertex_unnamed_106 = (unity_MatrixVP__array[2].w * vertex_unnamed_64.z) + vertex_unnamed_106;
				vertex_unnamed_106 = (unity_MatrixVP__array[3].w * vertex_unnamed_64.w) + vertex_unnamed_106;
				float2 vertex_unnamed_209 = _ScreenParams.yy * glstate_matrix_projection__array[1].xy;
				vertex_unnamed_64 = float4(vertex_unnamed_209.x, vertex_unnamed_209.y, vertex_unnamed_64.z, vertex_unnamed_64.w);
				float2 vertex_unnamed_221 = (glstate_matrix_projection__array[0].xy * _ScreenParams.xx) + vertex_unnamed_64.xy;
				vertex_unnamed_64 = float4(vertex_unnamed_221.x, vertex_unnamed_221.y, vertex_unnamed_64.z, vertex_unnamed_64.w);
				float2 vertex_unnamed_233 = vertex_unnamed_64.xy * float2(_ScaleX, _ScaleY);
				vertex_unnamed_64 = float4(vertex_unnamed_233.x, vertex_unnamed_233.y, vertex_unnamed_64.z, vertex_unnamed_64.w);
				float2 vertex_unnamed_240 = vertex_unnamed_106.xx / vertex_unnamed_64.xy;
				vertex_unnamed_64 = float4(vertex_unnamed_240.x, vertex_unnamed_240.y, vertex_unnamed_64.z, vertex_unnamed_64.w);
				vertex_unnamed_106 = dot(vertex_unnamed_64.xy, vertex_unnamed_64.xy);
				vertex_unnamed_106 = rsqrt(vertex_unnamed_106);
				vertex_unnamed_64.x = abs(vertex_input_4.y) * _GradientScale;
				vertex_unnamed_258 = _Sharpness + 1.0f;
				vertex_unnamed_64.x = vertex_unnamed_258 * vertex_unnamed_64.x;
				vertex_unnamed_258 = vertex_unnamed_106 * vertex_unnamed_64.x;
				vertex_unnamed_273 = (-_PerspectiveFilter) + 1.0f;
				vertex_unnamed_258 = vertex_unnamed_273 * vertex_unnamed_258;
				vertex_unnamed_106 = (vertex_unnamed_106 * vertex_unnamed_64.x) + (-vertex_unnamed_258);
				float3 vertex_unnamed_296 = _WorldSpaceCameraPos.yyy * unity_WorldToObject__array[1].xyz;
				vertex_unnamed_64 = float4(vertex_unnamed_296.x, vertex_unnamed_64.y, vertex_unnamed_296.y, vertex_unnamed_296.z);
				float3 vertex_unnamed_308 = (unity_WorldToObject__array[0].xyz * _WorldSpaceCameraPos.xxx) + vertex_unnamed_64.xzw;
				vertex_unnamed_64 = float4(vertex_unnamed_308.x, vertex_unnamed_64.y, vertex_unnamed_308.y, vertex_unnamed_308.z);
				float3 vertex_unnamed_320 = (unity_WorldToObject__array[2].xyz * _WorldSpaceCameraPos.zzz) + vertex_unnamed_64.xzw;
				vertex_unnamed_64 = float4(vertex_unnamed_320.x, vertex_unnamed_64.y, vertex_unnamed_320.y, vertex_unnamed_320.z);
				float3 vertex_unnamed_328 = vertex_unnamed_64.xzw + unity_WorldToObject__array[3].xyz;
				vertex_unnamed_64 = float4(vertex_unnamed_328.x, vertex_unnamed_64.y, vertex_unnamed_328.y, vertex_unnamed_328.z);
				vertex_unnamed_9.z = vertex_input_0.z;
				vertex_unnamed_9 = (-vertex_unnamed_9) + vertex_unnamed_64.xzw;
				vertex_unnamed_9.x = dot(vertex_input_2, vertex_unnamed_9);
				vertex_unnamed_346 = int((0.0f < vertex_unnamed_9.x) ? 4294967295u : 0u);
				vertex_unnamed_355 = int((vertex_unnamed_9.x < 0.0f) ? 4294967295u : 0u);
				vertex_unnamed_355 = (-vertex_unnamed_346) + vertex_unnamed_355;
				vertex_unnamed_9.x = float(vertex_unnamed_355);
				vertex_unnamed_9 = vertex_unnamed_9.xxx * vertex_input_2;
				vertex_unnamed_70.y = dot(vertex_unnamed_9, unity_WorldToObject__array[0].xyz);
				vertex_unnamed_70.z = dot(vertex_unnamed_9, unity_WorldToObject__array[1].xyz);
				vertex_unnamed_70.x = dot(vertex_unnamed_9, unity_WorldToObject__array[2].xyz);
				vertex_unnamed_9.x = dot(vertex_unnamed_70.xyz, vertex_unnamed_70.xyz);
				vertex_unnamed_9.x = rsqrt(vertex_unnamed_9.x);
				vertex_unnamed_9 = vertex_unnamed_9.xxx * vertex_unnamed_70.xyz;
				float3 vertex_unnamed_413 = (unity_ObjectToWorld__array[3].xyz * vertex_input_0.www) + vertex_unnamed_40.xyz;
				vertex_unnamed_64 = float4(vertex_unnamed_413.x, vertex_unnamed_64.y, vertex_unnamed_413.y, vertex_unnamed_413.z);
				vertex_unnamed_40 = (unity_ObjectToWorld__array[3] * vertex_input_0.wwww) + vertex_unnamed_40;
				float3 vertex_unnamed_428 = (-vertex_unnamed_64.xzw) + _WorldSpaceCameraPos;
				vertex_unnamed_70 = float4(vertex_unnamed_428.x, vertex_unnamed_428.y, vertex_unnamed_428.z, vertex_unnamed_70.w);
				vertex_output_6 = vertex_unnamed_64.xzw;
				vertex_unnamed_64.x = dot(vertex_unnamed_70.xyz, vertex_unnamed_70.xyz);
				vertex_unnamed_64.x = rsqrt(vertex_unnamed_64.x);
				float3 vertex_unnamed_449 = vertex_unnamed_64.xxx * vertex_unnamed_70.xyz;
				vertex_unnamed_64 = float4(vertex_unnamed_449.x, vertex_unnamed_64.y, vertex_unnamed_449.y, vertex_unnamed_449.z);
				vertex_unnamed_64.x = dot(vertex_unnamed_9.yzx, vertex_unnamed_64.xzw);
				vertex_output_2.y = (abs(vertex_unnamed_64.x) * vertex_unnamed_106) + vertex_unnamed_258;
				vertex_unnamed_469 = 0.0f >= vertex_input_4.y;
				vertex_unnamed_106 = float(vertex_unnamed_469);
				vertex_unnamed_64.x = (-_WeightNormal) + _WeightBold;
				vertex_unnamed_106 = (vertex_unnamed_106 * vertex_unnamed_64.x) + _WeightNormal;
				vertex_unnamed_106 = (vertex_unnamed_106 * 0.25f) + _FaceDilate;
				vertex_unnamed_106 *= _ScaleRatioA;
				vertex_output_2.x = vertex_unnamed_106 * 0.5f;
				vertex_output_3.z = vertex_unnamed_9.y;
				float3 vertex_unnamed_517 = vertex_input_1.yyy * unity_ObjectToWorld__array[1].yzx;
				vertex_unnamed_64 = float4(vertex_unnamed_517.x, vertex_unnamed_517.y, vertex_unnamed_517.z, vertex_unnamed_64.w);
				float3 vertex_unnamed_528 = (unity_ObjectToWorld__array[0].yzx * vertex_input_1.xxx) + vertex_unnamed_64.xyz;
				vertex_unnamed_64 = float4(vertex_unnamed_528.x, vertex_unnamed_528.y, vertex_unnamed_528.z, vertex_unnamed_64.w);
				float3 vertex_unnamed_539 = (unity_ObjectToWorld__array[2].yzx * vertex_input_1.zzz) + vertex_unnamed_64.xyz;
				vertex_unnamed_64 = float4(vertex_unnamed_539.x, vertex_unnamed_539.y, vertex_unnamed_539.z, vertex_unnamed_64.w);
				vertex_unnamed_106 = dot(vertex_unnamed_64.xyz, vertex_unnamed_64.xyz);
				vertex_unnamed_106 = rsqrt(vertex_unnamed_106);
				float3 vertex_unnamed_553 = vertex_unnamed_106.xxx * vertex_unnamed_64.xyz;
				vertex_unnamed_64 = float4(vertex_unnamed_553.x, vertex_unnamed_553.y, vertex_unnamed_553.z, vertex_unnamed_64.w);
				vertex_unnamed_556 = vertex_unnamed_9 * vertex_unnamed_64.xyz;
				vertex_unnamed_556 = (vertex_unnamed_9.zxy * vertex_unnamed_64.yzx) + (-vertex_unnamed_556);
				vertex_unnamed_569 = vertex_input_1.w * unity_WorldTransformParams.w;
				vertex_unnamed_556 = vertex_unnamed_569.xxx * vertex_unnamed_556;
				vertex_output_3.y = vertex_unnamed_556.x;
				vertex_output_3.x = vertex_unnamed_64.z;
				vertex_output_4.z = vertex_unnamed_9.z;
				vertex_output_5.z = vertex_unnamed_9.x;
				vertex_output_4.x = vertex_unnamed_64.x;
				vertex_output_5.x = vertex_unnamed_64.y;
				vertex_output_4.y = vertex_unnamed_556.y;
				vertex_output_5.y = vertex_unnamed_556.z;
				vertex_output_7 = vertex_input_5;
				vertex_unnamed_9 = vertex_unnamed_70.yyy * _EnvMatrix__array[1].xyz;
				vertex_unnamed_9 = (_EnvMatrix__array[0].xyz * vertex_unnamed_70.xxx) + vertex_unnamed_9;
				vertex_output_8 = (_EnvMatrix__array[2].xyz * vertex_unnamed_70.zzz) + vertex_unnamed_9;
				vertex_unnamed_9 = vertex_unnamed_40.yyy * unity_WorldToLight__array[1].xyz;
				vertex_unnamed_9 = (unity_WorldToLight__array[0].xyz * vertex_unnamed_40.xxx) + vertex_unnamed_9;
				vertex_unnamed_9 = (unity_WorldToLight__array[2].xyz * vertex_unnamed_40.zzz) + vertex_unnamed_9;
				vertex_output_9 = (unity_WorldToLight__array[3].xyz * vertex_unnamed_40.www) + vertex_unnamed_9;
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

				unity_WorldToLight__array[0] = float4(unity_WorldToLight[0][0], unity_WorldToLight[1][0], unity_WorldToLight[2][0], unity_WorldToLight[3][0]);
				unity_WorldToLight__array[1] = float4(unity_WorldToLight[0][1], unity_WorldToLight[1][1], unity_WorldToLight[2][1], unity_WorldToLight[3][1]);
				unity_WorldToLight__array[2] = float4(unity_WorldToLight[0][2], unity_WorldToLight[1][2], unity_WorldToLight[2][2], unity_WorldToLight[3][2]);
				unity_WorldToLight__array[3] = float4(unity_WorldToLight[0][3], unity_WorldToLight[1][3], unity_WorldToLight[2][3], unity_WorldToLight[3][3]);

				_EnvMatrix__array[0] = float4(_EnvMatrix[0][0], _EnvMatrix[1][0], _EnvMatrix[2][0], _EnvMatrix[3][0]);
				_EnvMatrix__array[1] = float4(_EnvMatrix[0][1], _EnvMatrix[1][1], _EnvMatrix[2][1], _EnvMatrix[3][1]);
				_EnvMatrix__array[2] = float4(_EnvMatrix[0][2], _EnvMatrix[1][2], _EnvMatrix[2][2], _EnvMatrix[3][2]);
				_EnvMatrix__array[3] = float4(_EnvMatrix[0][3], _EnvMatrix[1][3], _EnvMatrix[2][3], _EnvMatrix[3][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_4 = stage_input.vertex_input_4;
				vertex_input_3 = stage_input.vertex_input_3;
				vertex_input_2 = stage_input.vertex_input_2;
				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_5 = stage_input.vertex_input_5;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_0 = vertex_output_0;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_6 = vertex_output_6;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
				stage_output.vertex_output_7 = vertex_output_7;
				stage_output.vertex_output_8 = vertex_output_8;
				stage_output.vertex_output_9 = vertex_output_9;
				return stage_output;
			}

			float4 _Time;
			float3 _WorldSpaceCameraPos;
			float4 _WorldSpaceLightPos0;
			float4 _LightColor0;
			float4 _SpecColor;
			float4x4 unity_WorldToLight;
			float _FaceUVSpeedX;
			float _FaceUVSpeedY;
			float4 _FaceColor;
			float _OutlineSoftness;
			float _OutlineUVSpeedX;
			float _OutlineUVSpeedY;
			float4 _OutlineColor;
			float _OutlineWidth;
			float _Bevel;
			float _BevelOffset;
			float _BevelWidth;
			float _BevelClamp;
			float _BevelRoundness;
			float _BumpOutline;
			float _BumpFace;
			float _ShaderFlags;
			float _ScaleRatioA;
			float _TextureWidth;
			float _TextureHeight;
			float _GradientScale;
			float _FaceShininess;
			float _OutlineShininess;

			static float4 unity_WorldToLight__array[4];
			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;
			Texture2D<float4> _OutlineTex;
			SamplerState sampler_OutlineTex;
			Texture2D<float4> _FaceTex;
			SamplerState sampler_FaceTex;
			Texture2D<float4> _BumpMap;
			SamplerState sampler_BumpMap;
			TextureCube<float4> _LightTexture0;
			SamplerState sampler_LightTexture0;
			Texture2D<float4> _LightTextureB0;
			SamplerState sampler_LightTextureB0;

			static float2 fragment_input_2;
			static float4 fragment_input_0;
			static float2 fragment_input_1;
			static float4 fragment_input_7;
			static float3 fragment_input_3;
			static float3 fragment_input_4;
			static float3 fragment_input_5;
			static float3 fragment_input_6;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_0 : TEXCOORD0; // vs_TEXCOORD0
				float2 fragment_input_1 : TEXCOORD1; // vs_TEXCOORD1
				float2 fragment_input_2 : TEXCOORD6; // vs_TEXCOORD6
				float3 fragment_input_3 : TEXCOORD2; // vs_TEXCOORD2
				float3 fragment_input_4 : TEXCOORD3; // vs_TEXCOORD3
				float3 fragment_input_5 : TEXCOORD4; // vs_TEXCOORD4
				float3 fragment_input_6 : TEXCOORD5; // vs_TEXCOORD5
				float4 fragment_input_7 : UNKNOWN7;
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static float4 fragment_unnamed_9;
			static float4 fragment_unnamed_32;
			static float4 fragment_unnamed_48;
			static float4 fragment_unnamed_62;
			static float fragment_unnamed_168;
			static bool fragment_unnamed_175;
			static bool fragment_unnamed_193;
			static float fragment_unnamed_270;
			static float fragment_unnamed_428;
			static float fragment_unnamed_449;
			static float fragment_unnamed_479;
			static float fragment_unnamed_548;
			static float fragment_unnamed_731;
			static float fragment_unnamed_803;

			void frag_main()
			{
				fragment_unnamed_9.x = fragment_input_2.x + _BevelOffset;
				float2 fragment_unnamed_42 = 1.0f.xx / float2(_TextureWidth, _TextureHeight);
				fragment_unnamed_32 = float4(fragment_unnamed_42.x, fragment_unnamed_42.y, fragment_unnamed_32.z, fragment_unnamed_32.w);
				fragment_unnamed_32.z = 0.0f;
				fragment_unnamed_48 = (-fragment_unnamed_32.xzzy) + fragment_input_0.xyxy;
				fragment_unnamed_32 = fragment_unnamed_32.xzzy + fragment_input_0.xyxy;
				fragment_unnamed_62.x = _MainTex.Sample(sampler_MainTex, fragment_unnamed_48.xy).w;
				fragment_unnamed_62.z = _MainTex.Sample(sampler_MainTex, fragment_unnamed_48.zw).w;
				fragment_unnamed_62.y = _MainTex.Sample(sampler_MainTex, fragment_unnamed_32.xy).w;
				fragment_unnamed_62.w = _MainTex.Sample(sampler_MainTex, fragment_unnamed_32.zw).w;
				fragment_unnamed_9 = fragment_unnamed_9.xxxx + fragment_unnamed_62;
				fragment_unnamed_9 += (-0.5f).xxxx;
				fragment_unnamed_32.x = _BevelWidth + _OutlineWidth;
				fragment_unnamed_32.x = max(fragment_unnamed_32.x, 0.00999999977648258209228515625f);
				fragment_unnamed_9 /= fragment_unnamed_32.xxxx;
				fragment_unnamed_32.x *= _Bevel;
				fragment_unnamed_32.x *= _GradientScale;
				fragment_unnamed_32.x *= (-2.0f);
				fragment_unnamed_9 += 0.5f.xxxx;
				fragment_unnamed_9 = clamp(fragment_unnamed_9, 0.0f.xxxx, 1.0f.xxxx);
				fragment_unnamed_48 = (fragment_unnamed_9 * 2.0f.xxxx) + (-1.0f).xxxx;
				fragment_unnamed_48 = (-abs(fragment_unnamed_48)) + 1.0f.xxxx;
				fragment_unnamed_168 = _ShaderFlags * 0.5f;
				fragment_unnamed_175 = fragment_unnamed_168 >= (-fragment_unnamed_168);
				fragment_unnamed_168 = frac(abs(fragment_unnamed_168));
				float fragment_unnamed_185;
				if (fragment_unnamed_175)
				{
					fragment_unnamed_185 = fragment_unnamed_168;
				}
				else
				{
					fragment_unnamed_185 = -fragment_unnamed_168;
				}
				fragment_unnamed_168 = fragment_unnamed_185;
				fragment_unnamed_193 = fragment_unnamed_168 >= 0.5f;
				bool4 fragment_unnamed_200 = fragment_unnamed_193.xxxx;
				fragment_unnamed_9 = float4(fragment_unnamed_200.x ? fragment_unnamed_48.x : fragment_unnamed_9.x, fragment_unnamed_200.y ? fragment_unnamed_48.y : fragment_unnamed_9.y, fragment_unnamed_200.z ? fragment_unnamed_48.z : fragment_unnamed_9.z, fragment_unnamed_200.w ? fragment_unnamed_48.w : fragment_unnamed_9.w);
				fragment_unnamed_48 = fragment_unnamed_9 * 1.57079601287841796875f.xxxx;
				fragment_unnamed_48 = sin(fragment_unnamed_48);
				fragment_unnamed_48 = (-fragment_unnamed_9) + fragment_unnamed_48;
				fragment_unnamed_9 = (float4(float4(_BevelRoundness, _BevelRoundness, _BevelRoundness, _BevelRoundness)) * fragment_unnamed_48) + fragment_unnamed_9;
				fragment_unnamed_168 = (-_BevelClamp) + 1.0f;
				fragment_unnamed_9 = min(fragment_unnamed_9, fragment_unnamed_168.xxxx);
				float2 fragment_unnamed_244 = fragment_unnamed_32.xx * fragment_unnamed_9.xz;
				fragment_unnamed_9 = float4(fragment_unnamed_244.x, fragment_unnamed_9.y, fragment_unnamed_244.y, fragment_unnamed_9.w);
				float2 fragment_unnamed_255 = (fragment_unnamed_9.wy * fragment_unnamed_32.xx) + (-fragment_unnamed_9.zx);
				fragment_unnamed_9 = float4(fragment_unnamed_9.x, fragment_unnamed_255.x, fragment_unnamed_255.y, fragment_unnamed_9.w);
				fragment_unnamed_9.x = -1.0f;
				fragment_unnamed_9.w = 1.0f;
				fragment_unnamed_32.x = dot(fragment_unnamed_9.xy, fragment_unnamed_9.xy);
				fragment_unnamed_32.x = rsqrt(fragment_unnamed_32.x);
				fragment_unnamed_270 = dot(fragment_unnamed_9.zw, fragment_unnamed_9.zw);
				fragment_unnamed_270 = rsqrt(fragment_unnamed_270);
				fragment_unnamed_48.x = fragment_unnamed_270 * fragment_unnamed_9.z;
				float2 fragment_unnamed_286 = fragment_unnamed_270.xx * float2(1.0f, 0.0f);
				fragment_unnamed_48 = float4(fragment_unnamed_48.x, fragment_unnamed_286.x, fragment_unnamed_286.y, fragment_unnamed_48.w);
				fragment_unnamed_9.z = 0.0f;
				float3 fragment_unnamed_294 = fragment_unnamed_32.xxx * fragment_unnamed_9.xyz;
				fragment_unnamed_9 = float4(fragment_unnamed_294.x, fragment_unnamed_294.y, fragment_unnamed_294.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_301 = fragment_unnamed_9.xyz * fragment_unnamed_48.xyz;
				fragment_unnamed_32 = float4(fragment_unnamed_301.x, fragment_unnamed_301.y, fragment_unnamed_301.z, fragment_unnamed_32.w);
				float3 fragment_unnamed_312 = (fragment_unnamed_48.zxy * fragment_unnamed_9.yzx) + (-fragment_unnamed_32.xyz);
				fragment_unnamed_9 = float4(fragment_unnamed_312.x, fragment_unnamed_312.y, fragment_unnamed_312.z, fragment_unnamed_9.w);
				float2 fragment_unnamed_330 = (float2(_OutlineUVSpeedX, _OutlineUVSpeedY) * _Time.yy) + fragment_input_1;
				fragment_unnamed_32 = float4(fragment_unnamed_330.x, fragment_unnamed_330.y, fragment_unnamed_32.z, fragment_unnamed_32.w);
				fragment_unnamed_32 = _OutlineTex.Sample(sampler_OutlineTex, fragment_unnamed_32.xy);
				float3 fragment_unnamed_347 = fragment_unnamed_32.xyz * _OutlineColor.xyz;
				fragment_unnamed_32 = float4(fragment_unnamed_347.x, fragment_unnamed_347.y, fragment_unnamed_347.z, fragment_unnamed_32.w);
				fragment_unnamed_270 = fragment_input_7.w * _OutlineColor.w;
				fragment_unnamed_48.w = fragment_unnamed_32.w * fragment_unnamed_270;
				float3 fragment_unnamed_365 = fragment_unnamed_32.xyz * fragment_unnamed_48.www;
				fragment_unnamed_48 = float4(fragment_unnamed_365.x, fragment_unnamed_365.y, fragment_unnamed_365.z, fragment_unnamed_48.w);
				float2 fragment_unnamed_381 = (float2(_FaceUVSpeedX, _FaceUVSpeedY) * _Time.yy) + fragment_input_0.zw;
				fragment_unnamed_32 = float4(fragment_unnamed_381.x, fragment_unnamed_381.y, fragment_unnamed_32.z, fragment_unnamed_32.w);
				fragment_unnamed_32 = _FaceTex.Sample(sampler_FaceTex, fragment_unnamed_32.xy);
				fragment_unnamed_62 = fragment_input_7 * _FaceColor;
				fragment_unnamed_32 *= fragment_unnamed_62;
				float3 fragment_unnamed_404 = fragment_unnamed_32.www * fragment_unnamed_32.xyz;
				fragment_unnamed_32 = float4(fragment_unnamed_404.x, fragment_unnamed_404.y, fragment_unnamed_404.z, fragment_unnamed_32.w);
				fragment_unnamed_48 = (-fragment_unnamed_32) + fragment_unnamed_48;
				fragment_unnamed_270 = _OutlineWidth * _ScaleRatioA;
				fragment_unnamed_270 *= fragment_input_2.y;
				fragment_unnamed_62.x = min(fragment_unnamed_270, 1.0f);
				fragment_unnamed_62.x = sqrt(fragment_unnamed_62.x);
				fragment_unnamed_428 = _MainTex.Sample(sampler_MainTex, fragment_input_0.xy).w;
				fragment_unnamed_428 = (-fragment_unnamed_428) + 0.5f;
				fragment_unnamed_428 += (-fragment_input_2.x);
				fragment_unnamed_428 = (fragment_unnamed_428 * fragment_input_2.y) + 0.5f;
				fragment_unnamed_449 = (fragment_unnamed_270 * 0.5f) + fragment_unnamed_428;
				fragment_unnamed_449 = clamp(fragment_unnamed_449, 0.0f, 1.0f);
				fragment_unnamed_270 = ((-fragment_unnamed_270) * 0.5f) + fragment_unnamed_428;
				fragment_unnamed_62.x *= fragment_unnamed_449;
				fragment_unnamed_32 = (fragment_unnamed_62.xxxx * fragment_unnamed_48) + fragment_unnamed_32;
				fragment_unnamed_48.x = _OutlineSoftness * _ScaleRatioA;
				fragment_unnamed_479 = fragment_unnamed_48.x * fragment_input_2.y;
				fragment_unnamed_48.x = (fragment_unnamed_48.x * fragment_input_2.y) + 1.0f;
				fragment_unnamed_270 = (fragment_unnamed_479 * 0.5f) + fragment_unnamed_270;
				fragment_unnamed_270 /= fragment_unnamed_48.x;
				fragment_unnamed_270 = clamp(fragment_unnamed_270, 0.0f, 1.0f);
				fragment_unnamed_270 = (-fragment_unnamed_270) + 1.0f;
				fragment_unnamed_32 = fragment_unnamed_270.xxxx * fragment_unnamed_32;
				fragment_unnamed_270 = (-_BumpFace) + _BumpOutline;
				fragment_unnamed_270 = (fragment_unnamed_449 * fragment_unnamed_270) + _BumpFace;
				float3 fragment_unnamed_531 = _BumpMap.Sample(sampler_BumpMap, fragment_input_0.zw).xyw;
				fragment_unnamed_48 = float4(fragment_unnamed_531.x, fragment_unnamed_531.y, fragment_unnamed_531.z, fragment_unnamed_48.w);
				fragment_unnamed_48.x = fragment_unnamed_48.z * fragment_unnamed_48.x;
				float2 fragment_unnamed_545 = (fragment_unnamed_48.xy * 2.0f.xx) + (-1.0f).xx;
				fragment_unnamed_48 = float4(fragment_unnamed_545.x, fragment_unnamed_545.y, fragment_unnamed_48.z, fragment_unnamed_48.w);
				fragment_unnamed_548 = dot(fragment_unnamed_48.xy, fragment_unnamed_48.xy);
				fragment_unnamed_548 = min(fragment_unnamed_548, 1.0f);
				fragment_unnamed_548 = (-fragment_unnamed_548) + 1.0f;
				fragment_unnamed_48.z = sqrt(fragment_unnamed_548);
				float3 fragment_unnamed_569 = (fragment_unnamed_48.xyz * fragment_unnamed_270.xxx) + float3(-0.0f, -0.0f, -1.0f);
				fragment_unnamed_48 = float4(fragment_unnamed_569.x, fragment_unnamed_569.y, fragment_unnamed_569.z, fragment_unnamed_48.w);
				float3 fragment_unnamed_578 = (fragment_unnamed_32.www * fragment_unnamed_48.xyz) + float3(0.0f, 0.0f, 1.0f);
				fragment_unnamed_48 = float4(fragment_unnamed_578.x, fragment_unnamed_578.y, fragment_unnamed_578.z, fragment_unnamed_48.w);
				float3 fragment_unnamed_586 = fragment_unnamed_9.xyz + (-fragment_unnamed_48.xyz);
				fragment_unnamed_9 = float4(fragment_unnamed_586.x, fragment_unnamed_586.y, fragment_unnamed_586.z, fragment_unnamed_9.w);
				fragment_unnamed_270 = dot(fragment_unnamed_9.xyz, fragment_unnamed_9.xyz);
				fragment_unnamed_270 = rsqrt(fragment_unnamed_270);
				float3 fragment_unnamed_600 = fragment_unnamed_270.xxx * fragment_unnamed_9.xyz;
				fragment_unnamed_9 = float4(fragment_unnamed_600.x, fragment_unnamed_600.y, fragment_unnamed_600.z, fragment_unnamed_9.w);
				fragment_unnamed_48.x = dot(fragment_input_3, -fragment_unnamed_9.xyz);
				fragment_unnamed_48.y = dot(fragment_input_4, -fragment_unnamed_9.xyz);
				fragment_unnamed_48.z = dot(fragment_input_5, -fragment_unnamed_9.xyz);
				fragment_unnamed_9.x = dot(fragment_unnamed_48.xyz, fragment_unnamed_48.xyz);
				fragment_unnamed_9.x = rsqrt(fragment_unnamed_9.x);
				float3 fragment_unnamed_639 = fragment_unnamed_9.xxx * fragment_unnamed_48.xyz;
				fragment_unnamed_9 = float4(fragment_unnamed_639.x, fragment_unnamed_639.y, fragment_unnamed_639.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_649 = (-fragment_input_6) + _WorldSpaceLightPos0.xyz;
				fragment_unnamed_48 = float4(fragment_unnamed_649.x, fragment_unnamed_649.y, fragment_unnamed_649.z, fragment_unnamed_48.w);
				fragment_unnamed_270 = dot(fragment_unnamed_48.xyz, fragment_unnamed_48.xyz);
				fragment_unnamed_270 = rsqrt(fragment_unnamed_270);
				float3 fragment_unnamed_663 = fragment_unnamed_270.xxx * fragment_unnamed_48.xyz;
				fragment_unnamed_48 = float4(fragment_unnamed_663.x, fragment_unnamed_663.y, fragment_unnamed_663.z, fragment_unnamed_48.w);
				float3 fragment_unnamed_672 = (-fragment_input_6) + _WorldSpaceCameraPos;
				fragment_unnamed_62 = float4(fragment_unnamed_672.x, fragment_unnamed_672.y, fragment_unnamed_62.z, fragment_unnamed_672.z);
				fragment_unnamed_270 = dot(fragment_unnamed_62.xyw, fragment_unnamed_62.xyw);
				fragment_unnamed_270 = rsqrt(fragment_unnamed_270);
				float3 fragment_unnamed_689 = (fragment_unnamed_62.xyw * fragment_unnamed_270.xxx) + fragment_unnamed_48.xyz;
				fragment_unnamed_62 = float4(fragment_unnamed_689.x, fragment_unnamed_689.y, fragment_unnamed_62.z, fragment_unnamed_689.z);
				fragment_unnamed_9.w = dot(fragment_unnamed_9.xyz, fragment_unnamed_48.xyz);
				fragment_unnamed_48.x = dot(fragment_unnamed_62.xyw, fragment_unnamed_62.xyw);
				fragment_unnamed_48.x = rsqrt(fragment_unnamed_48.x);
				float3 fragment_unnamed_712 = fragment_unnamed_48.xxx * fragment_unnamed_62.xyw;
				fragment_unnamed_48 = float4(fragment_unnamed_712.x, fragment_unnamed_712.y, fragment_unnamed_712.z, fragment_unnamed_48.w);
				fragment_unnamed_9.x = dot(fragment_unnamed_9.xyz, fragment_unnamed_48.xyz);
				float2 fragment_unnamed_724 = max(fragment_unnamed_9.xw, 0.0f.xx);
				fragment_unnamed_9 = float4(fragment_unnamed_724.x, fragment_unnamed_9.y, fragment_unnamed_9.z, fragment_unnamed_724.y);
				fragment_unnamed_9.x = log2(fragment_unnamed_9.x);
				fragment_unnamed_731 = (-_FaceShininess) + _OutlineShininess;
				fragment_unnamed_731 = (fragment_unnamed_449 * fragment_unnamed_731) + _FaceShininess;
				fragment_unnamed_731 *= 128.0f;
				fragment_unnamed_9.x *= fragment_unnamed_731;
				fragment_unnamed_9.x = exp2(fragment_unnamed_9.x);
				float3 fragment_unnamed_764 = fragment_input_6.yyy * unity_WorldToLight__array[1].xyz;
				fragment_unnamed_48 = float4(fragment_unnamed_764.x, fragment_unnamed_764.y, fragment_unnamed_764.z, fragment_unnamed_48.w);
				float3 fragment_unnamed_775 = (unity_WorldToLight__array[0].xyz * fragment_input_6.xxx) + fragment_unnamed_48.xyz;
				fragment_unnamed_48 = float4(fragment_unnamed_775.x, fragment_unnamed_775.y, fragment_unnamed_775.z, fragment_unnamed_48.w);
				float3 fragment_unnamed_786 = (unity_WorldToLight__array[2].xyz * fragment_input_6.zzz) + fragment_unnamed_48.xyz;
				fragment_unnamed_48 = float4(fragment_unnamed_786.x, fragment_unnamed_786.y, fragment_unnamed_786.z, fragment_unnamed_48.w);
				float3 fragment_unnamed_795 = fragment_unnamed_48.xyz + unity_WorldToLight__array[3].xyz;
				fragment_unnamed_48 = float4(fragment_unnamed_795.x, fragment_unnamed_795.y, fragment_unnamed_795.z, fragment_unnamed_48.w);
				fragment_unnamed_731 = dot(fragment_unnamed_48.xyz, fragment_unnamed_48.xyz);
				fragment_unnamed_803 = _LightTexture0.Sample(sampler_LightTexture0, fragment_unnamed_48.xyz).w;
				fragment_unnamed_731 = _LightTextureB0.Sample(sampler_LightTextureB0, fragment_unnamed_731.xx).x;
				fragment_unnamed_731 = fragment_unnamed_803 * fragment_unnamed_731;
				float3 fragment_unnamed_833 = fragment_unnamed_731.xxx * _LightColor0.xyz;
				fragment_unnamed_48 = float4(fragment_unnamed_833.x, fragment_unnamed_833.y, fragment_unnamed_833.z, fragment_unnamed_48.w);
				float3 fragment_unnamed_842 = fragment_unnamed_48.xyz * _SpecColor.xyz;
				fragment_unnamed_62 = float4(fragment_unnamed_842.x, fragment_unnamed_842.y, fragment_unnamed_842.z, fragment_unnamed_62.w);
				float3 fragment_unnamed_849 = fragment_unnamed_9.xxx * fragment_unnamed_62.xyz;
				fragment_unnamed_9 = float4(fragment_unnamed_849.x, fragment_unnamed_849.y, fragment_unnamed_849.z, fragment_unnamed_9.w);
				fragment_unnamed_548 = max(fragment_unnamed_32.w, 9.9999997473787516355514526367188e-05f);
				float3 fragment_unnamed_860 = fragment_unnamed_32.xyz / fragment_unnamed_548.xxx;
				fragment_unnamed_32 = float4(fragment_unnamed_860.x, fragment_unnamed_860.y, fragment_unnamed_860.z, fragment_unnamed_32.w);
				fragment_output_0.w = fragment_unnamed_32.w;
				float3 fragment_unnamed_873 = fragment_unnamed_48.xyz * fragment_unnamed_32.xyz;
				fragment_unnamed_32 = float4(fragment_unnamed_873.x, fragment_unnamed_873.y, fragment_unnamed_873.z, fragment_unnamed_32.w);
				float3 fragment_unnamed_883 = (fragment_unnamed_32.xyz * fragment_unnamed_9.www) + fragment_unnamed_9.xyz;
				fragment_output_0 = float4(fragment_unnamed_883.x, fragment_unnamed_883.y, fragment_unnamed_883.z, fragment_output_0.w);
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				unity_WorldToLight__array[0] = float4(unity_WorldToLight[0][0], unity_WorldToLight[1][0], unity_WorldToLight[2][0], unity_WorldToLight[3][0]);
				unity_WorldToLight__array[1] = float4(unity_WorldToLight[0][1], unity_WorldToLight[1][1], unity_WorldToLight[2][1], unity_WorldToLight[3][1]);
				unity_WorldToLight__array[2] = float4(unity_WorldToLight[0][2], unity_WorldToLight[1][2], unity_WorldToLight[2][2], unity_WorldToLight[3][2]);
				unity_WorldToLight__array[3] = float4(unity_WorldToLight[0][3], unity_WorldToLight[1][3], unity_WorldToLight[2][3], unity_WorldToLight[3][3]);

				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_0 = stage_input.fragment_input_0;
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_7 = stage_input.fragment_input_7;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				fragment_input_6 = stage_input.fragment_input_6;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // POINT_COOKIE
			#endif // !DIRECTIONAL
			#endif // !DIRECTIONAL_COOKIE
			#endif // !POINT
			#endif // !SPOT


			#ifdef DIRECTIONAL_COOKIE
			#ifndef DIRECTIONAL
			#ifndef POINT
			#ifndef POINT_COOKIE
			#ifndef SPOT
			#define ANY_SHADER_VARIANT_ACTIVE

			float3 _WorldSpaceCameraPos;
			float4 _ScreenParams;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4 unity_WorldTransformParams;
			float4x4 glstate_matrix_projection;
			float4x4 unity_MatrixVP;
			float4x4 unity_WorldToLight;
			float _FaceDilate;
			float4x4 _EnvMatrix;
			float _WeightNormal;
			float _WeightBold;
			float _ScaleRatioA;
			float _VertexOffsetX;
			float _VertexOffsetY;
			float _GradientScale;
			float _ScaleX;
			float _ScaleY;
			float _PerspectiveFilter;
			float _Sharpness;
			float4 _MainTex_ST;
			float4 _FaceTex_ST;
			float4 _OutlineTex_ST;

			static float4 unity_ObjectToWorld__array[4];
			static float4 unity_WorldToObject__array[4];
			static float4 glstate_matrix_projection__array[4];
			static float4 unity_MatrixVP__array[4];
			static float4 unity_WorldToLight__array[4];
			static float4 _EnvMatrix__array[4];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_4;
			static float4 vertex_output_0;
			static float2 vertex_output_1;
			static float4 vertex_input_3;
			static float3 vertex_input_2;
			static float3 vertex_output_6;
			static float2 vertex_output_2;
			static float3 vertex_output_3;
			static float4 vertex_input_1;
			static float3 vertex_output_4;
			static float3 vertex_output_5;
			static float4 vertex_output_7;
			static float4 vertex_input_5;
			static float3 vertex_output_8;
			static float2 vertex_output_9;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION;
				float4 vertex_input_1 : TANGENT;
				float3 vertex_input_2 : NORMAL;
				float4 vertex_input_3 : TEXCOORD0;
				float4 vertex_input_4 : TEXCOORD1;
				float4 vertex_input_5 : COLOR;
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_0 : TEXCOORD0; // vs_TEXCOORD0
				float2 vertex_output_1 : TEXCOORD1; // vs_TEXCOORD1
				float2 vertex_output_2 : TEXCOORD6; // vs_TEXCOORD6
				float3 vertex_output_3 : TEXCOORD2; // vs_TEXCOORD2
				float3 vertex_output_4 : TEXCOORD3; // vs_TEXCOORD3
				float3 vertex_output_5 : TEXCOORD4; // vs_TEXCOORD4
				float3 vertex_output_6 : TEXCOORD5; // vs_TEXCOORD5
				float4 vertex_output_7 : UNKNOWN7;
				float3 vertex_output_8 : TEXCOORD7; // vs_TEXCOORD7
				float2 vertex_output_9 : TEXCOORD8; // vs_TEXCOORD8
				float4 gl_Position : SV_Position;
			};

			static float3 vertex_unnamed_9;
			static float4 vertex_unnamed_40;
			static float4 vertex_unnamed_64;
			static float4 vertex_unnamed_70;
			static float vertex_unnamed_106;
			static float vertex_unnamed_258;
			static float vertex_unnamed_273;
			static int vertex_unnamed_346;
			static int vertex_unnamed_355;
			static bool vertex_unnamed_469;
			static float3 vertex_unnamed_556;
			static float vertex_unnamed_569;

			void vert_main()
			{
				float2 vertex_unnamed_36 = vertex_input_0.xy + float2(_VertexOffsetX, _VertexOffsetY);
				vertex_unnamed_9 = float3(vertex_unnamed_36.x, vertex_unnamed_36.y, vertex_unnamed_9.z);
				vertex_unnamed_40 = vertex_unnamed_9.yyyy * unity_ObjectToWorld__array[1];
				vertex_unnamed_40 = (unity_ObjectToWorld__array[0] * vertex_unnamed_9.xxxx) + vertex_unnamed_40;
				vertex_unnamed_40 = (unity_ObjectToWorld__array[2] * vertex_input_0.zzzz) + vertex_unnamed_40;
				vertex_unnamed_64 = vertex_unnamed_40 + unity_ObjectToWorld__array[3];
				vertex_unnamed_70 = vertex_unnamed_64.yyyy * unity_MatrixVP__array[1];
				vertex_unnamed_70 = (unity_MatrixVP__array[0] * vertex_unnamed_64.xxxx) + vertex_unnamed_70;
				vertex_unnamed_70 = (unity_MatrixVP__array[2] * vertex_unnamed_64.zzzz) + vertex_unnamed_70;
				gl_Position = (unity_MatrixVP__array[3] * vertex_unnamed_64.wwww) + vertex_unnamed_70;
				vertex_unnamed_106 = vertex_input_4.x * 0.000244140625f;
				vertex_unnamed_70.x = floor(vertex_unnamed_106);
				vertex_unnamed_70.y = ((-vertex_unnamed_70.x) * 4096.0f) + vertex_input_4.x;
				float2 vertex_unnamed_130 = vertex_unnamed_70.xy * 0.001953125f.xx;
				vertex_unnamed_70 = float4(vertex_unnamed_130.x, vertex_unnamed_130.y, vertex_unnamed_70.z, vertex_unnamed_70.w);
				float2 vertex_unnamed_144 = (vertex_unnamed_70.xy * _FaceTex_ST.xy) + _FaceTex_ST.zw;
				vertex_output_0 = float4(vertex_output_0.x, vertex_output_0.y, vertex_unnamed_144.x, vertex_unnamed_144.y);
				vertex_output_1 = (vertex_unnamed_70.xy * _OutlineTex_ST.xy) + _OutlineTex_ST.zw;
				float2 vertex_unnamed_171 = (vertex_input_3.xy * _MainTex_ST.xy) + _MainTex_ST.zw;
				vertex_output_0 = float4(vertex_unnamed_171.x, vertex_unnamed_171.y, vertex_output_0.z, vertex_output_0.w);
				vertex_unnamed_106 = vertex_unnamed_64.y * unity_MatrixVP__array[1].w;
				vertex_unnamed_106 = (unity_MatrixVP__array[0].w * vertex_unnamed_64.x) + vertex_unnamed_106;
				vertex_unnamed_106 = (unity_MatrixVP__array[2].w * vertex_unnamed_64.z) + vertex_unnamed_106;
				vertex_unnamed_106 = (unity_MatrixVP__array[3].w * vertex_unnamed_64.w) + vertex_unnamed_106;
				float2 vertex_unnamed_209 = _ScreenParams.yy * glstate_matrix_projection__array[1].xy;
				vertex_unnamed_64 = float4(vertex_unnamed_209.x, vertex_unnamed_209.y, vertex_unnamed_64.z, vertex_unnamed_64.w);
				float2 vertex_unnamed_221 = (glstate_matrix_projection__array[0].xy * _ScreenParams.xx) + vertex_unnamed_64.xy;
				vertex_unnamed_64 = float4(vertex_unnamed_221.x, vertex_unnamed_221.y, vertex_unnamed_64.z, vertex_unnamed_64.w);
				float2 vertex_unnamed_233 = vertex_unnamed_64.xy * float2(_ScaleX, _ScaleY);
				vertex_unnamed_64 = float4(vertex_unnamed_233.x, vertex_unnamed_233.y, vertex_unnamed_64.z, vertex_unnamed_64.w);
				float2 vertex_unnamed_240 = vertex_unnamed_106.xx / vertex_unnamed_64.xy;
				vertex_unnamed_64 = float4(vertex_unnamed_240.x, vertex_unnamed_240.y, vertex_unnamed_64.z, vertex_unnamed_64.w);
				vertex_unnamed_106 = dot(vertex_unnamed_64.xy, vertex_unnamed_64.xy);
				vertex_unnamed_106 = rsqrt(vertex_unnamed_106);
				vertex_unnamed_64.x = abs(vertex_input_4.y) * _GradientScale;
				vertex_unnamed_258 = _Sharpness + 1.0f;
				vertex_unnamed_64.x = vertex_unnamed_258 * vertex_unnamed_64.x;
				vertex_unnamed_258 = vertex_unnamed_106 * vertex_unnamed_64.x;
				vertex_unnamed_273 = (-_PerspectiveFilter) + 1.0f;
				vertex_unnamed_258 = vertex_unnamed_273 * vertex_unnamed_258;
				vertex_unnamed_106 = (vertex_unnamed_106 * vertex_unnamed_64.x) + (-vertex_unnamed_258);
				float3 vertex_unnamed_296 = _WorldSpaceCameraPos.yyy * unity_WorldToObject__array[1].xyz;
				vertex_unnamed_64 = float4(vertex_unnamed_296.x, vertex_unnamed_64.y, vertex_unnamed_296.y, vertex_unnamed_296.z);
				float3 vertex_unnamed_308 = (unity_WorldToObject__array[0].xyz * _WorldSpaceCameraPos.xxx) + vertex_unnamed_64.xzw;
				vertex_unnamed_64 = float4(vertex_unnamed_308.x, vertex_unnamed_64.y, vertex_unnamed_308.y, vertex_unnamed_308.z);
				float3 vertex_unnamed_320 = (unity_WorldToObject__array[2].xyz * _WorldSpaceCameraPos.zzz) + vertex_unnamed_64.xzw;
				vertex_unnamed_64 = float4(vertex_unnamed_320.x, vertex_unnamed_64.y, vertex_unnamed_320.y, vertex_unnamed_320.z);
				float3 vertex_unnamed_328 = vertex_unnamed_64.xzw + unity_WorldToObject__array[3].xyz;
				vertex_unnamed_64 = float4(vertex_unnamed_328.x, vertex_unnamed_64.y, vertex_unnamed_328.y, vertex_unnamed_328.z);
				vertex_unnamed_9.z = vertex_input_0.z;
				vertex_unnamed_9 = (-vertex_unnamed_9) + vertex_unnamed_64.xzw;
				vertex_unnamed_9.x = dot(vertex_input_2, vertex_unnamed_9);
				vertex_unnamed_346 = int((0.0f < vertex_unnamed_9.x) ? 4294967295u : 0u);
				vertex_unnamed_355 = int((vertex_unnamed_9.x < 0.0f) ? 4294967295u : 0u);
				vertex_unnamed_355 = (-vertex_unnamed_346) + vertex_unnamed_355;
				vertex_unnamed_9.x = float(vertex_unnamed_355);
				vertex_unnamed_9 = vertex_unnamed_9.xxx * vertex_input_2;
				vertex_unnamed_70.y = dot(vertex_unnamed_9, unity_WorldToObject__array[0].xyz);
				vertex_unnamed_70.z = dot(vertex_unnamed_9, unity_WorldToObject__array[1].xyz);
				vertex_unnamed_70.x = dot(vertex_unnamed_9, unity_WorldToObject__array[2].xyz);
				vertex_unnamed_9.x = dot(vertex_unnamed_70.xyz, vertex_unnamed_70.xyz);
				vertex_unnamed_9.x = rsqrt(vertex_unnamed_9.x);
				vertex_unnamed_9 = vertex_unnamed_9.xxx * vertex_unnamed_70.xyz;
				float3 vertex_unnamed_413 = (unity_ObjectToWorld__array[3].xyz * vertex_input_0.www) + vertex_unnamed_40.xyz;
				vertex_unnamed_64 = float4(vertex_unnamed_413.x, vertex_unnamed_64.y, vertex_unnamed_413.y, vertex_unnamed_413.z);
				vertex_unnamed_40 = (unity_ObjectToWorld__array[3] * vertex_input_0.wwww) + vertex_unnamed_40;
				float3 vertex_unnamed_428 = (-vertex_unnamed_64.xzw) + _WorldSpaceCameraPos;
				vertex_unnamed_70 = float4(vertex_unnamed_428.x, vertex_unnamed_428.y, vertex_unnamed_428.z, vertex_unnamed_70.w);
				vertex_output_6 = vertex_unnamed_64.xzw;
				vertex_unnamed_64.x = dot(vertex_unnamed_70.xyz, vertex_unnamed_70.xyz);
				vertex_unnamed_64.x = rsqrt(vertex_unnamed_64.x);
				float3 vertex_unnamed_449 = vertex_unnamed_64.xxx * vertex_unnamed_70.xyz;
				vertex_unnamed_64 = float4(vertex_unnamed_449.x, vertex_unnamed_64.y, vertex_unnamed_449.y, vertex_unnamed_449.z);
				vertex_unnamed_64.x = dot(vertex_unnamed_9.yzx, vertex_unnamed_64.xzw);
				vertex_output_2.y = (abs(vertex_unnamed_64.x) * vertex_unnamed_106) + vertex_unnamed_258;
				vertex_unnamed_469 = 0.0f >= vertex_input_4.y;
				vertex_unnamed_106 = float(vertex_unnamed_469);
				vertex_unnamed_64.x = (-_WeightNormal) + _WeightBold;
				vertex_unnamed_106 = (vertex_unnamed_106 * vertex_unnamed_64.x) + _WeightNormal;
				vertex_unnamed_106 = (vertex_unnamed_106 * 0.25f) + _FaceDilate;
				vertex_unnamed_106 *= _ScaleRatioA;
				vertex_output_2.x = vertex_unnamed_106 * 0.5f;
				vertex_output_3.z = vertex_unnamed_9.y;
				float3 vertex_unnamed_517 = vertex_input_1.yyy * unity_ObjectToWorld__array[1].yzx;
				vertex_unnamed_64 = float4(vertex_unnamed_517.x, vertex_unnamed_517.y, vertex_unnamed_517.z, vertex_unnamed_64.w);
				float3 vertex_unnamed_528 = (unity_ObjectToWorld__array[0].yzx * vertex_input_1.xxx) + vertex_unnamed_64.xyz;
				vertex_unnamed_64 = float4(vertex_unnamed_528.x, vertex_unnamed_528.y, vertex_unnamed_528.z, vertex_unnamed_64.w);
				float3 vertex_unnamed_539 = (unity_ObjectToWorld__array[2].yzx * vertex_input_1.zzz) + vertex_unnamed_64.xyz;
				vertex_unnamed_64 = float4(vertex_unnamed_539.x, vertex_unnamed_539.y, vertex_unnamed_539.z, vertex_unnamed_64.w);
				vertex_unnamed_106 = dot(vertex_unnamed_64.xyz, vertex_unnamed_64.xyz);
				vertex_unnamed_106 = rsqrt(vertex_unnamed_106);
				float3 vertex_unnamed_553 = vertex_unnamed_106.xxx * vertex_unnamed_64.xyz;
				vertex_unnamed_64 = float4(vertex_unnamed_553.x, vertex_unnamed_553.y, vertex_unnamed_553.z, vertex_unnamed_64.w);
				vertex_unnamed_556 = vertex_unnamed_9 * vertex_unnamed_64.xyz;
				vertex_unnamed_556 = (vertex_unnamed_9.zxy * vertex_unnamed_64.yzx) + (-vertex_unnamed_556);
				vertex_unnamed_569 = vertex_input_1.w * unity_WorldTransformParams.w;
				vertex_unnamed_556 = vertex_unnamed_569.xxx * vertex_unnamed_556;
				vertex_output_3.y = vertex_unnamed_556.x;
				vertex_output_3.x = vertex_unnamed_64.z;
				vertex_output_4.z = vertex_unnamed_9.z;
				vertex_output_5.z = vertex_unnamed_9.x;
				vertex_output_4.x = vertex_unnamed_64.x;
				vertex_output_5.x = vertex_unnamed_64.y;
				vertex_output_4.y = vertex_unnamed_556.y;
				vertex_output_5.y = vertex_unnamed_556.z;
				vertex_output_7 = vertex_input_5;
				vertex_unnamed_9 = vertex_unnamed_70.yyy * _EnvMatrix__array[1].xyz;
				vertex_unnamed_9 = (_EnvMatrix__array[0].xyz * vertex_unnamed_70.xxx) + vertex_unnamed_9;
				vertex_output_8 = (_EnvMatrix__array[2].xyz * vertex_unnamed_70.zzz) + vertex_unnamed_9;
				float2 vertex_unnamed_639 = vertex_unnamed_40.yy * unity_WorldToLight__array[1].xy;
				vertex_unnamed_9 = float3(vertex_unnamed_639.x, vertex_unnamed_639.y, vertex_unnamed_9.z);
				float2 vertex_unnamed_650 = (unity_WorldToLight__array[0].xy * vertex_unnamed_40.xx) + vertex_unnamed_9.xy;
				vertex_unnamed_9 = float3(vertex_unnamed_650.x, vertex_unnamed_650.y, vertex_unnamed_9.z);
				float2 vertex_unnamed_661 = (unity_WorldToLight__array[2].xy * vertex_unnamed_40.zz) + vertex_unnamed_9.xy;
				vertex_unnamed_9 = float3(vertex_unnamed_661.x, vertex_unnamed_661.y, vertex_unnamed_9.z);
				vertex_output_9 = (unity_WorldToLight__array[3].xy * vertex_unnamed_40.ww) + vertex_unnamed_9.xy;
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

				unity_WorldToLight__array[0] = float4(unity_WorldToLight[0][0], unity_WorldToLight[1][0], unity_WorldToLight[2][0], unity_WorldToLight[3][0]);
				unity_WorldToLight__array[1] = float4(unity_WorldToLight[0][1], unity_WorldToLight[1][1], unity_WorldToLight[2][1], unity_WorldToLight[3][1]);
				unity_WorldToLight__array[2] = float4(unity_WorldToLight[0][2], unity_WorldToLight[1][2], unity_WorldToLight[2][2], unity_WorldToLight[3][2]);
				unity_WorldToLight__array[3] = float4(unity_WorldToLight[0][3], unity_WorldToLight[1][3], unity_WorldToLight[2][3], unity_WorldToLight[3][3]);

				_EnvMatrix__array[0] = float4(_EnvMatrix[0][0], _EnvMatrix[1][0], _EnvMatrix[2][0], _EnvMatrix[3][0]);
				_EnvMatrix__array[1] = float4(_EnvMatrix[0][1], _EnvMatrix[1][1], _EnvMatrix[2][1], _EnvMatrix[3][1]);
				_EnvMatrix__array[2] = float4(_EnvMatrix[0][2], _EnvMatrix[1][2], _EnvMatrix[2][2], _EnvMatrix[3][2]);
				_EnvMatrix__array[3] = float4(_EnvMatrix[0][3], _EnvMatrix[1][3], _EnvMatrix[2][3], _EnvMatrix[3][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_4 = stage_input.vertex_input_4;
				vertex_input_3 = stage_input.vertex_input_3;
				vertex_input_2 = stage_input.vertex_input_2;
				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_5 = stage_input.vertex_input_5;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_0 = vertex_output_0;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_6 = vertex_output_6;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
				stage_output.vertex_output_7 = vertex_output_7;
				stage_output.vertex_output_8 = vertex_output_8;
				stage_output.vertex_output_9 = vertex_output_9;
				return stage_output;
			}

			float4 _Time;
			float3 _WorldSpaceCameraPos;
			float4 _WorldSpaceLightPos0;
			float4 _LightColor0;
			float4 _SpecColor;
			float4x4 unity_WorldToLight;
			float _FaceUVSpeedX;
			float _FaceUVSpeedY;
			float4 _FaceColor;
			float _OutlineSoftness;
			float _OutlineUVSpeedX;
			float _OutlineUVSpeedY;
			float4 _OutlineColor;
			float _OutlineWidth;
			float _Bevel;
			float _BevelOffset;
			float _BevelWidth;
			float _BevelClamp;
			float _BevelRoundness;
			float _BumpOutline;
			float _BumpFace;
			float _ShaderFlags;
			float _ScaleRatioA;
			float _TextureWidth;
			float _TextureHeight;
			float _GradientScale;
			float _FaceShininess;
			float _OutlineShininess;

			static float4 unity_WorldToLight__array[4];
			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;
			Texture2D<float4> _OutlineTex;
			SamplerState sampler_OutlineTex;
			Texture2D<float4> _FaceTex;
			SamplerState sampler_FaceTex;
			Texture2D<float4> _BumpMap;
			SamplerState sampler_BumpMap;
			Texture2D<float4> _LightTexture0;
			SamplerState sampler_LightTexture0;

			static float2 fragment_input_2;
			static float4 fragment_input_0;
			static float2 fragment_input_1;
			static float4 fragment_input_7;
			static float3 fragment_input_3;
			static float3 fragment_input_4;
			static float3 fragment_input_5;
			static float3 fragment_input_6;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_0 : TEXCOORD0; // vs_TEXCOORD0
				float2 fragment_input_1 : TEXCOORD1; // vs_TEXCOORD1
				float2 fragment_input_2 : TEXCOORD6; // vs_TEXCOORD6
				float3 fragment_input_3 : TEXCOORD2; // vs_TEXCOORD2
				float3 fragment_input_4 : TEXCOORD3; // vs_TEXCOORD3
				float3 fragment_input_5 : TEXCOORD4; // vs_TEXCOORD4
				float3 fragment_input_6 : TEXCOORD5; // vs_TEXCOORD5
				float4 fragment_input_7 : UNKNOWN7;
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static float4 fragment_unnamed_9;
			static float4 fragment_unnamed_32;
			static float4 fragment_unnamed_48;
			static float4 fragment_unnamed_62;
			static float fragment_unnamed_168;
			static bool fragment_unnamed_175;
			static bool fragment_unnamed_193;
			static float fragment_unnamed_270;
			static float fragment_unnamed_428;
			static float fragment_unnamed_449;
			static float fragment_unnamed_479;
			static float fragment_unnamed_548;
			static float3 fragment_unnamed_705;
			static float2 fragment_unnamed_711;

			void frag_main()
			{
				fragment_unnamed_9.x = fragment_input_2.x + _BevelOffset;
				float2 fragment_unnamed_42 = 1.0f.xx / float2(_TextureWidth, _TextureHeight);
				fragment_unnamed_32 = float4(fragment_unnamed_42.x, fragment_unnamed_42.y, fragment_unnamed_32.z, fragment_unnamed_32.w);
				fragment_unnamed_32.z = 0.0f;
				fragment_unnamed_48 = (-fragment_unnamed_32.xzzy) + fragment_input_0.xyxy;
				fragment_unnamed_32 = fragment_unnamed_32.xzzy + fragment_input_0.xyxy;
				fragment_unnamed_62.x = _MainTex.Sample(sampler_MainTex, fragment_unnamed_48.xy).w;
				fragment_unnamed_62.z = _MainTex.Sample(sampler_MainTex, fragment_unnamed_48.zw).w;
				fragment_unnamed_62.y = _MainTex.Sample(sampler_MainTex, fragment_unnamed_32.xy).w;
				fragment_unnamed_62.w = _MainTex.Sample(sampler_MainTex, fragment_unnamed_32.zw).w;
				fragment_unnamed_9 = fragment_unnamed_9.xxxx + fragment_unnamed_62;
				fragment_unnamed_9 += (-0.5f).xxxx;
				fragment_unnamed_32.x = _BevelWidth + _OutlineWidth;
				fragment_unnamed_32.x = max(fragment_unnamed_32.x, 0.00999999977648258209228515625f);
				fragment_unnamed_9 /= fragment_unnamed_32.xxxx;
				fragment_unnamed_32.x *= _Bevel;
				fragment_unnamed_32.x *= _GradientScale;
				fragment_unnamed_32.x *= (-2.0f);
				fragment_unnamed_9 += 0.5f.xxxx;
				fragment_unnamed_9 = clamp(fragment_unnamed_9, 0.0f.xxxx, 1.0f.xxxx);
				fragment_unnamed_48 = (fragment_unnamed_9 * 2.0f.xxxx) + (-1.0f).xxxx;
				fragment_unnamed_48 = (-abs(fragment_unnamed_48)) + 1.0f.xxxx;
				fragment_unnamed_168 = _ShaderFlags * 0.5f;
				fragment_unnamed_175 = fragment_unnamed_168 >= (-fragment_unnamed_168);
				fragment_unnamed_168 = frac(abs(fragment_unnamed_168));
				float fragment_unnamed_185;
				if (fragment_unnamed_175)
				{
					fragment_unnamed_185 = fragment_unnamed_168;
				}
				else
				{
					fragment_unnamed_185 = -fragment_unnamed_168;
				}
				fragment_unnamed_168 = fragment_unnamed_185;
				fragment_unnamed_193 = fragment_unnamed_168 >= 0.5f;
				bool4 fragment_unnamed_200 = fragment_unnamed_193.xxxx;
				fragment_unnamed_9 = float4(fragment_unnamed_200.x ? fragment_unnamed_48.x : fragment_unnamed_9.x, fragment_unnamed_200.y ? fragment_unnamed_48.y : fragment_unnamed_9.y, fragment_unnamed_200.z ? fragment_unnamed_48.z : fragment_unnamed_9.z, fragment_unnamed_200.w ? fragment_unnamed_48.w : fragment_unnamed_9.w);
				fragment_unnamed_48 = fragment_unnamed_9 * 1.57079601287841796875f.xxxx;
				fragment_unnamed_48 = sin(fragment_unnamed_48);
				fragment_unnamed_48 = (-fragment_unnamed_9) + fragment_unnamed_48;
				fragment_unnamed_9 = (float4(float4(_BevelRoundness, _BevelRoundness, _BevelRoundness, _BevelRoundness)) * fragment_unnamed_48) + fragment_unnamed_9;
				fragment_unnamed_168 = (-_BevelClamp) + 1.0f;
				fragment_unnamed_9 = min(fragment_unnamed_9, fragment_unnamed_168.xxxx);
				float2 fragment_unnamed_244 = fragment_unnamed_32.xx * fragment_unnamed_9.xz;
				fragment_unnamed_9 = float4(fragment_unnamed_244.x, fragment_unnamed_9.y, fragment_unnamed_244.y, fragment_unnamed_9.w);
				float2 fragment_unnamed_255 = (fragment_unnamed_9.wy * fragment_unnamed_32.xx) + (-fragment_unnamed_9.zx);
				fragment_unnamed_9 = float4(fragment_unnamed_9.x, fragment_unnamed_255.x, fragment_unnamed_255.y, fragment_unnamed_9.w);
				fragment_unnamed_9.x = -1.0f;
				fragment_unnamed_9.w = 1.0f;
				fragment_unnamed_32.x = dot(fragment_unnamed_9.xy, fragment_unnamed_9.xy);
				fragment_unnamed_32.x = rsqrt(fragment_unnamed_32.x);
				fragment_unnamed_270 = dot(fragment_unnamed_9.zw, fragment_unnamed_9.zw);
				fragment_unnamed_270 = rsqrt(fragment_unnamed_270);
				fragment_unnamed_48.x = fragment_unnamed_270 * fragment_unnamed_9.z;
				float2 fragment_unnamed_286 = fragment_unnamed_270.xx * float2(1.0f, 0.0f);
				fragment_unnamed_48 = float4(fragment_unnamed_48.x, fragment_unnamed_286.x, fragment_unnamed_286.y, fragment_unnamed_48.w);
				fragment_unnamed_9.z = 0.0f;
				float3 fragment_unnamed_294 = fragment_unnamed_32.xxx * fragment_unnamed_9.xyz;
				fragment_unnamed_9 = float4(fragment_unnamed_294.x, fragment_unnamed_294.y, fragment_unnamed_294.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_301 = fragment_unnamed_9.xyz * fragment_unnamed_48.xyz;
				fragment_unnamed_32 = float4(fragment_unnamed_301.x, fragment_unnamed_301.y, fragment_unnamed_301.z, fragment_unnamed_32.w);
				float3 fragment_unnamed_312 = (fragment_unnamed_48.zxy * fragment_unnamed_9.yzx) + (-fragment_unnamed_32.xyz);
				fragment_unnamed_9 = float4(fragment_unnamed_312.x, fragment_unnamed_312.y, fragment_unnamed_312.z, fragment_unnamed_9.w);
				float2 fragment_unnamed_330 = (float2(_OutlineUVSpeedX, _OutlineUVSpeedY) * _Time.yy) + fragment_input_1;
				fragment_unnamed_32 = float4(fragment_unnamed_330.x, fragment_unnamed_330.y, fragment_unnamed_32.z, fragment_unnamed_32.w);
				fragment_unnamed_32 = _OutlineTex.Sample(sampler_OutlineTex, fragment_unnamed_32.xy);
				float3 fragment_unnamed_347 = fragment_unnamed_32.xyz * _OutlineColor.xyz;
				fragment_unnamed_32 = float4(fragment_unnamed_347.x, fragment_unnamed_347.y, fragment_unnamed_347.z, fragment_unnamed_32.w);
				fragment_unnamed_270 = fragment_input_7.w * _OutlineColor.w;
				fragment_unnamed_48.w = fragment_unnamed_32.w * fragment_unnamed_270;
				float3 fragment_unnamed_365 = fragment_unnamed_32.xyz * fragment_unnamed_48.www;
				fragment_unnamed_48 = float4(fragment_unnamed_365.x, fragment_unnamed_365.y, fragment_unnamed_365.z, fragment_unnamed_48.w);
				float2 fragment_unnamed_381 = (float2(_FaceUVSpeedX, _FaceUVSpeedY) * _Time.yy) + fragment_input_0.zw;
				fragment_unnamed_32 = float4(fragment_unnamed_381.x, fragment_unnamed_381.y, fragment_unnamed_32.z, fragment_unnamed_32.w);
				fragment_unnamed_32 = _FaceTex.Sample(sampler_FaceTex, fragment_unnamed_32.xy);
				fragment_unnamed_62 = fragment_input_7 * _FaceColor;
				fragment_unnamed_32 *= fragment_unnamed_62;
				float3 fragment_unnamed_404 = fragment_unnamed_32.www * fragment_unnamed_32.xyz;
				fragment_unnamed_32 = float4(fragment_unnamed_404.x, fragment_unnamed_404.y, fragment_unnamed_404.z, fragment_unnamed_32.w);
				fragment_unnamed_48 = (-fragment_unnamed_32) + fragment_unnamed_48;
				fragment_unnamed_270 = _OutlineWidth * _ScaleRatioA;
				fragment_unnamed_270 *= fragment_input_2.y;
				fragment_unnamed_62.x = min(fragment_unnamed_270, 1.0f);
				fragment_unnamed_62.x = sqrt(fragment_unnamed_62.x);
				fragment_unnamed_428 = _MainTex.Sample(sampler_MainTex, fragment_input_0.xy).w;
				fragment_unnamed_428 = (-fragment_unnamed_428) + 0.5f;
				fragment_unnamed_428 += (-fragment_input_2.x);
				fragment_unnamed_428 = (fragment_unnamed_428 * fragment_input_2.y) + 0.5f;
				fragment_unnamed_449 = (fragment_unnamed_270 * 0.5f) + fragment_unnamed_428;
				fragment_unnamed_449 = clamp(fragment_unnamed_449, 0.0f, 1.0f);
				fragment_unnamed_270 = ((-fragment_unnamed_270) * 0.5f) + fragment_unnamed_428;
				fragment_unnamed_62.x *= fragment_unnamed_449;
				fragment_unnamed_32 = (fragment_unnamed_62.xxxx * fragment_unnamed_48) + fragment_unnamed_32;
				fragment_unnamed_48.x = _OutlineSoftness * _ScaleRatioA;
				fragment_unnamed_479 = fragment_unnamed_48.x * fragment_input_2.y;
				fragment_unnamed_48.x = (fragment_unnamed_48.x * fragment_input_2.y) + 1.0f;
				fragment_unnamed_270 = (fragment_unnamed_479 * 0.5f) + fragment_unnamed_270;
				fragment_unnamed_270 /= fragment_unnamed_48.x;
				fragment_unnamed_270 = clamp(fragment_unnamed_270, 0.0f, 1.0f);
				fragment_unnamed_270 = (-fragment_unnamed_270) + 1.0f;
				fragment_unnamed_32 = fragment_unnamed_270.xxxx * fragment_unnamed_32;
				fragment_unnamed_270 = (-_BumpFace) + _BumpOutline;
				fragment_unnamed_270 = (fragment_unnamed_449 * fragment_unnamed_270) + _BumpFace;
				float3 fragment_unnamed_531 = _BumpMap.Sample(sampler_BumpMap, fragment_input_0.zw).xyw;
				fragment_unnamed_48 = float4(fragment_unnamed_531.x, fragment_unnamed_531.y, fragment_unnamed_531.z, fragment_unnamed_48.w);
				fragment_unnamed_48.x = fragment_unnamed_48.z * fragment_unnamed_48.x;
				float2 fragment_unnamed_545 = (fragment_unnamed_48.xy * 2.0f.xx) + (-1.0f).xx;
				fragment_unnamed_48 = float4(fragment_unnamed_545.x, fragment_unnamed_545.y, fragment_unnamed_48.z, fragment_unnamed_48.w);
				fragment_unnamed_548 = dot(fragment_unnamed_48.xy, fragment_unnamed_48.xy);
				fragment_unnamed_548 = min(fragment_unnamed_548, 1.0f);
				fragment_unnamed_548 = (-fragment_unnamed_548) + 1.0f;
				fragment_unnamed_48.z = sqrt(fragment_unnamed_548);
				float3 fragment_unnamed_569 = (fragment_unnamed_48.xyz * fragment_unnamed_270.xxx) + float3(-0.0f, -0.0f, -1.0f);
				fragment_unnamed_48 = float4(fragment_unnamed_569.x, fragment_unnamed_569.y, fragment_unnamed_569.z, fragment_unnamed_48.w);
				float3 fragment_unnamed_578 = (fragment_unnamed_32.www * fragment_unnamed_48.xyz) + float3(0.0f, 0.0f, 1.0f);
				fragment_unnamed_48 = float4(fragment_unnamed_578.x, fragment_unnamed_578.y, fragment_unnamed_578.z, fragment_unnamed_48.w);
				float3 fragment_unnamed_586 = fragment_unnamed_9.xyz + (-fragment_unnamed_48.xyz);
				fragment_unnamed_9 = float4(fragment_unnamed_586.x, fragment_unnamed_586.y, fragment_unnamed_586.z, fragment_unnamed_9.w);
				fragment_unnamed_270 = dot(fragment_unnamed_9.xyz, fragment_unnamed_9.xyz);
				fragment_unnamed_270 = rsqrt(fragment_unnamed_270);
				float3 fragment_unnamed_600 = fragment_unnamed_270.xxx * fragment_unnamed_9.xyz;
				fragment_unnamed_9 = float4(fragment_unnamed_600.x, fragment_unnamed_600.y, fragment_unnamed_600.z, fragment_unnamed_9.w);
				fragment_unnamed_48.x = dot(fragment_input_3, -fragment_unnamed_9.xyz);
				fragment_unnamed_48.y = dot(fragment_input_4, -fragment_unnamed_9.xyz);
				fragment_unnamed_48.z = dot(fragment_input_5, -fragment_unnamed_9.xyz);
				fragment_unnamed_9.x = dot(fragment_unnamed_48.xyz, fragment_unnamed_48.xyz);
				fragment_unnamed_9.x = rsqrt(fragment_unnamed_9.x);
				float3 fragment_unnamed_639 = fragment_unnamed_9.xxx * fragment_unnamed_48.xyz;
				fragment_unnamed_9 = float4(fragment_unnamed_639.x, fragment_unnamed_639.y, fragment_unnamed_639.z, fragment_unnamed_9.w);
				float3 fragment_unnamed_649 = (-fragment_input_6) + _WorldSpaceCameraPos;
				fragment_unnamed_48 = float4(fragment_unnamed_649.x, fragment_unnamed_649.y, fragment_unnamed_649.z, fragment_unnamed_48.w);
				fragment_unnamed_270 = dot(fragment_unnamed_48.xyz, fragment_unnamed_48.xyz);
				fragment_unnamed_270 = rsqrt(fragment_unnamed_270);
				float3 fragment_unnamed_668 = (fragment_unnamed_48.xyz * fragment_unnamed_270.xxx) + _WorldSpaceLightPos0.xyz;
				fragment_unnamed_48 = float4(fragment_unnamed_668.x, fragment_unnamed_668.y, fragment_unnamed_668.z, fragment_unnamed_48.w);
				fragment_unnamed_270 = dot(fragment_unnamed_48.xyz, fragment_unnamed_48.xyz);
				fragment_unnamed_270 = rsqrt(fragment_unnamed_270);
				float3 fragment_unnamed_682 = fragment_unnamed_270.xxx * fragment_unnamed_48.xyz;
				fragment_unnamed_48 = float4(fragment_unnamed_682.x, fragment_unnamed_682.y, fragment_unnamed_682.z, fragment_unnamed_48.w);
				fragment_unnamed_9.w = dot(fragment_unnamed_9.xyz, fragment_unnamed_48.xyz);
				fragment_unnamed_9.x = dot(fragment_unnamed_9.xyz, _WorldSpaceLightPos0.xyz);
				float2 fragment_unnamed_701 = max(fragment_unnamed_9.xw, 0.0f.xx);
				fragment_unnamed_9 = float4(fragment_unnamed_701.x, fragment_unnamed_701.y, fragment_unnamed_9.z, fragment_unnamed_9.w);
				fragment_unnamed_705.x = log2(fragment_unnamed_9.y);
				fragment_unnamed_711.x = (-_FaceShininess) + _OutlineShininess;
				fragment_unnamed_711.x = (fragment_unnamed_449 * fragment_unnamed_711.x) + _FaceShininess;
				fragment_unnamed_711.x *= 128.0f;
				fragment_unnamed_705.x *= fragment_unnamed_711.x;
				fragment_unnamed_705.x = exp2(fragment_unnamed_705.x);
				fragment_unnamed_711 = fragment_input_6.yy * unity_WorldToLight__array[1].xy;
				fragment_unnamed_711 = (unity_WorldToLight__array[0].xy * fragment_input_6.xx) + fragment_unnamed_711;
				fragment_unnamed_711 = (unity_WorldToLight__array[2].xy * fragment_input_6.zz) + fragment_unnamed_711;
				fragment_unnamed_711 += unity_WorldToLight__array[3].xy;
				fragment_unnamed_711.x = _LightTexture0.Sample(sampler_LightTexture0, fragment_unnamed_711).w;
				float3 fragment_unnamed_787 = fragment_unnamed_711.xxx * _LightColor0.xyz;
				fragment_unnamed_48 = float4(fragment_unnamed_787.x, fragment_unnamed_787.y, fragment_unnamed_787.z, fragment_unnamed_48.w);
				float3 fragment_unnamed_796 = fragment_unnamed_48.xyz * _SpecColor.xyz;
				fragment_unnamed_62 = float4(fragment_unnamed_796.x, fragment_unnamed_796.y, fragment_unnamed_796.z, fragment_unnamed_62.w);
				fragment_unnamed_705 = fragment_unnamed_705.xxx * fragment_unnamed_62.xyz;
				fragment_unnamed_548 = max(fragment_unnamed_32.w, 9.9999997473787516355514526367188e-05f);
				float3 fragment_unnamed_812 = fragment_unnamed_32.xyz / fragment_unnamed_548.xxx;
				fragment_unnamed_32 = float4(fragment_unnamed_812.x, fragment_unnamed_812.y, fragment_unnamed_812.z, fragment_unnamed_32.w);
				fragment_output_0.w = fragment_unnamed_32.w;
				float3 fragment_unnamed_825 = fragment_unnamed_48.xyz * fragment_unnamed_32.xyz;
				fragment_unnamed_32 = float4(fragment_unnamed_825.x, fragment_unnamed_825.y, fragment_unnamed_825.z, fragment_unnamed_32.w);
				float3 fragment_unnamed_834 = (fragment_unnamed_32.xyz * fragment_unnamed_9.xxx) + fragment_unnamed_705;
				fragment_output_0 = float4(fragment_unnamed_834.x, fragment_unnamed_834.y, fragment_unnamed_834.z, fragment_output_0.w);
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				unity_WorldToLight__array[0] = float4(unity_WorldToLight[0][0], unity_WorldToLight[1][0], unity_WorldToLight[2][0], unity_WorldToLight[3][0]);
				unity_WorldToLight__array[1] = float4(unity_WorldToLight[0][1], unity_WorldToLight[1][1], unity_WorldToLight[2][1], unity_WorldToLight[3][1]);
				unity_WorldToLight__array[2] = float4(unity_WorldToLight[0][2], unity_WorldToLight[1][2], unity_WorldToLight[2][2], unity_WorldToLight[3][2]);
				unity_WorldToLight__array[3] = float4(unity_WorldToLight[0][3], unity_WorldToLight[1][3], unity_WorldToLight[2][3], unity_WorldToLight[3][3]);

				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_0 = stage_input.fragment_input_0;
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_7 = stage_input.fragment_input_7;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				fragment_input_6 = stage_input.fragment_input_6;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // DIRECTIONAL_COOKIE
			#endif // !DIRECTIONAL
			#endif // !POINT
			#endif // !POINT_COOKIE
			#endif // !SPOT


			#ifdef POINT
			#ifndef DIRECTIONAL
			#ifndef DIRECTIONAL_COOKIE
			#ifndef POINT_COOKIE
			#ifndef SPOT
			#define ANY_SHADER_VARIANT_ACTIVE

			float4 _LightColor0;
			float4 _SpecColor;
			float4x4 unity_WorldToLight;
			float _FaceUVSpeedX;
			float _FaceUVSpeedY;
			float4 _FaceColor;
			float _OutlineSoftness;
			float _OutlineUVSpeedX;
			float _OutlineUVSpeedY;
			float4 _OutlineColor;
			float _OutlineWidth;
			float _Bevel;
			float _BevelOffset;
			float _BevelWidth;
			float _BevelClamp;
			float _BevelRoundness;
			float _BumpOutline;
			float _BumpFace;
			float _ShaderFlags;
			float _ScaleRatioA;
			float _TextureWidth;
			float _TextureHeight;
			float _GradientScale;
			float _FaceShininess;
			float _OutlineShininess;
			float4 _Time;
			float3 _WorldSpaceCameraPos;
			float4 _WorldSpaceLightPos0;

			static float4 fragment_uniform_buffer_0[36];
			static float4 fragment_uniform_buffer_1[5];
			static float4 fragment_uniform_buffer_2[1];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _FaceTex;
			Texture2D<float4> _OutlineTex;
			Texture2D<float4> _BumpMap;
			Texture2D<float4> _LightTexture0;
			SamplerState sampler_LightTexture0;
			SamplerState sampler_FaceTex;
			SamplerState sampler_OutlineTex;
			SamplerState sampler_BumpMap;
			SamplerState sampler_MainTex;

			static float4 fragment_input_1;
			static float2 fragment_input_2;
			static float2 fragment_input_2;
			static float3 fragment_input_3;
			static float3 fragment_input_4;
			static float3 fragment_input_5;
			static float3 fragment_input_6;
			static float4 fragment_input_7;
			static float3 fragment_input_8;
			static float3 fragment_input_9;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : TEXCOORD; // TEXCOORD
				float2 fragment_input_2 : TEXCOORD1; // TEXCOORD_1
				float2 fragment_input_2 : TEXCOORD6; // TEXCOORD_6
				float3 fragment_input_3 : TEXCOORD2; // TEXCOORD_2
				float3 fragment_input_4 : TEXCOORD3; // TEXCOORD_3
				float3 fragment_input_5 : TEXCOORD4; // TEXCOORD_4
				float3 fragment_input_6 : TEXCOORD5; // TEXCOORD_5
				float4 fragment_input_7 : COLOR; // COLOR
				float3 fragment_input_8 : TEXCOORD7; // TEXCOORD_7
				float3 fragment_input_9 : TEXCOORD8; // TEXCOORD_8
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				precise float fragment_unnamed_74 = fragment_input_2.x + fragment_uniform_buffer_0[12u].z;
				precise float fragment_unnamed_80 = 1.0f / fragment_uniform_buffer_0[33u].z;
				precise float fragment_unnamed_82 = 1.0f / fragment_uniform_buffer_0[33u].w;
				float fragment_unnamed_83 = asfloat(0u);
				precise float fragment_unnamed_84 = (-0.0f) - fragment_unnamed_80;
				precise float fragment_unnamed_86 = (-0.0f) - fragment_unnamed_83;
				precise float fragment_unnamed_87 = (-0.0f) - fragment_unnamed_82;
				precise float fragment_unnamed_92 = fragment_unnamed_84 + fragment_input_1.x;
				precise float fragment_unnamed_93 = fragment_unnamed_86 + fragment_input_1.y;
				precise float fragment_unnamed_94 = fragment_unnamed_86 + fragment_input_1.x;
				precise float fragment_unnamed_95 = fragment_unnamed_87 + fragment_input_1.y;
				precise float fragment_unnamed_100 = fragment_unnamed_80 + fragment_input_1.x;
				precise float fragment_unnamed_101 = fragment_unnamed_83 + fragment_input_1.y;
				precise float fragment_unnamed_102 = fragment_unnamed_83 + fragment_input_1.x;
				precise float fragment_unnamed_103 = fragment_unnamed_82 + fragment_input_1.y;
				precise float fragment_unnamed_119 = fragment_unnamed_74 + _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_92, fragment_unnamed_93)).w;
				precise float fragment_unnamed_120 = fragment_unnamed_74 + _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_100, fragment_unnamed_101)).w;
				precise float fragment_unnamed_121 = fragment_unnamed_74 + _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_94, fragment_unnamed_95)).w;
				precise float fragment_unnamed_122 = fragment_unnamed_74 + _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_102, fragment_unnamed_103)).w;
				precise float fragment_unnamed_123 = fragment_unnamed_119 + (-0.5f);
				precise float fragment_unnamed_125 = fragment_unnamed_120 + (-0.5f);
				precise float fragment_unnamed_126 = fragment_unnamed_121 + (-0.5f);
				precise float fragment_unnamed_127 = fragment_unnamed_122 + (-0.5f);
				precise float fragment_unnamed_134 = fragment_uniform_buffer_0[12u].w + fragment_uniform_buffer_0[12u].x;
				float fragment_unnamed_136 = max(fragment_unnamed_134, 0.00999999977648258209228515625f);
				precise float fragment_unnamed_138 = fragment_unnamed_123 / fragment_unnamed_136;
				precise float fragment_unnamed_139 = fragment_unnamed_125 / fragment_unnamed_136;
				precise float fragment_unnamed_140 = fragment_unnamed_126 / fragment_unnamed_136;
				precise float fragment_unnamed_141 = fragment_unnamed_127 / fragment_unnamed_136;
				precise float fragment_unnamed_145 = fragment_unnamed_136 * fragment_uniform_buffer_0[12u].y;
				precise float fragment_unnamed_150 = fragment_unnamed_145 * fragment_uniform_buffer_0[34u].x;
				precise float fragment_unnamed_151 = fragment_unnamed_150 * (-2.0f);
				precise float fragment_unnamed_153 = fragment_unnamed_138 + 0.5f;
				precise float fragment_unnamed_155 = fragment_unnamed_139 + 0.5f;
				precise float fragment_unnamed_156 = fragment_unnamed_140 + 0.5f;
				precise float fragment_unnamed_157 = fragment_unnamed_141 + 0.5f;
				float fragment_unnamed_158 = clamp(fragment_unnamed_153, 0.0f, 1.0f);
				float fragment_unnamed_159 = clamp(fragment_unnamed_155, 0.0f, 1.0f);
				float fragment_unnamed_160 = clamp(fragment_unnamed_156, 0.0f, 1.0f);
				float fragment_unnamed_161 = clamp(fragment_unnamed_157, 0.0f, 1.0f);
				precise float fragment_unnamed_169 = (-0.0f) - abs(mad(fragment_unnamed_158, 2.0f, -1.0f));
				precise float fragment_unnamed_171 = (-0.0f) - abs(mad(fragment_unnamed_159, 2.0f, -1.0f));
				precise float fragment_unnamed_173 = (-0.0f) - abs(mad(fragment_unnamed_160, 2.0f, -1.0f));
				precise float fragment_unnamed_175 = (-0.0f) - abs(mad(fragment_unnamed_161, 2.0f, -1.0f));
				precise float fragment_unnamed_176 = fragment_unnamed_169 + 1.0f;
				precise float fragment_unnamed_177 = fragment_unnamed_171 + 1.0f;
				precise float fragment_unnamed_178 = fragment_unnamed_173 + 1.0f;
				precise float fragment_unnamed_179 = fragment_unnamed_175 + 1.0f;
				precise float fragment_unnamed_184 = fragment_uniform_buffer_0[28u].x * 0.5f;
				precise float fragment_unnamed_185 = (-0.0f) - fragment_unnamed_184;
				float fragment_unnamed_189 = frac(abs(fragment_unnamed_184));
				precise float fragment_unnamed_190 = (-0.0f) - fragment_unnamed_189;
				bool fragment_unnamed_192 = ((fragment_unnamed_184 >= fragment_unnamed_185) ? fragment_unnamed_189 : fragment_unnamed_190) >= 0.5f;
				float fragment_unnamed_202 = asfloat(fragment_unnamed_192 ? asuint(fragment_unnamed_176) : asuint(fragment_unnamed_158));
				float fragment_unnamed_204 = asfloat(fragment_unnamed_192 ? asuint(fragment_unnamed_177) : asuint(fragment_unnamed_159));
				float fragment_unnamed_206 = asfloat(fragment_unnamed_192 ? asuint(fragment_unnamed_178) : asuint(fragment_unnamed_160));
				float fragment_unnamed_208 = asfloat(fragment_unnamed_192 ? asuint(fragment_unnamed_179) : asuint(fragment_unnamed_161));
				precise float fragment_unnamed_209 = fragment_unnamed_202 * 1.57079601287841796875f;
				precise float fragment_unnamed_211 = fragment_unnamed_204 * 1.57079601287841796875f;
				precise float fragment_unnamed_212 = fragment_unnamed_206 * 1.57079601287841796875f;
				precise float fragment_unnamed_213 = fragment_unnamed_208 * 1.57079601287841796875f;
				precise float fragment_unnamed_218 = (-0.0f) - fragment_unnamed_202;
				precise float fragment_unnamed_219 = (-0.0f) - fragment_unnamed_204;
				precise float fragment_unnamed_220 = (-0.0f) - fragment_unnamed_206;
				precise float fragment_unnamed_221 = (-0.0f) - fragment_unnamed_208;
				precise float fragment_unnamed_222 = fragment_unnamed_218 + sin(fragment_unnamed_209);
				precise float fragment_unnamed_223 = fragment_unnamed_219 + sin(fragment_unnamed_211);
				precise float fragment_unnamed_224 = fragment_unnamed_220 + sin(fragment_unnamed_212);
				precise float fragment_unnamed_225 = fragment_unnamed_221 + sin(fragment_unnamed_213);
				precise float fragment_unnamed_237 = (-0.0f) - fragment_uniform_buffer_0[13u].x;
				precise float fragment_unnamed_238 = fragment_unnamed_237 + 1.0f;
				precise float fragment_unnamed_243 = fragment_unnamed_151 * min(mad(fragment_uniform_buffer_0[13u].y, fragment_unnamed_222, fragment_unnamed_202), fragment_unnamed_238);
				precise float fragment_unnamed_244 = fragment_unnamed_151 * min(mad(fragment_uniform_buffer_0[13u].y, fragment_unnamed_224, fragment_unnamed_206), fragment_unnamed_238);
				precise float fragment_unnamed_245 = (-0.0f) - fragment_unnamed_244;
				precise float fragment_unnamed_246 = (-0.0f) - fragment_unnamed_243;
				float fragment_unnamed_247 = mad(min(mad(fragment_uniform_buffer_0[13u].y, fragment_unnamed_225, fragment_unnamed_208), fragment_unnamed_238), fragment_unnamed_151, fragment_unnamed_245);
				float fragment_unnamed_248 = mad(min(mad(fragment_uniform_buffer_0[13u].y, fragment_unnamed_223, fragment_unnamed_204), fragment_unnamed_238), fragment_unnamed_151, fragment_unnamed_246);
				float fragment_unnamed_249 = asfloat(3212836864u);
				float fragment_unnamed_251 = asfloat(1065353216u);
				float fragment_unnamed_256 = rsqrt(dot(float2(fragment_unnamed_249, fragment_unnamed_247), float2(fragment_unnamed_249, fragment_unnamed_247)));
				float fragment_unnamed_260 = rsqrt(dot(float2(fragment_unnamed_248, fragment_unnamed_251), float2(fragment_unnamed_248, fragment_unnamed_251)));
				precise float fragment_unnamed_261 = fragment_unnamed_260 * fragment_unnamed_248;
				precise float fragment_unnamed_262 = fragment_unnamed_260 * 1.0f;
				precise float fragment_unnamed_263 = fragment_unnamed_260 * 0.0f;
				precise float fragment_unnamed_265 = fragment_unnamed_256 * fragment_unnamed_249;
				precise float fragment_unnamed_266 = fragment_unnamed_256 * fragment_unnamed_247;
				precise float fragment_unnamed_267 = fragment_unnamed_256 * asfloat(0u);
				precise float fragment_unnamed_268 = fragment_unnamed_265 * fragment_unnamed_261;
				precise float fragment_unnamed_269 = fragment_unnamed_266 * fragment_unnamed_262;
				precise float fragment_unnamed_270 = fragment_unnamed_267 * fragment_unnamed_263;
				precise float fragment_unnamed_271 = (-0.0f) - fragment_unnamed_268;
				precise float fragment_unnamed_272 = (-0.0f) - fragment_unnamed_269;
				precise float fragment_unnamed_273 = (-0.0f) - fragment_unnamed_270;
				float4 fragment_unnamed_292 = _OutlineTex.Sample(sampler_OutlineTex, float2(mad(fragment_uniform_buffer_0[10u].z, fragment_uniform_buffer_1[0u].y, fragment_input_2.x), mad(fragment_uniform_buffer_0[10u].w, fragment_uniform_buffer_1[0u].y, fragment_input_2.y)));
				precise float fragment_unnamed_304 = fragment_unnamed_292.x * fragment_uniform_buffer_0[11u].x;
				precise float fragment_unnamed_305 = fragment_unnamed_292.y * fragment_uniform_buffer_0[11u].y;
				precise float fragment_unnamed_306 = fragment_unnamed_292.z * fragment_uniform_buffer_0[11u].z;
				precise float fragment_unnamed_313 = fragment_input_7.w * fragment_uniform_buffer_0[11u].w;
				precise float fragment_unnamed_314 = fragment_unnamed_292.w * fragment_unnamed_313;
				precise float fragment_unnamed_315 = fragment_unnamed_304 * fragment_unnamed_314;
				precise float fragment_unnamed_316 = fragment_unnamed_305 * fragment_unnamed_314;
				precise float fragment_unnamed_317 = fragment_unnamed_306 * fragment_unnamed_314;
				float4 fragment_unnamed_334 = _FaceTex.Sample(sampler_FaceTex, float2(mad(fragment_uniform_buffer_0[8u].x, fragment_uniform_buffer_1[0u].y, fragment_input_1.z), mad(fragment_uniform_buffer_0[8u].y, fragment_uniform_buffer_1[0u].y, fragment_input_1.w)));
				precise float fragment_unnamed_355 = fragment_input_7.x * fragment_uniform_buffer_0[9u].x;
				precise float fragment_unnamed_356 = fragment_input_7.y * fragment_uniform_buffer_0[9u].y;
				precise float fragment_unnamed_357 = fragment_input_7.z * fragment_uniform_buffer_0[9u].z;
				precise float fragment_unnamed_358 = fragment_input_7.w * fragment_uniform_buffer_0[9u].w;
				precise float fragment_unnamed_359 = fragment_unnamed_334.x * fragment_unnamed_355;
				precise float fragment_unnamed_360 = fragment_unnamed_334.y * fragment_unnamed_356;
				precise float fragment_unnamed_361 = fragment_unnamed_334.z * fragment_unnamed_357;
				precise float fragment_unnamed_362 = fragment_unnamed_334.w * fragment_unnamed_358;
				precise float fragment_unnamed_363 = fragment_unnamed_362 * fragment_unnamed_359;
				precise float fragment_unnamed_364 = fragment_unnamed_362 * fragment_unnamed_360;
				precise float fragment_unnamed_365 = fragment_unnamed_362 * fragment_unnamed_361;
				precise float fragment_unnamed_366 = (-0.0f) - fragment_unnamed_363;
				precise float fragment_unnamed_367 = (-0.0f) - fragment_unnamed_364;
				precise float fragment_unnamed_368 = (-0.0f) - fragment_unnamed_365;
				precise float fragment_unnamed_369 = (-0.0f) - fragment_unnamed_362;
				precise float fragment_unnamed_370 = fragment_unnamed_366 + fragment_unnamed_315;
				precise float fragment_unnamed_371 = fragment_unnamed_367 + fragment_unnamed_316;
				precise float fragment_unnamed_372 = fragment_unnamed_368 + fragment_unnamed_317;
				precise float fragment_unnamed_373 = fragment_unnamed_369 + fragment_unnamed_314;
				precise float fragment_unnamed_380 = fragment_uniform_buffer_0[12u].x * fragment_uniform_buffer_0[28u].w;
				precise float fragment_unnamed_383 = fragment_unnamed_380 * fragment_input_2.y;
				precise float fragment_unnamed_393 = (-0.0f) - _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y)).w;
				precise float fragment_unnamed_394 = fragment_unnamed_393 + 0.5f;
				precise float fragment_unnamed_397 = (-0.0f) - fragment_input_2.x;
				precise float fragment_unnamed_398 = fragment_unnamed_394 + fragment_unnamed_397;
				float fragment_unnamed_401 = mad(fragment_unnamed_398, fragment_input_2.y, 0.5f);
				float fragment_unnamed_403 = clamp(mad(fragment_unnamed_383, 0.5f, fragment_unnamed_401), 0.0f, 1.0f);
				precise float fragment_unnamed_404 = (-0.0f) - fragment_unnamed_383;
				precise float fragment_unnamed_406 = sqrt(min(fragment_unnamed_383, 1.0f)) * fragment_unnamed_403;
				precise float fragment_unnamed_417 = fragment_uniform_buffer_0[10u].y * fragment_uniform_buffer_0[28u].w;
				precise float fragment_unnamed_420 = fragment_unnamed_417 * fragment_input_2.y;
				precise float fragment_unnamed_425 = mad(fragment_unnamed_420, 0.5f, mad(fragment_unnamed_404, 0.5f, fragment_unnamed_401)) / mad(fragment_unnamed_417, fragment_input_2.y, 1.0f);
				precise float fragment_unnamed_427 = (-0.0f) - clamp(fragment_unnamed_425, 0.0f, 1.0f);
				precise float fragment_unnamed_428 = fragment_unnamed_427 + 1.0f;
				precise float fragment_unnamed_429 = fragment_unnamed_428 * mad(fragment_unnamed_406, fragment_unnamed_370, fragment_unnamed_363);
				precise float fragment_unnamed_430 = fragment_unnamed_428 * mad(fragment_unnamed_406, fragment_unnamed_371, fragment_unnamed_364);
				precise float fragment_unnamed_431 = fragment_unnamed_428 * mad(fragment_unnamed_406, fragment_unnamed_372, fragment_unnamed_365);
				precise float fragment_unnamed_432 = fragment_unnamed_428 * mad(fragment_unnamed_406, fragment_unnamed_373, fragment_unnamed_362);
				precise float fragment_unnamed_436 = (-0.0f) - fragment_uniform_buffer_0[13u].w;
				precise float fragment_unnamed_440 = fragment_unnamed_436 + fragment_uniform_buffer_0[13u].z;
				float fragment_unnamed_444 = mad(fragment_unnamed_403, fragment_unnamed_440, fragment_uniform_buffer_0[13u].w);
				float4 fragment_unnamed_450 = _BumpMap.Sample(sampler_BumpMap, float2(fragment_input_1.z, fragment_input_1.w));
				precise float fragment_unnamed_455 = fragment_unnamed_450.w * fragment_unnamed_450.x;
				float fragment_unnamed_456 = mad(fragment_unnamed_455, 2.0f, -1.0f);
				float fragment_unnamed_457 = mad(fragment_unnamed_450.y, 2.0f, -1.0f);
				precise float fragment_unnamed_462 = (-0.0f) - min(dot(float2(fragment_unnamed_456, fragment_unnamed_457), float2(fragment_unnamed_456, fragment_unnamed_457)), 1.0f);
				precise float fragment_unnamed_463 = fragment_unnamed_462 + 1.0f;
				precise float fragment_unnamed_471 = (-0.0f) - mad(fragment_unnamed_432, mad(fragment_unnamed_456, fragment_unnamed_444, -0.0f), 0.0f);
				precise float fragment_unnamed_472 = (-0.0f) - mad(fragment_unnamed_432, mad(fragment_unnamed_457, fragment_unnamed_444, -0.0f), 0.0f);
				precise float fragment_unnamed_473 = (-0.0f) - mad(fragment_unnamed_432, mad(sqrt(fragment_unnamed_463), fragment_unnamed_444, -1.0f), 1.0f);
				precise float fragment_unnamed_474 = mad(fragment_unnamed_263, fragment_unnamed_266, fragment_unnamed_271) + fragment_unnamed_471;
				precise float fragment_unnamed_475 = mad(fragment_unnamed_261, fragment_unnamed_267, fragment_unnamed_272) + fragment_unnamed_472;
				precise float fragment_unnamed_476 = mad(fragment_unnamed_262, fragment_unnamed_265, fragment_unnamed_273) + fragment_unnamed_473;
				float fragment_unnamed_480 = rsqrt(dot(float3(fragment_unnamed_474, fragment_unnamed_475, fragment_unnamed_476), float3(fragment_unnamed_474, fragment_unnamed_475, fragment_unnamed_476)));
				precise float fragment_unnamed_481 = fragment_unnamed_480 * fragment_unnamed_474;
				precise float fragment_unnamed_482 = fragment_unnamed_480 * fragment_unnamed_475;
				precise float fragment_unnamed_483 = fragment_unnamed_480 * fragment_unnamed_476;
				precise float fragment_unnamed_490 = (-0.0f) - fragment_unnamed_481;
				precise float fragment_unnamed_491 = (-0.0f) - fragment_unnamed_482;
				precise float fragment_unnamed_492 = (-0.0f) - fragment_unnamed_483;
				float fragment_unnamed_493 = dot(float3(fragment_input_3.x, fragment_input_3.y, fragment_input_3.z), float3(fragment_unnamed_490, fragment_unnamed_491, fragment_unnamed_492));
				precise float fragment_unnamed_502 = (-0.0f) - fragment_unnamed_481;
				precise float fragment_unnamed_503 = (-0.0f) - fragment_unnamed_482;
				precise float fragment_unnamed_504 = (-0.0f) - fragment_unnamed_483;
				float fragment_unnamed_505 = dot(float3(fragment_input_4.x, fragment_input_4.y, fragment_input_4.z), float3(fragment_unnamed_502, fragment_unnamed_503, fragment_unnamed_504));
				precise float fragment_unnamed_514 = (-0.0f) - fragment_unnamed_481;
				precise float fragment_unnamed_515 = (-0.0f) - fragment_unnamed_482;
				precise float fragment_unnamed_516 = (-0.0f) - fragment_unnamed_483;
				float fragment_unnamed_517 = dot(float3(fragment_input_5.x, fragment_input_5.y, fragment_input_5.z), float3(fragment_unnamed_514, fragment_unnamed_515, fragment_unnamed_516));
				float fragment_unnamed_523 = rsqrt(dot(float3(fragment_unnamed_493, fragment_unnamed_505, fragment_unnamed_517), float3(fragment_unnamed_493, fragment_unnamed_505, fragment_unnamed_517)));
				precise float fragment_unnamed_524 = fragment_unnamed_523 * fragment_unnamed_493;
				precise float fragment_unnamed_525 = fragment_unnamed_523 * fragment_unnamed_505;
				precise float fragment_unnamed_526 = fragment_unnamed_523 * fragment_unnamed_517;
				precise float fragment_unnamed_529 = (-0.0f) - fragment_input_6.x;
				precise float fragment_unnamed_532 = (-0.0f) - fragment_input_6.y;
				precise float fragment_unnamed_535 = (-0.0f) - fragment_input_6.z;
				precise float fragment_unnamed_541 = fragment_unnamed_529 + fragment_uniform_buffer_2[0u].x;
				precise float fragment_unnamed_542 = fragment_unnamed_532 + fragment_uniform_buffer_2[0u].y;
				precise float fragment_unnamed_543 = fragment_unnamed_535 + fragment_uniform_buffer_2[0u].z;
				float fragment_unnamed_547 = rsqrt(dot(float3(fragment_unnamed_541, fragment_unnamed_542, fragment_unnamed_543), float3(fragment_unnamed_541, fragment_unnamed_542, fragment_unnamed_543)));
				precise float fragment_unnamed_548 = fragment_unnamed_547 * fragment_unnamed_541;
				precise float fragment_unnamed_549 = fragment_unnamed_547 * fragment_unnamed_542;
				precise float fragment_unnamed_550 = fragment_unnamed_547 * fragment_unnamed_543;
				precise float fragment_unnamed_553 = (-0.0f) - fragment_input_6.x;
				precise float fragment_unnamed_556 = (-0.0f) - fragment_input_6.y;
				precise float fragment_unnamed_559 = (-0.0f) - fragment_input_6.z;
				precise float fragment_unnamed_566 = fragment_unnamed_553 + fragment_uniform_buffer_1[4u].x;
				precise float fragment_unnamed_567 = fragment_unnamed_556 + fragment_uniform_buffer_1[4u].y;
				precise float fragment_unnamed_568 = fragment_unnamed_559 + fragment_uniform_buffer_1[4u].z;
				float fragment_unnamed_572 = rsqrt(dot(float3(fragment_unnamed_566, fragment_unnamed_567, fragment_unnamed_568), float3(fragment_unnamed_566, fragment_unnamed_567, fragment_unnamed_568)));
				float fragment_unnamed_573 = mad(fragment_unnamed_566, fragment_unnamed_572, fragment_unnamed_548);
				float fragment_unnamed_574 = mad(fragment_unnamed_567, fragment_unnamed_572, fragment_unnamed_549);
				float fragment_unnamed_575 = mad(fragment_unnamed_568, fragment_unnamed_572, fragment_unnamed_550);
				float fragment_unnamed_582 = rsqrt(dot(float3(fragment_unnamed_573, fragment_unnamed_574, fragment_unnamed_575), float3(fragment_unnamed_573, fragment_unnamed_574, fragment_unnamed_575)));
				precise float fragment_unnamed_583 = fragment_unnamed_582 * fragment_unnamed_573;
				precise float fragment_unnamed_584 = fragment_unnamed_582 * fragment_unnamed_574;
				precise float fragment_unnamed_585 = fragment_unnamed_582 * fragment_unnamed_575;
				float fragment_unnamed_590 = max(dot(float3(fragment_unnamed_524, fragment_unnamed_525, fragment_unnamed_526), float3(fragment_unnamed_548, fragment_unnamed_549, fragment_unnamed_550)), 0.0f);
				precise float fragment_unnamed_596 = (-0.0f) - fragment_uniform_buffer_0[35u].y;
				precise float fragment_unnamed_600 = fragment_unnamed_596 + fragment_uniform_buffer_0[35u].z;
				precise float fragment_unnamed_605 = mad(fragment_unnamed_403, fragment_unnamed_600, fragment_uniform_buffer_0[35u].y) * 128.0f;
				precise float fragment_unnamed_607 = log2(max(dot(float3(fragment_unnamed_524, fragment_unnamed_525, fragment_unnamed_526), float3(fragment_unnamed_583, fragment_unnamed_584, fragment_unnamed_585)), 0.0f)) * fragment_unnamed_605;
				float fragment_unnamed_608 = exp2(fragment_unnamed_607);
				precise float fragment_unnamed_616 = fragment_input_6.y * fragment_uniform_buffer_0[5u].x;
				precise float fragment_unnamed_617 = fragment_input_6.y * fragment_uniform_buffer_0[5u].y;
				precise float fragment_unnamed_618 = fragment_input_6.y * fragment_uniform_buffer_0[5u].z;
				precise float fragment_unnamed_646 = mad(fragment_uniform_buffer_0[6u].x, fragment_input_6.z, mad(fragment_uniform_buffer_0[4u].x, fragment_input_6.x, fragment_unnamed_616)) + fragment_uniform_buffer_0[7u].x;
				precise float fragment_unnamed_647 = mad(fragment_uniform_buffer_0[6u].y, fragment_input_6.z, mad(fragment_uniform_buffer_0[4u].y, fragment_input_6.x, fragment_unnamed_617)) + fragment_uniform_buffer_0[7u].y;
				precise float fragment_unnamed_648 = mad(fragment_uniform_buffer_0[6u].z, fragment_input_6.z, mad(fragment_uniform_buffer_0[4u].z, fragment_input_6.x, fragment_unnamed_618)) + fragment_uniform_buffer_0[7u].z;
				float4 fragment_unnamed_653 = _LightTexture0.Sample(sampler_LightTexture0, dot(float3(fragment_unnamed_646, fragment_unnamed_647, fragment_unnamed_648), float3(fragment_unnamed_646, fragment_unnamed_647, fragment_unnamed_648)).xx);
				float fragment_unnamed_655 = fragment_unnamed_653.x;
				precise float fragment_unnamed_661 = fragment_unnamed_655 * fragment_uniform_buffer_0[2u].x;
				precise float fragment_unnamed_662 = fragment_unnamed_655 * fragment_uniform_buffer_0[2u].y;
				precise float fragment_unnamed_663 = fragment_unnamed_655 * fragment_uniform_buffer_0[2u].z;
				precise float fragment_unnamed_669 = fragment_unnamed_661 * fragment_uniform_buffer_0[3u].x;
				precise float fragment_unnamed_670 = fragment_unnamed_662 * fragment_uniform_buffer_0[3u].y;
				precise float fragment_unnamed_671 = fragment_unnamed_663 * fragment_uniform_buffer_0[3u].z;
				precise float fragment_unnamed_672 = fragment_unnamed_608 * fragment_unnamed_669;
				precise float fragment_unnamed_673 = fragment_unnamed_608 * fragment_unnamed_670;
				precise float fragment_unnamed_674 = fragment_unnamed_608 * fragment_unnamed_671;
				float fragment_unnamed_675 = max(fragment_unnamed_432, 9.9999997473787516355514526367188e-05f);
				precise float fragment_unnamed_677 = fragment_unnamed_429 / fragment_unnamed_675;
				precise float fragment_unnamed_678 = fragment_unnamed_430 / fragment_unnamed_675;
				precise float fragment_unnamed_679 = fragment_unnamed_431 / fragment_unnamed_675;
				fragment_output_0.w = fragment_unnamed_432;
				precise float fragment_unnamed_682 = fragment_unnamed_661 * fragment_unnamed_677;
				precise float fragment_unnamed_683 = fragment_unnamed_662 * fragment_unnamed_678;
				precise float fragment_unnamed_684 = fragment_unnamed_663 * fragment_unnamed_679;
				fragment_output_0.x = mad(fragment_unnamed_682, fragment_unnamed_590, fragment_unnamed_672);
				fragment_output_0.y = mad(fragment_unnamed_683, fragment_unnamed_590, fragment_unnamed_673);
				fragment_output_0.z = mad(fragment_unnamed_684, fragment_unnamed_590, fragment_unnamed_674);
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[2] = float4(_LightColor0[0], _LightColor0[1], _LightColor0[2], _LightColor0[3]);

				fragment_uniform_buffer_0[3] = float4(_SpecColor[0], _SpecColor[1], _SpecColor[2], _SpecColor[3]);

				fragment_uniform_buffer_0[4] = float4(unity_WorldToLight[0][0], unity_WorldToLight[1][0], unity_WorldToLight[2][0], unity_WorldToLight[3][0]);
				fragment_uniform_buffer_0[5] = float4(unity_WorldToLight[0][1], unity_WorldToLight[1][1], unity_WorldToLight[2][1], unity_WorldToLight[3][1]);
				fragment_uniform_buffer_0[6] = float4(unity_WorldToLight[0][2], unity_WorldToLight[1][2], unity_WorldToLight[2][2], unity_WorldToLight[3][2]);
				fragment_uniform_buffer_0[7] = float4(unity_WorldToLight[0][3], unity_WorldToLight[1][3], unity_WorldToLight[2][3], unity_WorldToLight[3][3]);

				fragment_uniform_buffer_0[8] = float4(_FaceUVSpeedX, fragment_uniform_buffer_0[8][1], fragment_uniform_buffer_0[8][2], fragment_uniform_buffer_0[8][3]);

				fragment_uniform_buffer_0[8] = float4(fragment_uniform_buffer_0[8][0], _FaceUVSpeedY, fragment_uniform_buffer_0[8][2], fragment_uniform_buffer_0[8][3]);

				fragment_uniform_buffer_0[9] = float4(_FaceColor[0], _FaceColor[1], _FaceColor[2], _FaceColor[3]);

				fragment_uniform_buffer_0[10] = float4(fragment_uniform_buffer_0[10][0], _OutlineSoftness, fragment_uniform_buffer_0[10][2], fragment_uniform_buffer_0[10][3]);

				fragment_uniform_buffer_0[10] = float4(fragment_uniform_buffer_0[10][0], fragment_uniform_buffer_0[10][1], _OutlineUVSpeedX, fragment_uniform_buffer_0[10][3]);

				fragment_uniform_buffer_0[10] = float4(fragment_uniform_buffer_0[10][0], fragment_uniform_buffer_0[10][1], fragment_uniform_buffer_0[10][2], _OutlineUVSpeedY);

				fragment_uniform_buffer_0[11] = float4(_OutlineColor[0], _OutlineColor[1], _OutlineColor[2], _OutlineColor[3]);

				fragment_uniform_buffer_0[12] = float4(_OutlineWidth, fragment_uniform_buffer_0[12][1], fragment_uniform_buffer_0[12][2], fragment_uniform_buffer_0[12][3]);

				fragment_uniform_buffer_0[12] = float4(fragment_uniform_buffer_0[12][0], _Bevel, fragment_uniform_buffer_0[12][2], fragment_uniform_buffer_0[12][3]);

				fragment_uniform_buffer_0[12] = float4(fragment_uniform_buffer_0[12][0], fragment_uniform_buffer_0[12][1], _BevelOffset, fragment_uniform_buffer_0[12][3]);

				fragment_uniform_buffer_0[12] = float4(fragment_uniform_buffer_0[12][0], fragment_uniform_buffer_0[12][1], fragment_uniform_buffer_0[12][2], _BevelWidth);

				fragment_uniform_buffer_0[13] = float4(_BevelClamp, fragment_uniform_buffer_0[13][1], fragment_uniform_buffer_0[13][2], fragment_uniform_buffer_0[13][3]);

				fragment_uniform_buffer_0[13] = float4(fragment_uniform_buffer_0[13][0], _BevelRoundness, fragment_uniform_buffer_0[13][2], fragment_uniform_buffer_0[13][3]);

				fragment_uniform_buffer_0[13] = float4(fragment_uniform_buffer_0[13][0], fragment_uniform_buffer_0[13][1], _BumpOutline, fragment_uniform_buffer_0[13][3]);

				fragment_uniform_buffer_0[13] = float4(fragment_uniform_buffer_0[13][0], fragment_uniform_buffer_0[13][1], fragment_uniform_buffer_0[13][2], _BumpFace);

				fragment_uniform_buffer_0[28] = float4(_ShaderFlags, fragment_uniform_buffer_0[28][1], fragment_uniform_buffer_0[28][2], fragment_uniform_buffer_0[28][3]);

				fragment_uniform_buffer_0[28] = float4(fragment_uniform_buffer_0[28][0], fragment_uniform_buffer_0[28][1], fragment_uniform_buffer_0[28][2], _ScaleRatioA);

				fragment_uniform_buffer_0[33] = float4(fragment_uniform_buffer_0[33][0], fragment_uniform_buffer_0[33][1], _TextureWidth, fragment_uniform_buffer_0[33][3]);

				fragment_uniform_buffer_0[33] = float4(fragment_uniform_buffer_0[33][0], fragment_uniform_buffer_0[33][1], fragment_uniform_buffer_0[33][2], _TextureHeight);

				fragment_uniform_buffer_0[34] = float4(_GradientScale, fragment_uniform_buffer_0[34][1], fragment_uniform_buffer_0[34][2], fragment_uniform_buffer_0[34][3]);

				fragment_uniform_buffer_0[35] = float4(fragment_uniform_buffer_0[35][0], _FaceShininess, fragment_uniform_buffer_0[35][2], fragment_uniform_buffer_0[35][3]);

				fragment_uniform_buffer_0[35] = float4(fragment_uniform_buffer_0[35][0], fragment_uniform_buffer_0[35][1], _OutlineShininess, fragment_uniform_buffer_0[35][3]);

				fragment_uniform_buffer_1[0] = float4(_Time[0], _Time[1], _Time[2], _Time[3]);

				fragment_uniform_buffer_1[4] = float4(_WorldSpaceCameraPos[0], _WorldSpaceCameraPos[1], _WorldSpaceCameraPos[2], fragment_uniform_buffer_1[4][3]);

				fragment_uniform_buffer_2[0] = float4(_WorldSpaceLightPos0[0], _WorldSpaceLightPos0[1], _WorldSpaceLightPos0[2], _WorldSpaceLightPos0[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				fragment_input_6 = stage_input.fragment_input_6;
				fragment_input_7 = stage_input.fragment_input_7;
				fragment_input_8 = stage_input.fragment_input_8;
				fragment_input_9 = stage_input.fragment_input_9;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // POINT
			#endif // !DIRECTIONAL
			#endif // !DIRECTIONAL_COOKIE
			#endif // !POINT_COOKIE
			#endif // !SPOT


			#ifdef DIRECTIONAL
			#ifndef DIRECTIONAL_COOKIE
			#ifndef POINT
			#ifndef POINT_COOKIE
			#ifndef SPOT
			#define ANY_SHADER_VARIANT_ACTIVE

			float4 _LightColor0;
			float4 _SpecColor;
			float _FaceUVSpeedX;
			float _FaceUVSpeedY;
			float4 _FaceColor;
			float _OutlineSoftness;
			float _OutlineUVSpeedX;
			float _OutlineUVSpeedY;
			float4 _OutlineColor;
			float _OutlineWidth;
			float _Bevel;
			float _BevelOffset;
			float _BevelWidth;
			float _BevelClamp;
			float _BevelRoundness;
			float _BumpOutline;
			float _BumpFace;
			float _ShaderFlags;
			float _ScaleRatioA;
			float _TextureWidth;
			float _TextureHeight;
			float _GradientScale;
			float _FaceShininess;
			float _OutlineShininess;
			float4 _Time;
			float3 _WorldSpaceCameraPos;
			float4 _WorldSpaceLightPos0;

			static float4 fragment_uniform_buffer_0[32];
			static float4 fragment_uniform_buffer_1[5];
			static float4 fragment_uniform_buffer_2[1];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _FaceTex;
			Texture2D<float4> _OutlineTex;
			Texture2D<float4> _BumpMap;
			SamplerState sampler_FaceTex;
			SamplerState sampler_OutlineTex;
			SamplerState sampler_BumpMap;
			SamplerState sampler_MainTex;

			static float4 fragment_input_1;
			static float2 fragment_input_2;
			static float2 fragment_input_2;
			static float3 fragment_input_3;
			static float3 fragment_input_4;
			static float3 fragment_input_5;
			static float3 fragment_input_6;
			static float4 fragment_input_7;
			static float3 fragment_input_8;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : TEXCOORD; // TEXCOORD
				float2 fragment_input_2 : TEXCOORD1; // TEXCOORD_1
				float2 fragment_input_2 : TEXCOORD6; // TEXCOORD_6
				float3 fragment_input_3 : TEXCOORD2; // TEXCOORD_2
				float3 fragment_input_4 : TEXCOORD3; // TEXCOORD_3
				float3 fragment_input_5 : TEXCOORD4; // TEXCOORD_4
				float3 fragment_input_6 : TEXCOORD5; // TEXCOORD_5
				float4 fragment_input_7 : COLOR; // COLOR
				float3 fragment_input_8 : TEXCOORD7; // TEXCOORD_7
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				precise float fragment_unnamed_69 = fragment_input_2.x + fragment_uniform_buffer_0[8u].z;
				precise float fragment_unnamed_75 = 1.0f / fragment_uniform_buffer_0[29u].z;
				precise float fragment_unnamed_77 = 1.0f / fragment_uniform_buffer_0[29u].w;
				float fragment_unnamed_78 = asfloat(0u);
				precise float fragment_unnamed_79 = (-0.0f) - fragment_unnamed_75;
				precise float fragment_unnamed_81 = (-0.0f) - fragment_unnamed_78;
				precise float fragment_unnamed_82 = (-0.0f) - fragment_unnamed_77;
				precise float fragment_unnamed_87 = fragment_unnamed_79 + fragment_input_1.x;
				precise float fragment_unnamed_88 = fragment_unnamed_81 + fragment_input_1.y;
				precise float fragment_unnamed_89 = fragment_unnamed_81 + fragment_input_1.x;
				precise float fragment_unnamed_90 = fragment_unnamed_82 + fragment_input_1.y;
				precise float fragment_unnamed_95 = fragment_unnamed_75 + fragment_input_1.x;
				precise float fragment_unnamed_96 = fragment_unnamed_78 + fragment_input_1.y;
				precise float fragment_unnamed_97 = fragment_unnamed_78 + fragment_input_1.x;
				precise float fragment_unnamed_98 = fragment_unnamed_77 + fragment_input_1.y;
				precise float fragment_unnamed_114 = fragment_unnamed_69 + _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_87, fragment_unnamed_88)).w;
				precise float fragment_unnamed_115 = fragment_unnamed_69 + _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_95, fragment_unnamed_96)).w;
				precise float fragment_unnamed_116 = fragment_unnamed_69 + _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_89, fragment_unnamed_90)).w;
				precise float fragment_unnamed_117 = fragment_unnamed_69 + _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_97, fragment_unnamed_98)).w;
				precise float fragment_unnamed_118 = fragment_unnamed_114 + (-0.5f);
				precise float fragment_unnamed_120 = fragment_unnamed_115 + (-0.5f);
				precise float fragment_unnamed_121 = fragment_unnamed_116 + (-0.5f);
				precise float fragment_unnamed_122 = fragment_unnamed_117 + (-0.5f);
				precise float fragment_unnamed_129 = fragment_uniform_buffer_0[8u].w + fragment_uniform_buffer_0[8u].x;
				float fragment_unnamed_131 = max(fragment_unnamed_129, 0.00999999977648258209228515625f);
				precise float fragment_unnamed_133 = fragment_unnamed_118 / fragment_unnamed_131;
				precise float fragment_unnamed_134 = fragment_unnamed_120 / fragment_unnamed_131;
				precise float fragment_unnamed_135 = fragment_unnamed_121 / fragment_unnamed_131;
				precise float fragment_unnamed_136 = fragment_unnamed_122 / fragment_unnamed_131;
				precise float fragment_unnamed_140 = fragment_unnamed_131 * fragment_uniform_buffer_0[8u].y;
				precise float fragment_unnamed_145 = fragment_unnamed_140 * fragment_uniform_buffer_0[30u].x;
				precise float fragment_unnamed_146 = fragment_unnamed_145 * (-2.0f);
				precise float fragment_unnamed_148 = fragment_unnamed_133 + 0.5f;
				precise float fragment_unnamed_150 = fragment_unnamed_134 + 0.5f;
				precise float fragment_unnamed_151 = fragment_unnamed_135 + 0.5f;
				precise float fragment_unnamed_152 = fragment_unnamed_136 + 0.5f;
				float fragment_unnamed_153 = clamp(fragment_unnamed_148, 0.0f, 1.0f);
				float fragment_unnamed_154 = clamp(fragment_unnamed_150, 0.0f, 1.0f);
				float fragment_unnamed_155 = clamp(fragment_unnamed_151, 0.0f, 1.0f);
				float fragment_unnamed_156 = clamp(fragment_unnamed_152, 0.0f, 1.0f);
				precise float fragment_unnamed_164 = (-0.0f) - abs(mad(fragment_unnamed_153, 2.0f, -1.0f));
				precise float fragment_unnamed_166 = (-0.0f) - abs(mad(fragment_unnamed_154, 2.0f, -1.0f));
				precise float fragment_unnamed_168 = (-0.0f) - abs(mad(fragment_unnamed_155, 2.0f, -1.0f));
				precise float fragment_unnamed_170 = (-0.0f) - abs(mad(fragment_unnamed_156, 2.0f, -1.0f));
				precise float fragment_unnamed_171 = fragment_unnamed_164 + 1.0f;
				precise float fragment_unnamed_172 = fragment_unnamed_166 + 1.0f;
				precise float fragment_unnamed_173 = fragment_unnamed_168 + 1.0f;
				precise float fragment_unnamed_174 = fragment_unnamed_170 + 1.0f;
				precise float fragment_unnamed_179 = fragment_uniform_buffer_0[24u].x * 0.5f;
				precise float fragment_unnamed_180 = (-0.0f) - fragment_unnamed_179;
				float fragment_unnamed_184 = frac(abs(fragment_unnamed_179));
				precise float fragment_unnamed_185 = (-0.0f) - fragment_unnamed_184;
				bool fragment_unnamed_187 = ((fragment_unnamed_179 >= fragment_unnamed_180) ? fragment_unnamed_184 : fragment_unnamed_185) >= 0.5f;
				float fragment_unnamed_197 = asfloat(fragment_unnamed_187 ? asuint(fragment_unnamed_171) : asuint(fragment_unnamed_153));
				float fragment_unnamed_199 = asfloat(fragment_unnamed_187 ? asuint(fragment_unnamed_172) : asuint(fragment_unnamed_154));
				float fragment_unnamed_201 = asfloat(fragment_unnamed_187 ? asuint(fragment_unnamed_173) : asuint(fragment_unnamed_155));
				float fragment_unnamed_203 = asfloat(fragment_unnamed_187 ? asuint(fragment_unnamed_174) : asuint(fragment_unnamed_156));
				precise float fragment_unnamed_204 = fragment_unnamed_197 * 1.57079601287841796875f;
				precise float fragment_unnamed_206 = fragment_unnamed_199 * 1.57079601287841796875f;
				precise float fragment_unnamed_207 = fragment_unnamed_201 * 1.57079601287841796875f;
				precise float fragment_unnamed_208 = fragment_unnamed_203 * 1.57079601287841796875f;
				precise float fragment_unnamed_213 = (-0.0f) - fragment_unnamed_197;
				precise float fragment_unnamed_214 = (-0.0f) - fragment_unnamed_199;
				precise float fragment_unnamed_215 = (-0.0f) - fragment_unnamed_201;
				precise float fragment_unnamed_216 = (-0.0f) - fragment_unnamed_203;
				precise float fragment_unnamed_217 = fragment_unnamed_213 + sin(fragment_unnamed_204);
				precise float fragment_unnamed_218 = fragment_unnamed_214 + sin(fragment_unnamed_206);
				precise float fragment_unnamed_219 = fragment_unnamed_215 + sin(fragment_unnamed_207);
				precise float fragment_unnamed_220 = fragment_unnamed_216 + sin(fragment_unnamed_208);
				precise float fragment_unnamed_232 = (-0.0f) - fragment_uniform_buffer_0[9u].x;
				precise float fragment_unnamed_233 = fragment_unnamed_232 + 1.0f;
				precise float fragment_unnamed_238 = fragment_unnamed_146 * min(mad(fragment_uniform_buffer_0[9u].y, fragment_unnamed_217, fragment_unnamed_197), fragment_unnamed_233);
				precise float fragment_unnamed_239 = fragment_unnamed_146 * min(mad(fragment_uniform_buffer_0[9u].y, fragment_unnamed_219, fragment_unnamed_201), fragment_unnamed_233);
				precise float fragment_unnamed_240 = (-0.0f) - fragment_unnamed_239;
				precise float fragment_unnamed_241 = (-0.0f) - fragment_unnamed_238;
				float fragment_unnamed_242 = mad(min(mad(fragment_uniform_buffer_0[9u].y, fragment_unnamed_220, fragment_unnamed_203), fragment_unnamed_233), fragment_unnamed_146, fragment_unnamed_240);
				float fragment_unnamed_243 = mad(min(mad(fragment_uniform_buffer_0[9u].y, fragment_unnamed_218, fragment_unnamed_199), fragment_unnamed_233), fragment_unnamed_146, fragment_unnamed_241);
				float fragment_unnamed_244 = asfloat(3212836864u);
				float fragment_unnamed_246 = asfloat(1065353216u);
				float fragment_unnamed_251 = rsqrt(dot(float2(fragment_unnamed_244, fragment_unnamed_242), float2(fragment_unnamed_244, fragment_unnamed_242)));
				float fragment_unnamed_255 = rsqrt(dot(float2(fragment_unnamed_243, fragment_unnamed_246), float2(fragment_unnamed_243, fragment_unnamed_246)));
				precise float fragment_unnamed_256 = fragment_unnamed_255 * fragment_unnamed_243;
				precise float fragment_unnamed_257 = fragment_unnamed_255 * 1.0f;
				precise float fragment_unnamed_258 = fragment_unnamed_255 * 0.0f;
				precise float fragment_unnamed_260 = fragment_unnamed_251 * fragment_unnamed_244;
				precise float fragment_unnamed_261 = fragment_unnamed_251 * fragment_unnamed_242;
				precise float fragment_unnamed_262 = fragment_unnamed_251 * asfloat(0u);
				precise float fragment_unnamed_263 = fragment_unnamed_260 * fragment_unnamed_256;
				precise float fragment_unnamed_264 = fragment_unnamed_261 * fragment_unnamed_257;
				precise float fragment_unnamed_265 = fragment_unnamed_262 * fragment_unnamed_258;
				precise float fragment_unnamed_266 = (-0.0f) - fragment_unnamed_263;
				precise float fragment_unnamed_267 = (-0.0f) - fragment_unnamed_264;
				precise float fragment_unnamed_268 = (-0.0f) - fragment_unnamed_265;
				float4 fragment_unnamed_287 = _OutlineTex.Sample(sampler_OutlineTex, float2(mad(fragment_uniform_buffer_0[6u].z, fragment_uniform_buffer_1[0u].y, fragment_input_2.x), mad(fragment_uniform_buffer_0[6u].w, fragment_uniform_buffer_1[0u].y, fragment_input_2.y)));
				precise float fragment_unnamed_299 = fragment_unnamed_287.x * fragment_uniform_buffer_0[7u].x;
				precise float fragment_unnamed_300 = fragment_unnamed_287.y * fragment_uniform_buffer_0[7u].y;
				precise float fragment_unnamed_301 = fragment_unnamed_287.z * fragment_uniform_buffer_0[7u].z;
				precise float fragment_unnamed_308 = fragment_input_7.w * fragment_uniform_buffer_0[7u].w;
				precise float fragment_unnamed_309 = fragment_unnamed_287.w * fragment_unnamed_308;
				precise float fragment_unnamed_310 = fragment_unnamed_299 * fragment_unnamed_309;
				precise float fragment_unnamed_311 = fragment_unnamed_300 * fragment_unnamed_309;
				precise float fragment_unnamed_312 = fragment_unnamed_301 * fragment_unnamed_309;
				float4 fragment_unnamed_329 = _FaceTex.Sample(sampler_FaceTex, float2(mad(fragment_uniform_buffer_0[4u].x, fragment_uniform_buffer_1[0u].y, fragment_input_1.z), mad(fragment_uniform_buffer_0[4u].y, fragment_uniform_buffer_1[0u].y, fragment_input_1.w)));
				precise float fragment_unnamed_349 = fragment_input_7.x * fragment_uniform_buffer_0[5u].x;
				precise float fragment_unnamed_350 = fragment_input_7.y * fragment_uniform_buffer_0[5u].y;
				precise float fragment_unnamed_351 = fragment_input_7.z * fragment_uniform_buffer_0[5u].z;
				precise float fragment_unnamed_352 = fragment_input_7.w * fragment_uniform_buffer_0[5u].w;
				precise float fragment_unnamed_353 = fragment_unnamed_329.x * fragment_unnamed_349;
				precise float fragment_unnamed_354 = fragment_unnamed_329.y * fragment_unnamed_350;
				precise float fragment_unnamed_355 = fragment_unnamed_329.z * fragment_unnamed_351;
				precise float fragment_unnamed_356 = fragment_unnamed_329.w * fragment_unnamed_352;
				precise float fragment_unnamed_357 = fragment_unnamed_356 * fragment_unnamed_353;
				precise float fragment_unnamed_358 = fragment_unnamed_356 * fragment_unnamed_354;
				precise float fragment_unnamed_359 = fragment_unnamed_356 * fragment_unnamed_355;
				precise float fragment_unnamed_360 = (-0.0f) - fragment_unnamed_357;
				precise float fragment_unnamed_361 = (-0.0f) - fragment_unnamed_358;
				precise float fragment_unnamed_362 = (-0.0f) - fragment_unnamed_359;
				precise float fragment_unnamed_363 = (-0.0f) - fragment_unnamed_356;
				precise float fragment_unnamed_364 = fragment_unnamed_360 + fragment_unnamed_310;
				precise float fragment_unnamed_365 = fragment_unnamed_361 + fragment_unnamed_311;
				precise float fragment_unnamed_366 = fragment_unnamed_362 + fragment_unnamed_312;
				precise float fragment_unnamed_367 = fragment_unnamed_363 + fragment_unnamed_309;
				precise float fragment_unnamed_374 = fragment_uniform_buffer_0[8u].x * fragment_uniform_buffer_0[24u].w;
				precise float fragment_unnamed_377 = fragment_unnamed_374 * fragment_input_2.y;
				precise float fragment_unnamed_387 = (-0.0f) - _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y)).w;
				precise float fragment_unnamed_388 = fragment_unnamed_387 + 0.5f;
				precise float fragment_unnamed_391 = (-0.0f) - fragment_input_2.x;
				precise float fragment_unnamed_392 = fragment_unnamed_388 + fragment_unnamed_391;
				float fragment_unnamed_395 = mad(fragment_unnamed_392, fragment_input_2.y, 0.5f);
				float fragment_unnamed_397 = clamp(mad(fragment_unnamed_377, 0.5f, fragment_unnamed_395), 0.0f, 1.0f);
				precise float fragment_unnamed_398 = (-0.0f) - fragment_unnamed_377;
				precise float fragment_unnamed_400 = sqrt(min(fragment_unnamed_377, 1.0f)) * fragment_unnamed_397;
				precise float fragment_unnamed_411 = fragment_uniform_buffer_0[6u].y * fragment_uniform_buffer_0[24u].w;
				precise float fragment_unnamed_414 = fragment_unnamed_411 * fragment_input_2.y;
				precise float fragment_unnamed_419 = mad(fragment_unnamed_414, 0.5f, mad(fragment_unnamed_398, 0.5f, fragment_unnamed_395)) / mad(fragment_unnamed_411, fragment_input_2.y, 1.0f);
				precise float fragment_unnamed_421 = (-0.0f) - clamp(fragment_unnamed_419, 0.0f, 1.0f);
				precise float fragment_unnamed_422 = fragment_unnamed_421 + 1.0f;
				precise float fragment_unnamed_423 = fragment_unnamed_422 * mad(fragment_unnamed_400, fragment_unnamed_364, fragment_unnamed_357);
				precise float fragment_unnamed_424 = fragment_unnamed_422 * mad(fragment_unnamed_400, fragment_unnamed_365, fragment_unnamed_358);
				precise float fragment_unnamed_425 = fragment_unnamed_422 * mad(fragment_unnamed_400, fragment_unnamed_366, fragment_unnamed_359);
				precise float fragment_unnamed_426 = fragment_unnamed_422 * mad(fragment_unnamed_400, fragment_unnamed_367, fragment_unnamed_356);
				precise float fragment_unnamed_430 = (-0.0f) - fragment_uniform_buffer_0[9u].w;
				precise float fragment_unnamed_434 = fragment_unnamed_430 + fragment_uniform_buffer_0[9u].z;
				float fragment_unnamed_438 = mad(fragment_unnamed_397, fragment_unnamed_434, fragment_uniform_buffer_0[9u].w);
				float4 fragment_unnamed_444 = _BumpMap.Sample(sampler_BumpMap, float2(fragment_input_1.z, fragment_input_1.w));
				precise float fragment_unnamed_449 = fragment_unnamed_444.w * fragment_unnamed_444.x;
				float fragment_unnamed_450 = mad(fragment_unnamed_449, 2.0f, -1.0f);
				float fragment_unnamed_451 = mad(fragment_unnamed_444.y, 2.0f, -1.0f);
				precise float fragment_unnamed_456 = (-0.0f) - min(dot(float2(fragment_unnamed_450, fragment_unnamed_451), float2(fragment_unnamed_450, fragment_unnamed_451)), 1.0f);
				precise float fragment_unnamed_457 = fragment_unnamed_456 + 1.0f;
				precise float fragment_unnamed_465 = (-0.0f) - mad(fragment_unnamed_426, mad(fragment_unnamed_450, fragment_unnamed_438, -0.0f), 0.0f);
				precise float fragment_unnamed_466 = (-0.0f) - mad(fragment_unnamed_426, mad(fragment_unnamed_451, fragment_unnamed_438, -0.0f), 0.0f);
				precise float fragment_unnamed_467 = (-0.0f) - mad(fragment_unnamed_426, mad(sqrt(fragment_unnamed_457), fragment_unnamed_438, -1.0f), 1.0f);
				precise float fragment_unnamed_468 = mad(fragment_unnamed_258, fragment_unnamed_261, fragment_unnamed_266) + fragment_unnamed_465;
				precise float fragment_unnamed_469 = mad(fragment_unnamed_256, fragment_unnamed_262, fragment_unnamed_267) + fragment_unnamed_466;
				precise float fragment_unnamed_470 = mad(fragment_unnamed_257, fragment_unnamed_260, fragment_unnamed_268) + fragment_unnamed_467;
				float fragment_unnamed_474 = rsqrt(dot(float3(fragment_unnamed_468, fragment_unnamed_469, fragment_unnamed_470), float3(fragment_unnamed_468, fragment_unnamed_469, fragment_unnamed_470)));
				precise float fragment_unnamed_475 = fragment_unnamed_474 * fragment_unnamed_468;
				precise float fragment_unnamed_476 = fragment_unnamed_474 * fragment_unnamed_469;
				precise float fragment_unnamed_477 = fragment_unnamed_474 * fragment_unnamed_470;
				precise float fragment_unnamed_484 = (-0.0f) - fragment_unnamed_475;
				precise float fragment_unnamed_485 = (-0.0f) - fragment_unnamed_476;
				precise float fragment_unnamed_486 = (-0.0f) - fragment_unnamed_477;
				float fragment_unnamed_487 = dot(float3(fragment_input_3.x, fragment_input_3.y, fragment_input_3.z), float3(fragment_unnamed_484, fragment_unnamed_485, fragment_unnamed_486));
				precise float fragment_unnamed_496 = (-0.0f) - fragment_unnamed_475;
				precise float fragment_unnamed_497 = (-0.0f) - fragment_unnamed_476;
				precise float fragment_unnamed_498 = (-0.0f) - fragment_unnamed_477;
				float fragment_unnamed_499 = dot(float3(fragment_input_4.x, fragment_input_4.y, fragment_input_4.z), float3(fragment_unnamed_496, fragment_unnamed_497, fragment_unnamed_498));
				precise float fragment_unnamed_508 = (-0.0f) - fragment_unnamed_475;
				precise float fragment_unnamed_509 = (-0.0f) - fragment_unnamed_476;
				precise float fragment_unnamed_510 = (-0.0f) - fragment_unnamed_477;
				float fragment_unnamed_511 = dot(float3(fragment_input_5.x, fragment_input_5.y, fragment_input_5.z), float3(fragment_unnamed_508, fragment_unnamed_509, fragment_unnamed_510));
				float fragment_unnamed_517 = rsqrt(dot(float3(fragment_unnamed_487, fragment_unnamed_499, fragment_unnamed_511), float3(fragment_unnamed_487, fragment_unnamed_499, fragment_unnamed_511)));
				precise float fragment_unnamed_518 = fragment_unnamed_517 * fragment_unnamed_487;
				precise float fragment_unnamed_519 = fragment_unnamed_517 * fragment_unnamed_499;
				precise float fragment_unnamed_520 = fragment_unnamed_517 * fragment_unnamed_511;
				precise float fragment_unnamed_523 = (-0.0f) - fragment_input_6.x;
				precise float fragment_unnamed_526 = (-0.0f) - fragment_input_6.y;
				precise float fragment_unnamed_529 = (-0.0f) - fragment_input_6.z;
				precise float fragment_unnamed_535 = fragment_unnamed_523 + fragment_uniform_buffer_1[4u].x;
				precise float fragment_unnamed_536 = fragment_unnamed_526 + fragment_uniform_buffer_1[4u].y;
				precise float fragment_unnamed_537 = fragment_unnamed_529 + fragment_uniform_buffer_1[4u].z;
				float fragment_unnamed_541 = rsqrt(dot(float3(fragment_unnamed_535, fragment_unnamed_536, fragment_unnamed_537), float3(fragment_unnamed_535, fragment_unnamed_536, fragment_unnamed_537)));
				float fragment_unnamed_547 = mad(fragment_unnamed_535, fragment_unnamed_541, fragment_uniform_buffer_2[0u].x);
				float fragment_unnamed_548 = mad(fragment_unnamed_536, fragment_unnamed_541, fragment_uniform_buffer_2[0u].y);
				float fragment_unnamed_549 = mad(fragment_unnamed_537, fragment_unnamed_541, fragment_uniform_buffer_2[0u].z);
				float fragment_unnamed_553 = rsqrt(dot(float3(fragment_unnamed_547, fragment_unnamed_548, fragment_unnamed_549), float3(fragment_unnamed_547, fragment_unnamed_548, fragment_unnamed_549)));
				precise float fragment_unnamed_554 = fragment_unnamed_553 * fragment_unnamed_547;
				precise float fragment_unnamed_555 = fragment_unnamed_553 * fragment_unnamed_548;
				precise float fragment_unnamed_556 = fragment_unnamed_553 * fragment_unnamed_549;
				float fragment_unnamed_568 = max(dot(float3(fragment_unnamed_518, fragment_unnamed_519, fragment_unnamed_520), float3(fragment_uniform_buffer_2[0u].xyz)), 0.0f);
				precise float fragment_unnamed_575 = (-0.0f) - fragment_uniform_buffer_0[31u].y;
				precise float fragment_unnamed_579 = fragment_unnamed_575 + fragment_uniform_buffer_0[31u].z;
				precise float fragment_unnamed_584 = mad(fragment_unnamed_397, fragment_unnamed_579, fragment_uniform_buffer_0[31u].y) * 128.0f;
				precise float fragment_unnamed_586 = log2(max(dot(float3(fragment_unnamed_518, fragment_unnamed_519, fragment_unnamed_520), float3(fragment_unnamed_554, fragment_unnamed_555, fragment_unnamed_556)), 0.0f)) * fragment_unnamed_584;
				float fragment_unnamed_587 = exp2(fragment_unnamed_586);
				precise float fragment_unnamed_598 = fragment_uniform_buffer_0[2u].x * fragment_uniform_buffer_0[3u].x;
				precise float fragment_unnamed_599 = fragment_uniform_buffer_0[2u].y * fragment_uniform_buffer_0[3u].y;
				precise float fragment_unnamed_600 = fragment_uniform_buffer_0[2u].z * fragment_uniform_buffer_0[3u].z;
				precise float fragment_unnamed_601 = fragment_unnamed_587 * fragment_unnamed_598;
				precise float fragment_unnamed_602 = fragment_unnamed_587 * fragment_unnamed_599;
				precise float fragment_unnamed_603 = fragment_unnamed_587 * fragment_unnamed_600;
				float fragment_unnamed_604 = max(fragment_unnamed_426, 9.9999997473787516355514526367188e-05f);
				precise float fragment_unnamed_606 = fragment_unnamed_423 / fragment_unnamed_604;
				precise float fragment_unnamed_607 = fragment_unnamed_424 / fragment_unnamed_604;
				precise float fragment_unnamed_608 = fragment_unnamed_425 / fragment_unnamed_604;
				fragment_output_0.w = fragment_unnamed_426;
				precise float fragment_unnamed_616 = fragment_unnamed_606 * fragment_uniform_buffer_0[2u].x;
				precise float fragment_unnamed_617 = fragment_unnamed_607 * fragment_uniform_buffer_0[2u].y;
				precise float fragment_unnamed_618 = fragment_unnamed_608 * fragment_uniform_buffer_0[2u].z;
				fragment_output_0.x = mad(fragment_unnamed_616, fragment_unnamed_568, fragment_unnamed_601);
				fragment_output_0.y = mad(fragment_unnamed_617, fragment_unnamed_568, fragment_unnamed_602);
				fragment_output_0.z = mad(fragment_unnamed_618, fragment_unnamed_568, fragment_unnamed_603);
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[2] = float4(_LightColor0[0], _LightColor0[1], _LightColor0[2], _LightColor0[3]);

				fragment_uniform_buffer_0[3] = float4(_SpecColor[0], _SpecColor[1], _SpecColor[2], _SpecColor[3]);

				fragment_uniform_buffer_0[4] = float4(_FaceUVSpeedX, fragment_uniform_buffer_0[4][1], fragment_uniform_buffer_0[4][2], fragment_uniform_buffer_0[4][3]);

				fragment_uniform_buffer_0[4] = float4(fragment_uniform_buffer_0[4][0], _FaceUVSpeedY, fragment_uniform_buffer_0[4][2], fragment_uniform_buffer_0[4][3]);

				fragment_uniform_buffer_0[5] = float4(_FaceColor[0], _FaceColor[1], _FaceColor[2], _FaceColor[3]);

				fragment_uniform_buffer_0[6] = float4(fragment_uniform_buffer_0[6][0], _OutlineSoftness, fragment_uniform_buffer_0[6][2], fragment_uniform_buffer_0[6][3]);

				fragment_uniform_buffer_0[6] = float4(fragment_uniform_buffer_0[6][0], fragment_uniform_buffer_0[6][1], _OutlineUVSpeedX, fragment_uniform_buffer_0[6][3]);

				fragment_uniform_buffer_0[6] = float4(fragment_uniform_buffer_0[6][0], fragment_uniform_buffer_0[6][1], fragment_uniform_buffer_0[6][2], _OutlineUVSpeedY);

				fragment_uniform_buffer_0[7] = float4(_OutlineColor[0], _OutlineColor[1], _OutlineColor[2], _OutlineColor[3]);

				fragment_uniform_buffer_0[8] = float4(_OutlineWidth, fragment_uniform_buffer_0[8][1], fragment_uniform_buffer_0[8][2], fragment_uniform_buffer_0[8][3]);

				fragment_uniform_buffer_0[8] = float4(fragment_uniform_buffer_0[8][0], _Bevel, fragment_uniform_buffer_0[8][2], fragment_uniform_buffer_0[8][3]);

				fragment_uniform_buffer_0[8] = float4(fragment_uniform_buffer_0[8][0], fragment_uniform_buffer_0[8][1], _BevelOffset, fragment_uniform_buffer_0[8][3]);

				fragment_uniform_buffer_0[8] = float4(fragment_uniform_buffer_0[8][0], fragment_uniform_buffer_0[8][1], fragment_uniform_buffer_0[8][2], _BevelWidth);

				fragment_uniform_buffer_0[9] = float4(_BevelClamp, fragment_uniform_buffer_0[9][1], fragment_uniform_buffer_0[9][2], fragment_uniform_buffer_0[9][3]);

				fragment_uniform_buffer_0[9] = float4(fragment_uniform_buffer_0[9][0], _BevelRoundness, fragment_uniform_buffer_0[9][2], fragment_uniform_buffer_0[9][3]);

				fragment_uniform_buffer_0[9] = float4(fragment_uniform_buffer_0[9][0], fragment_uniform_buffer_0[9][1], _BumpOutline, fragment_uniform_buffer_0[9][3]);

				fragment_uniform_buffer_0[9] = float4(fragment_uniform_buffer_0[9][0], fragment_uniform_buffer_0[9][1], fragment_uniform_buffer_0[9][2], _BumpFace);

				fragment_uniform_buffer_0[24] = float4(_ShaderFlags, fragment_uniform_buffer_0[24][1], fragment_uniform_buffer_0[24][2], fragment_uniform_buffer_0[24][3]);

				fragment_uniform_buffer_0[24] = float4(fragment_uniform_buffer_0[24][0], fragment_uniform_buffer_0[24][1], fragment_uniform_buffer_0[24][2], _ScaleRatioA);

				fragment_uniform_buffer_0[29] = float4(fragment_uniform_buffer_0[29][0], fragment_uniform_buffer_0[29][1], _TextureWidth, fragment_uniform_buffer_0[29][3]);

				fragment_uniform_buffer_0[29] = float4(fragment_uniform_buffer_0[29][0], fragment_uniform_buffer_0[29][1], fragment_uniform_buffer_0[29][2], _TextureHeight);

				fragment_uniform_buffer_0[30] = float4(_GradientScale, fragment_uniform_buffer_0[30][1], fragment_uniform_buffer_0[30][2], fragment_uniform_buffer_0[30][3]);

				fragment_uniform_buffer_0[31] = float4(fragment_uniform_buffer_0[31][0], _FaceShininess, fragment_uniform_buffer_0[31][2], fragment_uniform_buffer_0[31][3]);

				fragment_uniform_buffer_0[31] = float4(fragment_uniform_buffer_0[31][0], fragment_uniform_buffer_0[31][1], _OutlineShininess, fragment_uniform_buffer_0[31][3]);

				fragment_uniform_buffer_1[0] = float4(_Time[0], _Time[1], _Time[2], _Time[3]);

				fragment_uniform_buffer_1[4] = float4(_WorldSpaceCameraPos[0], _WorldSpaceCameraPos[1], _WorldSpaceCameraPos[2], fragment_uniform_buffer_1[4][3]);

				fragment_uniform_buffer_2[0] = float4(_WorldSpaceLightPos0[0], _WorldSpaceLightPos0[1], _WorldSpaceLightPos0[2], _WorldSpaceLightPos0[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				fragment_input_6 = stage_input.fragment_input_6;
				fragment_input_7 = stage_input.fragment_input_7;
				fragment_input_8 = stage_input.fragment_input_8;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // DIRECTIONAL
			#endif // !DIRECTIONAL_COOKIE
			#endif // !POINT
			#endif // !POINT_COOKIE
			#endif // !SPOT


			#ifdef SPOT
			#ifndef DIRECTIONAL
			#ifndef DIRECTIONAL_COOKIE
			#ifndef POINT
			#ifndef POINT_COOKIE
			#define ANY_SHADER_VARIANT_ACTIVE

			float4 _LightColor0;
			float4 _SpecColor;
			float4x4 unity_WorldToLight;
			float _FaceUVSpeedX;
			float _FaceUVSpeedY;
			float4 _FaceColor;
			float _OutlineSoftness;
			float _OutlineUVSpeedX;
			float _OutlineUVSpeedY;
			float4 _OutlineColor;
			float _OutlineWidth;
			float _Bevel;
			float _BevelOffset;
			float _BevelWidth;
			float _BevelClamp;
			float _BevelRoundness;
			float _BumpOutline;
			float _BumpFace;
			float _ShaderFlags;
			float _ScaleRatioA;
			float _TextureWidth;
			float _TextureHeight;
			float _GradientScale;
			float _FaceShininess;
			float _OutlineShininess;
			float4 _Time;
			float3 _WorldSpaceCameraPos;
			float4 _WorldSpaceLightPos0;

			static float4 fragment_uniform_buffer_0[36];
			static float4 fragment_uniform_buffer_1[5];
			static float4 fragment_uniform_buffer_2[1];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _FaceTex;
			Texture2D<float4> _OutlineTex;
			Texture2D<float4> _BumpMap;
			Texture2D<float4> _LightTexture0;
			Texture2D<float4> _LightTextureB0;
			SamplerState sampler_LightTexture0;
			SamplerState sampler_LightTextureB0;
			SamplerState sampler_FaceTex;
			SamplerState sampler_OutlineTex;
			SamplerState sampler_BumpMap;
			SamplerState sampler_MainTex;

			static float4 fragment_input_1;
			static float2 fragment_input_2;
			static float2 fragment_input_2;
			static float3 fragment_input_3;
			static float3 fragment_input_4;
			static float3 fragment_input_5;
			static float3 fragment_input_6;
			static float4 fragment_input_7;
			static float3 fragment_input_8;
			static float4 fragment_input_9;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : TEXCOORD; // TEXCOORD
				float2 fragment_input_2 : TEXCOORD1; // TEXCOORD_1
				float2 fragment_input_2 : TEXCOORD6; // TEXCOORD_6
				float3 fragment_input_3 : TEXCOORD2; // TEXCOORD_2
				float3 fragment_input_4 : TEXCOORD3; // TEXCOORD_3
				float3 fragment_input_5 : TEXCOORD4; // TEXCOORD_4
				float3 fragment_input_6 : TEXCOORD5; // TEXCOORD_5
				float4 fragment_input_7 : COLOR; // COLOR
				float3 fragment_input_8 : TEXCOORD7; // TEXCOORD_7
				float4 fragment_input_9 : TEXCOORD8; // TEXCOORD_8
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				precise float fragment_unnamed_78 = fragment_input_2.x + fragment_uniform_buffer_0[12u].z;
				precise float fragment_unnamed_84 = 1.0f / fragment_uniform_buffer_0[33u].z;
				precise float fragment_unnamed_86 = 1.0f / fragment_uniform_buffer_0[33u].w;
				float fragment_unnamed_87 = asfloat(0u);
				precise float fragment_unnamed_88 = (-0.0f) - fragment_unnamed_84;
				precise float fragment_unnamed_90 = (-0.0f) - fragment_unnamed_87;
				precise float fragment_unnamed_91 = (-0.0f) - fragment_unnamed_86;
				precise float fragment_unnamed_96 = fragment_unnamed_88 + fragment_input_1.x;
				precise float fragment_unnamed_97 = fragment_unnamed_90 + fragment_input_1.y;
				precise float fragment_unnamed_98 = fragment_unnamed_90 + fragment_input_1.x;
				precise float fragment_unnamed_99 = fragment_unnamed_91 + fragment_input_1.y;
				precise float fragment_unnamed_104 = fragment_unnamed_84 + fragment_input_1.x;
				precise float fragment_unnamed_105 = fragment_unnamed_87 + fragment_input_1.y;
				precise float fragment_unnamed_106 = fragment_unnamed_87 + fragment_input_1.x;
				precise float fragment_unnamed_107 = fragment_unnamed_86 + fragment_input_1.y;
				precise float fragment_unnamed_123 = fragment_unnamed_78 + _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_96, fragment_unnamed_97)).w;
				precise float fragment_unnamed_124 = fragment_unnamed_78 + _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_104, fragment_unnamed_105)).w;
				precise float fragment_unnamed_125 = fragment_unnamed_78 + _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_98, fragment_unnamed_99)).w;
				precise float fragment_unnamed_126 = fragment_unnamed_78 + _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_106, fragment_unnamed_107)).w;
				precise float fragment_unnamed_127 = fragment_unnamed_123 + (-0.5f);
				precise float fragment_unnamed_129 = fragment_unnamed_124 + (-0.5f);
				precise float fragment_unnamed_130 = fragment_unnamed_125 + (-0.5f);
				precise float fragment_unnamed_131 = fragment_unnamed_126 + (-0.5f);
				precise float fragment_unnamed_138 = fragment_uniform_buffer_0[12u].w + fragment_uniform_buffer_0[12u].x;
				float fragment_unnamed_140 = max(fragment_unnamed_138, 0.00999999977648258209228515625f);
				precise float fragment_unnamed_142 = fragment_unnamed_127 / fragment_unnamed_140;
				precise float fragment_unnamed_143 = fragment_unnamed_129 / fragment_unnamed_140;
				precise float fragment_unnamed_144 = fragment_unnamed_130 / fragment_unnamed_140;
				precise float fragment_unnamed_145 = fragment_unnamed_131 / fragment_unnamed_140;
				precise float fragment_unnamed_149 = fragment_unnamed_140 * fragment_uniform_buffer_0[12u].y;
				precise float fragment_unnamed_154 = fragment_unnamed_149 * fragment_uniform_buffer_0[34u].x;
				precise float fragment_unnamed_155 = fragment_unnamed_154 * (-2.0f);
				precise float fragment_unnamed_157 = fragment_unnamed_142 + 0.5f;
				precise float fragment_unnamed_159 = fragment_unnamed_143 + 0.5f;
				precise float fragment_unnamed_160 = fragment_unnamed_144 + 0.5f;
				precise float fragment_unnamed_161 = fragment_unnamed_145 + 0.5f;
				float fragment_unnamed_162 = clamp(fragment_unnamed_157, 0.0f, 1.0f);
				float fragment_unnamed_163 = clamp(fragment_unnamed_159, 0.0f, 1.0f);
				float fragment_unnamed_164 = clamp(fragment_unnamed_160, 0.0f, 1.0f);
				float fragment_unnamed_165 = clamp(fragment_unnamed_161, 0.0f, 1.0f);
				precise float fragment_unnamed_173 = (-0.0f) - abs(mad(fragment_unnamed_162, 2.0f, -1.0f));
				precise float fragment_unnamed_175 = (-0.0f) - abs(mad(fragment_unnamed_163, 2.0f, -1.0f));
				precise float fragment_unnamed_177 = (-0.0f) - abs(mad(fragment_unnamed_164, 2.0f, -1.0f));
				precise float fragment_unnamed_179 = (-0.0f) - abs(mad(fragment_unnamed_165, 2.0f, -1.0f));
				precise float fragment_unnamed_180 = fragment_unnamed_173 + 1.0f;
				precise float fragment_unnamed_181 = fragment_unnamed_175 + 1.0f;
				precise float fragment_unnamed_182 = fragment_unnamed_177 + 1.0f;
				precise float fragment_unnamed_183 = fragment_unnamed_179 + 1.0f;
				precise float fragment_unnamed_188 = fragment_uniform_buffer_0[28u].x * 0.5f;
				precise float fragment_unnamed_189 = (-0.0f) - fragment_unnamed_188;
				float fragment_unnamed_193 = frac(abs(fragment_unnamed_188));
				precise float fragment_unnamed_194 = (-0.0f) - fragment_unnamed_193;
				bool fragment_unnamed_196 = ((fragment_unnamed_188 >= fragment_unnamed_189) ? fragment_unnamed_193 : fragment_unnamed_194) >= 0.5f;
				float fragment_unnamed_206 = asfloat(fragment_unnamed_196 ? asuint(fragment_unnamed_180) : asuint(fragment_unnamed_162));
				float fragment_unnamed_208 = asfloat(fragment_unnamed_196 ? asuint(fragment_unnamed_181) : asuint(fragment_unnamed_163));
				float fragment_unnamed_210 = asfloat(fragment_unnamed_196 ? asuint(fragment_unnamed_182) : asuint(fragment_unnamed_164));
				float fragment_unnamed_212 = asfloat(fragment_unnamed_196 ? asuint(fragment_unnamed_183) : asuint(fragment_unnamed_165));
				precise float fragment_unnamed_213 = fragment_unnamed_206 * 1.57079601287841796875f;
				precise float fragment_unnamed_215 = fragment_unnamed_208 * 1.57079601287841796875f;
				precise float fragment_unnamed_216 = fragment_unnamed_210 * 1.57079601287841796875f;
				precise float fragment_unnamed_217 = fragment_unnamed_212 * 1.57079601287841796875f;
				precise float fragment_unnamed_222 = (-0.0f) - fragment_unnamed_206;
				precise float fragment_unnamed_223 = (-0.0f) - fragment_unnamed_208;
				precise float fragment_unnamed_224 = (-0.0f) - fragment_unnamed_210;
				precise float fragment_unnamed_225 = (-0.0f) - fragment_unnamed_212;
				precise float fragment_unnamed_226 = fragment_unnamed_222 + sin(fragment_unnamed_213);
				precise float fragment_unnamed_227 = fragment_unnamed_223 + sin(fragment_unnamed_215);
				precise float fragment_unnamed_228 = fragment_unnamed_224 + sin(fragment_unnamed_216);
				precise float fragment_unnamed_229 = fragment_unnamed_225 + sin(fragment_unnamed_217);
				precise float fragment_unnamed_241 = (-0.0f) - fragment_uniform_buffer_0[13u].x;
				precise float fragment_unnamed_242 = fragment_unnamed_241 + 1.0f;
				precise float fragment_unnamed_247 = fragment_unnamed_155 * min(mad(fragment_uniform_buffer_0[13u].y, fragment_unnamed_226, fragment_unnamed_206), fragment_unnamed_242);
				precise float fragment_unnamed_248 = fragment_unnamed_155 * min(mad(fragment_uniform_buffer_0[13u].y, fragment_unnamed_228, fragment_unnamed_210), fragment_unnamed_242);
				precise float fragment_unnamed_249 = (-0.0f) - fragment_unnamed_248;
				precise float fragment_unnamed_250 = (-0.0f) - fragment_unnamed_247;
				float fragment_unnamed_251 = mad(min(mad(fragment_uniform_buffer_0[13u].y, fragment_unnamed_229, fragment_unnamed_212), fragment_unnamed_242), fragment_unnamed_155, fragment_unnamed_249);
				float fragment_unnamed_252 = mad(min(mad(fragment_uniform_buffer_0[13u].y, fragment_unnamed_227, fragment_unnamed_208), fragment_unnamed_242), fragment_unnamed_155, fragment_unnamed_250);
				float fragment_unnamed_253 = asfloat(3212836864u);
				float fragment_unnamed_255 = asfloat(1065353216u);
				float fragment_unnamed_260 = rsqrt(dot(float2(fragment_unnamed_253, fragment_unnamed_251), float2(fragment_unnamed_253, fragment_unnamed_251)));
				float fragment_unnamed_264 = rsqrt(dot(float2(fragment_unnamed_252, fragment_unnamed_255), float2(fragment_unnamed_252, fragment_unnamed_255)));
				precise float fragment_unnamed_265 = fragment_unnamed_264 * fragment_unnamed_252;
				precise float fragment_unnamed_266 = fragment_unnamed_264 * 1.0f;
				precise float fragment_unnamed_267 = fragment_unnamed_264 * 0.0f;
				precise float fragment_unnamed_269 = fragment_unnamed_260 * fragment_unnamed_253;
				precise float fragment_unnamed_270 = fragment_unnamed_260 * fragment_unnamed_251;
				precise float fragment_unnamed_271 = fragment_unnamed_260 * asfloat(0u);
				precise float fragment_unnamed_272 = fragment_unnamed_269 * fragment_unnamed_265;
				precise float fragment_unnamed_273 = fragment_unnamed_270 * fragment_unnamed_266;
				precise float fragment_unnamed_274 = fragment_unnamed_271 * fragment_unnamed_267;
				precise float fragment_unnamed_275 = (-0.0f) - fragment_unnamed_272;
				precise float fragment_unnamed_276 = (-0.0f) - fragment_unnamed_273;
				precise float fragment_unnamed_277 = (-0.0f) - fragment_unnamed_274;
				float4 fragment_unnamed_296 = _OutlineTex.Sample(sampler_OutlineTex, float2(mad(fragment_uniform_buffer_0[10u].z, fragment_uniform_buffer_1[0u].y, fragment_input_2.x), mad(fragment_uniform_buffer_0[10u].w, fragment_uniform_buffer_1[0u].y, fragment_input_2.y)));
				precise float fragment_unnamed_308 = fragment_unnamed_296.x * fragment_uniform_buffer_0[11u].x;
				precise float fragment_unnamed_309 = fragment_unnamed_296.y * fragment_uniform_buffer_0[11u].y;
				precise float fragment_unnamed_310 = fragment_unnamed_296.z * fragment_uniform_buffer_0[11u].z;
				precise float fragment_unnamed_317 = fragment_input_7.w * fragment_uniform_buffer_0[11u].w;
				precise float fragment_unnamed_318 = fragment_unnamed_296.w * fragment_unnamed_317;
				precise float fragment_unnamed_319 = fragment_unnamed_308 * fragment_unnamed_318;
				precise float fragment_unnamed_320 = fragment_unnamed_309 * fragment_unnamed_318;
				precise float fragment_unnamed_321 = fragment_unnamed_310 * fragment_unnamed_318;
				float4 fragment_unnamed_338 = _FaceTex.Sample(sampler_FaceTex, float2(mad(fragment_uniform_buffer_0[8u].x, fragment_uniform_buffer_1[0u].y, fragment_input_1.z), mad(fragment_uniform_buffer_0[8u].y, fragment_uniform_buffer_1[0u].y, fragment_input_1.w)));
				precise float fragment_unnamed_359 = fragment_input_7.x * fragment_uniform_buffer_0[9u].x;
				precise float fragment_unnamed_360 = fragment_input_7.y * fragment_uniform_buffer_0[9u].y;
				precise float fragment_unnamed_361 = fragment_input_7.z * fragment_uniform_buffer_0[9u].z;
				precise float fragment_unnamed_362 = fragment_input_7.w * fragment_uniform_buffer_0[9u].w;
				precise float fragment_unnamed_363 = fragment_unnamed_338.x * fragment_unnamed_359;
				precise float fragment_unnamed_364 = fragment_unnamed_338.y * fragment_unnamed_360;
				precise float fragment_unnamed_365 = fragment_unnamed_338.z * fragment_unnamed_361;
				precise float fragment_unnamed_366 = fragment_unnamed_338.w * fragment_unnamed_362;
				precise float fragment_unnamed_367 = fragment_unnamed_366 * fragment_unnamed_363;
				precise float fragment_unnamed_368 = fragment_unnamed_366 * fragment_unnamed_364;
				precise float fragment_unnamed_369 = fragment_unnamed_366 * fragment_unnamed_365;
				precise float fragment_unnamed_370 = (-0.0f) - fragment_unnamed_367;
				precise float fragment_unnamed_371 = (-0.0f) - fragment_unnamed_368;
				precise float fragment_unnamed_372 = (-0.0f) - fragment_unnamed_369;
				precise float fragment_unnamed_373 = (-0.0f) - fragment_unnamed_366;
				precise float fragment_unnamed_374 = fragment_unnamed_370 + fragment_unnamed_319;
				precise float fragment_unnamed_375 = fragment_unnamed_371 + fragment_unnamed_320;
				precise float fragment_unnamed_376 = fragment_unnamed_372 + fragment_unnamed_321;
				precise float fragment_unnamed_377 = fragment_unnamed_373 + fragment_unnamed_318;
				precise float fragment_unnamed_384 = fragment_uniform_buffer_0[12u].x * fragment_uniform_buffer_0[28u].w;
				precise float fragment_unnamed_387 = fragment_unnamed_384 * fragment_input_2.y;
				precise float fragment_unnamed_397 = (-0.0f) - _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y)).w;
				precise float fragment_unnamed_398 = fragment_unnamed_397 + 0.5f;
				precise float fragment_unnamed_401 = (-0.0f) - fragment_input_2.x;
				precise float fragment_unnamed_402 = fragment_unnamed_398 + fragment_unnamed_401;
				float fragment_unnamed_405 = mad(fragment_unnamed_402, fragment_input_2.y, 0.5f);
				float fragment_unnamed_407 = clamp(mad(fragment_unnamed_387, 0.5f, fragment_unnamed_405), 0.0f, 1.0f);
				precise float fragment_unnamed_408 = (-0.0f) - fragment_unnamed_387;
				precise float fragment_unnamed_410 = sqrt(min(fragment_unnamed_387, 1.0f)) * fragment_unnamed_407;
				precise float fragment_unnamed_421 = fragment_uniform_buffer_0[10u].y * fragment_uniform_buffer_0[28u].w;
				precise float fragment_unnamed_424 = fragment_unnamed_421 * fragment_input_2.y;
				precise float fragment_unnamed_429 = mad(fragment_unnamed_424, 0.5f, mad(fragment_unnamed_408, 0.5f, fragment_unnamed_405)) / mad(fragment_unnamed_421, fragment_input_2.y, 1.0f);
				precise float fragment_unnamed_431 = (-0.0f) - clamp(fragment_unnamed_429, 0.0f, 1.0f);
				precise float fragment_unnamed_432 = fragment_unnamed_431 + 1.0f;
				precise float fragment_unnamed_433 = fragment_unnamed_432 * mad(fragment_unnamed_410, fragment_unnamed_374, fragment_unnamed_367);
				precise float fragment_unnamed_434 = fragment_unnamed_432 * mad(fragment_unnamed_410, fragment_unnamed_375, fragment_unnamed_368);
				precise float fragment_unnamed_435 = fragment_unnamed_432 * mad(fragment_unnamed_410, fragment_unnamed_376, fragment_unnamed_369);
				precise float fragment_unnamed_436 = fragment_unnamed_432 * mad(fragment_unnamed_410, fragment_unnamed_377, fragment_unnamed_366);
				precise float fragment_unnamed_440 = (-0.0f) - fragment_uniform_buffer_0[13u].w;
				precise float fragment_unnamed_444 = fragment_unnamed_440 + fragment_uniform_buffer_0[13u].z;
				float fragment_unnamed_448 = mad(fragment_unnamed_407, fragment_unnamed_444, fragment_uniform_buffer_0[13u].w);
				float4 fragment_unnamed_454 = _BumpMap.Sample(sampler_BumpMap, float2(fragment_input_1.z, fragment_input_1.w));
				precise float fragment_unnamed_459 = fragment_unnamed_454.w * fragment_unnamed_454.x;
				float fragment_unnamed_460 = mad(fragment_unnamed_459, 2.0f, -1.0f);
				float fragment_unnamed_461 = mad(fragment_unnamed_454.y, 2.0f, -1.0f);
				precise float fragment_unnamed_466 = (-0.0f) - min(dot(float2(fragment_unnamed_460, fragment_unnamed_461), float2(fragment_unnamed_460, fragment_unnamed_461)), 1.0f);
				precise float fragment_unnamed_467 = fragment_unnamed_466 + 1.0f;
				precise float fragment_unnamed_475 = (-0.0f) - mad(fragment_unnamed_436, mad(fragment_unnamed_460, fragment_unnamed_448, -0.0f), 0.0f);
				precise float fragment_unnamed_476 = (-0.0f) - mad(fragment_unnamed_436, mad(fragment_unnamed_461, fragment_unnamed_448, -0.0f), 0.0f);
				precise float fragment_unnamed_477 = (-0.0f) - mad(fragment_unnamed_436, mad(sqrt(fragment_unnamed_467), fragment_unnamed_448, -1.0f), 1.0f);
				precise float fragment_unnamed_478 = mad(fragment_unnamed_267, fragment_unnamed_270, fragment_unnamed_275) + fragment_unnamed_475;
				precise float fragment_unnamed_479 = mad(fragment_unnamed_265, fragment_unnamed_271, fragment_unnamed_276) + fragment_unnamed_476;
				precise float fragment_unnamed_480 = mad(fragment_unnamed_266, fragment_unnamed_269, fragment_unnamed_277) + fragment_unnamed_477;
				float fragment_unnamed_484 = rsqrt(dot(float3(fragment_unnamed_478, fragment_unnamed_479, fragment_unnamed_480), float3(fragment_unnamed_478, fragment_unnamed_479, fragment_unnamed_480)));
				precise float fragment_unnamed_485 = fragment_unnamed_484 * fragment_unnamed_478;
				precise float fragment_unnamed_486 = fragment_unnamed_484 * fragment_unnamed_479;
				precise float fragment_unnamed_487 = fragment_unnamed_484 * fragment_unnamed_480;
				precise float fragment_unnamed_494 = (-0.0f) - fragment_unnamed_485;
				precise float fragment_unnamed_495 = (-0.0f) - fragment_unnamed_486;
				precise float fragment_unnamed_496 = (-0.0f) - fragment_unnamed_487;
				float fragment_unnamed_497 = dot(float3(fragment_input_3.x, fragment_input_3.y, fragment_input_3.z), float3(fragment_unnamed_494, fragment_unnamed_495, fragment_unnamed_496));
				precise float fragment_unnamed_506 = (-0.0f) - fragment_unnamed_485;
				precise float fragment_unnamed_507 = (-0.0f) - fragment_unnamed_486;
				precise float fragment_unnamed_508 = (-0.0f) - fragment_unnamed_487;
				float fragment_unnamed_509 = dot(float3(fragment_input_4.x, fragment_input_4.y, fragment_input_4.z), float3(fragment_unnamed_506, fragment_unnamed_507, fragment_unnamed_508));
				precise float fragment_unnamed_518 = (-0.0f) - fragment_unnamed_485;
				precise float fragment_unnamed_519 = (-0.0f) - fragment_unnamed_486;
				precise float fragment_unnamed_520 = (-0.0f) - fragment_unnamed_487;
				float fragment_unnamed_521 = dot(float3(fragment_input_5.x, fragment_input_5.y, fragment_input_5.z), float3(fragment_unnamed_518, fragment_unnamed_519, fragment_unnamed_520));
				float fragment_unnamed_527 = rsqrt(dot(float3(fragment_unnamed_497, fragment_unnamed_509, fragment_unnamed_521), float3(fragment_unnamed_497, fragment_unnamed_509, fragment_unnamed_521)));
				precise float fragment_unnamed_528 = fragment_unnamed_527 * fragment_unnamed_497;
				precise float fragment_unnamed_529 = fragment_unnamed_527 * fragment_unnamed_509;
				precise float fragment_unnamed_530 = fragment_unnamed_527 * fragment_unnamed_521;
				precise float fragment_unnamed_533 = (-0.0f) - fragment_input_6.x;
				precise float fragment_unnamed_536 = (-0.0f) - fragment_input_6.y;
				precise float fragment_unnamed_539 = (-0.0f) - fragment_input_6.z;
				precise float fragment_unnamed_545 = fragment_unnamed_533 + fragment_uniform_buffer_2[0u].x;
				precise float fragment_unnamed_546 = fragment_unnamed_536 + fragment_uniform_buffer_2[0u].y;
				precise float fragment_unnamed_547 = fragment_unnamed_539 + fragment_uniform_buffer_2[0u].z;
				float fragment_unnamed_551 = rsqrt(dot(float3(fragment_unnamed_545, fragment_unnamed_546, fragment_unnamed_547), float3(fragment_unnamed_545, fragment_unnamed_546, fragment_unnamed_547)));
				precise float fragment_unnamed_552 = fragment_unnamed_551 * fragment_unnamed_545;
				precise float fragment_unnamed_553 = fragment_unnamed_551 * fragment_unnamed_546;
				precise float fragment_unnamed_554 = fragment_unnamed_551 * fragment_unnamed_547;
				precise float fragment_unnamed_557 = (-0.0f) - fragment_input_6.x;
				precise float fragment_unnamed_560 = (-0.0f) - fragment_input_6.y;
				precise float fragment_unnamed_563 = (-0.0f) - fragment_input_6.z;
				precise float fragment_unnamed_570 = fragment_unnamed_557 + fragment_uniform_buffer_1[4u].x;
				precise float fragment_unnamed_571 = fragment_unnamed_560 + fragment_uniform_buffer_1[4u].y;
				precise float fragment_unnamed_572 = fragment_unnamed_563 + fragment_uniform_buffer_1[4u].z;
				float fragment_unnamed_576 = rsqrt(dot(float3(fragment_unnamed_570, fragment_unnamed_571, fragment_unnamed_572), float3(fragment_unnamed_570, fragment_unnamed_571, fragment_unnamed_572)));
				float fragment_unnamed_577 = mad(fragment_unnamed_570, fragment_unnamed_576, fragment_unnamed_552);
				float fragment_unnamed_578 = mad(fragment_unnamed_571, fragment_unnamed_576, fragment_unnamed_553);
				float fragment_unnamed_579 = mad(fragment_unnamed_572, fragment_unnamed_576, fragment_unnamed_554);
				float fragment_unnamed_586 = rsqrt(dot(float3(fragment_unnamed_577, fragment_unnamed_578, fragment_unnamed_579), float3(fragment_unnamed_577, fragment_unnamed_578, fragment_unnamed_579)));
				precise float fragment_unnamed_587 = fragment_unnamed_586 * fragment_unnamed_577;
				precise float fragment_unnamed_588 = fragment_unnamed_586 * fragment_unnamed_578;
				precise float fragment_unnamed_589 = fragment_unnamed_586 * fragment_unnamed_579;
				float fragment_unnamed_594 = max(dot(float3(fragment_unnamed_528, fragment_unnamed_529, fragment_unnamed_530), float3(fragment_unnamed_552, fragment_unnamed_553, fragment_unnamed_554)), 0.0f);
				precise float fragment_unnamed_600 = (-0.0f) - fragment_uniform_buffer_0[35u].y;
				precise float fragment_unnamed_604 = fragment_unnamed_600 + fragment_uniform_buffer_0[35u].z;
				precise float fragment_unnamed_609 = mad(fragment_unnamed_407, fragment_unnamed_604, fragment_uniform_buffer_0[35u].y) * 128.0f;
				precise float fragment_unnamed_611 = log2(max(dot(float3(fragment_unnamed_528, fragment_unnamed_529, fragment_unnamed_530), float3(fragment_unnamed_587, fragment_unnamed_588, fragment_unnamed_589)), 0.0f)) * fragment_unnamed_609;
				float fragment_unnamed_612 = exp2(fragment_unnamed_611);
				precise float fragment_unnamed_621 = fragment_input_6.y * fragment_uniform_buffer_0[5u].x;
				precise float fragment_unnamed_622 = fragment_input_6.y * fragment_uniform_buffer_0[5u].y;
				precise float fragment_unnamed_623 = fragment_input_6.y * fragment_uniform_buffer_0[5u].z;
				precise float fragment_unnamed_624 = fragment_input_6.y * fragment_uniform_buffer_0[5u].w;
				precise float fragment_unnamed_657 = mad(fragment_uniform_buffer_0[6u].x, fragment_input_6.z, mad(fragment_uniform_buffer_0[4u].x, fragment_input_6.x, fragment_unnamed_621)) + fragment_uniform_buffer_0[7u].x;
				precise float fragment_unnamed_658 = mad(fragment_uniform_buffer_0[6u].y, fragment_input_6.z, mad(fragment_uniform_buffer_0[4u].y, fragment_input_6.x, fragment_unnamed_622)) + fragment_uniform_buffer_0[7u].y;
				precise float fragment_unnamed_659 = mad(fragment_uniform_buffer_0[6u].z, fragment_input_6.z, mad(fragment_uniform_buffer_0[4u].z, fragment_input_6.x, fragment_unnamed_623)) + fragment_uniform_buffer_0[7u].z;
				precise float fragment_unnamed_660 = mad(fragment_uniform_buffer_0[6u].w, fragment_input_6.z, mad(fragment_uniform_buffer_0[4u].w, fragment_input_6.x, fragment_unnamed_624)) + fragment_uniform_buffer_0[7u].w;
				precise float fragment_unnamed_661 = fragment_unnamed_657 / fragment_unnamed_660;
				precise float fragment_unnamed_662 = fragment_unnamed_658 / fragment_unnamed_660;
				precise float fragment_unnamed_663 = fragment_unnamed_661 + 0.5f;
				precise float fragment_unnamed_664 = fragment_unnamed_662 + 0.5f;
				precise float fragment_unnamed_681 = _LightTexture0.Sample(sampler_LightTexture0, float2(fragment_unnamed_663, fragment_unnamed_664)).w * asfloat(((0.0f < fragment_unnamed_659) ? 4294967295u : 0u) & 1065353216u);
				precise float fragment_unnamed_682 = _LightTextureB0.Sample(sampler_LightTextureB0, dot(float3(fragment_unnamed_657, fragment_unnamed_658, fragment_unnamed_659), float3(fragment_unnamed_657, fragment_unnamed_658, fragment_unnamed_659)).xx).x * fragment_unnamed_681;
				precise float fragment_unnamed_688 = fragment_unnamed_682 * fragment_uniform_buffer_0[2u].x;
				precise float fragment_unnamed_689 = fragment_unnamed_682 * fragment_uniform_buffer_0[2u].y;
				precise float fragment_unnamed_690 = fragment_unnamed_682 * fragment_uniform_buffer_0[2u].z;
				precise float fragment_unnamed_696 = fragment_unnamed_688 * fragment_uniform_buffer_0[3u].x;
				precise float fragment_unnamed_697 = fragment_unnamed_689 * fragment_uniform_buffer_0[3u].y;
				precise float fragment_unnamed_698 = fragment_unnamed_690 * fragment_uniform_buffer_0[3u].z;
				precise float fragment_unnamed_699 = fragment_unnamed_612 * fragment_unnamed_696;
				precise float fragment_unnamed_700 = fragment_unnamed_612 * fragment_unnamed_697;
				precise float fragment_unnamed_701 = fragment_unnamed_612 * fragment_unnamed_698;
				float fragment_unnamed_702 = max(fragment_unnamed_436, 9.9999997473787516355514526367188e-05f);
				precise float fragment_unnamed_704 = fragment_unnamed_433 / fragment_unnamed_702;
				precise float fragment_unnamed_705 = fragment_unnamed_434 / fragment_unnamed_702;
				precise float fragment_unnamed_706 = fragment_unnamed_435 / fragment_unnamed_702;
				fragment_output_0.w = fragment_unnamed_436;
				precise float fragment_unnamed_709 = fragment_unnamed_688 * fragment_unnamed_704;
				precise float fragment_unnamed_710 = fragment_unnamed_689 * fragment_unnamed_705;
				precise float fragment_unnamed_711 = fragment_unnamed_690 * fragment_unnamed_706;
				fragment_output_0.x = mad(fragment_unnamed_709, fragment_unnamed_594, fragment_unnamed_699);
				fragment_output_0.y = mad(fragment_unnamed_710, fragment_unnamed_594, fragment_unnamed_700);
				fragment_output_0.z = mad(fragment_unnamed_711, fragment_unnamed_594, fragment_unnamed_701);
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[2] = float4(_LightColor0[0], _LightColor0[1], _LightColor0[2], _LightColor0[3]);

				fragment_uniform_buffer_0[3] = float4(_SpecColor[0], _SpecColor[1], _SpecColor[2], _SpecColor[3]);

				fragment_uniform_buffer_0[4] = float4(unity_WorldToLight[0][0], unity_WorldToLight[1][0], unity_WorldToLight[2][0], unity_WorldToLight[3][0]);
				fragment_uniform_buffer_0[5] = float4(unity_WorldToLight[0][1], unity_WorldToLight[1][1], unity_WorldToLight[2][1], unity_WorldToLight[3][1]);
				fragment_uniform_buffer_0[6] = float4(unity_WorldToLight[0][2], unity_WorldToLight[1][2], unity_WorldToLight[2][2], unity_WorldToLight[3][2]);
				fragment_uniform_buffer_0[7] = float4(unity_WorldToLight[0][3], unity_WorldToLight[1][3], unity_WorldToLight[2][3], unity_WorldToLight[3][3]);

				fragment_uniform_buffer_0[8] = float4(_FaceUVSpeedX, fragment_uniform_buffer_0[8][1], fragment_uniform_buffer_0[8][2], fragment_uniform_buffer_0[8][3]);

				fragment_uniform_buffer_0[8] = float4(fragment_uniform_buffer_0[8][0], _FaceUVSpeedY, fragment_uniform_buffer_0[8][2], fragment_uniform_buffer_0[8][3]);

				fragment_uniform_buffer_0[9] = float4(_FaceColor[0], _FaceColor[1], _FaceColor[2], _FaceColor[3]);

				fragment_uniform_buffer_0[10] = float4(fragment_uniform_buffer_0[10][0], _OutlineSoftness, fragment_uniform_buffer_0[10][2], fragment_uniform_buffer_0[10][3]);

				fragment_uniform_buffer_0[10] = float4(fragment_uniform_buffer_0[10][0], fragment_uniform_buffer_0[10][1], _OutlineUVSpeedX, fragment_uniform_buffer_0[10][3]);

				fragment_uniform_buffer_0[10] = float4(fragment_uniform_buffer_0[10][0], fragment_uniform_buffer_0[10][1], fragment_uniform_buffer_0[10][2], _OutlineUVSpeedY);

				fragment_uniform_buffer_0[11] = float4(_OutlineColor[0], _OutlineColor[1], _OutlineColor[2], _OutlineColor[3]);

				fragment_uniform_buffer_0[12] = float4(_OutlineWidth, fragment_uniform_buffer_0[12][1], fragment_uniform_buffer_0[12][2], fragment_uniform_buffer_0[12][3]);

				fragment_uniform_buffer_0[12] = float4(fragment_uniform_buffer_0[12][0], _Bevel, fragment_uniform_buffer_0[12][2], fragment_uniform_buffer_0[12][3]);

				fragment_uniform_buffer_0[12] = float4(fragment_uniform_buffer_0[12][0], fragment_uniform_buffer_0[12][1], _BevelOffset, fragment_uniform_buffer_0[12][3]);

				fragment_uniform_buffer_0[12] = float4(fragment_uniform_buffer_0[12][0], fragment_uniform_buffer_0[12][1], fragment_uniform_buffer_0[12][2], _BevelWidth);

				fragment_uniform_buffer_0[13] = float4(_BevelClamp, fragment_uniform_buffer_0[13][1], fragment_uniform_buffer_0[13][2], fragment_uniform_buffer_0[13][3]);

				fragment_uniform_buffer_0[13] = float4(fragment_uniform_buffer_0[13][0], _BevelRoundness, fragment_uniform_buffer_0[13][2], fragment_uniform_buffer_0[13][3]);

				fragment_uniform_buffer_0[13] = float4(fragment_uniform_buffer_0[13][0], fragment_uniform_buffer_0[13][1], _BumpOutline, fragment_uniform_buffer_0[13][3]);

				fragment_uniform_buffer_0[13] = float4(fragment_uniform_buffer_0[13][0], fragment_uniform_buffer_0[13][1], fragment_uniform_buffer_0[13][2], _BumpFace);

				fragment_uniform_buffer_0[28] = float4(_ShaderFlags, fragment_uniform_buffer_0[28][1], fragment_uniform_buffer_0[28][2], fragment_uniform_buffer_0[28][3]);

				fragment_uniform_buffer_0[28] = float4(fragment_uniform_buffer_0[28][0], fragment_uniform_buffer_0[28][1], fragment_uniform_buffer_0[28][2], _ScaleRatioA);

				fragment_uniform_buffer_0[33] = float4(fragment_uniform_buffer_0[33][0], fragment_uniform_buffer_0[33][1], _TextureWidth, fragment_uniform_buffer_0[33][3]);

				fragment_uniform_buffer_0[33] = float4(fragment_uniform_buffer_0[33][0], fragment_uniform_buffer_0[33][1], fragment_uniform_buffer_0[33][2], _TextureHeight);

				fragment_uniform_buffer_0[34] = float4(_GradientScale, fragment_uniform_buffer_0[34][1], fragment_uniform_buffer_0[34][2], fragment_uniform_buffer_0[34][3]);

				fragment_uniform_buffer_0[35] = float4(fragment_uniform_buffer_0[35][0], _FaceShininess, fragment_uniform_buffer_0[35][2], fragment_uniform_buffer_0[35][3]);

				fragment_uniform_buffer_0[35] = float4(fragment_uniform_buffer_0[35][0], fragment_uniform_buffer_0[35][1], _OutlineShininess, fragment_uniform_buffer_0[35][3]);

				fragment_uniform_buffer_1[0] = float4(_Time[0], _Time[1], _Time[2], _Time[3]);

				fragment_uniform_buffer_1[4] = float4(_WorldSpaceCameraPos[0], _WorldSpaceCameraPos[1], _WorldSpaceCameraPos[2], fragment_uniform_buffer_1[4][3]);

				fragment_uniform_buffer_2[0] = float4(_WorldSpaceLightPos0[0], _WorldSpaceLightPos0[1], _WorldSpaceLightPos0[2], _WorldSpaceLightPos0[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				fragment_input_6 = stage_input.fragment_input_6;
				fragment_input_7 = stage_input.fragment_input_7;
				fragment_input_8 = stage_input.fragment_input_8;
				fragment_input_9 = stage_input.fragment_input_9;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // SPOT
			#endif // !DIRECTIONAL
			#endif // !DIRECTIONAL_COOKIE
			#endif // !POINT
			#endif // !POINT_COOKIE


			#ifdef POINT_COOKIE
			#ifndef DIRECTIONAL
			#ifndef DIRECTIONAL_COOKIE
			#ifndef POINT
			#ifndef SPOT
			#define ANY_SHADER_VARIANT_ACTIVE

			float4 _LightColor0;
			float4 _SpecColor;
			float4x4 unity_WorldToLight;
			float _FaceUVSpeedX;
			float _FaceUVSpeedY;
			float4 _FaceColor;
			float _OutlineSoftness;
			float _OutlineUVSpeedX;
			float _OutlineUVSpeedY;
			float4 _OutlineColor;
			float _OutlineWidth;
			float _Bevel;
			float _BevelOffset;
			float _BevelWidth;
			float _BevelClamp;
			float _BevelRoundness;
			float _BumpOutline;
			float _BumpFace;
			float _ShaderFlags;
			float _ScaleRatioA;
			float _TextureWidth;
			float _TextureHeight;
			float _GradientScale;
			float _FaceShininess;
			float _OutlineShininess;
			float4 _Time;
			float3 _WorldSpaceCameraPos;
			float4 _WorldSpaceLightPos0;

			static float4 fragment_uniform_buffer_0[36];
			static float4 fragment_uniform_buffer_1[5];
			static float4 fragment_uniform_buffer_2[1];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _FaceTex;
			Texture2D<float4> _OutlineTex;
			Texture2D<float4> _BumpMap;
			Texture2D<float4> _LightTextureB0;
			TextureCube<float4> _LightTexture0;
			SamplerState sampler_LightTexture0;
			SamplerState sampler_LightTextureB0;
			SamplerState sampler_FaceTex;
			SamplerState sampler_OutlineTex;
			SamplerState sampler_BumpMap;
			SamplerState sampler_MainTex;

			static float4 fragment_input_1;
			static float2 fragment_input_2;
			static float2 fragment_input_2;
			static float3 fragment_input_3;
			static float3 fragment_input_4;
			static float3 fragment_input_5;
			static float3 fragment_input_6;
			static float4 fragment_input_7;
			static float3 fragment_input_8;
			static float3 fragment_input_9;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : TEXCOORD; // TEXCOORD
				float2 fragment_input_2 : TEXCOORD1; // TEXCOORD_1
				float2 fragment_input_2 : TEXCOORD6; // TEXCOORD_6
				float3 fragment_input_3 : TEXCOORD2; // TEXCOORD_2
				float3 fragment_input_4 : TEXCOORD3; // TEXCOORD_3
				float3 fragment_input_5 : TEXCOORD4; // TEXCOORD_4
				float3 fragment_input_6 : TEXCOORD5; // TEXCOORD_5
				float4 fragment_input_7 : COLOR; // COLOR
				float3 fragment_input_8 : TEXCOORD7; // TEXCOORD_7
				float3 fragment_input_9 : TEXCOORD8; // TEXCOORD_8
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				precise float fragment_unnamed_80 = fragment_input_2.x + fragment_uniform_buffer_0[12u].z;
				precise float fragment_unnamed_86 = 1.0f / fragment_uniform_buffer_0[33u].z;
				precise float fragment_unnamed_88 = 1.0f / fragment_uniform_buffer_0[33u].w;
				float fragment_unnamed_89 = asfloat(0u);
				precise float fragment_unnamed_90 = (-0.0f) - fragment_unnamed_86;
				precise float fragment_unnamed_92 = (-0.0f) - fragment_unnamed_89;
				precise float fragment_unnamed_93 = (-0.0f) - fragment_unnamed_88;
				precise float fragment_unnamed_98 = fragment_unnamed_90 + fragment_input_1.x;
				precise float fragment_unnamed_99 = fragment_unnamed_92 + fragment_input_1.y;
				precise float fragment_unnamed_100 = fragment_unnamed_92 + fragment_input_1.x;
				precise float fragment_unnamed_101 = fragment_unnamed_93 + fragment_input_1.y;
				precise float fragment_unnamed_106 = fragment_unnamed_86 + fragment_input_1.x;
				precise float fragment_unnamed_107 = fragment_unnamed_89 + fragment_input_1.y;
				precise float fragment_unnamed_108 = fragment_unnamed_89 + fragment_input_1.x;
				precise float fragment_unnamed_109 = fragment_unnamed_88 + fragment_input_1.y;
				precise float fragment_unnamed_125 = fragment_unnamed_80 + _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_98, fragment_unnamed_99)).w;
				precise float fragment_unnamed_126 = fragment_unnamed_80 + _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_106, fragment_unnamed_107)).w;
				precise float fragment_unnamed_127 = fragment_unnamed_80 + _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_100, fragment_unnamed_101)).w;
				precise float fragment_unnamed_128 = fragment_unnamed_80 + _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_108, fragment_unnamed_109)).w;
				precise float fragment_unnamed_129 = fragment_unnamed_125 + (-0.5f);
				precise float fragment_unnamed_131 = fragment_unnamed_126 + (-0.5f);
				precise float fragment_unnamed_132 = fragment_unnamed_127 + (-0.5f);
				precise float fragment_unnamed_133 = fragment_unnamed_128 + (-0.5f);
				precise float fragment_unnamed_140 = fragment_uniform_buffer_0[12u].w + fragment_uniform_buffer_0[12u].x;
				float fragment_unnamed_142 = max(fragment_unnamed_140, 0.00999999977648258209228515625f);
				precise float fragment_unnamed_144 = fragment_unnamed_129 / fragment_unnamed_142;
				precise float fragment_unnamed_145 = fragment_unnamed_131 / fragment_unnamed_142;
				precise float fragment_unnamed_146 = fragment_unnamed_132 / fragment_unnamed_142;
				precise float fragment_unnamed_147 = fragment_unnamed_133 / fragment_unnamed_142;
				precise float fragment_unnamed_151 = fragment_unnamed_142 * fragment_uniform_buffer_0[12u].y;
				precise float fragment_unnamed_156 = fragment_unnamed_151 * fragment_uniform_buffer_0[34u].x;
				precise float fragment_unnamed_157 = fragment_unnamed_156 * (-2.0f);
				precise float fragment_unnamed_159 = fragment_unnamed_144 + 0.5f;
				precise float fragment_unnamed_161 = fragment_unnamed_145 + 0.5f;
				precise float fragment_unnamed_162 = fragment_unnamed_146 + 0.5f;
				precise float fragment_unnamed_163 = fragment_unnamed_147 + 0.5f;
				float fragment_unnamed_164 = clamp(fragment_unnamed_159, 0.0f, 1.0f);
				float fragment_unnamed_165 = clamp(fragment_unnamed_161, 0.0f, 1.0f);
				float fragment_unnamed_166 = clamp(fragment_unnamed_162, 0.0f, 1.0f);
				float fragment_unnamed_167 = clamp(fragment_unnamed_163, 0.0f, 1.0f);
				precise float fragment_unnamed_175 = (-0.0f) - abs(mad(fragment_unnamed_164, 2.0f, -1.0f));
				precise float fragment_unnamed_177 = (-0.0f) - abs(mad(fragment_unnamed_165, 2.0f, -1.0f));
				precise float fragment_unnamed_179 = (-0.0f) - abs(mad(fragment_unnamed_166, 2.0f, -1.0f));
				precise float fragment_unnamed_181 = (-0.0f) - abs(mad(fragment_unnamed_167, 2.0f, -1.0f));
				precise float fragment_unnamed_182 = fragment_unnamed_175 + 1.0f;
				precise float fragment_unnamed_183 = fragment_unnamed_177 + 1.0f;
				precise float fragment_unnamed_184 = fragment_unnamed_179 + 1.0f;
				precise float fragment_unnamed_185 = fragment_unnamed_181 + 1.0f;
				precise float fragment_unnamed_190 = fragment_uniform_buffer_0[28u].x * 0.5f;
				precise float fragment_unnamed_191 = (-0.0f) - fragment_unnamed_190;
				float fragment_unnamed_195 = frac(abs(fragment_unnamed_190));
				precise float fragment_unnamed_196 = (-0.0f) - fragment_unnamed_195;
				bool fragment_unnamed_198 = ((fragment_unnamed_190 >= fragment_unnamed_191) ? fragment_unnamed_195 : fragment_unnamed_196) >= 0.5f;
				float fragment_unnamed_208 = asfloat(fragment_unnamed_198 ? asuint(fragment_unnamed_182) : asuint(fragment_unnamed_164));
				float fragment_unnamed_210 = asfloat(fragment_unnamed_198 ? asuint(fragment_unnamed_183) : asuint(fragment_unnamed_165));
				float fragment_unnamed_212 = asfloat(fragment_unnamed_198 ? asuint(fragment_unnamed_184) : asuint(fragment_unnamed_166));
				float fragment_unnamed_214 = asfloat(fragment_unnamed_198 ? asuint(fragment_unnamed_185) : asuint(fragment_unnamed_167));
				precise float fragment_unnamed_215 = fragment_unnamed_208 * 1.57079601287841796875f;
				precise float fragment_unnamed_217 = fragment_unnamed_210 * 1.57079601287841796875f;
				precise float fragment_unnamed_218 = fragment_unnamed_212 * 1.57079601287841796875f;
				precise float fragment_unnamed_219 = fragment_unnamed_214 * 1.57079601287841796875f;
				precise float fragment_unnamed_224 = (-0.0f) - fragment_unnamed_208;
				precise float fragment_unnamed_225 = (-0.0f) - fragment_unnamed_210;
				precise float fragment_unnamed_226 = (-0.0f) - fragment_unnamed_212;
				precise float fragment_unnamed_227 = (-0.0f) - fragment_unnamed_214;
				precise float fragment_unnamed_228 = fragment_unnamed_224 + sin(fragment_unnamed_215);
				precise float fragment_unnamed_229 = fragment_unnamed_225 + sin(fragment_unnamed_217);
				precise float fragment_unnamed_230 = fragment_unnamed_226 + sin(fragment_unnamed_218);
				precise float fragment_unnamed_231 = fragment_unnamed_227 + sin(fragment_unnamed_219);
				precise float fragment_unnamed_243 = (-0.0f) - fragment_uniform_buffer_0[13u].x;
				precise float fragment_unnamed_244 = fragment_unnamed_243 + 1.0f;
				precise float fragment_unnamed_249 = fragment_unnamed_157 * min(mad(fragment_uniform_buffer_0[13u].y, fragment_unnamed_228, fragment_unnamed_208), fragment_unnamed_244);
				precise float fragment_unnamed_250 = fragment_unnamed_157 * min(mad(fragment_uniform_buffer_0[13u].y, fragment_unnamed_230, fragment_unnamed_212), fragment_unnamed_244);
				precise float fragment_unnamed_251 = (-0.0f) - fragment_unnamed_250;
				precise float fragment_unnamed_252 = (-0.0f) - fragment_unnamed_249;
				float fragment_unnamed_253 = mad(min(mad(fragment_uniform_buffer_0[13u].y, fragment_unnamed_231, fragment_unnamed_214), fragment_unnamed_244), fragment_unnamed_157, fragment_unnamed_251);
				float fragment_unnamed_254 = mad(min(mad(fragment_uniform_buffer_0[13u].y, fragment_unnamed_229, fragment_unnamed_210), fragment_unnamed_244), fragment_unnamed_157, fragment_unnamed_252);
				float fragment_unnamed_255 = asfloat(3212836864u);
				float fragment_unnamed_257 = asfloat(1065353216u);
				float fragment_unnamed_262 = rsqrt(dot(float2(fragment_unnamed_255, fragment_unnamed_253), float2(fragment_unnamed_255, fragment_unnamed_253)));
				float fragment_unnamed_266 = rsqrt(dot(float2(fragment_unnamed_254, fragment_unnamed_257), float2(fragment_unnamed_254, fragment_unnamed_257)));
				precise float fragment_unnamed_267 = fragment_unnamed_266 * fragment_unnamed_254;
				precise float fragment_unnamed_268 = fragment_unnamed_266 * 1.0f;
				precise float fragment_unnamed_269 = fragment_unnamed_266 * 0.0f;
				precise float fragment_unnamed_271 = fragment_unnamed_262 * fragment_unnamed_255;
				precise float fragment_unnamed_272 = fragment_unnamed_262 * fragment_unnamed_253;
				precise float fragment_unnamed_273 = fragment_unnamed_262 * asfloat(0u);
				precise float fragment_unnamed_274 = fragment_unnamed_271 * fragment_unnamed_267;
				precise float fragment_unnamed_275 = fragment_unnamed_272 * fragment_unnamed_268;
				precise float fragment_unnamed_276 = fragment_unnamed_273 * fragment_unnamed_269;
				precise float fragment_unnamed_277 = (-0.0f) - fragment_unnamed_274;
				precise float fragment_unnamed_278 = (-0.0f) - fragment_unnamed_275;
				precise float fragment_unnamed_279 = (-0.0f) - fragment_unnamed_276;
				float4 fragment_unnamed_298 = _OutlineTex.Sample(sampler_OutlineTex, float2(mad(fragment_uniform_buffer_0[10u].z, fragment_uniform_buffer_1[0u].y, fragment_input_2.x), mad(fragment_uniform_buffer_0[10u].w, fragment_uniform_buffer_1[0u].y, fragment_input_2.y)));
				precise float fragment_unnamed_310 = fragment_unnamed_298.x * fragment_uniform_buffer_0[11u].x;
				precise float fragment_unnamed_311 = fragment_unnamed_298.y * fragment_uniform_buffer_0[11u].y;
				precise float fragment_unnamed_312 = fragment_unnamed_298.z * fragment_uniform_buffer_0[11u].z;
				precise float fragment_unnamed_319 = fragment_input_7.w * fragment_uniform_buffer_0[11u].w;
				precise float fragment_unnamed_320 = fragment_unnamed_298.w * fragment_unnamed_319;
				precise float fragment_unnamed_321 = fragment_unnamed_310 * fragment_unnamed_320;
				precise float fragment_unnamed_322 = fragment_unnamed_311 * fragment_unnamed_320;
				precise float fragment_unnamed_323 = fragment_unnamed_312 * fragment_unnamed_320;
				float4 fragment_unnamed_340 = _FaceTex.Sample(sampler_FaceTex, float2(mad(fragment_uniform_buffer_0[8u].x, fragment_uniform_buffer_1[0u].y, fragment_input_1.z), mad(fragment_uniform_buffer_0[8u].y, fragment_uniform_buffer_1[0u].y, fragment_input_1.w)));
				precise float fragment_unnamed_361 = fragment_input_7.x * fragment_uniform_buffer_0[9u].x;
				precise float fragment_unnamed_362 = fragment_input_7.y * fragment_uniform_buffer_0[9u].y;
				precise float fragment_unnamed_363 = fragment_input_7.z * fragment_uniform_buffer_0[9u].z;
				precise float fragment_unnamed_364 = fragment_input_7.w * fragment_uniform_buffer_0[9u].w;
				precise float fragment_unnamed_365 = fragment_unnamed_340.x * fragment_unnamed_361;
				precise float fragment_unnamed_366 = fragment_unnamed_340.y * fragment_unnamed_362;
				precise float fragment_unnamed_367 = fragment_unnamed_340.z * fragment_unnamed_363;
				precise float fragment_unnamed_368 = fragment_unnamed_340.w * fragment_unnamed_364;
				precise float fragment_unnamed_369 = fragment_unnamed_368 * fragment_unnamed_365;
				precise float fragment_unnamed_370 = fragment_unnamed_368 * fragment_unnamed_366;
				precise float fragment_unnamed_371 = fragment_unnamed_368 * fragment_unnamed_367;
				precise float fragment_unnamed_372 = (-0.0f) - fragment_unnamed_369;
				precise float fragment_unnamed_373 = (-0.0f) - fragment_unnamed_370;
				precise float fragment_unnamed_374 = (-0.0f) - fragment_unnamed_371;
				precise float fragment_unnamed_375 = (-0.0f) - fragment_unnamed_368;
				precise float fragment_unnamed_376 = fragment_unnamed_372 + fragment_unnamed_321;
				precise float fragment_unnamed_377 = fragment_unnamed_373 + fragment_unnamed_322;
				precise float fragment_unnamed_378 = fragment_unnamed_374 + fragment_unnamed_323;
				precise float fragment_unnamed_379 = fragment_unnamed_375 + fragment_unnamed_320;
				precise float fragment_unnamed_386 = fragment_uniform_buffer_0[12u].x * fragment_uniform_buffer_0[28u].w;
				precise float fragment_unnamed_389 = fragment_unnamed_386 * fragment_input_2.y;
				precise float fragment_unnamed_399 = (-0.0f) - _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y)).w;
				precise float fragment_unnamed_400 = fragment_unnamed_399 + 0.5f;
				precise float fragment_unnamed_403 = (-0.0f) - fragment_input_2.x;
				precise float fragment_unnamed_404 = fragment_unnamed_400 + fragment_unnamed_403;
				float fragment_unnamed_407 = mad(fragment_unnamed_404, fragment_input_2.y, 0.5f);
				float fragment_unnamed_409 = clamp(mad(fragment_unnamed_389, 0.5f, fragment_unnamed_407), 0.0f, 1.0f);
				precise float fragment_unnamed_410 = (-0.0f) - fragment_unnamed_389;
				precise float fragment_unnamed_412 = sqrt(min(fragment_unnamed_389, 1.0f)) * fragment_unnamed_409;
				precise float fragment_unnamed_423 = fragment_uniform_buffer_0[10u].y * fragment_uniform_buffer_0[28u].w;
				precise float fragment_unnamed_426 = fragment_unnamed_423 * fragment_input_2.y;
				precise float fragment_unnamed_431 = mad(fragment_unnamed_426, 0.5f, mad(fragment_unnamed_410, 0.5f, fragment_unnamed_407)) / mad(fragment_unnamed_423, fragment_input_2.y, 1.0f);
				precise float fragment_unnamed_433 = (-0.0f) - clamp(fragment_unnamed_431, 0.0f, 1.0f);
				precise float fragment_unnamed_434 = fragment_unnamed_433 + 1.0f;
				precise float fragment_unnamed_435 = fragment_unnamed_434 * mad(fragment_unnamed_412, fragment_unnamed_376, fragment_unnamed_369);
				precise float fragment_unnamed_436 = fragment_unnamed_434 * mad(fragment_unnamed_412, fragment_unnamed_377, fragment_unnamed_370);
				precise float fragment_unnamed_437 = fragment_unnamed_434 * mad(fragment_unnamed_412, fragment_unnamed_378, fragment_unnamed_371);
				precise float fragment_unnamed_438 = fragment_unnamed_434 * mad(fragment_unnamed_412, fragment_unnamed_379, fragment_unnamed_368);
				precise float fragment_unnamed_442 = (-0.0f) - fragment_uniform_buffer_0[13u].w;
				precise float fragment_unnamed_446 = fragment_unnamed_442 + fragment_uniform_buffer_0[13u].z;
				float fragment_unnamed_450 = mad(fragment_unnamed_409, fragment_unnamed_446, fragment_uniform_buffer_0[13u].w);
				float4 fragment_unnamed_456 = _BumpMap.Sample(sampler_BumpMap, float2(fragment_input_1.z, fragment_input_1.w));
				precise float fragment_unnamed_461 = fragment_unnamed_456.w * fragment_unnamed_456.x;
				float fragment_unnamed_462 = mad(fragment_unnamed_461, 2.0f, -1.0f);
				float fragment_unnamed_463 = mad(fragment_unnamed_456.y, 2.0f, -1.0f);
				precise float fragment_unnamed_468 = (-0.0f) - min(dot(float2(fragment_unnamed_462, fragment_unnamed_463), float2(fragment_unnamed_462, fragment_unnamed_463)), 1.0f);
				precise float fragment_unnamed_469 = fragment_unnamed_468 + 1.0f;
				precise float fragment_unnamed_477 = (-0.0f) - mad(fragment_unnamed_438, mad(fragment_unnamed_462, fragment_unnamed_450, -0.0f), 0.0f);
				precise float fragment_unnamed_478 = (-0.0f) - mad(fragment_unnamed_438, mad(fragment_unnamed_463, fragment_unnamed_450, -0.0f), 0.0f);
				precise float fragment_unnamed_479 = (-0.0f) - mad(fragment_unnamed_438, mad(sqrt(fragment_unnamed_469), fragment_unnamed_450, -1.0f), 1.0f);
				precise float fragment_unnamed_480 = mad(fragment_unnamed_269, fragment_unnamed_272, fragment_unnamed_277) + fragment_unnamed_477;
				precise float fragment_unnamed_481 = mad(fragment_unnamed_267, fragment_unnamed_273, fragment_unnamed_278) + fragment_unnamed_478;
				precise float fragment_unnamed_482 = mad(fragment_unnamed_268, fragment_unnamed_271, fragment_unnamed_279) + fragment_unnamed_479;
				float fragment_unnamed_486 = rsqrt(dot(float3(fragment_unnamed_480, fragment_unnamed_481, fragment_unnamed_482), float3(fragment_unnamed_480, fragment_unnamed_481, fragment_unnamed_482)));
				precise float fragment_unnamed_487 = fragment_unnamed_486 * fragment_unnamed_480;
				precise float fragment_unnamed_488 = fragment_unnamed_486 * fragment_unnamed_481;
				precise float fragment_unnamed_489 = fragment_unnamed_486 * fragment_unnamed_482;
				precise float fragment_unnamed_496 = (-0.0f) - fragment_unnamed_487;
				precise float fragment_unnamed_497 = (-0.0f) - fragment_unnamed_488;
				precise float fragment_unnamed_498 = (-0.0f) - fragment_unnamed_489;
				float fragment_unnamed_499 = dot(float3(fragment_input_3.x, fragment_input_3.y, fragment_input_3.z), float3(fragment_unnamed_496, fragment_unnamed_497, fragment_unnamed_498));
				precise float fragment_unnamed_508 = (-0.0f) - fragment_unnamed_487;
				precise float fragment_unnamed_509 = (-0.0f) - fragment_unnamed_488;
				precise float fragment_unnamed_510 = (-0.0f) - fragment_unnamed_489;
				float fragment_unnamed_511 = dot(float3(fragment_input_4.x, fragment_input_4.y, fragment_input_4.z), float3(fragment_unnamed_508, fragment_unnamed_509, fragment_unnamed_510));
				precise float fragment_unnamed_520 = (-0.0f) - fragment_unnamed_487;
				precise float fragment_unnamed_521 = (-0.0f) - fragment_unnamed_488;
				precise float fragment_unnamed_522 = (-0.0f) - fragment_unnamed_489;
				float fragment_unnamed_523 = dot(float3(fragment_input_5.x, fragment_input_5.y, fragment_input_5.z), float3(fragment_unnamed_520, fragment_unnamed_521, fragment_unnamed_522));
				float fragment_unnamed_529 = rsqrt(dot(float3(fragment_unnamed_499, fragment_unnamed_511, fragment_unnamed_523), float3(fragment_unnamed_499, fragment_unnamed_511, fragment_unnamed_523)));
				precise float fragment_unnamed_530 = fragment_unnamed_529 * fragment_unnamed_499;
				precise float fragment_unnamed_531 = fragment_unnamed_529 * fragment_unnamed_511;
				precise float fragment_unnamed_532 = fragment_unnamed_529 * fragment_unnamed_523;
				precise float fragment_unnamed_535 = (-0.0f) - fragment_input_6.x;
				precise float fragment_unnamed_538 = (-0.0f) - fragment_input_6.y;
				precise float fragment_unnamed_541 = (-0.0f) - fragment_input_6.z;
				precise float fragment_unnamed_547 = fragment_unnamed_535 + fragment_uniform_buffer_2[0u].x;
				precise float fragment_unnamed_548 = fragment_unnamed_538 + fragment_uniform_buffer_2[0u].y;
				precise float fragment_unnamed_549 = fragment_unnamed_541 + fragment_uniform_buffer_2[0u].z;
				float fragment_unnamed_553 = rsqrt(dot(float3(fragment_unnamed_547, fragment_unnamed_548, fragment_unnamed_549), float3(fragment_unnamed_547, fragment_unnamed_548, fragment_unnamed_549)));
				precise float fragment_unnamed_554 = fragment_unnamed_553 * fragment_unnamed_547;
				precise float fragment_unnamed_555 = fragment_unnamed_553 * fragment_unnamed_548;
				precise float fragment_unnamed_556 = fragment_unnamed_553 * fragment_unnamed_549;
				precise float fragment_unnamed_559 = (-0.0f) - fragment_input_6.x;
				precise float fragment_unnamed_562 = (-0.0f) - fragment_input_6.y;
				precise float fragment_unnamed_565 = (-0.0f) - fragment_input_6.z;
				precise float fragment_unnamed_572 = fragment_unnamed_559 + fragment_uniform_buffer_1[4u].x;
				precise float fragment_unnamed_573 = fragment_unnamed_562 + fragment_uniform_buffer_1[4u].y;
				precise float fragment_unnamed_574 = fragment_unnamed_565 + fragment_uniform_buffer_1[4u].z;
				float fragment_unnamed_578 = rsqrt(dot(float3(fragment_unnamed_572, fragment_unnamed_573, fragment_unnamed_574), float3(fragment_unnamed_572, fragment_unnamed_573, fragment_unnamed_574)));
				float fragment_unnamed_579 = mad(fragment_unnamed_572, fragment_unnamed_578, fragment_unnamed_554);
				float fragment_unnamed_580 = mad(fragment_unnamed_573, fragment_unnamed_578, fragment_unnamed_555);
				float fragment_unnamed_581 = mad(fragment_unnamed_574, fragment_unnamed_578, fragment_unnamed_556);
				float fragment_unnamed_588 = rsqrt(dot(float3(fragment_unnamed_579, fragment_unnamed_580, fragment_unnamed_581), float3(fragment_unnamed_579, fragment_unnamed_580, fragment_unnamed_581)));
				precise float fragment_unnamed_589 = fragment_unnamed_588 * fragment_unnamed_579;
				precise float fragment_unnamed_590 = fragment_unnamed_588 * fragment_unnamed_580;
				precise float fragment_unnamed_591 = fragment_unnamed_588 * fragment_unnamed_581;
				float fragment_unnamed_596 = max(dot(float3(fragment_unnamed_530, fragment_unnamed_531, fragment_unnamed_532), float3(fragment_unnamed_554, fragment_unnamed_555, fragment_unnamed_556)), 0.0f);
				precise float fragment_unnamed_602 = (-0.0f) - fragment_uniform_buffer_0[35u].y;
				precise float fragment_unnamed_606 = fragment_unnamed_602 + fragment_uniform_buffer_0[35u].z;
				precise float fragment_unnamed_611 = mad(fragment_unnamed_409, fragment_unnamed_606, fragment_uniform_buffer_0[35u].y) * 128.0f;
				precise float fragment_unnamed_613 = log2(max(dot(float3(fragment_unnamed_530, fragment_unnamed_531, fragment_unnamed_532), float3(fragment_unnamed_589, fragment_unnamed_590, fragment_unnamed_591)), 0.0f)) * fragment_unnamed_611;
				float fragment_unnamed_614 = exp2(fragment_unnamed_613);
				precise float fragment_unnamed_622 = fragment_input_6.y * fragment_uniform_buffer_0[5u].x;
				precise float fragment_unnamed_623 = fragment_input_6.y * fragment_uniform_buffer_0[5u].y;
				precise float fragment_unnamed_624 = fragment_input_6.y * fragment_uniform_buffer_0[5u].z;
				precise float fragment_unnamed_652 = mad(fragment_uniform_buffer_0[6u].x, fragment_input_6.z, mad(fragment_uniform_buffer_0[4u].x, fragment_input_6.x, fragment_unnamed_622)) + fragment_uniform_buffer_0[7u].x;
				precise float fragment_unnamed_653 = mad(fragment_uniform_buffer_0[6u].y, fragment_input_6.z, mad(fragment_uniform_buffer_0[4u].y, fragment_input_6.x, fragment_unnamed_623)) + fragment_uniform_buffer_0[7u].y;
				precise float fragment_unnamed_654 = mad(fragment_uniform_buffer_0[6u].z, fragment_input_6.z, mad(fragment_uniform_buffer_0[4u].z, fragment_input_6.x, fragment_unnamed_624)) + fragment_uniform_buffer_0[7u].z;
				precise float fragment_unnamed_667 = _LightTexture0.Sample(sampler_LightTexture0, float3(fragment_unnamed_652, fragment_unnamed_653, fragment_unnamed_654)).w * _LightTextureB0.Sample(sampler_LightTextureB0, dot(float3(fragment_unnamed_652, fragment_unnamed_653, fragment_unnamed_654), float3(fragment_unnamed_652, fragment_unnamed_653, fragment_unnamed_654)).xx).x;
				precise float fragment_unnamed_673 = fragment_unnamed_667 * fragment_uniform_buffer_0[2u].x;
				precise float fragment_unnamed_674 = fragment_unnamed_667 * fragment_uniform_buffer_0[2u].y;
				precise float fragment_unnamed_675 = fragment_unnamed_667 * fragment_uniform_buffer_0[2u].z;
				precise float fragment_unnamed_681 = fragment_unnamed_673 * fragment_uniform_buffer_0[3u].x;
				precise float fragment_unnamed_682 = fragment_unnamed_674 * fragment_uniform_buffer_0[3u].y;
				precise float fragment_unnamed_683 = fragment_unnamed_675 * fragment_uniform_buffer_0[3u].z;
				precise float fragment_unnamed_684 = fragment_unnamed_614 * fragment_unnamed_681;
				precise float fragment_unnamed_685 = fragment_unnamed_614 * fragment_unnamed_682;
				precise float fragment_unnamed_686 = fragment_unnamed_614 * fragment_unnamed_683;
				float fragment_unnamed_687 = max(fragment_unnamed_438, 9.9999997473787516355514526367188e-05f);
				precise float fragment_unnamed_689 = fragment_unnamed_435 / fragment_unnamed_687;
				precise float fragment_unnamed_690 = fragment_unnamed_436 / fragment_unnamed_687;
				precise float fragment_unnamed_691 = fragment_unnamed_437 / fragment_unnamed_687;
				fragment_output_0.w = fragment_unnamed_438;
				precise float fragment_unnamed_694 = fragment_unnamed_673 * fragment_unnamed_689;
				precise float fragment_unnamed_695 = fragment_unnamed_674 * fragment_unnamed_690;
				precise float fragment_unnamed_696 = fragment_unnamed_675 * fragment_unnamed_691;
				fragment_output_0.x = mad(fragment_unnamed_694, fragment_unnamed_596, fragment_unnamed_684);
				fragment_output_0.y = mad(fragment_unnamed_695, fragment_unnamed_596, fragment_unnamed_685);
				fragment_output_0.z = mad(fragment_unnamed_696, fragment_unnamed_596, fragment_unnamed_686);
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[2] = float4(_LightColor0[0], _LightColor0[1], _LightColor0[2], _LightColor0[3]);

				fragment_uniform_buffer_0[3] = float4(_SpecColor[0], _SpecColor[1], _SpecColor[2], _SpecColor[3]);

				fragment_uniform_buffer_0[4] = float4(unity_WorldToLight[0][0], unity_WorldToLight[1][0], unity_WorldToLight[2][0], unity_WorldToLight[3][0]);
				fragment_uniform_buffer_0[5] = float4(unity_WorldToLight[0][1], unity_WorldToLight[1][1], unity_WorldToLight[2][1], unity_WorldToLight[3][1]);
				fragment_uniform_buffer_0[6] = float4(unity_WorldToLight[0][2], unity_WorldToLight[1][2], unity_WorldToLight[2][2], unity_WorldToLight[3][2]);
				fragment_uniform_buffer_0[7] = float4(unity_WorldToLight[0][3], unity_WorldToLight[1][3], unity_WorldToLight[2][3], unity_WorldToLight[3][3]);

				fragment_uniform_buffer_0[8] = float4(_FaceUVSpeedX, fragment_uniform_buffer_0[8][1], fragment_uniform_buffer_0[8][2], fragment_uniform_buffer_0[8][3]);

				fragment_uniform_buffer_0[8] = float4(fragment_uniform_buffer_0[8][0], _FaceUVSpeedY, fragment_uniform_buffer_0[8][2], fragment_uniform_buffer_0[8][3]);

				fragment_uniform_buffer_0[9] = float4(_FaceColor[0], _FaceColor[1], _FaceColor[2], _FaceColor[3]);

				fragment_uniform_buffer_0[10] = float4(fragment_uniform_buffer_0[10][0], _OutlineSoftness, fragment_uniform_buffer_0[10][2], fragment_uniform_buffer_0[10][3]);

				fragment_uniform_buffer_0[10] = float4(fragment_uniform_buffer_0[10][0], fragment_uniform_buffer_0[10][1], _OutlineUVSpeedX, fragment_uniform_buffer_0[10][3]);

				fragment_uniform_buffer_0[10] = float4(fragment_uniform_buffer_0[10][0], fragment_uniform_buffer_0[10][1], fragment_uniform_buffer_0[10][2], _OutlineUVSpeedY);

				fragment_uniform_buffer_0[11] = float4(_OutlineColor[0], _OutlineColor[1], _OutlineColor[2], _OutlineColor[3]);

				fragment_uniform_buffer_0[12] = float4(_OutlineWidth, fragment_uniform_buffer_0[12][1], fragment_uniform_buffer_0[12][2], fragment_uniform_buffer_0[12][3]);

				fragment_uniform_buffer_0[12] = float4(fragment_uniform_buffer_0[12][0], _Bevel, fragment_uniform_buffer_0[12][2], fragment_uniform_buffer_0[12][3]);

				fragment_uniform_buffer_0[12] = float4(fragment_uniform_buffer_0[12][0], fragment_uniform_buffer_0[12][1], _BevelOffset, fragment_uniform_buffer_0[12][3]);

				fragment_uniform_buffer_0[12] = float4(fragment_uniform_buffer_0[12][0], fragment_uniform_buffer_0[12][1], fragment_uniform_buffer_0[12][2], _BevelWidth);

				fragment_uniform_buffer_0[13] = float4(_BevelClamp, fragment_uniform_buffer_0[13][1], fragment_uniform_buffer_0[13][2], fragment_uniform_buffer_0[13][3]);

				fragment_uniform_buffer_0[13] = float4(fragment_uniform_buffer_0[13][0], _BevelRoundness, fragment_uniform_buffer_0[13][2], fragment_uniform_buffer_0[13][3]);

				fragment_uniform_buffer_0[13] = float4(fragment_uniform_buffer_0[13][0], fragment_uniform_buffer_0[13][1], _BumpOutline, fragment_uniform_buffer_0[13][3]);

				fragment_uniform_buffer_0[13] = float4(fragment_uniform_buffer_0[13][0], fragment_uniform_buffer_0[13][1], fragment_uniform_buffer_0[13][2], _BumpFace);

				fragment_uniform_buffer_0[28] = float4(_ShaderFlags, fragment_uniform_buffer_0[28][1], fragment_uniform_buffer_0[28][2], fragment_uniform_buffer_0[28][3]);

				fragment_uniform_buffer_0[28] = float4(fragment_uniform_buffer_0[28][0], fragment_uniform_buffer_0[28][1], fragment_uniform_buffer_0[28][2], _ScaleRatioA);

				fragment_uniform_buffer_0[33] = float4(fragment_uniform_buffer_0[33][0], fragment_uniform_buffer_0[33][1], _TextureWidth, fragment_uniform_buffer_0[33][3]);

				fragment_uniform_buffer_0[33] = float4(fragment_uniform_buffer_0[33][0], fragment_uniform_buffer_0[33][1], fragment_uniform_buffer_0[33][2], _TextureHeight);

				fragment_uniform_buffer_0[34] = float4(_GradientScale, fragment_uniform_buffer_0[34][1], fragment_uniform_buffer_0[34][2], fragment_uniform_buffer_0[34][3]);

				fragment_uniform_buffer_0[35] = float4(fragment_uniform_buffer_0[35][0], _FaceShininess, fragment_uniform_buffer_0[35][2], fragment_uniform_buffer_0[35][3]);

				fragment_uniform_buffer_0[35] = float4(fragment_uniform_buffer_0[35][0], fragment_uniform_buffer_0[35][1], _OutlineShininess, fragment_uniform_buffer_0[35][3]);

				fragment_uniform_buffer_1[0] = float4(_Time[0], _Time[1], _Time[2], _Time[3]);

				fragment_uniform_buffer_1[4] = float4(_WorldSpaceCameraPos[0], _WorldSpaceCameraPos[1], _WorldSpaceCameraPos[2], fragment_uniform_buffer_1[4][3]);

				fragment_uniform_buffer_2[0] = float4(_WorldSpaceLightPos0[0], _WorldSpaceLightPos0[1], _WorldSpaceLightPos0[2], _WorldSpaceLightPos0[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				fragment_input_6 = stage_input.fragment_input_6;
				fragment_input_7 = stage_input.fragment_input_7;
				fragment_input_8 = stage_input.fragment_input_8;
				fragment_input_9 = stage_input.fragment_input_9;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // POINT_COOKIE
			#endif // !DIRECTIONAL
			#endif // !DIRECTIONAL_COOKIE
			#endif // !POINT
			#endif // !SPOT


			#ifdef DIRECTIONAL_COOKIE
			#ifndef DIRECTIONAL
			#ifndef POINT
			#ifndef POINT_COOKIE
			#ifndef SPOT
			#define ANY_SHADER_VARIANT_ACTIVE

			float4 _LightColor0;
			float4 _SpecColor;
			float4x4 unity_WorldToLight;
			float _FaceUVSpeedX;
			float _FaceUVSpeedY;
			float4 _FaceColor;
			float _OutlineSoftness;
			float _OutlineUVSpeedX;
			float _OutlineUVSpeedY;
			float4 _OutlineColor;
			float _OutlineWidth;
			float _Bevel;
			float _BevelOffset;
			float _BevelWidth;
			float _BevelClamp;
			float _BevelRoundness;
			float _BumpOutline;
			float _BumpFace;
			float _ShaderFlags;
			float _ScaleRatioA;
			float _TextureWidth;
			float _TextureHeight;
			float _GradientScale;
			float _FaceShininess;
			float _OutlineShininess;
			float4 _Time;
			float3 _WorldSpaceCameraPos;
			float4 _WorldSpaceLightPos0;

			static float4 fragment_uniform_buffer_0[36];
			static float4 fragment_uniform_buffer_1[5];
			static float4 fragment_uniform_buffer_2[1];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _FaceTex;
			Texture2D<float4> _OutlineTex;
			Texture2D<float4> _BumpMap;
			Texture2D<float4> _LightTexture0;
			SamplerState sampler_LightTexture0;
			SamplerState sampler_FaceTex;
			SamplerState sampler_OutlineTex;
			SamplerState sampler_BumpMap;
			SamplerState sampler_MainTex;

			static float4 fragment_input_1;
			static float2 fragment_input_2;
			static float2 fragment_input_2;
			static float3 fragment_input_3;
			static float3 fragment_input_4;
			static float3 fragment_input_5;
			static float3 fragment_input_6;
			static float4 fragment_input_7;
			static float3 fragment_input_8;
			static float2 fragment_input_9;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : TEXCOORD; // TEXCOORD
				float2 fragment_input_2 : TEXCOORD1; // TEXCOORD_1
				float2 fragment_input_2 : TEXCOORD6; // TEXCOORD_6
				float3 fragment_input_3 : TEXCOORD2; // TEXCOORD_2
				float3 fragment_input_4 : TEXCOORD3; // TEXCOORD_3
				float3 fragment_input_5 : TEXCOORD4; // TEXCOORD_4
				float3 fragment_input_6 : TEXCOORD5; // TEXCOORD_5
				float4 fragment_input_7 : COLOR; // COLOR
				float3 fragment_input_8 : TEXCOORD7; // TEXCOORD_7
				float2 fragment_input_9 : TEXCOORD8; // TEXCOORD_8
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				precise float fragment_unnamed_74 = fragment_input_2.x + fragment_uniform_buffer_0[12u].z;
				precise float fragment_unnamed_80 = 1.0f / fragment_uniform_buffer_0[33u].z;
				precise float fragment_unnamed_82 = 1.0f / fragment_uniform_buffer_0[33u].w;
				float fragment_unnamed_83 = asfloat(0u);
				precise float fragment_unnamed_84 = (-0.0f) - fragment_unnamed_80;
				precise float fragment_unnamed_86 = (-0.0f) - fragment_unnamed_83;
				precise float fragment_unnamed_87 = (-0.0f) - fragment_unnamed_82;
				precise float fragment_unnamed_92 = fragment_unnamed_84 + fragment_input_1.x;
				precise float fragment_unnamed_93 = fragment_unnamed_86 + fragment_input_1.y;
				precise float fragment_unnamed_94 = fragment_unnamed_86 + fragment_input_1.x;
				precise float fragment_unnamed_95 = fragment_unnamed_87 + fragment_input_1.y;
				precise float fragment_unnamed_100 = fragment_unnamed_80 + fragment_input_1.x;
				precise float fragment_unnamed_101 = fragment_unnamed_83 + fragment_input_1.y;
				precise float fragment_unnamed_102 = fragment_unnamed_83 + fragment_input_1.x;
				precise float fragment_unnamed_103 = fragment_unnamed_82 + fragment_input_1.y;
				precise float fragment_unnamed_119 = fragment_unnamed_74 + _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_92, fragment_unnamed_93)).w;
				precise float fragment_unnamed_120 = fragment_unnamed_74 + _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_100, fragment_unnamed_101)).w;
				precise float fragment_unnamed_121 = fragment_unnamed_74 + _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_94, fragment_unnamed_95)).w;
				precise float fragment_unnamed_122 = fragment_unnamed_74 + _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_102, fragment_unnamed_103)).w;
				precise float fragment_unnamed_123 = fragment_unnamed_119 + (-0.5f);
				precise float fragment_unnamed_125 = fragment_unnamed_120 + (-0.5f);
				precise float fragment_unnamed_126 = fragment_unnamed_121 + (-0.5f);
				precise float fragment_unnamed_127 = fragment_unnamed_122 + (-0.5f);
				precise float fragment_unnamed_134 = fragment_uniform_buffer_0[12u].w + fragment_uniform_buffer_0[12u].x;
				float fragment_unnamed_136 = max(fragment_unnamed_134, 0.00999999977648258209228515625f);
				precise float fragment_unnamed_138 = fragment_unnamed_123 / fragment_unnamed_136;
				precise float fragment_unnamed_139 = fragment_unnamed_125 / fragment_unnamed_136;
				precise float fragment_unnamed_140 = fragment_unnamed_126 / fragment_unnamed_136;
				precise float fragment_unnamed_141 = fragment_unnamed_127 / fragment_unnamed_136;
				precise float fragment_unnamed_145 = fragment_unnamed_136 * fragment_uniform_buffer_0[12u].y;
				precise float fragment_unnamed_150 = fragment_unnamed_145 * fragment_uniform_buffer_0[34u].x;
				precise float fragment_unnamed_151 = fragment_unnamed_150 * (-2.0f);
				precise float fragment_unnamed_153 = fragment_unnamed_138 + 0.5f;
				precise float fragment_unnamed_155 = fragment_unnamed_139 + 0.5f;
				precise float fragment_unnamed_156 = fragment_unnamed_140 + 0.5f;
				precise float fragment_unnamed_157 = fragment_unnamed_141 + 0.5f;
				float fragment_unnamed_158 = clamp(fragment_unnamed_153, 0.0f, 1.0f);
				float fragment_unnamed_159 = clamp(fragment_unnamed_155, 0.0f, 1.0f);
				float fragment_unnamed_160 = clamp(fragment_unnamed_156, 0.0f, 1.0f);
				float fragment_unnamed_161 = clamp(fragment_unnamed_157, 0.0f, 1.0f);
				precise float fragment_unnamed_169 = (-0.0f) - abs(mad(fragment_unnamed_158, 2.0f, -1.0f));
				precise float fragment_unnamed_171 = (-0.0f) - abs(mad(fragment_unnamed_159, 2.0f, -1.0f));
				precise float fragment_unnamed_173 = (-0.0f) - abs(mad(fragment_unnamed_160, 2.0f, -1.0f));
				precise float fragment_unnamed_175 = (-0.0f) - abs(mad(fragment_unnamed_161, 2.0f, -1.0f));
				precise float fragment_unnamed_176 = fragment_unnamed_169 + 1.0f;
				precise float fragment_unnamed_177 = fragment_unnamed_171 + 1.0f;
				precise float fragment_unnamed_178 = fragment_unnamed_173 + 1.0f;
				precise float fragment_unnamed_179 = fragment_unnamed_175 + 1.0f;
				precise float fragment_unnamed_184 = fragment_uniform_buffer_0[28u].x * 0.5f;
				precise float fragment_unnamed_185 = (-0.0f) - fragment_unnamed_184;
				float fragment_unnamed_189 = frac(abs(fragment_unnamed_184));
				precise float fragment_unnamed_190 = (-0.0f) - fragment_unnamed_189;
				bool fragment_unnamed_192 = ((fragment_unnamed_184 >= fragment_unnamed_185) ? fragment_unnamed_189 : fragment_unnamed_190) >= 0.5f;
				float fragment_unnamed_202 = asfloat(fragment_unnamed_192 ? asuint(fragment_unnamed_176) : asuint(fragment_unnamed_158));
				float fragment_unnamed_204 = asfloat(fragment_unnamed_192 ? asuint(fragment_unnamed_177) : asuint(fragment_unnamed_159));
				float fragment_unnamed_206 = asfloat(fragment_unnamed_192 ? asuint(fragment_unnamed_178) : asuint(fragment_unnamed_160));
				float fragment_unnamed_208 = asfloat(fragment_unnamed_192 ? asuint(fragment_unnamed_179) : asuint(fragment_unnamed_161));
				precise float fragment_unnamed_209 = fragment_unnamed_202 * 1.57079601287841796875f;
				precise float fragment_unnamed_211 = fragment_unnamed_204 * 1.57079601287841796875f;
				precise float fragment_unnamed_212 = fragment_unnamed_206 * 1.57079601287841796875f;
				precise float fragment_unnamed_213 = fragment_unnamed_208 * 1.57079601287841796875f;
				precise float fragment_unnamed_218 = (-0.0f) - fragment_unnamed_202;
				precise float fragment_unnamed_219 = (-0.0f) - fragment_unnamed_204;
				precise float fragment_unnamed_220 = (-0.0f) - fragment_unnamed_206;
				precise float fragment_unnamed_221 = (-0.0f) - fragment_unnamed_208;
				precise float fragment_unnamed_222 = fragment_unnamed_218 + sin(fragment_unnamed_209);
				precise float fragment_unnamed_223 = fragment_unnamed_219 + sin(fragment_unnamed_211);
				precise float fragment_unnamed_224 = fragment_unnamed_220 + sin(fragment_unnamed_212);
				precise float fragment_unnamed_225 = fragment_unnamed_221 + sin(fragment_unnamed_213);
				precise float fragment_unnamed_237 = (-0.0f) - fragment_uniform_buffer_0[13u].x;
				precise float fragment_unnamed_238 = fragment_unnamed_237 + 1.0f;
				precise float fragment_unnamed_243 = fragment_unnamed_151 * min(mad(fragment_uniform_buffer_0[13u].y, fragment_unnamed_222, fragment_unnamed_202), fragment_unnamed_238);
				precise float fragment_unnamed_244 = fragment_unnamed_151 * min(mad(fragment_uniform_buffer_0[13u].y, fragment_unnamed_224, fragment_unnamed_206), fragment_unnamed_238);
				precise float fragment_unnamed_245 = (-0.0f) - fragment_unnamed_244;
				precise float fragment_unnamed_246 = (-0.0f) - fragment_unnamed_243;
				float fragment_unnamed_247 = mad(min(mad(fragment_uniform_buffer_0[13u].y, fragment_unnamed_225, fragment_unnamed_208), fragment_unnamed_238), fragment_unnamed_151, fragment_unnamed_245);
				float fragment_unnamed_248 = mad(min(mad(fragment_uniform_buffer_0[13u].y, fragment_unnamed_223, fragment_unnamed_204), fragment_unnamed_238), fragment_unnamed_151, fragment_unnamed_246);
				float fragment_unnamed_249 = asfloat(3212836864u);
				float fragment_unnamed_251 = asfloat(1065353216u);
				float fragment_unnamed_256 = rsqrt(dot(float2(fragment_unnamed_249, fragment_unnamed_247), float2(fragment_unnamed_249, fragment_unnamed_247)));
				float fragment_unnamed_260 = rsqrt(dot(float2(fragment_unnamed_248, fragment_unnamed_251), float2(fragment_unnamed_248, fragment_unnamed_251)));
				precise float fragment_unnamed_261 = fragment_unnamed_260 * fragment_unnamed_248;
				precise float fragment_unnamed_262 = fragment_unnamed_260 * 1.0f;
				precise float fragment_unnamed_263 = fragment_unnamed_260 * 0.0f;
				precise float fragment_unnamed_265 = fragment_unnamed_256 * fragment_unnamed_249;
				precise float fragment_unnamed_266 = fragment_unnamed_256 * fragment_unnamed_247;
				precise float fragment_unnamed_267 = fragment_unnamed_256 * asfloat(0u);
				precise float fragment_unnamed_268 = fragment_unnamed_265 * fragment_unnamed_261;
				precise float fragment_unnamed_269 = fragment_unnamed_266 * fragment_unnamed_262;
				precise float fragment_unnamed_270 = fragment_unnamed_267 * fragment_unnamed_263;
				precise float fragment_unnamed_271 = (-0.0f) - fragment_unnamed_268;
				precise float fragment_unnamed_272 = (-0.0f) - fragment_unnamed_269;
				precise float fragment_unnamed_273 = (-0.0f) - fragment_unnamed_270;
				float4 fragment_unnamed_292 = _OutlineTex.Sample(sampler_OutlineTex, float2(mad(fragment_uniform_buffer_0[10u].z, fragment_uniform_buffer_1[0u].y, fragment_input_2.x), mad(fragment_uniform_buffer_0[10u].w, fragment_uniform_buffer_1[0u].y, fragment_input_2.y)));
				precise float fragment_unnamed_304 = fragment_unnamed_292.x * fragment_uniform_buffer_0[11u].x;
				precise float fragment_unnamed_305 = fragment_unnamed_292.y * fragment_uniform_buffer_0[11u].y;
				precise float fragment_unnamed_306 = fragment_unnamed_292.z * fragment_uniform_buffer_0[11u].z;
				precise float fragment_unnamed_313 = fragment_input_7.w * fragment_uniform_buffer_0[11u].w;
				precise float fragment_unnamed_314 = fragment_unnamed_292.w * fragment_unnamed_313;
				precise float fragment_unnamed_315 = fragment_unnamed_304 * fragment_unnamed_314;
				precise float fragment_unnamed_316 = fragment_unnamed_305 * fragment_unnamed_314;
				precise float fragment_unnamed_317 = fragment_unnamed_306 * fragment_unnamed_314;
				float4 fragment_unnamed_334 = _FaceTex.Sample(sampler_FaceTex, float2(mad(fragment_uniform_buffer_0[8u].x, fragment_uniform_buffer_1[0u].y, fragment_input_1.z), mad(fragment_uniform_buffer_0[8u].y, fragment_uniform_buffer_1[0u].y, fragment_input_1.w)));
				precise float fragment_unnamed_355 = fragment_input_7.x * fragment_uniform_buffer_0[9u].x;
				precise float fragment_unnamed_356 = fragment_input_7.y * fragment_uniform_buffer_0[9u].y;
				precise float fragment_unnamed_357 = fragment_input_7.z * fragment_uniform_buffer_0[9u].z;
				precise float fragment_unnamed_358 = fragment_input_7.w * fragment_uniform_buffer_0[9u].w;
				precise float fragment_unnamed_359 = fragment_unnamed_334.x * fragment_unnamed_355;
				precise float fragment_unnamed_360 = fragment_unnamed_334.y * fragment_unnamed_356;
				precise float fragment_unnamed_361 = fragment_unnamed_334.z * fragment_unnamed_357;
				precise float fragment_unnamed_362 = fragment_unnamed_334.w * fragment_unnamed_358;
				precise float fragment_unnamed_363 = fragment_unnamed_362 * fragment_unnamed_359;
				precise float fragment_unnamed_364 = fragment_unnamed_362 * fragment_unnamed_360;
				precise float fragment_unnamed_365 = fragment_unnamed_362 * fragment_unnamed_361;
				precise float fragment_unnamed_366 = (-0.0f) - fragment_unnamed_363;
				precise float fragment_unnamed_367 = (-0.0f) - fragment_unnamed_364;
				precise float fragment_unnamed_368 = (-0.0f) - fragment_unnamed_365;
				precise float fragment_unnamed_369 = (-0.0f) - fragment_unnamed_362;
				precise float fragment_unnamed_370 = fragment_unnamed_366 + fragment_unnamed_315;
				precise float fragment_unnamed_371 = fragment_unnamed_367 + fragment_unnamed_316;
				precise float fragment_unnamed_372 = fragment_unnamed_368 + fragment_unnamed_317;
				precise float fragment_unnamed_373 = fragment_unnamed_369 + fragment_unnamed_314;
				precise float fragment_unnamed_380 = fragment_uniform_buffer_0[12u].x * fragment_uniform_buffer_0[28u].w;
				precise float fragment_unnamed_383 = fragment_unnamed_380 * fragment_input_2.y;
				precise float fragment_unnamed_393 = (-0.0f) - _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y)).w;
				precise float fragment_unnamed_394 = fragment_unnamed_393 + 0.5f;
				precise float fragment_unnamed_397 = (-0.0f) - fragment_input_2.x;
				precise float fragment_unnamed_398 = fragment_unnamed_394 + fragment_unnamed_397;
				float fragment_unnamed_401 = mad(fragment_unnamed_398, fragment_input_2.y, 0.5f);
				float fragment_unnamed_403 = clamp(mad(fragment_unnamed_383, 0.5f, fragment_unnamed_401), 0.0f, 1.0f);
				precise float fragment_unnamed_404 = (-0.0f) - fragment_unnamed_383;
				precise float fragment_unnamed_406 = sqrt(min(fragment_unnamed_383, 1.0f)) * fragment_unnamed_403;
				precise float fragment_unnamed_417 = fragment_uniform_buffer_0[10u].y * fragment_uniform_buffer_0[28u].w;
				precise float fragment_unnamed_420 = fragment_unnamed_417 * fragment_input_2.y;
				precise float fragment_unnamed_425 = mad(fragment_unnamed_420, 0.5f, mad(fragment_unnamed_404, 0.5f, fragment_unnamed_401)) / mad(fragment_unnamed_417, fragment_input_2.y, 1.0f);
				precise float fragment_unnamed_427 = (-0.0f) - clamp(fragment_unnamed_425, 0.0f, 1.0f);
				precise float fragment_unnamed_428 = fragment_unnamed_427 + 1.0f;
				precise float fragment_unnamed_429 = fragment_unnamed_428 * mad(fragment_unnamed_406, fragment_unnamed_370, fragment_unnamed_363);
				precise float fragment_unnamed_430 = fragment_unnamed_428 * mad(fragment_unnamed_406, fragment_unnamed_371, fragment_unnamed_364);
				precise float fragment_unnamed_431 = fragment_unnamed_428 * mad(fragment_unnamed_406, fragment_unnamed_372, fragment_unnamed_365);
				precise float fragment_unnamed_432 = fragment_unnamed_428 * mad(fragment_unnamed_406, fragment_unnamed_373, fragment_unnamed_362);
				precise float fragment_unnamed_436 = (-0.0f) - fragment_uniform_buffer_0[13u].w;
				precise float fragment_unnamed_440 = fragment_unnamed_436 + fragment_uniform_buffer_0[13u].z;
				float fragment_unnamed_444 = mad(fragment_unnamed_403, fragment_unnamed_440, fragment_uniform_buffer_0[13u].w);
				float4 fragment_unnamed_450 = _BumpMap.Sample(sampler_BumpMap, float2(fragment_input_1.z, fragment_input_1.w));
				precise float fragment_unnamed_455 = fragment_unnamed_450.w * fragment_unnamed_450.x;
				float fragment_unnamed_456 = mad(fragment_unnamed_455, 2.0f, -1.0f);
				float fragment_unnamed_457 = mad(fragment_unnamed_450.y, 2.0f, -1.0f);
				precise float fragment_unnamed_462 = (-0.0f) - min(dot(float2(fragment_unnamed_456, fragment_unnamed_457), float2(fragment_unnamed_456, fragment_unnamed_457)), 1.0f);
				precise float fragment_unnamed_463 = fragment_unnamed_462 + 1.0f;
				precise float fragment_unnamed_471 = (-0.0f) - mad(fragment_unnamed_432, mad(fragment_unnamed_456, fragment_unnamed_444, -0.0f), 0.0f);
				precise float fragment_unnamed_472 = (-0.0f) - mad(fragment_unnamed_432, mad(fragment_unnamed_457, fragment_unnamed_444, -0.0f), 0.0f);
				precise float fragment_unnamed_473 = (-0.0f) - mad(fragment_unnamed_432, mad(sqrt(fragment_unnamed_463), fragment_unnamed_444, -1.0f), 1.0f);
				precise float fragment_unnamed_474 = mad(fragment_unnamed_263, fragment_unnamed_266, fragment_unnamed_271) + fragment_unnamed_471;
				precise float fragment_unnamed_475 = mad(fragment_unnamed_261, fragment_unnamed_267, fragment_unnamed_272) + fragment_unnamed_472;
				precise float fragment_unnamed_476 = mad(fragment_unnamed_262, fragment_unnamed_265, fragment_unnamed_273) + fragment_unnamed_473;
				float fragment_unnamed_480 = rsqrt(dot(float3(fragment_unnamed_474, fragment_unnamed_475, fragment_unnamed_476), float3(fragment_unnamed_474, fragment_unnamed_475, fragment_unnamed_476)));
				precise float fragment_unnamed_481 = fragment_unnamed_480 * fragment_unnamed_474;
				precise float fragment_unnamed_482 = fragment_unnamed_480 * fragment_unnamed_475;
				precise float fragment_unnamed_483 = fragment_unnamed_480 * fragment_unnamed_476;
				precise float fragment_unnamed_490 = (-0.0f) - fragment_unnamed_481;
				precise float fragment_unnamed_491 = (-0.0f) - fragment_unnamed_482;
				precise float fragment_unnamed_492 = (-0.0f) - fragment_unnamed_483;
				float fragment_unnamed_493 = dot(float3(fragment_input_3.x, fragment_input_3.y, fragment_input_3.z), float3(fragment_unnamed_490, fragment_unnamed_491, fragment_unnamed_492));
				precise float fragment_unnamed_502 = (-0.0f) - fragment_unnamed_481;
				precise float fragment_unnamed_503 = (-0.0f) - fragment_unnamed_482;
				precise float fragment_unnamed_504 = (-0.0f) - fragment_unnamed_483;
				float fragment_unnamed_505 = dot(float3(fragment_input_4.x, fragment_input_4.y, fragment_input_4.z), float3(fragment_unnamed_502, fragment_unnamed_503, fragment_unnamed_504));
				precise float fragment_unnamed_514 = (-0.0f) - fragment_unnamed_481;
				precise float fragment_unnamed_515 = (-0.0f) - fragment_unnamed_482;
				precise float fragment_unnamed_516 = (-0.0f) - fragment_unnamed_483;
				float fragment_unnamed_517 = dot(float3(fragment_input_5.x, fragment_input_5.y, fragment_input_5.z), float3(fragment_unnamed_514, fragment_unnamed_515, fragment_unnamed_516));
				float fragment_unnamed_523 = rsqrt(dot(float3(fragment_unnamed_493, fragment_unnamed_505, fragment_unnamed_517), float3(fragment_unnamed_493, fragment_unnamed_505, fragment_unnamed_517)));
				precise float fragment_unnamed_524 = fragment_unnamed_523 * fragment_unnamed_493;
				precise float fragment_unnamed_525 = fragment_unnamed_523 * fragment_unnamed_505;
				precise float fragment_unnamed_526 = fragment_unnamed_523 * fragment_unnamed_517;
				precise float fragment_unnamed_529 = (-0.0f) - fragment_input_6.x;
				precise float fragment_unnamed_532 = (-0.0f) - fragment_input_6.y;
				precise float fragment_unnamed_535 = (-0.0f) - fragment_input_6.z;
				precise float fragment_unnamed_542 = fragment_unnamed_529 + fragment_uniform_buffer_1[4u].x;
				precise float fragment_unnamed_543 = fragment_unnamed_532 + fragment_uniform_buffer_1[4u].y;
				precise float fragment_unnamed_544 = fragment_unnamed_535 + fragment_uniform_buffer_1[4u].z;
				float fragment_unnamed_548 = rsqrt(dot(float3(fragment_unnamed_542, fragment_unnamed_543, fragment_unnamed_544), float3(fragment_unnamed_542, fragment_unnamed_543, fragment_unnamed_544)));
				float fragment_unnamed_554 = mad(fragment_unnamed_542, fragment_unnamed_548, fragment_uniform_buffer_2[0u].x);
				float fragment_unnamed_555 = mad(fragment_unnamed_543, fragment_unnamed_548, fragment_uniform_buffer_2[0u].y);
				float fragment_unnamed_556 = mad(fragment_unnamed_544, fragment_unnamed_548, fragment_uniform_buffer_2[0u].z);
				float fragment_unnamed_560 = rsqrt(dot(float3(fragment_unnamed_554, fragment_unnamed_555, fragment_unnamed_556), float3(fragment_unnamed_554, fragment_unnamed_555, fragment_unnamed_556)));
				precise float fragment_unnamed_561 = fragment_unnamed_560 * fragment_unnamed_554;
				precise float fragment_unnamed_562 = fragment_unnamed_560 * fragment_unnamed_555;
				precise float fragment_unnamed_563 = fragment_unnamed_560 * fragment_unnamed_556;
				float fragment_unnamed_575 = max(dot(float3(fragment_unnamed_524, fragment_unnamed_525, fragment_unnamed_526), float3(fragment_uniform_buffer_2[0u].xyz)), 0.0f);
				precise float fragment_unnamed_582 = (-0.0f) - fragment_uniform_buffer_0[35u].y;
				precise float fragment_unnamed_586 = fragment_unnamed_582 + fragment_uniform_buffer_0[35u].z;
				precise float fragment_unnamed_591 = mad(fragment_unnamed_403, fragment_unnamed_586, fragment_uniform_buffer_0[35u].y) * 128.0f;
				precise float fragment_unnamed_593 = log2(max(dot(float3(fragment_unnamed_524, fragment_unnamed_525, fragment_unnamed_526), float3(fragment_unnamed_561, fragment_unnamed_562, fragment_unnamed_563)), 0.0f)) * fragment_unnamed_591;
				float fragment_unnamed_594 = exp2(fragment_unnamed_593);
				precise float fragment_unnamed_601 = fragment_input_6.y * fragment_uniform_buffer_0[5u].x;
				precise float fragment_unnamed_602 = fragment_input_6.y * fragment_uniform_buffer_0[5u].y;
				precise float fragment_unnamed_625 = mad(fragment_uniform_buffer_0[6u].x, fragment_input_6.z, mad(fragment_uniform_buffer_0[4u].x, fragment_input_6.x, fragment_unnamed_601)) + fragment_uniform_buffer_0[7u].x;
				precise float fragment_unnamed_626 = mad(fragment_uniform_buffer_0[6u].y, fragment_input_6.z, mad(fragment_uniform_buffer_0[4u].y, fragment_input_6.x, fragment_unnamed_602)) + fragment_uniform_buffer_0[7u].y;
				float4 fragment_unnamed_628 = _LightTexture0.Sample(sampler_LightTexture0, float2(fragment_unnamed_625, fragment_unnamed_626));
				float fragment_unnamed_630 = fragment_unnamed_628.w;
				precise float fragment_unnamed_636 = fragment_unnamed_630 * fragment_uniform_buffer_0[2u].x;
				precise float fragment_unnamed_637 = fragment_unnamed_630 * fragment_uniform_buffer_0[2u].y;
				precise float fragment_unnamed_638 = fragment_unnamed_630 * fragment_uniform_buffer_0[2u].z;
				precise float fragment_unnamed_644 = fragment_unnamed_636 * fragment_uniform_buffer_0[3u].x;
				precise float fragment_unnamed_645 = fragment_unnamed_637 * fragment_uniform_buffer_0[3u].y;
				precise float fragment_unnamed_646 = fragment_unnamed_638 * fragment_uniform_buffer_0[3u].z;
				precise float fragment_unnamed_647 = fragment_unnamed_594 * fragment_unnamed_644;
				precise float fragment_unnamed_648 = fragment_unnamed_594 * fragment_unnamed_645;
				precise float fragment_unnamed_649 = fragment_unnamed_594 * fragment_unnamed_646;
				float fragment_unnamed_650 = max(fragment_unnamed_432, 9.9999997473787516355514526367188e-05f);
				precise float fragment_unnamed_652 = fragment_unnamed_429 / fragment_unnamed_650;
				precise float fragment_unnamed_653 = fragment_unnamed_430 / fragment_unnamed_650;
				precise float fragment_unnamed_654 = fragment_unnamed_431 / fragment_unnamed_650;
				fragment_output_0.w = fragment_unnamed_432;
				precise float fragment_unnamed_657 = fragment_unnamed_636 * fragment_unnamed_652;
				precise float fragment_unnamed_658 = fragment_unnamed_637 * fragment_unnamed_653;
				precise float fragment_unnamed_659 = fragment_unnamed_638 * fragment_unnamed_654;
				fragment_output_0.x = mad(fragment_unnamed_657, fragment_unnamed_575, fragment_unnamed_647);
				fragment_output_0.y = mad(fragment_unnamed_658, fragment_unnamed_575, fragment_unnamed_648);
				fragment_output_0.z = mad(fragment_unnamed_659, fragment_unnamed_575, fragment_unnamed_649);
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[2] = float4(_LightColor0[0], _LightColor0[1], _LightColor0[2], _LightColor0[3]);

				fragment_uniform_buffer_0[3] = float4(_SpecColor[0], _SpecColor[1], _SpecColor[2], _SpecColor[3]);

				fragment_uniform_buffer_0[4] = float4(unity_WorldToLight[0][0], unity_WorldToLight[1][0], unity_WorldToLight[2][0], unity_WorldToLight[3][0]);
				fragment_uniform_buffer_0[5] = float4(unity_WorldToLight[0][1], unity_WorldToLight[1][1], unity_WorldToLight[2][1], unity_WorldToLight[3][1]);
				fragment_uniform_buffer_0[6] = float4(unity_WorldToLight[0][2], unity_WorldToLight[1][2], unity_WorldToLight[2][2], unity_WorldToLight[3][2]);
				fragment_uniform_buffer_0[7] = float4(unity_WorldToLight[0][3], unity_WorldToLight[1][3], unity_WorldToLight[2][3], unity_WorldToLight[3][3]);

				fragment_uniform_buffer_0[8] = float4(_FaceUVSpeedX, fragment_uniform_buffer_0[8][1], fragment_uniform_buffer_0[8][2], fragment_uniform_buffer_0[8][3]);

				fragment_uniform_buffer_0[8] = float4(fragment_uniform_buffer_0[8][0], _FaceUVSpeedY, fragment_uniform_buffer_0[8][2], fragment_uniform_buffer_0[8][3]);

				fragment_uniform_buffer_0[9] = float4(_FaceColor[0], _FaceColor[1], _FaceColor[2], _FaceColor[3]);

				fragment_uniform_buffer_0[10] = float4(fragment_uniform_buffer_0[10][0], _OutlineSoftness, fragment_uniform_buffer_0[10][2], fragment_uniform_buffer_0[10][3]);

				fragment_uniform_buffer_0[10] = float4(fragment_uniform_buffer_0[10][0], fragment_uniform_buffer_0[10][1], _OutlineUVSpeedX, fragment_uniform_buffer_0[10][3]);

				fragment_uniform_buffer_0[10] = float4(fragment_uniform_buffer_0[10][0], fragment_uniform_buffer_0[10][1], fragment_uniform_buffer_0[10][2], _OutlineUVSpeedY);

				fragment_uniform_buffer_0[11] = float4(_OutlineColor[0], _OutlineColor[1], _OutlineColor[2], _OutlineColor[3]);

				fragment_uniform_buffer_0[12] = float4(_OutlineWidth, fragment_uniform_buffer_0[12][1], fragment_uniform_buffer_0[12][2], fragment_uniform_buffer_0[12][3]);

				fragment_uniform_buffer_0[12] = float4(fragment_uniform_buffer_0[12][0], _Bevel, fragment_uniform_buffer_0[12][2], fragment_uniform_buffer_0[12][3]);

				fragment_uniform_buffer_0[12] = float4(fragment_uniform_buffer_0[12][0], fragment_uniform_buffer_0[12][1], _BevelOffset, fragment_uniform_buffer_0[12][3]);

				fragment_uniform_buffer_0[12] = float4(fragment_uniform_buffer_0[12][0], fragment_uniform_buffer_0[12][1], fragment_uniform_buffer_0[12][2], _BevelWidth);

				fragment_uniform_buffer_0[13] = float4(_BevelClamp, fragment_uniform_buffer_0[13][1], fragment_uniform_buffer_0[13][2], fragment_uniform_buffer_0[13][3]);

				fragment_uniform_buffer_0[13] = float4(fragment_uniform_buffer_0[13][0], _BevelRoundness, fragment_uniform_buffer_0[13][2], fragment_uniform_buffer_0[13][3]);

				fragment_uniform_buffer_0[13] = float4(fragment_uniform_buffer_0[13][0], fragment_uniform_buffer_0[13][1], _BumpOutline, fragment_uniform_buffer_0[13][3]);

				fragment_uniform_buffer_0[13] = float4(fragment_uniform_buffer_0[13][0], fragment_uniform_buffer_0[13][1], fragment_uniform_buffer_0[13][2], _BumpFace);

				fragment_uniform_buffer_0[28] = float4(_ShaderFlags, fragment_uniform_buffer_0[28][1], fragment_uniform_buffer_0[28][2], fragment_uniform_buffer_0[28][3]);

				fragment_uniform_buffer_0[28] = float4(fragment_uniform_buffer_0[28][0], fragment_uniform_buffer_0[28][1], fragment_uniform_buffer_0[28][2], _ScaleRatioA);

				fragment_uniform_buffer_0[33] = float4(fragment_uniform_buffer_0[33][0], fragment_uniform_buffer_0[33][1], _TextureWidth, fragment_uniform_buffer_0[33][3]);

				fragment_uniform_buffer_0[33] = float4(fragment_uniform_buffer_0[33][0], fragment_uniform_buffer_0[33][1], fragment_uniform_buffer_0[33][2], _TextureHeight);

				fragment_uniform_buffer_0[34] = float4(_GradientScale, fragment_uniform_buffer_0[34][1], fragment_uniform_buffer_0[34][2], fragment_uniform_buffer_0[34][3]);

				fragment_uniform_buffer_0[35] = float4(fragment_uniform_buffer_0[35][0], _FaceShininess, fragment_uniform_buffer_0[35][2], fragment_uniform_buffer_0[35][3]);

				fragment_uniform_buffer_0[35] = float4(fragment_uniform_buffer_0[35][0], fragment_uniform_buffer_0[35][1], _OutlineShininess, fragment_uniform_buffer_0[35][3]);

				fragment_uniform_buffer_1[0] = float4(_Time[0], _Time[1], _Time[2], _Time[3]);

				fragment_uniform_buffer_1[4] = float4(_WorldSpaceCameraPos[0], _WorldSpaceCameraPos[1], _WorldSpaceCameraPos[2], fragment_uniform_buffer_1[4][3]);

				fragment_uniform_buffer_2[0] = float4(_WorldSpaceLightPos0[0], _WorldSpaceLightPos0[1], _WorldSpaceLightPos0[2], _WorldSpaceLightPos0[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				fragment_input_6 = stage_input.fragment_input_6;
				fragment_input_7 = stage_input.fragment_input_7;
				fragment_input_8 = stage_input.fragment_input_8;
				fragment_input_9 = stage_input.fragment_input_9;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // DIRECTIONAL_COOKIE
			#endif // !DIRECTIONAL
			#endif // !POINT
			#endif // !POINT_COOKIE
			#endif // !SPOT


			// Fallback Shader Code
			#ifndef ANY_SHADER_VARIANT_ACTIVE

			// https://docs.unity3d.com/Manual/SL-UnityShaderVariables.html
			float4x4 unity_MatrixMVP;

			struct Vertex_Stage_Input
			{
				float3 pos : POSITION;
			};

			struct Vertex_Stage_Output
			{
				float4 pos : SV_POSITION;
			};

			Vertex_Stage_Output vert(Vertex_Stage_Input input)
			{
				Vertex_Stage_Output output;
				output.pos = mul(unity_MatrixMVP, float4(input.pos, 1.0));
				return output;
			}

			float4 frag(Vertex_Stage_Output input) : SV_TARGET
			{
				// Output solid grey color (e.g., 50% grey)
				return float4(0.5, 0.5, 0.5, 1.0); // RGBA
			}

			#endif // !ANY_SHADER_VARIANT_ACTIVE


			ENDHLSL
		}
		Pass
		{
			Name "Caster"
			LOD 300
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "SHADOWCASTER" "QUEUE" = "Transparent" "RenderType" = "Transparent" "SHADOWSUPPORT" = "true" }
			ColorMask RGB
			Cull Off
			Offset 1, 1
			Fog
			{
				Mode Off
			}
			GpuProgramID 184110

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.0
			#pragma shader_feature SHADOWS_CUBE
			#pragma shader_feature SHADOWS_DEPTH


			#ifdef SHADOWS_DEPTH
			#ifndef SHADOWS_CUBE
			#define ANY_SHADER_VARIANT_ACTIVE

			float4 _MainTex_ST;
			float4 _OutlineTex_ST;
			float _OutlineWidth;
			float _FaceDilate;
			float _ScaleRatioA;
			float4 unity_LightShadowBias;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[5];
			static float4 vertex_uniform_buffer_1[6];
			static float4 vertex_uniform_buffer_2[4];
			static float4 vertex_uniform_buffer_3[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float3 vertex_input_1;
			static float4 vertex_input_2;
			static float2 vertex_output_1;
			static float2 vertex_output_1;
			static float vertex_output_2;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TEXCOORD; // TEXCOORD
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_1 : TEXCOORD1; // TEXCOORD_1
				float2 vertex_output_1 : TEXCOORD3; // TEXCOORD_3
				float vertex_output_2 : TEXCOORD2; // TEXCOORD_2
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_54 = vertex_input_0.y * vertex_uniform_buffer_2[1u].x;
				precise float vertex_unnamed_55 = vertex_input_0.y * vertex_uniform_buffer_2[1u].y;
				precise float vertex_unnamed_56 = vertex_input_0.y * vertex_uniform_buffer_2[1u].z;
				precise float vertex_unnamed_57 = vertex_input_0.y * vertex_uniform_buffer_2[1u].w;
				precise float vertex_unnamed_91 = mad(vertex_uniform_buffer_2[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].x, vertex_input_0.x, vertex_unnamed_54)) + vertex_uniform_buffer_2[3u].x;
				precise float vertex_unnamed_92 = mad(vertex_uniform_buffer_2[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].y, vertex_input_0.x, vertex_unnamed_55)) + vertex_uniform_buffer_2[3u].y;
				precise float vertex_unnamed_93 = mad(vertex_uniform_buffer_2[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].z, vertex_input_0.x, vertex_unnamed_56)) + vertex_uniform_buffer_2[3u].z;
				precise float vertex_unnamed_94 = mad(vertex_uniform_buffer_2[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].w, vertex_input_0.x, vertex_unnamed_57)) + vertex_uniform_buffer_2[3u].w;
				precise float vertex_unnamed_102 = vertex_unnamed_92 * vertex_uniform_buffer_3[18u].x;
				precise float vertex_unnamed_103 = vertex_unnamed_92 * vertex_uniform_buffer_3[18u].y;
				precise float vertex_unnamed_104 = vertex_unnamed_92 * vertex_uniform_buffer_3[18u].z;
				precise float vertex_unnamed_105 = vertex_unnamed_92 * vertex_uniform_buffer_3[18u].w;
				float vertex_unnamed_138 = mad(vertex_uniform_buffer_3[20u].w, vertex_unnamed_94, mad(vertex_uniform_buffer_3[19u].w, vertex_unnamed_93, mad(vertex_uniform_buffer_3[17u].w, vertex_unnamed_91, vertex_unnamed_105)));
				precise float vertex_unnamed_142 = vertex_uniform_buffer_1[5u].x / vertex_unnamed_138;
				precise float vertex_unnamed_147 = mad(vertex_uniform_buffer_3[20u].z, vertex_unnamed_94, mad(vertex_uniform_buffer_3[19u].z, vertex_unnamed_93, mad(vertex_uniform_buffer_3[17u].z, vertex_unnamed_91, vertex_unnamed_104))) + max(min(vertex_unnamed_142, 0.0f), -1.0f);
				gl_Position.x = mad(vertex_uniform_buffer_3[20u].x, vertex_unnamed_94, mad(vertex_uniform_buffer_3[19u].x, vertex_unnamed_93, mad(vertex_uniform_buffer_3[17u].x, vertex_unnamed_91, vertex_unnamed_102)));
				gl_Position.y = mad(vertex_uniform_buffer_3[20u].y, vertex_unnamed_94, mad(vertex_uniform_buffer_3[19u].y, vertex_unnamed_93, mad(vertex_uniform_buffer_3[17u].y, vertex_unnamed_91, vertex_unnamed_103)));
				gl_Position.w = vertex_unnamed_138;
				precise float vertex_unnamed_152 = (-0.0f) - vertex_unnamed_147;
				precise float vertex_unnamed_154 = vertex_unnamed_152 + min(vertex_unnamed_138, vertex_unnamed_147);
				gl_Position.z = mad(vertex_uniform_buffer_1[5u].y, vertex_unnamed_154, vertex_unnamed_147);
				vertex_output_1.x = mad(vertex_input_2.x, vertex_uniform_buffer_0[2u].x, vertex_uniform_buffer_0[2u].z);
				vertex_output_1.y = mad(vertex_input_2.y, vertex_uniform_buffer_0[2u].y, vertex_uniform_buffer_0[2u].w);
				vertex_output_1.x = mad(vertex_input_2.x, vertex_uniform_buffer_0[3u].x, vertex_uniform_buffer_0[3u].z);
				vertex_output_1.y = mad(vertex_input_2.y, vertex_uniform_buffer_0[3u].y, vertex_uniform_buffer_0[3u].w);
				precise float vertex_unnamed_195 = (-0.0f) - vertex_uniform_buffer_0[4u].x;
				precise float vertex_unnamed_204 = (-0.0f) - vertex_uniform_buffer_0[4u].y;
				precise float vertex_unnamed_209 = mad(vertex_unnamed_204, vertex_uniform_buffer_0[4u].z, mad(vertex_unnamed_195, vertex_uniform_buffer_0[4u].z, 1.0f)) * 0.5f;
				vertex_output_2 = vertex_unnamed_209;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[2] = float4(_MainTex_ST[0], _MainTex_ST[1], _MainTex_ST[2], _MainTex_ST[3]);

				vertex_uniform_buffer_0[3] = float4(_OutlineTex_ST[0], _OutlineTex_ST[1], _OutlineTex_ST[2], _OutlineTex_ST[3]);

				vertex_uniform_buffer_0[4] = float4(_OutlineWidth, vertex_uniform_buffer_0[4][1], vertex_uniform_buffer_0[4][2], vertex_uniform_buffer_0[4][3]);

				vertex_uniform_buffer_0[4] = float4(vertex_uniform_buffer_0[4][0], _FaceDilate, vertex_uniform_buffer_0[4][2], vertex_uniform_buffer_0[4][3]);

				vertex_uniform_buffer_0[4] = float4(vertex_uniform_buffer_0[4][0], vertex_uniform_buffer_0[4][1], _ScaleRatioA, vertex_uniform_buffer_0[4][3]);

				vertex_uniform_buffer_1[5] = float4(unity_LightShadowBias[0], unity_LightShadowBias[1], unity_LightShadowBias[2], unity_LightShadowBias[3]);

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
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				return stage_output;
			}

			#endif // SHADOWS_DEPTH
			#endif // !SHADOWS_CUBE


			#ifdef SHADOWS_CUBE
			#ifndef SHADOWS_DEPTH
			#define ANY_SHADER_VARIANT_ACTIVE

			float4 _MainTex_ST;
			float4 _OutlineTex_ST;
			float _OutlineWidth;
			float _FaceDilate;
			float _ScaleRatioA;
			float4 unity_LightShadowBias;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[5];
			static float4 vertex_uniform_buffer_1[6];
			static float4 vertex_uniform_buffer_2[4];
			static float4 vertex_uniform_buffer_3[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float3 vertex_input_1;
			static float4 vertex_input_2;
			static float2 vertex_output_1;
			static float2 vertex_output_1;
			static float vertex_output_2;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TEXCOORD; // TEXCOORD
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_1 : TEXCOORD1; // TEXCOORD_1
				float2 vertex_output_1 : TEXCOORD3; // TEXCOORD_3
				float vertex_output_2 : TEXCOORD2; // TEXCOORD_2
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_54 = vertex_input_0.y * vertex_uniform_buffer_2[1u].x;
				precise float vertex_unnamed_55 = vertex_input_0.y * vertex_uniform_buffer_2[1u].y;
				precise float vertex_unnamed_56 = vertex_input_0.y * vertex_uniform_buffer_2[1u].z;
				precise float vertex_unnamed_57 = vertex_input_0.y * vertex_uniform_buffer_2[1u].w;
				precise float vertex_unnamed_91 = mad(vertex_uniform_buffer_2[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].x, vertex_input_0.x, vertex_unnamed_54)) + vertex_uniform_buffer_2[3u].x;
				precise float vertex_unnamed_92 = mad(vertex_uniform_buffer_2[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].y, vertex_input_0.x, vertex_unnamed_55)) + vertex_uniform_buffer_2[3u].y;
				precise float vertex_unnamed_93 = mad(vertex_uniform_buffer_2[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].z, vertex_input_0.x, vertex_unnamed_56)) + vertex_uniform_buffer_2[3u].z;
				precise float vertex_unnamed_94 = mad(vertex_uniform_buffer_2[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].w, vertex_input_0.x, vertex_unnamed_57)) + vertex_uniform_buffer_2[3u].w;
				precise float vertex_unnamed_102 = vertex_unnamed_92 * vertex_uniform_buffer_3[18u].x;
				precise float vertex_unnamed_103 = vertex_unnamed_92 * vertex_uniform_buffer_3[18u].y;
				precise float vertex_unnamed_104 = vertex_unnamed_92 * vertex_uniform_buffer_3[18u].z;
				precise float vertex_unnamed_105 = vertex_unnamed_92 * vertex_uniform_buffer_3[18u].w;
				float vertex_unnamed_137 = mad(vertex_uniform_buffer_3[20u].z, vertex_unnamed_94, mad(vertex_uniform_buffer_3[19u].z, vertex_unnamed_93, mad(vertex_uniform_buffer_3[17u].z, vertex_unnamed_91, vertex_unnamed_104)));
				float vertex_unnamed_138 = mad(vertex_uniform_buffer_3[20u].w, vertex_unnamed_94, mad(vertex_uniform_buffer_3[19u].w, vertex_unnamed_93, mad(vertex_uniform_buffer_3[17u].w, vertex_unnamed_91, vertex_unnamed_105)));
				precise float vertex_unnamed_140 = (-0.0f) - vertex_unnamed_137;
				precise float vertex_unnamed_142 = vertex_unnamed_140 + min(vertex_unnamed_138, vertex_unnamed_137);
				gl_Position.z = mad(vertex_uniform_buffer_1[5u].y, vertex_unnamed_142, vertex_unnamed_137);
				gl_Position.x = mad(vertex_uniform_buffer_3[20u].x, vertex_unnamed_94, mad(vertex_uniform_buffer_3[19u].x, vertex_unnamed_93, mad(vertex_uniform_buffer_3[17u].x, vertex_unnamed_91, vertex_unnamed_102)));
				gl_Position.y = mad(vertex_uniform_buffer_3[20u].y, vertex_unnamed_94, mad(vertex_uniform_buffer_3[19u].y, vertex_unnamed_93, mad(vertex_uniform_buffer_3[17u].y, vertex_unnamed_91, vertex_unnamed_103)));
				gl_Position.w = vertex_unnamed_138;
				vertex_output_1.x = mad(vertex_input_2.x, vertex_uniform_buffer_0[2u].x, vertex_uniform_buffer_0[2u].z);
				vertex_output_1.y = mad(vertex_input_2.y, vertex_uniform_buffer_0[2u].y, vertex_uniform_buffer_0[2u].w);
				vertex_output_1.x = mad(vertex_input_2.x, vertex_uniform_buffer_0[3u].x, vertex_uniform_buffer_0[3u].z);
				vertex_output_1.y = mad(vertex_input_2.y, vertex_uniform_buffer_0[3u].y, vertex_uniform_buffer_0[3u].w);
				precise float vertex_unnamed_186 = (-0.0f) - vertex_uniform_buffer_0[4u].x;
				precise float vertex_unnamed_195 = (-0.0f) - vertex_uniform_buffer_0[4u].y;
				precise float vertex_unnamed_200 = mad(vertex_unnamed_195, vertex_uniform_buffer_0[4u].z, mad(vertex_unnamed_186, vertex_uniform_buffer_0[4u].z, 1.0f)) * 0.5f;
				vertex_output_2 = vertex_unnamed_200;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[2] = float4(_MainTex_ST[0], _MainTex_ST[1], _MainTex_ST[2], _MainTex_ST[3]);

				vertex_uniform_buffer_0[3] = float4(_OutlineTex_ST[0], _OutlineTex_ST[1], _OutlineTex_ST[2], _OutlineTex_ST[3]);

				vertex_uniform_buffer_0[4] = float4(_OutlineWidth, vertex_uniform_buffer_0[4][1], vertex_uniform_buffer_0[4][2], vertex_uniform_buffer_0[4][3]);

				vertex_uniform_buffer_0[4] = float4(vertex_uniform_buffer_0[4][0], _FaceDilate, vertex_uniform_buffer_0[4][2], vertex_uniform_buffer_0[4][3]);

				vertex_uniform_buffer_0[4] = float4(vertex_uniform_buffer_0[4][0], vertex_uniform_buffer_0[4][1], _ScaleRatioA, vertex_uniform_buffer_0[4][3]);

				vertex_uniform_buffer_1[5] = float4(unity_LightShadowBias[0], unity_LightShadowBias[1], unity_LightShadowBias[2], unity_LightShadowBias[3]);

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
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				return stage_output;
			}

			#endif // SHADOWS_CUBE
			#endif // !SHADOWS_DEPTH


			#ifdef SHADOWS_DEPTH
			#ifndef SHADOWS_CUBE
			#define ANY_SHADER_VARIANT_ACTIVE

			float4 unity_LightShadowBias;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;
			float4 _MainTex_ST;
			float4 _OutlineTex_ST;
			float _OutlineWidth;
			float _FaceDilate;
			float _ScaleRatioA;

			static float4 unity_ObjectToWorld__array[4];
			static float4 unity_MatrixVP__array[4];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float2 vertex_output_0;
			static float4 vertex_input_1;
			static float2 vertex_output_2;
			static float vertex_output_1;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION;
				float4 vertex_input_1 : TEXCOORD0;
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_0 : TEXCOORD1; // vs_TEXCOORD1
				float vertex_output_1 : TEXCOORD2; // vs_TEXCOORD2
				float2 vertex_output_2 : TEXCOORD3; // vs_TEXCOORD3
				float4 gl_Position : SV_Position;
			};

			static float4 vertex_unnamed_9;
			static float4 vertex_unnamed_48;
			static float vertex_unnamed_95;

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
				vertex_unnamed_48.x = unity_LightShadowBias.x / vertex_unnamed_9.w;
				vertex_unnamed_48.x = min(vertex_unnamed_48.x, 0.0f);
				vertex_unnamed_48.x = max(vertex_unnamed_48.x, -1.0f);
				vertex_unnamed_95 = vertex_unnamed_9.z + vertex_unnamed_48.x;
				vertex_unnamed_48.x = min(vertex_unnamed_9.w, vertex_unnamed_95);
				gl_Position = float4(vertex_unnamed_9.xyw.x, vertex_unnamed_9.xyw.y, gl_Position.z, vertex_unnamed_9.xyw.z);
				vertex_unnamed_9.x = (-vertex_unnamed_95) + vertex_unnamed_48.x;
				gl_Position.z = (unity_LightShadowBias.y * vertex_unnamed_9.x) + vertex_unnamed_95;
				vertex_output_0 = (vertex_input_1.xy * _MainTex_ST.xy) + _MainTex_ST.zw;
				vertex_output_2 = (vertex_input_1.xy * _OutlineTex_ST.xy) + _OutlineTex_ST.zw;
				vertex_unnamed_9.x = ((-_OutlineWidth) * _ScaleRatioA) + 1.0f;
				vertex_unnamed_9.x = ((-_FaceDilate) * _ScaleRatioA) + vertex_unnamed_9.x;
				vertex_output_1 = vertex_unnamed_9.x * 0.5f;
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
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}

			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

			static float2 fragment_input_0;
			static float fragment_input_1;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_0 : TEXCOORD1; // vs_TEXCOORD1
				float fragment_input_1 : TEXCOORD2; // vs_TEXCOORD2
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static float fragment_unnamed_8;
			static bool fragment_unnamed_36;

			void frag_main()
			{
				fragment_unnamed_8 = _MainTex.Sample(sampler_MainTex, fragment_input_0).w;
				fragment_unnamed_8 += (-fragment_input_1);
				fragment_unnamed_36 = fragment_unnamed_8 < 0.0f;
				if ((int(fragment_unnamed_36) * (-1)) != 0)
				{
					discard;
				}
				fragment_output_0 = 0.0f.xxxx;
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

			#endif // SHADOWS_DEPTH
			#endif // !SHADOWS_CUBE


			#ifdef SHADOWS_CUBE
			#ifndef SHADOWS_DEPTH
			#define ANY_SHADER_VARIANT_ACTIVE

			float4 unity_LightShadowBias;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;
			float4 _MainTex_ST;
			float4 _OutlineTex_ST;
			float _OutlineWidth;
			float _FaceDilate;
			float _ScaleRatioA;

			static float4 unity_ObjectToWorld__array[4];
			static float4 unity_MatrixVP__array[4];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float2 vertex_output_0;
			static float4 vertex_input_1;
			static float2 vertex_output_2;
			static float vertex_output_1;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION;
				float4 vertex_input_1 : TEXCOORD0;
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_0 : TEXCOORD1; // vs_TEXCOORD1
				float vertex_output_1 : TEXCOORD2; // vs_TEXCOORD2
				float2 vertex_output_2 : TEXCOORD3; // vs_TEXCOORD3
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
				vertex_unnamed_48.x = min(vertex_unnamed_9.w, vertex_unnamed_9.z);
				vertex_unnamed_48.x = (-vertex_unnamed_9.z) + vertex_unnamed_48.x;
				gl_Position.z = (unity_LightShadowBias.y * vertex_unnamed_48.x) + vertex_unnamed_9.z;
				gl_Position = float4(vertex_unnamed_9.xyw.x, vertex_unnamed_9.xyw.y, gl_Position.z, vertex_unnamed_9.xyw.z);
				vertex_output_0 = (vertex_input_1.xy * _MainTex_ST.xy) + _MainTex_ST.zw;
				vertex_output_2 = (vertex_input_1.xy * _OutlineTex_ST.xy) + _OutlineTex_ST.zw;
				vertex_unnamed_9.x = ((-_OutlineWidth) * _ScaleRatioA) + 1.0f;
				vertex_unnamed_9.x = ((-_FaceDilate) * _ScaleRatioA) + vertex_unnamed_9.x;
				vertex_output_1 = vertex_unnamed_9.x * 0.5f;
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
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}

			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

			static float2 fragment_input_0;
			static float fragment_input_1;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_0 : TEXCOORD1; // vs_TEXCOORD1
				float fragment_input_1 : TEXCOORD2; // vs_TEXCOORD2
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static float fragment_unnamed_8;
			static bool fragment_unnamed_36;

			void frag_main()
			{
				fragment_unnamed_8 = _MainTex.Sample(sampler_MainTex, fragment_input_0).w;
				fragment_unnamed_8 += (-fragment_input_1);
				fragment_unnamed_36 = fragment_unnamed_8 < 0.0f;
				if ((int(fragment_unnamed_36) * (-1)) != 0)
				{
					discard;
				}
				fragment_output_0 = 0.0f.xxxx;
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

			#endif // SHADOWS_CUBE
			#endif // !SHADOWS_DEPTH


			#ifdef SHADOWS_DEPTH
			#ifndef SHADOWS_CUBE
			#define ANY_SHADER_VARIANT_ACTIVE

			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

			static float2 fragment_input_1;
			static float2 fragment_input_1;
			static float fragment_input_2;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD1; // TEXCOORD_1
				float2 fragment_input_1 : TEXCOORD3; // TEXCOORD_3
				float fragment_input_2 : TEXCOORD2; // TEXCOORD_2
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static bool discard_state;

			void discard_cond(bool fragment_unnamed_56)
			{
				if (fragment_unnamed_56)
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
				precise float fragment_unnamed_39 = (-0.0f) - fragment_input_2;
				precise float fragment_unnamed_41 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y)).w + fragment_unnamed_39;
				discard_cond(fragment_unnamed_41 < 0.0f);
				fragment_output_0.x = 0.0f;
				fragment_output_0.y = 0.0f;
				fragment_output_0.z = 0.0f;
				fragment_output_0.w = 0.0f;
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // SHADOWS_DEPTH
			#endif // !SHADOWS_CUBE


			#ifdef SHADOWS_CUBE
			#ifndef SHADOWS_DEPTH
			#define ANY_SHADER_VARIANT_ACTIVE

			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

			static float2 fragment_input_1;
			static float2 fragment_input_1;
			static float fragment_input_2;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD1; // TEXCOORD_1
				float2 fragment_input_1 : TEXCOORD3; // TEXCOORD_3
				float fragment_input_2 : TEXCOORD2; // TEXCOORD_2
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static bool discard_state;

			void discard_cond(bool fragment_unnamed_56)
			{
				if (fragment_unnamed_56)
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
				precise float fragment_unnamed_39 = (-0.0f) - fragment_input_2;
				precise float fragment_unnamed_41 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y)).w + fragment_unnamed_39;
				discard_cond(fragment_unnamed_41 < 0.0f);
				fragment_output_0.x = 0.0f;
				fragment_output_0.y = 0.0f;
				fragment_output_0.z = 0.0f;
				fragment_output_0.w = 0.0f;
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // SHADOWS_CUBE
			#endif // !SHADOWS_DEPTH


			// Fallback Shader Code
			#ifndef ANY_SHADER_VARIANT_ACTIVE

			// https://docs.unity3d.com/Manual/SL-UnityShaderVariables.html
			float4x4 unity_MatrixMVP;

			struct Vertex_Stage_Input
			{
				float3 pos : POSITION;
			};

			struct Vertex_Stage_Output
			{
				float4 pos : SV_POSITION;
			};

			Vertex_Stage_Output vert(Vertex_Stage_Input input)
			{
				Vertex_Stage_Output output;
				output.pos = mul(unity_MatrixMVP, float4(input.pos, 1.0));
				return output;
			}

			float4 frag(Vertex_Stage_Output input) : SV_TARGET
			{
				// Output solid grey color (e.g., 50% grey)
				return float4(0.5, 0.5, 0.5, 1.0); // RGBA
			}

			#endif // !ANY_SHADER_VARIANT_ACTIVE


			ENDHLSL
		}
	}
	CustomEditor "TMPro.EditorUtilities.TMP_SDFShaderGUI"
}
