
Shader "Cusom/MetaBlob"
	{

	Properties{
	    _iMouse ("iMouse", Vector) = (0,0,0,0)
        _rangeX ("rangeX", Range (0.1, 0.9)) = 0.5
        _rangeY ("rangeY", Range (0.1, 0.9)) = 0.5
        _Amplitude ("Amplitude", Float) = 1
        _ControlTime ("ControlTime", float) = 0
        _testRangeX ("rangeTestX", Range(0, 1)) = 0
	}

	SubShader
	{
	Tags { "RenderType" = "Transparent" "Queue" = "Transparent" }

	Pass
	{
	    ZWrite Off
	    Blend SrcAlpha OneMinusSrcAlpha

    	CGPROGRAM
    	#pragma vertex vert
    	#pragma fragment frag
    	#include "UnityCG.cginc"

    	struct VertexInput {
            fixed4 vertex : POSITION;
    	    fixed2 uv:TEXCOORD0;
            fixed4 tangent : TANGENT;
            fixed3 normal : NORMAL;
        };
    
    	struct VertexOutput {
    	    fixed4 pos : SV_POSITION;
    	    fixed2 uv:TEXCOORD0;
    	};

	    float4 _iMouse;
        float _rangeX;
        float _rangeY;
        float _testRangeX;
        float _Amplitude;
        float _ControlTime;
     
    	VertexOutput vert (VertexInput v)
    	{
        	VertexOutput o;
        	o.pos = UnityObjectToClipPos (v.vertex);
        	o.uv = v.uv;
            
        	return o;
        }
        
    	fixed4 frag(VertexOutput i) : SV_Target
    	{
    	
            fixed mx = max(1, 1);
            fixed2 uv = i.uv / mx;
            fixed2 center = 1 / mx * 0.5;
            
            // wave animation
            
            fixed cDist = distance(center, uv) * 2.0;
            
            //_rangeX = clamp(sin(_ControlTime), -0.1, 0.1);
            //_rangeY = clamp(cos(_ControlTime), -0.1, 0.1);
            
            
            fixed2 rangeXY = fixed2(_rangeX, _rangeY);
            //ixed mDist = distance(_iMouse.xy / mx, uv) * 20.0;
            fixed mDist = distance(rangeXY / mx, uv) * 22.0;
            
        	fixed color = cDist * cDist * mDist;
            
            return fixed4(0.9, 0.2, 0.4, color < 1);
	    }
    
	    ENDCG
	}
  }
}

