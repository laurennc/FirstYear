FUNCTION PRESSURE_SNWINDS_WECHS,t, vars, lumin_params
	retval = call_function('luminosity_snwinds_wechs',t,vars[2],vars[1],vars[0],lumin_params)/(2.0*!pi*vars[2]^3.0)
	retval = retval - (5.0*vars[0]*vars[1])/vars[2]
	return, retval
END
