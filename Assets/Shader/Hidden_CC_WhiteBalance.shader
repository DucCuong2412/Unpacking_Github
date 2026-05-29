Shader "Hidden/CC_WhiteBalance"
{
	Properties
	{
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_White ("White Color (RGB)", Color) = (0.5,0.5,0.5,1)
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
			GpuProgramID 2174

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

			float4 _White;

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

			static float3 fragment_unnamed_9;
			static float3 fragment_unnamed_27;

			void frag_main()
			{
				fragment_unnamed_9 = _White.xyz + 9.9999999747524270787835121154785e-07f.xxx;
				fragment_unnamed_9 = 0.5f.xxx / fragment_unnamed_9;
				fragment_unnamed_27 = _MainTex.Sample(sampler_MainTex, fragment_input_0).xyz;
				float3 fragment_unnamed_48 = fragment_unnamed_9 * fragment_unnamed_27;
				fragment_output_0 = float4(fragment_unnamed_48.x, fragment_unnamed_48.y, fragment_unnamed_48.z, fragment_output_0.w);
				float3 fragment_unnamed_57 = clamp(fragment_output_0.xyz, 0.0f.xxx, 1.0f.xxx);
				fragment_output_0 = float4(fragment_unnamed_57.x, fragment_unnamed_57.y, fragment_unnamed_57.z, fragment_output_0.w);
				fragment_output_0.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_0 = stage_input.fragment_input_0;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			float4 _White;

			static float4 fragment_uniform_buffer_0[3];
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
				precise float fragment_unnamed_36 = fragment_uniform_buffer_0[2u].x + 9.9999999747524270787835121154785e-07f;
				precise float fragment_unnamed_38 = fragment_uniform_buffer_0[2u].y + 9.9999999747524270787835121154785e-07f;
				precise float fragment_unnamed_39 = fragment_uniform_buffer_0[2u].z + 9.9999999747524270787835121154785e-07f;
				precise float fragment_unnamed_40 = 0.5f / fragment_unnamed_36;
				precise float fragment_unnamed_42 = 0.5f / fragment_unnamed_38;
				precise float fragment_unnamed_43 = 0.5f / fragment_unnamed_39;
				float4 fragment_unnamed_53 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				precise float fragment_unnamed_58 = fragment_unnamed_40 * fragment_unnamed_53.x;
				precise float fragment_unnamed_59 = fragment_unnamed_42 * fragment_unnamed_53.y;
				precise float fragment_unnamed_60 = fragment_unnamed_43 * fragment_unnamed_53.z;
				fragment_output_0.x = clamp(fragment_unnamed_58, 0.0f, 1.0f);
				fragment_output_0.y = clamp(fragment_unnamed_59, 0.0f, 1.0f);
				fragment_output_0.z = clamp(fragment_unnamed_60, 0.0f, 1.0f);
				fragment_output_0.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[2] = float4(_White[0], _White[1], _White[2], _White[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			ENDHLSL
		}
		Pass
		{
			ZTest Always
			ZWrite Off
			Cull Off
			Fog
			{
				Mode Off
			}
			GpuProgramID 82663

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

			float4 _White;

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

			static float fragment_unnamed_8;
			static float3 fragment_unnamed_32;
			static float3 fragment_unnamed_49;
			static float fragment_unnamed_72;

			void frag_main()
			{
				fragment_unnamed_8 = dot(float3(0.381099998950958251953125f, 0.578299999237060546875f, 0.0401999987661838531494140625f), _White.xyz);
				fragment_unnamed_8 += 9.9999999747524270787835121154785e-07f;
				fragment_unnamed_8 = 0.5f / fragment_unnamed_8;
				fragment_unnamed_32 = _MainTex.Sample(sampler_MainTex, fragment_input_0).xyz;
				fragment_unnamed_49.x = dot(float3(0.381099998950958251953125f, 0.578299999237060546875f, 0.0401999987661838531494140625f), fragment_unnamed_32);
				fragment_unnamed_49.x = fragment_unnamed_8 * fragment_unnamed_49.x;
				fragment_unnamed_8 = dot(float3(0.1967000067234039306640625f, 0.724399983882904052734375f, 0.07819999754428863525390625f), _White.xyz);
				fragment_unnamed_8 += 9.9999999747524270787835121154785e-07f;
				fragment_unnamed_8 = 0.5f / fragment_unnamed_8;
				fragment_unnamed_72 = dot(float3(0.1967000067234039306640625f, 0.724399983882904052734375f, 0.07819999754428863525390625f), fragment_unnamed_32);
				fragment_unnamed_32.x = dot(float3(0.02410000003874301910400390625f, 0.1288000047206878662109375f, 0.844399988651275634765625f), fragment_unnamed_32);
				fragment_unnamed_49.y = fragment_unnamed_8 * fragment_unnamed_72;
				fragment_unnamed_8 = dot(float3(0.02410000003874301910400390625f, 0.1288000047206878662109375f, 0.844399988651275634765625f), _White.xyz);
				fragment_unnamed_8 += 9.9999999747524270787835121154785e-07f;
				fragment_unnamed_8 = 0.5f / fragment_unnamed_8;
				fragment_unnamed_49.z = fragment_unnamed_32.x * fragment_unnamed_8;
				fragment_output_0.x = dot(float3(4.467899799346923828125f, -3.5873000621795654296875f, 0.119300000369548797607421875f), fragment_unnamed_49);
				fragment_output_0.x = clamp(fragment_output_0.x, 0.0f, 1.0f);
				fragment_output_0.y = dot(float3(-1.2186000347137451171875f, 2.380899906158447265625f, -0.1624000072479248046875f), fragment_unnamed_49);
				fragment_output_0.y = clamp(fragment_output_0.y, 0.0f, 1.0f);
				fragment_output_0.z = dot(float3(0.049699999392032623291015625f, -0.243900001049041748046875f, 1.2044999599456787109375f), fragment_unnamed_49);
				fragment_output_0.z = clamp(fragment_output_0.z, 0.0f, 1.0f);
				fragment_output_0.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_0 = stage_input.fragment_input_0;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			float4 _White;

			static float4 fragment_uniform_buffer_0[3];
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
				precise float fragment_unnamed_43 = dot(float3(0.381099998950958251953125f, 0.578299999237060546875f, 0.0401999987661838531494140625f), float3(fragment_uniform_buffer_0[2u].xyz)) + 9.9999999747524270787835121154785e-07f;
				precise float fragment_unnamed_45 = 0.5f / fragment_unnamed_43;
				float4 fragment_unnamed_56 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				float fragment_unnamed_58 = fragment_unnamed_56.x;
				precise float fragment_unnamed_64 = dot(float3(0.381099998950958251953125f, 0.578299999237060546875f, 0.0401999987661838531494140625f), float3(fragment_unnamed_58, fragment_unnamed_56.yz)) * fragment_unnamed_45;
				precise float fragment_unnamed_76 = dot(float3(0.1967000067234039306640625f, 0.724399983882904052734375f, 0.07819999754428863525390625f), float3(fragment_uniform_buffer_0[2u].xyz)) + 9.9999999747524270787835121154785e-07f;
				precise float fragment_unnamed_77 = 0.5f / fragment_unnamed_76;
				precise float fragment_unnamed_87 = fragment_unnamed_77 * dot(float3(0.1967000067234039306640625f, 0.724399983882904052734375f, 0.07819999754428863525390625f), float3(fragment_unnamed_58, fragment_unnamed_56.yz));
				precise float fragment_unnamed_96 = dot(float3(0.02410000003874301910400390625f, 0.1288000047206878662109375f, 0.844399988651275634765625f), float3(fragment_uniform_buffer_0[2u].xyz)) + 9.9999999747524270787835121154785e-07f;
				precise float fragment_unnamed_97 = 0.5f / fragment_unnamed_96;
				precise float fragment_unnamed_98 = dot(float3(0.02410000003874301910400390625f, 0.1288000047206878662109375f, 0.844399988651275634765625f), float3(fragment_unnamed_58, fragment_unnamed_56.yz)) * fragment_unnamed_97;
				fragment_output_0.x = clamp(dot(float3(4.467899799346923828125f, -3.5873000621795654296875f, 0.119300000369548797607421875f), float3(fragment_unnamed_64, fragment_unnamed_87, fragment_unnamed_98)), 0.0f, 1.0f);
				fragment_output_0.y = clamp(dot(float3(-1.2186000347137451171875f, 2.380899906158447265625f, -0.1624000072479248046875f), float3(fragment_unnamed_64, fragment_unnamed_87, fragment_unnamed_98)), 0.0f, 1.0f);
				fragment_output_0.z = clamp(dot(float3(0.049699999392032623291015625f, -0.243900001049041748046875f, 1.2044999599456787109375f), float3(fragment_unnamed_64, fragment_unnamed_87, fragment_unnamed_98)), 0.0f, 1.0f);
				fragment_output_0.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[2] = float4(_White[0], _White[1], _White[2], _White[3]);

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
