Shader "Hidden/CC_BrightnessContrastGamma"
{
	Properties
	{
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_BCG ("Brightness (X), Contrast (Y), Gamma (Z)", Vector) = (0,1,1,1)
		_Coeffs ("Contrast coeffs (RGB)", Vector) = (0.5,0.5,0.5,1)
	}
	SubShader
	{
		Pass
		{
			ZTest Always
			ZWrite Off
			Cull Off
			Fog
			{
				Mode Off
			}
			GpuProgramID 56653

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

			float4 _BCG;
			float4 _Coeffs;

			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

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
			static float4 fragment_unnamed_25;

			void frag_main()
			{
				fragment_unnamed_9 = _MainTex.Sample(sampler_MainTex, fragment_input_0);
				fragment_unnamed_25 = float4(_Coeffs.xyz.x, _Coeffs.xyz.y, _Coeffs.xyz.z, fragment_unnamed_25.w);
				fragment_unnamed_25.w = fragment_unnamed_9.w;
				fragment_unnamed_9 = (fragment_unnamed_9 * _BCG.xxxx) + (-fragment_unnamed_25);
				fragment_unnamed_9 = (fragment_unnamed_9 * _BCG.yyyy) + fragment_unnamed_25;
				fragment_unnamed_9 = clamp(fragment_unnamed_9, 0.0f.xxxx, 1.0f.xxxx);
				fragment_unnamed_9 = log2(fragment_unnamed_9);
				fragment_unnamed_9 *= _BCG.zzzz;
				fragment_output_0 = exp2(fragment_unnamed_9);
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_0 = stage_input.fragment_input_0;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			float4 _BCG;
			float4 _Coeffs;

			static float4 fragment_uniform_buffer_0[4];
			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

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
				float4 fragment_unnamed_38 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				float fragment_unnamed_43 = fragment_unnamed_38.w;
				uint4 fragment_unnamed_49 = asuint(fragment_uniform_buffer_0[3u]);
				float fragment_unnamed_51 = asfloat(fragment_unnamed_49.x);
				float fragment_unnamed_53 = asfloat(fragment_unnamed_49.y);
				float fragment_unnamed_55 = asfloat(fragment_unnamed_49.z);
				precise float fragment_unnamed_60 = (-0.0f) - fragment_unnamed_51;
				precise float fragment_unnamed_62 = (-0.0f) - fragment_unnamed_53;
				precise float fragment_unnamed_63 = (-0.0f) - fragment_unnamed_55;
				precise float fragment_unnamed_64 = (-0.0f) - fragment_unnamed_43;
				precise float fragment_unnamed_89 = log2(clamp(mad(mad(fragment_unnamed_38.x, fragment_uniform_buffer_0[2u].x, fragment_unnamed_60), fragment_uniform_buffer_0[2u].y, fragment_unnamed_51), 0.0f, 1.0f)) * fragment_uniform_buffer_0[2u].z;
				precise float fragment_unnamed_90 = log2(clamp(mad(mad(fragment_unnamed_38.y, fragment_uniform_buffer_0[2u].x, fragment_unnamed_62), fragment_uniform_buffer_0[2u].y, fragment_unnamed_53), 0.0f, 1.0f)) * fragment_uniform_buffer_0[2u].z;
				precise float fragment_unnamed_91 = log2(clamp(mad(mad(fragment_unnamed_38.z, fragment_uniform_buffer_0[2u].x, fragment_unnamed_63), fragment_uniform_buffer_0[2u].y, fragment_unnamed_55), 0.0f, 1.0f)) * fragment_uniform_buffer_0[2u].z;
				precise float fragment_unnamed_92 = log2(clamp(mad(mad(fragment_unnamed_43, fragment_uniform_buffer_0[2u].x, fragment_unnamed_64), fragment_uniform_buffer_0[2u].y, fragment_unnamed_43), 0.0f, 1.0f)) * fragment_uniform_buffer_0[2u].z;
				fragment_output_0.x = exp2(fragment_unnamed_89);
				fragment_output_0.y = exp2(fragment_unnamed_90);
				fragment_output_0.z = exp2(fragment_unnamed_91);
				fragment_output_0.w = exp2(fragment_unnamed_92);
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[2] = float4(_BCG[0], _BCG[1], _BCG[2], _BCG[3]);

				fragment_uniform_buffer_0[3] = float4(_Coeffs[0], _Coeffs[1], _Coeffs[2], _Coeffs[3]);

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
