Shader "Custom/CutawaySurfaceShader" 
{
	Properties 
	{
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.0
		_CutawayPosition("Cutaway Position", Vector) = (0, 0, 0, 0)
		_CutawayNormal("Cutaway Normal", Vector) = (0, 0, 0, 0)

	}

	SubShader
	{
		Cull Off
		Tags{ "Queue" = "Transparent" "RenderType" = "Transparent" }
		LOD 200

		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows vertex:vert 

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;

		struct Input
		{
			float2 uv_MainTex;
			float4 posInObjectCoords : TEXCOORD0;
			float3 worldPos;
		};

		half _Glossiness;
		half _Metallic;
		float4 _CutawayPosition;
		float4 _CutawayNormal;
		fixed4 _Color;

		
		void vert(inout appdata_full v, out Input o)
		{
			UNITY_INITIALIZE_OUTPUT(Input, o);
			o.posInObjectCoords = v.vertex;
		}

		void surf(Input IN, inout SurfaceOutputStandard o)
		{
			float dist = dot(_CutawayNormal, (_CutawayPosition - IN.worldPos));
			if (dist > 0.0f)
			{
				discard;
			}
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;//float4(0.0, 0.0, 0.0, 1.0);
			o.Albedo = c.rgb;
			// Metallic and smoothness come from slider variables
			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;
			o.Alpha = c.a;
		}
		ENDCG

		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows vertex:vert alpha:fade

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;

		struct Input
		{
			float2 uv_MainTex;
			float4 posInObjectCoords : TEXCOORD0;
			float3 worldPos;
		};

		half _Glossiness;
		half _Metallic;
		float4 _CutawayPosition;
		float4 _CutawayNormal;
		fixed4 _Color;

		void vert(inout appdata_full v, out Input o)
		{
			UNITY_INITIALIZE_OUTPUT(Input, o);
			o.posInObjectCoords = v.vertex;
		}

		void surf(Input IN, inout SurfaceOutputStandard o)
		{
			float dist = dot(_CutawayNormal, (_CutawayPosition - IN.worldPos));
			if (dist < 0.0f)
			{
				discard;
			}

			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;//float4(0.0, 0.0, 0.0, 0.5);
			o.Albedo = c.rgb;
			// Metallic and smoothness come from slider variables
			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;
			o.Alpha = 0.5;
			
		}
		ENDCG
	}
	FallBack "Diffuse"
}
