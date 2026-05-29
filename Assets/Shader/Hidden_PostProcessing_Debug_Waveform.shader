Shader "Hidden/PostProcessing/Debug/Waveform"
{
	Properties
	{
	}
	SubShader
	{
		Pass
		{
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 54601

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0


			float _RenderViewportScaleFactor;

			static float4 vertex_uniform_buffer_0[27];
			static float4 gl_Position;
			static float3 vertex_input_0;
			static float2 vertex_output_1;
			static float2 vertex_output_1;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				float2 vertex_output_1 : TEXCOORD1; // TEXCOORD_1
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				gl_Position.x = vertex_input_0.x;
				gl_Position.y = vertex_input_0.y;
				gl_Position.z = 0.0f;
				gl_Position.w = 1.0f;
				vertex_output_1.x = mad(vertex_input_0.x + 1.0f, 0.5f, 0.0f) * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.y = mad(vertex_input_0.y + 1.0f, -0.5f, 1.0f) * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.x = mad(vertex_input_0.x, 0.5f, 0.5f);
				vertex_output_1.y = mad(vertex_input_0.y, -0.5f, 0.5f);
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, vertex_uniform_buffer_0[26][1], vertex_uniform_buffer_0[26][2], vertex_uniform_buffer_0[26][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}


			float _RenderViewportScaleFactor;

			static float4 gl_Position;
			static float3 vertex_input_0;
			static float2 vertex_output_1;
			static float2 vertex_output_0;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION;
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_0 : TEXCOORD0; // vs_TEXCOORD0
				float2 vertex_output_1 : TEXCOORD1; // vs_TEXCOORD1
				float4 gl_Position : SV_Position;
			};

			static float2 vertex_unnamed_33;

			void vert_main()
			{
				gl_Position = float4(vertex_input_0.xy.x, vertex_input_0.xy.y, gl_Position.z, gl_Position.w);
				gl_Position = float4(gl_Position.x, gl_Position.y, float2(0.0f, 1.0f).x, float2(0.0f, 1.0f).y);
				vertex_unnamed_33 = vertex_input_0.xy + 1.0f.xx;
				vertex_unnamed_33 = (vertex_unnamed_33 * float2(0.5f, -0.5f)) + float2(0.0f, 1.0f);
				vertex_output_1 = vertex_unnamed_33 * _RenderViewportScaleFactor.xx;
				vertex_output_0 = (vertex_input_0.xy * float2(0.5f, -0.5f)) + 0.5f.xx;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_0 = vertex_output_0;
				return stage_output;
			}

			float3 _Params;

			struct fragment_unnamed_68
			{
				uint _m0[4];
			};

			ByteAddressBuffer fragment_unnamed_72;

			static float4 gl_FragCoord;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 gl_FragCoord : SV_Position;
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static uint3 fragment_unnamed_28;
			static float4 fragment_unnamed_37;
			static float3 fragment_unnamed_94;
			static float3 fragment_unnamed_154;

			void frag_main()
			{
				float4 fragment_unnamed_9 = float4(gl_FragCoord.xyz, 1.0f / gl_FragCoord.w);
				uint2 fragment_unnamed_33 = uint2(fragment_unnamed_9.xy);
				fragment_unnamed_28 = uint3(fragment_unnamed_33.x, fragment_unnamed_33.y, fragment_unnamed_28.z);
				float2 fragment_unnamed_40 = float2(fragment_unnamed_28.xy);
				fragment_unnamed_37 = float4(fragment_unnamed_40.x, fragment_unnamed_40.y, fragment_unnamed_37.z, fragment_unnamed_37.w);
				fragment_unnamed_37.x = (fragment_unnamed_37.x * _Params.y) + fragment_unnamed_37.y;
				fragment_unnamed_28.x = uint(fragment_unnamed_37.x);
				fragment_unnamed_28 = uint3(fragment_unnamed_72.Load<uint>(fragment_unnamed_28.x * 16 + 0), fragment_unnamed_72.Load<uint>(fragment_unnamed_28.x * 16 + 4), fragment_unnamed_72.Load<uint>(fragment_unnamed_28.x * 16 + 8));
				float3 fragment_unnamed_90 = float3(fragment_unnamed_28);
				fragment_unnamed_37 = float4(fragment_unnamed_90.x, fragment_unnamed_90.y, fragment_unnamed_90.z, fragment_unnamed_37.w);
				fragment_unnamed_94 = fragment_unnamed_37.yyy * float3(0.0199999995529651641845703125f, 1.10000002384185791015625f, 0.0500000007450580596923828125f);
				float3 fragment_unnamed_109 = (fragment_unnamed_37.xxx * float3(1.39999997615814208984375f, 0.02999999932944774627685546875f, 0.0199999995529651641845703125f)) + fragment_unnamed_94;
				fragment_unnamed_37 = float4(fragment_unnamed_109.x, fragment_unnamed_109.y, fragment_unnamed_37.z, fragment_unnamed_109.z);
				float3 fragment_unnamed_121 = (fragment_unnamed_37.zzz * float3(0.0f, 0.25f, 1.5f)) + fragment_unnamed_37.xyw;
				fragment_unnamed_37 = float4(fragment_unnamed_121.x, fragment_unnamed_121.y, fragment_unnamed_121.z, fragment_unnamed_37.w);
				float3 fragment_unnamed_133 = (fragment_unnamed_37.xyz * _Params.zzz) + (-0.0040000001899898052215576171875f).xxx;
				fragment_unnamed_37 = float4(fragment_unnamed_133.x, fragment_unnamed_133.y, fragment_unnamed_133.z, fragment_unnamed_37.w);
				float3 fragment_unnamed_139 = max(fragment_unnamed_37.xyz, 0.0f.xxx);
				fragment_unnamed_37 = float4(fragment_unnamed_139.x, fragment_unnamed_139.y, fragment_unnamed_139.z, fragment_unnamed_37.w);
				fragment_unnamed_94 = (fragment_unnamed_37.xyz * 6.19999980926513671875f.xxx) + 0.5f.xxx;
				fragment_unnamed_94 = fragment_unnamed_37.xyz * fragment_unnamed_94;
				fragment_unnamed_154 = (fragment_unnamed_37.xyz * 6.19999980926513671875f.xxx) + 1.7000000476837158203125f.xxx;
				float3 fragment_unnamed_167 = (fragment_unnamed_37.xyz * fragment_unnamed_154) + 0.0599999986588954925537109375f.xxx;
				fragment_unnamed_37 = float4(fragment_unnamed_167.x, fragment_unnamed_167.y, fragment_unnamed_167.z, fragment_unnamed_37.w);
				float3 fragment_unnamed_173 = fragment_unnamed_94 / fragment_unnamed_37.xyz;
				fragment_unnamed_37 = float4(fragment_unnamed_173.x, fragment_unnamed_173.y, fragment_unnamed_173.z, fragment_unnamed_37.w);
				float3 fragment_unnamed_180 = fragment_unnamed_37.xyz * fragment_unnamed_37.xyz;
				fragment_unnamed_37 = float4(fragment_unnamed_180.x, fragment_unnamed_180.y, fragment_unnamed_180.z, fragment_unnamed_37.w);
				float3 fragment_unnamed_188 = min(fragment_unnamed_37.xyz, 1.0f.xxx);
				fragment_output_0 = float4(fragment_unnamed_188.x, fragment_unnamed_188.y, fragment_unnamed_188.z, fragment_output_0.w);
				fragment_output_0.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				gl_FragCoord = stage_input.gl_FragCoord;
				gl_FragCoord.w = 1.0 / gl_FragCoord.w;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			float3 _Params;

			static float4 fragment_uniform_buffer_0[29];
			Buffer<uint4> T0;

			static float4 gl_FragCoord;
			static float2 fragment_input_1;
			static float2 fragment_input_1;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD; // TEXCOORD
				float2 fragment_input_1 : TEXCOORD1; // TEXCOORD_1
				float4 gl_FragCoord : SV_Position;
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				uint fragment_unnamed_44 = uint(mad(float(uint(gl_FragCoord.x)), fragment_uniform_buffer_0[28u].y, float(uint(gl_FragCoord.y)))) * 4u;
				uint3 fragment_unnamed_57 = uint3(T0.Load(fragment_unnamed_44).x, T0.Load(fragment_unnamed_44 + 1u).x, T0.Load(fragment_unnamed_44 + 2u).x);
				float fragment_unnamed_61 = float(fragment_unnamed_57.x);
				float fragment_unnamed_62 = float(fragment_unnamed_57.y);
				float fragment_unnamed_63 = float(fragment_unnamed_57.z);
				float fragment_unnamed_88 = max(mad(mad(fragment_unnamed_63, 0.0f, mad(fragment_unnamed_61, 1.39999997615814208984375f, fragment_unnamed_62 * 0.0199999995529651641845703125f)), fragment_uniform_buffer_0[28u].z, -0.0040000001899898052215576171875f), 0.0f);
				float fragment_unnamed_89 = max(mad(mad(fragment_unnamed_63, 0.25f, mad(fragment_unnamed_61, 0.02999999932944774627685546875f, fragment_unnamed_62 * 1.10000002384185791015625f)), fragment_uniform_buffer_0[28u].z, -0.0040000001899898052215576171875f), 0.0f);
				float fragment_unnamed_90 = max(mad(mad(fragment_unnamed_63, 1.5f, mad(fragment_unnamed_61, 0.0199999995529651641845703125f, fragment_unnamed_62 * 0.0500000007450580596923828125f)), fragment_uniform_buffer_0[28u].z, -0.0040000001899898052215576171875f), 0.0f);
				float fragment_unnamed_107 = (fragment_unnamed_88 * mad(fragment_unnamed_88, 6.19999980926513671875f, 0.5f)) / mad(fragment_unnamed_88, mad(fragment_unnamed_88, 6.19999980926513671875f, 1.7000000476837158203125f), 0.0599999986588954925537109375f);
				float fragment_unnamed_108 = (fragment_unnamed_89 * mad(fragment_unnamed_89, 6.19999980926513671875f, 0.5f)) / mad(fragment_unnamed_89, mad(fragment_unnamed_89, 6.19999980926513671875f, 1.7000000476837158203125f), 0.0599999986588954925537109375f);
				float fragment_unnamed_109 = (fragment_unnamed_90 * mad(fragment_unnamed_90, 6.19999980926513671875f, 0.5f)) / mad(fragment_unnamed_90, mad(fragment_unnamed_90, 6.19999980926513671875f, 1.7000000476837158203125f), 0.0599999986588954925537109375f);
				fragment_output_0.x = min(fragment_unnamed_107 * fragment_unnamed_107, 1.0f);
				fragment_output_0.y = min(fragment_unnamed_108 * fragment_unnamed_108, 1.0f);
				fragment_output_0.z = min(fragment_unnamed_109 * fragment_unnamed_109, 1.0f);
				fragment_output_0.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[28] = float4(_Params[0], _Params[1], _Params[2], fragment_uniform_buffer_0[28][3]);

				gl_FragCoord = stage_input.gl_FragCoord;
				gl_FragCoord.w = 1.0 / gl_FragCoord.w;
				fragment_input_1 = stage_input.fragment_input_1;
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
