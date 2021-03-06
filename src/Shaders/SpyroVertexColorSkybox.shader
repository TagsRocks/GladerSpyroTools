﻿/*
GladerSpyroTools is a library Unity3D library tool developed by Glader/HelloKitty@Github to do Spyro things in Unity3D.
Copyright (C) 2017 Glader/HelloKitty@Github

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/
Shader "Spyro/SpyroVertexColorSkybox" 
{
	Properties
	{
		_Color("Skybox Color", Color) = (1.0, 1.0, 1.0)
		_SkyboxIntensity("Skybox Light Intensity", Float) = 1.0
	}
	SubShader
	{
		Tags { "Queue" = "Transparent" "RenderType" = "Opaque" }
		LOD 200
		CULL OFF

		CGPROGRAM
		//We use a no lighting function to avoid any lighting at all
		#pragma surface surf NoLighting noforwardadd nolightmaps noambient nolppv vertex:vert

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 1.0

		uniform fixed3 _Color;
		uniform half _SkyboxIntensity;

		struct Input
		{
			half3 vertexColor;
			float2 uv_MainTex;
		};

		fixed4 LightingNoLighting(SurfaceOutput s, fixed3 lightDir, fixed atten)
		{
			fixed4 c;
			c.rgb = s.Albedo;
			c.a = s.Alpha;
			return c;
		}

		void vert(inout appdata_full v, out Input o)
		{
			UNITY_INITIALIZE_OUTPUT(Input, o);
			o.vertexColor = v.color; // Save the Vertex Color in the Input for the surf() method
		}

		void surf (Input IN, inout SurfaceOutput o)
		{
			o.Albedo = IN.vertexColor * _Color * _SkyboxIntensity;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
