Shader "Hidden/PostProcessing/Debug/Vectorscope"
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
			GpuProgramID 15523

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

			struct fragment_unnamed_66
			{
				uint _m0[1];
			};

			ByteAddressBuffer fragment_unnamed_70;

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
			static float2 fragment_unnamed_25;
			static uint2 fragment_unnamed_42;
			static float3 fragment_unnamed_95;
			static float fragment_unnamed_106;

			void frag_main()
			{
				fragment_unnamed_9 = (fragment_input_0.xyxy * float4(-1.0f, 1.0f, -1.0f, 1.0f)) + float4(0.5f, -0.5f, 1.0f, 0.0f);
				fragment_unnamed_25 = fragment_unnamed_9.zw * _Params.xy;
				fragment_unnamed_42 = uint2(fragment_unnamed_25);
				fragment_unnamed_25 = float2(fragment_unnamed_42);
				fragment_unnamed_25.x = (fragment_unnamed_25.y * _Params.x) + fragment_unnamed_25.x;
				fragment_unnamed_42.x = uint(fragment_unnamed_25.x);
				fragment_unnamed_42.x = fragment_unnamed_70.Load<uint>(fragment_unnamed_42.x * 4 + 0);
				fragment_unnamed_25.x = float(fragment_unnamed_42.x);
				fragment_unnamed_25.x = (fragment_unnamed_25.x * _Params.z) + (-0.0040000001899898052215576171875f);
				fragment_unnamed_25.x = max(fragment_unnamed_25.x, 0.0f);
				float2 fragment_unnamed_103 = (fragment_unnamed_25.xx * 6.19999980926513671875f.xx) + float2(0.5f, 1.7000000476837158203125f);
				fragment_unnamed_95 = float3(fragment_unnamed_103.x, fragment_unnamed_103.y, fragment_unnamed_95.z);
				fragment_unnamed_106 = fragment_unnamed_25.x * fragment_unnamed_95.x;
				fragment_unnamed_25.x = (fragment_unnamed_25.x * fragment_unnamed_95.y) + 0.0599999986588954925537109375f;
				fragment_unnamed_25.x = fragment_unnamed_106 / fragment_unnamed_25.x;
				fragment_unnamed_25.x *= fragment_unnamed_25.x;
				fragment_unnamed_25.x = min(fragment_unnamed_25.x, 1.0f);
				fragment_unnamed_9.x = ((-fragment_unnamed_9.x) * 0.3440000116825103759765625f) + 0.5f;
				fragment_unnamed_95.y = ((-fragment_unnamed_9.y) * 0.7139999866485595703125f) + fragment_unnamed_9.x;
				float2 fragment_unnamed_160 = (fragment_input_0.yx * float2(1.40299999713897705078125f, 1.7730000019073486328125f)) + float2(-0.201499998569488525390625f, -0.38650000095367431640625f);
				fragment_unnamed_95 = float3(fragment_unnamed_160.x, fragment_unnamed_95.y, fragment_unnamed_160.y);
				float3 fragment_unnamed_171 = (fragment_unnamed_25.xxx * (-fragment_unnamed_95)) + fragment_unnamed_95;
				fragment_output_0 = float4(fragment_unnamed_171.x, fragment_unnamed_171.y, fragment_unnamed_171.z, fragment_output_0.w);
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


			float3 _Params;

			static float4 fragment_uniform_buffer_0[29];
			Buffer<uint4> T0;

			static float2 fragment_input_1;
			static float2 fragment_input_1;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD; // TEXCOORD
				float2 fragment_input_1 : TEXCOORD1; // TEXCOORD_1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				float fragment_unnamed_68 = max(mad(float(T0.Load(uint(mad(float(uint(mad(fragment_input_1.y, 1.0f, 0.0f) * fragment_uniform_buffer_0[28u].y)), fragment_uniform_buffer_0[28u].x, float(uint(mad(fragment_input_1.x, -1.0f, 1.0f) * fragment_uniform_buffer_0[28u].x))))).x), fragment_uniform_buffer_0[28u].z, -0.0040000001899898052215576171875f), 0.0f);
				float fragment_unnamed_76 = (fragment_unnamed_68 * mad(fragment_unnamed_68, 6.19999980926513671875f, 0.5f)) / mad(fragment_unnamed_68, mad(fragment_unnamed_68, 6.19999980926513671875f, 1.7000000476837158203125f), 0.0599999986588954925537109375f);
				float fragment_unnamed_78 = min(fragment_unnamed_76 * fragment_unnamed_76, 1.0f);
				float fragment_unnamed_84 = mad((-0.0f) - mad(fragment_input_1.y, 1.0f, -0.5f), 0.7139999866485595703125f, mad((-0.0f) - mad(fragment_input_1.x, -1.0f, 0.5f), 0.3440000116825103759765625f, 0.5f));
				float fragment_unnamed_90 = mad(fragment_input_1.y, 1.40299999713897705078125f, -0.201499998569488525390625f);
				float fragment_unnamed_93 = mad(fragment_input_1.x, 1.7730000019073486328125f, -0.38650000095367431640625f);
				fragment_output_0.x = mad(fragment_unnamed_78, (-0.0f) - fragment_unnamed_90, fragment_unnamed_90);
				fragment_output_0.y = mad(fragment_unnamed_78, (-0.0f) - fragment_unnamed_84, fragment_unnamed_84);
				fragment_output_0.z = mad(fragment_unnamed_78, (-0.0f) - fragment_unnamed_93, fragment_unnamed_93);
				fragment_output_0.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[28] = float4(_Params[0], _Params[1], _Params[2], fragment_uniform_buffer_0[28][3]);

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
