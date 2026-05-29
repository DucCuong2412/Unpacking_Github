Shader "Hidden/Custom/GradRamp"
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
			GpuProgramID 22820

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.0


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
				precise float vertex_unnamed_42 = vertex_input_0.x + 1.0f;
				precise float vertex_unnamed_43 = vertex_input_0.y + 1.0f;
				precise float vertex_unnamed_54 = mad(vertex_unnamed_42, 0.5f, 0.0f) * vertex_uniform_buffer_0[26u].x;
				precise float vertex_unnamed_55 = mad(vertex_unnamed_43, -0.5f, 1.0f) * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.x = vertex_unnamed_54;
				vertex_output_1.y = vertex_unnamed_55;
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

			float _Blend;

			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;
			Texture2D<float4> _RampTex;
			SamplerState sampler_RampTex;

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
			static float4 fragment_unnamed_17;

			void frag_main()
			{
				fragment_unnamed_9.y = 0.5f;
				fragment_unnamed_17 = _MainTex.Sample(sampler_MainTex, fragment_input_0);
				fragment_unnamed_9.x = dot(fragment_unnamed_17.xyz, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f));
				fragment_unnamed_9 = _RampTex.Sample(sampler_RampTex, fragment_unnamed_9.xy).xyz;
				fragment_unnamed_9 = (-fragment_unnamed_17.xyz) + fragment_unnamed_9;
				float3 fragment_unnamed_71 = (_Blend.xxx * fragment_unnamed_9) + fragment_unnamed_17.xyz;
				fragment_output_0 = float4(fragment_unnamed_71.x, fragment_unnamed_71.y, fragment_unnamed_71.z, fragment_output_0.w);
				fragment_output_0.w = fragment_unnamed_17.w;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_0 = stage_input.fragment_input_0;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			float _Blend;

			static float4 fragment_uniform_buffer_0[29];
			Texture2D<float4> _RampTex;
			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;
			SamplerState sampler_RampTex;

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
				float4 fragment_unnamed_45 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				float fragment_unnamed_47 = fragment_unnamed_45.x;
				float fragment_unnamed_48 = fragment_unnamed_45.y;
				float fragment_unnamed_49 = fragment_unnamed_45.z;
				float4 fragment_unnamed_59 = _RampTex.Sample(sampler_RampTex, float2(dot(float3(fragment_unnamed_47, fragment_unnamed_48, fragment_unnamed_49), float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)), asfloat(1056964608u)));
				precise float fragment_unnamed_64 = (-0.0f) - fragment_unnamed_47;
				precise float fragment_unnamed_66 = (-0.0f) - fragment_unnamed_48;
				precise float fragment_unnamed_67 = (-0.0f) - fragment_unnamed_49;
				precise float fragment_unnamed_68 = fragment_unnamed_64 + fragment_unnamed_59.x;
				precise float fragment_unnamed_69 = fragment_unnamed_66 + fragment_unnamed_59.y;
				precise float fragment_unnamed_70 = fragment_unnamed_67 + fragment_unnamed_59.z;
				fragment_output_0.x = mad(fragment_uniform_buffer_0[28u].x, fragment_unnamed_68, fragment_unnamed_47);
				fragment_output_0.y = mad(fragment_uniform_buffer_0[28u].x, fragment_unnamed_69, fragment_unnamed_48);
				fragment_output_0.z = mad(fragment_uniform_buffer_0[28u].x, fragment_unnamed_70, fragment_unnamed_49);
				fragment_output_0.w = fragment_unnamed_45.w;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[28] = float4(_Blend, fragment_uniform_buffer_0[28][1], fragment_uniform_buffer_0[28][2], fragment_uniform_buffer_0[28][3]);

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
