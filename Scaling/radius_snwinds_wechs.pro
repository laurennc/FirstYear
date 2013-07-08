FUNCTION RADIUS_SNWINDS_WECHS,t,vars,lumin_params
	H_0 = 7.48609e-11;yr^-1
        ;print,t,lumin_params
	eta_here = eta_calc(t,lumin_params)

	;USING THEIR COSMOLOGY NOW
	retval = (18.0*!pi*vars[0])/(0.0416*vars[2]*eta_here^2.0)
	retval = retval - 3.0*(vars[1]^2.0/vars[2])*(1-(2.0/3.0)*(eta_here*vars[2]/(vars[1])))^2.0
	

	retval = retval - (2.0*0.238 + 0.0416)*(eta_here^2.0)*vars[2]*(1.0/9.0)
	return, retval
END
